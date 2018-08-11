require 'script/_lib/WebHelpers'
require 'script/_lib/Resources/Shared/Webs/WebHierarchy'

local politicalWebData = {}; -- : TABLE

local politicalWebFrame = nil; -- : FRAME
local politicalWebContainer = nil; -- : CONTAINER

function CreateWebFrame(webData)
  politicalWebData = webData;
  Custom_Log("Clicked web button");
  -- If the frame exists don't make a new one
  local existingFrame = Util.getComponentWithName("politicalWebFrame");
  if existingFrame then
    Custom_Log("Found old frame...deleting");
    existingFrame:Delete();
  end
  Custom_Log("Creating new frame");
  -- Make the frame
  politicalWebFrame = Frame.new("politicalWebFrame");
  politicalWebFrame:SetTitle("Political Web");
  
  local xRes, yRes = core:get_screen_resolution();
  politicalWebFrame:Resize(politicalWebFrame:Width() * 1.3 + 200, yRes - 200);
  Util.centreComponentOnScreen(politicalWebFrame);
  
  -- Delete all existing components before recreating
  if politicalWebContainer then
    Custom_Log("Found old components...deleting");
    politicalWebContainer:Clear();
  end
  
  Custom_Log("Before creating components");
  CreateComponentsForWebType({"Province",});
  politicalWebFrame:AddComponent(politicalWebContainer);
  
  Util.centreComponentOnComponent(politicalWebContainer, politicalWebFrame);
  politicalWebFrame.uic:PropagatePriority(100);
  politicalWebFrame:AddCloseButton();
  Custom_Log("Clicked web button");
  
  return politicalWebFrame;
end

function CreateComponentsForWebDistricts(webUUID)
  
end

function CreateComponentsForWebDistrictCharacters(webUUID, districtName)
  
end

function CreateComponentsForWebType(webTypes, webUUID)
  
  if not politicalWebContainer then
    politicalWebContainer = Container.new(FlowLayout.VERTICAL);
  end
  
  for key, webType in pairs(webTypes) do
    Custom_Log("Creating components for webType: "..webType);
    local dataForType = GetDataForType(webType, politicalWebData, webUUID);
    Custom_Log("Finished grabbing data");
    if dataForType then 
      for key, data in pairs(dataForType) do
        local componentName = data.Name;
        if webType == "Character" then
          componentName = data:GetCharacterName();
        end
        local existingComponent = Util.getComponentWithName(componentName..webType);
        if existingComponent then
          existingComponent:Delete();
        end
        Custom_Log("Adding text: "..componentName);
        local individualWebContainer = Container.new(FlowLayout.HORIZONTAL);
        
        local nextWebTypes = GetNextWebType(webType, WebHierarchy);
        Custom_Log("Grabbed next web type");
        if nextWebTypes then
          if AreValuesInList(nextWebTypes, {"District"}) then
            Custom_Log("Getting district text");
            individualWebContainer:AddComponent(Text.new(componentName..webType, politicalWebFrame, "NORMAL", componentName));
            individualWebContainer:AddComponent(CreateViewDistrictsButton(componentName, webType, data.UUID));
          elseif AreValuesInList(nextWebTypes, {"Character"}) then
            Custom_Log("Getting character text: "..key);
            individualWebContainer:AddComponent(Text.new(key..componentName..webType, politicalWebFrame, "NORMAL", componentName));
            individualWebContainer:AddComponent(CreateViewCharactersButton(key..componentName, webType, data.UUID));
          elseif AreValuesInList(nextWebTypes, {"CharacterDetails"}) then
            Custom_Log("Adding character details text");
            individualWebContainer:AddComponent(Text.new(key..componentName..webType.."Text", politicalWebFrame, "NORMAL", componentName));
          elseif webType ~= "Character" then
            Custom_Log("Getting web text");
            individualWebContainer:AddComponent(Text.new(componentName..webType, politicalWebFrame, "NORMAL", componentName));
            individualWebContainer:AddComponent(CreateNextWebLevelButton(componentName, webType, data.UUID));
          end
        else
          individualWebContainer:AddComponent(Text.new(key..componentName..webType.."Text", politicalWebFrame, "NORMAL", componentName));
        end
        
        politicalWebContainer:AddComponent(individualWebContainer);
      end
    else
      Custom_Log("No data found for: "..webType);
    end
  end  
  Custom_Log("\n\nFinished building container\n\n");
  return politicalWebContainer;
end

function CreateViewDistrictsButton(name, webType, UUID)
  local viewDistrictsButton = Button.new(name.."ViewDistrictsButton", politicalWebFrame, "CIRCULAR",  "ui/skins/default/icon_end_turn.png");
  
  viewDistrictsButton:RegisterForClick(
    function(context)
      CreateAndShowComponentsForWebType(webType, name, UUID);
    end
  );

  return viewDistrictsButton;
end

function CreateViewCharactersButton(name, webType, UUID)
  local viewCharactersButton = Button.new(name.."ViewCharacterButton", politicalWebFrame, "CIRCULAR",  "ui/skins/default/icon_end_turn.png");
  
  viewCharactersButton:RegisterForClick(
    function(context)
      CreateAndShowComponentsForWebType(webType, name, UUID);
    end
  );

  return viewCharactersButton;
end

function CreateNextWebLevelButton(name, webType, UUID)
  local viewNextLevelWebButton = Button.new(name.."ViewChildWebButton", politicalWebFrame, "CIRCULAR",  "ui/skins/default/icon_end_turn.png");
  
  viewNextLevelWebButton:RegisterForClick(
    function(context)
      CreateAndShowComponentsForWebType(webType, name, UUID);
    end
  );

  return viewNextLevelWebButton;
end

function CreateAndShowComponentsForWebType(webType, name, UUID)
  local nextWebTypes = GetNextWebType(webType, WebHierarchy);
  
  politicalWebContainer:Clear();
  CreateComponentsForWebType(nextWebTypes, UUID);
  politicalWebFrame:AddComponent(politicalWebContainer);

  Util.centreComponentOnComponent(politicalWebContainer, politicalWebFrame);
end