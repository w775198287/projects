local TTViewBase = import("..tt.TTViewBase")
local TTNet = import("..tt.TTNet")
local TTPoker = import("..tt.TTPoker")
local TTBoss = import("..tt.TTBoss")
local TTHelp = import("..tt.TTHelp")
local TTTrend = import("..tt.TTTrend")
local TTResult = import("..tt.TTResult")
local TTHead = import("..tt.TTHead")
local TTMsgId = import("..tt.TTMsgId")
local TTEvent = import("..tt.TTEvent")
local TTUtils = import("..tt.TTUtils")
local TTTips = import("..tt.TTTips")
local TTTest = import("..tt.TTTest")
local TTConstant = import("..tt.TTConstant")
local TTGameData = import("..tt.TTGameData")
local TTLanguage = import("..tt.TTLanguage")
local TTPokerManager = import("..tt.TTPokerManager")
local TTCoinManager = import("..tt.TTCoinManager")
local TTAudio = import("..tt.TTAudio")
local TTGame = class("TTGame", TTViewBase)
local scheduler = cc.Director:getInstance():getScheduler()
local targetPlatform = cc.Application:getInstance():getTargetPlatform()
require "socket"
function TTGame:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	TTUtils:Log("TTGame:onCreate")
	TTUtils:Log(string.format("winSize width=%f,height=%f",self.winSize_.width,self.winSize_.height))
	local ratio = self.winSize_.width/self.winSize_.height
	local phonePlatform = TTUtils:GetPhonePlatform()
	self:createResoueceNode("ttGame"..phonePlatform..".csb")
	-- --适配
    if "Iphone6s"==phonePlatform then--fixed高
        self.resourceNode_:setScaleY(self.winSize_.height/2208.0)
    elseif "Ipad"==phonePlatform then --fixed宽        
        self.resourceNode_:setScaleY(self.winSize_.height/2208.0)
    end 


	--按钮事件
	TTUtils:setOnViewClickedListener("Button_help",function(view)
		self:helpEvent(view)
	end,self.resourceNode_)
	TTUtils:setOnViewClickedListener("Button_close",function(view)
		self:closeEvent(view)
	end,self.resourceNode_)
	TTUtils:setOnViewClickedListener("Button_boss",function(view)
		self:bossEvent(view)
	end,self.resourceNode_)
	TTUtils:setOnViewClickedListener("Button_trend",function(view)
		self:trendEvent(view)
	end,self.resourceNode_)	
	for i=0,2 do
		local btnPosName = string.format("btnPos_%d", i)
		local btnPosNode = self.resourceNode_:getChildByName("middle"):getChildByName(btnPosName)
		btnPosNode.posIndex = i+1
		TTUtils:setOnViewClickedListener(btnPosNode,function(view)
			self:betEvent(view)
		end,self.resourceNode_,"static")
	end
	TTUtils:setOnViewClickedListener("CheckBox_bet",function(view)
		self:repeatBetEvent(view)
	end,self.resourceNode_,"static")
	for i=0,4 do
		local Button_coinName = string.format("Button_coin%d", i)
		local Button_coin = self.resourceNode_:getChildByName("bottom"):getChildByName(Button_coinName)
		Button_coin.coinIndex = i
		TTUtils:setOnViewClickedListener(Button_coin,function(view)
			self:selectCoinEvent(view)
		end,self.resourceNode_)		
	end
	--node节点
	self.timeCDLabel = TTUtils:findNodeByName("time_cd", self.resourceNode_)
	self.gameStatusLabel = TTUtils:findNodeByName("game_status", self.resourceNode_)
	self.CheckBox_bet = TTUtils:findNodeByName("CheckBox_bet", self.resourceNode_)	
	self.mycoinLabel = TTUtils:findNodeByName("Text_mycoin", self.resourceNode_)	
	self.Panel_gps = self.resourceNode_:getChildByName("Panel_gps")
	self.Panel_coinBank = self.Panel_gps:getChildByName("Panel_coinBank")
	self.Panel_coinSelf = self.Panel_gps:getChildByName("Panel_coinSelf")
	self.Panel_coinGuest = self.Panel_gps:getChildByName("Panel_coinGuest")
	self.Panel_maxWiner = self.Panel_gps:getChildByName("Panel_maxWiner")
	self.ttNotifyMaxWinerNode = nil--是self.Panel_maxWiner子节点

	TTLanguage:loadLanguageCsvFile("ttLanguage.csv")	
	self:onNodeEvent("enter")
    self:onNodeEvent("exit")

    TTUtils:init(self)
	TTEvent:init()
	self:initHeads()
	self.Panel_head_PosTable = {}
	for k,v in pairs(self.headNodes_) do		
		if v.seatId~=nil then
			local Panel_cardStart = self.Panel_gps:getChildByName( string.format("Panel_head%d", v.seatId) )
			local x,y = Panel_cardStart:getPosition()
			self.Panel_head_PosTable[v.seatId] = cc.p(x,y)
		end
	end	

	local Panel_gpsChildred = self.Panel_gps:getChildren()
	for k,v in pairs(Panel_gpsChildred) do
		v:setBackGroundColorOpacity(0)
	end
	TTPokerManager:setTTGameNode(self)
	TTCoinManager:setTTGameNode(self)
	self:clear()	

	self:resetRepeatTable()
	self:setRepeatCheckBoxTouchEnable(false)
	self._reqHttpLoginCDTime = 0--请求http超时倒计时
	-- TTUtils:findNodeByName("CheckBox_bet", self.resourceNode_):setPositionX(400)
	-- TTUtils:findNodeByName("Text_RepeatBet", self.resourceNode_):setPositionX(400)

end
function TTGame:onEnter()
	self:registTTEvent()
	cc.SpriteFrameCache:getInstance():addSpriteFrames("ttPokerAtlas.plist")
	--播放背景音乐
	TTAudio:playMusic("ttaudio/mp3/background.mp3",true)
	self:preloadEffect()
	TTCoinManager:intervalShowCoin()

	self.delayInit_ = scheduler:scheduleScriptFunc(function( dt )
		if self.delayInit_ then			
			scheduler:unscheduleScriptEntry(self.delayInit_)
			self.delayInit_ = nil
			self:delayInit()
		end
	end, 0, false)
	self.delayTest_ = scheduler:scheduleScriptFunc(function( dt )
		if self.delayTest_ then			
			scheduler:unscheduleScriptEntry(self.delayTest_)
			self.delayTest_ = nil
			self:delaydTest()
		end
	end, 1, false)
	self.updateEverySecond_ = scheduler:scheduleScriptFunc(function( dt )
		self:updateEverySecond()
	end, 1, false)
	self.scheduleSecMaxWiner_ = scheduler:scheduleScriptFunc(function( dt )
		self:scheduleSecMaxWiner()
	end, 1, false)
	self.updateHttpConnect_ = scheduler:scheduleScriptFunc(function( dt )
		self:updateHttpConnect(dt)
	end, 0.1, false)
end
function TTGame:onExit()
	TTUtils:Log("TTGame onExit")
    --停止背景音乐
	self:uncacheEffect()
 	TTAudio:stopMusic(true)
	TTEvent:removeAllEventListeners()
	TTCoinManager:destroy()
	TTPokerManager:destroy()
    cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile("ttPokerAtlas.plist")
    scheduler:unscheduleScriptEntry(self.updateEverySecond_)
    scheduler:unscheduleScriptEntry(self.updateHttpConnect_)
    self.updateEverySecond_ = nil
    scheduler:unscheduleScriptEntry(self.scheduleSecMaxWiner_)
    self.scheduleSecMaxWiner_ = nil

    if self.delayReconnect_ then
    	scheduler:unscheduleScriptEntry(self.delayReconnect_)
    end
    if self.delayInit_ then
    	scheduler:unscheduleScriptEntry(self.delayInit_)
    	self.delayInit_ = nil
    end
    if self.delayTest_ then
    	scheduler:unscheduleScriptEntry(self.delayTest_)
		self.delayTest_ = nil
	end
	--大赢家头像
	if self.ttNotifyMaxWinerNode then
		self.ttNotifyMaxWinerNode:removeFromParent()
		self.ttNotifyMaxWinerNode = nil
	end
	if self.maxWinerTexture2d then
		cc.Director:getInstance():getTextureCache():removeTexture(self.maxWinerTexture2d)
		self.maxWinerTexture2d = nil
	end
	--断开网络
	TTNet:standUp()
	TTNet:close()
