	maxscript可以做什么
1.	max脚本的基本操作环境
2.	执行第一条脚本代码  print("Hello MaxScript")
	添加函数的参数  box height:50
3.	了解相关知识点
	（变量的创建、使用、修改）（数组）
	选择的模型导出FBX  exportfile (maxfilepath+"/"+selection[1].name+".fbx")#noPrompt selectedOnly:true
4.	循环  for / while
	批量创建物体
	批量导出FBX文件


--选择批处理
clearselection()
for o = 75 to 91 do(
	execute("selectmore $Bo*"+o as string)
)

Sphere pos:[0,0,0] wirecolor:(color 150 20 10)
--偏移取i的2次方(i^2)
for i = 1 to 12 do sphere pos:[i^2,0,0] radius:i
Box pos:[0,0,0]
for i = 1 to 15 do box length:(i*2) width:(i*2) height:(i*2) pos:[i^2,0,0]
$.objectoffsetpos = [100,0,0]
$.pivot = [100,0,0]
--章鱼材质
meditMaterials[1].diffuseMap = Gradient ()
meditMaterials[1][#Maps][#Diffuse_Color__Gradient____Gradient].color1 = color 102 0 0
meditMaterials[1][#Maps][#Diffuse_Color__Gradient____Gradient].color2 = color 225 122 71
meditMaterials[1][#Maps][#Diffuse_Color__Gradient____Gradient].color3 = color 255 225 160
meditMaterials[1][#Maps][#Diffuse_Color__Gradient____Gradient].coords.V_Mirror = true
max modify mode
allbox = #()
for i in 1 to 12 do(
	siz = 10*i
	newpos = 5*i*i
	bb=box length:siz width:siz height:siz pos:[newpos,0,0] pivot:[(newpos+siz/2),0,0] wirecolor:(color 225 87 143) material:meditMaterials[1]
	select bb
	modPanel.addModToSelection (Uvwmap ()) ui:on
	bb.modifiers[#UVW_Map].axis = 1
	bb.modifiers[#UVW_Map].vtile = 0.97
	showTextureMap bb.material on
	torus radius1:(i+i*0.25) radius2:i parent:bb pos:[newpos,-siz/4,0] wirecolor:(color 255 199 172) smooth:5
	torus radius1:(i+i*0.25) radius2:i parent:bb pos:[newpos,siz/4,0] wirecolor:(color 228 166 137) smooth:5
	append allbox bb
)
for o in 1 to allbox.count do if o < allbox.count do allbox[o].parent = allbox[o+1]
delete allbox

--排除选择
deselect $To*

environmentMap = Bitmaptexture fileName:"$scripts\oxTOOLSfiles\TmpScene\BG.bmp"
environmentMap.coords.mappingType=2
environmentMap.coords.mapping=3
ambientColor = color 101 101 101
bm=(bitmap renderwidth renderheight color:red)
render outputwidth:renderWidth outputheight:renderHeight frame:1 pos:#vfb_upper_left to:bm
display bm

unDisplay bm

--3示例
max reset file
--选择编号3-7区间，使用执行字符串命令
clearselection()
for o = 3 to 7 do(
	execute("selectmore $B*"+o as string)
)

Sphere pos:[0,0,0] wirecolor:(color 50 200 190)
Box pos:[0,0,0]
--循环创建偏移盒子
for i in 1 to 6 do(
	box length:(10*i) width:(10*i) height:(10*i) pos:[5*i*i,0,0]
)

--调用MAX外部程序
thePath = maxfilepath + "newFolder"
makedir thePath
--运行window的Explorer浏览器,并打开目录
shellLaunch "Explorer.EXE" thePath

--选择被赋予材质编辑器里当前选择的材质球的物体
select (for o in objects where o.material == medit.GetCurMtl() collect o)


--遍历抽取不重复的值
A = #(2,6,2,2,4,4,5)
B = #()
for o in A do(
	if finditem B o == 0 do append B o
)
B = #(2, 6, 4, 5)