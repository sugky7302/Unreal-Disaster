//TESH.scrollpos=73
//TESH.alwaysfold=0
/*
                   _ooOoo_
                  o8888888o
                  88" . "88
                  (| -_- |)
                  O\  =  /O
               ____/`---'\____
             .'  \\|     |//  `.
            /  \\|||  :  |||//  \
           /  _||||| -:- |||||-  \
           |   | \\\  -  /// |   |
           | \_|  ''\---/''  |   |
           \  .-\__  `-`  ___/-. /
         ___`. .'  /--.--\  `. . __
      ."" '<  `.___\_<|>_/___.'  >'"".
     | | :  `- \`.;`\ _ /`;.`/ - ` : | |
     \  \ `-.   \_ __\ /__ _/   .-` /  /
======`-.____`-.___\_____/___.-`____.-'======
                   `=---='
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         佛祖保佑       永無BUG
*/


//這個庫裡面的japi 是在本地玩家 異步的情況下運行的動作 ,不可在非異步的環境下運行
//數據需要同步之後再使用
//運行完之後 會自動同步 在觸發響應之後做動作
// 本地消息的FLAG
#define FLAG_FIFO       1 //隊列  指令進入隊列,相當於按住shift發布指令
#define FLAG_INSTANT    2 //瞬發  瞬發指令,該指令會立即觸發發布命令事件(即使單位處於暈眩狀態)
#define FLAG_ONLY       4 //獨立  單獨施放,當選中多個單位時只有一個單位會響應該指令
#define FLAG_RESTORE    32//恢復 恢復指令,該指令完成後會恢復之前的指令
// 這4個消息標誌可以相加組合

//使用方法 本地坐標命令(命令id,坐標x軸,坐標y軸,FLAG_INSTANT + FLAG_ONLY) flag標籤為   瞬發+獨立
library LocalActionLib requires japi
    globals
        private constant hashtable ht=japi_ht
        private constant integer key=StringHash("jass")
    endglobals
    private function Call takes string str returns nothing
        call UnitId(str)
    endfunction
    
    //本地發布無目標命令
    function LocalOrder takes integer order,integer flags returns nothing
        call SaveStr(ht,key,0,"(II)V")
        call SaveInteger(ht,key,1,order)
        call SaveInteger(ht,key,2,flags)
        call Call("LocalOrder")
    endfunction
    
    //本地發布坐標命令
    function LocalPointOrder takes integer order,real x,real y,integer flags returns nothing
        call SaveStr(ht,key,0,"(IRRI)V")
        call SaveInteger(ht,key,1,order)
        call SaveReal(ht,key,2,x)
        call SaveReal(ht,key,3,y)
        call SaveInteger(ht,key,4,flags)
        call Call("LocalPointOrder")
    endfunction
    
    //本地發布目標命令
    function LocalTargetOrder takes integer order,widget object,integer flags returns nothing
        call SaveStr(ht,key,0,"(IHwidget;I)V")
        call SaveInteger(ht,key,1,order)
        call SaveWidgetHandle(ht,key,2,object)
        call SaveInteger(ht,key,3,flags)
        call Call("LocalTargetOrder")
    endfunction
    
    //獲取玩家當前選擇的單位
    function GetPlayerSelectedUnit takes player p returns unit
        call SaveStr(ht,key,0,"(I)Hunit;")
        call RemoveSavedHandle(ht,key,0)
        call SaveInteger(ht,key,1,GetHandleId(p))
        call Call("GetPlayerSelectedUnit")
        return         LoadUnitHandle(ht,key,0)
    endfunction
    
    //獲取玩家當前鼠標指向的單位
    function GetTargetUnit takes nothing returns unit
        call SaveStr(ht,key,0,"(V)Hunit;")
        call RemoveSavedHandle(ht,key,0)
        call Call("GetTargetObject")
        return         LoadUnitHandle(ht,key,0)
    endfunction
    
    //獲取玩家當前鼠標指向的物品
    function GetTargetItem takes nothing returns item
        call SaveStr(ht,key,0,"(V)Hitem;")
        call RemoveSavedHandle(ht,key,0)
        call Call("GetTargetObject")
        return         LoadItemHandle(ht,key,0)
    endfunction
    
    //獲取玩家當前鼠標指向的 可選擇的可破壞物
    function GetTargetDestructable takes nothing returns destructable
        call SaveStr(ht,key,0,"(V)Hdestructable;")
        call RemoveSavedHandle(ht,key,0)
        call Call("GetTargetObject")
        return         LoadDestructableHandle(ht,key,0)
    endfunction
    
    // 設置單位技能按鈕是否顯示   false 即隱藏 隱藏之後無法發布命令 跟玩家禁用相同
    //使用不會打斷命令  可以 在發布命令的時候  顯示 發布命令 隱藏 即可
    function SetUnitAbilityButtonShow takes unit u,integer id,boolean show returns nothing
        call SaveStr(ht,key,0,"(IIB)V")
        call SaveInteger(ht,key,1,GetHandleId(u))
        call SaveInteger(ht,key,2,id)
        call SaveBoolean(ht,key,3,show)
        call Call("SetUnitAbilityButtonShow")
    endfunction
    
    //設置 是否顯示FPS  顯示狀態下 調用false 可以隱藏 ，相反可以顯示
    function ShowFpsText takes boolean Open returns nothing
        call SaveStr(ht,key,0,"(B)V")
        call SaveBoolean(ht,key,1,Open)
        call Call("ShowFpsText")
    endfunction
    
    //獲取當前遊戲的 fps值  即 遊戲畫面的幀數
    function GetFps takes nothing returns real
        call SaveStr(ht,key,0,"()R")
        call Call("GetFps")
        return         LoadReal(ht,key,0)
    endfunction
    
    //獲取聊天狀態  有聊天輸入框的情況下 返回true  沒有返回false 
    //可以通過 d3d庫裡的模擬按鍵 模擬按下ESC 或者enter 來禁止玩家聊天
    function GetChatState takes nothing returns boolean
        call SaveStr(ht,key,0,"()B")
        call Call("GetChatState")
        return         LoadBoolean(ht,key,0)
    endfunction
  
endlibrary

