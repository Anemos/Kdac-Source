$PBExportHeader$uo_treeview_two.sru
$PBExportComments$Treeview user object( dataobject가 두개) 해당dataobject는 data는 code, labe은 name으로 정의되어있어야함
forward
global type uo_treeview_two from userobject
end type
type dw_1 from datawindow within uo_treeview_two
end type
type tv_1 from treeview within uo_treeview_two
end type
type st_pin from statictext within uo_treeview_two
end type
type gb_1 from groupbox within uo_treeview_two
end type
end forward

global type uo_treeview_two from userobject
integer width = 887
integer height = 1388
long backcolor = 79218872
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
event type integer ue_populate ( )
event ue_resize ( unsignedlong syzetype,  integer newwidth,  integer newheight )
event ue_pop ( integer li_level )
event ue_hide ( integer hidewidth,  integer hideheight )
event ue_select ( integer ai_level,  string as_one,  string as_two,  string as_title )
event ue_change_check ( ref boolean ab_change )
event ue_show ( )
dw_1 dw_1
tv_1 tv_1
st_pin st_pin
gb_1 gb_1
end type
global uo_treeview_two uo_treeview_two

type variables
string		is_title, is_dataobject1, is_dataobject2
integer		ii_uo_border=15	//Window border to be used on all sides
DataStore	ids_Data[2]

end variables

forward prototypes
public function integer uf_add_item (long al_parent, integer ai_level, integer ai_rows, boolean ab_security)
public function integer of_retrieve_data (long al_handle)
public function treeviewitem uf_set_tv_item (integer ai_level, integer ai_row, ref treeviewitem atvi_new, boolean ab_security)
end prototypes

event ue_populate;Integer			li_Rows
Long				ll_Root
TreeViewItem	ltvi_Root

SetPointer(HourGlass!)
This.SetRedraw(False)

// Add the root item
ltvi_Root.Label	=	is_title
ltvi_Root.Data		=	is_title
ltvi_Root.PictureIndex	=	1
ltvi_Root.SelectedPictureIndex	=	1
ltvi_Root.Children	=	True
ll_Root	=	tv_1.InsertItemLast(0, ltvi_Root)

tv_1.ExpandItem(ll_Root)
tv_1.SelectItem(ll_Root)

// Retrieve data of first level(Plant:Site)
ids_Data[1].Reset()
li_Rows = ids_Data[1].Retrieve()

This.SetRedraw(True)

return 1


end event

event ue_resize;int li_gb_h

SetRedraw(False)
li_gb_h	= gb_1.Height

gb_1.Resize(newwidth - 2 * ii_uo_border, li_gb_h)
gb_1.Move(ii_uo_border, ii_uo_border)

st_pin.Resize(newwidth - 4 * ii_uo_border , st_pin.Height)
st_pin.Move(ii_uo_border * 2 , ii_uo_border * 4)

tv_1.Resize(newwidth - (2 * ii_uo_border), newheight - (3 * ii_uo_border) - li_gb_h)
tv_1.Move(ii_uo_border, li_gb_h + (2 * ii_uo_border))

SetRedraw(True)

end event

event ue_select;CHOOSE CASE ai_level
	CASE 1
		st_pin.Text	= is_title
	CASE ELSE
		st_pin.Text	= as_title
END CHOOSE
end event

event ue_change_check;ab_change = True
end event

event ue_show;tv_1.width	= width - ii_uo_border * 3
tv_1.height = height - st_pin.height - ii_uo_border * 6
end event

public function integer uf_add_item (long al_parent, integer ai_level, integer ai_rows, boolean ab_security);Integer				li_cnt
TreeViewItem		ltvi_new

uf_set_tv_item(ai_level, ai_rows, ltvi_new, ab_security)

if ab_security and ai_level = 3 then	
	If tv_1.InsertItemFirst(al_parent, ltvi_new) < 1 Then
		MessageBox("Error", "Error inserting item", Exclamation!)
		Return -1
	End If
