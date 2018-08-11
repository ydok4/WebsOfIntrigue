require 'script/_lib/CustomLog'
require 'script/_lib/MVC/Views/WebFrame'

local politicalWebFrame = nil --: FRAME
local politicalWebButton = nil; --: BUTTON
  
 function InitialiseUIListeners(webs)

  local topBar = find_uicomponent(core:get_ui_root(), "layout", "resources_bar", "topbar_list_parent");
  politicalWebButton = TextButton.new("politicalWebButton", topBar, "TEXT", "Political Web");
  politicalWebButton:Resize(300, 50);
  politicalWebButton:PositionRelativeTo(topBar, 100, 0);
  politicalWebButton:RegisterForClick(
    function(context)
        CreateWebFrame(webs);
    end
  );
  politicalWebButton:SetVisible(true);
end