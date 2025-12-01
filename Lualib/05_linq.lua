--!   linq(列表数组数据) 关于一些列表数组数据的处理函数 linq这个名字随便起的
函数.处理=函数.处理 or {}
local linq=函数.处理

--?因为泛型委托一直出现CSharpCallLua的问题 只好自己写一个部分linq功能出来
--?目前仅支持List Dictionary Array ArrayList table 这五种类型



---识别类型
---@param any Array|ArrayList|List|Dictionary|table@数组
---@return string@返回table List Array ArrayList Dictionary字符串文本
function linq.获取类型名(any)
    
    if type(any)=="table" then
        return "table"
    else
        local name=any:GetType().Name
        if(name=="List`1")then
            return "List"
        elseif(name=="Dictionary`2") then
            return "Dictionary"
        elseif(name=="ArrayList") then
            return "ArrayList"
        elseif(any:GetType().IsArray==true) then
            return "Array"
        else
            print("无法识别类型.在文件>>>>list.type.lua")
            return""
        end
    end
end

--获取数组成员数量
---@param any Array|ArrayList|List|Dictionary|table@数组
---@return number@返回的数量
function linq.获取成员数(any,isprint)
    local n
    if type(any)=="table" then
        local len=0
        for _ in pairs(any) do
            len=len+1
        end

        n=len
    else
        
        local name=any:GetType().Name
        if(name=="List`1")then
            n=any.Count
        elseif(name=="Dictionary`2") then
            n=any.Count
        elseif(name=="ArrayList") then
            n=any.Count
        elseif(any:GetType().IsArray==true) then
            n=any.Length
        else
            print("无法识别类型.在文件>>>>list.num.lua")
            n=0
        end
    end
    if isprint then print(n) end

    return n
end

--循环数组
---@param any Array|ArrayList|List|Dictionary|table@数组
---@param func function@执行循环的操作act<Tkey,Tvalue> 一个是键一个是值
function linq.循环遍历(any,func)
    
    local type=linq.获取类型名(any)
    
    if type=="table" or type=="Dictionary" then
        for key, value in pairs(any) do
            func(key,value)
        end
    elseif type=="List" or type=="Array" or type=="ArrayList" then

        local num=linq.获取成员数(any)

        if num>0 then
            for i = 0, num-1, 1 do
                func(i,any[i])
            end
        end
    end

end

---打印数组
---@param any Array|ArrayList|List|Dictionary|table@数组
---@param isfy boolean@是否翻译
function linq.循环输出(any,isfy)
    
    if(any==nil)then print("print空值") return end
    local num=linq.获取成员数(any)
    if(num==0)then print("数组成员为0") return end
    linq.循环遍历(any,function(key,value)
        local kestr=tostring(key)
        local ketystr=tostring(type(key))
        local vastr=tostring(value)
        local vatystr=tostring(type(value))
        if isfy then
            kestr=kestr.."("..函数.系统.翻译(kestr,基础.翻译词典)..")"
            ketystr=函数.系统.翻译(ketystr,基础.翻译词典)
            vastr=vastr.."("..函数.系统.翻译(vastr,基础.翻译词典)..")"
            vatystr=函数.系统.翻译(vatystr,基础.翻译词典)
        end

        print("键:"..kestr.." 类型:"..ketystr)
        print("值:"..vastr.." 类型:"..vatystr)
    end)

    --将翻译失败的文本置入到剪辑版中
    if isfy then
        函数.系统.置剪辑版(基础.翻译失败文本)
    end
    
end

---创建数组aslist() 或 强转数组到list强转后的类型是List<object>
---@param any Array|ArrayList|List|Dictionary|table@数组
---@param class string|any@创建数组的类型 nil默认CS.System.Object 也可以简写 str int bool 
---@return List@返回一个list数组
function linq.转泛型数组(any,class)

    local T
    if(class==nil)then T=CS.System.Object
    elseif(class=="str") then T=CS.System.String
    elseif(class=="int") then T=CS.System.Int32
    elseif(class=="bool") then T=CS.System.Boolean
    else T=class end
    
    ---@type List
    local lst = CS.System.Collections.Generic.List(T)()
    if(any~=nil)then
        linq.循环遍历(any,function(key,value)
            lst:Add(value)
        end)
    end


    return lst
