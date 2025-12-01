--!   fan(反射) 关于一些反射的函数处理
函数.反射=函数.反射 or {}
local fan=函数.反射


---加载C#dll返回一个Assembly
---@param path string@dll文件路径 比如 Scripts\\tiantang.dll
---@return Assembly
function fan.加载文件(path)
    --获取运行目录
    local yunxing=CS.System.IO.Directory.GetCurrentDirectory()..lang.modpath
    ---@type Assembly
    local dll=CS.System.Reflection.Assembly.LoadFile(yunxing.."\\"..path)
    return dll
end



