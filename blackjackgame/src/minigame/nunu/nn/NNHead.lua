local NNViewBase = import("..nn.NNViewBase")
local NNUtils = import("..nn.NNUtils")
local NNConstant = import("..nn.NNConstant")
local NNEvent = import("..nn.NNEvent")
local NNMsgId = import("..nn.NNMsgId")
local NNNet = import("..nn.NNNet")
local NNGameData = import("..nn.NNGameData")
local NNLanguage = import("..nn.NNLanguage")
local NNHead = class("NNHead", NNViewBase)
local scheduler = cc.Director:getInstance():getScheduler()
function NNHead:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self:setName("NNHead")
	self:createResoueceNode("nnHead.csb")
	--按钮事件
	NNUtils:setOnViewClickedListener("Button_seat",function(view)
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
	self:registNNEvent()
	self:onNodeEvent("enter")
    self:onNodeEvent("exit")
	self:updateMultiRes()
end
function NNHead:onEnter()
	self.updateEveryShotTime_ = scheduler:scheduleScriptFunc(function( dt )
		if self.updateEveryShotTime_ then
			self:updateEveryShotTime()
		end		
	end, 0.05, false)
end
function NNHead:onExit()
	NNUtils:Log("NNHead onExit")
	if self.updateEveryShotTime_ then
    	scheduler:unscheduleScriptEntry(self.updateEveryShotTime_)
		self.updateEveryShotTime_ = nil
    end
	self:clear()

end
function NNHead:registNNEvent()
	self._,self.handle1 = NNEvent:on(NNMsgId.ID_ACK+NNMsgId.MSGID_SIT_DOWN,function(event)--坐下返回
		if event.userData.seatId==self.seatId then
			if event.userData.result~=0 then
				NNUtils:showToast(event.userData.reason)
			end
		end
    end)
    self._,self.handle2 = NNEvent:on(NNMsgId.UPDATE_SEAT_COIN,function(event)--更新金币
		if event.userData.userId and event.userData.userId==self.userId_ then
			self:updateCoins(event.userData.coins,event.userData.coinsChg)
		end
    end)
    self._,self.handle3 = NNEvent:on(NNMsgId.ID_NTF+NNMsgId.MSGID_TABLE_EVENT,function(event)--桌子事件通知
		for k,v in ipairs(event.userData.eventList) do
			if v.eventType==NNConstant.TABLE_EVENT_SIT_DOWN then
				self:onNotifySitDown(v)
			elseif v.eventType==NNConstant.TABLE_EVENT_STAND_UP then
				if self.isBank==false then
					self:onNotifyStandUp(v)
				end				
			elseif v.eventType==NNConstant.TABLE_EVENT_KICK_OFF then
				self:onNotifyKickOff(v)
			end			 
		end
    end)
    
end
--更新多语言资源图
function NNHead:updateMultiRes()
    self.resourceNode_:getChildByName("headBg"):getChildByName("Button_seat"):loadTextures(NNUtils:getMutiRes("nnimg/btn8.png"), NNUtils:getMutiRes("nnimg/btn8.png"), "")    
end
function NNHead:updateEveryShotTime(dt)
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
	NNUtils:xpcall(f)
end
function NNHead:onNotifySitDown( data )
	if data.seatId==self.seatId then
		self:clear()--避免一个位置出现坐多个人，服务器不出bug可以不用调用
		self:setUserId(data.userInfo.userId)
		self:updateCoins(data.userInfo.coins)
		self:updateHead(data.userInfo.avatar,data.userInfo.userId)
	end
end
function NNHead:onNotifyStandUp( data )
	if data.userId==self.userId_ then
		self:clear()
	end
end
function NNHead:onNotifyKickOff( data )
	if data.kickedUserId==self.userId_ then
		self:clear()		
	end
end

function NNHead:setSeatId(seatId)
	self.seatId = seatId
end
function NNHead:setUserId(userId)
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
	NNUtils:Log("设置用户ID 座位号="..tostring(seatIdTemp).." ,用户ID="..tostring(userIdTemp))
end
function NNHead:setBank(status)
	self.isBank = status
	self.Text_coin:setTextColor(cc.c4b(245, 255, 17, 255))
end
function NNHead:seatEvent(view)	
	if self.seatId~=nil and self.userId_==nil then
		
	end	
end
function NNHead:getUserId()
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
	NNUtils:Log("获取用户ID 座位号="..tostring(seatIdTemp).." ,用户ID="..tostring(userIdTemp))

	return self.userId_
end

function NNHead:clear()
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
	self.userId_ = nil
	self.BitmapFontLabel_1:stopAllActions()
	self.BitmapFontLabel_1:setVisible(false)
end
function NNHead:updateCoins(coins,coinsChg)
	local coinString = ""
	if coins > 100000000 then--1亿
		if NNGameData.language==NNConstant.LANGUAGE_EN then
            coinString = string.format("%.0f", coins/1000.0)..NNLanguage.a[13][NNGameData.language]
        elseif NNGameData.language==NNConstant.LANGUAGE_ZH_HANT then
            coinString = string.format("%.0f", coins/10000.0)..NNLanguage.a[13][NNGameData.language]
        elseif NNGameData.language==NNConstant.LANGUAGE_ZH_SIMPLE then
            coinString = string.format("%.0f", coins/10000.0)..NNLanguage.a[13][NNGameData.language]
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
			BitmapFontLabel_1:setFntFile("nnimg/numberGreen.fnt")
		else
			BitmapFontLabel_1:setFntFile("nnimg/numberRed.fnt")
		end	
		BitmapFontLabel_1:setString(pm..tostring(coinsChg))--NNUtils:formtNumber(coinsChg)
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
function NNHead:updateHead( url ,userId)
	NNUtils:downloadImage(url, function( data )
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
			if NNGameData.sex=="male" then
				headNode = cc.Sprite:create("nnimg/headMale.png")
			else
				headNode = cc.Sprite:create("nnimg/headFamale.png")
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
return NNHead
