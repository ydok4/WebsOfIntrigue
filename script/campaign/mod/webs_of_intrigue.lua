require 'script/_lib/MVC/Controllers/NaggarothController'

require 'script/_lib/MVC/Models/Web'

require 'script/_lib/MVC/Views/WebView'

local politicalWebFrame = nil --: FRAME
local politicalWebButton = nil; --: BUTTON
local politicalWebText = {}; -- : TEXT

local webs = {};

function webs_of_intrigue(isIDE)
  Custom_Log("Webs of Intrigue START");
  local NaggarondWeb = Web:new({
      Name = "Naggaroth",
      Size = -1,
      SupportedBackgrounds = {},
      
      Characters = {},
      ChildWebs = {},
    });
  NaggarondWeb.ChildWebs[#NaggarondWeb.ChildWebs + 1] = InitialiseNaggaroth();
	Custom_Log("Webs of Intrigue Naggaroth completed");
  webs[#webs + 1] = NaggarondWeb;
  
  if not isIDE then
    Custom_Log("Setting up UI listeners");
    InitialiseUIListeners();
    Custom_Log("Finished UI listeners");
  end
 end
 
 function InitialiseUIListeners()
  local topBar = find_uicomponent(core:get_ui_root(), "layout", "resources_bar", "topbar_list_parent");
  politicalWebButton = TextButton.new("politicalWebButton", topBar, "TEXT", "Political Web");
  politicalWebButton:Resize(300, 50);
  politicalWebButton:PositionRelativeTo(topBar, 100, 0);
  politicalWebButton:RegisterForClick(
    function(context)
        CreatePoliticalWebTopLevelFrame();
    end
  );
  politicalWebButton:SetVisible(true);
  --[[core:add_listener(
        "WebsOfIntrigueMainPanel",
        "PanelOpenedCampaign",
        function(context) 
            Custom_Log("Context: "..context.string);
            return context.string == "clan"; 
        end,
        function(context)
          Custom_Log("IS faction dropdown");
          local ui_root = core:get_ui_root();
          local tabGroup = find_uicomponent(ui_root, "clan", "main", "TabGroup");
          local stats = find_uicomponent(ui_root, "clan", "main", "TabGroup", "Stats");	
                              
          local politicalWebButton = TextButton.new("politicalWebButton", tabGroup, "TEXT", "Political Web");
          politicalWebButton:Resize(250, 50);
          politicalWebButton:PositionRelativeTo(stats, 0, 75);
          
          politicalWebButton:RegisterForClick(
                function(context)
                    CreatePoliticalWebTopLevelFrame();
                end
            );
          
          politicalWebButton:SetVisible(true);
        end,
        true
    );
    
    core:add_listener(
      "PoliticalWebButtonRemover",
      "PanelClosedCampaign",
      function(context) 
          return context.string == "clan"; 
      end,
      function(context)
          local politicalWebButton = Util.getComponentWithName("politicalWebButton");
          if politicalWebButton then
              politicalWebButton:Delete();
          end
      end,
      true
  );--]]
end

function CreatePoliticalWebTopLevelFrame()
  -- If the frame exists don't make a new one
  local existingFrame = Util.getComponentWithName("politicalWebFrame");
  if existingFrame then
    return;
  end
  
  -- Make the frame
  politicalWebFrame = Frame.new("politicalWebFrame");
  politicalWebFrame:SetTitle("Political Web");
  local xRes, yRes = core:get_screen_resolution();
  politicalWebFrame:Resize(politicalWebFrame:Width() * 1.3 + 200, yRes - 200);
  Util.centreComponentOnScreen(politicalWebFrame);

  local frameContainer = Container.new(FlowLayout.VERTICAL);
  politicalWebFrame:AddComponent(frameContainer);
  politicalWebFrame:AddCloseButton();
  
  AddWebTextToFrameContainer(politicalWebFrame, frameContainer);

  --[[ local closeButton = Button.new("PolitcalWebFrameCloseButton", politicalWebFrame, "CIRCULAR", "ui/skins/warhammer2/icon_cross.png");
    closeButton:RegisterForClick(
        function(context)
            destroyPoliticalWebFrame();
        end
    );
  recuitContainer:AddComponent(closeButton); --]]
  
  Util.centreComponentOnComponent(frameContainer, politicalWebFrame);
  
  local xPos, yPos = recuitContainer:Position();
  
  recuitContainer:MoveTo(xPos, yPos + (politicalWebFrame:Height() / 2) - 50);
  politicalWebFrame.uic:PropagatePriority(100);
  
  -- Move the clan screen offscreen
  --local ui_root = core:get_ui_root();
  --local clan = find_uicomponent(ui_root, "clan");
  --clan:MoveTo(-5000, 0);
  
  Custom_Log("Clicked web button");
  return politicalWebFrame;
end

function destroyPoliticalWebFrame()
  local politicalWebFrame = Util.getComponentWithName("politicalWebFrame");
  if politicalWebFrame then
    politicalWebFrame:Delete();
  end
end

function AddWebTextToFrameContainer(frame, frameContainer)
  for key,web in pairs(webs) do
    politicalWebText[#politicalWebText + 1] = Text.new("text", frame, "NORMAL", web.Name);
    GetChildWebNameFromWeb(web, frame);
  end
  
  for key,web in pairs(politicalWebText) do
    frameContainer.AddComponent(webName);
  end
end

function GetChildWebNameFromWeb(web, frame)
  if not web then
    return;
  end
  for key,childWeb in pairs(web.ChildWebs) do
    politicalWebText[#politicalWebText + 1] = Text.new("text", frame, "NORMAL", childWeb.Name);
    GetChildWebNameFromWeb(childWeb);
  end
end