function luurrs(name, ghichu);
	writetxt("Quan li RRS.txt", ghichu, "a", 1, 1)
	openURL("XoaInfo://Reset?RRS")
	usleep(4000000)
	i = 1
	repeat
		local a = appState("com.ienthach.XoaInfo")
		usleep(2000000);
		i = i + 1
	until (i == 20 or a == "NOT RUNNING")
	local f = io.popen("ls var/mobile/Media/XoaInfo")
	tab = {}
	repeat
		line = f:read("*line")
		tab[#tab+1] = line
	until(line == nil)
	f:close()
	b = tab[#tab]
	local f = io.open("var/mobile/Media/XoaInfo/GhiChu.txt", "w") f:write(ghichu) f:close()
	local f = io.popen("mv var/mobile/Media/XoaInfo/GhiChu.txt var/mobile/Media/XoaInfo/GhiChu") f:close()
	local f = io.popen("mv var/mobile/Media/XoaInfo/GhiChu var/mobile/Media/XoaInfo/"..b.."/GhiChu") f:close()
	local f = io.popen("mv var/mobile/Media/XoaInfo/"..b.."/ var/mobile/Media/XoaInfo/"..name) f:close()
end
