local NNViewBase = import("..nn.NNViewBase")
local NNNet = import("..nn.NNNet")
local NNPoker = import("..nn.NNPoker")
local NNBoss = import("..nn.NNBoss")
local NNHelp = import("..nn.NNHelp")
local NNTrend = import("..nn.NNTrend")
local NNResult = import("..nn.NNResult")
local NNHead = import("..nn.NNHead")
local NNMsgId = import("..nn.NNMsgId")
local NNEvent = import("..nn.NNEvent")
local NNUtils = import("..nn.NNUtils")
local NNTips = import("..nn.NNTips")
local NNTest = import("..nn.NNTest")
local NNConstant = import("..nn.NNConstant")
local NNGameData = import("..nn.NNGameData")
local NNLanguage = import("..nn.NNLanguage")
local NNPokerManager = import("..nn.NNPokerManager")
local NNCoinManager = import("..nn.NNCoinManager")
local NNAudio = import("..nn.NNAudio")
local NNGame = class("NNGame", NNViewBase)
local scheduler = cc.Director:getInstance():getScheduler()
local targetPlatform = cc.Application:getInstance():getTargetPlatform()
function NNGame:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	NNUtils:Log("NNGame:onCreate")
	NNUtils:Log(string.format("winSize width=%f,height=%f",self.winSize_.width,self.winSize_.height))
	local ratio = self.winSize_.width/self.winSize_.height
	local phonePlatform = NNUtils:GetPhonePlatform()
	self:createResoueceNode("nnGame"..phonePlatform..".csb")	

	--适配
	local phonePlatform = NNUtils:GetPhonePlatform()
    if "Iphone6s"==phonePlatform then--fixed高
        self.resourceNode_:setScaleY(self.winSize_.height/2208.0)
    elseif "Ipad"==phonePlatform then --fixed宽        
        self.resourceNode_:setScaleY(self.winSize_.height/2208.0)
    end
    

	--按钮事件
	NNUtils:setOnViewClickedListener("Button_help",function(view)
		self:helpEvent(view)
	end,self.resourceNode_)
	NNUtils:setOnViewClickedListener("Button_close",function(view)
		self:closeEvent(view)
	end,self.resourceNode_)
	NNUtils:setOnViewClickedListener("Button_boss",function(view)
		self:bossEvent(view)
	end,self.resourceNode_)
	NNUtils:setOnViewClickedListener("Button_trend",function(view)
		self:trendEvent(view)
	end,self.resourceNode_)	
	for i=0,3 do
		local btnPosName = string.format("btnPos_%d", i)
		local btnPosNode = self.resourceNode_:getChildByName("middle"):getChildByName(btnPosName)
		btnPosNode.posIndex = i+1
		NNUtils:setOnViewClickedListener(btnPosNode,function(view)
			self:betEvent(view)
		end,self.resourceNode_,"static")
	end
	NNUtils:setOnViewClickedListener("CheckBox_bet",function(view)
		self:repeatBetEvent(view)
	end,self.resourceNode_,"static")
	for i=0,4 do
		local Button_coinName = string.format("Button_coin%d", i)
		local Button_coin = self.resourceNode_:getChildByName("bottom"):getChildByName(Button_coinName)
		Button_coin.coinIndex = i
		NNUtils:setOnViewClickedListener(Button_coin,function(view)
			self:selectCoinEvent(view)
		end,self.resourceNode_)		
	end
	--node节点
	self.timeCDLabel = NNUtils:findNodeByName("time_cd", self.resourceNode_)
	self.gameStatusLabel = NNUtils:findNodeByName("game_status", self.resourceNode_)
	self.CheckBox_bet = NNUtils:findNodeByName("CheckBox_bet", self.resourceNode_)	
	self.mycoinLabel = NNUtils:findNodeByName("Text_mycoin", self.resourceNode_)	
	self.Panel_gps = self.resourceNode_:getChildByName("Panel_gps")

	NNUtils:init(self)
	NNEvent:init()
	NNLanguage:loadLanguageCsvFile("nnLanguage.csv")
	
	self:onNodeEvent("enter")
    self:onNodeEvent("exit")
	self:initHeads()
	

	local Panel_gpsChildred = self.Panel_gps:getChildren()
	for k,v in pairs(Panel_gpsChildred) do
		v:setBackGroundColorOpacity(0)
	end
	NNPokerManager:setNNGameNode(self)
	NNCoinManager:setNNGameNode(self)
	self:clear()
	self:resetRepeatTable()
	self:setRepeatCheckBoxTouchEnable(false)
	self.CheckBox_bet:setSelected(false)

	self._reqHttpLoginCDTime = 0--请求http超时倒计时
