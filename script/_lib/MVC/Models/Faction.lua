Faction = {
  UUID = "",
  ParentWebUUID = "",
  Name = "",
  -- Name Object
  GrantedNameOverride = nil,
  TemplateType = "",
  ParentName = "",
  Types = {},
  Ranks = {},
  SupportedBackgrounds = {},
  SocialClassModifier = 0,
  MemberCharacters = {},
  Traits = {},
  Goals = {},
  Actions = {},
}
  
function Faction:new (o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end

function Faction:SetCharacterAsRank(character, rank)
  local factionRank = FindFirstDataInTable(self.Ranks, "Name", {rank.Name, });
  factionRank.CharacterUUIDs[#factionRank.CharacterUUIDs + 1] = character.UUID;
end

function Faction:IsRankPositionAvailable(rank)
  local rankWeAreChecking = FindFirstDataInTable(self.Ranks, "Name", {rank.Name, });
  if rankWeAreChecking then
    if #rankWeAreChecking.CharacterUUIDs < rankWeAreChecking.Limit or rankWeAreChecking.Limit == 0 then
      return true;
    end
  end
  return false;
end

function Faction:HasType(type)
  return AreValuesInList(self.Types, {type});
end

function Faction:IsCharacterAMember(character)
  return AreValuesInList(self.MemberCharacters, {character.UUID});
end

function Faction:GetCharacterRank(character)
  if character.Memberships[self.UUID] then
    for key, rank in pairs(self.Ranks) do
      if AreValuesInList(rank.CharacterUUIDs, {character.UUID}) then
        return rank;
      end
    end
  end
  return nil;
end