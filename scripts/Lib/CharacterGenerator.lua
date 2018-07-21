require 'scripts/Lib/DataHelpers'

function GenerateGender(isSexless, careers)
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
      if Random(2) == 0 then
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
end

function GenerateName(raceNames, gender);
  local genderNames = FindDataItemsInTable(raceNames, "Gender", {gender, "Both"});
  local genderFirstNames = FindDataItemsInTable(genderNames, "Type", {"FirstName"});
  local genderSurnames = FindDataItemsInTable(genderNames, "Type", {"Surname"});
  
  local firstNameData = genderFirstNames[Random(#genderFirstNames)];
  local surnameData = genderSurnames[Random(#genderSurnames)];
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