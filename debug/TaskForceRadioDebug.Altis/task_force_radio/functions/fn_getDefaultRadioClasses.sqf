/*
 	Name: TFAR_fnc_getDefaultRadioClasses
 	
 	Author(s):
		NKey

 	Description:
		Return array of default radio classes for player. 
	
	Parameters:
		Nothing
 	
 	Returns:
		ARRAY - [defaultLR, defaultPersonal, defaultRifleman]
 	
 	Example:
		_classes = call TFAR_fnc_getDefaultRadioClasses;
*/
private ["_personalRadio", "_riflemanRadio", "_lrRadio"];

switch (player call BIS_fnc_objectSide) do {
	case west: {_personalRadio = TF_defaultWestPersonalRadio; _riflemanRadio = TF_defaultWestRiflemanRadio; _lrRadio = TF_defaultWestBackpack;};
	case east: {_personalRadio = TF_defaultEastPersonalRadio; _riflemanRadio = TF_defaultEastRiflemanRadio;_lrRadio = TF_defaultEastBackpack;};
	default {_personalRadio = TF_defaultGuerPersonalRadio; _riflemanRadio = TF_defaultGuerRiflemanRadio;_lrRadio = TF_defaultGuerBackpack;};
};

TFAR_tryResolveFactionClass = 
{
	private ["_prefix", "_faction", "_result", "_default"];
	_prefix = _this select 0;
	_default = _this select 1;
	_faction = str(faction player);
	_result = missionNamespace getVariable (_faction + "_" + _prefix + "_tf_faction_radio");
	if (isNil "_result") then {		
		if (isText (configFile >> "CfgVehicles" >> (typeof player) >> (_prefix + "_tf_faction_radio_api"))) then {
			 _result = getText (configFile >> "CfgVehicles" >> (typeof player) >> (_prefix + "_tf_faction_radio_api"));
		} else {
			if (isText (configFile >> "CfgVehicles" >> (typeof player) >> (_prefix + "_tf_faction_radio"))) then {
				_result = getText (configFile >> "CfgVehicles" >> (typeof player) >> (_prefix + "_tf_faction_radio"));
			} else {
				_result = _default;
			};
		};		
	};
	_result
};

[["backpack", _lrRadio] call TFAR_tryResolveFactionClass , ["personal", _personalRadio] call TFAR_tryResolveFactionClass , ["rifleman", _riflemanRadio] call TFAR_tryResolveFactionClass];