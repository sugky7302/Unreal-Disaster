globals
//globals from Base:
constant boolean LIBRARY_Base=true
//endglobals from Base
//globals from JapiConstantLib:
constant boolean LIBRARY_JapiConstantLib=true
integer array i_1
integer array i_2
integer array i_3
integer array i_4
integer array i_5
integer array i_6
integer array i_7
integer array i_8
integer array i_9
integer array i_10
integer array i_11
integer array i_12
integer array i_13
integer array i_14
integer array i_15
integer array i_16
integer array i_17
integer array i_18
integer array i_19
integer array i_20
integer array i_21
integer array i_22
integer array i_23
integer array i_24
integer array i_25
integer array i_26
integer array i_27
integer array i_28
integer array i_29
integer array i_30
integer array i_31
integer array i_32

//endglobals from JapiConstantLib
//globals from japi:
constant boolean LIBRARY_japi=true
hashtable japi_ht=InitHashtable()
integer japi___key=StringHash("jass")
//endglobals from japi
//globals from LocalActionLib:
constant boolean LIBRARY_LocalActionLib=true
constant hashtable LocalActionLib__ht=japi_ht
constant integer LocalActionLib__key=StringHash("jass")
//endglobals from LocalActionLib
//globals from d3d:
constant boolean LIBRARY_d3d=true
constant hashtable d3d__ht=japi_ht
constant integer d3d__key=StringHash("jass")
//endglobals from d3d
    // Generated
trigger gg_trg_japi_constant_lib= null
trigger gg_trg_japi= null
trigger gg_trg_d3d= null
trigger gg_trg_async_japi= null

trigger l__library_init

//JASSHelper struct globals:
constant integer si__LOGFONT=1
integer si__LOGFONT_F=0
integer si__LOGFONT_I=0
integer array si__LOGFONT_V
integer array s__LOGFONT_font
trigger st__LOGFONT_onDestroy
integer f__arg_this

endglobals
    native SetHeroLevels takes code f returns nothing 
    native TeleportCaptain takes real x, real y returns nothing
    native GetUnitGoldCost takes integer unitid returns integer


//Generated method caller for LOGFONT.onDestroy
function sc__LOGFONT_onDestroy takes integer this returns nothing
    set f__arg_this=this
    call TriggerEvaluate(st__LOGFONT_onDestroy)
endfunction

//Generated allocator of LOGFONT
function s__LOGFONT__allocate takes nothing returns integer
 local integer this=si__LOGFONT_F
    if (this!=0) then
        set si__LOGFONT_F=si__LOGFONT_V[this]
    else
        set si__LOGFONT_I=si__LOGFONT_I+1
        set this=si__LOGFONT_I
    endif
    if (this>8190) then
        return 0
    endif

    set si__LOGFONT_V[this]=-1
 return this
endfunction

//Generated destructor of LOGFONT
function sc__LOGFONT_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__LOGFONT_V[this]!=-1) then
        return
    endif
    set f__arg_this=this
    call TriggerEvaluate(st__LOGFONT_onDestroy)
    set si__LOGFONT_V[this]=si__LOGFONT_F
    set si__LOGFONT_F=this
endfunction

//library Base:
    function Base___init takes nothing returns nothing
        call AbilityId("exec-lua: main")
    endfunction

//library Base ends
//library JapiConstantLib:
    function JapiConstantLib_init_memory takes nothing returns nothing
         set i_1[8191]=0
 set i_2[8191]=0
 set i_3[8191]=0
 set i_4[8191]=0
 set i_5[8191]=0
 set i_6[8191]=0
 set i_7[8191]=0
 set i_8[8191]=0
 set i_9[8191]=0
 set i_10[8191]=0
 set i_11[8191]=0
 set i_12[8191]=0
 set i_13[8191]=0
 set i_14[8191]=0
 set i_15[8191]=0
 set i_16[8191]=0
 set i_17[8191]=0
 set i_18[8191]=0
 set i_19[8191]=0
 set i_20[8191]=0
 set i_21[8191]=0
 set i_22[8191]=0
 set i_23[8191]=0
 set i_24[8191]=0
 set i_25[8191]=0
 set i_26[8191]=0
 set i_27[8191]=0
 set i_28[8191]=0
 set i_29[8191]=0
 set i_30[8191]=0
 set i_31[8191]=0
 set i_32[8191]=0

    endfunction
    function JapiConstantLib_init takes nothing returns integer
        call ExecuteFunc("JapiConstantLib_init_memory")
        return 1
    endfunction

