require 'script/_lib/DataHelpers'
require 'script/_lib/CharacterGenerator'

require 'script/_lib/MVC/Models/Character'

local RaceNames = {};
local RaceTitles = {};
local RaceSocialClasses = {};
local RaceArchetypes = {};

local RaceBackgrounds = {};
local RaceCareers = {};
local RaceTraits = {};
local RaceNatures = {};

local RaceReligions = {};
local RaceSpecialFactions = {};
local RaceFactionTemplates = {};

local RaceSpecialCharactersForWeb = {};


function InitialiseRaceData(raceResources, webName)
  RaceNames = raceResources.Names;
  RaceTitles = raceResources.Titles;
  table.sort(raceResources.SocialClasses, SortByAppearanceChance);
  RaceSocialClasses = raceResources.SocialClasses;
  RaceBackgrounds = raceResources.Backgrounds;
  RaceCareers = raceResources.Careers;
  RaceTraits = raceResources.Traits;
  RaceNatures = raceResources.Natures;
  RaceReligions = raceResources.Religions;
  RaceArchetypes = raceResources.Archetypes;
  --RaceSpecialCharactersForWeb = FindFirstDataInTable(raceResources.SpecialCharacters, "Web", {webName});
  RaceSpecialFactions = raceResources.SpecialFactions;
  RaceFactionTemplates = raceResources.FactionTemplates;
end

