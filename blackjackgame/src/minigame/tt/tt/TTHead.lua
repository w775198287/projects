local TTViewBase = import("..tt.TTViewBase")
local TTUtils = import("..tt.TTUtils")
local TTConstant = import("..tt.TTConstant")
local TTEvent = import("..tt.TTEvent")
local TTMsgId = import("..tt.TTMsgId")
local TTNet = import("..tt.TTNet")
local TTGameData = import("..tt.TTGameData")
local TTLanguage = import("..tt.TTLanguage")
local TTHead = class("TTHead", TTViewBase)
local scheduler = cc.Director:getInstance():getScheduler()
function TTHead:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self:setName("TTHead")
	self:createResoueceNode("ttHead.csb")
	--按钮事件
	TTUtils:setOnViewClickedListener("Button_seat",function(view)
		self:seatEvent(view)
	end,self.resourceNode_)

	self.headBg = self.resourceNode_:getChildByName("headBg")
	self.Button_seat = self.headBg:getChildByName("Button_seat")
	self.Button_seat:setTouchEnabled(false)
	self.Text_coin = self.resourceNode_:getChildByName("Text_coin")
	self.Text_coin:setVisible(false)
	self.BitmapFontLabel_1 = self.resourceNode_:getChildByName("BitmapFontLabel_1")
	self.userId_ = nil
	self.isBank = false
	self:registTTEvent()
	self:onNodeEvent("enter")
    self:onNodeEvent("exit")
	self:updateMultiRes()
end
function TTHead:onEnter()
	self.updateEverySecond_ = scheduler:scheduleScriptFunc(function( dt )
		if self.updateEverySecond_ then
			self:updateEveryShotTime()
		end		
	end, 0.05, false)
end
function TTHead:onExit()
	TTUtils:Log("TTHead onExit")
	if self.updateEverySecond_ then
    	scheduler:unscheduleScriptEntry(self.updateEverySecond_)
		self.updateEverySecond_ = nil
    end
	self:clear()

end
function TTHead:registTTEvent()
	self._,self.handle1 = TTEvent:on(TTMsgId.ID_ACK+TTMsgId.MSGID_SIT_DOWN,function(event)--坐下返回
		if event.userData.seatId==self.seatId then
			if event.userData.result~=0 then
				TTUtils:showToast(event.userData.reason)
			end
		end
    end)
    self._,self.handle2 = TTEvent:on(TTMsgId.UPDATE_SEAT_COIN,function(event)--更新金币
		if event.userData.userId and event.userData.userId==self.userId_ then
			self:updateCoins(event.userData.coins,event.userData.coinsChg)
		end
    end)
    self._,self.handle3 = TTEvent:on(TTMsgId.ID_NTF+TTMsgId.MSGID_TABLE_EVENT,function(event)--桌子事件通知
		for k,v in ipairs(event.userData.eventList) do
			if v.eventType==TTConstant.TABLE_EVENT_SIT_DOWN then
				self:onNotifySitDown(v)
			elseif v.eventType==TTConstant.TABLE_EVENT_STAND_UP then
				if self.isBank==false then
					self:onNotifyStandUp(v)
				end				
			elseif v.eventType==TTConstant.TABLE_EVENT_KICK_OFF then
				self:onNotifyKickOff(v)
			end			 
		end
    end)
    
end
--更新多语言资源图
function TTHead:updateMultiRes()
    self.resourceNode_:getChildByName("headBg"):getChildByName("Button_seat"):loadTextures(TTUtils:getMutiRes("ttimg/btn8.png"), TTUtils:getMutiRes("ttimg/btn8.png"), "")    
end
function TTHead:updateEveryShotTime(dt)
    local function f()
    	local headNode = self.headBg:getChildByName("headNode")
		if self.userId_==nil and headNode then--疯狂点击会莫名其妙的出现头像显示出来
			headNode:removeFromParent()
			if self.texture2d then
				cc.Director:getInstance():getTextureCache():removeTexture(self.texture2d)
				self.texture2d = nil
			end
		end
    end
    TTUtils:xpcall(f)
end
function TTHead:onNotifySitDown( data )
	if data.seatId==self.seatId then
		self:clear()--避免一个位置出现坐多个人，服务器不出bug可以不用调用
		self:setUserId(data.userInfo.userId)
		self:updateCoins(data.userInfo.coins)
		self:updateHead(data.userInfo.avatar,data.userInfo.userId)
	end
end
function TTHead:onNotifyStandUp( data )
	if data.userId==self.userId_ then
		self:clear()
	end
end
function TTHead:onNotifyKickOff( data )
	if data.kickedUserId==self.userId_ then
		self:clear()		
	end
end

function TTHead:setSeatId(seatId)
	self.seatId = seatId
end
function TTHead:setUserId(userId)
	self.userId_ = userId

	local seatIdTemp = -1
	local userIdTemp = -1
	if nil==self.seatId then
		seatIdTemp = -99999999
	else
		seatIdTemp = self.seatId
	end
	if nil==self.userId_ then
		userIdTemp = -99999999
	else
		userIdTemp = self.userId_
	end
	TTUtils:Log("设置用户ID 座位号="..tostring(seatIdTemp).." ,用户ID="..tostring(userIdTemp))
