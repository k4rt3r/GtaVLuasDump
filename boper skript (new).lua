--[[
	welcome to this pile of shit also known as boper skript :)
]]
require(string.gsub(string.gsub(filesystem.list_files(filesystem.scripts_dir() .. "lib\\")[1], filesystem.scripts_dir().."lib\\", ""), ".lua", ""))--whatever is there will probably work fine

script = {}
local ladder =     1888301071
local ground =    -1951226014
local kicks = { -- some kicks from my cheat
	1317868303,
	-1243454584,
	-1212832151,
	-1252906024,
	-1890951223,
	-442306200,
	-966559987,
	1977655521,
	1998625272,
	1070934291,
	-1169499038
}
local rus_chars = {
    "а", "б", "в", "г", "д", "е", "ë", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я"
}
local is_session_started_addrs = memory.scan("40 38 35 ? ? ? ? 75 0E 4C 8B C3 49 8B D7 49 8B CE") --if this gets outdated just replace it with the native
local floppa = false
local dvd_thingy = false
local outline = 0
local watermark = true
local rus_kick = false
local commands_for_everyone = false
local funky_plate = false
local onkey_boost = false
local launch_vehicles_forward = false
local spinbot_vehicles = false
--yes
function Kick(pid)
	for i,v in ipairs(kicks) do
		util.trigger_script_event(1 << pid, {v,pid,0,0}) --i dont even know if this is correct but people seem to get kicked so yes
		util.yield()
	end
end

function is_online()
	return memory.read_int(memory.rip(is_session_started_addrs + 3)) -- didnt realise theres litteraly a native that does the same thing
end																	 -- but who cares, patterns look cooler B))

function RequestControlOfid(netid)
	local tick = 0
	NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netid)
	while not NETWORK.NETWORK_HAS_CONTROL_OF_NETWORK_ID(netid) and tick <= 10 do
		NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netid)
		tick = tick + 1
	end
	return NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netid)
end

function RequestControlOfEnt(entity,budget)

	if not is_online() then
		return true
	end

	local tick = 0
	local tries = 0

	local max_ticks = budget or 1000
	local max_tries = 50
	if budget then max_tries = 5 end 
	
	NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
	while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and tick <= max_ticks do
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
		tick = tick + 1
		tries = tries + 1
		if tries >= max_tries then 
			util.yield()
			tries = 0
		end
	end

	local result = NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity)	
	if result then
		local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
		if RequestControlOfid(netID) then
			NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, true)
		end
	end
	return result
end

function clamp(n,low, high) return math.min(math.max(n, low), high) end --clamp func joinked from random forum

function get_player_veh(pid,with_access)
	local ped = PLAYER.GET_PLAYER_PED(pid)	
	if PED.IS_PED_IN_ANY_VEHICLE(ped,true) then
		local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
		if vehicle then 
			if not with_access or RequestControlOfEnt(vehicle) then
				return vehicle
			end
		end
	end
	return 0
end

function tp_veh_to(pid,x,y,z)
	if not ENTITY.IS_ENTITY_A_VEHICLE(pid) and PED.IS_PED_IN_ANY_VEHICLE(PLAYER.GET_PLAYER_PED(pid),true) then
		pid = get_player_veh(pid,false)	
	end
	
	if not pid then return end

	local tries = 0
	while tries <= 1000 do --bad cooooooode >:( but idk anything better
		if RequestControlOfEnt(pid) then			
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(pid, x, y, z, 0, 0, 1);
			tries = tries + 1
		end
	end
end

function for_table_do(table,with_access,func) --this wasnt even about making it easier, just if i could do it
	for i,ent in ipairs(table) do
		if with_access then
			if not RequestControlOfEnt(ent,3) then goto skip end
		end
		func(ent)
		::skip::
	end
end

function ladder_attach(hash, xPos, zPos, yPos, xRot, yRot, zRot, visible, pid) --took from bunny's script cuz cleaner
	while not STREAMING.HAS_MODEL_LOADED(hash) do
		STREAMING.REQUEST_MODEL(hash)      
		util.yield()
	end  
	local ped = PLAYER.GET_PLAYER_PED(pid)
	local obj = OBJECT.CREATE_OBJECT(hash, 1.55,3.35,0, true, true)
   
	ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, ped, 0, xPos, zPos, yPos, xRot, zRot, yRot, false, true, true, false, 0, false)
	ENTITY.SET_ENTITY_VISIBLE(obj, visible)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
