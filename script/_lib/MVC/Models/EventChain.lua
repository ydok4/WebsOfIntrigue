require 'script/_lib/DataHelpers'

EventChain = {
    Key = "",
    Object = "",
    ElapsedEvents = {
        {EventKey = "", ResultKey = "", TurnNumber = 0,}
    },
    NextEvent = {},
}

function EventChain:new (o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function EventChain:CheckAndAdvanceNextEvent()

end

function EventChain:AddResultToEventChain(event, result, currentTurn)
    self.ElapsedEvents[#self.ElapsedEvents + 1] =  {
        EventKey = event.Key,
        ResultKey = result.Key,
        TurnNumber = currentTurn,
    };
    if result.NextEvent.EventChainKey then
        self.NextEvent = {
             EventKey = result.NextEvent.EventKey,
             TurnNumber = (result.NextEvent.TurnNumber + currentTurn),
         };
     end
end