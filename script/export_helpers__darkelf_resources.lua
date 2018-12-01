--cm = get_cm();

--out("WOI: Loading Dark Elf Resources");

require 'script/_lib/Resources/DarkElf/WebData/SpecialCharacters/DarkElfSpecialCharacters'
require 'script/_lib/Resources/DarkElf/WebData/Religions/DarkElfReligions'
require 'script/_lib/Resources/DarkElf/WebData/Factions/DarkElfSpecialFactions'
require 'script/_lib/Resources/DarkElf/WebData/Factions/DarkElfFactionTemplates'
require 'script/_lib/Resources/DarkElf/WebData/Factions/DarkElfFactionNamePools'
require 'script/_lib/Resources/DarkElf/WebData/Webs/DarkElfWebs'
require 'script/_lib/Resources/DarkElf/WebData/Webs/DarkElfSpecialDistricts'
require 'script/_lib/Resources/DarkElf/WebData/Webs/DarkElfDistricts'

require 'script/_lib/Resources/DarkElf/CharacterData/CharacterSettings/DarkElfCharacterSettings'
require 'script/_lib/Resources/DarkElf/CharacterData/Names/DarkElfNames'
require 'script/_lib/Resources/DarkElf/CharacterData/Archetypes/DarkElfArchetypes'
require 'script/_lib/Resources/DarkElf/CharacterData/Titles/DarkElfTitles'
require 'script/_lib/Resources/DarkElf/CharacterData/SocialClasses/DarkElfSocialClasses'
require 'script/_lib/Resources/DarkElf/CharacterData/Traits/DarkElfTraits'
require 'script/_lib/Resources/DarkElf/CharacterData/Actions/DarkElfActions'
require 'script/_lib/Resources/DarkElf/CharacterData/Backgrounds/DarkElfBackgrounds'
require 'script/_lib/Resources/DarkElf/CharacterData/Natures/DarkElfNatures'
require 'script/_lib/Resources/DarkElf/CharacterData/Careers/DarkElfCareers'

require 'script/_lib/Resources/DarkElf/EventData/DarkElfEvents'


--out("WOI: Finished loading required files");

_G.DarkElfResources = {
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

_G.DarkElfEvents = DarkElfEvents;

--out("WOI: Global data initialised");