//library JapiConstantLib ends
//library japi:



    
    
     function Call takes string str returns nothing
        call UnitId(str)
    endfunction
    //???????????????????????????x???
     function GetMouseX takes nothing returns real
        call SaveStr(japi_ht, japi___key, 0, "()R")
        call UnitId(("GetMouseX")) // INLINED!!
        return LoadReal(japi_ht, japi___key, 0)
    endfunction
    //???????????????????????????y???
     function GetMouseY takes nothing returns real
        call SaveStr(japi_ht, japi___key, 0, "()R")
        call UnitId(("GetMouseY")) // INLINED!!
        return LoadReal(japi_ht, japi___key, 0)
    endfunction
    
    
    
    
    //==========================================================================
     function EXGetUnitAbility takes unit u,integer abilityId returns integer
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(u))
        call SaveInteger(japi_ht, japi___key, 2, abilityId)
        call SaveStr(japi_ht, japi___key, 0, "(II)I")
        call UnitId(("EXGetUnitAbility")) // INLINED!!
        return LoadInteger(japi_ht, japi___key, 0)
    endfunction
    
    // yd japi ==================================================================
    // ??????----------------------------------------------------
    
    ///<summary>???????????? [JAPI]</summary>
  function YDWEGetUnitAbilityState takes unit u,integer abilcode,integer data_type returns real
        call SaveInteger(japi_ht, japi___key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi___key, 2, data_type)
        call SaveStr(japi_ht, japi___key, 0, "(II)R")
        call UnitId(("EXGetAbilityState")) // INLINED!!
		return LoadReal(japi_ht, japi___key, 0)
	endfunction
	///<summary>???????????? (??????) [JAPI]</summary>
  function YDWEGetUnitAbilityDataInteger takes unit u,integer abilcode,integer level,integer data_type returns integer
        call SaveInteger(japi_ht, japi___key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi___key, 2, level)
        call SaveInteger(japi_ht, japi___key, 3, data_type)
        call SaveStr(japi_ht, japi___key, 0, "(III)I")
        call UnitId(("EXGetAbilityDataInteger")) // INLINED!!
		return LoadInteger(japi_ht, japi___key, 0)
	endfunction
	///<summary>???????????? (??????) [JAPI]</summary>
  function YDWEGetUnitAbilityDataReal takes unit u,integer abilcode,integer level,integer data_type returns real
        call SaveInteger(japi_ht, japi___key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi___key, 2, level)
        call SaveInteger(japi_ht, japi___key, 3, data_type)
        call SaveStr(japi_ht, japi___key, 0, "(III)R")
        call UnitId(("EXGetAbilityDataReal")) // INLINED!!
		return LoadReal(japi_ht, japi___key, 0)
    endfunction
	///<summary>???????????? (?????????) [JAPI]</summary>
  function YDWEGetUnitAbilityDataString takes unit u,integer abilcode,integer level,integer data_type returns string
        call SaveInteger(japi_ht, japi___key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi___key, 2, level)
        call SaveInteger(japi_ht, japi___key, 3, data_type)
        call SaveStr(japi_ht, japi___key, 0, "(III)S")
        call UnitId(("EXGetAbilityDataString")) // INLINED!!
		return LoadStr(japi_ht, japi___key, 0)
	endfunction
	///<summary>?????????????????? [JAPI]</summary>
  function YDWESetUnitAbilityState takes unit u,integer abilcode,integer data_type,real value returns nothing
        call SaveInteger(japi_ht, japi___key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi___key, 2, data_type)
        call SaveReal(japi_ht, japi___key, 3, value)
        call SaveStr(japi_ht, japi___key, 0, "(IIR)V")
        call UnitId(("EXSetAbilityState")) // INLINED!!
    endfunction
	///<summary>?????????????????? (??????) [JAPI]</summary>
  function YDWESetUnitAbilityDataInteger takes unit u,integer abilcode,integer level,integer data_type,integer value returns nothing
        call SaveInteger(japi_ht, japi___key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi___key, 2, level)
        call SaveInteger(japi_ht, japi___key, 3, data_type)
        call SaveInteger(japi_ht, japi___key, 4, value)
        call SaveStr(japi_ht, japi___key, 0, "(IIII)V")
        call UnitId(("EXSetAbilityDataInteger")) // INLINED!!
    endfunction
	///<summary>?????????????????? (??????) [JAPI]</summary>
  function YDWESetUnitAbilityDataReal takes unit u,integer abilcode,integer level,integer data_type,real value returns nothing
        call SaveInteger(japi_ht, japi___key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi___key, 2, level)
        call SaveInteger(japi_ht, japi___key, 3, data_type)
        call SaveReal(japi_ht, japi___key, 4, value)
        call SaveStr(japi_ht, japi___key, 0, "(IIIR)V")
        call UnitId(("EXSetAbilityDataReal")) // INLINED!!
    endfunction
	///<summary>?????????????????? (?????????) [JAPI]</summary>
  function YDWESetUnitAbilityDataString takes unit u,integer abilcode,integer level,integer data_type,string value returns nothing
        call SaveInteger(japi_ht, japi___key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi___key, 2, level)
        call SaveInteger(japi_ht, japi___key, 3, data_type)
        call SaveStr(japi_ht, japi___key, 4, value)
        call SaveStr(japi_ht, japi___key, 0, "(IIIS)V")
        call UnitId(("EXSetAbilityDataString")) // INLINED!!
    endfunction
	
    
    //????????????????????????A
     function EXSetAbilityAEmeDataA takes integer ability_handle,integer value returns boolean
        call SaveInteger(japi_ht, japi___key, 1, ability_handle)
        call SaveInteger(japi_ht, japi___key, 2, value)
        call SaveStr(japi_ht, japi___key, 0, "(II)B")
        call UnitId(("EXSetAbilityAEmeDataA")) // INLINED!!
        return LoadBoolean(japi_ht, japi___key, 0)
    endfunction
    
    //????????????
     function YDWEUnitTransform takes unit u,integer abilcode,integer targetid returns nothing
		call UnitAddAbility(u, abilcode)
		call YDWESetUnitAbilityDataInteger(u , abilcode , 1 , 117 , GetUnitTypeId(u))
		call EXSetAbilityAEmeDataA(EXGetUnitAbility(u , abilcode) , GetUnitTypeId(u))
		call UnitRemoveAbility(u, abilcode)
		call UnitAddAbility(u, abilcode)
		call EXSetAbilityAEmeDataA(EXGetUnitAbility(u , abilcode) , targetid)
		call UnitRemoveAbility(u, abilcode)
	endfunction
    
    // ??????-------------------------------------------------------
    
    //????????????
     function EXPauseUnit takes unit unit_handle,boolean flag returns nothing
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(unit_handle))
        call SaveBoolean(japi_ht, japi___key, 2, flag)
        call SaveStr(japi_ht, japi___key, 0, "(IB)V")
        call UnitId(("EXPauseUnit")) // INLINED!!
    endfunction
    
    //?????????????????????
     function EXGetUnitString takes integer unitcode,integer Type returns string
        call SaveInteger(japi_ht, japi___key, 1, unitcode)
        call SaveInteger(japi_ht, japi___key, 2, Type)
        call SaveStr(japi_ht, japi___key, 0, "(II)S")
        call UnitId(("EXGetUnitString")) // INLINED!!
        return LoadStr(japi_ht, japi___key, 0)
    endfunction
    
       //?????????????????????
     function EXSetUnitString takes integer unitcode,integer Type,string value returns boolean
        call SaveInteger(japi_ht, japi___key, 1, unitcode)
        call SaveInteger(japi_ht, japi___key, 2, Type)
        call SaveStr(japi_ht, japi___key, 3, value)
        call SaveStr(japi_ht, japi___key, 0, "(IIS)B")
        call UnitId(("EXSetUnitString")) // INLINED!!
        return LoadBoolean(japi_ht, japi___key, 0)
    endfunction
    
    //??????????????????
     function EXGetUnitReal takes integer unitcode,integer Type returns real
        call SaveInteger(japi_ht, japi___key, 1, unitcode)
        call SaveInteger(japi_ht, japi___key, 2, Type)
        call SaveStr(japi_ht, japi___key, 0, "(II)R")
        call UnitId(("EXGetUnitReal")) // INLINED!!
        return LoadReal(japi_ht, japi___key, 0)
    endfunction
    
    //??????????????????
     function EXSetUnitReal takes integer unitcode,integer Type,real value returns boolean
        call SaveInteger(japi_ht, japi___key, 1, unitcode)
        call SaveInteger(japi_ht, japi___key, 2, Type)
        call SaveReal(japi_ht, japi___key, 3, value)
        call SaveStr(japi_ht, japi___key, 0, "(IIR)B")
        call UnitId(("EXSetUnitReal")) // INLINED!!
        return LoadBoolean(japi_ht, japi___key, 0)
    endfunction
    
    
    //??????????????????
     function EXGetUnitInteger takes integer unitcode,integer Type returns integer
        call SaveInteger(japi_ht, japi___key, 1, unitcode)
        call SaveInteger(japi_ht, japi___key, 2, Type)
        call SaveStr(japi_ht, japi___key, 0, "(II)I")
        call UnitId(("EXGetUnitInteger")) // INLINED!!
        return LoadInteger(japi_ht, japi___key, 0)
    endfunction
    
    //??????????????????
     function EXSetUnitInteger takes integer unitcode,integer Type,integer value returns boolean
        call SaveInteger(japi_ht, japi___key, 1, unitcode)
        call SaveInteger(japi_ht, japi___key, 2, Type)
        call SaveInteger(japi_ht, japi___key, 3, value)
        call SaveStr(japi_ht, japi___key, 0, "(III)B")
        call UnitId(("EXSetUnitInteger")) // INLINED!!
        return LoadBoolean(japi_ht, japi___key, 0)
    endfunction
    
        //???????????????????????????
     function EXGetUnitArrayString takes integer unitcode,integer Type,integer index returns string
        call SaveInteger(japi_ht, japi___key, 1, unitcode)
        call SaveInteger(japi_ht, japi___key, 2, Type)
        call SaveInteger(japi_ht, japi___key, 3, index)
        call SaveStr(japi_ht, japi___key, 0, "(III)S")
        call UnitId(("EXGetUnitArrayString")) // INLINED!!
        return LoadStr(japi_ht, japi___key, 0)
    endfunction
    
    //???????????????????????????
     function EXSetUnitArrayString takes integer unitcode,integer Type,integer index,string value returns boolean
        call SaveInteger(japi_ht, japi___key, 1, unitcode)
        call SaveInteger(japi_ht, japi___key, 2, Type)
        call SaveInteger(japi_ht, japi___key, 3, index)
        call SaveStr(japi_ht, japi___key, 4, value)
        call SaveStr(japi_ht, japi___key, 0, "(IIIS)B")
        call UnitId(("EXSetUnitArrayString")) // INLINED!!
        return LoadBoolean(japi_ht, japi___key, 0)
    endfunction
    //????????????????????????(????????????)
     function EXSetUnitFacing takes unit unit_handle,real angle returns nothing
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(unit_handle))
        call SaveReal(japi_ht, japi___key, 2, angle)
        call SaveStr(japi_ht, japi___key, 0, "(IR)V")
        call UnitId(("EXSetUnitFacing")) // INLINED!!
    endfunction
    
    //????????????????????????
     function EXSetUnitCollisionType takes boolean enable,unit unit_handle,integer Type returns nothing
        call SaveBoolean(japi_ht, japi___key, 1, enable)
        call SaveInteger(japi_ht, japi___key, 2, GetHandleId(unit_handle))
        call SaveInteger(japi_ht, japi___key, 3, Type)
        call SaveStr(japi_ht, japi___key, 0, "(BII)V")
        call UnitId(("EXSetUnitCollisionType")) // INLINED!!
    endfunction
    
    //????????????????????????
     function EXSetUnitMoveType takes unit unit_handle,integer Type returns nothing
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(unit_handle))
        call SaveInteger(japi_ht, japi___key, 2, Type)
        call SaveStr(japi_ht, japi___key, 0, "(II)V")
        call UnitId(("EXSetUnitMoveType")) // INLINED!!
    endfunction
    
    //??????????????????
     function YDWEUnitAddStun takes unit u returns nothing
		call EXPauseUnit(u , true)
	endfunction
    
    //??????????????????
  function YDWEUnitRemoveStun takes unit u returns nothing
		call EXPauseUnit(u , false)
	endfunction
    
    //??????????????????
     function EXGetEventDamageData takes integer Type returns integer
        //call SaveInteger(ht,key,1,Type)
        //call SaveStr(ht,key,0,"(I)I")
        //call Call("EXGetEventDamageData")
        //return LoadInteger(ht,key,0)
        return GetUnitGoldCost(Type)
    endfunction
	
    //????????????
     function EXSetEventDamage takes real Damage returns boolean
        //call SaveReal(ht,key,1,Damage)
        //call SaveStr(ht,key,0,"(R)B")
        //call Call("EXSetEventDamage")
        //return LoadBoolean(ht,key,0)
        call TeleportCaptain(Damage, 0.00)
        return true
    endfunction
    
    //???????????????????????????
     function YDWEIsEventPhysicalDamage takes nothing returns boolean
		return 0 != (GetUnitGoldCost((1))) // INLINED!!
	endfunction
    //???????????????????????????
  function YDWEIsEventAttackDamage takes nothing returns boolean
		return 0 != (GetUnitGoldCost((2))) // INLINED!!
	endfunction
	
    //???????????????????????????
  function YDWEIsEventRangedDamage takes nothing returns boolean
		return 0 != (GetUnitGoldCost((3))) // INLINED!!
	endfunction
	
    //??????????????????
  function YDWEIsEventDamageType takes damagetype damageType returns boolean
		return damageType == ConvertDamageType((GetUnitGoldCost((4)))) // INLINED!!
	endfunction
    
    //??????????????????
  function YDWEIsEventWeaponType takes weapontype weaponType returns boolean
		return weaponType == ConvertWeaponType((GetUnitGoldCost((5)))) // INLINED!!
	endfunction
	
    //??????????????????
  function YDWEIsEventAttackType takes attacktype attackType returns boolean
		return attackType == ConvertAttackType((GetUnitGoldCost((6)))) // INLINED!!
	endfunction
	//????????????
  function YDWESetEventDamage takes real amount returns boolean
		return EXSetEventDamage(amount)
	endfunction
    
    // ??????----------------------------------------------------
    
    ///<summary>?????????????????? (?????????) [JAPI]</summary>
     function YDWESetItemDataString takes integer ItemTypeId,integer Type,string Value returns nothing
        call SaveStr(japi_ht, japi___key, 0, "(IIS)V")
        call SaveInteger(japi_ht, japi___key, 1, ItemTypeId)
        call SaveInteger(japi_ht, japi___key, 2, Type)
        call SaveStr(japi_ht, japi___key, 3, Value)
        call UnitId(("EXSetItemDataString")) // INLINED!!
    endfunction
    ///<summary>?????????????????? (?????????) [JAPI]</summary>
     function YDWEGetItemDataString takes integer ItemTypeId,integer Type returns string
        call SaveStr(japi_ht, japi___key, 0, "(II)S")
        call SaveInteger(japi_ht, japi___key, 1, ItemTypeId)
        call SaveInteger(japi_ht, japi___key, 2, Type)
        call UnitId(("EXGetItemDataString")) // INLINED!!
        return LoadStr(japi_ht, japi___key, 0)
    endfunction
    
    //??????--------------------------------------------------------
    
    ///<summary>?????????????????? [JAPI]</summary>
     function EXSetEffectXY takes effect Handle,real x,real y returns nothing
        call SaveStr(japi_ht, japi___key, 0, "(IRR)V")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi___key, 2, x)
        call SaveReal(japi_ht, japi___key, 3, y)
        call UnitId(("EXSetEffectXY")) // INLINED!!
    endfunction
    
    ///<summary>????????????Z??? [JAPI]</summary>
     function EXSetEffectZ takes effect Handle,real z returns nothing
        call SaveStr(japi_ht, japi___key, 0, "(IRR)V")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi___key, 2, z)
		call UnitId(("EXSetEffectZ")) // INLINED!!
	endfunction
    
    ///<summary>????????????X??? [JAPI]</summary>
     function EXGetEffectX takes effect Handle returns real
        call SaveStr(japi_ht, japi___key, 0, "(I)R")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectX")) // INLINED!!
        return LoadReal(japi_ht, japi___key, 0)
	endfunction
    
    ///<summary>????????????Y??? [JAPI]</summary>
  function EXGetEffectY takes effect Handle returns real
        call SaveStr(japi_ht, japi___key, 0, "(I)R")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectY")) // INLINED!!
        return LoadReal(japi_ht, japi___key, 0)
	endfunction
    
    ///<summary>????????????Z??? [JAPI]</summary>
  function EXGetEffectZ takes effect Handle returns real
        call SaveStr(japi_ht, japi___key, 0, "(I)R")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectZ")) // INLINED!!
		return LoadReal(japi_ht, japi___key, 0)
	endfunction
    
    ///<summary>?????????????????? [JAPI]</summary>
  function EXSetEffectSize takes effect Handle,real size returns nothing
		call SaveStr(japi_ht, japi___key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi___key, 2, size)
        call UnitId(("EXSetEffectSize")) // INLINED!!
	endfunction
    
    ///<summary>?????????????????? [JAPI]</summary>
  function EXGetEffectSize takes effect Handle returns real
        call SaveStr(japi_ht, japi___key, 0, "(I)R")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectSize")) // INLINED!!
		return LoadReal(japi_ht, japi___key, 0)
	endfunction
    
    ///<summary>????????????X????????? [JAPI]</summary>
  function EXEffectMatRotateX takes effect Handle,real x returns nothing
        call SaveStr(japi_ht, japi___key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi___key, 2, x)
        call UnitId(("EXEffectMatRotateX")) // INLINED!!
	endfunction
    
    ///<summary>????????????Y????????? [JAPI]</summary>
  function EXEffectMatRotateY takes effect Handle,real y returns nothing
        call SaveStr(japi_ht, japi___key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi___key, 2, y)
        call UnitId(("EXEffectMatRotateY")) // INLINED!!
	endfunction
    
    ///<summary>????????????Z????????? [JAPI]</summary>
  function EXEffectMatRotateZ takes effect Handle,real z returns nothing
        call SaveStr(japi_ht, japi___key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi___key, 2, z)
        call UnitId(("EXEffectMatRotateZ")) // INLINED!!
	endfunction
    
    ///<summary>?????????????????? [JAPI]</summary>
  function EXEffectMatScale takes effect Handle,real x,real y,real z returns nothing
        call SaveStr(japi_ht, japi___key, 0, "(IRRR)V")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi___key, 2, x)
        call SaveReal(japi_ht, japi___key, 3, y)
        call SaveReal(japi_ht, japi___key, 4, z)
        call UnitId(("EXEffectMatScale")) // INLINED!!
	endfunction
    
    ///<summary>?????????????????? [JAPI]</summary>
  function EXEffectMatReset takes effect Handle returns nothing
        call SaveStr(japi_ht, japi___key, 0, "(I)V")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call UnitId(("EXEffectMatReset")) // INLINED!!
	endfunction
    
    ///<summary>?????????????????? [JAPI]</summary>
  function EXSetEffectSpeed takes effect Handle,real speed returns nothing
        call SaveStr(japi_ht, japi___key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi___key, 2, speed)
        call UnitId(("EXSetEffectSpeed")) // INLINED!!
	endfunction
    
    ///<summary>???????????????????????? [JAPI]</summary>
     function EXSetTrackableXY takes trackable Handle,real x,real y returns nothing
        call SaveStr(japi_ht, japi___key, 0, "(IRR)V")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi___key, 2, x)
        call SaveReal(japi_ht, japi___key, 3, y)
        call UnitId(("EXSetEffectXY")) // INLINED!!
    endfunction
    
    
    ///<summary>??????????????????X??? [JAPI]</summary>
     function EXGetTrackableX takes trackable Handle returns real
        call SaveStr(japi_ht, japi___key, 0, "(I)R")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectX")) // INLINED!!
        return LoadReal(japi_ht, japi___key, 0)
	endfunction
    
    ///<summary>??????????????????Y??? [JAPI]</summary>
  function EXGetTrackableY takes trackable Handle returns real
        call SaveStr(japi_ht, japi___key, 0, "(I)R")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectY")) // INLINED!!
        return LoadReal(japi_ht, japi___key, 0)
	endfunction
    
    
    
     function EXExecuteScript takes string str returns string
        call SaveStr(japi_ht, japi___key, 0, "(S)S")
        call SaveStr(japi_ht, japi___key, 1, str)
        call UnitId(("EXExecuteScript")) // INLINED!!
        return LoadStr(japi_ht, japi___key, 0)
    endfunction
    //-----------------????????????----------------------------
     function EXDisplayChat takes player p,integer chat_recipient,string message returns nothing
        call SaveStr(japi_ht, japi___key, 0, "(IIS)V")
        call SaveInteger(japi_ht, japi___key, 1, GetHandleId(p))
        call SaveInteger(japi_ht, japi___key, 2, chat_recipient)
        call SaveStr(japi_ht, japi___key, 3, message)
        call UnitId(("EXDisplayChat")) // INLINED!!
    endfunction
  function YDWEDisplayChat takes player p,integer chat_recipient,string message returns nothing
		call EXDisplayChat(p , chat_recipient , message)
	endfunction
    
    //-----------????????????-------------------------------------
    
    //??????????????????
     function GetMapName takes nothing returns string
        call SaveStr(japi_ht, japi___key, 0, "()S")
        call UnitId(("GetMapName")) // INLINED!!
        return LoadStr(japi_ht, japi___key, 0)
    endfunction
    
    //??????????????????
     function GetGameVersion takes nothing returns integer
        call SaveStr(japi_ht, japi___key, 0, "()I")
        call UnitId(("GetGameVersion")) // INLINED!!
        return LoadInteger(japi_ht, japi___key, 0)
    endfunction
    
    //??????????????????
     function GetPluginVersion takes nothing returns string
        call SaveStr(japi_ht, japi___key, 0, "()S")
        call UnitId(("GetPluginVersion")) // INLINED!!
        return LoadStr(japi_ht, japi___key, 0)
    endfunction
    
     function GetFuncAddr takes code f returns integer
        call SetHeroLevels(f)
        return LoadInteger(japi_ht, japi___key, 0)
    endfunction
     function japiDoNothing takes nothing returns nothing
        
    endfunction
    
     function func_bind_trigger_name takes code functions,string name returns nothing
        call SaveStr(japi_ht, japi___key, 0, "(IS)V")
        call SaveInteger(japi_ht, japi___key, 1, GetFuncAddr(functions))
        call SaveStr(japi_ht, japi___key, 2, name)
        call UnitId(("func_bind_trigger_name")) // INLINED!!
    endfunction
    
     function open_code_run_logs takes boolean open returns nothing
        local string l=""
        set l=l + "(function () "
        set l=l + "lfunc={}  lfunc_name={}"
        set l=l + "save_lfunc_info=function (func,name,index)index=1<<index lfunc[func]=index lfunc_name[index]=name end "
        set l=l + "save_lfunc_info('GetLocalPlayer','[????????????]',0)"
        set l=l + "save_lfunc_info('GetFps','[????????????]',1)"
        set l=l + "save_lfunc_info('GetChatState','[????????????]',2)"
        set l=l + "save_lfunc_info('GetCameraTargetPositionLoc','[?????????????????????]',3)"
        set l=l + "save_lfunc_info('GetCameraTargetPositionX','[??????????????????X??????]',4)"
        set l=l + "save_lfunc_info('GetCameraTargetPositionY','[??????????????????Y??????]',5)"
        set l=l + "save_lfunc_info('GetCameraTargetPositionZ','[??????????????????Z??????]',6)"
        
        set l=l + "save_lfunc_info('GetCameraEyePositionLoc','[?????????????????????]',7)"
        set l=l + "save_lfunc_info('GetCameraEyePositionX','[???????????????X??????]',8)"
        set l=l + "save_lfunc_info('GetCameraEyePositionY','[???????????????Y??????]',9)"
        set l=l + "save_lfunc_info('GetCameraEyePositionZ','[???????????????Z??????]',10)"
        
        set l=l + "save_lfunc_info('GetMouseX','[????????????X???]',11)"
        set l=l + "save_lfunc_info('GetMouseY','[????????????Y???]',12)"
        set l=l + "save_lfunc_info('GetMouseVectorX','[??????????????????X???]',13)"
        set l=l + "save_lfunc_info('GetMouseVectorY','[??????????????????Y???]',14)"
        
        set l=l + "end)() or '' "
        call EXExecuteScript(l)
        
        set l=""
        
        set l=l + "(function () "
        
        set l=l + "get_jass_func_info=function (func_name) "
        set l=l + " return lfunc[func_name] or 0 "
        set l=l + "end "
        
        set l=l + "get_jass_func_msg=function (func_name_index)"
        set l=l + " return lfunc_name[func_name_index] or '' "
        set l=l + "end "
        
        set l=l + "local storm=require 'jass.storm' "
        set l=l + "local ss=storm.load('war3map.j') "
        set l=l + "ss:gsub('function%s+([%w_]+)%s+takes(.-)endfunction',function (name,code)\n"
        set l=l + "code=code:gsub('function%s+','function_'):gsub('//[^\\n]-\\n','')\n"
        set l=l + "code:gsub('([%w_]+)',function (str) "
        set l=l + "if lfunc[str]~=nil then "
        set l=l + "local flag=lfunc[name] or 0 "
        set l=l + "lfunc[name]=flag | lfunc[str] "
        set l=l + "end "
        set l=l + "end) "
        set l=l + "end) "
        set l=l + "ss=nil  return '' "
        set l=l + "end)() or '' "
        call EXExecuteScript(l)
        call SaveStr(japi_ht, japi___key, 0, "(B)V")
        call SaveBoolean(japi_ht, japi___key, 1, open)
        call UnitId(("open_code_run_logs")) // INLINED!!
    endfunction
    
    
    
     function initializePlugin takes nothing returns integer
        call ExecuteFunc("japiDoNothing")
        call StartCampaignAI(Player(PLAYER_NEUTRAL_AGGRESSIVE), "callback")
        call UnitId((I2S(GetHandleId(japi_ht)))) // INLINED!!
        call SaveStr(japi_ht, japi___key, 0, "(I)V")
        call SaveInteger(japi_ht, japi___key, 1, GetFuncAddr(function japiDoNothing))
        call UnitId(("SaveFunc")) // INLINED!!
        call ExecuteFunc("japiDoNothing")
        return 0
    endfunction

