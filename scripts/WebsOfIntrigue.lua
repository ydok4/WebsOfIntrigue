require 'scripts/MVC/Controllers/NaggarothController'

require 'scripts/MVC/Models/Web'


function WebsOfIntrigue()
  local NaggarondWeb = Web:new({
      Name = "Naggaroth",
      Size = -1,
      SupportedBackgrounds = {},
      
      Characters = {},
      Children = InitialiseNaggaroth(),
    });
 
 end