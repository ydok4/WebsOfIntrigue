District = {
  UUID = "",
  ParentWebUUID = "",
  Name = "",
  SchemaKey = "",
  ParentName = "",
  -- 1 to 5
  Size = 0,
  SupportedBackgrounds = {},
  Characters = {},
  ActiveFactions = {},
  EventHistory = {},
}

function District:new (o)
  o = o or {};
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function District:AddCharacters(characterList)
  for key, character in pairs(characterList) do
    self.Characters[#self.Characters + 1] = character.UUID;
  end
end

function District:ApplyEventAndReturnResult(event, currentTurn, cachedData)
  local selectedResult = event:FindResultForScope(self, 'District', cachedData);
  if selectedResult then
    self:ApplyEventResult(event, selectedResult, currentTurn);
  end

  return selectedResult;
end

function District:ApplyEventResult(event, result, currentTurn)
  self:AddEventHistory(event.Key, result.Key, currentTurn);
end

function District:AddEventHistory(eventKey, resultKey, currentTurn)
  self.EventHistory[#self.EventHistory + 1] = {EventKey = eventKey, ResultKey = resultKey, TurnNumber = currentTurn};
end