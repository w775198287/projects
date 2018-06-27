local NNUtils = import("..nn.NNUtils")
local NNEvent = class("NNEvent")

local DEBUG = 2
local EXPORTED_METHODS = {
    "addEventListener",
    "dispatchEvent",
    "removeEventListener",
    "removeEventListenersByTag",
    "removeEventListenersByEvent",
    "removeAllEventListeners",
    "hasEventListener",
    "dumpAllEventListeners",
}

function NNEvent:init_()
    self.target_ = nil
    self.listeners_ = {}
    self.nextListenerHandleIndex_ = 0
end
--lxf liuxiaofei add
function NNEvent:init()
    self.target_ = nil
    self.listeners_ = {}
    self.nextListenerHandleIndex_ = 0
end
--lxf liuxiaofei add
function NNEvent:bind(target)
    self:init_()
    cc.setmethods(target, self, EXPORTED_METHODS)
    self.target_ = target
end

function NNEvent:unbind(target)
    cc.unsetmethods(target, EXPORTED_METHODS)
    self:init_()
end

function NNEvent:on(pEventName, listener, tag)
    local eventName = tostring(pEventName)
    assert(type(eventName) == "string" and eventName ~= "",
        "NNEvent:addEventListener() - invalid eventName")
    eventName = string.upper(eventName)
    if self.listeners_[eventName] == nil then
        self.listeners_[eventName] = {}
    end

    self.nextListenerHandleIndex_ = self.nextListenerHandleIndex_ + 1
    local handle = tostring(self.nextListenerHandleIndex_)
    tag = tag or ""
    self.listeners_[eventName][handle] = {listener, tag}

    if DEBUG > 1 then
        NNUtils:Log(string.format("%s [NNEvent] addEventListener() - event: %s, handle: %s, tag: \"%s\"",
                  tostring(self.target_), eventName, handle, tostring(tag) ))
    end

    return self.target_, handle
end

NNEvent.addEventListener = NNEvent.on

function NNEvent:dispatchEvent(event)
    event.name = string.upper(tostring(event.name))
    local eventName = event.name
    if DEBUG > 1 then
        NNUtils:Log(string.format("%s [NNEvent] dispatchEvent() - event %s", tostring(self.target_), eventName))
    end

    if self.listeners_[eventName] == nil then return end
    event.target = self.target_
    event.stop_ = false
    event.stop = function(self)
        self.stop_ = true
    end

    for handle, listener in pairs(self.listeners_[eventName]) do
        if DEBUG > 1 then
            NNUtils:Log(string.format("%s [NNEvent] dispatchEvent() - dispatching event %s to listener %s", tostring(self.target_), eventName, handle))
        end
        -- listener[1] = listener
        -- listener[2] = tag
        event.tag = listener[2]
        listener[1](event)
        if event.stop_ then
            if DEBUG > 1 then
                NNUtils:Log(string.format("%s [NNEvent] dispatchEvent() - break dispatching for event %s", tostring(self.target_), eventName))
            end
            break
        end
    end
    NNUtils:Log("NNEvent:dispatchEvent diapatch end")
    return self.target_
end

function NNEvent:removeEventListener(handleToRemove)
    for eventName, listenersForEvent in pairs(self.listeners_) do
        for handle, _ in pairs(listenersForEvent) do
            if handle == handleToRemove then
                listenersForEvent[handle] = nil
                if DEBUG > 1 then
                    NNUtils:Log(string.format("%s [NNEvent] removeEventListener() - remove listener [%s] for event %s", tostring(self.target_), handle, eventName))
                end
                return self.target_
            end
        end
    end

    return self.target_
end

function NNEvent:removeEventListenersByTag(tagToRemove)
    for eventName, listenersForEvent in pairs(self.listeners_) do
        for handle, listener in pairs(listenersForEvent) do
            -- listener[1] = listener
            -- listener[2] = tag
            if listener[2] == tagToRemove then
                listenersForEvent[handle] = nil
                if DEBUG > 1 then
                    NNUtils:Log(string.format("%s [NNEvent] removeEventListener() - remove listener [%s] for event %s", tostring(self.target_), handle, eventName))
                end
            end
        end
    end

    return self.target_
end

function NNEvent:removeEventListenersByEvent(eventName)
    self.listeners_[string.upper(eventName)] = nil
    if DEBUG > 1 then
        NNUtils:Log(string.format("%s [NNEvent] removeAllEventListenersForEvent() - remove all listeners for event %s", tostring(self.target_), eventName))
    end
    return self.target_
end

function NNEvent:removeAllEventListeners()
    self.listeners_ = {}
    if DEBUG > 1 then
        NNUtils:Log(string.format("%s [NNEvent] removeAllEventListeners() - remove all listeners", tostring(self.target_)))
    end
    return self.target_
end

function NNEvent:hasEventListener(eventName)
    eventName = string.upper(tostring(eventName))
    local t = self.listeners_[eventName]
    for _, __ in pairs(t) do
        return true
    end
    return false
end

function NNEvent:dumpAllEventListeners()
    NNUtils:Log("---- NNEvent:dumpAllEventListeners() ----")
    for name, listeners in pairs(self.listeners_) do
        NNUtils:Log(string.format("-- event: %s", name))
        for handle, listener in pairs(listeners) do
            NNUtils:Log(string.format("--     listener: %s, handle: %s", tostring(listener[1]), tostring(handle)))
        end
    end
    return self.target_
end

return NNEvent
