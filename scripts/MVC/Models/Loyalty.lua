  Loyalty = {
    CharacterUUID = "",
    LoyaltyValue = 0,
    LoyaltyValuePlayerKnown = 0,
    -- List of LoyaltyHistory objects
    LoyaltyHistory = {},
  }
  
  
function Loyalty:new (o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end

-- Returns a string description based off of known the changes from the
-- LoyaltyHistory list
function Loyalty:Description(self)
  
end