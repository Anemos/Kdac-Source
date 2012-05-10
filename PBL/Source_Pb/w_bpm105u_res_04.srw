$PBExportHeader$w_bpm105u_res_04.srw
forward
global type w_bpm105u_res_04 from window
end type
type tv_1 from treeview within w_bpm105u_res_04
end type
type dw_1 from datawindow within w_bpm105u_res_04
end type
type cb_3 from commandbutton within w_bpm105u_res_04
end type
type cb_2 from commandbutton within w_bpm105u_res_04
end type
end forward

global type w_bpm105u_res_04 from window
integer x = 498
integer y = 500
integer width = 2834
integer height = 1428
boolean titlebar = true
string title = "Option 품목 BOM 오류 수정"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
tv_1 tv_1
dw_1 dw_1
cb_3 cb_3
cb_2 cb_2
end type
global w_bpm105u_res_04 w_bpm105u_res_04

type variables
string l_s_plant,l_s_div, l_s_pitno, l_s_parm, l_s_errchk
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

public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this);Integer			l_n_Cnt
TreeViewItem	l_tvi_New
For l_n_Cnt = 1 To ag_Rows
	// TreeView의 Item에 각각의 값을 Setting시킨다.
	
	wf_set_items(ag_Level, l_n_Cnt, l_tvi_New)
	
	// TreeView에 Item을 추가시킨다.
	If ag_this.InsertItemLast(ag_Parent, l_tvi_New) < 1 Then
		Return -1
	End If
Next

Return ag_Rows
end function

public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent);Integer			l_n_Level, l_n_count
TreeViewItem	l_tvi_Current
Treeview			l_tv_current

SetPointer(HourGlass!)

// Determine the level
ag_tvcurrent.GetItem(ag_handle, l_tvi_Current)
l_n_Level = l_tvi_Current.Level
ids_data1.reset()
l_n_count = ids_data1.retrieve(l_s_plant,l_s_div,l_s_pitno,g_s_date)
wf_add_items(ag_handle,l_n_level,l_n_count,ag_tvcurrent)


end subroutine

on w_bpm105u_res_04.create
this.tv_1=create tv_1
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.Control[]={this.tv_1,&
this.dw_1,&
this.cb_3,&
this.cb_2}
end on

on w_bpm105u_res_04.destroy
destroy(this.tv_1)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_2)
end on

event open;treeviewitem l_tvi_root
long l_n_tvi
integer l_n_root

setpointer(hourglass!)
dw_1.settransobject(sqlca)
dw_1.object.pwkct.protect = true
dw_1.object.pwkct.background.color = rgb(192,192,192)      
l_s_parm = message.stringparm

l_s_plant = mid(l_s_parm,1,1)
l_s_div = mid(l_s_parm,2,1)
l_s_pitno = mid(l_s_parm,3,12)
l_s_errchk = " "
ids_data1 = create Datastore
ids_data1.dataobject = "d_bpm001_secitem"
ids_data1.settransobject(sqlca)
l_n_tvi = tv_1.FindItem(roottreeitem!, 0)
tv_1.DeleteItem(l_n_tvi)
ids_data1.reset()
l_tvi_root.label = l_s_pitno + "      Option 주 품번 "
l_tvi_root.data  = l_s_pitno
l_tvi_root.pictureindex = 1
l_tvi_root.selectedpictureindex = 2
l_tvi_root.children = true
l_n_root = tv_1.insertitemlast(0,l_tvi_root)
tv_1.expanditem(l_n_root)




end event

event close;l_s_errchk = "C"
l_s_parm = l_s_errchk
destroy ids_data1
closewithreturn(this, l_s_parm)
end event

type tv_1 from treeview within w_bpm105u_res_04
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

event itempopulate;Integer			l_n_Level
TreeViewItem	l_tvi_Current

// Determine the level
tv_1.GetItem(handle, l_tvi_Current)
l_n_Level = l_tvi_Current.Level

if l_n_level >= 3 then 
	return
end if
wf_itempopulate(handle, tv_1)

end event

event selectionchanged;string l_s_itno
treeviewitem l_tvi_item	

