module(...,package.seeall)

--每帧创建播放动画最大个数
local PLAYANIMATE_NUMS_EVERY_FRAME = 5

local LOCAL_GAMEITEM_OBJ = require "configdata.gameitemdata"

function Create()
    local selfObj ={}
    setmetatable( selfObj, { __index = _M } )

    --动画列表数据 这里传入的位置不能是坐标，只能是座位的相对位置(0-8)，
    --防止短时间内处理不过来，有人站起坐下会出错
    selfObj.miAnimationData = {}
--    selfObj.miAnimationData.miParentNode = nil
--    selfObj.miAnimationData.miFromUuid = nil
--    selfObj.miAnimationData.miToUuid = nil
--    selfObj.miAnimationData.miData = nil

    selfObj.miItemList = {}

    selfObj:OnInitItemList()

    --收费表情的配置数据
    selfObj.miItemDataObj = LOCAL_GAMEITEM_OBJ.Create()

    return selfObj
end

--后台切前台需要清空列表
function OnInitItemList(selfObj)
My_Lua_log(" file=[playanimationmgr] fun=[OnInitItemList];")
    for key, value in pairs(selfObj.miItemList) do
        if value.miIsComplete == true then

            for key,value in pairs(value.miSpriteTable) do
                if value ~= nil then
                    value:release()
                end
            end

            selfObj.miItemList[key] = nil
        else

            for key,value in pairs(value.miSpriteTable) do
                if value ~= nil then
                    value:removeFromParent()
                    value:release()
                end
            end

            selfObj.miItemList[key] = nil
        end
    end

    selfObj.miItemList = {}
end

function OnClearItemList(selfObj)
 
    for key, value in pairs(selfObj.miItemList) do
        if value.miIsComplete == true then
        My_Lua_log(" file=[playanimationmgr] fun=[OnClearItemList];")  
            for key,value in pairs(value.miSpriteTable) do
                if value ~= nil then
                --My_Lua_log(" file=[playanimationmgr] fun=[OnClearItemList]; release")  
                    value:release()
                end
            end

            selfObj.miItemList[key] = nil
        end
    end
end

--添加数据
function AddAnimateData(selfObj, aiData)
    
    table.insert(selfObj.miAnimationData, aiData)
end

--播放动画，传入数据
function PlayAnimation(selfObj, aiData)

