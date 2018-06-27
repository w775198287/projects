
module(...,package.seeall)
local Local_Flip_Time = 0.3

local Local_Card_Size = cc.size(57*2, 78*2)

local Local_Card_Bg = "card/card_bg.png"
local Local_Card_Type = {
    "card/cardtype_fang.png",
    "card/cardtype_mei.png",
    "card/cardtype_hong.png",
    "card/cardtype_hei.png",
}
local Local_Card_Value = "card/cardvalue_%d.png"
local Local_Card_Black = "card/poker_back_1.png"
local Local_Card_Root = "yellow.png"


local Local_Value_Png = false  --控制扑克牌value采用label或者图片


--通知消息
local Local_Type_Color ={
    cc.c3b(255, 0, 0),--方块
    cc.c3b(0, 0, 0),--梅花
    cc.c3b(255, 0, 0),--红桃
    cc.c3b(0, 0, 0), --黑桃
}

function Create(aiData)
    local selfObj = {}
    setmetatable( selfObj, {__index = _M} ) 

    --数据
    selfObj.bSelected = false
    selfObj.miCardId = aiData
    
    selfObj:Init()

    selfObj:ShowCardVisible(true)
    -- selfObj:ShowCardVisible(false)
    -- selfObj:PlayFlipAction()

    return selfObj
end

function Init( selfObj )
    
    -- 扑克牌数据
    selfObj:SetCardData(selfObj.miCardId)

    -- 根节点
    selfObj.root = cc.Node:create()
    -- selfObj.root:loadTexture(Local_Card_Root,0)
    -- selfObj.root:setContentSize(Local_Card_Size)
    -- selfObj.root:setColor(cc.c3b(0, 0, 0))


    local tRootSize = selfObj.root:getContentSize()
    selfObj.miCenterPos = cc.p(tRootSize.width / 2, tRootSize.height / 2)
    -- selfObj.root:setScale(2)
    -- 背面
    selfObj:CreateBackImg()
    -- 正面
    selfObj:CreatePKImg()
    -- 高亮圈
    selfObj:CreateHightImg()
end

-- 背面
function CreateBackImg( selfObj )
    selfObj.miCardBack = ccui.ImageView:create()
    selfObj.miCardBack:loadTexture(Local_Card_Black,0)
    selfObj.miCardBack:setContentSize(Local_Card_Size)
    selfObj.root:addChild(selfObj.miCardBack)
end

-- 正面
function CreatePKImg( selfObj )
    
    selfObj.miCardBg = ccui.ImageView:create()
    selfObj.miCardBg:loadTexture(Local_Card_Bg,0)
    selfObj.miCardBg:setContentSize(Local_Card_Size)
    selfObj.miCardBg:setPosition(selfObj.miCenterPos)

    local tPosY = selfObj.miCardBg:getContentSize().height - 10
    if Local_Value_Png then
        selfObj.miCardValueNode = cc.Sprite:create(string.format(Local_Card_Value, selfObj.lValue))
        selfObj.miCardValueNode:setAnchorPoint(cc.p(0, 1))
        selfObj.miCardValueNode:setPosition(cc.p(10, tPosY))
    else
        selfObj.miCardValueNode = cc.LabelTTF:create(selfObj.lValue, "Arial", 42)
        selfObj.miCardValueNode:setColor(Local_Type_Color[selfObj.miCardColor]) 
        selfObj.miCardValueNode:setAnchorPoint(cc.p(0, 1))
        selfObj.miCardValueNode:setPosition(cc.p(15, tPosY))
    end
    selfObj.miCardBg:addChild(selfObj.miCardValueNode)

    print(" selfObj.miCardColor = "..selfObj.miCardColor)
    tPosY = selfObj.miCardBg:getContentSize().height / 2
    selfObj.miCardTypeNode = ccui.ImageView:create()
    selfObj.miCardTypeNode:loadTexture(Local_Card_Type[selfObj.miCardColor],0)
    selfObj.miCardTypeNode:setAnchorPoint(cc.p(0, 0.5))
    selfObj.miCardTypeNode:setPosition(cc.p(20, tPosY))
    selfObj.miCardBg:addChild(selfObj.miCardTypeNode)

    selfObj.root:addChild(selfObj.miCardBg)

    selfObj.miCardBg:setVisible(false)