end

function marqee(text)
	local temp = text
    text = text:sub(2)
	return text .. temp:sub(1, 1)
end
--gaming

function upgrade_vehicle(player)
	local vehicle = get_player_veh(player,true)
	if vehicle then
		DECORATOR.DECOR_SET_INT(vehicle, "MPBitset", 0)
		VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
		for i = 0 ,50 do
			VEHICLE.SET_VEHICLE_MOD(vehicle, i, VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i) - 1, false)
		end	
		VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, 0, 0, 0)
		VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle,0, 0, 0)
		VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 22, true)
		VEHICLE._SET_VEHICLE_XENON_LIGHTS_COLOR(vehicle, 10)
		VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 18, true)
		VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 20, true)
		for i = 0 ,4 do
			if not VEHICLE._IS_VEHICLE_NEON_LIGHT_ENABLED(vehicle, i) then
				VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, i, true)
			end
		end
		VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, 255, 0, 255)
		VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "cokc")
	end
end

function launch_vehicle(pid)
	local vehicle = get_player_veh(pid,true)
	if vehicle then
		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(vehicle, 1, 0, 0, 10000, true, false, true)
	end
end  
--cock
GenerateFeatures = function(pid)
main = menu.list(menu.player_root(pid), "boper script", {}, "", function(); end)

player_tab = menu.list(main, "grifin", {}, "", function(); end)
menu.action(player_tab,"ladder", {"ladder"}, "puts funny ladder on player",function()
	ladder_attach(ladder,   0.8 ,  3.55,    0   , 1.55  ,  1.55  ,  3.35 , false, pid)
	ladder_attach(ladder,  -0.8 , -3.55,    0   , 1.55  ,  181.55,  3.35 , false, pid)
	ladder_attach(ladder,  -3.55,  1   ,    0   , 1.55  ,  91.55 ,  3.35 , false, pid)
	ladder_attach(ladder,  -3.55,  0.9 ,    0   , 1.55  ,  91.55 ,  3.35 , false, pid)
	ladder_attach(ground,   0   ,  0   ,   -2   , 0     ,  0     , -2    , false, pid)
end)
menu.action(player_tab,"shit kick test", {"cick"}, "kick test",function()
	Kick(pid)
end)
menu.action(player_tab,"expode", {"explode"}, "explodes",function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
	FIRE.ADD_EXPLOSION(pos.x,pos.y,pos.z, 7, 1000, true, false, 1, false)
end)

menu.action(player_tab,"owned expode", {"ownedexplode"}, "explode by me",function()
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
	FIRE.ADD_OWNED_EXPLOSION(PLAYER.GET_PLAYER_PED(players.user()),pos.x,pos.y,pos.z, 7, 1000, true, false, 1, false)
end)

vehicle_tab = menu.list(main, "vehikel", {}, "", function(); end)
menu.action(vehicle_tab,"upgrade", {"ugcar"}, "pimp car",function()
	upgrade_vehicle(pid)
end)

menu.action(vehicle_tab,"kill car", {"killcar"}, "sets health to -4000", function()
	local vehicle = get_player_veh(pid,true)
	if vehicle then
		VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, -4000)
		VEHICLE.SET_VEHICLE_BODY_HEALTH(vehicle, -4000)
		VEHICLE.SET_VEHICLE_PETROL_TANK_HEALTH(vehicle, -4000)
	end
end)	

