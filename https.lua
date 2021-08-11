function tapchu(text, space)
	local tababc = {"@|421|1283", ".|517|1283", "1|35|960", "2|111|960", "3|187|960", "4|259|960", "5|334|960", "6|412|960", "7|488|960", "8|564|960", "9|638|960", "0|713|960", "q|35|960", "w|111|960", "e|187|960", "r|259|960", "t|334|960", "y|412|960", "u|488|960", "i|564|960", "o|638|960", "p|713|960", "a|72|1070", "s|145|1070", "d|223|1070", "f|300|1070", "g|373|1070", "h|450|1070", "j|525|1070", "k|599|1070", "l|676|1070", "z|147|1170", "x|221|1170", "c|299|1170", "v|374|1170", "b|451|1170", "n|527|1170", "m|599|1170", " |315|1280"}																				
	local tababc2 = {"à", "á", "ả", "ã", "ạ", "ă", "ằ", "ắ", "ẳ", "ẵ", "ặ", "â", "ầ", "ấ", "ẩ", "ẫ", "ậ", "đ", "e"}
	local tem = string.sub(text, 1, string.len(text))
	num = 1
	for i = 1, #tem do
		local abc = string.sub(tem, i, i)
		if (string.upper(abc) == abc and type(tonumber(abc)) ~= "number" and abc ~= " " and abc ~= "@" and abc ~= ".") then
			tap(43, 1183)
			sleep(1)
			for k = 1, #tababc do
			local tem = tachchuoi(tababc[k])
			if (string.lower(abc) == tem[1]) then
				tap(tem[2], tem[3])
			end
		end
		end
		local abc2 = string.sub(tem, i+1, i+1)
		if (type(tonumber(abc)) == "number" and num == 1) then
			tap(50, 1280)
			sleep(1)
			num = 2
		end
		for j = 1, #tababc do
			local tem = tachchuoi(tababc[j])
			if (abc == tem[1]) then
				tap(tem[2], tem[3])
			end
		end
		if (type(tonumber(abc2)) ~= "number" and type(tonumber(abc)) == "number") then
			tap(50, 1280)
			sleep(1)
		else
			--num = 2
		end
	end
end
function checkuid(uid)
	toast("Đang check uid")
	repeat
		https = require("ssl.https")
		body, code, headers, status = https.request('https://graph.facebook.com/'..uid..'/picture')
		if (body == nil or headers == nil) then
			io.popen("activator send switch-on.com.a3tweaks.switch.airplane-mode");
			usleep(2000000)
			io.popen("activator send switch-off.com.a3tweaks.switch.airplane-mode")
			usleep(10000000)
		end
	until (body ~= nil or headers ~= nil)
	test = headers["content-type"]
	if (test == "image/gif") then
		toast("uid die")
		return 1
	else
		toast("uid live")
		return 0
	end
end
function getsdt(api_codetextnow)
	local http = require("socket.http")
	local i = 1
	repeat
		sleep(2)
		local body = http.request("http://codetextnow.com/api.php?apikey="..api_codetextnow.."&action=create-request&serviceId=1&count=1")
		if (body ~= nil) then
			if (string.find(body, "sdt") ~= nil) then
				local a = string.sub(body, string.find(body, "%[")+1, string.len(body))
				local b = string.sub(a, 1, string.find(a, "%]")-1)
				local c = json.decode(b)
				local sdt = c["sdt"]
				local requestId = c["requestId"]
				toast("get sdt codetextnow")
				return sdt, requestId
			else
				for i = 1, 5 do
					toast(body.."_codetextnow")
					sleep(2)
				end
				return 0, 0
			end
		else
			return 0
		end
		i = i + 1
	until (1 == 2)
end
---
function getsdt2(api_otpmmo)
	repeat
		local body = http.request("https://otpmmo.xyz/textnow/api.php?apikey="..api_otpmmo.."&type=getphone&qty=1")
		if (body ~= nil) then
			if (string.len(body) == 10) then
				toast("get sdt otpmmo")
				return body
			else
				for i = 1, 5 do
					toast(body.."_otpmmo")
					sleep(2)
				end
				return 0
			end
		else
			return 0
		end
		sleep(2)
	until(string.len(body) == 10)
end
---
function getsdt3(api_simfast)
	local json = require("json")
	repeat
		local body = http.request("https://access.simfast.vn/api/ig/request?api_token="..api_simfast.."&serviceId=19")
		if (string.find(body, "session_id") ~= nil) then
			id = string.sub(body, string.find(body, "session_id")+12, string.find(body, "session_id")+18)
		else
			for i = 1, 5 do
				toast(body.."_simfast")
				sleep(2)
			end
		end
	until(string.find(body, "session_id") ~= nil)
	repeat
		local body = http.request("https://access.simfast.vn/api/ig/code?api_token="..api_simfast.."&sessionId="..id)
		local b = string.sub(body, string.find(body, "data")+6, string.find(body, "}"))
		local a = json.decode(b)
		if (a["phone"] ~= nil) then  toast("get sdt simfast") return a["phone"], id end
	until(a["phone"] ~= nil)
end
---
function getsdt4(api_otpsim)
	idnet = "4"
	repeat
		local iddv = "7"
		local http = require("socket.http")
		local json = require("json")
		local body = http.request("http://otpsim.com/api/phones/request?token="..api_otpsim.."&service="..iddv.."&network="..idnet)
		local test = string.find(body, "false")
		if (test ~= nil) then
			toast("Hết sim "..idnet)
		else
			id = string.sub(body, string.find(body, "session")+10, string.len(body)-3)
			sdt = string.sub(body, string.find(body, "phone_number")+15, string.find(body, "phone_number")+23)
			return sdt, id
		end
	until(test == nil)
end
---
function getotp(site, sdt)
	if (site == 1) then
		local i = 1;
		repeat
			toast("Chờ otp.. "..i)
			sleep(4)
			local body = http.request("http://codetextnow.com/api.php?apikey="..api_codetextnow.."&action=data-request&requestId="..requestId)
			if (body ~= nil) then
				if (string.find(body, "%[") ~= nil) then
					local a = string.sub(body, string.find(body, "%[")+1, string.len(body))
					local b = string.sub(a, 1, string.find(a, "%]")-1)
					local c = json.decode(b)
					otp = c["otp"]
					if (#otp ~= 0) then
						toast("OTP: "..otp)
						return otp
					end
				end
			else
				alert("body1")
				stop()
			end
			i = i + 1
			if (i == 12) then
				return 0
			end
		until(i == 12);
	else
		if (site == 2) then
			local i = 1;
			repeat
				toast("Chờ otp.. "..i)
				sleep(4)
				local body = http.request("https://otpmmo.xyz/textnow/api.php?apikey="..api_otpmmo.."&type=getotp&sdt="..sdt)
				if (body ~= nil) then
					if (string.len(body) > 3) then
						local tem = string.sub(body, 2, string.len(body)-1)
						local json = require("json")
						local tem2 = json.decode(tem)
						local tem3 = tem2["otp"]
						local otp = string.sub(tem3, 1, string.find(tem3, " "))
						return otp
					else
					end
				else
					alert("body2")
					stop()
				end
				i = i + 1
				if (i == 12) then
					return 0
				end
			until(i == 12);
		else
			local i = 1;
			repeat
				toast("Chờ otp.. "..i)
				sleep(4)
				local body = http.request("https://access.simfast.vn/api/ig/code?api_token="..api_simfast.."&sessionId="..seson)
				local b = string.sub(body, string.find(body, "data")+6, string.find(body, "}"))
				local a = json.decode(b)
				if (a["sms"] ~= nil) then return string.sub(a["sms"], 1, 5) end
				i = i + 1
				if (i == 12) then
					return 0
				end
			until(i == 12);
		end
	end
end
----------
function goisim(web_sim, api_codetextnow, api_otpmmo)
	local c = readtxt("sdt chờ.txt")
	local d = type(c)
	if (d == "nil") then
		toast("Hết sim")
		if (web_sim == "codetextnow") then
			local a = getsdt(api_codetextnow)
			if (a ~= 0) then
				toast("Get sdt codetextnow")
				writetxt("sdt chờ.txt", a, "a", 1, 1)
				writetxt("data.txt", "", "a", 1, 1)
				writetxt("data.txt", a, "a", 1, 0)
			end
		end
		if (web_sim == "otpmmo") then
			local b = getsdt2(api_otpmmo)
			if (b ~= 0) then
				toast("Get sdt otpmmo")
				writetxt("sdt chờ.txt", b, "a", 1, 1)
				writetxt("data.txt", "", "a", 1, 1)
				writetxt("data.txt", b, "a", 1, 0)
			end
		end
	end
end
function upavatar(id, apikey, urlweb, api)
	sleep(2)
	local http = require("socket.http")
	openURL("fb://profile")
	usleep(1500000)
	tap(669, 913)
	tap(669, 913)
	tap(669, 913)
	usleep(1000000)
	tap(50,100)
	usleep(1000000)
	local test = tapimg("xnok.jpg", 1, 2000000)
	if (test == 1) then tap(45, 111) sleep(2) end
	tapimg("x.jpg", 1, 1500000)
	tapimg("dung2.jpg", 1, 2000000)
	local region = {181, 370, 564, 750};
	local testavt1 = tapimg2("avt.jpg", 1, 1000000, region)
	local testavt2 = tapimg2("avt2.jpg", 1, 1000000, region) 
	if (testavt1 == 1 or testavt2 == 1) then
		local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..apikey.."/upavt")
		openURL("photos-redirect://")
		waitcolor(53, 84, 31487, 557, 284, 31487, 466, 1278, 31487, 20, 1)
		tap(450, 1280)
		tap(450, 1280)
		usleep(1000000);
		tap(196, 490);
		usleep(1500000);
		tap(125, 1099);
		----
		waitcolor(694, 1287, 31487, 365, 1272, 31487, 55, 1281, 31487, 7, 1)

		tap(50, 1284);---tap chia sẻ
		usleep(2000000);
		tapimg("iconfb.jpg", 1, 1)
		tapimg("iconfb2.jpg", 1, 1)
		usleep(2000000);
		tap(194, 1264);
		---C&#211; 2 giao diện
		---
		local x = waitcolor(53, 84, 5869823, 634, 84, 228095, 678, 85, 228095, 10, 1)
		tap(678, 85);
		tap(678, 140);
		tap(678, 130);
		tap(678, 85);
	---
		local x = waitcolor(694, 1287, 31487, 365, 1272, 31487, 55, 1281, 31487, 25, 1)
		if (x ~= 694 and x ~= 365 and x ~= 55) then
			tap(62, 81)
			sleep(2)
			tap(382, 1126)
			sleep(3)
			tap(696, 135)
			sleep(2)
		end
		tap(696, 1284);
		usleep(1500000);
		tap(375, 1133);
		usleep(1500000);
		appRun("com.facebook.Facebook")
		usleep(3000000)
		tapimg("xnok.jpg", 1, 2000000)
		local te = tapimg("chonanh3.jpg", 1, 1000000)
		local te2 = tapimg("chonanh4.jpg", 1, 1000000)
		if (te ~= 1 and te2 ~= 1) then
			openURL("fb://profile")
			usleep(1000000)
			tap(673, 922)
			tap(673, 922)
			usleep(1000000)
			tap(50,100)
			usleep(1000000)
			tapimg("xnok.jpg", 1, 2000000)
			tapimg("x.jpg", 1, 1500000)
			tapimg("dung2.jpg", 1, 2000000)
			tapimg("mayanh.jpg", 1, 1000000)
			sleep(2)
			tap(285, 1149)
			---local te = tapimg("chonanh3.jpg", 1, 1000000)
			---local te2 = tapimg("chonanh4.jpg", 1, 1000000)
		end
		x = waitcolor(605, 316, 2191323, 145, 311, 328965, 20, 1)
		keoxuong(1000)
		tap(144, 759)
		---tap(141, 1184);
		usleep(1000000)
		x1 = getColor(572, 1307)---13225169
		x2 = getColor(696, 1307)
		if (x1 == 13225169 or x2 == 13225169) then
			keolen(10000)
			tap(154, 486);
			usleep(1000000)
		end
		usleep(1000000)
		tap(658, 94);
		tap(658, 94);
		waitcolor(104, 279, 9080209, 90, 495, 9080209, 160, 922, 1799396, 539, 922, 1603570, 30, 1)
	end
	
