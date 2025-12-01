--!这里展示一下中文变量 的控制台
local 新版控制台=函数.游戏.获取模组("新版控制台")
--!下面是新版控制台的成员参考说明
--//TODO:新版控制台.旧版=>旧版控制台实例
--//TODO:新版控制台.旧版UI=>旧版控制台实例中的UIInfo
--//TODO:新版控制台.旧版输入框=>旧版控制台的输入框
--//TODO:新版控制台.保存路径=>保存数据表的路径
--//TODO:新版控制台.当前页=>目前选中的页数
--//TODO:新版控制台.表数据=>负责存放所有文本的表
--//TODO:新版控制台.记事本=>记事本组件对象
--//TODO:新版控制台.页数列表=>负责控制当前页数的列表
--//TODO:新版控制台.记事本输入框=>记事本的输入框组件
--//TODO:新版控制台.输入框滚动条=>记事本的输入框滚动条
--//TODO:新版控制台.是否每次重载=>是否每次发送都重载

function 新版控制台:游戏初始化()

    函数.xlua.解锁私有变量(CS.Wnd_ConsoleWindow)
    GameMain:GetMod("_Event"):RegisterEvent(CS.XiaWorld.g_emEvent.WindowEvent , 新版控制台.事件, 新版控制台)
end

function 新版控制台:游戏离开()
    GameMain:GetMod("_Event"):UnRegisterEvent(CS.XiaWorld.g_emEvent.WindowEvent,新版控制台)
end

function 新版控制台:事件(事物,对象数据)

    
    if 对象数据.Length==2 then
        新版控制台.旧版=CS.Wnd_ConsoleWindow.instance
        local 窗口=对象数据[0]

        if 窗口==新版控制台.旧版 then

            新版控制台:初始化()

        end

    end
end

function 新版控制台:初始化()

    新版控制台.保存路径=基础.模组路径.."\\新版控制台\\控制台记事本保存数据.txt"
    --Error是报错=红色  Exception是C异常=紫色  Log是常规日志=白色  Assert是断言=蓝色  Warning是警告=黄色
    新版控制台.颜色表={["Error"]="#FF0000",["Exception"]="#FF8C00",["Log"]="#FFFFFF",["Assert"]="#0000FF",["Warning"]="#FFFF00"}

    --//TODO!替换表标记标签
    新版控制台.替换表={
        {"at XLua.LuaEnv.DoString (System.Byte[] chunk, System.String chunkName, XLua.LuaTable env) [0x00000] in <filename unknown>:0 \r\n",""},
        {"at XLua.LuaEnv.DoString (System.String chunk, System.String chunkName, XLua.LuaTable env) [0x00000] in <filename unknown>:0 \r\n",""},
        {"at XiaWorld.LuaMgr.DoString (System.String name) [0x00000] in <filename unknown>:0 \r\n",""},
        {"at (wrapper managed-to-native) System.Reflection.MonoMethod:InternalInvoke (object,object[],System.Exception&)\r\n",""},
        {"at System.Reflection.MonoMethod.Invoke (System.Object obj, BindingFlags invokeAttr, System.Reflection.Binder binder, System.Object[] parameters, System.Globalization.CultureInfo culture) [0x00000] in <filename unknown>:0 \n",""},
        {"[0x00000] in <filename unknown>:0",""},
        {"[string \"chunk\"]:305: in function <[string \"chunk\"]:302>",""},
        {"at XLua.LuaEnv.ThrowExceptionFromError (Int32 oldTop)",""},
        {"[C]: in method 'DoString'",""},
        {"stack:",""},
        {"stack traceback:\n",""},
        {"at XLua.StaticLuaCallbacks.CSharpWrapperCallerImpl (IntPtr L, Int32 funcidx, Int32 top)",""},
        {"at XLua.ObjectTranslator.CallCSharpWrapper (IntPtr L, Int32 funcidx, Int32 top)",""},

        {"[string \"chunk\"]","[所在行→]"},
        {"attempt to index a nil value","这是一个null,无法调用其中成员"},
        {"c# exception","C#"},
        {"LuaException:","代码异常:"},
        
        
        
        {"unexpected symbol near","代码格式不正确"},
        
        {"[DEBUG]","调试"}

    }
    local 数据表=函数.文件.反序列化(新版控制台.保存路径)

    if(数据表~=nil)then
        新版控制台.当前页=tonumber(数据表["最后选择索引"])
        新版控制台.表数据=数据表["记事本数据"]
    else
        新版控制台.当前页=1
        新版控制台.表数据={}
    end
    
    if 新版控制台.是否每次重载==nil then
        新版控制台.是否每次重载=true
    end
    
    --!顺序不能乱了
    新版控制台:原版调整参数()
    新版控制台:加入记事本组件()
    新版控制台:加入其余组件()

