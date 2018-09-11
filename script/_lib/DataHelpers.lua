
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

function FindDataItemsInTableByKey(table, values)
  local items = {};
  
  for key2,value in pairs(values) do
    if table[value] then 
      items[#items + 1] = table[value];
    end
  end
  
  if #items == 0 then
    return nil;
  end
  return items;
end

function FindDataItemsInTable(table, field, values)
  local items = {};
  
  for key1,tableItem in pairs(table) do 
    for key2,value in pairs(values) do
      if tableItem[field] then 
        if type(tableItem[field]) == 'table' then
          if AreValuesInList(tableItem[field], values) then
            items[#items + 1] = tableItem;
            break;
          end
        elseif tableItem[field] == value then
          items[#items + 1] = tableItem;
          break;
        end
      end
    end
  end
  if #items == 0 then
    return nil;
  end
  return items;
end

function AreValuesInList(list, values, doLog)
  for key1,listItem in pairs(list) do
    for key2,value in pairs(values) do
      if doLog then
        Custom_Log("listItem: "..listItem.." value: "..value);
      end
      if listItem == value then
        return true;
      end
    end
  end
  return false;
end

function FindDataItemsNotInTable(table, field, values)
  local items = {};
  
  for key,tableItem in pairs(table) do 
    for key,value in pairs(values) do
      if tableItem[field] and tableItem[field] ~= value then
        items[#items + 1] = tableItem;
        break;
      end
    end
  end
  
  if #items == 0 then
    return nil;
  end
  return items;
end

function TableLength(table)
  local count = 0;
  for key in pairs(table) do
    count = count + 1;
  end
  return count;
end

function TableHasValue(table)
  for key in pairs(table) do
    return true;
  end
  return false;
end

function TableConcat(table1, table2)
  for i=1, #table2 do
    table1[#table1 + 1] = table2[i];
  end
  return table1;
end

function TableConcatByKeyWithUUID(table1, table2)
  for key, value in  pairs(table2) do
    table1[value.UUID] = value;
  end
  return table1;
end

function SortByAppearanceChance(a, b)
  return a.AppearanceChance < b.AppearanceChance
end

function Roll100(passValue)
  return Random(99) < passValue;
end

function GenerateUUID()
local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end);
end

function GetRandomObjectFromList(objectList)
    local tempTable = {}
    for key, value in pairs(objectList) do
      tempTable[#tempTable + 1] = key; --Store keys in another table
    end
    local index = tempTable[Random(#tempTable)];
    return objectList[index];
end