
local myname, ns = ...


local function OnLogin()
  for i,v in pairs(ns) do
    if i:match("^Create") then ns[i] = nil end
  end
end


ns.RegisterCallback("_THIS_ADDON_LOADED", ns.CreatePanel)
ns.RegisterCallback("PLAYER_LOGIN", OnLogin)
