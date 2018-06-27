--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


--region *.lua
--Date
--此文件由[BabeLua]插件自动生成



module(...,package.seeall)
local Local_UiBase = require "comm.uibase"

local Local_Pubic_Poker1_Tag = 10001
local Local_Pubic_Poker1_Back_Tag = 10011
local Local_Pubic_Poker2_Tag = 10002
local Local_Pubic_Poker2_Back_Tag = 10012
local Local_Pubic_Card_Tag = 10013

local Local_State = "gamestart"
local UI_State = "GameStart"

local Local_Flip_Time = 0.1

function Create(aiData)
    local selfObj = Local_UiBase.Create(aiData)
    local parents = {_M, Local_UiBase}
	setmetatable( selfObj ,{__index = function(t,k)
		return search(k,parents) end } )
    selfObj.miPagName = "minigamemainscenepag"
    selfObj.miPagObj = nil
   
    --初始化动态数据
    selfObj:InitializeDynamicData()
    selfObj:Init()
    return selfObj
end

--初始化动态数据
function InitializeDynamicData(selfObj)
    --选择bet(0-4)
    selfObj.miSelBetIndex = 0
    --比较输赢 选择牌索引
    selfObj.doubleIndex = 0

    selfObj.pkData = {}
    for pk = 1, 5 do
        selfObj.pkData[pk] = {}
        selfObj.pkData[pk].Action = {}
    end

    --第一次加载
    selfObj.IsTwo = false
    --是否翻倍
    selfObj.IsDouble = false
    --奖池中德扑币
    selfObj.iPoolCoin = 0

    --请求换牌位置列表
    selfObj.pos = {}

    --状态机     
    selfObj.STATE_ENUM = 
    {
        [1] = "gStart_Began",   --gamestart 开始
        [2] = "gStart_End",     --gamestart 结束
        [3] = "gChange_Began",  --gamechange 开始
        [4] = "gChange_End",    --gamechange 结束
        [5] = "gDouble_Began",  --gamedouble 开始
        [6] = "gDouble_End",    --gamedouble 结束
        [7] = "gCheck_Began",   --gamecheck 开始
        [8] = "gCheck_End",     --gamecheck 结束
    }

    selfObj.UI_STATE = 
    {
        [1] = "GameStart",
        [2] = "GameChange",
        [3] = "GameDouble",
        [4] = "GameCheck",
    }
    --防止闭牌动画重复
    selfObj.close = false
    --防止double 闭牌动画重复
    selfObj.dClose = false
    --翻牌动画列表
    selfObj.flipActionList = {}

    --闭牌动画列表
    selfObj.closeActionList = {}

    --点击bet索引(1-5)
    selfObj.aiIndex = 1

    --防止  GAMECHECKSTATE  状态下，重复选牌
    selfObj.Once = true

    --防止session 超时 与 logging冲入
    selfObj.session = true
    --显示loading保护
    selfObj.IsLogging = false

    selfObj.loadingTime = {}
    selfObj.loadingTime.nowTime = nil
    selfObj.loadingTime.startTime = nil
    selfObj.loadingTime.endTime = nil


    --设置数据
    selfObj.miMiniGameData = {}
    selfObj.miMiniGameData.eCmd = 0

    selfObj.miMiniGameData.vCards = {} --tRsp.vCmd_start_cards
    selfObj.miMiniGameData.iCurCoin = 0 --tRsp.iCurCoin
    selfObj.miMiniGameData.iPoolCoin = 0 --tRsp.iPoolCoin
    selfObj.miMiniGameData.iFlag = 0 --tRsp.iFlag

    selfObj.miMiniGameData.iCard ={} --tRsp.iCmd_double_card
--    selfObj.miMiniGameData.iCurCoin = tRsp.iCurCoin
--    selfObj.miMiniGameData.iPoolCoin = tRsp.iPoolCoin
--    selfObj.miMiniGameData.iFlag = tRsp.iFlag

    selfObj.miMiniGameData.vCards ={} --tRsp.vCmd_change_cards
    selfObj.miMiniGameData.ePattern ={} --tRsp.eCmd_change_pattern

    selfObj.miMiniGameData.vCards ={} --tRsp.vCmd_check_cards
    selfObj.miMiniGameData.eResult = 0 --tRsp.eCmd_check_result

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

function IsCacheUi(selfObj)
    return false
end

function GetRootNode(selfObj)
    return selfObj.miPagObj['root']
end

