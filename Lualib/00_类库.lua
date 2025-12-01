--此文件不会加载到游戏内 只是为了给智能识别用的









--#region Base
---@class Base
---@type Base
local Base={}
function Base:ToString() end
---@return Tyep
function Base:GetType() end
--#endregion

--#region List
---@class List:Base
---@field Count number@数组成员数
---@type List
local List={}

---增加数组成员
function List.Add() end
---清空数组
function List:Clear() end
---合并数组
function List:AddRange() end
---寻找
function List:Find() end
---寻找匹配数组
function List:FindAll() end
---遍历循环
function List:ForEach() end
---寻找第一个匹配的索引
function List:IndexOf() end
---插入
function List:Insert() end
---插入数组
function List:InsertRange() end
---移除匹配项目
function List:Remove() end
---移除匹配项目
function List:RemoveAll() end
---移除指定索引
function List:RemoveAt() end
---移除一定范围内的项目
function List:RemoveRange() end
---顺序翻转
function List:Reverse() end
---默认比较器进行排序
function List:Sort() end
---转到 数组 T[]
---@return Array
function List:ToArray() end

function List:Contains() end

--#endregion

--#region Dictionary
---@class Dictionary:Base
---@field Count number@词典的数量
---@field Keys any@所有键组
---@field Values any@所有值组
---@type Dictionary
local Dictionary={}
---增加词典内容
---@param key any@键
---@param value any@值
function Dictionary:Add(key,value) end

---清除词典内容
function Dictionary:Clear() end

---寻找键是否在词典内
---@param key any@键
---@return boolean@如果存在返回true 不存在返回false
function Dictionary:ContainsKey(key) end

---寻找键是否在词典内
---@param value any@值
---@return boolean@如果存在返回true 不存在返回false
function Dictionary:ContainsValue(value) end

---移除词典某个键
---@param key any@键
---@return boolean@如果成功返回true 失败返回false
function Dictionary:Remove(key) end

---尝试从词典获取某个值
---@param key any@键
---@return boolean,any@有两个返回第一个是返回是否成功获取  第二个返回获取值
function Dictionary:TryGetValue(key) end

--#endregion

--#region Array
---@class Array:Base
---@field Length number
---@field Rank number

---@type Array
local Array={}
function Array:Clone() end
function Array:GetLength() end
function Array:GetLowerBound() end
function Array:GetUpperBound() end
function Array:GetValue() end
function Array:SetValue() end

--#endregion

--#region ArrayList
---@class ArrayList:Base
---@field Count number
---@type ArrayList
local ArrayList={}
function ArrayList:Add() end
function ArrayList:AddRange() end
function ArrayList:AddRange() end
function ArrayList:Clear() end
function ArrayList:Contains() end
function ArrayList:Insert() end
function ArrayList:InsertRange() end
function ArrayList:Remove() end
function ArrayList:RemoveAt() end
function ArrayList:RemoveRange() end
function ArrayList:ToArray() end

--#endregion

--#region Tyep
---@class Tyep
---@field Name string
---@field BaseType Tyep
---@field Attributes any@关联属性
---@field IsArray boolean
---@field GenericTypeArguments any@泛型类型

---@type Tyep
local Tyep={}
function Tyep:GetMethod() end
function Tyep:GetTypes() end
function Tyep:GetEnumName() end
function Tyep:GetEnumNames() end
function Tyep:GetEvent() end
function Tyep:GetEvents() end
function Tyep:GetField() end
function Tyep:GetFields() end
function Tyep:GetMember() end

---@return Array
function Tyep:GetMembers() end
function Tyep:GetMethod() end
---@return Array
function Tyep:GetMethods() end
function Tyep:GetNestedType() end
---@return Array
function Tyep:GetNestedTypes() end
function Tyep:GetProperty() end
function Tyep:GetProperties() end

--#endregion

--#region Assembly
---@class Assembly:Base

---@type Assembly
local Assembly={}
function Assembly:GetType() end
function Assembly:GetTypes() end
---创建实例
function Assembly:CreateInstance(name) end
function Assembly:GetName() end

--#endregion

--#region ModBase

