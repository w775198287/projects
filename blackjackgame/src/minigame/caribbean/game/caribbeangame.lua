
module(...,package.seeall)
local Local_UiBase = require "comm.uibase"
local scheduler = cc.Director:getInstance():getScheduler()
local VisibleSize = cc.Director:getInstance():getVisibleSize()

local Jackpot_Num = 10
local Jackpot_Show_Width = 500
local Jackpot_Show_Height = 70
local Jackpot_Show_SpaceY = 65
local Jackpot_Move_Time = 2

local MI_CUIRBBEAN_STATE_BET = 2
local MI_CUIRBBEAN_STATE_SENDCARD = 3
local MI_CUIRBBEAN_STATE_REBET = 4
local MI_CUIRBBEAN_STATE_END = 5

local Local_Pubic_Poker1_Tag = 10001
local Local_Pubic_Poker2_Back_Tag = 10012

local Loacl_Public_Chip_Percent = 100

local Local_Flip_Time = 0.1

local Local_Action_SendCard_Chip = 101
local Local_Action_SendCard_ReChip = 102

local Local_Chip_Max = 100000

local Local_FlyCoin_Num = 80
local Local_MoveCoin_num = 30

local PosXArr_JackPot = {400, 370, 340,   290, 260, 230,   180, 150, 120,  70}
local Poker_Times = {1, 1, 2, 3, 4, 5, 7, 20, 50, 100}

local PosArr_Chip = {
    {55, 30}, {125, 30}, {195, 30}, {255, 30},
    {55, 80}, {125, 80}, {195, 80}, {255, 80},
    {55, 130}, {125, 130}, {195, 130},{255, 130},
    {55, 180}, {125, 180}, {195, 180}, {255, 180},
}

JACKPOT_MGR = {
    NORMAL = 1,    -- 下注
    PRESSED = 2,     -- 取消
    UNUSE = 3       -- 禁用
}

local Local_xEndPos = {-410, -205, 0, 205, 410}
local Local_yEndPos = {0, 0, 0, 0, 0}

function Create(aiData)

    local selfObj = Local_UiBase.Create(aiData)
    local parents = {_M, Local_UiBase}
	setmetatable( selfObj ,{__index = function(t,k)
		return search(k,parents) end } )
    selfObj.miPagName = "caribbeangame"
    selfObj.miCaribbeanObj = nil
    -- selfObj.miZOrder = 201

    
    selfObj:InitBaseData()
    selfObj:Init()
    selfObj:InitJackPot()

    return selfObj
end

--初始化动态数据
function InitBaseData(selfObj)
    
    selfObj.jackpot = 0                     --奖池数字
    selfObj.lPond = 0                       --jackpot消耗
    selfObj.lChip = 0                       --第一次下注额
    selfObj.bJackPot = 0                    --是否选jackpot
    selfObj.bLastJackpot = 0                --上局是否选jackpot
    selfObj.lReChip = 0                     --第二次下注额
    selfObj.bRaiseOrFold = false            --是否第二次下注
    selfObj.lCurCoin = 0                    --当前币
    selfObj.lPokerType = 9000               --自己牌型
    selfObj.lWinCoin = 0                    --赢取数量
    selfObj.lLastChip = 0                   --上局赢取
    selfObj.lLastSilderMark = 0             --下注拉杆记录
    selfObj.lMinBet = 0                     --最小下注额
    selfObj.lMaxBet = 100000                --最大下注额
    selfObj.lTotalPercent = 100             --拉杆总刻度
    selfObj.bDealTouched = false            --deal是否已点
    selfObj.gameState = MI_CUIRBBEAN_STATE_BET
    selfObj.bNewCardType = true             --新的发牌方式

    selfObj.myPkData = {}
    selfObj.bankerPkData = {}
    for pk = 1, 5 do
        selfObj.myPkData[pk] = {}
        selfObj.myPkData[pk].Action = {}

        selfObj.bankerPkData[pk] = {}
        selfObj.bankerPkData[pk].Action = {}

        selfObj.myPkData[pk].EndPos = {x = Local_xEndPos[pk], y = Local_yEndPos[pk]}
        selfObj.myPkData[pk].StartPos = {x = 0, y = 385}

        selfObj.bankerPkData[pk].EndPos = {x = Local_xEndPos[pk], y = Local_yEndPos[pk]}
        selfObj.bankerPkData[pk].StartPos = {x = 0, y = -320}
    end

    --翻牌动画列表
    selfObj.flipActionList = {}

    --闭牌动画列表
    selfObj.closeActionList = {}  

    --显示loading保护
    selfObj.IsLogging = false

    selfObj.loadingTime = {}
    selfObj.loadingTime.nowTime = nil
    selfObj.loadingTime.startTime = nil
    selfObj.loadingTime.endTime = nil
end

--创建初始化UI
function Init(selfObj)
    My_Lua_log(" file=[caribbeangame] fun=[init];")

    local PromptNode = nil
    if G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPHONE_4 then
        PromptNode = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MINIGAME_CARIBBEANSCENE_I4"))
    elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPHONE_6S then
        PromptNode = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MINIGAME_CARIBBEANSCENE")) 
    elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPAD then
        PromptNode = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MINIGAME_CARIBBEANSCENE_IPAD"))
    elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.SUMSUNG_S8 then
        PromptNode = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MINIGAME_CARIBBEANSCENE_S8"))
    end

    local callBackProvider = function ( path,node,funcName )
        --点击关闭
        if  node:getName()=="btnback" and funcName =="OnExitMiniGameButton" then
            local function OnBackCloseImage1(  node,eventType )
                 selfObj:OnCloseButton( node,eventType )
            end
            return OnBackCloseImage1
        end
        --点击帮助
        if  node:getName()=="btnhelp" and funcName =="OnHelpMiniGameButton" then
            local function OnHelpButton1(  node,eventType )
                selfObj:OnHelpButton( node,eventType )
            end
            return OnHelpButton1
        end
        --关闭帮助
        if  node:getName()=="helpnode" and funcName =="OnHideHelpNode" then
            local function OnHideHelpNode1(  node,eventType )
                selfObj:OnHideHelpNode( node, eventType )
            end
            return OnHideHelpNode1
        end
        if  node:getName()=="btnchip" and funcName =="OnChipMiniGameButton" then
            local function OnChipButton1(  node, eventType )
                selfObj:OnChipButton( node,eventType )
            end
            return OnChipButton1
        end
        --清空下注
        if node:getName() == "btnrebet" and funcName == "OnRebetMiniGameButton" then
            local function OnRebetButton1(  node,eventType )
                selfObj:OnRebetButton( node,eventType )
            end
            return OnRebetButton1
        end
        --deal游戏开始
        if node:getName() == "btndeal" and funcName == "OnDealButton" then
            local function OnDealButton1(  node,eventType )
                selfObj:OnDealButton( node,eventType )
            end
            return OnDealButton1
        end
        --弃牌
        if node:getName() == "btnfold" and funcName == "OnFoldButton" then
            local function OnFoldButton1(  node,eventType )
                selfObj:OnFoldButton( node,eventType )
            end
            return OnFoldButton1
        end
        --再次加注
        if node:getName() == "btnraise" and funcName == "OnRaiseButton" then
            local function OnRaiseButton1(  node,eventType )
                selfObj:OnRaiseButton( node,eventType )
            end
            return OnRaiseButton1
        end
        --游戏重构
        if node:getName() == "resetlayer" and funcName == "onResetGameButton" then
            local function OnReSetGameButton1(  node,eventType )
                selfObj:OnReSetGameButton( node,eventType )
            end
            return OnReSetGameButton1
        end
        --jackpot
        if node:getName() == "btnjackpot" and funcName == "OnJackPotButton" then
            local function OnJackPotButton1(  node,eventType )
                selfObj:OnJackPotButton( node,eventType )
            end
            return OnJackPotButton1
        end
        --点击扑克
        if string.find(node:getName(), "btnmypoker") and funcName == "OnMyPokerButton" then
            local function OnMyPokerButton1(  node,eventType )
                selfObj:OnMyPokerButton( node,eventType )
            end
            return OnMyPokerButton1
        end
    end

    selfObj.miCaribbeanObj = PromptNode.create(callBackProvider)
    selfObj.miCaribbeanObj['root']:retain()

    selfObj.miSsystemNotifyPag = nil
    -- selfObj.miCaribbeanObj['noticebg']:setVisible(false)

    local pUp = cc.Sprite:create("minigame/caribbean/common/up.png")
    pUp:setScale(G_Android_Scale_Ratio)
    pUp:setTag(100)
    pUp:setPosition(cc.p(110, 290))
    selfObj.miCaribbeanObj['btnchip']:addChild(pUp)
    pUp:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(110, 290)), cc.MoveTo:create(0.5, cc.p(110, 250)))))

    local pCoinSP = cc.Sprite:create("minigame/caribbean/common/icon.png")
    pCoinSP:setScale(G_Android_Scale_Ratio)
    local tSize = selfObj.miCaribbeanObj['labelscore']:getContentSize()
    pCoinSP:setPosition(cc.p(-37, tSize.height / 2))
    selfObj.miCaribbeanObj['labelscore']:addChild(pCoinSP)
    selfObj.miCaribbeanObj['iconimg']:setVisible(false)
    selfObj.miCaribbeanObj['noticebg']:setVisible(false)

    selfObj:setLanguageUI()

    selfObj.miEventMgr:AddListen( G_Fy.MiniGamegLobal:GetMiniConfig("MSG_MINI_CARIBBEAN_ENUM", "MSG_TYPE_ENUM_MINIGAME_CARIBBEAN_CSINI"), OnSubInitGameData, 5, selfObj)
    selfObj.miEventMgr:AddListen( G_Fy.MiniGamegLobal:GetMiniConfig("MSG_MINI_CARIBBEAN_ENUM", "MSG_TYPE_ENUM_MINIGAME_CARIBBEAN_CSREFRESHPOOL"), OnSubRefreshJackPot, 5, selfObj)
    selfObj.miEventMgr:AddListen( G_Fy.MiniGamegLobal:GetMiniConfig("MSG_MINI_CARIBBEAN_ENUM", "MSG_TYPE_ENUM_MINIGAME_CARIBBEAN_CSSTART"), OnSubGameStartRep, 5, selfObj)
    selfObj.miEventMgr:AddListen( G_Fy.MiniGamegLobal:GetMiniConfig("MSG_MINI_CARIBBEAN_ENUM", "MSG_TYPE_ENUM_MINIGAME_CARIBBEAN_CSCHECK"), OnSubGameCheckRep, 5, selfObj)

    selfObj.miEventMgr:AddListen( MSG_MINI_PUBLIC_ENUM.MSG_TYPE_ENUM_MINIGAME_REFRESH_COIN, OnSubRefreshUserCoin, 5, selfObj)
    selfObj.miEventMgr:AddListen( MSG_TYPE_ENUM.MSG_TYPE_ENUM_MINIGAME_TIMEOUT, OnSubResetGame, 5, selfObj)
    selfObj.miEventMgr:AddListen( MSG_TYPE_ENUM.MSG_TYPE_ENUM_MINIGAME_SEND_FAIL, OnSubMiniGameSendFail, 5, selfObj)
    selfObj.miEventMgr:AddListen( MSG_MINI_PUBLIC_ENUM.MSG_TYPE_ENUM_MINIGAME_EXIT, OnSubExitMiniGame, 5, selfObj)
    selfObj.miEventMgr:AddListen( MSG_TYPE_ENUM.MSG_TYPE_ENUM_MINIGAME_SEND_INIT, SendPacketOfInitGame, 5, selfObj)
end

