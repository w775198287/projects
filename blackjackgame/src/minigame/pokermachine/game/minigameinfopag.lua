--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


--region *.lua
--Date
--此文件由[BabeLua]插件自动生成



module(...,package.seeall)
local Local_UiBase = require "comm.uibase"

function Create(aiData)
    local selfObj = Local_UiBase.Create(aiData)
    local parents = {_M, Local_UiBase}
	setmetatable( selfObj ,{__index = function(t,k)
		return search(k,parents) end } )
    selfObj.miPagName = "minigameinfopag"
    selfObj.miPagObj = nil

    selfObj:Init()
    return selfObj
end

function GetRootNode(selfObj)
    return selfObj.miPagObj['root']
end

--创建初始化UI
function Init(selfObj)
    My_Lua_log(" file=[minigameinfopag] fun=[init];")
    local PromptNode = require(COCOSTUDIO_UI_MINIGAMEINFO)
    local callBackProvider = function ( path,node,funcName )
        --点击关闭
        if node:getName()=="closebutton" and funcName =="OnCloseButton" then  
            local function OnCloseButton1(  node,eventType )  
                selfObj:OnCloseButton( node )
            end  
            return OnCloseButton1
        end
    end  

    selfObj.miPagObj = PromptNode.create(callBackProvider)
    selfObj.miPagObj['root']:retain()
end

--点击关闭
function OnCloseButton( selfObj, node )
    My_Lua_log(" file=[minigameinfopag] fun=[onclosebutton];")
    local aiEvent = {}
    aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_CLOSE_PAG
    aiEvent.miPagName = "minigameinfopag"
    aiEvent.miData = {}
    G_Fy.EventMgr.Instance():NextDispatch(aiEvent)
end

--改变UI位置
function ChangePos(selfObj, aiWidth, aiHeight)
    selfObj.miPagObj['root']:setPosition(aiWidth, aiHeight)
end


--刷新数据
function OnOpen(selfObj)
    My_Lua_log(" file=[minigameinfopag] fun=[onopen];")

    --设置位置
    selfObj.miMoveTo = {beginPos={x=0,y=0}, endPos={x=0,y=0}}
    local tScrollViewSize = selfObj.miPagObj['ScrollView']:getSize()
    local tVisibleSize =cc.Director:getInstance():getOpenGLView():getVisibleSize()
    selfObj.miMoveTo.beginPos.x = tVisibleSize.width/2
    selfObj.miMoveTo.beginPos.y = tVisibleSize.height/2
    selfObj:ChangePos(selfObj.miMoveTo.beginPos.x, selfObj.miMoveTo.beginPos.y)

    selfObj.miMoveTo.endPos.x = -tVisibleSize.width/2
    selfObj.miMoveTo.endPos.y = tVisibleSize.height/2

    local tRunAction = cc.MoveTo:create(0.5, cc.p(selfObj.miMoveTo.endPos.x, selfObj.miMoveTo.endPos.y))

    selfObj.miPagObj['root']:runAction( tRunAction )

    Local_UiBase:OnOpen()
end

function OnClose(selfObj)
    Local_UiBase:OnClose()
    --移除
    selfObj.miPagObj['root']:removeFromParentAndCleanup()
    My_Lua_log(" file=[minigameinfopag] fun=[onclose]; remove   ok")
end

--真正的退出删除
function OnExit(selfObj)
    selfObj.miPagObj['root']:release()
    My_Lua_log(" file=[minigameinfopag] fun=[onexit];")
end

function OnUpdate(selfObj, aiDelTime)

end



--endregion
--endregion
