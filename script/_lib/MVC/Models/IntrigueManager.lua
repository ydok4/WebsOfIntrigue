-- Models
require 'script/_lib/MVC/Models/Controller'

IntrigueManager = {
  CurrentTurn = 0,
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

function IntrigueManager:InitialiseShared()

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

function IntrigueManager:CharacterJoinsFaction(character, faction, rank)
  local factionMembers = self.Factions[faction.UUID].MemberCharacters;
  factionMembers[#factionMembers + 1] = character.UUID;
  character:AddFactionMembership(faction, rank);
  faction:SetCharacterAsRank(character, rank);
  local event = self:GetSharedEventByKey('CharacterJoinsFaction');
  character:ApplyEventAndReturnResult(event, self.CurrentTurn, nil);
end

function IntrigueManager:GetSharedEventByKey(key)
  return self.Controllers['Shared'].EventResources[key];
end