District = {
    UUID = "",
    ParentWebUUID = "",
    Name = "",
    ParentName = "",
    -- 1 to 5
    Size = 0,
    SupportedBackgrounds = {},
    Characters = {},
    ActiveFactions = {},
    EventHistory = {},
  }
  
function District:new (o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
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
  self.EventHistory[#self.EventHistory + 1] = {eventKey, resultKey, currentTurn};
end