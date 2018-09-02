DarkElfEvents = {
    IceStorm = {
        Key = "IceStorm",
        Scope = "Settlement",
        NamePool = {"SETTLEMENTNAME has unseasonal cold weather", "SETTLEMENTNAME is cold"},
        CanApplyEvent = function(web) return AreValuesInList(web.Traits, {"FrozenClimate",}); end,
        CachedDataFunction = function(self, web, district, character)
            return {
                MatchingFactions = web:GetFactionsWithType("Military"),
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
                        if TableLength(cachedData.MatchingFactions) > 0 then
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