tv_1.getitem(newhandle, l_tvi_item)
l_s_itno = trim(l_tvi_item.data)	
dw_1.retrieve(l_s_plant,l_s_div,l_s_itno,g_s_date)





end event

type dw_1 from datawindow within w_bpm105u_res_04
integer x = 1138
integer y = 36
integer width = 1627
integer height = 1108
integer taborder = 10
string title = "none"
string dataobject = "d_bpm001_implo_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;this.selectrow(0,false)
this.selectrow(row,true)

end event

type cb_3 from commandbutton within w_bpm105u_res_04
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

event clicked;integer l_n_yesno, l_n_count, i, l_n_chk_count, l_n_row, l_s_lolevchk, k 
string l_s_wkct, l_s_ppitn, l_s_pcitn, l_s_edtm, l_s_edte, l_s_exdv, l_s_empno
string l_s_rout,  l_s_oscd, l_s_ebst, l_s_chdt, l_s_indt, l_s_citno[]
dec{3}  l_s_qtym,l_s_qtye
long l_s_handle
treeviewitem l_tvi_item

l_n_yesno = messagebox("확인", "선택된 상위 품번의 모든 Option 품번을 삭제하시겠습니까 ?",Question!,OkCancel!,2)
if l_n_yesno <> 1 then
	return
end if
setpointer(hourglass!)
l_n_row = dw_1.getrow()
if l_n_row = 0 then
	messagebox("확인","상위품번이 존재하지 않습니다")
	return
end if
l_s_handle = tv_1.finditem(RootTreeItem!, 0)
tv_1.GetItem(l_s_handle, l_tvi_item)
l_s_citno[1] = l_tvi_item.data
l_s_handle = tv_1.finditem(ChildTreeItem!, l_s_handle)
tv_1.GetItem(l_s_handle, l_tvi_item)
l_s_citno[2] = l_tvi_item.data
l_s_handle = tv_1.finditem(NextTreeItem!, l_s_handle)
i = 2
do while l_s_handle > 1 
	tv_1.GetItem(l_s_handle, l_tvi_item)
	i = i + 1
	l_s_citno[i] = l_tvi_item.data
	l_s_handle = tv_1.finditem(NextTreeItem!, l_s_handle)
loop
l_s_ppitn = dw_1.object.ppitn[l_n_row]
l_s_chdt  = dw_1.object.pchdt[l_n_row]
l_s_edte  = g_s_date
for k = 1 to i
	
//	UPDATE "PBBPM"."BPM001"  
//   	SET "PEDTE" = :g_s_date,   
//          "PCHCD" = 'D'  
//   	WHERE ( "PBBPM"."BPM001"."PCMCD" = :g_s_company ) AND  
//         	( "PBBPM"."BPM001"."PLANT" = :l_s_plant ) AND  
//         	( "PBBPM"."BPM001"."PDVSN" = :l_s_div ) AND  
//         	( "PBBPM"."BPM001"."PPITN" = :l_s_ppitn ) AND  
//         	( "PBBPM"."BPM001"."PCITN" = :l_s_citno[k] ) AND  
//         	( "PBBPM"."BPM001"."PCHDT" = :l_s_chdt )   
//            using sqlca;
//
//   if sqlca.sqlcode = 0 then
//		commit using sqlca;
//	end if
	
	DELETE FROM "PBBPM"."BPM001"  
   	WHERE ( "PBBPM"."BPM001"."PCMCD" = :g_s_company ) AND  
         	( "PBBPM"."BPM001"."PLANT" = :l_s_plant ) AND  
         	( "PBBPM"."BPM001"."PDVSN" = :l_s_div ) AND  
         	( "PBBPM"."BPM001"."PPITN" = :l_s_ppitn ) AND  
         	( "PBBPM"."BPM001"."PCITN" = :l_s_citno[k] )
				using sqlca ;
   if sqlca.sqlcode = 0 then
		commit using sqlca;
	end if
next
l_s_errchk = " "
l_s_parm = l_s_errchk
destroy ids_data1
closewithreturn(parent, l_s_parm)

end event

type cb_2 from commandbutton within w_bpm105u_res_04
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

event clicked;l_s_errchk = "C"
l_s_parm = l_s_errchk
destroy ids_data1
closewithreturn(parent, l_s_parm)
end event

