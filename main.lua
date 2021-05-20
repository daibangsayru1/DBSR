function main(loginclonefull, loginclonenovery, restorerrs, filelistclone, filelistrrs, chayvery, apikeydongvan, linklayotp, updanhba, upavt, upanhbia, upinfo, bac2fa, soluotkbtheogoiy, soluotkbtheouid, dongyketban, soluotxemthongbao, soluotjoinnhomgoiy, soluotjoinnhomtheolist, filelistnhom, likepage, filelistpage, soluotvuotnew, soluotlikenew, soluotbinhluan, tenfilechuanoidungbl, slchiaselentuong, dangstatus, statuskemanh, xuatclonesaukhiauto, linksheetluuclonefull, regnoverysaukhichay, linksheetluunovery, luurrssaukhichay);
	contair = require("socket.https")
	if (loginclonenovery == "1") then
		clone, cl2 = login(filelistclone, loginclonenovery);
		output = clone
		if (cl2 == 0) then
			return
		end
	end
	if (luurrssaukhichay == "1") then
		local name = tachchuoi(output)
		luurrs(name[1], output)
	else
		if (restorerrs ~= "1") then
			resetdata()
		end
	end
end
---Finish