end
------
---------
function regclone(reg_clone, web_sim, api_codetextnow, api_otpmmo, api_simfast, api_otpsim, very_acc, avt, fa, luu_rss, link_gg_sheet)
	local api = readtxt("api key.txt")
	local urlweb = readtxt("site.txt")
	local json = require("json")
	local http = require("socket.http")
	if (very_acc == "0") then
		if (web_sim == "0") then
			toast("Lấy data.txt")
			line = daodong("data.txt")
			sdt = string.sub(line, 1, 7)..os.date("%d")..math.random(0, 9)
		else
			sdt = laydong1("sdt chờ.txt")
			testsdt = 1
			if (sdt == nil) then
				testsdt = 2
				toast("sdt chờ trống, lấy data.txt")
				line = daodong("data.txt")
				sdt = string.sub(line, 1, 7)..os.date("%d")..math.random(0, 9)
			end
			if (web_sim == "codetextnow") then
				local a = getsdt(api_codetextnow)
				if (a ~= 0) then
					toast("Get sdt codetextnow")
					writetxt("sdt chờ.txt", a, "a", 1, 1)
					writetxt("data.txt", "", "a", 1, 1)
					writetxt("data.txt", a, "a", 1, 0)
				end
			end
			if (web_sim == "otpmmo") then
				local b = getsdt2(api_otpmmo)
				if (b ~= 0) then
					toast("Get sdt otpmmo")
					writetxt("sdt chờ.txt", b, "a", 1, 1)
					writetxt("data.txt", "", "a", 1, 1)
					writetxt("data.txt", b, "a", 1, 0)
				end
			end
		end
	else
		if (web_sim == "codetextnow") then
			repeat
				local a, a1 = getsdt(api_codetextnow)
				if (a ~= 0) then
					sdt = a
					site = 1
					requestId = a1
					toast("Get sdt codetextnow")
					writetxt("data.txt", "", "a", 1, 1)
					writetxt("data.txt", a, "a", 1, 0)
				else
					toast("Chờ codetextnow")
					sleep(2)
				end
			until (a ~= 0)
		end
		if (web_sim == "otpmmo") then
			repeat
				local b = getsdt2(api_otpmmo)
				if (b ~= 0) then
					sdt = b
					site = 2
					toast("Get sdt otpmmo")
					writetxt("data.txt", "", "a", 1, 1)
					writetxt("data.txt", b, "a", 1, 0)
				else
					toast("Chờ otpmmo")
					sleep(2)
				end
			until (b ~= 0)
		end
		if (web_sim == "simfast") then
			sdt, seson = getsdt3(api_simfast)
			toast("Get sdt simfast")
			site = 3
		end
		if (web_sim == "otpsim") then
			sdt, seson = getsdt4(api_otpsim)
			toast("Get sdt otpsim vn")
		end
	end
	local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..getapi().."/moappfb")
	appRun("com.facebook.Facebook");
	x = waitcolor(399, 1260, 15201279, 515, 777, 31487, 287, 774, 31487, 20, 0);
	tap(399, 1260);
	usleep(500000);
	tap(399, 1260);
	waitcolor(380, 303, 1603570, 302, 523, 1603570, 15, 1);
	tap(302, 523);
	local x = waitcolor(286, 256, 1603570, 286, 256, 328965, 5, 0);
	if (x ~= 286) then
		tap(153, 400)
	else
		tap(153, 348);
	end
	usleep(300000)
	ho = daodong("họ.txt")
	---tapchu(ho)
	inputText(ho)
	usleep(300000)
	tap(430, 357);
	usleep(300000);
	ten = daodong("tên.txt")
	local tem = daodong("pass.txt")
	---tapchu(ten)
	inputText(ten)
	usleep(300000)
	tap(50, 1280)
	usleep(300000)
	tap(617, 1288);
	waitcolor(134, 256, 1603570, 15, 0);
	if (very_acc == "0" and web_sim ~= "0") then
		goisim(web_sim, api_codetextnow, api_otpmmo)
	end
	local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..getapi().."/dientt")
	touchDown(3, 581.97, 1057.27);
	usleep(33058.08);
	touchMove(3, 580.94, 1074.57);
	usleep(17112.62);
	touchMove(3, 584.01, 1102.07);
	usleep(16438.46);
	touchMove(3, 591.20, 1168.25);
	usleep(16539.92);
	touchMove(3, 606.59, 1236.46);
	usleep(16519.04);
	touchMove(3, 618.92, 1281.26);
	usleep(14959.42);
	touchUp(3, 623.02, 1285.33);
	usleep(434978.88);
	
	local x = os.date "%X"
	local y = string.sub(x, string.len(x), string.len(x));
	local z = "7"..y.."0000";
	usleep(z);
	
	touchDown(4, 564.51, 1116.32);
	usleep(82669.29);
	touchUp(4, 564.51, 1116.32);
	usleep(784912.12);
	
	touchDown(5, 419, 1082.71);
	usleep(32556.92);
	touchMove(5, 419, 1111.23);
	usleep(16622.38);
	touchMove(5, 419, 1142.78);
	usleep(16781.08);
	touchMove(5, 419, 1195.73);
	usleep(16544.67);
	touchMove(5, 419, 1249.69);
	usleep(14891.42);
	touchUp(5, 419, 1253.76);
	usleep(418820.38);
	
	local x = os.date "%X"
	local y = string.sub(x, string.len(x), string.len(x));
	local z = "7"..y.."0000";
	usleep(z);
	
	touchDown(6, 419, 1137.69);
	usleep(98232.38);
	touchUp(6, 419, 1137.69);
	usleep(668236.67);
	
	touchDown(1, 172.43, 1056.25);
	usleep(50063.46);
	touchMove(1, 171.40, 1071.52);
	usleep(16813.96);
	touchMove(1, 171.40, 1116.32);
	usleep(16501.92);
	touchMove(1, 172.43, 1197.76);
	usleep(16551.38);
	touchMove(1, 183.72, 1265.99);
	usleep(16695.46);
	touchMove(1, 199.12, 1307.72);
	usleep(15203.12);
	touchUp(1, 203.22, 1311.81);
	usleep(434736.29);
	
	local x = os.date "%X"
	local y = string.sub(x, string.len(x), string.len(x));
	local z = "7"..y.."0000";
	usleep(z);
	
	
	touchDown(2, 180.64, 1136.68);
	usleep(133961.33);
	touchUp(2, 180.64, 1136.68);
	usleep(100000);
	---------------------
	tap(599, 866);
	waitcolor(190, 304, 1603570, 15, 0);
	local x = getColor(249, 438);---4612766
	if (x ~= 4612766) then
		tap(700, 490);
		usleep(500000);
		tap(380, 819);
	else
		tap(250, 461);
		usleep(1000000);
	end
	waitcolor(170, 298, 1603570, 15, 1);
	if (reg_clone == "reg_sdt_ngoai") then
		tap(78, 400)
		usleep(1500000)
		tap(253, 290)
		sleep(2)
	end
	tap(300, 395);
	sleep(2)
	if (very_acc == "0" and web_sim ~= "0") then
		goisim(web_sim, api_codetextnow, api_otpmmo)
	end
	tapso(sdt)
	usleep(300000);
	tap(669, 867);
	---.Điền mật khẩu---
	waitcolor(273, 245, 1603570, 5, 0);
	local b = os.date("%M")..os.date("%S")
	matkhau = tem..b
	---tapchu(matkhau)
	inputText(matkhau)
	usleep(300000)
	tap(50, 1280)
	usleep(500000);
	tap(634, 1287);
	waitcolor(272, 674, 1799396, 298, 673, 1603570, 298, 700, 1603570, 10, 0)
	tap(298, 680);
	local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..getapi().."/chodk")
	---v&#242;ng lặp chờ kết quả đăng k&#253;
	local i = 1;
	j = 1;
	repeat
		---t&#234;n sai
		ten1 = getColor(225, 431);---15738953
		ten2 = getColor(420, 431);---15738953
		if (ten1 == 15738953 or ten2 == 15738953) then
			if (getColor(154, 256) == 1603570 or getColor(179, 255) == 1603570) then
				usleep(1000000)
				tap(709, 1174);
				usleep(300000);
				tap(663, 1285);
			else
				tap(328, 352)
				tap(328, 352);
				usleep(500000);
				ho = daodong("họ.txt")
				inputText(ho)
				usleep(500000)
				tap(684, 352);
				tap(684, 352);
				usleep(500000)
				ten = daodong("tên.txt")
				inputText(ten)
				usleep(500000)
				tap(600, 352)
				tap(666, 1280);
				usleep(2000000)
			end
		end
		local cp301 = getColor(257, 1267)---, 1799396, 
		local cp302 = getColor(459, 1265)---, 1799396
		local test = getColor(381, 765)---31487
		local testsdt = getColor(124, 431)---15738953
		---nếu hiện th&#234;m ảnh
		local x1 = getColor(228, 1141);---1603570
		local x2 = getColor(240, 1259);---1668851
		---nếu hiện very sdt
		local x3 = getColor(354, 474);---1603570
		local x4 = getColor(375, 475);---1603570
		---nếu hiện t&#236;m bạn b&#232;
		local x5 = getColor(277, 1081);---1603571
		local x6 = getColor(550, 1081);---1538034
		local x7 = getColor(169, 903);---1603570
		local x8 = getColor(633, 897);
		local i1 = getColor(292, 553)
		local cpmail1 = getColor(281, 686)--- 14540770)
		local cp1 = getColor(278, 508);---1603571
		local cp2 = getColor(469, 508);---1538034
		local gd1 = getColor(306, 474)--- 1799396)
	---	waitcolor(278, 508, 2984191, 469, 508, 2984191, 60, 0)
		---lỗi ko thể xử l&#253; đăng k&#253;
		if (testsdt == 15738953) then
			if (very_acc == "0") then
				if (web_sim == "0") then
					toast("Lấy data.txt")
					line = daodong("data.txt")
					sdt = string.sub(line, 1, 7)..os.date("%d")..math.random(0, 9)
				else
					toast("Lấy data.txt")
					line = daodong("data.txt")
					sdt = string.sub(line, 1, 7)..os.date("%d")..math.random(0, 9)
					if (web_sim == "codetextnow") then
						local a = getsdt(api_codetextnow)
						if (a ~= 0) then
							toast("Get sdt codetextnow")
							writetxt("sdt chờ.txt", a, "a", 1, 1)
							writetxt("data.txt", "", "a", 1, 1)
							writetxt("data.txt", a, "a", 1, 0)
						end
					end
					if (web_sim == "otpmmo") then
						local b = getsdt2(api_otpmmo)
						if (b ~= 0) then
							toast("Get sdt otpmmo")
							writetxt("sdt chờ.txt", b, "a", 1, 1)
							writetxt("data.txt", "", "a", 1, 1)
							writetxt("data.txt", b, "a", 1, 0)
						end
					end
				end
			else
				if (web_sim == "codetextnow") then
					repeat
						local a, a1 = getsdt(api_codetextnow)
						if (a ~= 0) then
							sdt = a
							site = 1
							requestId = a1
							toast("Get sdt codetextnow")
							writetxt("data.txt", "", "a", 1, 1)
							writetxt("data.txt", a, "a", 1, 0)
						else
							toast("Chờ codetextnow")
							sleep(2)
						end
					until (a ~= 0)
				end
				if (web_sim == "otpmmo") then
					repeat
						local b = getsdt2(api_otpmmo)
						if (b ~= 0) then
							sdt = b
							site = 2
							toast("Get sdt otpmmo")
							writetxt("data.txt", "", "a", 1, 1)
							writetxt("data.txt", b, "a", 1, 0)
						else
							toast("Chờ otpmmo")
							sleep(2)
						end
					until (b ~= 0)
				end
				if (web_sim == "simfast") then
					sdt, seson = getsdt3(api_simfast)
					toast("Get sdt simfast")
					site = 3
				end
			end
			tap(689, 355)
			tapso(sdt)
			usleep(300000);
			tap(669, 867);
		end
		if (getColor(355, 784) == 31487 or getColor(373, 784) == 31487) then
			break
		end
		i = i + 1;
		usleep(1000000)
	until(gd1 == 1799396 or cp301 == 1799396 or cp302 == 1799396 or cpmail1 == 14540770 or i1 == 1603570 or cp1 == 2984191 or cp2 == 2984191 or test == 31487 or i == 35 or x1 == 1603570 or x2 == 1668851 or x3 == 1603570 or x4 == 1603570 or x5 == 1603570 or x6 == 1603570 or x5 == 1603571 or x6 == 1538034 or x7 == 1603570 or x8 == 1603570)
	local x9 = getColor(355, 784);---31487
	local x10 = getColor(373, 784);---31487
	local x11 = getColor(381, 783);---31487
	---nếu hiện th&#234;m ảnh
	local x1 = getColor(228, 1141);---1603570
	local x2 = getColor(240, 1259);---1668851
	---nếu hiện very sdt
	local x3 = getColor(354, 474);---1603570
	local x4 = getColor(375, 475);---1603570
	---nếu hiện t&#236;m bạn b&#232;
	local x5 = getColor(277, 1081);---1603571
	local x6 = getColor(550, 1081);---1538034
	local cpmail1 = getColor(281, 686)--- 14540770)
	local gd1 = getColor(306, 474)--- 1799396)
	---nếu reg ok th&#236; xử l&#253; tếp
	if (gd1 == 1799396 or x == 35 or x == 139 or x1 == 1603570 or x2 == 1668851 or x3 == 1603570 or x4 == 1603570 or x5 == 1603570 or x6 == 1603570 or x5 == 1603571 or x6 == 1538034) then
		local apikey = getapi()
		local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..apikey.."/dkthanhcong")
		copyText("11")
		if (very_acc == "0" and web_sim ~= "0") then
			goisim(web_sim, api_codetextnow, api_otpmmo)
		end
		if (getColor(35, 88) == 1603570 or getColor(139, 90) == 1603570) then
			tap(66, 1280)
		end
		for i = 1, 6 do
			tapimg("skip.jpg", 1, 1000000)
		end
		
		cookie = clipText()
		local test1 = findimg("addmail.jpg", 1, 1)
		if (test1 ~= 1) then
			test2 = findimg("xnmail.jpg", 1, 1)
		else
			test2 = 0
		end
		if (test1 ~= 1 and test2 ~= 1 or very_acc == "0") then
			if (avt == "1") then
				upavatar(id, apikey, urlweb, api)
			end
			if (cookie == "11") then
				local i = 1
				repeat
					openURL("fb://profile");
					usleep(1000000);
					cookie = clipText();
					i = i + 1
				until(cookie ~= "11" or i == 4)
			end
			id = string.sub(cookie, string.find(cookie, "c_user=")+7, string.find(cookie, "c_user=")+21)
			if (fa == "1") then
				key2fa, goiy = bacfa(id, matkhau, apikey, urlweb, api);
				clone = id.."|"..matkhau.."|"..key2fa.."|"..cookie
			else
				clone = id.."|"..matkhau.."|"..cookie
			end
			local url = string.sub(link_gg_sheet, 1, string.find(link_gg_sheet, "entry")-2);
			local entry = string.sub(link_gg_sheet, string.find(link_gg_sheet, "entry")+6, string.len(link_gg_sheet))
			local data = "--form-string 'entry."..entry.."="..clone.."'"
			curlPost(url,data);
			toast("Lỗi vr, lưu nvr")
		else
			local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..apikey.."/very")
			if (cookie == "11") then
				tap(372, 791)
				usleep(2000000)
				tap(42, 84)
				usleep(2000000)
			end
			local otp = getotp(site, sdt)
			if (otp == 0) then
				toast("lỗi otp, lưu nvr")
				if (string.find(cookie, "c_user=") == nil) then
					repeat
						openURL("fb://profile");
						usleep(1000000);
						cookie = clipText();
					until(string.find(cookie, "c_user=") ~= nil)
				end
				id = string.sub(cookie, string.find(cookie, "c_user=")+7, string.find(cookie, "c_user=")+21)
				local link = readtxt("link sheet clone nvr.txt")
				local url = string.sub(link, 1, string.find(link, "entry")-2);
				local entry = string.sub(link, string.find(link, "entry")+6, string.len(link))
				local data = "--form-string 'entry."..entry.."="..id.."|"..matkhau.."|"..cookie.."'"
				curlPost(url,data);
			else
				tap(359, 364);
				tap(359, 364);
				usleep(500000);
				inputText(otp);
				usleep(500000);
				tap(379, 474);
				usleep(1000000) 
				waitcolor(620, 907, 1603570, 610, 907, 1603570, 213, 785, 31487, 249, 788, 31487, 511, 788, 31487, 34, 89, 1603570, 139, 93, 1603570, 20, 1)
				for i = 1, 6 do
					tapimg("skip.jpg", 1, 1000000)
				end	
				x = waitcolor(620, 907, 1603570, 610, 907, 1603570, 213, 785, 31487, 249, 788, 31487, 511, 788, 31487, 34, 89, 1603570, 139, 93, 1603570, 20, 1)
	  			if (x == 213 or x == 249 or x == 511) then
				
				else
					if (getColor(35, 88) ~= 1603570 and getColor(139, 90) ~= 1603570) then
						appKill("com.facebook.Facebook");
						usleep(1000000)
						appRun("com.facebook.Facebook");
						usleep(2000000)
					end
					if (avt == "1") then
						upavatar(id)
					end
					cookie = clipText();
					local id = string.sub(cookie, string.find(cookie, "c_user=")+7, string.find(cookie, "c_user=")+21)
					local link = readtxt("link sheet clone full.txt")
					local url = string.sub(link, 1, string.find(link, "entry")-2);
					local entry = string.sub(link, string.find(link, "entry")+6, string.len(link))
					local data = "--form-string 'entry."..entry.."="..id.."|"..matkhau.."|"..cookie.."'"
					curlPost(url,data);
					toast("vr ok, lưu data")
				end
			end
		end
		if (luu_rss ~= "0") then
			alert("Chưa xử lý")
			stop()
		else
			resetdata()
		end
	else
		local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..getapi().."/dkthatbai")
		resetdata()
	end
