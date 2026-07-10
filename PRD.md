# PRD — Life Balance

**Product**: Life Balance — nền tảng quản lý công việc và cân bằng cuộc sống dành cho freelancer
**Status**: Draft v0.2
**Owner**: Ngoc
**Last updated**: 2026-07-11

## 1. Vấn đề & Tầm nhìn

Freelancer thường phải tự quản lý nhiều dự án, nhiều khách hàng, và thời gian làm việc bằng các công cụ rời rạc (note app, spreadsheet, timer riêng, Zalo/email cho khách hàng). Điều này gây:
- Mất thời gian tổng hợp giờ làm để tính tiền
- Không có cái nhìn tổng quan về deadline/tải công việc giữa các dự án
- Thiếu lịch sử làm việc rõ ràng với từng khách hàng
- Vì làm việc tự do không có ranh giới rõ ràng giữa công việc và cuộc sống cá nhân, freelancer dễ cắm đầu vào công việc mà quên mất các mặt khác của cuộc sống (tình cảm, sức khỏe, tài chính cá nhân) cho tới khi mất cân bằng nghiêm trọng

**Life Balance** hợp nhất quản lý task/dự án, chấm công giờ làm (time tracking), và quản lý khách hàng (CRM nhẹ) vào một sản phẩm đồng bộ trên Web, iOS, Android — giúp freelancer làm việc có tổ chức và tính phí chính xác hơn. Điểm khác biệt cốt lõi: màn hình trang chủ không chỉ hiện task cần làm, mà hiển thị **bức tranh cân bằng cuộc sống trên 4 trục — Công việc, Tình yêu, Sức khỏe, Tài chính** — đúng như tên sản phẩm, để công việc không âm thầm nuốt chửng các phần còn lại của cuộc sống.

## 2. Đối tượng người dùng

- **Người dùng chính**: Freelancer độc lập (thiết kế, lập trình, viết lách, tư vấn...) làm việc với nhiều khách hàng cùng lúc.
- **Ngữ cảnh sử dụng**: Chuyển đổi liên tục giữa các thiết bị — laptop khi làm việc sâu, điện thoại khi di chuyển hoặc trao đổi nhanh với khách hàng.

## 3. Mục tiêu & Thước đo thành công

| Mục tiêu | Thước đo |
|---|---|
| Freelancer chấm công đầy đủ, chính xác | ≥70% task có time entry trước khi đóng |
| Giảm thời gian tổng hợp cuối tháng | Xuất báo cáo giờ làm theo khách hàng trong <30s |
| Giữ chân người dùng trả phí | Retention tháng 2 ≥40% cho tài khoản trả phí |
| Đồng bộ đa nền tảng mượt | Độ trễ đồng bộ realtime <2s giữa các thiết bị |

## 4. Phạm vi

### Trong phạm vi (MVP — cả 3 nền tảng song song)
- Đăng ký/đăng nhập, quản lý hồ sơ cá nhân
- **Life Balance Overview (trang chủ)**: biểu đồ radar 4 trục Công việc/Tình yêu/Sức khỏe/Tài chính — trục Công việc tự tính từ dữ liệu thật, 3 trục còn lại người dùng tự chấm điểm định kỳ
- Quản lý dự án & task (CRUD, trạng thái, deadline, ưu tiên)
- Time tracking (bấm giờ theo task, nhập giờ thủ công, timesheet)
- Quản lý khách hàng (CRM nhẹ): hồ sơ khách hàng, gắn dự án với khách hàng, ghi chú
- Gói trả phí (subscription) qua Stripe: giới hạn theo gói Free/Pro
- Đồng bộ realtime giữa Web/iOS/Android

### Ngoài phạm vi (Phase sau)
- Xuất hóa đơn/invoice tự động
- Tích hợp thanh toán trực tiếp từ khách hàng (nhận tiền qua app)
- Cộng tác nhóm (nhiều freelancer chung 1 workspace)
- Tích hợp lịch bên ngoài (Google Calendar, Outlook)
- Báo cáo nâng cao / phân tích năng suất bằng AI

