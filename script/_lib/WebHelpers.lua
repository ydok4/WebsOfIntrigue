require 'script/_lib/CharacterHelpers'


function CreateWeb(RaceResources, webName, parentName, parentUUID)
  --  Find the web by name
  local webSchema = RaceResources.Webs[webName];
  
  local web = Web:new({
    UUID = GenerateUUID(),
    ParentUUID = parentUUID,
    Name = webSchema.Name,
    ParentName = parentName,
    Population = webSchema.Population,
    SupportedBackgrounds = webSchema.SupportedBackgrounds,
    Size = webSchema.Size,
    SocialClassModifier = webSchema.SocialClassModifier,
    Characters = CreateCharactersForWeb(RaceResources, webSchema),
    ChildWebs = {},
    InternalWebs = {},
    Type = webSchema.Type,
  });
      
      
  if #webSchema.ChildWebs > 0 then
    
    local webChildren = {};
    for key,value in pairs(webSchema.ChildWebs) do
      
      local childWeb = CreateWeb(RaceResources, value, web.Name, web.UUID);
      webChildren[#webChildren + 1] = childWeb;
      
    end
    
    web.ChildWebs = webChildren;
    
  end
  
  if #webSchema.InternalWebs > 0 then
    local internalWebs = {};
    for key,value in pairs(webSchema.InternalWebs) do
      
      local internalWeb = CreateWeb(RaceResources, value, web.Name, web.UUID);
      internalWebs[#internalWebs + 1] = internalWeb;
      
    end
    
    web.InternalWebs = internalWebs;        
  end
  
  return web;
end

function GetWebText(webType, webData)
  if not webData then
    Custom_Log("ERROR: No Web data");
    return {};
  end
  webText = {};
  for key,web in pairs(webData) do
    --Custom_Log(web.Name);
    if web.Type == webType then
      webText[#webText + 1] = web.Name;
    end
    GetChildWebNameFromWeb(web, webType, webText);
  end
  
  return webText;
end

function GetChildWebNameFromWeb(web, webType, webText)
  if not web then
    return;
  end
  for key, childWeb in pairs(web.ChildWebs) do
    --Custom_Log(childWeb.Name);
    if childWeb.Type == webType then
      webText[#webText + 1] = childWeb.Name;
    end
    GetChildWebNameFromWeb(childWeb, webType, webText);
  end
end