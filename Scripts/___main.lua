lang=lang or {}


--模组名字 和 DLL文件名字
lang.modname="lang"
lang.dllname="TianTang.dll"
lang.modpath=CS.ModsMgr.Instance:FindMod(lang.modname).Path


--反射自用dll
lang.dll=CS.System.Reflection.Assembly.LoadFile(lang.modpath.."\\"..lang.dllname)



--所有变量词典
---@type Dictionary
lang.vardic= CS.System.Collections.Generic.Dictionary(CS.System.Int32,CS.System.String)()
---@type any
lang.localdic1= CS.System.Collections.Generic.Dictionary(CS.System.String,CS.System.String)()
---@type any
lang.localdic2= CS.System.Collections.Generic.Dictionary(CS.System.String,CS.System.String)()

---加载脚本(支持中文变量和参数)可以用vscode编写lua 搭配 Lua中的lua-language-server 和 中文代码快速补全 以及Lua Debug 这三个插件一起使用
---@param path string@mod下的文件路径比如 "Lualib\test.lua" 脚本一定要放入Lualib文件夹中 其他无效
---@param datas string@是脚本数据
---@param flag string@标记用于给变量起名用的 用来定位文件名字的 [必须英文]
function lang.LoadCnScrpts(path,flag,datas)
	local data
	--创建一个引号词典
	local yindic={}

	if path then
		--获取游戏运行目录
		local rundic=lang.modpath
		--读取文本数据
		data=CS.System.IO.File.ReadAllText(rundic.."\\"..path)


	end
	if datas then
		data=datas
	end


	--创建双引号匹配规则
	local shuangmatch =  CS.System.Text.RegularExpressions.MatchEvaluator(function(mat)
		local name="lang_shuangyin_"..tostring(#yindic)
		table.insert(yindic,1,{varkey=name,varvalue=mat.Value})
		return name

	end)
	--按照规则来替换双引号内的文本
	local text=CS.System.Text.RegularExpressions.Regex.Replace(data, "\"([\\s\\S]*?)\"", shuangmatch)



	--创建单引号匹配规则
	local danmatch =  CS.System.Text.RegularExpressions.MatchEvaluator(function(mat)

		local name="lang_danyin_"..tostring(#yindic)
		table.insert(yindic,1,{varkey=name,varvalue= mat.Value})
		return name

	end)

	text=CS.System.Text.RegularExpressions.Regex.Replace(text, "\'([\\s\\S]*?)\'", danmatch)


	--创建[]符号匹配规则
	local kuomatch =  CS.System.Text.RegularExpressions.MatchEvaluator(function(mat)

		local name="lang_kuoyin_"..tostring(#yindic)
		table.insert(yindic,1,{varkey=name,varvalue= mat.Value})
		return name

	end)

	text=CS.System.Text.RegularExpressions.Regex.Replace(text, "\\[\\[([\\s\\S]*?)\\]\\]", kuomatch)	

	--这个是记录变量词典
	local varmatch =  CS.System.Text.RegularExpressions.MatchEvaluator(function(mat)

		
		local is,var=lang.localdic1:TryGetValue(mat.Value)
		if is then
			return var
		end
		
		local name="lang_var_"..flag.."_"..tostring(lang.localdic1.Count)
		
		lang.localdic1:Add(mat.Value,name)
		lang.localdic2:Add(name,mat.Value)
		lang.vardic:Add(lang.localdic1.Count,mat.Value)
		return name

	end)

	text=CS.System.Text.RegularExpressions.Regex.Replace(text, "[\\u4e00-\\u9fa5]+", varmatch, CS.System.Text.RegularExpressions.RegexOptions.IgnoreCase)

	local SB=CS.System.Text.StringBuilder(text)
	--将单引号和双引号的文本返还回去
	for key, value in pairs(yindic) do
		local k=value.varkey
		local v=value.varvalue
		SB:Replace(k,v)
		--text=string.gsub(text,k,v)
	end
	text=SB:ToString()
	--CS.System.IO.File.WriteAllText("查看转后中文变量文本.lua", text)
	
	--加载脚本
	--load(text) 不报错加载
	CS.XiaWorld.LuaMgr.Instance:DoString(text)--报错加载
end

--获取变量名
function getvar(num)
	
	local is,var=lang.vardic:TryGetValue(num+1)
	if(is)then print(var) else print("没有寻找到变量") end
	
end

---打印输出含有中文变量的脚本
---@param scrpts string@脚本内容
function prints(scrpts)
	lang.LoadCnScrpts(nil,"prints",scrpts)
end


--可以在这里加入新的需要读取的脚本

lang.LoadCnScrpts("Lualib\\01_main.lua","main1")
lang.LoadCnScrpts("Lualib\\04_xlua.lua","xlua")
lang.LoadCnScrpts("Lualib\\05_linq.lua","linq")
lang.LoadCnScrpts("Lualib\\11_cs_str.lua","str")
lang.LoadCnScrpts("Lualib\\15_file.lua","file")
lang.LoadCnScrpts("Lualib\\18_sys.lua","sys")
lang.LoadCnScrpts("Lualib\\25_fan.lua","fan")
lang.LoadCnScrpts("Lualib\\26_xml.lua","xml")
lang.LoadCnScrpts("Lualib\\50_game.lua","game")
lang.LoadCnScrpts("Lualib\\53_form.lua","form")
lang.LoadCnScrpts("Lualib\\54_list.lua","list")
lang.LoadCnScrpts("Lualib\\99_main.lua","main2")


lang.LoadCnScrpts("新版控制台\\新版控制台.lua","conl")
lang.LoadCnScrpts("物品查询器\\物品查询器.lua","item")
lang.LoadCnScrpts("属性查询器\\属性查询器.lua","Prop")
lang.LoadCnScrpts("符咒编辑器\\符咒编辑器.lua","spell")
lang.LoadCnScrpts("技巧选择器\\技巧选择器.lua","skill")
lang.LoadCnScrpts("模组查询器\\模组查询器.lua","mods")

