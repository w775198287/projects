--region NewFile_1.lua
--Author : chgq1023
--Date   : 2017/6/13
--此文件由[BabeLua]插件自动生成


module(...,package.seeall)

--
--aiData
--aiData.miNode
--aiData.miGameDesk
--

local Local_UiBase = require "comm.uibase"
function Create(aiData)
    local selfObj = {}
    setmetatable( selfObj, {__index = _M} ) 

    selfObj.miMainFrameObj = nil
    selfObj.miChoosedesknpagList={}
    selfObj:Init(aiData)
	return selfObj
end

function GetRootNode(selfObj)
    return selfObj.miMainFrameObj['root']
end

function Init(selfObj, aiData)
    My_Lua_log(" file=[gamedeskmain] fun=[Init]; ")
    local MainFrame = require("uilua.hallscene.multideskscene")
    local callBackProvider = function ( path,node,funcName )
        if  node:getName()=="pagedeskview" and funcName =="OnPageDeskViewEvent" then
            local function OnPageDeskViewEvent1(  node,eventType )  
                selfObj:OnPageDeskViewEvent( node, eventType )
            end  
            return OnPageDeskViewEvent1
        end
        if  node:getName()=="listdeskhandcardview" and funcName =="OnListDeskHandCardView" then
            local function OnListDeskHandCardView1(  node,eventType )  
                selfObj:OnListDeskHandCardView( node,eventType )
            end  
            return OnListDeskHandCardView1
        end
    end  
    selfObj.miMainFrameObj = MainFrame.create(callBackProvider)
    --根据分辨率调整ui尺寸
    local tPlatform = G_Fy.GamegLobal:GetPhonePlatform()
    local designSize = DesignResolutionSizeList[tPlatform]
    local tListViewSize = selfObj.miMainFrameObj['listdeskhandcardview']:getSize()
    selfObj.miMainFrameObj['listdeskhandcardview']:setSize(designSize.width, tListViewSize.height)
    selfObj.miMainFrameObj['listdeskhandcardview']:setInnerContainerSize(cc.size(designSize.width, tListViewSize.height))
    local tSize =cc.Director:getInstance():getOpenGLView():getVisibleSize()
    selfObj.miMainFrameObj['pagedeskview']:setSize(tSize.width, tSize.height)
    ccui.Helper:doLayout(selfObj.miMainFrameObj['root'])
    --
    
    --local tSize =cc.Director:getInstance():getOpenGLView():getVisibleSize()
    local tDesignByHeight = G_Fy.GamegLobal:IsDesignSizeByHeight()
    if tDesignByHeight == true then
        local tWidthOff = 0.5 * (tSize.width - designSize.width)
        My_Lua_log(" file=[gamedeskmain] fun=[OnSetduozuo]; tWidthOff="..tWidthOff)
        selfObj.miMainFrameObj['root']:setPosition({x=tWidthOff, y=0})
    elseif tDesignByHeight == false then
        local tHeightOff = 0.5 * (tSize.height - designSize.height)
        --My_Lua_log(" file=[gamedeskmain] fun=[OnSetduozuo]; tHeightOff="..tHeightOff)
        selfObj.miMainFrameObj['root']:setPosition({x=0, y=0})
    end

    selfObj.miMainFrameObj['listdeskhandcardview']:setVisible(false)
    aiData.miParentNode:addChild(selfObj.miMainFrameObj['root'])


    --添加一个“+”控件
    local adddesknode = require("uilua.hallscene.adddesknode")
    local callBackProvider1 = function ( path,node,funcName )
        if  node:getName()=="addbutton" and funcName =="OnAddButton" then
            local function OnAddButton1(  node,eventType )
                selfObj:OnAddButton( node, eventType )
            end
            return OnAddButton1
        end
        if  node:getName()=="backimage" and funcName =="OnBackTouch" then
            local function OnBackTouch1(  node,eventType )
                selfObj:OnBackTouch( node, eventType )
            end
            return OnBackTouch1
        end
    end
    local adddeskpag = adddesknode.create(callBackProvider1)
    selfObj.miMainFrameObj['listdeskhandcardview']:insertCustomItem(adddeskpag['root'], 0)
    --
    selfObj.miMainFrameObj['listdeskhandcardview']:setVisible(false)
    selfObj.miEventMgr = G_Fy:GetFyEvent()

    selfObj.miEventMgr:AddListen( SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_ADD_DESK_MSG, OnAddDeskEvent, 5, selfObj)
    selfObj.miEventMgr:AddListen( SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_DEL_DESK_MSG, OnDelDeskEvent, 5, selfObj)
end


function OnPageDeskViewEvent(selfObj, node, eventType )

end

