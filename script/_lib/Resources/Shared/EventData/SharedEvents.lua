SharedEvents = {
    CharacterJoinedFaction = {
        Key = "CharacterJoinedFaction",
        Scope = "Character",
        Type = "Settlement",
        Priority = 1,
        ScopeLimits = {
            Districts = 1,
            Characters = 1,
        },
        NamePool = {"CHARACTERNAME has been joined FACTIONAME",},
        CanApplyEvent = function() return true; end,
        CachedDataFunction = function()
            return {};
        end,
        ResultPool = {
            CharacterJoinsFactionDefault = {
                Key = 'CharacterJoinsFactionDefault',
                Scopes = {"Character",},
                Priority = 0,
                CanApplyResult = function() return true; end,
                ResultEffect = function() end,
                NextEvent = {},
            },
        },
    },
}