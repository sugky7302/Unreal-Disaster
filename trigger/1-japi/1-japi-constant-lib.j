//TESH.scrollpos=20
//TESH.alwaysfold=0
/*

japi引用的常量庫 由於wave宏定義 只對以下的代碼有效

請將常量庫裡所有內容複製到  自定義腳本代碼區
*/



<?
    trigger_name={}
 
    function get_saved_trigger_name(str)
        trigger_variable=""
        code=""
        pos=str:find(",")
        if pos~=nil then
            trigger_variable=str:sub(1,pos-1)
            code=str:sub(pos+1,str:len())
        end
        
        name=trigger_name[trigger_variable] or ""

        if name~="" then
            return "Trigger".."AddAction("..trigger_variable..','..code
            ..')\ncall func_bind_trigger_name('..code..',"'..name..'")\n'
        else
            return "Trigger".."AddAction("..trigger_variable..','..code..')'
        end
    end
?>

#define DEBUG
#undef YDWESaveTriggerName
#define YDWESaveTriggerName_(t,n) DoNothing() <?trigger_name[t']=n?>
#define YDWESaveTriggerName(t,n) YDWESaveTriggerName_('t,n)

#define TriggerAddAction2(t,c) <?=get_saved_trigger_name(t,c')?>
#define TriggerAddAction(t,c) TriggerAddAction2('t,c)

    #define KEY_MOUSE_MOVE     0x200 //鼠標移動 進入區域運行第3個函數 離開區域運行第4個參數
    #define KEY_MOUSE_LEFT_UP      0x201 //鼠標左鍵按下  TextureAddEvent運行第3個參數
    #define KEY_MOUSE_LEFT_DOWN    0x202 //鼠標左鍵彈起  TextureAddEvent運行第4個參數
    #define KEY_MOUSE_RIGHT_UP     0x204 //鼠標右鍵按下  TextureAddEvent運行第3個參數
    #define KEY_MOUSE_RIGHT_DOWN   0x205 //鼠標右鍵彈起  TextureAddEvent運行第4個參數
        
    //鍵盤鍵位 
    //以下鍵位 按下 運行 TextureAddEvent 的第3個參數
    //彈起 運行 第4個參數
    
    //大鍵盤數字鍵
    #define KEY_0        0x30
    #define KEY_1        0x31
    #define KEY_2        0x32
    #define KEY_3        0x33
    #define KEY_4        0x34
    #define KEY_5        0x35
    #define KEY_6        0x36
    #define KEY_7        0x37
    #define KEY_8        0x38
    #define KEY_9        0x39
    
    //小鍵盤 數字鍵
    #define KEY_NUM_0         0x60
    #define KEY_NUM_1         0x61
    #define KEY_NUM_2         0x62
    #define KEY_NUM_3         0x63
    #define KEY_NUM_4         0x64
    #define KEY_NUM_5         0x65
    #define KEY_NUM_6         0x66
    #define KEY_NUM_7         0x67
    #define KEY_NUM_8         0x68
    #define KEY_NUM_9         0x69
    
    #define KEY_A        'A'
    #define KEY_B        'B'
    #define KEY_C        'C'
    #define KEY_D        'D'
    #define KEY_E        'E'
    #define KEY_F        'F'
    #define KEY_G        'G'
    #define KEY_H        'H'
    #define KEY_I        'I'
    #define KEY_J        'J'
    #define KEY_K        'K'
    #define KEY_L        'L'
    #define KEY_M        'M'
    #define KEY_N        'N'
    #define KEY_O        'O'
    #define KEY_P        'P'
    #define KEY_Q        'Q'
    #define KEY_R        'R'
    #define KEY_S        'S'
    #define KEY_T        'T'
    #define KEY_U        'U'
    #define KEY_V        'V'
    #define KEY_W        'W'
    #define KEY_X        'X'
    #define KEY_Y        'Y'
    #define KEY_Z        'Z'
    
    #define KEY_F1            0x70
    #define KEY_F2            0x71
    #define KEY_F3            0x72
    #define KEY_F4            0x73
    #define KEY_F5            0x74
    #define KEY_F6            0x75
    #define KEY_F7            0x76
    #define KEY_F8            0x77
    #define KEY_F9            0x78
    #define KEY_F10           0x79
    #define KEY_F11           0x7a
    #define KEY_F12           0x7b
    
    
    #define KEY_TAB           0x9
    #define KEY_ENTER         0xd //迴車鍵
    #define KEY_SHLFT         0x10
    #define KEY_CTRL          0x11
    #define KEY_ALT           0x12
    #define KEY_ESC           0x1b
    #define KEY_SPACE         0x20 //空格鍵
    
    #define KEY_SLASH         0xbf // 正斜槓 \\ 
    #define KEY_BACKSLASH     0xdc //反斜槓 //
    
    //魔獸版本 用GetGameVersion 來獲取當前版本 來對比以下具體版本做出相應操作
    #define version_124b   6374
    #define version_124e   6387
    #define version_126    6401  
    #define version_127a   7000
    #define version_127b   7085
    #define version_128a   7205

    //-----------模擬聊天------------------
    #define CHAT_RECIPIENT_ALL    0    // [所有人]
    #define CHAT_RECIPIENT_ALLIES      1    // [盟友]
    #define CHAT_RECIPIENT_OBSERVERS   2    // [觀看者]
    #define CHAT_RECIPIENT_REFEREES    2    // [裁判]
    #define CHAT_RECIPIENT_PRIVATE     3    // [私人的]
    
    //---------技能數據類型---------------
    
    ///<summary>冷卻時間</summary>
    #define ABILITY_STATE_COOLDOWN 1

    ///<summary>目標允許</summary>
    #define ABILITY_DATA_TARGS 100

    ///<summary>施放時間</summary>
    #define ABILITY_DATA_CAST 101

    ///<summary>持續時間</summary>
    #define ABILITY_DATA_DUR 102

    ///<summary>持續時間</summary>
    #define ABILITY_DATA_HERODUR 103

    ///<summary>魔法消耗</summary>
    #define ABILITY_DATA_COST 104

    ///<summary>施放間隔</summary>
    #define ABILITY_DATA_COOL 105

    ///<summary>影響區域</summary>
    #define ABILITY_DATA_AREA 106

    ///<summary>施法距離</summary>
    #define ABILITY_DATA_RNG 107

    ///<summary>數據A</summary>
    #define ABILITY_DATA_DATA_A 108

    ///<summary>數據B</summary>
    #define ABILITY_DATA_DATA_B 109

    ///<summary>數據C</summary>
    #define ABILITY_DATA_DATA_C 110

    ///<summary>數據D</summary>
    #define ABILITY_DATA_DATA_D 111

    ///<summary>數據E</summary>
    #define ABILITY_DATA_DATA_E 112

    ///<summary>數據F</summary>
    #define ABILITY_DATA_DATA_F 113

    ///<summary>數據G</summary>
    #define ABILITY_DATA_DATA_G 114

    ///<summary>數據H</summary>
    #define ABILITY_DATA_DATA_H 115

    ///<summary>數據I</summary>
    #define ABILITY_DATA_DATA_I 116

    ///<summary>單位類型</summary>
    #define ABILITY_DATA_UNITID 117

    ///<summary>熱鍵</summary>
    #define ABILITY_DATA_HOTKET 200

    ///<summary>關閉熱鍵</summary>
    #define ABILITY_DATA_UNHOTKET 201

    ///<summary>學習熱鍵</summary>
    #define ABILITY_DATA_RESEARCH_HOTKEY 202

    ///<summary>名字</summary>
    #define ABILITY_DATA_NAME 203

    ///<summary>圖標</summary>
    #define ABILITY_DATA_ART 204

    ///<summary>目標效果</summary>
    #define ABILITY_DATA_TARGET_ART 205

    ///<summary>施法者效果</summary>
    #define ABILITY_DATA_CASTER_ART 206

    ///<summary>目標點效果</summary>
    #define ABILITY_DATA_EFFECT_ART 207

    ///<summary>區域效果</summary>
    #define ABILITY_DATA_AREAEFFECT_ART 208

    ///<summary>投射物</summary>
    #define ABILITY_DATA_MISSILE_ART 209

    ///<summary>特殊效果</summary>
    #define ABILITY_DATA_SPECIAL_ART 210

    ///<summary>閃電效果</summary>
    #define ABILITY_DATA_LIGHTNING_EFFECT 211

    ///<summary>buff提示</summary>
    #define ABILITY_DATA_BUFF_TIP 212

    ///<summary>buff提示</summary>
    #define ABILITY_DATA_BUFF_UBERTIP 213

    ///<summary>學習提示</summary>
    #define ABILITY_DATA_RESEARCH_TIP 214

    ///<summary>提示</summary>
    #define ABILITY_DATA_TIP 215

    ///<summary>關閉提示</summary>
    #define ABILITY_DATA_UNTIP 216

    ///<summary>學習提示</summary>
    #define ABILITY_DATA_RESEARCH_UBERTIP 217

    ///<summary>提示</summary>
    #define ABILITY_DATA_UBERTIP 218

    ///<summary>關閉提示</summary>
    #define ABILITY_DATA_UNUBERTIP 219

    #define ABILITY_DATA_UNART 220
    
    #define ABILITY_DATA_RESEARCH_ART 221

    //----------物品數據類型----------------------

    ///<summary>物品圖標</summary>
    #define ITEM_DATA_ART 1

    ///<summary>物品提示</summary>
    #define ITEM_DATA_TIP 2

    ///<summary>物品擴展提示</summary>
    #define ITEM_DATA_UBERTIP 3

    ///<summary>物品名字</summary>
    #define ITEM_DATA_NAME 4

    ///<summary>物品說明</summary>
    #define ITEM_DATA_DESCRIPTION 5


    //------------單位數據類型--------------
    ///<summary>攻擊1 傷害骰子數量</summary>
    #define UNIT_STATE_ATTACK1_DAMAGE_DICE 0x10

    ///<summary>攻擊1 傷害骰子面數</summary>
    #define UNIT_STATE_ATTACK1_DAMAGE_SIDE 0x11

    ///<summary>攻擊1 基礎傷害</summary>
    #define UNIT_STATE_ATTACK1_DAMAGE_BASE 0x12

    ///<summary>攻擊1 升級獎勵</summary>
    #define UNIT_STATE_ATTACK1_DAMAGE_BONUS 0x13

    ///<summary>攻擊1 最小傷害</summary>
    #define UNIT_STATE_ATTACK1_DAMAGE_MIN 0x14

    ///<summary>攻擊1 最大傷害</summary>
    #define UNIT_STATE_ATTACK1_DAMAGE_MAX 0x15

    ///<summary>攻擊1 全傷害範圍</summary>
    #define UNIT_STATE_ATTACK1_RANGE 0x16

    ///<summary>裝甲</summary>
    #define UNIT_STATE_ARMOR 0x20

    // attack 1 attribute adds
    ///<summary>攻擊1 傷害衰減參數</summary>
    #define UNIT_STATE_ATTACK1_DAMAGE_LOSS_FACTOR 0x21

    ///<summary>攻擊1 武器聲音</summary>
    #define UNIT_STATE_ATTACK1_WEAPON_SOUND 0x22

    ///<summary>攻擊1 攻擊類型</summary>
    #define UNIT_STATE_ATTACK1_ATTACK_TYPE 0x23

    ///<summary>攻擊1 最大目標數</summary>
    #define UNIT_STATE_ATTACK1_MAX_TARGETS 0x24

    ///<summary>攻擊1 攻擊間隔</summary>
    #define UNIT_STATE_ATTACK1_INTERVAL 0x25

    ///<summary>攻擊1 攻擊延遲/summary>
    #define UNIT_STATE_ATTACK1_INITIAL_DELAY 0x26

    ///<summary>攻擊1 彈射弧度</summary>
    #define UNIT_STATE_ATTACK1_BACK_SWING 0x28

    ///<summary>攻擊1 攻擊範圍緩衝</summary>
    #define UNIT_STATE_ATTACK1_RANGE_BUFFER 0x27

    ///<summary>攻擊1 目標允許</summary>
    #define UNIT_STATE_ATTACK1_TARGET_TYPES 0x29

    ///<summary>攻擊1 濺出區域</summary>
    #define UNIT_STATE_ATTACK1_SPILL_DIST 0x56

    ///<summary>攻擊1 濺出半徑</summary>
    #define UNIT_STATE_ATTACK1_SPILL_RADIUS 0x57

    ///<summary>攻擊1 武器類型</summary>
    #define UNIT_STATE_ATTACK1_WEAPON_TYPE 0x58

    // attack 2 attributes (sorted in a sequencial order based on memory address)
    ///<summary>攻擊2 傷害骰子數量</summary>
    #define UNIT_STATE_ATTACK2_DAMAGE_DICE 0x30

    ///<summary>攻擊2 傷害骰子面數</summary>
    #define UNIT_STATE_ATTACK2_DAMAGE_SIDE 0x31

    ///<summary>攻擊2 基礎傷害</summary>
    #define UNIT_STATE_ATTACK2_DAMAGE_BASE 0x32

    ///<summary>攻擊2 升級獎勵</summary>
    #define UNIT_STATE_ATTACK2_DAMAGE_BONUS 0x33

    ///<summary>攻擊2 傷害衰減參數</summary>
    #define UNIT_STATE_ATTACK2_DAMAGE_LOSS_FACTOR 0x34

    ///<summary>攻擊2 武器聲音</summary>
    #define UNIT_STATE_ATTACK2_WEAPON_SOUND 0x35

    ///<summary>攻擊2 攻擊類型</summary>
    #define UNIT_STATE_ATTACK2_ATTACK_TYPE 0x36

    ///<summary>攻擊2 最大目標數</summary>
    #define UNIT_STATE_ATTACK2_MAX_TARGETS 0x37

    ///<summary>攻擊2 攻擊間隔</summary>
    #define UNIT_STATE_ATTACK2_INTERVAL 0x38

    ///<summary>攻擊2 攻擊延遲</summary>
    #define UNIT_STATE_ATTACK2_INITIAL_DELAY 0x39

    ///<summary>攻擊2 攻擊範圍</summary>
    #define UNIT_STATE_ATTACK2_RANGE 0x40

    ///<summary>攻擊2 攻擊緩衝</summary>
    #define UNIT_STATE_ATTACK2_RANGE_BUFFER 0x41

    ///<summary>攻擊2 最小傷害</summary>
    #define UNIT_STATE_ATTACK2_DAMAGE_MIN 0x42

    ///<summary>攻擊2 最大傷害</summary>
    #define UNIT_STATE_ATTACK2_DAMAGE_MAX 0x43

    ///<summary>攻擊2 彈射弧度</summary>
    #define UNIT_STATE_ATTACK2_BACK_SWING 0x44

    ///<summary>攻擊2 目標允許類型</summary>
    #define UNIT_STATE_ATTACK2_TARGET_TYPES 0x45

    ///<summary>攻擊2 濺出區域</summary>
    #define UNIT_STATE_ATTACK2_SPILL_DIST 0x46

    ///<summary>攻擊2 濺出半徑</summary>
    #define UNIT_STATE_ATTACK2_SPILL_RADIUS 0x47

    ///<summary>攻擊2 武器類型</summary>
    #define UNIT_STATE_ATTACK2_WEAPON_TYPE 0x59

    ///<summary>裝甲類型</summary>
    #define UNIT_STATE_ARMOR_TYPE 0x50

    #define UNIT_STATE_RATE_OF_FIRE 0x51 // global attack rate of unit, work on both attacks
    #define UNIT_STATE_ACQUISITION_RANGE 0x52 // how far the unit will automatically look for targets
    #define UNIT_STATE_LIFE_REGEN 0x53
    #define UNIT_STATE_MANA_REGEN 0x54

    #define UNIT_STATE_MIN_RANGE 0x55
    #define UNIT_STATE_AS_TARGET_TYPE 0x60
    #define UNIT_STATE_TYPE 0x61
    
    


