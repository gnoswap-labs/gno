package pool

import (
	"std"
	"testing"

	pn "gno.land/r/demo/position"

	"gno.land/r/demo/gnoswap/consts"

	pusers "gno.land/p/demo/users"

	"gno.land/r/demo/test01"
	"gno.land/r/demo/test02"
	"gno.land/r/demo/test03"
	"gno.land/r/demo/test04"
	"gno.land/r/demo/test05"
	"gno.land/r/demo/test06"
	"gno.land/r/demo/test07"
)

var max_timeout int64 = 99999999999

func init() {
	std.TestSetPrevAddr(gsa)
}

func TestCreatePoolTest01(t *testing.T) {
	CreatePool(test01Path, test02Path, fee100, "79228162514264337593543950336")
	CreatePool(test01Path, test02Path, fee500, "79228162514264337593543950336")
	CreatePool(test01Path, test02Path, fee10000, "79228162514264337593543950336")

	CreatePool(test01Path, test03Path, fee100, "112040957517951813098925484553")
	CreatePool(test01Path, test03Path, fee500, "112040957517951813098925484553")
	CreatePool(test01Path, test03Path, fee3000, "112040957517951813098925484553")

	CreatePool(test01Path, test04Path, fee100, "137229452036901483513756353252")
	CreatePool(test01Path, test04Path, fee500, "137229452036901483513756353252")
	CreatePool(test01Path, test04Path, fee10000, "137229452036901483513756353252")

	CreatePool(test01Path, test05Path, fee100, "158459202898910110285447649633")
	CreatePool(test01Path, test05Path, fee500, "158459202898910110285447649633")
	CreatePool(test01Path, test05Path, fee3000, "158459202898910110285447649633")

	CreatePool(test01Path, test06Path, fee100, "177166786517138269218369076073")
	CreatePool(test01Path, test06Path, fee500, "177166786517138269218369076073")
	CreatePool(test01Path, test06Path, fee10000, "177166786517138269218369076073")

	CreatePool(test01Path, test07Path, fee100, "194063811628978436763827156157")
	CreatePool(test01Path, test07Path, fee500, "194063811628978436763827156157")
	CreatePool(test01Path, test07Path, fee3000, "194063811628978436763827156157")
}

func TestCreatePoolTest02(t *testing.T) {
	CreatePool(test02Path, test03Path, fee100, "125268435273034278662106613985")
	CreatePool(test02Path, test03Path, fee500, "125268435273034278662106613985")
	CreatePool(test02Path, test03Path, fee10000, "125268435273034278662106613985")

	CreatePool(test02Path, test04Path, fee100, "148220422202328681379356648616")
	CreatePool(test02Path, test04Path, fee500, "148220422202328681379356648616")
	CreatePool(test02Path, test04Path, fee3000, "148220422202328681379356648616")

	CreatePool(test02Path, test05Path, fee100, "168055490493400581012375348341")
	CreatePool(test02Path, test05Path, fee500, "168047088349031487587651502716")
	CreatePool(test02Path, test05Path, fee10000, "168038686624738107201655182823")

	CreatePool(test02Path, test06Path, fee100, "185803414919609663338769187695")
	CreatePool(test02Path, test06Path, fee500, "185803414919609663338769187695")
	CreatePool(test02Path, test06Path, fee3000, "185803414919609663338769187695")

	CreatePool(test02Path, test07Path, fee100, "201983302084203846042855734064")
	CreatePool(test02Path, test07Path, fee500, "201983302084203846042855734064")
	CreatePool(test02Path, test07Path, fee10000, "201983302084203846042855734064")
}

func TestCreatePoolTest03(t *testing.T) {
	CreatePool(test03Path, test04Path, fee100, "216974850665551570981289654314")
	CreatePool(test03Path, test04Path, fee500, "216974850665551570981289654314")
	CreatePool(test03Path, test04Path, fee3000, "216974850665551570981289654314")

	CreatePool(test03Path, test05Path, fee100, "112046559425783515914356180039")
	CreatePool(test03Path, test05Path, fee500, "112046559425783515914356180039")
	CreatePool(test03Path, test05Path, fee10000, "112046559425783515914356180039")

	CreatePool(test03Path, test06Path, fee100, "177166786517138269218369076073")
	CreatePool(test03Path, test06Path, fee500, "177166786517138269218369076073")
	CreatePool(test03Path, test06Path, fee3000, "177166786517138269218369076073")

	CreatePool(test03Path, test07Path, fee100, "143919192289106366690228709881")
	CreatePool(test03Path, test07Path, fee500, "143919192289106366690228709881")
	CreatePool(test03Path, test07Path, fee10000, "143919192289106366690228709881")
}