end
---
function getclone(urlweb, api)
	local http = require("socket.http")
	local body = http.request(urlweb.."/api/getacc/"..api)
	if (string.find(body, "uid") ~= nil) then
		local a = json.decode(body)
		local uid = a["uid"]
		local password = a["password"]
		if (string.len(a["2fa"]) > 40) then
			key2fa = 0
		else
			key2fa = a["2fa"]
		end
		local b = a["uid"].."|"..a["password"].."|"..a["2fa"].."|"..a["cookie"].."|"..a["token"].."|"..a["mail"].."|"..a["passmail"]
		local clone = string.gsub(b, "|||", "")
		return clone, uid, password, key2fa
	else
		alert(body)
		stop()
	end
end
function doiten(id, matkhau)
	---usleep(2000000)
	---appKill("com.facebook.Facebook")
	---usleep(2000000)
	---appRun("com.facebook.Facebook")
	---usleep(4000000)
	---x = waitcolor(399, 1260, 15201279, 515, 777, 31487, 287, 774, 31487, 355, 767, 31487, 362, 767, 31487, 354, 136, 1603570, 394, 136, 1603570, 496, 1261, 1603570, 594, 1267, 1603570, 10, 1)
	---tapimg("xnok.jpg", 1, 2000000)
	---local testlogin = waitcolor(35, 88, 1603570, 139, 90, 1603570, 496, 1261, 1603570, 594, 1267, 1603570, 20, 1)
	---local testok = tapimg("xnok.jpg", 1, 2000000)
	---local check = checkuid(id)
	---if (check == 1) then
	---	return 0
	---end
	tap(691, 1289);
	tap(691, 1289);
	---nếu giao diện m&#224;u xan
	usleep(1000000)
	---TH hiện m&#224;n
	keoxuong(1000)
	keoxuong(1000)
	local a = tapimg("caidat.jpg", 1, 1000000)
	local b = tapimg("caidat2.jpg", 1, 1000000)
	if (a ~= 1 and b ~= 1) then
		tap(285, 1085);
		usleep(2000000)
		tapimg("caidat.jpg", 1, 1000000)
		tapimg("caidat2.jpg", 1, 1000000)
	end
	x = waitcolor(62, 1047, 13556448, 69, 1196, 13556448, 83, 694, 13556448, 20, 1)
	if (getColor(62, 1047) ~= 13556448 and getColor(69, 1196) ~= 13556448 and getColor(83, 694) ~= 13556448) then
		tap(43, 89);
		usleep(2000000);
		if (getColor(300, 655) == 16777215) then
			tap(273, 649);
		else
			tap(273, 770);
		end
		x = waitcolor(62, 1047, 13556448, 69, 1196, 13556448, 83, 694, 13556448, 20, 1)
	end
	tapimg("thongtin.jpg", 1, 1000000)
	waitcolor(217, 207, 328965, 344, 207, 328965, 60, 0)
	tap(76, 399)
	waitcolor(255, 853, 4227327, 531, 852, 4227327, 60, 0)
	tap(266, 332)
	usleep(2000000)
	tap(300, 332)
	usleep(2000000)
	tap(300, 332)
	usleep(2000000)
	touchDown(6, 704, 1176)
	usleep(2000000)
	touchUp(6, 704, 1176)
	usleep(1000000)
	local fi = daodong("tên.txt")
	local la = daodong("họ.txt")
	inputText(fi)
	usleep(1000000)
	tap(294, 520)
	usleep(2000000)
	touchDown(6, 704, 1176)
	usleep(2000000)
	touchUp(6, 704, 1176)
	usleep(1000000)
	inputText(la)
	usleep(1000000)
	tap(666, 1280)
	local x = waitcolor(254, 796, 4227327, 157, 157, 16772072, 680, 353, 6724345, 60, 0)
	if (x == 157) then
		repeat
			tap(50, 100)
			usleep(3000000)
			tap(76, 399)
			waitcolor(255, 853, 4227327, 531, 852, 4227327, 60, 0)
			tap(266, 332)
			usleep(2000000)
			tap(300, 332)
			usleep(2000000)
			touchDown(6, 704, 1176)
			usleep(2000000)
			touchUp(6, 704, 1176)
			usleep(1000000)
			local fi = daodong("tên.txt")
			local la = daodong("họ.txt")
			inputText(fi)
			usleep(1000000)
			tap(294, 520)
			usleep(2000000)
			touchDown(6, 704, 1176)
			usleep(2000000)
			touchUp(6, 704, 1176)
			usleep(1000000)
			inputText(la)
			usleep(1000000)
			tap(666, 1280)
			local x = waitcolor(254, 796, 4227327, 157, 157, 16772072, 680, 353, 6724345, 60, 0)
		until(x ~= 157 or x == 680)
	end
	usleep(1000000)
	tap(201, 715)
	usleep(1000000)
	inputText(matkhau)
	usleep(1000000)
	tap(666, 1280)
	usleep(5000000)
