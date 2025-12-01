
--local text=lang.LoadCnScrpts("53_form.lua","form")

--CS.System.IO.File.WriteAllText("测试文本中文变量.lua", text)


local 窗口表=函数.控件.创建窗口()

窗口表.Show()
函数.控件.加入高级输入(窗口表,nil)




local 模组=函数.游戏.获取模组()









prints([[



  local 窗口表=函数.控件.创建窗口()

  窗口表.Show()
  函数.控件.加入高级输入(窗口表,nil)






]])



function 测试函数()
  CS.XiaWorld.LuaMgr.Instance:DoString("1")
end
function 调试函数(s)
  print(debug.traceback(s, 2))
end

xpcall(测试函数,调试函数)




local logs=CS.Wnd_ConsoleWindow.instance.logs
for i = 0, logs.Count-1, 1 do
  local data=""
  data=data.."消息:\r\n"..logs[i].message.."\r\n".."堆栈:\r\n"

  CS.System.IO.File.WriteAllText("调试文件"..i..".txt", data)


end



xlua.private_accessible(CS.Wnd_ConsoleWindow)
local logs=CS.Wnd_ConsoleWindow.logs
for i = 0, logs.Count-1, 1 do
  local data=""
  data=data.."消息:\r\n"..logs[i].message.."\r\n".."堆栈:\r\n"

  CS.System.IO.File.WriteAllText("调试文件"..i..".txt", data)


end

print(CS.Wnd_ConsoleWindow.instance.logs.Count)

xlua.private_accessible(CS.Wnd_ConsoleWindow)
print(CS.Wnd_ConsoleWindow.instance.showlogs.Count)

--[[
LuaException: c# exception:Could not find a part of the path "Z:\steam\steamapps\common\AmazingCultivationSimulator\lang\Lualib\53_form.lua".,stack:  at System.IO.FileStream..ctor (System.String path, FileMode mode, FileAccess access, FileShare share, Int32 bufferSize, Boolean anonymous, FileOptions options) [0x00000] in <filename unknown>:0 
  at System.IO.FileStream..ctor (System.String path, FileMode mode, FileAccess access, FileShare share) [0x00000] in <filename unknown>:0 
  at (wrapper remoting-invoke-with-check) System.IO.FileStream:.ctor (string,System.IO.FileMode,System.IO.FileAccess,System.IO.FileShare)
  at System.IO.File.OpenRead (System.String path) [0x00000] in <filename unknown>:0 
  at System.IO.StreamReader..ctor (System.String path, System.Text.Encoding encoding, Boolean detectEncodingFromByteOrderMarks, Int32 bufferSize) [0x00000] in <filename unknown>:0 
  at System.IO.StreamReader..ctor (System.String path, System.Text.Encoding encoding) [0x00000] in <filename unknown>:0 
  at (wrapper remoting-invoke-with-check) System.IO.StreamReader:.ctor (string,System.Text.Encoding)
  at System.IO.File.ReadAllText (System.String path, System.Text.Encoding encoding) [0x00000] in <filename unknown>:0 
  at System.IO.File.ReadAllText (System.String path) [0x00000] in <filename unknown>:0 
  at (wrapper managed-to-native) System.Reflection.MonoMethod:InternalInvoke (object,object[],System.Exception&)
  at System.Reflection.MonoMethod.Invoke (System.Object obj, BindingFlags invokeAttr, System.Reflection.Binder binder, System.Object[] parameters, System.Globalization.CultureInfo culture) [0x00000] in <filename unknown>:0 stack traceback:	[C]: in field 'ReadAllText'	[string "lang"]:12: in field 'LoadCnScrpts'	[string "chunk"]:2: in main chunk


local biao={}
biao.bei=true
function biao:Init1() print("初始化类") end


local newb=Lib:NewClass(biao)
for key, value in pairs(newb) do
	print(key)
	print(value)
	for key1, value1 in pairs(value) do
		print(key1)
		print(value1)
	end
end

print("结束")

]]
--[[
01-11 20:32:57.648 [DEBUG]: LUA:键:OnEnter(进入) 类型:字符串
01-11 20:32:57.648 [DEBUG]: LUA:值:function: 0000027056F72BB0(函数: 0000027056F72BB0) 类型:函数
01-11 20:32:57.648 [DEBUG]: LUA:键:GetWindow(获取窗口) 类型:字符串
01-11 20:32:57.648 [DEBUG]: LUA:值:function: 0000027056F72CD0(函数: 0000027056F72CD0) 类型:函数
01-11 20:32:57.649 [DEBUG]: LUA:键:_tbBase(_tbBase) 类型:字符串
01-11 20:32:57.649 [DEBUG]: LUA:值:table: 0000027015AD5E20(表: 0000027015AD5E20) 类型:表
01-11 20:32:57.649 [DEBUG]: LUA:键:OnLeave(离开) 类型:字符串
01-11 20:32:57.649 [DEBUG]: LUA:值:function: 0000027056F72FD0(函数: 0000027056F72FD0) 类型:函数
01-11 20:32:57.650 [DEBUG]: LUA:键:enter(进入) 类型:字符串
01-11 20:32:57.650 [DEBUG]: LUA:值:false(假) 类型:逻辑型
01-11 20:32:57.650 [DEBUG]: LUA:键:CreateWindow(创建窗口) 类型:字符串
01-11 20:32:57.650 [DEBUG]: LUA:值:function: 0000027054BFBA30(函数: 0000027054BFBA30) 类型:函数
01-11 20:32:57.650 [DEBUG]: LUA:键:init(初始化) 类型:字符串
01-11 20:32:57.650 [DEBUG]: LUA:值:true(真) 类型:逻辑型
01-11 20:32:57.650 [DEBUG]: LUA:键:tbWindowClass(tbWindowClass) 类型:字符串
01-11 20:32:57.650 [DEBUG]: LUA:值:table: 0000027015AD6A20(表: 0000027015AD6A20) 类型:表
01-11 20:32:57.651 [DEBUG]: LUA:键:WindowBase(窗口根本) 类型:字符串
01-11 20:32:57.651 [DEBUG]: LUA:值:table: 0000027015AD5A20(表: 0000027015AD5A20) 类型:表
01-11 20:32:57.651 [DEBUG]: LUA:键:GetWindowClass(GetWindowClass) 类型:字符串
01-11 20:32:57.651 [DEBUG]: LUA:值:function: 0000027056F72BE0(函数: 0000027056F72BE0) 类型:函数
01-11 20:32:57.651 [DEBUG]: LUA:键:tbWindow(tbWindow) 类型:字符串
01-11 20:32:57.651 [DEBUG]: LUA:值:table: 0000027015AD6AA0(表: 0000027015AD6AA0) 类型:表
01-11 20:32:57.652 [DEBUG]: LUA:键:NewClass(新建类) 类型:字符串
01-11 20:32:57.652 [DEBUG]: LUA:值:function: 0000027056F72790(函数: 0000027056F72790) 类型:函数
]]--

