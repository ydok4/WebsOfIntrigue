require 'script/_lib/DataHelpers'
require 'script/_lib/MVC/Models/IntrigueManager'

require 'script/_lib/MVC/Views/WebUIListeners'

require 'script/_lib/CustomLog'

require 'script/_lib/MVC/Views/WebFrame'

WebsOfIntrigue = {};

function webs_of_intrigue(isIDE)
  Custom_Log("Webs of Intrigue START");
  -- Create the main Webs Of Intrigue Manager object
  WebsOfIntrigue = IntrigueManager:new({
    CurrentTurn = 0,
    Webs = {},
    Characters = {},
    Factions = {},
    Controllers = {},
  });

  -- Start initialising
  WebsOfIntrigue:InitialiseShared();
  WebsOfIntrigue:InitialiseDarkElves();

	Custom_Log("Webs of Intrigue Initialisation completed");

  if not isIDE then
    Custom_Log("Setting up UI listeners");
    InitialiseUIListeners(webs);
    Custom_Log("Finished UI listeners");
  end

  TriggerEventManagersStep();
  local test = "";
 end

 function TriggerEventManagersStep()
  for i = 0, 10 do
    WebsOfIntrigue:TriggerEventManagersStep();
  end
 end