function setLanguageUI(selfObj)
    -- 非中文变化bgimg
    -- if G_Fy.GamegLobal:GetCurrentLanguage() ~= LANGUAGE_TYPE.G_LANGUAGE_ENGLISH then
        -- local bgimgSize = selfObj.miCaribbeanObj['bgimg']:getContentSize() 
        -- if G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPHONE_4 then
        --     selfObj.miCaribbeanObj['bgimg']:loadTexture(G_Fy.MiniGamegLobal:GetMiniConfig("CARIBBEAN_BG_PNG_I4"))
        -- elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPHONE_6S then
        --     selfObj.miCaribbeanObj['bgimg']:loadTexture(G_Fy.MiniGamegLobal:GetMiniConfig("CARIBBEAN_BG_PNG"))
        -- elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPAD then
        --     selfObj.miCaribbeanObj['bgimg']:loadTexture(G_Fy.MiniGamegLobal:GetMiniConfig("CARIBBEAN_BG_PNG_IPAD"))
        -- elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.SUMSUNG_S8 then
        --     selfObj.miCaribbeanObj['bgimg']:loadTexture(G_Fy.MiniGamegLobal:GetMiniConfig("CARIBBEAN_BG_PNG_S8"))
        -- end
        -- selfObj.miCaribbeanObj['bgimg']:setContentSize(bgimgSize)
    -- end

    selfObj.miCaribbeanObj['anteimg']:loadTexture(G_Fy.MiniGamegLobal:GetMiniConfig("CARIBBEAN_BG_PNG_ANTE"))
    selfObj.miCaribbeanObj['betimg']:loadTexture(G_Fy.MiniGamegLobal:GetMiniConfig("CARIBBEAN_BG_PNG_BET"))


    selfObj.miCaribbeanObj['listimg']:loadTexture(G_Fy.MiniGamegLobal:GetMiniConfig("CARIBBEAN_LIST_PNG"))
    selfObj.miCaribbeanObj['helpinfoimg']:loadTexture(G_Fy.MiniGamegLobal:GetMiniConfig("CARIBBEAN_HELP_INFO_PNG"))

    selfObj.miCaribbeanObj['btnchip']:setTitleText(G_Fy.MiniGamegLobal:GetMiniConfig("STR_CARIBBEAN_BET"))
    selfObj.miCaribbeanObj['btnrebet']:setTitleText(G_Fy.MiniGamegLobal:GetMiniConfig("STR_CARIBBEAN_REBET"))
    selfObj.miCaribbeanObj['btndeal']:setTitleText(G_Fy.MiniGamegLobal:GetMiniConfig("STR_CARIBBEAN_DEAL"))
    selfObj.miCaribbeanObj['btnfold']:setTitleText(G_Fy.MiniGamegLobal:GetMiniConfig("STR_CARIBBEAN_FOLD"))
    selfObj.miCaribbeanObj['btnraise']:setTitleText(G_Fy.MiniGamegLobal:GetMiniConfig("STR_CARIBBEAN_RAISE"))

    local MaxChipSize = selfObj.miCaribbeanObj['btnmaxchip']:getContentSize()
    selfObj.miCaribbeanObj['btnmaxchip']:loadTextureNormal(G_Fy.MiniGamegLobal:GetMiniConfig("BTN_CHIP_SLIDER_PRESSED_PNG"),0)
    selfObj.miCaribbeanObj['btnmaxchip']:loadTexturePressed(G_Fy.MiniGamegLobal:GetMiniConfig("BTN_CHIP_SLIDER_PRESSED_PNG"),0)
    selfObj.miCaribbeanObj['btnmaxchip']:loadTextureDisabled(G_Fy.MiniGamegLobal:GetMiniConfig("BTN_CHIP_SLIDER_PRESSED_PNG"),0)
    selfObj.miCaribbeanObj['btnmaxchip']:setContentSize(MaxChipSize)

    local btnJackpotSize = selfObj.miCaribbeanObj['btnjackpot']:getContentSize()
    selfObj.miCaribbeanObj['btnjackpot']:loadTextureNormal(G_Fy.MiniGamegLobal:GetMiniConfig("BTN_JACKPOT_NORMAL_PNG"),0)
    selfObj.miCaribbeanObj['btnjackpot']:loadTexturePressed(G_Fy.MiniGamegLobal:GetMiniConfig("BTN_JACKPOT_PRESSED_PNG"),0)
    selfObj.miCaribbeanObj['btnjackpot']:loadTextureDisabled(G_Fy.MiniGamegLobal:GetMiniConfig("BTN_JACKPOT_NORMAL_PNG"),0)
    selfObj.miCaribbeanObj['btnjackpot']:setContentSize(btnJackpotSize)
end

-- jackpot
function InitJackPot(selfObj)
    My_Lua_log(" file=[caribbeangame] fun=[InitJackPot]; ")

    local pScrollViewAni = cc.Sprite:create(string.format(G_Fy.MiniGamegLobal:GetMiniConfig("CARIBBEAN_JACKPOT_ANI_PNG"), 1))
    pScrollViewAni:setScale(G_Android_Scale_Ratio)
    pScrollViewAni:setPosition(cc.p(475, 118.5))
    pScrollViewAni:setTag(100)
    selfObj.miCaribbeanObj['listimg']:addChild(pScrollViewAni)

    if G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPHONE_6S then
        pScrollViewAni:setPosition(cc.p(475, 118.5))
    elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPAD then
        pScrollViewAni:setPosition(cc.p(475, 114))
    elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.SUMSUNG_S8 then
        pScrollViewAni:setScaleY(2.3)
        pScrollViewAni:setPosition(cc.p(475, 134))
    end

    local pJackPotNode = cc.Node:create()
    pJackPotNode:setPosition(cc.p(650, 45))
    selfObj.miCaribbeanObj['listimg']:addChild(pJackPotNode)
    if G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.SUMSUNG_S8 then
        pJackPotNode:setPosition(cc.p(650, 65))
    end

    selfObj.pScrollView = cc.ScrollView:create()
    selfObj.pScrollView:setViewSize(cc.size(Jackpot_Show_Width, Jackpot_Show_Height))
    selfObj.pScrollView:setPosition(cc.p(-Jackpot_Show_Width / 2, Jackpot_Show_Height / 2))
    selfObj.pScrollView:setTouchEnabled(false)
    selfObj.pContainLayer = cc.Layer:create()
    selfObj.pContainLayer:setColor(cc.c3b(0, 0, 255))
    selfObj.pScrollView:setContainer(selfObj.pContainLayer)
    pJackPotNode:addChild(selfObj.pScrollView)

    local xPos = Jackpot_Show_Width / (Jackpot_Num + 1)

    for i = 1, Jackpot_Num do
        local pNode = cc.Node:create()
        for j = 1, 10 do
            local pLabel = cc.LabelTTF:create(tostring(j - 1), "Arial", 36)
            pLabel:setFontSize(60)
            pLabel:setColor(cc.c3b(0, 0, 0))
            local spaceY = pLabel:getContentSize().height + 10
            pLabel:setPosition(cc.p(0, 0 - Jackpot_Show_SpaceY * (j - 1)))
            pNode:addChild(pLabel)

            if j == 10 then
                local pLabel0 = cc.LabelTTF:create(tostring(0), "Arial", 36)
                pLabel0:setFontSize(60)
                pLabel0:setColor(cc.c3b(0, 0, 0))
                pLabel0:setPosition(cc.p(0, 0 - Jackpot_Show_SpaceY * (11 - 1)))
                pNode:addChild(pLabel0)
            end
        end
        pNode:setTag(100 + i) --Jackpot_Num + 1 - i)
        pNode:setPosition(cc.p(PosXArr_JackPot[i], Jackpot_Show_Height / 2))
        selfObj.pContainLayer:addChild(pNode)
        pNode:setVisible(false)

        if i % 3 == 0 then
            local pPoint = cc.LabelTTF:create(",", "Arial", 36)
            pPoint:setFontSize(60)
            pPoint:setColor(cc.c3b(0, 0, 0))
            pPoint:setPosition(cc.p(PosXArr_JackPot[i] - 25, 37))
            pPoint:setTag(1000 + i / 3)
            selfObj.pContainLayer:addChild(pPoint)
            pPoint:setVisible(false)
        end
    end
end

function OnSubExitMiniGame(selfObj, aiEvent)
    My_Lua_log("caribbean  OnSubExitMiniGame...")
    local aiEvent = {}
    aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_CLOSE_PAG
    aiEvent.miPagName = "caribbeangame"
    aiEvent.miData = {}
    selfObj.miEventMgr:NextDispatch(aiEvent)
end

function OnSubMiniGameSendFail(selfObj, aiEvent)
    My_Lua_log("file=[minigamescenepag] fun=[MiniGameSendFail]")


end

function OnSubResetGame( selfObj, aiEvent  )
    My_Lua_log(" file=[caribbeangame] fun=[OnSubResetGame]; ")

    selfObj:resetGameData()
end

-- 刷新德扑币
function OnSubRefreshUserCoin( selfObj, aiEvent )
    My_Lua_log(" file=[caribbeangame] fun=[OnSubRefreshUserCoin]; ")

    selfObj.lCurCoin = tonumber(aiEvent.miData.lCurCoin)
    selfObj:setOwnCoin()

    selfObj:setChipPercent()
end

-- 初始化游戏数据
function OnSubInitGameData(selfObj, aiEvent)
    My_Lua_log(" file=[caribbeangame] fun=[OnSubInitGameData]; ")
    
    selfObj.lCurCoin = aiEvent.miData.lCurCoin
    selfObj:setOwnCoin()

    selfObj.lMaxBet = 100000 --aiEvent.miData.lMaxBet
    selfObj.lMinBet = aiEvent.miData.lMinBet
    selfObj.lPond = aiEvent.miData.lPond

    selfObj:setJackpotType(JACKPOT_MGR.NORMAL)

    selfObj:setChipPercent()

    selfObj:OnSubRefreshJackPot(aiEvent)
    function OnCallBack()
        selfObj:SendPacketOfRefresh()
    end
    local seq = cc.Sequence:create(cc.DelayTime:create(10.0), cc.CallFunc:create(OnCallBack))
    selfObj.miCaribbeanObj['root']:runAction(cc.RepeatForever:create(seq))
end

-- 更新jackpot
function OnSubRefreshJackPot(selfObj, aiEvent)
    My_Lua_log(" file=[caribbeangame] fun=[OnSubRefreshJackPot]; ")

    if aiEvent.miData.lPool == selfObj.jackpot then
        return
    end

    if aiEvent.miData.lPool <=0 then
        aiEvent.miData.lPool = 0
    end

    local lastJackpot = selfObj.jackpot
    selfObj.jackpot = aiEvent.miData.lPool

    local perNumLast = 0
    local perNumNow = 0
    local perDividend = 10

    local nowJackpot = selfObj.jackpot
    local nCount = 0
    if nowJackpot == 0 then
        nCount = 1
    else
        while(nowJackpot > 0) do
            nowJackpot = math.floor( nowJackpot / 10 ) 
            nCount = nCount + 1
        end
    end

    if nCount <= 3 then
        selfObj.pContainLayer:getChildByTag(1001):setVisible(false)
        selfObj.pContainLayer:getChildByTag(1002):setVisible(false)
        selfObj.pContainLayer:getChildByTag(1003):setVisible(false)
    elseif nCount > 3 and nCount <= 6 then
        selfObj.pContainLayer:getChildByTag(1001):setVisible(true)
        selfObj.pContainLayer:getChildByTag(1002):setVisible(false)
        selfObj.pContainLayer:getChildByTag(1003):setVisible(false)
    elseif nCount > 6 and nCount <=9 then
        selfObj.pContainLayer:getChildByTag(1001):setVisible(true)
        selfObj.pContainLayer:getChildByTag(1002):setVisible(true)
        selfObj.pContainLayer:getChildByTag(1003):setVisible(false)
    else
        selfObj.pContainLayer:getChildByTag(1001):setVisible(true)
        selfObj.pContainLayer:getChildByTag(1002):setVisible(true)
        selfObj.pContainLayer:getChildByTag(1003):setVisible(true)
    end
    
    for i = 1, Jackpot_Num do
        local pNode = selfObj.pContainLayer:getChildByTag(100 + i)
        pNode:stopAllActions()
        if i > nCount then
            pNode:setVisible(false)
        else
            pNode:setVisible(true)
            perDividend = math.pow(10,  i-1)
            perNumLast = math.floor((lastJackpot / perDividend) % 10)
            perNumNow = math.floor((selfObj.jackpot / perDividend) % 10)

            -- if perNumLast ~= perNumNow then
                if perNumLast <= perNumNow then
                     pNode:runAction(cc.MoveTo:create(Jackpot_Move_Time, cc.p(pNode:getPositionX(), Jackpot_Show_Height / 2 + Jackpot_Show_SpaceY * (perNumNow))))
                else
                    local moveTime1 = (10 - perNumLast) / (10 - perNumLast + perNumNow) * Jackpot_Move_Time
                    local moveTime2 = perNumNow / (10 - perNumLast + perNumNow) * Jackpot_Move_Time
                    local move1 = cc.MoveTo:create(moveTime1, cc.p(pNode:getPositionX(), Jackpot_Show_Height / 2 + Jackpot_Show_SpaceY * 10))
                    local move2 = cc.MoveTo:create(moveTime2,cc.p(pNode:getPositionX(), Jackpot_Show_Height / 2 + Jackpot_Show_SpaceY * (perNumNow)))
                    pNode:runAction(cc.Sequence:create(move1, cc.CallFunc:create(function()
                            pNode:setPositionY(Jackpot_Show_Height / 2)
                    end), move2))
                end
            -- end
        end
    end

    if nil ~= aiEvent.miData.vInfos and #(aiEvent.miData.vInfos) > 0 then
        My_Lua_log("其他人中奖池。。。")
        selfObj:setNoticeStr(aiEvent.miData.vInfos)
    end
end

