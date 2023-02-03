require("natives-1606100775")
script = {}


_natives_PLAYER = PLAYER
_natives_NETWORK = NETWORK
_natives_ENTITY = ENTITY
player = {

  ["get_player_ped"] =
  function(player)
    -- if player == players.user() then return _natives_PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(-1) end 
    return _natives_PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
  end,

  ["get_player_coords"] =
  function(player)
    return _natives_ENTITY.GET_ENTITY_COORDS(_natives_PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player), true)
  end,
  
}


ptoggle1 = {}
for a=0, 30 do 
  ptoggle1[a] = false
end

ptoggle2 = {}
for a=0, 30 do 
  ptoggle1[a] = false
end

ptoggle3 = {}
for a=0, 30 do 
  ptoggle1[a] = false
end

ptoggle4 = {}
for a=0, 30 do 
  ptoggle1[a] = false
end

ptoggle5 = {}
for a=0, 30 do 
  ptoggle1[a] = false
end

ptoggle6 = {}
for a=0, 30 do 
  ptoggle1[a] = false
end

ptoggle7 = {}
for a=0, 30 do 
  ptoggle1[a] = false
end

ptoggle8 = {}
for a=0, 30 do 
  ptoggle1[a] = false
end

ptoggle9 = {}
for a=0, 30 do 
  ptoggle1[a] = false
end

ptoggle10 = {}
for a=0, 30 do 
  ptoggle1[a] = false
end

ptoggle11 = {}
for a=0, 30 do 
  ptoggle1[a] = false
end

ptoggle12 = {}
for a=0, 30 do 
  ptoggle1[a] = false
end

tabble_ladder = {attach}
table_entity = {attach}
table_gravity = {attach}
table_kidnap = {veh_to_attach}
veh_attach = {attach}
table_veh   = {"adder", "buzzard", "cargobob","dinghy","banshee" ,"frogger","zentorno" }
table_ped = { "a_c_boar","a_c_deer","a_c_chop","a_c_chimp","a_c_cow","a_c_mtlion","a_c_rabbit_01","a_c_husky", }
--table_ped_to_attach = {ped_to_attach_crash}

GenerateFeatures = function(pid) 
menu.divider(menu.player_root(pid),"Bunny Lua")
parent  = menu.list(menu.player_root(pid), "Frendly" ,{}, "", function();end)
parent2 = menu.list(menu.player_root(pid), "Griefing", {}, "", function();end)

ladder =     1888301071
ground =    -1951226014
attach = 1 
veh_to_attach = 1

function v3(x, y, z)
  if x == nil then x = 0 end
  if y == nil then y = 0 end
  if z == nil then z = 0 end
end

