--!   最优先运行脚本的所在

函数=函数 or {}


--! 以下设置一下基础表的数据

基础=基础 or {}

基础.模组名字=lang.modname

基础.是否调试模式=true

基础.游戏运行目录=CS.System.IO.Directory.GetCurrentDirectory()

基础.模组路径=lang.modpath

基础.翻译失败文本=""

---@type Assembly
基础.dll=lang.dll

基础.dll类型=基础.dll:GetType("TianTang.Main")

---@type Assembly
基础.修仙dll=CS.System.Reflection.Assembly.GetExecutingAssembly()


--! 基础(表) 成员:[模组名字],[是否调试模式],[游戏运行目录],[模组路径],[翻译失败文本],[dll],[dll类型],[修仙dll]