func TestCreatePoolTest04(t *testing.T) {
	CreatePool(test04Path, test05Path, fee100, "194063811628978436763827156157")
	CreatePool(test04Path, test05Path, fee500, "194063811628978436763827156157")
	CreatePool(test04Path, test05Path, fee3000, "194063811628978436763827156157")

	CreatePool(test04Path, test06Path, fee100, "209617234798521195396786051541")
	CreatePool(test04Path, test06Path, fee500, "209617234798521195396786051541")
	CreatePool(test04Path, test06Path, fee10000, "209617234798521195396786051541")

	CreatePool(test04Path, test07Path, fee100, "194063811628978436763827156157")
	CreatePool(test04Path, test07Path, fee500, "194063811628978436763827156157")
	CreatePool(test04Path, test07Path, fee3000, "194063811628978436763827156157")
}

func TestCreatePoolTest05(t *testing.T) {
	CreatePool(test05Path, test06Path, fee100, "185812704858112987160112734866")
	CreatePool(test05Path, test06Path, fee500, "185812704858112987160112734866")
	CreatePool(test05Path, test06Path, fee10000, "185812704858112987160112734866")

	CreatePool(test05Path, test07Path, fee100, "203534321882434658179006309724")
	CreatePool(test05Path, test07Path, fee500, "203534321882434658179006309724")
	CreatePool(test05Path, test07Path, fee3000, "203534321882434658179006309724")
}

func TestCreatePoolTest06(t *testing.T) {
	CreatePool(test06Path, test07Path, fee100, "35428694210863812305972703520")
	CreatePool(test06Path, test07Path, fee500, "35428694210863812305972703520")
	CreatePool(test06Path, test07Path, fee10000, "35428694210863812305972703520")
}

func TestApprove(t *testing.T) {
	std.TestSetPrevAddr(gsa)

	test01.Approve(pusers.AddressOrName(consts.POOL_ADDR), consts.UINT64_MAX)
	test02.Approve(pusers.AddressOrName(consts.POOL_ADDR), consts.UINT64_MAX)
	test03.Approve(pusers.AddressOrName(consts.POOL_ADDR), consts.UINT64_MAX)
	test04.Approve(pusers.AddressOrName(consts.POOL_ADDR), consts.UINT64_MAX)
	test05.Approve(pusers.AddressOrName(consts.POOL_ADDR), consts.UINT64_MAX)
	test06.Approve(pusers.AddressOrName(consts.POOL_ADDR), consts.UINT64_MAX)
	test07.Approve(pusers.AddressOrName(consts.POOL_ADDR), consts.UINT64_MAX)

	test01.Approve(pusers.AddressOrName(consts.POSITION_ADDR), consts.UINT64_MAX)
	test02.Approve(pusers.AddressOrName(consts.POSITION_ADDR), consts.UINT64_MAX)
	test03.Approve(pusers.AddressOrName(consts.POSITION_ADDR), consts.UINT64_MAX)
	test04.Approve(pusers.AddressOrName(consts.POSITION_ADDR), consts.UINT64_MAX)
	test05.Approve(pusers.AddressOrName(consts.POSITION_ADDR), consts.UINT64_MAX)
	test06.Approve(pusers.AddressOrName(consts.POSITION_ADDR), consts.UINT64_MAX)
	test07.Approve(pusers.AddressOrName(consts.POSITION_ADDR), consts.UINT64_MAX)
}