end
---
---------------
function danhbatxt(folder, slkb)
	local f = io.open("/var/mobile/Library/AutoTouch/danhba.vcf", "w");
	f:write("");
	f:close();
	local f = io.popen("ls "..currentPath().."/"..folder)
	local file = f:read("*l")
	f:close()
	local f = io.open("/var/mobile/Library/AutoTouch/danhba.vcf", "a");
	local f2 = io.open(currentPath().."/"..folder.."/"..file, "r")
	repeat
		local sdt = f2:read("*l")
		if (sdt ~= nil) then
			f:write("BEGIN:VCARD", "\n")
			f:write("VERSION:3.0", "\n")
			f:write("TITLE;CHARSET=UTF-8:", "\n")
			f:write("ORG;CHARSET=UTF-8:;", "\n")
			f:write("TEL;PREF;MOBILE:"..sdt, "\n");
			f:write("END:VCARD", "\n");
		end
	until(sdt == nil)
	f:close();
	f2:close()
	openURL("filza://var/mobile/Library/AutoTouch/danhba.vcf")
	waitcolor(464, 476, 16777177, 698, 476, 228607, 20, 1)
	tap(464, 476)
	usleep(1000000)
	waitcolor(53, 135, 31487, 693, 137, 31487, 20, 1);
	tap(693, 137);
	waitcolor(696, 84, 31487, 734, 314, 31487, 30, 1)
	io.popen("rm -rf "..currentPath().."/"..folder.."/"..file)
	appRun("com.facebook.Facebook");
	waitcolor(35, 88, 1603570, 139, 90, 1603570, 60, 0)
	tap(666, 1280)
	tap(691, 1289);
	---nếu giao diện m&#224;u xanh
	usleep(1000000)
	---TH hiện m&#224;n
	keoxuong(5000)
	tap(285, 1085);
	usleep(2000000)
	if (getColor(300, 655) == 16777215) then
		tap(273, 649);
	else
		tap(273, 770);
	end
	waitcolor(446, 92, 15001323, 596, 92, 15001323, 60, 0)
	tap(300, 100)
	usleep(1000000)
	inputText("Tải danh bạ")
	waitcolor(52, 232, 7830920, 86, 194, 13030361, 60, 0)
	tap(100, 232)
	waitcolor(305, 426, 2191323, 401, 431, 2191323, 60, 0)
	tap(690, 345)
	waitcolor(338, 221, 13449787, 363, 655, 3889560, 5, 1)
	tap(371, 1101)
	x = waitcolor(697, 368, 1603570, 700, 470, 1603570, 331, 648, 12501705, 409, 637, 12501705, 50, 1)
	for i = 1, slkb do
		tapimg("them.jpg", 1, 1)
	end
	tap(667, 95);
	usleep(1500000);
	tap(66, 1280)
end
----------------
function luotuid(sluid, sllike, slbl, slcs, adduid)
	local j = 0
	repeat
		local uid = laydong1("uid.txt")
		openURL("fb://profile?id="..uid)
		usleep(3000000)
		tapimg("xnok.jpg", 1, 2000000)
		if (adduid == 1) then
			tapimg("addprofile.jpg", 1, 2000000)
		end
		local i = 0
		local k = 0
		local m = 0
		local l = 0
		repeat
			for n = 1, 5 do
				keoxuong(8000)
				local testlike = tapimg("like.jpg", 1, 1000000)
				if (testlike == 1) then
					if (m ~= slbl) then
						local test1 = tapimg("binhluan.jpg", 1, 3000000)
						if (test1 == 1) then
							m = m + 1
							local text, cont = readtxt("binhluan.txt")
							writetxt2("binhluan.txt", cont, text, "w", 1)
							inputText(text)
							usleep(1000000)
							tap(691, 852)
							usleep(3000000)
							tap(50, 100)
							usleep(2000000)
						end
					end
					if (l ~= slcs) then
						local test1 = tapimg("chiase.jpg", 1, 2000000)
						if (test1 == 1) then
							l = l + 1
							tapimg("chiase2.jpg", 1, 3000000)
						end
					end
					k = k + 1
					break
				end
				if (n == 5 and testlike == 0) then
					test = 0
					break
				end
			end
		until(k == sllike or test == 0)
		test = 1
		m = 0
		l = 0
		j = j + 1
	until(j == sluid)
end
--- sluid: số uid muốn bay vào, uid bỏ vào file uid.txt
--- adduid: có kết bạn với uid đó ko (ghi 1 hoặc 0)

function likelink(file)
	local url = laydong1(file)
	openURL(url)
	waitcolor(77, 195, 291302, 685, 180, 31487, 60, 0)
	tap(685, 180)
	usleep(5000000)
end

function ketban(slkb, sluid, time, updb, id, matkhau, key2fa)
	if (slkb == 0 and sluid == 0) then return end
	local test = tapimg("add.jpg", 1, 1000000)
	local test2 = tapimg("add0.jpg", 1, 1000000)
	if (test == 0 and test2 == 0) then
		tap(666, 1280)
		usleep(1000000)
		tap(666, 1280)
		usleep(1000000)
		tap(666, 1280)
		usleep(2000000)
		tapimg("add2.jpg", 1, 1000000)
		tapimg("add3.jpg", 1, 1000000)
	end
	y = waitcolor(458, 468, 1603570, 458, 613, 1603570, 458, 845, 1603570, 461, 685, 1603570, 7, 1)
	if (y ~= 458 and y ~= 461) then
		if (updb ~= 0) then
			local test = tapimg("updb.jpg", 1, 1000000)
			local test2 = tapimg("bat.jpg", 1, 1000000)
			if (test == 1 or test2 == 1) then
				waitcolor(338, 221, 13449787, 363, 655, 3889560, 5, 1)
				tap(371, 1100)
				x = waitcolor(697, 368, 1603570, 700, 470, 1603570, 331, 648, 12501705, 409, 637, 12501705, 50, 1)
				tap(667, 95);
				usleep(1500000);
				tapimg("xong.jpg", 1, 1000000)
				keolen(500)
				y = waitcolor(458, 468, 1603570, 458, 613, 1603570, 458, 845, 1603570, 461, 685, 1603570, 7, 1)
				if (y ~= 458 and y ~= 461) then
					return 0
				end
			end
		end
	end
	if (slkb == 0) then return end
	local i, k = 0, 0
	repeat
		for j = 1, 4 do
			testkb = tapimg("addfr.jpg", 1, time)
			testkb2 = tapimg("addfr2.jpg", 1, time)
			if (testkb == 1 or testkb2 == 1) then
				i = i + 1
				if (i == slkb) then return 1 end
			end
			k = k + 1
		end
		if (i == slkb) then return 1 end
		keoxuong(10000)
		usleep(500000)
		testkb = tapimg("addfr.jpg", 1, time)
		testkb2 = tapimg("addfr2.jpg", 1, time)
		if (testkb ~= 1 and testkb2 ~= 1) then 
			local te = tapimg("ok.jpg", 1, 2000000)
			if (te == 1) then
				test = loginlai(id, matkhau, key2fa)
			else
				usleep(1)
			end
			local test = tapimg("add.jpg", 1, 1000000)
			if (test == 0) then
				tap(666, 1280)
				usleep(1000000)
				tap(666, 1280)
				usleep(1000000)
				tap(666, 1280)
				usleep(2000000)
				tapimg("add2.jpg", 1, 3000000)
				tapimg("add3.jpg", 1, 3000000)
				testkb = tapimg("addfr.jpg", 1, time)
				testkb2 = tapimg("addfr.jpg", 1, time)
				if (testkb ~= 1 and testkb2 ~= 1) then return end
			end
		end
	until(i == sl)
	if (sluid ~= 0) then
		if (sluid == 0) then return end
		local i, k = 0, 0
		repeat
			repeat
				uid , cont = readtxt("uid.txt")
				test = checkuid(uid)
				if (test == 0) then 
					writetxt2("uid.txt", cont, uid, "w", 1)
				else 
					writetxt("uid.txt", cont, "w", 1, 0) 
				end
			until(test == 0)
			openURL("fb://profile?id="..uid)
			usleep(2000000)
			local test = tapimg("addprofile.jpg", 1, 2000000)
			tapimg("thembb.jpg", 1, 1000000)
			if (test == 1) then
				i = i + 1
				if (i == sluid) then return end
			end
			k = k + 1
			if (k > i) then 
				return
			end
		until (i == sluid)
	end
end
------
function likepage(sl, file)
	for i = 1, sl do
		local page = daodong(file)
		openURL("fb://profile?id="..page)
		waitcolor(141, 803, 1603570, 400, 803, 1603570, 60, 1)
		tapimg("likepage.jpg", 1, 500000)
	end
end
function vuotnew()
	touchDown(3, 393.10, 932.05);
	usleep(16438.96);
	touchMove(3, 393.10, 878.08);
	usleep(16646.92);
	touchMove(3, 393.10, 801.71);
	usleep(16673.17);
	touchMove(3, 393.10, 719.25);
	usleep(14974.17);
	touchUp(3, 393.10, 715.18);
	usleep(434912.25);

	touchDown(1, 393.10, 594.01);
	usleep(9858.58);
	touchUp(1, 393.10, 594.01);
	usleep(1000000)
end
function luotnew(slvuot, sllike, slbl, slcs)
	vuot, like, bl, cs = 0, 0, 0, 0
	if (vuot == slvuot) then return end
	tap(66, 1280)
	usleep(1000000)
	tap(66, 1280)
	usleep(1000000)
	keolen(2000)
	usleep(3000000)
	tapimg("xnok.jpg", 1, 2000000)
	keolen(2000)
	usleep(3000000)
	tapimg("xnok.jpg", 1, 2000000)
	repeat
		local test1 = tapimg("ok.jpg", 1, 2000000)
		if (test1 == 1) then
			loginlai(matkhau, key2fa)
		end
		keoxuong(8000)
		usleep(1000000)
		if (like ~= sllike) then
			local test1 = tapimg("like.jpg", 1, 1000000)
			if (test1 == 1) then
				like = like + 1
			end
		end
		if (bl ~= slbl) then
			local test1 = tapimg("binhluan.jpg", 1, 3000000)
			if (test1 == 1) then
				bl = bl + 1
				local text, cont = readtxt("binhluan.txt")
				writetxt2("binhluan.txt", cont, text, "w", 1)
				inputText(text)
				usleep(1000000)
				tap(691, 852)
				usleep(3000000)
				tap(66, 1280)
				usleep(2000000)
				keoxuong(8000)
				usleep(1000000)
			end
		end
		if (cs ~= slcs) then
			local test1 = tapimg("chiase.jpg", 1, 2000000)
			if (test1 == 1) then
				cs = cs + 1
				tapimg("chiase2.jpg", 1, 3000000)
			end
		end
		vuot = vuot + 1
	until (vuot == slvuot)
end


------
function loginlai(uid, matkhau, key2fa)
	local test = tapimg("dangnhap2.jpg", 1, 2000000)
	if (test == 1) then
		tap(267, 541);
		usleep(1000000)
		tap(673, 329)
		usleep(1000000)
		inputText(uid)
		usleep(500000)
		tap(229, 417);
		usleep(500000)
		inputText(matkhau)
		usleep(500000)
		tap(270, 520);
		x = waitcolor(35, 88, 1603570, 139, 90, 1603570, 355, 785, 31487, 382, 785, 31487, 30, 1)
	else
		tap(374, 557)
		usleep(2000000)
		local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/matkhau.jpg", 1, 0.99, nil)
		for i, v in pairs(img) do
			tap(v[1], v[2])
			usleep(1000000)
			inputText(matkhau)
			usleep(1000000)
			local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/dangnhap.jpg", 1, 0.99, nil)
			for i, v in pairs(img) do
				tap(v[1], v[2])
				usleep(1000000)
			end
		end
		x = waitcolor(35, 88, 1603570, 139, 90, 1603570, 355, 785, 31487, 382, 785, 31487, 30, 1)
	end
	if (x == 355 or x == 382) then
		local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/ok.jpg", 1, 0.99, nil)
		for i, v in pairs(img) do
			tap(v[1], v[2])
			usleep(2000000)
			local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/ma2fa.jpg", 1, 0.99, nil)
			for i, v in pairs(img) do
				tap(v[1], v[2])
				http = require("socket.http")
				local body = http.request("https://2fa.live/tok/"..key2fa);
				json = require("json");
				temp1 = json.decode(body)
				otp2fa = temp1["token"]
				inputText(otp2fa);
				usleep(1000000)
				local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/dangnhap.jpg", 1, 0.99, nil)
				for i, v in pairs(img) do
					tap(v[1], v[2])
					usleep(1000000)
				end
			end
			waitcolor(35, 88, 1603570, 139, 90, 1603570, 355, 785, 31487, 382, 785, 31487, 30, 1)
		end
	end
	return 1
