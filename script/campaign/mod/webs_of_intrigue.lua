require 'script/_lib/DataHelpers'
require 'script/_lib/MVC/Models/IntrigueManager'

require 'script/_lib/MVC/Views/WebUIListeners'

require 'script/_lib/CustomLog'

require 'script/_lib/MVC/Views/WebFrame'

-- Create the main Webs Of Intrigue Manager object
woi = IntrigueManager:new({
  CurrentTurn = 0,
  Webs = {},
  Districts = {},
  Characters = {},
  Factions = {},
  Controllers = {},
});
-- Add it as a global variable
_G.woi = woi;

function webs_of_intrigue(isIDE)
  Custom_Log("\n\nWebs of Intrigue START");

  -- Start initialising
  woi:InitialiseShared();
  woi:InitialiseDarkElves();

	Custom_Log("Webs of Intrigue Initialisation completed");

  if not isIDE then
    Custom_Log("Setting up UI listeners");
    InitialiseUIListeners();
    Custom_Log("Finished UI listeners");
  end

  --TriggerEventManagersStep();
  local test = "";
 end

 function TriggerEventManagersStep()
  for i = 0, 10 do
    woi:TriggerEventManagersStep();
  end
 end