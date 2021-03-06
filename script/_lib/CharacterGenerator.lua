require 'script/_lib/MVC/Models/Name'
require 'script/_lib/MVC/Models/Membership'

require 'script/_lib/DataHelpers'

function GenerateGender(isSexless, careers, raceCareers)
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
      if Random(2) == 2 then
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
  for key,socialClass in pairs(raceSocialClasses) do
    if Roll100(socialClass["AppearanceChance"] + socialClassModifier) then
        return socialClass;
    end
  end
  return 
end

function GenerateName(raceNames, gender)
  local genderNames = FindDataItemsInTable(raceNames, "Gender", {gender, "Both"});
  local genderFirstNames = FindDataItemsInTable(genderNames, "Type", {"FirstName"});
  local genderSurnames = FindDataItemsInTable(genderNames, "Type", {"Surname"});
  
  local firstNameData = genderFirstNames[Random(#genderFirstNames)];
  local surnameData = genderSurnames[Random(#genderSurnames)];
  
  return Name:new({
    FirstName = firstNameData.Name,
    Surname = surnameData.Name,
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

  return potentialCareers[Random(#potentialCareers)];
end

function GetValidBackgroundFromCareers(raceBackgrounds, raceCareers, careers)
  local validBackgrounds = {};
  for key,background in pairs(raceBackgrounds) do
    local validBackground = true;
    for key,career in pairs(careers) do
      local careerData = FindFirstDataInTable(raceCareers, "Name", {career});
      if career.ExcludedBackgrounds and AreValuesInList(career.ExcludedBackgrounds, {background}) then
        validBackground = false;
        break;
      end
    end
      
    if validBackground == true then
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

function GenerateMembershipForFaction(faction, rank, webUUID)
  local memberships = {};
  memberships[#memberships + 1] = Membership:new({
    FactionName = faction,
    WebUUID = webUUID,
    Rank = rank.Name,
    IsKnownMember = Roll100(rank.StealthValue),
  });
  return memberships;
end