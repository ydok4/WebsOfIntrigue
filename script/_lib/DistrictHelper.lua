require 'script/_lib/CharacterHelpers'
require 'script/_lib/FactionGenerator'

require 'script/_lib/MVC/Models/District'

function CreateDistrict(RaceResources, districtName, parentWeb)
    local districtSchema = RaceResources.Districts[districtName];
    if not districtSchema then
        districtSchema = RaceResources.SpecialDistricts[districtName];
    end

    local district = District:new({
        UUID = GenerateUUID(),
        ParentWebUUID = parentWeb.UUID,
        Name = districtSchema.Name,
        SchemaKey = districtName,
        ParentName = parentWeb.Name,
        SupportedBackgrounds = {},
        Characters = {},
        ActiveFactions = {},
        EventHistory = {},
    });

    --district.Characters = CreateCharactersForDistrict(RaceResources, district);

    return district;
end