local NNViewBase = import("..nn.NNViewBase")
local NNUtils = import("..nn.NNUtils")
local NNNet = import("..nn.NNNet")
local NNEvent = import("..nn.NNEvent")
local NNMsgId = import("..nn.NNMsgId")
local NNGameData = import("..nn.NNGameData")
local NNLanguage = import("..nn.NNLanguage")
local NNConstant = import("..nn.NNConstant")
local NNBoss = class("NNBoss", NNViewBase)
local scheduler = cc.Director:getInstance():getScheduler()
function NNBoss:onCreate()
	self.winSize_ = cc.Director:getInstance():getWinSize()
	self.itemSpan = 3
    self:setName("NNBoss")
	local nnBoss = cc.CSLoader:createNode("nnBoss.csb")
	nnBoss:setPosition(cc.p(self.winSize_.width/2,self.winSize_.height/2))
    assert(nnBoss, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", nnBoss))
    self.nnBoss_ = nnBoss;
    self:addChild(nnBoss)
    --按钮事件
	NNUtils:setOnViewClickedListener("Button_reqBoss",function(view)
		self:reqBossEvent(view)
	end,nnBoss)
	NNUtils:setOnViewClickedListener("Button_close",function(view)
		self:closeEvent(view)
	end,nnBoss)
    NNUtils:setOnViewClickedListener("Panel_1",function(view)
        self:closeEvent(view)
    end,nnBoss)

    self.ScrollView_1 = nnBoss:getChildByName("bg_0"):getChildByName("ScrollView_1")
    self.Image_item = self.ScrollView_1:getChildByName("Image_item")

    self.localBankerList = {}
    self:onNodeEvent("enter")
    self:onNodeEvent("exit")
    self:updateMultiRes()
end
--更新多语言资源图
function NNBoss:updateMultiRes()
    self.nnBoss_:getChildByName("titleBg"):getChildByName("title"):loadTexture(NNUtils:getMutiRes("nnimg/p0_title3.png"))
    self:updateReqBtnStatus()
    local coinString = ""
    if NNGameData.roomInfo.applyBankerCoins>10000 then
        if NNGameData.language==NNConstant.LANGUAGE_EN then
            coinString = string.format("%.0f", NNGameData.roomInfo.applyBankerCoins/1000.0)..NNLanguage.a[13][NNGameData.language]
        elseif NNGameData.language==NNConstant.LANGUAGE_ZH_HANT then
            coinString = string.format("%.0f", NNGameData.roomInfo.applyBankerCoins/10000.0)..NNLanguage.a[13][NNGameData.language]
        elseif NNGameData.language==NNConstant.LANGUAGE_ZH_SIMPLE then
            coinString = string.format("%.0f", NNGameData.roomInfo.applyBankerCoins/10000.0)..NNLanguage.a[13][NNGameData.language]
        end
    else
        coinString = tostring(NNGameData.roomInfo.applyBankerCoins)
    end
    
    local Text_2 = self.nnBoss_:getChildByName("Panel_2"):getChildByName("Text_2")
    local Text_3 = self.nnBoss_:getChildByName("Panel_2"):getChildByName("Text_3")
    local Text_4 = self.nnBoss_:getChildByName("Panel_2"):getChildByName("Text_4")
    Text_2:setString( NNLanguage.a[4][NNGameData.language] )
    Text_3:setString(coinString )
    Text_4:setString( NNLanguage.a[5][NNGameData.language] )
    local width_2 = Text_2:getContentSize().width
    local width_3 = Text_3:getContentSize().width
    local width_4 = Text_4:getContentSize().width
    local span = 5
    local totalWidth = width_2+width_3+width_4+2*span
    Text_2:setPositionX(-totalWidth/2.0)
    Text_3:setPositionX(-totalWidth/2.0 + width_2 + span)
    Text_4:setPositionX(-totalWidth/2.0 + width_2 + width_3 + span*2)

end
function NNBoss:updateView(waitBankerList)
    local bossNum = table.nums(waitBankerList)
     if 0==bossNum then
        self.ScrollView_1:setVisible(false)
    else
        self.ScrollView_1:setVisible(true)
    end

    local isChange = false--申请boss队列是否有改变
    if table.nums(waitBankerList)~=table.nums(self.localBankerList) then
        isChange = true
    end
    for k,v in pairs(waitBankerList) do
        if not self.localBankerList[k] or self.localBankerList[k]~=v.userId then
            isChange = true
            break
        end
    end
    if false==isChange then
        return
    end
    self.localBankerList = {}

    local cloneItemNodeName = "cloneItemNodeName"
    self:removeNodeByName(self.ScrollView_1,cloneItemNodeName)
    local innerWidth = self.ScrollView_1:getContentSize().width
    local innerHeight = bossNum*(self.itemSpan+self.Image_item:getContentSize().height) - self.itemSpan    
    self.ScrollView_1:setInnerContainerSize(cc.size(innerWidth, innerHeight))
    innerHeight = self.ScrollView_1:getInnerContainerSize().height

    for i=0,(bossNum-1) do
        local item = nil
        if 0==i then
            item = self.Image_item
            item:getChildByName("Panel_head"):removeAllChildren()
        else
            item = self.Image_item:clone()
            item:setName(cloneItemNodeName)
            self.ScrollView_1:addChild(item)
        end
        local posY = innerHeight - i*(self.itemSpan+item:getContentSize().height) - item:getContentSize().height/2
        item:setPositionY(posY)
        self:setItemView(item,waitBankerList[i+1])--lua下标从1开始 
    end
    self:updateReqBtnStatus()
end
function NNBoss:updateReqBtnStatus()
    local Button_reqBoss = self.nnBoss_:getChildByName("Button_reqBoss")
    if self:getIsReqBoss() then
        Button_reqBoss:loadTextures(NNUtils:getMutiRes("nnimg/btn6_quit.png"), NNUtils:getMutiRes("nnimg/btn6_quit.png"), "")
    else
        Button_reqBoss:loadTextures(NNUtils:getMutiRes("nnimg/btn6.png"), NNUtils:getMutiRes("nnimg/btn6.png"), "")
    end
end
function NNBoss:getIsReqBoss()
    local isReqBoss = false--是否申请了申请boss
    for k,v in pairs(self.localBankerList) do
        if v==NNGameData.userInfo.userId then
            isReqBoss = true
            break
        end
    end
    return isReqBoss
end
function NNBoss:onEnter( )
    self._,self.handle1 = NNEvent:on(NNMsgId.MSGID_BAI_APPLY_BANKER+NNMsgId.ID_ACK,function(event)--申请上庄返回
        self:onApplayBank(event.userData)
    end)
    self._,self.handle2 = NNEvent:on(NNMsgId.MSGID_BAI_WAIT_BANKER_LIST+NNMsgId.ID_ACK,function(event)--上庄列表返回
        self:onWaitBankList(event.userData)
    end)
    self._,self.handle3 = NNEvent:on(NNMsgId.MSGID_BAI_QUIT_BANKER+NNMsgId.ID_ACK,function(event)--取消申请上庄返回
        self:onQuitBankList(event.userData)
    end)
    self._,self.handle4 = NNEvent:on(NNMsgId.MSGID_BAI_CHANGE_BANKER+NNMsgId.ID_NTF,function(event)--换庄通知
        self:onNotifyChangeBank(event.userData)
    end)
    -- self.updateEverySecond_ = scheduler:scheduleScriptFunc(function( dt )
    --     self:updateEverySecond()
    -- end, 1, false)
end
function NNBoss:onExit()
    if self.updateEverySecond_ then
        scheduler:unscheduleScriptEntry(self.updateEverySecond_)
    end
    NNEvent:removeEventListener(self.handle1)
    NNEvent:removeEventListener(self.handle2)
    NNEvent:removeEventListener(self.handle3)
    NNEvent:removeEventListener(self.handle4)
    if self.texture2dTabel then
        for k,v in pairs(self.texture2dTabel) do
            cc.Director:getInstance():getTextureCache():removeTexture(v)
        end
    end
end

function NNBoss:setItemView(item,userInfo)
    local clipperNodeName = "clipperNode"
	local name = NNUtils:findNodeByName("name", item)
	name:setString(tostring(userInfo.userId))
    local coin = NNUtils:findNodeByName("coin", item)
    coin:setString(tostring(userInfo.coins))
    local Panel_head = NNUtils:findNodeByName("Panel_head", item)
    table.insert(self.localBankerList, userInfo.userId)
    item.isExitFlag = true
    item.avatar = userInfo.avatar
    NNUtils:downloadImage(userInfo.avatar, function( data )
        if not self or not self.nnBoss_ or not item or not item.isExitFlag then
            return
        end

        Panel_head:removeAllChildren()
        local headNode = nil
        if data.done==true then
            -- 2.头像
            self.texture2dTabel = self.texture2dTabel or {}
            table.insert(self.texture2dTabel, data.texture2d)
            headNode = cc.Sprite:createWithTexture(data.texture2d)
        else
            headNode = cc.Sprite:create("nnimg/headMale.png")
        end 
        local headWidth = headNode:getContentSize().width
        local headHeight = headNode:getContentSize().height
        local headMaxSide = ( (headWidth>headHeight and headWidth) or headHeight)
        local ratio = Panel_head:getContentSize().width/headMaxSide
        headNode:setScale(ratio)
        headNode:setPosition(Panel_head:getContentSize().width/2, Panel_head:getContentSize().height/2)
        Panel_head:addChild(headNode)
    end)

end

function NNBoss:reqBossEvent(view)
	NNUtils:Log("reqBossEvent")
    if self:getIsReqBoss() then
        NNNet:quitBank()
    else
        NNNet:applyBank()
    end
end
function NNBoss:onApplayBank( userData )
    if userData.result==1 then
        NNUtils:showToast( NNLanguage.a[1][NNGameData.language] )
    elseif userData.result==0 then
        self:updateView(userData.waitBankerList)
    end
end
function NNBoss:onWaitBankList( userData )
    if userData.result ~= 0 then
        NNUtils:Log("NNBoss:onWaitBankList获取上庄列表失败")
        return
    end
    self:updateView(userData.waitBankerList)
end
function NNBoss:onQuitBankList( userData )
    self:updateView(userData.waitBankerList)
end
function NNBoss:onNotifyChangeBank( userData )
    NNNet:waitBankList()--刷新上庄列表
end
function NNBoss:updateEverySecond(dt)
    NNNet:waitBankList()
end
function NNBoss:removeNodeByName(node, name)
    local targetNode = NNUtils:findNodeByName(name, node)
    if targetNode then
        targetNode:removeFromParent()
        self:removeNodeByName(node,name)
    end
end
function NNBoss:closeEvent(view)
	NNUtils:Log("closeEvent")
	self:removeFromParent()
end

return NNBoss
