/*
 * Ambient helicopters by Skullfox
 * http://www.armaholic.com/page.php?id=29210
 * https://bitbucket.org/Skullfox/ambient-helicopters
 */
if (!isServer) exitWith {};
zp_heliInit = {
  
  	//extend this array with new helis
    _heliArray = ["C_Heli_Light_01_civil_F"];
    //extend this array with A1 & A2 helipads 
	_heliPadClasses = ["Land_HelipadSquare_F","Land_HelipadRescue_F","Land_HelipadCivil_F"];
	
    _y = 0;
    
	_heliPads= nearestObjects[(getmarkerpos "respawn_west"),_heliPadClasses,500000];
	
	/*
    {    

		_m = createMarker [str position _x, position _x];
        _m setMarkerType "mil_flag";
        _m setMarkerText format["Helipad - %1",_y];
        _y = _y + 1;
        
	} foreach _heliPads;
	   */
	_c = count  _helipads;
	_numbers = floor( _c / 2  );
	
	_linkedHelipads = [];
	
	for [{_i=0}, {_i< _numbers}, {_i=_i+1}] do
	{
	    
	    _index = _i;
	    _helipadStart = _helipads select _index;
	    _indexEnd = _index + _numbers;
	    
	   _helipadEnd = _helipads select _indexEnd;
	    
	    _linkedHelipads pushBack [_helipadStart,_helipadEnd];
	      
	};
	
	_y = 0;
    
    {    
    	_start = _x select 0;
        _end = _x select 1;
        _class = [_heliArray] call zp_selectHeliCiv; 
               
        _veh = _class createVehicle position _start;
        
        _veh setVariable ["zp_heliVars",[_start,_end,_class,_y],true];
        /*
	    [_veh]spawn{ 
        
            _veh = _this select 0;     
	        while{true}do{
	            sleep 5;
	            if(damage _veh > 0.3)exitWith {
	                [_veh] call zp_resetHeli;
	            };
	        };
	    };
        */
        createVehicleCrew _veh;
        /*
        if(zp_heliDev)then{

    		_m = createMarker [str position _start, position _start];
	        _m setMarkerType "mil_flag";
	        _m setMarkerText format["Helipad - %1 start",_y];
        
        	_r = str floor(((position _veh) select 0));
			_v = createMarker [_r, position _veh];
            
            _veh setVariable ["zp_heliDevMarker",[_r],true];
            
	        _v setMarkerType "n_air";
	        _v setMarkerColor "ColorGreen";
	        _v setMarkerText format["Heli - %1 start",_y];
        	
			[_v,_veh] call zp_addMarkerToHeli;

            _m = createMarker [str position _end, position _end];
	        _m setMarkerType "mil_flag";
	        _m setMarkerText format["Helipad - %1 end",_y];
            
        };
       */
        _y = _y + 1;
                
        [_veh,_start,_end,_y] call zp_startHeliTour;
        
	} foreach _linkedHelipads;  
    
};
/*
 zp_addMarkerToHeli = {
   
	_v = _this select 0;
	_veh = _this select 1;
    
    [_v,_veh] spawn {

	    _v = _this select 0;
	    _veh = _this select 1;
	    
        while{alive _veh} do {
			_v setMarkerPos getpos _veh;
      		 sleep 10;
        };
	    
	};
         
};
*/
zp_startHeliTour = {
    
    _vehicle = _this select 0;
    _startPad = _this select 1;
    _endPad = _this select 2;
    _id = _this select 3;
    
    sleep random(30);
	
	clearWeaponCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearItemCargoGlobal _vehicle;
	_vehicle addItemCargoGlobal ["ACE_epinephrine", 10];
	_vehicle addItemCargoGlobal ["ACE_EarPlugs", 10];
	_vehicle addItemCargoGlobal ["ACE_fieldDressing", 30];
	_vehicle addItemCargoGlobal ["ACE_morphine", 30];
	_vehicle addItemCargoGlobal ["ACE_bloodIV", 10];
	_vehicle addItemCargoGlobal ["ACE_NVG_Wide", 2];
	_vehicle addItemCargoGlobal ["APERSTripMine_Wire_Mag", 4];
	_vehicle addItemCargoGlobal ["ACE_IR_Strobe_Item", 10];
	_vehicle addItemCargoGlobal ["ACE_CableTie", 10];
	_vehicle addItemCargoGlobal ["ACE_Clacker", 1];
	_vehicle addItemCargoGlobal ["ACE_Flashlight_XL50", 2];
	_vehicle addItemCargoGlobal ["DemoCharge_Remote_Mag", 4];
	_vehicle addItemCargoGlobal ["ClaymoreDirectionalMine_Remote_Mag", 4];
	_vehicle addItemCargoGlobal ["ItemGPS", 2];
	_vehicle addItemCargoGlobal ["ACE_HandFlare_Green", 4];
	_vehicle addItemCargoGlobal ["SmokeShell", 10];
	_vehicle addItemCargoGlobal ["SmokeShellBlue", 2];
	_vehicle addItemCargoGlobal ["SmokeShellGreen", 2];
	_vehicle addItemCargoGlobal ["bipod_01_F_snd", 2];
	
    _vehicle domove getPos _endPad;
    _vehicle flyinheight 120;
	_vehicle disableAi "TARGET"; 
	_vehicle disableAi "AUTOTARGET"; 
	_vehicle enableAttack false; 
	_vehicle setCombatMode "BLUE"; 
	_vehicle setBehaviour "CARELESS";  
    
     [_endPad,_vehicle,_id,_startPad] spawn {

	    _endPad = _this select 0;
	    _vehicle = _this select 1;
		_id = _this select 2;
		_c = true;
		_startPad = _this select 3;
		_d = driver _vehicle; 
          
        while{alive _vehicle AND _c} do {
            
			sleep 5;
            
			_meters = _vehicle distance _endpad;
                             
            if(_meters < 200)then{

				_c = false;
				dostop _vehicle;
                                
				_vehicle land "LAND";
	                
	            [_vehicle,_startPad,_endPad,_id] call zp_launchTime;
                
            };
            
        };
	    
	};
      
};

