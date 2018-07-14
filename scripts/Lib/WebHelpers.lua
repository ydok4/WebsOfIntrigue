require 'scripts/Lib/CharacterHelpers'


function CreateWeb(RaceResources, webName)
  --  Find the web by name
  local webSchema = FindFirstDataInTable(RaceResources.Webs, 'Name', {webName});
  
  local web = Web:new({
    Name = webSchema.Name,
    Size = webSchema.Size,
    SupportedBackgrounds = webSchema.SupportedBackgrounds,
    Size = webSchema.Size,
    
    Characters = CreateCharactersForWeb(RaceResources, webSchema),
    Children = {},
  });
      
      
  if #webSchema.Children > 0 then
    
    local webChildren = {};
    for key,value in pairs(webSchema.Children) do
      
      local childWeb = CreateWeb(RaceResources, value);
      webChildren[#webChildren + 1] = childWeb;
      
    end
    
    web.Children = webChildren;
    return web;
    
  end
  
  return web;
end