local TTViewBase = import("..tt.TTViewBase")
local TTUtils = import("..tt.TTUtils")
local TTTest = class("TTTest", TTViewBase)


local luaunit = import("..tt.luaunit") --require('luaunit')
require "socket" 
--结算消息内容
function TTTest:getResultMsg()
	local msgStr = '{"id":40101,"body":{"gameStatus":2,"resultInfo":{"xiaZhuCoins":{"1":0,"2":0,"3":0},"totalXiaZhuCoins":{"1":110,"2":130,"3":140},"totalXiaZhuDetail":{"1":[1,0],"2":[0,0,0,1],"3":[1,0,0,0,0]},"cardsData":[{"cards":[5,0],"niuCnt":5,"winFan":0,"winCoins":380},{"cards":[9,2],"niuCnt":2,"winFan":-1,"winCoins":-110},{"cards":[8,3],"niuCnt":1,"winFan":-1,"winCoins":-130},{"cards":[1,10],"niuCnt":1,"winFan":-1,"winCoins":-140}],"coinsChg":0,"coins":199999900,"bankerCoinsChg":380,"bankerCoins":62500380,"seatXiaZhuDetail":[]}}}'
	local msg = json.decode(msgStr)
	return msgStr
end
--加入牌值消息内容
function TTTest:getJoinTableMsg( )
	local msgStr = ""--旧的消息内容已不能使用请截取最新消息内容
	local msg = json.decode(msgStr)
	return msg.body
end



function add(v1,v2)
    -- add positive numbers
    -- return 0 if any of the numbers are 0
    -- error if any of the two numbers are negative
    if v1 < 0 or v2 < 0 then
        error('Can only add positive or null numbers, received '..v1..' and '..v2)
    end
    if v1 == 0 or v2 == 0 then
        return 0
    end
    return v1+v2
end
function adder(v)
    -- return a function that adds v to its argument using add
    function closure( x ) return x+v end
    return closure
end




function TTTest:runTest()
	
	local t0 = socket.gettime()
	luaunit.LuaUnit.run()
	local t1 = socket.gettime()
	TTUtils:Log("t1-t0 = ", (t1-t0))
end
return TTTest