end
function TTGame:initData( data )
	dump(data)
	local initLog = os.date("%Y-%m-%d %H:%M:%S", os.time()).."  28碰小游戏启动初始化信息： \n"
	for key,value in pairs(data) do
		initLog = initLog.."  "..tostring(key).."  :  "..tostring(value).." \n"
	end
	TTUtils:writeLog(nil,initLog)

	local exitError = false
	local function dataError( msg )
		exitError = true
		TTUtils:Log("初始化数据失败  "..msg)
		TTUtils:showToast(msg,5.0)
		self.initDataFail_ = scheduler:scheduleScriptFunc(function( dt )			
			scheduler:unscheduleScriptEntry(self.initDataFail_)
			self.initDataFail_ = nil;
			self:removeFromParent()
		end, 0, false)
	end
	if data==nil then
		dataError("初始化数据失败,数据为空")
	elseif data~=nil and type(data)~="table" then
		dataError("初始化数据失败,数据格式不正确")
	elseif data.avatar==nil then
		dataError("初始化数据失败,头像数据为空")
	elseif data.avatar~=nil and type(data.avatar)~="string" then
		dataError("初始化数据失败,头像数据不为字符串")
	elseif data.avatar~=nil and type(data.avatar)=="string" and string.len(data.avatar)<5 then
			dataError("初始化数据失败,头像数据长度过短")
	elseif data.avatar~=nil and type(data.avatar)=="string" and string.len(data.avatar)>=5 and 
		string.sub(data.avatar,-3,-1)~="png" and
		string.sub(data.avatar,-3,-1)~="jpg" then
			dataError("初始化数据失败,头像数据不是png jpg结尾的字符串")	
	elseif data.uuid==nil then
		dataError("初始化数据失败,uuid数据为空")
	elseif data.uuid~=nil and  type(data.uuid)~="number" then
		dataError("初始化数据失败,uuid数据不为数字")
	elseif data.coins==nil then
		dataError("初始化数据失败,coins数据为空")
	elseif data.coins~=nil and  type(data.coins)~="string" and type(data.coins)~="number" then
		dataError("初始化数据失败,coins数据需要数字或字符串类型")
	elseif data.isEffectsAudio==nil then
		dataError("初始化数据失败,音效数据不存在")
	elseif data.isEffectsAudio~=nil and type(data.isEffectsAudio)~="boolean" then
		dataError("初始化数据失败,音效数据格式错误")
	elseif data.sex==nil then
		dataError("初始化数据失败,性别数据不存在")
	elseif data.sex~=nil and type(data.sex)~="string" then
		dataError("初始化数据失败,性别数据不为字符串")
	elseif data.sex~=nil and type(data.sex)=="string" and
		data.sex~="male" and data.sex~="famale" then
			dataError("初始化数据失败,性别数据值错误")
	elseif data.isDebug==nil then
		dataError("初始化数据失败,是否调试模式数据不存在")
	elseif data.isDebug~=nil and type(data.isDebug)~="boolean" then
		dataError("初始化数据失败,是否调试数据格式错误")
	elseif data.language==nil then
		dataError("初始化数据失败,语言数据不存在")
	elseif data.language~=nil and type(data.language)~="number" then
		dataError("初始化数据失败,语言数据格式错误")
	end
	if exitError then
		return
	end



	TTGameData.userInfo.userId = data.uuid
	TTGameData.avatar = data.avatar
	TTGameData.userInfo.coins = tonumber(data.coins)
	TTGameData.isDebug = data.isDebug
	TTGameData.language = data.language
	TTGameData.dpqToken = data.token
	if nil==TTGameData.userInfo.coins  then
		dataError("初始化数据失败,coins数据不正确")
		return
	end
	if data.language~=1 then-- and data.language~=2 and data.language~=3 
		dataError("初始化数据失败,暂不支持语言")
		return
	end
	if data.isEffectsAudio then		
		TTGameData.isEffectsAudio = true
		TTGameData.isBackgroundMusic = true
		TTGameData.effectsVolume = 1.0
		TTGameData.backgroundMusicVolume = 1.0
	else
		TTGameData.isEffectsAudio = false
		TTGameData.isBackgroundMusic = false
	end	
	TTGameData.sex = data.sex
	--可选
	if data.imei and type(data.imei)=="string" and data.imei~="" then
		TTGameData.imei = data.imei
	else
		TTGameData.imei = tostring( TTUtils:random(1000000,999999999) )	
	end
	if data.model and type(data.model)=="string" then
		TTGameData.model = data.model
	end
	-- if data.version and type(data.version)=="string" then
	-- 	TTGameData.version = data.version
	-- end
	if data.channel and type(data.channel)=="string" then
		TTGameData.channel = data.channel
	end
	if data.platform and type(data.platform)=="string" then
		TTGameData.platform = data.platform
	end

	self:updateMultiRes()

