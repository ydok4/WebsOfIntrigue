woi = _G.woi;

require 'script/_lib/DistrictHelper'

require 'script/_lib/MVC/Models/Web'

local RaceResources = {};
local createdWebs = {};

function CreateWebsForRace(raceResources, rootName, rootUUID)
  Custom_Log("Creating Webs for race initialisation");
  createdWebs = {};
  RaceResources = raceResources;
  if not RaceResources or not RaceResources["Webs"] then
    Custom_Log("ERROR: Race Resources not loaded");
    return createdWebs;
  end
  local root = CreateWeb(rootName, rootUUID);
  createdWebs[root.UUID] = root;
  RaceResources = {};
  return createdWebs;
end

function CreateWeb(webGameKey, webUUID, parentName, parentUUID)
  --  Find the web by name
  local webSchema = RaceResources.Webs[webGameKey];
  local uuid = webUUID;
  if uuid == nil then
   uuid = GetWebUUIDByNameIfAvailable(webGameKey, webUUID);
  end

  local web = Web:new({
    UUID = uuid,
    GameKey = webGameKey,
    ParentUUID = parentUUID,
    Name = webSchema.Name,
    ParentName = parentName,
    Population = webSchema.Population,
    SupportedBackgrounds = webSchema.SupportedBackgrounds,
    Size = webSchema.Size,
    SocialClassModifier = webSchema.SocialClassModifier,
    ChildWebs = {},
    Districts = webSchema.Districts,
    --ExtraFactions = webSchema.ExtraFactions,
    Type = webSchema.Type,
    Traits = webSchema.Traits,
    EventHistory = {},
    ActiveEventChains = {},
    CompletedEventChains = {},
  });

  if #webSchema.ChildWebs > 0 then
    local webChildren = {};
    for key, value in pairs(webSchema.ChildWebs) do
      local childUUID = GetWebUUIDByNameIfAvailable(value, nil);
      Custom_Log("Creating Child web: "..value);
      createdWebs[childUUID] = CreateWeb(value, childUUID, web.Name, web.UUID);
      webChildren[#webChildren + 1] = childUUID;
    end

    web.ChildWebs = webChildren;
  end

  if #webSchema.Districts > 0 then
    local Districts = {};
    for key, value in pairs(webSchema.Districts) do
      local district = CreateDistrict(RaceResources, value, web);
      Districts[district.UUID] = district.UUID;
      woi:AddDistrict(district);
    end
    web.Districts = Districts;
  end

  return web;
end

function GetWebUUIDByNameIfAvailable(webName, webUUID)
  if not RaceResources or not RaceResources["Webs"] then
    return GenerateUUID();
  end

  --  Find the web by name
  local webSchema = RaceResources.Webs[webName];
  local uuid = webUUID;
  if webSchema.UUID then
    Custom_Log("Specified UUID");
    uuid = webSchema.UUID;
  elseif webUUID == nil then
    Custom_Log("Random UUID");
    uuid = GenerateUUID();
  end

  return uuid;
end

function GetDataForType(webType, UUID)
  data = {};

  if webType == "District" then
    Custom_Log("Grabbing districts");
    data = woi:GetDistrictsForWeb(UUID);
  elseif webType == "Character" then
    Custom_Log("Grabbing characters: "..UUID);
    data = woi:GetCharactersForDistrict(UUID);
  else
    Custom_Log("Grabbing web names");
    data = woi:GetWebsForType(webType);
  end
  Custom_Log("Finished grabbing text ");
  return data;
end

function GetNextWebType(currentWebType, webHierarchy)
  local hierarchyData = webHierarchy[currentWebType];
  if hierarchyData then
    local currentWebTypeOrder = webHierarchy[currentWebType].Order;

    local nextLevels = {};
    for key, value in pairs(webHierarchy) do
      if value.Order == currentWebTypeOrder + 1 then
        nextLevels[#nextLevels] = value.Type;
      end
    end

    return nextLevels;
  end
end