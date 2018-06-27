--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

---
-- @module EventManager
-- 事件管理器
module(...,package.seeall)

local Local_GIsCreate = false
local Local_TimeMgrObj = {}


function Instance()
	if Local_GIsCreate == true then
		return Local_TimeMgrObj
	end
	setmetatable(Local_TimeMgrObj, {__index = _M})
	Local_GIsCreate = true
    --下一帧执行事件列表
    Local_TimeMgrObj.miListeners = {}

	return Local_TimeMgrObj
end

---
-- 添加监听
--aiTimeLegin 时长(毫秒)
--aiOnce 是否一次
--回调函数
function AddListen(selfObj, aiTimeLegin, aiOnce, aiCallFun, aiCallObj)
    local tData={}
    tData.miBeginTime = G_Fy.GetLocationMilliTime()
    tData.miTimeLegin = aiTimeLegin
    tData.miEndTime = tData.miBeginTime + tData.miTimeLegin
    tData.miOnce = aiOnce
    tData.miCallFun = aiCallFun
    tData.miCallObj = aiCallObj
    table.insert(selfObj.miListeners, tData)
end

--以后加全局id
function RemoveListen(selfObj, id)
    if selfObj.miListeners[id] then
        selfObj.miListeners[id] = nil	
    end
end

-----
---- 触发事件
---- @function [parent=#EventManager] dispatch
---- @param self
---- @param #event event
--function Dispatch(selfObj, aiData, aiCurTime)
--    if aiCurTime >= tData.miEndTime then
--        if then
--        end
--    end
--end


function Update( selfObj, aiDelTime )
    if #selfObj.miListeners > 0 then
        local tRemoveTable = {}
        local tCurTime = G_Fy.GetLocationMilliTime()
        for idx = 1, #selfObj.miListeners do
            local tData = selfObj.miListeners[idx]
            if tCurTime >= tData.miEndTime then
                if tData.miOnce == true then
                    table.insert(tRemoveTable, idx)
                else
                    tData.miBeginTime = tCurTime
                    tData.miEndTime = tData.miBeginTime + tData.miTimeLegin
                end
                tData.miCallFun( tData.miCallObj )
            end
        end
        for key, value in pairs(tRemoveTable) do
            table.remove(selfObj.miListeners, value)
        end
    end
end


--endregion
