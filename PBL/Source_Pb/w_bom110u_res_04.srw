$PBExportHeader$w_bom110u_res_04.srw
$PBExportComments$호환품번 상위제품조회
forward
global type w_bom110u_res_04 from window
end type
type tv_1 from treeview within w_bom110u_res_04
end type
type dw_1 from datawindow within w_bom110u_res_04
end type
type cb_delete from commandbutton within w_bom110u_res_04
end type
type cb_cancel from commandbutton within w_bom110u_res_04
end type
end forward

global type w_bom110u_res_04 from window
integer x = 498
integer y = 500
integer width = 2834
integer height = 1444
boolean titlebar = true
string title = "Option 품목 BOM 오류 수정"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
tv_1 tv_1
dw_1 dw_1
cb_delete cb_delete
cb_cancel cb_cancel
end type
global w_bom110u_res_04 w_bom110u_res_04

type variables
string is_plant,is_div, is_pitno, is_parm, is_errchk
datastore ids_data1
end variables

forward prototypes
public subroutine wf_set_items (integer ag_level, integer ag_row, readonly treeviewitem ag_tvinew)
public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this)
public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent)
end prototypes

public subroutine wf_set_items (integer ag_level, integer ag_row, readonly treeviewitem ag_tvinew);ag_tvinew.data = ids_data1.object.ofitn[ag_row]
ag_tvinew.label = ids_data1.object.ofitn[ag_row] + "      Option 부 품번 "
ag_tvinew.pictureindex = 1
ag_tvinew.selectedpictureindex = 2
ag_tvinew.children = false

end subroutine

public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this);Integer			ln_Cnt
TreeViewItem	l_tvi_New
For ln_Cnt = 1 To ag_Rows
	// TreeView의 Item에 각각의 값을 Setting시킨다.
	
	wf_set_items(ag_Level, ln_Cnt, l_tvi_New)
	
	// TreeView에 Item을 추가시킨다.
	If ag_this.InsertItemLast(ag_Parent, l_tvi_New) < 1 Then
		Return -1
	End If
Next

Return ag_Rows
end function

public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent);Integer			ln_Level, ln_count
TreeViewItem	l_tvi_Current
Treeview			l_tv_current

SetPointer(HourGlass!)

// Determine the level
ag_tvcurrent.GetItem(ag_handle, l_tvi_Current)
ln_Level = l_tvi_Current.Level
ids_data1.reset()
ln_count = ids_data1.retrieve(is_plant,is_div,is_pitno,g_s_date)
wf_add_items(ag_handle,ln_level,ln_count,ag_tvcurrent)


end subroutine

on w_bom110u_res_04.create
this.tv_1=create tv_1
this.dw_1=create dw_1
this.cb_delete=create cb_delete
this.cb_cancel=create cb_cancel
this.Control[]={this.tv_1,&
this.dw_1,&
this.cb_delete,&
this.cb_cancel}
end on

on w_bom110u_res_04.destroy
destroy(this.tv_1)
destroy(this.dw_1)
destroy(this.cb_delete)
destroy(this.cb_cancel)
end on

event open;treeviewitem l_tvi_root
long ln_tvi
integer ln_root,ln_count
Datawindowchild idwc_child

setpointer(hourglass!)
dw_1.settransobject(sqlca)
dw_1.getchild("pwkct",idwc_child)
idwc_child.settransobject(sqlca)
idwc_child.reset()
select	count(*)	into	:ln_count	from pbpdm.bom014
	where	comltd	=	'01'	and	empno	=	:g_s_empno
	using	sqlca	;
if	ln_count	>	0	then
	idwc_child.retrieve(g_s_empno)
else
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'')
	idwc_child.setitem(1,"dac001_dname",'')
	idwc_child.setitem(1,"display",'')
end if
dw_1.object.pwkct.protect = true
dw_1.object.pwkct.background.color = rgb(192,192,192)      
is_parm = message.stringparm
is_plant 	= mid(is_parm,1,1)
is_div 		= mid(is_parm,2,1)
is_pitno 	= mid(is_parm,3,12)
is_errchk = "C"
ids_data1 	= create Datastore
ids_data1.dataobject = "d_bom001_secitem"
ids_data1.settransobject(sqlca)
ln_tvi = tv_1.FindItem(roottreeitem!, 0)
tv_1.DeleteItem(ln_tvi)
ids_data1.reset()
l_tvi_root.label = is_pitno + "      Option 주 품번 "
l_tvi_root.data  = is_pitno
l_tvi_root.pictureindex = 1
l_tvi_root.selectedpictureindex = 2
l_tvi_root.children = true
ln_root = tv_1.insertitemlast(0,l_tvi_root)
tv_1.expanditem(ln_root)




end event

event close;is_parm = is_errchk
destroy ids_data1
closewithreturn(this, is_parm)
end event

type tv_1 from treeview within w_bom110u_res_04
integer y = 44
integer width = 1102
integer height = 1104
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
integer indent = 1
boolean tooltips = false
grsorttype sorttype = ascending!
string picturename[] = {"Custom039!","Custom050!","",""}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event itempopulate;Integer			ln_Level
TreeViewItem	l_tvi_Current

// Determine the level
tv_1.GetItem(handle, l_tvi_Current)
ln_Level = l_tvi_Current.Level

if ln_level >= 3 then 
	return
end if
wf_itempopulate(handle, tv_1)

end event

event selectionchanged;string 		ls_itno
integer	ln_count
treeviewitem l_tvi_item	
datawindowchild		idwc_child