menu.action(vehicle_tab,"explode car", {"explodecar"}, "",function()
	local vehicle = get_player_veh(pid,false)
	if vehicle then
		VEHICLE.ADD_VEHICLE_PHONE_EXPLOSIVE_DEVICE(vehicle)
		VEHICLE.DETONATE_VEHICLE_PHONE_EXPLOSIVE_DEVICE()
	end
end)

menu.action(vehicle_tab,"burst tires", {"burst"}, "",function()
	local vehicle = get_player_veh(pid,true)
	if vehicle then
		DECORATOR.DECOR_SET_INT(vehicle, "MPBitset", 0)
		if not VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(vehicle) then
			VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, true)
		end
		for i = 0 ,8 do
			VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, i, 1, 1000)
		end
	end
end)

menu.action(vehicle_tab,"slingshot", {"slingshot"}, "shoots player up",function()
	launch_vehicle(pid)
end)

menu.action(vehicle_tab,"give god", {"givegod"}, "give god to vehicle",function()
	local vehicle = get_player_veh(pid,true)
	if vehicle then	
		ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true) 
	end
end)

menu.action(vehicle_tab,"remove god", {"removegod"}, "removes god from vehicle",function()
	local vehicle = get_player_veh(pid,true)
	if vehicle then	
		ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false) 
	end
end)

menu.action(vehicle_tab,"lock doors", {""}, "locks the doors so player cant get out",function()
	local vehicle = get_player_veh(pid,true)
	if vehicle then	
		VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, true)
		VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 4)
	end
end)

menu.action(vehicle_tab,"fuck acceleration", {"setspeed"}, "sets max speed of vehicle to INT_MIN",function()
	local vehicle = get_player_veh(pid,true)
	if vehicle then
		VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, -2147483647) 
	end
end)

menu.action(vehicle_tab,"tp to self", {""}, "tries to teleport vehicle to self",function()
	local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
	tp_veh_to(pid,coords.x,coords.y,coords.z)
end)
menu.action(vehicle_tab,"ocean right?", {""}, "tries to teleport vehicle to ocean",function()	
	tp_veh_to(pid,15000,15000,0)
end)

end

menu.toggle(menu.my_root(),"kick on cyrillic", {}, "kicks player typing cyrillic",function(bop)
	rus_kick = bop
end)
menu.toggle(menu.my_root(),"scrolling licenseplate", {}, "yea",function(bop)
	funky_plate = bop
end)
menu.toggle(menu.my_root(),"hold to boost", {}, "rocket boost while horn pressed",function(bop)
	onkey_boost = bop
end)

chat.on_message(function(sender_player_id, sender_player_name, message, is_team_chat)
	if rus_kick then 
		for C = 1, #rus_chars do
			if string.find(message, rus_chars[C], 1) then	
				util.toast("Detected " .. sender_player_name .. " typing forbidden rus chars!", TOAST_ABOVE_MAP | TOAST_WEB)
				menu.trigger_commands("kick "..sender_player_name)
				--Kick(sender_player_id)
			end
		end
	end
	
	if commands_for_everyone then --this is a realllllly stupid idea but why not)
		if string.find(message, "/cmd ") then
			local cock = string.gsub(message, "/cmd ", "") 
			util.toast(sender_player_name .. " -> \"" .. cock .. "\"", TOAST_ABOVE_MAP | TOAST_WEB | TOAST_LOGGER)
			menu.trigger_commands(cock)
		elseif string.find(message, "/say ") then
			local cock = string.gsub(message, "/say ", "") 
			util.toast(sender_player_name .. " -> \"" .. cock .. "\"", TOAST_ABOVE_MAP | TOAST_WEB | TOAST_LOGGER)
			chat.send_message(cock, false, true, true)	
		elseif string.find(message, "/help") then
			chat.send_message("/cmd - call litteraly any stand command\n/say - say something as me\n/*lua stuff* - do anything with lua", is_team_chat, true, true)
		elseif message:sub(1, 1) == "/" and #message > 1 then --good for testing but doesnt work for some funky reasoning
			local cock = message:sub(2, #message)
			util.toast(sender_player_name .. " -> \"" .. cock .. "\"", TOAST_ABOVE_MAP | TOAST_WEB | TOAST_LOGGER)
			load(cock)()
		end
	end

end)

