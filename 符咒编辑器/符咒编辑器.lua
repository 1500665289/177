--!注意 注意 该编辑区需要 有 属性查询器 技巧选择器 不然会有错误
local 符咒编辑器=函数.控件.创建窗口("符咒编辑器")
local 激活快捷键模组=函数.游戏.获取模组("符咒面板","LeftShift+L",function()
    符咒编辑器:Show()
end)
--!下面是符咒编辑器的成员参考说明
--//TODO:符咒编辑器.显示图片表
--//TODO:符咒编辑器.系统名输入框表
--//TODO:符咒编辑器.显示名输入框表
--//TODO:符咒编辑器.五维输入框表
--//TODO:符咒编辑器.符咒列表框表
--//TODO:符咒编辑器.选中文本
--//TODO:符咒编辑器.选中定义


function 符咒编辑器:窗口初始化()

    符咒编辑器:设置宽高(800,680)


    ---@type any
    符咒编辑器.所有符咒定义=函数.游戏.获取定义组("符咒")

    符咒编辑器:控件创建()
end


function 符咒编辑器:控件创建()

    --内容列表框合集
    local 符咒头参={{200,"显示名"},{100,"符咒名"}}
    符咒编辑器.符咒列表框表=函数.控件.加入超级列表框(符咒编辑器,符咒头参,符咒编辑器.项目被单击事件,20,60,340,400)
    符咒编辑器:符咒定义组到列表(符咒编辑器.所有符咒定义)

    --加入一个图片显示符咒图片空间
    ---@type any
    符咒编辑器.显示图片表=函数.控件.加入图片(符咒编辑器,nil,120,570,200,200)

    --加入一个标签输入框 系统名
    符咒编辑器.系统名输入框表=函数.控件.加入标签输入(符咒编辑器,nil,"系统名",370,60)
    
    --加入一个标签输入框 显示名
    符咒编辑器.显示名输入框表=函数.控件.加入标签输入(符咒编辑器,nil,"显示名",570,60)

    --加入一个标签输入框 五维
    符咒编辑器.五维输入框表=函数.控件.加入标签输入(符咒编辑器,nil,"五维(神识,根骨,魅力,悟性,机缘)",370,120)

    --加入一个标签输入框 是否解锁
    符咒编辑器.是否解锁输入框表=函数.控件.加入标签输入(符咒编辑器,nil,"是否初始解锁",570,120)

    --加入一个标签输入框 图片路径
    符咒编辑器.图片路径输入框表=函数.控件.加入标签输入(符咒编辑器,nil,"符咒图片路径",370,180)

    --加入一个标签大输入框 描述
    函数.控件.加入文字(符咒编辑器,"符咒描述内容:",375,240)
    符咒编辑器.描述大输入框表=函数.控件.加入输入(符咒编辑器,nil,false,370,260,400,100)


    --加入一个属性列表
    local 属性头参={{100,"属性名"},{60,"追加值"},{60,"百分比"}}
    符咒编辑器.属性列表框表=函数.控件.加入超级列表框(符咒编辑器,属性头参,nil,230,480,260,120)

    --创建属性加入按钮
    函数.控件.加入按钮(符咒编辑器,符咒编辑器.加入属性被单击事件,"加入属性",250,600)

    --创建属性移除按钮
    函数.控件.加入按钮(符咒编辑器,符咒编辑器.移除属性被单击事件,"移除属性",350,600)



    --加入一个技巧列表
    local 技巧头参={{80,"技巧名"},{70,"追加等级"},{70,"追加上限"}}
    符咒编辑器.技巧列表框表=函数.控件.加入超级列表框(符咒编辑器,技巧头参,nil,470,480,260,120)
    --创建技巧加入按钮
    函数.控件.加入按钮(符咒编辑器,符咒编辑器.加入技巧被单击事件,"加入属性",500,600)

    --创建技巧移除按钮
    函数.控件.加入按钮(符咒编辑器,符咒编辑器.移除技巧被单击事件,"移除属性",600,600)

    --创建独立模组按钮
    函数.控件.加入按钮(符咒编辑器,符咒编辑器.单击创建模组事件,"创建到独立模组",370,360,100,100)

    --加入已有模组按钮
    函数.控件.加入按钮(符咒编辑器,符咒编辑器.单击加入模组事件,"加入到已有模组",480,360,100,100)

    --加入获得该符咒按钮
    函数.控件.加入按钮(符咒编辑器,符咒编辑器.单击立即获得事件,"立刻获得符咒",590,360,100,100)

    --加入保存信息按钮
    函数.控件.加入按钮(符咒编辑器,符咒编辑器.保存符咒信息事件,"保存符咒信息",570,180,100,50)