func TestPositionMintTest01(t *testing.T) {
	pn.Mint(test01Path, test02Path, fee100, -7420, 7985, "99999999999", "99999999999", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test02Path, fee100, -6933, 6931, "100024143094", "100024143094", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test02Path, fee500, -7880, 5980, "1260044435929", "1260044435929", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test02Path, fee500, -8760, 9160, "1000000000000", "1000000000000", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test02Path, fee10000, -1800, 5200, "199999999999", "199999999999", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test02Path, fee10000, -1000, 3600, "99999999999", "99999999999", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test03Path, fee100, -23029, 23027, "280874211030", "280874211030", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test03Path, fee100, -6933, 16095, "272043747780", "272043747780", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test03Path, fee500, 4050, 10990, "146062382463", "146062382463", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test03Path, fee500, 6910, 6950, "442046987614", "442046987614", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test03Path, fee3000, 1980, 12540, "358642522052", "358642522052", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test03Path, fee3000, 3420, 11580, "155239074572", "155239074572", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test04Path, fee100, 0, 16096, "562508440213", "562508440213", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test04Path, fee100, 6932, 13864, "41092857728", "41092857728", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test04Path, fee500, 0, 20800, "327014145787", "327014145787", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test04Path, fee500, 7000, 13830, "122760651481", "122760651481", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test04Path, fee10000, -16000, 19400, "6470622718", "6470622718", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test04Path, fee10000, 9000, 13600, "23166482059", "23166482059", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test05Path, fee100, 6932, 17919, "638463861008", "638463861008", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test05Path, fee100, 13844, 13883, "421057401632", "421057401632", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test05Path, fee500, 0, 21970, "1200510506426", "1200510506426", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test05Path, fee500, 10990, 20800, "36541253381", "36541253381", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test05Path, fee3000, 10980, 19440, "220772753729", "220772753729", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test05Path, fee3000, 0, 21960, "600856564327", "600856564327", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test06Path, fee100, 6931, 23028, "627563342144", "627563342144", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test06Path, fee100, 6932, 21973, "72190384504", "72190384504", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test06Path, fee500, 13860, 42050, "100000000000", "100000000000", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test06Path, fee500, 10990, 21970, "442699863581", "442699863581", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test06Path, fee10000, 13800, 19400, "356144066864", "356144066864", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test06Path, fee10000, 9200, 23000, "499555550854", "499555550854", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test07Path, fee100, 13863, 20795, "821789902092", "821789902092", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test07Path, fee100, 13863, 20795, "821789902092", "821789902092", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test07Path, fee500, 13860, 20800, "1642023534758", "1642023534758", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test07Path, fee500, 6930, 21970, "1382870753552", "1382870753552", "0", "0", max_timeout, gsa.String())

	pn.Mint(test01Path, test07Path, fee3000, 16080, 23040, "699483794906", "699483794906", "0", "0", max_timeout, gsa.String())
	pn.Mint(test01Path, test07Path, fee3000, 0, 24840, "364073594326", "364073594326", "0", "0", max_timeout, gsa.String())
}

func TestPositionMintTest02(t *testing.T) {
	pn.Mint(test02Path, test03Path, fee100, 0, 16095, "313690621950", "313690621950", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test03Path, fee100, 6931, 17039, "100000000000", "100000000000", "0", "0", max_timeout, gsa.String())

	pn.Mint(test02Path, test03Path, fee500, 0, 40260, "11648610111", "11648610111", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test03Path, fee500, 0, 21970, "388600909063", "388600909063", "0", "0", max_timeout, gsa.String())

	pn.Mint(test02Path, test03Path, fee10000, 7000, 18000, "200000000000", "200000000000", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test03Path, fee10000, 2200, 16000, "253843175539", "253843175539", "0", "0", max_timeout, gsa.String())

	pn.Mint(test02Path, test04Path, fee100, 6932, 17919, "361527556520", "361527556520", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test04Path, fee100, 0, 17919, "6895200332340", "6895200332340", "0", "0", max_timeout, gsa.String())

	pn.Mint(test02Path, test04Path, fee500, 10990, 20800, "100000000000", "100000000000", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test04Path, fee500, 10990, 16100, "158385190994", "158385190994", "0", "0", max_timeout, gsa.String())

	pn.Mint(test02Path, test04Path, fee3000, 0, 17940, "687188963830", "687188963830", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test04Path, fee3000, 5580, 19440, "703031331230", "703031331230", "0", "0", max_timeout, gsa.String())

	pn.Mint(test02Path, test05Path, fee100, 10986, 17918, "615942459146", "615942459146", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test05Path, fee100, 0, 19460, "1199425721469", "1199425721469", "0", "0", max_timeout, gsa.String())

	pn.Mint(test02Path, test05Path, fee500, 13860, 17920, "38394512076", "38394512076", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test05Path, fee500, 0, 21970, "405957838945", "405957838945", "0", "0", max_timeout, gsa.String())

	pn.Mint(test02Path, test05Path, fee10000, 11000, 19400, "419695809134", "419695809134", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test05Path, fee10000, 8200, 22000, "443122151130", "443122151130", "0", "0", max_timeout, gsa.String())

	pn.Mint(test02Path, test06Path, fee100, 6931, 21972, "1000521331334", "1000521331334", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test06Path, fee100, 6931, 20795, "2556074500385", "2556074500385", "0", "0", max_timeout, gsa.String())

	pn.Mint(test02Path, test06Path, fee500, 13860, 21970, "37146250082", "37146250082", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test06Path, fee500, 10990, 17920, "3368852140124", "3368852140124", "0", "0", max_timeout, gsa.String())

	pn.Mint(test02Path, test06Path, fee3000, 0, 19440, "2798672975286", "2798672975286", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test06Path, fee3000, 10140, 24000, "164120263441", "164120263441", "0", "0", max_timeout, gsa.String())

	pn.Mint(test02Path, test07Path, fee100, 16095, 20795, "809882085924", "809882085924", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test07Path, fee100, 10986, 21972, "1387878022963", "1387878022963", "0", "0", max_timeout, gsa.String())

	pn.Mint(test02Path, test07Path, fee500, 6930, 23030, "1492431403396", "1492431403396", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test07Path, fee500, 13860, 19460, "384840542642", "384840542642", "0", "0", max_timeout, gsa.String())

	pn.Mint(test02Path, test07Path, fee10000, -887200, 887200, "649937758546", "649937758546", "0", "0", max_timeout, gsa.String())
	pn.Mint(test02Path, test07Path, fee10000, 11800, 25600, "652783607869", "652783607869", "0", "0", max_timeout, gsa.String())
}

