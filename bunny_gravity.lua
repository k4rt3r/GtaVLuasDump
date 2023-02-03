require("natives-1606100775")

_natives_PLAYER = PLAYER
_natives_NETWORK = NETWORK
_natives_ENTITY = ENTITY
player = {
	
	["get_player_ped"] =
	function(player)
		return _natives_PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
	end,

	["get_player_coords"] =
	function(player)
		return _natives_ENTITY.GET_ENTITY_COORDS(_natives_PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player), true)
	end,
}

GenerateFeatures = function(pid)
table_entity = {attach}

function attach_spam(model_name)
	
	hash = util.joaat(model_name)
	STREAMING.REQUEST_MODEL(hash) 

	STREAMING.IS_MODEL_A_VEHICLE(hash) 

		table_entity[attach] = util.create_vehicle(hash, ENTITY.GET_ENTITY_COORDS(V3, true), CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
		VEHICLE.SET_VEHICLE_GRAVITY( table_entity[attach], false)

	ENTITY.SET_ENTITY_INVINCIBLE(table_entity[attach], true)
	ENTITY.ATTACH_ENTITY_TO_ENTITY(table_entity[attach], ped_to_attach, 0, 0, 0, 0, 0, 0, 0, false, true, true, false, 0, false)
	ENTITY.SET_ENTITY_VISIBLE(table_entity[attach], true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)

	attach = attach + 1

	util.yield()
end

		function v3(x, y, z)
    if x == nil then x = 0 end
    if y == nil then y = 0 end
    if z == nil then z = 0 end
end
		
function delet_entity(entity)
		entitypointer = memory.alloc(24)
		memory.write_int(entitypointer, entity)
		bool = ENTITY.DELETE_ENTITY(entitypointer)
		memory.free(entitypointer)
		return bool
end


menu.divider(menu.player_root(pid),"Bunny Lua")
parent  = menu.list(menu.player_root(pid), "BOOM" ,{}, "", function();end)
	

menu.action(parent,"BOOM", {}, "", function(on) -- This function creates the button inside Stand
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
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)

        ENTITY.SET_ENTITY_INVINCIBLE(ped_to_attach, true)
        attach = 1
        util.toast(os.date("%H:%M:%S").." explosion loading.", TOAST_ABOVE_MAP)		

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
        util.toast(os.date("%H:%M:%S").." explosion loaded.", TOAST_ABOVE_MAP)		


        local player_pedv3 = PLAYER.PLAYER_PED_ID()

        util.yield(100)

        coordsped = ENTITY.GET_ENTITY_COORDS(V3, true)
        util.yield(20)
        ENTITY.SET_ENTITY_COORDS(ped_to_attach, coordsped.x, coordsped.y + 1 , coordsped.z - 0.5  , false, false, false, true )
        util.yield(100)

        delet_entity(ped_to_attach)
        util.toast(os.date("%H:%M:%S").." explosion send.", TOAST_ABOVE_MAP)		

        util.yield(15000)
        util.toast(os.date("%H:%M:%S").." Clean up attempt.", TOAST_ABOVE_MAP)		

        for n = 1, #table_entity do
        	delet_entity(table_entity[n])
        end
        util.toast(os.date("%H:%M:%S").."Clean up done.", TOAST_ABOVE_MAP)		
    end)

end

menu.action(menu.my_root(), "clean", {}, "", function(on)
	util.toast(os.date("%H:%M:%S").."  Clean up attempt.", TOAST_ABOVE_MAP)		

	for n=0, 300000 do
		if table_entity[n] == nil then table_entity[n] = 0 end

		delet_entity(table_entity[n])
		if table_entity[n] > 0 then 
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
	util.yield()
end
