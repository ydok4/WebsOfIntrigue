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
  }
  
function Web:new (o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end


function Web:GetFactionsWithType(type)
  local matchingFactions = {};
  for key, district in pairs(self.Districts) do
    for key, faction in pairs(district.ActiveFactions) do
      if faction:HasType(type) then
        matchingFactions[#matchingFactions + 1] = faction;
      end
    end
  end

  return matchingFactions;
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
  local selectedResult = event:FindResultForScope(self, self.Type);
  if selectedResult then
    self:ApplyEventResult(event, selectedResult, currentTurn);
  end
  if #self.Districts > 0 then
    self:ApplyEventForDistrictScope(event, currentTurn);
  end

  return selectedResult;
end

function Web:ApplyEventForDistrictScope(event, currentTurn)
  local scopeResults = event:FindResultsForScope('District');
  for key, result in pairs(scopeResults) do
    for key2, district in pairs(self.Districts) do
      district:ApplyEventAndReturnResult(event, currentTurn);
      self:ApplyEventForCharacterScope(event, currentTurn, district);
    end
  end
end

function Web:ApplyEventForCharacterScope(event, currentTurn, district)
  for key, character in pairs(district.Characters) do
    character:ApplyEventAndReturnResult(event, currentTurn, self);
  end
end


function Web:ApplyEventResult(event, result, currentTurn)
  self:AddEventHistory(event.Key, result.Key, currentTurn);
end

function Web:AddEventHistory(eventKey, resultKey, currentTurn)
  self.EventHistory[#self.EventHistory + 1] = {eventKey, resultKey, currentTurn};
end