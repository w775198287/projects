
module(...,package.seeall)
local Local_Flip_Time = 0.1

local Local_Card_Size = cc.size(57, 78)

local Local_Card_Bg = "minigame/poker/cardbg.png"
local Local_Card_Type = {
    "minigame/poker/cardtype_heitao.png",
    "minigame/poker/cardtype_hongtao.png",
    "minigame/poker/cardtype_meihua.png",
    "minigame/poker/cardtype_fangpian.png"
}
local Local_Card_Value = "minigame/poker/cardvalue_%d.png"

local Local_Value_Png = false  --控制扑克牌value采用label或者图片

function Create(aiData, data)
    local selfObj = {}
    setmetatable( selfObj, {__index = _M} ) 

    --数据
    selfObj.bSelected = false

    
    selfObj:Init();

    selfObj.root:setScale(2.0)

    return selfObj
end

function Init( selfObj )
    
    -- 扑克牌数据
    selfObj:SetCardData(data.value)

    -- 根节点
    selfObj.root = cc.Sprite:create()
    -- selfObj.root = cc.Node:create()
    -- 背面
    selfObj:CreateBackImg()
    -- 正面
    selfObj:CreatePKImg()
    -- 高亮圈
    selfObj:CreateHightImg()
end

-- 背面
function CreateBackImg( selfObj )
    selfObj.miCardBack = cc.Sprite:create(USER_STATE_IMAGE.POKER_BACK_ICON)
    selfObj.miCardBack:setContentSize(Local_Card_Size)
    selfObj.root:addChild(selfObj.miCardBack)
end

-- 正面
function CreatePKImg( selfObj )
    selfObj.miCardBg = cc.Sprite:create(Local_Card_Bg)
    -- selfObj.miCardBg:setScale(0.42)
    selfObj.miCardBg:setContentSize(Local_Card_Size)

    if Local_Value_Png then
        selfObj.miCardValueNode = cc.Sprite:create(string.format(Local_Card_Value, selfObj.lValue))
        selfObj.miCardValueNode:setAnchorPoint(cc.p(0, 0.5))
        selfObj.miCardValueNode:setPosition(cc.p(10, 185))
    else
        selfObj.miCardValueNode = cc.LabelTTF:create(selfObj.lValue, "Arial", 72)
        selfObj.miCardValueNode:setColor(cc.c3b(27, 122, 33)) 
        selfObj.miCardValueNode:setAnchorPoint(cc.p(0, 0.5))
        selfObj.miCardValueNode:setPosition(cc.p(27, 185))
    end
    selfObj.miCardBg:addChild(selfObj.miCardValueNode)

    selfObj.miCardTypeNode = cc.Sprite:create(Local_Card_Type[selfObj.miCardColor])
    selfObj.miCardTypeNode:setAnchorPoint(cc.p(0, 0.5))
    selfObj.miCardTypeNode:setPosition(cc.p(20, 91))
    selfObj.miCardBg:addChild(selfObj.miCardTypeNode)

    selfObj.root:addChild(selfObj.miCardBg)

    selfObj.miCardBg:setVisible(false)
end

function CreateHightImg( selfObj )
    selfObj.miHighBright = cc.Sprite:create(USER_STATE_IMAGE.POKER_BACK_ICON)    
    selfObj.root:addChild(selfObj.miHighBright)
    selfObj.miHighBright:setVisible(false)
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


--endregion
