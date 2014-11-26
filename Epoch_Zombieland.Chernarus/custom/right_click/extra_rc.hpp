class ExtraRc {
	class ItemToolbox {
		class deploybike {
			text = "Deploy Bike";
			script = "execVM 'custom\deploy\deploy_bike.sqf'";
		};
	};
	class ItemRadio {
		class switchOnOff {
			text = "Switch ON/OFF";
			script = "execVM 'custom\remote\switch_on_off.sqf'";
		};
	};
	class ItemBriefcase_Base {
		class OpenSurpriseBrief {
			text = "Open EpochPack Premium";
			script = "['Premium'] execVM 'custom\mbc\open_brief.sqf'";
		};
	};

	class ItemSilvercase_Base {
		class OpenSurpriseBrief {
			text = "Open EpochPack Silver";
			script = "['Silver'] execVM 'custom\mbc\open_brief.sqf'";
		};
	};
};