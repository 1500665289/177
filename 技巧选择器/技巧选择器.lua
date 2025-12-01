---@type any
技巧选择器=函数.控件.创建窗口_加载组("技巧选择器")

function 技巧选择器:窗口初始化()

    技巧选择器.分类表={Building="版筑",Farming="农耕",Cooking="烹饪",Art="雅艺",Mining="金石",Medicine="岐黄",Manual="巧匠",SocialContact="处世",Fight="战斗",Qi="气感",DouFa="斗法",DanQi="丹器",Fabao="御器",FightSkill="术法",Barrier="护体",Zhen="阵法"}

    --加载图片列表
    技巧选择器.装载器列表.onClickItem:Add(技巧选择器.图标被选中事件)
    for key, value in pairs(技巧选择器.分类表) do
        local 装载器=技巧选择器.装载器列表:AddItemFromPool()
        装载器:SetSize(35,35)
        装载器.m_n183:SetSize(35,35)
        装载器.m_icon.url="技巧查询器/"..key..".png"

    end

    技巧选择器.按钮.onClick:Add(技巧选择器.确定按钮被单击事件)

    技巧选择器:控件创建()


end

function 技巧选择器:控件创建()

    

    技巧选择器.追加等级表=函数.控件.加入标签输入(技巧选择器,nil,"追加数值",50,260)
    技巧选择器.追加上限表=函数.控件.加入标签输入(技巧选择器,nil,"追加百分比",50,310)
    --显示选中的文字
    技巧选择器.选中显示字段=函数.控件.加入文字(技巧选择器,"",250,280)
end

function 技巧选择器.图标被选中事件(obj)
    local 选中图片路径=obj.data.m_icon.url
    local 技巧名=函数.文本.取文本(选中图片路径,"技巧查询器/",".png")
    技巧选择器.选中显示字段.text=技巧选择器.分类表[技巧名]
    技巧选择器.选中技巧=技巧名
end

function 技巧选择器.确定按钮被单击事件()

    local 等级=技巧选择器.追加等级表.输入框.text
    local 上限=技巧选择器.追加上限表.输入框.text
    if 技巧选择器.选中显示字段.text=="" then
        函数.游戏.信息框("你没有选中技巧")
        return
    end
    if 等级=="" and 上限=="" then
        函数.游戏.信息框("你输入的值为空")
        return
    end
    技巧选择器.等级=tonumber(等级)
    技巧选择器.上限=tonumber(上限)
    技巧选择器.确定技巧=技巧选择器.选中技巧
    技巧选择器:Hide()
end

function 技巧选择器:窗口显示后()
    
end
function 技巧选择器:窗口隐藏后()
    
end