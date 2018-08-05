require 'script/_lib/WebHelpers'

function CreateWebFrameForType(webType)


  --[[local closeButton = Button.new("PoliticalWebFrameCloseButton", politicalWebFrame, "CIRCULAR", "ui/skins/warhammer2/icon_cross.png");
    closeButton:RegisterForClick(
        function(context)
            destroyPoliticalWebFrame();
        end
    );
  frameContainer:AddComponent(closeButton);--]]
  

end

function CreateComponentsForWebType(webType, frame, webData)
  Custom_Log("Creating components for webType: "..webType);
  local continentsContainer = Container.new(FlowLayout.VERTICAL);
  local namesForType = GetWebText(webType, webData);
  for key, name in pairs(namesForType) do
    local existingComponent = Util.getComponentWithName(name..webType);
    if existingComponent then
      existingComponent:Delete();
    end
    Custom_Log("Adding text: "..name);
    local individualWebContainer = Container.new(FlowLayout.HORIZONTAL);
    
    individualWebContainer:AddComponent(Text.new(name..webType, frame, "NORMAL", name));
    individualWebContainer:AddComponent(CreateNextWebLevelButton(name, frame));
    
    continentsContainer.AddComponent(individualWebContainer);
    Util.centreComponentOnComponent(individualWebContainer, frame);
  end
  return continentsContainer;
end

function CreateNextWebLevelButton(name, frame)
  local viewNextLevelWebButton = Button.new(name.."ViewChildWebButton", frame, "CIRCULAR",  "ui/skins/default/icon_end_turn.png");
  viewNextLevelWebButton:RegisterForClick(
    function(context)
      CreateAndShowComponentsForType("TypeTest");
    end
  );
  return viewNextLevelWebButton;
end

function CreateAndShowComponentsForType(webType)
  Custom_Log(webType);
end