--!   xlua(xlua内置函数) 关于一些xlua插件的部分函数
函数.xlua= 函数.xlua or {}
local xlua=函数.xlua

---获取泛型方法函数 后面是创建泛型 类型 比如 CS.System.String 如果是nil 默认CS.System.Object 可以创建多个泛型
---@param class any@该方法的所在类比如CS.System.Linq.Enumerable
---@param name string@该方法的名字 比如 Count
---@vararg any @后面是创建泛型 类型 比如 CS.System.String 如果是nil 默认CS.System.Object 可以创建多个泛型
---@return function@返回的泛型方法
function xlua.获取泛型方法(class,name,...)

    local foo= _G.xlua.get_generic_method(class,name)
    if select('#',...)==0 then

        return foo(CS.System.Object)
    end
    
    return foo(...)
    
end

---突破类的私有成员 突破后可以访问私有成员
---@param class any@需要突破的类
function xlua.解锁私有变量(class)
    _G.xlua.private_accessible(class)
end

---转到lua函数一般用于反射调用C#成员的时候
---@param method any@需要转换的C#方法
---@return function@返回的函数
function xlua.转函数(method)
    
    return _G.xlua.tofunction(method)
end


--!下面暂未开发使用
--[[
function xlua.getmetatable()
    --暂时未用到
end

function xlua.setmetatable()
    --暂时未用到
end

function xlua.metatable_operation()
    --暂时未用到
end

function xlua.setclass()
    --暂时未用到
end

function xlua.cast()
    --暂时未用到
end

function xlua.structclone()
    --暂时未用到
end

function xlua.release()
    --暂时未用到
end

function xlua.import_generic_type()
    --暂时未用到
end

function xlua.import_type()
    --暂时未用到
end
]]--