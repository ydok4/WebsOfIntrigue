-- Helper classes
require 'script/_lib/WebHelpers'
require 'script/_lib/EventHelpers'

-- Resource Files
require 'script/_lib/Resources/DarkElves/WebData/SpecialCharacters/DarkElfSpecialCharacters'
require 'script/_lib/Resources/DarkElves/WebData/Religions/DarkElfReligions'
require 'script/_lib/Resources/DarkElves/WebData/Factions/DarkElfSpecialFactions'
require 'script/_lib/Resources/DarkElves/WebData/Factions/DarkElfFactionTemplates'
require 'script/_lib/Resources/DarkElves/WebData/Factions/DarkElfFactionNamePools'
require 'script/_lib/Resources/DarkElves/WebData/Webs/DarkElfWebs'
require 'script/_lib/Resources/DarkElves/WebData/Webs/DarkElfSpecialDistricts'
require 'script/_lib/Resources/DarkElves/WebData/Webs/DarkElfDistricts'

require 'script/_lib/Resources/DarkElves/CharacterData/CharacterSettings/DarkElfCharacterSettings'
require 'script/_lib/Resources/DarkElves/CharacterData/Names/DarkElfNames'
require 'script/_lib/Resources/DarkElves/CharacterData/Archetypes/DarkElfArchetypes'
require 'script/_lib/Resources/DarkElves/CharacterData/Titles/DarkElfTitles'
require 'script/_lib/Resources/DarkElves/CharacterData/SocialClasses/DarkElfSocialClasses'
require 'script/_lib/Resources/DarkElves/CharacterData/Traits/DarkElfTraits'
require 'script/_lib/Resources/DarkElves/CharacterData/Actions/DarkElfActions'
require 'script/_lib/Resources/DarkElves/CharacterData/Backgrounds/DarkElfBackgrounds'
require 'script/_lib/Resources/DarkElves/CharacterData/Natures/DarkElfNatures'
require 'script/_lib/Resources/DarkElves/CharacterData/Careers/DarkElfCareers'

require 'script/_lib/Resources/DarkElves/EventData/DarkElfEvents'

-- Models
require 'script/_lib/MVC/Models/NarrativeManager'

local DarkElfResources = {
    CharacterSettings = DarkElfCharacterSettings,
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
    SpecialFactions = DarkElfSpecialFactions,
    FactionTemplates = DarkElfFactionTemplates,
    FactionNamePools =  DarkElfFactionNamePools,
    Districts = DarkElfDistricts,
    SpecialDistricts = DarkElfSpecialDistricts,
    Webs = DarkElfWebs,
  }

  local DarkElfNarrativeManager = {};
  local DarkElfWebObjects = {};

  function InitialiseNaggaroth()
    DarkElfWebObjects = {CreateWeb(DarkElfResources, "Naggaroth", "", "")};
    InitialiseDarkElfEventManager();
    return DarkElfWebObjects;
  end

  function InitialiseDarkElfEventManager()
    -- Initialise the object
    DarkElfNarrativeManager = NarrativeManager:new({
      EventResources = LoadEventResources(DarkElfEvents);
    });
  end

  function TriggerDarkElfEventManagerStep()
    DarkElfNarrativeManager:StartTriggerEvents(DarkElfWebObjects);
  end