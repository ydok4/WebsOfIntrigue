require 'script/_lib/DataHelpers'

require 'script/_lib/MVC/Models/Event'

function LoadEventResources(raceResources)
    local eventObjects = {};
    for key, eventSchema in pairs(raceResources) do
        eventObjects[#eventObjects + 1] = MapEventData(eventSchema);
    end
    -- TODO: Combine the valid generic events with the race revents 
    return eventObjects;
end

function MapEventData(eventSchema)
    return Event:new({
        Key = eventSchema.Key,
        NamePool = eventSchema.NamePool,
        Scope = eventSchema.Scope,
        ResultPool = eventSchema.ResultPool,
        CanApplyEvent = eventSchema.CanApplyEvent,
        CachedDataFunction = eventSchema.CachedDataFunction,
    });
end