-- deal结果
function OnSubGameStartRep(selfObj, aiEvent)
    My_Lua_log(" file=[caribbeangame] fun=[OnSubGameStartRes]; ")

    if selfObj.gameState > MI_CUIRBBEAN_STATE_SENDCARD then
        return
    end
    selfObj.gameState = MI_CUIRBBEAN_STATE_SENDCARD

    --取消加载
    selfObj.IsLogging = false
    selfObj:CenterLoadingTime() 

    --翻牌动画列表
    selfObj.flipActionList = {}
    --闭牌动画列表
    selfObj.closeActionList = {}
    
    selfObj:setJackpotType(JACKPOT_MGR.UNUSE)
    -- selfObj.miCaribbeanObj['gameingnode']:setVisible(true)
    -- selfObj.miCaribbeanObj['chipmenunode']:setVisible(false)
    -- selfObj.miCaribbeanObj['btnfold']:setEnabled(true)
    -- selfObj.miCaribbeanObj['btnraise']:setEnabled(true)
    -- selfObj.lCurCoin = selfObj.lCurCoin - selfObj.lChip
    -- if selfObj.bJackPot == 1 then
    --     selfObj.lCurCoin = selfObj.lCurCoin - selfObj.lPond
    -- end
    selfObj.miCaribbeanObj["labelcurchip"]:setString(tostring(selfObj.lChip))
    -- selfObj:setOwnCoin()

    if aiEvent.miData.lCurCoin ~= selfObj.lCurCoin then
        My_Lua_log("native = "..selfObj.lCurCoin.."   sever = "..aiEvent.miData.lCurCoin)
        selfObj.lCurCoin = aiEvent.miData.lCurCoin
    end

    selfObj.bankerFisrtData = aiEvent.miData.iDealerCard
    selfObj.lPokerType = aiEvent.miData.ePlayerPattern

    for i = 1, 5 do
        local str = G_Fy.MiniGamegLobal:GetMiniConfig("STR_TEXT_POKER_FACECARD")
        selfObj.myPkData[i].PK:setTexture( string.format(str, aiEvent.miData.vPlayerCards[i]))
        selfObj.myPkData[i].value = aiEvent.miData.vPlayerCards[i]
    end
    local str = G_Fy.MiniGamegLobal:GetMiniConfig("STR_TEXT_POKER_FACECARD")
    selfObj.bankerPkData[5].PK:setTexture( string.format(str, aiEvent.miData.iDealerCard))
    selfObj.bankerPkData[5].value = aiEvent.miData.iDealerCard

    -- 是否高亮
    if aiEvent.miData.ePlayerPattern >= 9001 then
        selfObj:setCardHighBright(aiEvent.miData.vPlayerCards, aiEvent.miData.ePlayerPattern, true)
    end

    -- 发牌
    if selfObj.bNewCardType then
        selfObj:sendCardNew()
    else
        selfObj:SetFlipActionList(Local_Action_SendCard_Chip)
    end

    -- 延时播放牌型动画
    if aiEvent.miData.ePlayerPattern >= 9001 then
        cc.SimpleAudioEngine:getInstance():playEffect("audio/minigame/caribbean/apire_beyond.wav")
    end
    local myPokerType = selfObj.miCaribbeanObj["mytypenode"]:getChildByTag(100)
    local typeStr = G_Fy.MiniGamegLobal:GetMiniConfig("CARIBBEAN_POKER_TYPE_PNG")
    if nil == myPokerType then
    	myPokerType = cc.Sprite:create(string.format(typeStr, aiEvent.miData.ePlayerPattern))
        myPokerType:setScale(G_Android_Scale_Ratio)
        myPokerType:setTag(100)
        myPokerType:setPosition(cc.p(VisibleSize.width / 2 + myPokerType:getContentSize().width, 0))
        selfObj.miCaribbeanObj["mytypenode"]:addChild(myPokerType)
    else
        myPokerType:setTexture( string.format(typeStr, aiEvent.miData.ePlayerPattern))
        myPokerType:setPosition(cc.p(VisibleSize.width / 2 + myPokerType:getContentSize().width, 0))
    end
    local delaytime = 0.35
    if selfObj.bNewCardType then
        delaytime = 1.7
    end
    local function OnCallBackForSetGameBtnEnable()
        selfObj.miCaribbeanObj['gameingnode']:setVisible(true)
        selfObj.miCaribbeanObj['chipmenunode']:setVisible(false)
        selfObj.miCaribbeanObj['btnfold']:setEnabled(true)
        selfObj.miCaribbeanObj['btnraise']:setEnabled(true)
    end
    myPokerType:runAction(cc.Sequence:create(cc.DelayTime:create(delaytime), cc.CallFunc:create(OnCallBackForSetGameBtnEnable), cc.MoveTo:create(0.1, cc.p(-250, 0))))

    -- 奖池中奖： 自己
    if aiEvent.miData.iWinPool == 1 then
        -- 播放完中奖动画后，金币显示更新
        --My_Lua_log("中奖了。。。deal  = "..selfObj.lCurCoin.."  now = "..aiEvent.miData.lCurCoin.."   lWinCoin = "..aiEvent.miData.lWinCoin)
        selfObj:OnSubRefreshJackPot(aiEvent)

        selfObj:playPoolAni()

        local vInfos = {}
        local tInfo = {}
        local tUUid = selfObj.miGameRoom:GetUuid()
        tInfo.sNickName = selfObj.miGameRoom:GetNickNameByUuid(tUUid)
        tInfo.ePattern = aiEvent.miData.ePlayerPattern + 1
        tInfo.lWinCoin = aiEvent.miData.lWinCoin
        My_Lua_log("name = "..tInfo.sNickName.."  pattern="..tInfo.ePattern.."  lWinCoin="..tInfo.lWinCoin)
        table.insert(vInfos, tInfo)
        selfObj:setNoticeStr(vInfos)
    else
        selfObj:setOwnCoin()
    end
end

-- 二次下注结果
function OnSubGameCheckRep(selfObj, aiEvent)
    My_Lua_log(" file=[caribbeangame] fun=[OnSubGameCheckRep]; ")
    
    if selfObj.gameState == MI_CUIRBBEAN_STATE_END then
        return
    else
        selfObj.gameState = MI_CUIRBBEAN_STATE_END
    end

    --取消加载
    selfObj.IsLogging = false
    selfObj:CenterLoadingTime() 
    
    selfObj.miCaribbeanObj['btnfold']:setEnabled(false)
    selfObj.miCaribbeanObj['btnraise']:setEnabled(false)
    
    selfObj.lCurCoin = selfObj.lCurCoin - selfObj.lReChip
    selfObj:setOwnCoin()

    if selfObj.lReChip > 0 then
        selfObj:settleCoin(selfObj.lReChip, false)
        selfObj.miCaribbeanObj['rebetlabel']:setString(tostring(selfObj.lReChip))
    end
    
    selfObj.lCurCoin = aiEvent.miData.lCurCoin
    -- if aiEvent.miData.lPool ~= selfObj.jackpot then
    --     selfObj:OnSubRefreshJackPot(aiEvent)
    -- end
    
    for i = 1, 4 do
        local str = G_Fy.MiniGamegLobal:GetMiniConfig("STR_TEXT_POKER_FACECARD")
        selfObj.bankerPkData[i].PK:setTexture( string.format(str, aiEvent.miData.vDealerCards[i]))
        selfObj.bankerPkData[i].value = aiEvent.miData.vDealerCards[i]
    end

    -- 是否高亮
    if aiEvent.miData.eDealerPattern >= 9001 then
        table.insert(aiEvent.miData.vDealerCards, selfObj.bankerFisrtData)
        selfObj:setCardHighBright(aiEvent.miData.vDealerCards, aiEvent.miData.eDealerPattern,  false)
    end

    local pNode = cc.Node:create()
    selfObj.miCaribbeanObj['bgimg']:addChild(pNode)

    function OnCallFunc( )
        pNode:removeFromParentAndCleanup()

        if selfObj.bNewCardType then
            selfObj:setBankerCardShow()
        else
            selfObj:SetFlipActionList(Local_Action_SendCard_ReChip)
        end

        -- 延时播放牌型动画
        if aiEvent.miData.eDealerPattern >= 9001 then
            cc.SimpleAudioEngine:getInstance():playEffect("audio/minigame/caribbean/apire_beyond.wav")
        end

        local bankerPokerType = selfObj.miCaribbeanObj['othertypenode']:getChildByTag(100)
        local typeStr = G_Fy.MiniGamegLobal:GetMiniConfig("CARIBBEAN_POKER_TYPE_PNG")
        if nil == bankerPokerType then
            bankerPokerType = cc.Sprite:create(string.format(typeStr, aiEvent.miData.eDealerPattern))
            bankerPokerType:setScale(G_Android_Scale_Ratio)
            bankerPokerType:setTag(100)
            bankerPokerType:setPosition(cc.p(-VisibleSize.width / 2 - bankerPokerType:getContentSize().width, 0))
            selfObj.miCaribbeanObj['othertypenode']:addChild(bankerPokerType)
        else
            bankerPokerType:setTexture( string.format(typeStr, aiEvent.miData.eDealerPattern))
            bankerPokerType:setPosition(cc.p(-VisibleSize.width / 2 - bankerPokerType:getContentSize().width, 0))
        end
            
        function delayForSettle()
            selfObj:settleGame(aiEvent)
        end
        bankerPokerType:runAction(cc.Sequence:create(cc.DelayTime:create(0.35), cc.MoveTo:create(0.1, cc.p(250, 0)), cc.DelayTime:create(0.1), cc.CallFunc:create(delayForSettle)))
    end

    local seq = cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(OnCallFunc))
    pNode:runAction(seq)
end

