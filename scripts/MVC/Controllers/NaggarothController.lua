-- Helper classes
require 'scripts/Lib/WebHelpers'

-- Resource Files
require 'scripts/Resources/DarkElves/WebData/SpecialCharacters/DarkElfSpecialCharacters'
require 'scripts/Resources/DarkElves/WebData/Religions/DarkElfReligions'
require 'scripts/Resources/DarkElves/WebData/Factions/DarkElfFactions'
require 'scripts/Resources/DarkElves/WebData/Webs/DarkElfWebs'

require 'scripts/Resources/DarkElves/CharacterData/Names/DarkElfNames'
require 'scripts/Resources/DarkElves/CharacterData/Titles/DarkElfTitles'
require 'scripts/Resources/DarkElves/CharacterData/Traits/DarkElfTraits'
require 'scripts/Resources/DarkElves/CharacterData/Actions/DarkElfActions'
require 'scripts/Resources/DarkElves/CharacterData/Backgrounds/DarkElfBackgrounds'
require 'scripts/Resources/DarkElves/CharacterData/Careers/DarkElfCareers'


local DarkElfResources = {
    SpecialCharacters = DarkElfSpecialCharacters,
    Names = DarkElfNames,
    Titles = DarkElfTitles,
    Religions = DarkElfReligions,
    Traits = DarkElfTraits,
    Actions = DarkElfActions,
    Backgrounds = DarkElfBackgrounds,
    Careers = DarkElfCareers,
    Factions = DarkElfFactions,
    Webs = DarkElfWebs,
  }
  
  function InitialiseNaggaroth()
    local web = CreateWeb(DarkElfResources, "Naggaroth");
    local test = "";
  end