end
------
function kbtheogr(sl, matkhau, key2fa)
	tap(66, 1280)
	usleep(2000000)
	keolen(5000)
	usleep(1000000)
	i, j = 1, 1
	repeat
		local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/xnok.jpg", 1, 0.99, nil)
		for i, v in pairs(img) do
			tap(v[1], v[2])
			usleep(2000000)
		end
		local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/muiten.jpg", 1, 0.99, nil)
		for i, v in pairs(img) do
			tap(v[1]-50, v[2])
			usleep(2000000)
			local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/addprofile.jpg", 1, 0.99, nil)
			for i, v in pairs(img) do
				tap(v[1], v[2])
				usleep(2000000)
				local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/thembb.jpg", 1, 0.99, nil)
				for i, v in pairs(img) do
					tap(v[1], v[2])
					usleep(2000000)
				end
				local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/addfr.jpg", 5, 0.99, nil)
				for i, v in pairs(img) do
					tap(v[1], v[2])
					local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/addfr.jpg", 5, 0.99, nil)
					for i, v in pairs(img) do
						tap(v[1], v[2])
					end
					return
				end
				local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/updb.jpg", 1, 0.99, nil)
				for i, v in pairs(img) do
					tap(v[1], v[2])
					usleep(1000000)
					x = waitcolor(338, 221, 13449787, 363, 655, 3889560, 3, 1)
					tap(371, 1101)
					x = waitcolor(697, 368, 1603570, 700, 470, 1603570, 331, 648, 12501705, 409, 637, 12501705, 50, 1)
					local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/them.jpg", 10, 0.99, nil)
					for i, v in pairs(img) do
						tap(v[1], v[2])
						usleep(1000000)
						tap(666, 50)
						usleep(1000000)
						tap(666, 50)
						usleep(2000000)
						keolen(5000)
						usleep(2000000)
						return
					end
				end
				j = j + 1
			end
			tap(66, 1280)
			usleep(1000000)
		end
		tap(66, 1280)
		usleep(1000000)
		tap(66, 1280)
		usleep(2000000)
		loginlai(matkhau, key2fa)
	until (j == sl+1)
end
------
function doctb(sl)
	if (sl == 0) then return end
	for j = 0, sl do
		openURL("fb://notifications")
		usleep(2000000)
		local result = findColor(15201279, 1, nil);
		for i, v in pairs(result) do
			tap(v[1], v[2]);
			usleep(3000000)
		end
	end
end
------
function thamgiagr(sl)
	soluot = 0
	if (soluot == sl) then return end
	local test = tapimg("gr1.jpg", 1, 1000000)
	if (test == 0) then
		tap(666, 1280)
		usleep(2000000)
		tap(666, 1280)
		usleep(1000000)
		keolen(5000)
		usleep(1000000);
		tapimg("gr3.jpg", 1, 1000000)
		tapimg("gr2.jpg", 1, 1000000)
	end
	tapimg("xnok.jpg", 1, 2000000)
	keoxuong(8000)
	usleep(1000000)
	local test = tapimg("thamgia.jpg", 1, 500000)
	tapimg("thamgia.jpg", 1, 500000)
	tapimg("thamgia.jpg", 1, 500000)
	tapimg("thamgia.jpg", 1, 1000000)
	if (test ~= 1) then
		keolen(1000)
		keolen(1000)
		keolen(1000)
		usleep(1000000)
		tapimg("khampha.jpg", 1, 1000000)
		for i = 1, 1 do
			tapimg("xnok.jpg", 1, 2000000)
			keoxuong(8000)
			usleep(1000000)
			tapimg("thamgia.jpg", 1, 500000)
			tapimg("thamgia.jpg", 1, 500000)
			tapimg("thamgia.jpg", 1, 500000)
			tapimg("thamgia.jpg", 1, 500000)
		end
	end
	appKill("com.facebook.Facebook");
	usleep(2000000)
	appRun("com.facebook.Facebook");
	waitcolor(35, 88, 1603570, 139, 90, 1603570, 60, 0)
end
---

------
------

function Danhba()
	local f = io.open("/var/mobile/Library/AutoTouch/danhba.vcf", "w");
	f:write("");
	f:close();
	local f = io.open("/var/mobile/Library/AutoTouch/danhba.vcf", "a");
	local dsdt = {"097","098","096","032","033","034","035","036","037","038","090","091","092","093","094","095","099","070","078","085","081","082","083","084"};
	for i = 1, 200 do
		local sdt = dsdt[math.random(24)]..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)
		f:write("BEGIN:VCARD", "\n")
		f:write("VERSION:3.0", "\n")
		f:write("TITLE;CHARSET=UTF-8:", "\n")
		f:write("ORG;CHARSET=UTF-8:;", "\n")
		f:write("TEL;PREF;MOBILE:"..sdt, "\n");
		f:write("END:VCARD", "\n");
	end
	f:close();
	openURL("filza://var/mobile/Library/AutoTouch/danhba.vcf")
	waitcolor(464, 476, 16777177, 698, 476, 228607, 20, 1)
	tap(464, 476)
	usleep(1000000)
	waitcolor(53, 135, 31487, 693, 137, 31487, 20, 1);
	tap(693, 137);
	waitcolor(696, 84, 31487, 734, 314, 31487, 30, 1)
	---appRun("com.facebook.Facebook");
end
------
function modulecurl(url, method, header, params)
	local curlRequest = "curl -m 5 --location --request " .. method .. " '" .. url .. "'"
	for k, v in pairs (header) do
		curlRequest = curlRequest .. " --header '"..v.."'"
	end
	for k, v in pairs (params) do
		curlRequest = curlRequest .. " --data-urlencode '"..v.."'"
	end
	local file = io.popen(curlRequest,'r');
	local f = file:read('*all');
	file:close();
	if f ~= nil then
		return f
	else return false end
end
------
function modulecurlRaw(url, method, header, raw)
	local curlRequest = "curl -m 5 --location --request " .. method .. " '" .. url .. "'"
	for k, v in pairs (header) do
		curlRequest = curlRequest .. " --header '"..v.."'"
	end
	curlRequest = curlRequest .. " --data-raw '"..raw.."'"
	local file = io.popen(curlRequest,'r');
	local f = file:read('*all');
	file:close();
	if f ~= nil then
		return f
	else return false end
end
-------
function exec(cmd)
	local p = io.popen(cmd)
	local result = ''
	for file in p:lines() do
		if result == '' then
			result = file
		else
			result = result .. "\n" .. file
		end
	end
	return result
end
------
function curl(url, method, header, params)
	local curlRequest = "curl --location --request " .. method .. " '" .. url .. "'"
	for k, v in pairs (header) do
		curlRequest = curlRequest .. " --header '"..v.."'"
	end
	for k, v in pairs (params) do
		curlRequest = curlRequest .. " --data-urlencode '"..v.."'"
	end
	local body = exec(curlRequest)
	if body == '' or body == nil then
		return nil
	end
	return body
