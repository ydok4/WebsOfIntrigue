require 'script/campaign/mod/webs_of_intrigue'

math.randomseed(os.time())

-- This is used in game by Warhammer but we have it hear so it won't throw errors when running
-- in ZeroBrane IDE
function Custom_Log(text)
  print(text);
end

webs_of_intrigue(true);