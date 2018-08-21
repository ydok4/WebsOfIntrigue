require 'script/_lib/MVC/Models/Faction'
require 'script/_lib/MVC/Models/Rank'

require 'script/_lib/DataHelpers'

function GenerateFactionForDistrict(RaceResources, district, factionTemplateSchema, factionTemplateType, webName)
    return Faction:new({
        UUID = GenerateUUID(),
        ParentWebUUID = district.UUID,
        TemplateType = factionTemplateType,
        Name = GenerateFactionName(RaceResources, factionTemplateSchema, webName),
        ParentName = district.Name,
        Ranks = GenerateFactionRanks(factionTemplateSchema),
        SupportedBackgrounds = factionTemplateSchema.SupportedBackgrounds,
        SocialClassModifier = factionTemplateSchema.SocialClassModifier,
        MemberCharacters = {},
        Traits = GenerateFactionTraits(factionTemplateSchema),
        Goals =  GenerateFactionGoals(factionTemplateSchema),
        Actions = GenerateFactionActions(factionTemplateSchema),
    });
end

function GenerateSpecialFactionForDistrict(RaceResources, district, specialFaction)
    local specialFactionSchema =  RaceResources.SpecialFactions[specialFaction];

    return Faction:new({
        UUID = GenerateUUID(),
        ParentWebUUID = district.UUID,
        Name = specialFactionSchema.Name,
        ParentName = district.Name,
        Ranks = GenerateFactionRanks(specialFactionSchema),
        SupportedBackgrounds = specialFactionSchema.SupportedBackgrounds,
        SocialClassModifier = specialFactionSchema.SocialClassModifier,
        MemberCharacters = {},
        Traits = GenerateFactionTraits(specialFactionSchema),
        Goals =  GenerateFactionGoals(specialFactionSchema),
        Actions = GenerateFactionActions(specialFactionSchema),
    });
end

function GenerateFactionName(RaceResources, factionTemplate, webName)
    local name = factionTemplate.NamePool[Random(#factionTemplate.NamePool)];
    local surname = GetRandomSurname(RaceResources.Names, "Both");

    name = name:gsub("WEBNAME", webName);
    name = name:gsub("SURNAME", surname);
    return name;
end

function GenerateFactionRanks(factionTemplate)
    local ranks = {};
    for key, rankData in pairs(factionTemplate.Ranks) do
        local rank = GenerateRank(rankData);
        ranks[#ranks + 1] = rank;
    end
    return ranks;
end

function GenerateRank(rankData)

    return Rank:new({
        Name = rankData.Name,
        AdditionalMemberships = rankData.AdditionalMemberships,
        Careers = rankData.Careers,
        Limit = rankData.Limit,
        Ordinal = rankData.Ordinal,
        StealthValue = rankData.StealthValue,
        CharacterUUIDs = {},
        Gender = rankData.Gender,
    });
end

function GenerateFactionTraits(factionTemplate)

end

function GenerateFactionGoals(factionTemplate)

end

function GenerateFactionActions(factionTemplate)

end