func TestPositionMintTest03(t *testing.T) {
	pn.Mint(test03Path, test04Path, fee100, 17919, 21973, "908694196799", "908694196799", "0", "0", max_timeout, gsa.String())
	pn.Mint(test03Path, test04Path, fee100, 6932, 21973, "416341339041", "416341339041", "0", "0", max_timeout, gsa.String())

	pn.Mint(test03Path, test04Path, fee500, 21970, 23030, "20000000000", "20000000000", "0", "0", max_timeout, gsa.String())
	pn.Mint(test03Path, test04Path, fee500, 16100, 20800, "429942823203", "429942823203", "0", "0", max_timeout, gsa.String())

	pn.Mint(test03Path, test04Path, fee3000, -887220, 887220, "749997177131", "749997177131", "0", "0", max_timeout, gsa.String())
	pn.Mint(test03Path, test04Path, fee3000, 13200, 27060, "3768141002150", "3768141002150", "0", "0", max_timeout, gsa.String())

	pn.Mint(test03Path, test05Path, fee100, 0, 10987, "31922613274", "31922613274", "0", "0", max_timeout, gsa.String())
	pn.Mint(test03Path, test05Path, fee100, 0, 21973, "221652920494", "221652920494", "0", "0", max_timeout, gsa.String())

	pn.Mint(test03Path, test05Path, fee500, -23030, 23030, "280887666874", "280887666874", "0", "0", max_timeout, gsa.String())
	pn.Mint(test03Path, test05Path, fee500, 6920, 6940, "29997545352", "29997545352", "0", "0", max_timeout, gsa.String())

	pn.Mint(test03Path, test05Path, fee10000, 0, 11000, "3183059201", "3183059201", "0", "0", max_timeout, gsa.String())
	pn.Mint(test03Path, test05Path, fee10000, 0, 13800, "201563173011", "201563173011", "0", "0", max_timeout, gsa.String())

	pn.Mint(test03Path, test06Path, fee100, 13864, 17919, "606104542844", "606104542844", "0", "0", max_timeout, gsa.String())
	pn.Mint(test03Path, test06Path, fee100, 6932, 20796, "877649638582", "877649638582", "0", "0", max_timeout, gsa.String())

	pn.Mint(test03Path, test06Path, fee500, 0, 21970, "1086196044932", "1086196044932", "0", "0", max_timeout, gsa.String())
	pn.Mint(test03Path, test06Path, fee500, 16090, 16110, "29997545352", "29997545352", "0", "0", max_timeout, gsa.String())

	pn.Mint(test03Path, test06Path, fee3000, 20820, 23040, "100000000000", "100000000000", "0", "0", max_timeout, gsa.String())
	pn.Mint(test03Path, test06Path, fee3000, 13860, 17940, "600527349889", "600527349889", "0", "0", max_timeout, gsa.String())

	pn.Mint(test03Path, test07Path, fee100, 0, 17918, "574015775664", "574015775664", "0", "0", max_timeout, gsa.String())
	pn.Mint(test03Path, test07Path, fee100, 11927, 11948, "439930859", "439930859", "0", "0", max_timeout, gsa.String())

	pn.Mint(test03Path, test07Path, fee500, 6930, 13860, "79825840230", "79825840230", "0", "0", max_timeout, gsa.String())
	pn.Mint(test03Path, test07Path, fee500, -887270, 16100, "175680910214", "175680910214", "0", "0", max_timeout, gsa.String())

	pn.Mint(test03Path, test07Path, fee10000, 11000, 18000, "100000000000", "100000000000", "0", "0", max_timeout, gsa.String())
	pn.Mint(test03Path, test07Path, fee10000, 5000, 18800, "1665556973", "1665556973", "0", "0", max_timeout, gsa.String())
}

