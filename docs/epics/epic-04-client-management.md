# Epic 4 — Client Management (CRM nhẹ)

**Mục tiêu**: Freelancer lưu trữ thông tin khách hàng và liên kết với các dự án để có cái nhìn lịch sử làm việc theo từng khách hàng.

**Ưu tiên**: P1

## Story 4.1 — Tạo & quản lý hồ sơ khách hàng
**Là** freelancer, **tôi muốn** tạo hồ sơ khách hàng với thông tin liên hệ, **để** quản lý tập trung không cần công cụ riêng.

Tiêu chí chấp nhận:
- [ ] Hồ sơ khách hàng: tên, công ty, email, số điện thoại, ghi chú, tag/ngành nghề
- [ ] Danh sách khách hàng tìm kiếm được theo tên/công ty
- [ ] Sửa/xóa (soft-delete) khách hàng

## Story 4.2 — Xem lịch sử dự án theo khách hàng
**Là** freelancer, **tôi muốn** xem tất cả dự án và tổng giờ đã làm cho một khách hàng, **để** đánh giá mức độ hợp tác lâu dài.

Tiêu chí chấp nhận:
- [ ] Trang chi tiết khách hàng liệt kê tất cả dự án liên kết + trạng thái
- [ ] Hiển thị tổng giờ làm và tổng số dự án đã hoàn thành với khách hàng đó

## Story 4.3 — Ghi chú & lịch sử liên hệ
**Là** freelancer, **tôi muốn** ghi chú các mốc trao đổi quan trọng với khách hàng, **để** không quên ngữ cảnh khi làm việc tiếp.

Tiêu chí chấp nhận:
- [ ] Thêm ghi chú có timestamp vào hồ sơ khách hàng
- [ ] Ghi chú hiển thị theo thứ tự thời gian mới nhất trước

## Story 4.4 — Gắn khách hàng khi tạo dự án
**Là** freelancer, **tôi muốn** chọn khách hàng có sẵn hoặc tạo mới ngay khi tạo dự án, **để** không phải thoát luồng công việc.

Tiêu chí chấp nhận:
- [ ] Dropdown chọn khách hàng có sẵn hoặc "+ Tạo khách hàng mới" ngay trong form tạo dự án
- [ ] Dự án không bắt buộc phải có khách hàng (cho phép dự án cá nhân/nội bộ)
