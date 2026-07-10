# Epic 1 — Onboarding & Authentication

**Mục tiêu**: Người dùng tạo tài khoản, đăng nhập an toàn, và thiết lập hồ sơ cá nhân trên cả Web/iOS/Android, dữ liệu đồng bộ ngay từ Supabase Auth.

**Ưu tiên**: P0 (chặn mọi epic khác)

## Story 1.1 — Đăng ký tài khoản
**Là** một freelancer mới, **tôi muốn** đăng ký tài khoản bằng email/mật khẩu hoặc Google, **để** bắt đầu dùng sản phẩm.

Tiêu chí chấp nhận:
- [ ] Form đăng ký có validate email hợp lệ, mật khẩu tối thiểu 8 ký tự
- [ ] Hỗ trợ đăng ký qua Google OAuth (Supabase Auth provider)
- [ ] Sau đăng ký, tự động tạo bản ghi `profiles` liên kết với `auth.users`
- [ ] Gửi email xác nhận (Supabase Auth email confirmation)
- [ ] Lỗi hiển thị rõ nguyên nhân + cách khắc phục (email đã tồn tại, mật khẩu yếu...)

## Story 1.2 — Đăng nhập
**Là** người dùng đã có tài khoản, **tôi muốn** đăng nhập nhanh, **để** truy cập dữ liệu công việc của mình.

Tiêu chí chấp nhận:
- [ ] Đăng nhập email/mật khẩu và Google OAuth
- [ ] Giữ phiên đăng nhập (session) giữa các lần mở app
- [ ] Sinh trắc học (Face ID/Touch ID trên iOS, fingerprint trên Android) làm phương án đăng nhập nhanh sau lần đầu

## Story 1.3 — Quên mật khẩu
**Là** người dùng quên mật khẩu, **tôi muốn** đặt lại mật khẩu qua email, **để** khôi phục quyền truy cập.

Tiêu chí chấp nhận:
- [ ] Gửi email reset password qua Supabase Auth
- [ ] Link reset có hạn sử dụng (theo cấu hình Supabase mặc định)
- [ ] Sau khi đặt lại, tự động đăng xuất các phiên cũ

## Story 1.4 — Thiết lập hồ sơ cá nhân
**Là** freelancer, **tôi muốn** thiết lập tên, ảnh đại diện, ngành nghề, đơn vị tiền tệ mặc định, **để** cá nhân hóa trải nghiệm và báo cáo.

Tiêu chí chấp nhận:
- [ ] Form chỉnh sửa hồ sơ: tên hiển thị, avatar (upload qua Supabase Storage), ngành nghề, đơn vị tiền tệ, múi giờ
- [ ] Đồng bộ ngay lập tức trên các thiết bị khác qua Realtime
- [ ] Avatar hỗ trợ resize/nén trước khi upload

## Story 1.5 — Đăng xuất & Xóa tài khoản
**Là** người dùng, **tôi muốn** đăng xuất hoặc xóa tài khoản, **để** kiểm soát dữ liệu của mình.

Tiêu chí chấp nhận:
- [ ] Đăng xuất xóa session cục bộ trên thiết bị đó
- [ ] Xóa tài khoản có bước xác nhận rõ ràng (dialog cảnh báo không thể hoàn tác)
- [ ] Xóa tài khoản xóa toàn bộ dữ liệu liên quan (cascade delete hoặc soft-delete có thời hạn theo chính sách)