end
function TTHead:setBank(status)
	self.isBank = status
	self.Text_coin:setTextColor(cc.c4b(245, 255, 17, 255))
end
function TTHead:seatEvent(view)	
	if self.seatId~=nil and self.userId_==nil then
		
	end	
end
function TTHead:getUserId()
	local seatIdTemp = -1
	local userIdTemp = -1
	if nil==self.seatId then
		seatIdTemp = -99999999
	else
		seatIdTemp = self.seatId
	end
	if nil==self.userId_ then
		userIdTemp = -99999999
	else
		userIdTemp = self.userId_
	end
	TTUtils:Log("获取用户ID 座位号="..tostring(seatIdTemp).." ,用户ID="..tostring(userIdTemp))

	return self.userId_
end

function TTHead:clear()
	self.userId_ = nil
	self.Button_seat:setVisible(true)
	self.Text_coin:setVisible(false)
	local headNode = self.headBg:getChildByName("headNode")
	if headNode then
		headNode:removeFromParent()
	end
	if self.texture2d then
		cc.Director:getInstance():getTextureCache():removeTexture(self.texture2d)
		self.texture2d = nil
	end
	self.BitmapFontLabel_1:stopAllActions()
	self.BitmapFontLabel_1:setVisible(false)
end
function TTHead:updateCoins(coins,coinsChg)
	local coinString = ""
	if coins > 100000000 then--1亿
		if TTGameData.language==TTConstant.LANGUAGE_EN then
            coinString = string.format("%.0f", coins/1000.0)..TTLanguage.a[13][TTGameData.language]
        elseif TTGameData.language==TTConstant.LANGUAGE_ZH_HANT then
            coinString = string.format("%.0f", coins/10000.0)..TTLanguage.a[13][TTGameData.language]
        elseif TTGameData.language==TTConstant.LANGUAGE_ZH_SIMPLE then
            coinString = string.format("%.0f", coins/10000.0)..TTLanguage.a[13][TTGameData.language]
        end
    else
    	coinString = tostring(coins)
    end

	self.Text_coin:setString(coinString)
	if coinsChg~=nil and coinsChg~=0 then
		local BitmapFontLabel_1 = self.BitmapFontLabel_1
		local pm = ""--加减
		if coinsChg>=0 then
			pm = "+"
			BitmapFontLabel_1:setFntFile("ttimg/numberGreen.fnt")
		else
			BitmapFontLabel_1:setFntFile("ttimg/numberRed.fnt")
		end	
		BitmapFontLabel_1:setString(pm..tostring(coinsChg))--TTUtils:formtNumber(coinsChg)
		local startPos = nil
		local endPos = nil
		if self.seatId==0 or self.seatId==1 or self.seatId==2 then
			startPos = cc.p(100,0)
		else
			startPos = cc.p(-100,0)
		end
		endPos = cc.p(startPos.x,70)	
		BitmapFontLabel_1:setPosition(startPos)
		BitmapFontLabel_1:setVisible(true)
		BitmapFontLabel_1:setScale(1.5)
		local function playEnd( node )
			BitmapFontLabel_1:setVisible(false)
		end
		BitmapFontLabel_1:runAction( cc.Sequence:create(cc.MoveTo:create(0.5, endPos), cc.DelayTime:create(1.5), cc.CallFunc:create(playEnd)) )
	end	
end
function TTHead:updateHead( url ,userId)
	TTUtils:downloadImage(url, function( data )
		if not self or nil==self.userId_ or self:getUserId()~=userId then		
			return
		end
		local headNodeName = "headNode"
		local oldHeadNode = self.headBg:getChildByName(headNodeName)
		if oldHeadNode then
			oldHeadNode:removeFromParent()
		end
		if self.texture2d then
			cc.Director:getInstance():getTextureCache():removeTexture(self.texture2d)
			self.texture2d = nil
		end
		local headNode = nil
		if data.done==true then
			-- 2.头像
			self.texture2d = data.texture2d
			headNode = cc.Sprite:createWithTexture(data.texture2d)
		else
			if TTGameData.sex=="male" then
				headNode = cc.Sprite:create("ttimg/headMale.png")
			else
				headNode = cc.Sprite:create("ttimg/headFamale.png")
			end
		end
		local headWidth = headNode:getContentSize().width
		local headHeight = headNode:getContentSize().height
		local headMaxSide = ( (headWidth>headHeight and headWidth) or headHeight)
		local ratio = self.headBg:getContentSize().width/headMaxSide
		headNode:setScale(ratio)
		headNode:setName(headNodeName)
		headNode:setPosition(self.headBg:getContentSize().width/2, self.headBg:getContentSize().height/2)
		self.headBg:addChild(headNode)
		--显示
		self.Button_seat:setVisible(false)
		self.Text_coin:setVisible(true)
	end)
end
return TTHead
