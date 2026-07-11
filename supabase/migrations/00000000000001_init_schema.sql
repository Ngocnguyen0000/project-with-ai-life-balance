-- Life Balance — initial schema
-- Covers Epic 1 (Auth/Profile), Epic 2 (Projects/Tasks), Epic 3 (Time Tracking),
-- Epic 4 (Clients), Epic 5 (Billing), Epic 6 (notification prefs), Epic 7 (Life Balance check-ins).
--
-- Multi-tenancy model: single-tenant-per-user (no team workspaces in MVP — see PRD "Ngoài phạm vi").
-- Every business table carries owner_id directly (denormalized, not joined through projects) so RLS
-- policies stay simple and fast — see PRD.md §5 "logic nghiệp vụ được validate ở tầng database".

create extension if not exists "pgcrypto";

-- ============================================================================
-- PROFILES (Epic 1, Story 1.4)
-- ============================================================================

create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  full_name text,
  avatar_url text,
  industry text,
  currency text not null default 'USD',
  timezone text not null default 'UTC',
  checkin_reminder_enabled boolean not null default true,
  checkin_reminder_time time not null default '20:00',
  checkin_reminder_frequency text not null default 'daily' check (checkin_reminder_frequency in ('daily', 'weekly')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Auto-create a profile row whenever a new auth user signs up (Story 1.1).
create function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, new.raw_user_meta_data ->> 'full_name');
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ============================================================================
-- updated_at helper (reused by every table below)
-- ============================================================================

create function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

-- ============================================================================
-- CLIENTS (Epic 4)
-- ============================================================================

