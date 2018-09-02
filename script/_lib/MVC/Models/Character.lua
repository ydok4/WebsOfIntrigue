  Character = {
    UUID = "",
    Name = {},
    Gender = "",
    -- List of Membership Objects
    Memberships = {},
    
    Background = "",
    Race = "",
    -- SocialClass object
    SocialClass = {},
    -- List of Career string identifiers
    Careers = {},
    Nature = "",
    
    Strength = 0,
    Influence = 0,
    Wealth = 0,
    Stealth = 0,
    
    -- List of Trait string identifiers
    Traits = {},
    -- List of Action string identifiers
    Actions = {},
    -- List of Goal string identifiers
    Goals = {},
    
    -- List of History objects
    History = {},
    -- List of History objects
    PlayerKnownHistory = {},
    EventHistory = {},
    
    -- Loyalty Object
    LoyaltyRaceLeader = {},
    -- Loyalty Object
    LoyaltyDirectOwner = {},
    -- List of loyalty objects
    LoyaltyOtherCharacters = {},
}
  
function Character:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end

function Character:GetCharacterName()
  return self.Name.FirstName.." "..self.Name.Surname;
end

function Character:HasFactionMembership(factionUUID)
  for key1, membership in pairs(self.Memberships) do
    if membership.FactionUUID == factionUUID then
      return true;
    end
  end

  return false;
end

function Character:SetName(nameObject)
  if nameObject then
    if #nameObject.TitlePrefix > 0 then
      self.Name.TitlePrefix = nameObject.TitlePrefix;
    end

    if #nameObject.FirstName > 0 then
      self.Name.FirstName = nameObject.FirstName;
    end

    if #nameObject.Surname > 0 then
      self.Name.Surname = nameObject.Surname;
    end

    if #nameObject.TitleSuffix > 0 then
      self.Name.TitleSuffix = nameObject.TitleSuffix;
    end
  end
end

function Character:ApplyEventAndReturnResult(event, currentTurn, cachedData)
  local selectedResults = event:FindResultsForScope(self, 'Character', cachedData);
  local selectedResult = GetRandomObjectFromList(selectedResults);
  if selectedResult then
    self:ApplyEventResult(event, selectedResult, currentTurn);
  end

  return selectedResult;
end

function Character:ApplyEventResult(event, result, currentTurn)
  result.ResultEffect(self);
  self:AddEventHistory(event.Key, result.Key, currentTurn);
end

function Character:AddEventHistory(eventKey, resultKey, currentTurn)
  self.EventHistory[#self.EventHistory + 1] = {eventKey, resultKey, currentTurn};
end

function Character:ChangePrimaryCharacteristic(key, value)
  self[key] = self[key] + value;
end