end
function TTGame:registTTEvent()
	 self._,self.handle1 = TTEvent:on(TTMsgId.WEBSOCKET_ONOPEN,function(event)--websocket打开
	 	TTNet:loginHall()
    end)
    self._,self.handle2 = TTEvent:on(TTMsgId.MSGID_LOGIN_GUEST+TTMsgId.ID_ACK,function(event)--游客登录返回
    	self:onGuestLogin(event.userData)
    end)
    self._,self.handle3 = TTEvent:on(TTMsgId.MSGID_LOGIN_DPQ+TTMsgId.ID_ACK,function(event)--德扑圈登录返回
    	self:onDpqLogin(event.userData)
    end)
    self._,self.handle1003 = TTEvent:on(TTMsgId.MSGID_LOGIN_HALL+TTMsgId.ID_ACK,function(event)--长连接websocket登录返回
    	self:onLoginHall(event.userData)
    end)
    self._,self.handle4 = TTEvent:on(TTMsgId.MSGID_QUICK_START+TTMsgId.ID_ACK,function(event)--进入房间返回
    	self:onJoinRoom(event.userData)
    end)
    self._,self.handle5 = TTEvent:on(TTMsgId.MSGID_JOIN_TABLE+TTMsgId.ID_ACK,function(event)--进入桌子返回
    	self:onJoinTable(event.userData)
    end)
	self._,self.handle6 = TTEvent:on(TTMsgId.WEBSOCKET_ONCLOSE,function(event)--web socket断开
		TTUtils:Log(event.userData.reconnectTimes)
		if event.userData.reconnectTimes>1 then
			self.delayReconnect_ = scheduler:scheduleScriptFunc(function( dt )
				scheduler:unscheduleScriptEntry(self.delayReconnect_)
				self.delayReconnect_ = nil
				TTUtils:showToast( TTLanguage.a[2][TTGameData.language] ,2.0)
				TTNet:create()
			end, 3, false)
		else
			TTNet:create()
		end    	
    end)
    self._,self.handle7 = TTEvent:on(TTMsgId.MSGID_BAI_STATUS+TTMsgId.ID_NTF,function(event)--游戏状态切换通知
    	self:onNotifyChangeGameStatus(event.userData)
    end)
    self._,self.handle8 = TTEvent:on(TTMsgId.MSGID_BAI_XIAZHU+TTMsgId.ID_ACK,function(event)--下注返回
    	self:onBet(event.userData)
    end)
    self._,self.handle9 = TTEvent:on(TTMsgId.MSGID_BAI_XIAZHU+TTMsgId.ID_NTF,function(event)--下注通知
    	self:onNotifyBet(event.userData)
    end)
    self._,self.handle10 = TTEvent:on(TTMsgId.PLAY_PEEKANI_END,function(event)--撵牌动画播放完毕
		self:addNiuCnt(event.userData.pos,event.userData.notifyResultInfo)
    end) 
    self._,self.handle11 = TTEvent:on(TTMsgId.UPDATE_BANK_COIN,function(event)--更新庄家金币
		self:updateBankCoins(event.userData.coins)
    end) 
    self._,self.handle12 = TTEvent:on(TTMsgId.UPDATE_SELF_COIN,function(event)--更新自己金币
		TTGameData.userInfo.coins = event.userData.coins
		self:updateSelfCoins()
    end) 
	self._,self.handle13 = TTEvent:on(TTMsgId.MSGID_BAI_WIN_HISTORY+TTMsgId.ID_ACK,function(event)--趋势返回
    	self:onTrend(event.userData)
    end)
    self._,self.handle14 = TTEvent:on(TTMsgId.MSGID_BAI_WAIT_BANKER_LIST+TTMsgId.ID_ACK,function(event)--上庄列表返回
    	self:onBoss(event.userData)
    end)
    self._,self.handle15 = TTEvent:on(TTMsgId.MSGID_BAI_CHANGE_BANKER+TTMsgId.ID_NTF,function(event)--换庄通知
    	self:onNotifyChangeBank(event.userData)
    end)
    self._,self.handle16 = TTEvent:on(TTMsgId.MSGID_BAI_QUIT_BANKER+TTMsgId.ID_NTF,function(event)--下庄通知
    	TTUtils:showToast(event.userData.desc)
    end)
    self._,self.handle17 = TTEvent:on(TTMsgId.MSGID_BAI_BANKER_COINS_LIMIT+TTMsgId.ID_NTF,function(event)--下注金额达到庄家上限：
		TTUtils:showToast(TTLanguage.a[20][TTGameData.language])
    end)
    self._,self.handle18 = TTEvent:on(TTMsgId.MSGID_READY+TTMsgId.ID_ACK,function(event)--准备返回
    end)
    self._,self.handle19 = TTEvent:on(TTMsgId.MSGID_BAI_QUIT_BANKER+TTMsgId.ID_ACK,function(event)--取消上庄返回
        if self.gameStatus~=TTConstant.GAME_STATUS_FREE and 0==event.userData.result and TTGameData.userInfo.userId==self:getTTHeadBank():getUserId() then
        	TTUtils:showToast( TTLanguage.a[3][TTGameData.language] )
        end
    end)
    self._,self.handle20 = TTEvent:on(TTMsgId.MSGID_BAI_BIG_WINNER+TTMsgId.ID_NTF,function(event)--大赢家通知
    	self:onNotifyMaxWiner(event.userData)
    end)
    self._,self.handle21 = TTEvent:on(TTMsgId.UPDATE_SELF_BET_COIN,function(event)--更新自己下注的筹码数量显示
    	--betZone, coins, coinsChg --betZone 1 2 3 中发白三个位置
		self:updateSelfBetCoins(event.userData.betZone, nil , event.userData.coinsChg)
    end) 
    self._,self.handle22 = TTEvent:on(TTMsgId.UPDATE_TOTAL_BET_COIN,function(event)--更新中发白区域下注的筹码数量显示
		--betZone, coins, coinsChg --betZone 1 2 3 中发白三个位置
		self:updateTotalBetCoins(event.userData.betZone, nil , event.userData.coinsChg)
    end)
    self._,self.handle23 = TTEvent:on(TTMsgId.HTTP_DPQ_LOGIN,function(event)--http登录返回
		if event.userData.result==0 then--http登录成功
			self._reqHttpLoginCDTime = 0
			if TTGameData.server=="" then
				TTGameData.server = event.userData.host..":"..event.userData.port
				TTGameData.httpLoginToken = event.userData.token
				TTGameData.userInfo.userId = event.userData.userId
				TTUtils.Log("TTGameData.server = "..TTGameData.server)
				TTNet:create()
			end
		end    	
    end)

end
function TTGame:delayInit()
	TTCoinManager:initCoinPool()
	TTPokerManager:initPokerPool()
	self:httpDpqLogin()
	TTUtils:downLoadSelfImage()


end
function TTGame:delaydTest()
	TTUtils:Log("delaydTest")


    --随机测试
	-- self.lxftest_spTable = {}
	-- local speed = 0.25
	-- local seq = cc.Sequence:create( cc.MoveBy:create(speed, cc.p(0,2000)), cc.MoveBy:create(speed, cc.p(-600,0)), cc.MoveBy:create(speed, cc.p(0,-2000)), cc.MoveBy:create(speed, cc.p(600,0) ) )
 --    local rep = cc.RepeatForever:create(seq)       
	-- for i=1,3000 do
 --        local sp = cc.Sprite:create()
 --        local spriteFrameName = string.format("ttpoker/chip_%d.png", 10)
 --        sp:setSpriteFrame(spriteFrameName)
 --        sp:setPosition(800, 200)
 --        TTCoinManager.Panel_gps:addChild(sp)        
	-- 	table.insert(self.lxftest_spTable, sp)
 --    end
 --    local randomTest = scheduler:scheduleScriptFunc(function( dt )
	-- 	local len = TTUtils:random(40,50)
	-- 	for i=1,len do
	-- 		local sp = self.lxftest_spTable[1]
	-- 		table.remove(self.lxftest_spTable,1)
	-- 		table.insert(self.lxftest_spTable, sp)
	

	-- 		local coinStartPos = cc.p(577.86, 56.09)
	-- 		local coinEndPos = cc.p(1157.74, 1165.27)
	-- 		sp:setPosition(coinStartPos)
	-- 		local bezier = {
	-- 	        cc.p( (coinStartPos.x+(coinEndPos.x-coinStartPos.x)/3.0), math.max(coinStartPos.y, coinEndPos.y)+200 ),
	-- 	        cc.p( (coinStartPos.x+(coinEndPos.x-coinStartPos.x)*2/3.0), math.max(coinStartPos.y, coinEndPos.y)+200 ),
	-- 	        cc.p(coinEndPos.x, coinEndPos.y),
	-- 	    }
	-- 	    local bezierForward = cc.BezierTo:create(0.7, bezier)
	-- 	    local seq = cc.Sequence:create( cc.DelayTime:create(0.01*i), bezierForward )
	-- 	    sp:setLocalZOrder(TTUtils:random(1,1000))
	-- 		sp:runAction(seq)
	-- 	end
	-- end, 0.7, false)



	--压力测试最大筹码量
	-- local lotsCoinTest = scheduler:scheduleScriptFunc(function( dt )	
	-- 	local cacheBetTable	 = {}
	-- 	local betRound = TTConstant.BET_ROUND_FIRST		
	-- 	if self.gameStatus==TTConstant.GAME_STATUS_XIAZHU then
	-- 		for i=1,2 do
	-- 			local item = {}
	-- 			item.betGps = {betZone=TTUtils:random(1,3),betRound=betRound}
	-- 			item.coinIndex = 0
	-- 			item.seatId = TTConstant.SEATID_SELF
	-- 			item.isAni = true
	-- 			table.insert(cacheBetTable, item)
	-- 			TTCoinManager:cacheBet(item.betGps, item.coinIndex, item.seatId, item.isAni)
	-- 			--TTCoinManager:bet(item.betGps, item.coinIndex, item.seatId, item.isAni)
	-- 		end
	-- 	end		
	-- end, 1.0, false)



	--结算测试
	-- local msgStr = TTTest:getResultMsg()
	-- local msg = json.decode(msgStr)
 --    TTEvent:dispatchEvent({name=msg.id,userData=msg.body})
end

