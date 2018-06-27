--------------------------------------------------------
--info:寮规�鐖剁被
--author:Daneil
--date:2014-4-18
--------------------------------------------------------
module(...,package.seeall)

function Create(aiData)
    local selfObj = {}
    setmetatable( selfObj, {__index = _M} )  

    selfObj.miPagName = "uibase"

    selfObj.miZOrder = 50

    --绑定桌数据对象
    selfObj.miGameDesk = aiData.miGameDesk
    selfObj.miEventMgr = selfObj.miGameDesk:GetEventMgr()
    selfObj.miUiMgr = selfObj.miGameDesk:GetUiMgr()
    selfObj.miGameRoom = selfObj.miGameDesk:GetGameRoom()
    selfObj.miRoomStateMgr = selfObj.miGameDesk:GetRoomStateMgr()

    --UI创建时间，用于内存报警时删除用
    selfObj.miPagQuitTime = nil --单位（秒）

    --最底层的back按钮
    selfObj.miBackButton = nil

    --动画节点位置类型
    selfObj.miActionType = {
        LEFT_TOP_TO_RIGHT = 1,   --左上角往右滑动
        LEFT_TOP_TO_BOTTOM = 2,   --左上角往下滑动
        LEFT_BOTTOM_TO_RIGHT = 3,   --左下角往右滑动
        LEFT_BOTTOM_TO_TOP = 4,   --左下角往上滑动
        RIGHT_TOP_TO_LEFT = 5,  --右上角往左滑动
        RIGHT_TOP_TO_BOTTOM = 6,  --右上角往下滑动
        RIGHT_BOTTOM_TO_LEFT = 7,  --右下角往左滑动
        RIGHT_BOTTOM_TO_TOP = 8,  --右下角往上滑动
        LEFT_MIDDLE_TO_RIGHT = 9,  --左中间往右滑动
        RIGHT_MIDDLE_TO_LEFT = 10,  --右中间往左滑动
        TOP_MIDDLE_TO_BOTTOM = 11,  --上中间往下滑动
        BOTTOM_MIDDLE_TO_TOP = 12,  --下中间往上滑动
    }

    return selfObj
end

function GetRootNode(selfObj)
    return selfObj.miPagObj['root']
end

--获得创建时间到现在时间戳
function GetExistTime(selfObj)
    if selfObj.miPagQuitTime ~= nil then
        return os.time() - selfObj.miPagQuitTime
    end
    return 0
end

function GetPagName(selfObj)
    return selfObj.miPagName
end

function IsCacheUi(selfObj)
    return true
end


function OnOpen(selfObj, aiData)
    selfObj.miPagQuitTime = nil
end

--只是做节点的脱离  相当于隐藏操作
function OnClose(selfObj)
    selfObj.miPagQuitTime = os.time() --单位（秒）
end

--真正的退出删除
function OnExit(selfObj)
    
end

function OnUpdate(selfObj, aiDelTime)
    
end

--适配分辨率 重新计算节点位置
function AdaptResolution(selfObj)

end

function RemoveBackButton(selfObj)

    if selfObj.miBackButton then
        My_Lua_log(" file=[uibase] fun=[DelBackButton];")

        selfObj.miBackButton:removeFromParentAndCleanup()
        selfObj.miBackButton = nil
    end
end

--底层按钮，分为是否有遮盖效果
function GetCreateBackButton(selfObj,isMask)
    My_Lua_log(" file=[uibase] fun=[GetCreateBackButton];")
    
    local tButtonFile = G_Fy.GamegLobal:GetThemeDefineConfigByArgs("COMMON_BACKIMAGE_BUTTON_NORMAL_IMAGE")
    if isMask == true then
        tButtonFile = G_Fy.GamegLobal:GetThemeDefineConfigByArgs("COMMON_BACKIMAGE_BUTTON_MASK_IMAGE")
    end

    selfObj.miBackButton = ccui.Button:create(tButtonFile,tButtonFile)
    selfObj.miBackButton:ignoreContentAdaptWithSize(false)
    selfObj.miBackButton:setSize({width = 1688,height = 2208,})
    selfObj.miBackButton:setScale(1000,1000)
    selfObj.miBackButton:setZOrder(-1)
    selfObj.miBackButton:setTouchEnabled(true)

    function OnBackCallback(node)
        selfObj:OnBackButton(node)
    end
    selfObj.miBackButton:addClickEventListener(OnBackCallback) 

    return selfObj.miBackButton
end

function OnBackButton( selfObj, node )
My_Lua_log(" file=[uibase] fun=[OnBackButton]; ]")

end

--公用的从上下左右滑出动画--

