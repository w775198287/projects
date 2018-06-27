-- @Author: zhangzg 
-- @Date: 2018-06-13 18:47:17 
-- @Last Modified by:   zhangzg 
-- @Last Modified time: 2018-06-13 18:47:17 


module(...,package.seeall)
local Local_UiBase = require "comm.uibase"
local Local_UserObj = require "minigame.blackgame.game.usernodepag"
local Local_UserMgr = require "minigame.blackgame.game.system.usermgr"


local Local_GIsCreate = false
local Local_GameStateObj = {}


function Instance()
	if Local_GIsCreate == true then
		return Local_GameStateObj
	end
	setmetatable(Local_GameStateObj, {__index = _M})
    Local_GIsCreate = true
    
    Local_GameStateObj:Init()

	return Local_GameStateObj
end

function Init( selfObj )
    My_Lua_log(" file=[gamestateobj] fun=[Init]; ")

    selfObj.miGameState = GAME_STATE.WAITING

    selfObj.miStateStart = true
    selfObj.miRoundIndex = 1
    selfObj:SetGameStateStartFalse()
    -- selfObj:UpdateTimeState()

end

function GetGameState( selfObj )
    return selfObj.miGameState
end

function SetGameStateToEnd( selfObj )
    My_Lua_log(" file=[gamestateobj] fun=[SetGameStateToEnd]; ")
    selfObj.miGameState = GAME_STATE.GAMEEND
    Local_UserMgr.Instance():SetAlreadySitDownUserWaiting()
end

function GetGameStateIsStart( selfObj )
    if selfObj.miGameState == GAME_STATE.START then
        return true
    end

    return false
end

function GetGameStateIsRound( selfObj )
    if selfObj.miGameState == GAME_STATE.ROUND then
        return true
    end

    return false
end

function GetStartState( selfObj )
    return selfObj.miStartState
end

function SetGameStateStartFalse( selfObj )
    selfObj.miStartState = false
end

function UpdateTimeState( selfObj )
    if selfObj.miGameState == GAME_STATE.START or selfObj.miGameState == GAME_STATE.ROUND then
        selfObj.miStartState = true
    end


    if selfObj.miGameState == GAME_STATE.START then
        Local_UserMgr.Instance():SetAlreadySitDownUserPlaying()
    -- elseif selfObj.miGameState == GAME_STATE.WAITING then
    --     Local_UserMgr.Instance():SetAlreadySitDownUserWaiting()
    elseif selfObj.miGameState == GAME_STATE.GAMEEND then
        Local_UserMgr.Instance():SetAlreadySitDownUserPlaying()
    end


    local tNowTime = os.time()
    selfObj.miStartStateTime = tNowTime
    selfObj.miStateEndTime = tNowTime + GAME_TIME_STATE[selfObj.miGameState]

    My_Lua_log(" file=[gamestateobj] fun=[UpdateTimeState]; selfObj.miGameState="..tostring(selfObj.miGameState))
end

function OnUpdate( selfObj, aiDelTime )

    -- 人数没有达到要求
    local tUserIsFitStart = Local_UserMgr.Instance():GetUserIsFitStart()
    if tUserIsFitStart == false then
        -- 游戏没有开始时
        if selfObj.miGameState == GAME_STATE.WAITING then
            return
        end

        -- 游戏过程中玩家推出导致游戏提前结束(非end阶段)
        if selfObj.miGameState < GAME_STATE.GAMEEND then
            
            selfObj.miGameState = GAME_STATE.GAMEEND
            return
        end
    end

    local tNowTime = os.time()
    -- waiting阶段人数达到要求，转入START阶段
    if selfObj.miGameState == GAME_STATE.WAITING then
        -- local tUserIsFitStart = Local_UserMgr.Instance():GetUserIsFitStart()
        -- if tUserIsFitStart == false then
        --     selfObj:UpdateTimeState()
        --     return
        -- end

        selfObj.miGameState = GAME_STATE.START
        selfObj:UpdateTimeState()
    else
        --  状态时间到了：正常轮转
        if tNowTime >= selfObj.miStateEndTime then
            My_Lua_log(" file=[gamestateobj] fun=[OnUpdate]; selfObj.miGameState="..tostring(selfObj.miGameState))
            if selfObj.miGameState == GAME_STATE.GAMEEND then
                selfObj.miGameState = GAME_STATE.WAITING
            elseif selfObj.miGameState == GAME_STATE.START then
                My_Lua_log(" file=[gamestateobj] fun=[OnUpdate]; 1111111")
                selfObj.miGameState = GAME_STATE.ROUND
            elseif selfObj.miGameState == GAME_STATE.ROUND then
                My_Lua_log(" file=[gamestateobj] fun=[OnUpdate]; 2222222")
                if Local_UserMgr.Instance():GetIsCardMax() == true then
                    My_Lua_log(" file=[gamestateobj] fun=[OnUpdate]; GetIsCardMax")
                    selfObj:SetGameStateToEnd()
                else
                    My_Lua_log(" file=[gamestateobj] fun=[OnUpdate]; 3333333")
                    selfObj.miGameState = GAME_STATE.ROUND
                end
            end
            selfObj:UpdateTimeState()
        else
            --  状态时间没有到，什么都不干
        end
    end
end