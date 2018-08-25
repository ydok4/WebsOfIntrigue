Trait = {
    Name = "",
    Key = "",
    MutuallyExclusiveTraits = {},
    StatRequirements = {},
    EventHistoryRequirements = {},
    GrantedActions = {},
    GrantedStatBonuses = {},
    EventStatBonuses = {},
}

function Trait:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end

function Trait:CanBeApplied(character)
    for key, trait in pairs(character.Traits) do
        for key2, exclusiveTrait in pairs(trait.MutuallyExclusiveTraits) do
            if self.Key == exclusiveTrait then
                return false;
            end
        end
    end

    return true;
end

function Trait:GetStatBonusesForEvent(eventKey)

end