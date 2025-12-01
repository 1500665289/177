--! 在 [__main.lua]中没有对这个 12_lua_str.lua 文件进行处理 所以就 先这样放着以后有机会在做修改
lang.str_lua=lang.str_lua or{}
local str=lang.str_lua


---获取文本中间
---@param zhu string@主要文本
---@param l string@左边文本如果nil则获取所有左边内容
---@param r string@右边文本如果nil则获取所有右边内容
---@return string@最终匹配的结果文本
function str.get(zhu, l, r)
	
    if zhu == nil or string.len(zhu) == 0 then
        return ""
    end
	
	if l ~= nil then

		local liint = string.find(zhu, l, 1)
		
        if (liint ==nil) then
            return ""
		end
		
		liint = liint + string.len(l)
		
		if r ~= nil then
			
            local riint = string.find(zhu, r, liint)
            if riint ==nil then
                return ""
            end
			
            return string.sub(zhu, liint, riint - 1)
		else
			
            return string.sub(zhu, liint, string.len(zhu))
		end
		
	else
		
        if r == nil then
            return ""
        end
		local riint = string.find(zhu, r, 1)
		
        if riint ==nil then
            return ""
        else
            return string.sub(zhu, 1, riint - 1)
		end
		
	end
	
end

---获取文本行数
---@param zhu string@主要文本
---@return number@返回的行数数量
function str.line(zhu)

	local sep = "\r\n"
	local t={}
	local i=1
	for st in string.gmatch(zhu, "([^"..sep.."]+)") do
		t[i] = st
		i = i + 1
	end
	return #t

end

---获取某一行文本
---@param zhu string@主要文本
---@param line number@第几行
---@return string@返回获得的那一行
function str.seline(zhu,line)

	local sep = "\r\n"

	local t={}
	local i=1
	for st in string.gmatch(zhu, "([^"..sep.."]+)") do
		t[i] = st
		i = i + 1
	end
	return t[line]

end

---分割文本
---@param zhu string@主要文本
---@param sep string@分割的字符
---@return List @返回List`string一个数组文本
function str.split(zhu,sep)

	local List_String = CS.System.Collections.Generic.List(CS.System.String)
	local lst = List_String()
    if sep == nil then
		sep = "\r\n"
	end

	for st in string.gmatch(zhu, "([^"..sep.."]+)") do
		lst:Add(st)
	end
	return lst

end

---获取文本左右两边的词
---@param zhu string@主要文本
---@param sep string@间隔符
---@return string,string@返回两个字符串
function str.lr(zhu,sep)

	if sep==nil then sep="\t" end

	local t={}
	local i=1
	for st in string.gmatch(zhu, "([^"..sep.."]+)") do
		t[i]=st
		i=i+1
	end

	if(#t>2) then return "","" end

	return t[1],t[2]

end

---批量获取文本中匹配的数据
---@param zhu string@主要文本
---@param l string@左边文本
---@param r string@右边文本
---@return table @返回lua数组表
function str.getes(zhu, l, r)
    local nillist = {}
    local startint = 0
    local strtext, endint

    repeat
        startint = string.find(zhu, l, startint)

        if startint ~= nil then
            startint = startint + string.len(l)
            endint = string.find(zhu, r, startint)
            if endint ~= nil then
                strtext = string.sub(zhu, startint, endint - 1)
                table.insert(nillist, #nillist+1, strtext)
            else
                break
            end
        else
            break
        end
    until (startint == nil)

    return nillist
end

---获取文本的最后一行
---@param zhu string@主要文本
---@return string@返回的最后一行文本
function str.last(zhu)

	local sep = "%s"
	local t={}
	local i=1
	for st in string.gmatch(zhu, "([^"..sep.."]+)") do
		t[i] = st
		i = i + 1
	end
	
	return t[#t]
end

---获取文本的第一行
---@param zhu string@主要文本
---@return string@返回的第一行文本
function str.first(zhu)

	local sep = "%s"
	local t={}
	local i=1
	for st in string.gmatch(zhu, "([^"..sep.."]+)") do
		t[i] = st
		i = i + 1
	end
	
	return t[1]
end

---文本随机取一行出来
---@param zhu string@主要文本
---@return string@返回随机的文本
function str.randomline(zhu)

	local sep = "%s"
	local t={}
	local i=1
	for st in string.gmatch(zhu, "([^"..sep.."]+)") do
		t[i] = st
		i = i + 1
	end
	local hang= math.floor((math.random()*#t)+1)
	return t[hang]

end

---正则_分割文本
---@param zhu string@主要文本
---@param sep string@分割的字符
---@return Array @返回Array`string[]一个数组文本
function str.zz_split(zhu,sep)
	if sep ==nil then sep="\r\n" end
	return CS.System.Text.RegularExpressions.Regex.Split(zhu, sep, CS.System.Text.RegularExpressions.RegexOptions.IgnoreCase)
end

---正则匹配保留数字 将文本不是数字的内容去掉
---@param zhu string@主要文本
---@return string@返回所有数字文本
function str.zz_num(zhu)
	return CS.System.Text.RegularExpressions.Regex.Replace(zhu, "[^0-9]+", "")
end

---正则匹配保留汉字 将文本不是汉字的内容去掉
---@param zhu string@主要文本
---@return string@返回所有汉字文本
function str.zz_cn(zhu)
	return CS.System.Text.RegularExpressions.Regex.Replace(zhu, "[u4e00-u9fa5]", "", CS.System.Text.RegularExpressions.RegexOptions.IgnoreCase);
end

---正则匹配文本中匹配文本出现的次数
---@param zhu string@主要文本
---@param mate string@匹配文本
---@return number@返回出现的次数
function str.zz_count(zhu,mate)
	if mate then mate="\r\n" end
	return CS.System.Text.RegularExpressions.Regex.Matches(zhu, mate).Count
end


