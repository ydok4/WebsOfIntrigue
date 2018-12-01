  woi = _G.woi;
  
  Membership = {
    FactionUUID = "",
    RankUUID = "",
    IsKnownMember = true,
  }

function Membership:new (o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end

function Membership:GetFormmatedFactionNameAndRank()
  local faction = woi:GetFactionByUUID(self.FactionUUID);
  local rank = faction:GetRankByUUID(self.RankUUID);
  return faction.Name..", Rank: "..rank.Name;
end