## 5. Nền tảng & Kiến trúc kỹ thuật

| Layer | Lựa chọn |
|---|---|
| Web | (chọn ở bước xây dựng — khuyến nghị Next.js) |
| iOS | Swift + SwiftUI |
| Android | Kotlin + Jetpack Compose |
| Backend | Supabase (Postgres, Auth, Realtime, Storage, Row Level Security cho multi-tenant) |
| Billing | Stripe (subscriptions), tích hợp qua Supabase Edge Functions |
| Đồng bộ đa thiết bị | Supabase Realtime (Postgres changes → subscribe trên cả 3 client) |

**Ghi chú kiến trúc**: 3 client native riêng biệt, dùng chung 1 backend Supabase và chung schema database — đảm bảo logic nghiệp vụ (business rules) được validate ở tầng database (RLS policies, constraints, Postgres functions) để tránh lệch logic giữa 3 codebase.

## 6. Tổng quan tính năng (chi tiết ở Epic/Story trong `docs/epics/`)

1. **Onboarding & Authentication** — đăng ký, đăng nhập, quên mật khẩu, hồ sơ cá nhân
2. **Project & Task Management** — CRUD dự án/task, trạng thái, deadline, ưu tiên
3. **Time Tracking** — bấm giờ, nhập tay, timesheet, báo cáo theo khách hàng/dự án
4. **Client Management (CRM nhẹ)** — hồ sơ khách hàng, gắn dự án, ghi chú, lịch sử
5. **Billing & Subscription** — gói Free/Pro, thanh toán Stripe, giới hạn tính năng theo gói
6. **Cross-Platform Sync & Notifications** — đồng bộ realtime, push notification, offline support
7. **Life Balance Overview** — trang chủ dạng radar 4 trục (Công việc/Tình yêu/Sức khỏe/Tài chính), check-in tự chấm điểm, xu hướng theo thời gian, nhắc nhở check-in

## 7. Yêu cầu phi chức năng

- **Bảo mật**: Row Level Security trên mọi bảng multi-tenant; không client nào truy cập được dữ liệu ngoài tenant của mình
- **Hiệu năng**: Thời gian tải màn hình chính <2s trên mạng 4G
- **Khả năng tiếp cận**: Tuân theo WCAG 2.1 AA (đã có sẵn quy tắc trong skill `ui-ux-pro-max`)
- **Offline**: Time tracking phải hoạt động được khi mất mạng, đồng bộ lại khi có mạng
- **Đa nền tảng nhất quán**: Cùng design system (token màu/typography/spacing) áp dụng nhất quán trên Web/iOS/Android, tôn trọng idiom riêng từng nền tảng (Apple HIG / Material Design)

## 8. Giả định & Rủi ro

| Giả định/Rủi ro | Ảnh hưởng | Giảm thiểu |
|---|---|---|
| Xây 3 native app song song tốn nhiều công sức hơn 1 codebase chung | Chậm tiến độ MVP | Ưu tiên schema/API ổn định trước, 3 team/luồng làm song song theo cùng epic |
| RLS Postgres cấu hình sai gây lộ dữ liệu chéo tenant | Nghiêm trọng (bảo mật) | Viết test RLS riêng cho từng bảng trước khi launch |
| Time tracking offline gây xung đột dữ liệu khi đồng bộ lại | Sai lệch giờ công | Thiết kế conflict resolution (last-write-wins theo timestamp + log audit) |

## 9. Roadmap giai đoạn

- **Phase 1 (MVP)**: Epic 1, 2, 3, 4, 7 (Auth, Task/Project, Time Tracking, Client Management, Life Balance Overview) trên cả 3 nền tảng — Life Balance Overview đi cùng Phase 1 vì là trang chủ, không phải tính năng phụ
- **Phase 2**: Epic 5–6 (Billing, Sync/Notification nâng cao) hoàn thiện cho ra mắt SaaS trả phí
- **Phase 3**: Invoice tự động, cộng tác nhóm, tích hợp lịch ngoài

---
Chi tiết Epic & Story: xem thư mục [`docs/epics/`](docs/epics/).
