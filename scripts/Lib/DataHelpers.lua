
function Random(limit)
  return math.random(limit) ; 
end

function FindDataInTable(table, field, value)
  for key,tableItem in pairs(table) do 
    if tableItem[field] and tableItem[field] == value then
      return tableItem;
    end
  end
  
  return nil;
end