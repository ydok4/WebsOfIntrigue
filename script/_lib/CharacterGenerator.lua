require 'script/_lib/MVC/Models/Name'
require 'script/_lib/MVC/Models/Career'
require 'script/_lib/MVC/Models/Membership'
require 'script/_lib/MVC/Models/Trait'

function GenerateGender(isSexless, careers, maleGenderChance)
  if isSexless and isSexless == true then
    return "Sexless";
  else
    local femaleExcluded = false;
    local maleExcluded = false;
    for key,career in pairs(careers) do
      if career.ExcludedGender then
        if femaleExcluded == false and career.ExcludedGender == "Female" then
          femaleExcluded = true;
        elseif maleExcluded == false and career.ExcludedGender == "Male" then
          maleExcluded = true;
        end
      end
    end

    if maleExcluded == false and femaleExcluded == false then
      if Roll100(maleGenderChance) then
        return "Male"
      else
        return "Female"
      end
    elseif maleExcluded == true then
      return "Female";
    else
      return "Male";
    end
  end
end

function GenerateSocialClass(raceSocialClasses, socialClassModifier)
  for key, socialClass in pairs(raceSocialClasses) do
    if Roll100(socialClass["AppearanceChance"] + socialClassModifier) then
        return socialClass;
    end
  end
  return 
end

