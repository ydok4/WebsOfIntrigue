function Custom_Log(text)
  local logText = tostring(text);
  local logContext = tostring(ftext);
  local logTimeStamp = os.date("%d, %m %Y %X");
  local popLog = io.open("Intrigue_Log.txt","a");

  popLog :write("woi:  "..logText .. "    : [" .. logContext .. "] : [".. logTimeStamp .. "]\n");
  popLog :flush();
  popLog :close();
end