-- 游戏数据初始化
function SendPacketOfInitGame(selfObj)
    My_Lua_log(" file=[caribbeangame] fun=[SendPacketOfInitGame] 发送协议;")

    --发送协议
    require("proto.TexasPokerCaribbeanStud_pb")
    local tPacke = TexasPokerCaribbeanStud_pb.CSCaribbeanStudIni()
    tPacke.uuid = selfObj.miGameRoom:GetUuid()
    local tBuff = tPacke:SerializeToString()
    cc.CClientPlatform:sharedClientPlatform():SendHttpMiniGamePacket(TexasPokerCmd_pb.Cmd_CSCaribbeanStudIni, tBuff, #tBuff, MINIGAME_CARIBBEAN_TYPE)
end

-- 开始游戏
function SendHttpStartGame(selfObj)
    My_Lua_log(" file=[caribbeangame] fun=[SendHttpStartGame] 发送协议;")

    --发送协议
    require("proto.TexasPokerCaribbeanStud_pb")
    local tPacke = TexasPokerCaribbeanStud_pb.CSCaribbeanStudStart()
    tPacke.uuid = selfObj.miGameRoom:GetUuid()
    tPacke.lChip = selfObj.lChip
    tPacke.iBet = selfObj.bJackPot
    local tBuff = tPacke:SerializeToString()
    cc.CClientPlatform:sharedClientPlatform():SendHttpMiniGamePacket(TexasPokerCmd_pb.Cmd_CSCaribbeanStudStart, tBuff, #tBuff, MINIGAME_CARIBBEAN_TYPE)
end

-- 刷新奖池
function SendPacketOfRefresh(selfObj)
    -- My_Lua_log(" file=[caribbeangame] fun=[SendPacketOfRefresh] 发送协议;")

    --发送协议
    require("proto.TexasPokerCaribbeanStud_pb")
    local tPacke = TexasPokerCaribbeanStud_pb.CSCaribbeanStudRefresh()
    tPacke.uuid = selfObj.miGameRoom:GetUuid()
    local tBuff = tPacke:SerializeToString()
    cc.CClientPlatform:sharedClientPlatform():SendHttpMiniGamePacket(TexasPokerCmd_pb.Cmd_CSCaribbeanStudRefresh, tBuff, #tBuff, MINIGAME_CARIBBEAN_TYPE)
end

-- 第二次下注
function SendPacketOfReBet(selfObj, isReChip)
    My_Lua_log(" file=[caribbeangame] fun=[SendPacketOfReBet] 发送协议;")

    --发送协议
    require("proto.TexasPokerCaribbeanStud_pb")
    local tPacke = TexasPokerCaribbeanStud_pb.CSCaribbeanStudCheck()
    tPacke.uuid = selfObj.miGameRoom:GetUuid()
    if isReChip == 0 then
        tPacke.eAction = TexasPokerCaribbeanStud_pb.ACTION_FOLD
    else
        tPacke.eAction = TexasPokerCaribbeanStud_pb.ACTION_RAISE
    end
    local tBuff = tPacke:SerializeToString()
    cc.CClientPlatform:sharedClientPlatform():SendHttpMiniGamePacket(TexasPokerCmd_pb.Cmd_CSCaribbeanStudCheck, tBuff, #tBuff, MINIGAME_CARIBBEAN_TYPE)
end

function resetGameData(selfObj)
    My_Lua_log(" file=[caribbeangame]  fun=[resetGameData];")

    selfObj.gameState = MI_CUIRBBEAN_STATE_BET
    selfObj.lLastChip = selfObj.lChip
    selfObj.bLastJackpot = selfObj.bJackPot
    selfObj.miCaribbeanObj['resetlayer']:setVisible(false)
    selfObj.miCaribbeanObj['labellastchip']:setString(tostring(selfObj.lLastChip + selfObj.lReChip))
    selfObj.miCaribbeanObj['labellastwin']:setString(tostring(selfObj.lWinCoin))
    selfObj.miCaribbeanObj['gameingnode']:setVisible(false)
    selfObj.miCaribbeanObj['chipmenunode']:setVisible(true)
    selfObj.miCaribbeanObj['btndeal']:setEnabled(false)
    selfObj.miCaribbeanObj['labelcurchip']:setString("0")
    selfObj.miCaribbeanObj['labelcurwin']:setString("0")
    selfObj.miCaribbeanObj['chiplabel']:setString("0")
    selfObj.miCaribbeanObj['rebetlabel']:setString("0")

    selfObj:setChipPercent()

    -- rebet 是否可点
    local lChipMax = math.floor((selfObj.lCurCoin - selfObj.lPond) / 3)
    if selfObj.lLastChip > 0 and selfObj.lLastChip <= lChipMax then
        selfObj.miCaribbeanObj['btnrebet']:setEnabled(true)
    else
        selfObj.miCaribbeanObj['btnrebet']:setEnabled(false)
    end

    selfObj:setJackpotType(JACKPOT_MGR.NORMAL)

    local PKtable = {}
    for i = 1, 5 do
        if selfObj.myPkData[i].PK:isVisible() == true then
            table.insert(PKtable, selfObj.myPkData[i])
        end
        
        if selfObj.bankerPkData[i].PK:isVisible() == true then
            table.insert(PKtable, selfObj.bankerPkData[i])
        end
    end
    if #PKtable > 0 then
        selfObj:PlayClosePokerAction(PKtable)
    end

    if selfObj.bNewCardType then
        for i = 1, 5 do
            if selfObj.myPkData[i].PK:isVisible() == true then
                selfObj.myPkData[i].PK:setVisible(false)
                selfObj.myPkData[i].Back:setVisible(true)
            end
            
            if selfObj.bankerPkData[i].PK:isVisible() == true then
                selfObj.bankerPkData[i].PK:setVisible(false)
                selfObj.bankerPkData[i].Back:setVisible(true)
            end

            selfObj.miCaribbeanObj["mypokerrootnode"..i]:setVisible(false)
            selfObj.miCaribbeanObj["mypokerrootnode"..i]:setPosition(selfObj.myPkData[i].StartPos)
            selfObj.miCaribbeanObj["otherpokerrootnode"..i]:setVisible(false)
            selfObj.miCaribbeanObj["otherpokerrootnode"..i]:setPosition(selfObj.bankerPkData[i].StartPos)
        end
    end

    selfObj.miCaribbeanObj['chiprect']:removeAllChildren()
    selfObj.miCaribbeanObj['rechiprect']:removeAllChildren()

    selfObj.lChip = 0
    selfObj.bJackPot = 0
    selfObj.lReChip = 0
    selfObj.lWinCoin = 0
    selfObj.lLastSilderMark = 0
    selfObj.lPokerType = 9000
    selfObj.bDealTouched = false
    selfObj.bRaiseOrFold = false
end

-- 创建背面扑克
function BackPoker(selfObj)
    My_Lua_log(" file=[caribbeangame]  fun=[BackPoker];")

    for back = 1, 5 do
        -- 自己
        local myPokerBackBefore = selfObj.miCaribbeanObj["mypokerrootnode"..back]:getChildByTag(Local_Pubic_Poker2_Back_Tag)
        if nil ~= myPokerBackBefore then
            myPokerBackBefore:removeFromParentAndCleanup()
        end

        local tPokerBack1 = cc.Sprite:create(G_Fy.MiniGamegLobal:GetMiniConfig("USER_STATE_IMAGE", "POKER_BACK_ICON"))
        tPokerBack1:setScale(G_Android_Scale_Ratio / 2)
        selfObj.miCaribbeanObj["mypokerrootnode"..back]:addChild(tPokerBack1, Local_Pubic_Poker2_Back_Tag, Local_Pubic_Poker2_Back_Tag)
        selfObj.myPkData[back].Back = tPokerBack1

        -- 庄家
        local otherPokerBackBefore = selfObj.miCaribbeanObj["otherpokerrootnode"..back]:getChildByTag(Local_Pubic_Poker2_Back_Tag)
        if nil ~= otherPokerBackBefore then
            otherPokerBackBefore:removeFromParentAndCleanup()
        end

        local tPokerBack2 = cc.Sprite:create(G_Fy.MiniGamegLobal:GetMiniConfig("USER_STATE_IMAGE", "POKER_BACK_ICON"))
        tPokerBack2:setScale(G_Android_Scale_Ratio / 2)
        selfObj.miCaribbeanObj["otherpokerrootnode"..back]:addChild(tPokerBack2, Local_Pubic_Poker2_Back_Tag, Local_Pubic_Poker2_Back_Tag)
        selfObj.bankerPkData[back].Back = tPokerBack2

    end
end

--创建默认牌
function CreateDefaultPoker(selfObj, aiNodeName)
    My_Lua_log(" file=[caribbeangame]  fun=[CreateDefaultPoker];")

    --------------------
    -- 自己手牌
    --------------------
    selfObj.myPkData[aiNodeName].aiNodeName = aiNodeName
    selfObj.myPkData[aiNodeName].isClick = false
    selfObj.miCaribbeanObj["btnmypoker"..aiNodeName]:removeAllChildren()

    local myPKimg =  selfObj.miCaribbeanObj["mypokerrootnode"..aiNodeName]:getChildByTag(Local_Pubic_Poker1_Tag)
    if nil ~= myPKimg then
        myPKimg:removeFromParentAndCleanup()
    end

    local PK = cc.Sprite:create(G_Fy.MiniGamegLobal:GetMiniConfig("USER_STATE_IMAGE", "POKER_BACK_ICON"))
    PK:setScale(G_Android_Scale_Ratio / 2)
    selfObj.miCaribbeanObj["mypokerrootnode"..aiNodeName]:addChild(PK, Local_Pubic_Poker1_Tag, Local_Pubic_Poker1_Tag)
    selfObj.myPkData[aiNodeName].PK = PK
    selfObj.myPkData[aiNodeName].PK:setVisible(false)

    selfObj.miCaribbeanObj["btnmypoker"..aiNodeName]:setEnabled(false)
    selfObj.miCaribbeanObj["btnmypoker"..aiNodeName]:loadTextureDisabled(STR_TEXT_POKER_GRAY)
    --正
    local tOrbitFront1 = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 90, -90, 0 , 0)
    local tOrbitBack1 = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 0, -90, 0 , 0)
    local tOrbitFront2 = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 90, -90, 0 , 0)
    local tOrbitBack2 = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 0, -90, 0 , 0)
    --正-反
    selfObj.myPkData[aiNodeName].Action["action_just"] = cc.Sequence:create(cc.Show:create(), tOrbitBack2, cc.Hide:create(), cc.TargetedAction:create(selfObj.myPkData[aiNodeName].Back, cc.Sequence:create(cc.Show:create(), tOrbitFront2)))
    selfObj.myPkData[aiNodeName].Action["action_just"]:retain()
    --反-正
    selfObj.myPkData[aiNodeName].Action["action_against"] = cc.Sequence:create(cc.Show:create(), tOrbitBack1, cc.Hide:create(), cc.TargetedAction:create(selfObj.myPkData[aiNodeName].PK, cc.Sequence:create(cc.Show:create(), tOrbitFront1)))
    selfObj.myPkData[aiNodeName].Action["action_against"]:retain()

    --------------------
    -- 庄家手牌
    --------------------
    selfObj.bankerPkData[aiNodeName].aiNodeName = aiNodeName
    selfObj.bankerPkData[aiNodeName].isClick = false
    selfObj.miCaribbeanObj["btnotherpoker"..aiNodeName]:removeAllChildren()

    local bankerPKimg =  selfObj.miCaribbeanObj["otherpokerrootnode"..aiNodeName]:getChildByTag(Local_Pubic_Poker1_Tag)
    if nil ~= bankerPKimg then
        bankerPKimg:removeFromParentAndCleanup()
    end
    
    local PK_banker = cc.Sprite:create(G_Fy.MiniGamegLobal:GetMiniConfig("USER_STATE_IMAGE", "POKER_BACK_ICON"))
    PK_banker:setScale(G_Android_Scale_Ratio / 2)
    selfObj.miCaribbeanObj["otherpokerrootnode"..aiNodeName]:addChild(PK_banker, Local_Pubic_Poker1_Tag, Local_Pubic_Poker1_Tag)
    selfObj.bankerPkData[aiNodeName].PK = PK_banker
    selfObj.bankerPkData[aiNodeName].PK:setVisible(false)

    selfObj.miCaribbeanObj["btnotherpoker"..aiNodeName]:setEnabled(false)
    selfObj.miCaribbeanObj["btnotherpoker"..aiNodeName]:loadTextureDisabled(STR_TEXT_POKER_GRAY)
    --正
    local tOrbitFront1_banker = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 90, -90, 0 , 0)
    local tOrbitBack1_banker = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 0, -90, 0 , 0)
    local tOrbitFront2_banker = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 90, -90, 0 , 0)
    local tOrbitBack2_banker = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 0, -90, 0 , 0)
    --正-反
    selfObj.bankerPkData[aiNodeName].Action["action_just"] = cc.Sequence:create(cc.Show:create(), tOrbitBack2_banker, cc.Hide:create(), cc.TargetedAction:create(selfObj.bankerPkData[aiNodeName].Back, cc.Sequence:create(cc.Show:create(), tOrbitFront2_banker)))
    selfObj.bankerPkData[aiNodeName].Action["action_just"]:retain()
    --反-正
    selfObj.bankerPkData[aiNodeName].Action["action_against"] = cc.Sequence:create(cc.Show:create(), tOrbitBack1_banker, cc.Hide:create(), cc.TargetedAction:create(selfObj.bankerPkData[aiNodeName].PK, cc.Sequence:create(cc.Show:create(), tOrbitFront1_banker)))
    selfObj.bankerPkData[aiNodeName].Action["action_against"]:retain()

    if selfObj.bNewCardType then
        selfObj.miCaribbeanObj["mypokerrootnode"..aiNodeName]:setPosition(selfObj.myPkData[aiNodeName].StartPos)
        selfObj.miCaribbeanObj["otherpokerrootnode"..aiNodeName]:setPosition(selfObj.bankerPkData[aiNodeName].StartPos)
    end
end

--翻牌动画列表
function SetFlipActionList(selfObj, type)
    My_Lua_log(" file=[caribbeangame] fun=[SetFlipActionList];")

    selfObj.flipActionList = {}

    if type == Local_Action_SendCard_Chip then       -- 自己手牌 + 庄家的最后一张牌
        for i = 1, 5 do
            table.insert(selfObj.flipActionList, selfObj.myPkData[i])
        end
        table.insert(selfObj.flipActionList, selfObj.bankerPkData[5])
    elseif type == Local_Action_SendCard_ReChip then -- 庄家剩余全亮
        for i = 1, 4 do
            table.insert(selfObj.flipActionList, selfObj.bankerPkData[i])
        end
    end

    cc.SimpleAudioEngine:getInstance():playEffect("audio/pokersound.mp3")
    selfObj:PlayFlipPokerAction(selfObj.flipActionList)
end

--翻牌动画
function PlayFlipPokerAction(selfObj, aiActionList)
    My_Lua_log(" file=[caribbeangame] fun=[PlayFlipPokerAction];")

    function OnCallback()
        for i = 1,#aiActionList do
            aiActionList[i].PK:setVisible(true)
        end
        if selfObj.gameState == MI_CUIRBBEAN_STATE_SENDCARD then
            selfObj.gameState = MI_CUIRBBEAN_STATE_REBET
        end
    end

    for i = 1,#aiActionList  do
        local tIndex = i
        local tAct
        if i == #aiActionList then
            tAct = cc.Sequence:create(aiActionList[tIndex].Action["action_against"],
                cc.CallFunc:create(OnCallback))
        else
            tAct = cc.Sequence:create(aiActionList[tIndex].Action["action_against"])
        end
        aiActionList[tIndex].PK:setVisible(false)
        aiActionList[tIndex].Back:stopAllActions()
        aiActionList[tIndex].Back:runAction(tAct)
    end
end

--闭牌动画列表
function SetCloseActionList(selfObj)
    My_Lua_log(" file=[caribbeangame] fun=[SetCloseActionList]")

    if selfObj.bNewCardType then
        selfObj:setNewCardClose()
        return
    end

    selfObj.closeActionList = {}
    for i = 1 ,5  do
        table.insert(selfObj.closeActionList, selfObj.myPkData[i])
        selfObj.myPkData[i].PK:removeAllChildren()

        table.insert(selfObj.closeActionList, selfObj.bankerPkData[i])
        selfObj.bankerPkData[i].PK:removeAllChildren()
    end

    selfObj:PlayClosePokerAction(selfObj.closeActionList)
end