function GetRandomFirstName(raceNames, gender)
  local genderNames = {};
  if gender == "Both" then
    genderNames = raceNames;
  else
    genderNames = FindDataItemsInTable(raceNames, "Gender", {gender, "Both"});
  end
  local genderFirstNames = FindDataItemsInTable(genderNames, "Type", {"FirstName"});
  local firstNameData = genderFirstNames[Random(#genderFirstNames)];

  local firstName = firstNameData.Name;
  if #firstNameData.Prefixes > 0 and Random(#firstNameData.Prefixes + 1) > 1 then
    firstName = firstNameData.Prefixes[#firstNameData.Prefixes]..firstName;
  end
  if #firstNameData.Suffixes > 0 and Random(#firstNameData.Suffixes + 1) > 1 then
    firstName = firstName..firstNameData.Suffixes[#firstNameData.Suffixes];
  end

  return firstName;
end

function GetRandomSurname(raceNames, gender)
  local genderNames = {};
  if gender == "Both" then
    genderNames = raceNames;
  else
    genderNames = FindDataItemsInTable(raceNames, "Gender", {gender, "Both"});
  end
  local genderSurnames = FindDataItemsInTable(genderNames, "Type", {"Surname"});
  local surnameData = genderSurnames[Random(#genderSurnames)];

  local surname = surnameData.Name;
  if #surnameData.Prefixes > 0 and Random(#surnameData.Prefixes + 1) > 1 then
    surname = surnameData.Prefixes[#surnameData.Prefixes]..surname;
  end
  if #surnameData.Suffixes > 0 and Random(#surnameData.Suffixes + 1) > 1 then
    surname = surname..surnameData.Suffixes[#surnameData.Suffixes];
  end

  return surname;
end

function GenerateFullNameObject(raceNames, gender, nameSettings)
  local titlePrefix = "";
  local firstName = "";
  local surname = "";
  local titleSuffix = "";

  if nameSettings.UseFirstName == true then
    firstName = GetRandomFirstName(raceNames, gender);
  end

  if nameSettings.UseSurname == true then
    surname = GetRandomSurname(raceNames, gender);
  end

  return Name:new({
    TitlePrefix = titlePrefix,
    FirstName = firstName,
    Surname = surname,
    TitleSuffix = titleSuffix,
  });
end

function GetRace(socialClass)
  local availableRaces = socialClass["AvailableRaces"];
  return availableRaces[Random(TableLength(availableRaces))]; 
end

function GenerateBackground(raceBackgrounds, webBackgrounds, socialClass)
  local potentialBackgrounds = FindDataItemsInTableByKey(raceBackgrounds, webBackgrounds);
  potentialBackgrounds = FindDataItemsInTable(potentialBackgrounds, "SocialClasses", {socialClass.Name, "Any"});
  return potentialBackgrounds[Random(#potentialBackgrounds)];
end

function GenerateCareer(raceCareers, webCareers, background, socialClass)
  local potentialCareers = {};
  if #webCareers > 0 then
    potentialCareers = FindDataItemsInTableByKey(raceCareers, webCareers);
  else
    potentialCareers = raceCareers;
  end
  potentialCareers = FindDataItemsInTable(potentialCareers, "Backgrounds", {background, "Any"});
  potentialCareers = FindDataItemsNotInTable(potentialCareers, "ExcludedBackgrounds", {background, "Any"});
  potentialCareers = FindDataItemsInTable(potentialCareers, "SocialClasses", {socialClass.Name, "Any"});

  local selectedCareer = potentialCareers[Random(#potentialCareers)];
  return GenerateCareerFromData(selectedCareer);
end

function GenerateCareerFromData(careerData)
  return Career:new({
    Name = careerData.Name,
    Archetype = careerData.Archetype,
    CareerLevel = careerData.CareerLevel,

    Actions = careerData.Actions,
    Traits = careerData.Traits,
    ExitCareers = careerData.ExitCareers,
  });
end

function GetValidBackgroundFromCareers(raceBackgrounds, raceCareers, careers)
  local validBackgrounds = {};
  for key,background in pairs(raceBackgrounds) do
    local validBackground = true;
    for key,career in pairs(careers) do
      local careerData = FindFirstDataInTable(raceCareers, "Name", {career});
      if career.ExcludedBackgrounds and ( AreValuesInList(career.ExcludedBackgrounds, {background.Name}) or AreValuesInList(career.Backgrounds, {background.Name, "Any"}) == false) then
        validBackground = false;
        break;
      end
    end
      
    if validBackground == true  then
      validBackgrounds[#validBackgrounds + 1] = background; 
    end
  end
  
  return validBackgrounds[Random(#validBackgrounds)];
end

function GetValidSocialClassFromCareers(raceSocialClasses, careers)
  local validSocialClasses = {};
  
  for key,career in pairs(careers) do
    for key,socialClass in pairs(career.SocialClasses) do
        validSocialClasses[#validSocialClasses + 1] = FindFirstDataInTable(raceSocialClasses, "Name", {socialClass});
    end
  end
    
  return validSocialClasses[Random(#validSocialClasses)];
end

function GenerateMembershipForFaction(factionData, rank)
  local membershipTraits = GenerateMembershipTraits(factionData, rank);
  return Membership:new({
    FactionName = factionData.Name,
    FactionUUID = factionData.UUID,
    Rank = rank.Name,
    OrdinalRank = rank.Ordinal,
    IsKnownMember = Roll100(rank.StealthValue),
    Traits = membershipTraits,
  });
end

function GenerateMembershipTraits(factionData, rank)
  local traits = {};
  for key, trait in pairs(factionData.Traits) do
    if Roll100(trait.CharacterAppearanceChance) then
      traits[#traits + 1] = trait.Key;
      if trait.IsExclusive then
        break;
      end
    end
  end

  for key, rankTrait in pairs(rank.Traits) do
    if Roll100(rankTrait.CharacterAppearanceChance) then
      traits[#traits + 1] = trait.Key;
      if trait.IsExclusive then
        break;
      end
    end
  end

  return traits;
end

function GenerateTraits(character, raceTraits)
  local traits = GenerateStartingTraitsForCharacter(character, raceTraits);
  traits =  GenerateTraitsForCareers(character, traits, raceTraits);
  traits = GenerateTraitsForFactions(character, traits, raceTraits);
  return traits;
end
  
function GenerateTraitFromData(traitData)
  return Trait:new({
    Name = traitData.Name,
    Key = traitData.Key,
    MutuallyExclusiveTraits = traitData.MutuallyExclusiveTraits,
    StatRequirements = traitData.StatRequirements,
    EventHistoryRequirements = traitData.EventHistoryRequirements,
    GrantedActions = traitData.GrantedActions,
    GrantedStatBonuses = traitData.GrantedStatBonuses,
    EventStatBonuses = traitData.EventStatBonuses,
  });
end

function GenerateStartingTraitsForCharacter(character, raceTraits)
  local validTraits = {};
  for key, trait in pairs(raceTraits) do
    validTraits[#validTraits + 1] = trait;
  end

  local traitData = validTraits[Random(#validTraits)];

  return { GenerateTraitFromData(traitData)};
end

function GenerateTraitsForCareers(character, existingTraits, raceTraits)
  for key1, career in pairs(character.Careers) do
    for key2, careerTrait in pairs(career.Traits) do
      local newTraitData = raceTraits[careerTrait];
      local newTrait = GenerateTraitFromData(newTraitData);
      if newTrait:CanBeApplied(character) then
        existingTraits[#existingTraits + 1] = newTrait;
      end
    end
  end

  return existingTraits;
end

function GenerateTraitsForFactions(character, existingTraits, raceTraits)
  for key1, factionMembership in pairs(character.Memberships) do
    for key2, factionTrait in pairs(factionMembership.Traits) do
      local newTraitData = raceTraits[factionTrait];
      local newTrait = GenerateTraitFromData(newTraitData);
      if newTrait:CanBeApplied(character) then
        existingTraits[#existingTraits + 1] = newTrait;
      end
    end
  end

  return existingTraits;
end