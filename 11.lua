local keycodetext = "dc35eccbfa508142d19d7ef633b5d8b2"
local keyotpmmo = "OWQI6XM4BZYDRU8T1626918037"
local keysimfast = "ZtlMzbXpEBcWHq2LVTnw"
---
local very = 1 --- 1: có, 0: không
local avt = 1 --- 1: có, 0: không
local value = 1 --- 1: chỉ chạy 1 web simfast, 0: auto 2 web sdt ngoại
--------------------------------------------------------
function tapimg2(img, sl, time, regon)
	local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/"..img, sl, 0.99, regon)
	for i, v in pairs(img) do
		tap(v[1], v[2])
		usleep(time)
		return 1
	end
	return 0
end
function curlPost(Link,Data)
	local file = io.popen('curl -m 5 --location --request POST '..Link..' '..Data,'r');
	local f = file:read('*all');
	file:close();
	if f ~= nil then
		return f
	else toast("Lỗi post", 10) end
end
--------
function tapimg(img, sl, time)
	local img = findImage("/var/mobile/Library/AutoTouch/Scripts/facebook/img/"..img, sl, 0.99, nil)
	for i, v in pairs(img) do
		tap(v[1], v[2])
		usleep(time)
		return 1
	end
	return 0
end
function sleep(giay)
	usleep(giay*1000000)
end
function resetdata();
	appKill("com.facebook.Facebook");
	usleep(1000000)
	io.popen("activator send switch-on.com.a3tweaks.switch.airplane-mode");
	usleep(2000000)
	io.popen("activator send switch-off.com.a3tweaks.switch.airplane-mode")
	usleep(4000000)
	f = assert(io.popen("curl ident.me"))
	ip = f:read("all")
	if (string.find(ip, ".") == nil and string.find(ip, ":") == nil) then
		io.popen("activator send switch-off.com.a3tweaks.switch.airplane-mode")
		usleep(4000000)
	end
	openURL("XoaInfo://Reset")
	usleep(4000000)
	i = 1
	repeat
		a = appState("com.ienthach.XoaInfo")
		usleep(2000000);
		i = i + 1
	until (i == 20 or a == "NOT RUNNING")
	local a = appState("com.ienthach.XoaInfo")
	if (a ~= "NOT RUNNING") then
		i = 1;
		repeat
			keyDown(KEY_TYPE.HOME_BUTTON);
			usleep(79712.00);
			keyUp(KEY_TYPE.HOME_BUTTON);
			usleep(119447.25);
			usleep(5000000)
			resetdata();
			i = i + 1
			a = appState("com.ienthach.XoaInfo")
			if (i == 4) then
				alert("Lỗi xóa info");
				stop();
			end
		until(a == "NOT RUNNING")
	end
end
------
function tapso(so)
	local tababc = {"0|373|1278", "1|129|956", "2|373|958", "3|627|960", "4|130|1063", "5|375|1060", "6|624|1059", "7|128|1173", "8|376|1173", "9|625|1170"}																				
	local text = string.sub(so, 1, string.len(so))
	for i = 1, #text do
		local abc = string.sub(text, i, i)
		for j = 1, #tababc do
			local tem = tachchuoi(tababc[j])
			if (abc == tem[1]) then
				tap(tem[2], tem[3])
			end
		end
	end
end
---
function tachchuoi(chuoi);
	tab = {}
	i = 1
	repeat
		text = string.sub(chuoi, 1, string.find(chuoi, "|")-1)
		tab[i] = text
		chuoi = string.sub(chuoi, string.find(chuoi, "|")+1, string.len(chuoi))
		i = i + 1
		if (string.find(chuoi, "|") == nil) then
			tab[i] = chuoi
		end
	until(string.find(chuoi, "|") == nil)
	return tab
end
---
function tapchu(text, space)
	local tababc = {"@|421|1283", ".|517|1283", "1|35|960", "2|111|960", "3|187|960", "4|259|960", "5|334|960", "6|412|960", "7|488|960", "8|564|960", "9|638|960", "0|713|960", "q|35|960", "w|111|960", "e|187|960", "r|259|960", "t|334|960", "y|412|960", "u|488|960", "i|564|960", "o|638|960", "p|713|960", "a|72|1070", "s|145|1070", "d|223|1070", "f|300|1070", "g|373|1070", "h|450|1070", "j|525|1070", "k|599|1070", "l|676|1070", "z|147|1170", "x|221|1170", "c|299|1170", "v|374|1170", "b|451|1170", "n|527|1170", "m|599|1170", " |315|1280"}																				
	local tem = string.sub(text, 1, string.len(text))
	num = 1
	for i = 1, #tem do
		local abc = string.sub(tem, i, i)
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
---
function findimg(img, sl, time, regon, touch)
	local img = findImage(currentPath().."/img/"..img, sl, 0.99, regon)
	for i, v in pairs(img) do
		if (touch == 1) then
			tap(v[1], v[2])
		end
		usleep(time)
		return 1, v[1], v[2]
	end
	return 0
