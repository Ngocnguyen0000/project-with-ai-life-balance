# Epic 7 — Life Balance Overview

**Mục tiêu**: Màn hình tổng quan (trang chủ sau đăng nhập) cho freelancer thấy được sự cân bằng cuộc sống trên 4 trục: **Công việc, Tình yêu, Sức khỏe, Tài chính** — không chỉ quản lý công việc mà còn phản ánh đúng tên sản phẩm "Life Balance".

**Ưu tiên**: P0 (là màn hình trang chủ, thay thế Dashboard thuần công việc ở Epic 2)

**Cơ chế**: Trục **Công việc** tự tính từ dữ liệu thật trong app (task hoàn thành, giờ đã log, deadline). 3 trục còn lại (**Tình yêu, Sức khỏe, Tài chính**) do người dùng tự chấm điểm định kỳ — không có nguồn dữ liệu tự động.

## Story 7.1 — Xem biểu đồ Life Balance 4 trục
**Là** freelancer, **tôi muốn** thấy biểu đồ dạng radar/wheel với 4 trục Công việc/Tình yêu/Sức khỏe/Tài chính ngay khi mở app, **để** nắm nhanh cuộc sống mình đang mất cân bằng ở đâu.

Tiêu chí chấp nhận:
- [ ] Biểu đồ radar (spider chart) 4 trục, thang điểm 0–10 mỗi trục
- [ ] Trung tâm màn hình, là nội dung đầu tiên thấy sau khi đăng nhập
- [ ] Mỗi trục có màu riêng nhất quán trong toàn app (vd: Công việc = primary, Tình yêu = hồng/đỏ, Sức khỏe = xanh lá, Tài chính = vàng/cam)
- [ ] Có text tóm tắt tự động (vd: "Sức khỏe đang thấp hơn các trục khác 3 tuần liên tiếp")
- [ ] Tap vào 1 trục mở trang chi tiết/lịch sử của trục đó

## Story 7.2 — Trục Công việc tự tính từ dữ liệu thật
**Là** hệ thống, **tôi muốn** tự tính điểm trục Công việc từ dữ liệu task/giờ làm thật, **để** người dùng không phải tự chấm điểm phần đã có dữ liệu khách quan.

Tiêu chí chấp nhận:
- [ ] Công thức điểm kết hợp: % task đúng hạn hoàn thành trong 7 ngày qua + mức độ giờ làm so với mục tiêu cá nhân (không quá tải, không quá ít)
- [ ] Công thức tính được hiển thị minh bạch khi người dùng bấm "Vì sao điểm này?"
- [ ] Cập nhật điểm realtime khi có task/time entry mới (tái dùng dữ liệu từ Epic 2, 3)

## Story 7.3 — Tự chấm điểm Tình yêu / Sức khỏe / Tài chính
**Là** freelancer, **tôi muốn** tự chấm điểm nhanh 3 trục còn lại, **để** biểu đồ phản ánh đúng cảm nhận thực tế của mình.

Tiêu chí chấp nhận:
- [ ] Check-in nhanh dạng slider hoặc thang 1–5/1–10 cho từng trục, làm trong <10 giây
- [ ] Nhắc check-in theo chu kỳ người dùng chọn (hàng ngày hoặc hàng tuần)
- [ ] Cho phép thêm ghi chú ngắn kèm mỗi lần chấm điểm (optional, vd: "Tuần này ít gặp bạn bè vì deadline gấp")
- [ ] Nếu quên check-in, trục đó hiển thị điểm cũ kèm nhãn "Chưa cập nhật X ngày" thay vì fake dữ liệu

## Story 7.4 — Xem xu hướng cân bằng theo thời gian
**Là** freelancer, **tôi muốn** xem lịch sử 4 trục theo tuần/tháng, **để** nhận ra xu hướng mất cân bằng sớm thay vì chỉ nhìn 1 thời điểm.

Tiêu chí chấp nhận:
- [ ] Biểu đồ line/area theo thời gian cho từng trục, chọn khoảng 4 tuần / 3 tháng / 6 tháng
- [ ] So sánh trực quan trục nào đang tăng/giảm
- [ ] Empty state rõ ràng khi chưa đủ dữ liệu lịch sử (mới dùng app)

## Story 7.5 — Nhắc nhở check-in định kỳ
**Là** freelancer dễ quên tự chấm điểm, **tôi muốn** được nhắc nhở đúng lúc, **để** dữ liệu 3 trục tự chấm luôn được cập nhật.

Tiêu chí chấp nhận:
- [ ] Push notification theo chu kỳ đã chọn ở Story 7.3 (mobile)
- [ ] Người dùng chỉnh được giờ/ngày nhắc trong Settings
- [ ] Không nhắc nếu đã check-in trong chu kỳ đó rồi
