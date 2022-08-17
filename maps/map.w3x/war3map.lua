udg_AbilityTest = nil
udg_AbilityTestArray = {}
gg_rct_Region_000 = nil
gg_cam_Camera_001 = nil
gg_snd_SoulPreservation = nil
gg_trg_Untitled_Trigger_001 = nil
gg_unit_Hblm_0000 = nil
gg_unit_Obla_0002 = nil
gg_item_ratf_0004 = nil
gg_dest_LTbr_0000 = nil
function InitGlobals()
local i = 0

end

function InitSounds()
gg_snd_SoulPreservation = CreateSound("Abilities/Spells/Demon/SoulPreservation/SoulPreservation.flac", false, true, true, 0, 0, "SpellsEAX")
SetSoundParamsFromLabel(gg_snd_SoulPreservation, "SoulPreservation")
SetSoundDuration(gg_snd_SoulPreservation, 3612)
SetSoundVolume(gg_snd_SoulPreservation, 127)
end

function CreateAllDestructables()
local d
local t
local life

gg_dest_LTbr_0000 = BlzCreateDestructableWithSkin(FourCC("LTbr"), 480.0, -480.0, 354.000, 1.102, 0, FourCC("LTbr"))
end

function CreateAllItems()
local itemID

gg_item_ratf_0004 = BlzCreateItemWithSkin(FourCC("ratf"), -116.6, -255.6, FourCC("ratf"))
end

function CreateUnitsForPlayer0()
local p = Player(0)
local u
local unitID
local t
local life

gg_unit_Hblm_0000 = BlzCreateUnitWithSkin(p, FourCC("Hblm"), 506.5, -8.6, 235.930, FourCC("Hblm"))
end

function CreateUnitsForPlayer1()
local p = Player(1)
local u
local unitID
local t
local life

gg_unit_Obla_0002 = BlzCreateUnitWithSkin(p, FourCC("Obla"), -597.5, -9.0, 302.350, FourCC("Obla"))
end

function CreatePlayerBuildings()
end

function CreatePlayerUnits()
CreateUnitsForPlayer0()
CreateUnitsForPlayer1()
end

function CreateAllUnits()
CreatePlayerBuildings()
CreatePlayerUnits()
end

function CreateRegions()
local we

gg_rct_Region_000 = Rect(-512.0, -512.0, 0.0, 0.0)
end

function CreateCameras()
gg_cam_Camera_001 = CreateCameraSetup()
CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ZOFFSET, 0.0, 0.0)
CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ROTATION, 90.0, 0.0)
CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ANGLE_OF_ATTACK, 304.0, 0.0)
CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_TARGET_DISTANCE, 3000.0, 0.0)
CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ROLL, 0.0, 0.0)
CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_FIELD_OF_VIEW, 70.0, 0.0)
CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_FARZ, 5000.0, 0.0)
CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_NEARZ, 16.0, 0.0)
CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_LOCAL_PITCH, 0.0, 0.0)
CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_LOCAL_YAW, 0.0, 0.0)
CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_LOCAL_ROLL, 0.0, 0.0)
CameraSetupSetDestPosition(gg_cam_Camera_001, 0.0, 0.0, 0.0)
end

function Trig_Untitled_Trigger_001_Actions()
SelectUnitSingle(gg_unit_Hblm_0000)
SelectUnitSingle(gg_unit_Obla_0002)
ShowDestructableBJ(true, gg_dest_LTbr_0000)
SetItemVisibleBJ(true, gg_item_ratf_0004)
udg_AbilityTest = BlzGetItemAbilityByIndex(gg_item_ratf_0004, 0)
end

function InitTrig_Untitled_Trigger_001()
gg_trg_Untitled_Trigger_001 = CreateTrigger()
DisableTrigger(gg_trg_Untitled_Trigger_001)
TriggerAddAction(gg_trg_Untitled_Trigger_001, Trig_Untitled_Trigger_001_Actions)
end

function InitCustomTriggers()
InitTrig_Untitled_Trigger_001()
end

function InitCustomPlayerSlots()
SetPlayerStartLocation(Player(0), 0)
SetPlayerColor(Player(0), ConvertPlayerColor(0))
SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
SetPlayerRaceSelectable(Player(0), true)
SetPlayerController(Player(0), MAP_CONTROL_USER)
SetPlayerStartLocation(Player(1), 1)
SetPlayerColor(Player(1), ConvertPlayerColor(1))
SetPlayerRacePreference(Player(1), RACE_PREF_ORC)
SetPlayerRaceSelectable(Player(1), true)
SetPlayerController(Player(1), MAP_CONTROL_COMPUTER)
end

function InitCustomTeams()
SetPlayerTeam(Player(0), 0)
SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
SetPlayerTeam(Player(1), 0)
SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
end

function InitAllyPriorities()
SetStartLocPrioCount(1, 2)
SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_LOW)
SetEnemyStartLocPrioCount(1, 2)
SetEnemyStartLocPrio(1, 0, 0, MAP_LOC_PRIO_LOW)
end

function main()
SetCameraBounds(-3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
NewSoundEnvironment("Default")
SetAmbientDaySound("LordaeronSummerDay")
SetAmbientNightSound("LordaeronSummerNight")
SetMapMusic("Music", true, 0)
InitSounds()
CreateRegions()
CreateCameras()
CreateAllDestructables()
CreateAllItems()
CreateAllUnits()
InitBlizzard()
InitGlobals()
InitCustomTriggers()
end

function config()
SetMapName("TRIGSTR_001")
SetMapDescription("TRIGSTR_003")
SetPlayers(2)
SetTeams(2)
SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
DefineStartLocation(0, 0.0, 0.0)
DefineStartLocation(1, 0.0, 0.0)
InitCustomPlayerSlots()
InitCustomTeams()
InitAllyPriorities()
end

