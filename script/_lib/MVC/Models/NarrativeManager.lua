require 'script/_lib/DataHelpers'

NarrativeManager = {
    CurrentTurn = 0,
    SpecialEventResources = {},
    EventResources = {},
    ActiveEventChains = {},
}

function NarrativeManager:new (o)
  o = o or {};
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function NarrativeManager:TriggerEventsForWebs(topLevelWebs)
    for key, web in pairs(topLevelWebs) do
        -- Find and apply any valid narrative events
        self:FindAndApplyNarrativeEvents(web);
        -- Check event any active event chains need to advanced

        -- Perform character actions

        -- Find and apply any valid special narrative events


        -- Repeat for web children
        self:TriggerEventsForWebs(web.ChildWebs);
    end
    self.CurrentTurn = self.CurrentTurn + 1;
end

function NarrativeManager:FindAndApplyNarrativeEvents(object)
    local validEvents = {};
    for key, event in pairs(self.EventResources) do
        if event:IsThereResultForWebType(object.Type) and
        self:HasEventOccurredRecently(key, object) == false and
        event.CanApplyEvent(object) then
            validEvents[#validEvents + 1] = event;
        end
    end
    if #validEvents == 0 then
        return;
    end

    local randomEvent = GetRandomObjectFromList(validEvents);
    object:ApplyEventAndReturnResult(randomEvent, self.CurrentTurn);
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