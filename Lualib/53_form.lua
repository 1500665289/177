--! form(控件)  主要处理控件内部函数 这里
函数.控件=函数.控件 or {}
local form=函数.控件



---获取创建系统窗口(设置了关闭隐藏按钮) 可以用作 获取窗口使用 也可以用作创建窗口使用 如果name是已经创建过的则变成获取 否则 创建
---采用了FairyGUI.UIPackage.CreateObject("InGame", "WindowEmpty")
---@param name string@窗口的系统名字 可以随意起名字 如果为nil则使用时间戳来替代
---@param notCreate boolean@是否不创建 获取时候使用 如果获取到则返回 获取不到则返回nil 不会创建窗口 默认创建
---@return Windowb@返回创建的Windowb表
function form.创建窗口(name,notCreate)

	if(name==nil)then name=函数.系统.时间戳() end
	local Windows=GameMain:GetMod("Windows")
	if Windows.tbWindow[name] ~= nil then
		return Windows.tbWindow[name]
	end
	if notCreate then
		return
	end
	--CreateWindow游戏内部C#代码调用了newclass
	local win = CS.Wnd_LuaWindowBase.CreateWindow(name)
	--InGame  WindowEmpty 是游戏内自己写好的窗口 懒得自己做一个了直接拿来用
	win.window.contentPane=CS.FairyGUI.UIPackage.CreateObject("InGame", "WindowEmpty")
	
	---@type UI_WindowEmpty
	local contentPane=win.window.contentPane

	--!设置窗口标题
	contentPane.m_frame.m_title.text=name

	--设置关闭按钮的事件
	local closebut=contentPane.m_frame.m_n5
	closebut.onClick:Add(function()
		win:Hide()
	end)

	--新增设置初始坐标的方法
	win.设置XY=function(自身表,x,y)
		win.window:SetXY(x,y)
	end
	win.设置宽高=function(自身表,w,h)
		win.window:SetSize(w,h)
	end

	win.OnInit=function() if(win.窗口初始化)then win:窗口初始化() end end
	win.OnShown=function() if(win.窗口显示后)then win:窗口显示后() end end
	win.OnObjectEvent=function(自身表,事物,对象,内容) if(win.窗口事件)then win:窗口事件(事物,对象,内容) end end
	win.OnShowUpdate=function() if(win.窗口显示更新)then win:窗口显示更新() end end
	win.OnUpdate=function(自身表,dt) if(win.窗口更新)then win:窗口更新(dt) end end
	win.OnHide=function() if(win.窗口隐藏后)then win:窗口隐藏后() end end


	Windows.tbWindow[name] = win
	--将窗口加入到win表中   class表在CS.Wnd_LuaWindowBase.CreateWindow内部已经执行过了
	--这里说明一下 win所有表 和class所有表 都一样的目前发现不了有什么区别
	--一个是GameMain:GetMod("Windows").tbWindow
	--一个是GameMain:GetMod("Windows").tbWindowClass
	print("创建了一个新的窗口:"..name)
	return win
end

---创建一个自定义窗口(没有设置关闭隐藏按钮) 使用该方法需要加载UI包 Info.json需要加入UIPackage文件 最好学习一下如何创建Fgui教程
---@param bao string@FGUI包的名字
---@param zujian string@FGUI组件名字
---@param name string@窗口的系统名字 可以随意起名字 如果为nil则使用时间戳来替代
---@return Windowb@返回创建的Windowb表
function form.创建FGUI窗口(bao,zujian,name)
	if(bao==nil)then print("没有找到包的名字 创建失败") return end
	if(zujian==nil)then print("没有找到组件的名字 创建失败") return end
	if(name==nil)then name=函数.系统.时间戳() end
	local Windows=GameMain:GetMod("Windows")

	---@type Windowb
	local win = CS.Wnd_LuaWindowBase.CreateWindow(name)
	win.window.contentPane=CS.FairyGUI.UIPackage.CreateObject(bao,name)
	if not win.window.contentPane then print("内容面板为空,创建失败") return end

	--新增设置初始坐标的方法
	win.SetXY=function(x,y)
		win.window:SetXY(x,y)
	end


	--将窗口加入到win表中   class表在CS.Wnd_LuaWindowBase.CreateWindow内部已经执行过了
	Windows.tbWindow[name] = win

	print("创建了一个新的窗口:"..name)
	return win

end