--    父节点 初始地uuid 目标地uuid 数据data
--    aiData.miParentNode = nil
--    aiData.miFromUuid = nil
--    aiData.miToUuid = nil
--    aiData.miFromPos = nil
--    aiData.miToPos = nil
--    aiData.miData = nil
    if aiData == nil then
        My_Lua_log(" file=[playanimationmgr] fun=[PlayAnimation];  nil data")
        return
    end
    if aiData.miParentNode == nil then
        My_Lua_log(" file=[playanimationmgr] fun=[PlayAnimation];  aiData.miParentNode is nil")
        return
    end
    if aiData.miFromUuid == nil or aiData.miFromUuid < 1 then
        My_Lua_log(" file=[playanimationmgr] fun=[PlayAnimation];  aiData.miFromUuid is nil or error")
        return
    end
    if aiData.miToUuid == nil or aiData.miToUuid < 1 then
        My_Lua_log(" file=[playanimationmgr] fun=[PlayAnimation];  aiData.miToUuid is nil or error")
        return
    end
    if aiData.miData == nil then
        My_Lua_log(" file=[playanimationmgr] fun=[PlayAnimation];  aiData.miData is nil")
        return
    end

    --初始点，目标点位置,初始点是否坐下，目标点是否坐下(未坐下就不播动画)
    local tFromPos = aiData.miFromPos
    local tToPos = aiData.miToPos
    local tIsHaveFromPos = false
    local tIsHaveToPos = false

    local tCurGameRoomId = G_Fy.miGameDeskMgr:GetCurGameRoomId()
    local tGameDesk = G_Fy.miGameDeskMgr:GetGameDesk(tCurGameRoomId)
    local tGameRoom = tGameDesk:GetGameRoom()
    if tCurGameRoomId == nil or tCurGameRoomId < 1 or tGameDesk == nil or tGameRoom == nil then
        return
    end

    local tIsHaveFromPos = tGameRoom:GetStateStandby(aiData.miFromUuid)
    local tIsHaveToPos = tGameRoom:GetStateStandby(aiData.miToUuid)

    if tIsHaveFromPos == false or tIsHaveToPos == false then
        My_Lua_log(" file=[playanimationmgr] fun=[PlayAnimation];  tIsHaveFromPos or tIsHaveToPos is nil")
        return
    end
    if tFromPos == nil or tToPos == nil then
        My_Lua_log(" file=[playanimationmgr] fun=[PlayAnimation];  tFromPos or tToPos is nil")
        return
    end

    My_Lua_log(" file=[playanimationmgr] fun=[PlayAnimation];  tFromPos=["..tFromPos.x..","..tFromPos.y.."]")
    My_Lua_log(" file=[playanimationmgr] fun=[PlayAnimation];  tFromPos=["..tToPos.x..","..tToPos.y.."]")

    --动画数据
    local tValue = nil
    local tGameItemList = selfObj.miItemDataObj:GetData()
    for key, value in pairs(tGameItemList) do
        if value.idname == aiData.miData.sExtra then
            tValue = value
            break
        end
    end
    if tValue == nil then
        My_Lua_log(" file=[playanimationmgr] fun=[PlayAnimation];  error pos no have item")
        return
    end

    My_Lua_log(" file=[playanimationmgr] fun=[OnPlayItemAnimation];")
    --始发点节点
    local tFromSprite = nil
    if tValue.from ~= nil then
        tFromSprite = cc.Sprite:create(tValue.from)
        tFromSprite:retain()
        aiData.miParentNode:addChild(tFromSprite)
        tFromSprite:setPosition(tFromPos.x, tFromPos.y)
        tFromSprite:setScale(G_Android_Scale_Ratio)
    end
    
    --目标表情节点
    local tTargetSprite = nil
    if tValue.to ~= nil then
My_Lua_log(" file=[playanimationmgr] fun=[OnPlayItemAnimation]; 222222222222222")
        tTargetSprite = cc.Sprite:create(tValue.to)
        tTargetSprite:retain()
        aiData.miParentNode:addChild(tTargetSprite)
        tTargetSprite:setPosition(tToPos.x, tToPos.y)
        tTargetSprite:setVisible(false)

        tTargetSprite:setScale(G_Android_Scale_Ratio)
    end

    --飞行动画节点
    local tFlySprite = nil
    if tValue.fly ~= nil then
My_Lua_log(" file=[playanimationmgr] fun=[OnPlayItemAnimation]; 33333333333333")
        tFlySprite = cc.Sprite:create(tValue.fly)
        tFlySprite:retain()
        aiData.miParentNode:addChild(tFlySprite)
        tFlySprite:setPosition(tFromPos.x, tFromPos.y)
        tFlySprite:setVisible(false)

        tFlySprite:setScale(G_Android_Scale_Ratio)
    end

    --加入管理列表
    local tItemData = {}
    tItemData.miMsgId = aiData.miData.lMsgID
    tItemData.miIsComplete = false

    tItemData.miSpriteTable = {}
    table.insert(tItemData.miSpriteTable,tFromSprite)
    table.insert(tItemData.miSpriteTable,tTargetSprite)
    table.insert(tItemData.miSpriteTable,tFlySprite)
    
    selfObj.miItemList[tItemData.miMsgId] = tItemData
    --table.insert(selfObj.miItemList, tItemData)

    --动画结束回调
    function OnCallback()
        tItemData.miIsComplete = true

        for key,value in pairs(tItemData.miSpriteTable) do
            if value ~= nil then
                value:removeFromParentAndCleanup()
            end
        end
    end

    --初始点动画
    local tFromAnimate = selfObj:CreateItemAnimate(
        tValue.fromplist,
        tValue.fromplistpng,
        tValue.fromplistimage,
        tValue.frompnum,
        tValue.fromanimstimer,
        tValue.fromactiontimes)

    --直接飞到目的地，然后播动画
    if tValue.type == OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_TARGET then
        tFromSprite:runAction( cc.Sequence:create( cc.MoveTo:create(tValue.flytime, cc.p(tToPos.x, tToPos.y)), tFromAnimate, cc.CallFunc:create(OnCallback) ) )
    
    --鲨鱼
    elseif tValue.type == OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_ROTATE_TARGET_SEVERAL_ACTION then

        local tSelfPosX = tFromSprite:getPositionX()
        local tSelfPosY = tFromSprite:getPositionY()
        local tSelfPos = cc.p(tSelfPosX, tSelfPosY)
        local tAngle = 0
        if tToPos.x > tSelfPos.x then
            tFromSprite:setScaleX(1*G_Android_Scale_Ratio)
        else
            tFromSprite:setScaleX(-1*G_Android_Scale_Ratio)
        end

        local diff = cc.pSub( tSelfPos, cc.p(tToPos.x, tToPos.y));	
        diff = cc.pNormalize(diff); 
        local tRadians = cc.pGetAngle( cc.p(1, 0), diff )
        local tAngle = math.deg(tRadians)

        tFromSprite:setVisible(true)
        tTargetSprite:setVisible(true)
