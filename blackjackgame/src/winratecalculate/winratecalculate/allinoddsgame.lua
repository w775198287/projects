
module(...,package.seeall)
local Local_UiBase = require "comm.uibase"

function Create(aiData)

    local selfObj = Local_UiBase.Create(aiData)
    local parents = {_M, Local_UiBase}
	setmetatable( selfObj ,{__index = function(t,k)
		return search(k,parents) end } )
    selfObj.miPagName = "allinoddsgame"
    selfObj.miRoot = nil
    selfObj.nnGame = nil
    selfObj:Init()

    return selfObj
end

--创建初始化UI
function Init(selfObj)
    My_Lua_log(" file=[ttgame] fun=[init];")
    selfObj.miRoot =cc.Node:create()
    selfObj.miRoot:setName("allinoddsgame")
    selfObj.miRoot:retain()


    local allinoddsgame = require("winratecalculate.winratecalculate.winratecalculatepag")
    selfObj.miAllinOddsGame = allinoddsgame:Create()

    selfObj.miRoot:addChild(selfObj.miAllinOddsGame:GetRootNode())

    selfObj.miEventMgr:AddListen( SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_APPLICATIONDIDENTERBACKGROUND_MSG, OnApplicationDidEnterBackground, 5, selfObj)
    selfObj.miEventMgr:AddListen( SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_APPLICATIONDIDENTERFOREGROUND_MSG, OnApplicationWillEnterForeground, 5, selfObj)
end

function GetRootNode(selfObj)
    return selfObj.miRoot
end

function OnApplicationDidEnterBackground(selfObj)
    My_Lua_log(" file=[allinoddsgame] fun=[OnApplicationDidEnterBackground];")
end

function OnApplicationWillEnterForeground(selfObj)
    My_Lua_log(" file=[allinoddsgame] fun=[OnApplicationWillEnterForeground];")
end


function OnClose(selfObj)
    Local_UiBase:OnClose()
    --移除
    selfObj.miRoot:removeFromParentAndCleanup()
    My_Lua_log(" file=[allinoddsgame] fun=[onclose]; remove   ok")
end

--真正的退出删除
function OnExit(selfObj)
    selfObj.miRoot:release()
    selfObj.miEventMgr:RemoveListenFromObj(selfObj)
    My_Lua_log(" file=[allinoddsgame] fun=[onexit];")
end

-- 刷新数据
function OnOpen(selfObj, miData)
    My_Lua_log(" file=[allinoddsgame] fun=[OnOpen]; ")

end


function OnUpdate(selfObj, aiDelTime)
    if selfObj.miRoot:getChildrenCount() < 1 then
        --切换到IOS界面
        My_Lua_log(" selfObj.miGameRoom:GetGameRoomId() = "..selfObj.miGameRoom:GetGameRoomId())
        G_Fy.miNetMgr:StopGame(selfObj.miGameRoom:GetGameRoomId())

        local aiEvent = {}
        aiEvent.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_EXIST_COCOS2DX
        aiEvent.miData = {}
        aiEvent.miData.miType = 0
        aiEvent.miData.miRoomName = ""
        G_Fy:GetFyEvent():NextDispatch(aiEvent)
    end
end

--endregion
