  Web = {
    Name = "",
    -- 1 to 5
    Size = 0,
    SupportedBackgrounds = {},
    SocialClassModifier = 0,
    Characters = {},
    ChildWebs = {},
    InternalWebs = {},
  }
  
  
function Web:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
  end