--创建初始化UI
function Init(selfObj)
    My_Lua_log(" file=[minigamemainscenepag] fun=[init];")
    local PromptNode = nil
    if G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPHONE_4 then
        PromptNode = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MINIGAMESCENE_I4"))
    elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPHONE_6S then
        PromptNode = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MINIGAMESCENE"))
    elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.IPAD then
        PromptNode = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MINIGAMESCENE_IPAD"))
    elseif G_Fy.GamegLobal:GetPhonePlatform() == DESIGNSIZE_PHONE_NAME.SUMSUNG_S8 then
        PromptNode = require(G_Fy.MiniGamegLobal:GetMiniConfig("COCOSTUDIO_UI_MINIGAMESCENE_S8"))
    end    
    --local PromptNode = require(COCOSTUDIO_UI_MINIGAMESCENE)
    local callBackProvider = function ( path,node,funcName )
        --点击关闭
        if node:getName()=="closebutton" and funcName =="OnCloseButton" then
            local function OnCloseButton1(  node,eventType )  
                selfObj:OnCloseButton( node,  eventType )
            end  
            return OnCloseButton1
        end


        --点击免费
        if node:getName()=="freebutton" and funcName =="OnFreeButton" then
            local function OnFreeButton1(  node,eventType )  
                selfObj:OnFreeButton( node,  eventType )
            end  
            return OnFreeButton1
        end

        --点击doublebutton
        if node:getName()=="doublebutton" and funcName =="OnDoubleButton" then
            local function OnDoubleButton1(  node,eventType )  
                selfObj:OnDoubleButton( node,  eventType )
            end  
            return OnDoubleButton1
        end

        --点击info
        if node:getName()=="infobutton" and funcName =="OnInfoButton" then
            local function OnInfoButton1(  node,eventType )  
                selfObj:OnInfoButton( node,  eventType )
            end  
            return OnInfoButton1
        end
        --点击1bet
        if node:getName()=="betcheckbox1" and funcName =="OnBetCheckBox1" then
            local function OnBetCheckBox11(  node,eventType )  
                selfObj:OnBetCheckBox1( node,  eventType )
            end  
            return OnBetCheckBox11
        end
        --点击2bet
        if node:getName()=="betcheckbox2" and funcName =="OnBetCheckBox2" then
            local function OnBetCheckBox21(  node,eventType )  
                selfObj:OnBetCheckBox2( node,  eventType )
            end  
            return OnBetCheckBox21
        end
        --点击3bet
        if node:getName()=="betcheckbox3" and funcName =="OnBetCheckBox3" then
            local function OnBetCheckBox31(  node,eventType )  
                selfObj:OnBetCheckBox3( node,  eventType )
            end  
            return OnBetCheckBox31
        end
        --点击4bet
        if node:getName()=="betcheckbox4" and funcName =="OnBetCheckBox4" then
            local function OnBetCheckBox41(  node,eventType )  
                selfObj:OnBetCheckBox4( node,  eventType )
            end  
            return OnBetCheckBox41
        end
        --点击5bet
        if node:getName()=="betcheckbox5" and funcName =="OnBetCheckBox5" then
            local function OnBetCheckBox51(  node,eventType )  
                selfObj:OnBetCheckBox5( node,  eventType )
            end  
            return OnBetCheckBox51
        end
        --点击deal
        if node:getName()=="dealbutton" and funcName =="OnDealButton" then
            local function OnDealButton1(  node,eventType )  
                selfObj:OnDealButton( node,  eventType )
            end  
            return OnDealButton1
        end
        --点击第一张牌
        if node:getName()=="pokerbutton1" and funcName =="OnPokerButton1" then
            local function OnPokerButton11(  node,eventType )  
                selfObj:OnPokerButton( node,  eventType )
            end  
            return OnPokerButton11
        end
        --点击第二张牌
        if node:getName()=="pokerbutton2" and funcName =="OnPokerButton2" then
            local function OnPokerButton21(  node,eventType )  
                selfObj:OnPokerButton( node,  eventType )
            end  
            return OnPokerButton21
        end
        --点击第三张牌
        if node:getName()=="pokerbutton3" and funcName =="OnPokerButton3" then
            local function OnPokerButton31(  node,eventType )  
                selfObj:OnPokerButton( node,  eventType )
            end  
            return OnPokerButton31
        end
        --点击第四张牌
        if node:getName()=="pokerbutton4" and funcName =="OnPokerButton4" then
            local function OnPokerButton41(  node,eventType )  
                selfObj:OnPokerButton( node,  eventType )
            end  
            return OnPokerButton41
        end
        --点击第五张牌
        if node:getName()=="pokerbutton5" and funcName =="OnPokerButton5" then  
            local function OnPokerButton51(  node,eventType )  
                selfObj:OnPokerButton( node,  eventType )
            end  
            return OnPokerButton51
        end
    end  

    selfObj.miPagObj = PromptNode.create(callBackProvider)
    selfObj.miPagObj['root']:retain()

    selfObj.miEventMgr:AddListen( G_Fy.MiniGamegLobal:GetMiniConfig("MSG_MINI_POJER_ENUM", "MSG_TYPE_ENUM_MINIGAME_CSMINIGAMESTART"), InitPoker, 5, selfObj)
    selfObj.miEventMgr:AddListen( G_Fy.MiniGamegLobal:GetMiniConfig("MSG_MINI_POJER_ENUM", "MSG_TYPE_ENUM_MINIGAME_DOUBLEPOKER"), DoublePoker, 5, selfObj)
    selfObj.miEventMgr:AddListen( G_Fy.MiniGamegLobal:GetMiniConfig("MSG_MINI_POJER_ENUM", "MSG_TYPE_ENUM_MINIGAME_COMPAREPOKER"), compareDouble, 5, selfObj)
    selfObj.miEventMgr:AddListen( G_Fy.MiniGamegLobal:GetMiniConfig("MSG_MINI_POJER_ENUM", "MSG_TYPE_ENUM_MINIGAME_CHANGEEPOKER"), ChangePoker, 5, selfObj)
    selfObj.miEventMgr:AddListen( G_Fy.MiniGamegLobal:GetMiniConfig("MSG_MINI_POJER_ENUM", "MSG_TYPE_ENUM_MINIGAME_INIT"), MiniGameIniRsp, 5, selfObj)
    selfObj.miEventMgr:AddListen( MSG_TYPE_ENUM.MSG_TYPE_ENUM_MINIGAME_TIMEOUT, SessionTimeOut, 5, selfObj)
    selfObj.miEventMgr:AddListen( MSG_TYPE_ENUM.MSG_TYPE_ENUM_MINIGAME_SEND_FAIL, MiniGameSendFail, 5, selfObj)

    selfObj.miEventMgr:AddListen( MSG_MINI_PUBLIC_ENUM.MSG_TYPE_ENUM_MINIGAME_REFRESH_COIN, OnSubRefreshUserCoin, 5, selfObj)
    selfObj.miEventMgr:AddListen( MSG_MINI_PUBLIC_ENUM.MSG_TYPE_ENUM_MINIGAME_EXIT, OnSubExitMiniGame, 5, selfObj)
    selfObj.miEventMgr:AddListen( MSG_TYPE_ENUM.MSG_TYPE_ENUM_MINIGAME_SEND_INIT, sendMiniGameIni, 5, selfObj)

end