--闭牌动画
function PlayClosePokerAction(selfObj, aiActionList)
    My_Lua_log(" file=[caribbeangame] fun=[PlayClosePokerAction];")

    local count = #aiActionList
    for i = 1, count do
        local tAct = cc.Sequence:create(aiActionList[i].Action["action_just"])
        aiActionList[i].Back:setVisible(false)
        aiActionList[i].PK:runAction(tAct)

        if i == count then
            local pNode = cc.Node:create()
            selfObj.miCaribbeanObj['bgimg']:addChild(pNode)
            function TimerForPlayTypeBack()
                pNode:removeFromParentAndCleanup()
                selfObj:PlayTypeBackAnimation()
                selfObj:resetGameData()
            end
            local seq = cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(TimerForPlayTypeBack))
            pNode:runAction(seq)
        end
    end
end

-- 牌型动画  收牌
function PlayTypeBackAnimation(selfObj)
    My_Lua_log(" file=[caribbeangame] fun=[PlayTypeBackAnimation];")

    local myTypeSprite = selfObj.miCaribbeanObj["mytypenode"]:getChildByTag(100)
    if nil ~= myTypeSprite then
        myTypeSprite:runAction(cc.MoveTo:create(0.1, cc.p(VisibleSize.width / 2 + myTypeSprite:getContentSize().width, 0)))
    end

    local otherTypeSprite = selfObj.miCaribbeanObj["othertypenode"]:getChildByTag(100)
    if nil ~= otherTypeSprite then
        otherTypeSprite:runAction(cc.MoveTo:create(0.1, cc.p(-VisibleSize.width / 2 - otherTypeSprite:getContentSize().width, 0)))
    end
end

-- 帮助
function OnHelpButton(selfObj, node, eventType )
    My_Lua_log(" file=[caribbeangame] fun=[OnHelpButton];")

    selfObj.miCaribbeanObj['helpnode']:setVisible(true)
end

-- 关闭帮助
function OnHideHelpNode(selfObj, node, eventType )
    My_Lua_log(" file=[caribbeangame] fun=[OnHideHelpNode];")

    selfObj.miCaribbeanObj['helpnode']:setVisible(false)
end

-- 下注
function OnChipButton(selfObj, node, eventType )
    My_Lua_log(" file=[caribbeangame] fun=[OnChipButton]; ")
    
    if selfObj:CheckCanPlay() == false then
        return
    end

    selfObj.miCaribbeanObj['btnchip']:setVisible(false)
    selfObj.miCaribbeanObj['chiprect']:removeAllChildren()
    if eventType == 0 then

        selfObj.lLastSilderMark = 0        
        selfObj.miCaribbeanObj['chipsliderpanel']:setVisible(true)
        selfObj.miCaribbeanObj['btndeal']:setEnabled(false)
        selfObj.labelcurchip = 0
        selfObj.lChip = 0
        --设置成原始位置
        local tPosX = selfObj.miCaribbeanObj['btnmaxchip']:getPositionX()
        local tPosY = selfObj.miCaribbeanObj['btnmaxchip']:getPositionY()
        selfObj.miCaribbeanObj['btnmaxchip']:setPosition(tPosX, 105)
    elseif eventType == 1 then
        if selfObj.miCaribbeanObj['chipsliderpanel']:isVisible() == false then
            return
        end

        local tMaxY = 940
        local tMaxBet = selfObj.lMaxBet

        local tList, tLong = GetAreaList(selfObj, selfObj.lChip, tMaxBet - selfObj.lChip)
        selfObj.miAddRateList = tList
        selfObj.miAddRateLong = tLong

        local tTouchMovePosition = node:getTouchMovePosition()
        local tTouchBeganPosition = node:getTouchBeganPosition()

        local tAddChip = 0
        local tOffY = tTouchMovePosition.y - tTouchBeganPosition.y
        local tPosX = selfObj.miCaribbeanObj['btnmaxchip']:getPositionX()

        if tOffY < 2 then
            if tOffY < 1 then
                tOffY = 0
            elseif tOffY < 2 then
                if tAddChip >= tMaxBet then
                    tOffY = tMaxY
                    tAddChip = tMaxBet
                end
            end
        else
            if tAddChip >= tMaxBet then
                tOffY = tMaxY
                tAddChip = tMaxBet
            else
                if tOffY >= tMaxY then
                    tOffY = tMaxY
                    tAddChip = tMaxBet
                else
                    local indexPos = math.floor( tOffY / selfObj.perDistance )
                    tOffY = selfObj.perDistance * indexPos
                    tAddChip = math.floor( tMaxBet / selfObj.lTotalPercent * indexPos )
                    My_Lua_log("tMaxBet 33 = "..tMaxBet.."  tAddChip="..tAddChip.."  tOffY="..tOffY.."  indexPos="..indexPos)
                end
            end
        end 

        if tAddChip == tMaxBet then
            if selfObj.lChip < tMaxBet then
                cc.SimpleAudioEngine:getInstance():playEffect(SOUND_FILE_KEY.SOUND_FILE_KEY_SLIDER_TOP)
            end
        else 
            local tDistance = tOffY - selfObj.lLastSilderMark
            -- My_Lua_log(" ---------------------------------------------- ")
            -- My_Lua_log(" tOffY = " .. tOffY)
            -- My_Lua_log(" tDistance = " .. tDistance)
            if tDistance >= 100 or tDistance <= -100  then
                selfObj.lLastSilderMark = tOffY
                cc.SimpleAudioEngine:getInstance():playEffect(SOUND_FILE_KEY.SOUND_FILE_KEY_SLIDER)
            end
        end
        My_Lua_log("tMaxBet = "..tMaxBet.."  tAddChip="..tAddChip)
        selfObj.lChip = tAddChip
        selfObj.miCaribbeanObj['btnmaxchip']:setPosition(tPosX, tOffY+105)
        selfObj.miCaribbeanObj['textchip']:setString(selfObj.lChip)

    elseif eventType == 2 or eventType == 3 then
        if selfObj.miCaribbeanObj['chipsliderpanel']:isVisible() == false then
            return
        end

        selfObj.lLastSilderMark = 0
        cc.SimpleAudioEngine:getInstance():playEffect(SOUND_FILE_KEY.SOUND_FILE_KEY_SLIDER)
        
        selfObj:settleCoin(selfObj.lChip, true)

        selfObj.miCaribbeanObj['chipsliderpanel']:setVisible(false)
        selfObj.miCaribbeanObj['btnchip']:setVisible(true)
        selfObj.miCaribbeanObj['labelcurchip']:setString(selfObj.lChip)
        selfObj.miCaribbeanObj['chiplabel']:setString(selfObj.lChip)

        if selfObj.lChip > 0 then
            selfObj.miCaribbeanObj['btndeal']:setEnabled(true)
        else
            selfObj.miCaribbeanObj['btndeal']:setEnabled(false)
        end

    end
end

-- 沿用上局下注
function OnRebetButton(selfObj, node, eventType )
    My_Lua_log(" file=[caribbeangame] fun=[OnRebetButton]; ")

    if selfObj:CheckCanPlay() == false then
        return
    end

    if selfObj.gameState > MI_CUIRBBEAN_STATE_BET then
        My_Lua_log("按钮不可点")
        selfObj.miCaribbeanObj['btnrebet']:setEnabled(true)
        return
    end

    local chipMax = math.floor((selfObj.lCurCoin - selfObj.lPond) / 3)
    if chipMax < selfObj.lLastChip or selfObj.lLastChip <= 0 then
        My_Lua_log("当前金币不足")
        return
    end
    selfObj.lChip = selfObj.lLastChip
    selfObj.miCaribbeanObj['labelcurchip']:setString(tostring(selfObj.lChip))
    selfObj.miCaribbeanObj['chiplabel']:setString(tostring(selfObj.lChip))

    if selfObj.bLastJackpot == 1 then
        if selfObj.bJackPot == 0 then
            selfObj.bJackPot = 1
            selfObj:setJackpotType(JACKPOT_MGR.PRESSED)
        end
    else
        if selfObj.bJackPot == 1 then
            selfObj.bJackPot = 0
            selfObj:setJackpotType(JACKPOT_MGR.NORMAL)
        end
    end
    
    selfObj:settleCoin(selfObj.lChip, true)
    selfObj.miCaribbeanObj['btndeal']:setEnabled(true)
end

-- 发牌
function OnDealButton(selfObj, node, eventType )
    My_Lua_log(" file=[caribbeangame] fun=[OnDealButton]; ")

    if selfObj.bDealTouched == true then
        return
    end
    if selfObj.lChip <= 0 then
        My_Lua_log(" file=[caribbeangame] fun=[OnDealButton];  selfObj.lChip <= 0")
        return
    end
    -- deal
    if selfObj:CheckCanPlay() == false then
        return
    end

    selfObj.bDealTouched = true

    selfObj.IsLogging = true
    selfObj:LoadingTime()

    -- --翻牌动画列表
    -- selfObj.flipActionList = {}
    -- --闭牌动画列表
    -- selfObj.closeActionList = {}
    
    selfObj:setJackpotType(JACKPOT_MGR.UNUSE)
    -- selfObj.miCaribbeanObj['gameingnode']:setVisible(true)
    selfObj.miCaribbeanObj['chipmenunode']:setVisible(false)
    -- selfObj.miCaribbeanObj['btnfold']:setEnabled(true)
    -- selfObj.miCaribbeanObj['btnraise']:setEnabled(true)
    -- selfObj.lCurCoin = selfObj.lCurCoin - selfObj.lChip
    -- if selfObj.bJackPot == 1 then
    --     selfObj.lCurCoin = selfObj.lCurCoin - selfObj.lPond
    -- end
    -- selfObj.miCaribbeanObj["labelcurchip"]:setString(tostring(selfObj.lChip))
    -- selfObj:setOwnCoin()

    selfObj:SendHttpStartGame()
end

-- 弃牌
function OnFoldButton(selfObj, node, eventType )
    My_Lua_log(" file=[caribbeangame] fun=[OnFoldButton]; ")
    -- fold
    if selfObj.bRaiseOrFold == false then
        My_Lua_log("fold == false ...")
        selfObj.bRaiseOrFold = true
        selfObj.miCaribbeanObj['btnfold']:setEnabled(false)
        selfObj.miCaribbeanObj['btnraise']:setEnabled(false)
    else
        My_Lua_log("fold return...")
        return
    end

    if eventType == 0 then
        local pNodeForDealy = selfObj.miCaribbeanObj['bgimg']:getChildByTag(1111)
        if nil ~= pNodeForDealy then
            pNodeForDealy:removeFromParentAndCleanup()
        end

        selfObj.IsLogging = true
	    selfObj:LoadingTime()

        selfObj.lReChip = 0
        selfObj.miCaribbeanObj['btnfold']:setEnabled(false)
        selfObj.miCaribbeanObj['btnraise']:setEnabled(false)
        selfObj:SendPacketOfReBet(0)
    end
    
end

-- 再次下注
function OnRaiseButton(selfObj, node, eventType )
    My_Lua_log(" file=[caribbeangame] fun=[OnRaiseButton]; ")

    if selfObj.bRaiseOrFold == false then
        My_Lua_log("raise == false ...")
        selfObj.bRaiseOrFold = true
        selfObj.miCaribbeanObj['btnfold']:setEnabled(false)
        selfObj.miCaribbeanObj['btnraise']:setEnabled(false)
    else
        My_Lua_log("raise return...")
        return
    end

    if eventType == 0 then
        local pNodeForDealy = selfObj.miCaribbeanObj['bgimg']:getChildByTag(1111)
        if nil ~= pNodeForDealy then
            pNodeForDealy:removeFromParentAndCleanup()
        end

        if selfObj.lReChip > 0 then -- 已经下注
            return
        end

        selfObj.IsLogging = true
	    selfObj:LoadingTime()

        cc.SimpleAudioEngine:getInstance():playEffect("audio/minigame/caribbean/raise.wav")

        selfObj.miCaribbeanObj['btnfold']:setEnabled(false)
        selfObj.miCaribbeanObj['btnraise']:setEnabled(false)

        selfObj.lReChip = selfObj.lChip*2;
        selfObj.miCaribbeanObj['labelcurchip']:setString(selfObj.lChip + selfObj.lReChip)


        selfObj:SendPacketOfReBet(1)
    end
    
end

-- 重构
function OnReSetGameButton(selfObj, node, eventType )
    My_Lua_log(" file=[caribbeangame] fun=[OnReSetGameButton]; ")
    if selfObj.gameState == MI_CUIRBBEAN_STATE_BET then
        return
    end

    selfObj:setOwnCoin()
    selfObj.gameState = MI_CUIRBBEAN_STATE_BET
    if selfObj.lWinCoin > 0 then

        selfObj:playCoinAni()
    else
        selfObj.miCaribbeanObj['resetlayer']:setVisible(false)
        selfObj:SetCloseActionList()
    end
    
end

