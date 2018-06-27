local TTNet = class("TTNet")
local TTMsgId = import("..tt.TTMsgId")
local TTEvent = import("..tt.TTEvent")
local TTGameData = import("..tt.TTGameData")
local TTUtils = import("..tt.TTUtils")
local reconnectTimes = 0
function TTNet:create()
  self.so_ = cc.WebSocket:create(TTGameData.server)
  local function onOpen(strData)
      TTUtils:Log("socket onOpen.")
      TTEvent:dispatchEvent({name=TTMsgId.WEBSOCKET_ONOPEN,userData="webSocketOnOpen"})
      reconnectTimes = 0
  end

  local function onMessage(msgStr)
      local function f(  )
        TTUtils:Log("收到消息："..msgStr)
        local msg = json.decode(msgStr)
        TTEvent:dispatchEvent({name=msg.id,userData=msg.body})
      end
      TTUtils:xpcall(f)
  end

  local function onClose(strData)
      TTUtils:Log("socket closed.")
      self.so_  = nil
      reconnectTimes = reconnectTimes+1 
      TTEvent:dispatchEvent({name=TTMsgId.WEBSOCKET_ONCLOSE,userData={reconnectTimes=reconnectTimes} })
  end

  local function onError(strData)
      TTUtils:Log("socket onError.")
  end

  if nil ~= self.so_  then
      self.so_ :registerScriptHandler(onOpen,cc.WEBSOCKET_OPEN)
      self.so_ :registerScriptHandler(onMessage,cc.WEBSOCKET_MESSAGE)
      self.so_ :registerScriptHandler(onClose,cc.WEBSOCKET_CLOSE)
      self.so_ :registerScriptHandler(onError,cc.WEBSOCKET_ERROR)
  end
end
function TTNet:close()
  TTUtils:Log("关闭websocket")
  if self.so_ then
    self.so_:close()
  end  
end
function TTNet:reconnect()
  TTUtils:Log("重新连接websocket")
  if self.so_ then
    self.so_:close()
  else
    self:create()
  end
end
function TTNet:send_(msgId,msgBody )
  if self.so_ then
    local data = {id=msgId,body=msgBody}
    local msgStr = json.encode(data)
    TTUtils:Log("发送消息："..msgStr)
    self.so_:sendString(msgStr)
  end
end

-------------http短链接-------------------
--德扑圈账号登录
function TTNet:httpDpqLogin()
  local xhr = cc.XMLHttpRequest:new() --创建一个请求  
  xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING --设置返回数据格式为字符串  
  local req = TTGameData.httpServer.."/v1/user/loginByDPQ" --请求地址  
  xhr:open("POST", req) --设置请求方式  GET     或者  POST  
  local function onReadyStateChange()  --请求响应函数  
      if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then --请求状态已完并且请求已成功  
            local statusString = "Http Status Code:"..xhr.statusText  
            TTUtils:Log("请求返回状态码"..statusString)  
            local s = xhr.response --获得返回的内容  
            TTUtils:Log("返回的数据"..s)
            local msg = json.decode(s)
            TTEvent:dispatchEvent({name=TTMsgId.HTTP_DPQ_LOGIN,userData=msg })   
      end  
  end  
  xhr:registerScriptHandler(onReadyStateChange) --注册请求响应函数  
  xhr.timeout = 3
  local msgBody = {userId=TTGameData.userInfo.userId, token=TTGameData.dpqToken,model=TTGameData.model, version=TTGameData.version, channel=TTGameData.channel, platform=TTGameData.platform}
  local msgStr = json.encode(msgBody)
  TTUtils:Log("http德扑圈账号请求登录发送消息："..msgStr)
  xhr:send(msgStr) --—最后发送请求 
end
--游客账号登录
function TTNet:httpGuestLogin()
  local xhr = cc.XMLHttpRequest:new() --创建一个请求  
  xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING --设置返回数据格式为字符串  
  local req = TTGameData.httpServer.."/v1/user/loginByGuest" --请求地址  
  xhr:open("POST", req) --设置请求方式  GET     或者  POST  
  local function onReadyStateChange()  --请求响应函数  
      if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then --请求状态已完并且请求已成功  
            local statusString = "Http Status Code:"..xhr.statusText  
            TTUtils:Log("请求返回状态码"..statusString)  
            local s = xhr.response --获得返回的内容  
            TTUtils:Log("返回的数据"..s)
            local msg = json.decode(s)
            TTEvent:dispatchEvent({name=TTMsgId.HTTP_DPQ_LOGIN,userData=msg })   
      end  
  end  
  xhr:registerScriptHandler(onReadyStateChange) --注册请求响应函数  
  xhr.timeout = 3
  local msgBody = {imei= TTGameData.imei,model=TTGameData.model,version=TTGameData.version,channel=TTGameData.channel,platform=TTGameData.platform}
  local msgStr = json.encode(msgBody)
  TTUtils:Log("http游客请求登录发送消息："..msgStr)
  xhr:send(msgStr) --—最后发送请求 
end

--配桌
function TTNet:joinRoom(roomId) 
  local msgBody = {roomId=101}--服务器有且仅有一个roomID 写死了
  self:send_(TTMsgId.ID_REQ+TTMsgId.MSGID_QUICK_START,msgBody)
end
--加入桌子
function TTNet:joinTable(tableId) 
  local msgBody = {tableId=tableId,avatar=TTGameData.avatar,coins=TTGameData.userInfo.coins}
  self:send_(TTMsgId.ID_REQ+TTMsgId.MSGID_JOIN_TABLE,msgBody)
end
--坐下
function TTNet:sitDown(seatId) 
  local msgBody = {seatId=seatId}
  self:send_(TTMsgId.ID_REQ+TTMsgId.MSGID_SIT_DOWN,msgBody)
end
--站起
function TTNet:standUp(seatId) 
  local msgBody = {}
  self:send_(TTMsgId.ID_REQ+TTMsgId.MSGID_STAND_UP,msgBody)
end
--准备
function TTNet:ready() 
  local msgBody = {}
  self:send_(TTMsgId.ID_REQ+TTMsgId.MSGID_READY,msgBody)
end
--离开
function TTNet:leave() 
  local msgBody = {}
  self:send_(TTMsgId.ID_REQ+TTMsgId.MSGID_LEAVE_TABLE,msgBody)
end
--下注
function TTNet:bet(chipList)
  local msgBody = {chipList=chipList}
  self:send_(TTMsgId.ID_REQ+TTMsgId.MSGID_BAI_XIAZHU,msgBody)
end
--趋势
function TTNet:trent()
  local msgBody = {}
  self:send_(TTMsgId.ID_REQ+TTMsgId.MSGID_BAI_WIN_HISTORY,msgBody)    
end
--上庄
function TTNet:applyBank()
  local msgBody = {}
  self:send_(TTMsgId.ID_REQ+TTMsgId.MSGID_BAI_APPLY_BANKER,msgBody)    
end
--下庄
function TTNet:quitBank()
  local msgBody = {}
  self:send_(TTMsgId.ID_REQ+TTMsgId.MSGID_BAI_QUIT_BANKER,msgBody)    
end
--等待上庄列表
function TTNet:waitBankList()
  local msgBody = {}
  self:send_(TTMsgId.ID_REQ+TTMsgId.MSGID_BAI_WAIT_BANKER_LIST,msgBody)    
end
--长连接登录
function TTNet:loginHall()
  local msgBody = {userId=TTGameData.userInfo.userId, token=TTGameData.httpLoginToken}
  self:send_(TTMsgId.ID_REQ+TTMsgId.MSGID_LOGIN_HALL,msgBody)    
end
return TTNet
