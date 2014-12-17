fnc_remote_message = {

	private["_type","_message"];

	_type 		= _this select 0;
	_message 	= _this select 1;

	call {
		if(_type == "radio")		exitWith { 
			if(player hasWeapon "ItemRadio") then { 
				if(player getVariable["radiostate",true]) then {
					systemChat _message;
					[objNull,player,rSAY,"Radio_Message_Sound",30] call RE;
				};
			}; 
		};
		if(_type == "private")		exitWith { if(getPlayerUID player == (_message select 0)) then { systemChat (_message select 1); }; };
		if(_type == "global")		exitWith { systemChat _message; };
		if(_type == "dynamic_text")	exitWith { 
			[
				format["<t size='0.40' color='#FFFFFF' align='center'>%1</t><br /><t size='0.70' color='#d5a040' align='center'>%2</t>",(_message select 0),(_message select 1)],
				0,
				0,
				10,
				0.5
			] spawn BIS_fnc_dynamicText; 
		};
	};
};

/* WIP

fnc_remote_marker = {

	private["_req","_location","_shape","_color","_size","_alpha","_timeout","_marker","_name"];

	_req = _this select 0;

	if(player hasWeapon "_req") then {

		_location 	= _this select 1;
		_shape 		= _this select 2;
		_color 		= _this select 3;
		_size		= _this select 4;
		_alpha 		= _this select 5;
		_timeout 	= _this select 6;
		_name 		= _this select 7;

		_marker = createMarkerLocal[_name,_location];
		_marker setMarkerShapeLocal _shape;
		_marker setMarkerColorLocal _color;
		_marker setMarkerAlphaLocal _alpha;
		_marker setMarkerSizeLocal[(_size),(_size)];

		[_timeout,_marker] spawn {
			sleep (_this select 0);
			deleteMarkerLocal (_this select 1);
		};

	};

};

*/

"RemoteMessage" addPublicVariableEventHandler { (_this select 1) spawn fnc_remote_message; };
//"RemoteMarker" addPublicVariableEventHandler { (_this select 1) spawn fnc_custom_marker; };