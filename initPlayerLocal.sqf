if (!hasInterface) exitWith {};
waitUntil {!isNull player};
_player	= player;

["Preload"] call BIS_fnc_arsenal;

call compile preprocessFileLineNumbers "\task_force_radio\functions\common.sqf";
["TF_no_auto_long_range_radio", true, true, "server"] call CBA_settings_fnc_set;
["TF_give_personal_radio_to_regular_soldier", true, true, "server"] call CBA_settings_fnc_set;
["TF_give_microdagr_to_soldier", false, true, "server"] call CBA_settings_fnc_set;
["TF_same_sw_frequencies_for_side", true, true, "server"] call CBA_settings_fnc_set;
["TF_same_lr_frequencies_for_side", true, true, "server"] call CBA_settings_fnc_set;
TF_give_microdagr_to_soldier 				= false;
tf_give_personal_radio_to_regular_soldier   = true;
tf_no_auto_long_range_radio				    = true;
tf_radio_channel_name					    = "TaskForceRadio - Sandbox";
tf_defaultWestPersonalRadio 				= "tf_anprc152";
tf_defaultWestRiflemanRadio 				= "tf_anprc152";	
tf_same_sw_frequencies_for_side 			= true;	
tf_same_lr_frequencies_for_side 			= true;		
_settingsSwWest = [false] call TFAR_fnc_generateSwSettings;
_settingsSwWest set [2, ["100","200","300","400","500","50","75","150"]];							 
tf_freq_west = _settingsSwWest;
_settingsLrWest = [false] call TFAR_fnc_generateLrSettings;
_settingsLrWest set [2, ["50","75","30","40","50","60","70","80"]];
tf_freq_west_lr = _settingsLrWest;	

publicVariable "tf_freq_west_lr";
publicVariable "tf_freq_west";
publicVariable "tf_same_lr_frequencies_for_side";	
publicVariable "tf_same_sw_frequencies_for_side";
publicVariable "tf_defaultWestRiflemanRadio";
publicVariable "tf_defaultWestPersonalRadio";
publicVariable "tf_radio_channel_name";
publicVariable "tf_no_auto_long_range_radio";
publicVariable "tf_give_personal_radio_to_regular_soldier";
publicVariable "TF_give_microdagr_to_soldier";