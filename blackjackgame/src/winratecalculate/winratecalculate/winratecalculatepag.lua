module(...,package.seeall)

local PokerNum = 52

function GetCardIndex( lType, lValue )
    return 13 * lType + lValue
end


function Create(aiData)
    local selfObj = {}
    setmetatable( selfObj, {__index = _M} ) 
    print(" file=[winratecalculatepag] fun=[Create];")
    selfObj.miPagObj = nil

    EventMgr = require("comm.eventmgr")
    selfObj.miEventMgr = EventMgr.Create(aiData)

    selfObj:InitBaseData()
    selfObj:Init()
    

    return selfObj
end

function InitBaseData( selfObj )
    selfObj.nIndex = 1
    selfObj.cardData = {}
    for i = 1, PokerNum do
        selfObj.cardData[i] = false
    end
    

    selfObj.cardNodes = {}
    selfObj.vUserNodes = {}
end

--创建初始化UI
function Init(selfObj)
    print(" file=[winratecalculatepag] fun=[init];")
    local PromptNode = require("winratecalculate.uiwinratecalculate.winratecalculate")
    local callBackProvider = function ( path,node,funcName )
        if  node:getName()=="btnexit" and funcName =="OnBtnExitButton" then
            local function OnBtnExitButton1(  node,eventType )
                 selfObj:OnBtnExitButton( node,eventType )
            end
            return OnBtnExitButton1
        end
        if  node:getName()=="btnreset" and funcName =="OnBtnResetButton" then
            local function OnBtnResetButton1(  node,eventType )
                 selfObj:OnBtnResetButton( node,eventType )
            end
            return OnBtnResetButton1
        end
        --减少人数
        if  node:getName()=="btnminus" and funcName =="OnBtnMinusUserButton" then
            local function OnBtnMinusUserButton1(  node,eventType )
                selfObj:OnBtnMinusUserButton( node,eventType )
            end
            return OnBtnMinusUserButton1
        end
        --添加人数
        if  node:getName()=="btnadd" and funcName =="OnBtnAddUserButton" then
            local function OnBtnAddUserButton1(  node,eventType )
                selfObj:OnBtnAddUserButton( node, eventType )
            end
            return OnBtnAddUserButton1
        end
        --计算胜率
        if  node:getName()=="btnCalculate" and funcName =="OnBtnCalculateButton" then
            local function OnBtnCalculateButton1(  node,eventType )
                selfObj:OnBtnCalculateButton( node, eventType )
            end
            return OnBtnCalculateButton1
        end
        --撤销
        if  node:getName()=="btncancel" and funcName =="OnBtnCancelButton" then
            local function OnBtnCancelButton1(  node,eventType )
                selfObj:OnBtnCancelButton( node, eventType )
            end
            return OnBtnCancelButton1
        end
        --牌型：黑桃
        if  node:getName()=="btnhei" and funcName =="OnBtnSelectHeiButton" then
            local function OnBtnSelectHeiButton1(  node,eventType )
                selfObj:OnBtnSelectHeiButton( node, eventType )
            end
            return OnBtnSelectHeiButton1
        end
        --牌型：红桃
        if  node:getName()=="btnhong" and funcName =="OnBtnSelectHongButton" then
            local function OnBtnSelectHongButton1(  node,eventType )
                selfObj:OnBtnSelectHongButton( node, eventType )
            end
            return OnBtnSelectHongButton1
        end
        --牌型：梅花
        if  node:getName()=="btnmei" and funcName =="OnBtnSelectMeiButton" then
            local function OnBtnSelectMeiButton1(  node,eventType )
                selfObj:OnBtnSelectMeiButton( node, eventType )
            end
            return OnBtnSelectMeiButton1
        end
        --牌型：方块
        if  node:getName()=="btnfang" and funcName =="OnBtnSelectFangButton" then
            local function OnBtnSelectFangButton1(  node,eventType )
                selfObj:OnBtnSelectFangButton( node, eventType )
            end
            return OnBtnSelectFangButton1
        end
        if  node:getName()=="btncard1" or node:getName()=="btncard2"  or node:getName()=="btncard3"
         or node:getName()=="btncard4"  or node:getName()=="btncard5"  or node:getName()=="btncard6"
          or node:getName()=="btncard7"  or node:getName()=="btncard8"  or node:getName()=="btncard9" 
           or node:getName()=="btncard10"  or node:getName()=="btncard11"  or node:getName()=="btncard12" 
            or node:getName()=="btncard13"  and funcName =="OnBtnSelectValueButton" then
            local function OnBtnSelectValueButton1(  node,eventType )
                selfObj:OnBtnSelectValueButton( node, eventType )
            end
            return OnBtnSelectValueButton1
        end
    end
    selfObj.miPagObj = PromptNode.create(callBackProvider)
    selfObj.miPagObj['root']:retain()

    

    selfObj:SetCalculateBtnState(false)

    for i = 1, 5 do
        local data = {
            tEventMgr = selfObj.miEventMgr,
            lFanPaiId = i
        }
        local pCardNodePag = require("winratecalculate.winratecalculate.cardnodepag")
        local pCardNode = pCardNodePag.Create(data)
        selfObj.miPagObj['nodefanpai'..i]:addChild(pCardNode:GetRootNode())
        selfObj:AddCardNodes(pCardNode)
    end

    for i = 1, 2 do 
        selfObj:addUser()
    end

    if #selfObj.cardNodes > 5  then
        selfObj.cardNodes[6]:SetBtnSelectState(true)
    else
        selfObj.cardNodes[1]:SetBtnSelectState(true)
    end
