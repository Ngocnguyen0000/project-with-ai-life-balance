# Life Balance — Supabase Schema

Bước 9: schema đầy đủ cho backend, dùng chung cho cả 3 client (Web/iOS/Android).

## Cách chạy

1. Tạo project mới trên [supabase.com](https://supabase.com) (hoặc chạy local qua `supabase start` nếu đã cài Supabase CLI).
2. Chạy migration:
   ```bash
   supabase link --project-ref <your-project-ref>
   supabase db push
   ```
   Hoặc copy nội dung `migrations/00000000000001_init_schema.sql` dán trực tiếp vào **SQL Editor** trên Supabase Dashboard nếu chưa dùng CLI.
3. Bật **Email** và **Google** làm Auth provider trong Dashboard → Authentication → Providers (Story 1.1).

## Bảng dữ liệu

| Bảng | Epic | Ghi chú |
|---|---|---|
| `profiles` | 1 | Mở rộng `auth.users`, tự tạo qua trigger khi user đăng ký |
| `subscriptions` | 5 | Free/Pro, tự tạo mặc định `free` khi có profile mới |
| `clients` | 4 | Giới hạn 2 bản ghi active trên gói Free (enforce bằng trigger) |
| `client_notes` | 4 | Ghi chú theo timestamp, tách bảng riêng để giữ lịch sử |
| `projects` | 2 | Giới hạn 3 bản ghi active trên gói Free (enforce bằng trigger) |
| `tasks` | 2 | Có `position` để giữ thứ tự kéo-thả trong Kanban |
| `time_entries` | 3 | `duration_seconds` tự tính (generated column); unique index đảm bảo **chỉ 1 timer chạy** mỗi user (Story 3.1); `client_generated_id` để dedupe khi đồng bộ offline (Story 3.5) |
| `life_balance_checkins` | 7 | Chỉ lưu 3 trục tự chấm (Love/Health/Finance) — trục Công việc **không lưu**, luôn tính live |
| `device_push_tokens` | 6 | Token APNs/FCM cho push notification |

## Hàm & View đáng chú ý

- **`calculate_work_score(owner_id, since)`** — công thức tính trục Công việc (Story 7.2): 70% tỷ lệ hoàn thành đúng hạn + 30% mức độ hợp lý của khối lượng giờ làm (20–45h/tuần là tối ưu). Gọi trực tiếp từ client hoặc qua view bên dưới.
- **`life_balance_current`** — view tổng hợp cả 4 trục hiện tại cho mỗi user (Work tính live + 3 trục self-rated mới nhất). Đây là nguồn dữ liệu chính cho màn Life Balance Overview.
- **`enforce_plan_limits()`** — trigger chặn insert `projects`/`clients` vượt giới hạn gói Free ngay ở tầng DB (không chỉ chặn ở UI), khớp với PRD §5 và MASTER.md.

## Row Level Security

Mọi bảng nghiệp vụ đều bật RLS với policy `auth.uid() = owner_id` — mỗi user chỉ đọc/ghi được dữ liệu của chính mình. Model hiện tại là **single-tenant-per-user** (không có team/workspace chung, theo đúng phạm vi MVP trong PRD). Bảng `subscriptions` chỉ cho phép **đọc**; ghi/sửa phải qua Stripe webhook chạy bằng `service_role` key (Supabase Edge Function), không client nào tự sửa được gói của mình.

## Realtime

Đã bật Realtime cho `projects`, `tasks`, `time_entries`, `clients`, `life_balance_checkins` — đúng yêu cầu đồng bộ <2s giữa 3 client trong PRD §3.

## Còn thiếu (làm ở bước sau)

- Stripe Edge Function để xử lý webhook và ghi vào `subscriptions` (Story 5.2)
- Edge Function gửi push notification qua `device_push_tokens` (Story 6.2)
- Seed data mẫu cho môi trường dev/test