end
------
function mailninja()
	abc ={"q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m"}
	account = abc[math.random(#abc)]..abc[math.random(#abc)]..abc[math.random(#abc)]..abc[math.random(#abc)]..abc[math.random(#abc)]..math.random(0,9)..math.random(0,9).."_"..abc[math.random(#abc)]..math.random(0,9)..math.random(0,9)..math.random(0,9)..abc[math.random(#abc)]
	tempmail = {"juzab.com", "ludxc.com", "xedmi.com", "pudxe.com", "mecip.net", "pidox.org", "buxod.com", "muyoc.com"}
	repeat
		response = modulecurlRaw('https://tempmail.ninja/api/create-recover-email', 'POST', {'referer: https://tempmail.ninja/', 'content-type:application/json'}, '{"ne_ne":"'..account..'","ne_dominio":"'..tempmail[math.random(#tempmail)]..'","action":"create","language":"en"}')
		if (string.find(response, "temp_mail") ~= nil) then
			json = require("json")
			respbody = json.decode(response)
			mkmail = math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)
			mail = respbody["temp_mail"]
			response2 = modulecurlRaw('https://tempmail.ninja/api/update-password', 'POST', {'referer: https://tempmail.ninja/', 'content-type:application/json'}, '{"tempmail":"'..mail..'","current_password":"","new_password":"'..mkmail..'","language":"en","timezone":-25200}')
			return mail, mkmail
		end
	until(string.find(response, "temp_mail") ~= nil)
end
------
function login(urlweb, api, loginclonenovery, apikey)
	local http = require("socket.http")
	a = appState("com.ienthach.XoaInfo")
	if (a == "ACTIVATED") then
		i = 1;
		repeat
			keyDown(KEY_TYPE.HOME_BUTTON);
			usleep(79712.00);
			keyUp(KEY_TYPE.HOME_BUTTON);
			usleep(119447.25);
			usleep(2000000)
			resetdata();
			i = i + 1
			a = appState("com.ienthach.XoaInfo")
			if (i == 4) then
				alert("Lỗi xóa info hoặc hết 3g");
				stop();
			end
		until(a == "NOT RUNNING")
	end
	appRun("com.facebook.Facebook");
	local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..apikey.."/login")
	local x = waitcolor(399, 1260, 15201279, 515, 777, 31487, 287, 774, 31487, 20, 0);
	if (x ~= 399 and x ~= 515 and x ~= 287) then
		resetdata()
		appRun("com.facebook.Facebook");
		local x = waitcolor(399, 1260, 15201279, 515, 777, 31487, 287, 774, 31487, 20, 0);
	end
	tap(267, 541);
	usleep(1000000)
	j = 1
	repeat
		repeat
			clone, uid, password, key2fa = getclone(urlweb, api)
			writetxt("clone đã chạy.txt", clone, "a", 1, 1)
			if (clone == nil) then
				alert(filelistclone.." trống")
				stop();
			end
			test = checkuid(uid)
			if (test == 1) then
				writetxt("Clone DIE.txt", clone, "a", 1, 1)
			end
		until(test ~= 1)
		inputText(uid);
		usleep(500000)
		tap(229, 417);
		usleep(500000)
		inputText(password)
		usleep(500000)
		tap(270, 520);
		toast("Chờ kết quả")
		x, y = waitcolor(572, 86, 4351922, 580, 40, 4351922, 661, 1263, 1603570, 35, 88, 1603570, 139, 90, 1603570, 525, 506, 1603570, 708, 469, 1603570, 353, 326, 1269698, 73, 767, 1269698, 60, 1)
		if (x == 353 or x == 73) then
			if (getColor(206, 604) == 0 or getColor(543, 607) == 0) then
				local te = tachchuoi(clone)
				key2fa = string.gsub(te[3], " ", "")
				if (key2fa == 0) then 
					toast("Ko có Key2fa")
					return 0, 0
				else
					key2fa = string.gsub(key2fa, " ", "")
					local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/ok.jpg", 1, 0.99, nil)
					for i, v in pairs(img) do
						tap(v[1], v[2])
						usleep(1000000)
						local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/ma2fa.jpg", 1, 0.99, nil)
						for i, v in pairs(img) do
							tap(v[1], v[2])
							local body = request("https://2fa.live/tok/"..key2fa);
							json = require("json");
							temp1 = json.decode(body)
							otp2fa = temp1["token"]
							usleep(500000)
							inputText(otp2fa);
							usleep(1000000)
							local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/dangnhap.jpg", 1, 0.99, nil)
							for i, v in pairs(img) do
								tap(v[1], v[2])
								usleep(1000000)
							end
						end
						waitcolor(35, 88, 1603570, 139, 90, 1603570, 355, 785, 31487, 382, 785, 31487, 30, 1)
					end
					tap(66, 1280)
					usleep(3000000)
					tap(66, 1280)
					usleep(3000000)
					tap(66, 1280)
					usleep(3000000)
					return clone, 2
				end
			end
			toast("Lỗi login")
			writetxt("Login Lỗi.txt", clone, "a", 1, 1)
		end
		j = j + 1
		if (j == 2 and x ~= 35 and x ~= 139) then
			return 0, 0
		end
	until(x == 35 or x == 139)
	return clone
end
-----
function goimail(dungapilayhotmail)
	toast("Đang lấy mail")
	if (dungapilayhotmail ~= "0") then
		local f = io.open(currentPath().."/hotmail.txt", "r")
		local temp = f:read("*line")
		f:close()
		local f = io.open(currentPath().."/hotmail.txt", "w")
		f:write("")
		f:close()
		if (temp == nil) then
			usleep(1)
		else
			local temp2 = tachchuoi(temp)
			mail, mkmail, total = temp2[1], temp2[2], 1
			return mail, mkmail, total
		end
		local apikeydongvan = readtxt("api key dongvan.txt")
		https = require("ssl.https")
		local body = https.request("http://dongvanfb.com/api/buyaccount.php?apiKey="..apikeydongvan.."&type=1&amount=1")
		if (body == nil) then alert("nill") end
		if (string.find(body, ".com") == nil) then
			repeat
				toast("Hết mail")
				body = https.request("http://dongvanfb.com/api/buyaccount.php?apiKey="..apikeydongvan.."&type=1&amount=1")
			until(string.find(body, ".com") ~= nil)
		end
		local json = require("json")
		local te = json.decode(body)
		local te2 = tachchuoi(te["accounts"])
		mail = te2[1]
		mkmail = te2[2]
		temp = string.sub(body, string.find(body, "balance")+9, string.len(body)-1);
		total = math.floor(tonumber(temp)/50)
		return mail, mkmail, total
	else
		local temp = laydong1("hotmail.txt")
		if (temp == nil) then
			alert("Hết mail") stop()
		end
		local temp2 = tachchuoi(temp)
		mail, mkmail, total = temp2[1], temp2[2], 1
		return mail, mkmail, total
	end
end
------
function chiveri(dungapilayhotmail, id)
	local a = readtxt("log.txt")
	local log = tonumber(a)
	if (log == 3) then 
		alert("Lỗi very die liên tiếp") 
		writetxt("log.txt", 0, "w", 0, 0)
		stop() 
	end
	copyText(0)
	if (getColor(35, 88) == 1603570 or getColor(139, 90) == 1603570) then
		tap(66, 1280)
	end
	x = waitcolor(394, 444, 1603570, 395, 508, 1603570, 707, 500, 1603570, 525, 506, 1603570, 708, 469, 1603570, 4, 0)
	tapimg("skip.jpg", 1, 1000000)
	tapimg("skip.jpg", 1, 1000000)
	tapimg("skip.jpg", 1, 1000000)
	tapimg("skip.jpg", 1, 1000000)
	---
	local test1 = tapimg("addmail.jpg", 1, 1)
	local test1 = tapimg("addmail.jpg", 1, 1)
	if (test1 ~= 1) then
		test2 = tapimg("xnmail.jpg", 1, 1)
		test2 = tapimg("xnmail.jpg", 1, 1000000)
	else
		test2 = 0
	end
	---if (x ~= 395 and x ~= 707 and x ~= 708 and x ~= 525 and x ~= 394) then
	if (test1 ~= 1 and test2 ~= 1) then
		local i = 1
		repeat
			appRun("com.apple.SpringBoard");
			usleep(1000000)
			appRun("com.facebook.Facebook");
			usleep(2000000)
			if (getColor(35, 88) == 1603570 or getColor(139, 90) == 1603570) then
				tap(66, 1280) 
				usleep(2000000)
			end
			if (getColor(35, 88) == 1603570 or getColor(139, 90) == 1603570) then
				tap(66, 1280)
				usleep(2000000)
			end
			tapimg("xnok.jpg", 1, 1000000)
			tapimg("skip.jpg", 1, 1000000)
			tapimg("skip.jpg", 1, 1000000)
			tapimg("skip.jpg", 1, 1000000)
			tapimg("skip.jpg", 1, 1000000)
			x = waitcolor(394, 444, 1603570, 395, 508, 1603570, 707, 500, 1603570, 525, 506, 1603570, 708, 469, 1603570, 2, 0)
			local test1 = tapimg("addmail.jpg", 1, 1)
			if (test1 ~= 1) then
				test2 = tapimg("xnmail.jpg", 1, 1)
			else
				test2 = 0
			end
			i = i + 1;
			if (i == 5) then
				cookie = clipText()
				tap(691, 1289);
				usleep(1000000)
				keoxuong(2000)
				tapimg("xnok.jpg", 1, 2000000)
				tap(285, 1085);
				repeat
					usleep(2000000)
					local test1 = tapimg("caidat.jpg", 1, 1000000)
					local test2 = tapimg("caidat2.jpg", 1, 1000000)
				until(test1 == 1 or test2 == 1)
				tes = checkuid(id)
				if (tes == 1) then
					writetxt("Clone DIE.txt", id.."|"..matkhau, "a", 1, 1)
					resetdata();
					return 0
				end
	---
				x = waitcolor(62, 1047, 13556448, 69, 1196, 13556448, 83, 694, 13556448, 20, 1)
				if (getColor(62, 1047) ~= 13556448 and getColor(69, 1196) ~= 13556448 and getColor(83, 694) ~= 13556448) then
					tap(43, 89);
					usleep(2000000);
					if (getColor(300, 655) == 16777215) then
						tap(273, 649);
					else
						tap(273, 770);
					end
					x = waitcolor(62, 1047, 13556448, 69, 1196, 13556448, 83, 694, 13556448, 20, 1)
				end
				tapimg("baomat.jpg", 1, 1000000)
				waitcolor(580, 591, 1603570, 643, 662, 1603570, 580, 662, 1603570, 639, 682, 1603570, 643, 622, 1603570, 5, 1)
				---tap xem tấc cả
				---tap(642, 613)
				tapimg("xemtacca.jpg", 1, 1)
				tap(642, 595)
				usleep(3000000)
				local test = tapimg("dangxuattb.jpg", 1, 2000000)
				if (test ~= 1) then
					local test = tapimg("dangxuattb.jpg", 1, 2000000)
					if (test ~= 1) then
						keoxuong(1000)
						usleep(1000000)
						local test = tapimg("dangxuattb.jpg", 1, 2000000)
					end
				end
				local x = waitcolor(268, 494, 4227327, 500, 494, 4227327, 20, 0)
				if (x ~= 268 and x ~= 500) then
					alert("Lỗi")
					stop()
				end
				tap(300, 494)
				local x = waitcolor(100, 188, 3889560, 273, 465, 1603570, 466, 465, 1603570, 20, 1)
				if (x == 273 or x == 466 or x == 100) then
					if (x == 100) then
						usleep(1000000)
						tap(378, 708)
						usleep(1000000)
						tap(363, 511)
					else
						usleep(1000000)
						tap(378, 587)
						usleep(2000000)
						tap(373, 589)
						usleep(2000000)
						tap(300, 257)
					end
					usleep(1000000)
					inputText(mail)
					usleep(1000000)
					tap(377, 367)
					waitcolor(139, 1185, 1603570, 272, 1187, 1603570, 20, 1)
					tap(559, 1184)
					usleep(2000000)
					urlotp = "http://14.225.27.38/api/getcode.php?apiKey=2sadasd&type=1&user="..mail.."&pass="..mkmail
					local i = 1;
					repeat
						toast("Chờ otp.. "..i)
						local body = request(urlotp)
						local text = string.find(body, "Facebook");
						if (string.find(body, "Facebook") ~= nil) then
							otp = string.sub(body, string.find(body, "code")+7, string.find(body, "sender")-4)
							toast("OTP: "..otp)
							tap(409, 390);
							usleep(1000000);
							inputText(otp);
							usleep(500000);
							tap(370, 509);
							usleep(6000000)
							appKill("com.facebook.Facebook");
							usleep(2000000)
							appRun("com.facebook.Facebook");
							usleep(3000000)
						end
						test = checkuid(id)
						if (test == 1) then
							log = log + 1
							writetxt("log.txt", log, "w", 0, 0)
							writetxt("Clone DIE.txt", clone, "a", 1, 1)
							return 0, 0
						end
						i = i + 1
						if (i == 12) then
							writetxt("Lỗi OTP.txt", clone, "a", 1, 1)
							return 0, 0
						end
					until(text ~= nil);
				else
					writetxt("hotmail.txt", mail.."|"..mkmail, "a", 1, 1)
					appKill("com.facebook.Facebook");
					usleep(2000000)
					appRun("com.facebook.Facebook");
					usleep(3000000)
					return 1, cookie
				end
				writetxt("log.txt", 0, "w", 0, 0)
				cookie = clipText()
				return 1, cookie
			end
		until(i == 5 or test1 == 1 or test2 == 1)
	end
	---nếu hiện very sdt
	local x = waitcolor(354, 327, 1603570, 395, 329, 1603570, 20, 0);
	if (x ~= 354 and x ~= 395) then
		local test1 = tapimg("addmail.jpg", 1, 1000000)
		test2 = tapimg("xnmail.jpg", 1, 1000000)
		local x = waitcolor(354, 327, 1603570, 395, 329, 1603570, 20, 0);
	end
	tap(700, 219);
	tap(700, 219)
	usleep(500000);
	inputText(mail)
	usleep(500000);
	tap(631, 1281)
	usleep(2000000);
	x = waitcolor(154, 544, 0, 381, 845, 31487, 35, 88, 1603570, 139, 90, 1603570, 620, 907, 1603570, 610, 907, 1603570, 355, 809, 31487, 382, 809, 31487, 382, 793, 31487, 354, 474, 1603570, 375, 475, 1603570, 60, 1)
	----
	if (x == 355 or x == 382) then
		tap(355, 809)
		usleep(2000000)
		tap(380, 343)
	end
	cookie = clipText();
	copyText("")
	---lấy otp
	urlotp = "http://14.225.27.38/api/getcode.php?apiKey=2sadasd&type=1&user="..mail.."&pass="..mkmail
	local i = 1;
	repeat
		toast("Chờ otp.. "..i)
		local body = request(urlotp)
		local text = string.find(body, "Facebook");
		if (string.find(body, "Facebook") ~= nil) then
			otp = string.sub(body, string.find(body, "code")+7, string.find(body, "sender")-4)
			toast("OTP: "..otp)
			tap(359, 364);
			tap(359, 364);
			usleep(500000);
			inputText(otp);
			usleep(500000);
			tap(379, 474);
			usleep(1000000) 
		end
		test = checkuid(id)
		if (test == 1) then
			log = log + 1
			writetxt("log.txt", log, "w", 0, 0)
			writetxt("Clone DIE.txt", clone, "a", 1, 1)
			return 0, 0
		end
		i = i + 1
		if (i == 12) then
			writetxt("Lỗi OTP.txt", clone, "a", 1, 1)
			return 0, 0
		end
	until(text ~= nil);
	x = waitcolor(620, 907, 1603570, 610, 907, 1603570, 213, 785, 31487, 249, 788, 31487, 511, 788, 31487, 34, 89, 1603570, 139, 93, 1603570, 20, 1)
	test = checkuid(id)
	if (test == 1) then
		writetxt("Clone DIE.txt", clone, "a", 1, 1)
		return 0, 0
	end
	---
  	if (x == 213 or x == 249 or x == 511) then
		stop()
		writetxt("Lỗi OTP.txt", clone, "a", 1, 1)
		return 0, 0
	else
		writetxt("log.txt", 0, "w", 0, 0)
		if (getColor(35, 88) ~= 1603570 and getColor(139, 90) ~= 1603570) then
			appKill("com.facebook.Facebook");
			usleep(1000000)
			appRun("com.facebook.Facebook");
			usleep(2000000)
		end
		if (string.find(cookie, "c_user=") ~= nil) then
			return 1, cookie
		else
			return 1, 0
		end
 	end
end

------
function bacfa(id, matkhau, apikey, urlweb, api)
	local http = require("socket.http")
	local ssl = require("ssl.https")
	local body = http.request(urlweb.."/api/updatedevicestatus/"..api.."/"..apikey.."/bat2fa")
	local test = tapimg("xnok.jpg", 1, 2000000)
	if (test == 1) then
		tap(691, 1289);
		usleep(1000000)
	else
		tap(691, 1289);
		usleep(1000000)
	end
	local test = tapimg("xnok.jpg", 1, 2000000)
	if (test == 1) then
		tap(691, 1289);
		usleep(1000000)
	else
		tap(691, 1289);
		usleep(1000000)
	end
	keoxuong(2000)
	tapimg("xnok.jpg", 1, 2000000)
	tap(285, 1085);
	local i = 1
	repeat
		usleep(2000000)
		local test1 = tapimg("caidat.jpg", 1, 1000000)
		local test2 = tapimg("caidat2.jpg", 1, 1000000)
		i = i + 1
		if (i == 3) then
			tap(166, 643)
		end
	until(test1 == 1 or test2 == 1 or i == 3)
	tes = checkuid(id)
	if (tes == 1) then
		writetxt("Clone DIE.txt", id.."|"..matkhau, "a", 1, 1)
		resetdata();
		return 0
	end
	---
	x = waitcolor(630, 643, 1603583, 629, 982, 1603583, 62, 1047, 13556448, 69, 1196, 13556448, 83, 694, 13556448, 20, 1)
	tapimg("baomat.jpg", 1, 1000000)
	tapimg("baomat2.jpg", 1, 1000000)
	waitcolor(581, 582, 1603570, 580, 591, 1603570, 643, 662, 1603570, 580, 662, 1603570, 639, 682, 1603570, 643, 622, 1603570, 80, 1)
	--tap xem tấc cả
	
	------------------
	touchDown(4, 517.30, 1102.07);
	usleep(14515.92);
	touchMove(4, 516.28, 1087.80);
	usleep(18260.54);
	touchMove(4, 517.30, 1053.20);
	usleep(16603.79);
	touchMove(4, 532.70, 1003.31);
	usleep(16810.29);
	touchMove(4, 552.20, 954.44);
	usleep(16663.79);
	touchMove(4, 566.56, 910.65);
	usleep(16677.75);
	touchMove(4, 573.75, 882.15);
	usleep(16619.08);
	touchMove(4, 575.81, 862.80);
	usleep(16801.67);
	touchMove(4, 576.83, 849.57);
	usleep(16560.75);
	touchMove(4, 577.86, 839.39);
	usleep(16613.00);
	touchMove(4, 577.86, 831.25);
	usleep(16746.79);
	touchMove(4, 577.86, 827.18);
	usleep(16610.54);
	touchMove(4, 577.86, 825.14);
	usleep(116945.08);
	touchMove(4, 580.94, 823.10);
	usleep(14975.62);
	touchUp(4, 585.04, 819.03);
	usleep(1000000)
	---------
	img = findImage(currentPath().."/img/2fa.jpg", 5, 0.99, nil)
	for i, v in pairs(img) do
		tap(v[1], v[2])
	end
	usleep(1000000)
	---X&#225;c thực 2fa
	waitcolor(263, 1185, 1603570, 263, 1185, 1799396, 10, 0);
	tap(390, 1175)
	usleep(1000000)
	---Tiếp tục
	local x = waitcolor(186, 1186, 15001323, 43, 184, 328965, 20, 0);
	if (x == 186) then
		tap(406, 781)
	else
		keoxuong(1000)
		---copy key
		tap(371, 1064);
	end
	usleep(1000000)
	local key2fa = clipText();
	temp = string.gsub(key2fa, " ", "")
	local body = http.request("https://2fa.live/tok/"..temp);
	json = require("json");
	temp1 = json.decode(body)
	otp2fa = temp1["token"]
	usleep(500000);
	tap(372, 1181);
	usleep(1000000)
	---tap tiếp
	tap(372, 1181);
	waitcolor(285, 1181, 1603570, 263, 1185, 1799396, 10, 0);
	---tap nhập m&#227;
	tap(185, 431);
	usleep(500000);
	inputText(otp2fa);
	usleep(500000);
	---tap xong
	tap(677, 863);
	waitcolor(285, 1181, 1603570, 263, 1185, 1799396, 10, 0);
	---tap tiếp tục
	tap(372, 1181);
	x = waitcolor(282, 1228, 1603570, 500, 1228, 1603570, 282, 1228, 4351922, 500, 1228, 4351922, 64, 185, 3320655, 46, 205, 3320655, 86, 208, 3320655, 20, 1)
	if (x == 282 or x == 500) then
		tap(215, 645)
		usleep(500000)
		inputText(matkhau)
		usleep(500000)
		tap(666, 1280)
		waitcolor(64, 185, 3320655, 46, 205, 3320655, 86, 208, 3320655, 10, 1)
	end
	tap(280, 1183)
	x2fa = waitcolor(64, 185, 3320655, 46, 205, 3320655, 86, 208, 3320655, 10, 1)
	if (x2fa == 64 or x2fa == 46 or x2fa == 86) then
		return key2fa, 1
	else
		return "KEY2FA"
	end
end
---
function novery(regbanghotmail, apikeydongvan, regbanggmailao, login);
	ktdb = {"!", "@", "#", "%", "?", "~", "-", "+", ":"}
	local abc ={"q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m"}
	local dsdt = {"097","098","096","032","033","034","035","036","037","038","090","091","092","093","094","095","099","070","078","085","081","082","083","084"};
	if (login == 1) then
		---img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/dangxuat.jpg", 5, 0.99, nil)
		---for i, v in pairs(img) do
		---	tap(v[1], v[2])
		---	usleep(1000000)
		---end
		---usleep(2000000)
		tap(690, 1291);
		usleep(1000000)
		tap(690, 1291);
		usleep(1000000)
		keoxuong(1000)
		tap(216, 1194);
		usleep(1500000);
		tap(381, 1120)---đây là tap đăng xuất nè a chỉnh tọa độ theo í
		usleep(2000000)
	else
		http = require("socket.http")
		io.popen("activator send switch-on.com.a3tweaks.switch.airplane-mode");
		usleep(2000000)
		io.popen("activator send switch-off.com.a3tweaks.switch.airplane-mode")
		usleep(4000000)
		---check3g();
		f = assert(io.popen("curl ident.me"))
		ip = f:read("all")
		if (string.find(ip, ".") == nil and string.find(ip, ":") == nil) then
			io.popen("activator send switch-off.com.a3tweaks.switch.airplane-mode")
		end
		local dem = readdem();
		a = appState("com.ienthach.XoaInfo")
		if (a == "ACTIVATED") then
			i = 1;
			repeat
				appKill("com.ienthach.XoaInfo")
				usleep(10000000)
				resetdata();
				i = i + 1
				a = appState("com.ienthach.XoaInfo")
				if (i == 4) then
					alert("Lỗi x&#243;a info hoặc hết 3g");
					stop();
				end
			until(a == "NOT RUNNING")
		end
		appRun("com.facebook.Facebook");
		---.Tạo tk mới---
		x = waitcolor(399, 1260, 15201279, 515, 777, 31487, 287, 774, 31487, 20, 0);
		---đoạn tút sai
	end
	---waitcolor(356, 134, 1603570, 372, 1259, 1603570, 15, 1)
	tap(399, 1260);
	usleep(500000);
	tap(399, 1260);
	---.Bắt đầu---
	waitcolor(302, 523, 1603570, 15, 1);
	tap(302, 523);
	local x = waitcolor(286, 256, 1603570, 286, 256, 328965, 5, 0);
	if (x ~= 286) then
		tap(153, 400)
	else
		tap(153, 348);
	end
	usleep(300000)
	---Nhập họ t&#234;n
	---Nhập họ t&#234;n
	ho = daodong("họ.txt")
	inputText(ho)
	usleep(300000)
	tap(430, 357);
	usleep(300000);
	ten = daodong("tên.txt")
	inputText(ten)
	usleep(300000)
	tap(628, 354);
	tap(617, 1288);
	waitcolor(134, 256, 1603570, 15, 0);
	---Đoạn chọn ng&#224;y sinh
	touchDown(3, 581.97, 1057.27);
	usleep(33058.08);
	touchMove(3, 580.94, 1074.57);
	usleep(17112.62);
	touchMove(3, 584.01, 1102.07);
	usleep(16438.46);
	touchMove(3, 591.20, 1168.25);
	usleep(16539.92);
	touchMove(3, 606.59, 1236.46);
	usleep(16519.04);
	touchMove(3, 618.92, 1281.26);
	usleep(14959.42);
	touchUp(3, 623.02, 1285.33);
	usleep(434978.88);

	local x = os.date "%X"
	local y = string.sub(x, string.len(x), string.len(x));
	local z = "7"..y.."0000";
	usleep(z);

	touchDown(4, 564.51, 1116.32);
	usleep(82669.29);
	touchUp(4, 564.51, 1116.32);
	usleep(784912.12);

	touchDown(5, 419, 1082.71);
	usleep(32556.92);
	touchMove(5, 419, 1111.23);
	usleep(16622.38);
	touchMove(5, 419, 1142.78);
	usleep(16781.08);
	touchMove(5, 419, 1195.73);
	usleep(16544.67);
	touchMove(5, 419, 1249.69);
	usleep(14891.42);
	touchUp(5, 419, 1253.76);
	usleep(418820.38);

	local x = os.date "%X"
	local y = string.sub(x, string.len(x), string.len(x));
	local z = "7"..y.."0000";
	usleep(z);

	touchDown(6, 419, 1137.69);
	usleep(98232.38);
	touchUp(6, 419, 1137.69);
	usleep(668236.67);

	touchDown(1, 172.43, 1056.25);
	usleep(50063.46);
	touchMove(1, 171.40, 1071.52);
	usleep(16813.96);
	touchMove(1, 171.40, 1116.32);
	usleep(16501.92);
	touchMove(1, 172.43, 1197.76);
	usleep(16551.38);
	touchMove(1, 183.72, 1265.99);
	usleep(16695.46);
	touchMove(1, 199.12, 1307.72);
	usleep(15203.12);
	touchUp(1, 203.22, 1311.81);
	usleep(434736.29);

	local x = os.date "%X"
	local y = string.sub(x, string.len(x), string.len(x));
	local z = "7"..y.."0000";
	usleep(z);


	touchDown(2, 180.64, 1136.68);
	usleep(133961.33);
	touchUp(2, 180.64, 1136.68);
	usleep(100000);

	tap(599, 866);
	waitcolor(190, 304, 1603570, 15, 0);
	local x = getColor(249, 438);---4612766
	if (x ~= 4612766) then
		---Giao diện ko ảnh
		tap(700, 490);
		usleep(500000);
		tap(380, 819);
	else
		---C&#243; ảnh nam nữ
		tap(250, 461);
		usleep(1000000);
	end
	waitcolor(170, 298, 1603570, 15, 1);
	local first = daodong("mail1.txt")
	local last = daodong("mail2.txt")
	if (regbanghotmail == "1") then
		tap(382, 622);
		usleep(1000000)
		tap(218, 398);
		mail, mkmail, total = goimail(apikeydongvan)---hihi
		inputText(mail.."a");
		usleep(300000);
		tap(709, 1174);
		usleep(300000);
		tap(663, 1285);
		---.Điền mật khẩu---
		waitcolor(273, 245, 1603570, 5, 0);
		tap(136, 354);
		matkhau = string.upper(abc[math.random(26)])..first..last..math.random(999)..ktdb[math.random(#ktdb)]
		inputText(matkhau);
		usleep(500000);
		inputText("A");
		usleep(500000);
		tap(695, 1176);
	end
	if (regbanggmailao == "1") then
		tap(382, 622);
		usleep(1000000)
		tap(218, 398);
		first, cont = readtxt("mail1.txt");
		writetxt2("mail1.txt", cont, first, "w", 500000)
		last, cont = readtxt("mail2.txt", 1)
		writetxt2("mail2.txt", cont, last, "w", 500000)
		local devi = readtxt("device.txt")
		local tem = tachchuoi(devi)
		device = tem[1]..tem[2]
		local mail = first..math.random(999)..abc[math.random(26)]..tem[2]..math.random(99)..last.."@gmail.com "
		inputText(mail);
		usleep(300000);
		tap(709, 1174);
		usleep(300000);
		tap(663, 1285);
		---.Điền mật khẩu---
		waitcolor(273, 245, 1603570, 5, 0);
		tap(136, 354);
		matkhau = string.upper(abc[math.random(26)])..first..last..math.random(999)..ktdb[math.random(#ktdb)]
		inputText(matkhau);
		usleep(500000);
		inputText("A");
		usleep(500000);
		tap(695, 1176);
	end
	if (regvr == 4) then
		local dsdt = {"095","096","097","098","032","033","034","035", "036", "037", "038"};
		tap(300, 395);
		usleep(500000)
		local sdt = dsdt[math.random(#dsdt)]..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)
		---local sdt = "093"..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)
		inputText(sdt);
		usleep(500000)
		tap(666, 1280)
		usleep(300000);
		tap(669, 867);
		---.Điền mật khẩu---
		waitcolor(273, 245, 1603570, 5, 0);
		tap(136, 354);
		local b = string.gsub(ten..ho..math.random(99), " ", "")
		matkhau = string.upper(abc[math.random(26)])..b..math.random(9)
		inputText(matkhau);
		usleep(500000);
		inputText("A");
		usleep(500000);
		tap(695, 1176);
	end
	---.N&#250;t đi---
	usleep(500000);
	tap(634, 1287);
	---.N&#250;t đăng k&#253;---
	waitcolor(298, 673, 1603570, 298, 700, 1603570, 20, 0)

	tap(298, 680);
	---v&#242;ng lặp chờ kết quả đăng k&#253;
	local i = 1;
	j = 1;
	repeat
		---t&#234;n sai
		ten1 = getColor(225, 431);---15738953
		ten2 = getColor(420, 431);---15738953
		if (ten1 == 15738953 or ten2 == 15738953) then
			if (getColor(154, 256) == 1603570 or getColor(179, 255) == 1603570) then
				usleep(1000000)
				tap(688, 352)
				usleep(500000)
				tap(688, 352)
				usleep(1000000)
				local a = ten..math.random(99)..ho
				local b = string.gsub(a, " ", "")
				test = abc[math.random(#abc)]..abc[math.random(#abc)]..abc[math.random(#abc)]..abc[math.random(#abc)]..".com "
				local mail = first..math.random(999)..abc[math.random(26)]..tem[2]..math.random(99)..last.."@g"..abc[math.random(26)]..abc[math.random(26)]..".com "
				inputText(mail);
				usleep(300000);
				tap(709, 1174);
				usleep(300000);
				tap(663, 1285);
			else
				tap(328, 352)
				tap(328, 352);
				usleep(500000);
				ho = daodong("họ.txt")
				inputText(ho)
				usleep(500000)
				tap(684, 352);
				tap(684, 352);
				usleep(500000)
				ten = daodong("tên.txt")
				inputText(ten)
				usleep(500000)
				tap(600, 352)
				tap(666, 1280);
				usleep(2000000)
			end
		end
		local test = getColor(381, 765)---31487
		local test2 = getColor(124, 431)---15738953
		---nếu hiện th&#234;m ảnh
		local x1 = getColor(228, 1141);---1603570
		local x2 = getColor(240, 1259);---1668851
		---nếu hiện very sdt
		local x3 = getColor(354, 474);---1603570
		local x4 = getColor(375, 475);---1603570
		---nếu hiện t&#236;m bạn b&#232;
		local x5 = getColor(277, 1081);---1603571
		local x6 = getColor(550, 1081);---1538034
		local x7 = getColor(169, 903);---1603570
		local x8 = getColor(633, 897);
		local i1 = getColor(292, 553)
		---lỗi ko thể xử l&#253; đăng k&#253;
		if (getColor(355, 784) == 31487 or getColor(373, 784) == 31487) then
			if (j == 2) then
				break
			end
			io.popen("activator send switch-on.com.a3tweaks.switch.airplane-mode");
			usleep(2000000)
			io.popen("activator send switch-off.com.a3tweaks.switch.airplane-mode")
			usleep(4000000)
			---check3g();
			f = assert(io.popen("curl ident.me"))
			ip = f:read("all")
			if (string.find(ip, ".") == nil and string.find(ip, ":") == nil) then
				io.popen("activator send switch-off.com.a3tweaks.switch.airplane-mode")
			end
			j = j + 1;
			img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/ok.jpg", 5, 0.99, nil)
			for i, v in pairs(img) do
				tap(v[1], v[2])
			end
			waitcolor(302, 523, 1603570, 15, 1);
			tap(302, 523);
			waitcolor(286, 256, 1603570, 15, 0);
			tap(617, 1288);
			waitcolor(134, 256, 1603570, 15, 0);
			tap(599, 866);
			waitcolor(190, 304, 1603570, 15, 0);
			tap(382, 822);
			usleep(2000000)
			tap(363, 485);
			waitcolor(273, 245, 1603570, 15, 0);
			tap(634, 1287);
			waitcolor(298, 673, 1603570, 298, 700, 1603570, 20, 1)
			tap(298, 680);
		end
		cp1 = getColor(565, 771);
		cp2 = getColor(672, 771);
		i = i + 1;
		usleep(1000000)
	until(i1 == 1603570 or cp1 == 1603570 or cp2 == 1603570 or test == 31487 or test2 == 15738953 or i == 35 or x1 == 1603570 or x2 == 1668851 or x3 == 1603570 or x4 == 1603570 or x5 == 1603570 or x6 == 1603570 or x5 == 1603571 or x6 == 1538034 or x7 == 1603570 or x8 == 1603570)
	local x9 = getColor(355, 784);---31487
	local x10 = getColor(373, 784);---31487
	local x11 = getColor(381, 783);---31487
	---nếu hiện th&#234;m ảnh
	local x1 = getColor(228, 1141);---1603570
	local x2 = getColor(240, 1259);---1668851
	---nếu hiện very sdt
	local x3 = getColor(354, 474);---1603570
	local x4 = getColor(375, 475);---1603570
	---nếu hiện t&#236;m bạn b&#232;
	local x5 = getColor(277, 1081);---1603571
	local x6 = getColor(550, 1081);---1538034
	---nếu reg ok th&#236; xử l&#253; tếp
	if (x == 35 or x == 139 or x1 == 1603570 or x2 == 1668851 or x3 == 1603570 or x4 == 1603570 or x5 == 1603570 or x6 == 1603570 or x5 == 1603571 or x6 == 1538034) then
		if (regbanghotmail == "1") then
			if (getColor(35, 88) == 1603570 or getColor(139, 90) == 1603570) then
				tap(66, 1280)
			end
			x = waitcolor(394, 444, 1603570, 395, 508, 1603570, 707, 500, 1603570, 525, 506, 1603570, 708, 469, 1603570, 4, 0)
			tapimg("skip.jpg", 1, 1000000)
			tapimg("skip.jpg", 1, 1000000)
			tapimg("skip.jpg", 1, 1000000)
			tapimg("skip.jpg", 1, 1000000)
			---
			local test1 = findimg("addmail.jpg", 1, 1)
			if (test1 ~= 1) then
				test2 = findimg("xnmail.jpg", 1, 1)
			else
				test2 = 0
			end
			---if (x ~= 395 and x ~= 707 and x ~= 708 and x ~= 525 and x ~= 394) then
			if (test1 ~= 1 and test2 ~= 1) then
				local i = 1
				repeat
					appRun("com.apple.SpringBoard");
					usleep(1000000)
					appRun("com.facebook.Facebook");
					usleep(2000000)
					if (getColor(35, 88) == 1603570 or getColor(139, 90) == 1603570) then
						tap(66, 1280) 
						usleep(2000000)
					end
					if (getColor(35, 88) == 1603570 or getColor(139, 90) == 1603570) then
						tap(66, 1280)
						usleep(2000000)
					end
					tapimg("xnok.jpg", 1, 1000000)
					tapimg("skip.jpg", 1, 1000000)
					tapimg("skip.jpg", 1, 1000000)
					tapimg("skip.jpg", 1, 1000000)
					tapimg("skip.jpg", 1, 1000000)
					x = waitcolor(394, 444, 1603570, 395, 508, 1603570, 707, 500, 1603570, 525, 506, 1603570, 708, 469, 1603570, 2, 0)
					local test1 = findimg("addmail.jpg", 1, 1)
					if (test1 ~= 1) then
						test2 = findimg("xnmail.jpg", 1, 1)
					else
						test2 = 0
					end
					i = i + 1;
				until(i == 5)
			end
			usleep(2000000)
			cookie = clipText();
			local id = string.sub(cookie, string.find(cookie, "c_user=")+7, string.find(cookie, "c_user=")+21)
			local clone = id.."|"..matkhau
			copyText("")
			---lấy otp
			urlotp = "http://14.225.27.38/api/getcode.php?apiKey=2sadasd&type=1&user="..mail.."&pass="..mkmail
			local i = 1;
			repeat
				toast("Chờ otp.. "..i)
				local body = request(urlotp)
				local text = string.find(body, "Facebook");
				if (string.find(body, "Facebook") ~= nil) then
					otp = string.sub(body, string.find(body, "code")+7, string.find(body, "sender")-4)
					toast("OTP: "..otp)
					tap(359, 364);
					tap(359, 364);
					usleep(500000);
					inputText(otp);
					usleep(500000);
					tap(379, 474);
					usleep(1000000) 
				end
				test = checkuid(id)
				if (test == 1) then
					writetxt("Clone DIE.txt", clone, "a", 1, 1)
					return 0, 0
				end
				i = i + 1
				if (i == 12) then
					writetxt("Lỗi OTP.txt", clone, "a", 1, 1)
					return 0, 0
				end
			until(text ~= nil);
			x = waitcolor(620, 907, 1603570, 610, 907, 1603570, 213, 785, 31487, 249, 788, 31487, 511, 788, 31487, 34, 89, 1603570, 139, 93, 1603570, 20, 1)
			test = checkuid(id)
			if (test == 1) then
				writetxt("Clone DIE.txt", clone, "a", 1, 1)
				return 0, 0
			end
			---
  			if (x == 213 or x == 249 or x == 511) then
				stop()
				writetxt("Lỗi OTP.txt", clone, "a", 1, 1)
				return 0, 0
			else
				if (getColor(35, 88) ~= 1603570 and getColor(139, 90) ~= 1603570) then
					appKill("com.facebook.Facebook");
					usleep(1000000)
					appRun("com.facebook.Facebook");
					usleep(2000000)
				end
				if (string.find(cookie, "c_user=") ~= nil) then
					id = string.sub(cookie, string.find(cookie, "c_user=")+7, string.find(cookie, "c_user=")+21)
					ghichu = id.."|"..matkhau.."|"..cookie.."|"..mail.."|"..mkmail
					return ghichu
				else
					return 1, 0
				end
			end
		else
			i = 1
			repeat
				openURL("fb://profile");
				usleep(1000000);
				cookie = clipText();
				if (string.find(cookie, "c_user=") ~= nil) then
					id = string.sub(cookie, string.find(cookie, "c_user=")+7, string.find(cookie, "c_user=")+21)
					cookie = clipText();
					return id.."|"..matkhau.."|"..cookie
				end
				i = i + 1;
				if (i == 5) then
					return 0
				end
			until(string.find(cookie, "c_user=") ~= nil)
		end
	else
		return 0
	end
end
---Finish