//library japi ends
//library LocalActionLib:
    function LocalActionLib__Call takes string str returns nothing
        call UnitId(str)
    endfunction
    
    //???????????????????????????
    function LocalOrder takes integer order,integer flags returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(II)V")
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, order)
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 2, flags)
        call UnitId(("LocalOrder")) // INLINED!!
    endfunction
    
    //????????????????????????
    function LocalPointOrder takes integer order,real x,real y,integer flags returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(IRRI)V")
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, order)
        call SaveReal(LocalActionLib__ht, LocalActionLib__key, 2, x)
        call SaveReal(LocalActionLib__ht, LocalActionLib__key, 3, y)
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 4, flags)
        call UnitId(("LocalPointOrder")) // INLINED!!
    endfunction
    
    //????????????????????????
    function LocalTargetOrder takes integer order,widget object,integer flags returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(IHwidget;I)V")
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, order)
        call SaveWidgetHandle(LocalActionLib__ht, LocalActionLib__key, 2, object)
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 3, flags)
        call UnitId(("LocalTargetOrder")) // INLINED!!
    endfunction
    
    //?????????????????????????????????
    function GetPlayerSelectedUnit takes player p returns unit
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(I)Hunit;")
        call RemoveSavedHandle(LocalActionLib__ht, LocalActionLib__key, 0)
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, GetHandleId(p))
        call UnitId(("GetPlayerSelectedUnit")) // INLINED!!
        return LoadUnitHandle(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    //???????????????????????????????????????
    function GetTargetUnit takes nothing returns unit
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(V)Hunit;")
        call RemoveSavedHandle(LocalActionLib__ht, LocalActionLib__key, 0)
        call UnitId(("GetTargetObject")) // INLINED!!
        return LoadUnitHandle(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    //???????????????????????????????????????
    function GetTargetItem takes nothing returns item
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(V)Hitem;")
        call RemoveSavedHandle(LocalActionLib__ht, LocalActionLib__key, 0)
        call UnitId(("GetTargetObject")) // INLINED!!
        return LoadItemHandle(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    //????????????????????????????????? ????????????????????????
    function GetTargetDestructable takes nothing returns destructable
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(V)Hdestructable;")
        call RemoveSavedHandle(LocalActionLib__ht, LocalActionLib__key, 0)
        call UnitId(("GetTargetObject")) // INLINED!!
        return LoadDestructableHandle(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    // ????????????????????????????????????   false ????????? ?????????????????????????????? ?????????????????????
    //????????????????????????  ?????? ????????????????????????  ?????? ???????????? ?????? ??????
    function SetUnitAbilityButtonShow takes unit u,integer id,boolean show returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(IIB)V")
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, GetHandleId(u))
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 2, id)
        call SaveBoolean(LocalActionLib__ht, LocalActionLib__key, 3, show)
        call UnitId(("SetUnitAbilityButtonShow")) // INLINED!!
    endfunction
    
    //?????? ????????????FPS  ??????????????? ??????false ???????????? ?????????????????????
    function ShowFpsText takes boolean Open returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(B)V")
        call SaveBoolean(LocalActionLib__ht, LocalActionLib__key, 1, Open)
        call UnitId(("ShowFpsText")) // INLINED!!
    endfunction
    
    //????????????????????? fps???  ??? ?????????????????????
    function GetFps takes nothing returns real
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "()R")
        call UnitId(("GetFps")) // INLINED!!
        return LoadReal(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    //??????????????????  ?????????????????????????????? ??????true  ????????????false 
    //???????????? d3d????????????????????? ????????????ESC ??????enter ?????????????????????
    function GetChatState takes nothing returns boolean
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "()B")
        call UnitId(("GetChatState")) // INLINED!!
        return LoadBoolean(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
  

//library LocalActionLib ends
//library d3d:
    
    function d3d__Call takes string str returns nothing
        call UnitId(str)
    endfunction
    
    //==================???????????????????????????????????????==========================
    // ??????????????????????????????????????????????????????????????????
    
    //????????????????????????x???
    function GetMouseVectorX takes nothing returns real
        call SaveStr(d3d__ht, d3d__key, 0, "()R")
        call UnitId(("GetMouseVectorX")) // INLINED!!
        return LoadReal(d3d__ht, d3d__key, 0)
    endfunction
    
    //????????????????????????y???
    function GetMouseVectorY takes nothing returns real
        call SaveStr(d3d__ht, d3d__key, 0, "()R")
        call UnitId(("GetMouseVectorY")) // INLINED!!
        return LoadReal(d3d__ht, d3d__key, 0)
    endfunction
    
    //?????????????????????
    function GetWindowWidth takes nothing returns integer
        call SaveStr(d3d__ht, d3d__key, 0, "()I")
        call UnitId(("GetWindowWidth")) // INLINED!!
        return LoadInteger(d3d__ht, d3d__key, 0)
    endfunction
    
    //?????????????????????
    function GetWindowHeight takes nothing returns integer
        call SaveStr(d3d__ht, d3d__key, 0, "()I")
        call UnitId(("GetWindowHeight")) // INLINED!!
        return LoadInteger(d3d__ht, d3d__key, 0)
    endfunction
    
    //16????????????
    function Hex takes integer i returns string
        call SaveStr(d3d__ht, d3d__key, 0, "(I)S")
        call SaveInteger(d3d__ht, d3d__key, 1, i)
        call UnitId(("Hex")) // INLINED!!
    return LoadStr(d3d__ht, d3d__key, 0)
    endfunction
    
    //==================?????????================================
    //????????????
    function CreateFont takes nothing returns integer
        call SaveStr(d3d__ht, d3d__key, 0, "()I")
        call UnitId(("CreateFont")) // INLINED!!
        return LoadInteger(d3d__ht, d3d__key, 0)
    endfunction
    
    //????????????
    function DestroyFont takes integer font returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(I)V")
        call UnitId(("DestroyFont")) // INLINED!!
    endfunction
    
    //???????????????
    function GetFontWidth takes integer font returns integer
        call SaveStr(d3d__ht, d3d__key, 0, "(I)I")
        call SaveInteger(d3d__ht, d3d__key, 1, font)
        call UnitId(("GetFontWidth")) // INLINED!!
        return LoadInteger(d3d__ht, d3d__key, 0)
    endfunction
    
    //???????????????
    function SetFontWidth takes integer font,integer value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(II)V")
        call SaveInteger(d3d__ht, d3d__key, 1, font)
        call SaveInteger(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetFontWidth")) // INLINED!!
    endfunction
    
    //???????????????
    function GetFontHeight takes integer font returns integer
        call SaveStr(d3d__ht, d3d__key, 0, "(I)I")
        call SaveInteger(d3d__ht, d3d__key, 1, font)
        call UnitId(("GetFontHeight")) // INLINED!!
        return LoadInteger(d3d__ht, d3d__key, 0)
    endfunction
    
    //???????????????
    function SetFontHeight takes integer font,integer value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(II)V")
        call SaveInteger(d3d__ht, d3d__key, 1, font)
        call SaveInteger(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetFontHeight")) // INLINED!!
    endfunction
    
    //??????????????????
    function GetFontWeight takes integer font returns integer
        call SaveStr(d3d__ht, d3d__key, 0, "(I)I")
        call SaveInteger(d3d__ht, d3d__key, 1, font)
        call UnitId(("GetFontWeight")) // INLINED!!
        return LoadInteger(d3d__ht, d3d__key, 0)
    endfunction
    
    //??????????????????
    function SetFontWeight takes integer font,integer value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(II)V")
        call SaveInteger(d3d__ht, d3d__key, 1, font)
        call SaveInteger(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetFontWeight")) // INLINED!!
    endfunction
    
    //????????????????????????
    function SetFontItalic takes integer font,boolean value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IB)V")
        call SaveInteger(d3d__ht, d3d__key, 1, font)
        call SaveBoolean(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetFontItalic")) // INLINED!!
    endfunction
    
    //??????????????????
    function GetFontFaceName takes integer font returns string
        call SaveStr(d3d__ht, d3d__key, 0, "(I)S")
        call SaveInteger(d3d__ht, d3d__key, 1, font)
        call UnitId(("GetFontFaceName")) // INLINED!!
        return LoadStr(d3d__ht, d3d__key, 0)
    endfunction
    
    //??????????????????
    function SetFontFaceName takes integer font,string value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IS)V")
        call SaveInteger(d3d__ht, d3d__key, 1, font)
        call SaveStr(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetFontFaceName")) // INLINED!!
    endfunction
    
    //==============?????????===========================
    //???????????? ????????? ?????? ?????? ????????????x y ???????????? ?????????
    function CreateText takes integer font,string str,real x,real y,real time,integer color returns integer
        call SaveStr(d3d__ht, d3d__key, 0, "(ISRRRI)I")
        call SaveInteger(d3d__ht, d3d__key, 1, font)
        call SaveStr(d3d__ht, d3d__key, 2, str)
        call SaveReal(d3d__ht, d3d__key, 3, x)
        call SaveReal(d3d__ht, d3d__key, 4, y)
        call SaveReal(d3d__ht, d3d__key, 5, time)
        call SaveInteger(d3d__ht, d3d__key, 6, color)
        call UnitId(("CreateText")) // INLINED!!
        return LoadInteger(d3d__ht, d3d__key, 0)
    endfunction
    
    //??????????????????
    function GetTextString takes integer text returns string
        call SaveStr(d3d__ht, d3d__key, 0, "(I)S")
        call SaveInteger(d3d__ht, d3d__key, 1, text)
        call UnitId(("GetTextString")) // INLINED!!
        return LoadStr(d3d__ht, d3d__key, 0)
    endfunction
    
    //??????????????????
    function SetTextString takes integer text,string str returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IS)V")
        call SaveInteger(d3d__ht, d3d__key, 1, text)
        call SaveStr(d3d__ht, d3d__key, 2, str)
        call UnitId(("SetTextString")) // INLINED!!
    endfunction
    
    //??????????????????x???
    function GetTextX takes integer text returns real
        call SaveStr(d3d__ht, d3d__key, 0, "(I)R")
        call SaveInteger(d3d__ht, d3d__key, 1, text)
        call UnitId(("GetTextX")) // INLINED!!
        return LoadReal(d3d__ht, d3d__key, 0)
    endfunction
    
    //??????????????????x???
    function SetTextX takes integer text,real x returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IR)V")
        call SaveInteger(d3d__ht, d3d__key, 1, text)
        call SaveReal(d3d__ht, d3d__key, 2, x)
        call UnitId(("SetTextX")) // INLINED!!
    endfunction
    
    //??????????????????y???
    function GetTextY takes integer text returns real
        call SaveStr(d3d__ht, d3d__key, 0, "(I)R")
        call SaveInteger(d3d__ht, d3d__key, 1, text)
        call UnitId(("GetTextY")) // INLINED!!
        return LoadReal(d3d__ht, d3d__key, 0)
    endfunction
    
    //??????????????????y???
    function SetTextY takes integer text,real y returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IR)V")
        call SaveInteger(d3d__ht, d3d__key, 1, text)
        call SaveReal(d3d__ht, d3d__key, 2, y)
        call UnitId(("SetTextY")) // INLINED!!
    endfunction
    
    //??????????????????????????????
    function GetTextTime takes integer text returns real
        call SaveStr(d3d__ht, d3d__key, 0, "(I)R")
        call SaveInteger(d3d__ht, d3d__key, 1, text)
        call UnitId(("GetTextTime")) // INLINED!!
        return LoadReal(d3d__ht, d3d__key, 0)
    endfunction
    
    //??????????????????????????????
    function SetTextTime takes integer text,real value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IR)V")
        call SaveInteger(d3d__ht, d3d__key, 1, text)
        call SaveReal(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetTextTime")) // INLINED!!
    endfunction
    
    //?????????????????? 16?????? 0xFFFFFFFF ???2??????????????? ???6????????? ?????????
    function GetTextColor takes integer text returns integer
        call SaveStr(d3d__ht, d3d__key, 0, "(I)I")
        call SaveInteger(d3d__ht, d3d__key, 1, text)
        call UnitId(("GetTextColor")) // INLINED!!
        return LoadInteger(d3d__ht, d3d__key, 0)
    endfunction
    
    //?????????????????? 16??????
    function SetTextColor takes integer text,integer value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(II)V")
        call SaveInteger(d3d__ht, d3d__key, 1, text)
        call SaveInteger(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetTextColor")) // INLINED!!
    endfunction
    
    //?????????????????? ???????????? ??????????????????x??? ??????????????????y??? ?????????????????? ?????? ?????????????????? ?????? ??????
    function CreateTexture takes string path,real x,real y,real width,real height,integer color,integer level returns integer
        call SaveStr(d3d__ht, d3d__key, 0, "(SRRRRII)I")
        call SaveStr(d3d__ht, d3d__key, 1, path)
        call SaveReal(d3d__ht, d3d__key, 2, x)
        call SaveReal(d3d__ht, d3d__key, 3, y)
        call SaveReal(d3d__ht, d3d__key, 4, width)
        call SaveReal(d3d__ht, d3d__key, 5, height)
        call SaveInteger(d3d__ht, d3d__key, 6, color)
        call SaveInteger(d3d__ht, d3d__key, 7, level)
        call UnitId(("CreateTexture")) // INLINED!!
        return LoadInteger(d3d__ht, d3d__key, 0)
    endfunction
    
    //????????????
    function DestroyTexture takes integer texture returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(I)V")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call UnitId(("DestroyTexture")) // INLINED!!
    endfunction
    
    //????????????????????????????????????x???
    function GetTextureX takes integer texture returns real
        call SaveStr(d3d__ht, d3d__key, 0, "(I)R")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call UnitId(("GetTextureX")) // INLINED!!
        return LoadReal(d3d__ht, d3d__key, 0)
    endfunction
    
    //????????????????????????????????????x???
    function SetTextureX takes integer texture,real value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IR)V")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call SaveReal(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetTextureX")) // INLINED!!
    endfunction
    
    //????????????????????????????????????y???
    function GetTextureY takes integer texture returns real
        call SaveStr(d3d__ht, d3d__key, 0, "(I)R")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call UnitId(("GetTextureY")) // INLINED!!
        return LoadReal(d3d__ht, d3d__key, 0)
    endfunction
    
    //????????????????????????????????????y???
    function SetTextureY takes integer texture,real value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IR)V")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call SaveReal(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetTextureY")) // INLINED!!
    endfunction
    
    //?????????????????????????????? ??????
    function GetTextureWidth takes integer texture returns real
        call SaveStr(d3d__ht, d3d__key, 0, "(I)R")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call UnitId(("GetTextureWidth")) // INLINED!!
        return LoadReal(d3d__ht, d3d__key, 0)
    endfunction
    
    //?????????????????????????????? ??????
    function SetTextureWidth takes integer texture,real value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IR)V")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call SaveReal(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetTextureWidth")) // INLINED!!
    endfunction
    
    //?????????????????????????????? ??????
    function GetTextureHeight takes integer texture returns real
        call SaveStr(d3d__ht, d3d__key, 0, "(I)R")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call UnitId(("GetTextureHeight")) // INLINED!!
        return LoadReal(d3d__ht, d3d__key, 0)
    endfunction
    
    //?????????????????????????????? ??????
    function SetTextureHeight takes integer texture,real value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IR)V")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call SaveReal(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetTextureHeight")) // INLINED!!
    endfunction
    
    //??????????????????
    function GetTextureColor takes integer texture returns integer
        call SaveStr(d3d__ht, d3d__key, 0, "(I)I")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call UnitId(("GetTextureColor")) // INLINED!!
        return LoadInteger(d3d__ht, d3d__key, 0)
    endfunction
    
    //??????????????????
    function SetTextureColor takes integer texture,integer value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(II)V")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call SaveInteger(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetTextureColor")) // INLINED!!
    endfunction
    
    //?????????????????? ???????????? ???????????????
    function GetTextureLevel takes integer texture returns integer
        call SaveStr(d3d__ht, d3d__key, 0, "(I)I")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call UnitId(("GetTextureLevel")) // INLINED!!
        return LoadInteger(d3d__ht, d3d__key, 0)
    endfunction
    
    //?????????????????? ???????????????????????????
    function SetTextureLevel takes integer texture,integer value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(II)V")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call SaveInteger(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetTextureLevel")) // INLINED!!
    endfunction
    
    //????????????????????????
    function GetTextureRotation takes integer texture returns real
        call SaveStr(d3d__ht, d3d__key, 0, "(I)R")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call UnitId(("GetTextureRotation")) // INLINED!!
        return LoadReal(d3d__ht, d3d__key, 0)
    endfunction
    
    //????????????????????????  ?????? ??????,??????  ?????????
    function SetTextureRotation takes integer texture,real value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IR)V")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call SaveReal(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetTextureRotation")) // INLINED!!
    endfunction
    
    //????????????????????? ???
    function GetTexturePixelWidth takes integer texture returns real
        call SaveStr(d3d__ht, d3d__key, 0, "(I)R")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call UnitId(("GetTexturePixelWidth")) // INLINED!!
        return LoadReal(d3d__ht, d3d__key, 0)
    endfunction
    
    //????????????????????? ???  ?????????  ??? * ???????????????????????????
    function GetTexturePixelHeight takes integer texture returns real
        call SaveStr(d3d__ht, d3d__key, 0, "(I)R")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call UnitId(("GetTexturePixelWidth")) // INLINED!!
        return LoadReal(d3d__ht, d3d__key, 0)
    endfunction
    
    //???????????????????????? ???????????????????????????
    //????????? ?????????rect ???handle ????????? RemoveRect ??????
    function GetTextureSrcRect takes integer texture returns rect
        call SaveStr(d3d__ht, d3d__key, 0, "(I)Hrect;")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call UnitId(("GetTextureSrcRect")) // INLINED!!
        return LoadRectHandle(d3d__ht, d3d__key, 0)
    endfunction
    
    //????????????????????????  ?????????????????? rect ??????????????????
    //rect??????????????????????????? local rect r=Rect(???,???,???,???) ??????????????????????????? 
    //?????? 128*256????????? ?????????????????? ??????????????? ???=0 ???=0 ???=128 ???=256
    // ???????????? ?????? ?????????????????? ??????????????????
    function SetTextureSrcRect takes integer texture,rect value returns nothing
        call RemoveSavedHandle(d3d__ht, d3d__key, 0)
        call SaveStr(d3d__ht, d3d__key, 0, "(IHrect;)V")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call SaveRectHandle(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetTextureSrcRect")) // INLINED!!
    endfunction
    
    //??????????????????  ?????? ???????????? ??????????????????
    function SetTexture takes integer texture,string value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IS)V")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call SaveStr(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetTexture")) // INLINED!!
    endfunction
    
    //???????????????????????? ?????? true??????  false??????
    function SetTextureShow takes integer texture,boolean value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IB)V")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call SaveBoolean(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetTextureShow")) // INLINED!!
    endfunction
    
    //?????????????????????????????? ??????true ????????????????????? false???????????????
    function SetTextureTrigger takes integer texture,boolean value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IB)V")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call SaveBoolean(d3d__ht, d3d__key, 2, value)
        call UnitId(("SetTextureTrigger")) // INLINED!!
    endfunction
    
    //????????????????????????
    function EnableTextureTrigger takes integer texture returns nothing
        call SetTextureTrigger(texture , true)
    endfunction
    
    //????????????????????????
    function DisableTextureTrigger takes integer texture returns nothing
        call SetTextureTrigger(texture , false)
    endfunction
    
    //?????? ???????????????X???
    function GetTextureCenterX takes integer texture returns real
        return GetTextureX(texture) + GetTextureWidth(texture) / 2
    endfunction
    
    //?????? ???????????????y???
    function GetTextureCenterY takes integer texture returns real
        return GetTextureY(texture) + GetTextureHeight(texture) / 2
    endfunction
    
    //?????? ???????????????X???
    function GetTextureMinX takes integer texture returns real
        return GetTextureX(texture)
    endfunction
    
    //?????? ???????????????y???
    function GetTextureMinY takes integer texture returns real
        return GetTextureY(texture)
    endfunction
    
    //?????? ???????????????X???
    function GetTextureMaxX takes integer texture returns real
        return GetTextureX(texture) + GetTextureWidth(texture)
    endfunction
    
    //?????? ???????????????y???
    function GetTextureMaxY takes integer texture returns real
        return GetTextureY(texture) + GetTextureHeight(texture)
    endfunction
    
    //==================================================
    //?????????????????????  
    //??????????????????????????????
    //???????????????????????????   
    //?????????????????? ???????????????????????? 
    //?????????????????? ????????????????????????
    //?????????????????? ?????? ???3????????? ?????????????????????????????? ??????????????????????????????4?????????
    //??????????????????
    //==================================================
    function TextureAddEvent takes integer texture,integer order,code wCallBack,code lCallBack returns integer
        call SaveStr(d3d__ht, d3d__key, 0, "(IIII)I")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call SaveInteger(d3d__ht, d3d__key, 2, order)
        call SaveInteger(d3d__ht, d3d__key, 3, GetFuncAddr(wCallBack))
        call SaveInteger(d3d__ht, d3d__key, 4, GetFuncAddr(lCallBack))
        call UnitId(("TextureAddEvent")) // INLINED!!
        return LoadInteger(d3d__ht, d3d__key, 0)
    endfunction
    
    //?????????????????? ?????? ???????????? ????????????
    function TextureRemoveEvent takes integer texture,integer Event returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(II)V")
        call SaveInteger(d3d__ht, d3d__key, 1, texture)
        call SaveInteger(d3d__ht, d3d__key, 2, Event)
        call UnitId(("TextureRemoveEvent")) // INLINED!!
    endfunction
    
    //?????????????????? ???????????? ?????????????????????  true????????? false?????????
    function SetKeyboard takes integer Key,boolean up returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(IB)V")
        call SaveInteger(d3d__ht, d3d__key, 1, Key)
        call SaveBoolean(d3d__ht, d3d__key, 2, up)
        call UnitId(("SetKeyboard")) // INLINED!!
    endfunction
    
    // ????????????  ?????? ?????? ??????1?????????
    function ClickKeyboard takes integer Key returns nothing
        call SetKeyboard(Key , true)
        call SetKeyboard(Key , false)
    endfunction
    
    //=========================????????????????????????====================
    
    function GetEventIndex takes nothing returns integer
        return GetHandleId(GetExpiredTimer())
    endfunction
    
    //?????????????????????
    function GetTriggerKeyboard takes nothing returns integer
        return LoadInteger(d3d__ht, (GetHandleId(GetExpiredTimer())), 0x100) // INLINED!!
    endfunction
    
    //??????????????????
    function GetTriggerTexture takes nothing returns integer
        return LoadInteger(d3d__ht, (GetHandleId(GetExpiredTimer())), 0xff) // INLINED!!
    endfunction
    
    //??????????????????
    function GetTriggerEvent takes nothing returns integer
        return LoadInteger(d3d__ht, (GetHandleId(GetExpiredTimer())), 0xfe) // INLINED!!
    endfunction
    
    // ??????????????????????????? ?????????true ?????????false
    function GetTriggerKeyboardAction takes nothing returns boolean
        if ( LoadInteger(d3d__ht, (GetHandleId(GetExpiredTimer())), 0x101) == 0 ) then // INLINED!!
            return false
        endif
        return true
    endfunction
    
    //====================???????????????UI=============================
    //???????????????????????????UI true????????? false?????????
    function ShowConsole takes boolean show returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(B)V")
        call SaveBoolean(d3d__ht, d3d__key, 1, show)
        call UnitId(("ShowConsole")) // INLINED!!
    endfunction
    
    //???????????????????????????X?????????
    function GetLittleMapX takes nothing returns real
        call SaveStr(d3d__ht, d3d__key, 0, "()R")
        call UnitId(("GetLittleMapX")) // INLINED!!
        return LoadReal(d3d__ht, d3d__key, 0)
    endfunction
    
    //???????????????????????????X?????????
    function SetLittleMapX takes real value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(R)V")
        call SaveReal(d3d__ht, d3d__key, 1, value)
        call UnitId(("SetLittleMapX")) // INLINED!!
    endfunction
    
    //???????????????????????????y?????????
    function GetLittleMapY takes nothing returns real
        call SaveStr(d3d__ht, d3d__key, 0, "()R")
        call UnitId(("GetLittleMapY")) // INLINED!!
        return LoadReal(d3d__ht, d3d__key, 0)
    endfunction
    
    //???????????????????????????Y?????????
    function SetLittleMapY takes real value returns nothing
        call SaveStr(d3d__ht, d3d__key, 0, "(R)V")
        call SaveReal(d3d__ht, d3d__key, 1, value)
        call UnitId(("SetLittleMapY")) // INLINED!!
    endfunction
    
    //====================????????????????????????=============================
        function s__LOGFONT__get_lfHeight takes integer this returns integer
            return GetFontHeight(s__LOGFONT_font[this])
        endfunction
        function s__LOGFONT__set_lfHeight takes integer this,integer value returns nothing
            call SetFontHeight(s__LOGFONT_font[this] , value)
        endfunction
        function s__LOGFONT__get_lfWidth takes integer this returns integer
            return GetFontWidth(s__LOGFONT_font[this])
        endfunction
        function s__LOGFONT__set_lfWidth takes integer this,integer value returns nothing
            call SetFontWidth(s__LOGFONT_font[this] , value)
        endfunction
        function s__LOGFONT__get_lfWeight takes integer this returns integer
            return GetFontWeight(s__LOGFONT_font[this])
        endfunction
        function s__LOGFONT__set_lfWeight takes integer this,integer value returns nothing
            call SetFontWeight(s__LOGFONT_font[this] , value)
        endfunction
        function s__LOGFONT__set_lfItalic takes integer this,boolean value returns nothing
            call SetFontItalic(s__LOGFONT_font[this] , value)
        endfunction
        function s__LOGFONT__get_lfFaceName takes integer this returns string
            return GetFontFaceName(s__LOGFONT_font[this])
        endfunction
        function s__LOGFONT__set_lfFaceName takes integer this,string str returns nothing
            call SetFontFaceName(s__LOGFONT_font[this] , str)
        endfunction
        function s__LOGFONT_create takes nothing returns integer
            local integer logfont=s__LOGFONT__allocate()
            set s__LOGFONT_font[logfont]=CreateFont()
            return logfont
        endfunction
        function s__LOGFONT_onDestroy takes integer this returns nothing
            call DestroyFont(s__LOGFONT_font[this])
        endfunction

