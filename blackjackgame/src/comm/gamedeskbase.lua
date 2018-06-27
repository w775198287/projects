--region NewFile_1.lua
--Author : chgq1023
--Date   : 2016/12/29
--此文件由[BabeLua]插件自动生成

module(...,package.seeall)

function Create(aiData)
    local selfObj ={}
    setmetatable( selfObj, { __index = _M } )
    selfObj:Init(aiData)
    return selfObj
end

function Init(selfObj, aiData)
    --房间唯一ID
    selfObj.miGameRoomId = 0    

    --房间数据数据
    selfObj.miGameRoom = nil

    --UI数据
    selfObj.miEventMgr = nil

    --事件数据
    selfObj.miUiMgr = nil

    --状态机事件管理器
    selfObj.miRoomStateMgr = nil

    --主UI窗口
    selfObj.miGameDeskMain = nil

    --Android使用字段
    selfObj.miTransitionCount = 0
end

function SetGameRoomId(selfObj, aiGameRoomId)
    selfObj.miGameRoomId = aiGameRoomId
end

function GetGameRoomId(selfObj)
    return selfObj.miGameRoomId
end

function GetGameRoom(selfObj)
   return selfObj.miGameRoom
end

function GetEventMgr(selfObj)
   return selfObj.miEventMgr
end

function GetUiMgr(selfObj)
   return selfObj.miUiMgr
end

function GetRoomStateMgr(selfObj)
   return selfObj.miRoomStateMgr
end


function Update(selfObj, aiDelTime)
    local app = cc.Application:getInstance()
    local target = app:getTargetPlatform()
    if target == cc.PLATFORM_OS_ANDROID then
        if selfObj.miTransitionCount > 0 then
            selfObj.miTransitionCount = selfObj.miTransitionCount - 1
            return
        else
            selfObj.miTransitionCount = 0
        end
    end

    if selfObj.miEventMgr then
        selfObj.miEventMgr:Update(aiDelTime) 
    end
    if selfObj.miUiMgr then
        selfObj.miUiMgr:Update(aiDelTime)
    end
    if selfObj.miRoomStateMgr then
        selfObj.miRoomStateMgr:Update(aiDelTime)
    end
end

--退出操作
function OnExit(selfObj)
   local tGameRoom = selfObj:GetGameRoom()
   if tGameRoom ~= nil then
        tGameRoom:OnExit()
   end
end


--重置牌局数据
function ResetGameRoomInfo(selfObj)
    
end

-- 商城回到游戏（主要用于ios）
function ShopToGame( selfObj )
    
end
