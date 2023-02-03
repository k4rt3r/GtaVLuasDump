require("natives-1606100775")

ptoggle1 = {}
for a=0, 30 do 
    ptoggle1[a] = false
end

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

function v3(x, y, z)
    if x == nil then x = 0 end
    if y == nil then y = 0 end
    if z == nil then z = 0 end
end

table_entity = {attach}
attach = 1
GenerateFeatures = function(pid)

function delet_entity(entity)
    entitypointer = memory.alloc(24)
    memory.write_int(entitypointer, entity)
    bool = ENTITY.DELETE_ENTITY(entitypointer)
    memory.free(entitypointer)
    return bool
end
-- body
function attach_entity(model_name, pid)
   vzRot = 0
   local V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
   local hash = util.joaat(model_name)
        STREAMING.REQUEST_MODEL(hash) 


STREAMING.IS_MODEL_A_PED(hash) 
         table_entity[attach]  = util.create_ped(28 ,hash, ENTITY.GET_ENTITY_COORDS(V3, true), CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
         PED.SET_PED_GRAVITY(table_entity[attach], false)
    ENTITY.SET_ENTITY_INVINCIBLE( table_entity[attach], false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY( table_entity[attach], ped_to_attach, 0, 0, 0, 0, 0, 0, vzRot, false, true, true, false, 0, false)
    ENTITY.SET_ENTITY_VISIBLE( table_entity[attach], true)
    attach = attach + 1
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
    util.yield()

end

menu.divider(menu.player_root(pid),"Bunny Lua")
parent  = menu.list(menu.player_root(pid), "Crash" ,{}, "", function();end)



oob = v3() 
oob = player.get_player_coords(pid)
oob.x = -5784.258301
oob.y = -8289.385742
oob.z = -136.411270


menu.toggle(parent,"crash", {}, "", function(on) 
    
    if on then 
        ptoggle1[pid] = true
        local ped_name1 = "a_c_rabbit_01"
        ped_hash = util.joaat(ped_name1)
        local V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        
        while not STREAMING.HAS_MODEL_LOADED(ped_hash)do
            STREAMING.REQUEST_MODEL(ped_hash)
            util.yield()
        end

               local coords_pe = ENTITY.GET_ENTITY_COORDS(V3, true) 
               coords_pe.x = 1000
               coords_pe.y = 1000
               coords_pe.z = 1000

      ped_to_attach = util.create_ped(28 ,ped_hash, oob, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
               ENTITY.SET_ENTITY_COORDS(ped_to_attach, coords_pe.x, coords_pe.y, coords_pe.z  , false, false, false, false )



        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)
        ENTITY.SET_ENTITY_INVINCIBLE(ped_to_attach, true)

    else 
        ptoggle1[pid] = false 


         V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        --local coords = ENTITY.GET_ENTITY_COORDS(V3, true) 
         coords_ped = ENTITY.GET_ENTITY_COORDS(V3, true) 

        local player_pedv3 = PLAYER.PLAYER_PED_ID()
      --  FIRE.ADD_EXPLOSION(coords_ped.x, coords_ped.y, coords_ped.z , 33, 1, true, false, 1 ,true )
        ENTITY.SET_ENTITY_COORDS(ped_to_attach, coords_ped.x + 1, coords_ped.y + 1, coords_ped.z + 1 , false, false, false, false )
     
    for n = 1 , #table_entity do
            ENTITY.DETACH_ENTITY(table_entity[n], true ,true)
                        util.toast(" done detach", TOAST_ABOVE_MAP)      

          end


        util.yield()
            

         
     
            coords = ENTITY.GET_ENTITY_COORDS(ped_to_attach, true)
            util.yield(600)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_to_attach)

    end 
end)
end
menu.action(menu.my_root(), "clean", {}, "", function(on)
    util.toast(os.date("%H:%M:%S").." Crash Clean up attempt.", TOAST_ABOVE_MAP)        

    for n=0, 300000 do
        --util.log(table_entity[n])

        if table_entity[n] == nil then table_entity[n] = 0 end


NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(table_entity[n])
        delet_entity(table_entity[n])
        if table_entity[n] > 0 then 

            util.toast(" ENTITY".." ".. n.." ".. table_entity[n], TOAST_ABOVE_MAP)      
        end

    end
    util.toast(os.date("%H:%M:%S").." done", TOAST_ABOVE_MAP)       

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

                attach_entity("a_c_rabbit_01",pid)

                

            util.toast(os.date("%H:%M:%S").." Test Toggle for PID: "..pid.." is active.", TOAST_ABOVE_MAP)      
            util.yield()
        end 

    end     
    util.yield()
end