create table public.clients (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users (id) on delete cascade,
  name text not null,
  company text,
  email text,
  phone text,
  tags text[] not null default '{}',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create index clients_owner_id_idx on public.clients (owner_id) where deleted_at is null;

create trigger clients_set_updated_at
  before update on public.clients
  for each row execute function public.set_updated_at();

-- Story 4.3: freeform timestamped notes, kept separate from the client row so history isn't lost on edit.
create table public.client_notes (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references public.clients (id) on delete cascade,
  owner_id uuid not null references auth.users (id) on delete cascade,
  body text not null,
  created_at timestamptz not null default now()
);

create index client_notes_client_id_idx on public.client_notes (client_id);

-- ============================================================================
-- PROJECTS (Epic 2, Story 2.1)
-- ============================================================================

create table public.projects (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users (id) on delete cascade,
  client_id uuid references public.clients (id) on delete set null,
  name text not null,
  description text,
  status text not null default 'active' check (status in ('active', 'paused', 'completed', 'archived')),
  start_date date,
  end_date date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create index projects_owner_id_idx on public.projects (owner_id) where deleted_at is null;
create index projects_client_id_idx on public.projects (client_id);

create trigger projects_set_updated_at
  before update on public.projects
  for each row execute function public.set_updated_at();

-- ============================================================================
-- TASKS (Epic 2, Story 2.2)
-- ============================================================================

create table public.tasks (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users (id) on delete cascade,
  project_id uuid not null references public.projects (id) on delete cascade,
  title text not null,
  description text,
  status text not null default 'todo' check (status in ('todo', 'in_progress', 'review', 'done')),
  priority text not null default 'medium' check (priority in ('low', 'medium', 'high')),
  due_at timestamptz,
  position integer not null default 0, -- manual sort order within a status column (kanban)
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create index tasks_owner_id_idx on public.tasks (owner_id) where deleted_at is null;
create index tasks_project_id_idx on public.tasks (project_id);
create index tasks_due_at_idx on public.tasks (due_at) where deleted_at is null and status <> 'done';

create trigger tasks_set_updated_at
  before update on public.tasks
  for each row execute function public.set_updated_at();

-- ============================================================================
-- TIME ENTRIES (Epic 3)
-- ============================================================================

create table public.time_entries (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users (id) on delete cascade,
  task_id uuid not null references public.tasks (id) on delete cascade,
  started_at timestamptz not null,
  ended_at timestamptz,
  duration_seconds integer generated always as (
    case when ended_at is not null
      then greatest(0, extract(epoch from (ended_at - started_at))::integer)
      else null
    end
  ) stored,
  source text not null default 'timer' check (source in ('timer', 'manual')),
  note text,
  -- Story 3.5: rows created offline carry a client-generated id to dedupe on re-sync.
  client_generated_id uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index time_entries_owner_id_idx on public.time_entries (owner_id);
create index time_entries_task_id_idx on public.time_entries (task_id);
create index time_entries_started_at_idx on public.time_entries (started_at);
create unique index time_entries_client_generated_id_idx on public.time_entries (owner_id, client_generated_id) where client_generated_id is not null;

create trigger time_entries_set_updated_at
  before update on public.time_entries
  for each row execute function public.set_updated_at();

-- Story 3.1: only one running timer (ended_at is null) per user at a time.
create unique index time_entries_one_running_per_user
  on public.time_entries (owner_id)
  where ended_at is null;

-- ============================================================================
-- LIFE BALANCE CHECK-INS (Epic 7, Story 7.3)
-- ============================================================================

create table public.life_balance_checkins (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users (id) on delete cascade,
  axis text not null check (axis in ('love', 'health', 'finance')), -- 'work' is computed, never stored here
  score numeric(3, 1) not null check (score >= 0 and score <= 10),
  note text,
  checked_in_at timestamptz not null default now()
);

create index life_balance_checkins_owner_axis_idx on public.life_balance_checkins (owner_id, axis, checked_in_at desc);

-- Story 7.2: transparent, callable formula for the Work axis — combines on-time completion rate
-- with a workload-balance factor so both "does no work" and "overworks" pull the score down.
create function public.calculate_work_score(p_owner_id uuid, p_since timestamptz default now() - interval '7 days')
returns numeric
language sql
stable
as $$
  with completed as (
    select
      count(*) filter (where status = 'done' and due_at is not null and updated_at <= due_at) as on_time,
      count(*) filter (where status = 'done') as done_count,
      count(*) as total_count
    from public.tasks
    where owner_id = p_owner_id and updated_at >= p_since and deleted_at is null
  ),
  hours as (
    select coalesce(sum(duration_seconds), 0) / 3600.0 as total_hours
    from public.time_entries
    where owner_id = p_owner_id and started_at >= p_since
  )
  select round(
    least(10, greatest(0,
      -- 70% weight: on-time completion rate (falls back to 5.0 baseline if no tasks yet)
      (case when completed.total_count = 0 then 5.0
            else (completed.on_time::numeric / greatest(completed.done_count, 1)) * 10 end) * 0.7
      -- 30% weight: workload sanity — 20-45h/week scores full, less or more tapers off
      + (case
           when hours.total_hours between 20 and 45 then 10
           when hours.total_hours < 20 then hours.total_hours / 20 * 10
           else greatest(0, 10 - (hours.total_hours - 45) / 5)
         end) * 0.3
    )), 1
  )
  from completed, hours;
$$;

-- Story 7.1/7.4: current balance snapshot — Work is computed live, the other 3 axes use
-- each one's most recent check-in (or null if the user has never checked in for that axis).
create view public.life_balance_current as
select
  u.id as owner_id,
  public.calculate_work_score(u.id) as work,
  (select score from public.life_balance_checkins where owner_id = u.id and axis = 'love' order by checked_in_at desc limit 1) as love,
  (select score from public.life_balance_checkins where owner_id = u.id and axis = 'health' order by checked_in_at desc limit 1) as health,
  (select score from public.life_balance_checkins where owner_id = u.id and axis = 'finance' order by checked_in_at desc limit 1) as finance,
  (select checked_in_at from public.life_balance_checkins where owner_id = u.id and axis = 'love' order by checked_in_at desc limit 1) as love_last_checkin,
  (select checked_in_at from public.life_balance_checkins where owner_id = u.id and axis = 'health' order by checked_in_at desc limit 1) as health_last_checkin,
  (select checked_in_at from public.life_balance_checkins where owner_id = u.id and axis = 'finance' order by checked_in_at desc limit 1) as finance_last_checkin
from auth.users u;

-- ============================================================================
-- SUBSCRIPTIONS (Epic 5)
-- ============================================================================

create table public.subscriptions (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null unique references auth.users (id) on delete cascade,
  plan text not null default 'free' check (plan in ('free', 'pro')),
  stripe_customer_id text,
  stripe_subscription_id text,
  status text not null default 'active' check (status in ('active', 'past_due', 'canceled')),
  current_period_end timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger subscriptions_set_updated_at
  before update on public.subscriptions
  for each row execute function public.set_updated_at();

-- Every new profile gets a default Free subscription row automatically.
create function public.handle_new_subscription()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.subscriptions (owner_id) values (new.id)
  on conflict (owner_id) do nothing;
  return new;
end;
$$;

create trigger on_profile_created_create_subscription
  after insert on public.profiles
  for each row execute function public.handle_new_subscription();

-- Story 5.1/5.4: enforce Free plan limits (3 projects, 2 clients) at the database layer,
-- not just in UI — mirrors the rule in PRD.md §5 and MASTER.md.
create function public.enforce_plan_limits()
returns trigger
language plpgsql
as $$
declare
  v_plan text;
  v_count integer;
  v_limit integer;
begin
  select plan into v_plan from public.subscriptions where owner_id = new.owner_id;
  if v_plan is distinct from 'free' then
    return new; -- Pro has no limits
  end if;

  if tg_table_name = 'projects' then
    select count(*) into v_count from public.projects where owner_id = new.owner_id and deleted_at is null;
    v_limit := 3;
  elsif tg_table_name = 'clients' then
    select count(*) into v_count from public.clients where owner_id = new.owner_id and deleted_at is null;
    v_limit := 2;
  end if;

  if v_count >= v_limit then
    raise exception 'free_plan_limit_reached: % limit is % on the Free plan', tg_table_name, v_limit
      using errcode = 'P0001';
  end if;
  return new;
end;
$$;

create trigger projects_enforce_plan_limit
  before insert on public.projects
  for each row execute function public.enforce_plan_limits();

create trigger clients_enforce_plan_limit
  before insert on public.clients
  for each row execute function public.enforce_plan_limits();

-- ============================================================================
-- DEVICE PUSH TOKENS (Epic 6, Story 6.2 — APNs/FCM)
-- ============================================================================

create table public.device_push_tokens (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users (id) on delete cascade,
  platform text not null check (platform in ('ios', 'android')),
  token text not null,
  created_at timestamptz not null default now(),
  unique (owner_id, token)
);

create index device_push_tokens_owner_id_idx on public.device_push_tokens (owner_id);

alter table public.device_push_tokens enable row level security;

create policy "device_push_tokens: owner read/write" on public.device_push_tokens
  for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);

-- ============================================================================
-- ROW LEVEL SECURITY
-- ============================================================================

alter table public.profiles enable row level security;
alter table public.clients enable row level security;
alter table public.client_notes enable row level security;
alter table public.projects enable row level security;
alter table public.tasks enable row level security;
alter table public.time_entries enable row level security;
alter table public.life_balance_checkins enable row level security;
alter table public.subscriptions enable row level security;

create policy "profiles: owner read/write" on public.profiles
  for all using (auth.uid() = id) with check (auth.uid() = id);

create policy "clients: owner read/write" on public.clients
  for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);

create policy "client_notes: owner read/write" on public.client_notes
  for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);

create policy "projects: owner read/write" on public.projects
  for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);

create policy "tasks: owner read/write" on public.tasks
  for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);

create policy "time_entries: owner read/write" on public.time_entries
  for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);

create policy "life_balance_checkins: owner read/write" on public.life_balance_checkins
  for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);

create policy "subscriptions: owner read only" on public.subscriptions
  for select using (auth.uid() = owner_id);
-- No insert/update/delete policy for subscriptions: only the Stripe webhook (via the
-- service_role key in a Supabase Edge Function) may write to this table.

-- ============================================================================
-- REALTIME
-- ============================================================================

alter publication supabase_realtime add table public.projects, public.tasks, public.time_entries, public.clients, public.life_balance_checkins;

-- ============================================================================
-- STORAGE (avatars — Story 1.4)
-- ============================================================================

insert into storage.buckets (id, name, public) values ('avatars', 'avatars', true)
on conflict (id) do nothing;

create policy "avatars: anyone can view" on storage.objects
  for select using (bucket_id = 'avatars');

create policy "avatars: owner can upload/update/delete their own" on storage.objects
  for all using (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text)
  with check (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);