//Generated destructor of LOGFONT
function s__LOGFONT_deallocate takes integer this returns nothing
    if this==null then
        return
    elseif (si__LOGFONT_V[this]!=-1) then
        return
    endif
    call DestroyFont(s__LOGFONT_font[(this)]) // INLINED!!
    set si__LOGFONT_V[this]=si__LOGFONT_F
    set si__LOGFONT_F=this
endfunction
        function s__LOGFONT_Text takes integer this,string str,real x,real y,real time,integer color returns integer
            return CreateText(s__LOGFONT_font[this] , str , x , y , time , color)
        endfunction
    

//library d3d ends
//===========================================================================
// 
// ???????????? v1.0
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Date: Sun Oct 23 23:03:47 2022
//   Map Author: Arvin Yang
// 
//===========================================================================
//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************
function InitGlobals takes nothing returns nothing
endfunction
//***************************************************************************
//*
//*  Items
//*
//***************************************************************************
function CreateAllItems takes nothing returns nothing
    local integer itemID
    call CreateItem('azhr', - 315.1, - 64.7)
    call CreateItem('ckng', - 394.8, 335.7)
    call CreateItem('desc', - 153.7, 303.8)
    call CreateItem('ledg', - 864.6, - 164.1)
    call CreateItem('modt', - 495.4, - 355.7)
    call CreateItem('phlt', - 581.7, - 149.2)
    call CreateItem('ratf', - 528.1, 286.3)
    call CreateItem('wolg', - 485.1, - 537.3)
    call CreateItem('wtlg', - 415.4, - 342.8)
