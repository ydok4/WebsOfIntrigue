  Membership = {
    FactionUUID = "",
    FactionName = "",
    Rank = 0,
    IsKnownMember = true,
    Traits = {},
  }
  
function Membership:new (o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end