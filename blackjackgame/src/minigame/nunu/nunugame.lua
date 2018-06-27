
module(...,package.seeall)
local Local_UiBase = require "comm.uibase"

function Create(aiData)

    local selfObj = Local_UiBase.Create(aiData)
    local parents = {_M, Local_UiBase}
	setmetatable( selfObj ,{__index = function(t,k)
		return search(k,parents) end } )
    selfObj.miPagName = "nunugame"
    selfObj.miRoot = nil
    selfObj.nnGame = nil
    selfObj:Init()

    return selfObj
end

--创建初始化UI
function Init(selfObj)
    My_Lua_log(" file=[nunugame] fun=[init];")
    selfObj.miRoot =cc.Node:create()
    selfObj.miRoot:setName("nunuNode")
    selfObj.miRoot:retain()

    local tList = G_Fy.GamegLobal:GetUserBaseInfoByUuid(G_Fy.GamegLobal:GetSelfUuid())

    local tData = {}
    tData.uuid =  tonumber(G_Fy.GamegLobal:GetSelfUuid())
    tData.avatar =  tList['url']
    tData.coins = tonumber(G_Fy.GamegLobal:GetCoin())
My_Lua_log(" file=[nunugame] fun=[init];  tData.coins="..tData.coins)

    tData.isEffectsAudio = true
    tData.isBackgroundMusic=true
    tData.effectsVolume = 1
    tData.backgroundMusicVolume = 1
    if tonumber(tList['gender']) > 0 then
        tData.sex = 'male'
    else
        tData.sex = 'famale'
    end
    tData.isDebug = false
    tData.language = tonumber(1)
    tData.token = G_Fy.miMiniGameToken

    local NNGame = require("minigame.nunu.nn.NNGame")
    selfObj.nnGame = NNGame.new()
    selfObj.nnGame:initData(tData)

    local tPlatform =  G_Fy.GamegLobal:GetPhonePlatform()
    local designSize = DesignResolutionSizeList[tPlatform]
    local theightOff = - 0.5* designSize.height
    local twidthtOff = - 0.5* designSize.width

    selfObj.nnGame:setPosition(cc.p(twidthtOff,theightOff))

    selfObj.miRoot:addChild(selfObj.nnGame)

    selfObj.miEventMgr:AddListen( SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_APPLICATIONDIDENTERBACKGROUND_MSG, OnApplicationDidEnterBackground, 5, selfObj)
    selfObj.miEventMgr:AddListen( SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_APPLICATIONDIDENTERFOREGROUND_MSG, OnApplicationWillEnterForeground, 5, selfObj)
end

function IsCacheUi(selfObj)
    return false
end

function GetRootNode(selfObj)
    return selfObj.miRoot
end

function OnApplicationDidEnterBackground(selfObj)
    selfObj.nnGame:enterBackground()
    My_Lua_log(" file=[nunugame] fun=[OnApplicationDidEnterBackground];")
end

function OnApplicationWillEnterForeground(selfObj)
    selfObj.nnGame:enterForeground()
    My_Lua_log(" file=[nunugame] fun=[OnApplicationWillEnterForeground];")
end


function OnClose(selfObj)
    Local_UiBase:OnClose()
    --移除
    selfObj.miRoot:removeFromParentAndCleanup()
    My_Lua_log(" file=[nunugame] fun=[onclose]; remove   ok")
end

--真正的退出删除
function OnExit(selfObj)
    selfObj.miRoot:release()
    selfObj.miEventMgr:RemoveListenFromObj(selfObj)
    My_Lua_log(" file=[nunugame] fun=[onexit];")
end

-- 刷新数据
function OnOpen(selfObj, miData)
    My_Lua_log(" file=[nunugame] fun=[OnOpen]; ")

end


function OnUpdate(selfObj, aiDelTime)
    if selfObj.miRoot:getChildrenCount() < 1 then
        --[[
        local aiEvent = {}
        aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_CLOSE_PAG
        aiEvent.miPagName = "nunugame"
        aiEvent.miData = {}
        selfObj.miEventMgr:Dispatch(aiEvent)
        --]]
        G_Fy.miNetMgr:StopGame(selfObj.miGameRoom:GetGameRoomId())  
        local aiEvent = {}
        aiEvent.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_EXIST_COCOS2DX
        aiEvent.miData = {}
        aiEvent.miData.miType = 0
        aiEvent.miData.miRoomName = ""
        G_Fy:GetFyEvent():NextDispatch(aiEvent)
        
        My_Lua_log(" file=[nunugame] fun=[OnUpdate]; 111111111")
    end
end

--endregion
