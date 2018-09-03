DarkElfEvents = {
    Drought = {
        Key = "Drought",
        Scope = "Settlement",
        NamePool = {"SETTLEMENTNAME has unseasonally dry weather", "SETTLEMENTNAME is in drought"},
        CanApplyEvent = function(web) return AreValuesInList(web.Traits, {"FrozenClimate",}); end,
        CachedDataFunction = function(self, web, district, character)
            return {
                MatchingFactions = web:GetFactionsWithTypes({"Civilian", }),
            }
        end,
        ResultPool = {
            DroughtDefault = {
                Key = 'DroughtDefault',
                Scopes = {"Settlement", "District", "Character"},
                Priority = 0,
                CanApplyResult = function(object) return true; end,
                ResultEffect = function(object) end,
                NextEvent = {},
            },
            ProlongedDroughtCharacter = {
                Key = 'ProlongedDroughtCharacter',
                Scopes = {"Character"},
                Priority = 1,
                CanApplyResult = function(object) return Roll100(60); end,
                ResultEffect = function(character)
                    character:ChangePrimaryCharacteristic("Wealth", -5);
                end,
                NextEvent = {},
            },
            ProlongedDroughtSettlement = {
                Key = 'ProlongedDroughtSettlement',
                Scopes = {"Settlement"},
                Priority = 1,
                CanApplyResult = function(object) return Roll100(60); end,
                ResultEffect = function(object) end,
                NextEvent = {EventChainKey = "DroughtEventChain", EventKey = "Drought", TurnNumber = 1},
            },
            ExtendedDroughtResult = {
                Key = 'ExtendedDroughtResult',
                Scopes = {"Settlement",},
                Priority = 2,
                CanApplyResult = function(object) return Roll100(30); end,
                ResultEffect = function(object) end,
                NextEvent = {EventChainKey = "DroughtEventChain", EventKey = "ExtendedDrought", TurnNumber = 1},
            },
        }
    },
    ExtendedDrought = {
        Key = "ExtendedDrought",
        Scope = "Settlement",
        NamePool = {"SETTLEMENTNAME has continued unseasonally dry weather", "SETTLEMENTNAME is in extended drought"},
        CanApplyEvent = function(web) return false; end,
        CachedDataFunction = function(self, web, district, character)
            return {
                MatchingFactions = web:GetFactionsWithTypes({"Civilian", "Military"}),
            }
        end,
        ResultPool = {
            ExtendedDroughtDefault = {
                Key = 'ExtendedDroughtDefault',
                Scopes = {"Settlement", "District", "Character"},
                Priority = 0,
                CanApplyResult = function(object) return true; end,
                ResultEffect = function(object) end,
                NextEvent = {},
            },
            ExtendedDroughtLessens = {
                Key = 'DroughtLessens',
                Scopes = {"Settlement", },
                Priority = 1,
                CanApplyResult = function(web) return Roll100(40); end,
                ResultEffect = function(character) end,
                NextEvent = {},
            },
            ExtendedDroughtContinuesCharacter = {
                Key = 'ExtendedDroughtContinuesCharacter',
                Scopes = {"Character"},
                Priority = 1,
                CanApplyResult = function(object) return Roll100(60); end,
                ResultEffect = function(character)
                    character:ChangePrimaryCharacteristic("Strength", -5);
                    character:ChangePrimaryCharacteristic("Wealth", -5);
                end,
                NextEvent = {},
            },
            ExtendedDroughtContinuesSettlement = {
                Key = 'ExtendedDroughtContinuesSettlement',
                Scopes = {"Settlement"},
                Priority = 2,
                CanApplyResult = function(web) Roll100(60); end,
                ResultEffect = function(character) end,
                NextEvent = {EventChainKey = "DroughtEventChain", EventKey = "ExtendedDrought", TurnNumber = 1},
            },
            ExtremeDroughtEffects = {
                Key = 'ExtremeDroughtEffects',
                Scopes = {"Character"},
                Priority = 3,
                CanApplyResult = function(web) return Roll100(15); end,
                ResultEffect = function(character)
                    character:ChangePrimaryCharacteristic("Strength", -10);
                    character:ChangePrimaryCharacteristic("Wealth", -10);
                end,
                NextEvent = {},
            },
        }
    },
    IceStorm = {
        Key = "IceStorm",
        Scope = "Settlement",
        NamePool = {"SETTLEMENTNAME has unseasonally cold weather", "SETTLEMENTNAME is cold"},
        CanApplyEvent = function(web) return AreValuesInList(web.Traits, {"FrozenClimate",}); end,
        CachedDataFunction = function(self, web, district, character)
            return {
                MatchingFactions = web:GetFactionsWithTypes({"Military",}),
            }
        end,
        ResultPool = {
            IceStormDefault = {
                Key = 'IceStormDefault',
                Scopes = {"Settlement", "District", "Character"},
                Priority = 0,
                CanApplyResult = function(web) return true; end,
                ResultEffect = function() end,
                NextEvent = {},
            },
            IceStormWeakenedForces = {
                    Key = 'IceStormWeakenedForces',
                    Scopes = {"Character",},
                    Priority = 1,
                    ResultEffect = function(character) character:ChangePrimaryCharacteristic("Strength", -5);  end,
                    CanApplyResult = function(character, cachedData)
                        if TableHasValue(cachedData.MatchingFactions) then
                            for key, membership in pairs(character.Memberships) do
                                if membership.OrdinalRank == 0 then
                                    local faction = cachedData.MatchingFactions[membership.FactionUUID];
                                    if faction and faction:HasType("Military") then
                                        return true;
                                    end
                                end
                            end
                        end
                        return false;
                    end,
                    NextEvent = {},
            },
        },
    },
}