--根据 左上角，右上角，左下角，右下角，左边中间，右边中间，上边中间，下边中间  类型
--UI都是以左上角为起点
--selfObj.miActionType = {
--        LEFT_TOP_TO_RIGHT = 1,   --左上角往右滑动
--        LEFT_TOP_TO_BOTTOM = 2,   --左上角往下滑动
--        LEFT_BOTTOM_TO_RIGHT = 3,   --左下角往右滑动
--        LEFT_BOTTOM_TO_TOP = 4,   --左下角往上滑动
--        RIGHT_TOP_TO_LEFT = 5,  --右上角往左滑动
--        RIGHT_TOP_TO_BOTTOM = 6,  --右上角往下滑动
--        RIGHT_BOTTOM_TO_LEFT = 7,  --右下角往左滑动
--        RIGHT_BOTTOM_TO_TOP = 8,  --右下角往上滑动
--        LEFT_MIDDLE_TO_RIGHT = 9,  --左中间往右滑动
--        RIGHT_MIDDLE_TO_LEFT = 10,  --右中间往左滑动
--        TOP_MIDDLE_TO_BOTTOM = 11,  --上中间往下滑动
--        BOTTOM_MIDDLE_TO_TOP = 12,  --下中间往上滑动
--    }
--参数：动作节点, 位置类型(决定移动方向), 移动距离, 时间, 是否反方向移动(用于滑动出来，滑动回去), 回调
function MoveActionByPositionType(selfObj, aiTarget, aiType, aiMoveDistance, aiTime, aiReverse,aiCallback)
    
    if aiTarget == nil then
        return
    end

    local tVisibleSize =cc.Director:getInstance():getOpenGLView():getVisibleSize()

    local tPlatform = G_Fy.GamegLobal:GetPhonePlatform()
    local designSize = DesignResolutionSizeList[tPlatform]
    local theightOff = 0.5 * tVisibleSize.height
    if tVisibleSize.width > designSize.width then
        tVisibleSize.width = designSize.width
    end
    
    local tBeginPosition = {}
    tBeginPosition.x = 0
    tBeginPosition.y = 0
    local tEndPosition = {}
    tEndPosition.x = 0
    tEndPosition.y = 0

    --左上角往右滑动
    if aiType == selfObj.miActionType.LEFT_TOP_TO_RIGHT then
        tBeginPosition.x = -tVisibleSize.width/2 - aiMoveDistance
        tBeginPosition.y = tVisibleSize.height/2 + theightOff

        tEndPosition.x = -tVisibleSize.width/2
        tEndPosition.y = tVisibleSize.height/2 + theightOff
    --左上角往下滑动
    elseif aiType == selfObj.miActionType.LEFT_TOP_TO_BOTTOM then
        tBeginPosition.x = -tVisibleSize.width/2
        tBeginPosition.y = tVisibleSize.height/2 + aiMoveDistance + theightOff

        tEndPosition.x = -tVisibleSize.width/2
        tEndPosition.y = tVisibleSize.height/2 + theightOff

    --左下角往右滑动
    elseif aiType == selfObj.miActionType.LEFT_BOTTOM_TO_RIGHT then
        tBeginPosition.x = -tVisibleSize.width/2 - aiMoveDistance
        tBeginPosition.y = -tVisibleSize.height/2 + theightOff

        tEndPosition.x = -tVisibleSize.width/2
        tEndPosition.y = -tVisibleSize.height/2 + theightOff
    --左下角往上滑动
    elseif aiType == selfObj.miActionType.LEFT_BOTTOM_TO_TOP then
        tBeginPosition.x = -tVisibleSize.width/2
        tBeginPosition.y = -tVisibleSize.height/2 - aiMoveDistance + theightOff

        tEndPosition.x = -tVisibleSize.width/2
        tEndPosition.y = -tVisibleSize.height/2 + theightOff

    --右上角往左滑动 
    elseif aiType == selfObj.miActionType.RIGHT_TOP_TO_LEFT then
        tBeginPosition.x = tVisibleSize.width/2
        tBeginPosition.y = tVisibleSize.height/2 + theightOff

        tEndPosition.x = tVisibleSize.width/2 - aiMoveDistance
        tEndPosition.y = tVisibleSize.height/2 + theightOff
    --右上角往下滑动 
    elseif aiType == selfObj.miActionType.RIGHT_TOP_TO_BOTTOM then
        tBeginPosition.x = tVisibleSize.width/2
        tBeginPosition.y = tVisibleSize.height/2 + aiMoveDistance + theightOff

        tEndPosition.x = tVisibleSize.width/2
        tEndPosition.y = tVisibleSize.height/2 + theightOff

    --右下角往左滑动
    elseif aiType == selfObj.miActionType.RIGHT_BOTTOM_TO_LEFT then
        tBeginPosition.x = tVisibleSize.width/2
        tBeginPosition.y = -tVisibleSize.height/2 + theightOff

        tEndPosition.x = tVisibleSize.width/2 - aiMoveDistance
        tEndPosition.y = -tVisibleSize.height/2 + theightOff
    --右下角往上滑动
    elseif aiType == selfObj.miActionType.RIGHT_BOTTOM_TO_TOP then
        tBeginPosition.x = tVisibleSize.width/2
        tBeginPosition.y = -tVisibleSize.height/2 - aiMoveDistance + theightOff

        tEndPosition.x = tVisibleSize.width/2
        tEndPosition.y = -tVisibleSize.height/2 + theightOff


    --左边中间往右滑动
    elseif aiType == selfObj.miActionType.LEFT_MIDDLE_TO_RIGHT then
        tBeginPosition.x = -tVisibleSize.width/2 - aiMoveDistance
        tBeginPosition.y = 0 + theightOff

        tEndPosition.x = -tVisibleSize.width/2
        tEndPosition.y = 0 + theightOff
    --右边中间往左滑动
    elseif aiType == selfObj.miActionType.RIGHT_MIDDLE_TO_LEFT then
        tBeginPosition.x = tVisibleSize.width/2 + aiMoveDistance
        tBeginPosition.y = 0 + theightOff

        tEndPosition.x = tVisibleSize.width/2
        tEndPosition.y = 0 + theightOff
    --上边中间往下滑动
    elseif aiType == selfObj.miActionType.TOP_MIDDLE_TO_BOTTOM then
        tBeginPosition.x = 0
        tBeginPosition.y = tVisibleSize.height/2 + aiMoveDistance + theightOff

        tEndPosition.x = 0
        tEndPosition.y = tVisibleSize.height/2 + theightOff
    --下中间往上滑动
    elseif aiType == selfObj.miActionType.BOTTOM_MIDDLE_TO_TOP then
        tBeginPosition.x = 0
        tBeginPosition.y = -tVisibleSize.height/2 + theightOff

        tEndPosition.x = 0
        tEndPosition.y = -tVisibleSize.height/2 + aiMoveDistance + theightOff
    else
        My_Lua_log(" file=[uibase] fun=[RunactionByPositionType]; error type")
        return
    end
    
    My_Lua_log(" file=[uibase] fun=[RunactionByPositionType]; tBeginPosition.x="..tBeginPosition.x)
    My_Lua_log(" file=[uibase] fun=[RunactionByPositionType]; tBeginPosition.y="..tBeginPosition.y)
    My_Lua_log(" file=[uibase] fun=[RunactionByPositionType]; tEndPosition.x="..tEndPosition.x)
    My_Lua_log(" file=[uibase] fun=[RunactionByPositionType]; tEndPosition.y="..tEndPosition.y)

    local tAction = nil            
    if aiReverse == true then
        aiTarget:setPosition(tEndPosition)
        local tMoveAction = cc.MoveTo:create(aiTime, tBeginPosition)
        tAction = tMoveAction
        if aiCallback ~= nil then        
            tAction = cc.Sequence:create(tMoveAction,cc.DelayTime:create(0.02), cc.CallFunc:create(aiCallback))
        end
    else
        aiTarget:setPosition(tBeginPosition)
        local tMoveAction = cc.MoveTo:create(aiTime, tEndPosition)
        tAction = tMoveAction
        if aiCallback ~= nil then        
            tAction = cc.Sequence:create(tMoveAction,cc.DelayTime:create(0.02), cc.CallFunc:create(aiCallback))
        end
    end

    aiTarget:runAction(tAction)
end


--通过起始和终止点 滑动 (特殊的滑出位置，自己算好位置)
function MoveActionByPosition(selfObj, aiTarget, aiBeginPosition, aiEndPosition, aiTime, aiReverse, aiCallback)
    
    if aiTarget == nil then
        return
    end

    local tAction = nil            
    if aiReverse == true then
        aiTarget:setPosition(aiEndPosition)
        local tMoveAction = cc.MoveTo:create(aiTime, aiBeginPosition)
        tAction = tMoveAction
        if aiCallback ~= nil then        
            tAction = cc.Sequence:create(tMoveAction,cc.DelayTime:create(0.02), cc.CallFunc:create(aiCallback))
        end
    else
        aiTarget:setPosition(aiBeginPosition)
        local tMoveAction = cc.MoveTo:create(aiTime, aiEndPosition)
        tAction = tMoveAction
        if aiCallback ~= nil then        
            tAction = cc.Sequence:create(tMoveAction,cc.DelayTime:create(0.02), cc.CallFunc:create(aiCallback))
        end
    end

    aiTarget:runAction(tAction)
end
