require("natives-1609079541")

if modLoaded then
	util.toast("iplLoader is already loaded.")
	return 
end
modLoaded = true


function teleportHome()
	ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), -63.477, -786.490, 44.227)
	return 1
end

function defaultCargoship()
	STREAMING.REMOVE_IPL("sunkcargoship")
	STREAMING.REMOVE_IPL("SUNK_SHIP_FIRE")
	STREAMING.REQUEST_IPL("cargoship")
	return 1
end

function sunkenCargoship()
	STREAMING.REMOVE_IPL("cargoship")
	STREAMING.REQUEST_IPL("sunkcargoship")
	STREAMING.REQUEST_IPL("SUNK_SHIP_FIRE")
	return 1
end

function tpCargoship()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -163.3628, -2385.161, 5.999994)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, -163.3628, -2385.161, 5.999994)
	end
	return 1
end

function loadMorgue()
	local iplList = {"coronertrash","Coroner_Int_On"}
		for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function unLoadMorgue()
	local iplList = {"coronertrash","Coroner_Int_On"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	return 1
end

function tpMorgue()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 275.446, -1361.11, 24.5378)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 275.446, -1361.11, 24.5378)
	end
	return 1
end

function LoadCasino()
	local iplList = {"vw_casino_main﻿","hei_dlc_casino_door","vw_dlc_casino_door"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function tpCasino()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 1109.996, 222.625, -49.841)
		util.yield(100)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 1109.996, 222.625, -49.841)
		util.yield(1000)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 1109.996, 222.625, -49.841)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 1109.996, 222.625, -49.841)
		util.yield(100)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 1109.996, 222.625, -49.841)
		util.yield(1000)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 1109.996, 222.625, -49.841)
	end
	return 1
end

function LoadPenthouse()
	local iplList = {"vw_casino_penthouse","hei_dlc_windows_casino"}
	--local intLocation = interior.get_interior_at_coords_with_type(v3(976.636, 70.295, 116.160),1)
	--local intList = {"Set_Pent_Tint_Shell","Set_Pent_Pattern_01","Set_Pent_Spa_Bar_Open","Set_Pent_Media_Bar_Open","Set_Pent_Dealer","Set_Pent_Arcade_Modern","Set_Pent_Bar_Clutter","set_pent_bar_light_0"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	--interior.enable_interior_prop(intLocation, "Set_Pent_Tint_Shell") -- @Sub please add INTERIOR::GET_INTERIOR_AT_COORDS()
	--[[for i, props in ipairs(intList) do
		interior.enable_interior_prop(intLocation, props)
	end]]--
	return 1
end

function unLoadPenthouse()
	local iplList = {"vw_casino_penthouse","hei_dlc_windows_casino"}
	local intLocation = interior.get_interior_at_coords_with_type(976.636, 70.295, 116.160,0)
	local intList = {"Set_Pent_Tint_Shell","Set_Pent_Pattern_01","Set_Pent_Spa_Bar_Open","Set_Pent_Media_Bar_Open","Set_Pent_Dealer","Set_Pent_Arcade_Modern","Set_Pent_Bar_Clutter","set_pent_bar_light_0"}
	local iplList = {"vw_casino_penthouse","hei_dlc_windows_casino"}
	local interiorList = {""}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	--[[for i, props in ipairs(intList) do
		interior.disable_interior_prop(intLocation, props)
	end]]--
	return 1
end

function tpPenthouse()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 976.636, 70.295, 116.160)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 976.636, 70.295, 116.160)
	end
	return 1
end

function LoadCasinoGarage()
	local iplList = {"vw_casino_garage"}
	local interiorList = {""}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function unLoadCasinoGarage()
	local iplList = {"vw_casino_garage"}
	local interiorList = {""}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	return 1
end

function tpCasinoGarage()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 1295.000, 230.000, -49.058)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 1295.000, 230.000, -49.058)
	end
	return 1
end

function LoadCasinoCarPark()
	local iplList = {"vw_casino_carpark"}
	local interiorList = {""}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function unLoadCasinoCarPark()
	local iplList = {"vw_casino_carpark"}
	local interiorList = {""}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	return 1
end

function tpCasinoCarPark()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 380.000, 200.000, -49.058)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 380.000, 200.000, -49.058)
	end
	return 1
end

function rebuildStilt()
	STREAMING.REMOVE_IPL("DES_StiltHouse_imapend")
	STREAMING.REQUEST_IPL("DES_stilthouse_rebuild")
	return 1
end

function brokenStilt()
	STREAMING.REMOVE_IPL("DES_stilthouse_rebuild")
	STREAMING.REQUEST_IPL("DES_StiltHouse_imapend")
	return 1
end

function tpStilt()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -984.259, 661.130, 165.664)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, -984.259, 661.130, 165.664)
	end
	return 1
end

function loadStadium()
	local iplList = {"SP1_10_real_interior"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function unLoadStadium()
	local iplList = {"SP1_10_real_interior"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	return 1
end

function tpStadium()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -248.6731, -2010.603, 30.14562)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, -248.6731, -2010.603, 30.14562)
	end
	return 1
end

function loadRenda()
	local iplList = {"refit_unload"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function unLoadRenda()
	local iplList = {"refit_unload"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	return 1
end

function tpRenda()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -585.8247, -282.72, 35.45475)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, -585.8247, -282.72, 35.45475)
	end
	return 1
end