---@class ModBase
---@field name string
---@type ModBase
local ModBase={}

---游戏初始化的时候
function ModBase:OnInit() end

---游戏进入地图触发
function ModBase:OnEnter() end

---逻辑帧间隔  dt是帧间隔  每帧都会执行一次 如果大量加载数据容易影响游戏卡顿
---@param dt number@游戏每一帧的间隔时间
function ModBase:OnStep(dt) end

---渲染帧间隔 dt是帧间隔  每帧都会执行一次 如果大量加载数据容易影响游戏卡顿
---@param dt number@游戏每一帧的间隔时间
function ModBase:OnRender(dt) end

---游戏离开地图触发
function ModBase:OnLeave() end

---游戏保存的时候触发   返回的表(table)  会写入存档文件内部 表(table)会经过  Lib:Serialize 转为txt 写入存档文件
---@return table
function ModBase:OnSave() end

---游戏读取的时候触发 读取存档文件中 表(tab)的数据  txt会经过 Lib:Unserialize(txt) 转为表(tab)  来源于OnSave return tab 的数据
---@param tab table@这个参数是回调返回的参数
function ModBase:OnLoad(tab) end

--切换地图是否同步保存数据  切换地图同步数据
---@return boolean@如果要同步则return true  不同步则return false
function ModBase:NeedSyncData() end

---切换地图保存数据 table是一个表  这个表(table)  会写入存档文件内部 表(table)会经过  Lib:Serialize 转为txt 写入存档文件
---@return table@
function ModBase:SyncSave() end

---游戏读取的时候触发 读取存档文件中 表(tab)的数据  txt会经过 Lib:Unserialize(txt) 转为表(tab)  来源于SyncSave return tab 的数据
function ModBase:OnSyncLoad(tab) end

---切换地图 或者 读取存档调用 所有数据准备就绪后触发  优先级在 OnLoad 后
function ModBase:OnAfterLoad() end

---这个会在所有初始化之前调用(包含MOD本身)，大量的对象都还不存在，用于处理一些与系统数据相关的逻辑，谨慎使用 优先级比 init快  建议使用一些基础的系统API
function ModBase:OnBeforeInit() end

---ID为快捷键注册时的编码，编码需要是唯一的，不可为空  如  "F9键"
---Name为快捷键的名称，会显示到快捷键面板上   如"测试按键"
---Type为快捷键所属类别，快捷键会根据类别自动分类  "Mod" "天堂分类"
---InitialKey1 InitialKey2 为快捷键的第一组和第二组 按键，使用"+"进行连接组合键位，键位请阅读快捷键列表找到所需要的键盘编码，可以为空 如  "LeftControl+K"组合键  "Alpha1"数字1  "LeftShift+K"
---设置热键
---@return table@表的格式需要注意 需要:{ {ID = "测试键" , Name = "Mod测试按键" , Type = "Mod", InitialKey1 = "LeftShift+K" , InitialKey2 = "Equals" } }
function ModBase:OnSetHotKey() end

---按下热键触发
---@param ID string@ID为快捷键注册时的编码，系统识别快捷键的唯一标识 如上面的"测试键"
---@param state string@快捷键当前操作状态，按下state="down"，持续state="stay"，离开state="up"
function ModBase:OnHotKey(ID,state) end

--#endregion






--#region Windowb

---@class Windowb
---@field window Window

---@type Windowb
local Windowb={}
---窗口初始化 可以覆写
function Windowb:OnInit() end
---打开显示后 可以覆写
function Windowb:OnShown() end
---窗口被隐藏 可以覆写
function Windowb:OnHide() end
---打开显示更新 可以覆写
function Windowb:OnShowUpdate() end
---帧间隔刷新 每一帧都会触发 处理不好容易卡顿
---@param dt number@帧间隔
function Windowb:OnUpdate(dt) end
---触发对象事件
---@param type string@事件类型 例如 "onClick","onKeyDown","onClickLink","onRightClick","onClickLink"
---@param obj any@事件对象
---@param context EventContext@来源是以上两项的根 也可以额外获取特殊的类型
function Windowb:OnObjectEvent(type,obj,context) end

