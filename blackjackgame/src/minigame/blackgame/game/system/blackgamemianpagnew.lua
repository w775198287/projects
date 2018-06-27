-- @Author: zhangzg 
-- @Date: 2018-06-11 19:20:17 
-- @Last Modified by:   zhangzg 
-- @Last Modified time: 2018-06-11 19:20:17 


module(...,package.seeall)
local Local_UiBase = require "comm.uibase"
local Local_DeskBase = require "comm.gamedeskbase"
local Local_UserObj = require "minigame.blackgame.game.usernodepag"

local Local_UserMgr = require "minigame.blackgame.game.system.usermgr"
local Local_GameStateObj = require "minigame.blackgame.game.system.gamestate"

function Create(aiData)
    local selfObj = Local_UiBase.Create(aiData)
    local parents = {_M, Local_UiBase}
	setmetatable( selfObj ,{__index = function(t,k)
		return search(k,parents) end } )
    selfObj.miPagName = "blackgamemianpagnew"
    selfObj.miBlackGameMainObj = nil

    selfObj.miIsFullUser = false

    selfObj:Init()
    return selfObj
end

function Init(selfObj, aiData)
    My_Lua_log(" file=[blackgamemianpagnew] fun=[init];")
    
    local PromptNode = require("minigame.blackgame.uilua.blackgamemainnode")

    local callBackProvider = function ( path,node,funcName )
        -- 加牌
        if  node:getName()=="btnAdd" and funcName =="OnAddButton" then
            local function OnAddButton1( node,eventType )
                 selfObj:OnAddButton( node,eventType )
            end
            return OnAddButton1
        end

        -- 重置
        if  node:getName()=="btnReset" and funcName =="OnResetButton" then
            local function OnResetButton1( node,eventType )
                 selfObj:OnResetButton( node,eventType )
            end
            return OnResetButton1
        end
    end

    selfObj.miBlackGameMainObj = PromptNode.create(callBackProvider)
    selfObj.miBlackGameMainObj['root']:retain()

end

function IsCacheUi(selfObj)
    return false
end

function GetRootNode(selfObj)
    return selfObj.miBlackGameMainObj['root']
end

--改变UI位置
function ChangePos(selfObj, aiWidth, aiHeight)
    selfObj.miBlackGameMainObj['root']:setPosition(aiWidth, aiHeight)
end

function OnOpen( selfObj, aiData)
    My_Lua_log(" file=[blackgamemianpagnew] fun=[OnOpen];")
    Local_UiBase.OnClose(selfObj)

    selfObj.miStartUpdate = false
    
    local SystemPag = require "minigame.blackgame.game.system.sytempag"
    selfObj.miSystemData = SystemPag.Create(aiData)

    selfObj.miStartUpdate = true
end

function OnAddButton( selfObj, node, eventType )

end

function OnResetButton( selfObj, node, eventType )
    Local_UserMgr.Instance():RemoveEndUser()
end

function CheckUserNode( selfObj )
    local tUserList = Local_UserMgr.Instance():GetUserList()

    local tUserLessCount = 0
    for i=1,3 do
        local tUserNode = selfObj.miBlackGameMainObj['node'..i]
        if tUserNode ~= nil then
            local tChildren = tUserNode:getChildren()
            if  #tChildren == 0 then
                if tUserList[i] ~= nil then
                    tUserNode:addChild(tUserList[i]:GetRootNode())
                end
            end
        end
    end
end

function OnUpdate(selfObj, aiDelTime )
    -- My_Lua_log(" file=[blackgamemianpagnew] fun=[OnUpdate]; ")
    if selfObj.miStartUpdate == false then
        return
    end
    
    selfObj:CheckUserNode()
    
end

function OnStartCard ( selfObj, aiData )
    My_Lua_log(" file=[blackgamemainpagnew] fun=[OnStartCard]; ")

    local tAllUserCardInfo = Local_GameStateObj.Instance():GetAllCardUserInfo()
    local tUserList = Local_UserMgr.Instance():GetUserList()

    for k,v in pairs(tAllUserCardInfo) do
        local tlUuid = k
        local tUserCardInfo = v
        if tUserCardInfo ~= nil then
            My_Lua_log(" file=[blackgamemainpagnew] fun=[OnStartCard]; tStardCardInfo ~= nil")
            for i=1,#tUserList do
                if tlUuid == tUserList[i]:GetUserId() then
                    My_Lua_log(" file=[blackgamemainpagnew] fun=[OnStartCard]; uuid")
                    tUserList[i]:AddStartCard(tUserCardInfo)

                    break
                end
            end
        end
    end
end