function TTGame:preloadEffect()
	TTAudio:preloadEffect("ttaudio/mp3/beginBet.mp3")
	TTAudio:preloadEffect("ttaudio/mp3/bet1.mp3")
	TTAudio:preloadEffect("ttaudio/mp3/deal.mp3")

	TTAudio:preloadEffect("ttaudio/mp3/flyCoins.mp3")
	TTAudio:preloadEffect("ttaudio/mp3/lose.mp3")

	TTAudio:preloadEffect("ttaudio/mp3/stopBet.mp3")
	TTAudio:preloadEffect("ttaudio/mp3/win.mp3")

	for i=0,11 do
		TTAudio:preloadEffect("ttaudio/mp3/pai_"..i..".mp3")
	end
end
function TTGame:uncacheEffect()
	TTAudio:uncacheEffect("ttaudio/mp3/beginBet.mp3")
	TTAudio:uncacheEffect("ttaudio/mp3/bet1.mp3")
	TTAudio:uncacheEffect("ttaudio/mp3/deal.mp3")

	TTAudio:uncacheEffect("ttaudio/mp3/flyCoins.mp3")
	TTAudio:uncacheEffect("ttaudio/mp3/lose.mp3")

	TTAudio:uncacheEffect("ttaudio/mp3/stopBet.mp3")
	TTAudio:uncacheEffect("ttaudio/mp3/win.mp3")

	for i=0,11 do
		TTAudio:uncacheEffect("ttaudio/mp3/pai_"..i..".mp3")
	end
end
---------------------------------------------------------------------------------------------------------------------头像---------------------------------------------------------
function TTGame:initHeads()
	self.headNodes_ = {}
	for i=0,5 do
		local headPanel = self.resourceNode_:getChildByName("middle"):getChildByName(string.format("head_%d",i))
		headPanel:setBackGroundColorOpacity(0)
		local headNode = TTHead.new()
		headNode:setSeatId(i)
		headNode:setPosition(headPanel:getContentSize().width/2, headPanel:getContentSize().height/2)
		headPanel:addChild(headNode)
		table.insert(self.headNodes_, headNode)
	end
	local headPanel = self.resourceNode_:getChildByName("top"):getChildByName("head_bank")
	headPanel:setBackGroundColorOpacity(0)
	local headNode = TTHead.new()
	headNode:setBank(true)
	headNode:setPosition(headPanel:getContentSize().width/2, headPanel:getContentSize().height/2)
	headPanel:addChild(headNode)
	table.insert(self.headNodes_, headNode)

end
function TTGame:getHeadNodes()
	return self.headNodes_
end
function TTGame:getSeatIdByUserId(userId)
	for k,v in pairs(self.headNodes_) do
		if userId and userId==v:getUserId() then
			return v.seatId
		end
	end
	return nil
end
function TTGame:getTTHeadByUserId(userId)
	for k,v in pairs(self.headNodes_) do
		if userId and userId==v:getUserId() then
			return v
		end
	end
	return nil
end
function TTGame:getTTHeadBySeatId(seatId)
	for k,v in pairs(self.headNodes_) do
		if seatId~=nil and seatId==v.seatId then
			return v
		end
	end
	return nil
end
function TTGame:getGpsPosByUserId( userId )
	local seatId = self:getSeatIdByUserId(userId)	
	if seatId~=nil then
		if nil~=self.Panel_head_PosTable[seatId] then
			return self.Panel_head_PosTable[seatId]
		else
			TTUtils:Log("根据用户ID获取位置失败")
			TTUtils:Log(userId)
			TTUtils:Log(seatId)
			dump(self.Panel_head_PosTable)
		end		
	end
	if userId==TTGameData.userInfo.userId then
		local x,y = self.Panel_coinSelf:getPosition()
		return cc.p(x,y)
	end
	local x,y = self.Panel_coinGuest:getPosition()
	return cc.p(x,y)
end

function TTGame:getTTHeadBank()
	for k,v in pairs(self.headNodes_) do
		if v.isBank then
			return v
		end
	end
	return nil
end
---------------------------------------------------------------------------------------------------------------------按钮事件---------------------------------------------------------
function TTGame:bossEvent(view)
	TTUtils:Log("bossEvent")
	local isBoss = (self:getTTHeadBank():getUserId()==TTGameData.userInfo.userId)
	local function quitBank()
		TTNet:quitBank()
	end
	if isBoss then
		local ttTips = TTTips.new()
		ttTips:initView(TTLanguage.a[14][TTGameData.language],quitBank)
		self:addChild(ttTips)
	else
		TTNet:waitBankList()
	end	
end
function TTGame:closeEvent(view)
	self:removeFromParent()
end
function TTGame:helpEvent(view)
	self:addChild(TTHelp.new())
end
function TTGame:betEvent(view)
 	TTUtils:Log("betEvent name: "..view:getName())
 	local betRound = TTConstant.BET_ROUND_FIRST
 	if self.gameStatus==TTConstant.GAME_STATUS_XIAZHU then
	 	if self:getTTHeadBank():getUserId()~=TTGameData.userInfo.userId then
	 		TTNet:bet({view.posIndex,self.coinIndex_})		
	 	end
 	end 	

 	self.CheckBox_bet:setSelected(false)
end
function TTGame:repeatBetEvent(view)
	TTUtils:Log("点击了重复投")
end
function TTGame:trendEvent( view )
	TTNet:trent()
end
function TTGame:selectCoinEvent( view )
	self.coinIndex_ = view.coinIndex--0 1 2 3 4
	self:updateSelectBetBtn(self.coinIndex_)
end
---------------------------------------------------------------------------------------------------------------------消息事件---------------------------------------------------------
function TTGame:onGuestLogin(userData)
	if 0~=userData.result then
		TTUtils:showToast(userData.reason,2.0)
		self:removeFromParent()
		return
	end
	TTGameData.userInfo = userData.userInfo
	TTNet:joinRoom(101)
end
function TTGame:onDpqLogin( userData )
	if 0~=userData.result then
		TTUtils:showToast(userData.reason,2.0)
		self:removeFromParent()
		return
	end
	TTNet:joinRoom(101)
end
function TTGame:onLoginHall(userData)
	if 0~=userData.result then
		TTUtils:showToast(userData.reason,2.0)
		TTUtils:writeLog(nil,"websocket loginHall fail")
		self:removeFromParent()
		return
	end
	TTNet:joinRoom(101)
end
function TTGame:onJoinRoom( userData )
	if 0~=userData.result then
		TTUtils:showToast(userData.reason,2.0)
		self:removeFromParent()
		return
	end
	TTNet:joinTable(userData.tableId)
end
function TTGame:onJoinTable( userData )
	if 0~=userData.result then
		TTUtils:showToast(userData.reason,2.0)
		self:removeFromParent()
		return
	end
	self:clear()
	self:selectCoinEvent(self.resourceNode_:getChildByName("bottom"):getChildByName("Button_coin0"))--默认选择第一个筹码
	TTGameData.userInfo.coins = userData.boardInfo.coins
	TTGameData.roomInfo = userData.boardInfo.roomInfo
	self:updateCoinTouch()

	self:updateGameStatus(userData.boardInfo.gameStatus)
	self.cdTime =  userData.boardInfo.leftTime
	self:updateSelfCoins()	
	local bankNode = self:getTTHeadBank()
	local isAni = false
	bankNode:setUserId(userData.boardInfo.bankerInfo.bankerId)
	bankNode:updateCoins(userData.boardInfo.bankerInfo.coins)
	bankNode:updateHead(userData.boardInfo.bankerInfo.avatar, userData.boardInfo.bankerInfo.bankerId)
	--更新在座玩家的头像、金币
	for k,v in pairs(userData.boardInfo.seatPlayersInfo) do
		local ttHead = self:getTTHeadBySeatId(v.seatId)
		if ttHead then
			ttHead:clear()
			ttHead:setUserId(v.userId)
			ttHead:updateCoins(v.coins)
			ttHead:updateHead(v.avatar, v.userId)
		else
			TTUtils:Log("服务器发送在座玩家的座位号错误 "..v.seatId)
		end
	end
	local function betInfo()
		for k,v in pairs(userData.boardInfo.resultInfo.xiaZhuCoins) do
			self:updateSelfBetCoins(k,v)
		end
		for k,v in pairs(userData.boardInfo.resultInfo.totalXiaZhuCoins) do
			self:updateTotalBetCoins(k,v)
		end
		for k1,v1 in pairs(userData.boardInfo.resultInfo.totalXiaZhuDetail) do--k1=betZone 值：1 2 3 表示中发白
			local betRound = TTConstant.BET_ROUND_FIRST
			local coinNum = 0
			for k3,v3 in ipairs(v1) do--v3
				--betGps,coinIndex,seatId,isAni
				TTCoinManager:bet({betZone=tonumber(k1),betRound=betRound},v3,nil,isAni)
				coinNum = coinNum+1
				if coinNum>math.floor(TTConstant.MAX_ONCE_COIN_NUM/1) then
					break
				end
			end
		end		
	end
	if userData.boardInfo.gameStatus==TTConstant.GAME_STATUS_XIAZHU then
		betInfo()		
	elseif userData.boardInfo.gameStatus==TTConstant.GAME_STATUS_KAIPAI then
		betInfo()
		TTPokerManager:dealPoker(userData.boardInfo.resultInfo, isAni, nil)
	end

	self:updateBankBtn()
	self:resetRepeatTable()
	self:setRepeatCheckBoxTouchEnable(false)
	self.CheckBox_bet:setSelected(false)