---获取子组件
---@param name string@子组件的名字 类似这种 m_title
function Windowb:GetChild(name) end

---窗口初始化不要 覆写 可以调用
function Windowb:Init() end
---显示窗口  不要 覆写 可以调用
function Windowb:Show() end
---隐藏窗口  不要 覆写 可以调用
function Windowb:Hide() end


---增加对象到窗口组件 可以调用
---@param url string@FGUI文件组件路径 类似这种 ui://0xrxw6g7wbawovog
---@param x number@添加后的x坐标
---@param y number@添加后的y坐标
function Windowb:AddObjectFromUrl(url,x,y) end

---设置窗口尺寸 可以调用
---@param w number@宽度
---@param h number@高度
function Windowb:SetSize(w,h) end

--#endregion

--#region Window

---@class Window:GComponent
---@field bringToFontOnClick any
---@field contentPane any
---@field frame any
---@field closeButton any
---@field dragArea any
---@field contentArea any
---@field isShowing any
---@field isTop any
---@field openani any
---@field noclose any

---@type Window
local Window={}
function Window:AddObj(obj,x,y) end
function Window:Show() end
function Window:Hide() end
function Window:HideImmediately() end
function Window:CenterOn() end
function Window:BringToFront() end
function Window:ShowModalWait() end
function Window:ShowModalWait() end
function Window:CloseModalWait() end
function Window:CloseModalWait() end
function Window:Init() end
function Window:Dispose() end

--#endregion

--#region GComponent

---@class GComponent:GObject
---@field rootContainer any
---@field container any
---@field scrollPane any
---@field onDrop any
---@field fairyBatching any
---@field opaque any
---@field margin any
---@field childrenRenderOrder any
---@field apexIndex any
---@field numChildren any
---@field Controllers any
---@field clipSoftness any
---@field mask any
---@field reversedMask any
---@field baseUserData any
---@field viewWidth any
---@field viewHeight any
---@field pause_boundsChanged any

---@type GComponent
local GComponent={}
function GComponent:Dispose() end
function GComponent:InvalidateBatchingState() end
---加入对象到组件
---@param obj GObject
function GComponent:AddChild(obj) end
function GComponent:AddChildAt() end
function GComponent:RemoveChild() end
function GComponent:RemoveChild() end
function GComponent:RemoveChildAt() end
function GComponent:RemoveChildAt() end
function GComponent:RemoveChildren() end
function GComponent:RemoveChildren() end
function GComponent:GetChildAt() end
function GComponent:GetChild() end
function GComponent:GetChildByPath() end
function GComponent:GetVisibleChild() end
function GComponent:GetChildInGroup() end
function GComponent:GetChildren() end
function GComponent:GetChildIndex() end
function GComponent:SetChildIndex() end
function GComponent:SetChildIndexBefore() end
function GComponent:SwapChildren() end
function GComponent:SwapChildrenAt() end
function GComponent:IsAncestorOf() end
function GComponent:AddController() end
function GComponent:GetControllerAt() end
function GComponent:GetController() end
function GComponent:RemoveController() end
function GComponent:GetTransitionAt() end
function GComponent:GetTransition() end
function GComponent:IsChildInView() end
function GComponent:GetFirstChildInView() end
function GComponent:HandleControllerChanged() end
function GComponent:SetBoundsChangedFlag() end
function GComponent:EnsureBoundsCorrect() end
function GComponent:ConstructFromResource() end
function GComponent:ConstructFromXML() end
function GComponent:Setup_AfterAdd() end

--#endregion

--#region GObject

