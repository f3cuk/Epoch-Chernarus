private["_player","_name","_objects","_key","_i","_data","_objectUID","_objectID","_option","_targetObj"];

_player 	= _this select 0;
_option 	= _this select 1;
_targetObj 	= _this select 2;
_i 			= 0;

if(_option == 1) then {
	_objects = nearestObjects[_targetObj,DZE_maintainClasses,DZE_maintainRange];
	{
		if(damage _x >= DZE_DamageBeforeMaint) then {
			_objectID = _x getVariable["ObjectID","0"];
			if(_objectID == "0") then {
				_objectUID = _x getVariable["ObjectUID","0"];
				if(_objectUID != "0") then {
					_key = format["CHILD:397:%1:",_objectUID];
					_data = "HiveExt" callExtension _key;
					_i = _i + 1;
				};
			} else {
				_key = format["CHILD:396:%1:",_objectID];
				_data = "HiveExt" callExtension _key;
				_i = _i + 1;
			};
		};
	} count _objects;
	_name = if(alive _player) then { name _player; } else { "Dead Player"; };
	diag_log format["MAINTAIN AREA BY %1 - %2 Objects at %3",_name,_i,([_player] call FNC_GetPos)];
};

if(_option == 2) then {
	if(damage _targetObj >= DZE_DamageBeforeMaint) then {
		_objectID = _targetObj getVariable["ObjectID","0"];
		if(_objectID == "0") then {
			_objectUID = _targetObj getVariable["ObjectUID","0"];
			if(_objectUID != "0") then {
				_key = format["CHILD:397:%1:",_objectUID];
				_data = "HiveExt" callExtension _key;
			};
		} else {
			_key = format["CHILD:396:%1:",_objectID];
			_data = "HiveExt" callExtension _key;

		};
	};
};