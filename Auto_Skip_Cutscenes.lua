local SCRIPT_NAME = "Auto Cutscene Skipper"


local mode = -1
local root = -1

function catch(what)
    return what[1]
end
 
function try(what)
    status, result = pcall(what[1])
    if not status then
       what[2](result)
    end
    return result
end

function try_catch(int_try, int_catch)
    try{function()
        int_try()
    end,
    catch{function()
        int_catch()
     end}
    }
end


try{function()
    menu.notify("")
    mode = 0
    root = menu.add_feature(SCRIPT_NAME, "parent", 0).id
end,
catch{function()
    require("natives-1614644776") 
    mode = 1
    root = menu.my_root()
    menu.divider(root, SCRIPT_NAME)
 end}
}

local name = "Unknown"

if mode == 1 then
    name = "Stand"
else
    name = "2Take1"
end


--start menu specific functions--

function stand_vector3(x, y, z)
    if mode == 1 then
        coords = {}
        coords["x"] = x
        coords["y"] = y
        coords["z"] = z
        return coords
    else
        return v3(x, y, z)
    end
end

function stand_keep_running()
    if mode == 1 then
        while true do 
            util.yield()
        end

    end
end

--start internal functions--

function internal_notification(text)
    if mode == 1 then
        util.toast(text)
    else
        menu.notify(text)
    end
end

function internal_yield(ms)
    if mode == 1 then
        util.yield(ms)
    else
        try{function()
            for i=0,ms do
                endsystem.yield()       
            end
        end,catch{function()
        end}}

    end
end

function internal_joaat(name)
    if mode == 1 then
        return util.joaat(name)
    else
        return gameplay.get_hash_key(name)
    end
end


function internal_on_stop(code)
    if mode == 1 then
        util.on_stop(code)
    else
        event.add_event_listener('exit', code)
    end
end

-- start streaming natives --
function streaming_request_model(model)
    if mode == 1 then
        STREAMING.REQUEST_MODEL(model)
    else
        streaming.request_model(model)
    end
end
function streaming_has_model_loaded(model)
    if mode == 1 then
        return STREAMING.HAS_MODEL_LOADED(model)
    else
        return streaming.has_model_loaded(model)
    end
end
function streaming_set_model_as_no_longer_needed(model)
    if mode == 1 then
        return STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(model)
    else
        return streaming.set_model_as_no_longer_needed(model)
    end
end
function streaming_is_model_in_cdimage(model)
    if mode == 1 then
        return STREAMING.IS_MODEL_IN_CDIMAGE(model)
    else
        return streaming.is_model_in_cdimage(model)
    end
end
function streaming_is_model_valid(model)
    if mode == 1 then
        return STREAMING.IS_MODEL_VALID(model)
    else
        return streaming.is_model_valid(model)
    end
end
function streaming_is_model_a_plane(model)
    if mode == 1 then
        return STREAMING.IS_MODEL_A_PLANE(model)
    else
        return streaming.is_model_a_plane(model)
    end
end
function streaming_is_model_a_vehicle(model)
    if mode == 1 then
        return STREAMING.IS_MODEL_A_VEHICLE(model)
    else
        return streaming.is_model_a_vehicle(model)
    end
end
function streaming_is_model_a_heli(model)
    if mode == 1 then
        return STREAMING.IS_MODEL_A_HELI(model)
    else
        return streaming.is_model_a_heli(model)
    end
end
function streaming_request_ipl(szName)
    if mode == 1 then
        STREAMING.REQUEST_IPL(szName)
    else
        streaming.request_ipl(model)
    end
end
function streaming_remove_ipl(szName)
    if mode == 1 then
        STREAMING.REMOVE_IPL(szName)
    else
        streaming.remove_ipl(model)
    end
end
-- end streaming natives --
-- start entity natives --
function entity_set_entity_as_mission_entity(entity, toggle) 
    if mode == 1 then
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, toggle, true)
    else
        entity.set_entity_as_mission_entity(entity, toggle, true)
    end

end
function entity_delete_entity(entity) 
    --entity_set_entity_as_mission_entity(entity, true)
    if mode == 1 then
        util.delete_entity(entity)
    else
        entity.delete_entity(entity)
    end

end
-- end entity natives --

function internal_create_ped(type, hash, x, y, z, heading)
    if mode == 1 then
        return util.create_ped(type, hash, stand_vector3(x, y, z), heading)
    else
        return ped.create_ped(type, hash, v3(x, y, z), 1, true, true)
    end
end

function internal_create_vehicle(hash, x, y, z, heading)
    if mode == 1 then
        if STREAMING.IS_MODEL_A_VEHICLE(hash) then
            STREAMING.REQUEST_MODEL(hash)
            while not STREAMING.HAS_MODEL_LOADED(hash) do
                util.yield()
            end
            veh = util.create_vehicle(hash, stand_vector3(x, y, z), heading)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
            return veh
        end
        
    else
        
        if streaming.is_model_a_vehicle(hash) then
            streaming.request_model(hash)
            while not streaming.has_model_loaded(hash) do
                internal_yield(1)
            end
            veh = vehicle.create_vehicle(hash, v3(x, y, z), 1, true, false)
            streaming.set_model_as_no_longer_needed(hash)
            return veh
        end
    end
end
-- end streaming natives --
-- start cutscene natives --
function cutscene_stop_cutscene_immediately()
    if mode == 1 then 
        CUTSCENE.STOP_CUTSCENE_IMMEDIATELY()
    else 
        cutscene.stop_cutscene_immediately()
    end
end
-- end cutscene natives --
-- start menu functions --

function create_menu_option(name, action)
    if mode == 1 then
        menu.action(menu.my_root(), name, {""}, "", function(on_click)
            action()
        end)
    else 
        menu.add_feature(name, "action", root, function(f)
            action()
            return HANDLER_POP
        end)
    end
end
function create_toggle(name, action)
    if mode == 1 then
        menu.toggle(menu.my_root(), name, {""}, "", function(on_toggle)
            while on_toggle do 
                action()
                util.yield()
            end
        end)
    else 
        menu.add_feature(name, "toggle", root, function(f)
            while f.on do 
                action()
                return HANDLER_CONTINUE
            end
        end)
    end
end
internal_notification("You are using Auto Cutscene Skipper on " .. name .. ".")
create_toggle("Auto Skip Cutscenes", function() 
    cutscene_stop_cutscene_immediately()
end)
stand_keep_running()



