-- @Author: zhangzg 
-- @Date: 2018-06-11 19:20:17 
-- @Last Modified by:   zhangzg 
-- @Last Modified time: 2018-06-11 19:20:17 


module(...,package.seeall)
local Local_UserObj = require("minigame.blackgame.game.usernodepag")
require("minigame.blackgame.game.system.blackdata")

local Local_GameScene = require "minigame.blackgame.game.system.blackgamemianpagnew"
local Local_GameStateObj = require "minigame.blackgame.game.system.gamestate"
local Local_UserMgr = require "minigame.blackgame.game.system.usermgr"
local Local_CardMgr = require "minigame.blackgame.game.system.cardmgr"


function Create(aiData)
    local selfObj ={}
    setmetatable( selfObj, { __index = _M } )

    selfObj:Init()
    return selfObj
end

function Init(selfObj)
    My_Lua_log(" file=[system] fun=[init];")
    
    selfObj:SystemStart()
end

function SystemStart( selfObj )
    local function Update( aiDelTime )
        -- My_Lua_log(" file=[system] fun=[Update];")
        Local_UserMgr.Instance():OnUpdate(aiDelTime)
        Local_GameStateObj:Instance():OnUpdate(aiDelTime)
        Local_CardMgr.Instance():OnUpdate(aiDelTime)
    end

    cc.Director:getInstance():getScheduler():scheduleScriptFunc(Update, 0, false)
end