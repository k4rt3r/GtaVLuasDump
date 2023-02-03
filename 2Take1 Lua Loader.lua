-- 2Take1 Lua Loader 0.2
-- Allows you to load some Lua scripts made for 2Take1Menu with Stand

-- Implemented from https://docs.2take1.menu/features/api/#entity-functions
-- With some implementation details copied from 2Take1Menu itself as convenient

-- Prepare 2Take1 Lua Loader
require("natives-1606100775")
stand = menu
local _2take1_lua_loader = {
	["player_script_features_lists"] = {},
	["player_features"] = {}
}
_2take1_lua_loader.add_feature = function(name, feat_type, parent, callback, callback_extra)
if parent == nil then
	parent = stand.my_root()
end
local handler = function() end
local f = {
	["name"] = name
}
if feat_type == "action" then
	if callback then
		handler =
		function()
			while callback(f, callback_extra) == HANDLER_CONTINUE do
				util.yield()
			end
		end
	end
	f.type = 2048
	f.id = stand.action(parent, name, {}, "", handler)
elseif feat_type == "parent" then
	if callback then
		error("Callback on parent is not supported")
	end
	f.type = 512
	f.id = stand.list(parent, name)
elseif feat_type == "toggle" then
	if callback then
		local handler_running = false
		handler =
		function(on)
			f.on = on
			if handler_running then
				return
			end
			handler_running = true
			while callback(f, callback_extra) == HANDLER_CONTINUE do
				util.yield()
			end
			handler_running = false
		end
	end
	f.type = 1
	f.id = stand.toggle(parent, name, {}, "", handler)
else
	error("Unsupported type: " + feat_type)
end
return f
end
_2take1_lua_loader.add_script_features_list_to_player = function(pid)
_2take1_lua_loader.player_script_features_lists[pid] = stand.list(stand.player_root(pid), "Script Features")
for _, playerfeat in pairs(_2take1_lua_loader.player_features) do
	_2take1_lua_loader.add_player_feature_to_player(pid, playerfeat)
end
end
_2take1_lua_loader.add_player_feature_to_player = function(pid, playerfeat)
_2take1_lua_loader.add_feature(playerfeat.name, playerfeat.feat_type, _2take1_lua_loader.player_script_features_lists[pid], playerfeat.callback, pid)
end

-- Constants
HANDLER_CONTINUE = 0
HANDLER_POP = 1

-- v3
function v3(x, y, z)
	return {
		["x"] = x,
		["y"] = y,
		["z"] = z
	}
end

-- Menu Functions
menu = {
	["delete_feature"] = stand.delete
}
function menu.add_feature(name, feat_type, parent, callback)
	return _2take1_lua_loader.add_feature(name, feat_type, parent, callback)
end
function menu.add_player_feature(name, feat_type, parent, callback)
	if feat_type == "parent" then
		error("Player feature of type parent is not supported")
	end
	local playerfeat = {
		["name"] = name,
		["feat_type"] = feat_type,
		["callback"] = callback
	}
	table.insert(_2take1_lua_loader.player_features, playerfeat)
	for pid, _ in pairs(_2take1_lua_loader.player_script_features_lists) do
		_2take1_lua_loader.add_player_feature_to_player(pid, playerfeat)
	end
end

-- Player Functions
_natives_PLAYER = PLAYER
player = {
	["get_player_ped"] =
	function(player)
		return _natives_PLAYER.GET_PLAYER_PED()
	end,
	["player_id"] =
	function()
		return players.user()
	end
}

-- Entity Functions
_natives_ENTITY = ENTITY
entity = {
	["set_entity_coords_no_offset"] =
	function(entity, pos)
		_natives_ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entity, pos.x, pos.y, pos.z, false, false, false)
	end
}

-- Streaming Functions
_natives_STREAMING = STREAMING
streaming = {
	["request_ipl"] =
	function(name)
		_natives_STREAMING.REQUEST_IPL(name)
	end,
	["remove_ipl"] =
	function(name)
		_natives_STREAMING.REMOVE_IPL(name)
	end
}

-- UI Functions
ui = {
	["notify_above_map"] =
	function(message, title, color)
		HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)
		util.BEGIN_TEXT_COMMAND_THEFEED_POST(message)
		HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT("CHAR_HUMANDEFAULT", "CHAR_HUMANDEFAULT", false, 4, "2Take1Lua Loader", title)
	end
}

-- Script Functions
script = {}
function script.trigger_script_event(first_arg, receiver, args)
	table.insert(args, 1, first_arg)
	util.trigger_script_event(1 << receiver, args)
end

-- System Functions
system = {
	["wait"] = util.yield,
	["yield"] = util.yield
}

-- Populate Script List
local dir = filesystem.scripts_dir() .. "From 2Take1Menu\\"
if not filesystem.is_dir(dir) then
	filesystem.mkdir(dir)
end
local no_scripts = true
stand.divider(stand.my_root(), "Scripts")
for i, path in ipairs(filesystem.list_files(dir)) do
	if filesystem.is_regular_file(path) then
		no_scripts = false
		path = string.sub(path, string.len(dir) + 1)
		stand.action(stand.my_root(), path, {}, "", function()
			local chunk, err = loadfile(dir .. path)
			local status
			if chunk then
				status, err = xpcall(chunk, function(e)
					util.toast(e)
					util.log(debug.traceback(e, 2))
				end)
				if status then
					util.toast("Successfully loaded " .. path)
					return
				end
			end
			util.toast(err, TOAST_ALL)
		end)
	end
end
if no_scripts then
	util.toast("Found no scripts in " .. dir)
else
	for _, pid in ipairs(players.list()) do
		_2take1_lua_loader.add_script_features_list_to_player(pid)
	end
	players.on_join(function(pid)
		_2take1_lua_loader.add_script_features_list_to_player(pid)
	end)
	players.on_leave(function(pid)
		_2take1_lua_loader.player_script_features_lists[pid] = nil
	end)
	stand.divider(stand.my_root(), "Script Features")
	while true do
		util.yield()
	end
end