else
	If tv_1.InsertItemLast(al_parent, ltvi_new) < 1 Then
		MessageBox("Error", "Error inserting item", Exclamation!)
		Return -1
	End If
end if

Return ai_rows
end function

public function integer of_retrieve_data (long al_handle);Integer			li_level
Long				ll_parent, ll_root
TreeViewItem	ltvi_current, ltvi_parent, ltvi_root

// Determine the level
tv_1.GetItem(al_Handle, ltvi_current)
li_level = ltvi_current.Level

If li_level = 1 Then
	ids_Data[li_level].Reset()
	Return ids_Data[li_level].Retrieve()
ElseIf li_level = 2 Then
	ids_Data[li_level].Reset()
	Return ids_Data[li_level].Retrieve(ltvi_current.Data)
End If

end function

public function treeviewitem uf_set_tv_item (integer ai_level, integer ai_row, ref treeviewitem atvi_new, boolean ab_security);long		ll_row
string	ls_winname, ls_winid
// Set the Lable and Data attributes for the new item from the data in the DataStore
Choose Case ai_level
	Case 2
		atvi_new.Data	=	ids_Data[1].Object.code[ai_row]
		atvi_new.Label	=	ids_Data[1].Object.name[ai_row]
	Case 3
		atvi_new.Data	=	ids_Data[2].Object.pgmname[ai_row]
		atvi_new.Label	=	ids_Data[2].Object.pgmname[ai_row]
End Choose

If ai_level < 3 Then
	atvi_new.Children = True
Else
	atvi_new.Children = False
End If

atvi_new.PictureIndex	=	ai_level

// 보안 관리(highlight)
if ab_security then
	atvi_new.SelectedPictureIndex	=	6
	// 라벨에 읽기전용 표시
	ls_winname	=	atvi_new.data
	ll_row		=	dw_1.find("pgmname = '" + ls_winname + "'", 1, dw_1.rowcount())
	if ll_row <= 0 then return atvi_new
	ls_winid		=	dw_1.getitemstring(ll_row, 'pgmid')
//	if not f_security(ls_winid, g_s_empno, gs_group, '_INSERT_') then
//		atvi_new.label		=	atvi_new.label + "(읽기전용)"
//	end if
else
	atvi_new.SelectedPictureIndex	=	ai_level
	atvi_new.CutHighLighted			=	true
end if

Return atvi_new
end function

event constructor;SetRedraw(False)

BringToTop = True

// In korea version case
ids_Data[1] = Create DataStore
ids_Data[1].DataObject = is_dataobject1
ids_Data[1].SetTransObject(sqlcmms)

ids_Data[2] = Create DataStore
ids_Data[2].DataObject = is_dataobject2
ids_Data[2].SetTransObject(sqlcmms)

//
dw_1.settransobject(sqlcmms)
dw_1.retrieve('%', '%')

TriggerEvent("ue_populate")
SetRedraw(True)
end event

on uo_treeview_two.create
this.dw_1=create dw_1
this.tv_1=create tv_1
this.st_pin=create st_pin
this.gb_1=create gb_1
this.Control[]={this.dw_1,&
this.tv_1,&
this.st_pin,&
this.gb_1}
end on

on uo_treeview_two.destroy
destroy(this.dw_1)
destroy(this.tv_1)
destroy(this.st_pin)
destroy(this.gb_1)
end on

type dw_1 from datawindow within uo_treeview_two
integer x = 448
integer width = 411
integer height = 152
integer taborder = 30
string title = "none"
string dataobject = "d_tv_pgm"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;visible	=	false
end event

type tv_1 from treeview within uo_treeview_two
event ue_mousemove pbm_mousemove
integer y = 136
integer width = 873
integer height = 1252
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
string picturename[] = {"WinLogo!","Window!","Window!","Custom080!","Custom035!","Next!"}
integer picturewidth = 16
integer pictureheight = 16
long picturemaskcolor = 553648127
string statepicturename[] = {""}
long statepicturemaskcolor = 553648127
end type