---@class GObject
---@field id string
---@field relations any
---@field parent any
---@field displayObject any
---@field onClick EventListener
---@field onRightClick EventListener
---@field onTouchBegin EventListener
---@field onTouchMove EventListener
---@field onTouchEnd EventListener
---@field onRollOver EventListener
---@field onRollOut EventListener
---@field onAddedToStage EventListener
---@field onRemovedFromStage EventListener
---@field onKeyDown EventListener
---@field onClickLink EventListener
---@field onRollOverLink EventListener
---@field onRollOutLink EventListener
---@field onPositionChanged EventListener
---@field onSizeChanged EventListener
---@field onDragStart EventListener
---@field onDragMove EventListener
---@field onDragEnd EventListener
---@field onGearStop EventListener
---@field x number
---@field y number
---@field z number
---@field xy Vector2
---@field position Vector3
---@field pixelSnapping any
---@field width number
---@field height number
---@field size any
---@field actualWidth any
---@field actualHeight any
---@field xMin number
---@field yMin number
---@field scaleX number
---@field scaleY number
---@field scale any
---@field skew any
---@field pivotX number
---@field pivotY number
---@field pivot any
---@field pivotAsAnchor any
---@field touchable any
---@field grayed any
---@field enabled any
---@field rotation any
---@field rotationX number
---@field rotationY number
---@field alpha any
---@field visible boolean
---@field sortingOrder any
---@field focusable any
---@field focused any
---@field tooltips any
---@field filter any
---@field blendMode any
---@field gameObjectName any
---@field inContainer any
---@field onStage any
---@field resourceURL string
---@field gearXY any
---@field gearSize any
---@field gearLook any
---@field group any
---@field root any
---@field text string
---@field fontsize any
---@field icon any
---@field draggable any
---@field dragging any
---@field isDisposed any
---@field asImage any
---@field asCom any
---@field asButton any
---@field asLabel any
---@field asProgress any
---@field asSlider any
---@field asComboBox any
---@field asTextField any
---@field asRichTextField any
---@field asTextInput any
---@field asLoader any
---@field asList any
---@field asGraph any
---@field asGroup any
---@field asMovieClip any
---@field asTree any
---@field treeNode any
---@field IsDraging any
---@field name string
---@field data any
---@field data2 any
---@field data3 any
---@field data4 any
---@field data5 any
---@field sourceWidth any
---@field sourceHeight any
---@field initWidth any
---@field initHeight any
---@field minWidth any
---@field maxWidth any
---@field minHeight any
---@field maxHeight any
---@field dragBounds any
---@field packageItem any
---@field LocalDrag any
---@field IsRollOver any

---@type GObject
local GObject={}
function GObject:SetXY() end
function GObject:SetXY() end
function GObject:SetPosition() end
function GObject:Center() end
function GObject:CenterTop() end
function GObject:LeftTop() end
function GObject:LeftBottom() end
function GObject:RightTop() end
function GObject:RightBottom() end
function GObject:RightCenter() end
function GObject:MidBottom() end
function GObject:Center() end
function GObject:MakeFullScreen() end
---设置尺寸
---@param w number@宽度
---@param h number@高度
function GObject:SetSize(w,h) end
function GObject:GetGlobleScale() end
function GObject:SetSize() end
function GObject:SetScale() end
function GObject:SetPivot() end
function GObject:SetPivot() end
function GObject:RequestFocus() end
function GObject:SetTooltip() end
function GObject:SetHome() end
function GObject:GetGear() end
function GObject:InvalidateBatchingState() end
function GObject:HandleControllerChanged() end
function GObject:AddRelation() end
function GObject:AddRelation() end
function GObject:RemoveRelation() end
function GObject:RemoveFromParent() end
function GObject:StartDrag() end
function GObject:StartDrag() end
function GObject:StopDrag() end
function GObject:LocalToGlobal() end
function GObject:GlobalToLocal() end
function GObject:LocalToGlobal() end
function GObject:GlobalToLocal() end
function GObject:LocalToRoot() end
function GObject:RootToLocal() end
function GObject:WorldToLocal() end
function GObject:WorldToLocal() end
function GObject:TransformPoint() end
function GObject:TransformRect() end
function GObject:Dispose() end
function GObject:ConstructFromResource() end
function GObject:Setup_BeforeAdd() end
function GObject:Setup_AfterAdd() end
function GObject:TweenMove() end
function GObject:TweenMoveX() end
function GObject:TweenMoveY() end
function GObject:TweenScale() end
function GObject:TweenScaleX() end
function GObject:TweenWidth() end
function GObject:TweenHeight() end
function GObject:TweenScaleY() end
function GObject:TweenResize() end
function GObject:TweenFade() end
function GObject:TweenRotate() end
function GObject:KillAllTween() end

