require 'script/_lib/MVC/Controllers/NaggarothController'

require 'script/_lib/MVC/Models/Web'

require 'script/_lib/MVC/Views/WebUIListeners'

require 'script/_lib/CustomLog'

require 'script/_lib/MVC/Views/WebFrame'

webs = {};

function webs_of_intrigue(isIDE)
  Custom_Log("Webs of Intrigue START");
  webs[#webs + 1] = InitialiseNaggaroth();
	Custom_Log("Webs of Intrigue Naggaroth completed");

  if not isIDE then
    Custom_Log("Setting up UI listeners");
    InitialiseUIListeners(webs);
    Custom_Log("Finished UI listeners");
  end

  TriggerDarkElfEventManagerStep();
  TriggerDarkElfEventManagerStep();
  TriggerDarkElfEventManagerStep();
  TriggerDarkElfEventManagerStep();
  TriggerDarkElfEventManagerStep();
  TriggerDarkElfEventManagerStep();
  TriggerDarkElfEventManagerStep();
  local test = "";
 end