function OnListDeskHandCardView(selfObj, node,eventType )
end
----------------------------------------------------
function OnAddDeskEvent(selfObj, aiEvent)
    local tChildrenCount = selfObj.miMainFrameObj["pagedeskview"]:getChildrenCount()
    My_Lua_log(" file=[multideskscenepag] fun=[OnAddDeskEvent]; tChildrenCount="..tChildrenCount)
    -- if tChildrenCount >= 1 then
    --     selfObj.miMainFrameObj['listdeskhandcardview']:setVisible(true)

    --     local aiEventPag1 = {}
    --     aiEventPag1.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_DESK_SCALE_MSG
    --     aiEventPag1.miData = {}
    --     aiEventPag1.miData.miScale = 0.92
    --     G_Fy:SendEventToAllGameDesk(aiEventPag1)

    -- else
    --     --selfObj.miMainFrameObj['listdeskhandcardview']:setVisible(false)
    --     selfObj.miMainFrameObj['listdeskhandcardview']:setVisible(true)

    --     local aiEventPag1 = {}
    --     aiEventPag1.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_DESK_SCALE_MSG
    --     aiEventPag1.miData = {}
    --     aiEventPag1.miData.miScale = 1
    --     G_Fy:SendEventToAllGameDesk(aiEventPag1)

    -- end

    local choosedesknode = require("uilua.hallscene.choosedesknode")
    local callBackProvider = function ( path,node,funcName )
        if  node:getName()=="backimage" and funcName =="OnBackTouch" then
            local function OnBackTouch1(  node,eventType )
                selfObj:OnBackTouch( node, eventType )
            end
            return OnBackTouch1
        end
    end


    local tTablePages = selfObj.miMainFrameObj["pagedeskview"]:getPages()
    for i = 1, #tTablePages do
        local tPageNod = tTablePages[i]
        local tGameDesk = tPageNod.userdata
        tGameDesk.miChildrenCount = i
    end

    local choosedesknpag = choosedesknode.create(callBackProvider)


    selfObj.miMainFrameObj['listdeskhandcardview']:insertCustomItem(choosedesknpag['root'], 0)

    My_Lua_log(" file=[gamedeskmain] fun=[OnAddDeskEvent]; tChildrenCount="..tChildrenCount)
    selfObj.miMainFrameObj["pagedeskview"]:insertPage(aiEvent.miData.miMainFrameNode,0)


    aiEvent.miData.miGameDesk.miChildrenCount = tChildrenCount
    aiEvent.miData.miMainFrameNode.userdata = aiEvent.miData.miGameDesk

    selfObj.miChoosedesknpagList[tChildrenCount] = choosedesknpag


    local tChildrenCount = selfObj.miMainFrameObj["pagedeskview"]:getChildrenCount()
    My_Lua_log(" file=[gamedeskmain] fun=[OnAddDeskEvent]; tChildrenCount111111="..tChildrenCount)


    selfObj.miMainFrameObj["pagedeskview"]:setCurPageIndex(0)
end

function OnDelDeskEvent(selfObj, aiEvent)
    local tDelIndext = aiEvent.miData.miGameDesk.miChildrenCount
    local tChildrenCount = selfObj.miMainFrameObj["pagedeskview"]:getChildrenCount()
    My_Lua_log(" file=[multideskscenepag] fun=[OnDelDeskEvent]; tChildrenCount="..tChildrenCount .. "  tDelIndext="..tDelIndext)
    --local tChildrenCount = selfObj.miMainFrameObj["pagedeskview"]:getChildrenCount()
    -- if tChildrenCount > 1 then
    --     --selfObj.miMainFrameObj['pagedeskview']:setVisible(true)
    -- else
    --     --selfObj.miMainFrameObj['pagedeskview']:setVisible(false)

    --     selfObj.miMainFrameObj['listdeskhandcardview']:setVisible(false)

    --     local aiEventPag1 = {}
    --     aiEventPag1.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_NOTIFY_DESK_SCALE_MSG
    --     aiEventPag1.miData = {}
    --     aiEventPag1.miData.miScale = 1
    --     G_Fy:SendEventToAllGameDesk(aiEventPag1)

    -- end
    local tChildrenCount = selfObj.miMainFrameObj["pagedeskview"]:getChildrenCount()
    local tChildrenCount = selfObj.miMainFrameObj["pagedeskview"]:getChildrenCount()
    My_Lua_log(" file=[multideskscenepag] fun=[OnDelDeskEvent]; tChildrenCount="..tChildrenCount)
    if tChildrenCount < 0 and tDelIndext < tChildrenCount then
        return
    end
    --tChildrenCount = tChildrenCount - 1

    selfObj.miMainFrameObj['listdeskhandcardview']:removeItem(tDelIndext)
    selfObj.miMainFrameObj["pagedeskview"]:removePageAtIndex(tDelIndext)
    selfObj.miChoosedesknpagList[tChildrenCount] = nil

    local tChildrenCount = selfObj.miMainFrameObj["pagedeskview"]:getChildrenCount()
    My_Lua_log(" file=[multideskscenepag] fun=[OnDelDeskEvent]; tChildrenCount="..tChildrenCount)

    local tTablePages = selfObj.miMainFrameObj["pagedeskview"]:getPages()
    for i = 1, #tTablePages do
        local tPageNod = tTablePages[i]
        local tGameDesk = tPageNod.userdata
        tGameDesk.miChildrenCount = i-1
    end

    selfObj.miMainFrameObj["pagedeskview"]:setCurPageIndex(0)
end

function OnAddButton(selfObj, node, eventType )
    My_Lua_log(" file=[multideskscenepag] fun=[OnAddButton]; ")
end

function OnBackTouch(selfObj, node, eventType )
    My_Lua_log(" file=[multideskscenepag] fun=[OnAddButton]; ")
end

----------------------------------------------------

--endregion
