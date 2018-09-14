DarkElfGoals = {
    BecomeAManorOwner = {
        Type = "JoinFaction",
        GoalPaths = {
            BecomeRich = {
                NumberOfTurns = 20,
                CharacteristicRequirements = {
                    Wealth = 80,
                },
                EventRequirements = {},
                ValidActionTraits = {"IncreasesWealth", },
                IsValidGoalPath = function(character) return character:HasCareer("Noble") == false; end,
                GoalResult = function(character)
                    local settlement = IntrigueManager:GetSettlementFromCharacter(character);
                    local district = IntrigueManager:GetDistrictFromSettlementByKey(settlement, "NobleDistrict");
                    local faction = GenerateFactionForDistrict(district, factionTemplateSchema, "NobilityFaction", settlement.Name);
                    IntrigueManager:AddFactions({faction});
                    local genderRank = "";
                    if character.Gender == "Male" then
                        genderRank = "Patriarch";
                    else
                        genderRank = "Matriarch";
                    end
                    IntrigueManager:CharacterJoinsFaction(character, faction, genderRank);
                end,
                NextGoalPools = {},
            },
            InheritManor = {
                NumberOfTurns = 0,
                CharacteristicRequirements = {},
                EventRequirements = {"FamilyLeaderRemoved", },
                RequriedActionTraits = {"RemoveFamilyLeader", },
                IsValidGoalPath = function(character) return character:HasCareer("Noble"); end,
                GoalResult = function(character)
                    local faction = character:GetFactionFromTemplateType("NobilityFaction");
                    local rank = faction:GetOrdinalRank(0, character.Gender);
                    faction:SetCharacterAsRank(character, rank);
                end,
                NextGoalPools = {},
            },
        },
    },
    AdvanceToResidenceOwner = {
        Type = "AdvanceRank",
    },
    JoinMilitary = {
        NumberOfTurns = 10,

    },
    KillCharacter = {
        Type = "KillCharacter",
    },
    StealWealth = {
        Type = "StealCharacteristic",
    },
    ReduceWealth = {
        Type = "ReduceCharacteristic",
    },
    BecomeANoble = {

    },
    BecomeMemberOfMajorCityGovernmentFaction = {

    },
    AdvanceToVaulkhar = {

    },
    AdvanceToDrachau = {

    },
}