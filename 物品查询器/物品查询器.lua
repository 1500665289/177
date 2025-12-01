物品查询器=函数.控件.创建窗口("物品查询器")

--!下面是物品查询器的成员参考说明
--//TODO:物品查询器.窗口表=>
--//TODO:物品查询器.分类表=>物品的分类
--//TODO:物品查询器.列表框表=>显示的超级列表框的表
--//TODO:物品查询器.所有物品定义=>所有物品定义的dic
--//TODO:物品查询器.搜索框表=>
--//TODO:物品查询器.选中物品=>


function 物品查询器:窗口初始化()

    物品查询器.分类表={None="无",Wood="原木",WoodBlock="木料",Rock="石头",RockBlock="石砖",Metal="矿石",Plant="植物",PlantProduct="植物产品",Ingredient="原料",Meat="肉",Leather="皮",Cloth="布",Bone="骨骼",Weapon="武器",FightFabao="法宝",TreasureFabao="秘宝",Hat="帽子",Clothes="衣服",Trousers="裤子",Food="食物",Drug="药物",Dan="丹药",Spell="符咒",Tool="工具",MetalBlock="铁块",Esoterica="秘籍",LeftoverMaterial="角料",SpellPaper="符纸",LingStone="灵石",Garbage="垃圾",SoulCrystal="魄类",Treasure="珍宝",Influence="影响",SPStuffCategories="特殊",BambooBlock="竹块",Other="其他"}

    物品查询器.所有物品定义=函数.游戏.获取定义组("物品")

    物品查询器.选中物品=""

    物品查询器:控件创建()
    

end

function 物品查询器:窗口显示后()

end
function 物品查询器:窗口隐藏后()
end

function 物品查询器:控件创建()

    --内容列表框合集
    local 头参={{200,"系统名"},{100,"事物名"},{100,"标签"}}
    物品查询器.列表框表=函数.控件.加入超级列表框(物品查询器,头参,物品查询器.项目被单击事件,220,120,450,400)
    物品查询器:物品定义组到列表(物品查询器.所有物品定义)

    --上方搜索框
    物品查询器.搜索框表=函数.控件.加入输入(物品查询器,物品查询器.搜索框内容更变,true,330,70,200)
    函数.控件.加入文字(物品查询器,"搜索:",280,80)

    --左侧单选框组合
    函数.控件.加入单选(物品查询器,物品查询器.分类被单击选中,物品查询器.分类表,20,60,180,450)

end

---@param obj EventContext
function 物品查询器.项目被单击事件(obj)

    local 主列表=obj.sender
    local 选中索引=函数.列表框.取选中索引(obj.sender)
    local 显示索引=主列表:ItemIndexToChildIndex(选中索引)
    local 选中文本=函数.列表框.取文本(主列表,显示索引,0)
    物品查询器.选中物品=选中文本
    
end


function 物品查询器:物品定义组到列表(defs)
    local 所有物品定义=defs
    local 所有数据=""

    for key, value in pairs(所有物品定义) do
        local 纹理路径,系统名,事物名,标签="","","",""
        if value.TexPath~=nil then 纹理路径=value.TexPath end
        
        if value.Name~=nil then 系统名=value.Name end
        
        if value.ThingName~=nil then 事物名=value.ThingName end
        
        if value.Item.Lable~=nil then 标签=value.Item.Lable:ToString() end

        所有数据=所有数据..纹理路径.."\t"..系统名.."\t"..事物名.."\t"..物品查询器.分类表[标签].."\r\n"
    end
    函数.列表框.设置数据(物品查询器.列表框表,所有数据,true)

end

function 物品查询器.搜索框内容更变()
    local 返回定义词典=函数.处理.匹配对象(物品查询器.所有物品定义,function(key,value)
        local 系统名,事物名,标签="","",""
        
        if value.Name~=nil then 系统名=value.Name end
        
        if value.ThingName~=nil then 事物名=value.ThingName end

        local 物品词=系统名.."\t"..事物名  
        return 函数.文本.包含(物品词,物品查询器.搜索框表.字段.text)
    end)
    物品查询器:物品定义组到列表(返回定义词典)
end

function 物品查询器.分类被单击选中(obj)

    local 选中文本=obj.m_title.text
    if 选中文本=="无" then
        物品查询器:物品定义组到列表(物品查询器.所有物品定义)
    else
        local 返回定义词典=函数.处理.匹配对象(物品查询器.所有物品定义,function(key,value)

            local 标签=""
            if value.Item.Lable~=nil then 标签=value.Item.Lable:ToString() end
            
            return 物品查询器.分类表[标签]==选中文本
        end)
        物品查询器:物品定义组到列表(返回定义词典)
    end

    
end