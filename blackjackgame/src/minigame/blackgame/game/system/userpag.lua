module(...,package.seeall)

local Local_GIsCreate = false
local CardObj = require("minigame.blackgame.game.card")

local Local_GameStateObj = require "minigame.blackgame.game.system.gamestate"

local Local_CardPosY = 200


-- function Instance(  )
--     if Local_GIsCreate == true then
-- 		return Local_UserPagObj
-- 	end
-- 	setmetatable(Local_UserPagObj, {__index = _M})
-- 	Local_GIsCreate = true
--     Local_UserPagObj.miCardPags = nil
--     Local_UserPagObj.miUserState = nil
--     Local_UserPagObj.miUserList = nil
--     Local_UserPagObj.miIsWin = false
-- 	return Local_UserPagObj
-- end

function Create(aiData)
    My_Lua_log(" file=[usernodepag] fun=[Create]; ")

    local selfObj = {}
    setmetatable( selfObj, {__index = _M} ) 

    selfObj.milUuid = aiData.lUuid
    selfObj.milSeatId = aiData.lSeatId
    selfObj.miCardPags = {}
    selfObj.miUserState = USER_STATE.WAITING
    selfObj.miIsWin = false
    
    selfObj:Init()

    return selfObj
end

function Init( selfObj )
    My_Lua_log(" file=[usernodepag] fun=[Init]; ")
    selfObj.miRoot = cc.Node:create()
    selfObj.miRoot:retain()
    
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

    local tCurIndex = #selfObj.miCardPags+1
    if tCurIndex >= 7 then
        My_Lua_log(" file=[usernodepag] fun=[AddCardNode]; 已经达到最大数量="..USER_CARD_MAX)
        return
    end

    local pCardPag = CardObj.Create(tCardValue)
    table.insert( selfObj.miCardPags,pCardPag )
    selfObj.miCardRoot:addChild(pCardPag:GetRootNode())

    selfObj:ResetCardPosition()

    selfObj:SetUserPoint()
end

function AddStartCard ( selfObj, vCardData )
    My_Lua_log(" file=[usernodepag] fun=[AddStartCard]; ")
    if vCardData == nil then
        return
    end

    for i=1,#vCardData do

        My_Lua_log(" file=[usernodepag] fun=[AddStartCard]; vCardData["..i.."]="..vCardData[i])
        selfObj:AddCardNode(vCardData[i])
    end
end

function AddRoundCard ( selfObj, vCardData )
    My_Lua_log(" file=[usernodepag] fun=[AddRoundCard]; ")

    if vCardData == nil then
        return
    end

    selfObj:AddCardNode(vCardData[i])
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
        selfObj.miCardPags[i]:GetRootNode():setPosition(cc.p(tPosX, Local_CardPosY))
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

    selfObj:SetUserState(USER_STATE.WAITING)
end

function GetCardsData( selfObj )
    local tCardsData = {}
    for i=1,#selfObj.miCardPags do
        table.insert( tCardsData, selfObj.miCardPags:GetCardIndex() )
    end
end

function SetUserPoint( selfObj )
    local tPoint = math.random( 1,21 )
    -- My_Lua_log(" file=[usernodepag] fun=[SetUserPoint]; point="..tPoint)
    selfObj.miUserPointText:setString(tPoint)
    selfObj.miUserPointText:setVisible(true)
end

-- 设置玩家游戏状态
function SetUserState( selfObj, aiStateType )
    selfObj.miUserState = aiStateType
end

function SetUserStatePlaying( selfObj )
    selfObj.miUserState = USER_STATE.PLAYING
end

function SetUserStateWaiting( selfObj )
    My_Lua_log(" file=[usernodepag] fun=[SetUserStateWaiting]; ")
    selfObj.miUserState = USER_STATE.WAITING
    selfObj:ClearCardsNode()
end

function GetUserState( selfObj )
    return selfObj.miUserState
end

function GetUserIsPlaying( selfObj )
    if selfObj.miUserState == USER_STATE.PLAYING then
        return true
    end
end

function GetUuid( selfObj )
    return selfObj.milUuid
end

function GetSeatId( selfObj )
    return selfObj.milSeatId
end

function GetCardCount( selfObj )
    if selfObj.miCardPags ~= nil then
        return #selfObj.miCardPags
    end
    
    return 0
end

function GetUserCardsIsMax( selfObj )

    My_Lua_log(" file=[userpag] fun=[GetIsCardMax]; ")
    if selfObj.miCardPags ~= nil and #selfObj.miCardPags >= USER_CARD_MAX then
        return true
    end
    return false
end

function Remove( selfObj )
    selfObj:ClearCardsNode()
    selfObj.miRoot:removeFromParent()
end