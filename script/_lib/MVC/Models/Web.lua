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
    for key2, faction in pairs(district.ActiveFactions) do
      for key3, type in pairs(types) do
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
    self:ApplyEventForWebScope(event, currentTurn);
    for key, web in pairs(self.ChildWebs) do
      web:ApplyEventForWebScope(event, currentTurn);
    end
  else
    self:ApplyEventForWebScope(event, currentTurn);
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
  for key1, district in pairs(self.Districts) do
    district:ApplyEventAndReturnResult(event, currentTurn, cachedData);
    self:ApplyEventForCharacterScope(event, currentTurn, district, cachedData);
  end
end

function Web:ApplyEventForCharacterScope(event, currentTurn, district, cachedData)
  for key1, character in pairs(district.Characters) do
    local selectedResult = character:ApplyEventAndReturnResult(event, currentTurn, cachedData);
  end
end


function Web:ApplyEventResult(event, result, currentTurn)
  self:AddEventHistory(event.Key, result.Key, currentTurn);
  if result.NextEvent.EventChainKey then
    if self.ActiveEventChains[result.NextEvent.EventChainKey] then
      self.ActiveEventChains[result.NextEvent.EventChainKey]:AddResultToEventChain(event, result, currentTurn);
    else -- New event chain
      local eventChain = GenerateEventChain(event, result, currentTurn, self);
      self.ActiveEventChains[eventChain.Key] = eventChain;
    end
  end
end

function Web:AddEventHistory(eventKey, resultKey, currentTurn)
  self.EventHistory[#self.EventHistory + 1] = {eventKey, resultKey, currentTurn};
end