end
function TTGame:onBet( userData )
	if 1==userData.result then--重复投失败	
		TTUtils:showToast(TTLanguage.a[18][TTGameData.language])
		self.resetRepeatTable()
	elseif 2==userData.result then--下注金额已达到个人上限		
		TTUtils:showToast(TTLanguage.a[19][TTGameData.language])
	elseif 3==userData.result then--庄家不能下注
		TTUtils:showToast(TTLanguage.a[17][TTGameData.language])
	elseif 4==userData.result then--下注金额已达到庄家上限
		TTUtils:showToast(TTLanguage.a[20][TTGameData.language])
	end
	if userData.result ~= 0 and userData.reason then
		return
	end
	local betZone = nil
	local coinIndex = 0
	local betLimitTable = {}
	local betRound = TTConstant.BET_ROUND_FIRST
	local cacheBetTable = {}
	local cacheZoneLimit = {}
	for i,v in ipairs(userData.chipList) do			
		if i%2==0 then
			coinIndex = v		
			if betLimitTable[betZone]==nil then
				betLimitTable[betZone] = 1
			else
				betLimitTable[betZone] = betLimitTable[betZone]+1
			end
			if nil==cacheZoneLimit[betZone] or cacheZoneLimit[betZone]<=math.floor(TTConstant.CACHE_FLYCOIN_NUM/4) then
				cacheZoneLimit[betZone] = cacheZoneLimit[betZone] or 1
				cacheZoneLimit[betZone] = cacheZoneLimit[betZone]+1
				local item = {}
				item.betGps = {betZone=betZone,betRound=betRound}
				item.coinIndex = coinIndex
				item.seatId = TTConstant.SEATID_SELF
				item.isAni = true
				table.insert(cacheBetTable, item)
			end	
			--记录本局的重复投
			table.insert(self.repeatBetTable[betRound], {pos=betZone, index=coinIndex}) 				
		else
			betZone = v
		end
	end
	TTUtils:shuffleTable(cacheBetTable)
	for i,v in ipairs(cacheBetTable) do
		TTCoinManager:cacheBet(v.betGps, v.coinIndex, v.seatId, v.isAni)
	end

	TTGameData.userInfo.coins = userData.coins
	for k,v in pairs(userData.xiaZhuCoins) do--k 1 2 3 中发白三个位置
		local cacheCoinNumTable = TTCoinManager:getCacheCoinNumSelf()
		self:updateSelfBetCoins(k,v-cacheCoinNumTable[tonumber(k)])--更新自己的总下注数量
	end
	for k,v in pairs(userData.totalXiaZhuCoins) do--k 1 2 3 中发白三个位置
		local cacheCoinNumTable = TTCoinManager:getCacheCoinNumTotal()
		self:updateTotalBetCoins(k,v-cacheCoinNumTable[tonumber(k)])--更新中发白的总下注数量
	end
	
	self:updateSelfCoins()--更新自己的筹码数量
	TTEvent:dispatchEvent({name=TTMsgId.UPDATE_SEAT_COIN,userData={userId=TTGameData.userInfo.userId,coins=TTGameData.userInfo.coins} })--如果自己坐在牌桌子，也更新显示
	self:updateCoinTouch()--更新筹码按钮是否可点击
	self:setRepeatCheckBoxTouchEnable(true)

	--选中下注的筹码自动下降
	if table.nums(userData.chipList)==2 and userData.chipList[2]~=userData.reqChipIndex then
		self.coinIndex_ = userData.chipList[2]--0 1 2 3 4
		self:updateSelectBetBtn(self.coinIndex_)
		TTUtils:showToast(TTLanguage.a[22][TTGameData.language])--投注过大
	end
end
function TTGame:onNotifyBet( userData )
	local betRound = TTConstant.BET_ROUND_FIRST
	local cacheBetTable = {}
	local cacheZoneLimit = {}
	for k1,v1 in pairs(userData.xiaZhuDetail) do--k1等于betZone
		local userId = nil
		local coinIndex = 0
		local betZone = tonumber(k1)
		local betLimitTable = {}
		for i2,v2 in ipairs(v1) do			
			if i2%2==0 then
				coinIndex = v2
				local seatId = self:getSeatIdByUserId(userId)
				--betGps,coinIndex,seatId,isAni
				if userId~=TTGameData.userInfo.userId then
					if betLimitTable[betZone]==nil then
						betLimitTable[betZone] = 1
					else
						betLimitTable[betZone] = betLimitTable[betZone]+1
					end
					if nil==cacheZoneLimit[betZone] or cacheZoneLimit[betZone]<=math.floor(TTConstant.CACHE_FLYCOIN_NUM/4) then
						cacheZoneLimit[betZone] = cacheZoneLimit[betZone] or 1
						cacheZoneLimit[betZone] = cacheZoneLimit[betZone]+1
						local item = {}
						item.betGps = {betZone=betZone,betRound=betRound}
						item.coinIndex = coinIndex
						item.seatId = seatId
						item.isAni = true
						table.insert(cacheBetTable, item)
					end
				end				
			else
				userId = v2
			end
		end		
	end
	TTUtils:shuffleTable(cacheBetTable)
	for i,v in ipairs(cacheBetTable) do
		TTCoinManager:cacheBet(v.betGps, v.coinIndex, v.seatId, v.isAni)
	end
	for k,v in pairs(userData.totalXiaZhuCoins) do--k等于betZone
		local cacheCoinNumTable = TTCoinManager:getCacheCoinNumTotal()
		self:updateTotalBetCoins(tonumber(k), v-cacheCoinNumTable[tonumber(k)])
	end
	for k,v in pairs(userData.seatPlayersInfo) do
		local ttHead = self:getTTHeadByUserId(v.userId)
		if ttHead then
			ttHead:updateCoins(v.coins)--更新在坐玩家的筹码
		end
	end
end
function TTGame:onNotifyChangeGameStatus( userData )
	self:updateGameStatus(userData.gameStatus)
	if userData.gameStatus==TTConstant.GAME_STATUS_XIAZHU then
		local function aniEnd()
			if not self.CheckBox_bet:isSelected() then
				self:resetRepeatTable()
				self:setRepeatCheckBoxTouchEnable(false)
 			end
			self:repeatBet()
		end
		self:beginBetAni(aniEnd)
		self:playTTEffect("beginBet")
		TTGameData.roomInfo = userData.roomInfo
	elseif userData.gameStatus==TTConstant.GAME_STATUS_KAIPAI then
		TTCoinManager:clearCoinCache()--不再飞筹码
		self:playTTEffect("stopBet")
		local function dealPokerEnd()
			self:resultCoins(userData.resultInfo)
		end
		TTPokerManager:dealPoker(userData.resultInfo, true, dealPokerEnd)
	elseif status==TTConstant.GAME_STATUS_FREE then

	end
