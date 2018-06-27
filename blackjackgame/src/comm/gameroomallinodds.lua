--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

module(...,package.seeall)
local Local_GameRoomkBase = require "comm.gameroombase"

function Create(aiData)
    local selfObj = Local_GameRoomkBase.Create(aiData)
    local parents = {_M, Local_GameRoomkBase}
	setmetatable( selfObj ,{__index = function(t,k)
		return search(k,parents) end } )

    selfObj:Init(aiData)
    return selfObj
end

function Init(selfObj, aiData)
    --gameroomId
    selfObj.miGameMiniType = 0
    
    --用户数据
    Player = require("comm.player")
    selfObj.miPlayer = Player.Create()
end


function GetNickNameByUuid(selfObj, aiUuid)
    
    return ""
end

function SetGameRoomType(selfObj, aiGameMiniType)
    selfObj.miGameMiniType = aiGameMiniType
end

function GetGameRoomType(selfObj)
    return selfObj.miGameMiniType
end

function SetGameRoomId(selfObj, aiGameRoomId)
    selfObj.miGameRoomId = aiGameRoomId
end

function GetGameRoomId(selfObj)
    return selfObj.miGameRoomId
end

--获得时间修正值(秒)
function GetTimeDifference(selfObj)
    return selfObj.miPlayer:GetTimeDifference()
end

function SetDelayFoldData(selfObj, aiDelayFoldData)

end

function GetDelayFoldData(selfObj)

end

function EmptyWinOddsDataList(selfObj)

end

function GetIsLeagueID(selfObj)

end
