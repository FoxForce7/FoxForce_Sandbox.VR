//=ATM= Airdrop by Pokertour // custom

private ["_position","_cut","_dialog","_s_alt","_s_alt_text","_sound","_sound2","_soundPath"];

waitUntil { !isNull player };
call compile preprocessFileLineNumbers "scr\ATM_airdrop\functions.sqf";

_position = getPos player;
_z = _position select 2;
Altitude = 500;

//hint Localize "STR_ATM_hinton";
openMap true;

createDialog "ATM_AD_ALTITUDE_SELECT";
disableSerialization;
_dialog = findDisplay 2900;
_s_alt = _dialog displayCtrl 2901;
_s_alt_text = _dialog displayCtrl 2902;
_s_alt_text ctrlSetText format["%1", Altitude];
_s_alt sliderSetRange [200, 2000];
_s_alt slidersetSpeed [100, 50, 50];
_s_alt sliderSetPosition Altitude;

ATM_Jump_mapclick = false;
onMapSingleClick "ATM_Jump_clickpos = _pos; ATM_Jump_mapclick = true; onMapSingleClick ''; true;";
waitUntil {ATM_Jump_mapclick or !(visiblemap)};

if (!visibleMap) exitwith
{
	//systemChat "HALO Drop canceled ....";
	breakOut "main";
};


player setVariable ["FF7_NextAvailHalo", (time + 200)];

_pos = ATM_Jump_clickpos;

ATM_Jump_mapclick = if(true) then
{
	call compile format
	[
		'mkr_halo = createmarker ["mkr_halo", ATM_Jump_Clickpos];
		"mkr_halo" setMarkerTypeLocal "hd_dot";
		"mkr_halo" setMarkerColorLocal "ColorGreen";
		"mkr_halo" setMarkerTextLocal "Jump";'
	];
};

_target = player;

/*

GreenSmokeOn = _target addAction["<t color='#30fd07'>Green Smoke On</t>", "src\ATM_airdrop\atm_chem_on.sqf",["SmokeShellGreen"],6,false,false,"","_target == ( player)"];

*/

_loadout = [_target] call Getloadout;

_posJump = getMarkerPos "mkr_halo";
_x = _posJump select 0;
_y = _posJump select 1;
_z = _posJump select 2;
_target setPos [_x,_y,_z + Altitude];

sleep 0.25;
openMap false;
deleteMarker "mkr_halo";

0 = [_target] call Frontpack;

removeBackpack _target;

_target addBackpack "B_Parachute";


//Cut_Rope = (FindDisplay 46) displayAddEventHandler ["keydown","_this call dokeyDown"];

_height = getPos _target select 2;

while {(getPos _target select 2) > 10} do
{
	if ((isTouchingGround _target) and (player == vehicle player)) then
	{}
	else
	{
		sleep 5;
	};

	if (!alive _target) then
	{
		_target setPos [getPos _target select 0, getPos _target select 1, 0];
		0 = [_target, _loadout] call Setloadout;
	};
};

deletevehicle (_target getvariable "frontpack");
_target setvariable ["frontpack", nil, true];

//(findDisplay 46) displayRemoveEventHandler ["KeyDown", Cut_Rope];

if ((count _loadout) > 0) then
{
	0 = [_target,_loadout] call Setloadout;
};

sleep 1;

if ((backpack _target) == "ACE_ReserveParachute") then
{
	removeBackPack _target;
};
/*
sleep 3;
_target removeaction GreenSmokeOn;
deletevehicle (_target getvariable "lgtarray"); _target setvariable ["lgtarray",nil,true];
*/
if (true) exitWith {};
