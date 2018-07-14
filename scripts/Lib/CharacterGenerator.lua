require 'scripts/Lib/DataHelpers'

function GenerateGender(isSexless)
  if isSexless and isSexless == true then
    return "Sexless";
  else
    if Random(2) == 0 then
      return "Male"
    else
      return "Female"
    end
  end
end

function GenerateSocialClass(raceSocialClasses, webWealth)
  for key,socialClass in pairs(raceSocialClasses) do
    if Roll100(raceSocialClasses.Chance) then
        return socialClass["Name"];
    end
  end
end

function GenerateName(raceNames, gender);
  local genderNames = FindDataItemsInTable(raceNames, "Gender", {gender, "Both"});
  local genderFirstNames = FindDataItemsInTable(genderNames, "Type", "FirstName");
  local genderSurnames = FindDataItemsInTable(genderNames, "Type", "Surname");
  
  local firstName = genderFirstNames[Random(#genderFirstNames)];
  local surname = genderSurnames[Random(#genderSurnames)];
end