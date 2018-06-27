local NNViewBase = import("..nn.NNViewBase")
local NNUtils = import("..nn.NNUtils")
local NNTest = class("NNTest", NNViewBase)

--结算消息内容
function NNTest:getResultMsg()
	local msgStr = ''--旧的消息内容已不能使用请截取最新消息内容
	local msg = json.decode(msgStr)
	return msg.body
end
--加入牌桌消息内容
function NNTest:getJoinTableMsg()
	local msgStr = '{"id":20004,"body":{"result":0,"boardInfo":{"gameStatus":4,"leftTime":8,"roomInfo":{"roomId":101,"freeTime":3,"firstXiaZhuTime":10,"faPaiTime":5,"secondXiaZhuTime":10,"kaiPaiTime":15,"chips":[10,100,1000,10000,100000],"playerMultiple":3,"applyBankerCoins":50000000,"maxBankerTimes":10},"coins":0,"bankerInfo":{"bankerId":"-3","avatar":"http://106.14.104.115:8085/niuAvatar/3.png","coins":89497405},"seatPlayersInfo":[{"userId":499640,"avatar":"http://info.pokermate.net/data/2017/5/6/499640_small_1494054898262.png","coins":152980,"seatId":0},{"userId":378189,"avatar":"http://info.pokermate.net/data/2017/10/13/378189_small_1507865252832.png","coins":1710,"seatId":1},{"userId":375627,"avatar":"http://info.pokermate.net/data/2017/9/6/375627_small_1504684892540.png","coins":1097,"seatId":2},{"userId":10502,"avatar":"http://info.pokermate.net/data/2015/11/17/10502_small_1447689790838.png","coins":133509,"seatId":3},{"userId":348066,"avatar":"http://info.pokermate.net/data/2017/1/29/348066_small_1485691240815.png","coins":34989,"seatId":4},{"userId":205243,"avatar":"http://info.pokermate.net/data/2016/4/17/205243_small_1460906316176.png","coins":394659,"seatId":5}],"resultInfo":{"xiaZhuCoins":{"1":0,"2":0,"3":0,"4":0},"totalXiaZhuCoins":{"1":910,"2":9910,"3":5710,"4":8230},"totalXiaZhuDetail":{"first":{"1":[0,1,1,1,1,1],"2":[0],"3":[0],"4":[0,0,0,1,1]},"second":{"1":[1,1,1,1],"2":[2,2,2,1,1,2,1,2,1,2,1,2,1,2,1,1,2,1],"3":[1,1,2,2,1,2,2,2,1,1,1,1],"4":[1,1,1,1,2,1,2,1,1,2,2,2,1,2,1,2,1]}},"cardsData":[{"cards":[33,21,45,26,41],"niuCnt":8,"winFan":0,"winCoins":-19440},{"cards":[31,39,13,37,7],"niuCnt":6,"winFan":-3,"winCoins":-2730},{"cards":[42,11,17,23,9],"niuCnt":9,"winFan":3,"winCoins":29730},{"cards":[10,28,29,32,16],"niuCnt":8,"winFan":3,"winCoins":17130},{"cards":[22,35,50,8,6],"niuCnt":6,"winFan":-3,"winCoins":-24690}],"coinsChg":0,"coins":0,"bankerCoinsChg":-19440,"bankerCoins":89497405,"seatXiaZhuDetail":[{"userId":499640,"xiaZhuCoins":{"1":0,"2":5000,"3":5000,"4":4000},"coins":152980,"coinsChg":17100},{"userId":378189,"xiaZhuCoins":{"1":500,"2":0,"3":0,"4":0},"coins":1710,"coinsChg":-1500},{"userId":375627,"xiaZhuCoins":{"1":10,"2":110,"3":10,"4":110},"coins":1097,"coinsChg":0},{"userId":10502,"xiaZhuCoins":{"1":0,"2":4000,"3":0,"4":3000},"coins":133509,"coinsChg":2850},{"userId":348066,"xiaZhuCoins":{"1":400,"2":200,"3":0,"4":220},"coins":34989,"coinsChg":-1260},{"userId":205243,"xiaZhuCoins":{"1":0,"2":600,"3":700,"4":900},"coins":394659,"coinsChg":1140}]}}}}'--旧的消息内容已不能使用请截取最新消息内容
	local msg = json.decode(msgStr)
	return msg.body
end
return NNTest
