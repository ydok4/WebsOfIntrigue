woi = _G.woi;

function CreateCharacterDetailsPanel(frame, container, characterUUID)
    Custom_Log("Creating character details panel");
    local character = woi:GetCharacterByUUID(characterUUID);

    local firstHorizontalContainer = Container.new(FlowLayout.HORIZONTAL);
    firstHorizontalContainer:AddComponent(Text.new("NameHeading", frame, "NORMAL", "Name: "));
    firstHorizontalContainer:AddComponent(Text.new("CharNameText", frame, "NORMAL", character:GetCharacterName()));

    local secondHorizontalContainer = Container.new(FlowLayout.HORIZONTAL);
    secondHorizontalContainer:AddComponent(Text.new("CareerHeading", frame, "NORMAL", "Careers: "));
    secondHorizontalContainer:AddComponent(Text.new("CareerText", frame, "NORMAL", character:GetCareerListText()));

    local thirdHorizontalContainer = Container.new(FlowLayout.HORIZONTAL);
    thirdHorizontalContainer:AddComponent(Text.new("FactionHeading", frame, "NORMAL", "Factions: "));
    thirdHorizontalContainer:AddComponent(Text.new("FactionText", frame, "NORMAL", character:GetFactionMemberships()));

    container:AddComponent(firstHorizontalContainer);
    container:AddComponent(secondHorizontalContainer);
    container:AddComponent(thirdHorizontalContainer);
end