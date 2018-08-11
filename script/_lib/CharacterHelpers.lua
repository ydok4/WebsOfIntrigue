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
local RaceFactions = {};

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
  RaceSpecialCharactersForWeb = FindFirstDataInTable(raceResources.SpecialCharacters, "Web", {webName});
  RaceFactions = raceResources.Factions;
end

function CreateCharactersForWeb(RaceResources, web) 

  if web.Population < 1 then
    return;
  end
  
  InitialiseRaceData(RaceResources, web.Name);
  local numberOfCharacters = GetRandomNumberOfCharactersFromPopulation(web["Population"]);
  
  local characters = {};
  
  if(web.ActiveFactions) then
    -- Generate characters for factions present in the web
    for key, faction in pairs(web.ActiveFactions) do
      GenerateCharactersForFaction(characters, web, faction);
    end
  end
  
  local genericCharacterPopulationLimit = numberOfCharacters - #characters;
  -- Generate a number of characters based on the web size
  for i = 0, genericCharacterPopulationLimit do
    characters[#characters + 1] = GenerateCharacter(web);
  end
  
  -- Roll to see which special characters initially appear in the web
  for key,specialCharacter in pairs(RaceSpecialCharactersForWeb) do
    
    if Roll100(specialCharacter["AppearanceChance"]) then
      characters[#characters + 1] = GenerateSpecialCharacter(specialCharacter);
    end
    
  end
  
  return characters;
end

function GetRandomNumberOfCharactersFromPopulation(population)
  local maxNumberOfCharacters = population * 20;
  local minNumberOfCharacters = maxNumberOfCharacters - 0.25 * maxNumberOfCharacters;
  return RandomRange(minNumberOfCharacters, maxNumberOfCharacters);
end

function GenerateCharactersForFaction(charactersList, web, faction)
  local factionData = RaceFactions[faction];
  if faction == "BlackGuardFaction" then
     test = ""; 
  end
  -- Generate a number of characters for each rank
  for key, rank in pairs(factionData.Ranks) do
    local numberOfChars = (rank.Limit == 0 and Random(5) + 1 or rank.Limit);
    
    for i = 1, numberOfChars do
      local char = GenerateCharacterForFactionRank(faction, rank, web);
      charactersList[#charactersList + 1] = char;
    end
  end
  
end

function GenerateCharacterForFactionRank(faction, rank, web)
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
  
  local factionMembership = GenerateMembershipForFaction(faction, rank, web.UUID);
  local background = GetValidBackgroundFromCareers(RaceBackgrounds, RaceCareers, careerObjects).Name;
  local socialClass = GetValidSocialClassFromCareers(RaceSocialClasses, careerObjects);

  local race = GetRace(socialClass);
  
  local gender = GenerateGender(false, careerObjects, RaceCareers);
  local name = GenerateName(RaceNames, gender);
      
  local character = Character:new({
      Name = name,
      Gender = gender,
      Memberships = factionMembership,
      
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
  careerObjects[#careerObjects + 1] = GenerateCareer(RaceCareers, web.SupportedCareers, background, socialClass);
  
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