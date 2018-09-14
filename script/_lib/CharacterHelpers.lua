require 'script/_lib/CharacterGenerator'

require 'script/_lib/MVC/Models/Character'

local RaceCharacterSettings = {};
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


function CreateCharactersForRace(raceResources, raceIdentifier)
  InitialiseRaceData(raceResources);
  local raceRootWeb = WebsOfIntrigue:GetRootWebForRace(raceIdentifier);
  for key, webUUID in pairs(raceRootWeb.ChildWebs) do
      local web = WebsOfIntrigue:GetWebByUUID(webUUID);
      CreateCharactersForWeb(web);
  end
end

function InitialiseRaceData(raceResources)
  if raceResources == nil then
    return;
  end
  RaceCharacterSettings = raceResources.CharacterSettings;
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

function CreateCharactersForWeb(web)
  if web.ChildWebs and #web.ChildWebs > 0 then
    for key, webUUID in pairs(web.ChildWebs) do
      local childWeb = WebsOfIntrigue:GetWebByUUID(webUUID);
      CreateCharactersForWeb(childWeb);
    end
  end

  if web.Districts then
    for key2, district in pairs(web.Districts) do
      CreateCharactersForDistrict(district);
    end
  end
end

function CreateCharactersForDistrict(district)
  for key, factionUUID in pairs(district.ActiveFactions) do
    local faction = WebsOfIntrigue:GetFactionByUUID(factionUUID);
    local factionCharacters = GenerateCharactersForFaction(district, faction);
    district:AddCharacters(factionCharacters);
    WebsOfIntrigue:AddCharacters(factionCharacters);
  end

  --[[
  local numberOfCharacters = GetRandomNumberOfCharactersFromPopulation(web["Population"]);  
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
    
  end--]]
end

function GenerateCharactersForFaction(district, factionData)
  local factionCharacters = {};
  -- Generate a number of characters for each rank
  for key, rank in pairs(factionData.Ranks) do
    local numberOfChars = 0;
    if factionData:IsRankPositionAvailable(rank) then
      if rank.Limit == 0 then
        numberOfChars = Random(2) + 1;
      else
        numberOfChars = rank.Limit;
      end
    end

    for i = 1, numberOfChars do
      local character = GenerateCharacterForFactionRank(factionData, rank, district);
      factionData:SetCharacterAsRank(character, rank);

      if rank.AdditionalMemberships then
        -- This will add any additional factions for this rank and recursively for all subsequent ranks
        AddAdditionalFactionMembership(character, rank, district.ActiveFactions);
      end

      factionCharacters[character.UUID] = character;
      district.Characters[#district.Characters + 1] = character.UUID;
    end
  end

  return factionCharacters;
end


function AddAdditionalFactionMembership(character, rank, factionList)
  for key, additionalMembership in pairs(rank.AdditionalMemberships) do

    local additionalFactionSchema = RaceFactionTemplates[additionalMembership.Faction];
    -- If the additional rank is unspecified 
    local additionalRank = nil;
    if additionalMembership.OrdinalRank == -1 then
      local matchingRanks =  FindDataItemsInTable(additionalFactionSchema.Ranks, "Gender", {character.Gender, ""});
      additionalRank = matchingRanks[Random(#matchingRanks)];
    else
      local matchingRanks = FindDataItemsInTable(additionalFactionSchema.Ranks, "Ordinal", {additionalMembership.OrdinalRank});
      matchingRanks =  FindDataItemsInTable(matchingRanks, "Gender", {character.Gender, ""});
      additionalRank = matchingRanks[Random(#matchingRanks)];
    end

    if not additionalRank then
      Custom_Log("No rank membership available matching criteria");
      return;
    end

    local additionalFaction = FindFactionWithVacantRank(factionList, additionalRank);
    if not additionalFaction then
      Custom_Log("No generated faction available for ran");
      return;
    else
      additionalFaction:SetCharacterAsRank(character, additionalRank);
    end
    character.Memberships[additionalFaction.UUID] = GenerateMembershipForFaction(additionalFaction, additionalRank);

    if additionalFaction.GrantedNameOverride then
      character:SetName(additionalFaction.GrantedNameOverride);
    end

    if additionalRank.AdditionalMemberships then
      AddAdditionalFactionMembership(character, additionalRank, factionList);
    end
  end
end

function FindFactionWithVacantRank(factionList, rank)
  for index, factionUUID in pairs(factionList) do
    local faction = WebsOfIntrigue:GetFactionByUUID(factionUUID);
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

  for key, career in pairs(rank.Careers) do
    if rank.Gender and career.Gender then
      if AreValuesInList(career.Gender, {rank.Gender}) then
        careerObjects[#careerObjects + 1] = RaceCareers[career];
      end
    else
      careerObjects[#careerObjects + 1] = RaceCareers[career];
    end
  end

  for key, career in pairs(careerObjects) do
    careerNames[#careerNames + 1] = career.Name;
  end

  local factionMemberships = {}
  factionMemberships[factionData.UUID] = GenerateMembershipForFaction(factionData, rank);
  local background = GetValidBackgroundFromCareers(RaceBackgrounds, RaceCareers, careerObjects).Name;
  local socialClass = GetValidSocialClassFromCareers(RaceSocialClasses, careerObjects);

  --Pick a career from the rank careers
  local careers = {};
  careers[#careers + 1] = GenerateCareer(RaceCareers, careerNames, background, socialClass);

  local race = GetRace(socialClass);

  local gender = "";
  if #rank.Gender > 0 then
    gender = rank.Gender;
  else
    gender = GenerateGender(false, careerObjects, RaceCharacterSettings.MaleGenderChance);
  end

  local name = GenerateFullNameObject(RaceNames, gender, RaceCharacterSettings.NameSettings);

  local character = Character:new({
      UUID = GenerateUUID(),
      Name = name,
      Gender = gender,
      Memberships = factionMemberships,
      Race = race,
      SocialClass = socialClass.Name,
      Background = background,
      Careers = careers,

      EventHistory = {},
    });

  local traits = GenerateTraits(character, RaceTraits);
  if rank.UseNameOverride == true then
    character:SetName(factionData.GrantedNameOverride);
  end

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

  local gender = GenerateGender(false, careerObjects, CharacterSettings.MaleGenderChance);
  local name = GenerateFullNameObject(RaceNames, gender, RaceCharacterSettings.NameSettings);

  local character = Character:new({
      UUID = GenerateUUID(),
      Name = name,
      Gender = gender,
      Memberships = {},
      
      Race = race,
      SocialClass = socialClass.Name,
      
      Background = background,
      Careers = careerNames,
      EventHistory = {},
    });
  
  return character;
end

function GenerateSpecialCharacter(character)
  
end

function GetRandomNumberOfCharactersFromPopulation(population)
  local maxNumberOfCharacters = population * 20;
  local minNumberOfCharacters = maxNumberOfCharacters - 0.25 * maxNumberOfCharacters;
  return RandomRange(minNumberOfCharacters, maxNumberOfCharacters);
end