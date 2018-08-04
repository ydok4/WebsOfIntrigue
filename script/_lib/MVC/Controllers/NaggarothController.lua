-- Helper classes
require 'script/_lib/WebHelpers'

-- Resource Files
require 'script/_lib/Resources/DarkElves/WebData/SpecialCharacters/DarkElfSpecialCharacters'
require 'script/_lib/Resources/DarkElves/WebData/Religions/DarkElfReligions'
require 'script/_lib/Resources/DarkElves/WebData/Factions/DarkElfFactions'
require 'script/_lib/Resources/DarkElves/WebData/Webs/DarkElfWebs'

require 'script/_lib/Resources/DarkElves/CharacterData/Names/DarkElfNames'
require 'script/_lib/Resources/DarkElves/CharacterData/Archetypes/DarkElfArchetypes'
require 'script/_lib/Resources/DarkElves/CharacterData/Titles/DarkElfTitles'
require 'script/_lib/Resources/DarkElves/CharacterData/SocialClasses/DarkElfSocialClasses'
require 'script/_lib/Resources/DarkElves/CharacterData/Traits/DarkElfTraits'
require 'script/_lib/Resources/DarkElves/CharacterData/Actions/DarkElfActions'
require 'script/_lib/Resources/DarkElves/CharacterData/Backgrounds/DarkElfBackgrounds'
require 'script/_lib/Resources/DarkElves/CharacterData/Natures/DarkElfNatures'
require 'script/_lib/Resources/DarkElves/CharacterData/Careers/DarkElfCareers'


local DarkElfResources = {
    SpecialCharacters = DarkElfSpecialCharacters,
    Names = DarkElfNames,
    Archetypes = DarkElfArchetypes,
    Titles = DarkElfTitles,
    SocialClasses = DarkElfSocialClasses,
    Religions = DarkElfReligions,
    Traits = DarkElfTraits,
    Actions = DarkElfActions,
    Backgrounds = DarkElfBackgrounds,
    Natures = DarkElfNatures,
    Careers = DarkElfCareers,
    Factions = DarkElfFactions,
    Webs = DarkElfWebs,
  }
  
  function InitialiseNaggaroth()
    local web = CreateWeb(DarkElfResources, "Naggaroth", "", "");
    local test = "";
    return web;
  end