end

function GetRootNode(selfObj)
    return selfObj.miPagObj['root']
end

function OnBtnExitButton( selfObj, node, eventType )
    print(" file=[winratecalculate] fun=[OnBtnExitButton];")

    selfObj.miPagObj['root']:removeFromParent()
    selfObj.miPagObj['root']:release()
end
-- 重置
function OnBtnResetButton( selfObj, node, eventType )
    print(" file=[winratecalculate] fun=[OnBtnResetButton];")

    selfObj.nIndex = 1
    for i = 1, PokerNum do
        selfObj.cardData[i] = false
    end
    selfObj:UpdateTypeBtnState("value",selfObj.nIndex)
    for i = 1, 13 do
        selfObj.miPagObj['btncard'..i]:setEnabled(true)
    end
    for i = 1, #selfObj.cardNodes do
        selfObj.cardNodes[i]:ResetCardData()
    end
end

-- 人数：减少
function OnBtnMinusUserButton( selfObj, node, eventType )
    print(" file=[winratecalculate] fun=[OnBtnMinusUserButton];")

    selfObj:minusUser()
end

-- 人数：增加
function OnBtnAddUserButton( selfObj, node, eventType )
    print(" file=[winratecalculate] fun=[OnBtnAddUserButton];")

    selfObj:addUser()
end

-- 计算胜率
function OnBtnCalculateButton( selfObj, node, eventType )
    print(" file=[winratecalculate] fun=[OnBtnCalculateButton];")

    local vTotalCardData = {}
    local tUserCurrentHandsDataListOdds = {}
    -- 手牌数据
    for i = 1, #selfObj.vUserNodes do
        local pUserNode = selfObj.vUserNodes[i]
        local vUserCardData = {}
        vUserCardData.lUserId = pUserNode:GetUserId()
        vUserCardData.vCardData = {}
        local vUserCardNodes = pUserNode:GetUserCardNodes()
        for j = 1, #vUserCardNodes do
            table.insert( vUserCardData.vCardData, vUserCardNodes[j]:GetCardIndex() )
            table.insert(tUserCurrentHandsDataListOdds, vUserCardNodes[j]:GetCardIndex())
        end
    end

    local tPublicCurrentCardsListOdds = {}
    -- 翻牌数据
    local nFanPaiIndex = 0
    local nFanPaiCount = 0
    for i = 1, #selfObj.cardNodes do
        local pCardNode = selfObj.cardNodes[i]
        local lFanPaiId = pCardNode:GetFanPaiId()
        if nil ~= lFanPaiId then
            if pCardNode:GetCardIndex() > 0 then
                 nFanPaiCount = nFanPaiCount + 1
                local vFanPaiCardData = {}
                vFanPaiCardData.lFanPaiId = lFanPaiId
                vFanPaiCardData.lIndex = selfObj.cardNodes[i]:GetCardIndex()
                table.insert( vTotalCardData, vFanPaiCardData )
                table.insert(tPublicCurrentCardsListOdds, vFanPaiCardData.lIndex)
            else
                print("翻牌、转牌、河牌牌...中止添加  lFanPaiId = "..lFanPaiId)
                break
            end
        end
    end


    ------------------------------------------------------
    local aiWinOdds = cc.CClientPlatform:sharedClientPlatform():GetALLinOdds(1, tUserCurrentHandsDataListOdds, tPublicCurrentCardsListOdds)


    local tAllAllinOdds = 100
    local miWinOddsDataList = {}
    for i = 1, #selfObj.vUserNodes do
        local tAllinOdds = 0
        if i == #selfObj.vUserNodes then
            tAllinOdds = tAllAllinOdds
        else
            tAllinOdds = selfObj:RoundedNumber(aiWinOdds[i] * 100)
            tAllAllinOdds = tAllAllinOdds - tAllinOdds
        end
        table.insert(miWinOddsDataList, tAllinOdds)
    end
    --------------------------------------------------------------------

    selfObj:ResetWinPercent(miWinOddsDataList)
    print("string = "..tostring(vTotalCardData))

    -- 传送人数:lUserCount = #selfObj.vUserNodes
    -- 数值table：vTotalCardData
    function CalculateFunc( lUserCount, vTotalCardData )
        
    end