-- jackpot
function OnJackPotButton(selfObj, node, eventType )
    My_Lua_log(" file=[caribbeangame] fun=[OnJackPotButton]; ")

    if selfObj:CheckCanPlay() == false then
        return
    end

    if selfObj.gameState >= MI_CUIRBBEAN_STATE_SENDCARD then
        return
    end

    cc.SimpleAudioEngine:getInstance():playEffect("audio/minigame/caribbean/jackpot.wav")
    if selfObj.bJackPot == 0 then
        selfObj.bJackPot = 1
        selfObj:setJackpotType(JACKPOT_MGR.PRESSED)
    else
        selfObj.bJackPot = 0
        selfObj:setJackpotType(JACKPOT_MGR.NORMAL)
    end
end

-- 自己扑克牌按钮回调
function OnMyPokerButton(selfObj, node, eventType )
    My_Lua_log(" file=[caribbeangame] fun=[OnMyPokerButton]; ")
end

-- 结算游戏
function settleGame(selfObj, aiEvent)
    My_Lua_log(" file=[caribbeangame] fun=[settleGame] ")

    selfObj.gameState = MI_CUIRBBEAN_STATE_END

    if aiEvent.miData.eResult == 9001 then
        cc.SimpleAudioEngine:getInstance():playEffect("audio/minigame/caribbean/game_win.wav")
        
        local times = 0
        local highCard = 0
        if aiEvent.miData.eDealerPattern == 9000 then
            local hasK = false
            local hasA = false
            for i = 1, 5 do
                if selfObj.bankerPkData[i].value == 12 or 
                    selfObj.bankerPkData[i].value == 25 or
                    selfObj.bankerPkData[i].value == 38 or
                    selfObj.bankerPkData[i].value == 51 then
                    hasK = true
                end

                if selfObj.bankerPkData[i].value == 0 or 
                    selfObj.bankerPkData[i].value == 13 or
                    selfObj.bankerPkData[i].value == 26 or
                    selfObj.bankerPkData[i].value == 39 then
                    hasA = true
                end
            end
        
            if hasK and hasA then
                times = Poker_Times[selfObj.lPokerType - 9000 + 1]
            end
        else
            times = Poker_Times[selfObj.lPokerType - 9000 + 1]
        end
        
        selfObj.lWinCoin = selfObj.lChip + selfObj.lReChip * times
    else
        if aiEvent.miData.eResult == 9000 and selfObj.lReChip > 0 then
            cc.SimpleAudioEngine:getInstance():playEffect("audio/minigame/caribbean/gamelose.wav")
        end
        selfObj.lWinCoin = 0
    end

    selfObj.miCaribbeanObj['labelcurwin']:setString(tostring(selfObj.lWinCoin))
    selfObj:playGameEndAnimate(aiEvent.miData.eResult)
end

function settleCoin(selfObj, chipNum, bChip)
    My_Lua_log(" file=[caribbeangame] fun=[settleCoin] ")

    -- chipNum = 99900
    if chipNum <= 0 then
        return
    end

    local tmpChipNum = chipNum
    local coinTypeNum = {5000, 1000, 500, 100, 50, 10, 5, 1}
    local coinTypeStr = {"5k", "1k", "500", "100", "50", "10", "5", "1" }

    -- 筛选icon 、数量
    local chipArr = {}
    for i = 1, #coinTypeNum do
        local itemInfo = {}
        itemInfo.id = "minigame/caribbean/common/"..coinTypeStr[i].."ch.png"
        itemInfo.num = math.floor( tmpChipNum / coinTypeNum[i] )
        tmpChipNum = tmpChipNum - itemInfo.num * coinTypeNum[i]
        
        if itemInfo.num > 0 then
            while (itemInfo.num > 5) 
            do
                local tItemInfo = {}
                tItemInfo.id = itemInfo.id
                tItemInfo.num = 5
                table.insert(chipArr, tItemInfo)
                itemInfo.num = itemInfo.num - 5
            end
            table.insert(chipArr, itemInfo)
        end
    end

    -- copy坐标
    local copyPosArr = {}
    
    for k, v in pairs(PosArr_Chip) do
        local tPos = {}
        tPos[1] = v[1]
        tPos[2] = v[2]
        table.insert(copyPosArr, tPos)
    end
    
    -- 筛选pos
    local curArrNum = 0
    local newPosArr = {}
    local index = 1

    curArrNum = #copyPosArr
    for n = 1, #chipArr do
        -- curArrNum = #copyPosArr
        -- if curArrNum > 0 then
        --     index = math.random(curArrNum)
        --     table.insert(newPosArr, copyPosArr[index])
        --     table.remove(copyPosArr, index)
        -- end
        index = math.random(curArrNum)
        table.insert(newPosArr, copyPosArr[index])
    end
    
    -- 创建icon并设置pos
    local parentNode
    local startPos
    if bChip then
        parentNode = selfObj.miCaribbeanObj['chiprect']
        startPos = cc.p(393, -680)
    else
        parentNode = selfObj.miCaribbeanObj['rechiprect']
        startPos = cc.p(93, -680)
    end
    parentNode:removeAllChildren()

    local curPos = {}
    local size
    for j = 1, #chipArr do
        curPos = newPosArr[j]
        curPos[1] = curPos[1] + math.floor(math.random()*12)
        curPos[2] = curPos[2] + math.floor(math.random()*8)
        local pCoin = cc.Sprite:create(chipArr[j].id)
        pCoin:setScale(G_Android_Scale_Ratio)
        -- pCoin:setScale(0.8)
        -- pCoin:setPosition(cc.p(curPos[1], curPos[2]))
        pCoin:setPosition(startPos)
        parentNode:addChild(pCoin)
        if chipArr[j].num > 1 then
            size =  pCoin:getContentSize()
            for k = 1, chipArr[j].num-1 do
                local pChildCoin = cc.Sprite:create(chipArr[j].id)
                pChildCoin:setPosition(cc.p(size.width / 2, size.height / 2 + 6 * (k)))
                pCoin:addChild(pChildCoin)
            end
        end
        
        local seq = cc.Sequence:create(cc.DelayTime:create(0.02 * j), cc.MoveTo:create(0.1, cc.p(curPos[1], curPos[2])))
        pCoin:runAction(seq)
    end
end

function playJackPot(selfObj)
    My_Lua_log(" file=[caribbeangame] fun=[playJackPot]; ")

    local pJackPotAni = selfObj.miCaribbeanObj['btnjackpot']:getChildByTag(100)
    if nil ~= pJackPotAni then
        pJackPotAni:removeFromParentAndCleanup()
    end

    pJackPotAni = cc.Sprite:create(string.format(G_Fy.MiniGamegLobal:GetMiniConfig("CARIBBEAN_BTN_JACKPOT_ANI_PNG"), 1))
    pJackPotAni:setScale(G_Android_Scale_Ratio)
    local size = selfObj.miCaribbeanObj['btnjackpot']:getContentSize()
    pJackPotAni:setPosition(cc.p(size.width / 2, size.height / 2))
    pJackPotAni:setTag(100)
    selfObj.miCaribbeanObj['btnjackpot']:addChild(pJackPotAni)

    local animation = cc.Animation:create()
	local number, name
    for i = 1, 8 do
        name = string.format(G_Fy.MiniGamegLobal:GetMiniConfig("CARIBBEAN_BTN_JACKPOT_ANI_PNG"), i)
        animation:addSpriteFrameWithFile(name)
    end

    animation:setDelayPerUnit(1.0 / 8.0)
    local action = cc.Animate:create(animation)

    pJackPotAni:setVisible(true)
    pJackPotAni:runAction(cc.RepeatForever:create(action))

    -- pot的动画
    local pScrollViewAni = selfObj.miCaribbeanObj['listimg']:getChildByTag(100)
    if pScrollViewAni == nil then
        return
    end
    pScrollViewAni:setVisible(true)
    local animation = cc.Animation:create()
    local name
    for i = 1, 6 do
        name = string.format(G_Fy.MiniGamegLobal:GetMiniConfig("CARIBBEAN_JACKPOT_ANI_PNG"), i)
        animation:addSpriteFrameWithFile(name)
    end
    animation:setDelayPerUnit(1.0 / 6.0)
    local action = cc.Animate:create(animation)
    pScrollViewAni:runAction(cc.RepeatForever:create(action))

    selfObj:setScrollViewNumColor(cc.c3b(246, 217, 90))
end

-- 游戏结束动画：胜利，失败
function playGameEndAnimate(selfObj, eResult)
    My_Lua_log(" file=[caribbeangame] fun=[playGameEndAnimate] ")

    selfObj.miCaribbeanObj['resetlayer']:setVisible(true)
    
    selfObj.miCaribbeanObj['resetlayer']:removeAllChildren()
    -- 9000 lose     9001 win      9002 ping
    if eResult == 9001 then  --selfObj.lWinCoin > 0 then  --win
        local size = selfObj.miCaribbeanObj['resetlayer']:getContentSize()
        local pAnimateSprite = cc.Sprite:create("minigame/caribbean/common/win/winAni_1.png")
        pAnimateSprite:setScale(G_Android_Scale_Ratio)
        pAnimateSprite:setTag(100)
        pAnimateSprite:setPosition(cc.p(size.width / 2, size.height / 2))
        selfObj.miCaribbeanObj['resetlayer']:addChild(pAnimateSprite)

        local animation = cc.Animation:create()
        local number, name
        for i = 1, 15 do
            name = "minigame/caribbean/common/win/winAni_"..i..".png"
            animation:addSpriteFrameWithFile(name)
        end
        animation:setDelayPerUnit(1.0 / 15)
        local animate = cc.Animate:create(animation)

        function delayForReset()
            if selfObj.gameState ~= MI_CUIRBBEAN_STATE_END then
                return
            end
            --My_Lua_log(" file=[caribbeangame] fun=[playGameEndAnimate] delayForReset")
            selfObj:playCoinAni()
        end
        pAnimateSprite:runAction(cc.Sequence:create(animate, cc.Hide:create(), cc.DelayTime:create(0.5),cc.CallFunc:create(delayForReset))) 
    elseif eResult == 9000 or eResult == 9002 then
        selfObj:setOwnCoin()

        local pNode = cc.Node:create()
        selfObj.miCaribbeanObj['bgimg']:addChild(pNode)
        function TimerForPlayTypeBack()
            pNode:removeFromParentAndCleanup()
            
            if selfObj.gameState == MI_CUIRBBEAN_STATE_BET then
                return
            end
            local bVisible = selfObj.miCaribbeanObj['resetlayer']:isVisible()
            if bVisible == true then
                selfObj.gameState = MI_CUIRBBEAN_STATE_BET
                selfObj.miCaribbeanObj['resetlayer']:setVisible(false)
                selfObj:SetCloseActionList()
            end
        end
        local seq = cc.Sequence:create(cc.DelayTime:create(3.0), cc.CallFunc:create(TimerForPlayTypeBack))
        pNode:runAction(seq)
    end
end

function OnStartsSystemNotifyPag(selfObj, aiEvent)
    My_Lua_log(" file=[caribbeangame] fun=[OnStartsSystemNotifyPag]; ")

    if selfObj.miSsystemNotifyPag == nil then
        local SystemNotifyPag = require("texaspoker.game.systemnotify.systemnotifypag")
        local aiData = {}
        aiData.miGameDesk = selfObj.miGameDesk
        selfObj.miSsystemNotifyPag = SystemNotifyPag.Create(aiData)
        selfObj.miSsystemNotifyPag.miType = "minigame"
        selfObj.miCaribbeanObj["noticenode"]:addChild(selfObj.miSsystemNotifyPag:GetRootNode())
    end
    selfObj.miSsystemNotifyPag:OnStart()
end

function setJackpotType(selfObj, type)
    My_Lua_log(" file=[caribbeangame] fun=[setJackpotType]; ")

    if type == JACKPOT_MGR.NORMAL then
        selfObj.miCaribbeanObj['btnjackpot']:setEnabled(true)
        -- selfObj:playJackPot()

        local pJackpotAni = selfObj.miCaribbeanObj['btnjackpot']:getChildByTag(100)
        if nil ~= pJackpotAni then
            pJackpotAni:stopAllActions()
            pJackpotAni:setVisible(false)
        end

        local pScrollViewAni = selfObj.miCaribbeanObj['listimg']:getChildByTag(100)
        if nil ~= pScrollViewAni then
            pScrollViewAni:stopAllActions()
            pScrollViewAni:setVisible(false)
        end

        selfObj:setScrollViewNumColor(cc.c3b(0, 0, 0))
    elseif type == JACKPOT_MGR.PRESSED then
        selfObj.miCaribbeanObj['btnjackpot']:setEnabled(true)
        -- local pJackpotAni = selfObj.miCaribbeanObj['btnjackpot']:getChildByTag(100)
        -- if nil ~= pJackpotAni then
        --     pJackpotAni:stopAllActions()
        --     pJackpotAni:setVisible(false)
        -- end

        selfObj:playJackPot()
    elseif type == JACKPOT_MGR.UNUSE then
        selfObj.miCaribbeanObj['btnjackpot']:setEnabled(false)
        -- local pJackpotAni = selfObj.miCaribbeanObj['btnjackpot']:getChildByTag(100)
        -- if nil ~= pJackpotAni then
        --     pJackpotAni:stopAllActions()
        --     pJackpotAni:setVisible(false)
        -- end
    -- else

    end
