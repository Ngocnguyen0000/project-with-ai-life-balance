# Epic 6 — Cross-Platform Sync & Notifications

**Mục tiêu**: Đảm bảo trải nghiệm nhất quán, dữ liệu luôn mới nhất, và thông báo đúng lúc trên cả Web/iOS/Android.

**Ưu tiên**: P1

## Story 6.1 — Realtime sync nền tảng chéo
**Là** freelancer dùng nhiều thiết bị, **tôi muốn** mọi thay đổi (task, time entry, khách hàng) đồng bộ ngay lập tức, **để** luôn thấy dữ liệu mới nhất bất kể mở app ở đâu.

Tiêu chí chấp nhận:
- [ ] Subscribe Supabase Realtime channel theo user/tenant trên cả 3 client
- [ ] UI cập nhật không cần refresh/reload thủ công
- [ ] Xử lý mất kết nối realtime: tự động reconnect + fetch lại state mới nhất

## Story 6.2 — Push notification đa nền tảng
**Là** freelancer, **tôi muốn** nhận thông báo đẩy trên điện thoại cho các sự kiện quan trọng, **để** không cần mở app liên tục.

Tiêu chí chấp nhận:
- [ ] Tích hợp APNs (iOS) và FCM (Android) qua Supabase Edge Function hoặc dịch vụ trung gian
- [ ] Loại thông báo: deadline sắp tới, subscription sắp hết hạn, đồng bộ lỗi cần chú ý
- [ ] Người dùng tùy chỉnh bật/tắt từng loại thông báo

## Story 6.3 — Trạng thái offline rõ ràng
**Là** freelancer, **tôi muốn** biết khi nào app đang offline và dữ liệu chưa đồng bộ, **để** yên tâm là không mất dữ liệu.

Tiêu chí chấp nhận:
- [ ] Banner/indicator hiển thị khi mất kết nối mạng
- [ ] Hiển thị số lượng thay đổi đang chờ đồng bộ (pending sync)
- [ ] Không chặn thao tác cơ bản (tạo task, chấm công) khi offline

## Story 6.4 — Nhất quán Design System đa nền tảng
**Là** người dùng chuyển đổi giữa Web/iOS/Android, **tôi muốn** trải nghiệm quen thuộc nhưng vẫn đúng chuẩn từng nền tảng, **để** không bị bỡ ngỡ khi đổi thiết bị.

Tiêu chí chấp nhận:
- [ ] Dùng chung 1 bộ design token (màu, typography, spacing) sinh ra từ skill `ui-ux-pro-max`
- [ ] Tôn trọng idiom riêng: Tab Bar dưới cho iOS, Top App Bar/Material cho Android, layout responsive cho Web
- [ ] Đạt checklist accessibility & pre-delivery của skill `ui-ux-pro-max` trước khi release mỗi nền tảng
