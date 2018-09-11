Event = {
    Key = {},
    NamePool = {},
    -- Province or settlement
    Type = "",
    Priority = 0,
    ScopeLimits = {},
    ResultPool = {},
    CanApplyEvent = {},
    CachedDataFunction = {},
  }

function Event:new (o)
  o = o or {};
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function Event:IsEventForScope(scope)
  return self.Scope == scope;
end

function Event:IsEventForType(type)
  return self.Type == type;
end

function Event:IsThereResultForScope(scope)
  for key, result in pairs(self.ResultPool) do
    if AreValuesInList(result.Scopes, {scope}) then
      return true;
    end
  end

  return false;
end

function Event:FindResultForScope(object, scope, cachedData)
  local validResults = {};
  for key, result in pairs(self.ResultPool) do
      if AreValuesInList(result.Scopes, {scope}) and self.CheckResultIsValid(self, object, result, cachedData) then
        validResults[#validResults + 1] = result;
      end
  end
  if #validResults > 0 then
    if #validResults == 1 then
      return GetRandomObjectFromList(validResults);
    end
    local equalHighestPriorityResults = GetHighestPriorityResults(validResults);
    return GetRandomObjectFromList(equalHighestPriorityResults);
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