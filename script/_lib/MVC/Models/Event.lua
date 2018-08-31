require 'script/_lib/DataHelpers'

Event = {
    Key = {},
    NamePool = {},
    Scope = "",
    ResultPool = {},
    CanApplyEvent = {},
  }

function Event:new (o)
  o = o or {};
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function Event:IsThereResultForWebType(webType)
  for key, result in pairs(self.ResultPool) do
    if result.Scope == webType then
      return true;
    end
  end

  return false;
end

function Event:FindResultsForScope(scope)
  local validResults = {};
  for key, result in pairs(self.ResultPool) do
      if  result.Scope == scope then
        validResults[#validResults + 1] = result;
      end
  end
  if #validResults > 0 then
    return validResults;
  end
  return nil;
end

function Event:CheckResultIsValid(object, result, cacheData)
  if result.CanApplyResult(object, cacheData) then
        return true;
  end

  return false;
end

function Event:GenerateResult()

end

function Event:CanApplyResult()

end