func TestPositionMintTest04(t *testing.T) {
	pn.Mint(test04Path, test05Path, fee100, 0, 21972, "483771709418", "483771709418", "0", "0", max_timeout, gsa.String())
	pn.Mint(test04Path, test05Path, fee100, 13863, 21972, "12002081358", "12002081358", "0", "0", max_timeout, gsa.String())

	pn.Mint(test04Path, test05Path, fee500, 0, 20800, "2645657104", "2645657104", "0", "0", max_timeout, gsa.String())
	pn.Mint(test04Path, test05Path, fee500, 0, 39120, "54322073822", "54322073822", "0", "0", max_timeout, gsa.String())

	pn.Mint(test04Path, test05Path, fee3000, 16080, 19440, "71891586720", "71891586720", "0", "0", max_timeout, gsa.String())
	pn.Mint(test04Path, test05Path, fee3000, 10980, 24840, "467541469014", "467541469014", "0", "0", max_timeout, gsa.String())

	pn.Mint(test04Path, test06Path, fee100, 10986, 21971, "204906414326", "204906414326", "0", "0", max_timeout, gsa.String())
	pn.Mint(test04Path, test06Path, fee100, 16095, 21972, "9183876931", "9183876931", "0", "0", max_timeout, gsa.String())

	pn.Mint(test04Path, test06Path, fee500, 6930, 21970, "165779912631", "165779912631", "0", "0", max_timeout, gsa.String())
	pn.Mint(test04Path, test06Path, fee500, 10990, 20800, "372926637517", "372926637517", "0", "0", max_timeout, gsa.String())

	pn.Mint(test04Path, test06Path, fee10000, 11000, 23000, "14883748980", "14883748980", "0", "0", max_timeout, gsa.String())
	pn.Mint(test04Path, test06Path, fee10000, 12600, 26400, "381277210771", "381277210771", "0", "0", max_timeout, gsa.String())

	pn.Mint(test04Path, test07Path, fee100, 0, 34013, "642255741475", "642255741475", "0", "0", max_timeout, gsa.String())
	pn.Mint(test04Path, test07Path, fee100, 17907, 17927, "733260702", "733260702", "0", "0", max_timeout, gsa.String())

	pn.Mint(test04Path, test07Path, fee500, -887270, 887270, "333313649477", "333313649477", "0", "0", max_timeout, gsa.String())
	pn.Mint(test04Path, test07Path, fee500, 10990, 21970, "957790886933", "957790886933", "0", "0", max_timeout, gsa.String())

	pn.Mint(test04Path, test07Path, fee3000, -115140, 22980, "267976902752", "267976902752", "0", "0", max_timeout, gsa.String())
	pn.Mint(test04Path, test07Path, fee3000, 10980, 24780, "3094931108259", "3094931108259", "0", "0", max_timeout, gsa.String())
}

