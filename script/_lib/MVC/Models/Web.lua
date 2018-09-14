  Web = {
    WebUUID = "",
    ParentUUID = "",
    Name = "",
    ParentName = "",
    -- 1 to 5
    Size = 0,
    SupportedBackgrounds = {},
    SocialClassModifier = 0,
    Characters = {},
    ChildWebs = {},
    Districts = {},
    EventHistory = {},
    ActiveEventChains = {},
    CompletedEventChains = {},
  }

function Web:new (o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end

function Web:GetFactionsWithTypes(types)
  local matchingFactions = {};
  for key1, district in pairs(self.Districts) do
    for key2, factionUUID in pairs(district.ActiveFactions) do
      for key3, type in pairs(types) do
        local faction = WebsOfIntrigue:GetFactionByUUID(factionUUID);
        if faction:HasType(type) then
          matchingFactions[faction.UUID] = faction;
          break;
        end
      end
    end
  end

  return matchingFactions;
end

function Web:IsEventPartOfActiveEventChain(eventKey)
  if self.ActiveEventChains[eventKey] then
    return true;
  end
  return false;
end

function Web:CompleteEventChain(eventChainKey)
  self.CompletedEventChains[#self.CompletedEventChains + 1] = ConvertEventChainToCompletedChain(self.ActiveEventChains[eventChainKey]);
  self.ActiveEventChains[eventChainKey] = nil;
end

function Web:ApplyEventAndReturnResult(event, currentTurn)
  if self.Type == "Province" then
    local selectedEvent = self:ApplyEventForWebScope(event, currentTurn);
    if event.ScopeLimits['Settlements'] and event.ScopeLimits['Settlements'] ~= 0 then
      local selectedWebUUIDs = {};
      for i = 1, event.ScopeLimits['Settlements'] do
        local web = GetRandomObjectFromList(self.ChildWebs);
        if selectedWebUUIDs[web.UUID] then
          i = i - 1;
        else
          web:ApplyEventForWebScope(event, currentTurn);
          selectedWebUUIDs[web.UUID] = 1;
        end
      end
    else
      for key, web in pairs(self.ChildWebs) do
        web:ApplyEventForWebScope(event, currentTurn);
      end
    end
    return selectedEvent;
  else
    return self:ApplyEventForWebScope(event, currentTurn);
  end
end

function Web:ApplyEventForWebScope(event, currentTurn)
  local cachedData = event:CachedDataFunction(self, nil, nil);
  local selectedResult = event:FindResultForScope(self, self.Type, cachedData);
  if selectedResult then
    self:ApplyEventResult(event, selectedResult, currentTurn, cachedData);
  end
  if #self.Districts > 0 then
    self:ApplyEventForDistrictScope(event, currentTurn, cachedData);
  end

  return selectedResult;
end

function Web:ApplyEventForDistrictScope(event, currentTurn, cachedData)
  if event.ScopeLimits['Districts'] and event.ScopeLimits['Districts'] ~= 0 then
    local selectedDistrictUUIDs = {};
    for i = 1, event.ScopeLimits['Districts'] do
      local district = GetRandomObjectFromList(self.Districts);
      if selectedDistrictUUIDs[district.UUID] then
        i = i - 1;
      else
        district:ApplyEventAndReturnResult(event, currentTurn, cachedData);
        selectedDistrictUUIDs[district.UUID] = 1;
      end
    end
  else
    for key1, district in pairs(self.Districts) do
      local selectedResult = district:ApplyEventAndReturnResult(event, currentTurn, cachedData);
      self:ApplyEventForCharacterScope(event, currentTurn, district, cachedData);
      self:CheckAndAddEventChain(event, selectedResult, currentTurn, { Scope = "Districts", UUID = district.UUID });
    end
  end
end

function Web:ApplyEventForCharacterScope(event, currentTurn, district, cachedData)
  if event.ScopeLimits['Characters'] and event.ScopeLimits['Characters'] ~= 0 then
    local selectedCharacterUUIDs = {};
    for i = 1, event.ScopeLimits['Characters'] do
        local character = GetRandomObjectFromList(district.Characters);
        if selectedCharacterUUIDs[character.UUID] then
          i = i - 1;
        else
          character:ApplyEventAndReturnResult(event, currentTurn, cachedData);
          selectedCharacterUUIDs[character.UUID] = 1;
        end
    end
  else
    for key1, character in pairs(district.Characters) do
      local selectedResult = character:ApplyEventAndReturnResult(event, currentTurn, cachedData);
      self:CheckAndAddEventChain(event, selectedResult, currentTurn, { Scope = "Characters", UUID = district.UUID });
    end
  end
end


function Web:ApplyEventResult(event, result, currentTurn)
  self:AddEventHistory(event.Key, result.Key, currentTurn);
  self:CheckAndAddEventChain(event, result, currentTurn, { Scope = Web.Type, UUID = self.UUID });
end

function Web:CheckAndAddEventChain(event, result, currentTurn, object)
  if result.NextEvent.EventChainKey then
    if self.ActiveEventChains[result.NextEvent.EventChainKey] then
      self.ActiveEventChains[result.NextEvent.EventChainKey]:AddResultToEventChain(event, result, currentTurn);
    else -- New event chain
      local eventChain = GenerateEventChain(event, result, currentTurn, self, object);
      self.ActiveEventChains[eventChain.Key] = eventChain;
    end
  end
end

function Web:AddEventHistory(eventKey, resultKey, currentTurn)
  self.EventHistory[#self.EventHistory + 1] = {EventKey = eventKey, ResultKey = resultKey, TurnNumber = currentTurn};
end