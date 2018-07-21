require 'scripts/Lib/DataHelpers'
require 'scripts/Lib/CharacterGenerator'

require 'scripts/MVC/Models/Character'

local RaceNames = {};
local RaceTitles = {};
local RaceSocialClasses = {};
local RaceArchetypes = {};

local RaceBackgrounds = {};
local RaceCareers = {};
local RaceTraits = {};
local RaceNatures = {};

local RaceReligions = {};

local RaceSpecialCharactersForWeb = {};
local RaceFactionsForWeb = {};

function CreateCharactersForWeb(RaceResources, web) 

  if web.Population < 1 then
    return;
  end
  
  InitialiseRaceData(RaceResources);
  local numberOfCharacters = GetRandomNumberOfCharactersFromPopulation(web["Population"]);
  
  local characters = {};
  
  -- Generate a number of characters based on the web size
  for i = 0, numberOfCharacters do
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
  RaceFactionsForWeb = FindFirstDataInTable(raceResources.Factions, "Web", {webName});
end

function GetRandomNumberOfCharactersFromPopulation(population)
  local maxNumberOfCharacters = population * 20;
  local minNumberOfCharacters = maxNumberOfCharacters - 0.25 * maxNumberOfCharacters;
  return RandomRange(minNumberOfCharacters, maxNumberOfCharacters);
end



function GenerateCharacter(web)

  
  local socialClass = GenerateSocialClass(RaceSocialClasses, web.SocialClassModifier);
  local race = GetRace(socialClass);
  
  local background = GenerateBackground(RaceBackgrounds, web.SupportedBackgrounds, socialClass).Name;
  local careers = {};
  careers[#careers + 1] = GenerateCareer(RaceCareers, web.SupportedCareers, background, socialClass);
  
  local gender = GenerateGender(false, careers);
  local name = GenerateName(RaceNames, gender);
  
  
  local character = Character:new({
      Name = name,
      Gender = gender,
      Race = race,
      SocialClass = socialClass.Name,
      
      Background = background,
      Careers = careers,
    });
  
  return character;
end

function GenerateSpecialCharacter(character)
  
end