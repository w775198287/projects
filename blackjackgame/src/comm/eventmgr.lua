---
-- @module EventManager
-- 事件管理器
module(...,package.seeall)

--处理时长
local LOCAL_DISPOSE_TIME_LENGTH = 300

function Create()
    local selfObj ={}
    setmetatable( selfObj, { __index = _M } )
    --下一帧执行事件列表
	selfObj.miNextEventList={}
    selfObj.miTypeListenerIds = {} 
    selfObj.miListeners = {}
    selfObj.miIndext = 0
	return selfObj
end

---
-- 添加监听
-- @function [parent=#EventManager] listen
-- @param self
-- @param #string eventType 监听的事件类型
-- @param #function handler 触发事件时执行的方法（-1表示中断）
-- @param #number priority 事件优先级（有效值1-6），默认为5，越小优先级越高(12错误信息,3、为检测功能开启 4pve剧情处理，5普通弹框)
-- @param #table obj 监听事件的对象
-- @param #bool once 是否只监听一次，默认false
-- @return #string 监听id6
function AddListen(selfObj, aiEventType, aiHandler, aiPriority, aiObj, aiOnce)
    selfObj.miIndext = selfObj.miIndext + 1
    local tPriority = aiPriority or 5
    selfObj.miTypeListenerIds[aiEventType] = selfObj.miTypeListenerIds[aiEventType] or {}
    selfObj.miTypeListenerIds[aiEventType][tPriority] = selfObj.miTypeListenerIds[aiEventType][tPriority] or {}
    selfObj.miTypeListenerIds[aiEventType][tPriority][selfObj.miIndext] = selfObj.miIndext
    selfObj.miListeners[selfObj.miIndext] = {
        miEventType = aiEventType,
        miHandler = aiHandler,
        miPriority = aiPriority,
        miObj = aiObj,
        miOnce = aiOnce
    }
    return selfObj.miIndext
end


---
-- 移除监听
-- @function [parent=#EventManager] unListen
-- @param self
-- @param #string id 监听id
function RemoveListen(selfObj, id)
    if selfObj.miListeners[id] then
        local tEventType = selfObj.miListeners[id].miEventType
        local tPriority = selfObj.miListeners[id].miPriority
        selfObj.miTypeListenerIds[tEventType][tPriority][id] = nil
        selfObj.miListeners[id] = nil	
    end
end

---
-- 移除监听
-- @function [parent=#EventManager] unListen
-- @param self
-- @param obj 监听selfobj
function RemoveListenFromObj(selfObj, aiObj)
    for key, value in pairs(selfObj.miListeners) do
        local tObj = value.miObj
        if aiObj == tObj then
            local tEventType = value.miEventType
            local tPriority = value.miPriority
            selfObj.miTypeListenerIds[tEventType][tPriority][key] = nil
            selfObj.miListeners[key] = nil
        end
    end
end

---
-- 触发事件
-- @function [parent=#EventManager] dispatch
-- @param self
-- @param #event event
function Dispatch(selfObj, aiEvent)
    local tIds = selfObj.miTypeListenerIds[aiEvent.type] or {}
    local tRet = nil
    for i = 1, 6 do
        if tIds[i] then
            for idx, value in pairs(tIds[i]) do
                local tListener = selfObj.miListeners[idx]
                tRet = tListener.miHandler(tListener.miObj, aiEvent)
            	if tListener.miOnce then  
                    selfObj:RemoveListen(idx) 
                end
        	end
    	end
        if tRet == -1 then break end
	end
end

---
-- 多个事件类型一起触发事件
-- @function [parent=#EventManager] dispatch
-- @param self
-- @param #event event
function DispatchMultiple(selfObj, aiEvent)
    for key, value in pairs(aiEvent.typelist) do
        aiEvent.type = value
        selfObj:Dispatch(aiEvent)
    end
end

function NextDispatch(selfObj, aiEvent)
    table.insert(selfObj.miNextEventList, aiEvent)
end

function Update( selfObj, aiDelTime )
    if #selfObj.miNextEventList > 0 then
        local tCurMilliTime = G_Fy:GetLocationMilliTime()
        while #selfObj.miNextEventList > 0 do
            local value = selfObj.miNextEventList[1]
            table.remove(selfObj.miNextEventList, 1)
            selfObj:Dispatch( value )
            local tEndMilliTime = G_Fy:GetLocationMilliTime()
            if tEndMilliTime-tCurMilliTime > LOCAL_DISPOSE_TIME_LENGTH then
                break
            end            
        end
    end
end
