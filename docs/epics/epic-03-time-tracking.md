# Epic 3 — Time Tracking

**Mục tiêu**: Freelancer ghi lại chính xác thời gian làm việc theo từng task/dự án để phục vụ tính phí và phân tích năng suất.

**Ưu tiên**: P0

## Story 3.1 — Bấm giờ theo task (Timer)
**Là** freelancer, **tôi muốn** bấm start/stop timer khi làm một task, **để** ghi nhận thời gian thực tế không cần nhập tay.

Tiêu chí chấp nhận:
- [ ] Nút start/stop gắn với 1 task cụ thể, hiển thị đồng hồ đang chạy
- [ ] Chỉ 1 timer chạy tại một thời điểm trên mỗi tài khoản (cảnh báo nếu cố start timer thứ 2)
- [ ] Timer tiếp tục chạy nền khi app bị thu nhỏ (mobile) hoặc chuyển tab (web)
- [ ] Timer hoạt động khi offline, đồng bộ lại khi có mạng

## Story 3.2 — Nhập thời gian thủ công
**Là** freelancer quên bấm giờ, **tôi muốn** nhập thời gian làm việc thủ công, **để** không mất dữ liệu chấm công.

Tiêu chí chấp nhận:
- [ ] Form nhập time entry: task, ngày, giờ bắt đầu/kết thúc hoặc tổng thời lượng, ghi chú
- [ ] Validate không cho nhập thời gian âm hoặc trùng lặp chồng chéo bất thường (cảnh báo, không chặn cứng)

## Story 3.3 — Timesheet & chỉnh sửa
**Là** freelancer, **tôi muốn** xem và chỉnh sửa lại các time entry theo ngày/tuần, **để** sửa sai sót trước khi tính phí.

Tiêu chí chấp nhận:
- [ ] Xem timesheet theo ngày/tuần, nhóm theo dự án
- [ ] Sửa/xóa từng time entry
- [ ] Tổng giờ hiển thị theo dự án và theo khách hàng

## Story 3.4 — Báo cáo giờ làm theo khách hàng/dự án
**Là** freelancer, **tôi muốn** xuất báo cáo tổng giờ làm theo khoảng thời gian, **để** đối chiếu khi tính tiền với khách hàng.

Tiêu chí chấp nhận:
- [ ] Chọn khoảng thời gian + lọc theo khách hàng/dự án
- [ ] Xuất báo cáo dạng CSV/PDF
- [ ] Hiển thị được trong <30s kể cả với dữ liệu nhiều tháng

## Story 3.5 — Offline-first cho time tracking
**Là** freelancer làm việc ở nơi không có mạng, **tôi muốn** timer và nhập tay vẫn hoạt động offline, **để** không gián đoạn công việc.

Tiêu chí chấp nhận:
- [ ] Time entry tạo offline được lưu local (SQLite/local storage tùy nền tảng)
- [ ] Tự động đồng bộ lên Supabase khi có mạng trở lại
- [ ] Có audit log khi xảy ra conflict để người dùng biết bản ghi nào đã bị ghi đè