function loadJewel()
	local iplList = {"bh1_16_refurb","jewel2fake"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	local iplList = {"post_hiest_unload"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function unLoadJewel()
	local iplList = {"post_hiest_unload"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	local iplList = {"jewel2fake"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function tpJewel()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -630.07, -236.332, 38.05704)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, -630.07, -236.332, 38.05704)
	end
	return 1
end

function loadFIB()
	local iplList = {"FIBlobby"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function unLoadFIB()
	local iplList = {"FIBlobby"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	return 1
end

function tpFIB()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 110.4, -744.2, 45.7496)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 110.4, -744.2, 45.7496)
	end
	return 1
end

function cleanTrailer()
	STREAMING.REMOVE_IPL("TrevorsMP")
	STREAMING.REQUEST_IPL("TrevorsTrailerTidy")
	util.yield(50)
	ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 1975.552, 3820.538, 33.44833)
	return 1
end

function dirtyTrailer()
	STREAMING.REMOVE_IPL("TrevorsTrailerTidy")
	STREAMING.REQUEST_IPL("TrevorsMP")
	util.yield(50)
	ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), 1975.552, 3820.538, 33.44833)
	return 1
end

function tpTrailer()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 1975.552, 3820.538, 33.44833)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 1975.552, 3820.538, 33.44833)
	end
	return 1
end