end

function CreateHightImg( selfObj )
    selfObj.miHighBright = ccui.ImageView:create()
    selfObj.miHighBright:loadTexture(Local_Card_Black,0)
    selfObj.miHighBright:setContentSize(Local_Card_Size)
    selfObj.root:addChild(selfObj.miHighBright)
    selfObj.miHighBright:setVisible(false)
end

function ShowCardVisible( selfObj, bShow )
    if bShow == true then
        selfObj.miCardBg:setVisible(true)
        selfObj.miCardBack:setVisible(false)
    else
        selfObj.miCardBg:setVisible(false)
        selfObj.miCardBack:setVisible(true)
    end
end

function GetRootNode(selfObj)
    return selfObj.root
end

--翻牌动画
function PlayFlipAction(selfObj)
    selfObj.miCardBg:setVisible(false)
    selfObj.miCardBack:stopAllActions()
    --反正
    local tOrbitFront1 = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 90, -90, 0 , 0)
    local tOrbitBack1 = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 0, -90, 0 , 0)
    local seq = cc.Sequence:create(cc.Show:create(), tOrbitBack1, cc.Hide:create(), cc.TargetedAction:create(selfObj.miCardBg, cc.Sequence:create(cc.Show:create(), tOrbitFront1)))
    selfObj.miCardBack:runAction(seq)
end

--闭牌动画
function PlayCloseAction(selfObj)
    selfObj.miCardBack:setVisible(false)
    selfObj.miCardBg:stopAllActions()
    --正反
    local tOrbitFront2 = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 90, -90, 0 , 0)
    local tOrbitBack2 = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 0, -90, 0 , 0)
    local seq = cc.Sequence:create(cc.Show:create(), tOrbitBack2, cc.Hide:create(), cc.TargetedAction:create(selfObj.miCardBack, cc.Sequence:create(cc.Show:create(), tOrbitFront2)))
    selfObj.miCardBg:runAction(seq)
end

function SetCardData( selfObj, lValue )
    if lValue < 0 or lValue > 51 then
        return 0
    end

    local tCardData = GetCardInfo(lValue)
    selfObj.miCardData = tCardData

    -- selfObj.lValue = lValue % 13

    selfObj.lValue = lValue % 13
    selfObj.miCardColor = tCardData.miCardColor

    if Local_Value_Png == false then
        selfObj.lValue = lValue % 13 + 1
        if selfObj.lValue == 1 then
            selfObj.lValue = "A"
        elseif selfObj.lValue == 11 then
            selfObj.lValue = "J"
        elseif selfObj.lValue == 12 then
            selfObj.lValue = "Q"
        elseif selfObj.lValue == 13 then
            selfObj.lValue = "K"
        end 
    end
end

function setCarValue(selfObj, lValue)
    if lValue >= 0 and lValue <= 51 then
        selfObj:SetCardData(lValue)

        if Local_Value_Png then
            selfObj.miCardValueNode:setTexture(string.format(Local_Card_Value, selfObj.lValue))
        else
            selfObj.miCardValueNode:setString(selfObj.lValue)
        end
        selfObj.miCardTypeNode:setTexture(Local_Card_Type[selfObj.miCardColor])
    end
end

-- 是否高亮
function setCardHighBrightShow(selfObj, bShow)
    --默认隐藏
    if nil == bShow and type(bShow) ~= "boolean" then
        return
    end

    selfObj.miHighBright:setVisible(bShow)
end

function GetCardIndex( selfObj )
    return selfObj.miCardId
end

--endregion
