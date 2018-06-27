local NNNet = class("NNNet")
local NNMsgId = import("..nn.NNMsgId")
local NNEvent = import("..nn.NNEvent")
local NNGameData = import("..nn.NNGameData")
local NNUtils = import("..nn.NNUtils")
local reconnectTimes = 0
function NNNet:create()
  self.so_ = cc.WebSocket:create(NNGameData.server)
  local function onOpen(strData)
      NNUtils:Log("socket onOpen.")
      NNEvent:dispatchEvent({name=NNMsgId.WEBSOCKET_ONOPEN,userData="webSocketOnOpen"})
      reconnectTimes = 0
  end

  local function onMessage(msgStr)
      local function f(  )
        NNUtils:Log("收到消息："..msgStr)
        local msg = json.decode(msgStr)
        NNEvent:dispatchEvent({name=msg.id,userData=msg.body})
      end
      NNUtils:xpcall(f)
  end

  local function onClose(strData)
      NNUtils:Log("socket closed.")
      self.so_  = nil
      reconnectTimes = reconnectTimes+1 
      NNEvent:dispatchEvent({name=NNMsgId.WEBSOCKET_ONCLOSE,userData={reconnectTimes=reconnectTimes} })
  end

  local function onError(strData)
      NNUtils:Log("socket onError.")
  end

  if nil ~= self.so_  then
      self.so_ :registerScriptHandler(onOpen,cc.WEBSOCKET_OPEN)
      self.so_ :registerScriptHandler(onMessage,cc.WEBSOCKET_MESSAGE)
      self.so_ :registerScriptHandler(onClose,cc.WEBSOCKET_CLOSE)
      self.so_ :registerScriptHandler(onError,cc.WEBSOCKET_ERROR)
  end
end
function NNNet:close()
  NNUtils:Log("关闭websocket")
  if self.so_ then
    self.so_:close()
  end  
end
function NNNet:reconnect()
  NNUtils:Log("重新连接websocket")
  if self.so_ then
    self.so_:close()
  else
    self:create()
  end
end
function NNNet:send_(msgId,msgBody )
  if self.so_ then
    local data = {id=msgId,body=msgBody}
    local msgStr = json.encode(data)
    NNUtils:Log("发送消息："..msgStr)
    self.so_:sendString(msgStr)
  end  
end

-------------http短链接-------------------
--德扑圈账号登录
function NNNet:httpDpqLogin()
  local xhr = cc.XMLHttpRequest:new() --创建一个请求  
  xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING --设置返回数据格式为字符串  
  local req = NNGameData.httpServer.."/v1/user/loginByDPQ" --请求地址  
  xhr:open("POST", req) --设置请求方式  GET     或者  POST  
  local function onReadyStateChange()  --请求响应函数  
      if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then --请求状态已完并且请求已成功  
            local statusString = "Http Status Code:"..xhr.statusText  
            NNUtils:Log("请求返回状态码"..statusString)  
            local s = xhr.response --获得返回的内容  
            NNUtils:Log("返回的数据"..s)
            local msg = json.decode(s)
            NNEvent:dispatchEvent({name=NNMsgId.HTTP_DPQ_LOGIN,userData=msg })   
      end  
  end  
  xhr:registerScriptHandler(onReadyStateChange) --注册请求响应函数  
  xhr.timeout = 3
  local msgBody = {userId=NNGameData.userInfo.userId, token=NNGameData.dpqToken,model=NNGameData.model, version=NNGameData.version, channel=NNGameData.channel, platform=NNGameData.platform}
  local msgStr = json.encode(msgBody)
  NNUtils:Log("http德扑圈账号请求登录发送消息："..msgStr)
  xhr:send(msgStr) --—最后发送请求 
end
--游客账号登录
function NNNet:httpGuestLogin()
  local xhr = cc.XMLHttpRequest:new() --创建一个请求  
  xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING --设置返回数据格式为字符串  
  local req = NNGameData.httpServer.."/v1/user/loginByGuest" --请求地址  
  xhr:open("POST", req) --设置请求方式  GET     或者  POST  
  local function onReadyStateChange()  --请求响应函数  
      if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then --请求状态已完并且请求已成功  
            local statusString = "Http Status Code:"..xhr.statusText  
            NNUtils:Log("请求返回状态码"..statusString)  
            local s = xhr.response --获得返回的内容  
            NNUtils:Log("返回的数据"..s)
            local msg = json.decode(s)
            NNEvent:dispatchEvent({name=NNMsgId.HTTP_DPQ_LOGIN,userData=msg })   
      end  
  end  
  xhr:registerScriptHandler(onReadyStateChange) --注册请求响应函数  
  xhr.timeout = 3
  local msgBody = {imei= NNGameData.imei,model=NNGameData.model,version=NNGameData.version,channel=NNGameData.channel,platform=NNGameData.platform}
  local msgStr = json.encode(msgBody)
  NNUtils:Log("http游客请求登录发送消息："..msgStr)
  xhr:send(msgStr) --—最后发送请求 
end


--配桌
function NNNet:joinRoom(roomId) 
  local msgBody = {roomId=101}--服务器有且仅有一个roomID 写死了
  self:send_(NNMsgId.ID_REQ+NNMsgId.MSGID_QUICK_START,msgBody)
end
--加入桌子
function NNNet:joinTable(tableId) 
  local msgBody = {tableId=tableId,avatar=NNGameData.avatar,coins=NNGameData.userInfo.coins}
  self:send_(NNMsgId.ID_REQ+NNMsgId.MSGID_JOIN_TABLE,msgBody)
end
--坐下
function NNNet:sitDown(seatId) 
  local msgBody = {seatId=seatId}
  self:send_(NNMsgId.ID_REQ+NNMsgId.MSGID_SIT_DOWN,msgBody)
end
--站起
function NNNet:standUp(seatId) 
  local msgBody = {}
  self:send_(NNMsgId.ID_REQ+NNMsgId.MSGID_STAND_UP,msgBody)
end
--准备
function NNNet:ready() 
  local msgBody = {}
  self:send_(NNMsgId.ID_REQ+NNMsgId.MSGID_READY,msgBody)
end
--离开
function NNNet:leave() 
  local msgBody = {}
  self:send_(NNMsgId.ID_REQ+NNMsgId.MSGID_LEAVE_TABLE,msgBody)
end
--下注
function NNNet:bet(chipList)
  local msgBody = {chipList=chipList}
  self:send_(NNMsgId.ID_REQ+NNMsgId.MSGID_BAI_XIAZHU,msgBody)
end
--趋势
function NNNet:trent()
  local msgBody = {}
  self:send_(NNMsgId.ID_REQ+NNMsgId.MSGID_BAI_WIN_HISTORY,msgBody)    
end
--上庄
function NNNet:applyBank()
  local msgBody = {}
  self:send_(NNMsgId.ID_REQ+NNMsgId.MSGID_BAI_APPLY_BANKER,msgBody)    
end
--下庄
function NNNet:quitBank()
  local msgBody = {}
  self:send_(NNMsgId.ID_REQ+NNMsgId.MSGID_BAI_QUIT_BANKER,msgBody)    
end
--等待上庄列表
function NNNet:waitBankList()
  local msgBody = {}
  self:send_(NNMsgId.ID_REQ+NNMsgId.MSGID_BAI_WAIT_BANKER_LIST,msgBody)    
end
--长连接登录
function NNNet:loginHall()
  local msgBody = {userId=NNGameData.userInfo.userId, token=NNGameData.httpLoginToken}
  self:send_(NNMsgId.ID_REQ+NNMsgId.MSGID_LOGIN_HALL,msgBody)    
end
return NNNet