theme_stuff = menu.list(menu.my_root(), "watermark stuff", {}, "", function(); end)
local watermark_clr = {["r"] = 1,["g"] = 1,["b"] = 1,["a"] = 1}
menu.rainbow(menu.colour(theme_stuff, "color", {"watermark_clr"}, "", {["r"] = 250/255,["g"] = 170/255,["b"] = 230/255,["a"] = 1.0}, true, function(cogg)
	watermark_clr = cogg
end))
menu.toggle(theme_stuff,"watermark", {"watermark"}, "watermark",function(bop)
	watermark = bop
end,true)
menu.toggle(theme_stuff,"flopa", {"flopa"}, "flopa",function(bop)
	floppa = bop
end)
menu.toggle(theme_stuff,"DVD thingy", {"dvd"}, "bouncy dvd thingy that fucks up a lot",function(bop)
	dvd_thingy = bop
end)
local gradient1_clr,gradient2_clr,static_clr = {["r"] = 1,["g"] = 0,["b"] = 1,["a"] = 1},{["r"] = 1,["g"] = 0,["b"] = 1,["a"] = 1},{["r"] = 1,["g"] = 0,["b"] = 1,["a"] = 1}
local gradient1,grad1r,gradient2,grad2r,static,staticr,rb_s = 0,0,0,0,0,0,0;
local rainbow_speed = 10
menu.slider(theme_stuff,"outline type", {""}, "ghetto selection\n0 - off\n1 - rainbow\n2 - gradient\n3 - static\nCAREFULL might fuck ur stand\nand u will have to reinject",0,3,0,1,function(value,prev_value)
	outline = value
	if prev_value == 2 then
		menu.delete(gradient1)
		menu.delete(gradient2)
		menu.delete(grad1r)
		menu.delete(grad2r)
	elseif prev_value == 3 then
		menu.delete(static)
		menu.delete(staticr)
	elseif prev_value == 1 then
		menu.delete(rb_s)	
	end

	if value == 2 then
		gradient1 = menu.colour(theme_stuff, "gradient1", {""}, "", gradient1_clr, true, function(cogg)
			gradient1_clr = cogg
		end)
		grad1r = menu.rainbow(gradient1)
		gradient2 = menu.colour(theme_stuff, "gradient2", {""}, "", gradient2_clr, true, function(cogg)
			gradient2_clr = cogg
		end)
		grad2r = menu.rainbow(gradient2)
	elseif value == 3 then
		static = menu.colour(theme_stuff, "static", {""}, "", static_clr, true, function(cogg)
			static_clr = cogg
		end)
		staticr = menu.rainbow(static)
	elseif value == 1 then
		rb_s = menu.slider(theme_stuff,"rainbow speed", {""}, "rainbow speed",0,100,rainbow_speed,1,function(value,prev_value)rainbow_speed = value end)
	end
end)

test_tab = menu.list(menu.my_root(), "test stuff", {}, "", function(); end)
menu.toggle(test_tab,"enable all commands for everyone in lobby", {}, "sus",function(bop)
	commands_for_everyone = bop
end)

menu.action(test_tab,"detach everything", {}, "detach everything, clientsided",function()
	for_table_do(util.get_all_vehicles(),false,function(ent) 
		ENTITY.DETACH_ENTITY(ent, 1, 1)
	end)
	for_table_do(util.get_all_peds(),false,function(ent) 
		ENTITY.DETACH_ENTITY(ent, 1, 1)
	end)
	for_table_do(util.get_all_objects(),false,function(ent) 
		ENTITY.DETACH_ENTITY(ent, 1, 1)
	end)
end)

