woi = _G.woi;

require 'script/_lib/CharacterHelpers'
require 'script/_lib/FactionGenerator'

local RaceResources = {};

function CreateFactionsForRace(raceResources, raceIdentifier)
    RaceResources = raceResources;
    InitialiseFactionGeneratorForRace(raceResources);

    local raceRootWeb = woi:GetRootWebForRace(raceIdentifier);
    for webKey, webUUID in pairs(raceRootWeb.ChildWebs) do
        local web = woi:GetWebByUUID(webUUID);
        CreateFactionsForWeb(web);
    end

    RaceResources = {};
    ClearRaceResourcesForFactionGenerator();
end

function CreateFactionsForWeb(web)
    if web.ChildWebs then
        for index, webUUID in pairs(web.ChildWebs) do
            local childWeb = woi:GetWebByUUID(webUUID);
            CreateFactionsForWeb(childWeb);
        end
    end
    -- Once we hit the end of the web children start generating factions
    for key, districtUUID in pairs(web.Districts) do
        local district = woi:GetDistrictByUUID(districtUUID);
        local extraFactions = GetExtraFactionsMatchingDistrict(district.SchemaKey, web);
        local districtFactions = GenerateFactionsForDistrict(web, district, extraFactions);
        woi:AddFactions(districtFactions);
    end
end

function GetExtraFactionsMatchingDistrict(districtName, parentWeb)
    local relevantExtraFaction = {};
    local parentWebSchema = RaceResources.Webs[parentWeb.GameKey];
    if #parentWebSchema.ExtraFactions > 0 then
        for key, extraFaction in pairs(parentWebSchema.ExtraFactions) do
            local factionSchema = RaceResources.FactionTemplates[extraFaction];
            if not factionSchema then
                factionSchema = RaceResources.SpecialFactions[extraFaction];
            end

            if factionSchema.RelatedDistrict == districtName then
                relevantExtraFaction[#relevantExtraFaction + 1] = extraFaction;
            end
        end
    end

    return relevantExtraFaction;
end

function GenerateFactionsForDistrict(web, district, extraFactions)
    local factionList = {};
    local districtSchema = RaceResources.Districts[district.SchemaKey];
    if extraFactions then
        for key1, extraFaction in pairs(extraFactions) do
            local extraFactionSchema =  RaceResources.FactionTemplates[extraFaction];
            local faction = GenerateFactionForDistrict(district, extraFactionSchema, extraFaction, web.Name);
            factionList[#factionList + 1] = faction;
            district.ActiveFactions[#district.ActiveFactions + 1] = faction.UUID;
        end
    end

    for key, factionTemplate in pairs(districtSchema.FactionTemplates) do
        local factionTemplateSchema =  RaceResources.FactionTemplates[factionTemplate];
        for i = 1, factionTemplateSchema.PregeneratedAmount do
            local faction = GenerateFactionForDistrict(district, factionTemplateSchema, factionTemplate, web.Name);
            factionList[#factionList + 1] = faction;
            district.ActiveFactions[#district.ActiveFactions + 1] = faction.UUID;
        end
    end

    for key, specialFaction in pairs(districtSchema.SpecialFactions) do
      local faction = GenerateSpecialFactionForDistrict(district, specialFaction);
      factionList[#factionList + 1] = faction;
      district.ActiveFactions[#district.ActiveFactions + 1] = faction.UUID;
    end

    return factionList;
end