module(...,package.seeall)

function Create(aiData)
    local selfObj = {}
    setmetatable( selfObj, {__index = _M} ) 
    print(" file=[usernodepag] fun=[Create];")
    selfObj.miPagObj = nil
    if nil ~= aiData then
        if nil ~= aiData.lUserId then
            selfObj.lUserId = aiData.lUserId
        end

        if nil ~= aiData.tEventMgr then
            selfObj.miEventMgr = aiData.tEventMgr
        end
    end

    selfObj.userCardNodes = {}

    selfObj:Init()

    return selfObj
end


--创建初始化UI
function Init(selfObj)
    print(" file=[usernodepag] fun=[init];")

    local PromptNode = require("winratecalculate.uiwinratecalculate.usernode")
    local callBackProvider = function ( path,node,funcName )
    end
    selfObj.miPagObj = PromptNode.create(callBackProvider)
    selfObj.miPagObj['root']:retain()

    local sName = ""
    for i = 1, 2 do
        local pCardNodePag = require("winratecalculate.winratecalculate.cardnodepag")
        local data = {
            tEventMgr = selfObj.miEventMgr,
            lOwnUserId = selfObj.lUserId,
            lUserPos = i
        }
        local pCardNode = pCardNodePag.Create(data)
        selfObj.miPagObj['cardnode'..i]:addChild(pCardNode:GetRootNode())
        
        table.insert( selfObj.userCardNodes, pCardNode )
    end
end

function GetRootNode(selfObj)
    return selfObj.miPagObj['root']
end

function SetWinPercentText( selfObj, lPercenet )
    if nil == lPercenet then
        selfObj.miPagObj['textpercent']:setString("")
        return
    end

    if lPercenet >= 50 then  -- 高胜率
        selfObj.miPagObj['textpercent']:setColor(cc.c3b(212, 103, 103))
    else
        selfObj.miPagObj['textpercent']:setColor(cc.c3b(0, 0, 0))
    end
    local str = lPercenet.."%"
    selfObj.miPagObj['textpercent']:setString(str)
end

function GetSelectedCardNode( selfObj )
    print(" file=[usernodepag] fun=[GetSelectedCard];")

    for i = 1, #selfObj.userCardNodes do
        if nil ~= selfObj.userCardNodes[i] then
            local isSelected = selfObj.userCardNodes[i]:GetBtnSelectType()
            if isSelected then
                return userCardNodes[i]
            end
        end
    end
end

function GetUserId( selfObj )
    return selfObj.lUserId
end

function GetUserCardNodes( selfObj )
    return selfObj.userCardNodes
end

function GetAllCardIsSetValue( selfObj )
    local count = 0
    for i = 1, #selfObj.userCardNodes do
        if selfObj.userCardNodes[i]:GetCardIndex() > 0 then
            count = count + 1
        end
    end
    
    if count == #selfObj.userCardNodes then
        return true
    else
        return false
    end
end

