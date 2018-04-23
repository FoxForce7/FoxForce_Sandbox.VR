enableSaving [false, false];



["Fox", "Nuke", { [[[(_this select 0),400,true,true,true,true], "scr\nuke\nuke.sqf"],"BIS_fnc_execVM",true,true] spawn BIS_fnc_MP;  }] call Ares_fnc_RegisterCustomModule;

["Fox", "Ambient Civs", { [[[], "scr\Civilians\Init.sqf"],"BIS_fnc_execVM",false,false] spawn BIS_fnc_MP;  }] call Ares_fnc_RegisterCustomModule;
["Fox", "Ambient Helis", { [[[], "scr\ambientHeli.sqf"],"BIS_fnc_execVM",false,false] spawn BIS_fnc_MP;  }] call Ares_fnc_RegisterCustomModule;
["Fox", "Ambient Traffic", { [[[], "scr\Traffic\Init.sqf"],"BIS_fnc_execVM",false,false] spawn BIS_fnc_MP;  }] call Ares_fnc_RegisterCustomModule;