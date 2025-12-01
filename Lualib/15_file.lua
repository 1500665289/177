--!处理一些文件函数
函数.文件=函数.文件 or {}
local file=函数.文件


---获取运行目录
---@param name string@是模组名字 如果name是nil的话返回游戏运行目录
---@return string@返回获得的文件夹路径
function file.取运行目录(name)
    if(name==nil)then
--这个比如:Z:\steam\steamapps\common\AmazingCultivationSimulator
        return CS.System.IO.Directory.GetCurrentDirectory()
    end
--这个比如Z:\steam\steamapps\common\AmazingCultivationSimulator\Mods\name
    return CS.ModsMgr.Instance:FindMod(name).Path
end

---获取路径的上级路径
---@param path string@路径
---@return string@返回路径的上级路径
function file.上级目录(path)
	return CS.System.IO.Directory.GetParent(path).FullName
end

---获取路径文件名字
---@param path string@路径
---@return string@返回文件名
function file.文件名字(path)
	return CS.System.IO.Path.GetFileName(path)
end

---获取路径最后文件夹名字
---@param path string@路径
---@return string@返回夹子名字
function file.夹子名字(path)
	return CS.System.IO.Directory.GetParent(path).Name
end

---创建文件夹 支持多级创建 如果存在则不创建
---@param path string@路径
function file.创建夹子(path)
	CS.System.IO.Directory.CreateDirectory(path)
end

---写入文件 @写入的数据文本 @路径
---@param path string
---@param data string
function file.写入(path,data)

	local parent = CS.System.IO.Directory.GetParent(path).FullName
	if(file.文件是否存在(parent)==false)then
		CS.System.IO.Directory.CreateDirectory(parent)
	end
	
	CS.System.IO.File.WriteAllText(path, data)
end

---读入文件
---@param path string@路径
---@return string@返回文件文本数据
function file.读入(path)
	if not CS.System.IO.File.Exists(path) then return "" end
	return CS.System.IO.File.ReadAllText(path)
end

---读入文本所有行
---@param path string@路径
---@return Array@返回一个string[]的数组
function file.读取文本组(path)
	if not CS.System.IO.File.Exists(path) then return nil end
	return CS.System.IO.File.ReadAllLines(path)
end

---写入文本所有行
---@param path string@路径
---@param data Array@是一个string[]的数组
function file.写入文本组(path,data)
	CS.System.IO.File.WriteAllLines(path, data)
end

---文件是否存在
---@param path string@路径
---@return boolean@如果文件存在返回true 不存在返回false
function file.文件是否存在(path)
	return CS.System.IO.File.Exists(path)
end

---夹子是否存在
---@param path string@路径
---@return boolean@如果夹子存在返回true 不存在返回false
function file.夹子是否存在(path)
	return CS.System.IO.Directory.Exists(path)
end

---复制文件
---@param path string@原来路径
---@param newpath string@新的路径
---@return boolean@如果复制成功返回true 复制失败返回false
function file.复制文件(path,newpath)
	if CS.System.IO.File.Exists(newpath) then return false end
    CS.System.IO.File.Copy(path, newpath)
    return true
end

---删除文件
---@param path string@路径
function file.删除文件(path)
	CS.System.IO.File.Delete(path)
end

---删除夹子
---@param path string@路径
function file.删除夹子(path)
	CS.System.IO.Directory.Delete(path)
end

---获取夹子组 采用传统的递归方法
---@param path string@路径
---@param bool boolean@是否包含子目录夹子
---@return List@返回一个List`sting 的数组
function file.获取夹子组(path,bool)
    local List_String = CS.System.Collections.Generic.List(CS.System.String)
    local lst = List_String()
	if bool then
		local dirs=CS.System.IO.Directory.GetDirectories(path)
		for i = 0, dirs.Length-1 do
			lst:Add(dirs[i])
			lst:AddRange(file.获取夹子组(dirs[i],bool))
		end
		
    else
        lst:AddRange(CS.System.IO.Directory.GetDirectories(path))
    end
    return lst
end

--获取路径文件组 ss是一个bool 是否访问多级包含子目录中的文件  采用传统的递归方法 返回list<string>  ex是匹配后缀
---获取文件组
---@param path string@路径
---@param bool boolean@是否包含子目录的文件
---@param ex string@文件的后缀 如: .xml .lua .exe 等
---@return List@返回一个List`string文件名数组
function file.获取文件组(path,bool,ex)

    local List_String = CS.System.Collections.Generic.List(CS.System.String)
    ---@type List
	local lst = List_String()
	if bool then
		local files=CS.System.IO.Directory.GetFiles(path,ex,CS.System.IO.SearchOption.AllDirectories)
		lst:AddRange(files)

	else
		local files=CS.System.IO.Directory.GetFiles(path,ex)
		lst:AddRange(files)

	end
	return lst
	
