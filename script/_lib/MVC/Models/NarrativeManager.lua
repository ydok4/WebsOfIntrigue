NarrativeManager = {
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

function NarrativeManager:StartTriggerEvents(raceIdentifier)
    local raceRootWeb = WebsOfIntrigue:GetRootWebForRace(raceIdentifier);
    for webKey, webUUID in pairs(raceRootWeb.ChildWebs) do
        local web = WebsOfIntrigue:GetWebByUUID(webUUID);
        self:TriggerEventsForWeb(web)
    end
    IntrigueManager.CurrentTurn = IntrigueManager.CurrentTurn + 1;
end

function NarrativeManager:TriggerEventsForWeb(web)
    if web.ChildWebs then
        for index, webUUID in pairs(web.ChildWebs) do
            local childWeb = WebsOfIntrigue:GetWebByUUID(webUUID);
            self:TriggerEventsForWeb(childWeb);
        end
    end
    -- Check any active event chains need to advanced
    self:AdvanceEventChainsInWeb(web);
    -- Find and apply any valid narrative events
    self:FindAndApplyNarrativeEvents(web);
    -- Perform character actions
    self:PerformCharacterActions(web);
    -- Find and apply any valid special narrative events
    
end

function NarrativeManager:AdvanceEventChainsInWeb(web)
    for key, eventChain in pairs(web.ActiveEventChains) do
        if eventChain.NextEvent.TurnNumber == IntrigueManager.CurrentTurn then
            local eventData = self.EventResources[eventChain.NextEvent.EventKey];
            web:ApplyEventAndReturnResult(eventData, IntrigueManager.CurrentTurn);
        elseif eventChain.NextEvent.TurnNumber < IntrigueManager.CurrentTurn then
            web:CompleteEventChain(eventChain.Key);
            Custom_Log("Remove event chain "..eventChain.Key);
        end
    end
end

function NarrativeManager:FindAndApplyNarrativeEvents(web)
    local validWebEvents = self:FindNarrativeEventsForWeb(web);
    if #validWebEvents == 0 then
        return;
    end

    local randomEvent = GetRandomObjectFromList(validWebEvents);
    local eventResult = web:ApplyEventAndReturnResult(randomEvent, self.CurrentTurn);
end

function NarrativeManager:FindNarrativeEventsForWeb(web)
    local validEvents = {};
    for eventKey, event in pairs(self.EventResources) do
        if  event:IsEventForType(web.Type) and
            self:HasEventOccurredRecently(eventKey, web) == false and
            web:IsEventPartOfActiveEventChain(eventKey) == false and
            event.CanApplyEvent(web) then
                validEvents[#validEvents + 1] = event;
        end
        --[[elseif event:IsEventForScope("District") then
            for key, district in pairs(web.District) do
                if self:HasEventOccurredRecently(eventKey, district) == false and
                    district:IsEventPartOfActiveEventChain(eventKey) == false and
                    event.CanApplyEvent(web) then
                        validEvents[#validEvents + 1] = event;
                end
            end
        elseif event:IsEventForScope("Character") then
            for key, district in pairs(web.District) do
                for key, character in pairs(district.Characters) do
                if self:HasEventOccurredRecently(eventKey, district) == false and
                    character:IsEventPartOfActiveEventChain(eventKey) == false and
                    event.CanApplyEvent(web) then
                        validEvents[#validEvents + 1] = event;
                end
            end--]]
    end
    return validEvents;
end

function NarrativeManager:FindNarrativeEventsForDistricts(web)

end

function NarrativeManager:FindNarrativeEventsForCharacters(characters)

end

function NarrativeManager:PerformCharacterActions(web)
    for characterKey, character in pairs(self.Characters) do
        for goalKey, goal in pairs(character.Goals) do
            local validActions = goal:GetMatchingActions(character.Actions);
            local selectedAction = GetRandomObjectFromList(validActions);;
            character:PerformAction(selectedAction);
        end
    end
end

function NarrativeManager:HasEventOccurredRecently(eventKey, web)
    for key, history in pairs(web.EventHistory) do
        if history.EventKey == eventKey then
            if IntrigueManager.CurrentTurn > history.TurnNumber + 20 then
                return false;
            else
                return true;
            end
        end
    end
    return false;
end

function NarrativeManager:AdvanceEventChains()
    for key, event in pairs(self.GlobalActiveEventChains) do

    end
end