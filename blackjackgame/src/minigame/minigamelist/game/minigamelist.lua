
module(...,package.seeall)
local Local_UiBase = require "comm.uibase"

function Create(aiData)
    local selfObj = Local_UiBase.Create(aiData)
    local parents = {_M, Local_UiBase}
    setmetatable( selfObj ,{__index = function(t,k)
        return search(k,parents) end } )
    selfObj.miPagName = "minigamelist"
    selfObj.miPagObj = nil
    selfObj.miZOrder = 201
    
    selfObj:Init()
    selfObj:InitGameList()
    return selfObj
end

--创建初始化UI
function Init(selfObj)
    My_Lua_log(" file=[minigamelist] fun=[init];")

    local PromptNode = nil
    if G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPHONE_4 then
        PromptNode = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MINIGAMELISTSCENE_I4"))
    elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPHONE_6S then
        PromptNode = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MINIGAMELISTSCENE"))
    elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.SUMSUNG_S8 then
        PromptNode = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MINIGAMELISTSCENE_S8"))
    elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPAD then
        PromptNode = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MINIGAMELISTSCENE_IPAD"))
    end

    local callBackProvider = function ( path,node,funcName )
        --点击退出
        if  node:getName()=="btntitleexit" and funcName =="onExitMiniGameButton" then
            local function OnExitMiniGame1(  node, eventType )
                selfObj:OnExitMiniGame( node, eventType )
            end
            return OnExitMiniGame1
        end
    end

    selfObj.miPagObj = PromptNode.create(callBackProvider)
    selfObj.miPagObj['root']:retain()

    selfObj.miPagObj['listview']:setScrollBarOpacity(0)
    selfObj.miPagObj['listview']:setSwallowTouches(false)

    selfObj.miPagObj['bg']:setVisible(false)
    
    selfObj.miPagObj['titlenametext']:setString(G_Fy.MiniGamegLobal:GetMiniConfig("MINI_TITLE_STR"))
end

function InitGameList(selfObj)
    My_Lua_log(" file=[minigamelist] fun=[InitGameList];")
    local tShowMiniList = {}
    table.insert(tShowMiniList, MI_GAME_LIST[1])
    local tMiniTypelist = selfObj.miGameDesk:GetMiniTypelist()
    for i = 1, #tMiniTypelist do
        table.insert(tShowMiniList, MI_GAME_LIST[tMiniTypelist[i]+1])
    end

    local viewSize = selfObj.miPagObj['listview']:getContentSize()
    local size = nil
    local listCount = #tShowMiniList 
    if listCount < 1 then
        return
    end

    local tUiMgr = selfObj.miGameDesk:GetUiMgr()

    for i = listCount, 1, -1 do
        if tShowMiniList[i].cellgame ~= "minigamelist" then
            local aiData = {}
            aiData.miGameDesk = selfObj.miGameDesk

            for k, v in pairs(tShowMiniList[i]) do
                aiData[k] = v
            end

            local tChildNod = nil
            if nil == aiData.cellnode then              -- cell  默认
                tChildNod = require(MI_LLIST_CELL_NODE_DEFAULT)
            else
                tChildNod = require(aiData.cellnode)    -- cell  自定义
            end
            tChildPag = tChildNod.Create(aiData)
            selfObj.miPagObj['listview']:pushBackCustomItem(tChildPag:GetRootNode())
        end
    end
end

-- 退出小游戏模块
function OnExitMiniGame(selfObj, node, eventType )
    My_Lua_log(" file=[minigamelist] fun=[OnExitMiniGame]; ")

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

function OnCloseButton(selfObj, node, eventType )
    local aiEventPag = {}
    aiEventPag.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_CLOSE_PAG
    aiEventPag.miPagName = "minigamelist"
    aiEventPag.miData = {}
    selfObj.miEventMgr:Dispatch(aiEventPag)
end

function IsCacheUi(selfObj)
    return false
end

function GetRootNode(selfObj)
    return selfObj.miPagObj['root']
end

--刷新数据
function OnOpen(selfObj, miData)

end

function OnClose(selfObj)
    Local_UiBase:OnClose()
    --移除
    My_Lua_log(" file=[minigamelist] fun=[onclose]; remove   ok")
    selfObj.miPagObj['root']:removeFromParentAndCleanup()
end

--真正的退出删除
function OnExit(selfObj)
    My_Lua_log(" file=[minigamelist] fun=[onexit];")
    selfObj.miPagObj['root']:release()
end

function OnUpdate(selfObj, aiDelTime)
    
end


--endregion
