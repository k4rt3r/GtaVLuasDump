-------------------------------------------------------------------WiriScript-------------------------------------------------------------------------------------------
--[[ Thanks to
		
		Koda,
		ICYPhoenix,
		jayphen,

and all other developers who shared their work and nice people who helped me. All of you guys teached me things I used in this script <3.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
This is an open code for you to use and share. Feel free to add, modify or remove features as long as you don't try to sell this script. Please consider 
sharing your own versions with Stand's community.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
To have 'Detach Entities' installed would be a good idea. You don't want a monkey attached to a player forever. :D I didn't include detach options cuz
such a nice script exists. 
--]]
-------------------------------------------------------------------dev: nowiry------------------------------------------------------------------------------------------
require("natives-1614644776")
script = {}

local audible = true
local shake, delay = 1, 300 --default shake camera and loop delay
local ped_weapon, ped_type = "weapon_pistol", "s_f_y_cop_01" --these are the default weapon and appearance for attackers
local scriptdir = filesystem.scripts_dir()
local owned = false

function notification(message)
	util.toast(tostring(message), TOAST_ABOVE_MAP)
end


local weapons = {						--here you can modify which weapons are available to choose
	{"Pistol", "weapon_pistol"}, --{'name shown in Stand', 'weapon ID'}
	{"Stun Gun", "weapon_stungun"},
	{"Up-n-Atomizer", "weapon_raypistol"},
	{"Special Carabine", "weapon_specialcarbine"},
	{"Combat MG", "weapon_combatmg"},
	{"Heavy Sniper", "weapon_heavysniper"},
	{"Minigun", "weapon_minigun"},
	{"RPG", "weapon_rpg"}
}

local melee_weapons = {
	{"Unarmed", "weapon_unarmed"}, --{'name shown in Stand', 'weapon ID'}
	{"Knife", "weapon_knife"},
	{"Machete", "weapon_machete"},
	{"Battle Axe", "weapon_battleaxe"},
	{"Wrench", "weapon_wrench"},
	{"Hammer", "weapon_hammer"},
	{"Baseball Bat", "weapon_bat"}
}

local peds = {									--here you can modify which peds are available to choose
	{"Prisoner", "s_m_y_prismuscl_01"}, --{'name shown in Stand', 'ped model ID'}
	{"Mime", "s_m_y_mime"},
	{"Astronaut", "s_m_m_movspace_01"},
	{"Black Ops Soldier", "s_m_y_blackops_01"},
	{"SWAT", "s_m_y_swat_01"},
	{"Ballas Ganster", "csb_ballasog"},
	{"Female Police Officer", "s_f_y_cop_01"},
	{"Male Police Officer", "s_m_y_cop_01"},
	{"Jesus", "u_m_m_jesus_01"},
	{"Zombie", "u_m_y_zombie_01"},
	{"Juggernaut", "u_m_y_juggernaut_01"},
	{"Clown", "s_m_y_clown_01"}
}

local random_peds = {				--add IDs here if you want
	"s_m_y_prismuscl_01",
	"s_m_y_mime",
	"s_m_m_movspace_01",
	"s_m_y_blackops_01",
	"s_m_y_swat_01",
	"csb_ballasog",
	"cs_movpremf_01",
	"a_f_m_prolhost_01",
	"g_m_y_ballasout_01",
	"g_m_y_lost_02",
	"g_m_y_ballaeast_01",
	"s_f_y_cop_01",
	"ig_claypain",
	"u_m_m_jesus_01",
	"u_m_y_rsranger_01",
	"u_m_y_imporage",
	"u_m_y_zombie_01",
	"u_m_y_juggernaut_01",
	"s_m_y_clown_01",
	"s_m_y_cop_01"
}

local gunner_weapon_list = {              --these are the buzzard's gunner weapons 
	{"Combat MG", "weapon_combatmg"},
	{"RPG", "weapon_rpg"}
}

function GetGroundZ(x, y)
	local tick = 0
	booleanValue, groundZ = util.get_ground_z(x, y, 1000)
	while not booleanValue and tick <= 100 do
		tick = tick + 1
		booleanValue, groundZ = util.get_ground_z(x, y, 1000)
	end
	return booleanValue, groundZ
end

function explode(pid, type, owned)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
	local booleanValue, groundZ = GetGroundZ(pos.x, pos.y)
	pos.z = pos.z-0.9
	
	if not owned then
		FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, type, 1000, audible, invisible, shake, false)
	else
		FIRE.ADD_OWNED_EXPLOSION(PLAYER.GET_PLAYER_PED(players.user()), pos.x, pos.y, pos.z, type, 1000, audible, invisible, shake, true)
	end