function CreateCharactersForDistrict(RaceResources, district) 
  
  InitialiseRaceData(RaceResources, district.Name);
  --local numberOfCharacters = GetRandomNumberOfCharactersFromPopulation(web["Population"]);
  
  local characters = {};

  for key, faction in pairs(district.ActiveFactions) do
    GenerateCharactersForFaction(characters, district.ActiveFactions, district, faction);
  end

  --UpdateFactionMembershipsForCharacters(characters, district.ActiveFactions);
  
  --[[local genericCharacterPopulationLimit = numberOfCharacters - #characters;
  -- Generate a number of characters based on the web size
  for i = 0, genericCharacterPopulationLimit do
    characters[#characters + 1] = GenerateCharacter(web);
  end
  
  -- Roll to see which special characters initially appear in the web
  for key,specialCharacter in pairs(RaceSpecialCharactersForWeb) do
    
    if Roll100(specialCharacter["AppearanceChance"]) then
      characters[#characters + 1] = GenerateSpecialCharacter(specialCharacter);
    end
    
  end--]]
  
  return characters;
end

function GetRandomNumberOfCharactersFromPopulation(population)
  local maxNumberOfCharacters = population * 20;
  local minNumberOfCharacters = maxNumberOfCharacters - 0.25 * maxNumberOfCharacters;
  return RandomRange(minNumberOfCharacters, maxNumberOfCharacters);
end

function GenerateCharactersForFaction(charactersList, factionList, district, factionData)

  -- Generate a number of characters for each rank
  for key, rank in pairs(factionData.Ranks) do
    
    local numberOfChars = 0;
    if factionData:IsRankPositionAvailable(rank) then
      if rank.Limit == 0 then
        numberOfChars = Random(5) + 1;
      else
        numberOfChars = rank.Limit;
      end
    end
    
    for i = 1, numberOfChars do
      local character = {};
      local character = GenerateCharacterForFactionRank(factionData, rank, district);
      factionData:SetCharacterAsRank(character, rank);

      if rank.AdditionalMemberships then
        -- This will add any additional factions for this rank and recursively for all subsequent ranks
        AddAdditionalFactionMembership(character, rank, factionList);
      end

      charactersList[#charactersList + 1] = character;
    end
  end
  
end

function AddAdditionalFactionMembership(character, rank, factionList)
  for key, additionalMembership in pairs(rank.AdditionalMemberships) do

    local additionalFactionSchema = RaceFactionTemplates[additionalMembership.Faction];
    -- If the additional rank is unspecified 
    local additionalRank = nil;
    if additionalMembership.OrdinalRank == -1 then
      additionalRank = additionalFactionSchema.Ranks[Random(#additionalFactionSchema.Ranks)];
    else
      local matchingRanks = FindDataItemsInTable(additionalFactionSchema.Ranks, "Ordinal", {additionalMembership.OrdinalRank});
      additionalRank = matchingRanks[Random(#matchingRanks)];
    end

    local additionalFaction = FindFactionWithVacantRank(factionList, additionalRank);
    if not additionalFaction then
      Custom_Log("No faction available for rank");
    else
      additionalFaction:SetCharacterAsRank(character, additionalRank);
    end
    character.Memberships[#character.Memberships + 1] = GenerateMembershipForFaction(additionalFaction, additionalRank);
    if additionalRank.AdditionalMemberships then
      AddAdditionalFactionMembership(character, additionalRank, factionList);
    end
  end
end

function FindFactionWithVacantRank(factionList, rank)
  for key, faction in pairs(factionList) do
    if faction:IsRankPositionAvailable(rank) then
      return faction;
    end
  end
  return nil;
end

function UpdateFactionMembershipsForCharacters(characters, districtFactions)
  for key, faction in pairs(districtFactions) do
    local matchingCharUUIDsForFactions = {};
    for key, character in pairs(characters) do
      if character:HasFactionMembership(faction.UUID) then
        matchingCharUUIDsForFactions[#matchingCharUUIDsForFactions + 1] = character.UUID;
      end
    end
    for key, charUUID in pairs(matchingCharUUIDsForFactions) do
      faction.MemberCharacters[#faction.MemberCharacters + 1] = charUUID;
    end
  end
end

function GenerateCharacterForFactionRank(factionData, rank, district)
  local careerIDs = {};
  local careerObjects = {};
  local careerNames = {};
  careerIDs[#careerIDs + 1] = rank.Careers[Random(#rank.Careers)];
  
  for key, career in pairs(careerIDs) do
    careerObjects[#careerObjects + 1] = RaceCareers[career];
  end
  
  for key, career in pairs(careerObjects) do
    careerNames[#careerNames + 1] = career.Name;
  end
  
  local factionMemberships = {}
  factionMemberships[#factionMemberships + 1] = GenerateMembershipForFaction(factionData, rank);
  local background = GetValidBackgroundFromCareers(RaceBackgrounds, RaceCareers, careerObjects).Name;
  local socialClass = GetValidSocialClassFromCareers(RaceSocialClasses, careerObjects);

  local race = GetRace(socialClass);
  
  local gender = GenerateGender(false, careerObjects, RaceCareers);
  local name = GenerateName(RaceNames, gender);
      
  local character = Character:new({
      UUID = GenerateUUID(),
      Name = name,
      Gender = gender,
      Memberships = factionMemberships,
      
      Race = race,
      SocialClass = socialClass.Name,
      
      Background = background,
      Careers = careerNames,
    });
  
  return character;
end

function GenerateCharacter(web)

  
  local socialClass = GenerateSocialClass(RaceSocialClasses, web.SocialClassModifier);
    
  local race = GetRace(socialClass);
  
  local background = GenerateBackground(RaceBackgrounds, web.SupportedBackgrounds, socialClass);
  
  background = background.Name;
  
  
  local careerObjects = {};
  local careerNames = {};
  careerObjects[#careerObjects + 1] = GenerateCareer(RaceCareers, web.ExtraCareers, background, socialClass);
  
  for key, career in pairs(careerObjects) do
    careerNames[#careerNames + 1] = career.Name;
  end
  
  local gender = GenerateGender(false, careerObjects, RaceCareers);
  local name = GenerateName(RaceNames, gender);
  
  
  local character = Character:new({
      UUID = GenerateUUID(),
      Name = name,
      Gender = gender,
      Memberships = {},
      
      Race = race,
      SocialClass = socialClass.Name,
      
      Background = background,
      Careers = careerNames,
    });
  
  return character;
end

function GenerateSpecialCharacter(character)
  
end