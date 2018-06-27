module(...,package.seeall)

function Create(aiData)
    print(" file=[cardnode] fun=[Create];")

    local selfObj = {}
    setmetatable( selfObj, {__index = _M} ) 

    selfObj.miPagObj = nil
    
    selfObj.lType = 0
    selfObj.lValue = 0
    selfObj.lCardID = 0
    selfObj.isSelected = false
    selfObj.miEventMgr = nil

    if nil ~= aiData then
        if nil ~= aiData.lOwnUserId then
            selfObj.lOwnUserId = aiData.lOwnUserId
        end
        if nil ~= aiData.lUserPos then
            selfObj.lUserPos = aiData.lUserPos
        end

        if nil ~= aiData.tEventMgr then
            selfObj.miEventMgr = aiData.tEventMgr
        end
    end

    if nil ~= aiData and nil ~= aiData.lFanPaiId then
        selfObj.lFanPaiId = aiData.lFanPaiId
    end

    selfObj:Init()

    return selfObj
end

--创建初始化UI
function Init(selfObj)
    print(" file=[cardnode] fun=[init];")
    local PromptNode = require("winratecalculate.uiwinratecalculate.cardnode")
    local callBackProvider = function ( path,node,funcName )
        if node:getName()=="btn" and funcName == "OnBtnSelectCard" then
            local function OnBtnSelectCard1(  node,eventType )
                 selfObj:OnBtnSelectCard( node,eventType )
            end
            return OnBtnSelectCard1
        end
    end
    selfObj.miPagObj = PromptNode.create(callBackProvider)
    selfObj.miPagObj['root']:retain()

    selfObj.miPagObj['btn']:setSwallowTouches(false)

    local function OnCallBack(  )
        selfObj:Update()
    end
    local seq = cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(OnCallBack))
    selfObj.miPagObj['root']:runAction(cc.RepeatForever:create(seq))

    if nil ~= selfObj.miEventMgr then
        selfObj.miEventMgr:AddListen( "updataSelectState", UpdataSelectState, 5, selfObj)
    end
end

function GetRootNode(selfObj)
    return selfObj.miPagObj['root']
end

function OnBtnSelectCard(selfObj, node, eventType )
    print("OnBtnSelectCard...")
    selfObj:SetBtnSelectState(true)
end

function SetBtnSelectState( selfObj, isSelected )
    print(" file=[cardnodepag] fun=[SetBtnSelectState];")

    selfObj.isSelected = isSelected
    selfObj:SetLightVisibleFalse(isSelected)

    -- 发送广播
    if isSelected and nil ~= selfObj.miEventMgr then
        local aiEvent = {}
        aiEvent.type = "updataSelectState"
        aiEvent.miData = {}
        aiEvent.miData.lCardID = selfObj.lCardID
        selfObj.miEventMgr:Dispatch(aiEvent)
    end
end

function GetBtnSelectType( selfObj )

    return selfObj.isSelected
end

function SetLightVisibleFalse( selfObj, isVisible )
    print(" file=[cardnodepag] fun=[SetLightVisibleFalse];")

    selfObj.miPagObj['light']:setVisible(isVisible)
end

function SetCardData( selfObj, data )
    print(" file=[cardnodepag] fun=[SetCardData];")

    selfObj.lType = data.lType
    selfObj.lValue = data.lValue 

    local sFileName
    if selfObj.lValue >=1 and selfObj.lValue <= 13 then 
        local index = 13 * data.lType + data.lValue - 1
        sFileName = string.format( "game/game_layer/ingame_poker/normal/poker_%d.png", index)
    else
        sFileName = "game/game_layer/ingame_poker/normal/poker_back_1.png"
    end
    print("sFileName = "..sFileName.." value = "..selfObj.lValue)
    selfObj.miPagObj["card"]:loadTexture(sFileName)
end

function GetCardIndex( selfObj )
    return 13 * selfObj.lType + selfObj.lValue
end

function GetCardTypeAndValue( selfObj )
    local data = {
        lType = selfObj.lType,
        lValue = selfObj.lValue
    }
    return data
end

-- 撤销当前数据
function ResetCardData( selfObj )
    print(" file=[cardnodepag] fun=[ResetCardData];")

    -- selfObj:SetBtnSelectState(false)
    local data = {
        lType = 0,
        lValue = 0
    }

    selfObj:SetCardData(data)
    selfObj:SetLightVisibleFalse(false)
end

function GetOwnUserId( selfObj )
    return selfObj.lOwnUserId
end

function GetUserPos( selfObj )
    return selfObj.lUserPos
end

function SetCardId( selfObj, lId )
    selfObj.lCardID = lId
end

function GetCardId( selfObj )
    return selfObj.lCardID
end

function SetFanPaiId( selfObj, lFanPaiId )
    selfObj.lFanPaiId = lFanPaiId
end

function GetFanPaiId( selfObj )
    return selfObj.lFanPaiId
end

function UpdataSelectState( selfObj, aiEvent )
    -- print(" file=[cardnodepag] fun=[UpdataSelectState]; ")

    if nil ~= aiEvent and nil ~= aiEvent.miData and nil ~= aiEvent.miData.lCardID then
        if selfObj.lCardID ~= aiEvent.miData.lCardID then
            selfObj:SetBtnSelectState(false)
        end
    end
end

function Update( selfObj,aiDelTime )
    -- print("cardNode Update...")
    if selfObj.isSelected then
        selfObj.miPagObj['light']:setVisible(true)
    else
        selfObj.miPagObj['light']:setVisible(false)
    end
end

