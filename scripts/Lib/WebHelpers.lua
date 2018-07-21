require 'scripts/Lib/CharacterHelpers'


function CreateWeb(RaceResources, webName)
  --  Find the web by name
  local webSchema = RaceResources.Webs[webName];
  
  local web = Web:new({
    Name = webSchema.Name,
    Population = webSchema.Population,
    SupportedBackgrounds = webSchema.SupportedBackgrounds,
    Size = webSchema.Size,
    SocialClassModifier = webSchema.SocialClassModifier,
    Characters = CreateCharactersForWeb(RaceResources, webSchema),
    ChildWebs = {},
    InternalWebs = {},
  });
      
      
  if #webSchema.ChildWebs > 0 then
    
    local webChildren = {};
    for key,value in pairs(webSchema.ChildWebs) do
      
      local childWeb = CreateWeb(RaceResources, value);
      webChildren[#webChildren + 1] = childWeb;
      
    end
    
    web.ChildWebs = webChildren;
    
  end
  
  if #webSchema.InternalWebs > 0 then
    local internalWebs = {};
    for key,value in pairs(webSchema.InternalWebs) do
      
      local internalWeb = CreateWeb(RaceResources, value);
      internalWebs[#internalWebs + 1] = internalWeb;
      
    end
    
    web.InternalWebs = internalWebs;        
  end
  
  return web;
end