event itempopulate;Integer				li_Rows, li_Level, i
string				ls_pgmname, ls_pgmid
long					ll_row
TreeViewItem		ltvi_Current

SetPointer(HourGlass!)

// Determine the level
GetItem(handle, ltvi_Current)
li_Level = ltvi_Current.Level

if li_level < 3 then
// Retrieve the data
	li_Rows = of_retrieve_data(handle)
	for i = 1 to li_rows
		if li_level = 2 then
			ls_pgmname		=	ids_Data[2].Object.pgmname[i]
			//ls_pgmname = ids_Data[2].GetItemString(i,'pgmname')
			ll_row			=	dw_1.find("pgmname ='" + ls_pgmname + "'", 1, dw_1.rowcount())
			ls_pgmid			=	dw_1.getitemstring(ll_row, 'pgmid')
//			if f_security_pgm(ls_pgmid, g_s_empno, gs_group) then
//				uf_add_item(handle, li_Level + 1, i, true)
//			else
				uf_add_item(handle, li_Level + 1, i, false)
//			end if
		else
			uf_add_item(handle, li_Level + 1, i, true)
		end if
	next
end if
end event

event selectionchanged;// Populate the ListView with this item's children
Integer			li_rows, li_level
Long				ll_parent, ll_super, ll_root
String			ls_one, ls_two, ls_title
TreeViewItem	ltvi_current, ltvi_parent

SetPointer(HourGlass!)

// Determine the level
GetItem(newhandle, ltvi_current)
li_level = ltvi_current.Level

If li_level < 3 Then
	//Retrieve child items
	li_rows = of_retrieve_data(newhandle)
End if

ls_title	= ltvi_current.Label

If li_level = 2 Then
	ls_one	=	Trim(ltvi_current.Data)
	ls_two	=	'%'
ElseIf li_level = 3 Then
	ll_parent = tv_1.FindItem(ParentTreeItem!, newhandle)
	tv_1.GetItem(ll_parent, ltvi_parent)
	ls_one	=	Trim(ltvi_parent.Data)
	ls_two	=	Trim(ltvi_current.Data)
End If

Parent.Post Event ue_select(li_level, ls_one, ls_two, ls_title)
end event

event rightclicked;Integer				li_Level
TreeViewItem		ltvi_Current

SetPointer(HourGlass!)

// Determine the level
GetItem(handle, ltvi_Current)
li_Level = ltvi_Current.Level

Parent.Trigger Event ue_pop(li_Level)
end event

event selectionchanging;boolean lb_change

Parent.Event Trigger ue_change_check(lb_change)

If lb_change Then
	Return 0
Else
	Return 1
End If
end event

event doubleclicked;window			lw_win
treeviewitem	ltvi
string	ls_winname, ls_winid
long		ll_row

getitem(handle, ltvi)
	  
if ltvi.level = 3 and ltvi.CutHighLighted = false then
	ls_winname	=	ltvi.data
	ll_row	=	dw_1.find("pgmname = '" + ls_winname + "'", 1, dw_1.rowcount())
	
	if ll_row <= 0 then return
	
	ls_winid	=	dw_1.getitemstring(ll_row, 'pgmid')

	//// 동일 class 제외
	lw_win = w_frame.GetFirstSheet()
	
	DO WHILE IsValid (lw_win)
		If Upper(ls_winid) = Upper(lw_win.ClassName()) then 
			lw_win.setposition(totop!)
			return
		end if
		lw_win = w_frame.GetNextSheet(lw_win)
	LOOP 
	//m_sys_menu.mf_open_sheet(ls_winid)
end if


end event

type st_pin from statictext within uo_treeview_two
event ue_mousemove pbm_mousemove
integer x = 27
integer y = 40
integer width = 818
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 16711680
long backcolor = 79218872
string text = "All Plant "
boolean focusrectangle = false
end type

type gb_1 from groupbox within uo_treeview_two
integer x = 9
integer width = 869
integer height = 128
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79218872
end type

