-- toggleHeadtracking
--
-- Version 1.0
-- Autor CptCray
-- https://github.com/JanCraymer/FS22_toggleHeadtracking
-- 
-- Change log:
-- 15.12.2018 / CptCray / created for FS19
-- 02.01.2022 / CptCray / update for FS22


toggleHeadtracking = {};

addModEventListener(toggleHeadtracking);

function toggleHeadtracking:loadMap(name)
	toggleHeadtracking.events = {};
	toggleHeadtracking.isHeadTrackingEnabledStartupValue = false;
	if g_gameSettings:getValue("isHeadTrackingEnabled") then
		toggleHeadtracking.isHeadTrackingEnabledStartupValue = true;
		print("toggleHeadtracking: Headtracking is enabled");
	else
		print("toggleHeadtracking: Headtracking is disabled");
	end;
	Enterable.onRegisterActionEvents = Utils.appendedFunction(Enterable.onRegisterActionEvents, toggleHeadtracking.registerActionEvents);
end;


function toggleHeadtracking:deleteMap()
	g_gameSettings:setValue("isHeadTrackingEnabled", toggleHeadtracking.isHeadTrackingEnabledStartupValue, true);
end;

function toggleHeadtracking:registerActionEvents()
	toggleHeadtracking.events = {};
	local result, eventName = InputBinding.registerActionEvent(g_inputBinding, "TOGGLE_HEADTRACKING", self, toggleHeadtracking.toggleHeadtracking, false, true, false, true);
	if result then
		table.insert(toggleHeadtracking.events, eventName);
        g_inputBinding:setActionEventTextVisibility(eventName, true);
		g_inputBinding:setActionEventTextPriority(eventName, GS_PRIO_NORMAL);
    end;
end;

function toggleHeadtracking:processActionEvent(self, actionName, inputValue, callbackState, isAnalog)
	if actionName == "TOGGLE_HEADTRACKING" then
		toggleHeadtracking.toggleHeadtracking();
	end;
end;

function toggleHeadtracking:toggleHeadtracking()
	if g_gameSettings:getValue("isHeadTrackingEnabled") then
		g_gameSettings:setValue("isHeadTrackingEnabled", false, false);
		print("toggleHeadtracking: disable Headtracking");	
	else
		g_gameSettings:setValue("isHeadTrackingEnabled", true, false);
		print("toggleHeadtracking: enable Headtracking");
	end;
end;