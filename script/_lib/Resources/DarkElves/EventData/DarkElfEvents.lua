DarkElfEvents = {
    IceStorm = {
        Key = "IceStorm",
        Scope = "Settlement",
        NamePool = {"SETTLEMENTNAME has unseasonal cold weather", "SETTLEMENTNAME is cold"},
        CanApplyEvent = function(web) return AreValuesInList(web.Traits, {"FrozenClimate",}); end,
        ResultPool = {
            SettlementIceStorm = {
                Key = 'SettlementIceStorm',
                Scope = "Settlement",
                CanApplyResult = function(web) return true; end,
                ResultEffect = function() end,
                NextEvent = {},
            },
            DistrictIceStorm = {
                Key = 'DistrictIceStorm',
                Scope = "District",
                CanApplyResult = function(district) return true; end,
                ResultEffect = function() end,
                NextEvent = {},
            },
            CharacterIceStorm = {
                Key = 'CharacterIceStorm',
                Scope = "Character",
                CanApplyResult = function(character) return true; end,
                ResultEffect = function() end,
                Priority = 1,
                NextEvent = {},
            },
            WeakenedForces = {
                    Key = 'WeakenedForces',
                    Scope = "Character",
                    Priority = 0,
                    ResultEffect = function(character) character:ChangePrimaryCharacteristic("Strength", -5);  end,
                    CachedDataFunction = function(web, district, character)
                        return {
                            matchingFactions = web:GetFactionsWithType("Military"),
                        }
                    end,
                    CanApplyResult = function(character, cachedData)
                        for key, faction in pairs(cachedData.matchingFactions) do
                            local rank = faction:GetCharacterRank(character);
                            if rank and  rank.Ordinal == 0 then
                                return true;
                            end
                        end
                        return false;
                    end,
                    NextEvent = {},
            },
        },
    },
}