end

---打开指定文件
---@param path string@路径
function file.打开文件(path)
	CS.System.Diagnostics.Process.Start(path)
end

---打开指定夹子
---@param path string@路径
function file.打开夹子(path)
	CS.System.Diagnostics.Process.Start("explorer.exe", path)
end

---获取文件后缀
---@param path string@路径
---@return string@返回文件路径
function file.获取后缀(path)
	return CS.System.IO.Path.GetExtension(path)
end


---加载一个数据dic 目前仅用于翻译单词 格式必须要正确
---@param path string@文件路径
---@return Dictionary@返回一个词典
function file.加载词典(path)


	local dic=函数.处理.转词典(nil,"str","str")
	if not 函数.文件.文件是否存在(path) then
		print("加载词典--路径文件不存在")
		return dic
	end
	local array=函数.文件.读取文本组(path)
	函数.处理.循环遍历(array,function(key,value)

		local kv=函数.文本.左右(value)
		if dic:ContainsKey(kv.Key)==false then
			dic:Add(kv.Key,kv.Value)
		end
		
	end)
	
	return dic

end


---序列化文本 这里采用官方的方法 传入一个对象或者表 将文本写到文件路径中
---@param path string@写入路径
---@param tab table@需要序列化的表
function file.序列化(path,tab)
	local txt=Lib:Serialize(tab) 
	函数.文件.写入(path,txt)
end


---反序列化文本 这里也是采用官方的方法  返回一个对象或者表
---@param path string@读取的文件路径
---@return table@返回读取数据转到表
function file.反序列化(path)
	local txt=函数.文件.读入(path)
	return Lib:Unserialize(txt)
end

--!下面是游戏方法

---创建一个某组的基础信息数据文件 Info.json
---@param name string
function file.创建模组信息(name)
	--CS.ModsMgr.ModData 数据过多 就暂时先不用 CS.Newtonsoft.Json.JsonConvert.SerializeObject
	--local modinfo=CS.ModsMgr.ModData()
	--local info=CS.Newtonsoft.Json.JsonConvert.SerializeObject(modinfo)
	local path=file.取运行目录().."\\Mods\\"..name
	local data=""
	data=data.."\"Name\":\""..name.."\",\r\n"
	data=data.."\"DisplayName\":\""..name.."\",\r\n"
	data=data..[["Desc":"这是描述内容  this desc data",]].."\r\n"
	data=data..[["UIPackage":"",]].."\r\n"
	data=data..[["GameVersion":1.0,]].."\r\n"
	data=data..[["Version":1.0,]].."\r\n"
	data=data..[["Author":"天堂小灰狼(发布的时候可以修改)",]].."\r\n"
	data=data..[["Sort":"99999",]].."\r\n"
	data=data..[["IncreasedDesc":"模组更新内容"]].."\r\n"
	data="{\r\n"..data.."}"
	
	file.写入(path.."\\Info.json",data)
end

function file.保存定义(path,def,tou,tips)
	
	if(tips==nil)then tips="来源:天堂小灰狼模组写出" end
	local 序列化类=CS.System.Xml.Serialization.XmlSerializer(def:GetType())
	local 头部命名空间=CS.System.Xml.Serialization.XmlSerializerNamespaces()
	头部命名空间:Add("","")
	
	local 写入流=CS.System.IO.StringWriter()
	
	序列化类:Serialize(写入流, def,头部命名空间)
	写入流:Close()
	local 保存文本=写入流:ToString()

	保存文本=string.sub(保存文本,40,-1)
	--local 左右词=函数.文本.左右(tou,"-")
	--保存文本=string.format("<%s><%s>%s\r\n</%s></%s>",左右词.Key,左右词.Value,保存文本,左右词.Value,左右词.Key)
	保存文本=string.format("<!-- %s -->\n%s",tips,保存文本)
	file.写入(path,保存文本)
	print("写入成功")

end