--点击关闭
function OnCloseButton( selfObj, node, eventType )
    My_Lua_log(" file=[minigamemainscenepag] fun=[OnCloseButton];")

    require("proto.TexasPokerMiniGame_pb")
    local tPacke = TexasPokerMiniGame_pb.CSMiniGameExit()
    tPacke.uuid = selfObj.miGameRoom:GetUuid()
    local tBuff = tPacke:SerializeToString()
    cc.CClientPlatform:sharedClientPlatform():SendHttpMiniGamePacket(TexasPokerCmd_pb.Cmd_CSMiniGameExit ,tBuff, #tBuff, MINIGAME_POKERMACHINE_TYPE)

    local aiEvent = {}
    aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_CLOSE_PAG
    aiEvent.miPagName = "minigamemainscenepag"
    aiEvent.miData = {}
    selfObj.miEventMgr:Dispatch(aiEvent)

    --切换到IOS界面
    G_Fy.miNetMgr:StopGame(selfObj.miGameRoom:GetGameRoomId())

    local aiEvent = {}
    aiEvent.type = SYSTEM_MSG_TYPE_ENUM.SYSTEM_MSG_TYPE_ENUM_SCENE_EXIST_COCOS2DX
    aiEvent.miData = {}
    aiEvent.miData.miType = 0
    aiEvent.miData.miRoomName = ""
    G_Fy:GetFyEvent():NextDispatch(aiEvent)



    --cc.CClientPlatform:sharedClientPlatform():StopGame(0, "")
end

--点击info
function OnInfoButton( selfObj, node, eventType )
    My_Lua_log(" file=[minigamemainscenepag] fun=[OnInfoButton];")
    cc.CClientPlatform:sharedClientPlatform():GoToMiniGameGoToPokerMachineInfo()
end

--点击免费
function OnFreeButton( selfObj, node, eventType )
    My_Lua_log(" file=[minigamemainscenepag] fun=[onfreebutton];")
end
--点击翻倍
function OnDoubleButton( selfObj, node, eventType )  
    --gamechangestate 结束
    cc.SimpleAudioEngine:getInstance():playEffect("audio/donclick.mp3")
    if Local_State ~= selfObj.STATE_ENUM[1] then        
        My_Lua_log("file=[minigamescenepag] fun=[OnDoubleButton]")
        if Local_State == selfObj.STATE_ENUM[4] or
            Local_State == selfObj.STATE_ENUM[5] or
            Local_State == selfObj.STATE_ENUM[8] then
            --gamedoublestate 开始   
            Local_State = "gDouble_Began"
            selfObj.IsLogging = true
			selfObj:LoadingTime()
            My_Lua_log(" file=[minigamemainscenepag] fun=[ondoublebutton] state=[gamedoublestate]")
            selfObj.IsDouble = false
            selfObj.miPagObj["doublebutton"]:setEnabled(selfObj.IsDouble)
            selfObj.miPagObj['dealbutton']:setEnabled(false) 
            function OnCallback()
                My_Lua_log("file=[minigamescenepag] fun=[OnCallback] state=[gamedoublestate]")
                --发送协议  
                --返回第一张牌
                require("proto.TexasPokerMiniGame_pb")
                local tPacke = TexasPokerMiniGame_pb.CSMiniGameDouble()
                tPacke.uuid = selfObj.miGameRoom:GetUuid()
                local tBuff = tPacke:SerializeToString()
                cc.CClientPlatform:sharedClientPlatform():SendHttpMiniGamePacket(TexasPokerCmd_pb.Cmd_CSMiniGameDouble , tBuff, #tBuff, MINIGAME_POKERMACHINE_TYPE)     
            end
            if selfObj.dClose == false then      
                My_Lua_log("file=[minigamescenepg] fun=[OnDoubleButton] selfObj.dClose = "..tostring(selfObj.dClose))
                selfObj.dClose = true
                --翻倍 背牌动画
                for i=1,5 do
                    if i == 1 then
                        selfObj.pkData[i].PK:runAction(cc.Sequence:create(selfObj.pkData[i].Action["action_just"]:clone(),cc.DelayTime:create(0.2),cc.CallFunc:create(OnCallback)))
                    else
                        selfObj.pkData[i].PK:runAction(selfObj.pkData[i].Action["action_just"]:clone())
                    end       
                    selfObj.miPagObj["pokertext"..i]:setVisible(false)
                end   
            else
                OnCallback()
            end
            --清除 翻倍点击红框...
            for clear = 1, 5 do
                selfObj.pkData[clear].PK:removeAllChildren()
                selfObj.miPagObj["betcheckbox"..clear]:setEnabled(false)
                selfObj.miPagObj['bet'..clear]:setVisible(false)
            end
            --设置stateimage
            selfObj.miPagObj["stateimage"]:loadTexture(STR_TEXT_POKER_GOODLUCK)
        end
    end
end

-- 翻倍 牌  
function DoublePoker(selfObj,aiEvent)
    --返回double协议返回第一张牌
    My_Lua_log("file = [minigamescenepag] fun = [DoublePoker]")

    selfObj:InitNetData(aiEvent, TexasPokerCmd_pb.Cmd_CSMiniGameDouble)

    selfObj.dClose = false
    selfObj.Once = true
    --加载界面出现保护
    selfObj.IsLogging = false
    --取消加载
    selfObj:CenterLoadingTime()   
    selfObj.IsTwo = true
    function OnCallback()
        --gamecheckstate 点击牌            
        Local_State = "gDouble_End"   
        selfObj:setState(4)
        --selfObj:StateMachine()     
    end
    
    if aiEvent.miData.iFlag ~= nil then
        selfObj:CloseLoading()
        selfObj.miPagObj["currencytext"]:setString(aiEvent.miData.iCurCoin)
        selfObj.miPagObj["wintext"]:setString(aiEvent.miData.iPoolCoin)
        My_Lua_log("file=[minigamescenepag fun=[DoublePoker] wintwxt="..aiEvent.miData.iPoolCoin)
        --初始化第一张牌
        selfObj.pkData[1].PK:setTexture( string.format(G_Fy.MiniGamegLobal:GetMiniConfig("STR_TEXT_POKER_FACECARD"), aiEvent.miData.iCard))
        local sequence = cc.Sequence:create(selfObj.pkData[1].Action["action_against"]:clone(),cc.CallFunc:create(OnCallback))    
        selfObj.pkData[1].Back:runAction(sequence) 
    else
        --初始化第一张牌
        selfObj.pkData[1].PK:setTexture( string.format(G_Fy.MiniGamegLobal:GetMiniConfig("STR_TEXT_POKER_FACECARD"), aiEvent.miData.iCard))
        local sequence = cc.Sequence:create(cc.DelayTime:create(0.5),selfObj.pkData[1].Action["action_against"]:clone(),cc.CallFunc:create(OnCallback))    
        selfObj.pkData[1].Back:runAction(sequence)  
    end
      
end

--点击  牌
function OnPokerButton( selfObj, node, eventType )
    My_Lua_log(" file=[minigamemainscenepag] fun=[onpokerbutton];")
    cc.SimpleAudioEngine:getInstance():playEffect("audio/pokersound.mp3")
    --动画开始牌不能点击
    local clickNode
    for i = 1, 5  do
        if selfObj.miPagObj["pokerbutton"..i] == node then
            clickNode = i
            My_Lua_log("file=[minigamescenepag] fun=[OnPokerButton] clickNode=["..clickNode.."]")
        end
    end
    if clickNode == nil then
        return 
    end

    if Local_State == selfObj.STATE_ENUM[2] then
        if selfObj.pkData[clickNode].isClick then
            selfObj.pkData[clickNode].isClick =false
            selfObj.miPagObj["pokertext"..clickNode]:setVisible(selfObj.pkData[clickNode].isClick)  
        else
            selfObj.pkData[clickNode].isClick = true 
            selfObj.miPagObj["pokertext"..clickNode]:setVisible(selfObj.pkData[clickNode].isClick)
        end
        --设置HELD动画
        local sq = cc.Sequence:create(cc.ScaleTo:create(0.1, 1.4,1.4,0), cc.ScaleTo:create(0.1, 1,1,1))
        selfObj.miPagObj["pokertext"..clickNode]:runAction(sq)  
    elseif Local_State == selfObj.STATE_ENUM[6] or
        Local_State == selfObj.STATE_ENUM[7] then
        --gamecheck 开始
        Local_State = "gCheck_Began"
        My_Lua_log("file=[minigamescenepag] fun=[OnPokerButton] state = gamecheckstate")
        --加载
        selfObj:LoadingTime()
        selfObj.IsLogging = true
        if selfObj.Once == true then
            selfObj.Once = false           
            selfObj.doubleIndex = clickNode
            My_Lua_log("file=[minigamescenepag] fun=[OnPokerButton] [once] clinode = "..selfObj.doubleIndex)
            selfObj.doubleIndex = clickNode - 1
            --发送协议获取四张牌 带入（clickNode - 1）
            --发送协议 选牌比大小
            My_Lua_log(" file=[minigamemainscenepag] fun=[OnPokerButton] 发送协议;")
            require("proto.TexasPokerMiniGame_pb")
            local tPacke = TexasPokerMiniGame_pb.CSMiniGameCheck()
            tPacke.uuid = selfObj.miGameRoom:GetUuid()
            tPacke.iSeq = selfObj.doubleIndex
            local tBuff = tPacke:SerializeToString()
            cc.CClientPlatform:sharedClientPlatform():SendHttpMiniGamePacket(TexasPokerCmd_pb.Cmd_CSMiniGameCheck  , tBuff, #tBuff, MINIGAME_POKERMACHINE_TYPE)                 
        end        
    end
end

--返回四张牌 （MiniGameCheck协议）
function compareDouble(selfObj,aiEvent)
    My_Lua_log("file=[minigamescenepag] fun=[compareDouble]")
    
    selfObj:InitNetData(aiEvent, TexasPokerCmd_pb.Cmd_CSMiniGameCheck)

    selfObj.IsLogging = false
    selfObj:CenterLoadingTime()  
    if aiEvent.miData.iFlag ~= nil then
        selfObj:CloseLoading()
        selfObj.IsTwo = true
        My_Lua_log("file=[minigamescenepag] fun=[compareDouble] iFlag="..aiEvent.miData.iFlag)
        selfObj.miPagObj["currencytext"]:setString(aiEvent.miData.iCurCoin)
        selfObj.miPagObj["wintext"]:setString(aiEvent.miData.iPoolCoin)
        My_Lua_log("file=[minigamescenepag fun=[compareDouble] wintwxt="..aiEvent.miData.iPoolCoin)
        for i = 1, 5  do
            selfObj.pkData[i].PK:setTexture( string.format(G_Fy.MiniGamegLobal:GetMiniConfig("STR_TEXT_POKER_FACECARD"), aiEvent.miData.vCards[i]))   
            selfObj.pkData[i].Back:runAction(selfObj.pkData[i].Action["action_against"]:clone())
            selfObj.miPagObj["pokerbutton"..i]:setEnabled(false)
        end
        --玩家赢
        if aiEvent.miData.eResult == 9001 then
            selfObj.IsDouble = true
            --设置stateimage
            selfObj.miPagObj["stateimage"]:loadTexture(STR_TEXT_POKER_YOUWIN)
        elseif aiEvent.miData.eResult == 9002 then
            selfObj.IsDouble = true
        else
            selfObj.IsDouble = false
        end
    else
        My_Lua_log("file=[minigamescenepag] fun=[compareDouble] iFlag=nil")
        for i = 2, 5  do
            selfObj.pkData[i].PK:setTexture( string.format(G_Fy.MiniGamegLobal:GetMiniConfig("STR_TEXT_POKER_FACECARD"), aiEvent.miData.vCards[i - 1]))   
            selfObj.pkData[i].Back:runAction(selfObj.pkData[i].Action["action_against"]:clone())
            selfObj.miPagObj["pokerbutton"..i]:setEnabled(false)
        end
        --创建选中框
        local cardImage = cc.Sprite:create(G_Fy.MiniGamegLobal:GetMiniConfig("USER_STATE_IMAGE", "POKER_SELECTED_ICON"))--("STR_TEXT_POKER_CARD"))
        --cardImage:setScale(G_Android_Scale_Ratio)
        cardImage:setAnchorPoint(0,0)
        selfObj.pkData[selfObj.doubleIndex + 1].PK:addChild(cardImage,Local_Pubic_Card_Tag)
        --玩家赢
        if aiEvent.miData.eResult == 9001 then
            selfObj.IsDouble = true
            selfObj.miPagObj["doublebutton"]:setEnabled(selfObj.IsDouble)
            selfObj.iPoolCoin = selfObj.iPoolCoin * 2
            --设置奖池中德扑币
            selfObj.miPagObj["wintext"]:setString(aiEvent.miData.iPoolCoin)
            --设置stateimage
            selfObj.miPagObj["stateimage"]:loadTexture(STR_TEXT_POKER_YOUWIN)
        elseif aiEvent.miData.eResult == 9002 then
            selfObj.IsDouble = true
            selfObj.miPagObj["doublebutton"]:setEnabled(selfObj.IsDouble)
            selfObj.iPoolCoin = selfObj.iPoolCoin
            --设置奖池中德扑币
            selfObj.miPagObj["wintext"]:setString(aiEvent.miData.iPoolCoin)
        else
            selfObj.IsDouble = false
            selfObj.iPoolCoin = 0
            selfObj.miPagObj["wintext"]:setString(aiEvent.miData.iPoolCoin)
        end
    end        
    
    --gamecheck状态 结束
    Local_State = "gCheck_End"
    if selfObj.IsDouble then
        selfObj:setState(3)
        cc.SimpleAudioEngine:getInstance():playEffect("audio/donwin.mp3")
    else
        selfObj:setState(1)
        cc.SimpleAudioEngine:getInstance():playEffect("audio/donlose.mp3")
    end 
end

--点击1bet
function OnBetCheckBox1( selfObj, node, eventType )
    My_Lua_log(" file=[minigamemainscenepag] fun=[onbetcheckbox1];")
    selfObj:OnChaginBetCheckBox(1) 
end
--点击2bet
function OnBetCheckBox2( selfObj, node, eventType )
    My_Lua_log(" file=[minigamemainscenepag] fun=[onbetcheckbox2];")
    selfObj:OnChaginBetCheckBox(2)
end
--点击3bet
function OnBetCheckBox3( selfObj, node, eventType )
    My_Lua_log(" file=[minigamemainscenepag] fun=[onbetcheckbox3];")
    selfObj:OnChaginBetCheckBox(3)
end
--点击4bet
function OnBetCheckBox4( selfObj, node, eventType )
    My_Lua_log(" file=[minigamemainscenepag] fun=[onbetcheckbox4];")
    selfObj:OnChaginBetCheckBox(4)
end

--点击5bet
function OnBetCheckBox5( selfObj, node, eventType )
    My_Lua_log(" file=[minigamemainscenepag] fun=[onbetcheckbox5];")
    selfObj:OnChaginBetCheckBox(5)
end

--改变bet
function OnChaginBetCheckBox(selfObj, aiIndex )
    My_Lua_log("file=[minigamescenepag] fuu=[OnChaginBetCheckBox]")
    --if Local_State ~= selfObj.STATE_ENUM[1] then
    --    if Local_State == selfObj.STATE_ENUM[4] or
     --       Local_State == selfObj.STATE_ENUM[8] or
     --       selfObj.IsTwo == false then
    cc.SimpleAudioEngine:getInstance():playEffect("audio/betclick.mp3")  
            selfObj.aiIndex = aiIndex
            --设置选中bet 按钮红框
            for i = 1, 5 do
                if i ==  aiIndex then
                    selfObj.miPagObj['bet'..i]:setVisible(true)
                else
                    selfObj.miPagObj['bet'..i]:setVisible(false)
                end        
            end

            if aiIndex == 0 then
                for boxs = 1, 5 do
                    selfObj.miPagObj['betcheckbox'..boxs]:setEnabled(false)
                end
            else
                selfObj.miSelBetIndex = aiIndex - 1
            end
     --   end
    --end
end

function sendMiniGameIni( selfObj, aiEvent )
    require("proto.TexasPokerMiniGame_pb")
    local tPacke = TexasPokerMiniGame_pb.CSMiniGameIni()
    tPacke.uuid = selfObj.miGameRoom:GetUuid()
    local tBuff = tPacke:SerializeToString()
    cc.CClientPlatform:sharedClientPlatform():SendHttpMiniGamePacket(TexasPokerCmd_pb.Cmd_CSMiniGameIni , tBuff, #tBuff, MINIGAME_POKERMACHINE_TYPE)  
end

---------------------------------------------------------------
--改变UI位置
function ChangePos(selfObj, aiWidth, aiHeight)
    selfObj.miPagObj['root']:setPosition(aiWidth, aiHeight)
end

--刷新数据
function OnOpen(selfObj)
    My_Lua_log(" file=[minigamemainscenepag] fun=[onopen];")
    Local_UiBase:OnOpen()
    --初始化动态数据
    selfObj:InitializeDynamicData()

    selfObj.miPagObj['wintipsimage']:setVisible(false)

    selfObj.miPagObj['infobutton']:setVisible(true)
    selfObj.miPagObj['doublebutton']:setEnabled(false)
    selfObj.wintipsPosY =selfObj.miPagObj['wintipsimage']:getPositionY()
    selfObj.miPagObj["currencytext"]:setString(0) --(G_Fy.GamegLobal:GetCoin())
    
    --创建五张背牌
    selfObj:BackPoker()
    for default = 1, 5 do
        --创建五张默认牌
        selfObj:CreateDefaultPoker(default)
        --隐藏HELD
        selfObj.miPagObj['pokertext'..default]:setVisible(false)
    end
     
    --发送协议  初始化小游戏
    My_Lua_log(" file=[minigamemainscenepag] fun=[Init] 发送协议;")
    require("proto.TexasPokerMiniGame_pb")
    local tPacke = TexasPokerMiniGame_pb.CSMiniGameIni()
    tPacke.uuid = selfObj.miGameRoom:GetUuid()
    local tBuff = tPacke:SerializeToString()
    cc.CClientPlatform:sharedClientPlatform():SendHttpMiniGamePacket(TexasPokerCmd_pb.Cmd_CSMiniGameIni , tBuff, #tBuff, MINIGAME_POKERMACHINE_TYPE)   

    local aiEventPag = {}
    aiEventPag.type = PUBLIC_MSG_TYPE_ENUM.PUBLIC_MSG_TYPE_ENUM_SHOW_LOADING_PAG
    aiEventPag.miPagName = "lodingpag"
    aiEventPag.miData = {}
    aiEventPag.miData.miIsShow = true
    selfObj.miEventMgr:Dispatch(aiEventPag)
end

--创建五张默认背牌
function BackPoker(selfObj)
    for back = 1, 5 do
        My_Lua_log("BackPoker="..tostring(G_Fy.MiniGamegLobal:GetMiniConfig("USER_STATE_IMAGE", "POKER_BACK_ICON")))
        local tPokerBack1 = cc.Sprite:create(G_Fy.MiniGamegLobal:GetMiniConfig("USER_STATE_IMAGE", "POKER_BACK_ICON"))
        tPokerBack1:setScale(G_Android_Scale_Ratio / 2)
        selfObj.miPagObj["pokerrootnode"..back]:addChild(tPokerBack1, Local_Pubic_Poker2_Back_Tag, Local_Pubic_Poker2_Back_Tag)
        selfObj.pkData[back].Back = tPokerBack1
    end
end

--创建默认牌
function CreateDefaultPoker(selfObj, aiNodeName)
    ------------------------------------------------------------------
    selfObj.pkData[aiNodeName].aiNodeName = aiNodeName
    selfObj.pkData[aiNodeName].isClick = false

    selfObj.miPagObj["pokerbutton"..aiNodeName]:removeAllChildren()

    local PK = cc.Sprite:create(G_Fy.MiniGamegLobal:GetMiniConfig("USER_STATE_IMAGE", "POKER_BACK_ICON"))
    PK:setScale(G_Android_Scale_Ratio / 2)
    selfObj.miPagObj["pokerrootnode"..aiNodeName]:addChild(PK, Local_Pubic_Poker1_Tag, Local_Pubic_Poker1_Tag)
    selfObj.pkData[aiNodeName].PK = PK
    selfObj.pkData[aiNodeName].PK:setVisible(false)


    selfObj.miPagObj["pokerbutton"..aiNodeName]:setEnabled(false)
    selfObj.miPagObj["pokerbutton"..aiNodeName]:setScale(0.9)
    selfObj.miPagObj["pokerbutton"..aiNodeName]:loadTextureDisabled(G_Fy.MiniGamegLobal:GetMiniConfig("STR_TEXT_POKER_GRAY"))
    --正
    local tOrbitFront1 = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 90, -90, 0 , 0)
    local tOrbitBack1 = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 0, -90, 0 , 0)
    
    local tOrbitFront2 = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 90, -90, 0 , 0)
    local tOrbitBack2 = cc.OrbitCamera:create(Local_Flip_Time, 0.5, 0, 0, -90, 0 , 0)

    --正-反
    selfObj.pkData[aiNodeName].Action["action_just"] = cc.Sequence:create(cc.Show:create(), tOrbitBack2, cc.Hide:create(), cc.TargetedAction:create(selfObj.pkData[aiNodeName].Back, cc.Sequence:create(cc.Show:create(), tOrbitFront2)))
    selfObj.pkData[aiNodeName].Action["action_just"]:retain()
    --反-正
    selfObj.pkData[aiNodeName].Action["action_against"] = cc.Sequence:create(cc.Show:create(), tOrbitBack1, cc.Hide:create(), cc.TargetedAction:create(selfObj.pkData[aiNodeName].PK, cc.Sequence:create(cc.Show:create(), tOrbitFront1)))
    selfObj.pkData[aiNodeName].Action["action_against"]:retain()
end

--点击deal
function OnDealButton( selfObj, node, eventType )  
    My_Lua_log(" file=[minigamemainscenepag] fun=[ondealbutton];")
    cc.SimpleAudioEngine:getInstance():playEffect("audio/menuclick.mp3")  
    --翻牌动画列表
    selfObj.flipActionList = {}
    --闭牌动画列表
    selfObj.closeActionList = {}
    selfObj.miPagObj["doublebutton"]:setEnabled(false)
    selfObj.IsLogging = true
    selfObj.wintipsIndex = nil
    for i = 1, 5 do
        selfObj.miPagObj['pokerbutton'..i]:setEnabled(false)
        selfObj.miPagObj['betcheckbox'..i]:setEnabled(false)
        selfObj.miPagObj['bet'..i]:setVisible(false)
    end        
    selfObj.miPagObj['dealbutton']:setEnabled(false)
    if selfObj.IsTwo then       
        selfObj:CloseActionList() 
        cc.SimpleAudioEngine:getInstance():playEffect("audio/pokersound.mp3")               
    else 
        --加载
        selfObj:LoadingTime()
        --gamestartstate状态 开始
        Local_State = "gStart_Began"
        --发送协议  初始化五张牌
        My_Lua_log(" file=[minigamemainscenepag] fun=[OnDealButton] 发送协议;")
        require("proto.TexasPokerMiniGame_pb")
        local tPacke = TexasPokerMiniGame_pb.CSMiniGameStart()
        tPacke.uuid = selfObj.miGameRoom:GetUuid()
        tPacke.iBet = selfObj.miSelBetIndex
        local tBuff = tPacke:SerializeToString()
        cc.CClientPlatform:sharedClientPlatform():SendHttpMiniGamePacket(TexasPokerCmd_pb.Cmd_CSMiniGameStart , tBuff, #tBuff, MINIGAME_POKERMACHINE_TYPE)                      
    end
end

function InitNetData(selfObj, aiEvent, aiCmd)
    --设置数据
    --selfObj.miMiniGameData = {}
    selfObj.miMiniGameData.eCmd = aiCmd

    selfObj.miMiniGameData.vCards = aiEvent.miData.vCards
    selfObj.miMiniGameData.iCurCoin = aiEvent.miData.iCurCoin
    selfObj.miMiniGameData.iPoolCoin = aiEvent.miData.iPoolCoin
    selfObj.miMiniGameData.iFlag = aiEvent.miData.iFlag

    selfObj.miMiniGameData.iCard = aiEvent.miData.iCard
--    selfObj.miMiniGameData.iCurCoin = tRsp.iCurCoin
--    selfObj.miMiniGameData.iPoolCoin = tRsp.iPoolCoin
--    selfObj.miMiniGameData.iFlag = tRsp.iFlag

    selfObj.miMiniGameData.vCards = aiEvent.miData.vCards
    selfObj.miMiniGameData.ePattern = aiEvent.miData.ePattern

    selfObj.miMiniGameData.vCards = aiEvent.miData.vCards
    selfObj.miMiniGameData.eResult = aiEvent.miData.eResult
end

function Reset(selfObj)
My_Lua_log("file=[minigamescenepag],fun=[Reset]")
    local aiEvent = {}
    aiEvent.miData = selfObj.miMiniGameData
    aiEvent.miData.iFlag = 1
My_Lua_log("file=[minigamescenepag],fun=[Reset]   cmd="..aiEvent.miData.eCmd)
    if aiEvent.miData.eCmd == TexasPokerCmd_pb.Cmd_CSMiniGameStart then
        selfObj:InitPoker(aiEvent)
    elseif aiEvent.miData.eCmd == TexasPokerCmd_pb.Cmd_CSMiniGameChange then
        selfObj:ChangePoker(aiEvent)
    elseif aiEvent.miData.eCmd == TexasPokerCmd_pb.Cmd_CSMiniGameCheck then
        selfObj:compareDouble(aiEvent)
    elseif aiEvent.miData.eCmd == TexasPokerCmd_pb.Cmd_CSMiniGameDouble then
        selfObj:DoublePoker(aiEvent)
    end
end

function OnSubRefreshUserCoin( selfObj, aiEvent )
    My_Lua_log(" file=[minigamescenepag] fun=[OnSubRefreshUserCoin]; ")

    selfObj.miPagObj["currencytext"]:setString(aiEvent.miData.lCurCoin)
end

--获得五张牌 （MiniGameStart协议）
function InitPoker(selfObj, aiEvent)
    My_Lua_log("file=[minigamescenepag],fun=[InitPoker]")    

    selfObj:InitNetData(aiEvent, TexasPokerCmd_pb.Cmd_CSMiniGameStart)

    selfObj.close = false
    Local_State = "gStart_Began"
	selfObj.IsLogging = false
    selfObj:CenterLoadingTime() 
    --第一次点击deal按钮
    selfObj.IsTwo = true 
    for i=1,5 do
        selfObj.pkData[i].PK:setTexture( string.format(G_Fy.MiniGamegLobal:GetMiniConfig("STR_TEXT_POKER_FACECARD"), aiEvent.miData.vCards[i]))       
    end
    selfObj.miPagObj["wintext"]:setString("0")
    selfObj.miPagObj["currencytext"]:setString(aiEvent.miData.iCurCoin)   
    if aiEvent.miData.iFlag ~= nil then   
        selfObj:CloseLoading()
        for i=1,5 do
--            selfObj.pkData[i].PK:setVisible(true)
--            selfObj.pkData[i].Back:setVisible(false)
            selfObj.pkData[i].Back:runAction(selfObj.pkData[i].Action["action_against"]:clone())
        end
        Local_State = "gStart_End"
        selfObj:setState(2)
    else
        selfObj:FlipActionList()
    end
end

--设置 wintipsimage 位置
function WintipsImageAction(selfObj,index)
    My_Lua_log("file=[minigamescenepag] fun=[WintipsImageAction]")
    selfObj.miPagObj['wintipsimage']:setVisible(true)
    local wPosX = selfObj.miPagObj['wintipsimage']:getPositionX()
    local wSize = selfObj.miPagObj['wintipsimage']:getSize()
    selfObj.miPagObj['wintipsimage']:setPosition(wPosX,wSize.height*index+selfObj.wintipsPosY) 
    selfObj.wintipsIndex = nil
end


--小游戏初始化
function MiniGameIniRsp(selfObj,aiEvent)
    My_Lua_log("file=[minigamescenepag] fun=[MiniGameIniRsp]") 
    selfObj.miPagObj["currencytext"]:setString(aiEvent.miData.iCurCoin)   
    selfObj:setState(1)
end

--翻牌动画列表
function FlipActionList(selfObj)
    My_Lua_log("file=[minigamescenepag] fun=[FlipActionList]")
    for i = 1, 5 do
        table.insert(selfObj.flipActionList,selfObj.pkData[i].Back)
    end

    cc.SimpleAudioEngine:getInstance():playEffect("audio/pokersound.mp3") 
    selfObj:FlipPokerAction(selfObj.flipActionList)
end

--翻牌动画
function FlipPokerAction(selfObj, aiActionList)
    My_Lua_log(" file=[minigamemainscenepag] fun=[FlipPokerAction];  aiNodeName=[]")
    selfObj.onces = true

    function OnCallback()
        for i = 1,#selfObj.pkData do
            if selfObj.pkData[i].isClick then
                selfObj.pkData[i].PK:setVisible(true)
            end
        end
          
        if Local_State == selfObj.STATE_ENUM[1] then 
            --gamestart状态  结束
            Local_State = "gStart_End"
            selfObj:setState(2)
        elseif Local_State == selfObj.STATE_ENUM[3] then
            selfObj.miPagObj["wintext"]:setString(selfObj.iPoolCoin)
            --gamechange状态 结束
            Local_State = "gChange_End"              
            if selfObj.IsDouble then
                selfObj:setState(3)
            else
                selfObj:setState(1)
            end                       
        end         
    end
    --判断 翻牌动作
    if Local_State == selfObj.STATE_ENUM[3] then
        if #selfObj.pos == 0 then           
            My_Lua_log("file=[minigamescene] fun=[FlipPokerAction] selfpos == [ "..#selfObj.pos.." ]")
            OnCallback()
        else
            My_Lua_log("file=[minigamescene] fun=[FlipPokerAction] selfpos == [ "..#selfObj.pos.." ]")
            for i = 1,#selfObj.pos  do
                local tIndex = selfObj.pos[i]
                local tAct = cc.Sequence:create(selfObj.pkData[tIndex].Action["action_against"])
                if i == #selfObj.pos then
                    tAct = cc.Sequence:create(
                        selfObj.pkData[tIndex].Action["action_against"],
                        cc.CallFunc:create(OnCallback))
                end
                selfObj.pkData[tIndex].PK:setVisible(false) 
                selfObj.pkData[tIndex].Back:stopAllActions()
                selfObj.pkData[tIndex].Back:runAction(tAct)
                selfObj.onces = false 

            end
            if selfObj.onces then
                My_Lua_log("file=[minigamescene] fun=[FlipPokerAction] onces ...")
                OnCallback()
            end
        end        
    elseif Local_State == selfObj.STATE_ENUM[1] then
        for i = 1,#aiActionList do
            local tAct = cc.Sequence:create(selfObj.pkData[i].Action["action_against"])
            if i == #aiActionList then
                tAct = cc.Sequence:create(
                    selfObj.pkData[i].Action["action_against"],
                    cc.CallFunc:create(OnCallback))
            end
            selfObj.pkData[i].PK:setVisible(false) 
            aiActionList[i]:stopAllActions()
            aiActionList[i]:runAction(tAct)
        end
    end 
end

--闭牌动画列表
function CloseActionList(selfObj)
    My_Lua_log("file=[minigamescenepag] fun=[CloseActionList]")    
    --不等于gamedouble 结束
    if Local_State ~= selfObj.STATE_ENUM[5] then   

        --gamechangestate 结束
        if Local_State == selfObj.STATE_ENUM[2] 
            or Local_State == selfObj.STATE_ENUM[3] then
            --从前往后闭牌 gamechangestate  开始
            Local_State = "gChange_Began"         
            My_Lua_log("file=[minigamescenepag] fun=[gamechangestate is began]") 
            for k = 1,5 do
                selfObj.miPagObj["pokerbutton"..k]:setEnabled(false)
                table.insert(selfObj.closeActionList,selfObj.pkData[k].PK)
            end                           
        elseif Local_State == selfObj.STATE_ENUM[4] or
            Local_State == selfObj.STATE_ENUM[1] or
            Local_State == selfObj.STATE_ENUM[8] then       
            --从后往前闭牌 gamestartstate  开始
            Local_State = "gStart_Began"        
            My_Lua_log("file=[minigamescenepag] fun=[gamestartstate is began]")
            for i = 1 ,5  do
                selfObj.pkData[i].isClick = false
                table.insert(selfObj.closeActionList,selfObj.pkData[i].PK)
                selfObj.pkData[i].PK:removeAllChildren()
                selfObj.miPagObj["pokertext"..i]:setVisible(false)
            end
            selfObj.miPagObj["stateimage"]:loadTexture(STR_TEXT_POKER_GOODLUCK)
            selfObj.miPagObj['wintipsimage']:setVisible(false)            
        end           

        selfObj:ClosePokerAction(selfObj.closeActionList)   
    end
end

--闭牌动画
function ClosePokerAction(selfObj, aiActionList)
    My_Lua_log(" file=[minigamemainscenepag] fun=[closepokeraction];")

    function OnCallback()   
    My_Lua_log(" file=[minigamemainscenepag] fun=[ClosePokerAction]; fun=[OnCallback]") 
        if Local_State == selfObj.STATE_ENUM[1] then          
            --加载
            selfObj:LoadingTime()                
            selfObj.close = true  
            selfObj.pos = {}           
            --发送协议  初始化五张牌
            My_Lua_log(" file=[minigamemainscenepag] fun=[OnCallback] 发送协议;")
            require("proto.TexasPokerMiniGame_pb")
            local tPacke = TexasPokerMiniGame_pb.CSMiniGameStart()
            tPacke.uuid = selfObj.miGameRoom:GetUuid()
            tPacke.iBet = selfObj.miSelBetIndex
            local tBuff = tPacke:SerializeToString()
            cc.CClientPlatform:sharedClientPlatform():SendHttpMiniGamePacket(TexasPokerCmd_pb.Cmd_CSMiniGameStart , tBuff, #tBuff, MINIGAME_POKERMACHINE_TYPE)

        elseif Local_State == selfObj.STATE_ENUM[3] then          
            --加载
            selfObj:LoadingTime()                         
            --发送协议  换牌
            selfObj.close = true
            selfObj.pos = {}
            My_Lua_log(" file=[minigamemainscenepag] fun=[ClosePokerAction] 发送协议;")
            require("proto.TexasPokerMiniGame_pb")
            local tPacke = TexasPokerMiniGame_pb.CSMiniGameChange()
            tPacke.uuid = selfObj.miGameRoom:GetUuid()
            --tPacke.vSeqs = {}
            for index = 0, 4 do
                if selfObj.pkData[index+1].isClick == true then
                    table.insert(tPacke.vSeqs, index)
                else
                    My_Lua_log("file=[minigamescenepag] fun=[ClosePokerAction] selfObj.pos=["..index.."]")
                    table.insert(selfObj.pos, index + 1)                        
                end
            end
            local tBuff = tPacke:SerializeToString()
            cc.CClientPlatform:sharedClientPlatform():SendHttpMiniGamePacket(TexasPokerCmd_pb.Cmd_CSMiniGameChange , tBuff, #tBuff, MINIGAME_POKERMACHINE_TYPE)                               
        end       
    end   
    if selfObj.close == false then
        --翻牌 动作
        if Local_State == selfObj.STATE_ENUM[1] then             

            for i = 1,#aiActionList do
                local tAct = cc.Sequence:create(selfObj.pkData[i].Action["action_just"])
                if i == #aiActionList then
                    tAct = cc.Sequence:create(
                        selfObj.pkData[i].Action["action_just"],
                        cc.CallFunc:create(OnCallback))
                end
                selfObj.pkData[i].Back:setVisible(false)
                aiActionList[i]:stopAllActions()
                aiActionList[i]:runAction(tAct)
            end
        elseif Local_State == selfObj.STATE_ENUM[3] then
            local tClickCount = 0
            for i = 1,#aiActionList do
                if selfObj.pkData[i].isClick then
                    tClickCount = tClickCount + 1
                end
            end
            local tNotClick = 0
            for i = 1,#aiActionList do
                selfObj.pkData[i].Back:setVisible(false)
                if selfObj.pkData[i].isClick then
                    --OnCallback()
                else
                    tNotClick = tNotClick + 1
                    local tAct = cc.Sequence:create(selfObj.pkData[i].Action["action_just"])
                    if tNotClick == #aiActionList - tClickCount then
                        tAct = cc.Sequence:create(
                            selfObj.pkData[i].Action["action_just"],
                            cc.CallFunc:create(OnCallback))
                    end
                    aiActionList[i]:stopAllActions()
                    aiActionList[i]:runAction(tAct)
                end
            end

            if tClickCount == 5 then
                OnCallback()
            end
        end
    else
        OnCallback()
    end

end

--请求换牌（MiniGameChange协议）
function ChangePoker(selfObj, aiEvent)
    My_Lua_log("file=[minigamescenepag] fun=[ChangePoker]")

    selfObj:InitNetData(aiEvent, TexasPokerCmd_pb.Cmd_CSMiniGameChange)

    selfObj.close = false
    --取消加载界面
    selfObj:CenterLoadingTime()    
    selfObj.IsLogging = false    
    Local_State = "gChange_Began"
    local m_Index = 0  
    if aiEvent.miData.iFlag ~= nil then
        selfObj.IsTwo = true
        selfObj:CloseLoading()
        selfObj.pos = {}
        selfObj.miPagObj["currencytext"]:setString(aiEvent.miData.iCurCoin)
        selfObj.miPagObj["wintext"]:setString(aiEvent.miData.iPoolCoin)
        My_Lua_log("file=[minigamescenepag fun=[DoublePoker] wintwxt="..aiEvent.miData.iPoolCoin)
        for i=1,5 do
            My_Lua_log("file=[minigamescene] fun=[ChangePoker] i=["..i.."]")
            selfObj.pkData[i].PK:setTexture( string.format(G_Fy.MiniGamegLobal:GetMiniConfig("STR_TEXT_POKER_FACECARD"), aiEvent.miData.vCards[i]))       
            table.insert(selfObj.pos,i)
        end 
    else
        if selfObj.pos ~= {} then
            for k,v in pairs(selfObj.pos) do
                m_Index = m_Index + 1
                selfObj.pkData[v].PK:setTexture( string.format(G_Fy.MiniGamegLobal:GetMiniConfig("STR_TEXT_POKER_FACECARD"), aiEvent.miData.vCards[m_Index]))
                selfObj.miPagObj["pokerbutton"..v]:setEnabled(false)
            end
        end
    end
  
    selfObj.iPoolCoin = aiEvent.miData.iPoolCoin
    
    --判断牌型 翻倍
    if aiEvent.miData.ePattern == 9001 then
        selfObj.wintipsIndex = 0
        selfObj.IsDouble = true
    elseif aiEvent.miData.ePattern == 9002 then
        selfObj.wintipsIndex = 1
        selfObj.IsDouble = true
    elseif aiEvent.miData.ePattern == 9003 then
        selfObj.wintipsIndex = 2
        selfObj.IsDouble = true
    elseif aiEvent.miData.ePattern == 9004 then
        selfObj.wintipsIndex = 3
        selfObj.IsDouble = true
    elseif aiEvent.miData.ePattern == 9005 then
        selfObj.wintipsIndex = 4
        selfObj.IsDouble = true
    elseif aiEvent.miData.ePattern == 9006 then
        selfObj.wintipsIndex = 5
        selfObj.IsDouble = true
    elseif aiEvent.miData.ePattern == 9007 then
        selfObj.wintipsIndex = 6
        selfObj.IsDouble = true
    elseif aiEvent.miData.ePattern == 9008 then
        selfObj.wintipsIndex = 7
        selfObj.IsDouble = true
    elseif aiEvent.miData.ePattern == 9009 then
        selfObj.wintipsIndex = 8
        selfObj.IsDouble = true
    else 
        selfObj.IsDouble = false 
        selfObj.miPagObj['wintipsimage']:setVisible(false)
    end
    --selfObj:FlipActionList()
    if selfObj.IsDouble == true then
        cc.SimpleAudioEngine:getInstance():playEffect("audio/pokerwin2.mp3")
    end

    if aiEvent.miData.iFlag ~= nil then
        for i=1,5 do
--            selfObj.pkData[i].PK:setVisible(true)
--            selfObj.pkData[i].Back:setVisible(false)
            selfObj.pkData[i].Back:runAction(selfObj.pkData[i].Action["action_against"]:clone())
        end
        Local_State = "gChange_End"
        if selfObj.IsDouble then
            selfObj:setState(3)
            --cc.SimpleAudioEngine:getInstance():playEffect("audio/pokerwin2.mp3")
        else
            selfObj:setState(1)
        end                       
        --selfObj:StateMachine()
My_Lua_log("file=[minigamescenepag] fun=[ChangePoker]   222222222222222")
    else
        selfObj:FlipActionList()
My_Lua_log("file=[minigamescenepag] fun=[ChangePoker]   11111111111111")
    end 
end

--session 超时
function SessionTimeOut(selfObj)
    My_Lua_log("file=[minigamescenepag] fun=[SessionTimeOut]")
    Local_State = "gCheck_End"
    selfObj.IsLogging = false 

    --背牌
    for i = 1, 5 do
        selfObj.pkData[i].PK:setVisible(false)
        selfObj.pkData[i].Back:setVisible(true)
    end

    selfObj:setState(1)
end
 
function OnClose(selfObj)
    Local_UiBase:OnClose()
    --移除
    selfObj.miPagObj['root']:removeFromParentAndCleanup()
    My_Lua_log(" file=[minigamemainscenepag] fun=[onclose]; remove   ok")  
end

--真正的退出删除
function OnExit(selfObj)
    selfObj.miPagObj['root']:release()
    My_Lua_log(" file=[minigamemainscenepag] fun=[onexit];")
    selfObj.miEventMgr:RemoveListenFromObj(selfObj)
    --release
    for k,v  in pairs(selfObj.pkData) do
        v.Action["action_just"]:release()
        v.Action["action_against"]:release()
    end
end

function setState(selfObj,index)    
    UI_State = selfObj.UI_STATE[index]
    My_Lua_log("file=[minigamescenepag] fun=[setState] Local_State=["..UI_State.."]")
    selfObj:StateMachine()
end


--状态机
function StateMachine(selfObj)
    My_Lua_log("file=[minigamescenepag] fun=[StateMachine] ")
    --selfObj.IsTwo = true
    if UI_State == "GameStart" then
        selfObj:GameStart()
    elseif UI_State == "GameChange" then
        selfObj:GameChange()
    elseif UI_State == "GameDouble" then
        selfObj:GameDouble()
    elseif UI_State == "GameCheck" then
        selfObj:GameCheck()
    end
end

--gamestart
function GameStart(selfObj)
    --gamestart   ui
    selfObj.miPagObj["doublebutton"]:setEnabled(false)
    for j = 1, 5 do
        selfObj.miPagObj['betcheckbox'..j]:setEnabled(true)
        selfObj.miPagObj["pokerbutton"..j]:setEnabled(false)
        selfObj.miPagObj["pokertext"..j]:setVisible(false)
    end
    selfObj.miPagObj["stateimage"]:loadTexture(STR_TEXT_POKER_GOODLUCK)
    selfObj.miPagObj['wintipsimage']:setVisible(false)
    selfObj.miPagObj['bet'..selfObj.aiIndex]:setVisible(true)
    selfObj.miPagObj['dealbutton']:setEnabled(true) 
end

--gamechange
function GameChange(selfObj)
    --gamechange   ui
    selfObj.miPagObj["doublebutton"]:setEnabled(false)
    for j = 1, 5 do
        selfObj.miPagObj['betcheckbox'..j]:setEnabled(false)
        selfObj.miPagObj["pokerbutton"..j]:setEnabled(true)
        selfObj.pkData[j].isClick = false
    end
    selfObj.miPagObj['bet'..selfObj.aiIndex]:setVisible(true)
    selfObj.miPagObj['dealbutton']:setEnabled(true)
end

--gamedouble
function GameDouble(selfObj)
    --gamedouble   ui
    --selfObj.miPagObj["doublebutton"]:setEnabled(selfObj.IsDouble)
    selfObj.miPagObj["doublebutton"]:setEnabled(true)
    --selfObj.miPagObj["wintext"]:setString(selfObj.iPoolCoin)
    for j = 1, 5 do
        selfObj.miPagObj['betcheckbox'..j]:setEnabled(true)
        selfObj.miPagObj["pokerbutton"..j]:setEnabled(false)
        selfObj.miPagObj["pokertext"..j]:setVisible(false)
    end
    if selfObj.wintipsIndex ~= nil then
        selfObj:WintipsImageAction(selfObj.wintipsIndex)
    end
    selfObj.miPagObj['bet'..selfObj.aiIndex]:setVisible(true)
    selfObj.miPagObj['dealbutton']:setEnabled(true)
end

--gamecheck
function GameCheck(selfObj)
    --gamecheck    ui
    for k = 2, 5 do
        selfObj.miPagObj["pokerbutton"..k]:setEnabled(true)
    end
    for j = 1, 5 do
        selfObj.miPagObj['betcheckbox'..j]:setEnabled(false)
        selfObj.miPagObj["pokertext"..j]:setVisible(false)
    end
    selfObj.miPagObj['dealbutton']:setEnabled(false)
end

function WaitLoading(selfObj)
    local nowTime = os.time()
    --My_Lua_log("file=[minigamescenepag] fun=[WaitLoading] nowtime="..nowTime)
    if selfObj.loadingTime.nowTime ~= nil then
        if nowTime >= selfObj.loadingTime.endTime then
            My_Lua_log("file=[minigamescenepag] fun=[WaitLoading] loading=[CloseLoading]")
            selfObj:CloseLoading()                          
            selfObj:CenterLoadingTime() 
        elseif nowTime >= selfObj.loadingTime.startTime then
            if selfObj.IsLogging then
                My_Lua_log("file=[minigamescenepag] fun=[WaitLoading] loading=[Loading]")
                --加载
                selfObj:Loading()
                if Local_State == selfObj.STATE_ENUM[7] then
                    selfObj.Once = true
                elseif Local_State == selfObj.STATE_ENUM[5] then
                    selfObj.miPagObj['doublebutton']:setEnabled(true)
                elseif Local_State == selfObj.STATE_ENUM[1] or
                    Local_State == selfObj.STATE_ENUM[3] then
                    selfObj.miPagObj['dealbutton']:setEnabled(true)
                end                   
                selfObj.IsLogging = false
            end
        end
    end
end

function OnUpdate(selfObj, aiDelTime)
    selfObj:WaitLoading()
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


function MiniGameSendFail(selfObj, aiEvent)
    My_Lua_log("file=[minigamescenepag] fun=[MiniGameSendFail]")

    selfObj.loadingTime.nowTime = nil

    if Local_State == selfObj.STATE_ENUM[7] then
        selfObj.Once = true
    elseif Local_State == selfObj.STATE_ENUM[5] then
        selfObj.miPagObj['doublebutton']:setEnabled(true)
    elseif Local_State == selfObj.STATE_ENUM[1] or
        Local_State == selfObj.STATE_ENUM[3] then
        selfObj.miPagObj['dealbutton']:setEnabled(true)
    end

    selfObj:CloseLoading()
    selfObj:CenterLoadingTime()

selfObj:StateMachine()
    --selfObj:Reset()
end

function OnSubExitMiniGame(selfObj, aiEvent)
    local aiEvent = {}
    aiEvent.type = MSG_TYPE_ENUM.MSG_TYPE_ENUM_CLOSE_PAG
    aiEvent.miPagName = "minigamemainscenepag"
    aiEvent.miData = {}
    selfObj.miEventMgr:NextDispatch(aiEvent)
end