menu.action(test_tab,"delete everything", {}, "delete everything from world,might crash game",function()
	for_table_do(util.get_all_vehicles(),false,function(ent) 
		util.delete_entity(ent)
	end)
	for_table_do(util.get_all_peds(),false,function(ent) 
		util.delete_entity(ent)
	end)
	for_table_do(util.get_all_objects(),false,function(ent) 
		util.delete_entity(ent)
	end)
end)

menu.toggle(test_tab,"boost all cars forward", {}, "boosts all cars forward, also sometimes crashes game so B)",function(bop)
	launch_vehicles_forward = bop
end)
menu.toggle(test_tab,"spinbot cars", {}, "speeeeen",function(bop)
	spinbot_vehicles = bop
end)

menu.action(test_tab,"fuck acceleration for all cars", {}, "yes",function()
	local local_veh = get_player_veh(PLAYER.PLAYER_ID(),false)
	for_table_do(util.get_all_vehicles(),true,function(ent) 
		if ent == local_veh then return end
		VEHICLE.MODIFY_VEHICLE_TOP_SPEED(ent, -2147483647)
	end)
end)
menu.action(test_tab,"kill all engine", {}, "kill all engine",function()
	local local_veh = get_player_veh(PLAYER.PLAYER_ID(),false)
	for_table_do(util.get_all_vehicles(),true,function(ent) 
		if ent == local_veh then return end
		VEHICLE.SET_VEHICLE_ENGINE_HEALTH(ent, -4000)
		VEHICLE.SET_VEHICLE_BODY_HEALTH(ent, -4000)
		VEHICLE.SET_VEHICLE_PETROL_TANK_HEALTH(ent, -4000)
	end)
end)

for pid = 0,30 do 
	if players.exists(pid) then
		GenerateFeatures(pid)
	end
end

players.on_join(GenerateFeatures)

-- balls
local lp_text = "    boper skript    "-- text here
local aspect_ratio
local local_hp
local screen_w, screen_h = directx.get_client_size()

function onTick()
	aspect_ratio = GRAPHICS._GET_ASPECT_RATIO()
	local ped = PLAYER.GET_PLAYER_PED(players.user())
	local_hp = ENTITY.GET_ENTITY_HEALTH(ped) * 100 / ENTITY.GET_ENTITY_MAX_HEALTH(ped)
	--local_ap = PED.GET_PED_ARMOUR(ped) * 100 / PLAYER.GET_PLAYER_MAX_ARMOUR(players.user())
end
onTick()

local frames = {}
for i, path in ipairs(filesystem.list_files(filesystem.scripts_dir() .. "gif\\")) do
	frames[#frames + 1] = directx.create_texture(path)
end

function _x(yes)
	return yes / screen_w
end
function _y(yes)
	return yes / screen_h
end
function hsvToRGB(h, s, v)
    local r, g, b
   
    local i = math.floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);
   
    i = i % 6
   
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end
	return {["r"] = r,["g"] = g,["b"] = b,["a"] = 1}
end
function rand_clr()
	return {["r"] = math.random(0,255)/255,["g"] = math.random(0,255)/255,["b"] = math.random(0,255)/255,["a"] = 1}
end
local cur_frame = 1
local last_call_time = util.current_time_millis()
local redo_boost = false
local toggle_boost = false
local flopa_x, flopa_y = 0.5, 0.5
local speed = 3
local bopx, bopy = speed * (math.random(0,1)==0 and _x(-1) or _x(1)), speed * (math.random(0,1)==0 and _y(-1) or _y(1)) --ew
local textsize = 0.7
local rotate = 0
local dvdthing_clr = rand_clr()

local Fps, LastFps = 0,0
local LastTickCount, TickCount = 0,0
function FrameRate() --$$$$$totalynotpasta$$$$$ https://www.unknowncheats.me/forum/d3d-tutorials-and-source/37873-displaying-framerate.html
	TickCount = util.current_time_millis() * 0.001
	Fps = Fps + 1
	if ((TickCount - LastTickCount) >= 1.0) then
		LastTickCount = TickCount
		LastFps = Fps
		Fps = 0
	end
	return LastFps
