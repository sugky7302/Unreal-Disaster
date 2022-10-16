//TESH.scrollpos=582
//TESH.alwaysfold=0
library d3d requires japi
    globals
        private constant hashtable ht=japi_ht
        private constant integer key=StringHash("jass")
    endglobals
    
    private function Call takes string str returns nothing
        call UnitId(str)
    endfunction
    
    //==================獲取鼠標相對魔獸窗口的坐標==========================
    // 不會因為窗口的改變大小或移動而影響的相對坐標
    
    //獲取鼠標在屏幕的x軸
    function GetMouseVectorX takes nothing returns real
        call SaveStr(ht,key,0,"()R")
        call Call("GetMouseVectorX")
        return         LoadReal(ht,key,0)
    endfunction
    
    //獲取鼠標在屏幕的y軸
    function GetMouseVectorY takes nothing returns real
        call SaveStr(ht,key,0,"()R")
        call Call("GetMouseVectorY")
        return         LoadReal(ht,key,0)
    endfunction
    
    //獲取魔獸窗口寬
    function GetWindowWidth takes nothing returns integer
        call SaveStr(ht,key,0,"()I")
        call Call("GetWindowWidth")
        return         LoadInteger(ht,key,0)
    endfunction
    
    //獲取魔獸窗口高
    function GetWindowHeight takes nothing returns integer
        call SaveStr(ht,key,0,"()I")
        call Call("GetWindowHeight")
        return         LoadInteger(ht,key,0)
    endfunction
    
    //16進制函數
    function Hex takes integer i returns string
        call SaveStr(ht,key,0,"(I)S")
        call SaveInteger(ht,key,1,i)
        call Call("Hex")
    return         LoadStr(ht,key,0)
    endfunction
    
    //==================字體類================================
    //創建字體
    function CreateFont takes nothing returns integer
        call SaveStr(ht,key,0,"()I")
        call Call("CreateFont")
        return         LoadInteger(ht,key,0)
    endfunction
    
    //銷毀字體
    function DestroyFont takes integer font returns nothing
        call SaveStr(ht,key,0,"(I)V")
        call Call("DestroyFont")
    endfunction
    
    //獲取字體寬
    function GetFontWidth takes integer font returns integer
        call SaveStr(ht,key,0,"(I)I")
        call SaveInteger(ht,key,1,font)
        call Call("GetFontWidth")
        return         LoadInteger(ht,key,0)
    endfunction
    
    //設置字體寬
    function SetFontWidth takes integer font,integer value returns nothing
        call SaveStr(ht,key,0,"(II)V")
        call SaveInteger(ht,key,1,font)
        call SaveInteger(ht,key,2,value)
        call Call("SetFontWidth")
    endfunction
    
    //獲取字體高
    function GetFontHeight takes integer font returns integer
        call SaveStr(ht,key,0,"(I)I")
        call SaveInteger(ht,key,1,font)
        call Call("GetFontHeight")
        return         LoadInteger(ht,key,0)
    endfunction
    
    //設置字體高
    function SetFontHeight takes integer font,integer value returns nothing
        call SaveStr(ht,key,0,"(II)V")
        call SaveInteger(ht,key,1,font)
        call SaveInteger(ht,key,2,value)
        call Call("SetFontHeight")
    endfunction
    
    //獲取字體粗細
    function GetFontWeight takes integer font returns integer
        call SaveStr(ht,key,0,"(I)I")
        call SaveInteger(ht,key,1,font)
        call Call("GetFontWeight")
        return         LoadInteger(ht,key,0)
    endfunction
    
    //設置字體粗細
    function SetFontWeight takes integer font,integer value returns nothing
        call SaveStr(ht,key,0,"(II)V")
        call SaveInteger(ht,key,1,font)
        call SaveInteger(ht,key,2,value)
        call Call("SetFontWeight")
    endfunction
    
    //設置字體是否傾斜
    function SetFontItalic takes integer font,boolean value returns nothing
        call SaveStr(ht,key,0,"(IB)V")
        call SaveInteger(ht,key,1,font)
        call SaveBoolean(ht,key,2,value)
        call Call("SetFontItalic")
    endfunction
    
    //獲取字體類型
    function GetFontFaceName takes integer font returns string
        call SaveStr(ht,key,0,"(I)S")
        call SaveInteger(ht,key,1,font)
        call Call("GetFontFaceName")
        return         LoadStr(ht,key,0)
    endfunction
    
    //設置字體類型
    function SetFontFaceName takes integer font,string value returns nothing
        call SaveStr(ht,key,0,"(IS)V")
        call SaveInteger(ht,key,1,font)
        call SaveStr(ht,key,2,value)
        call Call("SetFontFaceName")
    endfunction
    
    //==============寫字類===========================
    //創建文字 參數是 字體 內容 屏幕坐標x y 存活時間 顏色值
    function CreateText takes integer font,string str,real x,real y,real time,integer color returns integer
        call SaveStr(ht,key,0,"(ISRRRI)I")
        call SaveInteger(ht,key,1,font)
        call SaveStr(ht,key,2,str)
        call SaveReal(ht,key,3,x)
        call SaveReal(ht,key,4,y)
        call SaveReal(ht,key,5,time)
        call SaveInteger(ht,key,6,color)
        call Call("CreateText")
        return         LoadInteger(ht,key,0)
    endfunction
    
    //獲取文字內容
    function GetTextString takes integer text returns string
        call SaveStr(ht,key,0,"(I)S")
        call SaveInteger(ht,key,1,text)
        call Call("GetTextString")
        return         LoadStr(ht,key,0)
    endfunction
    
    //設置文字內容
    function SetTextString takes integer text,string str returns nothing
        call SaveStr(ht,key,0,"(IS)V")
        call SaveInteger(ht,key,1,text)
        call SaveStr(ht,key,2,str)
        call Call("SetTextString")
    endfunction
    
    //獲取文字坐標x軸
    function GetTextX takes integer text returns real
        call SaveStr(ht,key,0,"(I)R")
        call SaveInteger(ht,key,1,text)
        call Call("GetTextX")
        return         LoadReal(ht,key,0)
    endfunction
    
    //設置文字坐標x軸
    function SetTextX takes integer text,real x returns nothing
        call SaveStr(ht,key,0,"(IR)V")
        call SaveInteger(ht,key,1,text)
        call SaveReal(ht,key,2,x)
        call Call("SetTextX")
    endfunction
    
    //獲取文字坐標y軸
    function GetTextY takes integer text returns real
        call SaveStr(ht,key,0,"(I)R")
        call SaveInteger(ht,key,1,text)
        call Call("GetTextY")
        return         LoadReal(ht,key,0)
    endfunction
    
    //設置文字坐標y軸
    function SetTextY takes integer text,real y returns nothing
        call SaveStr(ht,key,0,"(IR)V")
        call SaveInteger(ht,key,1,text)
        call SaveReal(ht,key,2,y)
        call Call("SetTextY")
    endfunction
    
    //獲取文字剩餘存活時間
    function GetTextTime takes integer text returns real
        call SaveStr(ht,key,0,"(I)R")
        call SaveInteger(ht,key,1,text)
        call Call("GetTextTime")
        return         LoadReal(ht,key,0)
    endfunction
    
    //設置文字剩餘存活時間
    function SetTextTime takes integer text,real value returns nothing
        call SaveStr(ht,key,0,"(IR)V")
        call SaveInteger(ht,key,1,text)
        call SaveReal(ht,key,2,value)
        call Call("SetTextTime")
    endfunction
    
    //獲取文字顏色 16進制 0xFFFFFFFF 前2位表示透明 後6位表示 紅綠藍
    function GetTextColor takes integer text returns integer
        call SaveStr(ht,key,0,"(I)I")
        call SaveInteger(ht,key,1,text)
        call Call("GetTextColor")
        return         LoadInteger(ht,key,0)
    endfunction
    
    //設置文字顏色 16進制
    function SetTextColor takes integer text,integer value returns nothing
        call SaveStr(ht,key,0,"(II)V")
        call SaveInteger(ht,key,1,text)
        call SaveInteger(ht,key,2,value)
        call Call("SetTextColor")
    endfunction
    
    //創建屏幕圖像 圖像路徑 相對魔獸窗口x軸 相對魔獸窗口y軸 相對魔獸窗口 寬度 相對魔獸窗口 高度 等級
    function CreateTexture takes string path,real x,real y,real width,real height,integer color,integer level returns integer
        call SaveStr(ht,key,0,"(SRRRRII)I")
        call SaveStr(ht,key,1,path)
        call SaveReal(ht,key,2,x)
        call SaveReal(ht,key,3,y)
        call SaveReal(ht,key,4,width)
        call SaveReal(ht,key,5,height)
        call SaveInteger(ht,key,6,color)
        call SaveInteger(ht,key,7,level)
        call Call("CreateTexture")
        return         LoadInteger(ht,key,0)
    endfunction
    
    //刪除圖像
    function DestroyTexture takes integer texture returns nothing
        call SaveStr(ht,key,0,"(I)V")
        call SaveInteger(ht,key,1,texture)
        call Call("DestroyTexture")
    endfunction
    
    //獲取圖像相對魔獸窗口坐標x軸
    function GetTextureX takes integer texture returns real
        call SaveStr(ht,key,0,"(I)R")
        call SaveInteger(ht,key,1,texture)
        call Call("GetTextureX")
        return         LoadReal(ht,key,0)
    endfunction
    
    //設置圖像相對魔獸窗口坐標x軸
    function SetTextureX takes integer texture,real value returns nothing
        call SaveStr(ht,key,0,"(IR)V")
        call SaveInteger(ht,key,1,texture)
        call SaveReal(ht,key,2,value)
        call Call("SetTextureX")
    endfunction
    
    //獲取圖像相對魔獸窗口坐標y軸
    function GetTextureY takes integer texture returns real
        call SaveStr(ht,key,0,"(I)R")
        call SaveInteger(ht,key,1,texture)
        call Call("GetTextureY")
        return         LoadReal(ht,key,0)
    endfunction
    
    //設置圖像相對魔獸窗口坐標y軸
    function SetTextureY takes integer texture,real value returns nothing
        call SaveStr(ht,key,0,"(IR)V")
        call SaveInteger(ht,key,1,texture)
        call SaveReal(ht,key,2,value)
        call Call("SetTextureY")
    endfunction
    
    //獲取圖像相對魔獸窗口 寬度
    function GetTextureWidth takes integer texture returns real
        call SaveStr(ht,key,0,"(I)R")
        call SaveInteger(ht,key,1,texture)
        call Call("GetTextureWidth")
        return         LoadReal(ht,key,0)
    endfunction
    
    //設置圖像相對魔獸窗口 寬度
    function SetTextureWidth takes integer texture,real value returns nothing
        call SaveStr(ht,key,0,"(IR)V")
        call SaveInteger(ht,key,1,texture)
        call SaveReal(ht,key,2,value)
        call Call("SetTextureWidth")
    endfunction
    
    //獲取圖像相對魔獸窗口 高度
    function GetTextureHeight takes integer texture returns real
        call SaveStr(ht,key,0,"(I)R")
        call SaveInteger(ht,key,1,texture)
        call Call("GetTextureHeight")
        return         LoadReal(ht,key,0)
    endfunction
    
    //設置圖像相對魔獸窗口 高度
    function SetTextureHeight takes integer texture,real value returns nothing
        call SaveStr(ht,key,0,"(IR)V")
        call SaveInteger(ht,key,1,texture)
        call SaveReal(ht,key,2,value)
        call Call("SetTextureHeight")
    endfunction
    
    //獲取圖像顏色
    function GetTextureColor takes integer texture returns integer
        call SaveStr(ht,key,0,"(I)I")
        call SaveInteger(ht,key,1,texture)
        call Call("GetTextureColor")
        return         LoadInteger(ht,key,0)
    endfunction
    
    //設置圖像顏色
    function SetTextureColor takes integer texture,integer value returns nothing
        call SaveStr(ht,key,0,"(II)V")
        call SaveInteger(ht,key,1,texture)
        call SaveInteger(ht,key,2,value)
        call Call("SetTextureColor")
    endfunction
    
    //獲取圖像級別 級別越高 越上層顯示
    function GetTextureLevel takes integer texture returns integer
        call SaveStr(ht,key,0,"(I)I")
        call SaveInteger(ht,key,1,texture)
        call Call("GetTextureLevel")
        return         LoadInteger(ht,key,0)
    endfunction
    
    //設置圖像級別 級別越高越上層顯示
    function SetTextureLevel takes integer texture,integer value returns nothing
        call SaveStr(ht,key,0,"(II)V")
        call SaveInteger(ht,key,1,texture)
        call SaveInteger(ht,key,2,value)
        call Call("SetTextureLevel")
    endfunction
    
    //獲取圖像旋轉角度
    function GetTextureRotation takes integer texture returns real
        call SaveStr(ht,key,0,"(I)R")
        call SaveInteger(ht,key,1,texture)
        call Call("GetTextureRotation")
        return         LoadReal(ht,key,0)
    endfunction
    
    //設置圖像旋轉角度  參數 圖像,角度  角度制
    function SetTextureRotation takes integer texture,real value returns nothing
        call SaveStr(ht,key,0,"(IR)V")
        call SaveInteger(ht,key,1,texture)
        call SaveReal(ht,key,2,value)
        call Call("SetTextureRotation")
    endfunction
    
    //獲取圖像像素的 寬
    function GetTexturePixelWidth takes integer texture returns real
        call SaveStr(ht,key,0,"(I)R")
        call SaveInteger(ht,key,1,texture)
        call Call("GetTexturePixelWidth")
        return         LoadReal(ht,key,0)
    endfunction
    
    //獲取圖像像素的 高  可以在  寬 * 高的矩形裡進行切割
    function GetTexturePixelHeight takes integer texture returns real
        call SaveStr(ht,key,0,"(I)R")
        call SaveInteger(ht,key,1,texture)
        call Call("GetTexturePixelWidth")
        return         LoadReal(ht,key,0)
    endfunction
    
    //獲取圖形切割區域 默認完整的圖形區域
    //注意！ 返回的rect 是handle 記得用 RemoveRect 排泄
    function GetTextureSrcRect takes integer texture returns rect
        call SaveStr(ht,key,0,"(I)Hrect;")
        call SaveInteger(ht,key,1,texture)
        call Call("GetTextureSrcRect")
        return         LoadRectHandle(ht,key,0)
    endfunction
    
    //設置圖形切割區域  在原圖片上按 rect 矩形進行切割
    //rect的範圍應該這樣描繪 local rect r=Rect(左,下,右,上) 來決定切割這個區域 
    //比如 128*256的圖片 完整的圖片的 矩形應該是 左=0 下=0 右=128 上=256
    // 左上右下 表示 圖片像素裡的 寬跟高的範圍
    function SetTextureSrcRect takes integer texture,rect value returns nothing
        call RemoveSavedHandle(ht,key,0)
        call SaveStr(ht,key,0,"(IHrect;)V")
        call SaveInteger(ht,key,1,texture)
        call SaveRectHandle(ht,key,2,value)
        call Call("SetTextureSrcRect")
    endfunction
    
    //更改圖像圖形  參數 圖像句柄 新的圖形路徑
    function SetTexture takes integer texture,string value returns nothing
        call SaveStr(ht,key,0,"(IS)V")
        call SaveInteger(ht,key,1,texture)
        call SaveStr(ht,key,2,value)
        call Call("SetTexture")
    endfunction
    
    //設置圖像是否顯示 隱藏 true顯示  false隱藏
    function SetTextureShow takes integer texture,boolean value returns nothing
        call SaveStr(ht,key,0,"(IB)V")
        call SaveInteger(ht,key,1,texture)
        call SaveBoolean(ht,key,2,value)
        call Call("SetTextureShow")
    endfunction
    
    //設置圖像是否響應事件 默認true 為開啟觸發狀態 false為關閉觸發
    function SetTextureTrigger takes integer texture,boolean value returns nothing
        call SaveStr(ht,key,0,"(IB)V")
        call SaveInteger(ht,key,1,texture)
        call SaveBoolean(ht,key,2,value)
        call Call("SetTextureTrigger")
    endfunction
    
    //開啟圖像的觸發器
    function EnableTextureTrigger takes integer texture returns nothing
        call SetTextureTrigger(texture,true)
    endfunction
    
    //關閉圖像的觸發器
    function DisableTextureTrigger takes integer texture returns nothing
        call SetTextureTrigger(texture,false)
    endfunction
    
    //獲取 圖片中心點X軸
    function GetTextureCenterX takes integer texture returns real
        return         GetTextureX(texture) + GetTextureWidth(texture) / 2
    endfunction
    
    //獲取 圖片中心點y軸
    function GetTextureCenterY takes integer texture returns real
        return         GetTextureY(texture) + GetTextureHeight(texture) / 2
    endfunction
    
    //獲取 圖片左下角X軸
    function GetTextureMinX takes integer texture returns real
        return         GetTextureX(texture)
    endfunction
    
    //獲取 圖片左下角y軸
    function GetTextureMinY takes integer texture returns real
        return         GetTextureY(texture)
    endfunction
    
    //獲取 圖片右上角X軸
    function GetTextureMaxX takes integer texture returns real
        return         GetTextureX(texture) + GetTextureWidth(texture)
    endfunction
    
    //獲取 圖片右上角y軸
    function GetTextureMaxY takes integer texture returns real
        return         GetTextureY(texture) + GetTextureHeight(texture)
    endfunction
    
    //==================================================
    //給圖像添加事件  
    //第一個參數是圖像地址
    //第二個參數是按鍵值   
    //第三個參數是 按下時回調的函數 
    //第四個參數是 彈起時回調的函數
    //鼠標移動事件 則是 第3個參數 是進入圖形區域時調用 離開圖形區域時調用第4個參數
    //返回事件句柄
    //==================================================
    function TextureAddEvent takes integer texture,integer order,code wCallBack,code lCallBack returns integer
        call SaveStr(ht,key,0,"(IIII)I")
        call SaveInteger(ht,key,1,texture)
        call SaveInteger(ht,key,2,order)
        call SaveInteger(ht,key,3,GetFuncAddr(wCallBack))
        call SaveInteger(ht,key,4,GetFuncAddr(lCallBack))
        call Call("TextureAddEvent")
        return         LoadInteger(ht,key,0)
    endfunction
    
    //圖像刪除事件 參數 圖像句柄 事件句柄
    function TextureRemoveEvent takes integer texture,integer Event returns nothing
        call SaveStr(ht,key,0,"(II)V")
        call SaveInteger(ht,key,1,texture)
        call SaveInteger(ht,key,2,Event)
        call Call("TextureRemoveEvent")
    endfunction
    
    //設置鍵位狀態 指定鍵位 按下或彈起狀態  true為按下 false為彈起
    function SetKeyboard takes integer Key,boolean up returns nothing
        call SaveStr(ht,key,0,"(IB)V")
        call SaveInteger(ht,key,1,Key)
        call SaveBoolean(ht,key,2,up)
        call Call("SetKeyboard")
    endfunction
    
    // 模擬按鍵  按下 彈起 模擬1次點擊
    function ClickKeyboard takes integer Key returns nothing
        call SetKeyboard(Key,true)
        call SetKeyboard(Key,false)
    endfunction
    
    //=========================圖像事件響應動作====================
    
    function GetEventIndex takes nothing returns integer
        return         GetHandleId(GetExpiredTimer())
    endfunction
    
    //獲取響應的鍵位
    function GetTriggerKeyboard takes nothing returns integer
        return         LoadInteger(ht,GetEventIndex(),0x100)
    endfunction
    
    //獲取觸發圖像
    function GetTriggerTexture takes nothing returns integer
        return         LoadInteger(ht,GetEventIndex(),0xff)
    endfunction
    
    //獲取響應事件
    function GetTriggerEvent takes nothing returns integer
        return         LoadInteger(ht,GetEventIndex(),0xfe)
    endfunction
    
    // 獲取響應的鍵盤操作 按下為true 彈起為false
    function GetTriggerKeyboardAction takes nothing returns boolean
        if            (LoadInteger(ht,GetEventIndex(),0x101)==0) then
            return         false
        endif
        return         true
    endfunction
    
    //====================魔獸控制台UI=============================
    //設置是否隱藏控制台UI true為隱藏 false為恢復
    function ShowConsole takes boolean show returns nothing
        call SaveStr(ht,key,0,"(B)V")
        call SaveBoolean(ht,key,1,show)
        call Call("ShowConsole")
    endfunction
    
    //獲取小地圖圖形位置X軸向量
    function GetLittleMapX takes nothing returns real
        call SaveStr(ht,key,0,"()R")
        call Call("GetLittleMapX")
        return         LoadReal(ht,key,0)
    endfunction
    
    //設置小地圖圖形位置X軸向量
    function SetLittleMapX takes real value returns nothing
        call SaveStr(ht,key,0,"(R)V")
        call SaveReal(ht,key,1,value)
        call Call("SetLittleMapX")
    endfunction
    
    //獲取小地圖圖形位置y軸向量
    function GetLittleMapY takes nothing returns real
        call SaveStr(ht,key,0,"()R")
        call Call("GetLittleMapY")
        return         LoadReal(ht,key,0)
    endfunction
    
    //設置小地圖圖形位置Y軸向量
    function SetLittleMapY takes real value returns nothing
        call SaveStr(ht,key,0,"(R)V")
        call SaveReal(ht,key,1,value)
        call Call("SetLittleMapY")
    endfunction
    
    //====================字體結構體的封裝=============================
    struct LOGFONT
        integer font
        method operator lfHeight takes nothing returns integer
            return         GetFontHeight(font)
        endmethod
        method operator lfHeight= takes integer value returns nothing
            call SetFontHeight(font,value)
        endmethod
        method operator lfWidth takes nothing returns integer
            return         GetFontWidth(font)
        endmethod
        method operator lfWidth= takes integer value returns nothing
            call SetFontWidth(font,value)
        endmethod
        method operator lfWeight takes nothing returns integer
            return         GetFontWeight(font)
        endmethod
        method operator lfWeight= takes integer value returns nothing
            call SetFontWeight(font,value)
        endmethod
        method operator lfItalic= takes boolean value returns nothing
            call SetFontItalic(font,value)
        endmethod
        method operator lfFaceName takes nothing returns string
            return         GetFontFaceName(font)
        endmethod
        method operator lfFaceName= takes string str returns nothing
            call SetFontFaceName(font,str)
        endmethod
        static method create takes nothing returns LOGFONT
            local LOGFONT logfont=LOGFONT.allocate()
            set logfont.font=CreateFont()
            return         logfont
        endmethod
        method onDestroy takes nothing returns nothing
            call DestroyFont(font)
        endmethod
        method Text takes string str,real x,real y,real time,integer color returns integer
            return         CreateText(font,str,x,y,time,color)
        endmethod
    endstruct
    
endlibrary