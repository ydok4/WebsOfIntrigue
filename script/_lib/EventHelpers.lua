require 'script/_lib/MVC/Models/Event'
require 'script/_lib/MVC/Models/EventChain'

function LoadEventResources(raceResources)
    local eventObjects = {};
    for key, eventSchema in pairs(raceResources) do
        local mappedEvent = MapEventData(eventSchema)
        eventObjects[mappedEvent.Key] = mappedEvent;
    end
    -- TODO: Combine the valid generic events with the race revents
    return eventObjects;
end

function MapEventData(eventSchema)
    return Event:new({
        Key = eventSchema.Key,
        NamePool = eventSchema.NamePool,
        Type = eventSchema.Type,
        Priority = eventSchema.Priority,
        ScopeLimits = eventSchema.ScopeLimits,
        ResultPool = eventSchema.ResultPool,
        CanApplyEvent = eventSchema.CanApplyEvent,
        CachedDataFunction = eventSchema.CachedDataFunction,
    });
end

function GetHighestPriorityResults(results)
    local highestPriorityResults = {};
    local highestPriorityNumber = 0;
    for key, result in pairs(results) do
        if result.Priority == highestPriorityNumber then
            highestPriorityResults[#highestPriorityResults + 1] = result;
        elseif result.Priority > highestPriorityNumber then
            highestPriorityResults = {};
            highestPriorityResults[#highestPriorityResults + 1] = result;
            highestPriorityNumber = result.Priority
        end
    end
    return highestPriorityResults;
end

function GenerateEventChain(event, result, currentTurn, object)
    local nextEventData = {};
    if result.NextEvent.EventChainKey then
       nextEventData = {
            EventKey = result.NextEvent.EventKey,
            TurnNumber = (result.NextEvent.TurnNumber + currentTurn),
        };
    end

    return EventChain:new({
        Key = result.NextEvent.EventChainKey,
        Object = object,
        ElapsedEvents = {
            {EventKey = event.Key, ResultKey = result.Key, TurnNumber = currentTurn,}
        },
        NextEvent = nextEventData,
    });
end

function ConvertEventChainToCompletedChain(eventChain)
    local eventChainConverted = eventChain;
    eventChainConverted.NextEvent = nil;

    return eventChainConverted;
end