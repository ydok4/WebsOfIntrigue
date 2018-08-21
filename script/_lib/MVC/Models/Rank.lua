Rank = {
    Name = "",
    Careers = {},
    Limit = 0,
    Ordinal = 0,
    StealthValue = 0,
    CharacterUUIDs = {},
    Gender = "",
}
  
function Rank:new (o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end