end
function NNGame:onEnter()
	self:registNNEvent()
	cc.SpriteFrameCache:getInstance():addSpriteFrames("nnPokerAtlas.plist")
	--播放背景音乐
	NNAudio:playMusic("nnaudio/mp3/background.mp3",true)
	self:preloadEffect()
	NNCoinManager:intervalShowCoin()

	self.delayInit_ = scheduler:scheduleScriptFunc(function( dt )
		if self.delayInit_ then			
			scheduler:unscheduleScriptEntry(self.delayInit_)
			self.delayInit_ = nil;
			self:delayInit()
		end
	end, 0, false)
	self.delayTest_ = scheduler:scheduleScriptFunc(function( dt )
		if self.delayTest_ then			
			scheduler:unscheduleScriptEntry(self.delayTest_)
			self.delayTest_ = nil;
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
function NNGame:onExit()
	NNUtils:Log("NNGame onExit")
    --停止背景音乐
	self:uncacheEffect()
 	NNAudio:stopMusic(true)
	NNEvent:removeAllEventListeners()
	NNCoinManager:destroyCoinPool()
	NNCoinManager:destroyShowCoin()
	NNPokerManager:destroyPokerPool()
    cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile("nnPokerAtlas.plist")
    scheduler:unscheduleScriptEntry(self.updateEverySecond_)
    scheduler:unscheduleScriptEntry(self.updateHttpConnect_)
    scheduler:unscheduleScriptEntry(self.scheduleSecMaxWiner_)

    if self.delayReconnect_ then
    	scheduler:unscheduleScriptEntry(self.delayReconnect_)
    end
    if self.delayInit_ then
    	scheduler:unscheduleScriptEntry(self.delayInit_)
    	self.delayInit_ = nil
    end
    if self.delayTest_ then
    	scheduler:unscheduleScriptEntry(self.delayTest_)
		self.delayTest_ = nil;
	end
	--大赢家头像
	local nnNotifyMaxWinerNode = self.Panel_gps:getChildByName("nnNotifyMaxWiner")
	if nnNotifyMaxWinerNode then
		nnNotifyMaxWinerNode:removeFromParent()
	end
	if self.maxWinerTexture2d then
		cc.Director:getInstance():getTextureCache():removeTexture(self.maxWinerTexture2d)
		self.maxWinerTexture2d = nil
	end
	--断开网络
	NNNet:standUp()
	NNNet:close()
end
function NNGame:initData( data )
	dump(data)
	local initLog = os.date("%Y-%m-%d %H:%M:%S", os.time()).."  牛牛小游戏启动初始化信息： \n"
	for key,value in pairs(data) do
		initLog = initLog.."  "..tostring(key).."  :  "..tostring(value).." \n"
	end
	NNUtils:writeLog(nil,initLog)

	local exitError = false
	local function dataError( msg )
		exitError = true
		NNUtils:Log("初始化数据失败  "..msg)
		NNUtils:showToast(msg,5.0)
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



	NNGameData.userInfo.userId = data.uuid
	NNGameData.avatar = data.avatar
	NNGameData.userInfo.coins = tonumber(data.coins)
	NNGameData.isDebug = data.isDebug
	NNGameData.language = data.language
	NNGameData.dpqToken = data.token
	if nil==NNGameData.userInfo.coins  then
		dataError("初始化数据失败,coins数据不正确")
		return
	end
	if data.language~=1 then-- and data.language~=2 and data.language~=3 
		dataError("初始化数据失败,暂不支持语言")
		return
	end
	if data.isEffectsAudio then		
		NNGameData.isEffectsAudio = true
		NNGameData.isBackgroundMusic = true
		NNGameData.effectsVolume = 1.0
		NNGameData.backgroundMusicVolume = 1.0
	else
		NNGameData.isEffectsAudio = false
		NNGameData.isBackgroundMusic = false
	end	
	NNGameData.sex = data.sex
	--可选
	--可选
	if data.imei and type(data.imei)=="string" and data.imei~="" then
		NNGameData.imei = data.imei
	else
		NNGameData.imei = tostring( NNUtils:random(1000000,999999999) )	
	end

	if data.model and type(data.model)=="string" then
		NNGameData.model = data.model
	end
	-- if data.version and type(data.version)=="string" then
	-- 	NNGameData.version = data.version
	-- end
	if data.channel and type(data.channel)=="string" then
		NNGameData.channel = data.channel
	end
	if data.platform and type(data.platform)=="string" then
		NNGameData.platform = data.platform
	end

	self:updateMultiRes()

end
function NNGame:registNNEvent()
	 self._,self.handle1 = NNEvent:on(NNMsgId.WEBSOCKET_ONOPEN,function(event)--websocket打开
	 	NNNet:loginHall()
    end)
    self._,self.handle2 = NNEvent:on(NNMsgId.MSGID_LOGIN_GUEST+NNMsgId.ID_ACK,function(event)--游客登录返回
    	self:onGuestLogin(event.userData)
    end)
    self._,self.handle3 = NNEvent:on(NNMsgId.MSGID_LOGIN_DPQ+NNMsgId.ID_ACK,function(event)--德扑圈登录返回
    	self:onDpqLogin(event.userData)
    end)
    self._,self.handle1003 = NNEvent:on(NNMsgId.MSGID_LOGIN_HALL+NNMsgId.ID_ACK,function(event)--长连接websocket登录返回
    	self:onLoginHall(event.userData)
    end)
    self._,self.handle4 = NNEvent:on(NNMsgId.MSGID_QUICK_START+NNMsgId.ID_ACK,function(event)--进入房间返回
    	self:onJoinRoom(event.userData)
    end)
    self._,self.handle5 = NNEvent:on(NNMsgId.MSGID_JOIN_TABLE+NNMsgId.ID_ACK,function(event)--进入桌子返回
    	self:onJoinTable(event.userData)
    end)
	self._,self.handle6 = NNEvent:on(NNMsgId.WEBSOCKET_ONCLOSE,function(event)--web socket断开
		NNUtils:Log(event.userData.reconnectTimes)
		if event.userData.reconnectTimes>1 then
			self.delayReconnect_ = scheduler:scheduleScriptFunc(function( dt )
				scheduler:unscheduleScriptEntry(self.delayReconnect_)
				self.delayReconnect_ = nil
				NNUtils:showToast( NNLanguage.a[2][NNGameData.language] ,2.0)
				NNNet:create()
			end, 3, false)
		else
			NNNet:create()
		end    	
    end)
    self._,self.handle7 = NNEvent:on(NNMsgId.MSGID_BAI_STATUS+NNMsgId.ID_NTF,function(event)--游戏状态切换通知
    	self:onNotifyChangeGameStatus(event.userData)
    end)
    self._,self.handle8 = NNEvent:on(NNMsgId.MSGID_BAI_XIAZHU+NNMsgId.ID_ACK,function(event)--下注返回
    	self:onBet(event.userData)
    end)
    self._,self.handle9 = NNEvent:on(NNMsgId.MSGID_BAI_XIAZHU+NNMsgId.ID_NTF,function(event)--下注通知
    	self:onNotifyBet(event.userData)
    end)
    self._,self.handle10 = NNEvent:on(NNMsgId.PLAY_PEEKANI_END,function(event)--撵牌动画播放完毕
		self:addNiuCnt(event.userData.pos,event.userData.notifyResultInfo)
    end) 
    self._,self.handle11 = NNEvent:on(NNMsgId.UPDATE_BANK_COIN,function(event)--更新庄家金币
		self:updateBankCoins(event.userData.coins)
    end) 
    self._,self.handle12 = NNEvent:on(NNMsgId.UPDATE_SELF_COIN,function(event)--更新自己金币
		NNGameData.userInfo.coins = event.userData.coins
		self:updateSelfCoins()
    end) 
	self._,self.handle13 = NNEvent:on(NNMsgId.MSGID_BAI_WIN_HISTORY+NNMsgId.ID_ACK,function(event)--趋势返回
    	self:onTrend(event.userData)
    end)
    self._,self.handle14 = NNEvent:on(NNMsgId.MSGID_BAI_WAIT_BANKER_LIST+NNMsgId.ID_ACK,function(event)--上庄列表返回
    	self:onBoss(event.userData)
    end)
    self._,self.handle15 = NNEvent:on(NNMsgId.MSGID_BAI_CHANGE_BANKER+NNMsgId.ID_NTF,function(event)--换庄通知
    	self:onNotifyChangeBank(event.userData)
    end)
    self._,self.handle16 = NNEvent:on(NNMsgId.MSGID_BAI_QUIT_BANKER+NNMsgId.ID_NTF,function(event)--下庄通知
    	NNUtils:showToast(event.userData.desc)
    end)
    self._,self.handle17 = NNEvent:on(NNMsgId.MSGID_BAI_BANKER_COINS_LIMIT+NNMsgId.ID_NTF,function(event)--下注金额达到庄家上限：
		NNUtils:showToast(NNLanguage.a[20][NNGameData.language])
    end)
    self._,self.handle18 = NNEvent:on(NNMsgId.MSGID_READY+NNMsgId.ID_ACK,function(event)--准备返回
    end)
    self._,self.handle19 = NNEvent:on(NNMsgId.MSGID_BAI_QUIT_BANKER+NNMsgId.ID_ACK,function(event)--取消上庄返回
        if self.gameStatus~=NNConstant.GAME_STATUS_FREE and 0==event.userData.result and NNGameData.userInfo.userId==self:getNNHeadBank():getUserId() then
        	NNUtils:showToast( NNLanguage.a[3][NNGameData.language] )
        end
    end)
    self._,self.handle20 = NNEvent:on(NNMsgId.MSGID_BAI_BIG_WINNER+NNMsgId.ID_NTF,function(event)--大赢家通知
    	self:onNotifyMaxWiner(event.userData)
    end)
    self._,self.handle21 = NNEvent:on(NNMsgId.UPDATE_SELF_BET_COIN,function(event)--更新自己下注的筹码数量显示
    	--betZone, coins, coinsChg --betZone 1 2 3 4 天地玄黄四个位置
		self:updateSelfBetCoins(event.userData.betZone, nil , event.userData.coinsChg)
    end) 
    self._,self.handle22 = NNEvent:on(NNMsgId.UPDATE_TOTAL_BET_COIN,function(event)--更新天地玄黄区域下注的筹码数量显示
		--betZone, coins, coinsChg --betZone 1 2 3 4 天地玄黄四个位置
		self:updateTotalBetCoins(event.userData.betZone, nil , event.userData.coinsChg)
    end)
    self._,self.handle23 = NNEvent:on(NNMsgId.HTTP_DPQ_LOGIN,function(event)--http登录返回
		if event.userData.result==0 then--http登录成功
			self._reqHttpLoginCDTime = 0
			if NNGameData.server=="" then
				NNGameData.server = event.userData.host..":"..event.userData.port
				NNGameData.httpLoginToken = event.userData.token
				NNGameData.userInfo.userId = event.userData.userId
				NNUtils.Log("NNGameData.server = "..NNGameData.server)
				NNNet:create()
			end
		end    	
    end)

end
function NNGame:delayInit()
	NNCoinManager:initCoinPool()
	NNPokerManager:initPokerPool()
	self:httpDpqLogin()


	-- --测试筹码位置
	-- for i=1,4 do
	-- 	for j=1,100 do
	-- 		NNCoinManager:cacheBet({},i,nil,false)
	-- 	end
	-- end
	

	-- NNPokerManager:clear()
	-- NNCoinManager:clear()
	-- self:removeNiuCnt()
	-- self:resetBetCoin()
	-- for i=1,4 do
	-- 	for j=1,50 do
	-- 		--betZone,coinIndex,seatId,isAni
	-- 		NNCoinManager:cacheBet({},i-1,nil,false)
	-- 	end
	-- end

	-- local resultMsg = NNTest:getResultMsg()--结算消息内容
	-- NNPokerManager:dealPoker(resultMsg.resultInfo)
end
function NNGame:delaydTest()
	NNUtils:Log("delaydTest")


    --随机测试
	-- self.lxftest_spTable = {}
	-- local speed = 0.25
	-- local seq = cc.Sequence:create( cc.MoveBy:create(speed, cc.p(0,2000)), cc.MoveBy:create(speed, cc.p(-600,0)), cc.MoveBy:create(speed, cc.p(0,-2000)), cc.MoveBy:create(speed, cc.p(600,0) ) )
 --    local rep = cc.RepeatForever:create(seq)       
	-- for i=1,3000 do
 --        local sp = cc.Sprite:create()
 --        local spriteFrameName = string.format("nnpoker/chip_%d.png", 10)
 --        sp:setSpriteFrame(spriteFrameName)
 --        sp:setPosition(800, 200)
 --        NNCoinManager.Panel_gps:addChild(sp)        
	-- 	table.insert(self.lxftest_spTable, sp)
 --    end
 --    local lxftest = scheduler:scheduleScriptFunc(function( dt )
	-- 	local len = NNUtils:random(40,50)
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
	-- 	    sp:setLocalZOrder(NNUtils:random(1,1000))
	-- 		sp:runAction(seq)
	-- 	end
	-- end, 0.7, false)



	--压力测试最大筹码量
	-- self.delayTest_ = scheduler:scheduleScriptFunc(function( dt )	
	-- 	local cacheBetTable	 = {}
	-- 	local betRound = NNConstant.BET_ROUND_FIRST
	-- 	if self.gameStatus==NNConstant.GAME_STATUS_SECOND_XIAZHU then
	-- 		betRound = NNConstant.BET_ROUND_SECOND
	-- 	end
	-- 	if self.gameStatus==NNConstant.GAME_STATUS_SECOND_XIAZHU or self.gameStatus==NNConstant.GAME_STATUS_FIRST_XIAZHU then
	-- 		for i=1,100 do
	-- 			local item = {}
	-- 			item.betGps = {betZone=NNUtils:random(1,4),betRound=betRound}
	-- 			item.coinIndex = 0
	-- 			item.seatId = NNConstant.SEATID_SELF
	-- 			item.isAni = true
	-- 			table.insert(cacheBetTable, item)
	-- 			NNCoinManager:cacheBet(item.betGps, item.coinIndex, item.seatId, item.isAni)
	-- 		end
	-- 	end		
	-- end, 0.1, false)

end

function NNGame:preloadEffect()
	NNAudio:preloadEffect("nnaudio/mp3/beginBet.mp3")
	NNAudio:preloadEffect("nnaudio/mp3/bet1.mp3")
	NNAudio:preloadEffect("nnaudio/mp3/deal.mp3")

	NNAudio:preloadEffect("nnaudio/mp3/flyCoins.mp3")
	NNAudio:preloadEffect("nnaudio/mp3/lose.mp3")

	NNAudio:preloadEffect("nnaudio/mp3/stopBet.mp3")
	NNAudio:preloadEffect("nnaudio/mp3/win.mp3")
	for i=0,10 do
		NNAudio:preloadEffect(string.format("nnaudio/mp3/famale_niu_%d.mp3", i))
	end
	for i=15,18 do
		NNAudio:preloadEffect(string.format("nnaudio/mp3/famale_niu_%d.mp3", i))
	end
	for i=0,10 do
		NNAudio:preloadEffect(string.format("nnaudio/mp3/male_niu_%d.mp3", i))
	end
	for i=15,18 do
		NNAudio:preloadEffect(string.format("nnaudio/mp3/male_niu_%d.mp3", i))
	end
end
function NNGame:uncacheEffect()
	NNAudio:uncacheEffect("nnaudio/mp3/beginBet.mp3")
	NNAudio:uncacheEffect("nnaudio/mp3/bet1.mp3")
	NNAudio:uncacheEffect("nnaudio/mp3/deal.mp3")

	NNAudio:uncacheEffect("nnaudio/mp3/flyCoins.mp3")
	NNAudio:uncacheEffect("nnaudio/mp3/lose.mp3")

	NNAudio:uncacheEffect("nnaudio/mp3/stopBet.mp3")
	NNAudio:uncacheEffect("nnaudio/mp3/win.mp3")
	for i=0,10 do
		NNAudio:uncacheEffect(string.format("nnaudio/mp3/famale_niu_%d.mp3", i))
	end
	for i=15,18 do
		NNAudio:uncacheEffect(string.format("nnaudio/mp3/famale_niu_%d.mp3", i))
	end
	for i=0,10 do
		NNAudio:uncacheEffect(string.format("nnaudio/mp3/male_niu_%d.mp3", i))
	end
	for i=15,18 do
		NNAudio:uncacheEffect(string.format("nnaudio/mp3/male_niu_%d.mp3", i))
	end
end
---------------------------------------------------------------------------------------------------------------------头像---------------------------------------------------------
function NNGame:initHeads()
	self.headNodes_ = {}
	for i=0,5 do
		local headPanel = self.resourceNode_:getChildByName("middle"):getChildByName(string.format("head_%d",i))
		headPanel:setBackGroundColorOpacity(0)
		local headNode = NNHead.new()
		headNode:setSeatId(i)
		headNode:setPosition(headPanel:getContentSize().width/2, headPanel:getContentSize().height/2)
		headPanel:addChild(headNode)
		table.insert(self.headNodes_, headNode)
	end
	local headPanel = self.resourceNode_:getChildByName("top"):getChildByName("head_bank")
	headPanel:setBackGroundColorOpacity(0)
	local headNode = NNHead.new()
	headNode:setBank(true)
	headNode:setPosition(headPanel:getContentSize().width/2, headPanel:getContentSize().height/2)
	headPanel:addChild(headNode)
	table.insert(self.headNodes_, headNode)

end
function NNGame:getHeadNodes()
	return self.headNodes_
end
function NNGame:getSeatIdByUserId(userId)
	for k,v in pairs(self.headNodes_) do
		if userId and userId==v:getUserId() then
			return v.seatId
		end
	end
	return nil
end
function NNGame:getNNHeadByUserId(userId)
	for k,v in pairs(self.headNodes_) do
		if userId and userId==v:getUserId() then
			return v
		end
	end
	return nil
end
function NNGame:getNNHeadBySeatId(seatId)
	for k,v in pairs(self.headNodes_) do
		if seatId~=nil and seatId==v.seatId then
			return v
		end
	end
	return nil
end
function NNGame:getGpsPosByUserId( userId )
	local seatId = self:getSeatIdByUserId(userId)	
	if seatId~=nil then
		local x,y =  self.Panel_gps:getChildByName(string.format("Panel_head%d",seatId)):getPosition()				
		return cc.p(x,y)
	end
	if userId==NNGameData.userInfo.userId then
		local x,y = self.Panel_gps:getChildByName("Panel_coinSelf"):getPosition()
		return cc.p(x,y)
	end
	local x,y = self.Panel_gps:getChildByName("Panel_coinGuest"):getPosition()
	return cc.p(x,y)
end
function NNGame:getNNHeadBank()
	for k,v in pairs(self.headNodes_) do
		if v.isBank then
			return v
		end
	end
	return nil
end
---------------------------------------------------------------------------------------------------------------------按钮事件---------------------------------------------------------
function NNGame:bossEvent(view)
	NNUtils:Log("bossEvent")
	local isBoss = (self:getNNHeadBank():getUserId()==NNGameData.userInfo.userId)
	local function quitBank()
		NNNet:quitBank()
	end
	if isBoss then
		local nnTips = NNTips.new()
		nnTips:initView(NNLanguage.a[14][NNGameData.language],quitBank)
		self:addChild(nnTips)
	else
		NNNet:waitBankList()
	end	
end
function NNGame:closeEvent(view)
	self:removeFromParent()
end
function NNGame:helpEvent(view)
	self:addChild(NNHelp.new())
end
function NNGame:betEvent(view)
 	NNUtils:Log("betEvent name: "..view:getName())
 	local betRound = NNConstant.BET_ROUND_FIRST
	if self.gameStatus==NNConstant.GAME_STATUS_SECOND_XIAZHU then
		betRound = NNConstant.BET_ROUND_SECOND
	end
 	if self.gameStatus==NNConstant.GAME_STATUS_FIRST_XIAZHU or self.gameStatus==NNConstant.GAME_STATUS_SECOND_XIAZHU then
	 	if self:getNNHeadBank():getUserId()~=NNGameData.userInfo.userId then
 			NNNet:bet({view.posIndex,self.coinIndex_})
 		end
 	end 	

 	self.CheckBox_bet:setSelected(false)
end
function NNGame:repeatBetEvent(view)
	NNUtils:Log("点击了重复投")
end
function NNGame:trendEvent( view )
	NNNet:trent()
end
function NNGame:selectCoinEvent( view )
	self.coinIndex_ = view.coinIndex--0 1 2 3 4
	self:updateSelectBetBtn(self.coinIndex_)
end
---------------------------------------------------------------------------------------------------------------------消息事件---------------------------------------------------------
function NNGame:onGuestLogin(userData)
	if 0~=userData.result then
		NNUtils:showToast(userData.reason,2.0)
		self:removeFromParent()
		return
	end
	NNGameData.userInfo = userData.userInfo
	NNNet:joinRoom(101)
end
function NNGame:onDpqLogin( userData )
	if 0~=userData.result then
		NNUtils:showToast(userData.reason,2.0)
		self:removeFromParent()
		return
	end
	NNNet:joinRoom(101)
end
function NNGame:onLoginHall(userData)
	if 0~=userData.result then
		NNUtils:showToast(userData.reason,2.0)
		NNUtils:writeLog(nil,"websocket loginHall fail")
		self:removeFromParent()
		return
	end
	NNNet:joinRoom(101)
end
function NNGame:onJoinRoom( userData )
	if 0~=userData.result then
		NNUtils:showToast(userData.reason,2.0)
		self:removeFromParent()
		return
	end
	NNNet:joinTable(userData.tableId)
end
function NNGame:onJoinTable( userData )
	if 0~=userData.result then
		NNUtils:showToast(userData.reason,2.0)
		self:removeFromParent()
		return
	end

	-- userData = NNTest:getJoinTableMsg()
	-- dump(userData)
	-- NNNet:close()
	self:clear()
	self:selectCoinEvent(self.resourceNode_:getChildByName("bottom"):getChildByName("Button_coin0"))--默认选择第一个筹码
	NNGameData.userInfo.coins = userData.boardInfo.coins
	NNGameData.roomInfo = userData.boardInfo.roomInfo
	self:updateCoinTouch()
	self:updateGameStatus(userData.boardInfo.gameStatus)
	self.cdTime =  userData.boardInfo.leftTime
	self:updateSelfCoins()	
	local bankNode = self:getNNHeadBank()
	local isAni = false
	bankNode:setUserId(userData.boardInfo.bankerInfo.bankerId)
	bankNode:updateCoins(userData.boardInfo.bankerInfo.coins)
	bankNode:updateHead(userData.boardInfo.bankerInfo.avatar, userData.boardInfo.bankerInfo.bankerId)
	--更新在座玩家的头像、金币
	for k,v in pairs(userData.boardInfo.seatPlayersInfo) do
		local nnHead = self:getNNHeadBySeatId(v.seatId)
		if nnHead then
			nnHead:clear()
			nnHead:setUserId(v.userId)
			nnHead:updateCoins(v.coins)
			nnHead:updateHead(v.avatar, v.userId)
		else
			NNUtils:Log("服务器发送在座玩家的座位号错误 "..v.seatId)
		end
	end
	local function betInfo()
		for k,v in pairs(userData.boardInfo.resultInfo.xiaZhuCoins) do
			self:updateSelfBetCoins(k,v)
		end
		for k,v in pairs(userData.boardInfo.resultInfo.totalXiaZhuCoins) do
			self:updateTotalBetCoins(k,v)
		end
		for k1,v1 in pairs(userData.boardInfo.resultInfo.totalXiaZhuDetail) do--k1=first second
			local betRound = NNConstant.BET_ROUND_FIRST
			if k1=="second" then
				betRound = NNConstant.BET_ROUND_SECOND
			end
			for k2,v2 in pairs(v1) do--k2 = 1 2 3 4 天地玄黄
				local coinNum = 0
				for k3,v3 in ipairs(v2) do--v3筹码的index
					--betGps,coinIndex,seatId,isAni
					NNCoinManager:bet({betZone=k2,betRound=betRound},v3,nil,isAni)
					coinNum = coinNum+1
					if coinNum>math.floor(NNConstant.MAX_ONCE_COIN_NUM/1) then
						break
					end
				end
				
			end
		end		
	end
	local function dealPokerEnd()
		if userData.boardInfo.gameStatus==NNConstant.GAME_STATUS_KAIPAI then
			NNPokerManager:peekPokerAni(userData.boardInfo.resultInfo,isAni)
		end
	end
	if userData.boardInfo.gameStatus==NNConstant.GAME_STATUS_FIRST_XIAZHU then
		betInfo()
	elseif userData.boardInfo.gameStatus==NNConstant.GAME_STATUS_FAPAI or userData.boardInfo.gameStatus==NNConstant.GAME_STATUS_SECOND_XIAZHU then
		betInfo()
		NNPokerManager:dealPoker(userData.boardInfo.resultInfo.cardsData, isAni)
	elseif userData.boardInfo.gameStatus==NNConstant.GAME_STATUS_KAIPAI then
		betInfo()
		NNPokerManager:dealPoker(userData.boardInfo.resultInfo.cardsData, isAni, dealPokerEnd)
	end

	self:updateBankBtn()
	self:resetRepeatTable()
	self:setRepeatCheckBoxTouchEnable(false)
	self.CheckBox_bet:setSelected(false)
end
function NNGame:onBet( userData )
	if 1==userData.result then--重复投失败	
		NNUtils:showToast(NNLanguage.a[18][NNGameData.language])
		self.resetRepeatTable()
	elseif 2==userData.result then--下注金额已达到个人上限		
		NNUtils:showToast(NNLanguage.a[19][NNGameData.language])
	elseif 3==userData.result then--庄家不能下注
		NNUtils:showToast(NNLanguage.a[17][NNGameData.language])
	elseif 4==userData.result then--下注金额已达到庄家上限
		NNUtils:showToast(NNLanguage.a[20][NNGameData.language])
	end
	if userData.result ~= 0 and userData.reason then
		return
	end
	local betZone = nil
	local coinIndex = 0
	local betLimitTable = {}
	local betRound = NNConstant.BET_ROUND_FIRST
	if self.gameStatus==NNConstant.GAME_STATUS_SECOND_XIAZHU then
		betRound = NNConstant.BET_ROUND_SECOND
	end
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
			if nil==cacheZoneLimit[betZone] or cacheZoneLimit[betZone]<=math.floor(NNConstant.CACHE_FLYCOIN_NUM/4) then
				cacheZoneLimit[betZone] = cacheZoneLimit[betZone] or 1
				cacheZoneLimit[betZone] = cacheZoneLimit[betZone]+1
				local item = {}
				item.betGps = {betZone=betZone,betRound=betRound}
				item.coinIndex = coinIndex
				item.seatId = NNConstant.SEATID_SELF
				item.isAni = true
				table.insert(cacheBetTable, item)
			end					
			--记录本局的重复投
			table.insert(self.repeatBetTable[betRound], {pos=betZone, index=coinIndex}) 		
		else
			betZone = v
		end
	end
	NNUtils:shuffleTable(cacheBetTable)
	for i,v in ipairs(cacheBetTable) do
		NNCoinManager:cacheBet(v.betGps, v.coinIndex, v.seatId, v.isAni)
	end

	NNGameData.userInfo.coins = userData.coins
	for k,v in pairs(userData.xiaZhuCoins) do--k 1 2 3 4 天地玄黄四个位置
		local cacheCoinNumTable = NNCoinManager:getCacheCoinNumSelf()
		self:updateSelfBetCoins(k,v-cacheCoinNumTable[tonumber(k)])--更新自己的总下注数量
	end
	for k,v in pairs(userData.totalXiaZhuCoins) do--k 1 2 3 4 天地玄黄四个位置
		local cacheCoinNumTable = NNCoinManager:getCacheCoinNumTotal()
		self:updateTotalBetCoins(k,v-cacheCoinNumTable[tonumber(k)])--更新天地玄黄的总下注数量
	end
	
	self:updateSelfCoins()--更新自己的筹码数量
	NNEvent:dispatchEvent({name=NNMsgId.UPDATE_SEAT_COIN,userData={userId=NNGameData.userInfo.userId,coins=NNGameData.userInfo.coins} })--如果自己坐在牌桌子，也更新显示
	self:updateCoinTouch()--更新筹码按钮是否可点击
	self:setRepeatCheckBoxTouchEnable(true)

	--选中下注的筹码自动下降
	if table.nums(userData.chipList)==2 and userData.chipList[2]~=userData.reqChipIndex then
		self.coinIndex_ = userData.chipList[2]--0 1 2 3 4
		self:updateSelectBetBtn(self.coinIndex_)
		NNUtils:showToast(NNLanguage.a[22][NNGameData.language])--投注过大
	end
end
function NNGame:onNotifyBet( userData )
	local betRound = NNConstant.BET_ROUND_FIRST
	if self.gameStatus==NNConstant.GAME_STATUS_SECOND_XIAZHU then
		betRound = NNConstant.BET_ROUND_SECOND
	end
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
				if userId~=NNGameData.userInfo.userId then
					if betLimitTable[k1]==nil then
						betLimitTable[k1] = 1
					else
						betLimitTable[k1] = betLimitTable[k1]+1
					end
					if nil==cacheZoneLimit[betZone] or cacheZoneLimit[betZone]<=math.floor(NNConstant.CACHE_FLYCOIN_NUM/4) then
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
	NNUtils:shuffleTable(cacheBetTable)
	for i,v in ipairs(cacheBetTable) do
		NNCoinManager:cacheBet(v.betGps, v.coinIndex, v.seatId, v.isAni)
	end
	for k,v in pairs(userData.totalXiaZhuCoins) do--k等于betZone
		local cacheCoinNumTable = NNCoinManager:getCacheCoinNumTotal()
		self:updateTotalBetCoins(k, v-cacheCoinNumTable[tonumber(k)])
	end
	for k,v in pairs(userData.seatPlayersInfo) do
		local nnHead = self:getNNHeadByUserId(v.userId)
		if nnHead then
			nnHead:updateCoins(v.coins)--更新在坐玩家的筹码
		end
	end
end
function NNGame:onNotifyChangeGameStatus( userData )
	self:updateGameStatus(userData.gameStatus)
	if userData.gameStatus==NNConstant.GAME_STATUS_FIRST_XIAZHU then
		local function aniEnd()
			if not self.CheckBox_bet:isSelected() then
				self:resetRepeatTable()
				self:setRepeatCheckBoxTouchEnable(false)
 			end
			self:repeatBet()
		end
		self:beginBetAni(aniEnd)
		self:playNNEffect("beginBet")
		NNGameData.roomInfo = userData.roomInfo
	elseif userData.gameStatus==NNConstant.GAME_STATUS_FAPAI then
		NNCoinManager:clearCoinCache()--不再飞筹码
		self:playNNEffect("stopBet")
		NNPokerManager:dealPoker(userData.cardsData)
	elseif userData.gameStatus==NNConstant.GAME_STATUS_SECOND_XIAZHU then
		self:repeatBet()
		self:playNNEffect("beginBet")
	elseif userData.gameStatus==NNConstant.GAME_STATUS_KAIPAI then
		NNCoinManager:clearCoinCache()--不再飞筹码
		NNPokerManager:peekPokerAni(userData.resultInfo, true)
		self:playNNEffect("stopBet")
	elseif status==NNConstant.GAME_STATUS_FREE then

	end
end
function NNGame:onTrend( userData )
	if userData.result ~= 0 then
		NNUtils:Log("获取趋势失败")
		return
	end
	local nnTrend = NNTrend.new()
	nnTrend:initView(userData)
    self:addChild(nnTrend)
end
function NNGame:onBoss( userData )
	if userData.result ~= 0 then
		NNUtils:Log("NNGame:onBoss获取上庄列表失败")
		return
	end
	if not self:getChildByName("NNBoss") then
		local nnBoss = NNBoss.new()    
		nnBoss:updateView(userData.waitBankerList)
	    self:addChild(nnBoss)
	end	
end
function NNGame:onNotifyChangeBank( userData )
	local bankNode = self:getNNHeadBank()
	bankNode:clear()
	bankNode:setUserId(userData.bankerId)
	bankNode:updateCoins(userData.coins)
	bankNode:updateHead(userData.avatar, userData.bankerId)
	self:updateBankBtn()

	if NNGameData.userInfo.userId==userData.bankerId then
		self:repeatRemember()
	else
		self:repeatRecover()
	end
end
---------------------------------------------------------------------------------------------------------------------大赢家---------------------------------------------------------
function NNGame:onNotifyMaxWiner( userData )
	self.maxWinerTable = self.maxWinerTable or {}
	for i,v in ipairs(userData.list) do
		table.insert(self.maxWinerTable, v)
	end
end
function NNGame:scheduleSecMaxWiner( dt )--每秒刷新
	local function xpCallMaxWiner()
		local nnNotifyMaxWinerNode = self.Panel_gps:getChildByName("nnNotifyMaxWiner")
		if self.maxWinerTable and table.nums(self.maxWinerTable)>0 and nnNotifyMaxWinerNode==nil then
			self:showMaxWiner(self.maxWinerTable[1])
			table.remove(self.maxWinerTable,1)
		end
	end	
	NNUtils:xpcall(xpCallMaxWiner)
end
function NNGame:showMaxWiner( data )
	local nnNotifyMaxWiner = cc.CSLoader:createNode("nnNotifyMaxWiner.csb")
	local Panel_head = nnNotifyMaxWiner:getChildByName("bg"):getChildByName("Panel_head")
	nnNotifyMaxWiner:getChildByName("bg"):getChildByName("coins"):setString(data.coinsChg)
	nnNotifyMaxWiner:getChildByName("bg"):getChildByName("gameName"):setString(NNLanguage.a[12][NNGameData.language])
	local x,y = self.Panel_gps:getChildByName("Panel_maxWiner"):getPosition()
	nnNotifyMaxWiner:setName("nnNotifyMaxWiner")
	nnNotifyMaxWiner:setPosition(x, y)
	self.Panel_gps:addChild(nnNotifyMaxWiner)

	local function removeSelfNode()
		nnNotifyMaxWiner:removeFromParent()
		if self.maxWinerTexture2d then
			cc.Director:getInstance():getTextureCache():removeTexture(self.maxWinerTexture2d)
			self.maxWinerTexture2d = nil
		end
	end
	nnNotifyMaxWiner:runAction( cc.Sequence:create(
		cc.MoveBy:create(1.0, cc.p(-200,0)),
		cc.DelayTime:create(4.5),
		cc.FadeOut:create(0.5),
		cc.CallFunc:create(removeSelfNode)
	))
	NNUtils:downloadImage(data.avatar, function( data )		
		if not self or self.updateEverySecond_==nil then
			return
		end
		local function f()
			local headNode = nil
			if data.done==true then
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
		NNUtils:xpcall(f)
	end)
end
---------------------------------------------------------------------------------------------------------------------动画---------------------------------------------------------
function NNGame:beginBetAni(endCb)
	local nnBeginBet = cc.CSLoader:createNode("nnBeginBet.csb")
	nnBeginBet:setPosition(cc.p(self.winSize_.width/2,self.winSize_.height/2))
    assert(nnBeginBet, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", nnBeginBet))
    self:addChild(nnBeginBet)
    local action = cc.CSLoader:createTimeline("nnBeginBet.csb")
    action:setFrameEventCallFunc(function(frame)
           local event = frame:getEvent();
           NNUtils:Log(string.format("=========",event));
           nnBeginBet:removeFromParent()
           if endCb then
           	   endCb()
           end
   end)
    action:gotoFrameAndPlay(0, false)
    nnBeginBet:runAction(action)
end

---------------------------------------------------------------------------------------------------------------------重复投牛逼上庄再下来的记忆功能---------------------------------------------------------
--记住
function NNGame:repeatRemember()
	if self.CheckBox_bet:isSelected() then
		self.rememberBankId = NNGameData.userInfo.userId
		self.CheckBox_bet:setSelected(false)
	end
	self:setRepeatCheckBoxTouchEnable(false)
end
--恢复
function NNGame:repeatRecover()
	if self.rememberBankId then
		self.rememberBankId = nil
		self.CheckBox_bet:setSelected(true)
	end
	self:setRepeatCheckBoxTouchEnable(true)
end
function NNGame:setRepeatCheckBoxTouchEnable(status)
	if status==true then
		if self:getNNHeadBank():getUserId()
			and NNGameData.userInfo.userId~=self:getNNHeadBank():getUserId()  
			and  (table.nums(self.repeatBetTable[NNConstant.BET_ROUND_FIRST]) + table.nums(self.repeatBetTable[NNConstant.BET_ROUND_SECOND]) )>0 then
			self.CheckBox_bet:setTouchEnabled(true)
		end
	else
		self.CheckBox_bet:setTouchEnabled(false)
	end
end
function NNGame:resetRepeatTable()
	self.repeatBetTable = self.repeatBetTable or {}
	self.repeatBetTable[NNConstant.BET_ROUND_FIRST] = {}
	self.repeatBetTable[NNConstant.BET_ROUND_SECOND] = {}
end
---------------------------------------------------------------------------------------------------------------------更新状态---------------------------------------------------------
function NNGame:updateEverySecond(dt)
	if self.cdTime and self.cdTime>0 then
		self.timeCDLabel:setString(tostring(self.cdTime))
		self.cdTime = self.cdTime - 1
	end
end
--游戏状态
function NNGame:updateGameStatus( status )
	self.gameStatus = status
	if status==NNConstant.GAME_STATUS_FIRST_XIAZHU then
		self.cdTime = NNGameData.roomInfo.firstXiaZhuTime
		self.gameStatusLabel:setString( NNLanguage.a[6][NNGameData.language] )
	elseif status==NNConstant.GAME_STATUS_FAPAI then
		self.cdTime = NNGameData.roomInfo.faPaiTime
		self.gameStatusLabel:setString( NNLanguage.a[8][NNGameData.language] )
	elseif status==NNConstant.GAME_STATUS_SECOND_XIAZHU then
		self.cdTime = NNGameData.roomInfo.secondXiaZhuTime
		self.gameStatusLabel:setString( NNLanguage.a[7][NNGameData.language] )
	elseif status==NNConstant.GAME_STATUS_KAIPAI then
		self.cdTime = NNGameData.roomInfo.kaiPaiTime
		self.gameStatusLabel:setString( NNLanguage.a[9][NNGameData.language] )
	elseif status==NNConstant.GAME_STATUS_FREE then
		self.cdTime = NNGameData.roomInfo.freeTime
		NNNet:ready()
		self.gameStatusLabel:setString( NNLanguage.a[10][NNGameData.language] )
		self:clear()
	end
end
--重置天地玄黄四个位置下注的筹码
function NNGame:resetBetCoin()
	for i=0,3 do
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
function NNGame:updateCoinTouch()
	for i=0,4 do
		local Button_coinName = string.format("Button_coin%d", i)
		local Button_coin = self.resourceNode_:getChildByName("bottom"):getChildByName(Button_coinName)
		local chip = NNGameData.roomInfo.chips[i+1]--lua下标从1开始
		if NNGameData.userInfo.coins>=NNGameData.roomInfo.playerMultiple*chip then
			Button_coin:setTouchEnabled(true)
			NNUtils:grayUIBtn(Button_coin,false)
		else
			Button_coin:setTouchEnabled(false)
			NNUtils:grayUIBtn(Button_coin)
		end
	end
	for i=1,5 do
		local chip = NNGameData.roomInfo.chips[self.coinIndex_+1]	
		if chip~=nil and NNGameData.userInfo.coins<NNGameData.roomInfo.playerMultiple*chip then
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
function NNGame:updateSelfCoins()
	self.mycoinLabel:setString(tostring(NNGameData.userInfo.coins))
end
--更新庄家的金币
function NNGame:updateBankCoins(coins)
	local bankNode = self:getNNHeadBank()
	bankNode:updateCoins(coins)
end

--更新自己下注的筹码
function NNGame:updateSelfBetCoins(betZone, coins, coinsChg)--betZone 1 2 3 4 天地玄黄四个位置
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
function NNGame:updateTotalBetCoins(betZone, coins, coinsChg)--betZone 1 2 3 4 天地玄黄四个位置
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
		NNUtils:Log("NNGame:updateTotalBetCoins 显示总筹码失败   "..betZone.."  "..coins)
	end
	
end
--更新庄家相关的按钮
function NNGame:updateBankBtn()
	local Button_boss = self.resourceNode_:getChildByName("top"):getChildByName("Button_boss")
	local visible = true
	local bankId = self:getNNHeadBank():getUserId()
	if bankId==NNGameData.userInfo.userId then
		visible = false
		Button_boss:loadTextures(NNUtils:getMutiRes("nnimg/btn6_big_quit.png"), NNUtils:getMutiRes("nnimg/btn6_big_quit.png"), "")
	else
		Button_boss:loadTextures(NNUtils:getMutiRes("nnimg/btn6_big.png"), NNUtils:getMutiRes("nnimg/btn6_big.png"), "")
	end
	for i=0,4 do
		local Button_coinName = string.format("Button_coin%d", i)
		local Button_coin = self.resourceNode_:getChildByName("bottom"):getChildByName(Button_coinName)
		Button_coin:setVisible(visible)
	end
end
--更新多语言资源图
function NNGame:updateMultiRes()
	for i=0,3 do--天地玄黄底图
		local btnPos_i = self.resourceNode_:getChildByName("middle"):getChildByName("btnPos_"..i)
		local texturesName = NNUtils:getMutiRes( "nnimg/bg"..(i+3) )
		btnPos_i:loadTextures(texturesName, texturesName, "")
	end
	self.resourceNode_:getChildByName("bottom"):getChildByName("Text_RepeatBet"):setString(NNLanguage.a[11][NNGameData.language])
	self.resourceNode_:getChildByName("bottom"):getChildByName("Text_Trend"):setString(NNLanguage.a[21][NNGameData.language])
end
--更新下注筹码按钮的选中状态
function NNGame:updateSelectBetBtn(selectIndex)
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
		local spFlag = cc.Sprite:create("nnimg/choseFlag.png")
		spFlag:setName(selectFlagName)
		spFlag:setPosition(selectBetBtn:getContentSize().width/2, selectBetBtn:getContentSize().height/2)
		selectBetBtn:addChild(spFlag)
	end	
end
---------------------------------------------------------------------------------------------------------------------前台后台切换---------------------------------------------------------
function NNGame:enterBackground()
	self:clear()
	NNAudio:stopMusic(false)
	NNAudio:stopAllEffects()
end
function NNGame:enterForeground()
	if NNGameData.server~="" then
		NNUtils:showToast( NNLanguage.a[2][NNGameData.language] ,2.0)
		self:clear()
		NNNet:reconnect()
	end
	NNAudio:playMusic("nnaudio/mp3/background.mp3",true)
end

---------------------------------------------------------------------------------------------------------------------牛值--------------------------------------------------------
--pos 庄、天、地、玄、黄 0 1 2 3 4 
--resultInfo 服务器结算消息
function NNGame:addNiuCnt( pos, resultInfo )
	local cardsData = resultInfo.cardsData[pos+1]
	if not cardsData then
		NNUtils:Log("获取显示牛值数据失败")
		return
	end
	local niuCnt = cardsData.niuCnt
	local Panel_card = self.Panel_gps:getChildByName( string.format("Panel_card%d", pos))
	local sp = cc.Sprite:create( NNUtils:getMutiRes( string.format("nnimg/niu%d.png", niuCnt) ) )
	if Panel_card and sp then
		sp:setName("niuCnt")
		sp:setLocalZOrder(NNConstant.LOCALZORDER_NIU_CNT)
		sp:setPosition(Panel_card:getPositionX(),Panel_card:getPositionY()-sp:getContentSize().height/4)
		self.Panel_gps:addChild(sp)
		--播放牛值音频
		if resultInfo.isAni then
			self:playNNEffect(NNGameData.sex.."_niu_"..niuCnt)
		end	
	else
		NNUtils:Log("添加牛值显示失败")
	end
	if pos == NNConstant.POS_ZHUANG and resultInfo.isAni then
		self:resultCoins(resultInfo)
	end
end
function NNGame:removeNiuCnt()
	local niuNode = self.Panel_gps:getChildByName("niuCnt")
	if niuNode then
		niuNode:removeFromParent()
		self:removeNiuCnt()
	end
end
---------------------------------------------------------------------------------------------------------------------飞筹码--------------------------------------------------------
function NNGame:resultCoins( resultInfo )
	local isExitBankWin = false--庄家是否在天地玄黄位置有赢
	local isExitBankLose = false--庄家是否在天地玄黄位置有输
	local delayShowResult = 1.5
	local delayFlyCoins = 1.0
	for i=2,5 do
		if resultInfo.cardsData[i].winCoins<0 then
			isExitBankWin = true
		elseif resultInfo.cardsData[i].winCoins>0 then
			isExitBankLose = true
		end
	end
	local function showResultView( )
		local nnResult = NNResult.new()
		nnResult:initView(resultInfo)
		self:addChild(nnResult)
		if resultInfo.coinsChg>0 then
			self:playNNEffect("win")
		elseif resultInfo.coinsChg<0 then
			self:playNNEffect("lose")
		end
	end
	local function updateLatestCoin()
		for i,v in ipairs(resultInfo.seatXiaZhuDetail) do
			NNEvent:dispatchEvent({name=NNMsgId.UPDATE_SEAT_COIN,userData={userId=v.userId,coinsChg=v.coinsChg,coins=v.coins} })
		end		
		NNEvent:dispatchEvent({name=NNMsgId.UPDATE_BANK_COIN,userData={coinsChg=resultInfo.bankerCoins,coins=resultInfo.bankerCoins} })
		NNEvent:dispatchEvent({name=NNMsgId.UPDATE_SELF_COIN,userData={coinsChg=resultInfo.coinsChg,coins=resultInfo.coins} })
	end
	local function zoneToUserEnd()
		updateLatestCoin()
		self:scheduleOnce(showResultView, delayShowResult)
	end

	local function  zoneToUser()
		for i=1,4 do--1-4天地玄黄
			for k,v in pairs(NNCoinManager.betCoinTable[i]) do
				--(coinNode,userId,pCb)
				NNCoinManager:zoneCoinsToUser(v)
				if #resultInfo.seatXiaZhuDetail<=6 then--当在玩人数少于等于六个人时，筹码不会飞到游客
					v:setVisible(false)
				end
			end
		end
		for k1,v1 in ipairs(resultInfo.seatXiaZhuDetail) do
			for k2,v2 in pairs(v1.xiaZhuCoins) do--k2对应 天地玄黄 是字符串转成数字
				local zone = tonumber(k2)  ---Zone = 1 2 3 4
				--cardsData 1 2 3 4 5 庄 天 地 玄 黄
				if v2>0 and resultInfo.cardsData[zone+1].winCoins>0 then
					--zone,coins,userId,pCb
					NNCoinManager:zoneNewCoinsToUser(zone, v2, v1.userId)
				end
			end			
		end	
		self:scheduleOnce(zoneToUserEnd,delayFlyCoins)
	end

	local function bankToZone()
		local zoneWinCount = 0
		local coinBankNodeCount = table.nums(NNCoinManager.betCoinTable[NNConstant.POS_ZHUANG])
		local tmpTable = {}
		local tmpIndex = 0
		tmpTable[0] = {}
		tmpTable[1] = {}
		tmpTable[2] = {}--庄家赢得的筹码最多分到三个区域，庄家通赔的时候不会有区域筹码飞到庄家 庄家筹码飞到区域
		for i=2,5 do
			if resultInfo.cardsData[i].winCoins>0 then
				zoneWinCount = zoneWinCount + 1
			end
		end
		for k,v in pairs(NNCoinManager.betCoinTable[NNConstant.POS_ZHUANG]) do
			local yushu = k%zoneWinCount
			table.insert(tmpTable[yushu], v)
		end
		NNCoinManager.betCoinTable[NNConstant.POS_ZHUANG] = {}
		for i=2,5 do
			if resultInfo.cardsData[i].winCoins>0 then
				NNUtils:Log("tmpIndex = "..tmpIndex)
				for k,v in pairs(tmpTable[tmpIndex]) do
					NNCoinManager:bankToZone(v,i-1)
					table.insert(NNCoinManager.betCoinTable[i-1], v)
				end
				tmpIndex = tmpIndex+1
			end
		end
		self:scheduleOnce(zoneToUser,delayFlyCoins)
	end
	local function bankNewToZone()--庄家通赔，创建出一些筹码飞到下注区域
		NNCoinManager:bankNewCoinsToZone()
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
		for i=2,5 do
			if resultInfo.cardsData[i].winCoins<0 then
				for k,v in pairs(NNCoinManager.betCoinTable[i-1]) do
					NNCoinManager:zoneToBank(v)
					table.insert(NNCoinManager.betCoinTable[NNConstant.POS_ZHUANG], v)
				end
				NNCoinManager.betCoinTable[i-1] = {}
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


function NNGame:scheduleOnce( pCb, delayTime)--有局限性，调用需明白其原理
	if self.exitAction_ then
		NNUtils:Log("NNGame:scheduleOnce 取消上一个action")
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
function NNGame:clear()
	self:stopAllActions()
	NNCoinManager:clear()
	NNPokerManager:clear()
	self:removeNiuCnt()
	self:resetBetCoin()
	local nnResult = self:getChildByName("NNResult")
	if nnResult then
		nnResult:removeFromParent()
	end
end
function NNGame:repeatBet()
	local chipList = {}
	local betRound = NNConstant.BET_ROUND_FIRST
	if self.gameStatus==NNConstant.GAME_STATUS_SECOND_XIAZHU then
		betRound = NNConstant.BET_ROUND_SECOND
	end

	if self.CheckBox_bet:isSelected() and
		table.nums(self.repeatBetTable[betRound])>0 and 
		self:getNNHeadBank():getUserId()~=NNGameData.userInfo.userId then
		for k,v in ipairs(self.repeatBetTable[betRound]) do
			table.insert(chipList,v.pos)
			table.insert(chipList,v.index)
		end	
 		NNNet:bet(chipList)
 	end
	self.repeatBetTable[betRound] = {}
end
function NNGame:playNNEffect( name )
	-- if cc.PLATFORM_OS_ANDROID == targetPlatform then
	-- 	return NNAudio:playEffect("nnaudio/ogg/"..name..".ogg")
	-- else
		return NNAudio:playEffect("nnaudio/mp3/"..name..".mp3")
	--end
end
function NNGame:stopNNEffect( nSoundId )
	 NNAudio:stopEffect(nSoundId)
end

------------------------------http短链接相关---------------------------------------
function NNGame:httpDpqLogin()
	self._reqHttpLoginCDTime = 3.0
	NNNet:httpDpqLogin()
	--NNNet:httpGuestLogin()
end
function NNGame:updateHttpConnect(dt)
	if self._reqHttpLoginCDTime>0 then
		self._reqHttpLoginCDTime = self._reqHttpLoginCDTime - dt
		if self._reqHttpLoginCDTime<0 then
			self._reqHttpLoginCDTime = 0
		end
		if self._reqHttpLoginCDTime==0 then
			self:httpDpqLogin()
			NNUtils:showToast(NNLanguage.a[23][NNGameData.language])
		end
	end
end


return NNGame