--#endregion

--#region GRichTextField

---@class GRichTextField:GTextField
---@field richTextField any
---@field emojies any


--#endregion

--#region GTextField

---@class GTextField:GObject
---@field fontsize any
---@field text any
---@field templateVars any
---@field textFormat any
---颜色
---@field color Color
---@field align any
---@field verticalAlign any
---@field singleLine any
---@field stroke any
---@field strokeColor any
---@field shadowOffset any
---@field UBBEnabled any
---@field autoSize any
---@field textWidth any
---@field textHeight any
---@field textParentScrollPaneWidth any

---@type GTextField
local GTextField={}
function GTextField:SetVar() end
function GTextField:FlushVars() end
function GTextField:HasCharacter() end
function GTextField:UpdateSize() end
function GTextField:Setup_BeforeAdd() end
function GTextField:Setup_AfterAdd() end

--#endregion

--#region GButton

---@class GButton:GComponent
---@field onChanged EventListener
---@field fontsize any
---@field icon any
---@field title any
---@field text any
---@field selectedIcon any
---@field selectedTitle any
---@field titleColor any
---@field color any
---@field titleFontSize any
---@field selected any
---@field mode any
---@field relatedController any
---@field relatedPageId any
---@field sound any
---@field soundVolumeScale any
---@field changeStateOnClick any
---@field linkedPopup any

---@type GButton
local GButton={}
function GButton:FireClick() end
function GButton:GetTextField() end
function GButton:HandleControllerChanged() end
function GButton:Setup_AfterAdd() end

--#endregion


--#region GImage

---@class GImage:GObject
---@field color any
---@field flip any
---@field fillMethod any
---@field fillOrigin any
---@field fillClockwise any
---@field fillAmount any
---@field texture any
---@field material any
---@field shader any

---@type GImage
local GImage={}
function GImage:ConstructFromResource() end
function GImage:Setup_BeforeAdd() end

--#endregion

--#region GLoader

---@class GLoader:GObject
---资源路径
---@field url string
---@field icon any
---@field align any
---@field verticalAlign any
---@field fill any
---是否只能缩小
---@field shrinkOnly boolean
---@field autoSize any
---@field playing any
---@field frame any
---@field timeScale any
---@field ignoreEngineTimeScale any
---@field material any
---@field shader any
---@field color any
---@field fillMethod any
---@field fillOrigin any
---@field fillClockwise any
---@field fillAmount any
---@field image any
---@field movieClip any
---@field component any
---@field texture any
---@field filter any
---@field blendMode any
---@field showErrorSign any

---@type GLoader
local GLoader={}
function GLoader:Dispose() end
function GLoader:Advance() end
function GLoader:Setup_BeforeAdd() end

--#endregion

--#region GLabel

---@class GLabel:GComponent
---@field icon any
---@field title any
---@field fontsize any
---@field text any
---@field editable any
---@field titleColor any
---@field titleFontSize any
---@field color any

---@type GLabel
local GLabel={}
function GLabel:GetTextField() end
function GLabel:Setup_AfterAdd() end

--#endregion

--#region GGroup

---@class GGroup:GObject
---@field layout any
---@field lineGap any
---@field columnGap any
---@field excludeInvisibles any
---@field autoSizeDisabled any
---@field mainGridMinSize any
---@field mainGridIndex any

---@type GGroup
local GGroup={}
function GGroup:SetBoundsChangedFlag() end
function GGroup:EnsureBoundsCorrect() end
function GGroup:Setup_BeforeAdd() end
function GGroup:Setup_AfterAdd() end

--#endregion

--#region GComboBox

---@class GComboBox:GComponent
---@field onChanged EventListener
---@field icon any
---@field title any
---@field text any
---@field titleColor any
---@field titleFontSize any
---@field items table
---@field icons any
---@field values any
---@field tips any
---@field selectedIndex any
---@field selectionController any
---@field value any
---@field popupDirection any
---@field visibleItemCount any
---@field dropdown any

