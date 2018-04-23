private ["_nextAvail"];

_nextAvail = player getVariable ["FF7_NextAvailHalo", nil];

if (isNil "_nextAvail") then
{
	player setVariable ["FF7_NextAvailHalo", 0];
	_null = [] execVM "scr\ATM_airdrop\atm_airdrop.sqf";
}
else
{
	if (time > _nextAvail) then
	{
		_null = [] execVM "scr\ATM_airdrop\atm_airdrop.sqf";
	}
	else
	{
		_time = (ceil((_nextAvail - time)/60))+1;
		_targetStartText = format ["<t align='center' color='#66b3ff'>Next Airlift in <t color='#e6e600'> %1 <t color='#66b3ff'> mikes",  _time];
		hint parseText format["%1", _targetStartText];
	};
};