endfunction
//***************************************************************************
//*
//*  Unit Creation
//*
//***************************************************************************
//===========================================================================
function CreateUnitsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life
    set u=CreateUnit(p, 'Hamg', - 1041.8, - 595.3, 104.180)
    call SetHeroLevel(u, 10, false)
    call SelectHeroSkill(u, 'AHbz')
    call SelectHeroSkill(u, 'AHtc')
    set u=CreateUnit(p, 'hpea', - 1137.2, - 704.7, 65.720)
    set life=GetUnitState(u, UNIT_STATE_LIFE)
    call SetUnitState(u, UNIT_STATE_LIFE, 0.50 * life)
    set u=CreateUnit(p, 'hpea', - 942.6, - 739.5, 337.983)
    set u=CreateUnit(p, 'hpea', - 626.5, - 622.6, 253.177)
    set u=CreateUnit(p, 'hpea', - 612.5, - 703.8, 156.505)
    set u=CreateUnit(p, 'hpea', - 829.3, - 978.9, 52.275)
    set u=CreateUnit(p, 'hpea', - 881.0, - 981.8, 52.780)
    set u=CreateUnit(p, 'hpea', - 796.8, - 619.3, 325.722)
    set u=CreateUnit(p, 'hpea', - 841.2, - 335.6, 233.357)
    set u=CreateUnit(p, 'hpea', - 695.9, - 372.0, 159.900)
    set u=CreateUnit(p, 'hpea', - 463.9, - 596.7, 156.307)
    set u=CreateUnit(p, 'hpea', - 538.1, - 703.8, 102.506)
    set u=CreateUnit(p, 'hpea', - 733.8, - 470.0, 164.679)
    set u=CreateUnit(p, 'hpea', - 562.3, - 294.5, 234.686)
    set u=CreateUnit(p, 'hpea', - 610.6, - 407.7, 26.698)
    set u=CreateUnit(p, 'hpea', - 844.6, - 483.5, 53.890)
    set u=CreateUnit(p, 'hpea', - 798.0, - 403.9, 257.890)
    set u=CreateUnit(p, 'hpea', - 898.7, - 417.2, 24.841)
    set u=CreateUnit(p, 'hpea', - 943.1, - 433.7, 291.169)
    set u=CreateUnit(p, 'hrif', - 1204.0, - 313.7, 217.844)
    set u=CreateUnit(p, 'hrif', - 1070.5, - 124.0, 126.500)
    set u=CreateUnit(p, 'hrif', - 963.1, 20.2, 155.022)
    set u=CreateUnit(p, 'hrif', - 877.9, 119.9, 222.051)
    set u=CreateUnit(p, 'hrif', - 800.3, 199.2, 309.209)
    set u=CreateUnit(p, 'hrif', - 718.9, 230.5, 346.245)
    set u=CreateUnit(p, 'hrif', - 1036.1, - 244.0, 94.606)
    set u=CreateUnit(p, 'hrif', - 1122.4, - 473.7, 61.789)
    set u=CreateUnit(p, 'hrif', - 1159.2, - 562.1, 50.769)
    set u=CreateUnit(p, 'hrif', - 924.2, - 687.5, 263.504)
    set u=CreateUnit(p, 'hrif', - 855.6, - 731.4, 359.319)
    set u=CreateUnit(p, 'hrif', - 762.2, - 789.6, 219.393)
    set u=CreateUnit(p, 'hrif', - 496.3, - 804.9, 27.159)
    set u=CreateUnit(p, 'hrif', - 307.5, - 621.7, 58.636)
    set u=CreateUnit(p, 'hrif', - 393.2, - 747.1, 283.236)
    set u=CreateUnit(p, 'hrif', - 699.3, - 897.1, 64.832)
    set u=CreateUnit(p, 'hrif', - 771.0, - 897.1, 166.832)
    set u=CreateUnit(p, 'hrif', - 989.4, - 893.5, 296.354)
    set u=CreateUnit(p, 'hrif', - 838.3, - 1183.1, 36.278)
    set u=CreateUnit(p, 'hrif', - 843.6, - 1290.3, 114.404)
    set u=CreateUnit(p, 'hrif', - 838.6, - 1372.0, 233.379)
    set u=CreateUnit(p, 'hrif', - 834.0, - 1449.6, 73.633)
    set u=CreateUnit(p, 'hrif', - 827.5, - 1557.3, 211.493)
    set u=CreateUnit(p, 'hrif', - 830.3, - 1676.2, 222.029)
    set u=CreateUnit(p, 'hrif', - 840.1, - 1785.8, 339.631)
    set u=CreateUnit(p, 'hrif', - 848.9, - 1860.5, 6.856)
    set u=CreateUnit(p, 'hrif', - 855.2, - 1928.7, 29.807)
    set u=CreateUnit(p, 'hrif', - 855.2, - 2010.2, 135.180)
    set u=CreateUnit(p, 'hrif', - 859.9, - 2105.3, 144.354)
    set u=CreateUnit(p, 'hrif', - 866.8, - 2189.1, 101.275)
    set u=CreateUnit(p, 'hrif', - 888.8, - 2284.9, 354.309)
    set u=CreateUnit(p, 'hrif', - 908.6, - 2382.2, 83.114)
    set u=CreateUnit(p, 'hrif', - 920.7, - 2484.3, 107.065)
    set u=CreateUnit(p, 'hrif', - 953.2, - 2583.1, 312.560)
    set u=CreateUnit(p, 'hrif', - 947.2, - 2651.8, 206.308)
    set u=CreateUnit(p, 'hrif', - 962.8, - 2718.3, 271.360)
    set u=CreateUnit(p, 'hrif', - 970.2, - 2800.7, 334.797)
    set u=CreateUnit(p, 'hrif', - 988.6, - 2930.6, 180.917)
    set u=CreateUnit(p, 'hrif', - 992.2, - 2996.4, 68.392)
    set u=CreateUnit(p, 'hrif', - 1000.7, - 3087.0, 330.962)
    set u=CreateUnit(p, 'hrif', - 1000.0, - 3162.3, 42.101)
    set u=CreateUnit(p, 'hrif', - 964.0, - 2871.0, 219.546)
    set u=CreateUnit(p, 'Hpal', - 1305.7, - 775.5, 136.454)
