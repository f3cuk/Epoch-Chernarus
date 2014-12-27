waitUntil {!isNil "dayz_animalCheck"};

private["_messages","_timeout"];

_messages = [
	[format["Hello %1, welcome to",(name player)],"ZeroDays Epoch Chernarus"],
	["Admins","CHeeR, Brick and f3cuk"],
	["Teamspeak","ts.dayzepoch.nl"],
	["Website","dayzepoch.nl"]
];

_timeout = 7;
 
{

	private["_title","_content","_titleText"];

	sleep 2;

	_title 		= _x select 0;
	_content 	= _x select 1;
	_titleText 	= format["<t size='0.40' color='#FFFFFF' align='right'>%1</t><br /><t size='0.70' color='#d5a040' align='right'>%2</t>",_title,_content];

	[
		_titleText,
		[safezoneX + safezoneW - 0.8,0.50],
		[safezoneY + safezoneH - 0.8,0.7],
		(_timeout * .9),
		0.5
	] spawn BIS_fnc_dynamicText;
	sleep _timeout;
} count _messages;