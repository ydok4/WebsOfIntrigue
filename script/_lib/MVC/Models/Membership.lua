  Membership = {
    FactionName = "",
    -- The web where this character holds membership
    WebUUID = "",
    Rank = 0,
    IsKnownMember = true,
  }
  
  
function Membership:new (o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end