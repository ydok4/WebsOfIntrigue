require 'script/_lib/CustomLog'
require 'script/_lib/MVC/Views/WebFrame'

local politicalWebFrame = nil --: FRAME
local politicalWebButton = nil; --: BUTTON
local continentsContainer = nil; --: CONTAINER

local politicalWebText = {}; -- : TEXT
 
local politicalWebData = nil; 
 
 function InitialiseUIListeners(webs)
  politicalWebData = webs;
   
  local topBar = find_uicomponent(core:get_ui_root(), "layout", "resources_bar", "topbar_list_parent");
  politicalWebButton = TextButton.new("politicalWebButton", topBar, "TEXT", "Political Web");
  politicalWebButton:Resize(300, 50);
  politicalWebButton:PositionRelativeTo(topBar, 100, 0);
  politicalWebButton:RegisterForClick(
    function(context)
        CreateWebFrame();
    end
  );
  politicalWebButton:SetVisible(true);
end

function CreateWebFrame()
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
  if continentsContainer then
    Custom_Log("Found old components...deleting");
    local components = continentsContainer:RecursiveRetrieveAllComponents();
    for key, component in pairs(components) do
      component:Delete();
    end
  end
  continentsContainer = CreateComponentsForWebType("Continent", politicalWebFrame, politicalWebData);
  Custom_Log("Adding new components");  
  politicalWebFrame:AddComponent(continentsContainer);
  
  Util.centreComponentOnComponent(continentsContainer, politicalWebFrame);
  politicalWebFrame.uic:PropagatePriority(100);
  politicalWebFrame:AddCloseButton();
  Custom_Log("Clicked web button");
  
  return politicalWebFrame;
end

--[[function destroyPoliticalWebFrame()
  local politicalWebFrame = Util.getComponentWithName("politicalWebFrame");
  if politicalWebFrame then
    politicalWebFrame:Delete();
  end
end--]]