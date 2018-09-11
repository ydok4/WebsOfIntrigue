-- Helper classes
require 'script/_lib/WebHelpers'
require 'script/_lib/EventHelpers'
require 'script/_lib/CharacterHelpers'
require 'script/_lib/FactionHelpers'
require 'script/_lib/PathHelpers'

-- Models
require 'script/_lib/MVC/Models/NarrativeManager'

Controller = {
  RaceIdentifier = "";
  RaceResources = {},
  NarrativeManager = {},
  RootNodeUUID = "",
}

function Controller:new (o)
  o = o or {};
  setmetatable(o, self);
  self.__index = self;
  return o;
end

-- Resource Files

--[[require 'script/_lib/Resources/DarkElves/WebData/SpecialCharacters/DarkElfSpecialCharacters'
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

require 'script/_lib/Resources/DarkElves/EventData/DarkElfEvents'--]]

function Controller:InitialiseController()
  self:LoadRaceNamespaces();
  self:InitialiseResources(self.RaceIdentifier);
  self:InitialiseEventManager(self.RaceIdentifier);
end

function Controller:InitialiseResources(raceIdentifier)
  self.RaceResources = {
    CharacterSettings = _G[raceIdentifier.."CharacterSettings"],
    SpecialCharacters = _G[raceIdentifier.."SpecialCharacters"],
    Names = _G[raceIdentifier.."Names"],
    Archetypes = _G[raceIdentifier.."Archetypes"],
    Titles = _G[raceIdentifier.."Titles"],
    SocialClasses = _G[raceIdentifier.."SocialClasses"],
    Religions = _G[raceIdentifier.."Religions"],
    Traits = _G[raceIdentifier.."Traits"],
    Actions = _G[raceIdentifier.."Actions"],
    Backgrounds = _G[raceIdentifier.."Backgrounds"],
    Natures = _G[raceIdentifier.."Natures"],
    Careers = _G[raceIdentifier.."Careers"],
    SpecialFactions = _G[raceIdentifier.."SpecialFactions"],
    FactionTemplates = _G[raceIdentifier.."FactionTemplates"],
    FactionNamePools =  _G[raceIdentifier.."FactionNamePools"],
    Districts = _G[raceIdentifier.."Districts"],
    SpecialDistricts = _G[raceIdentifier.."SpecialDistricts"],
    Webs = _G[raceIdentifier.."Webs"],
  }
end

function Controller:LoadRaceNamespaces()
  local racePath = 'script/_lib/Resources/'..self.RaceIdentifier;
  local raceWebPath = racePath..'/WebData/';
  local raceCharPath = racePath..'/CharacterData/';
  local raceEventPath = racePath..'/EventData/';
  -- Web Data
  require (raceWebPath..'SpecialCharacters/'..self.RaceIdentifier..'SpecialCharacters');
  require (raceWebPath..'Religions/'..self.RaceIdentifier..'Religions')
  require (raceWebPath..'Factions/'..self.RaceIdentifier..'SpecialFactions')
  require (raceWebPath..'Factions/'..self.RaceIdentifier..'FactionTemplates')
  require (raceWebPath..'Factions/'..self.RaceIdentifier..'FactionNamePools')
  require (raceWebPath..'Webs/'..self.RaceIdentifier..'Webs')
  require (raceWebPath..'Webs/'..self.RaceIdentifier..'SpecialDistricts')
  require (raceWebPath..'Webs/'..self.RaceIdentifier..'Districts')
  -- Character Data
  require (raceCharPath..'CharacterSettings/'..self.RaceIdentifier..'CharacterSettings')
  require (raceCharPath..'Names/'..self.RaceIdentifier..'Names')
  require (raceCharPath..'Archetypes/'..self.RaceIdentifier..'Archetypes')
  require (raceCharPath..'Titles/'..self.RaceIdentifier..'Titles')
  require (raceCharPath..'SocialClasses/'..self.RaceIdentifier..'SocialClasses')
  require (raceCharPath..'Traits/'..self.RaceIdentifier..'Traits')
  require (raceCharPath..'Actions/'..self.RaceIdentifier..'Actions')
  require (raceCharPath..'Backgrounds/'..self.RaceIdentifier..'Backgrounds')
  require (raceCharPath..'Natures/'..self.RaceIdentifier..'Natures')
  require (raceCharPath..'Careers/'..self.RaceIdentifier..'Careers')
  -- Event Data
  require (raceEventPath..self.RaceIdentifier..'Events')
end

function Controller:InitialiseWebs(rootWebKey)
  self.RootNodeUUID =  GetWebUUIDByNameIfAvailable(rootWebKey, nil);
  local raceWebs = CreateWebsForRace(self.RaceResources, rootWebKey, self.RootNodeUUID);
  WebsOfIntrigue:AddWebs(raceWebs);
end

function Controller:InitialiseFactions()
  CreateFactionsForRace(self.RaceResources, self.RaceIdentifier);
end

function Controller:InitialiseCharacters()
  CreateCharactersForRace(self.RaceResources, self.RaceIdentifier);
end

function Controller:InitialiseEventManager(raceIdentifier)
  -- Initialise the object
  self.NarrativeManager = NarrativeManager:new({
    EventResources = LoadEventResources(_G[raceIdentifier.."Events"]);
  });
end

function Controller:TriggerEventManagerStep()
  self.NarrativeManager:StartTriggerEvents(self.RaceIdentifier);
end