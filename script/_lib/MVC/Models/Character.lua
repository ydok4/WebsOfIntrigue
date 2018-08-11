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