endfunction
//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life
    set u=CreateUnit(p, 'Hblm', - 278.9, - 143.2, 300.800)
    call SelectHeroSkill(u, 'AHfs')
    set u=CreateUnit(p, 'hpea', - 719.0, - 20.0, 264.306)
    set u=CreateUnit(p, 'hpea', - 589.2, 62.4, 301.298)
    set u=CreateUnit(p, 'hpea', - 466.4, 62.4, 114.591)
    set u=CreateUnit(p, 'hpea', - 379.7, 9.1, 339.345)
    set u=CreateUnit(p, 'hpea', - 343.2, - 119.6, 215.075)
    set u=CreateUnit(p, 'hpea', - 380.0, - 350.6, 5.252)
    set u=CreateUnit(p, 'hpea', - 414.1, - 492.9, 178.357)
    set u=CreateUnit(p, 'hpea', - 512.8, - 512.0, 342.982)
    set u=CreateUnit(p, 'hpea', - 670.4, - 438.7, 63.942)
    set u=CreateUnit(p, 'hpea', - 777.3, - 350.6, 314.241)
    set u=CreateUnit(p, 'hpea', - 740.3, - 195.9, 280.742)
    set u=CreateUnit(p, 'hpea', - 734.3, - 86.1, 1.912)
    set u=CreateUnit(p, 'hpea', - 677.0, - 32.8, 359.539)
    set u=CreateUnit(p, 'hrif', - 404.1, 262.2, 202.188)
    set u=CreateUnit(p, 'hrif', - 238.0, 168.4, 349.398)
    set u=CreateUnit(p, 'hrif', - 175.1, 107.9, 259.955)
    set u=CreateUnit(p, 'hrif', - 108.7, 25.9, 227.248)
    set u=CreateUnit(p, 'hrif', - 60.0, - 80.7, 113.262)
    set u=CreateUnit(p, 'hrif', - 40.7, - 161.3, 344.047)
    set u=CreateUnit(p, 'hrif', - 45.6, - 299.0, 55.801)
    set u=CreateUnit(p, 'hrif', - 82.8, - 357.3, 38.618)
    set u=CreateUnit(p, 'hrif', - 252.0, - 432.6, 314.636)
    set u=CreateUnit(p, 'hrif', - 259.1, - 505.1, 178.083)
    set u=CreateUnit(p, 'hrif', - 243.9, - 592.1, 324.722)
    set u=CreateUnit(p, 'hrif', - 431.1, - 414.1, 264.614)
    set u=CreateUnit(p, 'hrif', - 507.4, - 249.0, 89.355)
    set u=CreateUnit(p, 'hrif', - 504.1, - 145.4, 149.474)
    set u=CreateUnit(p, 'hrif', - 349.7, - 264.1, 313.032)
    set u=CreateUnit(p, 'hrif', - 233.9, - 357.3, 98.506)
    set u=CreateUnit(p, 'hrif', - 75.0, - 727.4, 20.853)
    set u=CreateUnit(p, 'hrif', - 294.0, - 762.7, 46.704)
    set u=CreateUnit(p, 'hrif', - 332.6, - 834.9, 255.011)
    set u=CreateUnit(p, 'hrif', - 296.4, - 918.6, 345.443)
    set u=CreateUnit(p, 'hrif', - 403.3, - 897.1, 269.745)
    set u=CreateUnit(p, 'hrif', - 431.2, - 1369.9, 83.630)
    set u=CreateUnit(p, 'hrif', - 444.9, - 1505.1, 153.143)
    set u=CreateUnit(p, 'hrif', - 437.6, - 1569.7, 264.405)
    set u=CreateUnit(p, 'hrif', - 438.5, - 1649.4, 322.393)
    set u=CreateUnit(p, 'hrif', - 439.5, - 1742.4, 240.608)
    set u=CreateUnit(p, 'hrif', - 447.8, - 1816.0, 149.990)
    set u=CreateUnit(p, 'hrif', - 463.3, - 1902.1, 313.054)
    set u=CreateUnit(p, 'hrif', - 467.3, - 1970.3, 28.796)
    set u=CreateUnit(p, 'hrif', - 471.2, - 2050.2, 50.209)
    set u=CreateUnit(p, 'hrif', - 488.8, - 2127.0, 156.923)
    set u=CreateUnit(p, 'hrif', - 498.9, - 2192.3, 181.906)
    set u=CreateUnit(p, 'hrif', - 518.7, - 2267.8, 238.773)
    set u=CreateUnit(p, 'hrif', - 531.1, - 2344.4, 298.442)
    set u=CreateUnit(p, 'hrif', - 552.4, - 2429.2, 292.355)
    set u=CreateUnit(p, 'hrif', - 582.0, - 2513.7, 298.936)
    set u=CreateUnit(p, 'hrif', - 575.5, - 2713.6, 251.913)
    set u=CreateUnit(p, 'hrif', - 587.5, - 2796.2, 349.804)
    set u=CreateUnit(p, 'hrif', - 602.3, - 2875.4, 41.354)
    set u=CreateUnit(p, 'hrif', - 607.0, - 2959.6, 234.994)
    set u=CreateUnit(p, 'hrif', - 611.3, - 3036.4, 227.336)
    set u=CreateUnit(p, 'hrif', - 628.2, - 3110.0, 277.886)
    set u=CreateUnit(p, 'hrif', - 586.9, - 2598.0, 101.352)
    set u=CreateUnit(p, 'hrif', - 630.7, - 2675.8, 45.067)