---@type GComboBox
local GComboBox={}
function GComboBox:GetTextField() end
function GComboBox:HandleControllerChanged() end
function GComboBox:Dispose() end
function GComboBox:Setup_AfterAdd() end
function GComboBox:UpdateDropdownList() end
function GComboBox:ShowDropdown() end
function GComboBox:GetComboList() end

--#endregion

--#region GList

---@class GList:GComponent
---@field onClickItem any
---@field onRightClickItem any
---@field layout any
---@field lineCount any
---@field columnCount any
---@field lineGap any
---@field columnGap any
---@field align any
---@field verticalAlign any
---@field autoResizeItem any
---@field itemPool any
---@field selectedIndex any
---@field selectionController any
---@field touchItem any
---@field isVirtual any
---@field numItems any
---@field defaultItem any
---@field foldInvisibleItems any
---@field needChangeScrollPos any
---@field selectionMode any
---@field itemRenderer any
---@field itemProvider any
---@field scrollItemToViewOnClick any

---@type GList
local GList={}
function GList:Dispose() end
function GList:GetFromPool() end
function GList:AddItemFromPool() end
function GList:AddItemFromPool() end
function GList:AddChildAt() end
function GList:RemoveChildAt() end
function GList:RemoveChildToPoolAt() end
function GList:RemoveChildToPool() end
---移除列表所有成员
function GList:RemoveChildrenToPool() end
function GList:RemoveChildrenToPool() end
function GList:GetSelection() end
function GList:GetSelection() end
function GList:AddSelection() end
function GList:RemoveSelection() end
function GList:ClearSelection() end
function GList:SelectAll() end
function GList:SelectNone() end
function GList:SelectReverse() end
function GList:HandleArrowKey() end
function GList:ResizeToFit() end
function GList:ResizeToFit() end
function GList:ResizeToFit() end
function GList:HandleControllerChanged() end
function GList:ScrollToView() end
function GList:ScrollToView() end
function GList:ScrollToView() end
function GList:GetFirstChildInView() end
function GList:ChildIndexToItemIndex() end
function GList:ItemIndexToChildIndex() end
function GList:SetVirtual() end
function GList:SetVirtualAndLoop() end
function GList:RefreshVirtualList() end
function GList:Setup_BeforeAdd() end
function GList:Setup_AfterAdd() end

--#endregion

--#region GTextInput

---@class GTextInput:GTextField
---@field inputTextField any
---@field onFocusIn EventListener
---@field onFocusOut EventListener
---@field onChanged EventListener
---@field onSubmit EventListener
---@field editable any
---@field hideInput any
---@field maxLength any
---@field restrict any
---@field displayAsPassword any
---@field caretPosition any
---@field promptText any
---@field keyboardInput any
---@field keyboardType any
---@field emojies any

---@type GTextInput
local GTextInput={}
function GTextInput:SetSelection() end
function GTextInput:ReplaceSelection() end
function GTextInput:Setup_BeforeAdd() end

--#endregion

--#region GGraph

---@class GGraph:GObject
---@field color any
---@field shape any

---@type GGraph
local GGraph={}
function GGraph:ReplaceMe() end
function GGraph:AddBeforeMe() end
function GGraph:AddAfterMe() end
function GGraph:SetNativeObject() end
function GGraph:DrawRect() end
function GGraph:DrawRoundRect() end
function GGraph:DrawEllipse() end
function GGraph:DrawPolygon() end
function GGraph:DrawPolygon() end
function GGraph:Setup_BeforeAdd() end

--#endregion



--#region Controller

---@class Controller
---@field onChanged EventListener
---@field selectedIndex any
---@field selectedPage any
---@field previsousIndex any
---@field previousPage any
---@field pageCount any
---@field name any

---@type Controller
local Controller={}
function Controller:Dispose() end
function Controller:SetSelectedIndex() end
function Controller:SetSelectedPage() end
function Controller:GetPageName() end
function Controller:GetPageId() end
function Controller:GetPageIdByName() end
function Controller:AddPage() end
function Controller:AddPageAt() end
function Controller:RemovePage() end
function Controller:RemovePageAt() end
function Controller:ClearPages() end
function Controller:HasPage() end
function Controller:RunActions() end
function Controller:Setup() end

