module(...,package.seeall)

local CardObj = require("minigame.blackgame.game.card")

local Local_CardNum_Max = 9
local Local_CardPosY_Self = 200
local Local_CardPosY_Other = 200

local Local_User_State = {
    WAITING = 1,    --等等状态
    PLAYING = 2,    --游戏状态
}

function Create(aiData)
    My_Lua_log(" file=[usernodepag] fun=[Create]; ")

    local selfObj = {}
    setmetatable( selfObj, {__index = _M} ) 

    selfObj.miUserId = aiData
    selfObj.miCardPags = {}

    selfObj.miUserState = Local_User_State.WAITING

    selfObj.miPosY = Local_CardPosY_Self
    if selfObj.miUserId ~= 1 then
        selfObj.miPosY = Local_CardPosY_Other
    end
    
    selfObj:Init()

    return selfObj
end

function Init( selfObj )
    My_Lua_log(" file=[usernodepag] fun=[Init]; ")
    selfObj.miRoot = cc.Node:create()

    selfObj.miHeadImg = ccui.ImageView:create()
    selfObj.miHeadImg:loadTexture("im_head.png",0)
    selfObj.miHeadImg:setPosition(0.0000, 0.0000)
    selfObj.miRoot:addChild(selfObj.miHeadImg)

    selfObj.miUserPointText = cc.LabelTTF:create(10, "Arial", 60)
    selfObj.miUserPointText:setColor(cc.c3b(255,255,255)) 
    selfObj.miUserPointText:setAnchorPoint(cc.p(0.5, 1))

    local tHeadImgSize = selfObj.miHeadImg:getContentSize()
    selfObj.miUserPointText:setPosition(cc.p(tHeadImgSize.width / 2, -10))
    selfObj.miHeadImg:addChild(selfObj.miUserPointText)

    selfObj.miCardRoot = cc.Node:create()
    selfObj.miRoot:addChild(selfObj.miCardRoot)

end

function GetRootNode(selfObj)
    return selfObj.miRoot
end

function AddCardNode( selfObj, tCardValue )
    My_Lua_log(" file=[usernodepag] fun=[AddCardNode]; tCardValue="..tCardValue)

    selfObj:SetUserState(Local_User_State.PLAYING)

    local tCurIndex = #selfObj.miCardPags+1
    if tCurIndex > Local_CardNum_Max then
        My_Lua_log(" file=[usernodepag] fun=[AddCardNode]; 已经达到最大数量="..Local_CardNum_Max)
        return
    end

    local pCardPag = CardObj.Create(tCardValue)
    table.insert( selfObj.miCardPags,pCardPag )
    selfObj.miCardRoot:addChild(pCardPag:GetRootNode())

    selfObj:ResetCardPosition()

    selfObj:SetUserPoint()
end

function ResetCardPosition( selfObj )
    -- 扑克间距
    local d = 40
    -- 扑克总数
    local n = #selfObj.miCardPags
    -- 最低位到最高位的间距
    local l = d*(n-1)
    -- 最低位相坐标
    local min = -l/2


    for i=1,n do
        local tPosX = min + (i-1)*d
        My_Lua_log(" file=[usernodepag] fun=[ResetCardPosition]; tPosX="..tPosX)
        selfObj.miCardPags[i]:GetRootNode():setPosition(cc.p(tPosX, selfObj.miPosY))
    end
end

function ClearCardsNode( selfObj )
    My_Lua_log(" file=[usernodepag] fun=[ClearCardsNode]; ")
    for i=1,#selfObj.miCardPags do
        selfObj.miCardPags[i]:GetRootNode():removeFromParent()
    end

    selfObj.miCardPags = {}

    selfObj.miUserPointText:setString(0)
    selfObj.miUserPointText:setVisible(false)

    selfObj:SetUserState(Local_User_State.WAITING)
end

function GetCardsData( selfObj )
    local tCardsData = {}
    for i=1,#selfObj.miCardPags do
        table.insert( tCardsData, selfObj.miCardPags:GetCardIndex() )
    end
end

function SetUserPoint( selfObj )
    local tPoint = math.random( 1,21 )
    selfObj.miUserPointText:setString(tPoint)
    selfObj.miUserPointText:setVisible(true)
end

-- 设置玩家游戏状态
function SetUserState( selfObj, aiStateType )
    selfObj.miUserState = aiStateType
end