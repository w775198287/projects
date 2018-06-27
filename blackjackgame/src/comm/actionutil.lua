module(...,package.seeall)

function Create()
    local selfObj ={}
    setmetatable( selfObj, { __index = _M } )

    return selfObj
end

--固定从屏幕中间上方 牌飞行并且旋转动画
--参数：
--aiNode 父节点
--aiToPos 目的地的世界坐标
--aiTime 时间
--aiCallback 回调
function CardFlyAction(selfObj, aiNode, aiScale, aiToPos, aiTime, aiCallback)
    My_Lua_log(" file=[actionutil] fun=[CardFlyAction];")
    
    if aiNode == nil or aiScale == nil or aiToPos == nil or aiTime == nil then
        return
    end

    local tVisibleSize = cc.Director:getInstance():getOpenGLView():getVisibleSize()
    local tFromPos = cc.p(0,tVisibleSize.height/2)
    local tToPos = aiNode:convertToNodeSpace(aiToPos)

    local tCardBackPath = G_Fy.GamegLobal:GetThemeDefineConfigByArgs("USER_STATE_IMAGE", "POKER_BACK_ICON")
    local tSprite = cc.Sprite:create(tCardBackPath)
    tSprite:setScale(aiScale)
    aiNode:addChild(tSprite)

    tSprite:setPosition(tFromPos)
    
    local function removeCallback()
        tSprite:removeFromParent()
        
        if aiCallback ~= nil then
            aiCallback()
        end
    end
    
    local tAction = cc.Spawn:create(cc.RotateBy:create(aiTime,360),cc.MoveTo:create(aiTime, tToPos))
    tSprite:runAction(cc.Sequence:create(tAction, cc.DelayTime:create(0.05), cc.CallFunc:create(removeCallback)))
end

--翻牌动画，
--参数：
--aiNode 父节点
--aiPos 父节点上的位置(节点坐标)
--aiDelayTime 延时翻牌时间
--aiOrbitTime 翻牌时间
--aiValue 牌面值
--aiScale 缩放比例
--aiCallback 回调
function FlipCardAction(selfObj, aiNode, aiPos, aiDelayTime, aiOrbitTime, aiValue, aiScale, aiCallback)

    if aiNode == nil or aiValue == nil or aiDelayTime == nil or aiOrbitTime == nil then
        return
    end
    if aiScale == nil then
        aiScale = 1.0
    end

    --牌背面
    local tPokerBack = selfObj:CreatePokerCardSprite(false)
    --牌正面 
    local tPokerFront = selfObj:CreatePokerCardSprite(true,aiValue)
    tPokerFront:setVisible(false)

    tPokerFront:setScale(aiScale)
    tPokerBack:setScale(aiScale)

    aiNode:addChild(tPokerFront)
    aiNode:addChild(tPokerBack)

    tPokerBack:setPosition(aiPos)
    tPokerFront:setPosition(aiPos)

    local tOrbitFront = cc.OrbitCamera:create(aiOrbitTime, 1, 0, 90, -90, 0 , 0)
    local tOrbitBack = cc.OrbitCamera:create(aiOrbitTime, 1, 0, 0, -90, 0 , 0)

    local function myCallback()
        if aiCallback ~= nil then
            aiCallback()
        end
    end

    tPokerBack:runAction( cc.Sequence:create(cc.DelayTime:create(aiDelayTime), cc.Show:create(), tOrbitBack, cc.Hide:create(), cc.TargetedAction:create( tPokerFront, cc.Sequence:create(cc.Show:create(), tOrbitFront, cc.CallFunc:create(myCallback))) ) )
end

--创建牌 是否牌面(FALSE 背面) 牌的面值
function CreatePokerCardSprite(selfObj,aiIsFront,aiCardNum)
    
    local tPokerCard = nil
    if aiIsFront and aiCardNum and aiIsFront == true then
        local tCardPath = G_Fy.miPofcFy.PofcGameGlobal:GetCardPath()        
        tPokerCard = cc.Sprite:create(string.format(tCardPath, aiCardNum))
    else
        local tImageIcon = G_Fy.GamegLobal:GetThemeDefineConfigByArgs("USER_STATE_IMAGE", "POKER_BACK_ICON")
        tPokerCard = cc.Sprite:create(tImageIcon)
    end

    return tPokerCard
end

--根据plist创建动画
function CreateAnimate(selfObj,tPlist,tPng,tImageName,tImageNum,tAnimTime,tAnimLoops)
    
    if tPlist == nil or tPng == nil or tImageName == nil or tImageNum == nil or tAnimTime == nil then    
        return nil
    end

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