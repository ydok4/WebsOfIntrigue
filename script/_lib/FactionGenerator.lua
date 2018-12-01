require 'script/_lib/MVC/Models/Faction'
require 'script/_lib/MVC/Models/Rank'

local RaceResources = {};

function InitialiseFactionGeneratorForRace(raceResources)
    RaceResources = raceResources;
end

function ClearRaceResourcesForFactionGenerator()
    RaceResources = {};
end

function GenerateFactionForDistrict(district, factionTemplateSchema, factionTemplateType, webName)
    local nameOverrideObject = GenerateNameOverrideObject(factionTemplateSchema);
    return Faction:new({
        UUID = GenerateUUID(),
        -- SchemaKey = factionTemplateSchema.Key,
        ParentWebUUID = district.UUID,
        TemplateType = factionTemplateType,
        Name = GenerateFactionName(factionTemplateSchema, webName, nameOverrideObject),
        GrantedNameOverride = nameOverrideObject,
        ParentName = district.Name,
        Ranks = GenerateFactionRanks(factionTemplateSchema),
        SupportedBackgrounds = factionTemplateSchema.SupportedBackgrounds,
        SocialClassModifier = factionTemplateSchema.SocialClassModifier,
        MemberCharacters = {},
        Traits = GenerateFactionTraits(factionTemplateSchema),
        Types = factionTemplateSchema.Types,
        Goals =  GenerateFactionGoals(factionTemplateSchema),
        Actions = GenerateFactionActions(factionTemplateSchema),
    });
end

function GenerateSpecialFactionForDistrict(district, specialFaction)
    local specialFactionSchema =  RaceResources.SpecialFactions[specialFaction];

    return Faction:new({
        UUID = GenerateUUID(),
        -- SchemaKey = specialFactionSchema.Key,
        ParentWebUUID = district.UUID,
        Name = specialFactionSchema.Name,
        GrantedNameOverride = GenerateNameOverrideObject(specialFactionSchema),
        ParentName = district.Name,
        Ranks = GenerateFactionRanks(specialFactionSchema),
        SupportedBackgrounds = specialFactionSchema.SupportedBackgrounds,
        SocialClassModifier = specialFactionSchema.SocialClassModifier,
        MemberCharacters = {},
        Traits = GenerateFactionTraits(specialFactionSchema),
        Types = specialFactionSchema.Types,
        Goals =  GenerateFactionGoals(specialFactionSchema),
        Actions = GenerateFactionActions(specialFactionSchema),
    });
end

function GenerateFactionName(factionTemplate, webName, nameOverrideObject)
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

    name = ReplaceNamePoolDataByKeyword(name);

    return name;
end

function GenerateNameOverrideObject(factionTemplate)
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

function ReplaceNamePoolDataByKeyword(name)
    for key, namePool in pairs(RaceResources.FactionNamePools) do
        if string.match(name, key) then
            local randomNameFromPool = namePool[Random(#namePool)];
            name = name:gsub(key, randomNameFromPool);
        end
    end

    return name;
end

function GenerateFactionRanks(factionTemplate)
    local ranks = {};
    for key, rankData in pairs(factionTemplate.Ranks) do
        local uuid = GenerateUUID();
        local rank = GenerateRank(rankData, uuid);
        ranks[uuid] = rank;
    end
    return ranks;
end

function GenerateRank(rankData, uuid)

    return Rank:new({
        UUID = uuid,
        Name = rankData.Name,
        AdditionalMemberships = rankData.AdditionalMemberships,
        Careers = rankData.Careers,
        Limit = rankData.Limit,
        Ordinal = rankData.Ordinal,
        StealthValue = rankData.StealthValue,
        CharacterUUIDs = {},
        Gender = rankData.Gender,
        UseNameOverride = rankData.UseNameOverride,
        Traits = rankData.Traits,
    });
end

function GenerateFactionTraits(factionTemplate)
    local selectedTraits = {};
    for key, trait in pairs(factionTemplate.Traits) do
        if Roll100(trait.FactionAppearanceChance) then
            selectedTraits[#selectedTraits + 1] = trait;
        end
    end

    return selectedTraits;
end

function GenerateFactionGoals(factionTemplate)

end

function GenerateFactionActions(factionTemplate)

end