function heistYacht()
	local iplList = {"hei_yacht_heist","hei_yacht_heist_enginrm","hei_yacht_heist_Lounge","hei_yacht_heist_Bridge","hei_yacht_heist_Bar","hei_yacht_heist_Bedrm","hei_yacht_heist_DistantLights","hei_yacht_heist_LODLights"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	local iplList = {"smboat","smboat_lod"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	return 1
end

function partyYacht()
	local iplList = {"smboat","smboat_lod"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	local iplList = {"hei_yacht_heist","hei_yacht_heist_enginrm","hei_yacht_heist_Lounge","hei_yacht_heist_Bridge","hei_yacht_heist_Bar","hei_yacht_heist_Bedrm","hei_yacht_heist_DistantLights","hei_yacht_heist_LODLights"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	return 1
end

function unLoadYacht()
	local iplList = {"hei_yacht_heist","hei_yacht_heist_enginrm","hei_yacht_heist_Lounge","hei_yacht_heist_Bridge","hei_yacht_heist_Bar","hei_yacht_heist_Bedrm","hei_yacht_heist_DistantLights","hei_yacht_heist_LODLights","smboat","smboat_lod"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	return 1
end

function tpYacht()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -2027.946, -1036.695, 6.707587)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, -2027.946, -1036.695, 6.707587)
	end
	return 1
end

function loadTrain()
	local iplList = {"canyonriver01","railing_start"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	local iplList = {"canyonriver01_traincrash","railing_end"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function unLoadTrain()
	local iplList = {"canyonriver01_traincrash","railing_end"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	local iplList = {"canyonriver01","railing_start"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function tpTrain()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -532.1309, 4526.187, 89.79387)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, -532.1309, 4526.187, 89.79387)
	end
	return 1
end

function burningFarm()
	local iplList = {"farm","farm_props","farmint","farmint_cap","farm_burnt","farm_burnt_props","des_farmhouse","des_farmhs_endimap","des_farmhs_startimap","des_farmhs_end_occl","des_farmhs_start_occl"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	local iplList = {"farm","des_farmhouse","des_farmhs_endimap","des_farmhs_startimap","des_farmhs_end_occl","des_farmhs_start_occl"}
	--local iplList = {"farmint","farm_burnt","farm_burnt_props","des_farmhs_endimap"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function burnedFarm()
	local iplList = {"farm","farm_props","farmint","farmint_cap","farm_burnt","farm_burnt_props","des_farmhouse","des_farmhs_endimap","des_farmhs_startimap","des_farmhs_end_occl","des_farmhs_start_occl"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	local iplList = {"farm_burnt","farm_burnt_props"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function normalFarm()
	local iplList = {"farm","farm_props","farmint","farmint_cap","farm_burnt","farm_burnt_props","des_farmhouse","des_farmhs_endimap","des_farmhs_startimap","des_farmhs_end_occl","des_farmhs_start_occl"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	local iplList = {"farm","farm_props","farmint","farmint_cap","des_farmhouse"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function tpFarm()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 2469.03, 4955.278, 45.11892)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 2469.03, 4955.278, 45.11892)
	end
	return 1
end

function loadChicken()
	local iplList = {"cs1_02_cf_onmission1","cs1_02_cf_onmission2","cs1_02_cf_onmission3","cs1_02_cf_onmission4"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function unLoadChicken()
	local iplList = {"cs1_02_cf_onmission1","cs1_02_cf_onmission2","cs1_02_cf_onmission3","cs1_02_cf_onmission4"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	return 1
end

function tpChicken()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -74.635, 6239.129, 31.082)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, -74.635, 6239.129, 31.082)
	end
	return 1
end

function loadCargoPlane()
	local iplList = {"crashed_cargoplane"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function unLoadCargoPlane()
	local iplList = {"crashed_cargoplane"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	return 1
end

function tpCargoPlane()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 300.705139, 3979.68262, 3.044629)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 300.705139, 3979.68262, 3.044629)
	end
	return 1
end

function loadYankton()
	local iplList = {"prologue01","prologue01c","prologue01d","prologue01e","prologue01f","prologue01g","prologue01h","prologue01i","prologue01j","prologue01k","prologue01z","prologue02","prologue03","prologue03b","prologue03_grv_dug","prologue_grv_torch","prologue04","prologue04b","prologue04_cover","des_protree_end","des_protree_start","prologue05","prologue05b","prologue06","prologue06b","prologue06b_int","prologue06b_pannel","plg_occl_00","prologue_occl","prologuerd","prologuerdb"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	util.toast("North Yankton Loaded.")
	return 1
end

function unLoadYankton()
	local iplList = {"prologue01","prologue01c","prologue01d","prologue01e","prologue01f","prologue01g","prologue01h","prologue01i","prologue01j","prologue01k","prologue01z","prologue02","prologue03","prologue03b","prologue03_grv_dug","prologue_grv_torch","prologue04","prologue04b","prologue04_cover","des_protree_end","des_protree_start","prologue05","prologue05b","prologue06","prologue06b","prologue06b_int","prologue06b_pannel","plg_occl_00","prologue_occl","prologuerd","prologuerdb"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	util.toast("North Yankton Unloaded.")
	return 1
end

function tpYankton()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 3217.697, -4834.826, 111.8152)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 3217.697, -4834.826, 111.8152)
	end
	return 1
end

function loadUFO()
	local iplList = {"ufo_eye"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function unLoadUFO()
	local iplList = {"ufo_eye"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	return 1
end

function tpUFO()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 501.729, 5603.795, 797.910)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 501.729, 5603.795, 797.910)
	end
	return 1
end

function loadRed()
	local iplList = {"redcarpet"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function unLoadRed()
	local iplList = {"redcarpet"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	return 1
end

function tpRed()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 294.651855, 189.581818, 105.084229)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 294.651855, 189.581818, 105.084229)
	end
	return 1
end

function loadFace()
	local iplList = {"facelobby"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	return 1
end

function unLoadFace()
	local iplList = {"facelobby"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	return 1
end

function tpFace()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, -1083.737, -254.300, 37.763)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, -1083.737, -254.300, 37.763)
	end
	return 1
end

function loadIsland()
	local iplList = {"h4_mph4_terrain_occ_09","h4_mph4_terrain_occ_06","h4_mph4_terrain_occ_05","h4_mph4_terrain_occ_01","h4_mph4_terrain_occ_00","h4_mph4_terrain_occ_08","h4_mph4_terrain_occ_04","h4_mph4_terrain_occ_07","h4_mph4_terrain_occ_03","h4_mph4_terrain_occ_02","h4_islandx_terrain_04","h4_islandx_terrain_05_slod","h4_islandx_terrain_props_05_d_slod","h4_islandx_terrain_02","h4_islandx_terrain_props_05_a_lod","h4_islandx_terrain_props_05_c_lod","h4_islandx_terrain_01","h4_mph4_terrain_04","h4_mph4_terrain_06","h4_islandx_terrain_04_lod","h4_islandx_terrain_03_lod","h4_islandx_terrain_props_06_a","h4_islandx_terrain_props_06_a_slod","h4_islandx_terrain_props_05_f_lod","h4_islandx_terrain_props_06_b","h4_islandx_terrain_props_05_b_lod","h4_mph4_terrain_lod","h4_islandx_terrain_props_05_e_lod","h4_islandx_terrain_05_lod","h4_mph4_terrain_02","h4_islandx_terrain_props_05_a","h4_mph4_terrain_01_long_0","h4_islandx_terrain_03","h4_islandx_terrain_props_06_b_slod","h4_islandx_terrain_01_slod","h4_islandx_terrain_04_slod","h4_islandx_terrain_props_05_d_lod","h4_islandx_terrain_props_05_f_slod","h4_islandx_terrain_props_05_c","h4_islandx_terrain_02_lod","h4_islandx_terrain_06_slod","h4_islandx_terrain_props_06_c_slod","h4_islandx_terrain_props_06_c","h4_islandx_terrain_01_lod","h4_mph4_terrain_06_strm_0","h4_islandx_terrain_05","h4_islandx_terrain_props_05_e_slod","h4_islandx_terrain_props_06_c_lod","h4_mph4_terrain_03","h4_islandx_terrain_props_05_f","h4_islandx_terrain_06_lod","h4_mph4_terrain_01","h4_islandx_terrain_06","h4_islandx_terrain_props_06_a_lod","h4_islandx_terrain_props_06_b_lod","h4_islandx_terrain_props_05_b","h4_islandx_terrain_02_slod","h4_islandx_terrain_props_05_e","h4_islandx_terrain_props_05_d","h4_mph4_terrain_05","h4_mph4_terrain_02_grass_2","h4_mph4_terrain_01_grass_1","h4_mph4_terrain_05_grass_0","h4_mph4_terrain_01_grass_0","h4_mph4_terrain_02_grass_1","h4_mph4_terrain_02_grass_0","h4_mph4_terrain_02_grass_3","h4_mph4_terrain_04_grass_0","h4_mph4_terrain_06_grass_0","h4_mph4_terrain_04_grass_1","island_distantlights","island_lodlights","h4_yacht_strm_0","h4_yacht","h4_yacht_long_0","h4_islandx_yacht_01_lod","h4_clubposter_palmstraxx","h4_islandx_yacht_02_int","h4_islandx_yacht_02","h4_clubposter_moodymann","h4_islandx_yacht_01","h4_clubposter_keinemusik","h4_islandx_yacht_03","h4_ch2_mansion_final","h4_islandx_yacht_03_int","h4_yacht_critical_0","h4_islandx_yacht_01_int","h4_mph4_island_placement","h4_islandx_mansion_vault","h4_islandx_checkpoint_props","h4_islandairstrip_hangar_props_slod","h4_se_ipl_01_lod","h4_ne_ipl_00_slod","h4_se_ipl_06_slod","h4_ne_ipl_00","h4_se_ipl_02","h4_islandx_barrack_props_lod","h4_se_ipl_09_lod","h4_ne_ipl_05","h4_mph4_island_se_placement","h4_ne_ipl_09","h4_islandx_mansion_props_slod","h4_se_ipl_09","h4_mph4_mansion_b","h4_islandairstrip_hangar_props_lod","h4_islandx_mansion_entrance_fence","h4_nw_ipl_09","h4_nw_ipl_02_lod","h4_ne_ipl_09_slod","h4_sw_ipl_02","h4_islandx_checkpoint","h4_islandxdock_water_hatch","h4_nw_ipl_04_lod","h4_islandx_maindock_props","h4_beach","h4_islandx_mansion_lockup_03_lod","h4_ne_ipl_04_slod","h4_mph4_island_nw_placement","h4_ne_ipl_08_slod","h4_nw_ipl_09_lod","h4_se_ipl_08_lod","h4_islandx_maindock_props_lod","h4_se_ipl_03","h4_sw_ipl_02_slod","h4_nw_ipl_00","h4_islandx_mansion_b_side_fence","h4_ne_ipl_01_lod","h4_se_ipl_06_lod","h4_ne_ipl_03","h4_islandx_maindock","h4_se_ipl_01","h4_sw_ipl_07","h4_islandx_maindock_props_2","h4_islandxtower_veg","h4_mph4_island_sw_placement","h4_se_ipl_01_slod","h4_mph4_wtowers","h4_se_ipl_02_lod","h4_islandx_mansion","h4_nw_ipl_04","h4_mph4_airstrip_interior_0_airstrip_hanger","h4_islandx_mansion_lockup_01","h4_islandx_barrack_props","h4_nw_ipl_07_lod","h4_nw_ipl_00_slod","h4_sw_ipl_08_lod","h4_islandxdock_props_slod","h4_islandx_mansion_lockup_02","h4_islandx_mansion_slod","h4_sw_ipl_07_lod","h4_islandairstrip_doorsclosed_lod","h4_sw_ipl_02_lod","h4_se_ipl_04_slod","h4_islandx_checkpoint_props_lod","h4_se_ipl_04","h4_se_ipl_07","h4_mph4_mansion_b_strm_0","h4_nw_ipl_09_slod","h4_se_ipl_07_lod","h4_islandx_maindock_slod","h4_islandx_mansion_lod","h4_sw_ipl_05_lod","h4_nw_ipl_08","h4_islandairstrip_slod","h4_nw_ipl_07","h4_islandairstrip_propsb_lod","h4_islandx_checkpoint_props_slod","h4_aa_guns_lod","h4_sw_ipl_06","h4_islandx_maindock_props_2_slod","h4_islandx_mansion_office","h4_islandx_maindock_lod","h4_mph4_dock","h4_islandairstrip_propsb","h4_islandx_mansion_lockup_03","h4_nw_ipl_01_lod","h4_se_ipl_05_slod","h4_sw_ipl_01_lod","h4_nw_ipl_05","h4_islandxdock_props_2_lod","h4_ne_ipl_04_lod","h4_ne_ipl_01","h4_beach_party_lod","h4_islandx_mansion_lights","h4_sw_ipl_00_lod","h4_islandx_mansion_guardfence","h4_beach_props_party","h4_ne_ipl_03_lod","h4_islandx_mansion_b","h4_beach_bar_props","h4_ne_ipl_04","h4_sw_ipl_08_slod","h4_islandxtower","h4_se_ipl_00_slod","h4_islandx_barrack_hatch","h4_ne_ipl_06_slod","h4_ne_ipl_03_slod","h4_sw_ipl_09_slod","h4_ne_ipl_02_slod","h4_nw_ipl_04_slod","h4_ne_ipl_05_lod","h4_nw_ipl_08_slod","h4_sw_ipl_05_slod","h4_islandx_mansion_b_lod","h4_ne_ipl_08","h4_islandxdock_props","h4_islandairstrip_doorsopen_lod","h4_se_ipl_05_lod","h4_islandxcanal_props_slod","h4_mansion_gate_closed","h4_se_ipl_02_slod","h4_nw_ipl_02","h4_ne_ipl_08_lod","h4_sw_ipl_08","h4_islandairstrip","h4_islandairstrip_props_lod","h4_se_ipl_05","h4_ne_ipl_02_lod","h4_islandx_maindock_props_2_lod","h4_sw_ipl_03_slod","h4_ne_ipl_01_slod","h4_beach_props_slod","h4_underwater_gate_closed","h4_ne_ipl_00_lod","h4_islandairstrip_doorsopen","h4_sw_ipl_01_slod","h4_se_ipl_00","h4_se_ipl_06","h4_islandx_mansion_lockup_02_lod","h4_islandxtower_veg_lod","h4_sw_ipl_00","h4_se_ipl_04_lod","h4_nw_ipl_07_slod","h4_islandx_mansion_props_lod","h4_islandairstrip_hangar_props","h4_nw_ipl_06_lod","h4_islandxtower_lod","h4_islandxdock_lod","h4_islandxdock_props_lod","h4_beach_party","h4_nw_ipl_06_slod","h4_islandairstrip_doorsclosed","h4_nw_ipl_00_lod","h4_ne_ipl_02","h4_islandxdock_slod","h4_se_ipl_07_slod","h4_islandxdock","h4_islandxdock_props_2_slod","h4_islandairstrip_props","h4_sw_ipl_09","h4_ne_ipl_06","h4_se_ipl_03_lod","h4_nw_ipl_03","h4_islandx_mansion_lockup_01_lod","h4_beach_lod","h4_ne_ipl_07_lod","h4_nw_ipl_01","h4_mph4_island_lod","h4_islandx_mansion_office_lod","h4_islandairstrip_lod","h4_beach_props_lod","h4_nw_ipl_05_slod","h4_islandx_checkpoint_lod","h4_nw_ipl_05_lod","h4_nw_ipl_03_slod","h4_nw_ipl_03_lod","h4_sw_ipl_05","h4_mph4_mansion","h4_sw_ipl_03","h4_se_ipl_08_slod","h4_mph4_island_ne_placement","h4_aa_guns","h4_islandairstrip_propsb_slod","h4_sw_ipl_01","h4_mansion_remains_cage","h4_nw_ipl_01_slod","h4_ne_ipl_06_lod","h4_se_ipl_08","h4_sw_ipl_04_slod","h4_sw_ipl_04_lod","h4_mph4_beach","h4_sw_ipl_06_lod","h4_sw_ipl_06_slod","h4_se_ipl_00_lod","h4_ne_ipl_07_slod","h4_mph4_mansion_strm_0","h4_nw_ipl_02_slod","h4_mph4_airstrip","h4_island_padlock_props","h4_islandairstrip_props_slod","h4_nw_ipl_06","h4_sw_ipl_09_lod","h4_islandxcanal_props_lod","h4_ne_ipl_05_slod","h4_se_ipl_09_slod","h4_islandx_mansion_vault_lod","h4_se_ipl_03_slod","h4_nw_ipl_08_lod","h4_islandx_barrack_props_slod","h4_islandxtower_veg_slod","h4_sw_ipl_04","h4_islandx_mansion_props","h4_islandxtower_slod","h4_beach_props","h4_islandx_mansion_b_slod","h4_islandx_maindock_props_slod","h4_sw_ipl_07_slod","h4_ne_ipl_07","h4_islandxdock_props_2","h4_ne_ipl_09_lod","h4_islandxcanal_props","h4_beach_slod","h4_sw_ipl_00_slod","h4_sw_ipl_03_lod","h4_islandx_disc_strandedshark","h4_islandx_disc_strandedshark_lod","h4_islandx","h4_islandx_props_lod","h4_mph4_island_strm_0","h4_islandx_sea_mines","h4_mph4_island","h4_boatblockers","h4_mph4_island_long_0","h4_islandx_disc_strandedwhale","h4_islandx_disc_strandedwhale_lod","h4_islandx_props","h4_int_placement_h4_interior_1_dlc_int_02_h4_milo_","h4_int_placement_h4_interior_0_int_sub_h4_milo_","h4_int_placement_h4"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REQUEST_IPL(ipl)
	end
	util.toast("Cayo Island Loaded.")
	return 1
end

function unLoadIsland()
	local iplList = {"h4_mph4_terrain_occ_09","h4_mph4_terrain_occ_06","h4_mph4_terrain_occ_05","h4_mph4_terrain_occ_01","h4_mph4_terrain_occ_00","h4_mph4_terrain_occ_08","h4_mph4_terrain_occ_04","h4_mph4_terrain_occ_07","h4_mph4_terrain_occ_03","h4_mph4_terrain_occ_02","h4_islandx_terrain_04","h4_islandx_terrain_05_slod","h4_islandx_terrain_props_05_d_slod","h4_islandx_terrain_02","h4_islandx_terrain_props_05_a_lod","h4_islandx_terrain_props_05_c_lod","h4_islandx_terrain_01","h4_mph4_terrain_04","h4_mph4_terrain_06","h4_islandx_terrain_04_lod","h4_islandx_terrain_03_lod","h4_islandx_terrain_props_06_a","h4_islandx_terrain_props_06_a_slod","h4_islandx_terrain_props_05_f_lod","h4_islandx_terrain_props_06_b","h4_islandx_terrain_props_05_b_lod","h4_mph4_terrain_lod","h4_islandx_terrain_props_05_e_lod","h4_islandx_terrain_05_lod","h4_mph4_terrain_02","h4_islandx_terrain_props_05_a","h4_mph4_terrain_01_long_0","h4_islandx_terrain_03","h4_islandx_terrain_props_06_b_slod","h4_islandx_terrain_01_slod","h4_islandx_terrain_04_slod","h4_islandx_terrain_props_05_d_lod","h4_islandx_terrain_props_05_f_slod","h4_islandx_terrain_props_05_c","h4_islandx_terrain_02_lod","h4_islandx_terrain_06_slod","h4_islandx_terrain_props_06_c_slod","h4_islandx_terrain_props_06_c","h4_islandx_terrain_01_lod","h4_mph4_terrain_06_strm_0","h4_islandx_terrain_05","h4_islandx_terrain_props_05_e_slod","h4_islandx_terrain_props_06_c_lod","h4_mph4_terrain_03","h4_islandx_terrain_props_05_f","h4_islandx_terrain_06_lod","h4_mph4_terrain_01","h4_islandx_terrain_06","h4_islandx_terrain_props_06_a_lod","h4_islandx_terrain_props_06_b_lod","h4_islandx_terrain_props_05_b","h4_islandx_terrain_02_slod","h4_islandx_terrain_props_05_e","h4_islandx_terrain_props_05_d","h4_mph4_terrain_05","h4_mph4_terrain_02_grass_2","h4_mph4_terrain_01_grass_1","h4_mph4_terrain_05_grass_0","h4_mph4_terrain_01_grass_0","h4_mph4_terrain_02_grass_1","h4_mph4_terrain_02_grass_0","h4_mph4_terrain_02_grass_3","h4_mph4_terrain_04_grass_0","h4_mph4_terrain_06_grass_0","h4_mph4_terrain_04_grass_1","island_distantlights","island_lodlights","h4_yacht_strm_0","h4_yacht","h4_yacht_long_0","h4_islandx_yacht_01_lod","h4_clubposter_palmstraxx","h4_islandx_yacht_02_int","h4_islandx_yacht_02","h4_clubposter_moodymann","h4_islandx_yacht_01","h4_clubposter_keinemusik","h4_islandx_yacht_03","h4_ch2_mansion_final","h4_islandx_yacht_03_int","h4_yacht_critical_0","h4_islandx_yacht_01_int","h4_mph4_island_placement","h4_islandx_mansion_vault","h4_islandx_checkpoint_props","h4_islandairstrip_hangar_props_slod","h4_se_ipl_01_lod","h4_ne_ipl_00_slod","h4_se_ipl_06_slod","h4_ne_ipl_00","h4_se_ipl_02","h4_islandx_barrack_props_lod","h4_se_ipl_09_lod","h4_ne_ipl_05","h4_mph4_island_se_placement","h4_ne_ipl_09","h4_islandx_mansion_props_slod","h4_se_ipl_09","h4_mph4_mansion_b","h4_islandairstrip_hangar_props_lod","h4_islandx_mansion_entrance_fence","h4_nw_ipl_09","h4_nw_ipl_02_lod","h4_ne_ipl_09_slod","h4_sw_ipl_02","h4_islandx_checkpoint","h4_islandxdock_water_hatch","h4_nw_ipl_04_lod","h4_islandx_maindock_props","h4_beach","h4_islandx_mansion_lockup_03_lod","h4_ne_ipl_04_slod","h4_mph4_island_nw_placement","h4_ne_ipl_08_slod","h4_nw_ipl_09_lod","h4_se_ipl_08_lod","h4_islandx_maindock_props_lod","h4_se_ipl_03","h4_sw_ipl_02_slod","h4_nw_ipl_00","h4_islandx_mansion_b_side_fence","h4_ne_ipl_01_lod","h4_se_ipl_06_lod","h4_ne_ipl_03","h4_islandx_maindock","h4_se_ipl_01","h4_sw_ipl_07","h4_islandx_maindock_props_2","h4_islandxtower_veg","h4_mph4_island_sw_placement","h4_se_ipl_01_slod","h4_mph4_wtowers","h4_se_ipl_02_lod","h4_islandx_mansion","h4_nw_ipl_04","h4_mph4_airstrip_interior_0_airstrip_hanger","h4_islandx_mansion_lockup_01","h4_islandx_barrack_props","h4_nw_ipl_07_lod","h4_nw_ipl_00_slod","h4_sw_ipl_08_lod","h4_islandxdock_props_slod","h4_islandx_mansion_lockup_02","h4_islandx_mansion_slod","h4_sw_ipl_07_lod","h4_islandairstrip_doorsclosed_lod","h4_sw_ipl_02_lod","h4_se_ipl_04_slod","h4_islandx_checkpoint_props_lod","h4_se_ipl_04","h4_se_ipl_07","h4_mph4_mansion_b_strm_0","h4_nw_ipl_09_slod","h4_se_ipl_07_lod","h4_islandx_maindock_slod","h4_islandx_mansion_lod","h4_sw_ipl_05_lod","h4_nw_ipl_08","h4_islandairstrip_slod","h4_nw_ipl_07","h4_islandairstrip_propsb_lod","h4_islandx_checkpoint_props_slod","h4_aa_guns_lod","h4_sw_ipl_06","h4_islandx_maindock_props_2_slod","h4_islandx_mansion_office","h4_islandx_maindock_lod","h4_mph4_dock","h4_islandairstrip_propsb","h4_islandx_mansion_lockup_03","h4_nw_ipl_01_lod","h4_se_ipl_05_slod","h4_sw_ipl_01_lod","h4_nw_ipl_05","h4_islandxdock_props_2_lod","h4_ne_ipl_04_lod","h4_ne_ipl_01","h4_beach_party_lod","h4_islandx_mansion_lights","h4_sw_ipl_00_lod","h4_islandx_mansion_guardfence","h4_beach_props_party","h4_ne_ipl_03_lod","h4_islandx_mansion_b","h4_beach_bar_props","h4_ne_ipl_04","h4_sw_ipl_08_slod","h4_islandxtower","h4_se_ipl_00_slod","h4_islandx_barrack_hatch","h4_ne_ipl_06_slod","h4_ne_ipl_03_slod","h4_sw_ipl_09_slod","h4_ne_ipl_02_slod","h4_nw_ipl_04_slod","h4_ne_ipl_05_lod","h4_nw_ipl_08_slod","h4_sw_ipl_05_slod","h4_islandx_mansion_b_lod","h4_ne_ipl_08","h4_islandxdock_props","h4_islandairstrip_doorsopen_lod","h4_se_ipl_05_lod","h4_islandxcanal_props_slod","h4_mansion_gate_closed","h4_se_ipl_02_slod","h4_nw_ipl_02","h4_ne_ipl_08_lod","h4_sw_ipl_08","h4_islandairstrip","h4_islandairstrip_props_lod","h4_se_ipl_05","h4_ne_ipl_02_lod","h4_islandx_maindock_props_2_lod","h4_sw_ipl_03_slod","h4_ne_ipl_01_slod","h4_beach_props_slod","h4_underwater_gate_closed","h4_ne_ipl_00_lod","h4_islandairstrip_doorsopen","h4_sw_ipl_01_slod","h4_se_ipl_00","h4_se_ipl_06","h4_islandx_mansion_lockup_02_lod","h4_islandxtower_veg_lod","h4_sw_ipl_00","h4_se_ipl_04_lod","h4_nw_ipl_07_slod","h4_islandx_mansion_props_lod","h4_islandairstrip_hangar_props","h4_nw_ipl_06_lod","h4_islandxtower_lod","h4_islandxdock_lod","h4_islandxdock_props_lod","h4_beach_party","h4_nw_ipl_06_slod","h4_islandairstrip_doorsclosed","h4_nw_ipl_00_lod","h4_ne_ipl_02","h4_islandxdock_slod","h4_se_ipl_07_slod","h4_islandxdock","h4_islandxdock_props_2_slod","h4_islandairstrip_props","h4_sw_ipl_09","h4_ne_ipl_06","h4_se_ipl_03_lod","h4_nw_ipl_03","h4_islandx_mansion_lockup_01_lod","h4_beach_lod","h4_ne_ipl_07_lod","h4_nw_ipl_01","h4_mph4_island_lod","h4_islandx_mansion_office_lod","h4_islandairstrip_lod","h4_beach_props_lod","h4_nw_ipl_05_slod","h4_islandx_checkpoint_lod","h4_nw_ipl_05_lod","h4_nw_ipl_03_slod","h4_nw_ipl_03_lod","h4_sw_ipl_05","h4_mph4_mansion","h4_sw_ipl_03","h4_se_ipl_08_slod","h4_mph4_island_ne_placement","h4_aa_guns","h4_islandairstrip_propsb_slod","h4_sw_ipl_01","h4_mansion_remains_cage","h4_nw_ipl_01_slod","h4_ne_ipl_06_lod","h4_se_ipl_08","h4_sw_ipl_04_slod","h4_sw_ipl_04_lod","h4_mph4_beach","h4_sw_ipl_06_lod","h4_sw_ipl_06_slod","h4_se_ipl_00_lod","h4_ne_ipl_07_slod","h4_mph4_mansion_strm_0","h4_nw_ipl_02_slod","h4_mph4_airstrip","h4_island_padlock_props","h4_islandairstrip_props_slod","h4_nw_ipl_06","h4_sw_ipl_09_lod","h4_islandxcanal_props_lod","h4_ne_ipl_05_slod","h4_se_ipl_09_slod","h4_islandx_mansion_vault_lod","h4_se_ipl_03_slod","h4_nw_ipl_08_lod","h4_islandx_barrack_props_slod","h4_islandxtower_veg_slod","h4_sw_ipl_04","h4_islandx_mansion_props","h4_islandxtower_slod","h4_beach_props","h4_islandx_mansion_b_slod","h4_islandx_maindock_props_slod","h4_sw_ipl_07_slod","h4_ne_ipl_07","h4_islandxdock_props_2","h4_ne_ipl_09_lod","h4_islandxcanal_props","h4_beach_slod","h4_sw_ipl_00_slod","h4_sw_ipl_03_lod","h4_islandx_disc_strandedshark","h4_islandx_disc_strandedshark_lod","h4_islandx","h4_islandx_props_lod","h4_mph4_island_strm_0","h4_islandx_sea_mines","h4_mph4_island","h4_boatblockers","h4_mph4_island_long_0","h4_islandx_disc_strandedwhale","h4_islandx_disc_strandedwhale_lod","h4_islandx_props","h4_int_placement_h4_interior_1_dlc_int_02_h4_milo_","h4_int_placement_h4_interior_0_int_sub_h4_milo_","h4_int_placement_h4"}
	for i, ipl in ipairs(iplList) do
		STREAMING.REMOVE_IPL(ipl)
	end
	util.toast("Cayo Island Unloaded.")
	return 1
end

function tpIslandAirport()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 4445.811, -4510.292, 4.184)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 4445.811, -4510.292, 4.184)
	end
	return 1
end

function tpIslandParty()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 4874.373, -4925.464, 3.166)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 4874.373, -4925.464, 3.166)
	end
	return 1
end

function tpIslandMain()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 4993.385, -5719.725, 19.880)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 4993.385, -5719.725, 19.880)
	end
	return 1
end

function tpIslandHarbour()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 4992.504, -5174.667, 2.503)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 4992.504, -5174.667, 2.503)
	end
	return 1
end

function tpIslandHarbour2()
	local vehicle
	local player = PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID())

	if PED.IS_PED_IN_ANY_VEHICLE(player) then
		vehicle = PED.GET_VEHICLE_PED_IS_USING(player)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehicle, 5071.473, -4629.821, 2.374)
	else
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(player, 5071.473, -4629.821, 2.374)
	end
	return 1