end

function 符咒编辑器.项目被单击事件()

    local 主列表=符咒编辑器.符咒列表框表.主列表
    local 选中索引=函数.列表框.取选中索引(主列表)
    local 显示索引=主列表:ItemIndexToChildIndex(选中索引)
    local 选中文本=函数.列表框.取文本(主列表,显示索引,0)
    local 是否成功,符咒定义=符咒编辑器.所有符咒定义:TryGetValue(选中文本)
    
    --!这里赋值给选中 方便修改
    符咒编辑器.选中符咒=选中文本
    符咒编辑器.选中定义=符咒定义

    if 是否成功 then
        符咒编辑器.显示图片表.装载器.url=符咒定义.Template
        符咒编辑器.系统名输入框表.输入框.text=符咒定义.Name
        符咒编辑器.显示名输入框表.输入框.text=符咒定义.DisplayName
        符咒编辑器.五维输入框表.输入框.text=符咒定义.BaseFive
        符咒编辑器.是否解锁输入框表.输入框.text=符咒定义.UnLock
        符咒编辑器.图片路径输入框表.输入框.text=符咒定义.Template
        符咒编辑器.描述大输入框表.输入框.text=符咒定义.Desc
        if 符咒定义.Effects~=nil then
            local 属性数据=""
            函数.处理.循环遍历(符咒定义.Effects,function(key,value)
                属性数据=属性数据..value.Name.."\t"..tostring(value.AddV).."\t"..tostring(value.AddP).."\r\n"
            end)
            函数.列表框.设置数据(符咒编辑器.属性列表框表,属性数据,false)
        end
        if 符咒定义.SkillEffects~=nil then
            local 技巧数据=""
            函数.处理.循环遍历(符咒定义.SkillEffects,function(key,value)
                技巧数据=技巧数据..value.Name:ToString().."\t"..tostring(value.Level).."\t"..tostring(value.LevelOver).."\r\n"
            end)

            函数.列表框.设置数据(符咒编辑器.技巧列表框表,技巧数据,false)
        else 函数.列表框.设置数据(符咒编辑器.技巧列表框表,"",false) end

    end

    
end

function 符咒编辑器:符咒定义组到列表(defs)

    local 所有数据=""

    for key, value in pairs(defs) do
        local 系统名,显示名,纹理="","",""
        if value.DisplayName~=nil then 显示名=value.DisplayName end
        
        if value.Name~=nil then 系统名=value.Name end
        
        if value.Template~=nil then 纹理=value.Template end
        

        所有数据=所有数据..纹理.."\t"..系统名.."\t"..显示名.."\r\n"
    end
    函数.列表框.设置数据(符咒编辑器.符咒列表框表,所有数据,true)

end

function 符咒编辑器.加入属性被单击事件()
    if(not 符咒编辑器.检查())then return end
    属性查询器:Show()
    属性查询器.窗口显示后=function()
        属性查询器.确定属性=""
    end
    属性查询器.窗口隐藏后=function()
        local 空属性=CS.XiaWorld.ModifierPropertyData()

        空属性.Name=tostring(属性查询器.确定属性)
        空属性.AddV=tonumber(属性查询器.追加值)
        空属性.AddP=tonumber(属性查询器.百分比)
        if 空属性.Name~="" and 空属性.Name~="nil" and 空属性.AddV+空属性.AddP~=0 then
            if 符咒编辑器.选中定义.Effects==nil then
                符咒编辑器.选中定义.Effects=函数.处理.转泛型数组(nil,CS.XiaWorld.ModifierPropertyData)
            end
            符咒编辑器.选中定义.Effects:Add(空属性)
            符咒编辑器.项目被单击事件()
        end

    end
end
function 符咒编辑器.移除属性被单击事件()
    if(not 符咒编辑器.检查())then return end
    local 选中索引=函数.列表框.取选中索引(符咒编辑器.属性列表框表.主列表)
    符咒编辑器.选中定义.Effects:RemoveAt(选中索引)
    符咒编辑器.项目被单击事件()
