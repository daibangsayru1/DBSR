function main(loginclonefull, loginclonenovery, restorerrs, filelistclone, filelistrrs, chayvery, apikeydongvan, linklayotp, updanhba, upavt, upanhbia, upinfo, bac2fa, soluotkbtheogoiy, soluotkbtheouid, dongyketban, soluotxemthongbao, soluotjoinnhomgoiy, soluotjoinnhomtheolist, filelistnhom, likepage, filelistpage, soluotvuotnew, soluotlikenew, soluotbinhluan, tenfilechuanoidungbl, slchiaselentuong, dangstatus, statuskemanh, xuatclonesaukhiauto, linksheetluuclonefull, regnoverysaukhichay, linksheetluunovery, luurrssaukhichay);
	contair = require("socket.https")
	if (loginclonefull == "1" or loginclonenovery == "1") then
		clone, cl2 = login(filelistclone, loginclonenovery);---login
	else
	-----------------------restore RRS
		clone = laydong1(filelistrrs)
		writetxt("RRS đã chạy.txt", clone, "a", 1, 1)
		ten = tachchuoi(clone)
		local check = checkuid(ten[1])
		if (check == 1) then
			local f = io.popen("ls var/mobile/Media/XoaInfo")
			local a = f:read("all")
			f:close()
			local e = io.popen("rm -rf var/mobile/Media/XoaInfo/"..ten[1])
			repeat
				toast("Đang xóa RRS "..ten[1])
				usleep(2000000)
				local f = io.popen("ls var/mobile/Media/XoaInfo")
				local b = f:read("all")
				f:close()
			until(#a > #b)
			return
		end
		restore(ten[1])
		local temp = tachchuoi(clone)
		usleep(4000000)
		appRun("com.facebook.Facebook")
		usleep(2000000)
		x = waitcolor(399, 1260, 15201279, 515, 777, 31487, 287, 774, 31487, 355, 767, 31487, 362, 767, 31487, 354, 136, 1603570, 394, 136, 1603570, 496, 1261, 1603570, 594, 1267, 1603570, 10, 1)
		tapimg("xnok.jpg", 1, 1)
		if (x == 355 or x == 362 or x == 354 or x == 394) then
			tapimg("ok.jpg", 1, 2000000)
			tapimg("ok2.jpg", 1, 2000000)
			test = loginlai(temp[1],temp[2], temp[3])
			tap(66, 1280)
			usleep(2000000)
			tap(66, 1280)
			usleep(2000000)
		else
			local test2 = tapimg("dangnhap2.jpg", 1, 1000000)
			if (test2 == 1) then
				test = loginlai(temp[1],temp[2], temp[3])
				tap(66, 1280)
				usleep(2000000)
				tap(66, 1280)
				usleep(2000000)
			end
		end
		local testlogin = waitcolor(35, 88, 1603570, 139, 90, 1603570, 496, 1261, 1603570, 594, 1267, 1603570, 20, 1)
		local testok = tapimg("xnok.jpg", 1, 2000000)
		if (testok == 1) then
			testlogin = waitcolor(35, 88, 1603570, 139, 90, 1603570, 496, 1261, 1603570, 594, 1267, 1603570, 20, 1)
		end
		if (testlogin ~= 35 and testlogin ~= 139) then
			toast("Ko login dc")
			local f = io.popen("ls var/mobile/Media/XoaInfo")
			local a = f:read("all")
			f:close()
			repeat
				toast("Đang xóa RRS")
				io.popen("rm -rf var/mobile/Media/XoaInfo/"..ten[1])
				local f = io.popen("ls var/mobile/Media/XoaInfo")
				local b = f:read("all")
				f:close()
			until(#a > #b)
			return
		else
			toast("Login ok")
			testvr = 1
		end
	end
	----------------------
	if (cl2 == 0) then return end
	----------------------
	if (chayvery == "1") then
		mail, mkmail, total = goimail(apikeydongvan)
		testvr, cookie = chiveri(apikeydongvan, apiotp)
	end
	----------------------
	if (testvr == 1) then
		if (upavt == "1") then
			upavt = upavatar();
			if (upavt == 0) then
				return
			end
		end
		if (bac2fa == "1") then
			key2fa, goiy = bacfa();
			if (key2fa == "KEY2FA") then
				return
			end
			clone = clone.."|"..key2fa.."|"..cookie.."|"..mail.."|"..mkmail
		else
			clone = clone.."|"..cookie.."|"..mail.."|"..mkmail
		end
	else
		if (restorerrs == "1") then
			io.popen("mv var/mobile/Media/XoaInfo/"..id.."/ var/mobile/Media/RRSLOI")
		else
			resetdata()
		end
		return
	end
	---lưu lại ghi chú
	if (restorerrs == "1") then
		if(chayvery == "1" or bac2fa == "1") then
			local f = io.popen("ls var/mobile/Media/XoaInfo/"..ten[1].."/GhiChu")
			local a = f:read("all")
			f:close()
			repeat
				toast("Đang lưu ghi chú")
				local f = io.open("var/mobile/Media/XoaInfo/GhiChu.txt", "w") f:write(clone) f:close()
				local f = io.popen("mv var/mobile/Media/XoaInfo/GhiChu.txt var/mobile/Media/XoaInfo/GhiChu") f:close()
				local f = io.popen("mv var/mobile/Media/XoaInfo/GhiChu var/mobile/Media/XoaInfo/"..ten[1].."/GhiChu") f:close()
				local f = io.popen("ls var/mobile/Media/XoaInfo/"..ten[1].."/GhiChu")
				local b = f:read("all")
				f:close()
			until(#b > #a)
		end
	end
	-------------------------------
	thamgiagr(soluotjoinnhomgoiy)
	local testkb = ketban(slkb, sluid, 1, updb, id, matkhau, key2fa)
	if (apigg ~= "0" and testvr == 1) then
		local url = string.sub(apigg, 1, string.find(apigg, "entry")-2);
		local entry = string.sub(apigg, string.find(apigg, "entry")+6, string.len(apigg))
		local data = "--form-string 'entry."..entry.."="..clone.."'"
		curlPost(url,data);
	end
	doctb(sltb)
	luotnew(slvuot, sllike, slbl, slcs)
	if (slreg ~= 0) then
		local id, matkhau, test = novery(domain, kieureg, slkb, 1);
		if (id ~= 0) then
			ghichu = id.."|"..matkhau.."|"..test
			tapimg("ok.jpg", 1, 1000000)
			---------------------
				local url = string.sub(ggnvr, 1, string.find(ggnvr, "entry")-2);
				local entry = string.sub(ggnvr, string.find(ggnvr, "entry")+6, string.len(ggnvr))
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
		end
	end
end
---Finish
