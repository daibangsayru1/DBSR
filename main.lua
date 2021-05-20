---333
function main(loginclonefull, loginclonenovery, restorerrs, filelistclone, filelistrrs, chạyvery, apikeydongvan, linklấyotp, úpdanhbạ, úpavt, úpảnhbìa, úpinfo, bậc2fa, sốlượtkbtheogợiý, sốlượtkbtheouid, đồngýkếtbạn, sốlượtxemthôngbáo, sốlượtjoinnhómgợiý, sốlượtjoinnhómtheolist, filelistnhóm, likepage, filelistpage, sốlượtvuốtnew, sốlượtlikenew, sốlượtbìnhluận, tênfilechứanộidungbl, slchiasẽlêntường, đăngstatus, statuskèmảnh, xuấtclonesaukhiauto, linksheetlưuclonefull, regnoverysaukhichạy, linksheetlưunovery, lưurrssaukhichạy)
	contair = require("socket.https")
	if (loginclonenovery == "1") then
		clone, cl2 = login(filelistclone, loginclonenovery);
		output = clone
		if (cl2 == 0) then
			return
		end
	end
	if (lưurrssaukhichạy == "1") then
		local name = tachchuoi(output)
		luurrs(name[1], output)
	else
		if (restorerrs ~= "1") then
			resetdata()
		end
	end
end
---Finish