---创建一个按钮插入窗口
---采用了FairyGUI.UIPackage.CreateObject("InGame", "Button")
---@param Windowb Windowb@窗口表可以使用 form.cwin()创建出来
---@param func function@单击按钮发生事件 可空默认无事件发生
---@param x number@X坐标 可空默认50
---@param y number@Y坐标 可空默认50
---@param w number@宽度  可空默认80
---@param h number@高度  可空默认25
---@return UI_Button@返回创建的按钮
function form.加入按钮(Windowb,func,name,x,y,w,h)
	if not name then name="按钮" end
	if not x then x=50 end
	if not y then y=50 end
	if not w then w=80 end
	if not h then h=25 end
	local 表={}
	--InGame  Button 是游戏内自己写好的按钮 懒得自己做一个了直接拿来用
	---@type UI_Button
	local butobj=CS.FairyGUI.UIPackage.CreateObject("InGame", "Button")
	butobj.m_title.text=name
	butobj.onClick:Add(func)
	butobj:SetSize(w,h)
	butobj:SetXY(x,y)
	if Windowb~=nil then
		Windowb.window:AddObj(butobj,x,y)
	end
	表.字段=butobj.m_title
	表.按钮=butobj
	return butobj
end

---创建标签加入窗口
---采用了动态创建
---@param Windowb Windowb@窗口表可以使用 form.cwin()创建出来
---@param name string@标签的显示内容
---@param x number
---@param y number
---@return GRichTextField@返回富文本类
function form.加入文字(Windowb,name,x,y)
	if not name then name="标签内容" end
	if not x then x=100 end
	if not y then y=100 end

	---@type GRichTextField
	local labobj=CS.FairyGUI.GRichTextField()

	labobj.text=name

	if Windowb~=nil then
		Windowb.window:AddObj(labobj,x,y)
	end
	
	return labobj
end

---创建图片加入窗口
---采用了 FairyGUI.UIPackage.CreateObject("InGame", "Com_Weather")
---@param Windowb Windowb@窗口表可以使用 form.cwin()创建出来
---@param path string@资源文件路径 可以用游戏里的 "res\\Sprs\\object\\object_DAdanyao04"  也可以用自己MOD Resources里面的 Spr\\Building\\building_test.png
---@param x number@X坐标
---@param y number@Y坐标
---@param w number@宽度
---@param h number@高度
---@return UI_Com_Weather
function form.加入图片(Windowb,path,x,y,w,h)
	if not x then x=200 end
	if not y then y=200 end
	if not w then w=100 end
	if not h then h=100 end
	local 表={}
	--不知道为什么lua   new GLoader() 输入url 无法加载资源所以只能用系统内部的Com_Weather效果也是一样
	---@type UI_Com_Weather
	local picobj=CS.FairyGUI.UIPackage.CreateObject("InGame", "Com_Weather")

	picobj.m_n51.visible=false
	local loader=picobj.m_icon
	loader:SetSize(w,h)
	loader.shrinkOnly=true
	loader.url=path

	if Windowb~=nil then
		Windowb.window:AddObj(picobj,x,y)
	end
	表.装载器=loader
	表.组件=picobj
	return 表

end

---创建选择框加入窗口
---采用FairyGUI.UIPackage.CreateObject("InGame", "itemget")
---@param Windowb Windowb@窗口表可以使用 form.cwin()创建出来
---@param func function@选择框被选中触发事件
---@param text string@选择框的显示文字文本 文字最多输入7个字
---@param x number@X坐标
---@param y number@Y坐标
---@return table@返回组件表
function form.加入选择(Windowb,func,text,x,y)

	local 表={}
	---@type UI_itemget
	local cheobj=CS.FairyGUI.UIPackage.CreateObject("InGame", "itemget")
	cheobj.m_title.text=text
	cheobj.m_sub.onClick:Add(func)
	cheobj:SetXY(x,y)
	if Windowb~=nil then
		Windowb.window:AddObj(cheobj,x,y)
	end
	
	表.字段=cheobj.m_title
	表.按钮=cheobj.m_sub
	表.组件=cheobj
	return 表
end

function form.加入高级选择(Windowb,func,texts,x,y,w)
	if w==nil then w=100 end
	if func==nil then func=function() end end

	---@type UI_Item_Storage
	local radobj=CS.FairyGUI.UIPackage.CreateObject("InGame","Item_Storage")


	radobj.m_title.text="全选"

	radobj.m_title.onClick:Add(function()
		for i = 0, radobj.m_n17.numItems-1, 1 do
			---@type UI_Checkbox
			local radz=radobj.m_n17:GetChildAt(i)
			radz.selected=radobj.m_title.selected
		end
		radobj.m_n17.onClickItem:Call()
	end)

	radobj.m_n17.onClickItem:Add(func)


	radobj.m_n17:RemoveChildrenToPool()
	radobj.m_n17.y=0
	local num=0

	for _, value in pairs(texts) do

		---@type UI_Checkbox
		local rad=radobj.m_n17:AddItemFromPool()
		rad.m_title.text=value
		
		num=num+1
	end

	radobj:SetSize(w,num*20+70)
	radobj.m_n17:SetSize(w,num*20+70)
	radobj.m_n24:SetSize(w,num*20+70)

	
	if Windowb~=nil then
		Windowb.window:AddObj(radobj,x,y)
	end

	return radobj