end

function IsCacheUi(selfObj)
    return false
end

function GetRootNode(selfObj)
    return selfObj.miCaribbeanObj['root']
end

-- 退出游戏
function OnCloseButton(selfObj, node )
    My_Lua_log(" file=[caribbeangame] fun=[OnCloseButton]; ")
--[[
    local aiEvent = {}
    aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_CLOSE_PAG
    aiEvent.miPagName = "caribbeangame"
    aiEvent.miData = {}
    selfObj.miEventMgr:NextDispatch(aiEvent)
]]-- 
    G_Fy.miNetMgr:StopGame(selfObj.miGameRoom:GetGameRoomId())  
    local aiEvent = {}
    aiEvent.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_EXIST_COCOS2DX
    aiEvent.miData = {}
    aiEvent.miData.miType = 0
    aiEvent.miData.miRoomName = ""
    G_Fy:GetFyEvent():NextDispatch(aiEvent)
end

-- 刷新数据
function OnOpen(selfObj, miData)
    My_Lua_log(" file=[caribbeangame] fun=[OnOpen]; ")

    math.randomseed(os.time())

    --创建五张背牌
    selfObj:BackPoker()
    for default = 1, 5 do
        --创建五张默认牌
        selfObj:CreateDefaultPoker(default)
    end

    selfObj:resetGameData()

    selfObj:SendPacketOfInitGame()

    local aiEventPag = {}
    aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_SHOW_LOADING_PAG
    aiEventPag.miPagName = "lodingpag"
    aiEventPag.miData = {}
    aiEventPag.miData.miIsShow = true
    selfObj.miEventMgr:Dispatch(aiEventPag)
end

function OnClose(selfObj)
    Local_UiBase:OnClose()
    --移除
    selfObj.miCaribbeanObj['root']:removeFromParentAndCleanup()
    My_Lua_log(" file=[caribbeangame] fun=[onclose]; remove   ok")
end

--真正的退出删除
function OnExit(selfObj)
    selfObj.miCaribbeanObj['root']:release()
    My_Lua_log(" file=[caribbeangame] fun=[onexit]; ")
    selfObj.miEventMgr:RemoveListenFromObj(selfObj)
    for k,v  in pairs(selfObj.myPkData) do
        
       v.Action["action_just"]:release()
       v.Action["action_against"]:release()
    end

    for k,v  in pairs(selfObj.bankerPkData) do
       v.Action["action_just"]:release()
       v.Action["action_against"]:release()
    end
end

function OnUpdate(selfObj, aiDelTime)
    selfObj:WaitLoading()
end


--获得自由加注(增长规律)
function GetAreaList(selfObj, aiBegin, aiEnd)

    function GetRiseDigit(aiDigit)
        if aiDigit == 1 then
            return 2, 5, 9
        elseif  aiDigit == 2 then
            return 5, 20, 99
        elseif aiDigit > 2 then
            return (math.pow(10, aiDigit-1))/10, 100, math.pow(10, aiDigit)-1
        end
        return 0, 0, 0
    end

    if aiBegin < 1 then
        aiBegin = 0
    end
    if aiEnd < 1 then
        aiEnd = 0
    end

    local tList = {}
    local tMaxEndNum = 0
    local tLong = 0
    while  tMaxEndNum <= aiEnd do
        local tTempCeil = math.ceil( math.log10(tMaxEndNum) ) --上取整
        if tMaxEndNum == 0 then
            tTempCeil = 0 --上取整
        end
        local tceil = math.ceil(math.log10(tMaxEndNum))
        local tfloor = math.floor(math.log10(tMaxEndNum))
        if tceil == tfloor then
            tTempCeil =  tTempCeil + 1
        end
        local tTempMinAreaCeilScale, tTempMinAreaCeilArea, tTempMinAreaCeilEndMax = GetRiseDigit(tTempCeil)
        tMaxEndNum = tMaxEndNum + tTempMinAreaCeilScale
        if tMaxEndNum > aiBegin then
            local tData = {}
            tData.miArea = 1
            tData.miScale = tMaxEndNum
            table.insert(tList,tData)
            tLong = tLong + tData.miArea
        end
    end
    return tList, tLong
end

-- 中奖公告
function setNoticeStr(selfObj, vInfos)
    My_Lua_log(" file=[caribbeangame] fun=[setNoticeStr]; ")

    local count = #vInfos
    if count < 1 then
        return
    end
    local aiEvent = {}
    selfObj:OnStartsSystemNotifyPag(aiEvent)

    for i = 1, #vInfos do
        local winStr = ""
        if vInfos[i].lWinCoin >= 1000 then
            winStr = vInfos[i].lWinCoin
            local len = string.len(winStr)
            local str1 = string.sub( winStr, 1, len-3)
            str1 = str1..","..string.sub( winStr, len-2, len)
            winStr = str1
        else
            winStr = vInfos[i].lWinCoin
        end

        local ePattern = vInfos[i].ePattern - 9000
        if G_Fy.GamegLobal:GetCurrentLanguage() == LANGUAGE_TYPE.G_LANGUAGE_ENGLISH then  --英文
            str = "<type=label; fontname=Marker Felt; fontsize=50; color=ffffff; content="..G_Fy.MiniGamegLobal:GetMiniConfig("MINI_NOTICE_STR", 1)..";>"
            str = str.."<type=label; fontname=Marker Felt; fontsize=50; color=fedf9e; content="..vInfos[i].sNickName..";>"
            str = str.."<type=label; fontname=Marker Felt; fontsize=50; color=ffffff; content="..G_Fy.MiniGamegLobal:GetMiniConfig("MINI_NOTICE_STR", 2)..";>"
            str = str.."<type=label; fontname=Marker Felt; fontsize=50; color=fedf9e; content="..winStr..";>"
            str = str.."<type=label; fontname=Marker Felt; fontsize=50; color=ffffff; content="..G_Fy.MiniGamegLobal:GetMiniConfig("MINI_NOTICE_STR", 3)..";>"
            str = str.."<type=label; fontname=Marker Felt; fontsize=50; color=fedf9e; content="..G_Fy.MiniGamegLobal:GetMiniConfig("POKER_MINI_CT_NAME", ePattern)..";>"
            str = str.."<type=label; fontname=Marker Felt; fontsize=50; color=ffffff; content="..G_Fy.MiniGamegLobal:GetMiniConfig("MINI_NOTICE_STR", 4)..";>"
        else
            str = "<type=label; fontname=Marker Felt; fontsize=50; color=ffffff; content="..G_Fy.MiniGamegLobal:GetMiniConfig("MINI_NOTICE_STR", 1)..";>"
            str = str.."<type=label; fontname=Marker Felt; fontsize=50; color=fedf9e; content="..vInfos[i].sNickName..";>"
            str = str.."<type=label; fontname=Marker Felt; fontsize=50; color=ffffff; content="..G_Fy.MiniGamegLobal:GetMiniConfig("MINI_NOTICE_STR", 2)..";>"
            str = str.."<type=label; fontname=Marker Felt; fontsize=50; color=fedf9e; content="..G_Fy.MiniGamegLobal:GetMiniConfig("POKER_MINI_CT_NAME", ePattern)..";>"
            str = str.."<type=label; fontname=Marker Felt; fontsize=50; color=ffffff; content="..G_Fy.MiniGamegLobal:GetMiniConfig("MINI_NOTICE_STR", 3)..";>"
            str = str.."<type=label; fontname=Marker Felt; fontsize=50; color=fedf9e; content="..winStr..";>"
            str = str.."<type=label; fontname=Marker Felt; fontsize=50; color=ffffff; content="..G_Fy.MiniGamegLobal:GetMiniConfig("MINI_NOTICE_STR", 4)..";>"
        end

        local ntime = os.time()

        local aiEvent = {}
        aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_ADD_SYSTEM_MSG_PAG
        aiEvent.miData = {}
        aiEvent.miData.miMsgId = vInfos[i].sNickName..ntime
        aiEvent.miData.miMsgStr = str
        selfObj.miEventMgr:Dispatch(aiEvent)

        -- My_Lua_log("id = "..aiEvent.miData.miMsgId.."  msgStr="..aiEvent.miData.miMsgStr)
    end
end

-- 是否高亮
function setCardHighBright(selfObj, cards, cardType ,bSelf)
    My_Lua_log(" file=[caribbeangame] fun=[setCardHighBright]; ")

    local tPokeList = {}
    for i = 1, 5 do
        local cardValue = cards[i]
        table.insert(tPokeList, cardValue)
    end
    local PokeCompare = require("texaspoker.game.pokercompare.pokecompare")
    local tCardKind, tLastCardData = PokeCompare.FiveFromSeven(tPokeList)
    -- My_Lua_log("type == "..tCardKind)

    for key, value in pairs(tLastCardData) do
        local tData = {}
        tData.miPokerNum = value.miPokeOldNum
        if cardType >= 9004 then
            if cardType ~= 9007 then
                value.miIsHighBright = true
            end
        end
        tData.miIsHighBright = value.miIsHighBright

        -- My_Lua_log(" value.miPokeOldNum = "..value.miPokeOldNum.."   value.miIsHighBright="..tostring(value.miIsHighBright))
        if tData.miIsHighBright == true then
            for i = 1, 5 do
                if tData.miPokerNum == cards[i] then
                    local pHighBright = cc.Sprite:create(G_Fy.MiniGamegLobal:GetMiniConfig("USER_STATE_IMAGE", "POKER_SELECTED_ICON"))
                    pHighBright:setAnchorPoint(cc.p(0, 0))
                    if bSelf then
                        selfObj.myPkData[i].PK:addChild(pHighBright)
                    else
                        selfObj.bankerPkData[i].PK:addChild(pHighBright)
                    end
                end
            end
        end
    end
end

function setChipPercent(selfObj)
    My_Lua_log(" file=[caribbeangame] fun=[setChipPercent]; ")

    local tMaxBet = math.floor((selfObj.lCurCoin - selfObj.lPond) / 3)
    My_Lua_log("tMaxBet = "..tMaxBet)
    local tPerBet = tMaxBet / 100
    local tInteger, tPoint = math.modf(tPerBet)

    if tInteger < 1 then
        selfObj.lMaxBet = tMaxBet
        selfObj.lTotalPercent = tMaxBet
    elseif tInteger < 2 then
        local tTotalPercent = 50
        local curMaxBet = 0
        while(curMaxBet <= tMaxBet and tTotalPercent < 100)
        do
            curMaxBet = 2 * tTotalPercent
            tTotalPercent = tTotalPercent + 1
        end
        selfObj.lMaxBet = curMaxBet
        selfObj.lTotalPercent = tTotalPercent
    else
        if tMaxBet <= Local_Chip_Max then
            selfObj.lMaxBet = tMaxBet
        else
            selfObj.lMaxBet = Local_Chip_Max
        end
        selfObj.lTotalPercent = Loacl_Public_Chip_Percent
    end

    My_Lua_log("end  selfObj.lCurCoin = "..selfObj.lCurCoin.."selfObj.lMaxBet = "..selfObj.lMaxBet.."   selfObj.lTotalPercent = "..selfObj.lTotalPercent)

    selfObj.perDistance = 940 / selfObj.lTotalPercent
end

function setOwnCoin(selfObj)
    
    local tReturnStr = "0"
    if selfObj.lCurCoin > 999999999 then
        My_Lua_log("BBBBBB")
        local tStr = tostring(selfObj.lCurCoin/1000000000.0)
        local tStrB = string.sub(tStr, 1, 4)
        local tbegin, tEnd = string.find(tStrB, '%.')
        if tbegin == nil then
            tReturnStr = tStrB.."B"
        else
            if tEnd == 4 then
                tStrB = string.sub(tStrB, 1, 3)
                tReturnStr = tStrB.."B"
            else
                tReturnStr = tStrB.."B"
            end
        end
    else
        tReturnStr = selfObj.lCurCoin
    end
    selfObj.miCaribbeanObj['labelscore']:setString(tReturnStr)
end

function playCoinAni(selfObj)
    My_Lua_log(" file=[caribbeangame] fun=[playCoinAni]; ")

    local endPos = selfObj.miCaribbeanObj['bottonnode']:getPosition()
    local chipCoinArr = selfObj.miCaribbeanObj['chiprect']:getChildren()
    local chipCount = #chipCoinArr
    if chipCount > 0 then
        for i = 1, chipCount do
            local seq = cc.Sequence:create(cc.MoveTo:create(0.3, cc.p(330, -1000)), cc.Hide:create())
            chipCoinArr[i]:runAction(seq)
        end
    end

    local reChipCoinArr = selfObj.miCaribbeanObj['rechiprect']:getChildren()
    local reChipCount = #reChipCoinArr
    if reChipCount > 0 then
        for i = 1, reChipCount do
            local seq = cc.Sequence:create(cc.MoveTo:create(0.3, cc.p(-80, -1000)), cc.Hide:create())
            reChipCoinArr[i]:runAction(seq)
        end
    end

    local pNode = cc.Node:create()
    selfObj.miCaribbeanObj['bgimg']:addChild(pNode)
    function TimerForPlayTypeBack()
        pNode:removeFromParentAndCleanup()

        local bVisible = selfObj.miCaribbeanObj['resetlayer']:isVisible()
        if bVisible == true then
            selfObj:setOwnCoin()
            selfObj.miCaribbeanObj['resetlayer']:setVisible(false)
            selfObj:SetCloseActionList()
        end    
    end
    local seq = cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(TimerForPlayTypeBack))
    pNode:runAction(seq)
