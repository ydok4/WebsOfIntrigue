
function Random(limit)
  return math.random(limit) ; 
end

function RandomRange(min, max)
  return math.random(min, max) ; 
end

function FindFirstDataInTable(table, field, values)
  for key,tableItem in pairs(table) do 
    for key,value in pairs(values) do
      if tableItem[field] and tableItem[field] == value then
        return tableItem;
      end
    end
  end
  
  return nil;
end

function FindDataItemsInTable(table, field, values)
  local items = {};
  
  for key,tableItem in pairs(table) do 
    for key,value in pairs(values) do
      if tableItem[field] and tableItem[field] == value then
        items[#items + 1] = tableItem;
      end
    end
  end
  
  return items;
end

function Roll100(passValue)
  return passValue < Random(100);
end