end

-- 撤销当前选中扑克数据
function OnBtnCancelButton( selfObj, node, eventType )
    print(" file=[winratecalculate] fun=[OnBtnCancelButton];")

    for i = 1, #selfObj.cardNodes do

        if selfObj.cardNodes[i]:GetBtnSelectType() then
            local index = selfObj.cardNodes[i]:GetCardIndex()
            if index == 0 then
                return
            end
            selfObj.cardData[index] = false
            local data = selfObj.cardNodes[i]:GetCardTypeAndValue()
            selfObj.cardNodes[i]:ResetCardData()
            selfObj:UpdateTypeBtnState("chexiao", GetCardIndex(data.lType, data.lValue))
            break
        end
    end
end

-- 黑桃
function OnBtnSelectHeiButton( selfObj, node, eventType )
    print(" file=[winratecalculate] fun=[OnBtnSelectHeiButton];")

    local pCardNode = selfObj:GetSelectedCardNode()
    if nil == pCardNode then
        return
    end

    local data = {
        lType = 0,
        lValue = selfObj.nIndex
    }

    selfObj:SetTypeBtnStateAndUpCardData(pCardNode, data)
end

-- 红桃
function OnBtnSelectHongButton( selfObj, node, eventType )
    print(" file=[winratecalculate] fun=[OnBtnSelectHongButton];")
    
    local pCardNode = selfObj:GetSelectedCardNode()
    if nil == pCardNode then
        return
    end
    
    local data = {
        lType = 1,
        lValue = selfObj.nIndex
    }

    selfObj:SetTypeBtnStateAndUpCardData(pCardNode, data)
end