end
function TTGame:onTrend( userData )
	if userData.result ~= 0 then
		TTUtils:Log("获取趋势失败")
		return
	end
	local ttTrend = TTTrend.new()
	ttTrend:initView(userData)
    self:addChild(ttTrend)
end
function TTGame:onBoss( userData )
	if userData.result ~= 0 then
		TTUtils:Log("TTGame:onBoss获取上庄列表失败")
		return
	end
	if not self:getChildByName("TTBoss") then
		local ttBoss = TTBoss.new()    
		ttBoss:updateView(userData.waitBankerList)
	    self:addChild(ttBoss)
	end	
end
function TTGame:onNotifyChangeBank( userData )
	local bankNode = self:getTTHeadBank()
	bankNode:clear()
	bankNode:setUserId(userData.bankerId)
	bankNode:updateCoins(userData.coins)
	bankNode:updateHead(userData.avatar, userData.bankerId)
	self:updateBankBtn()

	if TTGameData.userInfo.userId==userData.bankerId then
		self:repeatRemember()
	else
		self:repeatRecover()
	end
end
---------------------------------------------------------------------------------------------------------------------大赢家---------------------------------------------------------
function TTGame:onNotifyMaxWiner( userData )
	self.maxWinerTable = self.maxWinerTable or {}
	for i,v in ipairs(userData.list) do
		table.insert(self.maxWinerTable, v)
	end
end
function TTGame:scheduleSecMaxWiner( dt )--每秒刷新
	local function xpCallMaxWiner()
		if self.maxWinerTable and table.nums(self.maxWinerTable)>0 and self.ttNotifyMaxWinerNode==nil then
			self:showMaxWiner(self.maxWinerTable[1])
			table.remove(self.maxWinerTable,1)
		end
	end
	TTUtils:xpcall(xpCallMaxWiner)	
end
function TTGame:showMaxWiner( data )
	self.ttNotifyMaxWinerNode = cc.CSLoader:createNode("ttNotifyMaxWiner.csb")
	local Panel_head = self.ttNotifyMaxWinerNode:getChildByName("bg"):getChildByName("Panel_head")
	self.ttNotifyMaxWinerNode:getChildByName("bg"):getChildByName("coins"):setString(data.coinsChg)
	self.ttNotifyMaxWinerNode:getChildByName("bg"):getChildByName("gameName"):setString(TTLanguage.a[12][TTGameData.language])
	local x,y = self.Panel_maxWiner:getPosition()
	self.ttNotifyMaxWinerNode:setName("ttNotifyMaxWiner")
	self.ttNotifyMaxWinerNode:setPosition(x, y)
	self.Panel_gps:addChild(self.ttNotifyMaxWinerNode)

	local function removeSelfNode()
		self.ttNotifyMaxWinerNode:removeFromParent()
		self.ttNotifyMaxWinerNode = nil
		if self.maxWinerTexture2d then
			cc.Director:getInstance():getTextureCache():removeTexture(self.maxWinerTexture2d)
			self.maxWinerTexture2d = nil
		end
	end
	self.ttNotifyMaxWinerNode:runAction( cc.Sequence:create(
		cc.MoveBy:create(1.0, cc.p(-200,0)),
		cc.DelayTime:create(4.5),
		cc.FadeOut:create(0.5),
		cc.CallFunc:create(removeSelfNode)
	))
	TTUtils:downloadImage(data.avatar, function( data )
		local function f( )
			if not self or self.updateEverySecond_==nil then
				return
			end
			local headNode = nil
			if data.done==true and self.ttNotifyMaxWinerNode then
				-- 2.头像
				self.maxWinerTexture2d = data.texture2d
				headNode = cc.Sprite:createWithTexture(data.texture2d)
				local headWidth = headNode:getContentSize().width
				local headHeight = headNode:getContentSize().height
				local headMaxSide = ( (headWidth>headHeight and headWidth) or headHeight)
				local ratio = Panel_head:getContentSize().width/headMaxSide
				headNode:setScale(ratio)
				headNode:setPosition(Panel_head:getContentSize().width/2, Panel_head:getContentSize().height/2)
				Panel_head:addChild(headNode)						
			end
		end
		TTUtils:xpcall(f)		
	end)
