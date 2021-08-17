function main(login_clone, restore_rss, very_acc, up_danh_ba, up_avatar, up_anh_bia, up_info, bat_2fa, doi_ten, kb_goi_y, kb_uid, dong_y_kb, xem_tb, add_group_goi_y, add_group_list, like_page, luot_newsfeed, like_newsfeed, binh_luan, share_tuong, dang_stt, dang_stt_anh, xuat_clone, reg_clone, luu_rss);
	local websocket = require("websocket.clients")
	local api = readtxt("api key.txt")
	local plist = require("plist")
	local json = require("json")
	local urlweb = readtxt("site.txt")
	local http = require("socket.http")
	local ssl = require("ssl.https")
	local apikey = getapi()
	local pl = require("pl.tablex")
	contair = require("socket.https")
	local json = require("json")
	local f = io.open(currentPath().."/temp.txt")
	local data = f:read("all")
	f:close()
	local tem = json.decode(data)
	local login_clone = tem["login_clone"]
	local loai_accn = tem["loai_accn"]
	local very_acc = tem["very_acc"]
	local reg_clone = tem["reg_clone"]
	local xuat_clone = tem["xuat_clone"]
	local loai_accx = tem["loai_accx"]
	local luu_rrs = tem["luu_rrs"]
	local loai_luu_rrs = tem["loai_luu_rrs"]
	local restore_rrs = tem["restore_rrs"]
	local loai_restore_rrs = tem["loai_restore_rrs"]
	local xuat_xoa_rrs = tem["xuat_xoa_rrs"]
	local loai_xuat_rrs = tem["loai_xuat_rrs"]
	local web_mail = tem["web_mail"]
	local api_dongvanfb = tem["api_dongvanfb"]
	local api_maxclone = tem["api_maxclone"]
	local loai_mail = tem["loai_mail"]
	local web_sim = tem["web_sim"]
	local api_codetextnow = tem["api_codetextnow"]
	local api_otpmmo = tem["api_otpmmo"]
	local api_otpsim = tem["api_otpsim"]
	local api_simfast = tem["api_simfast"]
	local loai_sim = tem["loai_sim"]
	local up_danh_ba = tem["up_danh_ba"]
	local up_avatar = tem["up_avatar"]
	local up_anh_bia = tem["up_anh_bia"]
	local up_info= tem["up_info"]
	local bat_2fa = tem["bat_2fa"]
	local doi_ten = tem["doi_ten"]
	local kb_goi_y = tem["kb_goi_y"]
	local delay_kb_goiy = tem["delay_kb_goiy"]
	local kb_uid = tem["kb_uid"]
	local delay_kb_uid = tem["delay_kb_uid"]
	local dong_y_kb = tem["dong_y_kb"]
	local delay_dongy_kb = tem["delay_dongy_kb"]
	local xem_tb = tem["xem_tb"]
	local delay_xem_tb = tem["delay_xem_tb"]
	local xem_watch = tem["xem_watch"]
	local delay_xem_watch = tem["delay_xem_watch"]
	local add_group_goi_y = tem["add_group_goi_y"]
	local delay_add_group_goiy = tem["delay_add_group_goiy"]
	local add_group_list = tem["add_group_list"]
	local delay_add_group_list = tem["delay_add_group_list"]
	local like_page = tem["like_page"]
	local delay_like_page = tem["delay_like_page"]
	local luot_newsfeed = tem["luot_newsfeed"]
	local delay_luot_newsfeed = tem["delay_luot_newsfeed"]
	local like_newsfeed = tem["like_newsfeed"]
	local delay_like_newsfeed = tem["delay_like_newsfeed"]
	local binh_luan = tem["binh_luan"]
	local delay_binh_luan = tem["delay_binh_luan"]
	local share_tuong = tem["share_tuong"]
	local delay_share_tuong = tem["delay_share_tuong"]
	local share_live = tem["share_live"]
	local link_share_live = tem["link_share_live"]
	local dang_stt = tem["dang_stt"]
	local dang_stt_anh = tem["dang_stt_anh"]
	local tab = listfile("/var/mobile/Media/XoaInfo")
	postlog(urlweb, api, apikey, "rrs_logs", #tab, "postrrslogs")
	-------------------------------------
	if (xuat_clone ~= "0" and luu_rrs ~= "0" or xuat_clone == "0" and luu_rrs == "0") then
		local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..apikey.."/loicauhinh")
		stop()
	end
	-------------------------------------
	if (reg_clone ~= "0" and login_clone == "0" and restore_rrs == "0") then
		regclone(reg_clone, web_sim, api_codetextnow, api_otpmmo, api_simfast, api_otpsim, very_acc, up_avatar, bat_2fa, luu_rrs, loai_accx)
		return
	end
	if (login_clone == "1") then
		clone, cl2 = login(loai_accn, urlweb, api, loginclonenovery, apikey);---login
		if (loai_accn == "novery" and very_acc == "0") then
			for i = 1, 3 do
				tap(66, 1280)
				toast("Chờ load dữ liệu")
				sleep(3)
			end
		end
		testvr = 1
	else
	-----------------------restore RRS
		local file = "RRS "..loai_restore_rrs..".txt"
		clone = daodong(file)
		local f = io.popen("ls var/mobile/Media/XoaInfo")
		local a = f:read("all")
		f:close()
		ten = tachchuoi(clone)
		if (string.find(a, ten[1]) == nil) then toast("Ko có RRS") return end
		---writetxt("RRS đã chạy.txt", clone, "a", 1, 1)
		local check = checkuid(ten[1])
		if (check == 1) then
			openURL("XoaInfo://DelRRS?listRRS="..ten[1])
			toast("Đang xóa RRS")
			writetxt("RRS die.txt", clone, "a", 1, 1)
			return
		end
		restore(ten[1])
		local temp = tachchuoi(clone)
		usleep(4000000)
		appRun("com.facebook.Facebook")
		local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..apikey.."/moappfb")
		usleep(2000000)
		if (very_acc ~= "1") then
			---TH hiện màn add mail: 395, 508, 1603570, 707, 500, 1603570, 525, 506, 1603570, 708, 469, 1603570
			toast("chờ kết quả 1")
			x = waitcolor(395, 508, 1603570, 707, 500, 1603570, 525, 506, 1603570, 708, 469, 1603570, 399, 1260, 15201279, 515, 777, 31487, 287, 774, 31487, 355, 767, 31487, 362, 767, 31487, 354, 136, 1603570, 394, 136, 1603570, 496, 1261, 1603570, 594, 1267, 1603570, 10, 1)
			tapimg("xnok.jpg", 1, 1)
			if (x == 355 or x == 362 or x == 354 or x == 394) then
				toast("out cookie")
				tapimg("ok.jpg", 1, 2000000)
				tapimg("ok2.jpg", 1, 2000000)
				test = loginlai(temp[1],temp[2], temp[3])
				tap(66, 1280)
				usleep(2000000)
				tap(66, 1280)
				usleep(2000000)
				testrrs = 0
			else
				toast("out uid")
				local test2 = tapimg("dangnhap2.jpg", 1, 1000000)
				if (test2 == 1) then
					test = loginlai(temp[1],temp[2], temp[3])
					tap(66, 1280)
					usleep(2000000)
					tap(66, 1280)
					usleep(2000000)
					testrrs = 0
				end
			end
			toast("chờ kết quả 2")
			local testlogin = waitcolor(395, 508, 1603570, 707, 500, 1603570, 525, 506, 1603570, 708, 469, 1603570, 35, 88, 1603570, 139, 90, 1603570, 496, 1261, 1603570, 594, 1267, 1603570, 20, 1)
			local testok = tapimg("xnok.jpg", 1, 2000000)
			if (testok == 1) then
				testlogin = waitcolor(35, 88, 1603570, 139, 90, 1603570, 496, 1261, 1603570, 594, 1267, 1603570, 20, 1)
			end
			if (testlogin == 35 or testlogin == 139 or testlogin == 395 or testlogin == 707 or testlogin == 525 or testlogin == 708) then
				toast("login ok")
				testvr = 1
			else
				toast("RRS lỗi")
				local f = io.popen("ls var/mobile/Media/XoaInfo")
				local a = f:read("all")
				f:close()
				openURL("XoaInfo://DelRRS?listRRS="..ten[1])
				toast("Đang xóa RRS")
				return
			end
		end
	end
	----------------------
	if (cl2 == 0) then resetdata() return end
	----------------------
	local id = tachchuoi(clone)
	local uid, matkhau = id[1], id[2]
	if (very_acc == "1") then
		mail, mkmail, total = goimail(type, apimail, urlweb, api)
		testvr, cookie = chiveri(dungapilayhotmail, uid, urlweb, api, apikey)
	end
	----------------------
	if (testvr == 1) then
		if (up_avatar == "1") then
			upavt = upavatar(uid, apikey, urlweb, api);
			if (upavt == 0) then
				return
			end
		end
		if (bat_2fa == "1") then
			key2fa, goiy = bacfa(uid, matkhau, apikey, urlweb, api, loai_accn);
			if (key2fa == "KEY2FA" or key2fa == 1) then
				return
			end
			local tab = tachchuoi(clone)
			if (#tab ~= 2) then
				clone = tab[1].."|"..tab[2].."|"..key2fa
				for i = 3, #tab do
					clone = clone.."|"..tab[i]
				end
			else
				if (chayvery == "1") then
					clone = clone.."|"..key2fa.."|"..cookie.."|"..mail.."|"..mkmail
				end
			end
		else
			if (chayvery == "1") then
				clone = clone.."|"..cookie.."|"..mail.."|"..mkmail
			end
		end
	else
		if (restorerrs == "1") then
			io.popen("mv var/mobile/Media/XoaInfo/"..uid.."/ var/mobile/Media/RRSLOI")
		else
			resetdata()
		end
		return
	end
	clone = string.gsub(clone, "|0|", "|")
	if (doi_ten == "1") then
		doiten(uid, matkhau)
	end
	---lưu lại ghi chú
	if (restorerrs == "1") then
		if(chayvery == "1" or bac2fa == "1") then
			toast("Đang lưu ghi chú")
			local f = io.open("var/mobile/Media/XoaInfo/GhiChu.txt", "w") f:write(clone) f:close()
			local f = io.popen("mv var/mobile/Media/XoaInfo/GhiChu.txt var/mobile/Media/XoaInfo/GhiChu") f:close()
			local f = io.popen("mv var/mobile/Media/XoaInfo/GhiChu var/mobile/Media/XoaInfo/"..ten[1].."/GhiChu") f:close()
		end
	end
	-------------------------------
	if (add_group_goi_y ~= "0") then
		local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..apikey.."/joingroup")
		thamgiagr(tonumber(add_group_goi_y), tonumber(delay_add_group_goiy))
	end
	------------------------------
	if (luot_newsfeed ~= "0") then
		local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..apikey.."/newsfeed")
		luotnew(tonumber(luot_newsfeed), tonumber(delay_luot_newsfeed), tonumber(like_newsfeed), slbl, slcs)
	end
	------------------------------
	if (dong_y_kb ~= "0") then
		local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..apikey.."/ketban")
		dongy(tonumber(dong_y_kb), tonumber(delay_dongy_kb))
	end
	------------------------------
	if (kb_goi_y ~= "0") then
		local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..apikey.."/ketban")
		ketban(tonumber(kb_goi_y), tonumber(delay_kb_goiy), tonumber(kb_uid), tonumber(delay_kb_uid), up_danh_ba)
	end
	-------------------------------
	if (xem_tb ~= "0") then
		local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..apikey.."/doctb")
		doctb(tonumber(xem_tb), tonumber(delay_xem_tb))
	end
	-------------------------------
	--if (like_page ~= "0") then
	----	likepage(tonumber(sllikepage), filelistpage)
	---end
	-------------------------------
	-------------------------------
	if (xem_watch ~= "0") then
		local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..apikey.."/xemwatch")
		xemvideo(tonumber(xem_watch), tonumber(delay_xem_watch), sllike, slbl, slcs)
	end
	if (xuat_clone ~= "0" and testvr == 1) then
		local a = readtxt("status.txt")
		local b = tachchuoi(a)
		log = tonumber(b[1])+1
		writetxt("status.txt", log.."|"..b[2], "w", 0, 0)
		postlog(urlweb, api, apikey, "thanh_cong", log, "postsuccesslogs")
		postclone(urlweb, api, clone, loai_accx)
	end
	if (regnoverysaukhichay == "1") then
		local id, matkhau, test = novery(regbanghotmail, apikeydongvan, regbanggmailao, 1);
		if (id ~= 0) then
			ghichu = id
			tapimg("ok.jpg", 1, 1000000)
			---------------------
			local linksheetluunovery = readtxt("link sheet clone nvr.txt")
			local url = string.sub(linksheetluunovery, 1, string.find(linksheetluunovery, "entry")-2);
			local entry = string.sub(linksheetluunovery, string.find(linksheetluunovery, "entry")+6, string.len(linksheetluunovery))
			local data = "--form-string 'entry."..entry.."="..ghichu.."'"
			curlPost(url,data);	
		end
	end
	local a = readtxt("status.txt")
	local b = tachchuoi(a)
	log = tonumber(b[1])+1
	writetxt("status.txt", log.."|"..b[2], "w", 0, 0)
	postlog(urlweb, api, apikey, "thanh_cong", log, "postsuccesslogs")
	--------------------------------
	if (luu_rrs == "1") then
		local file = "RRS "..loai_luu_rrs..".txt"
		local name = tachchuoi(clone)
		toast("Đang lưu loại: "..file)
		luurrs(name[1], clone, file)
	else
		if (restore_rrs ~= "1") then
			resetdata()
		else
			if (testrrs == 0 and regnoverysaukhichay == "0") then
				local f = io.popen("ls var/mobile/Media/XoaInfo")
				local a = f:read("all")
				f:close()
				openURL("XoaInfo://DelRRS?listRRS="..ten[1])
				toast("Đang xóa RRS")
				local name = tachchuoi(clone)
				toast("lưu rrs lại", 7)
				luurrs(name[1], clone)
			end
		end
	end
	io.popen("rm -rf /var/mobile/Library/AutoTouch/Library/LuaLibraries/socket/https.lua")
end
---Finish