function vehicle_gun(  pid)  
  local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
  coords_ptr = memory.alloc()

  if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(player_ped, coords_ptr) then


   model_name = table_veh[math.random(#table_veh)]
   veh_hash  =  util.joaat(model_name)

   while not STREAMING.HAS_MODEL_LOADED(veh_hash) do
    STREAMING.REQUEST_MODEL(veh_hash)
    util.yield()
  end
  

  WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(player_ped, coords_ptr)
  local coords = memory.read_vector3(coords_ptr)

  table_entity[attach] = util.create_vehicle(veh_hash, coords ,CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
  util.toast(os.date("%H:%M:%S").." model_name "..model_name.." veh_hash "..veh_hash.." veh "..table_entity[attach], TOAST_ABOVE_MAP)
  STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_hash)

  attach = attach + 1

  memory.free(coords_ptr)
end
util.yield()
end


function ped_gun(  pid)  
  local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
  coords_ptr = memory.alloc()

  if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(player_ped, coords_ptr) then

   model_name = table_ped[math.random(#table_ped)]
   ped_hash  =  util.joaat(model_name)
   while not STREAMING.HAS_MODEL_LOADED(ped_hash) do
    STREAMING.REQUEST_MODEL(ped_hash)
    util.yield()
  end
  
  WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(player_ped, coords_ptr)
  local coords = memory.read_vector3(coords_ptr)

  table_entity[attach] = util.create_ped(28, ped_hash, coords ,CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
  util.toast(os.date("%H:%M:%S").." model_name "..model_name.." ped_hash "..ped_hash.." veh "..table_entity[attach], TOAST_ABOVE_MAP)
  STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)

  attach = attach + 1

  memory.free(coords_ptr)
end
util.yield()
end





function delet_entity(entity)
  entitypointer = memory.alloc(24)
  memory.write_int(entitypointer, entity)
  bool = ENTITY.DELETE_ENTITY(entitypointer)
  memory.free(entitypointer)
  return bool
end

function explosion(explosion_type, pid)  


  coords_ptr = memory.alloc()


  local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
  if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(player_ped, coords_ptr) then
    local coords = memory.read_vector3(coords_ptr)
    FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, explosion_type, 1, true, false, 0, pid)

    util.yield()
  end
  memory.free(coords_ptr)
end

function ladder_attach(hash, xPos, zPos, yPos, xRot, yRot, zRot, visible, pid)
 while not STREAMING.HAS_MODEL_LOADED(hash) do
  STREAMING.REQUEST_MODEL(hash)      
  util.yield()
end

playerped3      = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
tabble_ladder[attach] = OBJECT.CREATE_OBJECT(hash, 1.55,3.35,0, true, true)

ENTITY.ATTACH_ENTITY_TO_ENTITY(tabble_ladder[attach], playerped3, 0, xPos, zPos, yPos, xRot, zRot, yRot, false, true, true, false, 0, false)
ENTITY.SET_ENTITY_VISIBLE(tabble_ladder[attach], visible)

STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
attach = attach + 1
end

function attach_spam(model_name)
  
  hash = util.joaat(model_name)
  STREAMING.REQUEST_MODEL(hash) 

  STREAMING.IS_MODEL_A_VEHICLE(hash) 

  table_gravity[attach] = util.create_vehicle(hash, ENTITY.GET_ENTITY_COORDS(V3, true), CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
  VEHICLE.SET_VEHICLE_GRAVITY( table_gravity[attach], false)

  ENTITY.SET_ENTITY_INVINCIBLE(table_gravity[attach], true)
  ENTITY.ATTACH_ENTITY_TO_ENTITY(table_gravity[attach], ped_to_attach, 0, 0, 0, 0, 0, 0, 0, false, true, true, false, 0, false)
  ENTITY.SET_ENTITY_VISIBLE(table_gravity[attach], true)
  STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)

  attach = attach + 1

  util.yield()
end

function attach_vehicle(model_name, pid )
  vzRot = 0
  local V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
  local veh_hash = util.joaat(model_name)
  if STREAMING.IS_MODEL_A_VEHICLE(veh_hash) then
    STREAMING.REQUEST_MODEL(veh_hash)
    while not STREAMING.HAS_MODEL_LOADED(veh_hash) do
      util.yield()
    end
    veh_attach[attach] = util.create_vehicle(veh_hash, ENTITY.GET_ENTITY_COORDS(V3, true), CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(veh_attach[attach], V3, 0, 0, 0, 0, 0, 0, vzRot, false, true, true, false, 0, false)
    ENTITY.SET_ENTITY_VISIBLE(veh_attach[attach], true)
    attach = attach + 1

  end
end


menu.action(parent2,"Gravity", {}, "", function(on) -- This function creates the button inside Stand
 V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
 ped_name1 = "csb_abigail"
 ped_hash = util.joaat(ped_name1)

 while not STREAMING.HAS_MODEL_LOADED(ped_hash)do
  STREAMING.REQUEST_MODEL(ped_hash)
  util.yield()
end
oob = v3() 
oob = player.get_player_coords(pid)
oob.x = -1324
oob.y = -2971
oob.z = 16

ped_to_attach = util.create_ped(28, ped_hash, oob, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
ENTITY.FREEZE_ENTITY_POSITION(ped_to_attach, true)

STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)
STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)

ENTITY.SET_ENTITY_INVINCIBLE(ped_to_attach, true)
attach = 1
util.toast(os.date("%H:%M:%S").." Vehicle loading.", TOAST_ABOVE_MAP)   

for n=1, 4 do
 attach_spam("adder")
 attach_spam("buzzard")
 attach_spam("frogger")
 attach_spam("dinghy")
 attach_spam("dilettante")
 attach_spam("asterope")
 attach_spam("banshee")
 attach_spam("zentorno")
 attach_spam("guardian")
 attach_spam("swift")

end
util.toast(os.date("%H:%M:%S").." Vehicle loaded.", TOAST_ABOVE_MAP)    


local player_pedv3 = PLAYER.PLAYER_PED_ID()

util.yield(100)

coordsped = ENTITY.GET_ENTITY_COORDS(V3, true)
util.yield(20)
ENTITY.SET_ENTITY_COORDS(ped_to_attach, coordsped.x + 2, coordsped.y + 2 , coordsped.z   , false, false, false, true )
util.yield(100)
ENTITY.DETACH_ENTITY(ped_to_attach, true, true)
util.yield(100)
delet_entity(ped_to_attach)
util.toast(os.date("%H:%M:%S").." vehicle send.", TOAST_ABOVE_MAP)    

util.yield(15000)
util.toast(os.date("%H:%M:%S").." Clean up attempt.", TOAST_ABOVE_MAP)    

for n = 1, #table_gravity do
 delet_entity(table_gravity[n])
end
util.toast(os.date("%H:%M:%S").."Clean up done.", TOAST_ABOVE_MAP)    
end)


menu.action(parent2, "Kidnap", {}, "", function(on_click)
  V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

  hash = util.joaat("stockade")
  ped_hash = util.joaat("csb_abigail")

  if   STREAMING.IS_MODEL_A_VEHICLE(hash) then
    STREAMING.REQUEST_MODEL(hash)

    while not STREAMING.HAS_MODEL_LOADED(hash) do
      util.yield()
    end


    coords_ped = ENTITY.GET_ENTITY_COORDS(V3, true)

    aab = v3() 
    aab = player.get_player_coords(pid)
    aab.x = -5784.258301
    aab.y = -8289.385742
    aab.z = -136.411270
    

    ENTITY.SET_ENTITY_VISIBLE( ped_to_kidnap, false)
    ENTITY.FREEZE_ENTITY_POSITION(ped_to_kidnap, true)

    table_kidnap[veh_to_attach] = util.create_vehicle(hash, ENTITY.GET_ENTITY_COORDS(V3, true), CAM.GET_FINAL_RENDERED_CAM_ROT(0).z)
    while not STREAMING.HAS_MODEL_LOADED(ped_hash) do
      STREAMING.REQUEST_MODEL(ped_hash)
      util.yield()
    end
    ped_to_kidnap = util.create_ped(28 ,ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
    ped_to_drive  = util.create_ped(28 ,ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)


    ENTITY.SET_ENTITY_INVINCIBLE(ped_to_drive, true)
    ENTITY.SET_ENTITY_INVINCIBLE(table_kidnap[veh_to_attach], true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(table_kidnap[veh_to_attach], ped_to_kidnap, 0, 0, 1, -1, 0, 0, 0, false, true, true, false, 0, false)
    ENTITY.SET_ENTITY_COORDS(ped_to_kidnap, coords_ped.x , coords_ped.y  , coords_ped.z - 1  , false, false, false, false )
    PED.SET_PED_INTO_VEHICLE(ped_to_drive, table_kidnap[veh_to_attach],-1)
    TASK.TASK_VEHICLE_DRIVE_WANDER(ped_to_drive, table_kidnap[veh_to_attach], 20,16777216)

    util.yield(500)

    delet_entity(ped_to_kidnap)
    veh_to_attach = veh_to_attach + 1

    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)

    util.toast(os.date("%H:%M:%S").." DONE", TOAST_ABOVE_MAP)     

  end

end)


menu.action(parent2, "World of Tank", {}, "", function(on_click)
  V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

  hash = util.joaat("rhino")
  ped_hash = util.joaat("csb_abigail")

  if   STREAMING.IS_MODEL_A_VEHICLE(hash) then
    STREAMING.REQUEST_MODEL(hash)

    while not STREAMING.HAS_MODEL_LOADED(hash) do

      util.yield()
    end

    aab = v3() 
    aab = player.get_player_coords(pid)
    aab.x = -5784.258301
    aab.y = -8289.385742
    aab.z = -136.411270
    

    ENTITY.SET_ENTITY_VISIBLE( ped_to_kidnap, false)
    ENTITY.FREEZE_ENTITY_POSITION(ped_to_kidnap, false)

    table_kidnap[veh_to_attach] = util.create_vehicle(hash, ENTITY.GET_ENTITY_COORDS(V3, true), CAM.GET_FINAL_RENDERED_CAM_ROT(0).z)
    while not STREAMING.HAS_MODEL_LOADED(ped_hash) do
      STREAMING.REQUEST_MODEL(ped_hash)
      util.yield()
    end
    ped_to_kidnap = util.create_ped(28 ,ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
    ped_to_drive  = util.create_ped(28 ,ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)


    ENTITY.SET_ENTITY_INVINCIBLE(table_kidnap[veh_to_attach], true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(table_kidnap[veh_to_attach], ped_to_kidnap, 0, 0, 1, -1, 0, 0, 0, false, true, true, false, 0, false)

    coords_ped = v3()
    coords_ped = ENTITY.GET_ENTITY_COORDS(V3, true)
    coords_ped.x = coords_ped.x + math.random(-20,20)
    coords_ped.y = coords_ped.y + math.random(-20,20)
    coords_ped.z = coords_ped.z 

    ENTITY.SET_ENTITY_COORDS(ped_to_kidnap, coords_ped.x  , coords_ped.y   , coords_ped.z    , false, false, false, false )
    PED.SET_PED_INTO_VEHICLE(ped_to_drive, table_kidnap[veh_to_attach],-1)

    VEHICLE.SET_VEHICLE_ENGINE_ON(table_kidnap[veh_to_attach],true ,true, false)
    TASK.TASK_VEHICLE_SHOOT_AT_PED(ped_to_drive,V3,1)
    TASK.TASK_VEHICLE_CHASE(ped_to_drive, V3)


    util.yield(1)
    delet_entity(ped_to_kidnap)
    veh_to_attach = veh_to_attach + 1

    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)

    util.toast(os.date("%H:%M:%S").." DONE", TOAST_ABOVE_MAP) 
  end

end)

menu.action(parent2, "Ladder", {}, "", function(on_click)
  ladder_attach(ladder,   0.8 ,  3.55,    0   , 1.55  ,  1.55  ,  3.35 , false, pid)
  ladder_attach(ladder,  -0.8 , -3.55,    0   , 1.55  ,  181.55,  3.35 , false, pid)
  ladder_attach(ladder,  -3.55,  1   ,    0   , 1.55  ,  91.55 ,  3.35 , false, pid)
  ladder_attach(ladder,  -3.55,  0.9 ,    0   , 1.55  ,  91.55 ,  3.35 , false, pid)
  ladder_attach(ground,   0   ,  0   ,   -2   , 0     ,  0     , -2    , false, pid)
  util.toast(os.date("%H:%M:%S").." Ladder Attached ", TOAST_ABOVE_MAP)


end) 


menu.toggle(parent,"Give fire ammo", {}, "", function(on) 
 if on then 
  ptoggle1[pid] = true 
else 
  ptoggle1[pid] = false 
end 
end)

menu.toggle(parent,"Give explosive  ammo", {}, "", function(on) 
 if on then 
  ptoggle2[pid] = true 
else 
  ptoggle2[pid] = false 
end 
end)

menu.toggle(parent,"Give veh ammo", {}, "", function(on) 
 if on then 
  ptoggle3[pid] = true 
else 
  ptoggle3[pid] = false 
end 
end)

menu.toggle(parent,"Give ped ammo", {}, "", function(on) 
 if on then 
  ptoggle4[pid] = true 

else 
  ptoggle4[pid] = false 
end 
end)

menu.toggle(parent2, "Attach_vehicle", {}, "", function(on)
  if on then 
    ptoggle5[pid] = true 
  else 
    ptoggle5[pid] = false 
  end
  
end)
 

end

menu.action(menu.my_root(), "Respawn My Ped Button", {}, "", function(on_click)
  local V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
  local V2 = PLAYER.PLAYER_PED_ID()
  myLocation = v3()
  myLocation = ENTITY.GET_ENTITY_COORDS(V2, true)
  myLocation.x =   myLocation.x   
  myLocation.y =   myLocation.y
  myLocation.z =   myLocation.z

  util.toast(os.date("%H:%M:%S").." location.x "..myLocation.x, TOAST_ABOVE_MAP)

  myHeading = ENTITY.GET_ENTITY_HEADING(V2)
  util.toast(os.date("%H:%M:%S").." entity heading "..myHeading, TOAST_ABOVE_MAP)

  myModelhash = ENTITY.GET_ENTITY_MODEL(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()))
  util.toast(os.date("%H:%M:%S").." entity model "..myModelhash, TOAST_ABOVE_MAP)

  myClone = PED.CREATE_PED(26, myModelhash, myLocation.x, myLocation.y, myLocation.z, myHeading,false,false)
  util.toast(os.date("%H:%M:%S").." my clone "..myClone, TOAST_ABOVE_MAP)
  clone_pos = v3()
  clone_pos = ENTITY.GET_ENTITY_COORDS(myClone, true)
  clone_pos.x   =        clone_pos.x
  clone_pos.y  =      clone_pos.y           
  clone_pos.z   =        clone_pos.z
  util.toast(os.date("%H:%M:%S").." my clone pos "..clone_pos.x.." "..clone_pos.y, TOAST_ABOVE_MAP)
  util.yield(100)
  myPed = V2
  util.toast(os.date("%H:%M:%S").." my ped "..myPed, TOAST_ABOVE_MAP)

  PED.CLONE_PED_TO_TARGET(myPed, myClone)
  util.yield(400)
  PLAYER.CHANGE_PLAYER_PED(players.user(), myClone, false, false)
  util.toast(os.date("%H:%M:%S").." PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID()) "..PLAYER.GET_PLAYER_PED_SCRIPT_INDEX().." "..clone_pos.y, TOAST_ABOVE_MAP)



end)

menu.action(menu.my_root(), "Clean", {}, "", function(on)
 util.toast(os.date("%H:%M:%S").." Clean attempt ", TOAST_ABOVE_MAP)

 for n = 1 , #table_entity do
  delet_entity(table_entity[n])
end

 for n = 1 , #table_gravity do
  delet_entity(table_gravity[n])
end


 for n = 1 , #tabble_ladder do
  delet_entity(tabble_ladder[n])
end

for n = 1 , #veh_attach do
  delet_entity(veh_attach[n])
end


util.toast(os.date("%H:%M:%S").." Clean done ", TOAST_ABOVE_MAP)
end)    




for pid = 0,30 do 
  if players.exists(pid) then 
   GenerateFeatures(pid)
 end
end
players.on_join(GenerateFeatures)

while true do 



  for pid=0, 30 do 

   if ptoggle1[pid] and players.exists(pid) then  

    explosion(3 ,pid)
    util.yield()
  end       
end   

for pid=0, 30 do 

 if ptoggle2[pid] and players.exists(pid) then  

  explosion(1 ,pid)
  util.yield()
end       
end   

for pid=0, 30 do 

 if ptoggle5[pid] and players.exists(pid) then

  attach_vehicle("adder" ,pid)
  attach_vehicle("zentorno", pid)
  attach_vehicle("buzzard", pid)
  attach_vehicle("bullet", pid)
  attach_vehicle("frogger", pid)
  attach_vehicle("blista", pid)
  attach_vehicle("cargobob", pid)
  attach_vehicle("dinghy", pid )
  attach_vehicle("dilettante", pid )
  attach_vehicle("asterope", pid )
  attach_vehicle("banshee", pid ) 
  util.yield()
end 
end


for pid = 0,30 do 
  if ptoggle3[pid] and players.exists(pid) then
    vehicle_gun(pid)

    if #table_entity == 50 then
      util.toast(os.date("%H:%M:%S").." clean", TOAST_ABOVE_MAP)   
      for n = 1 , #table_entity do
        delet_entity(table_entity[n])
      end
      if #table_entity == 50 then 
        table_entity = {}
        attach = 1
      end

    end

  end


  for pid = 0,30 do 
    if ptoggle4[pid] and players.exists(pid) then
      ped_gun(pid)

      if #table_entity == 20 then
        util.toast(os.date("%H:%M:%S").." clean", TOAST_ABOVE_MAP)   
        for n = 1 , #table_entity do
          delet_entity(table_entity[n])
        end
        if #table_entity == 50 then 
          table_entity = {}
          attach = 1
        end

      end

    end

  end


  

end     
util.yield()    
end