end

---创建表astable() 或 强转数组到表
---@param any Array|ArrayList|List|Dictionary|table@数组
---@return table@返回一个表数组
function linq.转表(any)

    local tab={}

    if any~=nil then
        local type=linq.获取类型名(any)
        
        if type=="table" or type=="Dictionary" then
            
            linq.循环遍历(any,function(key,value)
                table.insert(tab,key,value)
            end)
    
        elseif type=="List" or type=="Array" or type=="ArrayList" then
    
            linq.循环遍历(any,function(key,value)
                table.insert(tab,key+1,value)
            end)
    
        end
    end

    
    return tab

end

---创建词典asdictionary() 或 强转数组到词典
---@param any Array|ArrayList|List|Dictionary|table@数组
---@param keyclass string|any@创建数组的类型 nil默认CS.System.Object
---@param valueclass string|any@创建数组的类型 nil默认CS.System.Object
---@return Dictionary@返回一个词典数组
function linq.转词典(any,keyclass,valueclass)

    local T1 local T2
    if(keyclass==nil)then T1=CS.System.Object
    elseif(keyclass=="str") then T1=CS.System.String
    elseif(keyclass=="int") then T1=CS.System.Int32
    elseif(keyclass=="bool") then T1=CS.System.Boolean
    else T1=keyclass end

    if(valueclass==nil)then T2=CS.System.Object
    elseif(valueclass=="str") then T2=CS.System.String
    elseif(valueclass=="int") then T2=CS.System.Int32
    elseif(valueclass=="bool") then T2=CS.System.Boolean
    else T2=valueclass end
    ---@type Dictionary
    local dic=CS.System.Collections.Generic.Dictionary(T1,T2)()

    if any~=nil then
        local type=linq.获取类型名(any)
        if type=="table" or type=="Dictionary" then
            linq.循环遍历(any,function(key,value)
                dic:Add(key,value)
            end)
        elseif type=="List" or type=="Array" or type=="ArrayList" then

            linq.循环遍历(any,function(key,value)
                dic:Add(key+1,value)
            end)

        end
    end

    return dic
end

---创建[]  asarray() 或 强转数组到[]
---@param any Array|ArrayList|List|Dictionary|table@数组
---@param class string|any@创建数组的类型 nil默认CS.System.Object
---@return Array@返回一个 []
function linq.转数组(any,class)

    if(class)then
        ---@type ArrayList
        local arrlis = CS.System.Collections.ArrayList()

        if any~=nil then
            linq.循环遍历(any,function(key,value)
                arrlis:Add(value)
            end)
        end

        return arrlis:ToArray()

    else
        
        local T
        if(class==nil)then T=CS.System.Object
        elseif(class=="str") then T=CS.System.String
        elseif(class=="int") then T=CS.System.Int32
        elseif(class=="bool") then T=CS.System.Boolean
        else T=class end
        
        ---@type List
        local lst = CS.System.Collections.Generic.List(T)()

        if any~=nil then
            linq.循环遍历(any,function(key,value)
                lst:Add(value)
            end)
        end

    
        return lst:ToArray()

    end

end

---创建 对象list
---@param any Array|ArrayList|List|Dictionary|table@数组
---@return ArrayList@返回一个对象list
function linq.转对象数组(any)

    ---@type ArrayList
    local arrlis = CS.System.Collections.ArrayList()

    if any~=nil then
        linq.循环遍历(any,function(key,value)
            arrlis:Add(value)
        end)
    end

    return arrlis
end

