--! str(文本) 一些文本函数的处理
函数.文本=函数.文本 or {}
local str=函数.文本

---获取文本中间
---@param zhu string@主要文本
---@param l string@左边文本如果nil则获取所有左边内容
---@param r string@右边文本如果nil则获取所有右边内容
---@param bool boolean@是否返回头尾文本
---@return string@最终匹配的结果文本
function str.取文本(zhu,l,r,bool)

	if bool==nil then bool=false end
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("获取")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu,l,r,bool)

end

---获取文本行数
---@param zhu string@主要文本
---@param bool string@是否计算空白行
---@return number@返回的行数数量
function str.行数(zhu,bool)
	if bool==nil then bool=true end
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("行数")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu,bool)
end

---获取某一行文本
---@param zhu string@主要文本
---@param line number@第几行
---@return string@返回获得的那一行
function str.某行(zhu,line)
	if(line==nil)then line=0 end
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("某行")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu,line)
end

---分割文本
---@param zhu string@主要文本
---@param sep string@分割的字符
---@param bool boolean@分割后是否移除空白值的数据
---@return List @返回List`string一个数组文本
function str.分割(zhu,sep,bool)
	if sep==nil then sep="\r\n" end
	if bool==nil then bool=false end
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("分割")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu,sep,bool)
end

---获取文本左右两边的词
---@param zhu string@主要文本
---@param sep string@间隔符
---@return KeyValuePair@返回一个KeyValuePair`string,string的类型
function str.左右(zhu,sep)
	if sep==nil then sep="\t" end
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("左右")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu,sep)
end

---批量获取文本中匹配的数据
---@param zhu string@主要文本
---@param l string@左边文本
---@param r string@右边文本
---@param bool boolean@是否返回头尾
---@return List @返回List`string一个数组文本
function str.取文本批量(zhu,l,r,bool)
	if bool==nil then bool=false end
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("获取批量")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu,l,r,bool)
end

---获取文本的最后一行
---@param zhu string@主要文本
---@return string@返回的最后一行文本
function str.末行(zhu)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("末行")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu)
end

---获取文本的第一行
---@param zhu string@主要文本
---@return string@返回的第一行文本
function str.首行(zhu)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("首行")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu)
end

---文本中是否包含匹配的文本
---@param zhu string@主要文本
---@param mate string@匹配文本
---@return boolean@如果有返回true 没有返回false
function str.包含(zhu,mate)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("包含")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu,mate)
end

---替换文本
---@param zhu string@主要文本
---@param old string@旧的文本  就是需要被替换的文本
---@param new string@新的文本  就是替换旧文本的文本
---@return boolean@如果有返回true 没有返回false
function str.替换(zhu,old,new)
	if(new==nil)then new="" end
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("替换")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu,old,new)
end

---文本随机取一行出来
---@param zhu string@主要文本
---@return string@返回随机的文本
function str.随机行(zhu)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("随机行")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu)
end

---文本如果头部分或者尾部分是空白的 则自动去除掉
---@param zhu string@主要文本
---@return string@返回文本
function str.去除首尾空(zhu)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("去除首尾空")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu)
end

---将文本所有汉字的内容转成拼音 这个网上方法有一定的BUG还有多音字问题无法解决
---@param zhu string@主要文本
---@return string@返回拼音文本
function str.汉字转拼音(zhu)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("汉字转拼音")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu)
end

---正则匹配文本中匹配文本出现的次数
---@param zhu string@主要文本
---@param mate string@匹配文本
---@return number@返回出现的次数
function str.出现次数(zhu,mate)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("出现次数")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu,mate)
end

---正则匹配保留数字 将文本不是数字的内容去掉 C#用正则Replace写法[^0-9]替换为空
---@param zhu string@主要文本
---@return string@返回所有数字文本
function str.保留数字(zhu)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("保留数字")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu)
end

---正则匹配去除数字 将文本除了数字以外的内容去掉  C#用正则Replace写法[0-9]替换为空
---@param zhu string@主要文本
---@return string@返回匹配文本
function str.去除数字(zhu)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("去除数字")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu)
end

---正则匹配保留汉字 将文本不是汉字的内容去掉   C#用正则Replace写法[^\u4e00-\u9fa5]替换为空
---@param zhu string@主要文本
---@return string@返回所有汉字文本
function str.保留汉字(zhu)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("保留汉字")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu)
end

---正则匹配去除汉字 将文本除了汉字以外的内容去掉  C#用正则Replace写法[\u4e00-\u9fa5]替换为空
---@param zhu string@主要文本
---@return string@返回匹配文本
function str.去除汉字(zhu)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("去除汉字")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu)
end

---正则匹配保留字母 将文本不是字母的内容去掉   C#用正则Replace写法[^a-z]替换为空
---@param zhu string@主要文本
---@return string@返回所有字母文本
function str.保留字母(zhu)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("保留字母")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu)
end

---正则匹配去除字母 将文本除了字母以外的内容去掉  C#用正则Replace写法[a-z]替换为空
---@param zhu string@主要文本
---@return string@返回匹配文本
function str.去除字母(zhu)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("去除字母")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu)
end

---正则匹配保留符号 将文本不是符号的内容去掉  C#用正则Replace写法[a-z0-9\u4e00-\u9fa5]替换为空
---@param zhu string@主要文本
---@return string@返回所有符号文本
function str.保留符号(zhu)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("保留符号")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu)
end

---正则匹配去除符号 将文本除了符号以外的内容去掉  C#用正则Replace写法[^a-z0-9\u4e00-\u9fa5]替换为空
---@param zhu string@主要文本
---@return string@返回匹配文本
function str.去除符号(zhu)
	local cfunc=基础.dll类型:GetNestedType("文本"):GetMethod("去除符号")
	local func=函数.xlua.转函数(cfunc)
	return func(zhu)
end




--懒得写入dll了 直接用xlua来实现
--翻译数据支持单词或者文本翻译
---@param zhu string@主要文本
---@param dic Dictionary@翻译的文件数据dic字典 可以用lang.file.loaddic 获得这个dic字典
---@return string@返回翻译后的文本
function str.翻译(zhu,dic)

	--if(dic==nil)then dic=lang.fydic end
	local match =  CS.System.Text.RegularExpressions.MatchEvaluator(function(mat)

		local bool,cn=dic:TryGetValue(mat.Value)
		if(bool)then
			return cn
		end

		if(#mat.Value>2)then
			基础.翻译失败文本=基础.翻译失败文本..mat.Value.."\r\n"
		end
	
		return mat.Value

	end)
	local text=CS.System.Text.RegularExpressions.Regex.Replace(zhu, "[a-z]+", match, CS.System.Text.RegularExpressions.RegexOptions.IgnoreCase)
	return text

end




--以下是lua的正则匹配

--获取单词组 返回一个泛型数组
---@param zhu string@主要文本
---@return List
function str.取单词组(zhu)

	local lst=函数.处理.转泛型数组(nil,"str")

	--%a+ 相当于正则 [a-z]+  匹配单词

	for data in string.gmatch(zhu, "[a-z]+") do
		if lst:Contains(data)==false then
			lst:Add(data)
		end
	end
	return lst
end


--!拓展方法

function str.数据转多维表(data)
	print("sdfwef")
	local 多维表={}
	local 分割行组= str.分割(data)
	
	函数.处理.循环遍历(分割行组,function(行索引,行文本)
		
		多维表[行索引]={}
		
		local 分割个组=str.分割(行文本,"\t",true)
		

		函数.处理.循环遍历(分割个组,function (个索引,个文本)

			多维表[行索引][个索引]=个文本
		end)

	end)


	return 多维表
end


