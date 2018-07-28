  Name = {
    FirstName = "",
    Surname = "",
  }
  
  
function Name:new (o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end