end


function main()

	top = menu.my_root()
	menu.action(top, "Teleport back inside map", {"tphome"}, "Stuck outside the map? Click here", teleportHome, teleportHome)
	cargoship = menu.list(top, "Cargo Ship", {}, "Cargoship at the docks")
	menu.action(cargoship, "Default", {}, "", defaultCargoship)
	menu.action(cargoship, "Sunken", {}, "", sunkenCargoship)
	menu.action(cargoship, "Teleport", {}, "", tpCargoship)
	morgue = menu.list(top, "Morgue", {}, "Morgue used in Dead Man Walking SP Mission")
	menu.action(morgue, "Load", {}, "", loadMorgue)
	menu.action(morgue, "Teleport", {}, "", tpMorgue)
	menu.action(morgue, "UnLoad", {}, "", unLoadMorgue)
	casino = menu.list(top, "Casino", {}, "Multiplayer Casino")
	menu.action(casino, "Load Main Casino", {}, "", LoadCasino)
	menu.action(casino, "Teleport inside Casino", {}, "", tpCasino)
	casinoPenthouse = menu.list(casino, "Penthouse", {}, casino)
	menu.action(casinoPenthouse, "Load", {}, "", LoadPenthouse)
	menu.action(casinoPenthouse, "Unload", {}, "", unLoadPenthouse)
	menu.action(casinoPenthouse, "Teleport", {}, "", tpPenthouse)
	casinoGarage = menu.list(casino, "Garage", {}, casino)
	menu.action(casinoGarage, "Load", {}, "", LoadCasinoGarage)
	menu.action(casinoGarage, "Unload", {}, "", unLoadCasinoGarage)
	menu.action(casinoGarage, "Teleport", {}, "", tpCasinoGarage)
	casinoCarPark = menu.list(casino, "CarPark", {}, casino)
	menu.action(casinoCarPark, "Load", {}, "", LoadCasinoCarPark)
	menu.action(casinoCarPark, "Unload", {}, "", unLoadCasinoCarPark)
	menu.action(casinoCarPark, "Teleport", {}, "", tpCasinoCarPark)
	stilt = menu.list(top, "Stilt House", {}, "Stilt house used in Marriage Counseling SP Mission")
	menu.action(stilt, "Rebuild", {}, "", rebuildStilt)
	menu.action(stilt, "Broken", {}, "", brokenStilt)
	menu.action(stilt, "Teleport", {}, "", tpStilt)
	stadium = menu.list(top, "Stadium", {}, "Stadium used in Fame or Shame SP Mission")
	menu.action(stadium, "Load", {}, "", loadStadium)
	menu.action(stadium, "Teleport", {}, "", tpStadium)
	menu.action(stadium, "UnLoad", {}, "", unLoadStadium)
	renda = menu.list(top, "Max Renda Shop", {}, "Shop used in The Jewel Store Job SP Mission")
	menu.action(renda, "Load", {}, "", loadRenda)
	menu.action(renda, "Teleport", {}, "", tpRenda)
	menu.action(renda, "UnLoad", {}, "", unLoadRenda)
	jewel = menu.list(top, "Jewel Store",{}, "Jewel Store used in The Jewl Store Job SP Mission")
	menu.action(jewel, "Load", {}, "", loadJewel)
	menu.action(jewel, "Teleport", {}, "", tpJewel)
	menu.action(jewel, "UnLoad", {}, "", unLoadJewel)
	fib = menu.list(top, "FIB Lobby",{}, "FIB Building used in The Bureau Raid SP Mission")
	menu.action(fib, "Load", {}, "", loadFIB)
	menu.action(fib, "Teleport", {}, "", tpFIB)
	menu.action(fib, "UnLoad", {}, "", unLoadFIB)
	trailer = menu.list(top, "Trevors Trailer",{}, "Trevors SP Trailer")
	menu.action(trailer, "Clean", {}, "", cleanTrailer)
	menu.action(trailer, "Dirty", {}, "", dirtyTrailer)
	menu.action(trailer, "Teleport", {}, "", tpTrailer)
	yacht = menu.list(top, "Dignity Yacht",{}, "Yacht used for multiple SP & MP Missions")
	menu.action(yacht, "Heist Yacht (MP Only)", {}, "", heistYacht)
	menu.action(yacht, "Party Yacht", {}, "", partyYacht)
	menu.action(yacht, "Teleport", {}, "", tpYacht)
	menu.action(yacht, "UnLoad", {}, "", unLoadYacht)
	train = menu.list(top, "Train Bridge Crash",{}, "Train crash used in Derailed SP Mission")
	menu.action(train, "Load", {}, "", loadTrain)
	menu.action(train, "Teleport", {}, "", tpTrain)
	menu.action(train, "UnLoad", {}, "", unLoadTrain)
	farm = menu.list(top, "ONeils Farm",{}, "Farm used in O'Neil Borthers SP Mission")
	menu.action(farm, "On Fire", {}, "", burningFarm)
	menu.action(farm, "Burned", {}, "", burnedFarm)
	menu.action(farm, "Normal", {}, "", normalFarm)
	menu.action(farm, "Teleport", {}, "", tpFarm)
	chicken = menu.list(top, "Cluckin Bell Factory",{}, "Factory used in The Paleto Score SP Mission")
	menu.action(chicken, "Load", {}, "", loadChicken)
	menu.action(chicken, "Teleport", {}, "", tpChicken)
	menu.action(chicken, "UnLoad", {}, "", unLoadChicken)
	cargoplane = menu.list(top, "Underwater Cargo Plane",{}, "Cargoplane crash used in Minor Turbulence SP Mission")
	menu.action(cargoplane, "Load", {}, "", loadCargoPlane)
	menu.action(cargoplane, "Teleport", {}, "", tpCargoPlane)
	menu.action(cargoplane, "UnLoad", {}, "", unLoadCargoPlane)
	yankton = menu.list(top, "North Yankton", {}, "North Yankton Used in the SP Prologue")
	menu.action(yankton, "Load", {}, "", loadYankton)
	menu.action(yankton, "Teleport", {}, "", tpYankton)
	menu.action(yankton, "UnLoad", {}, "", unLoadYankton)
	ufo = menu.list(top, "Chilliad UFO",{}, "I can't remember what this is used for, but its here :)")
	menu.action(ufo, "Load", {}, "", loadUFO)
	menu.action(ufo, "Teleport", {}, "", tpUFO)
	menu.action(ufo, "UnLoad", {}, "", unLoadUFO)
	red = menu.list(top, "Red Carpet",{}, "Movie area used in Meltdown SP Mission")
	menu.action(red, "Load", {}, "", loadRed)
	menu.action(red, "Teleport", {}, "", tpRed)
	menu.action(red, "UnLoad", {}, "", unLoadRed)
	face = menu.list(top, "LifeInvader",{}, "LifeInvader used in Friend Request SP Mission")
	menu.action(face, "Load", {}, "", loadFace)
	menu.action(face, "Teleport", {}, "", tpFace)
	menu.action(face, "UnLoad", {}, "", unLoadFace)
	island = menu.list(top, "Cayo Island", {}, "Cayo Perico Island from the new heist")
	menu.action(island, "Load (MP Only)", {}, "", loadIsland)
	menu.action(island, "UnLoad", {}, "", unLoadIsland)
	menu.action(island, "Teleport to Airport", {}, "", tpIslandAirport)
	menu.action(island, "Teleport to Party Beach", {}, "", tpIslandParty)
	menu.action(island, "Teleport to Main Complex", {}, "", tpIslandMain)
	menu.action(island, "Teleport to Harbour", {}, "", tpIslandHarbour)
	menu.action(island, "Teleport to Harbour2", {}, "", tpIslandHarbour2)
	while true do
		util.yield()
	end
end

main()