end

---创建一个下拉框加入窗口
---采用了 FairyGUI.UIPackage.CreateObject("InGame","ComboBox")
---@param Windowb Windowb@窗口表可以使用 form.cwin()创建出来
---@param func function@换一个选项触发事件
---@param texts table@一个数组表例如 {"第一","第二","第三"} 这样则创建了三个选项
---@param x number@X坐标
---@param y number@Y坐标
---@return UI_ComboBox@返回组件对象
function form.加入下拉(Windowb,func,texts,x,y)

	---@type UI_ComboBox
	local comobj=CS.FairyGUI.UIPackage.CreateObject("InGame","ComboBox")
	comobj.items=texts
	comobj.onChanged:Add(func)

	if Windowb~=nil then
		Windowb.window:AddObj(comobj,x,y)
	end
	
	return comobj

end

---创建单选框列表加入窗口
---采用了 FairyGUI.UIPackage.CreateObject("InGame","Item_Storage")
---@param Windowb Windowb@窗口表可以使用 form.cwin()创建出来
---@param func function@换一个选项触发事件
---@param texts table@一个数组表例如 {"第一","第二","第三"} 这样则创建了三个选项
---@param x number@X坐标
---@param y number@Y坐标
---@param w number@整体宽度
---@return UI_Item_Storage@返回组件对象
function form.加入单选(Windowb,func,texts,x,y,w,h)

	if w==nil then w=100 end
	if func==nil then func=function() end end

	---@type UI_Item_Storage
	local radobj=CS.FairyGUI.UIPackage.CreateObject("InGame","Item_Storage")

	radobj.m_title.visible=false--隐藏头上的复选框
	radobj.m_n26.visible=false--隐藏头上的红框框背景

	radobj.m_n17:RemoveChildrenToPool()
	radobj.m_n17.y=0
	local num=0

	for _, value in pairs(texts) do

		---@type UI_Checkbox
		local rad=radobj.m_n17:AddItemFromPool()
		rad.m_title.text=value

		rad.onClick:Add(function(context)
			for i = 0, radobj.m_n17.numItems-1, 1 do
				---@type UI_Checkbox
				local radz=radobj.m_n17:GetChildAt(i)
				radz.selected=false
			end
			rad.selected=true
			func(rad,context)
		end)
		
		num=num+1
	end
	if h==nil then
		radobj:SetSize(w,num*20+70)
		radobj.m_n17:SetSize(w,num*20+70)
		radobj.m_n24:SetSize(w,num*20+70)
	else
		radobj:SetSize(w,h)
		radobj.m_n17:SetSize(w,h)
		radobj.m_n24:SetSize(w,h+30)
	end


	

	if Windowb~=nil then
		Windowb.window:AddObj(radobj,x,y)
	end

	return radobj
end

---创建输入框加入窗口
---采用了FairyGUI.UIPackage.CreateObject("InGame","consoleinput")
function form.加入输入(Windowb,func,singleLine,x,y,w,h)
	if not x then x=150 end
	if not y then y=150 end

	if singleLine then
		if not w then w=200 end
		if not h then h=36 end
	else
		if not w then w=300 end
		if not h then h=100 end
	end

	local 输入框表={}
	---@type UI_consoleinput
	local putobj=CS.FairyGUI.UIPackage.CreateObject("InGame","consoleinput")
	putobj:SetSize(w,h)
	
	---修改输入的字体颜色
	putobj.m_title.color=CS.UnityEngine.Color.black
	---是否单行
	putobj.m_title.singleLine=singleLine
	---在输入框更变内容事件
	putobj.m_title.onChanged:Add(func)
	--在输入框中按下回车键事件
	--putobj.m_title.onSubmit:Add(func)

	if Windowb~=nil then
		Windowb.window:AddObj(putobj,x,y)
	end
	输入框表.输入框=putobj.m_title
	return 输入框表
end