end

cages = {}
function cage_player(pos)
	local object_hash = util.joaat("prop_gold_cont_01b")
	pos.z = pos.z-0.9
	
	STREAMING.REQUEST_MODEL(object_hash)
	while not STREAMING.HAS_MODEL_LOADED(object_hash) do
		util.yield()
	end
	local object1 = OBJECT.CREATE_OBJECT(object_hash, pos.x, pos.y, pos.z, true, true, true) --why do you think I spawned the same object twice? lol
	cages[#cages + 1] = object1																			--just one of these objects is useless

	local object2 = OBJECT.CREATE_OBJECT(object_hash, pos.x, pos.y, pos.z, true, true, true)
	cages[#cages + 1] = object2
	
	if object1 == 0 or object2 ==0 then --if 'CREATE_OBJECT' fails to create one of those 
		notification("[WiriScript] Something went wrong creating cage")
	end
	ENTITY.FREEZE_ENTITY_POSITION(object1, true) --took me too much to realise it was what I needed 
	ENTITY.FREEZE_ENTITY_POSITION(object2, true)
	local rot  = ENTITY.GET_ENTITY_ROTATION(object2)
	rot.x = -180
	rot.y = -180
	ENTITY.SET_ENTITY_ROTATION(object2, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(object_hash)
end

attackers = {}
function spawn_attacker(pid, ped_type, ped_weapon, godmode, stationary)
	local player_ped = PLAYER.GET_PLAYER_PED(pid)
	
	local pos = ENTITY.GET_ENTITY_COORDS(player_ped)
	pos.z = pos.z - 0.9
	pos.x  = pos.x + math.random(-3, 3)
	pos.y = pos.y + math.random(-3, 3)

	local ped_hash = util.joaat(ped_type)
	local weapon_hash = util.joaat(ped_weapon)
	STREAMING.REQUEST_MODEL(ped_hash)
	while not STREAMING.HAS_MODEL_LOADED(ped_hash) do
		util.yield()
	end
	local ped = util.create_ped(0, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
	attackers[#attackers + 1] = ped

	WEAPON.GIVE_WEAPON_TO_PED(ped, weapon_hash, 9999, true, true)
	ENTITY.SET_ENTITY_INVINCIBLE(ped, godmode)
	PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
	TASK.TASK_COMBAT_PED(ped, player_ped, 0, 16)
	if stationary then
		PED.SET_PED_COMBAT_MOVEMENT(ped, 0)
	end
	PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, 1)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)
end 

function shoot_owned_bullet(pid, weaponID, damage)
	local user = PLAYER.GET_PLAYER_PED(players.user())
	local player_ped = PLAYER.GET_PLAYER_PED(pid)
	local player_pos = ENTITY.GET_ENTITY_COORDS(player_ped)
	local spawn_pos = CAM.GET_GAMEPLAY_CAM_COORD()
	local weapon_hash = util.joaat(weaponID)
	if pid ~= players.user() then --the bullets can't hit the user's ped, that's why it's not available for own use
		MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(spawn_pos.x, spawn_pos.y, spawn_pos.z, player_pos.x , player_pos.y, player_pos.z, damage, 0, weapon_hash, user, true, false, 1000)
	else
		notification("[WiriScript] Not available for own use")
	end
end

buzzard_entities = {}
function spawn_buzzard(pid, gunner_weapon, collision)
	local player_ped =  PLAYER.GET_PLAYER_PED(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(player_ped)
	pos.x = pos.x + math.random(-20, 20)
	pos.y = pos.y + math.random(-20, 20)
	pos.z = pos.z + math.random(20, 40)

	PED.SET_PED_RELATIONSHIP_GROUP_HASH(player_ped, util.joaat("PLAYER"))

	local heli_hash = util.joaat("buzzard2")
	local ped_hash = util.joaat("s_m_y_blackops_01")
	STREAMING.REQUEST_MODEL(ped_hash)
	STREAMING.REQUEST_MODEL(heli_hash)
	while not STREAMING.HAS_MODEL_LOADED(ped_hash) or not STREAMING.HAS_MODEL_LOADED(heli_hash) do
		util.yield()
	end
	local heli = util.create_vehicle(heli_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
	buzzard_entities[#buzzard_entities + 1] = heli
	
	if not collision then
		VEHICLE._DISABLE_VEHICLE_WORLD_COLLISION(heli)
	end
	
	ENTITY.SET_ENTITY_INVINCIBLE(heli, buzzard_godmode)
	ENTITY.SET_ENTITY_VISIBLE(heli, buzzard_visible, 0)	
	VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
	VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
		
	local pilot = util.create_ped(5, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
	buzzard_entities[#buzzard_entities + 1] = pilot
	
	PED.SET_PED_RELATIONSHIP_GROUP_HASH(pilot, util.joaat("ARMY"))
	ENTITY.SET_ENTITY_VISIBLE(pilot, buzzard_visible, 0)
	PED.SET_PED_INTO_VEHICLE(pilot, heli, -1)
	PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)

	PED.SET_PED_MAX_HEALTH(pilot, 500)
	ENTITY.SET_ENTITY_HEALTH(pilot, 500)
	ENTITY.SET_ENTITY_INVINCIBLE(pilot, buzzard_godmode)
	--TASK.TASK_COMBAT_HATED_TARGETS_AROUND_PED(pilot, 500, 0)

	local gunner = {}
	for i  = 1,2 do
		gunner[i] = util.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
		buzzard_entities[#buzzard_entities + 1] = gunner[i]
		PED.SET_PED_INTO_VEHICLE(gunner[i], heli, i)
		WEAPON.GIVE_WEAPON_TO_PED(gunner[i], util.joaat(gunner_weapon) , 9999, false, true)
		PED.SET_PED_COMBAT_ATTRIBUTES(gunner[i], 20 --[[ they can shoot from vehicle ]], true)
		--PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(gunner[i], true)
		PED.SET_PED_MAX_HEALTH(gunner[i], 500)
		ENTITY.SET_ENTITY_HEALTH(gunner[i], 500)
		ENTITY.SET_ENTITY_INVINCIBLE(gunner[i], buzzard_godmode)
		ENTITY.SET_ENTITY_VISIBLE(gunner[i], buzzard_visible, 0)
		PED.SET_PED_SHOOT_RATE(gunner[i], 1000)
		PED.SET_PED_RELATIONSHIP_GROUP_HASH(gunner[i], util.joaat("ARMY"))
		TASK.TASK_COMBAT_HATED_TARGETS_AROUND_PED(gunner[i], 1000, 0)
	end
	
	util.create_tick_handler(function()
		PED.SET_RELATIONSHIP_BETWEEN_GROUPS(5, util.joaat("ARMY"), util.joaat("PLAYER"))
		PED.SET_RELATIONSHIP_BETWEEN_GROUPS(5, util.joaat("PLAYER"), util.joaat("ARMY"))
		PED.SET_RELATIONSHIP_BETWEEN_GROUPS(0, util.joaat("ARMY"), util.joaat("ARMY"))
	end)

	notification("[WiriScript] Buzzard sent to "..PLAYER.GET_PLAYER_NAME(pid))
	return pilot, heli
end	

settings = menu.list(menu.my_root(), "Settings", {}, "")

menu.divider(settings, "Settings")

local display = true
menu.toggle(settings, "Display Health Info When Modding Health", {}, "", function(on)
	display = on
end, true)

-----------------------------------------save name stuff-------------------------------------------------------------------------------

local savednames = menu.list(menu.my_root(), "Saved Names", {}, "")
menu.divider(savednames,"Saved Names")

local function add_name_to_savednames(name)
	menu.action(savednames, name, {}, "Click to paste name in Online/Spoofing/Name Spoofing/Spoofed Name. You might use Stand's 'Get Spoofed RID From Spoofed Name' option before RID spoofing", function() 
		menu.trigger_commands("spoofedname "..name)
		notification("[WiriScript] Spoofed name: "..name)
	end)
end

local namedata = {}
nameloaddata = (scriptdir.."\\savednames.data")

local function namesload()
	if not filesystem.exists(nameloaddata) then return end
    for line in io.lines(nameloaddata) do namedata[#namedata + 1] = line end
    for i = 1, #namedata do
    	add_name_to_savednames(namedata[i])
	end
	notification("[WiriScript] Saved names loaded: "..#namedata)
end
namesload()
-------------------------------------------------------------------------------------------------------------------------------------
GenerateFeatures = function(pid)
	menu.divider(menu.player_root(pid),"WiriScript")		
	
--------------------------------------------save name----------------------------------------------------------------------------

	menu.action(menu.player_root(pid), "Save Name", {}, "Allows you to save player's name in a dedicated list to spoof as them later. Note that Stand's 'Get RID From Spoofed Name' option will be useless if this is an invalid name", function()
		local player_name = PLAYER.GET_PLAYER_NAME(pid)
		local i = #namedata + 1
		if not filesystem.exists(nameloaddata) or #namedata == 0 or namedata[1] == "" then --test
			namedata[i] = player_name
			savednames_data = io.open(nameloaddata, "w")  
			savednames_data:write(namedata[i].."\n")
			savednames_data:close()
			add_name_to_savednames(namedata[i])
			notification("[WiriScript] Name saved: "..namedata[i])
		else
			for _, value in pairs(namedata) do 
				if value == player_name then 
					notification("[WiriScript] Name is already saved")
					return
				end
			end
			namedata[i] = player_name
			savednames_data = io.open(nameloaddata, "a") 
			savednames_data:write(namedata[i].."\n")
			savednames_data:close()
			add_name_to_savednames(namedata[i])
			notification("[WiriScript] Name saved: "..namedata[i])
		end
	end)

--------------------------------------------explosion and loop stuff----------------------------------------------------------------------------
	
	trolling_list = menu.list(menu.player_root(pid), "Trolling & Griefing", {}, "")

	explo_settings = menu.list(trolling_list, "Explosion Settings", {}, "")

	menu.divider(explo_settings, "Explosion Settings")

	menu.slider(explo_settings, "Explosion Type", {"explotype"}, "",0,72,0,1, function(value)
		type = value
	end)
	menu.toggle(explo_settings, "Invisible", {}, "", function(on)
		invisible = on
	end, false)
	menu. toggle(explo_settings, "Audible", {}, "", function(on)
		audible = on
	end, true)
	menu.slider(explo_settings, "Camera Shake", {"shake"}, "",0,100,1,1, function(value)
		shake = value
	end)
	menu.toggle(explo_settings, "Owned Explosions", {}, "", function(on)
		owned = on
	end)

	menu.action(trolling_list, "Explode", {}, "", function()
		explode(pid, type, owned)
	end)
		
	menu.toggle(trolling_list, "Explosion Loop", {},"", function(on)
		explosion_loop = on
		while explosion_loop do
			explode(pid, type, owned)
			util.yield(delay)
		end
	end, false)

	menu.slider(trolling_list, "Loop Delay", {"delay"}, "Allows you to change how fast the loops are",50,1000,300,10, function(value)
		delay = value
	end)

	menu.toggle(trolling_list, "Water Hydrant Loop", {},"", function(on)
		hydrant_loop = on
		while hydrant_loop do
			explode(pid, 13, false)
			util.yield(delay)
		end
	end, false)

	menu.action(trolling_list, "Kill as Orbital Cannon", {}, "", function()
		menu.trigger_commands("becomeorbitalcannon on") 
		util.yield(200)
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
		FIRE.ADD_OWNED_EXPLOSION(PLAYER.GET_PLAYER_PED(players.user()), pos.x, pos.y, pos.z, 59, 999999.99, true, false, 8)
		util.yield(1000)
		menu.trigger_commands("becomeorbitalcannon off")
	end)

	menu.toggle(trolling_list, "Flame Loop", {},"", function(on)
		fire_loop = on
		while fire_loop do
			explode(pid, 12, false)
			util.yield(delay)
		end
	end, false)

-------------------------------------------attacker and clone options-----------------------------------------------------------------------------

	local attacker_options = menu.list(trolling_list, "Attacker/Clone Settings", {}, "")

	menu.divider(attacker_options, "Attacker/Clone Settings")

	local ped_weapon_list = menu.list(attacker_options, "Weapon", {}, "Allows you to change the attacker/clone weapon. Default: Pistol")	
	menu.divider(ped_weapon_list, "Attacker/Clone Weapon List")										
	local ped_melee_list = menu.list(ped_weapon_list, "Melee", {}, "")

	for i = 1, #weapons do 								--creates the attacker weapon list
		menu.action(ped_weapon_list, weapons[i][1], {}, "", function()
			ped_weapon = weapons[i][2]
			notification("[WiriScript] Attacker weapon: "..weapons[i][1])
		end)
	end

	for i = 1, #melee_weapons do  --creates the attacker melee weapon list
		menu.action(ped_melee_list, melee_weapons[i][1], {}, "", function()
			ped_weapon = melee_weapons[i][2]
			notification("[WiriScript] Attacker weapon: "..melee_weapons[i][1])
		end)
	end

	local ped_list = menu.list(attacker_options, "Attacker Appearance", {}, "Allows to change the attacker appearance. Default: Female Cop")

	menu.divider(ped_list, "Attacker Appearance List")

	for i = 1, #peds do					--creates the attacker appearance list
		menu.action(ped_list, peds[i][1], {}, "", function()
			ped_type = peds[i][2]
			notification("[WiriScript] Attacker appearance: "..peds[i][1])
		end)
	end

	menu.toggle(attacker_options, "Invincible", {}, "Makes attacker/clone invincible when enabled", function(on_godmode)
		godmode = on_godmode
	end, false)

	menu.toggle(attacker_options, "Stationary", {}, "Use it to make the attacker stationary", function(on)
		stationary = on
	end, false)

	menu.action(trolling_list, "Spawn Attacker", {}, "", function()
		local player_ped = PLAYER.GET_PLAYER_PED(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(player_ped)
		spawn_attacker(pid, ped_type, ped_weapon, godmode, stationary)
		notification("[WiriScript] Attacker sent to "..PLAYER.GET_PLAYER_NAME(pid))
	end)

	menu.action(trolling_list, "Spawn Random Attacker", {}, "", function()
		local player_ped = PLAYER.GET_PLAYER_PED(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(player_ped)
		spawn_attacker(pid, random_peds[math.random(#random_peds)], ped_weapon, godmode, stationary)
		notification("[WiriScript] Attacker sent to "..PLAYER.GET_PLAYER_NAME(pid))
	end)

	menu.action(trolling_list, "Clone Player as Enemy", {}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
		
		pos.x  = pos.x + math.random(-3, 3)
		pos.y = pos.y + math.random(-3, 3)
		pos.z = pos.z-0.9

		local weapon_hash = util.joaat(ped_weapon)
		clone = PED.CLONE_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), 1, 1, 1)
		attackers[#attackers + 1] = clone

		WEAPON.GIVE_WEAPON_TO_PED(clone, weapon_hash, 9999, true, true)
		ENTITY.SET_ENTITY_COORDS(clone, pos.x, pos.y, pos.z)
		ENTITY.SET_ENTITY_INVINCIBLE(clone, godmode)
		PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(clone, true)
		TASK.TASK_COMBAT_PED(clone, PLAYER.GET_PLAYER_PED(pid), 0, 16)
		PED.SET_PED_COMBAT_ATTRIBUTES(clone, 46, 1)
		if stationary then
			PED.SET_PED_COMBAT_MOVEMENT(clone, 0)
		end
		notification("[WiriScript] Enemy clone sent to "..PLAYER.GET_PLAYER_NAME(pid))
	end)
	
	menu.action(attacker_options, "Delete All", {}, "Deletes all attackers and clones you've spawned", function()
		for key, value in pairs(attackers) do
			util.delete_entity(value)
		end
	end)

------------------------------------------cage options------------------------------------------------------------------------------
	
	local cage_options = menu.list(trolling_list, "Cage Options", {}, "")
	
	menu.divider(cage_options, "Cage Options")

	menu.action(cage_options, "Simple", {"cage"}, "", function()
		local player_ped = PLAYER.GET_PLAYER_PED(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(player_ped) 
		if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
			menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")
			util.yield(300)
			if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
				notification("[WiriScript] Failed to kick player out of the vehicle")
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
				return
			end
			menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
			pos =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid)) --if not it could place the cage at the wrong position
		end
		cage_player(pos)
	end)

	menu.action(cage_options, "Stunt Tube", {}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
		STREAMING.REQUEST_MODEL(2081936690)

		while not STREAMING.HAS_MODEL_LOADED(2081936690) do		
			util.yield()
		end
		local cage_object = OBJECT.CREATE_OBJECT(2081936690, pos.x, pos.y, pos.z, true, true, false)
		cages[#cages + 1] = cage_object

		local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
		rot.y = 90
		ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
		ENTITY.SET_ENTITY_AS_NO_LONGER_NEEDED(cage_object)
	end)
							
	local cage_loop = false
	menu.toggle(cage_options, "Atomatic", {"autocage"}, "Cage them in a trap. If they get out... Do it again. No, I'll do it for you actually", function(on)
		local player_ped = PLAYER.GET_PLAYER_PED(pid)
		local a = ENTITY.GET_ENTITY_COORDS(player_ped) --first position
		cage_loop = on
		if cage_loop then
			if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")
				util.yield(300)
				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
					notification("[WiriScript] Failed to kick player out of the vehicle")
					menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
					return
				end
				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
				a =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
			end
			cage_player(a)
		end
		while cage_loop do
			local b = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid)) --current position
			local ba = {x = b.x - a.x, y = b.y - a.y, z = b.z - a.z} 
			if math.sqrt(ba.x * ba.x + ba.y * ba.y + ba.z * ba.z) >= 4 then --now I know there's a native to find distance between coords but I like this >_<
				a = b
				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
					goto continue
				end
				cage_player(a)
				notification("[WiriScript] "..PLAYER.GET_PLAYER_NAME(pid).." was out of the cage. Doing it again")
				::continue::
			end
			util.yield(1000)
		end
	end)

	menu.action(cage_options, "Delete All", {}, "Deletes all traps you've spawn", function()
		for key, value in pairs(cages) do
			util.delete_entity(value)
		end
	end)

------------------------------------------------guitar------------------------------------------------------------------------

	menu.action(trolling_list, "Give Them a Guitar", {}, "Attaches a guitar to their ped causing crazy things if they're in a vehicle", function()
		local player_ped = PLAYER.GET_PLAYER_PED(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(player_ped)
		pos.z = pos.z - 0.9
		local object_hash = util.joaat("prop_acc_guitar_01_d1")
		STREAMING.REQUEST_MODEL(object_hash)
		while not STREAMING.HAS_MODEL_LOADED(object_hash) do
			util.yield()
		end
		local object = OBJECT.CREATE_OBJECT(object_hash, pos.x, pos.y, pos.z, true, true, true)
		if object == 0 then 
			notification("[WiriScript] Failure creating the entity")
		end
		ENTITY.ATTACH_ENTITY_TO_ENTITY(object, PLAYER.GET_PLAYER_PED(pid), PED.GET_PED_BONE_INDEX(PLAYER.GET_PLAYER_PED(pid), 0x5c01), 0.5, -0.1, 0.1, 0, 70, 0, false, true, true --[[Collision - This causes glitch when in vehicle]], false, 0, true)
		--ENTITY.SET_ENTITY_VISIBLE(object, false, 0) --turns guitar invisible
		util.yield(3000)
		if player_ped ~= ENTITY.GET_ENTITY_ATTACHED_TO(object) then
			notification("[WiriScript] The entity is not attached. Meaby "..PLAYER.GET_PLAYER_NAME(pid).." has attactment protections")
			return
		end
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(object_hash)
	end)

----------------------------------------------------rape--------------------------------------------------------------------

	menu.action(trolling_list, "Rape", {}, "", function()
		local player_ped = PLAYER.GET_PLAYER_PED(pid)
		local pos = 	ENTITY.GET_ENTITY_COORDS(player_ped)
		local ped_hash = util.joaat("a_c_chimp")
		STREAMING.REQUEST_MODEL(ped_hash)
		STREAMING.REQUEST_ANIM_DICT("rcmpaparazzo_2")
		util.yield(50)
		while not STREAMING.HAS_MODEL_LOADED(ped_hash) or not STREAMING.HAS_ANIM_DICT_LOADED("rcmpaparazzo_2") do
			util.yield()
		end
		local ped = util.create_ped(1, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
		PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
		TASK.TASK_PLAY_ANIM(ped, "rcmpaparazzo_2", "shag_loop_a", 8, 8, -1, 1, 0, 0, 0, 0)
		ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, player_ped, PED.GET_PED_BONE_INDEX(ped, 0x0), 0, -0.3, 0.2, 0, 0, 0, false, true, false, false, 0, true)
		ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
		ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(ped, false, false) --for ped not to be beaten with a melee weapon (because ped ditaches from player)
		util.yield(3000)
		if player_ped ~= ENTITY.GET_ENTITY_ATTACHED_TO(ped) then
			notification("[WiriScript] The entity is not attached. Meaby "..PLAYER.GET_PLAYER_NAME(pid).." has attactment protections")
			return
		end
		while player_ped == ENTITY.GET_ENTITY_ATTACHED_TO(ped) do
			if not ENTITY.IS_ENTITY_PLAYING_ANIM(ped, "rcmpaparazzo_2", "shag_loop_a",3) then
				TASK.TASK_PLAY_ANIM(ped, "rcmpaparazzo_2", "shag_loop_a", 8, 8, -1, 1, 0, 0, 0, 0)
			end
			util.yield()
		end
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)
	end)

---------------------------------------------------enemy buzzard---------------------------------------------------------------------

	local buzzard_options = menu.list(trolling_list, "Enemy Buzzard", {}, "")

	menu.divider(buzzard_options, "Enemy Buzzard")

	buzzard_visible = true
	local gunner_weapon = "weapon_combatmg"
	
	menu.action(buzzard_options, "Spawn Buzzard", {}, "", function()
		local pilot, heli = spawn_buzzard(pid, gunner_weapon, collision)

		while ENTITY.GET_ENTITY_HEALTH(pilot) > 0 do
			local player_ped = PLAYER.GET_PLAYER_PED(pid)
			local a = ENTITY.GET_ENTITY_COORDS(player_ped)
			local b = ENTITY.GET_ENTITY_COORDS(heli)
			if MISC.GET_DISTANCE_BETWEEN_COORDS(a.x, a.y, a.z, b.x, b.y, b.z, true) > 90 then
				TASK.TASK_HELI_CHASE(pilot, player_ped, 0, 0, 50)
			else
				TASK.TASK_HELI_MISSION(pilot, heli, 0, player_ped, a.x, a.y, a.z, 23, 30, -1, -1, 10, 10, 5, 0)
			end
			util.yield()
		end
	end)

	menu.divider(buzzard_options, "Settings")

	menu.toggle(buzzard_options, "Invincible", {}, "", function(on)
		buzzard_godmode = on
	end, false)
	
	local menu_gunner_weapon_list = menu.list(buzzard_options, "Gunners Weapon")
	menu.divider(menu_gunner_weapon_list, "Gunner Weapon List")

	for i = 1, #gunner_weapon_list do
		menu.action(menu_gunner_weapon_list, gunner_weapon_list[i][1], {}, "", function()
			gunner_weapon = gunner_weapon_list[i][2]
			notification("[WiriScript] Now gunners will shoot with "..gunner_weapon_list[i][1].."s")
		end)
	end

	menu.toggle(buzzard_options, "Visible", {}, "You shouldn't be that toxic to turn this off", function(on)
		buzzard_visible = on
	end, true)

	menu.toggle(buzzard_options, "Collision", {}, "When it's turned off disables world collision for Buzzard. Playes can still destroy the vehicle", function(on)
		collision = on
	end, false)

	menu.action(buzzard_options, "Delete All", {}, "Deletes all Buzzards you've spawned", function()
		for key, value in pairs(buzzard_entities) do
			util.delete_entity(value)
		end
	end)

-----------------------------------------------damage-------------------------------------------------------------------------

	local damage = menu.list(trolling_list, "Damage", {}, "Choose the weapon and shoot 'em no matter where you are")
	
	menu.toggle(damage, "Spectate", {}, "If player is not visible or far enough, you'll need to spectate before using Demage. This is just Stand's option duplicated", function(on)
		spectate = on
		if spectate then
			menu.trigger_commands("spectate "..PLAYER.GET_PLAYER_NAME(pid).." on")
		else
			menu.trigger_commands("spectate "..PLAYER.GET_PLAYER_NAME(pid).." off")
		end
	end)

	menu.divider(damage, "Damage")
	
	local damage_value = 200 --default damage
	menu.action(damage, "Heavy Sniper", {}, "", function() 
		shoot_owned_bullet(pid, "weapon_heavysniper", damage_value)
	end)

	menu.action(damage, "Shotgun", {}, "", function()
		shoot_owned_bullet(pid, "weapon_pumpshotgun", damage_value)
	end)

	menu.slider(damage, "Damage Amount", {"damagevalue"}, "The bullet demages player with the given value. ", 10, 1000, 200, 50, function(value)
		damage_value = value
	end)

	menu.toggle(damage, "Tase", {}, "", function(on)
		tase = on
		while tase do
			shoot_owned_bullet(pid, "weapon_stungun", 5)
			util.yield(500)
		end
	end, false)

-------------------------------------------------shake cam-----------------------------------------------------------------------

	menu.toggle(trolling_list, "Shake Camera", {}, "", function(on)
		shakecam = on
		while shakecam do
			local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
			FIRE.ADD_OWNED_EXPLOSION(PLAYER.GET_PLAYER_PED(players.user()), pos.x, pos.y, pos.z, 0, 0, false, true, 50)
			util.yield(200)
		end
	end)

end
---------------------------------------------------------------------------------------------------------------------------------
local rank = players.get_rank(players.user())
	
if rank < 20 then
	defaulthealth = 238
end
if rank >= 20 and rank < 40 then
	defaulthealth = 256
end
if rank >= 40 and rank < 60 then
	defaulthealth = 274
end
if rank >= 60 and rank < 80 then
	defaulthealth  = 292
end
if rank >= 80 and rank < 100 then
	defaulthealth = 310
end
if rank > 100 then
	defaulthealth = 328
end

local modhealth  = false
local modded_health = defaulthealth

--display health stuff

local screen_w, screen_h = directx.get_client_size() --from BoperSkript
function _x(yes)
	return yes / screen_w
end
function _y(yes)
	return yes / screen_h
end

-------------------------------------------------health options-----------------------------------------------------------------------

menu.toggle(menu.my_root(), "Mod Health", {"modhealth"}, "Changes your peds max health. Some menus will tag you as modder. It returns to defaulf max health when it's disabled", function(on)
	modhealth  = on
	if modhealth then
		local player_ped = PLAYER.GET_PLAYER_PED(players.user())
		PED.SET_PED_MAX_HEALTH(player_ped,  modded_health)
		ENTITY.SET_ENTITY_HEALTH(player_ped, modded_health)
		if PED.GET_PED_MAX_HEALTH(player_ped) == modded_health then
			notification("[WiriScript] Mod Health is on")
		else 
			notification("[WiriScript] Something went wrong")
			return
		end
	else
		local player_ped = PLAYER.GET_PLAYER_PED(players.user())
		PED.SET_PED_MAX_HEALTH(player_ped, defaulthealth)
		menu.trigger_commands("maxhealth "..defaulthealth) -- just if you want the slider to go to defaulf value when mod health is off
		if ENTITY.GET_ENTITY_HEALTH(player_ped) > defaulthealth then 
			ENTITY.SET_ENTITY_HEALTH(player_ped, defaulthealth)
		end
		if PED.GET_PED_MAX_HEALTH(player_ped) == defaulthealth then
			notification("[WiriScript] Mod Health is off. Default max health: "..defaulthealth)
		else 
			notification("[WiriScript] Something went wrong")
			return
		end
	end
	while modhealth do
		local player_ped = PLAYER.GET_PLAYER_PED(players.user())
		if PED.GET_PED_MAX_HEALTH(player_ped) ~= modded_health  then
			PED.SET_PED_MAX_HEALTH(player_ped, modded_health)
			ENTITY.SET_ENTITY_HEALTH(player_ped, modded_health)	
		end
								--display health info
		if display then
			local text = "| WiriScript | Player Health: "..ENTITY.GET_ENTITY_HEALTH(player_ped).."/"..PED.GET_PED_MAX_HEALTH(player_ped)
			--local wmtxt_x, wmtxt_y = directx.get_text_size(text, 0.6)
			local wmposx,wmposy = _x(25),_y(25) --+ wmtxt_y*0.4 --change the text position here
			directx.draw_text_client(wmposx, wmposy, text, ALIGN_CENTRE_LEFT, 0.7,  {["r"] = 1.0,["g"] = 0,["b"] = 0,["a"] = 1.0}, true)
		end
		util.yield()
	end
end, false)

menu.slider(menu.my_root(), "Modded Health", {"maxhealth"}, "Health will be modded with the given value", 100,9000,defaulthealth,50, function(value)
	modded_health = value
end)

menu.action(menu.my_root(), "Max Armour", {}, "", function()
	local player_ped = PLAYER.GET_PLAYER_PED(players.user())
	PED.SET_PED_ARMOUR(player_ped, 100)
end)

menu.action(menu.my_root(), "Max Health", {}, "", function()
	local player_ped = PLAYER.GET_PLAYER_PED(players.user())
	ENTITY.SET_ENTITY_HEALTH(player_ped, PED.GET_PED_MAX_HEALTH(player_ped))
end)

local refillincover = false
menu.toggle(menu.my_root(), "Refill Health When in Cover", {}, "", function(on)
	refillincover = on
	while refillincover do
		local player_ped = PLAYER.GET_PLAYER_PED(players.user())
		if PED.IS_PED_IN_COVER(player_ped) then
			PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(players.user(), 1)
			PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), 15)
		else
			PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(players.user(),0.5)
			PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), 1)
		end
		util.yield()
	end
	if not refillincover then
		PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(players.user(), 0.5)
		PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), 1)
	end
end)

----------------------------------------------clear area--------------------------------------------------------------------------

local clear_area = menu.list(menu.my_root(), "Clear Area")
local radius = 100

menu.action(clear_area, "Clear Area", {}, "", function()
	local player_ped = PLAYER.GET_PLAYER_PED(players.user())
	local pos = ENTITY.GET_ENTITY_COORDS(player_ped)
	MISC.CLEAR_AREA(pos.x, pos.y, pos.z, 100, true, false, false, false)
end)

menu.slider(clear_area, "Radius", {"clearradius"}, "", 20, 800, 100, 50, function(value)
	radius  = value
end)

------------------------------------------------------------------------------------------------------------------------

for pid = 0,30 do 
	if players.exists(pid) then
		GenerateFeatures(pid)
	end
end

players.on_join(GenerateFeatures)

while true do
	util.yield()
end