--#endregion


--#region Transition


---@class Transition
---@field name any
---@field playing any
---@field timeScale any
---@field ignoreEngineTimeScale any
---@field invalidateBatchingEveryFrame any

---@type Transition
local Transition={}
function Transition:Play() end
function Transition:Play() end
function Transition:Play() end
function Transition:Play() end
function Transition:PlayReverse() end
function Transition:PlayReverse() end
function Transition:PlayReverse() end
function Transition:ChangePlayTimes() end
function Transition:SetAutoPlay() end
function Transition:Stop() end
function Transition:Stop() end
function Transition:SetPaused() end
function Transition:Dispose() end
function Transition:SetValue() end
function Transition:SetHook() end
function Transition:ClearHooks() end
function Transition:SetTarget() end
function Transition:SetDuration() end
function Transition:GetLabelTime() end
function Transition:OnTweenStart() end
function Transition:OnTweenUpdate() end
function Transition:OnTweenComplete() end
function Transition:Setup() end

--#endregion

--#region EventListener

---@class EventListener
---@field type any
---@field isEmpty any
---@field isDispatching any

---@type EventListener
local EventListener={}
function EventListener:AddCapture() end
function EventListener:RemoveCapture() end
function EventListener:Add() end
function EventListener:Remove() end
function EventListener:Add() end
function EventListener:Remove() end
function EventListener:Set() end
function EventListener:Set() end
function EventListener:Clear() end
function EventListener:Call() end
function EventListener:Call() end
function EventListener:BubbleCall() end
function EventListener:BubbleCall() end
function EventListener:BroadcastCall() end
function EventListener:BroadcastCall() end

--#endregion


--#region EventContext

---@class EventContext
---@field sender any
---@field initiator any
---@field inputEvent any
---@field isDefaultPrevented boolean
---@field type string
---@field data any

---@type EventContext
local EventContext={}
function EventContext:StopPropagation() end
function EventContext:PreventDefault() end
function EventContext:CaptureTouch() end

--#endregion

--#region Vector2

---@class Vector2
---@field Item any
---@field normalized any
---@field magnitude any
---@field sqrMagnitude any
---@field x any
---@field y any

---@type Vector2
local Vector2={}
function Vector2:Set() end
function Vector2:Scale() end
function Vector2:Normalize() end
function Vector2:ToString() end
function Vector2:ToString() end
function Vector2:GetHashCode() end
function Vector2:Equals() end
function Vector2:SqrMagnitude() end

--#endregion



---@class UI_WindowEmpty:GLabel
---@field m_frame UI_WindowFrame
---@field m_html GRichTextField

---@class UI_Button:GButton
---@field m_button Controller
---@field m_n1 GImage
---@field m_icon GLoader
---@field m_title GTextField

---@class UI_RichText:GLabel
---@field m_title GRichTextField

---@class UI_Com_Weather
---@field m_icon GLoader
---@field m_n51 GImage

---@class UI_WindowCloseButton
---@field m_button any
---@field m_Stay any
---@field m_icon any

---@class UI_WindowFrame:GLabel
---@field m_hasClose any
---@field m_hasHead any
---@field m_NoUpDown any
---@field m_HeadStay any
---@field m_lang any
---@field m_n0 any
---@field m_n8 any
---@field m_n9 any
---@field m_n10 any
---@field m_n12 any
---@field m_n13 any
---@field m_n11 any
---@field m_icon any
---@field m_contentArea any
---@field m_dragArea any
---@field m_n14 any
---@field m_n15 any
---@field m_title GTextField
---@field m_n16 any
---@field m_n5 UI_WindowCloseButton|GButton
---@field m_Btn_Comment any

---@class UI_itemget:GLabel
---@field m_sub UI_ModCreatCheckbox
---@field m_title GTextField
---@field m_n15 GGroup

---@class UI_ModCreatCheckbox:GButton
---@field m_button Controller
---@field m_Loading Controller
---@field m_n1 GImage
---@field m_n3 GImage
---@field m_load GImage
---@field m_t0 Transition

