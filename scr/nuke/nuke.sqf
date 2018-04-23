// nul = [nuke_obj,radius,damage_buildings_units,weather_effect,radiation,fallout] spawn compile preprocessFile "scr\nuke\nuke.sqf";

obj_nuke = "Land_HelipadEmpty_F" createvehicle (_this select 0);
radius = _this select 1;
damage_buildings_units = _this select 2;
weather_effect = _this select 3;
radiation = _this select 4;
fallout = _this select 5;


	nul = [obj_nuke] execvm "scr\nuke\falling_nuke.sqf";
	nul = [] execvm "scr\nuke\fog_nuke.sqf";
	nul = [obj_nuke,radius] execvm "scr\nuke\ignite_nuke.sqf";
	if (weather_effect) then {nul = [] execvm "scr\nuke\weather_nuke.sqf";};
	if (damage_buildings_units) then {nul = [obj_nuke,radius] execvm "scr\nuke\damage_nuke.sqf";};
	if (radiation) then {nul = [obj_nuke,radius] execvm "scr\nuke\rad_nuke.sqf";};
	if (fallout) then {nul = [] execvm "scr\nuke\ash_nuke.sqf";};
