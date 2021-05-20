---222
function main(login clone full, login clone novery, restore rrs, file list clone, file list rrs, chạy very, api key dongvan, link lấy otp, úp danh bạ, úp avt, úp ảnh bìa, úp info, bậc 2fa, số lượt kb theo gợi ý, số lượt kb theo uid, đồng ý kết bạn, số lượt xem thông báo, số lượt join nhóm gợi ý, số lượt join nhóm theo list, file list nhóm, like page, file list page, số lượt vuốt new, số lượt like new, số lượt bình luận, tên file chứa nội dung bl, sl chia sẽ lên tường, đăng status, status kèm ảnh, xuất clone sau khi auto, link sheet lưu clone full, reg novery sau khi chạy, link sheet lưu novery, lưu rrs sau khi chạy)
	contair = require("socket.https")
	if (login clone novery == "1") then
		clone, cl2 = login(file list clone, login clone novery);
		output = clone
		if (cl2 == 0) then
			return
		end
	end
	if (lưu rrs sau khi chạy == "1") then
		local name = tachchuoi(output)
		luurrs(name[1], output)
	else
		if (restore rrs ~= "1") then
			resetdata()
		end
	end
end
---Finish
