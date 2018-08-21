require 'script/_lib/MVC/Models/Faction'
require 'script/_lib/MVC/Models/Rank'

require 'script/_lib/DataHelpers'

function GenerateFactionForDistrict(RaceResources, district, factionTemplateSchema, factionTemplateType, webName)
    local nameOverrideObject = GenerateNameOverrideObject(RaceResources, factionTemplateSchema);
    return Faction:new({
        UUID = GenerateUUID(),
        ParentWebUUID = district.UUID,
        TemplateType = factionTemplateType,
        Name = GenerateFactionName(RaceResources, factionTemplateSchema, webName, nameOverrideObject),
        GrantedNameOverride = nameOverrideObject,
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
        GrantedNameOverride = GenerateNameOverrideObject(factionTemplateSchema),
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

function GenerateFactionName(RaceResources, factionTemplate, webName, nameOverrideObject)
    local name = factionTemplate.NamePool[Random(#factionTemplate.NamePool)];

    if string.match(name, "WEBNAME") then
        name = name:gsub("WEBNAME", webName);
    end
    
    if string.match(name, "SURNAME") then
        local surname = "";
        if nameOverrideObject.Surname then
            surname = nameOverrideObject.Surname;
        else
            surname = GetRandomSurname(RaceResources.Names, "Both");
        end
        name = name:gsub("SURNAME", surname);
    end
    return name;
end

function GenerateNameOverrideObject(RaceResources, factionTemplate)
    if factionTemplate.GrantedNameOverride then
        local firstName = factionTemplate.GrantedNameOverride.FirstName;
        local surname = factionTemplate.GrantedNameOverride.Surname;

        if factionTemplate.GrantedNameOverride.FirstName 
        and string.match(factionTemplate.GrantedNameOverride.FirstName, "RANDOM") then
            firstName = GetRandomFirstName(RaceResources.Names, "Both");
        end

        if factionTemplate.GrantedNameOverride.Surname 
        and string.match(factionTemplate.GrantedNameOverride.Surname, "RANDOM") then
            surname = GetRandomSurname(RaceResources.Names, "Both");
        end

        return Name:new({
            TitlePrefix = factionTemplate.GrantedNameOverride.TitlePrefix,
            FirstName = firstName,
            Surname = surname,
            TitleSuffix = factionTemplate.GrantedNameOverride.TitleSuffix,
        });
    else
        return nil;
    end
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
        UseCharacterOverride = rankData.UseCharacterOverride,
    });
end

function GenerateFactionTraits(factionTemplate)

end

function GenerateFactionGoals(factionTemplate)

end

function GenerateFactionActions(factionTemplate)

end
