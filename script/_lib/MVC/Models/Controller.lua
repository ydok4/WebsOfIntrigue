woi = _G.woi;

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

function Controller:InitialiseController()
  self:InitialiseResources();
  Custom_Log("Loaded Race Resources");
  self:InitialiseEventManager(self.RaceIdentifier);
  Custom_Log("Loaded Race Events");
end

function Controller:InitialiseResources()
  self.RaceResources = _G[self.RaceIdentifier.."Resources"];
  --[[if _G.DarkElfResources then
    Custom_Log("Found Dark Elf Resources");
  else
    Custom_Log("NOT found Dark Elf Resources");
  end

  if _G["DarkElfResources"] then
    Custom_Log("Found Dark Elf Resources by key identifier");
  else
    Custom_Log("NOT Found Dark Elf Resources by key identifier");
  end

  if _G[self.RaceIdentifier.."Resources"] then
    Custom_Log("Found Dark Elf Resources by dynamic identifier");
  else
    Custom_Log("NOT Found Dark Elf Resources by dynamic identifier");
  end--]]
end

function Controller:InitialiseWebs(rootWebKey)
  self.RootNodeUUID =  GetWebUUIDByNameIfAvailable(rootWebKey, nil);
  local raceWebs = CreateWebsForRace(self.RaceResources, rootWebKey, self.RootNodeUUID);
  woi:AddWebs(raceWebs);
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