---数组排序
---@param any Array|ArrayList|List|Dictionary|table@数组
---@param func function@排序函数如 降序:function(a,b) return a>b end  升序:function(a,b) return a<b end
---@return any
function linq.排序(any,func)
    
    --//TODO待优化排序方法还有更加优化的方法
    local type=linq.获取类型名(any)
    
    local tab=linq.转表(any)
    
    table.sort(tab,function(a,b)
        if not a or not b then
            return false
        end
        if a == b then
            return false
        end
        return func(a,b)
    end)
    if(type=="List")then return linq.转泛型数组(tab)
    elseif(type=="Dictionary")then return linq.转词典(tab)
    elseif(type=="Array")then return linq.转数组(tab)
    elseif(type=="ArrayList")then linq.转对象数组(tab)
    elseif(type=="table")then return tab  end

end

---匹配数组
---@param any Array|ArrayList|List|Dictionary|table@数组
---@param func function@排序函数如 匹配:function(a,b) return true end
---@return Array|ArrayList|List|Dictionary|table@数组
function linq.匹配对象(any,func)

    local type=linq.获取类型名(any)
    local retu
    
    if(type=="table")then
        local newtab={}
        linq.循环遍历(any,function(key,value)
            if(func(key,value))then
                table.insert(newtab,key,value)
            end
        end)
        retu=newtab
    elseif(type=="List")then
        local 类型组=CS.Unity.Cloud.BugReporting.Plugin.SimpleJson.Reflection.ReflectionUtils.GetGenericTypeArguments(any:GetType())
        local T=类型组[0]
        local lst=linq.转泛型数组(nil,T)
        linq.循环遍历(any,function (key,value)
            if(func(key,value))then
                lst:Add(value)
            end
        end)
        retu=lst
    elseif(type=="Array")then
        local 类型组=CS.Unity.Cloud.BugReporting.Plugin.SimpleJson.Reflection.ReflectionUtils.GetGenericTypeArguments(any:GetType())
        local T=类型组[0]
        local lst=linq.转泛型数组(nil,T)
        linq.循环遍历(any,function (key,value)
            if(func(key,value))then
                lst:Add(value)
            end
        end)
        retu=lst:ToArray()
    elseif(type=="ArrayList")then
        local arrlst=linq.转对象数组(nil)
        linq.循环遍历(any,function (key,value)
            if(func(key,value))then
                arrlst:Add(value)
            end
        end)
        retu=arrlst
    elseif(type=="Dictionary")then
        local 类型组=CS.Unity.Cloud.BugReporting.Plugin.SimpleJson.Reflection.ReflectionUtils.GetGenericTypeArguments(any:GetType())
        local T1=类型组[0]
        local T2=类型组[1]
        
        local dic=linq.转词典(nil,T1,T2)
        linq.循环遍历(any,function (key,value)
            if(func(key,value))then
                dic:Add(key,value)
            end
        end)
        retu=dic
    end

    return retu

end




---测试代码作者自用的方法 只要不报错 证明linq 是没有问题的
function linq.测试数组互换作者专用()
    local b={}
    --print("创建一个不同类型的表")
    b["泛型表"]={1,"二","三",true,false,CS.CangJingGeMgr.Instance}
    --print("创建一个同类型string的表")
    b["字符串表"]={"一","二","三","四","五"}
    --print("创建一个同类型number的表")
    b["数值表"]={1,2,3,4,5,6,7}
    --print("泛型表类型:"..linq.type(b.tabf),"字符串表类型"..linq.type(b.tabf),"数值表类型:"..linq.type(b.tabf))
    
    local funcb={["array"]=linq.转数组,["arraylist"]=linq.转对象数组,["list"]=linq.转泛型数组,["dictionary"]=linq.转词典,["table"]=linq.转表}
    

    local data=""
    for name, as in pairs(funcb) do

        local bbs={["泛型表"]=as(b["泛型表"]),["字符串表"]=as(b["字符串表"]),["数值表"]=as(b["数值表"])}
        
        for biaoname, biaovalue in pairs(bbs) do
            for funcname, func in pairs(funcb) do
                
                local any=func(biaovalue)
                linq.循环输出(any)
                print(name..biaoname.." 转到:"..funcname.."数量是:"..linq.获取成员数(any).."通过")
                
            end
    
        end

    end

end