function form.加入高级输入(Windowb,func,x,y,w,h)
	
	if not w then w=300 end
	if not h then h=300 end

	---@type UI_consoleinput@背景图
	local imgobj=CS.FairyGUI.UIPackage.CreateObject("InGame","consoleinput")
	imgobj.m_title.visible=true--禁止原有的输入框


	---@type UI_InputTextAreaSorcll
	local putobj=CS.FairyGUI.UIPackage.CreateObject("InGame","InputTextAreaSorcll")
	putobj.m_title.color=CS.UnityEngine.Color.black
	putobj.scrollPane.touchEffect=false--禁止拖动

	imgobj:SetSize(w,h)
	putobj:SetSize(w-5,h-10)
	putobj:SetXY(5,5)
	imgobj:AddChild(putobj)
	
	--滚动条相关事件
	putobj.m_title.onChanged:Add(function()

		--这里是为了滚动条时刻更新粗细
		putobj.m_title.text=putobj.m_title.text
		if(putobj.m_title.caretPosition>=#putobj.m_title.text-20) then
			

			函数.文件.写入("查看文本.txt",putobj.m_title.text)

			--保证开头不会滚动 必须内容有十个换行符才会被滚动
			if(函数.文本.分割(putobj.m_title.text,'\n').Count>8)then

				putobj.scrollPane:ScrollDown(100,true)
			end
			
		end

	end)

	putobj.m_title.onChanged:Add(func)

	if Windowb~=nil then
		Windowb.window:AddObj(imgobj,x,y)
	end
	

end

function form.加入标签输入(Windowb,func,text,x,y)

	---@type UI_MakerCom
	local obj=CS.FairyGUI.UIPackage.CreateObject("InGame","MakerCom")
	local 表={}
	--文字字段
	obj.m_title.text=text
	obj.m_n144.m_title.onChanged:Add(func)
	obj.m_n144.m_title.color=CS.UnityEngine.Color.white

	if Windowb~=nil then
		Windowb.window:AddObj(obj,x,y)
	end
	
	表.字段=obj.m_title
	表.输入框=obj.m_n144.m_title

	return 表
end


--//TODO:拓展窗口创建
function form.创建窗口_加载组(name)

	if(name==nil)then name=函数.系统.时间戳() end
	local Windows=GameMain:GetMod("Windows")
	if Windows.tbWindow[name] ~= nil then
		return Windows.tbWindow[name]
	end

	--CreateWindow游戏内部C#代码调用了newclass
	---@type any
	local win = CS.Wnd_LuaWindowBase.CreateWindow(name)
	--InGame  WindowEmpty 是游戏内自己写好的窗口 懒得自己做一个了直接拿来用
	win.window.contentPane=CS.FairyGUI.UIPackage.CreateObject("InGame", "SelectIcon")
	
	---@type UI_SelectIcon
	local 面板=win.window.contentPane

	--设置关闭按钮的事件
	local 关闭按钮=面板.m_frame.m_n5
	关闭按钮.onClick:Add(function()
		win:Hide()
	end)

	--新增设置初始坐标的方法
	win.SetXY=function(x,y)
		win.window:SetXY(x,y)
	end

	win.OnInit=function() if(win.窗口初始化)then win:窗口初始化() end end
	win.OnShown=function() if(win.窗口显示后)then win:窗口显示后() end end
	win.OnObjectEvent=function(自身表,事物,对象,内容) if(win.窗口事件)then win:窗口事件(事物,对象,内容) end end
	win.OnShowUpdate=function() if(win.窗口显示更新)then win:窗口显示更新() end end
	win.OnUpdate=function(自身表,dt) if(win.窗口更新)then win:窗口更新(dt) end end
	win.OnHide=function() if(win.窗口隐藏后)then win:窗口隐藏后() end end
	
	local 窗体=面板.m_frame
	local 装载器列表=面板.m_n251
	local 背景图片=面板.m_n254
	local 按钮=面板.m_n252

	窗体:SetSize(335,380)
	装载器列表:SetSize(300,200)
	背景图片:SetSize(300,200)
	
	
	按钮:SetXY(260,340)

	win.窗体=窗体
	win.装载器列表=装载器列表
	win.背景图片=背景图片
	win.按钮=按钮

	Windows.tbWindow[name] = win

	return win
end

--//TODO!拓展超级列表框 需要附带UI [超级列表框_fui.bytes] 的组件
function form.加入超级列表框(Windowb,toucan,func,x,y,w,h)
	if(x==nil)then x=150 end
	if(y==nil)then y=150 end
	if(w==nil)then w=350 end
	if(h==nil)then h=350 end

	--创建组件对象
	local obj=CS.FairyGUI.UIPackage.CreateObject("超级列表框","组件")

	local 主列表=obj:GetChild("主列表")
	--?local tlist=obj:GetChild("头列表")

	obj:SetSize(w,h)

	if Windowb~=nil then
		Windowb.window:AddObj(obj,x,y)
	end

	主列表.onClickItem:Add(func)

	local 表={}
	表.对象=obj
	表.头参=toucan
	表.主列表=主列表
	表.头列表=obj:GetChild("头列表")
	return 表
end


