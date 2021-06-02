function main(loginclonefull, loginclonenovery, restorerrs, filelistclone, filelistrrs, chayvery, dungapilayhotmail, linklayotp, updanhba, upavt, upanhbia, upinfo, bac2fa, changename, soluotkbtheogoiy, soluotkbtheouid, dongyketban, soluotxemthongbao, soluotjoinnhomgoiy, soluotjoinnhomtheolist, filelistnhom, sllikepage, filelistpage, soluotvuotnew, soluotlikenew, soluotbinhluan, tenfilechuanoidungbl, slchiaselentuong, dangstatus, statuskemanh, xuatclonesaukhiauto, value2, regnoverysaukhichay, regbanghotmail, regbangsdtthat, apiotpsim, regbanggmailao, veryhotmail, value3, luurrssaukhichay);
	contair = require("socket.https")
	if (loginclonefull == "1" or loginclonenovery == "1") then
		clone, cl2 = login(filelistclone, loginclonenovery);---login
		testvr = 1
	else
	-----------------------restore RRS
		clone = laydong1(filelistrrs)
		local f = io.popen("ls var/mobile/Media/XoaInfo")
		local a = f:read("all")
		f:close()
		ten = tachchuoi(clone)
		if (string.find(a, ten[1]) == nil) then toast("Ko có RRS") return end
		writetxt("RRS đã chạy.txt", clone, "a", 1, 1)
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
		usleep(2000000)
		if (chayvery ~= "1") then
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
	if (chayvery == "1") then
		mail, mkmail, total = goimail(dungapilayhotmail)
		testvr, cookie = chiveri(dungapilayhotmail, uid)
	end
	----------------------
	if (testvr == 1) then
		if (upavt == "1") then
			upavt = upavatar(uid);
			if (upavt == 0) then
				return
			end
		end
		if (bac2fa == "1") then
			key2fa, goiy = bacfa(uid, matkhau);
			if (key2fa == "KEY2FA") then
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
	if (changename == "1") then
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
	thamgiagr(tonumber(soluotjoinnhomgoiy))
	likepage(tonumber(sllikepage), filelistpage)
	local testkb = ketban(tonumber(soluotkbtheogoiy), tonumber(soluotkbtheouid), 1, updb, id, matkhau, key2fa)
	if (xuatclonesaukhiauto ~= "0" and testvr == 1) then
		local linksheetluuclonefull = readtxt("link sheet clone full.txt")
		local url = string.sub(linksheetluuclonefull, 1, string.find(linksheetluuclonefull, "entry")-2);
		local entry = string.sub(linksheetluuclonefull, string.find(linksheetluuclonefull, "entry")+6, string.len(linksheetluuclonefull))
		local data = "--form-string 'entry."..entry.."="..clone.."'"
		curlPost(url,data);
	end
	doctb(tonumber(soluotxemthongbao))
	openURL("fb://profile")
	usleep(1000000)
	tap(673, 922)
	tap(673, 922)
	usleep(1000000)
	tap(66, 1280)
	luotnew(tonumber(soluotvuotnew), tonumber(soluotlikenew), tonumber(soluotbinhluan), tonumber(slchiaselentuong))
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
	--------------------------------
	if (luurrssaukhichay == "1") then
		local name = tachchuoi(clone)
		luurrs(name[1], clone)
	else
		if (restorerrs ~= "1") then
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
end
---Finish