end

function playPoolAni(selfObj)
    My_Lua_log(" file=[caribbeangame] fun=[playPoolAni]; ")

    selfObj.miCaribbeanObj['poolnode']:setVisible(true)

    local coinItems = selfObj.miCaribbeanObj['poolnode']:getChildren()
    local id = 1
    if #coinItems == 0 then
        for i = 1, Local_FlyCoin_Num do
            id = math.random(1, 8)
            local flyCoin = cc.Sprite:create("minigame/caribbean/common/coins/coin"..id..".png")
            flyCoin:setScale(math.random(8, 15) / 10)
            flyCoin:setTag(100 + i)
            selfObj.miCaribbeanObj['poolnode']:addChild(flyCoin)
        end

        local id = 1
        local idStr = ""
        local coinTypeStr = {"5k", "1k", "500", "100", "50", "10", "5", "1" }
        for j = 1, Local_MoveCoin_num do
            id = math.random(1, 8)
            idStr = "minigame/caribbean/common/"..coinTypeStr[id].."ch.png"
            local moveCoin = cc.Sprite:create(idStr)
            moveCoin:setScale(G_Android_Scale_Ratio)
            moveCoin:setTag(1000 + j)
            selfObj.miCaribbeanObj['poolnode']:addChild(moveCoin)
        end

        selfObj:PlayCoinsDown()
    else
        selfObj:PlayCoinsDown()
    end
end

function PlayCoinsDown( selfObj )
    My_Lua_log(" file=[caribbeangame] fun=[PlayCoinsDown]; ")

    for i = 1, Local_FlyCoin_Num do
        local coin = selfObj.miCaribbeanObj['poolnode']:getChildByTag(100 + i)
        if nil ~= coin then
            coin:stopAllActions()
        end
    end

    cc.SimpleAudioEngine:getInstance():playEffect("audio/minigame/caribbean/flycoin.wav")

    for i = 1, Local_FlyCoin_Num do
        local flyCoin = selfObj.miCaribbeanObj['poolnode']:getChildByTag(100 + i)
        local posX = math.random(1, VisibleSize.width)
        local posY = VisibleSize.height + 27*i
        flyCoin:setPosition(cc.p(posX, posY))
        local distance = posY + 0
        local time = distance / 2200

        function OnCallBack(  )
            if i == Local_FlyCoin_Num then
                for j = 1, Local_MoveCoin_num do
                    local moveCoin = selfObj.miCaribbeanObj['poolnode']:getChildByTag(1000+j)
                    local xPos = VisibleSize.width / 2  + math.random(1,400)
                    local yPos = 1700 + math.random(1,50)
                    moveCoin:setPosition(cc.p(xPos, yPos))
                    
                    function OnCallBack1(  )
                        if j == 30 then
                            My_Lua_log("OnCallBack1...")
                            selfObj:setOwnCoin()
                            selfObj.miCaribbeanObj['poolnode']:setVisible(false)
                            
                            local pNodeForDealy = cc.Node:create()
                            pNodeForDealy:setTag(1111)
                            selfObj.miCaribbeanObj['bgimg']:addChild(pNodeForDealy)

                            function delayForFold()
                                if nil ~= pNodeForDealy then
                                    pNodeForDealy:removeFromParentAndCleanup()
                                end

                                selfObj.miCaribbeanObj['btnfold']:setEnabled(false)
                                selfObj.miCaribbeanObj['btnraise']:setEnabled(false)
                                selfObj:SendPacketOfReBet(0)
                            end
                            local seq = cc.Sequence:create(cc.DelayTime:create(10.0), cc.CallFunc:create(delayForFold))
                            pNodeForDealy:runAction(seq)
                        end
                    end
                    local seq1 = cc.Sequence:create(cc.Show:create(), cc.MoveTo:create(0.8, cc.p(VisibleSize.width / 2, 50)), cc.Hide:create(), cc.CallFunc:create(OnCallBack1))
                    moveCoin:runAction(seq1)
                end
            end
        end
        
        local seq = cc.Sequence:create(cc.Show:create(), cc.MoveTo:create(time, cc.p(posX, 0)), cc.Hide:create(), cc.CallFunc:create(OnCallBack))
        flyCoin:runAction(seq)
    end
end

function CheckCanPlay(selfObj)
    local needCoin = selfObj.lMinBet * 3 + selfObj.lPond
    -- My_Lua_log("needCoin = "..needCoin)
    if needCoin > selfObj.lCurCoin then
        local aiEventPag = {}
        aiEventPag.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_POPUP_PAG
        aiEventPag.miPagName = "gotoshoppag"
        aiEventPag.miData = {}
        aiEventPag.miData.miType = 2
        aiEventPag.miData.needCoin = needCoin
        selfObj.miEventMgr:NextDispatch(aiEventPag)
        return false
    else 
        return true
    end
end

function LoadingTime(selfObj)
    --loading出现，消失间隔
    selfObj.loadingTime = {}
    selfObj.loadingTime.nowTime = os.time()
    selfObj.loadingTime.startTime = os.time() + 2
    selfObj.loadingTime.endTime = os.time() + 50
end

function CenterLoadingTime(selfObj)
    --取消loading
    selfObj.loadingTime.nowTime = nil
end

function WaitLoading(selfObj)
    local nowTime = os.time()
    --My_Lua_log("file=[minigamescenepag] fun=[WaitLoading] nowtime="..nowTime)
    if selfObj.loadingTime.nowTime ~= nil then
        if nowTime >= selfObj.loadingTime.endTime then
            My_Lua_log("file=[caribbeangame] fun=[WaitLoading] loading=[CloseLoading]")
            selfObj:CloseLoading()                          
            selfObj:CenterLoadingTime() 
        elseif nowTime >= selfObj.loadingTime.startTime then
            if selfObj.IsLogging then
                My_Lua_log("file=[caribbeangame] fun=[WaitLoading] loading=[Loading]")
                --加载
                selfObj:Loading()               
                selfObj.IsLogging = false
            end
        end
    end
end

--loading
function Loading(selfObj)
    --加载界面
    local IsErrorpag =  selfObj.miUiMgr:GetUiObj("errorpag")
    local IsGotoshoppag =  selfObj.miUiMgr:GetUiObj("gotoshoppag")
    if IsErrorpag == nil and IsGotoshoppag == nil then
        local aiEvent = {}
        aiEvent.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_SHOW_LOADING_PAG
        aiEvent.miPagName = "lodingpag"
        aiEvent.miData = {}
        aiEvent.miData.miIsShow = true
        selfObj.miEventMgr:Dispatch(aiEvent)
    end
end

--关闭 loading
function CloseLoading(selfObj)
    My_Lua_log("file=[minigamescenepag] fun=[CloseLoading]")
    local aiEventPag = {}
    aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_SHOW_LOADING_PAG
    aiEventPag.miPagName = "lodingpag"
    aiEventPag.miData = {}
    aiEventPag.miData.miIsShow = false
    selfObj.miEventMgr:Dispatch(aiEventPag)
end


function setScrollViewNumColor(selfObj, tColor)
    for i = 1, Jackpot_Num do
        local pNode = selfObj.pContainLayer:getChildByTag(100 + i)
        -- 246, 217, 90
        local itemArr = pNode:getChildren()
        for i = 1, #itemArr do
            if itemArr[i] then
                itemArr[i]:setColor(tColor)
            end
        end
    end

    for i = 1, 3 do
        local pPoint = selfObj.pContainLayer:getChildByTag(1000 + i)
        pPoint:setColor(tColor)
    end
end

--------------------------------

function sendCardNew(selfObj)
    My_Lua_log(" file=[caribbeangame] fun=[sendCardNew]; ")

    local endPos = {}
    local bankerPos = nil
    local index = 1
    selfObj.flipActionList = {}
    for i = 1, 10 do
        local tPKNode = nil
        local seq = nil
        if i % 2 == 1 then
            index = (i+1)/2
            tPKNode = selfObj.miCaribbeanObj["mypokerrootnode"..index]
            endPos = selfObj.myPkData[index].EndPos
        else
            index = i / 2
            tPKNode = selfObj.miCaribbeanObj["otherpokerrootnode"..index]
            endPos = selfObj.bankerPkData[index].EndPos
        end
        My_Lua_log("i = "..i.."  index = "..index.."   endPos: x="..endPos.x.." y="..endPos.y)
        if i == 10 then
            local function OnCallback()
                selfObj:playCardShow()
            end
            seq = cc.Sequence:create(cc.DelayTime:create(0.1 * i), cc.Show:create(), cc.MoveTo:create(0.2, endPos), cc.DelayTime:create(0.1), cc.CallFunc:create(OnCallback))
        else
            seq = cc.Sequence:create(cc.DelayTime:create(0.1 * i), cc.Show:create(), cc.MoveTo:create(0.2, endPos))
        end

        tPKNode:runAction(seq)
    end
end

function playCardShow(selfObj)
    My_Lua_log(" file=[caribbeangame] fun=[playCardShow]; ")

    cc.SimpleAudioEngine:getInstance():playEffect("audio/pokersound.mp3")

    local function OnCallbackForShowPK()
        for i = 1, 5 do
            selfObj.myPkData[i].PK:setVisible(true)
            if i == 5 then
                selfObj.bankerPkData[i].PK:setVisible(true)
            end
        end

        if selfObj.gameState == MI_CUIRBBEAN_STATE_SENDCARD then
            selfObj.gameState = MI_CUIRBBEAN_STATE_REBET
        end
    end

    for i = 1, 10 do
        if i <= 5 or i == 10 then
            local indexItem = nil
            local tIndex = i
            local tAct
            if i <= 5 then
                indexItem = selfObj.myPkData[i]
            elseif i == 10 then
                indexItem = selfObj.bankerPkData[i-5]
            end
            if i == 10 then
                tAct = cc.Sequence:create(indexItem.Action["action_against"],
                    cc.CallFunc:create(OnCallbackForShowPK))
            else
                tAct = cc.Sequence:create(indexItem.Action["action_against"])
            end
            indexItem.PK:setVisible(false)
            indexItem.Back:stopAllActions()
            indexItem.Back:runAction(tAct)
        end
    end
end

function setBankerCardShow(selfObj)
    My_Lua_log(" file=[caribbeangame] fun=[setBankerCardShow]; ")

    cc.SimpleAudioEngine:getInstance():playEffect("audio/pokersound.mp3")

    function OnCallback()
        for i = 1, 4 do
            selfObj.bankerPkData[i].PK:setVisible(true)
        end
    end

    for i = 1, 4 do
        local tAct
        if i == 4 then
            tAct = cc.Sequence:create(selfObj.bankerPkData[i].Action["action_against"], cc.CallFunc:create(OnCallback))
        else
            tAct = cc.Sequence:create(selfObj.bankerPkData[i].Action["action_against"])
        end
        selfObj.bankerPkData[i].PK:setVisible(false)
        selfObj.bankerPkData[i].Back:stopAllActions()
        selfObj.bankerPkData[i].Back:runAction(tAct)
    end
end

function setNewCardClose(selfObj)
    selfObj:PlayTypeBackAnimation()

    for i = 1, 10 do
        local tPKNode = nil
        local seq = nil
        if i % 2 == 1 then
            index = (i+1)/2
            selfObj.miCaribbeanObj["mypokerrootnode"..index]:setVisible(false)
            tPKNode = selfObj.myPkData[index]
            endPos = selfObj.myPkData[index].startPos
        else
            index = i / 2
            selfObj.miCaribbeanObj["otherpokerrootnode"..index]:setVisible(false)
            tPKNode = selfObj.bankerPkData[index]
            endPos = selfObj.bankerPkData[index].startPos
        end

        -- 去除高亮显示
        tPKNode.PK:removeAllChildren()

        local tAct = cc.Sequence:create(tPKNode.Action["action_just"])
        tPKNode.Back:setVisible(false)
        tPKNode.PK:runAction(tAct)

        if i == 10 then
            local pNode = cc.Node:create()
            selfObj.miCaribbeanObj['bgimg']:addChild(pNode)
            local function TimerForPlayTypeBack()
                pNode:removeFromParentAndCleanup()
                selfObj:resetGameData()
            end
            local seq = cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(TimerForPlayTypeBack))
            pNode:runAction(seq)
        end
    end
end

--endregion