zp_launchTime = {
    
    _vehicle = _this select 0;
    _startpad = _this select 1;
    _endPad = _this select 2;
    _id = _this select 3;
    
    _timeoutBase =  240;
    
    _timeOutAdditional = floor (random 300);
    
    _timeout = _timeoutBase + _timeOutAdditional;
    
    _vehicle setfuel 1;
    
    sleep _timeout;
    
    if(_vehicle distance _endPad < 50 )then{
            [_vehicle,_endPad,_startpad,_id] call zp_startHeliTour;           
    }else{                     
			[_vehicle,_startPad,_endPad,_id] call zp_startHeliTour;
    };
    
};

zp_selectHeliCiv = {
    
    _heliArray = _this select 0;
    
    _c = count _heliArray; 
    _i = floor( random _c );
    _class = _heliArray select _i;
    
    _class
    
};

zp_resetHeli = {
    
    _veh = _this select 0;
	_vehOld = _veh;
    
    _vars = _veh getVariable "zp_heliVars";
    
    _start = _vars select 0;
    _end = _vars select 1;
    _class = _vars select 2;
    _id = _vars select 3;
    /*
    if(zp_heliDev)then{
        
        _varsmarker = _vehOld getVariable "zp_heliDevMarker"; 
        _m = _varsmarker select 0;
       	_m setMarkerColor "ColorRed";
        _m setMarkerType "hd_destroy";
        
    };
    */
	{ deleteVehicle _x } forEach (crew _veh); deleteVehicle _veh;
    
    _veh = _class createVehicle position _start;
    createVehicleCrew _veh;
    
    _veh setVariable ["zp_heliVars",[_start,_end,_class,_id],true];
    /*
    [_veh]spawn{     
     	_veh = _this select 0;    
        while{true}do{
            sleep 60;
            if(damage _veh > 0.3)exitWith {
                [_veh] call zp_resetHeli;
            };
        };
    };
    */
    sleep 5;
	/*
    if(zp_heliDev)then{
        
        _r = str floor(((position _veh) select 0));
		_v = createMarker [_r, position _veh];
        _v setMarkerColor "ColorGreen";
        _v setMarkerText format["Heli - %1 start",_id];
    	[_v,_veh] call zp_addMarkerToHeli;
    	_veh setVariable ["zp_heliDevMarker",[_r],true];
   
    };
    */
    [_veh,_start,_end,_id] call zp_startHeliTour;
    
};
[] call zp_heliInit;