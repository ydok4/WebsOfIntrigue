-- Models
require 'script/_lib/MVC/Models/Controller'

IntrigueManager = {
  -- Global data pools
  Webs = {},
  Characters = {},
  Factions = {},
  -- Race controllers
  Controllers = {},
}

function IntrigueManager:new (o)
  o = o or {};
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function IntrigueManager:InitialiseDarkElves()
  local raceIdentifier = "DarkElf";
  self.Controllers[raceIdentifier] = Controller:new({
    RaceIdentifier = raceIdentifier,
  });

  local raceController = self.Controllers[raceIdentifier];
  raceController:InitialiseController();
  raceController:InitialiseWebs("Naggaroth");
  raceController:InitialiseFactions();
  raceController:InitialiseCharacters();

  local test = "";
end

function IntrigueManager:AddWebs(webList)
  TableConcatByKeyWithUUID(self.Webs, webList);
end

function IntrigueManager:AddFactions(factionList)
  TableConcatByKeyWithUUID(self.Factions, factionList);
end

function IntrigueManager:AddCharacters(characterList)
  TableConcatByKeyWithUUID(self.Characters, characterList);
end

function IntrigueManager:GetRootWebForRace(raceIdentifier)
  local raceController = self.Controllers[raceIdentifier];
  return self.Webs[raceController.RootNodeUUID];
end

function IntrigueManager:GetWebByUUID(webUUID)
  return self.Webs[webUUID];
end

function IntrigueManager:GetFactionByUUID(factionUUID)
  return self.Factions[factionUUID];
end

function IntrigueManager:TriggerEventManagersStep()
  for key, controller in pairs(self.Controllers) do
    controller:TriggerEventManagerStep();
  end
end