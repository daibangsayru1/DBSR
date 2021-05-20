function main(tuychon, RRS, apirrs, apinvr, apigg, apimail, apiotp, updb, slkb, avatar, bac2fa, sluid, slreg, kieureg, domain, sdt, ggnvr, sltb, sljoin, slvuot, slbl, slcs, luu)
	contair = require("socket.https")
	if (RRS == 1) then
		local line = laydong1(apirrs)
		writetxt("RRS đã chạy.txt", line, "a", 1, 1)
		local ten = tachchuoi(line)
		local check = checkuid(ten[1])
		local uid = ten[1]
		if (check == 1) then
			io.popen("rm -rf var/mobile/Media/XoaInfo/"..ten[1])
			return
		end
		restore(ten[1])
		if (updb ~= 0) then
			Danhba()
		end
		local f = io.open("var/mobile/Media/XoaInfo/"..ten[1].."/GhiChu", "r")
		ghichu = f:read("all")
		clone = ghichu
		cookie = ""
		mail = ""
		mkmail = ""
		f:close()
		local temp = tachchuoi(ghichu)
		id, matkhau, key2fa = temp[1], temp[2], temp[3]
		io.popen("activator send switch-on.com.a3tweaks.switch.airplane-mode");
		usleep(2000000)
		io.popen("activator send switch-off.com.a3tweaks.switch.airplane-mode")
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
			io.popen("rm -rf var/mobile/Media/XoaInfo/"..ten[1])
			return
		else
			toast("Login ok")
			---io.popen("rm -rf var/mobile/Media/XoaInfo/"..ten[1])
			---luurrs(ten[1], line)
			---usleep(5000000)
			---return
		end
	else
		if (updb ~= 0) then
			Danhba()
		end
		clone, cl2 = login(apinvr);
		if (cl2 == 0) then
			return
		end
	end
	----------------------------
	if (cl2 == 0) then
		resetdata()
		return
	end
	-------------------------
	if (cl2 ~= 0 and cl2 ~= 2) then
		if (tuychon == 2) then
			local a = tachchuoi(clone)
			if (#a > 2) then
				alert("Định dạng sai: chỉ lấy uid và pass")
				stop()
			end
			mail, mkmail, total = goimail(apimail)
			testvr, cookie = chiveri(apimail, apiotp)
			if (testvr == 2) then
				mail = ""
				mkmail = ""
			end
		else
			testvr = 1
		end
		---
		if (testvr == 1 or testvr == 2) then
			if (avatar == 0 and bac2fa == 0) then
				ghichu = clone.."|"..cookie.."|"..mail.."|"..mkmail
				ghichu2 = clone.."|"..mail.."|"..mkmail
			end
			if (avatar == 1 and bac2fa == 0) then
				upavt = upavatar();
				if (upavt == 0) then
					return
				end
				ghichu = clone.."|KEY2FA|".."|"..cookie.."|"..mail.."|"..mkmail
			end
			if (bac2fa == 1 and avatar == 0) then
				key2fa, goiy = bacfa();
				if (key2fa == "KEY2FA") then
					return
				end
				ghichu = clone.."|"..key2fa.."|"..cookie.."|"..mail.."|"..mkmail
			end
			if (avatar == 1 and bac2fa == 1) then
				upavt = upavatar();
				if (upavt == 0) then
					return
				end
				key2fa, goiy = bacfa();
				if (key2fa == 0) then
					return
				end
				ghichu = clone.."|"..key2fa.."|"..cookie.."|"..mail.."|"..mkmail
				ghichu2 = clone.."|"..key2fa.."|"..mail.."|"..mkmail
			end
			---local test = doiten(id, matkhau)
		else
			if (RRS == 1) then
				io.popen("mv var/mobile/Media/XoaInfo/"..id.."/ var/mobile/Media/RRSLOI")
			else
				resetdata()
			end
			return
		end
	end
	thamgiagr(sljoin)
	local testkb = ketban(slkb, sluid, 1, updb, id, matkhau, key2fa)
	if (apigg ~= "0" and testvr == 1) then
		local url = string.sub(apigg, 1, string.find(apigg, "entry")-2);
		local entry = string.sub(apigg, string.find(apigg, "entry")+6, string.len(apigg))
		local data = "--form-string 'entry."..entry.."="..ghichu.."'"
		curlPost(url,data);
	end
	doctb(sltb)
	luotnew(slvuot, sllike, slbl, slcs)
	if (slreg ~= 0) then
		local id, matkhau, test = novery(domain, kieureg, slkb, 1);
		if (id ~= 0) then
			ghichu = id.."|"..matkhau.."|"..test
			tapimg("ok.jpg", 1, 1000000)
			---tap(666, 1280)
			---usleep(1000000)
			--tap(666, 1280)
			---usleep(1000000)
			---tap(666, 1280)
			---appKill("com.facebook.Facebook")
			---usleep(1000000)
			---appRun("com.facebook.Facebook")
			---waitcolor(35, 88, 1603570, 139, 90, 1603570, 30, 1)
			---tap(66, 1280)
			---usleep(1000000)
			---mail, mkmail, total = goimail(apimail)
			---test3, cookie = chiveri(apimail, apiotp)
			---if (test3 == 1) then
				---ghichu = id.."|"..matkhau.."|"..mail.."|"..mkmail.."|"..os.date("%d")..os.date("%m").."_device_2"
				---local url = string.sub(apigg, 1, string.find(apigg, "entry")-2);
				---local entry = string.sub(apigg, string.find(apigg, "entry")+6, string.len(apigg))
				---local data = "--form-string 'entry."..entry.."="..ghichu.."'"
				---curlPost(url,data);	
			---else
			---------------------
				local url = string.sub(ggnvr, 1, string.find(ggnvr, "entry")-2);
				local entry = string.sub(ggnvr, string.find(ggnvr, "entry")+6, string.len(ggnvr))
				local data = "--form-string 'entry."..entry.."="..ghichu.."'"
				curlPost(url,data);	
			---end
			---local id2, matkhau2, test2 = novery(domain, kieureg, slkb, 1);
			---if (id2 ~= 0) then
				--ghichu2 = id2.."|"..matkhau2
				--local url = string.sub(ggnvr, 1, string.find(ggnvr, "entry")-2);
				--local entry = string.sub(ggnvr, string.find(ggnvr, "entry")+6, string.len(ggnvr))
				--local data = "--form-string 'entry."..entry.."="..ghichu2.."'"
				--curlPost(url,data);	 
			--end
		end
	end
	if (tuychon == 4) then
	end
	if (luu == 1) then
		local name = tachchuoi(ghichu)
		luurrs(name[1], ghichu2)
	else
		if (RRS ~= 1) then
			resetdata()
		end
	end
end
---Finish