My_Lua_log(" file=[mainbasescenepag] fun=[OnPlayItemAnimation] selfPos =" .. tSelfPosX .."/".. tSelfPosY)
My_Lua_log(" file=[mainbasescenepag] fun=[OnPlayItemAnimation] ToPos =" .. tToPos.x .."/".. tToPos.y)
My_Lua_log(" file=[mainbasescenepag] fun=[OnPlayItemAnimation] angle = " .. tAngle)
        --飞行动作
        local tAnimateFly = selfObj:CreateItemAnimate(
        tValue.flyplist,
        tValue.flyplistpng,
        tValue.flyplistimage,
        tValue.flypnum,
        tValue.flyanimstimer,1)

        local tMoveAndAnimate = cc.Spawn:create(cc.RotateBy:create(0,-tAngle-90),tAnimateFly,cc.MoveTo:create(tValue.flytime, cc.p(tToPos.x, tToPos.y)))

        --目标的原始动作
        local tAnimateSecond = selfObj:CreateItemAnimate(
        tValue.toplist,
        tValue.toplistpng,
        tValue.toplistimage,
        tValue.topnum,
        tValue.toanimstimer,1)

        --目标的kill动作
        local tAnimateKill = selfObj:CreateItemAnimate(
        tValue.killplist,
        tValue.killplistpng,
        tValue.killplistimage,
        tValue.killpnum,
        tValue.killanimstimer,1)

        --播音效
        --如果有动画音效，播音效
        if tValue.itemvoice ~= nil then
            cc.SimpleAudioEngine:getInstance():playEffect(tValue.itemvoice)
        end

        tTargetSprite:runAction(cc.Sequence:create(
            tAnimateSecond, 
            cc.DelayTime:create(tValue.flytime),
            tAnimateKill,
            cc.CallFunc:create(OnCallback)))

        tFromSprite:runAction( cc.Sequence:create( 
            tFromAnimate,
            tMoveAndAnimate,
            cc.Hide:create()))

    --飞到目的地同时播动画，到达后再播动画
    elseif tValue.type == OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_FLY_TARGET then
        
        --判断是否变转方向
        local tSelfPosX = tFromSprite:getPositionX()
        local tSelfPosY = tFromSprite:getPositionY()
        local tSelfPos = cc.p(tSelfPosX, tSelfPosY)
        local tScaleX = 1*G_Android_Scale_Ratio
        if tToPos.x > tSelfPos.x then
            tScaleX = -1*G_Android_Scale_Ratio
        end
        if tValue.fromisturn == true then
            tFromSprite:setScaleX(tScaleX)
        end
        if tValue.toisturn == true then
            tTargetSprite:setScaleX(tScaleX)
        end
        

        --目标点动画
        local tTargetAnimate = selfObj:CreateItemAnimate(
            tValue.toplist,
            tValue.toplistpng,
            tValue.toplistimage,
            tValue.topnum,
            tValue.toanimstimer,
            tValue.toactiontimes)

        --初始点播放动画，移动
        local tFromAction = cc.Sequence:create( cc.Spawn:create(tFromAnimate,cc.MoveTo:create(tValue.fromtime, cc.p(tToPos.x, tToPos.y))),cc.Hide:create())
        tFromSprite:runAction(tFromAction)

        --目标节点播放动画
        local tTargetAction = cc.Sequence:create(cc.Hide:create(),cc.DelayTime:create(tValue.fromtime), cc.Show:create(),tTargetAnimate,cc.CallFunc:create(OnCallback))
        tTargetSprite:runAction(tTargetAction)

    --初始位置先播完一套动画，然后飞到目的地 期间一套播动画，到达后再播一套动画
    elseif tValue.type == OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_PLAY_FLY_TARGET then
        
        --判断是否变转方向
        local tSelfPosX = tFromSprite:getPositionX()
        local tSelfPosY = tFromSprite:getPositionY()
        local tSelfPos = cc.p(tSelfPosX, tSelfPosY)
        local tScaleX = -1*G_Android_Scale_Ratio
        if tToPos.x > tSelfPos.x then
            tScaleX = 1*G_Android_Scale_Ratio
        end
        if tValue.fromisturn == true then
            tFromSprite:setScaleX(tScaleX)
        end
        if tValue.flyisturn == true then
            tFlySprite:setScaleX(tScaleX)
        end
        if tValue.toisturn == true then
            tTargetSprite:setScaleX(tScaleX)
        end

        --飞行动画
        local tFlyAnimate = selfObj:CreateItemAnimate(
            tValue.flyplist,
            tValue.flyplistpng,
            tValue.flyplistimage,
            tValue.flypnum,
            tValue.flyanimstimer,
            tValue.flyactiontimes)
        --目标点动画
        local tTargetAnimate = selfObj:CreateItemAnimate(
            tValue.toplist,
            tValue.toplistpng,
            tValue.toplistimage,
            tValue.topnum,
            tValue.toanimstimer,
            tValue.toactiontimes)


        --初始点播放动画
        local tFromAction = cc.Sequence:create( tFromAnimate,cc.Hide:create())
        tFromSprite:runAction(tFromAction)

        --飞行节点播动画，移动
        local tFlyAction = cc.Sequence:create( cc.Hide:create(),cc.DelayTime:create(tValue.fromtime),cc.Show:create(),cc.Spawn:create(tFlyAnimate,cc.MoveTo:create(tValue.flytime, cc.p(tToPos.x, tToPos.y))),cc.Hide:create())
        tFlySprite:runAction(tFlyAction)

        --目标节点播放动画
        local tTargetAction = cc.Sequence:create(cc.Hide:create(),cc.DelayTime:create(tValue.fromtime+tValue.flytime), cc.Show:create(),tTargetAnimate,cc.CallFunc:create(OnCallback))
        tTargetSprite:runAction(tTargetAction)

    --初始位置先播一套动画，几帧之后，飞行位置播动画，同时目标位置播一套动画(机枪)
    elseif tValue.type == OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_PLAY_DELAY_FLY_TARGET then
        --判断是否变转方向
        local tSelfPosX = tFromSprite:getPositionX()
        local tSelfPosY = tFromSprite:getPositionY()
        local tSelfPos = cc.p(tSelfPosX, tSelfPosY)
        local tScaleX = 1*G_Android_Scale_Ratio
        if tToPos.x < tSelfPos.x then
            tScaleX = -1*G_Android_Scale_Ratio
        end
        if tValue.fromisturn == true then
            tFromSprite:setScaleX(tScaleX)
        end
        if tValue.flyisturn == true then
            tFlySprite:setScaleX(tScaleX)
        end
        if tValue.toisturn == true then
            tTargetSprite:setScaleX(tScaleX)
        end

        --播音效
        --如果有动画音效，播音效
        if tValue.itemvoice ~= nil then
            cc.SimpleAudioEngine:getInstance():playEffect(tValue.itemvoice)
        end

        if tValue.isflyturnangle == true then
            --子弹弹道设置位置，倾斜角度 和 拉伸等
            local diff = cc.pSub( tSelfPos, cc.p(tToPos.x, tToPos.y));	
            diff = cc.pNormalize(diff); 
            local tRadians = cc.pGetAngle( cc.p(1, 0), diff )
            local tAngle = math.deg(tRadians)
            tFlySprite:setRotation(180-tAngle)
            tFromSprite:setRotation(-tAngle)

            local tFlySpriteWidth = tFlySprite:getContentSize().width
            local tDistance = cc.pGetDistance(tSelfPos,tToPos)
            local tScale = tDistance/tFlySpriteWidth
            local tFlySpPos = cc.p( (tSelfPos.x+tToPos.x)/2,(tSelfPos.y+tToPos.y)/2)        
            tFlySprite:setPosition(tFlySpPos)
            tFlySprite:setScaleX(tScale*G_Android_Scale_Ratio)
        end

        --飞行动画
        local tFlyAnimate = selfObj:CreateItemAnimate(
            tValue.flyplist,
            tValue.flyplistpng,
            tValue.flyplistimage,
            tValue.flypnum,
            tValue.flyanimstimer,
            tValue.flyactiontimes)
        --目标点动画
        local tTargetAnimate = selfObj:CreateItemAnimate(
            tValue.toplist,
            tValue.toplistpng,
            tValue.toplistimage,
            tValue.topnum,
            tValue.toanimstimer,
            tValue.toactiontimes)


        --初始点播放动画
        local tFromAction = cc.Sequence:create( tFromAnimate,cc.Hide:create())
        tFromSprite:runAction(tFromAction)

        --飞行节点播动画
        local tFlyAction = nil
        --判断是否需要移动
        if tValue.isflymove == true then
            tFlyAction = cc.Sequence:create( 
                cc.Hide:create(),
                cc.DelayTime:create(tValue.flydelaytime),
                cc.Show:create(),
                cc.Spawn:create(tFlyAnimate,cc.MoveTo:create(tValue.flytime, tToPos)),
                cc.Hide:create())
        else
            tFlyAction = cc.Sequence:create( cc.Hide:create(),cc.DelayTime:create(tValue.flydelaytime),cc.Show:create(),tFlyAnimate,cc.Hide:create())
        end
        
        tFlySprite:runAction(tFlyAction)

        --目标节点播放动画
        local tTargetAction = cc.Sequence:create(cc.Hide:create(),cc.DelayTime:create(tValue.todelaytime), cc.Show:create(),tTargetAnimate,cc.Hide:create(),cc.CallFunc:create(OnCallback))
        tTargetSprite:runAction(tTargetAction)        

    --(钓鱼)初始位置A先播一套动画，几帧之后，中间出现线，线延长，到达B后，B开始播动画，然后线缩短，B移向A
    elseif tValue.type == OTHER_INFO_FACE_TYPE_ENUM.OTHER_INFO_FACE_TYPE_ENUM_PLAY_DELAY_FLY_TARGET_MOVE then
        
        --判断是否变转方向
        local tSelfPosX = tFromSprite:getPositionX()
        local tSelfPosY = tFromSprite:getPositionY()
        local tSelfPos = cc.p(tSelfPosX, tSelfPosY)
        local tScaleX = 1*G_Android_Scale_Ratio
        local tScaleY = 1*G_Android_Scale_Ratio
        if tToPos.x < tSelfPos.x then
            tScaleX = -1*G_Android_Scale_Ratio
        end
        if tToPos.y < tSelfPos.y then
            tScaleY = -1*G_Android_Scale_Ratio
        end
        if tValue.fromisturn == true then
            tFromSprite:setScaleX(tScaleX)
            tFromSprite:setScaleY(tScaleY)
        end
        if tValue.toisturn == true then
            tTargetSprite:setScaleX(tScaleX)
        end

        --根据位置不同计算偏移值
        local LOCAL_FISH_LINE_DELTA = 130
        local tLineDeltaY = 0  --鱼线甩出上偏移
        --计算鱼竿出点的偏移
        if tToPos.y >= tSelfPos.y then
            tLineDeltaY = LOCAL_FISH_LINE_DELTA
        else
            tLineDeltaY = -LOCAL_FISH_LINE_DELTA
        end

        --鱼线设置位置，倾斜角度 和 拉伸等
        tToPos = cc.p(tToPos.x, tToPos.y + 20)  --通过偏移重新计算目标点
        local diff = cc.pSub( cc.p(tSelfPos.x, tSelfPos.y+tLineDeltaY), cc.p(tToPos.x, tToPos.y))
        diff = cc.pNormalize(diff)
        local tRadians = cc.pGetAngle( cc.p(1, 0), diff )
        local tAngle = math.deg(tRadians)
        tFlySprite:setRotation(180-tAngle)
        tFlySprite:setAnchorPoint(cc.p(0,0.5))

        local tFlySpriteWidth = tFlySprite:getContentSize().width
        local tDistance = cc.pGetDistance(cc.p(tSelfPos.x, tSelfPos.y+tLineDeltaY),cc.p(tToPos.x,tToPos.y))
        local tScale = tDistance/tFlySpriteWidth
        tFlySprite:setPosition(cc.p(tFromPos.x, tFromPos.y+tLineDeltaY))
        tFlySprite:setScaleX(tScale)
        
        tFlySprite:setRotation(180-tAngle)
        tFlySprite:setVisible(false)
        tTargetSprite:setVisible(false)
        --初始点播放动画
        local tFromAction = cc.Sequence:create( tFromAnimate,cc.Hide:create())
        tFromSprite:runAction(tFromAction)

        --飞行节点播动画
        --飞行动画 鱼线需要先延伸，然后缩短
        local tFlyAction = cc.Sequence:create( 
            cc.Hide:create(), 
            cc.DelayTime:create(tValue.linedelayflytime),
            cc.Show:create(), 
            cc.ScaleTo:create(tValue.lineflytime,tScale,1),
            cc.Hide:create())
        tFlySprite:runAction(tFlyAction)

        --目标节点播放动画
        local tTargetAnimate = selfObj:CreateItemAnimate(
            tValue.toplist,
            tValue.toplistpng,
            tValue.toplistimage,
            tValue.topnum,
            tValue.toanimstimer,
            tValue.toactiontimes)
        --目标节点移动动画
        local tTargetMoveAnimate = selfObj:CreateItemAnimate(
            tValue.flyplist,
            tValue.flyplistpng,
            tValue.flyplistimage,
            tValue.flypnum,
            tValue.flyanimstimer,
            tValue.flyactiontimes)

        local tTargetAction = cc.Sequence:create(
            cc.Hide:create(),
            cc.DelayTime:create(tValue.lineflytime + tValue.linedelayflytime), 
            cc.Show:create(),
            tTargetAnimate,
            cc.Spawn:create(tTargetMoveAnimate,cc.MoveTo:create(tValue.flytime, tSelfPos)),
            cc.Hide:create(),
            cc.CallFunc:create(OnCallback))
        tTargetSprite:runAction(tTargetAction)
    end
end

--根据plist创建动画
function CreateItemAnimate(selfObj,tPlist,tPng,tImageName,tImageNum,tAnimTime,tAnimLoops)
    
    cc.SpriteFrameCache:getInstance():addSpriteFrames(tPlist, tPng)
    local tAnimation = cc.Animation:create()
    for i = 1, tImageNum do
        local tPng = string.format(tImageName, i)
        local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(tPng)
        tAnimation:addSpriteFrame(frame)
    end
    if tAnimLoops ~= nil then
        tAnimation:setLoops(tAnimLoops)
    end
    tAnimation:setDelayPerUnit(tAnimTime)
    local tAnimate = cc.Animate:create(tAnimation)

    return tAnimate
end

function Update(selfObj, aiDelTime)
    
    local tIndex = 0
    while tIndex < PLAYANIMATE_NUMS_EVERY_FRAME and #selfObj.miAnimationData > 0 do
        
        local tData = selfObj.miAnimationData[1]
        selfObj:PlayAnimation(tData)
        table.remove(selfObj.miAnimationData, 1)

        tIndex = tIndex + 1
    end

    selfObj:OnClearItemList()
end