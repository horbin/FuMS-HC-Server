//SpawnMissionLoot.sqf
// Horbin
//1/2/15
//INPUTS: loot data from Mission, encounter center, one of "STATIC","WIN","LOSE", Loot Data to be parsed!
//OUTPUTS: loot box filled.
//XPos = compile preprocessFileLineNumbers "HC\Encounters\Functions\XPos.sqf";
//FillLoot = compile preprocessFileLineNumbers "HC\Encounters\LogicBomb\FillLoot.sqf";

private ["_lootConfig","_eCenter","_option","_staticLoot","_winLoot","_pos","_themeIndex","_box","_boxes","_loseLoot","_loot","_abort","_msnStatus",
"_lineage","_generation","_offspringID","_msnTag"];

_lootConfig = _this select 0;
_eCenter = _this select 1;
_msnStatus = _this select 2; // ["Win"]
_lineage = _this select 3;
_boxes = _this select 4;

_option = _msnStatus select 0;

_themeIndex = _lineage select 0;
_generation = _lineage select 1;
_offspringID = _lineage select 2;
_msnTag = format ["FuMS_%1_%2_%3",_themeIndex,_generation,_offspringID];

if (!isNil "_lootConfig") then  // if no loot data then no loot for mission!
{
    _staticLoot = _lootConfig select 0;
    _winLoot = _lootConfig select 1;
    _loseLoot = _lootConfig select 2;
  //  _boxes = [];
    _abort = false;
    _option = toupper _option;
    if (_option == "NO TRIGGERS") then {_option ="STATIC";};
    switch (_option) do
    {
        case "STATIC":
        {
           _loot = _staticLoot;
        };
        case "WIN":
        {
            _loot = _winLoot;
        };
        case "LOSE":
        {
            _loot = _loseLoot;
        };
        default {_abort = true;};
    };
    if (_abort) exitWith {_boxes};
    if (typeName (_loot select 0) == "STRING") then
    {    
        _pos = [_eCenter, _loot select 1] call FuMS_fnc_HC_MsnCtrl_Util_XPos;
        _box = [_loot select 0, _pos, _themeIndex] call FuMS_fnc_HC_Loot_FillLoot;
        if (TypeName _box != "ARRAY") then
        {
            if (!isNull _box) then
            {
                // if loot was not a 'scatter' add the container.                
                _box setVariable ["LINEAGE",_msnTag, false];
                _boxes = _boxes +[_box];
            };
        };        
    }else
    {
        //ASSERT it is an array of loot options!
        {
            _pos = [_eCenter, _x select 1] call FuMS_fnc_HC_MsnCtrl_Util_XPos;
            diag_log format ["<FuMS> SpawnMissionLoot: Type:%1 Loc:%2",_x select 0, _x select 1];
            _box = [_x select 0, _pos, _themeIndex] call FuMS_fnc_HC_Loot_FillLoot;
            _box setVariable ["LINEAGE",_msnTag, false];
            _boxes = _boxes + [_box];
        }foreach _loot;
    };
};
_boxes
