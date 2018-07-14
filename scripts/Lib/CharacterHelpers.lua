require 'scripts/Lib/DataHelpers'

require 'scripts/Lib/CharacterGenerator'

local RaceNames = {};
local RaceTitles = {};

local RaceBackgrounds = {};
local RaceCareers = {};
local RaceTraits = {};
local RaceNatures = {};

local RaceReligions = {};

local RaceSpecialCharactersForWeb = {};
local RaceFactionsForWeb = {};

function CreateCharactersForWeb(RaceResources, web) 

  if web.Size < 1 then
    return;
  end
  
  InitialiseRaceData(RaceResources);
  local numberOfCharacters = GetRandomNumberOfCharactersFromSize(web["Size"]);
  
  local characters = {};
  
  -- Generate a number of characters based on the web size
  for i = 0, numberOfCharacters do
    characters[#characters + 1] = GenerateCharacter();
  end
  
  -- Roll to see which special characters initially appear in the web
  for key,specialCharacter in pairs(RaceSpecialCharactersForWeb) do
    
    if Roll100(specialCharacter["AppearanceChance"]) then
      characters[#characters + 1] = GenerateSpecialCharacter(specialCharacter);
    end
    
  end
  
  return characters;
end

function InitialiseRaceData(raceResources, webName)
  RaceNames = raceResources.Names;
  RaceTitles = raceResources.Titles;
  RaceBackgrounds = raceResources.Backgrounds;
  RaceCareers = raceResources.Careers;
  RaceTraits = raceResources.Traits;
  RaceNatures = raceResources.Natures;
  RaceReligions = raceResources.Religions;
  RaceSpecialCharactersForWeb = FindFirstDataInTable(raceResources.SpecialCharacters, "Web", {webName});
  RaceFactionsForWeb = FindFirstDataInTable(raceResources.Factions, "Web", {webName});
end

function GetRandomNumberOfCharactersFromSize(size)
  local maxNumberOfCharacters = size * 20;
  local minNumberOfCharacters = maxNumberOfCharacters - 0.25 * maxNumberOfCharacters;
  return RandomRange(minNumberOfCharacters, maxNumberOfCharacters);
end



function GenerateCharacter()
  local gender = GenerateGender();
  local socialClass = GenerateSocialClass(RaceSocialClasses);
  local name = GenerateName(RaceNames, gender);
  
  local character = Character:new({
      
      
    });
end

function GenerateSpecialCharacter(character)
  
end