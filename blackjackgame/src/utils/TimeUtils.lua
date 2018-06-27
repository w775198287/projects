--region TimerUtils.lua
--Author : zsy
--Date   : 2015/8/27
--此文件由[BabeLua]插件自动生成

local TimerUtils = {
    timeOutSpans = {},
    timeOutCallBacks = {}
}

---
-- 超时执行
-- @function [parent=#TimerUtils] setTimeOut
-- @param self
-- @param #number timeSpan 延迟时间，单位秒，可以使用小数
-- @param #function callBack
function TimerUtils:setTimeOut(timeSpan, callBack)
    local key = os.time() + timeSpan
    if TimerUtils.timeOutCallBacks[key] then
        local oldCallBack = TimerUtils.timeOutCallBacks[key]
        TimerUtils.timeOutCallBacks[key] = function()
        	oldCallBack()
        	callBack()
        end
    else
        TimerUtils.timeOutCallBacks[key] = callBack
        table.insert(TimerUtils.timeOutSpans, key)
        table.sort(TimerUtils.timeOutSpans)
    end
end

---
-- 更新
-- @function [parent=#TimerUtils] update
function TimerUtils:update()
    local now = os.time()
    while TimerUtils.timeOutSpans[1] and TimerUtils.timeOutSpans[1] < now do
        local call = TimerUtils.timeOutCallBacks[TimerUtils.timeOutSpans[1]]
        TimerUtils.timeOutCallBacks[TimerUtils.timeOutSpans[1]] = nil
        table.remove(TimerUtils.timeOutSpans, 1)
        if call then call() end
    end
end

return TimerUtils

--endregion