-- 梅花
function OnBtnSelectMeiButton( selfObj, node, eventType )
    print(" file=[winratecalculate] fun=[OnBtnSelectMeiButton];  "..#selfObj.cardNodes)

    local pCardNode = selfObj:GetSelectedCardNode()
    if nil == pCardNode then
        return
    end

    local data = {
        lType = 2,
        lValue = selfObj.nIndex
    }
    
    selfObj:SetTypeBtnStateAndUpCardData(pCardNode, data)
end

-- 方块
function OnBtnSelectFangButton( selfObj, node, eventType )
    print(" file=[winratecalculate] fun=[OnBtnSelectFangButton];")

    local pCardNode = selfObj:GetSelectedCardNode()
    if nil == pCardNode then
        return
    end

    local data = {
        lType = 3,
        lValue = selfObj.nIndex
    }

    selfObj:SetTypeBtnStateAndUpCardData(pCardNode, data)
end

-- 数值：value
function OnBtnSelectValueButton( selfObj, node, eventType )
    print(" file=[winratecalculate] fun=[OnBtnSelectValueButton];")

    local sNodeName = node:getName()
    local length = string.len( sNodeName )
    local sIndex = string.sub( sNodeName, 8, length )
    selfObj.nIndex = tonumber(sIndex)
    print("selfObj.nIndex = "..selfObj.nIndex)
    selfObj.miPagObj['heivalue']:loadTexture(string.format("game/winratecalculate/num%d.png", selfObj.nIndex), 0)
    selfObj.miPagObj['hongvalue']:loadTexture(string.format("game/winratecalculate/num%d.png", selfObj.nIndex), 0)
    selfObj.miPagObj['meivalue']:loadTexture(string.format("game/winratecalculate/num%d.png", selfObj.nIndex), 0)
    selfObj.miPagObj['fangvalue']:loadTexture(string.format("game/winratecalculate/num%d.png", selfObj.nIndex), 0)
    if selfObj.miPagObj['heivalue'] == nil then
        print("selfObj.miPagObj['heivalue'] = nil")
    end

    -- 判断当前四种扑克是否可以使用
    selfObj:UpdateTypeBtnState("value", selfObj.nIndex)
end

-- 减少人数
function minusUser( selfObj )
    print(" file=[winratecalculate] fun=[minusUser];")

    local userCount = selfObj.miPagObj['userscrollview']:getChildrenCount()
    if userCount <= 2 then
        print("最少放2个...")
        return
    end

    local tMaxTag = 1
    local usersArr = selfObj.miPagObj['userscrollview']:getChildren()
    -- 筛选最后添加的用户
    for i = 1, #usersArr do
        local pUserChildNode = usersArr[i]
        if nil ~= pUserChildNode then
            if tMaxTag <= pUserChildNode:getTag() then
                tMaxTag = pUserChildNode:getTag()
            end
        end
    end

    if tMaxTag == 1 or tMaxTag == 2 then
        print("不能一直第一张和第二张..."..tMaxTag)
        return
    end

    for i = 1, #selfObj.vUserNodes do
        if selfObj.vUserNodes[i]:GetRootNode():getTag() == tMaxTag then
            table.remove(selfObj.vUserNodes, i)
            break
        end
    end
    selfObj:ResetWinPercent()
    selfObj.miPagObj['userscrollview']:removeChildByTag(tMaxTag)
    for i = 1, #selfObj.cardNodes do
        if nil ~= selfObj.cardNodes[i] and tMaxTag == selfObj.cardNodes[i]:GetOwnUserId() then
            table.remove( selfObj.cardNodes, i )
            break
        end
    end

    selfObj:SetScrollviewSizeAndSetItemPos(false)
    
    if selfObj:CheckIsCanCalculate() then
        selfObj:SetCalculateBtnState(true)
    else
        selfObj:SetCalculateBtnState(false)
    end
end

-- 添加人数
function addUser( selfObj )
    print(" file=[winratecalculate] fun=[addUser];")

    local userCount = selfObj.miPagObj['userscrollview']:getChildrenCount() + 1
    if userCount >= 10 then
        print("最多只能放9个...")
        return
    end

    local userNodePag = require("winratecalculate.winratecalculate.usernodepag")
    local data = {
        lUserId = userCount,
        tEventMgr = selfObj.miEventMgr
    }
    local pUserNode = userNodePag.Create(data)
    if nil == pUserNode then
        return
    end

    print(" children count = "..userCount)
    pUserNode:SetWinPercentText(userCount)
    pUserNode:GetRootNode():setTag(userCount)
    selfObj.miPagObj['userscrollview']:addChild(pUserNode:GetRootNode())
    table.insert(selfObj.vUserNodes, pUserNode)
    selfObj:ResetWinPercent()

    local userCardNodes = pUserNode:GetUserCardNodes()
    for i = 1, #userCardNodes do
        selfObj:AddCardNodes(userCardNodes[i])
    end
    
    selfObj:SetScrollviewSizeAndSetItemPos(true)

    if selfObj:CheckIsCanCalculate() then
        selfObj:SetCalculateBtnState(true)
    else
        selfObj:SetCalculateBtnState(false)
    end
end

-- scrollview大小尺寸实时变化
function SetScrollviewSizeAndSetItemPos( selfObj, isAdd )
    print(" file=[winratecalculate] fun=[SetScrollviewSizeAndSetItemPos];")
     -- 扩容
    local tScrollViewWidth = selfObj.miPagObj['userscrollview']:getInnerContainerSize().width
    local tScrollViewHeight = selfObj.miPagObj['userscrollview']:getInnerContainerSize().height
    if tScrollViewHeight <= 960 and isAdd == false then
        print("--到高度要求...最低")
        return
    end

    if tScrollViewHeight >= 2840 and isAdd == true then
        print("++到高度要求...最高")
        return
    end

    local userCount = selfObj.miPagObj['userscrollview']:getChildrenCount()
    if isAdd == true then
        -- 扩容
        if userCount >= 5 and userCount % 2 == 1 then
            selfObj.miPagObj['userscrollview']:setInnerContainerSize( cc.size(tScrollViewWidth, tScrollViewHeight + 470) )
            tScrollViewHeight = selfObj.miPagObj['userscrollview']:getInnerContainerSize().height
        end
    else
        -- 收缩
        if userCount >= 4 and userCount % 2 == 0 then
            selfObj.miPagObj['userscrollview']:setInnerContainerSize( cc.size(tScrollViewWidth, tScrollViewHeight - 470) )
            tScrollViewHeight = selfObj.miPagObj['userscrollview']:getInnerContainerSize().height
        end
    end
    
    local xPos = 0
    local yPos = 0
    local xArr = {368, 874}
    print(" 11xPos = -------------------------------------  tContentHeight = "..tScrollViewHeight)
    for i = 1, userCount do
        local pChildNode = selfObj.miPagObj['userscrollview']:getChildByTag(i)
        if nil ~= pChildNode then
            if i % 2 == 1 then
                xPos = xArr[1]
            else
                xPos = xArr[2]
            end
            yPos = tScrollViewHeight - 200 - 470 * (math.floor( (i - 1)/ 2 ))
            print(" 11xPos = "..xPos.."   yPos = "..yPos)
            pChildNode:setPosition(cc.p(xPos, yPos))
        end
    end
end

-- 扑克几点管理数组
function AddCardNodes( selfObj, tPokeNode )
    print(" file=[winratecalculate] fun=[AddCardNodes];")
    
    local lCount = #selfObj.cardNodes
    tPokeNode:SetCardId(lCount + 1)
    table.insert( selfObj.cardNodes, tPokeNode )
end

-- 更新已有数据的扑克
function SetTypeBtnStateAndUpCardData( selfObj, tCardNode, data )
    print(" file=[winratecalculate] fun=[SetTypeBtnStateAndUpCardData];")
    -- 更新扑克节点数据之前，对扑克数据进行更新，同时判断更新前后是否是都是一样的value，是的话要对type按钮更新
    local pCardData = tCardNode:GetCardTypeAndValue()
    if nil ~= pCardData and 0 ~= pCardData.lValue then
        local beforeIndex = GetCardIndex(pCardData.lType, pCardData.lValue)
        selfObj.cardData[beforeIndex] = false
        selfObj:UpdateTypeBtnState("type", beforeIndex)
    end

    -- 扑克节点更新
    tCardNode:SetCardData(data)

    -- type按钮更新
    local index = GetCardIndex(data.lType, data.lValue)
    selfObj.cardData[index] = true
    selfObj:UpdateTypeBtnState("type", index, tCardNode:GetCardId())
end

-- 获取当前选中的扑克
function GetSelectedCardNode( selfObj )
    for i = 1, #selfObj.cardNodes do
        if nil ~= selfObj.cardNodes[i] and selfObj.cardNodes[i]:GetBtnSelectType() == true then
            return selfObj.cardNodes[i]
        end
    end

    return nil
end

----------------------------
--四舍五入函数
function RoundedNumber(selfObj, aiNumber)
    local tX, tY = math.modf(aiNumber)
    if tY - 0.5 >= 0.000001 then
        tX = tX + 1
    end
    return tX
end


-- 设置胜率
function ResetWinPercent( selfObj, data)
    
    if nil == data then
        for i = 1, #selfObj.vUserNodes do
            selfObj.vUserNodes[i]:SetWinPercentText(nil)
        end
        return
    end
    
    for i = 1, #selfObj.vUserNodes do
       selfObj.vUserNodes[i]:SetWinPercentText(data[i])
    end
end

-- 设置type按钮是否可用
function UpdateTypeBtnState( selfObj, state, index, lChangeCardId )
    print("state = "..state.."  lValue = "..index.." nIndex = "..selfObj.nIndex.."  type = "..(math.floor((index-1) / 13) + 1))

    -- 判断当前四种扑克是否可以使用
    local sTypeNameArr = {"btnhei", "btnhong", "btnmei", "btnfang"}
    if state == "value" then
        for i = 1, 4 do
            local tIndex = GetCardIndex(i - 1, selfObj.nIndex)
            print("tIndex ... = "..tIndex)
            if selfObj.cardData[tIndex] == true then
                selfObj.miPagObj[sTypeNameArr[i]]:setEnabled(false)
            else
                selfObj.miPagObj[sTypeNameArr[i]]:setEnabled(true)
            end
        end
    elseif state == "chexiao" then
        local lType = math.floor((index-1) / 13) + 1
        local lValue = index - 13*(lType-1)
        print("33 lValue = "..lValue.."  lType = "..lType)
        if lValue == selfObj.nIndex then
            if selfObj.cardData[index] == true then
                selfObj.miPagObj[sTypeNameArr[lType]]:setEnabled(false)
            else
                selfObj.miPagObj[sTypeNameArr[lType]]:setEnabled(true)
            end
        end
    elseif state == "type" then
        local lType = math.floor((index-1) / 13) + 1
        local lValue = index - 13*(lType-1)
        print("33 lValue = "..lValue)
        if lValue == selfObj.nIndex then
            print("11 selfObj.cardData[index] == true...lValue = "..lValue)
            if selfObj.cardData[index] == true then
                print("22 selfObj.cardData[index] == true...lType = "..lType)
                selfObj.miPagObj[sTypeNameArr[lType]]:setEnabled(false)
            else
                selfObj.miPagObj[sTypeNameArr[lType]]:setEnabled(true)
            end
        end
    end

    -- 更新计算按钮状态
    if state ~= "value" then
        if selfObj:CheckIsCanCalculate() then
            selfObj:SetCalculateBtnState(true)
        else
            selfObj:SetCalculateBtnState(false)
        end
    end

    if state == "type" and nil ~= lChangeCardId then
        local count = #selfObj.cardNodes
        if lChangeCardId <= count then
            local pCardNode = selfObj.cardNodes[lChangeCardId]
            local nextId = nil
            if nil ~= pCardNode:GetFanPaiId() then
                if lChangeCardId < 5 then
                    nextId = lChangeCardId + 1
                else
                    nextId = 1
                end
            elseif nil ~= pCardNode:GetOwnUserId() then
                if lChangeCardId < count then
                    nextId = lChangeCardId + 1
                elseif lChangeCardId >= count then
                    nextId = 6
                end
            end
            if nextId ~= nil then
                print("nextId = "..nextId)
                selfObj.cardNodes[nextId]:SetBtnSelectState(true)
            end
        end
    end
end


-- 设置计算胜率按钮显示状态
function SetCalculateBtnState(selfObj, bEnable)
    if bEnable then
        selfObj.miPagObj['btnCalculate']:setEnabled(true)
        selfObj.miPagObj['btnCalculate']:setTitleColor(cc.c3b(0, 0, 0))
    else
        selfObj.miPagObj['btnCalculate']:setEnabled(false)
        selfObj.miPagObj['btnCalculate']:setTitleColor(cc.c3b(107, 107, 107))
    end
end

-- 判断计算胜率按钮是否可用
function CheckIsCanCalculate( selfObj )
    print(" file=[winratecalculate] fun=[CheckIsCanCalculate];")

    local bEnable = false
    local vTotalCardData = {}
    -- 手牌数据
    for i = 1, #selfObj.vUserNodes do
        local pUserNode = selfObj.vUserNodes[i]
        print(" file=[winratecalculate] fun=[CheckIsCanCalculate]; i = "..i)
        if pUserNode:GetAllCardIsSetValue() == false then
            print("还有手牌没有设置..."..pUserNode:GetUserId())
            return false
        end
    end

    -- 翻牌数据
    local nFanPaiIndex = 0
    local nFanPaiCount = 0
    local bFull = false
    for i = 1, #selfObj.cardNodes do
        local pCardNode = selfObj.cardNodes[i]
        local lFanPaiId = pCardNode:GetFanPaiId()
        if nil ~= lFanPaiId then
            print("翻牌、转牌、河牌: FanPaiId = "..lFanPaiId)
            if pCardNode:GetCardIndex() > 0 then
                print("CardIndex = "..pCardNode:GetCardIndex())
                nFanPaiCount = nFanPaiCount + 1
                if lFanPaiId >= 3 and lFanPaiId == nFanPaiCount then
                    bFull =  true
                end
            end
        end
    end

    if bFull == false then
        print("翻牌、转牌、河牌牌不完整...  "..nFanPaiCount)
        return false
    end

    return bFull
end

