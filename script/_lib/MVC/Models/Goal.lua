Goal = {
    UUID = "",
    ParentWebUUID = "",
    Name = "",
    SchemaKey = "",
    ParentName = "",
    -- 1 to 5
    Size = 0,
    SupportedBackgrounds = {},
    Characters = {},
    ActiveFactions = {},
    EventHistory = {},
}

function Goal:new (o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    return o;
end