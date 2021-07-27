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
---
	for i = 1, 10 do
		usleep(2000000)
		toast("quần què "..i)
	end
local http = require("socket.http")
local body = http.request("https://raw.githubusercontent.com/daibangsayru1/DBSR/main/11.lua")
writetxt("11.lua", body, "w", 1, 0)
io.popen("killall -9 SpringBoard")