end

function 新版控制台:原版调整参数()
    新版控制台.旧版UI=新版控制台.旧版.UIInfo


    --设置旧版控制台 第一次打开的XY坐标
    新版控制台.旧版:SetXY(610,100)

    --设置旧版控制台 总在最前效果取消
    新版控制台.旧版.sortingOrder=0

    local 旧版UI= 新版控制台.旧版UI

    --隐藏按钮collapse
    --旧版UI.m_Collapse.visible=false

    --隐藏按钮copy
    --旧版UI.m_copy.visible=false

    --隐藏按钮clear
    --旧版UI.m_Clear.visible=false

    --重载按钮列表
	旧版UI.m_function:SetXY(657,30)--设置按钮列表坐标
	旧版UI.m_n127:SetXY(650,0)--重载按钮的背景坐标
	旧版UI.m_n127:SetSize(170,605)--重载按钮的背景尺寸

	--背景黑框大小
    旧版UI.m_n126:SetSize(620,525)

    --关闭按钮设置
	旧版UI.m_closeButton:SetXY(620,0)

    --主窗体数据
	旧版UI.m_frame.m_title.text="回调代码"
    旧版UI.m_frame:SetSize(650,605)

    --!隐藏输入框
    新版控制台.旧版输入框=旧版UI.m_n119.m_title
    旧版UI.m_n119.visible=false
    --旧版UI.m_n119:SetXY(0,602)

	--回调函数文本列表
	旧版UI.m_n130:SetXY(18,68)
	旧版UI.m_n130:SetSize(620,523)
	--!这是回调列表代码 被单击后 置入剪辑版
	旧版UI.m_n130.onClickItem:Clear()
	旧版UI.m_n130.onClickItem:Add(function(obj) 
		local 被单击的字段文本=obj.data.m_content.m_title.text
        函数.系统.置剪辑版(被单击的字段文本)
	
    end)

    旧版UI.m_n130.itemRenderer=CS.FairyGUI.ListItemRenderer(新版控制台.优化翻译回调文本事件)


	--!发送按钮设置
	旧版UI.m_DO.m_title.text="发送"
	旧版UI.m_DO:SetXY(-554,552)
    旧版UI.m_DO:SetSize(557,51)



end

function 新版控制台.优化翻译回调文本事件(index,obj)
    
    local 日志=CS.Wnd_ConsoleWindow.instance.showlogs[index]
    local 日志类型=日志.type:ToString()
    local 日志信息=日志.message
    local 字符串处理=CS.System.Text.StringBuilder(日志信息)
    for key, value in pairs(新版控制台.替换表) do
        字符串处理:Replace(value[1],value[2])
    end
    local 匹配组=函数.文本.取文本批量(字符串处理:ToString(),"'","'")

    for i = 0, 匹配组.Count-1, 1 do
        local 是否成功,返回值=lang.localdic2:TryGetValue(匹配组[i])
        if 是否成功 then
            字符串处理:Replace(匹配组[i],返回值)
        end
    end

    
    日志信息=函数.文本.去除首尾空(字符串处理:ToString())
    local 返回文本=string.format("[color=%s]%s[/color]",新版控制台.颜色表[日志类型],日志信息)
    obj.m_content.title=返回文本
end


function 新版控制台:加入记事本组件()
    --创建一个记事本对象
    ---@type UI_WindowNotebook
    local 记事本组件对象=CS.FairyGUI.UIPackage.CreateObject("InGame","WindowNotebook")

    --!赋值新版控制台
    新版控制台.记事本=记事本组件对象
    新版控制台.记事本输入框=记事本组件对象.m_n119.m_title
    新版控制台.页数列表=记事本组件对象.m_n120
    新版控制台.输入框滚动条=记事本组件对象.m_n119.scrollPane



    --设置记事本的X Y 坐标
    记事本组件对象:SetXY(-554,0)
    

    --设置记事本页数列表的当前选中位置
    新版控制台.页数列表.selectedIndex=新版控制台.当前页-1
    新版控制台.记事本输入框.text=新版控制台.表数据["note"..tostring(新版控制台.当前页)]

    --!原控制台输入框内容编程记事本UI输入框内容  因为某些特殊原因 所以采用这种赋值方法来处理DoLua
    新版控制台.旧版输入框.text=新版控制台.记事本输入框.text

    --记事本文本内容禁止拖动
    记事本组件对象.m_n119.scrollPane.touchEffect=false
    
    --记事本标题名字
	记事本组件对象.m_frame.m_title.text="Lua脚本"

	--原记事本关闭按钮隐藏
	记事本组件对象.m_frame.m_n5.visible=false--关闭按钮隐藏
	记事本组件对象.m_frame.m_n11.visible=false--关闭图片隐藏


	--设置页数列表被单击事件
	新版控制台.页数列表.onClickItem:Add(新版控制台.记事本页数被更变)

	--记事本输入框内容更变事件
	新版控制台.记事本输入框.onChanged:Add(新版控制台.记事本内容被更变)


	--把记事本添加在控制台面板上
	新版控制台.旧版UI:AddChild(记事本组件对象)
