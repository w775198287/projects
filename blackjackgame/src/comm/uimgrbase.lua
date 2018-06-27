--------------------------------------------------------
--info:UIManger 窗口管理类
--author:Daneil
--date:2015-6-10
--------------------------------------------------------
module(...,package.seeall)

local Local_CacheCleanTime = 1 --秒

function Create(aiData)
    local selfObj ={}
    setmetatable( selfObj, { __index = _M } )

    --创建UI实例对象列表
    selfObj.miUiList = {}
    --注册UI对象
    selfObj.miUiRegList = {}
    --移除了只是隐藏，需要等待时间到了才能真正的删除（缓冲UI数据）
    selfObj.miCacheUiObjList = {}

    --绑定桌数据对象
    selfObj.miGameDesk = aiData.miGameDesk
    selfObj.miEventMgr = selfObj.miGameDesk:GetEventMgr()
    selfObj.miUiMgr = selfObj.miGameDesk:GetUiMgr()
    selfObj.miGameRoom = selfObj.miGameDesk:GetGameRoom()

    return selfObj
end

--用于注册更新前UI
function RegisteredUi(selfObj)
 
end

--用于注册更新后UI
function RegisteredUiEx(selfObj)
 
end

--创建UI这样的UI只能存在一份
function CreateUi(selfObj, aiName, aiData)
    local IsCreate = true
    aiData.miGameDesk = selfObj.miGameDesk
	if selfObj.miUiList[aiName] == nil then 
        if selfObj.miCacheUiObjList[aiName] ~= nil then
            selfObj.miUiList[aiName] = selfObj.miCacheUiObjList[aiName]
            selfObj.miUiList[aiName]:OnOpen(aiData)
            selfObj.miCacheUiObjList[aiName] = nil
            My_Lua_log("file=[uimgrbase] fun=[createui]; name=[" .. aiName.."] opened")
        else
            if selfObj.miUiRegList[aiName] == nil then
                My_Lua_log("file=[uimgrbase] fun=[createui]; name=[" .. aiName.."] error ui no registered")
                return nil
            end
       		tUi = selfObj.miUiRegList[aiName](aiData)

            -----------------------------------------------------------------------
            local designSize =cc.Director:getInstance():getOpenGLView():getVisibleSize()
            local theightOff = 0.5 * designSize.height
            tUi:GetRootNode():setPositionY(theightOff)
            -----------------------------------------------------------------------
            --如果是iphoneX 重置桌面所有位置
            local tIsIphoneX = G_Fy.GamegLobal:GetIsIphoneXPlatform()
            if tIsIphoneX == true then
                tUi:AdaptResolution()
            end
            
		    tUi:OnOpen(aiData)
            selfObj.miUiList[aiName] = tUi
            My_Lua_log("file=[uimgrbase] fun=[createui]; name=[" .. aiName .."] initialize")
        end
    else
        IsCreate = false
        selfObj.miUiList[aiName]:OnOpen(aiData)
    end	
    return IsCreate, selfObj.miUiList[aiName]
end

--获得UI
function GetUiObj(selfObj, aiName)
    local tUi = selfObj.miUiList[aiName]
    return tUi
end

--移除UI
function RemoveUi(selfObj, aiName)
    local tUi = selfObj.miUiList[aiName]
	if tUi ~= nil then 
        tUi:OnClose()
        if tUi:IsCacheUi() == false then
            tUi:OnExit()
            My_Lua_log("file=[uimgrbase] fun=[OnExit]; name=" .. aiName)
        else
           selfObj.miCacheUiObjList[aiName] = tUi
        end
        selfObj.miUiList[aiName] = nil
        My_Lua_log("file=[uimgrbase] fun=[removeui]; name=" .. aiName)
	end	
end

--移除所有UI
function RemoveAllUi(selfObj)
    My_Lua_log("file=[uimgrbase] fun=[removeallui];")
	for k,v in pairs(selfObj.miUiList) do
		if v.OnClose then 
			v:OnClose()
            selfObj.miCacheUiObjList[k] = v
		end
	end
    selfObj.miUiList = {}
end

--移除所有UI
function ExitAllUi(selfObj)
    My_Lua_log("file=[uimgrbase] fun=[exitallui];")
	for k,v in pairs(selfObj.miUiList) do
		if v.OnClose then 
			v:OnClose()
            selfObj.miCacheUiObjList[k] = v
		end
	end
    selfObj.miUiList = {}

    for k,v in pairs(selfObj.miCacheUiObjList) do
        v:OnExit()
    end
    selfObj.miCacheUiObjList = {}
end

--移除缓存UI
function RemoveAllCacheUiList(selfObj)
    My_Lua_log("file=[uimgrbase] fun=[removeallcacheuilist];")
	for k,v in pairs(selfObj.miCacheUiObjList) do
		if v.OnExit then 
			v:OnExit()
		end
	end
    selfObj.miCacheUiObjList = {}
end

--更新UI
function Update(selfObj, aiDelTime)
    --清理缓存
    for k,v in pairs(selfObj.miCacheUiObjList) do
        if v:GetExistTime() > Local_CacheCleanTime then
            v:OnExit()
            selfObj.miCacheUiObjList[v:GetPagName()] = nil
            My_Lua_log(" file=[uimgrbase] fun=[update]; remove name=["..v:GetPagName().."] from cache")
        end
    end
    --刷新UI（如果效率需要修改，可以把这改成需要updat的UI做事件监听）
	for k,v in pairs(selfObj.miUiList) do
		if v.OnUpdate then 
			v:OnUpdate(aiDelTime)
		end
	end
end