end
local menu_rainbow_lastcall = util.current_time_millis()
function draw_rect_outline(x,y,w,h,color,color2)
	local rainbow = false
	if not color then rainbow = true end
	w = w + _x(1)
	h = h + _y(1)
	if rainbow then--disgusting
		local delta = util.current_time_millis() - menu_rainbow_lastcall
		menu_rainbow_lastcall = util.current_time_millis()
		rotate = rotate + ((rainbow_speed/100) * delta)
		if rotate >= 360 then rotate = 0 end
		directx.draw_line(x, y, x+w/2, y, hsvToRGB((0+rotate)/360,1,1),hsvToRGB((45+rotate)/360,1,1))
		directx.draw_line(x+w/2, y, x+w, y, hsvToRGB((45+rotate)/360,1,1),hsvToRGB((90+rotate)/360,1,1))

		directx.draw_line(x+w, y, x+w, y+h/2, hsvToRGB((90+rotate)/360,1,1),hsvToRGB((135+rotate)/360,1,1))
		directx.draw_line(x+w, y+h/2, x+w, y+h, hsvToRGB((135+rotate)/360,1,1),hsvToRGB((180+rotate)/360,1,1))

		directx.draw_line(x, y+h, x+w/2, y+h, hsvToRGB((270+rotate)/360,1,1),hsvToRGB((225+rotate)/360,1,1))
		directx.draw_line(x+w/2, y+h, x+w, y+h,hsvToRGB((225+rotate)/360,1,1),hsvToRGB((180+rotate)/360,1,1))

		directx.draw_line(x, y, x, y+h/2, hsvToRGB((360+rotate)/360,1,1),hsvToRGB((315+rotate)/360,1,1))
		directx.draw_line(x, y+h/2, x, y+h, hsvToRGB((315+rotate)/360,1,1),hsvToRGB((270+rotate)/360,1,1))

	elseif color2 then
		directx.draw_line(x, y, x+w, y, color,color2)
		directx.draw_line(x, y+h, x+w, y+h, color2,color)
		directx.draw_line(x, y, x, y+h, color,color2)
		directx.draw_line(x+w, y, x+w, y+h, color2,color)
	else
		directx.draw_line(x, y, x+w, y, color)
		directx.draw_line(x, y+h, x+w, y+h, color)
		directx.draw_line(x, y, x, y+h, color)
		directx.draw_line(x+w, y, x+w, y+h, color)
	end
