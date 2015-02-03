private["_dialog"];

createDialog 'RscDisplayPassword';
ctrlSetText[1001,'Give money'];
ctrlSetText[101,''];
ctrlshow [1002,false];
buttonSetaction[1,'[(ctrlText 101)] spawn GivePlayerAmount;'];

waitUntil {!dialog};