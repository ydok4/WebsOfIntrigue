require 'script/_lib/DataHelpers'

NarrativeManager = {
    CurrentTurn = 0,
    SpecialEventResources = {},
    EventResources = {},
    GlobalActiveEventChains = {},
}

function NarrativeManager:new (o)
  o = o or {};
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function NarrativeManager:StartTriggerEvents(topLevelWebs)
    self:TriggerEventsForWebs(topLevelWebs)
    self.CurrentTurn = self.CurrentTurn + 1;
end

function NarrativeManager:TriggerEventsForWebs(topLevelWebs)
    for key, web in pairs(topLevelWebs) do
        -- Check any active event chains need to advanced
        self:AdvanceEventChainsInWeb(web);
        -- Find and apply any valid narrative events
        self:FindAndApplyNarrativeEvents(web);
        -- Perform character actions

        -- Find and apply any valid special narrative events

        -- Repeat for web children
        self:TriggerEventsForWebs(web.ChildWebs);
    end
end

function NarrativeManager:FindAndApplyNarrativeEvents(object)
    local validEvents = {};
    for eventKey, event in pairs(self.EventResources) do
        if event:IsThereResultForWebType(object.Type) and
        self:HasEventOccurredRecently(eventKey, object) == false and
        object:IsEventPartOfActiveEventChain(eventKey) == false and
        event.CanApplyEvent(object) then
            validEvents[#validEvents + 1] = event;
        end
    end
    if #validEvents == 0 then
        return;
    end

    local randomEvent = GetRandomObjectFromList(validEvents);
    local eventResult = object:ApplyEventAndReturnResult(randomEvent, self.CurrentTurn);

end

function NarrativeManager:HasEventOccurredRecently(eventKey, web)
    for key, history in pairs(web.EventHistory) do
        if history.EventKey == eventKey then
            if self.CurrentTurn > history.TurnNumber + 20 then
                return false;
            else
                return true;
            end
        end
    end
    return false;
end

function NarrativeManager:AdvanceEventChainsInWeb(web)
    for key, eventChain in pairs(web.ActiveEventChains) do
        if eventChain.NextEvent.TurnNumber == self.CurrentTurn then
            local eventData = self.EventResources[eventChain.NextEvent.EventKey];
            web:ApplyEventAndReturnResult(eventData, self.CurrentTurn);
        elseif eventChain.NextEvent.TurnNumber < self.CurrentTurn then
            web:CompleteEventChain(eventChain.Key);
            Custom_Log("Remove event chain "..eventChain.Key);
        end
    end
end

function NarrativeManager:AdvanceEventChains()
    for key, event in pairs(self.GlobalActiveEventChains) do

    end
end