---@class UI_ComboBox:GComboBox
---@field m_button Controller
---@field m_n1 GImage
---@field m_n6 GImage
---@field m_title GTextField

---@class UI_Item_Storage:GLabel
---@field m_n24 GImage
---多选框列表组
---@field m_n17 GList
---@field m_n26 GImage
---@field m_title UI_Checkbox

---@class UI_Checkbox:GButton
---@field m_button Controller
---@field m_n1 GImage
---@field m_n6 GLoader
---@field m_n3 GImage
---@field m_title GTextField

---@class UI_consoleinput:GComponent
---@field m_desc GImage
---输入框FGUI组件
---@field m_title GTextInput

---@class UI_InputTextAreaSorcll:GComponent
---@field m_title GTextInput

---@class UI_MakerCom
---@field m_type Controller
---@field m_Mul Controller
---@field m_n162 GImage
---@field m_n145 GGraph
---@field m_title GRichTextField
---@field m_n144 UI_InputTextField
---@field m_box UI_ComboBox
---@field m_n147 GList
---@field m_n149 GList
---@field m_xtitle GRichTextField
---@field m_ntitle GRichTextField
---@field m_n154 UI_Checkbox
---@field m_n150 GList
---@field m_n159 GGroup
---@field m_n153 UI_InputTextField
---@field m_n161 GGroup

---@class UI_InputTextField
---@field m_n0 GImage
---@field m_title GTextInput

---@class UI_SelectIcon:GComponent
---@field m_frame UI_WindowFrame
---@field m_n254 GImage
---@field m_n251 GList
---@field m_n252 UI_Button


---@class UI_WindowNotebook:GComponent
---@field m_n120 GList
---@field m_frame UI_WindowFrame
---@field m_n122 GImage
---@field m_n119 UI_InputTextAreaSorcll





--#region CS
---@type CS
CS=CS

---@class CS
---@field System System
---uniyt引擎
---@field UnityEngine UnityEngine
---@field FairyGUI FairyGUI
---@field Wnd_LuaWindowBase any
---@field Wnd_Message any
---@field XiaWorld XiaWorld
---@field ModsMgr ModsMgr
---@field CangJingGeMgr CangJingGeMgr
---@field Assets Assets
---@field OpenDialogDir OpenDialogDir
---@field SelectDialogForWindows SelectDialogForWindows
---@field WebSocketSharp WebSocketSharp
---@field Wnd_ConsoleWindow Wnd_ConsoleWindow
---@field Unity Unity
---@field XmlHelper XmlHelper
---@field Wnd_SelectNpc Wnd_SelectNpc
---@

--#endregion


--#region System

---@class System
---@field String string
---@field Object any
---@field Int32 number
---@field Boolean boolean
---@field IO IO
---@field Reflection Reflection
---@field Collections Collections
---@field Text Text
---@field Diagnostics Diagnostics
---@field Threading Threading
---@field Media Media
---@field DateTime DateTime
---@field Xml Xml

--#endregion

--#region UnityEngine

---@class UnityEngine
---颜色
---@field Color Color
---@field Input Input
---@field GUIUtility GUIUtility
---@field Debug Debug

--#endregion





---@class KeyValuePair:Base
---@field Key any
---@field Value any


---@class Vector3:Base
---@field x number
---@field y number
---@field z number

--#region CS.UnityEngine.Color

---@class Color
---黑色
---@field black Color@黑色
---蓝色
---@field blue Color
---空色
---@field clear Color
---青色
---@field cyan Color
---灰白
---@field gray Color
---绿色
---@field green Color
---灰色
---@field grey Color
---品红
---@field magenta Color
---红色
---@field red Color
---白色
---@field white Color
---黄色
---@field yellow Color


--#endregion

--函数.系统.获取类成员到剪辑版(CS.XiaWorld.UI.InGame.UI_WindowNotebook,"UI_WindowNotebook",1)
--函数.系统.获取类成员到剪辑版(CS.FairyGUI.GGraph,"GGraph",1)
--lang.sys.info(CS.UnityEngine.Color,"CS.UnityEngine.Color",1)

