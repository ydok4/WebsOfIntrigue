-- Models
require 'script/_lib/MVC/Models/Controller'

IntrigueManager = {
  CurrentTurn = 0,
  -- Global data pools
  Webs = {},
  Districts = {},
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
  Custom_Log("Initialising Dark Elves");
  local raceIdentifier = "DarkElf";
  self.Controllers[raceIdentifier] = Controller:new({
    RaceIdentifier = raceIdentifier,
  });

  local raceController = self.Controllers[raceIdentifier];
  Custom_Log("Created Dark Elf Controller");
  raceController:InitialiseController();
  Custom_Log("Dark Elf controller initalised");
  raceController:InitialiseWebs("Naggaroth");
  Custom_Log("Dark Elf webs initalised");
  raceController:InitialiseFactions();
  Custom_Log("Dark Elf factions initalised");
  raceController:InitialiseCharacters();
  Custom_Log("Dark Elf characters initalised");
  local test = "";
end

function IntrigueManager:AddWebs(webList)
  TableConcatByKeyWithUUID(self.Webs, webList);
end

function IntrigueManager:AddDistrict(district)
  self.Districts[district.UUID] = district;
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

function IntrigueManager:GetDistrictByUUID(districtUUID)
  return self.Districts[districtUUID];
end

function IntrigueManager:GetCharacterByUUID(characterUUID)
  return self.Characters[characterUUID];
end

function IntrigueManager:GetFactionByUUID(factionUUID)
  return self.Factions[factionUUID];
end

function IntrigueManager:GetDistrictsForWeb(webUUID)
  local web = self:GetWebByUUID(webUUID);
  local districts = {};
  for key, districtUUID in pairs(web.Districts) do
    districts[#districts + 1] = self:GetDistrictByUUID(districtUUID);
  end

  return districts;
end

function IntrigueManager:GetWebsForType(type)
  return FindDataItemsInTable(self.Webs, "Type", {type,});
end

function IntrigueManager:GetCharactersForDistrict(districtUUID)
  return self:GetCharactersFromDistrict(self.Districts[districtUUID]);
end

function IntrigueManager:GetCharactersFromDistrict(district)
  local characters = {};
  for key, characterUUID in pairs(district.Characters) do
    characters[#characters + 1] = self:GetCharacterByUUID(characterUUID);
  end
  return characters;
end

function IntrigueManager:GetCharactersForWeb(webUUID)
  local districts = self:GetDistrictsForWeb(webUUID);
  local characters = {};
  for key, district in pairs(districts) do
    TableConcat(characters, self:GetCharactersFromDistrict(district));
  end

  return characters;
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