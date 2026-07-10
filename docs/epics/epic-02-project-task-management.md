# Epic 2 — Project & Task Management

**Mục tiêu**: Freelancer tạo và quản lý dự án, chia nhỏ thành task, theo dõi tiến độ và deadline trên cả 3 nền tảng.

**Ưu tiên**: P0

## Story 2.1 — Tạo & quản lý dự án
**Là** freelancer, **tôi muốn** tạo dự án mới gắn với khách hàng, **để** tổ chức công việc theo từng hợp đồng/khách hàng.

Tiêu chí chấp nhận:
- [ ] Tạo dự án với tên, mô tả, khách hàng liên kết (optional), ngày bắt đầu/kết thúc, trạng thái (đang chạy/tạm dừng/hoàn thành/archived)
- [ ] Danh sách dự án lọc được theo trạng thái và khách hàng
- [ ] Sửa/xóa (soft-delete) dự án

## Story 2.2 — Tạo & quản lý task trong dự án
**Là** freelancer, **tôi muốn** chia dự án thành các task cụ thể, **để** theo dõi từng phần việc.

Tiêu chí chấp nhận:
- [ ] Task có tiêu đề, mô tả, trạng thái (todo/in-progress/review/done), độ ưu tiên, deadline
- [ ] Task thuộc về đúng 1 dự án
- [ ] Sắp xếp/kéo-thả để đổi trạng thái (kanban view) trên Web; danh sách theo trạng thái trên mobile

## Story 2.3 — Xem tổng quan công việc (Dashboard)
**Là** freelancer, **tôi muốn** xem tổng quan task sắp đến hạn trên mọi dự án, **để** không bỏ sót deadline.

Tiêu chí chấp nhận:
- [ ] Dashboard hiển thị task quá hạn, task hôm nay, task trong 7 ngày tới
- [ ] Nhóm theo dự án/khách hàng
- [ ] Empty state rõ ràng khi không có task nào

## Story 2.4 — Thông báo deadline
**Là** freelancer, **tôi muốn** được nhắc trước khi task đến hạn, **để** chủ động sắp xếp thời gian.

Tiêu chí chấp nhận:
- [ ] Push notification trước 24h và 1h so với deadline (mobile)
- [ ] Cấu hình bật/tắt nhắc nhở theo từng loại
- [ ] Không gửi trùng lặp nhiều thiết bị cho cùng 1 sự kiện

## Story 2.5 — Đồng bộ realtime giữa các thiết bị
**Là** freelancer dùng cả điện thoại và máy tính, **tôi muốn** thay đổi task trên thiết bị này hiện ngay trên thiết bị khác, **để** không bị lệch dữ liệu.

Tiêu chí chấp nhận:
- [ ] Cập nhật task/dự án đồng bộ qua Supabase Realtime trong <2s
- [ ] Xử lý xung đột khi 2 thiết bị sửa cùng lúc (last-write-wins + hiển thị cảnh báo nếu cần)
