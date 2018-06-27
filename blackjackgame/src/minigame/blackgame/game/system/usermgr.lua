-- @Author: zhangzg 
-- @Date: 2018-06-13 18:04:52 
-- @Last Modified by:   zhangzg 
-- @Last Modified time: 2018-06-13 18:04:52 


module(...,package.seeall)
local Local_UiBase = require "comm.uibase"
local Local_UserObj = require "minigame.blackgame.game.system.userpag"
local Local_GameStateObj = require "minigame.blackgame.game.system.gamestate"

local Local_GIsCreate = false
local Local_UserMgrObj = {}


function Instance()
	if Local_GIsCreate == true then
		return Local_UserMgrObj
	end
	setmetatable(Local_UserMgrObj, {__index = _M})
	Local_GIsCreate = true

    Local_UserMgrObj:Init()

	return Local_UserMgrObj
end

function Init(selfObj)
    selfObj.miUserList = {}
    local tNowTime = os.time()
    selfObj.miAddStartTime = tNowTime
    My_Lua_log(" file=[usermgr] fun=[Init]; selfObj.miAddStartTime = "..tostring(selfObj.miAddStartTime))
    selfObj.miAddEndTime = tNowTime + USRE_ADD_TIME

    selfObj.miSeatSitDown = {}
    for i=1,GAME_SEAT_NUM do
        selfObj.miSeatSitDown[i] = nil
    end
end


function GetUserList( selfObj )
    return selfObj.miUserList
end

function CreateUserPag( selfObj )
    My_Lua_log(" file=[usermgr] fun=[CreateUserPag]; ")
    local tSeatId = 1
    for i=1,#selfObj.miSeatSitDown do
        if selfObj.miSeatSitDown[i] == nil then
            tSeatId = i
            break
        end
    end
  
    local tUserData = {
        lSeatId = tSeatId,
        lUuid = 1000 + tSeatId,
    }
    local tUserPag = Local_UserObj.Create(tUserData)
    table.insert( selfObj.miUserList,tUserPag )
    My_Lua_log(" file=[usermgr] fun=[CreateUserPag]; user count = "..tostring(#selfObj.miUserList))

end

function GetPlayingUserPags( selfObj )
    local tPlayingUserPags = {}
    if selfObj.miUserList == nil then
        My_Lua_log(" file=[usermgr] fun=[GetPlayingUserPags]; selfObj.miUserList=nilllllll")
    end
    for i=1,#selfObj.miUserList do
        if selfObj.miUserList == nil then
            My_Lua_log(" file=[usermgr] fun=[GetPlayingUserPags]; i="..tostring(i))
        end
        local tUserPag = selfObj.miUserList[i]
        if tUserPag:GetUserIsPlaying() == true then
            table.insert( tPlayingUserPags, tUserPag )
        end
    end

    My_Lua_log(" file=[usermgr] fun=[GetPlayingUserPags]; #tPlayingUserPags="..tostring(#tPlayingUserPags))
    return tPlayingUserPags
end

function GetUserIsFitStart( selfObj )
    if #selfObj.miUserList >= GAME_USER_NUM_MIN then
        return true
    end

    return false
end

function SetAlreadySitDownUserPlaying( selfObj )
    My_Lua_log(" file=[usermgr] fun=[SetAlreadySitDownUserPlaying]; ")
    for i=1,#selfObj.miUserList do
        selfObj.miUserList[i]:SetUserStatePlaying()
    end
end

function SetAlreadySitDownUserWaiting( selfObj )
    for i=1,#selfObj.miUserList do
        selfObj.miUserList[i]:SetUserStateWaiting()
    end
end

function OnUpdate(selfObj, aiDelTime)
    local tNowTime = os.time()
    -- My_Lua_log(" file=[usermgr] fun=[OnUpdate]; tNowTime="..tostring(tNowTime).."  endtime="..tostring(selfObj.miAddEndTime))

    if tNowTime >= selfObj.miAddEndTime then
        if #selfObj.miUserList >= USER_MAX then
            -- My_Lua_log(" file=[usermgr] fun=[OnUpdate]; 超出最大人数")
            return
        end
        selfObj:CreateUserPag()
        
        selfObj.miAddStartTime = tNowTime
        selfObj.miAddEndTime = tNowTime + USRE_ADD_TIME
    end
end

function GetIsCardMax( selfObj )
    My_Lua_log(" file=[usermgr] fun=[GetIsCardMax]; ")
    if selfObj.miUserList ~= nil and selfObj.miUserList[1]:GetUserCardsIsMax() == true then
        return true
    end
    return false
end

function RemoveEndUser( selfObj )
    local tCount = #selfObj.miUserList
    My_Lua_log(" file=[usermgr] fun=[RemoveEndUser]; tCount="..tostring(tCount))
    local tUserPag = selfObj.miUserList[tCount]
    if tUserPag ~= nil then
        My_Lua_log(" file=[usermgr] fun=[RemoveEndUser]; ")
        tUserPag:Remove()
        table.remove( selfObj.miUserList,tCount )  
    end
end