end
---------------------------------------------------------------------------------------------------------------------动画---------------------------------------------------------
function TTGame:beginBetAni(endCb)
	local ttBeginBet = cc.CSLoader:createNode("ttBeginBet.csb")
	ttBeginBet:setPosition(cc.p(self.winSize_.width/2,self.winSize_.height/2))
    assert(ttBeginBet, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", ttBeginBet))
    self:addChild(ttBeginBet)
    local action = cc.CSLoader:createTimeline("ttBeginBet.csb")
    action:setFrameEventCallFunc(function(frame)
           local event = frame:getEvent();
           TTUtils:Log(string.format("=========",event));
           ttBeginBet:removeFromParent()
           if endCb then
           	   endCb()
           end
   end)
    action:gotoFrameAndPlay(0, false)
    ttBeginBet:runAction(action)
end

---------------------------------------------------------------------------------------------------------------------重复投牛逼上庄再下来的记忆功能---------------------------------------------------------
--记住
function TTGame:repeatRemember()
	if self.CheckBox_bet:isSelected() then
		self.rememberBankId = TTGameData.userInfo.userId
		self.CheckBox_bet:setSelected(false)
	end
	self:setRepeatCheckBoxTouchEnable(false)
end
--恢复
function TTGame:repeatRecover()
	if self.rememberBankId then
		self.rememberBankId = nil
		self.CheckBox_bet:setSelected(true)
	end
	self.CheckBox_bet:setTouchEnabled(true)
end
function TTGame:setRepeatCheckBoxTouchEnable(status)
	if status==true then
		if self:getTTHeadBank():getUserId()
			and TTGameData.userInfo.userId~=self:getTTHeadBank():getUserId()  
			and  table.nums(self.repeatBetTable[TTConstant.BET_ROUND_FIRST]) >0 then
			self.CheckBox_bet:setTouchEnabled(true)
		end
	else
		self.CheckBox_bet:setTouchEnabled(false)
	end
end
function TTGame:resetRepeatTable()
	self.repeatBetTable = self.repeatBetTable or {}
	self.repeatBetTable[TTConstant.BET_ROUND_FIRST] = {}
end
---------------------------------------------------------------------------------------------------------------------更新状态---------------------------------------------------------
function TTGame:updateEverySecond(dt)
	if self.cdTime and self.cdTime>0 then
		self.timeCDLabel:setString(tostring(self.cdTime))
		self.cdTime = self.cdTime - 1
	end
end
--游戏状态
function TTGame:updateGameStatus( status )
	self.gameStatus = status
	if status==TTConstant.GAME_STATUS_XIAZHU then
		self.cdTime = TTGameData.roomInfo.xiaZhuTime
		self.gameStatusLabel:setString( TTLanguage.a[6][TTGameData.language] )
	elseif status==TTConstant.GAME_STATUS_KAIPAI then
		self.cdTime = TTGameData.roomInfo.kaiPaiTime
		self.gameStatusLabel:setString( TTLanguage.a[9][TTGameData.language] )
	elseif status==TTConstant.GAME_STATUS_FREE then
		self.cdTime = TTGameData.roomInfo.freeTime
		TTNet:ready()
		self.gameStatusLabel:setString( TTLanguage.a[10][TTGameData.language] )
		self:clear()
	end
end
--重置中发白三个位置下注的筹码
function TTGame:resetBetCoin()
	for i=0,2 do
		local btnPosName = string.format("btnPos_%d", i)
		local btnPosNode = self.resourceNode_:getChildByName("middle"):getChildByName(btnPosName)
		local Image_bet = btnPosNode:getChildByName("Image_bet")
		local AtlasLabel_num = Image_bet:getChildByName("AtlasLabel_num")
		Image_bet:setVisible(false)
		AtlasLabel_num:setString("0")
		local AtlasLabel_total = btnPosNode:getChildByName("AtlasLabel_total")
		AtlasLabel_total:setVisible(false)
		AtlasLabel_total:setString("0")
	end
end
--筹码是否可以点击
function TTGame:updateCoinTouch()
	for i=0,4 do
		local Button_coinName = string.format("Button_coin%d", i)
		local Button_coin = self.resourceNode_:getChildByName("bottom"):getChildByName(Button_coinName)
		local chip = TTGameData.roomInfo.chips[i+1]--lua下标从1开始
		if TTGameData.userInfo.coins>=TTGameData.roomInfo.playerMultiple*chip then
			Button_coin:setTouchEnabled(true)
			TTUtils:grayUIBtn(Button_coin,false)
		else
			Button_coin:setTouchEnabled(false)
			TTUtils:grayUIBtn(Button_coin)
		end
	end
	for i=1,5 do
		local chip = TTGameData.roomInfo.chips[self.coinIndex_+1]
		if hip~=nil and TTGameData.userInfo.coins<TTGameData.roomInfo.playerMultiple*chip then
			self.coinIndex_ = self.coinIndex_ - 1 --0 1 2 3 4
			if self.coinIndex_<0 then
				self.coinIndex_ = 0
			elseif self.coinIndex_ > 4 then
				self.coinIndex_ = 4
			end
			self:updateSelectBetBtn(self.coinIndex_)
		end
	end
end
--更新自己的金币
function TTGame:updateSelfCoins()
	self.mycoinLabel:setString(tostring(TTGameData.userInfo.coins))
end
--更新庄家的金币
function TTGame:updateBankCoins(coins)
	local bankNode = self:getTTHeadBank()
	bankNode:updateCoins(coins)
end

--更新自己下注的筹码
function TTGame:updateSelfBetCoins(betZone, coins, coinsChg)--betZone 1 2 3 中发白个位置
	local btnPosName = string.format("btnPos_%d", betZone-1)
	local btnPosNode = self.resourceNode_:getChildByName("middle"):getChildByName(btnPosName)
	local Image_bet = btnPosNode:getChildByName("Image_bet")
	local AtlasLabel_num = Image_bet:getChildByName("AtlasLabel_num")

	if nil~=coinsChg then
		Image_bet:setVisible(true)
		AtlasLabel_num:setString(tostring(tonumber(AtlasLabel_num:getString())+coinsChg))
	end
	if coins~=nil and coins==0 then
		Image_bet:setVisible(false)
	elseif coins~=nil then
		Image_bet:setVisible(true)
		AtlasLabel_num:setString(tostring(coins))
	end
	
end
--更新下注区域的总筹码
function TTGame:updateTotalBetCoins(betZone, coins, coinsChg)--betZone 1 2 3 中发白个位置
	local btnPosName = string.format("btnPos_%d", betZone-1)
	local btnPosNode = self.resourceNode_:getChildByName("middle"):getChildByName(btnPosName)
	local AtlasLabel_total = btnPosNode:getChildByName("AtlasLabel_total")

	if nil~=coinsChg then
		AtlasLabel_total:setVisible(true)
		AtlasLabel_total:setString(tostring(tonumber(AtlasLabel_total:getString())+coinsChg))
	end
	if coins~=nil and btnPosNode then
		AtlasLabel_total:setVisible(true)
		AtlasLabel_total:setString(tostring(coins))
	elseif coins~=nil then
		TTUtils:Log("TTGame:updateTotalBetCoins 显示总筹码失败   "..tostring(betZone).."  "..tostring(coins))
	end
	
end
--更新庄家相关的按钮
function TTGame:updateBankBtn()
	local Button_boss = self.resourceNode_:getChildByName("top"):getChildByName("Button_boss")
	local visible = true
	local bankId = self:getTTHeadBank():getUserId()
	if bankId==TTGameData.userInfo.userId then
		visible = false
		Button_boss:loadTextures(TTUtils:getMutiRes("ttimg/btn6_big_quit.png"), TTUtils:getMutiRes("ttimg/btn6_big_quit.png"), "")
	else
		Button_boss:loadTextures(TTUtils:getMutiRes("ttimg/btn6_big.png"), TTUtils:getMutiRes("ttimg/btn6_big.png"), "")
	end
	for i=0,4 do
		local Button_coinName = string.format("Button_coin%d", i)
		local Button_coin = self.resourceNode_:getChildByName("bottom"):getChildByName(Button_coinName)
		Button_coin:setVisible(visible)
	end
end
--更新多语言资源图
function TTGame:updateMultiRes()
	for i=0,2 do --中发白个位置底图
		local btnPos_i = self.resourceNode_:getChildByName("middle"):getChildByName("btnPos_"..i)
		local texturesName = TTUtils:getMutiRes( "ttimg/bg"..(i+3) )
		btnPos_i:loadTextures(texturesName, texturesName, "")
	end
	self.resourceNode_:getChildByName("bottom"):getChildByName("Text_RepeatBet"):setString(TTLanguage.a[11][TTGameData.language])
	self.resourceNode_:getChildByName("bottom"):getChildByName("Text_Trend"):setString(TTLanguage.a[21][TTGameData.language])
end
--更新下注筹码按钮的选中状态
function TTGame:updateSelectBetBtn(selectIndex)
	local selectBetBtn = nil
	local selectFlagName = "selectFlagName"
	for i=0,4 do
		local Button_coinName = string.format("Button_coin%d", i)
		local Button_coin = self.resourceNode_:getChildByName("bottom"):getChildByName(Button_coinName)
		local selectFlagNode = Button_coin:getChildByName(selectFlagName)	
		if selectFlagNode then
			selectFlagNode:removeFromParent()
		end
		if selectIndex==i then
			selectBetBtn = Button_coin
		end
	end
	if selectBetBtn then
		local spFlag = cc.Sprite:create("ttimg/choseFlag.png")
		spFlag:setName(selectFlagName)
		spFlag:setPosition(selectBetBtn:getContentSize().width/2, selectBetBtn:getContentSize().height/2)
		selectBetBtn:addChild(spFlag)
	end	
end
---------------------------------------------------------------------------------------------------------------------前台后台切换---------------------------------------------------------
function TTGame:enterBackground()
	self:clear()
	TTAudio:stopMusic(false)
	TTAudio:stopAllEffects()
end
function TTGame:enterForeground()
	if TTGameData.server~="" then
		TTUtils:showToast( TTLanguage.a[2][TTGameData.language] ,2.0)
		self.cdTime = 1
		self:clear()
		TTNet:reconnect()
	end
	TTAudio:playMusic("ttaudio/mp3/background.mp3",true)
end

---------------------------------------------------------------------------------------------------------------------牛值--------------------------------------------------------
--pos 庄、中、发、白 0 1 2 3 
--resultInfo 服务器结算消息
function TTGame:addNiuCnt( pos, resultInfo )
	local cardsData = resultInfo.cardsData[pos+1]
	if not cardsData then
		TTUtils:Log("获取显示牛值数据失败")
		return
	end
	local niuCnt = cardsData.niuCnt
	local Panel_card = self.Panel_gps:getChildByName( string.format("Panel_card%d", pos))
	local sp = cc.Sprite:create( TTUtils:getMutiRes( string.format("ttimg/paidian_%d.png", niuCnt) ) )
	if Panel_card and sp then
		sp:setName("niuCnt")
		sp:setLocalZOrder(TTConstant.LOCALZORDER_NIU_CNT)
		sp:setPosition(Panel_card:getPositionX(),Panel_card:getPositionY()-sp:getContentSize().height/4)
		self.Panel_gps:addChild(sp)
		--播放牛值音频
		if resultInfo.isAni then
			self:playTTEffect("pai_"..niuCnt)
		end	
	else
		TTUtils:Log("添加牛值显示失败")
	end
end

function TTGame:removeNiuCnt()
	local niuNode = self.Panel_gps:getChildByName("niuCnt")
	if niuNode then
		niuNode:removeFromParent()
		self:removeNiuCnt()
	end
end

---------------------------------------------------------------------------------------------------------------------飞筹码--------------------------------------------------------
function TTGame:resultCoins( resultInfo )
	local isExitBankWin = false--庄家是否在中发白位置有赢
	local isExitBankLose = false--庄家是否在中发白位置有输
	local delayShowResult = 1.5
	local delayFlyCoins = 1.0
	for i=2,4 do
		if resultInfo.cardsData[i].winCoins<0 then
			isExitBankWin = true
		elseif resultInfo.cardsData[i].winCoins>0 then
			isExitBankLose = true
		end
	end
	local function showResultView( )
		local ttResult = TTResult.new()
		ttResult:initView(resultInfo)
		self:addChild(ttResult)
		if resultInfo.coinsChg>0 then
			self:playTTEffect("win")
		elseif resultInfo.coinsChg<0 then
			self:playTTEffect("lose")
		end
	end
	local function updateLatestCoin()
		for i,v in ipairs(resultInfo.seatXiaZhuDetail) do
			TTEvent:dispatchEvent({name=TTMsgId.UPDATE_SEAT_COIN,userData={userId=v.userId,coinsChg=v.coinsChg,coins=v.coins} })
		end		
		TTEvent:dispatchEvent({name=TTMsgId.UPDATE_BANK_COIN,userData={coinsChg=resultInfo.bankerCoins,coins=resultInfo.bankerCoins} })
		TTEvent:dispatchEvent({name=TTMsgId.UPDATE_SELF_COIN,userData={coinsChg=resultInfo.coinsChg,coins=resultInfo.coins} })
	end
	local function zoneToUserEnd()
		updateLatestCoin()
		self:scheduleOnce(showResultView, delayShowResult)
	end

	local function  zoneToUser()
		for i=1,3 do--1-3中发白
			for k,v in pairs(TTCoinManager.betCoinTable[i]) do
				--(coinNode,userId,pCb)
				TTCoinManager:zoneCoinsToUser(v)
				if #resultInfo.seatXiaZhuDetail<=6 then--当在玩人数少于等于六个人时，筹码不会飞到游客
					v:setVisible(false)
				end
			end
		end
		for k1,v1 in ipairs(resultInfo.seatXiaZhuDetail) do
			local limitNum = 1
			for k2,v2 in pairs(v1.xiaZhuCoins) do--k2对应 中发白 是字符串转成数字
				local zone = tonumber(k2)  ---Zone = 1 2 3 4
				--cardsData 1 2 3 4 5 庄 天 地 玄 黄
				if v2>0 and resultInfo.cardsData[zone+1].winCoins>0 and limitNum<TTConstant.MAX_ONCE_COIN_NUM then
					--zone,coins,userId,pCb
					TTCoinManager:zoneNewCoinsToUser(zone, v2, v1.userId)
				end
				limitNum = limitNum+1	
			end		
		end	
		self:scheduleOnce(zoneToUserEnd,delayFlyCoins)
	end

	local function bankToZone()
		local zoneWinCount = 0
		local coinBankNodeCount = table.nums(TTCoinManager.betCoinTable[TTConstant.POS_ZHUANG])
		local tmpTable = {}
		local tmpIndex = 0
		tmpTable[0] = {}
		tmpTable[1] = {}
		tmpTable[2] = {}--庄家赢得的筹码最多分到三个区域，庄家通赔的时候不会有区域筹码飞到庄家 庄家筹码飞到区域
		for i=2,4 do
			if resultInfo.cardsData[i].winCoins>0 then
				zoneWinCount = zoneWinCount + 1
			end
		end
		for k,v in pairs(TTCoinManager.betCoinTable[TTConstant.POS_ZHUANG]) do
			local yushu = k%zoneWinCount
			table.insert(tmpTable[yushu], v)
		end
		TTCoinManager.betCoinTable[TTConstant.POS_ZHUANG] = {}
		for i=2,4 do
			if resultInfo.cardsData[i].winCoins>0 then
				TTUtils:Log("tmpIndex = "..tmpIndex)
				for k,v in pairs(tmpTable[tmpIndex]) do
					TTCoinManager:bankToZone(v,i-1)
					table.insert(TTCoinManager.betCoinTable[i-1], v)
				end
				tmpIndex = tmpIndex+1
			end
		end
		self:scheduleOnce(zoneToUser,delayFlyCoins)
	end
	local function bankNewToZone()--庄家通赔，创建出一些筹码飞到下注区域
		TTCoinManager:bankNewCoinsToZone()
		self:scheduleOnce(zoneToUser,delayFlyCoins)
	end
	local function zoneToBankEnd()
		if isExitBankLose then
			bankToZone()
		else
			updateLatestCoin()
			self:scheduleOnce(showResultView, delayShowResult)
		end
	end
	local function zoneToBank()
		for i=2,4 do
			if resultInfo.cardsData[i].winCoins<0 then
				for k,v in pairs(TTCoinManager.betCoinTable[i-1]) do
					TTCoinManager:zoneToBank(v)
					table.insert(TTCoinManager.betCoinTable[TTConstant.POS_ZHUANG], v)
				end
				TTCoinManager.betCoinTable[i-1] = {}
			end
		end
		self:scheduleOnce(zoneToBankEnd,delayFlyCoins)
	end

	if isExitBankWin then
		self:scheduleOnce(zoneToBank, delayFlyCoins)
	else
		self:scheduleOnce(bankNewToZone, delayFlyCoins)
	end
	
end


function TTGame:scheduleOnce( pCb, delayTime)--有局限性，调用需明白其原理
	if self.exitAction_ then
		TTUtils:Log("TTGame:scheduleOnce 取消上一个action")
		self:stopAllActions()
	end
	local function callBack()		
		self.exitAction_ = false
		if pCb then
			pCb()
		end
	end	
	self.exitAction_ = true
	self:runAction(cc.Sequence:create(
		cc.DelayTime:create(delayTime),
		cc.CallFunc:create(callBack)
	))
end
function TTGame:clear()
	self:stopAllActions()
	TTCoinManager:clear()
	TTPokerManager:clear()
	self:resetBetCoin()
	self:removeNiuCnt()
	local ttResult = self:getChildByName("TTResult")
	if ttResult then
		ttResult:removeFromParent()
	end
end
function TTGame:repeatBet()
	local chipList = {}
	local betRound = TTConstant.BET_ROUND_FIRST
	if self.CheckBox_bet:isSelected() and
		table.nums(self.repeatBetTable[betRound])>0 and 
		self:getTTHeadBank():getUserId()~=TTGameData.userInfo.userId then
		for k,v in ipairs(self.repeatBetTable[betRound]) do
			table.insert(chipList,v.pos)
			table.insert(chipList,v.index)
		end	
 		TTNet:bet(chipList)
 	end
 	self.repeatBetTable[betRound] = {}
end
function TTGame:playTTEffect( name )
	-- if cc.PLATFORM_OS_ANDROID == targetPlatform then
	-- 	return TTAudio:playEffect("ttaudio/ogg/"..name..".ogg")
	-- else
		return TTAudio:playEffect("ttaudio/mp3/"..name..".mp3")
	--end
end
function TTGame:stopTTEffect( nSoundId )
	 TTAudio:stopEffect(nSoundId)
end

------------------------------http短链接相关---------------------------------------
function TTGame:httpDpqLogin()
	self._reqHttpLoginCDTime = 3.0
	TTNet:httpDpqLogin()
	--TTNet:httpGuestLogin()
end
function TTGame:updateHttpConnect(dt)
	if self._reqHttpLoginCDTime>0 then
		self._reqHttpLoginCDTime = self._reqHttpLoginCDTime - dt
		if self._reqHttpLoginCDTime<0 then
			self._reqHttpLoginCDTime = 0
		end
		if self._reqHttpLoginCDTime==0 then
			self:httpDpqLogin()
			TTUtils:showToast(TTLanguage.a[23][TTGameData.language])
		end
	end
end

return TTGame
