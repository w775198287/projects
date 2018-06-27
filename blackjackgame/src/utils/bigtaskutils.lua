---
-- 大任务分帧处理工具
-- @module BigTaskUtils
local BigTaskUtils = {
    _tasks = {}
}
local MAX_RUN_TIME_PER_FRAME = 0.1

---
-- 初始化
-- @function [parent=#BigTaskUtils] loop
-- @param self
function BigTaskUtils:loop()
    local startTime = os.time()
    for pos,task in pairs(self._tasks) do
    	local stop = task.func(task.param)
    	if stop then
    	   table.remove(self._tasks,pos)
    	end
    	if os.time() - startTime > MAX_RUN_TIME_PER_FRAME then
    	   break
    	end
    end
end

---
-- 添加任务
-- @function [parent=#BigTaskUtils] addTask
-- @param self
-- @param #function loop 返回true来结束任务
-- @param #table param 循环参数
function BigTaskUtils:addTask(loop, param)
    local task = {}
    task.func = loop
    task.param = param
    table.insert(self._tasks, task) 
end

return BigTaskUtils