tv_1.getitem(newhandle, l_tvi_item)
ls_itno = trim(l_tvi_item.data)	

dw_1.getchild("pwkct",idwc_child)
idwc_child.settransobject(sqlca)
idwc_child.reset()
select	count(*)	into	:ln_count	from pbpdm.bom014
	where	comltd	=	'01'	and	empno	=	:g_s_empno
	using	sqlca	;
if	ln_count	>	0	then
	idwc_child.retrieve(g_s_empno)
else
	idwc_child.insertrow(0) 
	idwc_child.setitem(1,"dac001_dcode",'')
	idwc_child.setitem(1,"dac001_dname",'')
	idwc_child.setitem(1,"display",'')
end if

dw_1.retrieve(is_plant,is_div,ls_itno,g_s_date)





end event

type dw_1 from datawindow within w_bom110u_res_04
integer x = 1138
integer y = 44
integer width = 1627
integer height = 1108
integer taborder = 10
string title = "none"
string dataobject = "d_bom001_implo_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;this.selectrow(0,false)
this.selectrow(row,true)

end event

type cb_delete from commandbutton within w_bom110u_res_04
integer x = 1829
integer y = 1192
integer width = 457
integer height = 104
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "BOM 삭제"
end type

event clicked;integer 	ln_yesno, ln_count, i, ln_chk_count, ln_row, ls_lolevchk, k 
string 	ls_wkct, ls_ppitn, ls_pcitn, ls_edtm, ls_edte, ls_exdv, ls_empno
string 	ls_rout, ls_oscd, ls_ebst, ls_chdt, ls_indt, ls_citno[]
dec{3}  	ld_qtym,	ld_qtye
long 		ln_handle
treeviewitem l_tvi_item

ln_yesno = messagebox("확인", "선택된 상위 품번의 모든 Option 품번을 삭제하시겠습니까 ?",Question!,OkCancel!,2)
if ln_yesno <> 1 then
	return
end if
setpointer(hourglass!)
ln_row = dw_1.getrow()
if ln_row = 0 then
	messagebox("확인","상위품번이 존재하지 않습니다")
	return
end if
ln_handle 	= tv_1.finditem(RootTreeItem!, 0)
tv_1.GetItem(ln_handle, l_tvi_item)
ls_citno[1] = l_tvi_item.data
ln_handle 	= tv_1.finditem(ChildTreeItem!, ln_handle)
tv_1.GetItem(ln_handle, l_tvi_item)
ls_citno[2] = l_tvi_item.data
ln_handle 	= tv_1.finditem(NextTreeItem!, ln_handle)
i = 2
do while ln_handle > 1 
	tv_1.GetItem(ln_handle, l_tvi_item)
	i = i + 1
	ls_citno[i] = l_tvi_item.data
	ln_handle 	= tv_1.finditem(NextTreeItem!, ln_handle)
loop
ls_ppitn = dw_1.object.ppitn[ln_row]
ls_chdt  = dw_1.object.pchdt[ln_row]
ls_edte  = g_s_date
for k = 1 to i
	UPDATE 	"PBPDM"."BOM001"  
   	SET 	"PEDTE" = :g_s_date,   
          		"PCHCD" = 'D'  
   	WHERE ( "PBPDM"."BOM001"."PCMCD" = :g_s_company ) AND  
         	( "PBPDM"."BOM001"."PLANT" = :is_plant ) AND  
         	( "PBPDM"."BOM001"."PDVSN" = :is_div ) AND  
         	( "PBPDM"."BOM001"."PPITN" = :ls_ppitn ) AND  
         	( "PBPDM"."BOM001"."PCITN" = :ls_citno[k] ) AND  
         	( "PBPDM"."BOM001"."PCHDT" = :ls_chdt )   
            using sqlca;

   	if sqlca.sqlcode = 0 then
		commit using sqlca;
	end if
	
	DELETE FROM "PBPDM"."BOM001"  
   	WHERE ( 	"PBPDM"."BOM001"."PCMCD" = :g_s_company ) AND  
         	( 	"PBPDM"."BOM001"."PLANT" = :is_plant ) AND  
         	( 	"PBPDM"."BOM001"."PDVSN" = :is_div ) AND  
         	( 	"PBPDM"."BOM001"."PPITN" = :ls_ppitn ) AND  
         	( 	"PBPDM"."BOM001"."PCITN" = :ls_citno[k] ) AND  
         	( 	"PBPDM"."BOM001"."PCHDT" = :g_s_date ) and
				( 	"PBPDM"."BOM001"."PEDTE" <> '' AND "PBPDM"."BOM001"."PEDTM" <> ' ' AND
				  	"PBPDM"."BOM001"."PEDTM" > "PBPDM"."BOM001"."PEDTE" )
	using sqlca ;
   if sqlca.sqlcode = 0 then
		commit using sqlca;
	end if
//	ls_lolevchk = 	f_lolev_update1(ls_plant,ls_div,ls_citno[k])
//	if ls_lolevchk = 1 then
//	  f_lolev_update(ls_plant,ls_div,ls_citno[k])
//	end if
next
is_errchk		= 	" "
is_parm 		= 	is_errchk
destroy ids_data1
closewithreturn(parent, is_parm)

end event

type cb_cancel from commandbutton within w_bom110u_res_04
integer x = 2309
integer y = 1192
integer width = 457
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취    소"
end type

event clicked;is_errchk 	= "C"
is_parm 		= is_errchk
destroy ids_data1
closewithreturn(parent, is_parm)
end event

