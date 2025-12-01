--! game(游戏)  主要处理游戏内部函数
函数.游戏=函数.游戏 or {}
local game=函数.游戏

--XT 是一个全局变量  负责识别中文还是英文方便以后 多种语言而设定  如 XT("你好")   如果是英文的话以后可以拓展 返回 hallo



---弹出信息框 演示:lang.game.mesbox("内容","标题")
---@param txt string @信息框内容文本
---@param title string @信息框标题
---@return any @返回Wnd_Message对象
function game.信息框(txt,title)
	if title==nil then title="提示" end
	return CS.Wnd_Message.Show(txt, 1, nil, true, title, 0, 0, "")
end

---弹出输入框 演示:lang.game.ipubox("标题",function(str) print("你输入了:"..str) end,"初始内容")
---@param title string@输入框标题
---@param act function@回调函数 Action<输入的内容:string>:void 负责处理单击确定后发生的事件
---@return any@返回Wnd_Message对象
function game.输入框(title,act,txt)
	CS.Wnd_Message.Show(txt,2,act ,true,title,1,0,"")
end

function game.选择角色框(func)
	local 选择方式=WorldLua:GetSelectNpcCallback(function(NPC编号组)
		if (NPC编号组 == nil or NPC编号组.Count == 0) then
			return
		end
		local 选中NPC=CS.XiaWorld.ThingMgr.Instance:FindThingByID(NPC编号组[0])
		func(选中NPC,选中NPC.LuaHelper)
	end)

	CS.Wnd_SelectNpc.Instance:Select(选择方式,CS.XiaWorld.g_emNpcRank.Normal,1,1,nil,nil,"选择人物")
	--GetSelectNpcCallback
end




---创建一个MOD类 里面包含了游戏初始化框架 游戏刷新框架 游戏进入框架 游戏离开框架 游戏保存框架 等等
---@param name string@MOD的名字
function game.获取模组(name,key,func)

	if name==nil then name=函数.系统.时间戳(true)  end

	if GameMain.tbMods[name] ~= nil then
		return GameMain.tbMods[name]
	end

	local b =  Lib:NewClass(GameMain.tbModBase)
	b.name=name
	GameMain.tbMods[name] = b
	print("成功创建类:"..name)
	--//TODO:拓展中文变量

	b.OnInit=function() if(b.游戏初始化)then b:游戏初始化() end end
	b.OnEnter=function() if(b.游戏进入)then b:游戏进入() end end
	b.OnLeave=function() if(b.游戏离开)then b:游戏离开() end end

	b.OnBeforeInit=function() if(b.之前初始化)then b:之前初始化() end end
	b.OnAfterLoad=function() if(b.之后加载)then b:之后加载() end end

	if key~=nil then

		b.OnSetHotKey=function()
			return { {ID = name , Name = name , Type = "天堂", InitialKey1 = key , InitialKey2 = nil } }
		end
	
		b.OnHotKey=function(自身表,键ID,键状态)
			if 键ID==name and 键状态=="down" then
				func()
			end
		end
	end

	--b.OnSetHotKey=function() if(b.设置热键)then  return b:设置热键() end end
	--b.OnHotKey=function(自身表,键ID,键状态) if(b.打开热键)then  b:打开热键(键ID,键状态) end end
	b.OnSave=function() if(b.游戏保存)then b:游戏保存() end end
	b.OnLoad=function(自身表,数据表) if(b.游戏加载)then b:游戏加载(数据表) end end
	b.SyncSave=function() if(b.同步保存)then b:同步保存() end end
	b.OnSyncLoad=function(自身表,数据表) if(b.同步加载)then b:同步加载(数据表) end end

	b.NeedSyncData=function() if(b.是否同步数据)then b:是否同步数据() end end


	b.OnStep=function(自身表,dt) if(b.游戏帧间隔)then b:游戏帧间隔(dt) end end
	b.OnRender=function(自身表,dt) if(b.渲染帧间隔)then b:渲染帧间隔(dt) end end
	


	return b

end

---获取游戏已经创建的所有MOD到表
---@return table@返回的所有MOD表
function game.获取所有模组()
	return GameMain.tbMods
end

---获取游戏时间值 游戏里面一个小时值是:25  一天24小时 25*24=每天值600 假设游戏目前是 57天早上11点 公式(57*600+11*25-775)=34200+275-775=33700  这个-775是第一天7点开始 所以值需要-775
---@return number@返回时间值
function game.时间值()
	return CS.XiaWorld.World.Instance.TolSecond
end

---获取游戏当前天数
---@return number
function game.天数()
	local value=game.时间值()
	local v=math.floor((value+775)/600)
	return v
end

---获取游戏当前小时
---@return number
function game.小时()
	local value=game.时间值()
	print(value)
	local v=math.floor((value+775)%600/25)
	return v
end

--游戏是否加载中
function game.是否加载中()
	local is1=CS.XiaWorld.WorldMgr.Instance.IsLoading
	local is2=CS.XiaWorld.WorldMgr.Instance.FightLoading
	return is1 or is2
end

function game.获取定义组(name)

	if name=="建筑" then return CS.XiaWorld.ThingMgr.s_mapThingDefs[1]
	elseif name=="物品" then return CS.XiaWorld.ThingMgr.s_mapThingDefs[2]
	elseif name=="属性" then return CS.XiaWorld.PropertyMgr.s_mapProperties
	elseif name=="符咒" then return CS.XiaWorld.PracticeMgr.s_mapSpellDefs

	end
end