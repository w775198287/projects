-- @Author: zhangzg 
-- @Date: 2018-06-11 19:20:17 
-- @Last Modified by:   zhangzg 
-- @Last Modified time: 2018-06-11 19:20:17 


module(...,package.seeall)
local Local_UiBase = require "comm.uibase"
local Local_DeskBase = require "comm.gamedeskbase"
local Local_UserObj = require("minigame.blackgame.game.usernodepag")

local Local_UserMgr = require("minigame.blackgame.game.system.usermgr")

function Create(aiData)
    local selfObj = Local_UiBase.Create(aiData)
    local parents = {_M, Local_UiBase}
	setmetatable( selfObj ,{__index = function(t,k)
		return search(k,parents) end } )
    selfObj.miPagName = "blackgamemianpag"
    selfObj.miBlackGameMainObj = nil

    selfObj.miUsersPag = {}

    selfObj:Init()
    return selfObj
end

function Init(selfObj, aiData)
    My_Lua_log(" file=[blackgamemianpag] fun=[init];")
    
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

    selfObj:SystemStart()

    selfObj:CreateAllUsers()
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

function OnOpen( selfObj)
    My_Lua_log(" file=[blackgamemianpag] fun=[OnOpen];")
    Local_UiBase.OnClose(selfObj)

    local tVisibleSize = cc.Director:getInstance():getOpenGLView():getVisibleSize()
    My_Lua_log(" file=[blackgamemianpag] fun=[OnOpen]; tVisibleSize.width="..tVisibleSize.width.."  height="..tVisibleSize.height)
    -- selfObj.miBlackGameMainObj['root']:setPosition(cc.p(0, tVisibleSize.height / 2+500))


    local tBgSize = selfObj.miBlackGameMainObj['rootpanel']:getSize();
    My_Lua_log(" file=[blackgamemianpag] fun=[OnOpen]; rootpanel.width="..tBgSize.width.."  height="..tBgSize.height)
end

function OnAddButton( selfObj, node, eventType )
    My_Lua_log(" file=[blackgamemianpag] fun=[OnAddButton];")

    local tCardValue = nil

    for i=1,#selfObj.miUsersPag do
        tCardValue = math.random( 0,51 )
        My_Lua_log(" file=[blackgamemianpag] fun=[OnAddButton]; i="..i..":  "..tCardValue)
        selfObj.miUsersPag[i]:AddCardNode(tCardValue)
    end
    
    -- tCardValue = math.random( 0,51 )
    -- My_Lua_log(" file=[blackgamemianpag] fun=[OnAddButton]; tCardValue="..tCardValue)
    -- selfObj.miUsersPag[3]:AddCardNode(tCardValue)
end

function OnResetButton( selfObj, node, eventType )
    My_Lua_log(" file=[blackgamemianpag] fun=[OnResetButton];")
    
    for i=1,#selfObj.miUsersPag do
        selfObj.miUsersPag[i]:ClearCardsNode()
    end
end


function CreateAllUsers( selfObj )
    My_Lua_log(" file=[blackgamemianpag] fun=[CreateAllUsers]; ")

    local tUsersData = {}
    local tUserData1 = {
        uuid = 2,
        vPos = cc.p(200, 1700),
        vCardData = {0, 1},
    }
    table.insert( tUsersData,tUserData1 )

    local tUserData2 = {
        uuid = 3,
        vPos = cc.p(1242-200, 1700),
        vCardData = {13, 14},
    }
    table.insert( tUsersData,tUserData2 )
    

    local tUserData3 = {
        uuid = 1,
        vPos = cc.p(1242/2, 200),
        vCardData = {26, 27},
    }
    table.insert( tUsersData,tUserData3 )
    My_Lua_log(" file=[blackgamemianpag] fun=[CreateAllUsers]; count="..#tUsersData)

    for i=1,#tUsersData do
        selfObj:CreateUserNode(tUsersData[i])
    end
end


function CreateUserNode( selfObj,tData )
    My_Lua_log(" file=[blackgamemianpag] fun=[CreateUserNode]; ")
    if tData == nil or tData.uuid == nil or tData.vPos == nil or tData.vCardData == nil then
        return
    end

    local tUserNodePag = Local_UserObj.Create(tData.uuid)
    tUserNodePag:GetRootNode():setPosition(tData.vPos)
    selfObj.miBlackGameMainObj['bgimg']:addChild(tUserNodePag:GetRootNode())
    if tUserNodePag == nil then
        My_Lua_log(" file=[blackgamemianpag] fun=[CreateUserNode]; 0000")
        return
    end

    for i=1,#tData.vCardData do
        tUserNodePag:AddCardNode(tData.vCardData[i])
    end


    table.insert( selfObj.miUsersPag, tUserNodePag)
end

function SystemStart( selfObj )
    local function Update( aiDelTime )
        G_Fy:Run(aiDelTime)
    end


    cc.Director:getInstance():getScheduler():scheduleScriptFunc(OnRun, 0, false)
end