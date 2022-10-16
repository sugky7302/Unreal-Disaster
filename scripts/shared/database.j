library Database {
    private hashtable ht = InitHashtable();

    /**
     * 由於哈希表可以在同一索引下儲存多個值，因此這裡建構一個內含整數、浮點數、字串、布林值、物件句柄。
     */
    struct Values {
        private integer i;
        private real r;
        private string s;
        private boolean b;
        private handle h;

        //! textmacro Values__make takes name, type
        method operator $name$() -> $type$ {
            return this.$name$;
        }

        method operator $name$=($type$ value) {
            this.$name$ = value;
        }
        //! endtextmacro
        //! runtextmacro Values__make("i", "integer")
        //! runtextmacro Values__make("r", "real")
        //! runtextmacro Values__make("s", "string")
        //! runtextmacro Values__make("b", "boolean")
        //! runtextmacro Values__make("h", "handle")
    }

    /**
     * 新增一筆資料到資料庫
     *
     * @param {string} table_name - 資料表名稱
     * @param {integer} row - 資料列
     * @param {integer} col - 資料欄
     * @param {Values} values - 資料
     */
     
     */
    function create(string table_name, integer row, integer col, Mix value) {

    }

    function read() {

    }

    function update() {

    }

    function delete() {

    }
}