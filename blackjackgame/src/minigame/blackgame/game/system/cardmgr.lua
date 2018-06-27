-- @Author: zhangzg 
-- @Date: 2018-06-22 15:41:30 
-- @Last Modified by:   zhangzg 
-- @Last Modified time: 2018-06-22 15:41:30 

module(...,package.seeall)
local Local_UiBase = require "comm.uibase"
local Local_UserObj = require("minigame.blackgame.game.usernodepag")
local Local_UserMgr = require "minigame.blackgame.game.system.usermgr"
local Local_GameStateObj = require "minigame.blackgame.game.system.gamestate"


local Local_GIsCreate = false
local Local_CardMgrObj = {}


function Instance()
	if Local_GIsCreate == true then
		return Local_CardMgrObj
	end
	setmetatable(Local_CardMgrObj, {__index = _M})
	Local_GIsCreate = true
    --下一帧执行事件列表
    Local_CardMgrObj.miAllCardData = CARD_DATA
    Local_CardMgrObj.miUserCardData = nil

	return Local_CardMgrObj
end

function SelectedCard( selfObj, lPerUserCount )
    My_Lua_log(" file=[cardmgr] fun=[SelectedCard]; ")
    local tPlayingUserPags = Local_UserMgr.Instance():GetPlayingUserPags()
    if tPlayingUserPags == nil then
        My_Lua_log(" file=[cardmgr] fun=[SelectedCard]; nil")
        return
    end
    local tPlayingCount = #tPlayingUserPags

    local tSelectedCardData = {}
    local tCardCount = lPerUserCount*tPlayingCount
    while (#tSelectedCardData < tCardCount)
    do
        local tRandIndex = math.random( 1, 52 )
        local tCardValue = selfObj.miAllCardData[tRandIndex]
        local bPerSuccess = true
        for i=1,#tSelectedCardData do
            if tSelectedCardData[i] == tCardValue then
                bPerSuccess = false
                table.remove( selfObj.miAllCardData,tRandIndex )
            end
        end
        if bPerSuccess == true then
            table.insert( tSelectedCardData,tCardValue )
        end
    end

    -- 根据座位号发牌
    local tUserIndex = 1
    for i=1,tPlayingCount do
        local tCards = {}
        for j=1,lPerUserCount do
            local tIndex = tUserIndex + tPlayingCount*(j-1)
            table.insert( tCards, tSelectedCardData[tIndex] )
            tPlayingUserPags[i]:AddCardNode(tSelectedCardData[tIndex])
        end

        -- for k=1,#tCards do
        --     My_Lua_log(" file=[cardmgr] fun=[DealGameState]; tCards["..k.."]="..tostring(tCards[k]))
        -- end

        tUserIndex = tUserIndex + 1
    end
end

function OnUpdate( selfObj, aiDelTime )

    local tStartState = Local_GameStateObj.Instance():GetStartState()
    if tStartState == false then
        return
    end
    if Local_GameStateObj.Instance():GetGameStateIsStart() == true then

        My_Lua_log(" file=[cardmgr] fun=[OnUpdate]; start")
        selfObj:SelectedCard(2)
        Local_GameStateObj.Instance():SetGameStateStartFalse()
    elseif Local_GameStateObj.Instance():GetGameStateIsRound() then
        My_Lua_log(" file=[cardmgr] fun=[OnUpdate]; round")
        selfObj:SelectedCard(1)
        Local_GameStateObj.Instance():SetGameStateStartFalse()
    end
end