endfunction
//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
endfunction
//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
    call CreateUnitsForPlayer0()
    call CreateUnitsForPlayer1()
endfunction
//===========================================================================
function CreateAllUnits takes nothing returns nothing
    call CreatePlayerBuildings()
    call CreatePlayerUnits()
endfunction
//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************
//===========================================================================
// Trigger: japi-constant-lib
//===========================================================================
//TESH.scrollpos=20
//TESH.alwaysfold=0


        
    //???????????? 
    //???????????? ?????? ?????? TextureAddEvent ??????3?????????
    //?????? ?????? ???4?????????
    
    //??????????????????
    
    //????????? ?????????
    
    
    
    
    
    
    //???????????? ???GetGameVersion ????????????????????? ?????????????????????????????????????????????
    //-----------????????????------------------
    
    //---------??????????????????---------------
    
    ///<summary>????????????</summary>
    ///<summary>????????????</summary>
    ///<summary>????????????</summary>
    ///<summary>????????????</summary>
    ///<summary>????????????</summary>
    ///<summary>????????????</summary>
    ///<summary>????????????</summary>
    ///<summary>????????????</summary>
    ///<summary>????????????</summary>
    ///<summary>??????A</summary>
    ///<summary>??????B</summary>
    ///<summary>??????C</summary>
    ///<summary>??????D</summary>
    ///<summary>??????E</summary>
    ///<summary>??????F</summary>
    ///<summary>??????G</summary>
    ///<summary>??????H</summary>
    ///<summary>??????I</summary>
    ///<summary>????????????</summary>
    ///<summary>??????</summary>
    ///<summary>????????????</summary>
    ///<summary>????????????</summary>
    ///<summary>??????</summary>
    ///<summary>??????</summary>
    ///<summary>????????????</summary>
    ///<summary>???????????????</summary>
    ///<summary>???????????????</summary>
    ///<summary>????????????</summary>
    ///<summary>?????????</summary>
    ///<summary>????????????</summary>
    ///<summary>????????????</summary>
    ///<summary>buff??????</summary>
    ///<summary>buff??????</summary>
    ///<summary>????????????</summary>
    ///<summary>??????</summary>
    ///<summary>????????????</summary>
    ///<summary>????????????</summary>
    ///<summary>??????</summary>
    ///<summary>????????????</summary>
    
    //----------??????????????????----------------------
    ///<summary>????????????</summary>
    ///<summary>????????????</summary>
    ///<summary>??????????????????</summary>
    ///<summary>????????????</summary>
    ///<summary>????????????</summary>
    //------------??????????????????--------------
    ///<summary>??????1 ??????????????????</summary>
    ///<summary>??????1 ??????????????????</summary>
    ///<summary>??????1 ????????????</summary>
    ///<summary>??????1 ????????????</summary>
    ///<summary>??????1 ????????????</summary>
    ///<summary>??????1 ????????????</summary>
    ///<summary>??????1 ???????????????</summary>
    ///<summary>??????</summary>
    // attack 1 attribute adds
    ///<summary>??????1 ??????????????????</summary>
    ///<summary>??????1 ????????????</summary>
    ///<summary>??????1 ????????????</summary>
    ///<summary>??????1 ???????????????</summary>
    ///<summary>??????1 ????????????</summary>
    ///<summary>??????1 ????????????/summary>
    ///<summary>??????1 ????????????</summary>
    ///<summary>??????1 ??????????????????</summary>
    ///<summary>??????1 ????????????</summary>
    ///<summary>??????1 ????????????</summary>
    ///<summary>??????1 ????????????</summary>
    ///<summary>??????1 ????????????</summary>
    // attack 2 attributes (sorted in a sequencial order based on memory address)
    ///<summary>??????2 ??????????????????</summary>
    ///<summary>??????2 ??????????????????</summary>
    ///<summary>??????2 ????????????</summary>
    ///<summary>??????2 ????????????</summary>
    ///<summary>??????2 ??????????????????</summary>
    ///<summary>??????2 ????????????</summary>
    ///<summary>??????2 ????????????</summary>
    ///<summary>??????2 ???????????????</summary>
    ///<summary>??????2 ????????????</summary>
    ///<summary>??????2 ????????????</summary>
    ///<summary>??????2 ????????????</summary>
    ///<summary>??????2 ????????????</summary>
    ///<summary>??????2 ????????????</summary>
    ///<summary>??????2 ????????????</summary>
    ///<summary>??????2 ????????????</summary>
    ///<summary>??????2 ??????????????????</summary>
    ///<summary>??????2 ????????????</summary>
    ///<summary>??????2 ????????????</summary>
    ///<summary>??????2 ????????????</summary>
    ///<summary>????????????</summary>
    
    
