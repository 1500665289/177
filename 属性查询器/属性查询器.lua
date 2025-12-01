属性查询器=函数.控件.创建窗口("属性查询器")
--属性查询器=函数.控件.创建窗口("属性查询器")
--!下面是属性查询器的成员参考说明
--//TODO:属性查询器
--//TODO:属性查询器
--//TODO:属性查询器
--//TODO:属性查询器
--//TODO:属性查询器
--//TODO:属性查询器



function 属性查询器:窗口初始化()

    属性查询器.分类表={["Body"]="体修",["Dan"]="道修",["God"]="神修",["Dan|God"]="道修|神修",["Dan|Body"]="道修|体修",["Dan|God|Body"]="道修|神修|体修",["Worker"]="外门",["基础属性"]="基础属性",["修炼属性"]="修炼属性",["战斗属性"]="战斗属性",["生产属性"]="生产属性",["未分类"]="未分类",["所有属性"]="所有属性"}
    
    属性查询器.选项表={"体修","道修","神修","道修|神修","道修|体修","道修|神修|体修","外门","基础属性","修炼属性","战斗属性","生产属性","未分类","所有属性"}
    属性查询器.所有属性定义=函数.游戏.获取定义组("属性")

    属性查询器.追加值=0
    属性查询器.百分比=0

    属性查询器:控件创建()

end

function 属性查询器:控件创建()
    
        --内容列表框合集
        local 头参={{200,"系统名"},{200,"属性名"},{80,"类型"},{80,"种类"}}
        属性查询器.列表框表=函数.控件.加入超级列表框(属性查询器,头参,属性查询器.项目被单击事件,120,120,600,330)
        属性查询器:属性定义组到列表(属性查询器.所有属性定义)
    
        --上方搜索框
        属性查询器.搜索框表=函数.控件.加入输入(属性查询器,属性查询器.搜索框内容更变,true,330,70,200)
        函数.控件.加入文字(属性查询器,"搜索:",280,80)

        
        --左侧单选框组合
        函数.控件.加入单选(属性查询器,属性查询器.分类被单击选中,属性查询器.选项表,20,120,120)

        --加入一个确定按钮
        函数.控件.加入按钮(属性查询器,属性查询器.确定按钮被单击事件,"确定",550,470)

        --加入一个标签输入框 追加数值
        属性查询器.追加值输入框=函数.控件.加入标签输入(属性查询器,nil,"追加数值",140,450)

        --加入一个标签输入框 追加百分比
        属性查询器.百分比输入框=函数.控件.加入标签输入(属性查询器,nil,"追加百分比",350,450)
end

---@param obj EventContext
function 属性查询器.项目被单击事件(obj)

    local 主列表=obj.sender
    local 选中索引=函数.列表框.取选中索引(obj.sender)
    local 显示索引=主列表:ItemIndexToChildIndex(选中索引)
    local 选中文本=函数.列表框.取文本(主列表,显示索引,0)
    属性查询器.选中属性=选中文本
    
end

function 属性查询器:属性定义组到列表(defs)

    local 所有数据=""

    for key, value in pairs(defs) do
        local 系统名,显示名,类型,种类="","","",""
        if value.DisplayName~=nil then 显示名=value.DisplayName end
        
        if value.Name~=nil then 系统名=value.Name end
        
        if value.PropertyType~=nil then 类型=value.PropertyType end
        
        if value.FunctionKind~=nil then 种类=value.FunctionKind end

        所有数据=所有数据..系统名.."\t"..显示名.."\t"..类型.."\t"..种类.."\r\n"
    end
    函数.列表框.设置数据(属性查询器.列表框表,所有数据,false)

end

function 属性查询器.搜索框内容更变()
    local 返回定义词典=函数.处理.匹配对象(属性查询器.所有属性定义,function(key,value)
        local 系统名,属性名="",""
        
        if value.Name~=nil then 系统名=value.Name end
        
        if value.DisplayName~=nil then 属性名=value.DisplayName end

        local 属性词=系统名.."\t"..属性名
        return 函数.文本.包含(属性词,属性查询器.搜索框表.字段.text)
    end)
    属性查询器:属性定义组到列表(返回定义词典)
end

function 属性查询器.分类被单击选中(obj)

    local 选中文本=obj.m_title.text
    
    if 选中文本=="所有属性" then
        属性查询器:属性定义组到列表(属性查询器.所有属性定义)

    elseif 选中文本=="未分类" then
        local 返回定义词典=函数.处理.匹配对象(属性查询器.所有属性定义,function(key,value)

            if value.PropertyType==nil and value.FunctionKind==nil then
                return true
            end
            return false
            
        end)

        属性查询器:属性定义组到列表(返回定义词典)
    else
        local 返回定义词典=函数.处理.匹配对象(属性查询器.所有属性定义,function(key,value)

            local 标签="" local 是否匹配=false
            if value.PropertyType~=nil then 标签=value.PropertyType 是否匹配=属性查询器.分类表[标签]==选中文本 end
            if 是否匹配 then return 是否匹配 end
            if value.FunctionKind~=nil then 标签=value.FunctionKind 是否匹配=属性查询器.分类表[标签]==选中文本 end
            return 是否匹配
            
        end)

        属性查询器:属性定义组到列表(返回定义词典)
    end

    
end

function 属性查询器.确定按钮被单击事件()
    local 追加值=属性查询器.追加值输入框.输入框.text
    local 百分比=属性查询器.百分比输入框.输入框.text
    if 属性查询器.选中属性=="" or 属性查询器.选中属性==nil then
        函数.游戏.信息框("你没有选中属性")
        return
    end
    if 追加值=="" and 百分比=="" then
        函数.游戏.信息框("你输入的值为空")
        return
    end
    属性查询器.追加值=tonumber(追加值)
    属性查询器.百分比=tonumber(百分比)
    属性查询器.确定属性=属性查询器.选中属性
    属性查询器:Hide()
    
end

function 属性查询器:窗口显示后()

end
function 属性查询器:窗口隐藏后()

end