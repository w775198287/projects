---http://blog.csdn.net/shimazhuge/article/details/45653407
---http://shahdza.blog.51cto.com/2410787/1566513/
local ViewBase = class("TTViewBase", function()
    return cc.Node:create()
end)

function ViewBase:ctor(app, name)
    self.app_ = app
    self.name_ = name

    -- -- check CSB resource file
    -- local res = rawget(self.class, "RESOURCE_FILENAME")
    -- if res then
    --     self:createResoueceNode(res)
    -- end

    if self.onCreate then self:onCreate() end
end

function ViewBase:getApp()
    return self.app_
end

function ViewBase:getName()
    return self.name_
end

function ViewBase:getResourceNode()
    return self.resourceNode_
end

function ViewBase:createResoueceNode(resourceFilename)
    if self.resourceNode_ then
        self.resourceNode_:removeSelf()
        self.resourceNode_ = nil
    end
    self.resourceNode_ = cc.CSLoader:createNode(resourceFilename)
    assert(self.resourceNode_, string.format("ViewBase:createResoueceNode() - load resouce node from file \"%s\" failed", resourceFilename))
    self:addChild(self.resourceNode_)
end


function ViewBase:onNodeEvent(eventName, callback)
    if "enter" == eventName then
        self.onEnterCallback_ = callback
    elseif "exit" == eventName then
        self.onExitCallback_ = callback
    elseif "enterTransitionFinish" == eventName then
        self.onEnterTransitionFinishCallback_ = callback
    elseif "exitTransitionStart" == eventName then
        self.onExitTransitionStartCallback_ = callback
    elseif "cleanup" == eventName then
        self.onCleanupCallback_ = callback
    end
    self:enableNodeEvents()
end

function ViewBase:enableNodeEvents()
    if self.isNodeEventEnabled_ then
        return self
    end

    self:registerScriptHandler(function(state)
        if state == "enter" then
            self:onEnter_()
        elseif state == "exit" then
            self:onExit_()
        elseif state == "enterTransitionFinish" then
            self:onEnterTransitionFinish_()
        elseif state == "exitTransitionStart" then
            self:onExitTransitionStart_()
        elseif state == "cleanup" then
            self:onCleanup_()
        end
    end)
    self.isNodeEventEnabled_ = true

    return self
end

function ViewBase:disableNodeEvents()
    self:unregisterScriptHandler()
    self.isNodeEventEnabled_ = false
    return self
end


function ViewBase:onEnter()
end

function ViewBase:onExit()
end

function ViewBase:onEnterTransitionFinish()
end

function ViewBase:onExitTransitionStart()
end

function ViewBase:onCleanup()
end

function ViewBase:onEnter_()
    self:onEnter()
    if not self.onEnterCallback_ then
        return
    end
    self:onEnterCallback_()
end

function ViewBase:onExit_()
    self:onExit()
    if not self.onExitCallback_ then
        return
    end
    self:onExitCallback_()
end

function ViewBase:onEnterTransitionFinish_()
    self:onEnterTransitionFinish()
    if not self.onEnterTransitionFinishCallback_ then
        return
    end
    self:onEnterTransitionFinishCallback_()
end

function ViewBase:onExitTransitionStart_()
    self:onExitTransitionStart()
    if not self.onExitTransitionStartCallback_ then
        return
    end
    self:onExitTransitionStartCallback_()
end

function ViewBase:onCleanup_()
    self:onCleanup()
    if not self.onCleanupCallback_ then
        return
    end
    self:onCleanupCallback_()
end



return ViewBase