end

function 符咒编辑器.加入技巧被单击事件()
    if(not 符咒编辑器.检查())then return end

    技巧选择器:Show()
    技巧选择器.窗口显示后=function()
        技巧选择器.确定技巧=""
    end
    技巧选择器.窗口隐藏后=function()

        local 空属性=CS.XiaWorld.ModifierSkillData()

        空属性.Name=CS.XiaWorld.g_emNpcSkillType[技巧选择器.确定技巧]
        空属性.Level=tonumber(技巧选择器.等级)
        空属性.LevelOver=tonumber(技巧选择器.上限)
        if 空属性.Name~="" and 空属性.Name~="nil" and 空属性.Level+空属性.LevelOver~=0 then

            if 符咒编辑器.选中定义.SkillEffects==nil then
                符咒编辑器.选中定义.SkillEffects=函数.处理.转泛型数组(nil,CS.XiaWorld.ModifierSkillData)
            end
            符咒编辑器.选中定义.SkillEffects:Add(空属性)
        end
        符咒编辑器.项目被单击事件()
    end

end

function 符咒编辑器.移除技巧被单击事件()
    if(not 符咒编辑器.检查())then return end
    local 选中索引=函数.列表框.取选中索引(符咒编辑器.技巧列表框表.主列表)
    符咒编辑器.选中定义.SkillEffects:RemoveAt(选中索引)
    符咒编辑器.项目被单击事件()
end

function 符咒编辑器.单击创建模组事件()
    if(not 符咒编辑器.检查())then return end

    符咒编辑器.保存符咒信息事件()
    函数.游戏.输入框("请给你的MOD起一个名字",function(txt)
        函数.文件.创建模组信息(txt)
        local 符咒名字=符咒编辑器.选中定义.Name
        local 保存路径=基础.游戏运行目录.."\\Mods\\"..txt.."\\Settings\\Practice\\Spell\\"..符咒名字..函数.系统.时间戳(true)..".xml"
        local 符咒类=CS.XiaWorld.SpellDefs()
        符咒类.Spells:Add(符咒编辑器.选中定义)
        函数.文件.保存定义(保存路径,符咒类)
        函数.游戏.信息框("创建模组成功,请大退游戏后激活模组")
    end)
end

function 符咒编辑器.单击加入模组事件()
    if(not 符咒编辑器.检查())then return end

    符咒编辑器.保存符咒信息事件()
    模组查询器:Show()
    模组查询器.窗口隐藏后=function()
        if 模组查询器.确定模组~="" then
            local 符咒名字=符咒编辑器.选中定义.Name
            local 保存路径=基础.游戏运行目录.."\\Mods\\"..模组查询器.确定模组.."\\Settings\\Practice\\Spell\\"..符咒名字..函数.系统.时间戳(true)..".xml"
            local 符咒类=CS.XiaWorld.SpellDefs()
            符咒类.Spells:Add(符咒编辑器.选中定义)
            函数.文件.保存定义(保存路径,符咒类)
            函数.游戏.信息框("加入成功,重开游戏后生效")
        end

    end
end

function 符咒编辑器.单击立即获得事件()
    if(not 符咒编辑器.检查())then return end

    函数.游戏.选择角色框(function(npc,me)
        me:DropSpell(2,符咒编辑器.选中符咒,1)
        函数.游戏.信息框("已经获得该符咒在你选择的NPC旁边")
    end)
end

function 符咒编辑器.保存符咒信息事件()
    if(not 符咒编辑器.检查())then return end

    符咒编辑器.选中定义.Template=符咒编辑器.图片路径输入框表.输入框.text
    符咒编辑器.选中定义.Name=符咒编辑器.系统名输入框表.输入框.text
    符咒编辑器.选中定义.DisplayName=符咒编辑器.显示名输入框表.输入框.text
    符咒编辑器.选中定义.BaseFive=符咒编辑器.五维输入框表.输入框.text
    符咒编辑器.选中定义.UnLock=符咒编辑器.是否解锁输入框表.输入框.text
    符咒编辑器.选中定义.Desc=符咒编辑器.描述大输入框表.输入框.text

end

function 符咒编辑器.检查()
    if 符咒编辑器.选中定义==nil then
        函数.游戏.信息框("你还没有选中符咒")
        return false
    end
    return true
end