--!   sys(系统) 关于一些系统的函数处理
函数.系统=函数.系统 or {}
local sys=函数.系统

---获取随机数
---@param min number@最小值
---@param max number@最大值
---@return number@返回随机值
function sys.随机数(min,max)
    return math.random(min,max)
end

---假死延迟
---@param s number@延迟时间1000等于1秒
function sys.延迟(s)
    CS.System.Threading.Thread.Sleep(s)
end

---置入剪辑版内容
---@param txt string@文本
function sys.置剪辑版(txt)
	CS.UnityEngine.GUIUtility.systemCopyBuffer = txt
end

---取剪辑版内容
---@return string@返回剪辑版中的内容
function sys.取剪辑版()
	return CS.UnityEngine.GUIUtility.systemCopyBuffer
end

---获取鼠标点位置
---@return Vector3@vector3是unity的矢量坐标类 有x,y,z 三个成员
function sys.鼠标点()
	return CS.UnityEngine.Input.mousePosition
end

---转到Md5文本
---@param data string@数据文本
---@return string@返回的Md5文本
function sys.md5(data)
	return CS.Assets.USecurity.Md5.ComputeHash(data)
end

---播放声音
---@param path string@文件路径
---@return any@返回C#内部类具体使用查看API中说明
function sys.播放声音(path)
	local mp3=CS.System.Media.SoundPlayer()
	mp3.SoundLocation=path
	mp3:Play()
	return mp3
end

---打开夹子选择框
function sys.文件夹选择框()
	local open=CS.OpenDialogDir()
	open.pszDisplayName=""
	open.lpszTitle=""
	CS.SelectDialogForWindows.SHBrowseForFolder(open)
end

---获取时间戳 默认返回10位
---@param bool boolean@如果为真返回10位数的  如果为假返回13位的
---@return string@返回的时间戳文本
function sys.时间戳(bool)

    local tx = CS.System.DateTime(1970, 1, 1, 0, 0, 0, 0)
    local te = CS.System.DateTime.UtcNow:Subtract(tx)
    if bool then
      return tostring(math.floor(te.TotalMilliseconds))
    else
      return tostring(math.floor(te.TotalSeconds))
	end
end

---获取当前日期
---@return string@返回的日期文本如 2021-01-08
function sys.获取日期()
	return CS.System.DateTime.UtcNow:ToString("yyyy-MM-dd")
end

---UTF8编码和解码
---@param data string@需要编码或者解码的数据文本
---@param bool boolean@如果为true则进行编码  false则解码
---@return string@返回解码或者编码后的文本
function sys.utf8(data,bool)
    if(bool==nil)then bool=true end
	if bool then

		return CS.WebSocketSharp.Net.HttpUtility.UrlEncode(data,CS.System.Text.Encoding.UTF8)

	else
		return CS.WebSocketSharp.Net.HttpUtility.UrlDecode(data,CS.System.Text.Encoding.UTF8)
	end

end

---获取lua中所有全局变量
---@return table@返回所有全局变量的表
function sys.全局变量()
	return _G
end


---尝试函数报错 类似C#里面的try 报错以后还会往下继续执行
---@param func function@需要尝试的函数  后面是长参数 代表函数的参数
---@return boolean,any@返回第一参数没有报错返回true 报错返回false  第二参数是func返回的结果
function sys.尝试(func,...)

	--errfunc 代表报错函数
	local errfunc=function(err)
		if WorldLua ~= nil then
			WorldLua:LogError(debug.traceback(err, 2));
		else
			CS.UnityEngine.Debug.LogError(debug.traceback(err, 2))
		end
 	end

	return xpcall(func,errfunc,...)
end


---这里采用了官方的新建类
---具体说明
---第一:新建类似于 自己创建一个表 如 newclass={} 内部含有一个成员_tbBase
---第二:_tbBase就是传递的base继承了base的所有字段和函数
---第三:当创建完成class以后 会寻找表内的Init函数来执行  如果没有则不运行
---@param base table
---@return table@返回新建的表
function sys.新建类(base,...)
	return Lib:NewClass(base, ...)
end



---这是作者自用的方法
---获取一个类型信息 到剪辑版 这个方法是给vscode的lua插件使用的 放在 类库 里面 可以查看更多信息 这个插件自带了Emmy Annotation
---@param tab table@需要遍历的表
---@param name string@类的名称
---@param isc boolean@是否是C#代码类
function sys.获取类成员到剪辑版(tab,name,isc)

	local any
	if isc then
		---@type Tyep
		local type=typeof(tab)
		any=type:GetMembers(CS.System.Reflection.BindingFlags.Public | CS.System.Reflection.BindingFlags.Instance | CS.System.Reflection.BindingFlags.DeclaredOnly)
	else
		any=tab
	end


	--创建类开头
	local tou="--#region "..name.."\r\n\r\n"
    tou =tou.."---@class "..name.."\r\n"

    --定义类型
    local ding="\r\n---@type "..name.."\r\n"
    ding=ding.."local "..name.."={}\r\n"

    --方法体
	local fang=""
	
	函数.处理.循环遍历(any,function (key,value)
		if isc then
			
			if(函数.文本.包含(tostring(value.MemberType),"Method") and not 函数.文本.包含(value.Name,"set_") and not 函数.文本.包含(value.Name,"get_") )then
				fang=fang.."function "..name..":"..value.Name.."() end\r\n"
			else
				tou=tou.."---@field "..value.Name.." any\r\n"
			end

		else
			if(tostring(type(value))=="function")then
				fang=fang.."function "..name..":"..key.."() end\r\n"
			else
				tou=tou.."---@field "..key.." any\r\n"
			end

		end

		
	end)
	local zong=tou..ding..fang.."\r\n--#endregion"
	函数.系统.置剪辑版(zong)
	print("类信息置入剪辑版成功")
end
