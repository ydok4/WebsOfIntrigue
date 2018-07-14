LoyaltyHistory = {
  -- This is an action history object
  ActionHistory = {};
  
  -- How much the relationship between this character and the other character shifted
  ValueChange = 0,
}
  
  
function LoyaltyHistory:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
  end