end
local dvdthinglastcall = util.current_time_millis()
local rotation = 0
while true do
	local fps = FrameRate()
	onTick()
	if floppa then --seems to flicker for some funky ass reason
		directx.draw_texture_client(
			frames[cur_frame],	-- id
			0,					-- index
			-9999,				-- level
			0,					-- time
			0.05,				-- sizeX
			0.05,				-- sizeY
			0.0,				-- centerX
			0.5,				-- centerY
			flopa_x,				-- posX
			flopa_y,				-- posY
			0,				-- rotation
			aspect_ratio,		-- screenHeightScaleFactor
			{					-- colour
				["r"] = 1.0,
				["g"] = 1.0,
				["b"] = 1.0,
				["a"] = 0.4
			}
		)

		local delta = util.current_time_millis() - last_call_time
		if delta > 20 then
			if cur_frame >= #frames then --not sure if this is how it works but who cars B)
				cur_frame = 1
			else
				cur_frame = cur_frame + 1
			end
			last_call_time = util.current_time_millis()
		end
	end

	if menu.is_open() and outline ~= 0 then
		local x,y,w,h = menu.get_main_view_position_and_size()
		if outline == 1 then
			draw_rect_outline(x,y,w,h)
		elseif outline == 2 then
			draw_rect_outline(x,y,w,h,gradient1_clr,gradient2_clr)
		else
			draw_rect_outline(x,y,w,h,static_clr)
		end
	end

	if menu.is_open() and dvd_thingy then
		local text = "boper skript"
		local delta = util.current_time_millis() - dvdthinglastcall
		dvdthinglastcall = util.current_time_millis()
		local sizex, sizey = directx.get_text_size(text, textsize)
		local hitx,hity = false,false
		if flopa_x + sizex >= 1 or flopa_x<= 0 then
			bopx = bopx * -1
			dvdthing_clr = rand_clr()
			hitx = true
		end
		if flopa_y + sizey >= 1 or flopa_y <= 0 then
			bopy = bopy * -1
			dvdthing_clr = rand_clr()
			hity = true
		end
		--do something funny when both corners are hit,idk
		flopa_x = flopa_x + ((bopx/10) * delta) 
		flopa_y = flopa_y + ((bopy/10) * delta) 

		directx.draw_text_client(flopa_x, flopa_y, text, ALIGN_TOP_LEFT, textsize,dvdthing_clr, true)
	end

	if watermark then
		local text = "| boper skript | "..string.format("%.0f", local_hp).."%hp | ".. string.format("%.0f", fps) .."fps | "
		local wmtxt_x, wmtxt_y = directx.get_text_size(text, 0.6)-- cock and balls tbh
		local wmposx,wmposy = _x(20),_y(20) + wmtxt_y*0.4 --u can change watermark pos here

		directx.draw_rect(wmposx, wmposy - wmtxt_y*0.2 - _y(4),wmtxt_x-wmtxt_x*0.025, 0.0038, watermark_clr)
		directx.draw_rect(wmposx, wmposy - wmtxt_y*0.2, wmtxt_x-wmtxt_x*0.025, wmtxt_y + wmtxt_y*0.5, {["r"] = 0.0,["g"] = 0.0,["b"] = 0.0,["a"] = 0.4})
		directx.draw_text(wmposx, wmposy, text, ALIGN_TOP_LEFT, 0.6, {["r"] = 1.0,["g"] = 1.0,["b"] = 1.0,["a"] = 1.0}, false)
		directx.draw_text(wmposx, wmposy, "| boper", ALIGN_TOP_LEFT, 0.6, watermark_clr, false)
		directx.draw_text(wmposx, wmposy, "|", ALIGN_TOP_LEFT, 0.6, {["r"] = 1.0,["g"] = 1.0,["b"] = 1.0,["a"] = 1.0}, false) --frick
	end	

	if launch_vehicles_forward then
		local local_veh = get_player_veh(PLAYER.PLAYER_ID(),false)
		for_table_do(util.get_all_vehicles(),true,function(ent) 
			if ent == local_veh then return end
			ENTITY.APPLY_FORCE_TO_ENTITY(ent, 1, 0, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		end)
	end

	if spinbot_vehicles then
		local local_veh = get_player_veh(PLAYER.PLAYER_ID(),false)
		for_table_do(util.get_all_vehicles(),true,function(ent) 
			if ent == local_veh then return end
			ENTITY.SET_ENTITY_ROTATION(ent, 0, 0, rotation, 0, 0)
		end)
		rotation = rotation + 20
		if rotation >= 360 then
			rotation = 0
		end
	end

	if funky_plate then
		local veh = util.get_vehicle()
		if veh then
			local delta = util.current_time_millis() - last_call_time
			if delta > 200 then
				lp_text = marqee(lp_text)
				last_call_time = util.current_time_millis()
			end
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh,lp_text)
		end
	end

	if onkey_boost then --funky
		local veh = util.get_vehicle() 
		if veh then
			--menu.trigger_commands("boostmod infinite")
			if not PLAYER.IS_PLAYER_PRESSING_HORN(players.user()) and redo_boost then
				menu.trigger_commands("boostmod empty")
				redo_boost = false	
			else
				menu.trigger_commands("boostmod infinite")
				if PLAYER.IS_PLAYER_PRESSING_HORN(players.user()) then
					redo_boost = true
				end
			end
		end
	end
	util.yield()
end