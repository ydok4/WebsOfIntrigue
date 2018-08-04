  Action = {
    ActionName = "",
    ActionRequirements =  function(self, owner, target) end,
    ActionFunction = function(self, owner, target) end,
    ActionSucceededFunction = function(self, owner, target) end,
    ActionFailedFunction = function(self, owner, target) end,
    
    ActionDescriptionFunction = function(self, owner, target) end,
  }
  
  
function Action:new (o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end