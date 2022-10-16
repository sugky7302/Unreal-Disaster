library PlayerUtils
    /**************************************************************
    *
    * v1.2.4 by TriggerHappy
    *
    * This library provides a struct which caches data about players
    * as well as provides functionality for manipulating player colors.
    *
    * Constants
    *   ------------------
    *
    * force FORCE_PLAYING - Player group of everyone who is playing.
    *
    * Struct API
    *   -------------------
    * struct User
    *
    * static method fromIndex takes integer i returns User
    * static method fromLocal takes nothing returns User
    * static method fromPlaying takes integer id returns User
    *
    * static method operator []    takes integer id returns User
    * static method operator count takes nothing returns integer
    *
    * method operator name takes nothing returns string
    * method operator name = takes string name returns nothing
    * method operator color takes nothing returns playercolor
    * method operator color = takes playercolor c returns nothing
    * method operator defaultColor takes nothing returns playercolor
    * method operator hex takes nothing returns string
    * method operator nameColored takes nothing returns string
    *
    * method colorUnits takes playercolor c returns nothing
    *
    * readonly string originalName
    * readonly boolean isPlaying
    * readonly static player Local
    * readonly static integer LocalId
    * readonly static integer AmountPlaying
    * readonly static playercolor array Color
    * readonly static player array PlayingPlayer
    *
    **************************************************************/

    globals
        // automatically change unit colors when changing player color
        private constant boolean AUTO_COLOR_UNITS = true
      
        // use an array for name / color lookups (instead of function calls)
        private constant boolean ARRAY_LOOKUP = false
      
        // this only applies if ARRAY_LOOKUP is true
        private constant boolean HOOK_SAFETY = false // disable for speed, but only use the struct to change name/color safely
      
        constant force FORCE_PLAYING = CreateForce()
      
        private string array Name
        private string array Hex
        private string array OriginalHex
        private playercolor array CurrentColor
    endglobals
  
    private keyword PlayerUtilsInit
  
    struct User extends array
        
        static constant integer EMPTY = 15
        
        readonly player handle
        readonly integer id
        readonly integer next
        readonly integer prev
        readonly string originalName
        readonly boolean isPlaying
      
        readonly static player Local
        readonly static integer LocalId
        readonly static integer AmountPlaying = 0
        readonly static playercolor array Color

        static if not (LIBRARY_GroupUtils) then
            readonly static group ENUM_GROUP = CreateGroup()
        endif

        readonly static player array PlayingPlayer
        private static integer array PlayingPlayerId
        private static integer array PlayingPlayerIdIndex
      
        // same as Player(#)
        static method fromIndex takes integer i returns thistype
            return thistype(i)
        endmethod
      
        // same as GetLocalPlayer
        static method fromLocal takes nothing returns thistype
            return thistype(thistype.LocalId)
        endmethod
      
        // access active players array
        static method fromPlaying takes integer id returns thistype
            return thistype(PlayingPlayerId[id])
        endmethod
      
        static method operator [] takes player p returns thistype
            return thistype(GetPlayerId(p))
        endmethod
      
        method operator name takes nothing returns string
            static if (ARRAY_LOOKUP) then
                return Name[this]
            else
                return GetPlayerName(this.handle)
            endif
        endmethod
      
        method operator name = takes string newName returns nothing
            call SetPlayerName(this.handle, name)
            static if (ARRAY_LOOKUP) then
                static if not (HOOK_SAFETY) then
                    set Name[this] = newName
                endif
            endif
        endmethod
      
        method operator color takes nothing returns playercolor
            static if (ARRAY_LOOKUP) then
                return CurrentColor[this]
            else
                return GetPlayerColor(this.handle)
            endif
        endmethod
      
        method operator hex takes nothing returns string
            return OriginalHex[GetHandleId(this.color)]
        endmethod
      
        method operator color = takes playercolor c returns nothing
            call SetPlayerColor(this.handle, c)
          
            static if (ARRAY_LOOKUP) then
                set CurrentColor[this] = c
                static if not (HOOK_SAFETY) then
                    static if (AUTO_COLOR_UNITS) then
                        call this.colorUnits(color)
                    endif
                endif
            endif
        endmethod
      
        method operator defaultColor takes nothing returns playercolor
            return Color[this]
        endmethod
      
        method operator nameColored takes nothing returns string
            return hex + this.name + "|r"
        endmethod
      
        method colorUnits takes playercolor c returns nothing
            local unit u
          
            call GroupEnumUnitsOfPlayer(ENUM_GROUP, this.handle, null)
          
            loop
                set u = FirstOfGroup(ENUM_GROUP)
                exitwhen u == null
                call SetUnitColor(u, c)
                call GroupRemoveUnit(ENUM_GROUP, u)
            endloop
        endmethod
      
        static method onLeave takes nothing returns boolean
            local thistype p = thistype[GetTriggerPlayer()]
            local integer i = PlayingPlayerIdIndex[p.id]
          
            // clean up
            call ForceRemovePlayer(FORCE_PLAYING, thistype.PlayingPlayer[i])
          
            // recycle index
            set .AmountPlaying = .AmountPlaying - 1
            set .PlayingPlayer[i] = .PlayingPlayer[.AmountPlaying]
            set .PlayingPlayerId[i] = .PlayingPlayerId[.AmountPlaying]
            set .PlayingPlayerIdIndex[i] = .PlayingPlayerIdIndex[.AmountPlaying]

            set p.isPlaying = false
          
            return false
        endmethod
      
        implement PlayerUtilsInit
      
    endstruct
  
    private module PlayerUtilsInit
    private static method onInit takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer i = 0
        local thistype p
          
        set thistype.Local = GetLocalPlayer()
        set thistype.LocalId = GetPlayerId(thistype.Local)
          
        set OriginalHex[0] = "|cffff0303"
        set OriginalHex[1] = "|cff0042ff"
        set OriginalHex[2] = "|cff1ce6b9"
        set OriginalHex[3] = "|cff540081"
        set OriginalHex[4] = "|cfffffc01"
        set OriginalHex[5] = "|cfffe8a0e"
        set OriginalHex[6] = "|cff20c000"
        set OriginalHex[7] = "|cffe55bb0"
        set OriginalHex[8] = "|cff959697"
        set OriginalHex[9] = "|cff7ebff1"
        set OriginalHex[10] = "|cff106246"
        set OriginalHex[11] = "|cff4e2a04"
          
        loop
            exitwhen i == bj_MAX_PLAYER_SLOTS

            set p = User(i)
            set p.handle = Player(i)
            set p.id = i
            set p.next = i + 1
                
            if (i >= bj_MAX_PLAYER_SLOTS - 1) then
                set p.next = User.EMPTY
            elseif (i == 0) then
                set p.prev = User.EMPTY
            endif
              
            set thistype.Color[i] = GetPlayerColor(p.handle)
            set CurrentColor[i] = thistype.Color[i]
              
            if (GetPlayerController(p.handle) == MAP_CONTROL_USER and GetPlayerSlotState(p.handle) == PLAYER_SLOT_STATE_PLAYING) then
                set .PlayingPlayer[AmountPlaying] = p.handle
                set .PlayingPlayerId[AmountPlaying] = i
                set .PlayingPlayerIdIndex[i] = .AmountPlaying
                  
                set p.isPlaying = true
                  
                call TriggerRegisterPlayerEvent(t, p.handle, EVENT_PLAYER_LEAVE)
                call ForceAddPlayer(FORCE_PLAYING, p.handle)
                  
                set Hex[p] = OriginalHex[GetHandleId(thistype.Color[i])]
                  
                set .AmountPlaying = .AmountPlaying + 1
            endif
              
            set Name[p] = GetPlayerName(p.handle)
            set p.originalName = Name[p]
              
            set i = i + 1
        endloop
          
        call TriggerAddCondition(t, Filter(function thistype.onLeave))
    endmethod
endmodule
  
//===========================================================================

  
static if (ARRAY_LOOKUP) then
    static if (HOOK_SAFETY) then
        private function SetPlayerNameHook takes player whichPlayer, string name returns nothing
            set Name[GetPlayerId(whichPlayer)] = name
        endfunction
          
        private function SetPlayerColorHook takes player whichPlayer, playercolor color returns nothing
            local User p = User[whichPlayer]
              
            set Hex[p] = OriginalHex[GetHandleId(color)]
            set CurrentColor[p] = color
              
            static if (AUTO_COLOR_UNITS) then
                call p.colorUnits(color)
            endif
        endfunction
          
        hook SetPlayerName SetPlayerNameHook
        hook SetPlayerColor SetPlayerColorHook
    endif   
endif
  
endlibrary