func TestPositionMintTest05(t *testing.T) {
	pn.Mint(test05Path, test06Path, fee100, 6932, 19461, "961039539315", "961039539315", "0", "0", max_timeout, gsa.String())
	pn.Mint(test05Path, test06Path, fee100, 17038, 17059, "12100504", "12100504", "0", "0", max_timeout, gsa.String())

	pn.Mint(test05Path, test06Path, fee500, 0, 6930, "10000000", "10000000", "0", "0", max_timeout, gsa.String())
	pn.Mint(test05Path, test06Path, fee500, 21970, 23030, "10000000000", "10000000000", "0", "0", max_timeout, gsa.String())

	pn.Mint(test05Path, test06Path, fee10000, -887200, 887200, "281129241820", "281129241820", "0", "0", max_timeout, gsa.String())
	pn.Mint(test05Path, test06Path, fee10000, 10200, 24000, "241450722505", "241450722505", "0", "0", max_timeout, gsa.String())

	pn.Mint(test05Path, test07Path, fee100, -69082, 115135, "65717311961", "65717311961", "0", "0", max_timeout, gsa.String())
	pn.Mint(test05Path, test07Path, fee100, 18859, 18880, "8798776", "8798776", "0", "0", max_timeout, gsa.String())

	pn.Mint(test05Path, test07Path, fee500, -6930, 93160, "4902367586", "4902367586", "0", "0", max_timeout, gsa.String())
	pn.Mint(test05Path, test07Path, fee500, 16100, 19460, "65376765453", "65376765453", "0", "0", max_timeout, gsa.String())

	pn.Mint(test05Path, test07Path, fee3000, -50220, 144660, "787553125", "787553125", "0", "0", max_timeout, gsa.String())
	pn.Mint(test05Path, test07Path, fee3000, 8460, 25800, "9146541088", "9146541088", "0", "0", max_timeout, gsa.String())
}

func TestPositionMintTest06(t *testing.T) {
	pn.Mint(test06Path, test07Path, fee100, -46055, 6931, "49999999998", "49999999998", "0", "0", max_timeout, gsa.String())
	pn.Mint(test06Path, test07Path, fee100, -16108, 16087, "999999997", "999999997", "0", "0", max_timeout, gsa.String())

	pn.Mint(test06Path, test07Path, fee500, -20960, 7850, "49999999992", "49999999992", "0", "0", max_timeout, gsa.String())
	pn.Mint(test06Path, test07Path, fee500, -16110, 16090, "1110999999", "1110999999", "0", "0", max_timeout, gsa.String())

	pn.Mint(test06Path, test07Path, fee10000, -67200, 7800, "998", "998", "0", "0", max_timeout, gsa.String())
	pn.Mint(test06Path, test07Path, fee10000, -887200, 887200, "123447", "123447", "0", "0", max_timeout, gsa.String())
}

/*
func TestSwapTest01_Test02(t *testing.T) {
	std.TestSetPrevAddr(gsa)

	poolIn := ""
	poolOut := ""
	ok := false

	poolIn, poolOut, ok = DrySwap(test01Path, test02Path, fee100, true, "10000", consts.MIN_PRICE)
	println("poolIn: ", poolIn)
	println("poolOut: ", poolOut)
	println("ok: ", ok)
	println()

	poolIn, poolOut, ok = DrySwap(test01Path, test02Path, fee100, false, "10000", consts.MAX_PRICE)
	println("poolIn: ", poolIn)
	println("poolOut: ", poolOut)
	println("ok: ", ok)
	println()

	poolIn, poolOut, ok = DrySwap(test01Path, test02Path, fee100, true, "-10000", consts.MIN_PRICE)
	println("poolIn: ", poolIn)
	println("poolOut: ", poolOut)
	println("ok: ", ok)
	println()

	poolIn, poolOut, ok = DrySwap(test01Path, test02Path, fee100, false, "-10000", consts.MAX_PRICE)
	println("poolIn: ", poolIn)
	println("poolOut: ", poolOut)
	println("ok: ", ok)
	println()
}
*/

func TestSwapTest06_Test07(t *testing.T) {
	std.TestSetPrevAddr(gsa)

	poolIn := ""
	poolOut := ""
	ok := false

	poolIn, poolOut, ok = DrySwap(test06Path, test07Path, fee10000, true, "10000", consts.MIN_PRICE)
	println("poolIn: ", poolIn)
	println("poolOut: ", poolOut)
	println("ok: ", ok)
	println()

	// poolIn, poolOut, ok = DrySwap(test06Path, test07Path, fee10000, false, "10000", consts.MAX_PRICE)
	// println("poolIn: ", poolIn)
	// println("poolOut: ", poolOut)
	// println("ok: ", ok)
	// println()

	// poolIn, poolOut, ok = DrySwap(test06Path, test07Path, fee10000, true, "-10000", consts.MIN_PRICE)
	// println("poolIn: ", poolIn)
	// println("poolOut: ", poolOut)
	// println("ok: ", ok)
	// println()

	// poolIn, poolOut, ok = DrySwap(test06Path, test07Path, fee10000, false, "-10000", consts.MAX_PRICE)
	// println("poolIn: ", poolIn)
	// println("poolOut: ", poolOut)
	// println("ok: ", ok)
	// println()
}
