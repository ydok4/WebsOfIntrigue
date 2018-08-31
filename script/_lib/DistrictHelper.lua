require 'script/_lib/DataHelpers'
require 'script/_lib/CharacterHelpers'
require 'script/_lib/FactionGenerator'

require 'script/_lib/MVC/Models/District'

function CreateDistrict(RaceResources, districtName, parentWeb)
    local districtSchema = RaceResources.Districts[districtName];
    if not districtSchema then
        districtSchema = RaceResources.SpecialDistricts[districtName];
    end

    local matchingExtraFactionForDistrict = GetExtraFactionsMatchingDistrict(districtName, RaceResources, parentWeb);

    local district = District:new({
        UUID = GenerateUUID(),
        ParentWebUUID = parentWeb.UUID,
        Name = districtSchema.Name,
        ParentName = parentWeb.Name,
        SupportedBackgrounds = {},
        Characters = {},
        ActiveFactions = GenerateFactionsForDistrict(RaceResources, parentWeb, 
                                                    districtSchema, matchingExtraFactionForDistrict),
        EventHistory = {},
    });

    district.Characters = CreateCharactersForDistrict(RaceResources, district);

    return district;
end

function GetExtraFactionsMatchingDistrict(districtName, RaceResources, parentWeb)
    local relevantExtraFaction = {};
    if #parentWeb.ExtraFactions > 0 then
        for key, extraFaction in pairs(parentWeb.ExtraFactions) do
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

function GenerateFactionsForDistrict(RaceResources, web, district, matchingExtraFactionForDistrict)
    local factionList = {};
    if matchingExtraFactionForDistrict then
        for key1, extraFaction in pairs(matchingExtraFactionForDistrict) do
            local extraFactionSchema =  RaceResources.FactionTemplates[extraFaction];
            local faction = GenerateFactionForDistrict(RaceResources, district, extraFactionSchema, extraFaction, web.Name);
            factionList[#factionList + 1] = faction;
        end
    end

    for key, factionTemplate in pairs(district.FactionTemplates) do
        local factionTemplateSchema =  RaceResources.FactionTemplates[factionTemplate];
        for i = 1, factionTemplateSchema.PregeneratedAmount do
            local faction = GenerateFactionForDistrict(RaceResources, district, factionTemplateSchema, factionTemplate, web.Name);
            factionList[#factionList + 1] = faction;
        end
    end
  
    for key, specialFaction in pairs(district.SpecialFactions) do
      local faction = GenerateSpecialFactionForDistrict(RaceResources, district, specialFaction);
      factionList[#factionList + 1] = faction;
    end
  



    return factionList;
  end