# Epic 5 — Billing & Subscription

**Mục tiêu**: Vận hành Life Balance như SaaS trả phí với gói Free/Pro, thanh toán qua Stripe, giới hạn tính năng theo gói.

**Ưu tiên**: P1 (cần trước khi launch thương mại, không chặn MVP nội bộ)

## Story 5.1 — Định nghĩa gói Free/Pro
**Là** chủ sản phẩm, **tôi muốn** định nghĩa rõ giới hạn của gói Free (số dự án, số khách hàng tối đa) so với Pro (không giới hạn + tính năng nâng cao), **để** tạo động lực nâng cấp.

Tiêu chí chấp nhận:
- [ ] Bảng so sánh gói hiển thị trong app (trang Pricing/Upgrade)
- [ ] Giới hạn được enforce ở tầng backend (Postgres function/RLS), không chỉ ở UI

## Story 5.2 — Đăng ký gói Pro qua Stripe
**Là** freelancer, **tôi muốn** nâng cấp lên gói Pro bằng thẻ, **để** dùng đầy đủ tính năng.

Tiêu chí chấp nhận:
- [ ] Tích hợp Stripe Checkout (hoặc Stripe Billing) qua Supabase Edge Function
- [ ] Webhook Stripe cập nhật trạng thái subscription vào Supabase real-time
- [ ] Hỗ trợ thanh toán trên Web; iOS/Android tuân thủ chính sách App Store/Play Store nếu bán subscription trong app (cân nhắc external purchase link theo quy định từng store)

## Story 5.3 — Quản lý subscription
**Là** người dùng Pro, **tôi muốn** xem trạng thái gói, ngày gia hạn, và hủy gói, **để** kiểm soát chi phí.

Tiêu chí chấp nhận:
- [ ] Trang quản lý subscription: gói hiện tại, ngày gia hạn tiếp theo, lịch sử thanh toán
- [ ] Hủy gói giữ quyền lợi Pro đến hết chu kỳ đã trả, sau đó tự chuyển về Free

## Story 5.4 — Giới hạn tính năng theo gói
**Là** hệ thống, **tôi muốn** chặn hành động vượt giới hạn gói Free, **để** khuyến khích nâng cấp mà không phá vỡ trải nghiệm.

Tiêu chí chấp nhận:
- [ ] Khi chạm giới hạn (vd: quá số dự án Free), hiển thị dialog rõ ràng mời nâng cấp thay vì lỗi khó hiểu
- [ ] Không xóa dữ liệu người dùng khi hạ gói (chỉ giới hạn tạo mới)
