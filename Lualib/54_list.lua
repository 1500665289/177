--! list(超级列表框)  这个是拓展的函数  需要附带UI [超级列表框_fui.bytes] 的组件
--*超级列表框的构造体是:
--*主体:组件:Gcomponent
--*组件:头列表:GList , 主列表:GList
--*头列表=>子对象(字段标签) 主列表=>子对象(横向标签)
--*字段标签=>title:GTextField , 黑边框:GGraph
--*横向标签=>图形1:GGraph , 图形2:GGraph , 横列表:GList 和 图片:GLoader
--*横列表=>子对象(字段标签)
--*字段标签=>title:GTextField , 黑边框:GGraph


函数.列表框=函数.列表框 or {}
local list=函数.列表框


--//TODO!超级列表框--扩展--函数
function list.设置数据(biao,data,ispic)

	local 分割行组=函数.文本.分割(data,nil,true)

	---@type GList
	local 头列表=biao.头列表

	头列表:RemoveChildrenToPool()

	函数.处理.循环遍历(biao.头参,function(key,value)

		local 字段标签=头列表:AddItemFromPool()
		字段标签:SetSize(value[1],20)
		---@type GTextField
		local 字段=字段标签:GetChild("title")
		字段.text=value[2]
	end)


	---@type GList
	local 主列表=biao.主列表

	主列表.itemRenderer=CS.FairyGUI.ListItemRenderer(function(索引1,横向标签)
		local 横列表=横向标签:GetChild("横列表")

		local 分割个组=函数.文本.分割(分割行组[索引1],"\t",false)
        if ispic then
            ---@type GLoader
            local 图片=横向标签:GetChild("图片")
            图片.url=分割个组[0]
            横列表.itemRenderer=CS.FairyGUI.ListItemRenderer(function (索引2,字段标签)
                
                local value=biao.头参[索引2+1]
                字段标签:SetSize(value[1],20)
                ---@type GTextField
				local 字段=字段标签:GetChild("title")

                字段.text=分割个组[索引2+1]
			end)
			
			横列表.numItems=#biao.头参


		else
			横列表.itemRenderer=CS.FairyGUI.ListItemRenderer(function (索引2,字段标签)
				local value=biao.头参[索引2+1]
				字段标签:SetSize(value[1],20)
	
				---@type GTextField
				local 字段=字段标签:GetChild("title")
				字段.text=分割个组[索引2]
	
			end)
			
			横列表.numItems=#biao.头参
		end

		
	end)

	
	主列表:SetVirtual()
	主列表.numItems=分割行组.Count
	主列表:RefreshVirtualList()

end

function list.获取数据(biao)
    local 返回数据=""
    ---@type GList
    local 主列表=biao.主列表
    for i = 0, 主列表.numItems-1, 1 do
        local 横向标签=主列表:GetChildAt(i)
        local 横列表=横向标签:GetChild("横列表")
        for o = 0, 横列表.numItems-1, 1 do
            local 字段标签=横列表:GetChildAt(o)
            local 字段=字段标签:GetChild("title")
            if o==0 then 返回数据=返回数据+字段.text
            else 返回数据=返回数据.."\t"..字段.text end
        end
        返回数据=返回数据.."\r\n"
    end
    return 返回数据
end

function list.取文本(glist,x,y)

	local 横向标签=glist:GetChildAt(x)
	local 横列表=横向标签:GetChild("横列表")
    local 字段标签=横列表:GetChildAt(y)
    local 字段=字段标签:GetChild("title")
	return 字段.text
end

function list.选中某行(glist,line)
	glist.selectedIndex=line
	glist.scrollPane:SetPercY(line/glist.numItems,true)
end

--获取选中文本  ind 第几列
function list.取选中文本(glist,ind)

	if(ind==nil)then ind=0 end
	

	local x=glist.selectedIndex
	local 选中文本=list.取文本(glist,x,ind)

	return 选中文本

end

function list.取选中索引(glist)
	return glist.selectedIndex
end