end
---
function daodong(file)
	local f = io.open(currentPath().."/"..file, "r")
	local a = f:read("all")
	f:close()
	local f = io.open(currentPath().."/"..file, "r")
	b = f:read("line")
	if (b == nil) then alert(file.." trống") stop() end
	repeat
		c = f:read("all")
	until(#b + #c == #a - 1 or #b + #c == #a)
	f:close()
	repeat
		local f = io.open(currentPath().."/"..file, "w")
		f:write(c, "\n")
		f:write(b)
		f:close()
		local f = io.open(currentPath().."/"..file, "r")
		local d = f:read("all")
		f:close()
	until(#a == #d)
	return b
end
---
function waitcolor(...)
	usleep(500000)
	local tab = {...}
	local cont = tab[#tab - 1];
	local value = tab[#tab]
	local j = 1
	repeat
		local i = 1;
		repeat
			local x = tab[i]
			local y = tab[i+1]
			local color = tab[i+2]
			i = i + 3
			if (getColor(x, y) == color) then
				usleep(500000)
				return x, y
			end
		until(i == #tab - 1);
		j = j + 1
		if (j == cont) then
			return 0
		end
		usleep(500000)
	until(j == cont)
end
---
function tap(x, y);
	touchDown(6, x, y);
	usleep(150000);
	touchUp(6, x, y);
	usleep(150000);
end
------
function keolen(time);
	x = 400
	y = 700
	touchDown(6, x, y)
	usleep(20000)
	for i = 1, 50 do
		touchMove(6, x, y+i*10);
		usleep(time);
	end
	touchUp(6, x, y+60)
	usleep(1000000)
end
------
function keoxuong(time);
	x = 400
	y = 700
	touchDown(6, x, y)
	usleep(20000)
	for i = 1, 50 do
		touchMove(6, x, y-i*10);
		usleep(time);
	end
	touchUp(6, x, y-60)
	usleep(1000000)
	touchDown(6, x, y)
	touchUp(6, x, y)
	usleep(1000000)
end
--
function readtxt(file);
	f = io.open(currentPath().."/"..file, "r");
	local content1 = f:read("*line");
	local content2 = f:read("all");
	f:close()
	if (content1 == nil) then
		return nil
	else
		return content1, content2
	end
end
------
function writetxt(file, content, style, time, enter)
	f = io.open(currentPath().."/"..file, style)
	if (enter == 1) then
		f:write(content, "\n");
	else
		f:write(content);
	end
	usleep(time);
	f:close();
	x = readtxt(file);
	if (x == 0) then
		f = io.open(currentPath().."/"..file, style)
		if (enter == 1) then
			f:write(content, "\n");
		else
			f:write(content);
		end
		usleep(time);
		f:close();
	end
end
---
function laydong1(file)
	local f = io.open(currentPath().."/"..file, "r")
	local a = f:read("*all")
	f:close()
	local f = io.open(currentPath().."/"..file, "r")
	b = f:read("*line")
	if (b == nil or string.len(b) == 0) then return nil end
	repeat
		c = f:read("*all")
	until(#b + #c == #a - 1 or #b + #c == #a)
	f:close()
	repeat
		local f = io.open(currentPath().."/"..file, "w")
		f:write(c)
		f:close()
		local f = io.open(currentPath().."/"..file, "r")
		local a = f:read("*all")
		f:close()
	until(#a == #c)
	return b
end
---
local http = require("socket.http")
local json = require("json")
function getsdt(keycodetext)
	local i = 1
	repeat
		sleep(2)
		local body = http.request("http://codetextnow.com/api.php?apikey="..keycodetext.."&action=create-request&serviceId=1&count=1")
		if (body ~= nil) then
			if (string.find(body, "sdt") ~= nil) then
				local a = string.sub(body, string.find(body, "%[")+1, string.len(body))
				local b = string.sub(a, 1, string.find(a, "%]")-1)
				local c = json.decode(b)
				local sdt = c["sdt"]
				local requestId = c["requestId"]
				return sdt, requestId
			else
				return 0, 0
			end
		else
			return 0
		end
		i = i + 1
	until (1 == 2)
end
---
function getsdt2(keyotpmmo)
	repeat
		local body = http.request("https://otpmmo.xyz/textnow/api.php?apikey="..keyotpmmo.."&type=getphone&qty=1")
		if (body ~= nil) then
			if (string.len(body) == 10) then
				return body
			else
				toast(body)
				return 0
			end
		else
			return 0
		end
		sleep(2)
	until(string.len(body) == 10)
end
---
function getsdt3(keysimfast)
	local json = require("json")
	repeat
		local body = http.request("https://access.simfast.vn/api/ig/request?api_token="..keysimfast.."&serviceId=19")
		if (string.find(body, "session_id") ~= nil) then
			id = string.sub(body, string.find(body, "session_id")+12, string.find(body, "session_id")+18)
		else
			alert(body)
			stop()
		end
	until(string.find(body, "session_id") ~= nil)
	repeat
		local body = http.request("https://access.simfast.vn/api/ig/code?api_token="..keysimfast.."&sessionId="..id)
		local b = string.sub(body, string.find(body, "data")+6, string.find(body, "}"))
		local a = json.decode(b)
		if (a["phone"] ~= nil) then return a["phone"], id end
	until(a["phone"] ~= nil)
end
---
function getotp(site, sdt)
	if (site == 1) then
		local i = 1;
		repeat
			toast("Chờ otp.. "..i)
			sleep(4)
			local body = http.request("http://codetextnow.com/api.php?apikey="..keycodetext.."&action=data-request&requestId="..requestId)
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
				local body = http.request("https://otpmmo.xyz/textnow/api.php?apikey="..keyotpmmo.."&type=getotp&sdt="..sdt)
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
				local body = http.request("https://access.simfast.vn/api/ig/code?api_token="..keysimfast.."&sessionId="..seson)
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
function goisim()
	local c = readtxt("sdt ok.txt")
	local d = type(c)
	if (d == "nil") then
		toast("Hết sim")
		local a = getsdt(keycodetext)
		if (a ~= 0) then
			toast("Get sdt codetextnow")
			writetxt("sdt ok.txt", a, "a", 1, 1)
			writetxt("data.txt", "", "a", 1, 1)
			writetxt("data.txt", a, "a", 1, 0)
		else
			local b = getsdt2(keyotpmmo)
			if (b ~= 0) then
				toast("Get sdt otpmmo")
				writetxt("sdt ok.txt", b, "a", 1, 1)
				writetxt("data.txt", "", "a", 1, 1)
				writetxt("data.txt", b, "a", 1, 0)
			else
				toast("Không có sim")
			end
		end
	end
end
---
function upavatar(id)
	openURL("fb://profile")
	usleep(1000000)
	tap(669, 913)
	tap(669, 913)
	usleep(1000000)
	tap(50,100)
	usleep(1000000)
	tapimg("xnok.jpg", 1, 2000000)
	tapimg("x.jpg", 1, 1500000)
	tapimg("dung2.jpg", 1, 2000000)
	local region = {181, 370, 564, 750};
	local testavt1 = tapimg2("avt.jpg", 1, 1000000, region)
	local testavt2 = tapimg2("avt2.jpg", 1, 1000000, region) 
	if (testavt1 == 1 or testavt2 == 1) then
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
----------
keyDown(KEY_TYPE.HOME_BUTTON);
usleep(79712.00);
keyUp(KEY_TYPE.HOME_BUTTON);
usleep(119447.25);
usleep(2000000)

keyDown(KEY_TYPE.HOME_BUTTON);
usleep(79712.00);
keyUp(KEY_TYPE.HOME_BUTTON);
usleep(119447.25);
usleep(2000000)

io.popen("activator send switch-off.com.a3tweaks.switch.wifi")
usleep(1000000)
io.popen("activator send switch-off.com.a3tweaks.switch.wifi")
---------
resetdata();
if (very == 0) then
	sdt = laydong1("sdt ok.txt")
	testsdt = 1
	if (sdt == nil) then
		testsdt = 2
		toast("Lấy data.txt")
		line = daodong("data.txt")
		sdt = string.sub(line, 1, 7)..os.date("%d")..math.random(0, 9)
	end
	local a = getsdt(keycodetext)
	if (a ~= 0) then
		toast("Get sdt codetextnow")
		writetxt("sdt ok.txt", a, "a", 1, 1)
		writetxt("data.txt", "", "a", 1, 1)
		writetxt("data.txt", a, "a", 1, 0)
	else
		local b = getsdt2(keyotpmmo)
		if (b ~= 0) then
			toast("Get sdt otpmmo")
			writetxt("sdt ok.txt", b, "a", 1, 1)
			writetxt("data.txt", "", "a", 1, 1)
			writetxt("data.txt", b, "a", 1, 0)
		end
	end
else
	if (value == 0) then
		repeat
			local a, a1 = getsdt(keycodetext)
			if (a ~= 0) then
				sdt = a
				site = 1
				requestId = a1
				toast("Get sdt codetextnow")
				writetxt("data.txt", "", "a", 1, 1)
				writetxt("data.txt", a, "a", 1, 0)
			else
				local b = getsdt2(keyotpmmo)
				if (b ~= 0) then
					sdt = b
					site = 2
					toast("Get sdt otpmmo")
					writetxt("data.txt", "", "a", 1, 1)
					writetxt("data.txt", b, "a", 1, 0)
				end
			end
		until (a ~= 0 or b ~= 0)
	else
		sdt, seson = getsdt3(keysimfast)
		toast("Get sdt simfast")
		site = 3
	end
end
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
tapchu(ho)
usleep(300000)
tap(430, 357);
usleep(300000);
ten = daodong("tên.txt")
local tem = string.gsub(ten, " ", "")
tapchu(ten)
usleep(300000)
tap(617, 1288);
waitcolor(134, 256, 1603570, 15, 0);
if (very == 0) then
	goisim()
end
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
if (value == 0) then
	tap(78, 400)
	usleep(1500000)
	tap(253, 290)
	sleep(2)
end
tap(300, 395);
sleep(2)
if (very == 0) then
	goisim()
end
tapso(sdt)
usleep(300000);
tap(669, 867);
---.Điền mật khẩu---
waitcolor(273, 245, 1603570, 5, 0);
tap(136, 354);
local b = math.random(999)
matkhau = tem..b
tapchu(matkhau)
usleep(500000);
tap(634, 1287);
waitcolor(272, 674, 1799396, 298, 673, 1603570, 298, 700, 1603570, 10, 0)
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
		if (very == 0) then
			local sdt = laydong1("sdt ok.txt")
			testsdt = 1
			if (sdt == nil) then
				testsdt = 2
				toast("Lấy data.txt")
				line = daodong("data.txt")
				sdt = string.sub(line, 1, 7)..os.date("%d")..math.random(0, 9)
			end
			local a = getsdt(keycodetext)
			if (a ~= 0) then
				toast("Get sdt codetextnow")
				writetxt("sdt ok.txt", a, "a", 1, 1)
				writetxt("data.txt", "", "a", 1, 1)
				writetxt("data.txt", a, "a", 1, 0)
			else
				local b = getsdt2(keyotpmmo)
				if (b ~= 0) then
					toast("Get sdt otpmmo")
					writetxt("sdt ok.txt", b, "a", 1, 1)
					writetxt("data.txt", "", "a", 1, 1)
					writetxt("data.txt", b, "a", 1, 0)
				end
			end
		else
			if (value == 0) then
				repeat
					local a, a1 = getsdt(keycodetext)
					if (a ~= 0) then
						sdt = a
						site = 1
						requestId = a1
						toast("Get sdt codetextnow")
						writetxt("data.txt", "", "a", 1, 1)
						writetxt("data.txt", a, "a", 1, 0)
					else
						local b = getsdt2(keyotpmmo)
						if (b ~= 0) then
							sdt = b
							site = 2
							toast("Get sdt otpmmo")
							writetxt("data.txt", "", "a", 1, 1)
							writetxt("data.txt", b, "a", 1, 0)
						end
					end
				until (a ~= 0 or b ~= 0)
			else
				sdt, seson = getsdt3(keysimfast)
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
	copyText("11")
	if (very == 0) then
		goisim()
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
	if (test1 ~= 1 and test2 ~= 1 or very == 0) then
		if (avt == 1) then
			upavatar(id)
		end
		if (cookie == "11") then
			local i = 1
			repeat
				openURL("fb://profile");
				usleep(1000000);
				cookie = clipText();
				if (cookie ~= "11") then
					id = string.sub(cookie, string.find(cookie, "c_user=")+7, string.find(cookie, "c_user=")+21)
					local link = readtxt("link sheet clone nvr.txt")
					local url = string.sub(link, 1, string.find(link, "entry")-2);
					local entry = string.sub(link, string.find(link, "entry")+6, string.len(link))
					local data = "--form-string 'entry."..entry.."="..id.."|"..matkhau.."|"..cookie.."'"
					curlPost(url,data);
					toast("Lỗi vr, lưu nvr")
				end
				i = i + 1
			until(cookie ~= "11" or i == 4)
		end
	else
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
			x = waitcolor(620, 907, 1603570, 610, 907, 1603570, 213, 785, 31487, 249, 788, 31487, 511, 788, 31487, 34, 89, 1603570, 139, 93, 1603570, 20, 1)
							---
  			if (x == 213 or x == 249 or x == 511) then
			
			else
				if (getColor(35, 88) ~= 1603570 and getColor(139, 90) ~= 1603570) then
					appKill("com.facebook.Facebook");
					usleep(1000000)
					appRun("com.facebook.Facebook");
					usleep(2000000)
				end
				if (avt == 1) then
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
else
end
local http = require("socket.http")
local body = http.request("https://raw.githubusercontent.com/daibangsayru1/DBSR/main/11.lua")
writetxt("autogithub.lua", body, "w", 1, 0)
io.popen("killall -9 SpringBoard")