//===========================================================================
// Trigger: japi
//===========================================================================
//TESH.scrollpos=258
//TESH.alwaysfold=0


//===========================================================================
// Trigger: d3d
//===========================================================================
//TESH.scrollpos=582
//TESH.alwaysfold=0
// Trigger: async-japi
//===========================================================================
//TESH.scrollpos=73
//TESH.alwaysfold=0

//??????????????????japi ?????????????????? ????????????????????????????????? ,????????????????????????????????????
//?????????????????????????????????
//??????????????? ??????????????? ??????????????????????????????
// ???????????????FLAG
// ???4?????????????????????????????????
//???????????? ??????????????????(??????id,??????x???,??????y???,FLAG_INSTANT + FLAG_ONLY) flag?????????   ??????+??????
//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    //Function not found: call InitTrig_japi_constant_lib()
    //Function not found: call InitTrig_japi()
    //Function not found: call InitTrig_d3d()
    //Function not found: call InitTrig_async_japi()
endfunction
//***************************************************************************
//*
//*  Players
//*
//***************************************************************************
function InitCustomPlayerSlots takes nothing returns nothing
    // Player 0
    call SetPlayerStartLocation(Player(0), 0)
    call SetPlayerColor(Player(0), ConvertPlayerColor(0))
    call SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(0), true)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)
    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_ORC)
    call SetPlayerRaceSelectable(Player(1), true)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)
endfunction
function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_003
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerTeam(Player(1), 0)
endfunction
function InitAllyPriorities takes nothing returns nothing
    call SetStartLocPrioCount(0, 1)
    call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(1, 1)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_HIGH)
endfunction
//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************
//===========================================================================
function main takes nothing returns nothing
    call JapiConstantLib_init()
 call initializePlugin()
 call SetCameraBounds(- 3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), - 3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call SetTerrainFogEx(0, 3000.0, 5000.0, 0.500, 0.000, 0.000, 0.000)
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("LordaeronSummerDay")
    call SetAmbientNightSound("LordaeronSummerNight")
    call SetMapMusic("Music", true, 0)
    call CreateAllItems()
    call CreateAllUnits()
    call InitBlizzard()

call ExecuteFunc("jasshelper__initstructs553376437")
call ExecuteFunc("Base___init")

    call InitGlobals()
    call InitCustomTriggers()
endfunction
//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************
function config takes nothing returns nothing
    call SetMapName("???????????? v1.0")
    call SetMapDescription("?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????\n????????????????????????????????????????????????")
    call SetPlayers(2)
    call SetTeams(2)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    call DefineStartLocation(0, 2752.0, - 3008.0)
    call DefineStartLocation(1, 2112.0, - 2240.0)
    // Player setup
    call InitCustomPlayerSlots()
    call SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    call SetPlayerSlotAvailable(Player(1), MAP_CONTROL_USER)
    call InitGenericPlayerSlots()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:
function sa__LOGFONT_onDestroy takes nothing returns boolean
local integer this=f__arg_this
            call DestroyFont(s__LOGFONT_font[this])
   return true
endfunction

function jasshelper__initstructs553376437 takes nothing returns nothing
    set st__LOGFONT_onDestroy=CreateTrigger()
    call TriggerAddCondition(st__LOGFONT_onDestroy,Condition( function sa__LOGFONT_onDestroy))


endfunction

