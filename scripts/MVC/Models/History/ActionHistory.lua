  ActionHistory = {
    -- The position this item was inserted into the list
    OrdinalValue = 0,
    ActionUUID = "",
    Succeeded = false,
    Hidden = false,
    PlayerKnown = true
  }
  
  
function ActionHistory:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
  end