end

function 新版控制台.记事本页数被更变()
	if 新版控制台.页数列表.selectedIndex+1 ~= 新版控制台.当前页 then
	
		--更新选中页数
		新版控制台.当前页=新版控制台.页数列表.selectedIndex+1
		--保存记事本数据和最后选中页数
		新版控制台.保存数据()
        --读取新页数的文本
        新版控制台.记事本输入框.text=新版控制台.表数据["note"..tostring(新版控制台.当前页)]

		--当前页更新为索引页
		
		--原控制台输入框内容编程记事本UI输入框内容  因为某些特殊原因 所以采用这种赋值方法来处理DoLua
		新版控制台.旧版输入框.text=新版控制台.记事本输入框.text

	end
	
end

function 新版控制台.记事本内容被更变()

    --更新滚动条的大小行数间距
	新版控制台.记事本输入框.text=新版控制台.记事本输入框.text

	-- 判断光标位置和最后的字符数 是否小于30 如果小于30则滚动 否则不动
	if(新版控制台.记事本输入框.caretPosition>=#新版控制台.记事本输入框.text-30) then
		
        --文本的行数必须大于10行才会进行滚动 否则不动 并且每一行都需要有内容
        
		if(函数.文本.分割(新版控制台.记事本输入框.text,'\n').Count>10)then
			--滚动条 滚到最底部
			新版控制台.输入框滚动条:ScrollDown(100,true)
		end
		
	end

	--原控制台输入框内容编程记事本UI输入框内容  因为某些特殊原因 所以采用这种赋值方法来处理DoLua
	新版控制台.旧版输入框.text=新版控制台.记事本输入框.text
	--将数据放入表数据中
	新版控制台.表数据["note"..tostring(新版控制台.当前页)]=新版控制台.记事本输入框.text
end

function 新版控制台.保存数据()


    local 写入文件的表={["最后选择索引"]=新版控制台.当前页,["记事本数据"]=新版控制台.表数据}
    --将记事本所有数据写入到mod路径下
    函数.文件.序列化(新版控制台.保存路径,写入文件的表)


end

function 新版控制台:加入其余组件()
    --创建翻译按钮
    --local 翻译按钮=函数.控件.加入按钮(nil,新版控制台.翻译按钮被单击,"翻译数据",20,20)
    --新版控制台.旧版UI:AddChild(翻译按钮)

    --创建保存按钮
    local 保存按钮=函数.控件.加入按钮(nil,function()
        新版控制台.保存数据()
    end,"保存记事本",-120,20)
    新版控制台.旧版UI:AddChild(保存按钮)
    
    --创建清空按钮
    local 清空按钮=函数.控件.加入按钮(nil,function()

        --清空控制台所有日志
        CS.Wnd_ConsoleWindow.logs:Clear()
        --重新加载所有脚本Scripts
        CS.XiaWorld.LuaMgr.Instance:LoadAll()

    end,"清空并重载",-210,20)
    新版控制台.旧版UI:AddChild(清空按钮)

    --创建每次重载勾选框
    新版控制台.勾选框表=函数.控件.加入选择(nil,新版控制台.每次发送重载事件,"每次发送重载",-500,25)

    新版控制台.勾选框表.按钮.selected=新版控制台.是否每次重载
    新版控制台.每次发送重载事件()
    新版控制台.旧版UI:AddChild(新版控制台.勾选框表.组件)
end



function 新版控制台.每次发送重载事件()

    local 是否被选中=新版控制台.勾选框表.按钮.selected
    新版控制台.是否每次重载=是否被选中

    新版控制台.旧版UI.m_DO.onClick:Clear()
    if 是否被选中 then
        新版控制台.旧版UI.m_DO.onClick:Add(function()
            CS.XiaWorld.LuaMgr.Instance:LoadAll()
            CS.Wnd_ConsoleWindow.logs:Clear()
            CS.XiaWorld.LuaMgr.Instance:DoString(新版控制台.旧版输入框.text)--报错加载
        end)
    else
        新版控制台.旧版UI.m_DO.onClick:Add(function()
            CS.XiaWorld.LuaMgr.Instance:DoString(新版控制台.旧版输入框.text)--报错加载
        end)
    end
end

