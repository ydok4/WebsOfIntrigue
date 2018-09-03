require 'script/_lib/DistrictHelper'

function CreateWeb(RaceResources, webName, parentName, parentUUID)
  --  Find the web by name
  local webSchema = RaceResources.Webs[webName];
  
  local uuid = "";
  if webSchema.UUID then
    uuid = webSchema.UUID;
  else
    uuid = GenerateUUID();
  end
  
  local web = Web:new({
    UUID = uuid,
    ParentUUID = parentUUID,
    Name = webSchema.Name,
    ParentName = parentName,
    Population = webSchema.Population,
    SupportedBackgrounds = webSchema.SupportedBackgrounds,
    Size = webSchema.Size,
    SocialClassModifier = webSchema.SocialClassModifier,
    ChildWebs = {},
    Districts = webSchema.Districts,
    ExtraFactions = webSchema.ExtraFactions,
    Type = webSchema.Type,
    Traits = webSchema.Traits,
    EventHistory = {},
    ActiveEventChains = {},
    CompletedEventChains = {},
  });
      
  if #webSchema.ChildWebs > 0 then
    local webChildren = {};
    for key,value in pairs(webSchema.ChildWebs) do
      local childWeb = CreateWeb(RaceResources, value, web.Name, web.UUID);
      webChildren[#webChildren + 1] = childWeb;
    end
    
    web.ChildWebs = webChildren;
  end
  
  if #webSchema.Districts > 0 then
    local Districts = {};
    for key,value in pairs(webSchema.Districts) do
      local district = CreateDistrict(RaceResources, value, web);
      Districts[#Districts + 1] = district;
    end
    web.Districts = Districts;
  end
  
  return web;
end

function GetDataForType(webType, webData, webUUID)
  if not webData then
    Custom_Log("ERROR: No Web data");
    return {};
  end
  data = {};
  
  if webType == "District" then
    Custom_Log("Grabbing districts");
    data = GetDistrictsForWeb(webUUID, webData);
  elseif webType == "Character" then
    Custom_Log("Grabbing characters: "..webUUID);
    data = GetCharactersForWeb(webUUID, webData);
  else
    Custom_Log("Grabbing web names");
    data = GetWebByType(webData, webType);
  end
  Custom_Log("Finished grabbing text ");
  return data;
end

function GetWebByUUID(webUUID, webData)
  local foundWeb = {};
  for key, web in pairs(webData) do
    if web.UUID == webUUID then
      foundWeb = web;
    end
    local webResult = SearchChildWebs(webUUID, web);
    if webResult then
      foundWeb = webResult;
      break;
    end
  end
  
  return foundWeb;
end

function SearchChildWebs(webUUID, web)
  if not web then
    return;
  end
  for key, childWeb in pairs(web.ChildWebs) do
    if childWeb.UUID == webUUID then
      return childWeb;
    end
    foundWeb = SearchChildWebs(webUUID, childWeb);
    if foundWeb then
      return foundWeb;
    else
      return SearchDistricts(webUUID, childWeb);
    end
  end
end

function SearchDistricts(webUUID, web)
  local foundWeb = {};
  for key, internalWeb in pairs(web.Districts) do
    if internalWeb.UUID == webUUID then
      return internalWeb;
    end
    
    foundWeb = SearchDistricts(webUUID, internalWeb);
    if foundWeb then
      return foundWeb;
    end
  end
end
    

function GetDistrictsForWeb(webUUID, webData)
  local foundWeb = GetWebByUUID(webUUID, webData);
  return foundWeb.Districts;
end

function GetDistrictsFromWeb(web)
  local Districts = {};
  for key, internalWeb in pairs(web.Districts) do
    Districts[#Districts + 1] = internalWeb;
  end
  
  return Districts;
end

function GetCharactersForWeb(webUUID, webData)
  local foundWeb = GetWebByUUID(webUUID, webData);
  return GetCharactersFromInternalWeb(foundWeb);
end

function GetCharactersFromInternalWeb(web)
  local characters = {};
  for key, character in pairs(web.Characters) do
    characters[#characters + 1] = character;
  end
  
  return characters;
end

function GetWebByType(webData, webType)
  local webs = {};
  
  for key, web in pairs(webData) do
    if web.Type == webType then
      webs[#webs + 1] = web;
    end
    SearchChildWebsForNameWhichMatchesWebType(web, webType, webs);
  end
  
  return webs;
end

function SearchChildWebsForNameWhichMatchesWebType(web, webType, webs)
  if not web then
    return;
  end
  for key, childWeb in pairs(web.ChildWebs) do
    if childWeb.Type == webType then
      webs[#webs + 1] = childWeb;
    end
    SearchChildWebsForNameWhichMatchesWebType(childWeb, webType, webs);
  end
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