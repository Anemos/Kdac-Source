$PBExportHeader$w_bpm105u.srw
$PBExportComments$M-BOM Update
forward
global type w_bpm105u from w_origin_sheet01
end type
type tv_1 from treeview within w_bpm105u
end type
type st_3 from statictext within w_bpm105u
end type
type sle_1 from singlelineedit within w_bpm105u
end type
type cb_1 from commandbutton within w_bpm105u
end type
type cb_2 from commandbutton within w_bpm105u
end type
type cb_5 from commandbutton within w_bpm105u
end type
type cb_3 from commandbutton within w_bpm105u
end type
type cb_4 from commandbutton within w_bpm105u
end type
type dw_edit from datawindow within w_bpm105u
end type
type rb_1 from radiobutton within w_bpm105u
end type
type rb_2 from radiobutton within w_bpm105u
end type
type cb_6 from commandbutton within w_bpm105u
end type
type cb_7 from commandbutton within w_bpm105u
end type
type pb_1 from picturebutton within w_bpm105u
end type
type gb_1 from groupbox within w_bpm105u
end type
type gb_2 from groupbox within w_bpm105u
end type
type gb_framemove from groupbox within w_bpm105u
end type
type dw_2 from datawindow within w_bpm105u
end type
type dw_3 from datawindow within w_bpm105u
end type
type uo_1 from uo_plandiv_pdcd within w_bpm105u
end type
end forward

global type w_bpm105u from w_origin_sheet01
integer height = 2704
string title = "M-BOM 등록"
boolean minbox = false
tv_1 tv_1
st_3 st_3
sle_1 sle_1
cb_1 cb_1
cb_2 cb_2
cb_5 cb_5
cb_3 cb_3
cb_4 cb_4
dw_edit dw_edit
rb_1 rb_1
rb_2 rb_2
cb_6 cb_6
cb_7 cb_7
pb_1 pb_1
gb_1 gb_1
gb_2 gb_2
gb_framemove gb_framemove
dw_2 dw_2
dw_3 dw_3
uo_1 uo_1
end type
global w_bpm105u w_bpm105u

type variables
datawindowchild i_dwc_plant, i_dwc_dvsn
datastore ids_data1[],ids_data2[], ids_data3
treeviewitem itvi_drag_object, itvi_drag_parent
string root_nm , l_s_sel
integer i_n_pos, l_s_populate_no, l_s_populate,i_n_first
decimal i_n_tm
long     i_i_LastRow

end variables

forward prototypes
public subroutine wf_item_clear ()
public subroutine wf_rgbclear ()
public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw)
public subroutine wf_add_picture (treeview ag_tvcurrent)
public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent)
public subroutine wf_option_update (string a_plant, string a_div, string a_first_itno, string a_second_itno, string a_update_code, string a_from_date, string a_to_date)
public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this)
public subroutine wf_set_items (integer ag_level, integer ag_row, readonly treeviewitem ag_tvinew)
end prototypes

public subroutine wf_item_clear ();
end subroutine

public subroutine wf_rgbclear ();dw_edit.object.pcitn.background.color = rgb(255,250,239)
dw_edit.object.pqtym.background.color = rgb(255,250,239)
dw_edit.object.pwkct.background.color = rgb(255,250,239)
dw_edit.object.pexdv.background.color = rgb(255,255,255)
dw_edit.object.pedtm.background.color = rgb(255,255,255)
dw_edit.object.pedte.background.color = rgb(255,255,255)

end subroutine

public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw);integer	l_i_Idx, l_i_last_row

l_i_last_row = i_i_LastRow

dw.setredraw(false)
dw.selectrow(0,false)

If l_i_last_row = 0 then
	dw.setredraw(true)
	Return 1
end if

if l_i_last_row > al_aclickedrow then
	For l_i_Idx = l_i_last_row to al_aclickedrow STEP -1
		dw.selectrow(l_i_Idx,TRUE)	
	end for	
else
	For l_i_Idx = l_i_last_row to al_aclickedrow 
		dw.selectrow(l_i_Idx,TRUE)	
	next	
end if

dw.setredraw(true)
Return 1

end function

public subroutine wf_add_picture (treeview ag_tvcurrent);ag_tvcurrent.PictureHeight = 15
ag_tvcurrent.PictureWidth = 16

ag_tvcurrent.AddPicture("Library!")
ag_tvcurrent.AddPicture("DosEdit!")
ag_tvcurrent.AddPicture("Custom050!")
ag_tvcurrent.AddStatePicture("Save!")

end subroutine

public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent);Integer			l_n_Level, l_n_rows
string			l_s_Parm , l_s_div, l_s_plant, l_s_rtncd
// long           l_n_tvi
TreeViewItem	l_tvi_Current
Treeview			l_tv_current

SetPointer(HourGlass!)

// Determine the level
ag_tvcurrent.GetItem(ag_handle, l_tvi_Current)

l_n_Level = l_tvi_Current.Level

l_s_rtncd = uo_1.uf_return()
l_s_plant = mid(l_s_rtncd,1,1)
l_s_div = mid(l_s_rtncd,2,1)

// Determine the Retrieval arguments for the new data
// if l_n_level <> 1 and rb_2.checked = true then
if rb_2.checked = true then
	   ids_data2[l_n_level].reset()
	   l_n_rows = ids_data2[l_n_level].retrieve(l_s_plant,l_s_div,l_tvi_current.data, g_s_date)
   	if l_n_rows > 0 then
	   	wf_add_items(ag_handle,l_n_level,l_n_rows,ag_tvcurrent)
   	end if
end if
// if l_n_level <> 1 and rb_1.checked = true then
if rb_1.checked = true then	
	ids_data1[l_n_level].reset()
	l_n_rows = ids_data1[l_n_level].retrieve(l_s_plant,l_s_div,l_tvi_current.data, g_s_date)
   if l_n_rows > 0 then
     	wf_add_items(ag_handle,l_n_level,l_n_rows,ag_tvcurrent)
   end if
 end if


end subroutine

public subroutine wf_option_update (string a_plant, string a_div, string a_first_itno, string a_second_itno, string a_update_code, string a_from_date, string a_to_date);string l_s_citno,l_s_cedtm,l_s_cedte,l_chk_citno[]
integer i,j,k

if a_update_code = 'D' then
//		UPDATE "PBBPM"."BPM003"
//			SET "OEDTE" = :g_s_date,
//				 "OCHCD" = :a_update_code 
   DELETE FROM "PBBPM"."BPM003"
		WHERE "PBBPM"."BPM003"."OCMCD" = '01' AND
				"PBBPM"."BPM003"."OPLANT" = :a_plant AND
				"PBBPM"."BPM003"."ODVSN" = :a_div AND
				"PBBPM"."BPM003"."OPITN"= :a_second_itno  
//				and	
//				( "PBBPM"."BPM003"."OEDTE" =  '' OR "PBBPM"."BPM003"."OEDTE" >= :a_to_date )
		using sqlca;
		if sqlca.sqlcode <> 0 then
			rollback using sqlca;
			return
		else
			commit using sqlca;
		end if
//		UPDATE "PBBPM"."BPM003"
//				SET "OEDTE"= :g_s_date, "OCHCD" = :a_update_code 
	DELETE FROM "PBBPM"."BPM003"	
		WHERE "PBBPM"."BPM003"."OCMCD" = '01' AND
				"PBBPM"."BPM003"."OPLANT" = :a_plant AND
				"PBBPM"."BPM003"."ODVSN" = :a_div AND	
				"PBBPM"."BPM003"."OFITN" = :a_second_itno
//				and
//				( "PBBPM"."BPM003"."OEDTE" = '' OR "PBBPM"."BPM003"."OEDTE" >= :a_to_date )
		using sqlca;
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
		return
	else
		commit using sqlca;
	end if
else	
//	DELETE FROM "PBBPM"."BPM003"
//	WHERE "PBBPM"."BPM003"."OCMCD" = '01' AND
//			"PBBPM"."BPM003"."OPLANT" = :a_plant AND
//			"PBBPM"."BPM003"."ODVSN" = :a_div AND	
//			"PBBPM"."BPM003"."OPITN" = :a_first_itno and
//			"PBBPM"."BPM003"."OFITN" = :a_second_itno  
//	using sqlca;
	UPDATE "PBBPM"."BPM003"
	SET "OEDTM"= :a_from_date, "OCHCD" = :a_update_code ,"OEDTE" = ''
	WHERE "PBBPM"."BPM003"."OCMCD" = '01' AND
			"PBBPM"."BPM003"."OPLANT" = :a_plant AND
			"PBBPM"."BPM003"."ODVSN"  = :a_div AND	
			"PBBPM"."BPM003"."OPITN"  = :a_first_itno and
			"PBBPM"."BPM003"."OFITN"  = :a_second_itno  
	using sqlca;
	if sqlca.sqlcode = 0 then
		commit using sqlca;
	end if
end if
end subroutine

public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this);Integer			l_n_Cnt
TreeViewItem	l_tvi_New
For l_n_Cnt = 1 To ag_Rows
	// TreeView에 Item에 각각의 값을 Setting시킨다.
	wf_set_items(ag_Level, l_n_Cnt, l_tvi_New)
	If ag_this.InsertItemLast(ag_Parent, l_tvi_New) < 1 Then
		Return -1
	End If
Next
Return ag_Rows

end function

public subroutine wf_set_items (integer ag_level, integer ag_row, readonly treeviewitem ag_tvinew);// Set the Lable and Data attributes for the new item from the data in the DataStore
long		l_n_check,ln_count = 0
string 	l_s_citno,l_s_plant,l_s_div, l_s_itnm , l_s_clsbsrce

l_s_plant = uo_1.uf_return()
l_s_div = mid(l_s_plant,2,1)
l_s_plant = mid(l_s_plant,1,1)

if rb_1.checked = true then
	if f_spacechk(sle_1.text) = -1 and ag_level = 1  then
		l_s_citno = ids_data3.object.itno[ag_row]
		ag_tvinew.label = l_s_citno 
	   ag_tvinew.data = l_s_citno
	   ag_tvinew.expanded = false
	else
      l_s_citno = string(ids_data1[ag_level].object.pcitn[ag_row],"@@@@@@@@@@@@")
		l_s_clsbsrce = f_bom_get_balance(l_s_plant,l_s_div, l_s_citno)
		ag_tvinew.label =  l_s_citno + "   " + l_s_clsbsrce 
		ag_tvinew.data = l_s_citno
   	ag_tvinew.expanded = false
	end if
end if
if f_spacechk(sle_1.text) <> -1 and rb_2.checked = true then
   l_s_citno = string(ids_data2[ag_level].object.ppitn[ag_row],"@@@@@@@@@@@@")
	l_s_clsbsrce = f_bom_get_balance(l_s_plant,l_s_div, l_s_citno)
	ag_tvinew.label = l_s_citno + "   " + l_s_clsbsrce
	ag_tvinew.data = l_s_citno
	ag_tvinew.expanded = false
end if

if rb_2.checked = true then
	SELECT count(*) INTO :l_n_check FROM "PBBPM"."BPM001" 
   	WHERE "PBBPM"."BPM001"."PCMCD" = '01' AND
				"PBBPM"."BPM001"."PLANT" = :l_s_plant AND
				"PBBPM"."BPM001"."PCITN" = :l_s_citno AND
				"PBBPM"."BPM001"."PDVSN" = :l_s_div  AND  
         	(( "PBBPM"."BPM001"."PEDTE" = '' ) OR  
         	( "PBBPM"."BPM001"."PEDTE" <> '' AND  
         	"PBBPM"."BPM001"."PEDTE" >= :g_s_date AND  "PBBPM"."BPM001"."PEDTE" >= "PBBPM"."BPM001"."PEDTM"))   
		using sqlca;
else
   SELECT count(*) INTO :l_n_check FROM "PBBPM"."BPM001" 
   	WHERE "PBBPM"."BPM001"."PCMCD" = '01' AND
				"PBBPM"."BPM001"."PLANT" = :l_s_plant AND
				"PBBPM"."BPM001"."PPITN" = :l_s_citno AND
   			"PBBPM"."BPM001"."PDVSN" = :l_s_div  AND   
         	(( "PBBPM"."BPM001"."PEDTE" = '' ) OR  
         	( "PBBPM"."BPM001"."PEDTE" <> '' AND  
         	"PBBPM"."BPM001"."PEDTE" >= :g_s_date AND  "PBBPM"."BPM001"."PEDTE" >= "PBBPM"."BPM001"."PEDTM"))       
		using sqlca;
end if
if l_n_check < 1 then
   ag_tvinew.children = false
else 
	ag_tvinew.children = true
end if
ag_tviNew.SelectedPictureIndex = 2
ag_tviNew.PictureIndex = 1

select count(*) into :ln_count from pbbpm.bpm106
where ayear = '2009' and acode = 'A' and aplant = :l_s_plant and
adiv  = :l_s_div and amdno = :l_s_citno
using sqlca  ;

//if ln_count = 0 then
//	ag_tviNew.textcolor = 5555
////else
////	ag_tviNew.textcolor = 555
//end if




end subroutine

on w_bpm105u.create
int iCurrent
call super::create
this.tv_1=create tv_1
this.st_3=create st_3
this.sle_1=create sle_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_5=create cb_5
this.cb_3=create cb_3
this.cb_4=create cb_4
this.dw_edit=create dw_edit
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cb_6=create cb_6
this.cb_7=create cb_7
this.pb_1=create pb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_framemove=create gb_framemove
this.dw_2=create dw_2
this.dw_3=create dw_3
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_5
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.cb_4
this.Control[iCurrent+9]=this.dw_edit
this.Control[iCurrent+10]=this.rb_1
this.Control[iCurrent+11]=this.rb_2
this.Control[iCurrent+12]=this.cb_6
this.Control[iCurrent+13]=this.cb_7
this.Control[iCurrent+14]=this.pb_1
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.gb_2
this.Control[iCurrent+17]=this.gb_framemove
this.Control[iCurrent+18]=this.dw_2
this.Control[iCurrent+19]=this.dw_3
this.Control[iCurrent+20]=this.uo_1
end on

on w_bpm105u.destroy
call super::destroy
destroy(this.tv_1)
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_5)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.dw_edit)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.pb_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_framemove)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.uo_1)
end on

event open;call super::open;call super:: open;
long l_n_root, l_n_rows
integer l_n_cnt

sle_1.setfocus()
setpointer(HourGlass!)

l_s_populate_no = 0
this.uo_status.st_winid.text = this.classname()
this.uo_status.st_kornm.text = g_s_kornm
this.uo_status.st_date.text = string(g_s_date, "@@@@-@@-@@")

i_b_retrieve = true
i_b_insert = true
i_b_save = false
i_b_delete = false
i_b_dretrieve = false
i_b_dprint = false
i_b_dchar = false
cb_1.enabled = true
cb_2.enabled = false
cb_3.enabled = false
cb_4.enabled = false
cb_5.enabled = false
cb_6.enabled = true
cb_7.enabled = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	              i_b_dprint,   i_b_dchar)

end event

event close;call super::close;integer l_n_cnt
for l_n_cnt = 1 to 30
	destroy ids_Data1[l_n_cnt]
   destroy ids_Data2[l_n_cnt]
next

destroy ids_data3     
end event

event ue_retrieve;int            l_n_check
Long				l_n_Root, l_n_tvi , ct
long           l_n_rows , l_n_cnt
string         l_s_plant, l_s_div, l_s_pdcd , l_s_pdcd1, l_s_div1, l_s_itno, root_data , l_s_clsbsrce
string         l_s_rtncd
TreeViewItem	l_tvi_Root
treeview       l_tv_current

if i_n_first = 0 then
	for l_n_cnt = 1 to 20
		ids_data1[l_n_cnt] = create datastore
		ids_data1[l_n_cnt].dataobject = "d_BPM001_explo_01"
		ids_data2[l_n_cnt] = create datastore
		ids_data2[l_n_cnt].dataobject = "d_BPM001_implo_01"
		ids_data1[l_n_cnt].settransobject(sqlca)	
		ids_data2[l_n_cnt].settransobject(sqlca)	
	next
	ids_data3 = Create datastore
	ids_data3.dataobject = "d_BPM001_pdcd_01"
	ids_data3.settransobject(sqlca)
	i_n_first = 1
end if

// SetPointer(HourGlass!)
f_pism_working_msg(This.title,"BOM 정보를 조회중입니다. 잠시만 기다려 주십시오.") 

l_s_sel = "I"

l_tv_current = tv_1
uo_status.st_message.text = ""
l_n_tvi = tv_1.FindItem(roottreeitem!, 0)
tv_1.DeleteItem(l_n_tvi)

dw_edit.reset()

if rb_1.checked = true then
	dw_2.reset()
	dw_2.visible = true
	dw_3.visible = false
end if
if rb_2.checked = true then
	dw_3.reset()
	dw_3.visible = true
	dw_2.visible = false
end if
l_s_rtncd = uo_1.uf_return()
l_s_plant = mid(l_s_rtncd,1,1)
l_s_div = mid(l_s_rtncd,2,1)
l_s_pdcd  = mid(l_s_rtncd,3,2) 
//l_s_pdcd1  = trim(uo_1.dw_pdcd.gettext()) + "%"
l_s_itno = upper(trim(sle_1.text))

if f_spacechk(l_s_itno) = -1  and rb_1.checked = true then 
	 l_s_div1 = l_s_div
	 //제품군명 가져오기기
	 root_nm = f_get_coflname(g_s_company, 'DAC160', l_s_pdcd) 
	 l_n_rows = ids_data3.retrieve(l_s_plant,l_s_div,l_s_pdcd)
	 l_n_check = 1
else
	if f_spacechk(l_s_itno) = -1  and rb_2.checked = true then
		uo_status.st_message.text = f_message("I080")
		If IsValid(w_pism_working) Then Close(w_pism_working) 
		return 0
	end if
	
	SELECT "PBINV"."INV101"."PDCD"  
   	INTO :l_s_pdcd1  
   	FROM "PBINV"."INV101"  
   	WHERE ( "PBINV"."INV101"."COMLTD" = :g_s_company ) AND  
         	( "PBINV"."INV101"."XPLANT" = :l_s_plant ) AND  
         	( "PBINV"."INV101"."DIV" = :l_s_div ) AND  
         	( "PBINV"."INV101"."ITNO" = :l_s_itno )  using sqlca;

	if f_spacechk(l_s_pdcd1) = -1 then
		uo_status.st_message.text = f_message("E320")
		If IsValid(w_pism_working) Then Close(w_pism_working) 
		return 0
   end if
	l_s_pdcd1 = mid(l_s_pdcd1,1,2)
	uo_1.uf_set_pdcd(l_s_pdcd1)
	if f_spacechk(sle_1.text) <> -1 and rb_1.checked = true then
		l_s_clsbsrce = f_bom_get_balance(l_s_plant,l_s_div, l_s_itno)
		l_s_itno = string(l_s_itno, "@@@@@@@@@@@@" )
      root_nm = l_s_itno  + "    "  + l_s_clsbsrce
		root_data = l_s_itno
   	l_n_rows = ids_data1[1].retrieve(l_s_plant,l_s_div,l_s_itno, g_s_date)
   else 
		if f_spacechk(sle_1.text) <> -1 and rb_2.checked = true then
			l_s_clsbsrce = f_bom_get_balance(l_s_plant,l_s_div, l_s_itno)
			l_s_itno = string(l_s_itno, "@@@@@@@@@@@@" )
			root_nm = l_s_itno  + "    "  + l_s_clsbsrce
			root_data = l_s_itno
			l_n_rows = ids_data2[1].retrieve(l_s_plant,l_s_div,l_s_itno, g_s_date)
		end if
	end if
end if
if l_n_rows < 1 then
	uo_status.st_message.text = f_message("I020")
	If IsValid(w_pism_working) Then Close(w_pism_working) 
	return 0
end if

i_b_retrieve = true
i_b_insert = true
i_b_delete = true
i_b_save = false
cb_1.enabled = true
cb_2.enabled = true
cb_3.enabled = true
cb_4.enabled = true
cb_5.enabled = true
cb_6.enabled = true
cb_7.enabled = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )
l_s_populate = 0
l_tvi_root.label = root_nm 
l_tvi_root.data  = root_data
l_tvi_Root.PictureIndex = 1
l_tvi_Root.SelectedPictureIndex = 1
l_tvi_Root.Children = True
l_n_Root = tv_1.InsertItemLast(0, l_tvi_Root)
tv_1.Expanditem(l_n_Root)
if l_n_check = 1 then
	wf_add_items(1,1,l_n_rows,l_tv_current)
	l_n_check = 0
end if
If IsValid(w_pism_working) Then Close(w_pism_working) 
return 0
end event

event ue_insert;string l_s_plant, l_s_div , l_s_itclsb , l_s_srce, l_s_ppitn , l_s_pdcd, l_s_rtncd
integer l_n_cnt
long l_s_handle
treeviewitem l_tvi_item

uo_status.st_message.text = ""
if rb_2.checked = true then
   uo_status.st_message.text = f_message("I080")
   return 0
end if
l_s_rtncd = uo_1.uf_return()
l_s_div  = mid(l_s_rtncd,2,1)
l_s_plant = mid(l_s_rtncd,1,1)
//l_s_pdcd = upper(trim(uo_1.dw_pdcd.gettext())) + "%"
l_s_handle = tv_1.finditem(CurrentTreeItem!, 0)
if l_s_handle = -1 or l_s_handle = 1 then
	l_s_ppitn = upper(trim(sle_1.text))
	
	SELECT "PBINV"."INV101"."PDCD"  
   	INTO :l_s_pdcd  
   	FROM "PBINV"."INV101"  
   	WHERE ( "PBINV"."INV101"."COMLTD" = :g_s_company ) AND  
         	( "PBINV"."INV101"."XPLANT" = :l_s_plant ) AND  
         	( "PBINV"."INV101"."DIV" = :l_s_div ) AND  
         	( "PBINV"."INV101"."ITNO" = :l_s_ppitn )   using sqlca;
				
	if f_spacechk(l_s_pdcd) = -1 then
		uo_status.st_message.text = f_message("E320")
		return 0
	end if
	l_s_pdcd = mid(l_s_pdcd,1,2)
else
	tv_1.getitem(l_s_handle,l_tvi_item)
	l_s_ppitn = upper(trim(l_tvi_item.data))
end if
if f_spacechk(l_s_ppitn) = -1 then
	uo_status.st_message.text = f_message("E320")
   return 0
end if

l_s_rtncd = f_bom_get_balance(l_s_plant, l_s_div, l_s_ppitn)
l_s_itclsb = mid(l_s_rtncd,1,2)
l_s_srce   = mid(l_s_rtncd,6,2)
if l_s_itclsb = "10" and ( l_s_srce = "01"  or l_s_srce = "05" or l_s_srce = "06" ) then
   uo_status.st_message.text = f_message("A041")
	return 0
end if
dw_edit.reset()
dw_edit.insertrow(0)
dw_edit.setfocus()
dw_edit.object.ppitn[1] = l_s_ppitn
wf_rgbclear()

// 입력 Field Check Routine 

l_s_sel = "A"

i_b_retrieve = true  
i_b_insert = true
i_b_delete = true
i_b_save = true
cb_1.enabled = true
cb_2.enabled = true
cb_3.enabled = true
cb_4.enabled = true
cb_5.enabled = true
cb_6.enabled = true
cb_7.enabled = true

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )
dw_edit.object.pcitn.protect = false
dw_edit.object.pqtym.protect = false
dw_edit.object.pwkct.protect = false
dw_edit.object.pexdv.protect = false
dw_edit.object.pedtm.protect = false
dw_edit.object.pedte.protect = false
dw_edit.setcolumn("pcitn")
dw_edit.object.pcitn.border = 5
dw_edit.object.pqtym.border = 5
dw_edit.object.pwkct.border = 5
dw_edit.object.pexdv.border = 5
dw_edit.object.pedtm.border = 5
dw_edit.object.pedte.border = 5
cb_7.enabled = true
return 0
end event

event ue_delete;integer l_n_row,l_n_yesno,l_n_rcnt,l_s_lolevchk,l_n_row1, l_n_sqlcount, l_n_routing_chk, i
string l_s_edte,l_s_citno, l_s_plant, l_s_div, l_s_edtm, l_s_ppitn, l_s_chdt, l_s_rout,  l_s_chkitno, &
		 l_s_oscd, l_s_ebst, l_s_exdv, l_s_empno , l_s_wkct, l_s_indt, l_s_parm, l_s_errchk
string l_s_explant, l_s_rtncd
long l_s_handle, l_s_nexthandle
dec{3} l_s_qtym, l_s_qtye
treeviewitem l_tvi_item

f_pism_working_msg(This.title,"BOM 정보를 삭제중입니다. 잠시만 기다려 주십시오.") 

uo_status.st_message.text = ""
l_s_rtncd = uo_1.uf_return()
l_s_plant = mid(l_s_rtncd,1,1)
l_s_div = mid(l_s_rtncd,2,1)

if rb_1.checked = true then
	l_n_row = dw_2.getselectedrow(0)
	if l_n_row <> 0 then
		l_n_yesno = messagebox("삭제확인", "선택된 품번(들)을 삭제하시겠습니까 ?",Question!,OkCancel!,2)
		if l_n_yesno <> 1 then
			uo_status.st_message.text = f_message("D030")
			If IsValid(w_pism_working) Then Close(w_pism_working)
			return 0
		end if
	else
		uo_status.st_message.text = f_message("D100")
		If IsValid(w_pism_working) Then Close(w_pism_working)
		return 0
	end if
	do until l_n_row = 0 
		l_s_citno = trim(dw_2.getitemstring(l_n_row,"pcitn"))
		l_s_ppitn = trim(dw_2.getitemstring(l_n_row,"ppitn"))
		l_s_chdt = trim(dw_2.getitemstring(l_n_row,"pchdt"))
		l_s_rout = trim(dw_2.getitemstring(l_n_row,"prout"))
		l_s_edtm = trim(dw_2.getitemstring(l_n_row,"pedtm"))
		l_s_edte = trim(dw_2.getitemstring(l_n_row,"pedte"))
		l_s_oscd = dw_2.getitemstring(l_n_row,"poscd")
		l_s_ebst = dw_2.getitemstring(l_n_row,"pebst")
		l_s_explant = dw_2.getitemstring(l_n_row,"pexplant")
		l_s_exdv = dw_2.getitemstring(l_n_row,"pexdv")
		l_s_empno = dw_2.getitemstring(l_n_row,"pemno")
		l_s_qtym = dw_2.getitemnumber(l_n_row,"pqtym")
		l_s_qtye = dw_2.getitemnumber(l_n_row,"pqtye")
		l_s_wkct = dw_2.getitemstring(l_n_row,"pwkct")
		l_s_indt = dw_2.getitemstring(l_n_row,"pindt")
		
		l_s_chkitno = f_option_chk_after_bpm(l_s_plant, l_s_div, l_s_citno, g_s_date)
		if f_spacechk(l_s_chkitno) <> -1 then
			if f_option_check_bpm(l_s_plant,l_s_div,l_s_chkitno) = 0 then
				l_s_chkitno = mid(l_s_chkitno,1,12)
				l_s_parm = l_s_plant + l_s_div + l_s_chkitno 
				openwithparm(w_bpm105u_res_04, l_s_parm)
				l_s_parm = message.stringparm
				l_s_errchk = mid(l_s_parm,1,1)
			   if l_s_errchk = "C" then
					uo_status.st_message.text = f_message("D030")
					If IsValid(w_pism_working) Then Close(w_pism_working)
					return 0
				end if 
				uo_status.st_message.text = f_message("D010")
			 end if
		else	
//			UPDATE  "PBBPM"."BPM001" 
//				SET  "PEDTE" = :g_s_date, "PCHCD" = 'D'
         delete from "PBBPM"."BPM001"
				where "PCMCD" = '01' and "PLANT" = :l_s_plant and "PDVSN" = :l_s_div and "PPITN" = :l_s_ppitn AND 
						"PROUT" = :l_s_rout AND "PCITN" = :l_s_citno AND PCHDT = :l_s_chdt
    		using sqlca;
			if sqlca.sqlcode = 0 then
				commit using sqlca;
				uo_status.st_message.text = f_message("D010")
			else
				rollback using sqlca;
				uo_status.st_message.text = f_message("D020")
				If IsValid(w_pism_working) Then Close(w_pism_working)
				return 0
			end if
		end if
	   l_n_row = dw_2.getselectedrow(l_n_row)
	loop
	 dw_2.reset()
    dw_2.retrieve(l_s_plant,l_s_div,l_s_ppitn, g_s_date)
end if
	
if rb_2.checked = true then
	l_n_rcnt = 0 
	l_n_row1 = dw_3.rowcount()
	l_n_row = dw_3.getselectedrow(0)
	if l_n_row <> 0 then
	   l_n_yesno = messagebox("삭제확인", "선택된 품번(들)을 삭제하시겠습니까 ?",Question!,OkCancel!,2)
		if l_n_yesno <> 1 then
			uo_status.st_message.text = f_message("D030")
			If IsValid(w_pism_working) Then Close(w_pism_working)
			return 0
		end if
	else
		uo_status.st_message.text = f_message("D100")
		If IsValid(w_pism_working) Then Close(w_pism_working)
		return 0
	end if
	do until l_n_row = 0
		l_n_row = dw_3.getselectedrow(l_n_row)
		l_n_rcnt = l_n_rcnt + 1
	loop
   l_n_row = dw_3.getselectedrow(0)
	l_s_citno = trim(dw_3.getitemstring(l_n_row,"pcitn"))
	l_s_chkitno = f_option_chk_after_bpm(l_s_plant,l_s_div,l_s_citno,g_s_date)
	if l_n_rcnt <> l_n_row1 then	
		if f_spacechk(l_s_chkitno) <> -1 then
			if f_option_check_bpm(l_s_plant,l_s_div,l_s_chkitno) = 0 then
				l_s_parm = l_s_plant + l_s_div + l_s_chkitno 
				openwithparm(w_bpm105u_res_04, l_s_parm)
				l_s_parm = message.stringparm
				l_s_errchk = mid(l_s_parm,1,1)
				if l_s_errchk = "C" then
					uo_status.st_message.text = f_message("D030")
				else
					uo_status.st_message.text = f_message("D010")
				end if
				If IsValid(w_pism_working) Then Close(w_pism_working)
				return 0
			end if
		end if
	else
		if f_spacechk(l_s_chkitno) <> -1 then
			l_n_yesno = messagebox("Option 해제 확인",  l_s_citno + " 은 Option 품목입니다. Option을 해제하겠습니까 ?" ,Question!,OkCancel!,2)
			if l_n_yesno <> 1 then
				uo_status.st_message.text = f_message("D030")
				If IsValid(w_pism_working) Then Close(w_pism_working)
				return 0
			else
				wf_option_update(l_s_plant,l_s_div,l_s_chkitno,l_s_citno,'D', '   ' , g_s_date)
			end if
		end if
	end if
	do until l_n_row = 0
		l_s_citno = trim(dw_3.getitemstring(l_n_row,"pcitn"))
		l_s_ppitn = trim(dw_3.getitemstring(l_n_row,"ppitn"))
		l_s_chdt = trim(dw_3.getitemstring(l_n_row,"pchdt"))
		l_s_rout = trim(dw_3.getitemstring(l_n_row,"prout"))
		l_s_edtm = trim(dw_3.getitemstring(l_n_row,"pedtm"))
		l_s_edte = trim(dw_3.getitemstring(l_n_row,"pedte"))
		l_s_oscd = dw_3.getitemstring(l_n_row,"poscd")
		l_s_ebst = dw_3.getitemstring(l_n_row,"pebst")
		l_s_explant = dw_3.getitemstring(l_n_row,"pexplant")
		l_s_exdv = dw_3.getitemstring(l_n_row,"pexdv")
		l_s_empno = dw_3.getitemstring(l_n_row,"pemno")
		l_s_qtym = dw_3.getitemnumber(l_n_row,"pqtym")
		l_s_qtye = dw_3.getitemnumber(l_n_row,"pqtye")
		l_s_wkct = dw_3.getitemstring(l_n_row,"pwkct")
		l_s_indt = dw_3.getitemstring(l_n_row,"pindt")
		

      delete from "PBBPM"."BPM001" 
		where "PCMCD" = '01' AND "PLANT" = :l_s_plant and "PDVSN" = :l_s_div and "PPITN" = :l_s_ppitn AND 
				"PROUT" = :l_s_rout AND "PCITN" = :l_s_citno and "PCHDT" = :l_s_chdt
			using sqlca;
		
		if sqlca.sqlcode = 0 then
			commit using sqlca;
			uo_status.st_message.text = f_message("D010")
		else
			rollback using sqlca;
			uo_status.st_message.text = f_message("D020")
			If IsValid(w_pism_working) Then Close(w_pism_working)
			return 0
		end if
		l_n_row = dw_3.getselectedrow(l_n_row)
	loop
	dw_3.reset()
	dw_3.retrieve(l_s_plant,l_s_div,l_s_citno,g_s_date)
end if

If IsValid(w_pism_working) Then Close(w_pism_working)
i_b_retrieve = true  
i_b_insert = true
i_b_delete = true
i_b_save = false
cb_1.enabled = true
cb_2.enabled = true
cb_3.enabled = true
cb_4.enabled = true
cb_5.enabled = true
cb_6.enabled = true
cb_7.enabled = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )
return 0

end event

event ue_save;string l_s_plant,l_s_div, l_s_wkct, l_s_ppitn, l_s_pcitn, l_s_edtm, l_s_edte, l_s_exdv, l_s_srce, l_s_item, l_s_chkitno
string l_s_itclsb, l_s_today, l_s_column, l_s_rout,  l_s_oscd, l_s_ebst, l_s_chdt, l_s_edte1, l_s_explant, l_s_rtncd
integer l_s_errchk, l_n_cnt, l_s_chkcase, l_s_tree_value, i , k, l_n_yesno
long  l_s_handle, l_s_nexthandle, l_n_root, l_s_handle1
dec{3} l_s_chkqtym , l_s_qtym, l_s_qtye
treeviewitem l_tvi_item
string l_s_chkchdt, l_s_chkedtm, l_s_chkedte, l_s_chkwkct, l_s_chkexdv, l_s_chgedtm, l_s_chgedte, l_s_parm, l_s_srce1
string l_s_oitno[],l_s_chkitno1, l_s_bar, l_s_valid_date, l_s_valid_date1, l_s_valid_date2

//SetPointer(HourGlass!)
f_pism_working_msg(This.title,"BOM 정보를 저장중입니다. 잠시만 기다려 주십시오.") 

l_s_chkedtm = dw_edit.object.pedtm[1]
l_s_chkedte = dw_edit.object.pedte[1]
l_s_chkwkct = dw_edit.object.pwkct[1]
l_s_chkexdv = dw_edit.object.pexdv[1]
l_s_chkqtym = dw_edit.object.pqtym[1]
l_s_chkchdt = dw_edit.object.pchdt[1]

dw_edit.accepttext()
l_s_errchk = 0
l_n_cnt = 0

f_sysdate()
uo_status.st_message.text = ""
wf_rgbclear()

l_s_wkct = upper(trim(dw_edit.object.pwkct[1]))
l_s_exdv = upper(trim(dw_edit.object.pexdv[1]))
l_s_explant = upper(trim(dw_edit.object.pexplant[1]))
l_s_edtm = dw_edit.object.pedtm[1]

if isnull(l_s_exdv) then 
	l_s_exdv = ''
end if
if isnull(l_s_explant) then 
	l_s_explant = ''
end if

l_s_edte = dw_edit.object.pedte[1]
l_s_rtncd = uo_1.uf_return()
l_s_div  = mid(l_s_rtncd,2,1)
l_s_plant = mid(l_s_rtncd,1,1)

l_s_handle = tv_1.finditem(CurrentTreeItem!, 0)
if rb_1.checked = true then
	l_s_pcitn = upper(trim(dw_edit.object.pcitn[1]))
	if l_s_handle = -1 or l_s_handle = 1 then
		l_s_ppitn = upper(trim(sle_1.text))
	else
		tv_1.getitem(l_s_handle,l_tvi_item)
		l_s_ppitn = upper(trim(l_tvi_item.data))
	end if
elseif rb_2.checked = true then
	l_s_ppitn = upper(trim(dw_edit.object.ppitn[1]))
	if l_s_handle = -1 or l_s_handle = 1 then
		l_s_pcitn = upper(trim(sle_1.text))
	else
		tv_1.getitem(l_s_handle,l_tvi_item)
		l_s_pcitn = upper(trim(l_tvi_item.data))
	end if
end if

l_s_qtym = dw_edit.object.pqtym[1]

l_s_itclsb = f_bom_get_balance(l_s_plant,l_s_div,l_s_ppitn)
l_s_srce   = mid(l_s_itclsb,6,2)
l_s_itclsb = mid(l_s_itclsb,1,2)

if l_s_sel = "A" then
	 if f_spacechk(l_s_pcitn) = -1 then
	    l_s_errchk = 1
		 uo_status.st_message.text = f_message("E320")
    else
		
	   select count(*) into : l_n_cnt from "PBINV"."INV101"
	   	where "PBINV"."INV101"."COMLTD" = :g_s_company and
					"PBINV"."INV101"."XPLANT" = :l_s_plant and
					"PBINV"."INV101"."DIV" = :l_s_div and 
					"PBINV"."INV101"."ITNO" = :l_s_pcitn 
		using sqlca;
	
   	if l_n_cnt = 0 then
		   l_s_errchk = 1
			uo_status.st_message.text = f_message("E320") 
	   else
   	   select count(*) into : l_n_cnt from "PBBPM"."BPM001"
	     	 	where "PBBPM"."BPM001"."PCMCD" = '01' AND
						"PBBPM"."BPM001"."PLANT" = :l_s_plant AND 
						"PBBPM"."BPM001"."PDVSN" = :l_s_div AND 
						"PBBPM"."BPM001"."PCITN" = :l_s_pcitn AND "PBBPM"."BPM001"."PPITN" = :l_s_ppitn AND 
						"PBBPM"."BPM001"."PCHDT" = :g_s_date 
				    using sqlca;
	      if l_n_cnt > 0 then
		     l_s_errchk = 1
			  uo_status.st_message.text = f_message("A060")
	   	else
   	     if l_s_ppitn = l_s_pcitn then
			     l_s_errchk = 1
			     uo_status.st_message.text = f_message("E330")
           else
					if f_chk_bom_bpm(l_s_plant,l_s_div,l_s_ppitn,l_s_pcitn) = 1 then	
		            l_s_errchk = 1 
			         uo_status.st_message.text = f_message("E330")
	            end if
	        end if
		  end if
	  end if
  end if
end if

if l_s_errchk = 1 and f_spacechk(l_s_column) = -1 then
	l_s_column = "pcitn"
	dw_edit.object.pcitn.background.color = rgb(255,255,0)
end if

l_s_errchk = 0

if isNull(l_s_qtym)    = True  or   l_s_qtym <= 0 then
	l_s_errchk = 1
	dw_edit.object.pqtym.background.color = rgb(255,255,0)
end if

if l_s_errchk = 1 and f_spacechk(l_s_column) = -1 then
	l_s_column = "pqtym"
end if

l_s_errchk = 0

if f_spacechk(l_s_wkct) = -1 then
	l_s_errchk = 1
else
	if l_s_wkct <> "8888" and l_s_wkct <> "9999" then
		select count(*) into :l_n_cnt from pbcommon.dac001
		       where duse = ' ' and dtodt = 0 and dcode = :l_s_wkct and dacttodt = 0 using sqlca;
		
		if l_n_cnt < 1 then
			l_s_errchk = 1
		end if
	else
		if l_s_itclsb = "40" or l_s_itclsb = "50" then
			if l_s_wkct <> "9999" then
				l_s_errchk = 1
			end if
		end if
		if l_s_itclsb = "10" and l_s_srce = "02" then
			if l_s_wkct <> "8888" then
				l_s_errchk = 1
			end if
		end if
		if ( l_s_itclsb = "30" or l_s_srce = "03" ) and ( l_s_wkct = "8888" or l_s_wkct = "9999" ) then
				l_s_errchk = 1
		end if
		if l_s_itclsb = "10" and l_s_srce = "04" then
			if l_s_wkct <> "8888" and l_s_wkct <> "9999" then
				l_s_errchk = 1
			end if
		end if
	end if
end if
if l_s_errchk = 1 then
	dw_edit.object.pwkct.background.color = rgb(255,255,0)
	if f_spacechk(l_s_column) = -1 then
		l_s_column = "pwkct"	
	end if
end if

l_s_errchk = 0
l_s_srce1   = f_bom_get_srce(l_s_plant,l_s_div,l_s_pcitn)
if l_s_srce1 = "05" or l_s_srce1 = "06" then
	if f_spacechk(l_s_exdv) = -1 or f_spacechk(l_s_explant)  = -1 then
		l_s_errchk = 1
	else
		if (l_s_plant = 'D' and ( l_s_div = "A" or l_s_div = "V" )) then
			l_s_errchk = 1		
		end if
		if ( l_s_plant <> l_s_explant and l_s_div = l_s_exdv ) then
			l_s_errchk = 0		   
		else
			l_s_errchk = 1
		end if
		select count(*) into :l_n_cnt from pbinv.inv101 
				where comltd = :g_s_company and
						xplant = :l_s_explant and
						div = :l_s_exdv and 
						itno = :l_s_pcitn using sqlca;
		if l_n_cnt = 0 then
			l_s_errchk = 1
		end if
	end if
else
	if f_spacechk(l_s_exdv) <> -1 then
		l_s_errchk = 1
	end if
end if

if l_s_errchk = 1 then
	dw_edit.object.pexdv.background.color = rgb(255,255,0)
	if f_spacechk(l_s_column) = -1 then
	   l_s_column = "pexdv"
   end if
end if

l_s_errchk = 0

if f_spacechk(l_s_edtm) <> -1 and f_spacechk(l_s_edte) = -1 then
	if f_dateedit(l_s_edtm) = SPACE(8) then 
		 dw_edit.object.pedtm.background.color = rgb(255,255,0)
		 if f_spacechk(l_s_column) = -1 then
			 l_s_column = "pedtm"
		 end if
  	end if
end if
if f_spacechk(l_s_edte) <> -1 and f_spacechk(l_s_edtm) = -1 then
	if f_dateedit(l_s_edte) <> SPACE(8) then 
		if l_s_edte <= g_s_date then
			if f_spacechk(l_s_column) = -1 then
	         l_s_column = "pedte"
         end if
			dw_edit.object.pedte.background.color = rgb(255,255,0)
	   end if
	else
		if f_spacechk(l_s_column) = -1 then
	         l_s_column = "pedte"
      end if
      dw_edit.object.pedte.background.color = rgb(255,255,0)
	end if
end if
if f_spacechk(l_s_edte) <> -1 and f_spacechk(l_s_edtm) <> -1 then
	if l_s_edte <= g_s_date then
			if f_spacechk(l_s_column) = -1 then
	         l_s_column = "pedte"
         end if
			dw_edit.object.pedte.background.color = rgb(255,255,0)
	end if
	if f_dateedit(l_s_edtm) <> SPACE(8) then
		if f_dateedit(l_s_edte) <> SPACE(8) then
			if l_s_edtm > l_s_edte then
				dw_edit.object.pedtm.background.color = rgb(255,255,0)
				if f_spacechk(l_s_column) = -1 then
	            l_s_column = "pedtm"
             end if      		
         end if
		else
			dw_edit.object.pedte.background.color = rgb(255,255,0)
			if f_spacechk(l_s_column) = -1 then
	            l_s_column = "pedte"
         end if      		
		end if
	else
		dw_edit.object.pedtm.background.color = rgb(255,255,0)
		if f_spacechk(l_s_column) = -1 then
	            l_s_column = "pedtm"
      end if      		
	end if
end if
if l_s_sel = "C" then
	if f_spacechk(l_s_edte) <> -1 then
		if l_s_edte < f_relativedate(g_s_date,1) then
			dw_edit.object.pedte.background.color = rgb(255,255,0)
		   if f_spacechk(l_s_column) = -1 then
	            l_s_column = "pedte"
         end if
		end if
	end if
end if

if len(l_s_column) > 0 then
	dw_edit.setcolumn(l_s_column)
	dw_edit.setfocus()
	if l_s_column <> "pcitn" then
	   uo_status.st_message.text = f_message("E010")
   end if
	i_n_erreturn = -1
	If IsValid(w_pism_working) Then Close(w_pism_working) 
	return 0
end if

setpointer(hourglass!)

l_s_rout = ""
l_s_qtye = 0
l_s_ebst = ""
if l_s_wkct = "8888" then 
	l_s_oscd = "1"
elseif l_s_wkct = "9999" then 
	l_s_oscd = "2"
end if

if l_s_sel = "A" then
	l_s_today = g_s_date
	if isnull(l_s_edtm) = true then
		l_s_edtm = "        "
   end if
	if isnull(l_s_edte) = true then
		l_s_edte = "        "
   end if
	if isnull(l_s_exdv) = true then
		l_s_exdv = ""
   end if
	l_s_chdt  = g_s_date
	l_s_chkitno = f_option_chk_after_bpm(l_s_plant,l_s_div,l_s_pcitn,g_s_date) 
	if f_spacechk(l_s_chkitno) <> -1 and f_option_check_bpm(l_s_plant,l_s_div,l_s_chkitno) = 0 then
		l_n_yesno = messagebox("Option 품목 Check", "현재 상위품번에 전체 Option 품목을 추가하시겠습니까 ?",Question!,OkCancel!,2)
		if l_n_yesno <> 1 then
			uo_status.st_message.text = f_message("A030")
			i_n_erreturn = -1
			If IsValid(w_pism_working) Then Close(w_pism_working) 
			return 0
		end if
		declare optchk_cur cursor for 
		select "PBBPM"."BPM003"."OFITN" from "PBBPM"."BPM003"
			  where "PBBPM"."BPM003"."OCMCD" = '01' AND
			  			"PBBPM"."BPM003"."OPITN" = :l_s_chkitno AND
					  "PBBPM"."BPM003"."ODVSN" = :l_s_div AND  
						("PBBPM"."BPM003"."OEDTE" = ''  OR  
						"PBBPM"."BPM003"."OEDTE" >= :g_s_date )    
			  using SQLCA ;
			open optchk_cur ;
			  l_s_oitno[1] = l_s_chkitno
			  i = 1
			  do while true
				 fetch optchk_cur into :l_s_chkitno1 ;
				 if sqlca.sqlcode <> 0 then
					exit
				 end if 
				 i = i + 1
				 l_s_oitno[i] = trim(l_s_chkitno1)
			  loop
			close optchk_cur ;
		 for k = 1 to i
			DELETE FROM "PBBPM"."BPM001"  
			WHERE PCMCD = :G_S_COMPANY AND  PLANT = :L_S_plant AND PDVSN = :L_S_DIV AND 
					PPITN = :L_S_PPITN AND PCITN = :l_s_oitno[k] USING SQLCA ;
					
			INSERT INTO "PBBPM"."BPM001"  
				( "PCMCD","PLANT","PDVSN","PPITN","PROUT","PCITN","PCHDT","PQTYM","PQTYE", "PWKCT","PEDTM",   
				  "PEDTE","POPCD","PEXPLANT","PEXDV","PCHCD","POSCD","PEBST",
				  "PMACADDR","PIPADDR","PINDT","PEMNO","PREMK" )  
				VALUES (:g_s_company,:l_s_plant,:l_s_div,:l_s_ppitn,:l_s_rout,:l_s_oitno[k],:l_s_chdt,:l_s_qtym,:l_s_qtye
				  ,:l_s_wkct,:l_s_edtm,:l_s_edte,'',:l_s_explant,:l_s_exdv,'A',:l_s_oscd,:l_s_ebst
				  ,:g_s_macaddr,:g_s_ipaddr,:g_s_date,:g_s_empno,' ')
				using sqlca;

			if sqlca.sqlcode <> 0 then
				rollback using sqlca;
				uo_status.st_message.text = f_message("A020")
				If IsValid(w_pism_working) Then Close(w_pism_working) 
			   i_n_erreturn = -1
			   return 0
			else
				commit using sqlca;
				uo_status.st_message.text = f_message("A010")
			end if
		 next
		 l_s_tree_value = 1
		// f_lolev_update(l_s_plant,l_s_div,l_s_ppitn)
	else
		DELETE FROM "PBBPM"."BPM001"  
		WHERE PCMCD = :G_S_COMPANY AND  PLANT = :L_S_plant AND PDVSN = :L_S_DIV AND 
	      PPITN = :L_S_PPITN AND PCITN = :L_S_PCITN USING SQLCA ;
			
		INSERT INTO "PBBPM"."BPM001"  
			( "PCMCD","PLANT","PDVSN","PPITN","PROUT","PCITN","PCHDT","PQTYM","PQTYE", "PWKCT","PEDTM",   
			  "PEDTE","POPCD","PEXPLANT","PEXDV","PCHCD","POSCD","PEBST",
			  "PMACADDR","PIPADDR","PINDT","PEMNO","PREMK" )  
			VALUES (:g_s_company,:l_s_plant,:l_s_div,:l_s_ppitn,:l_s_rout,:l_s_pcitn,:l_s_chdt,:l_s_qtym,:l_s_qtye
			  ,:l_s_wkct,:l_s_edtm,:l_s_edte,' ',:l_s_explant,:l_s_exdv,'A',:l_s_oscd,:l_s_ebst
			  ,:g_s_macaddr,:g_s_ipaddr,:g_s_date,:g_s_empno,' ')
			using sqlca;

		if sqlca.sqlcode <> 0 then
			messagebox("확인",sqlca.sqlerrtext)
			i_n_erreturn = -1
			rollback using sqlca;
			uo_status.st_message.text = f_message("A020")
			If IsValid(w_pism_working) Then Close(w_pism_working) 
			return 0
		else
			commit using sqlca;
			uo_status.st_message.text = f_message("A010")
		end if
		l_s_tree_value = 1
	//	f_lolev_update(l_s_plant,l_s_div,l_s_ppitn)
   end if
else
   DELETE FROM "PBBPM"."BPM001"  
	WHERE PCMCD = :G_S_COMPANY AND  PLANT = :L_S_plant AND PDVSN = :L_S_DIV AND 
	      PPITN = :L_S_PPITN AND PCITN = :L_S_PCITN USING SQLCA ;
   INSERT INTO "PBBPM"."BPM001"  
			( "PCMCD","PLANT","PDVSN","PPITN","PROUT","PCITN","PCHDT","PQTYM","PQTYE", "PWKCT","PEDTM",   
			  "PEDTE","POPCD","PEXPLANT","PEXDV","PCHCD","POSCD","PEBST",
			  "PMACADDR","PIPADDR","PINDT","PEMNO","PREMK" )  
			VALUES (:g_s_company,:l_s_plant,:l_s_div,:l_s_ppitn,:l_s_rout,:l_s_pcitn,:g_s_date,:l_s_qtym,:l_s_qtye
			  ,:l_s_wkct,:l_s_edtm,:l_s_edte,' ',:l_s_explant,:l_s_exdv,'R',:l_s_oscd,:l_s_ebst
			  ,:g_s_macaddr,:g_s_ipaddr,:g_s_date,:g_s_empno,' ')
	using sqlca;
	l_s_chkitno = f_option_chk_after_bpm(l_s_plant,l_s_div,l_s_pcitn,g_s_date) 
	if f_spacechk(l_s_chkitno) <> -1 and l_s_chkitno <> l_s_pcitn then
		l_s_valid_date = f_vaild_datechk(l_s_plant,l_s_div,l_s_ppitn,l_s_pcitn,'  ','  ')
		l_s_valid_date1 = mid(l_s_valid_date , 1, 8)
		l_s_valid_date2 = mid(l_s_valid_date , 9, 8)
		wf_option_update(l_s_plant,l_s_div,l_s_chkitno,l_s_pcitn,'R',l_s_valid_date1,l_s_valid_date2)
	else
		if l_s_chkitno = l_s_pcitn  then
			messagebox("확인", "Option 주품번입니다. Option 정보를 확인하십시오.")
		end if
	end if
end if
if l_s_tree_value = 1 then
	l_tvi_item.data = trim(l_s_pcitn)
	l_tvi_item.label = trim(l_s_pcitn) 
	l_tvi_item.children = false
	l_s_populate_no = 1
	l_s_handle = tv_1.finditem(CurrentTreeItem!, 0)
	l_tvi_item.SelectedPictureIndex = 2
   l_tvi_item.PictureIndex = 1
	tv_1.insertitemlast(l_s_handle, l_tvi_item)
	tv_1.setredraw(true)
end if

if rb_1.checked = true then
	dw_2.reset()
	dw_edit.reset()
	dw_2.retrieve(l_s_plant ,l_s_div,l_s_ppitn, g_s_date)
end if
if rb_2.checked = true then
	dw_3.reset()
	dw_edit.reset()
   dw_3.retrieve(l_s_plant,l_s_div,l_s_pcitn, g_s_date)
end if

If IsValid(w_pism_working) Then Close(w_pism_working) 
i_b_retrieve = true  
i_b_insert = true
i_b_delete = true
i_b_save = false
cb_1.enabled = true
cb_2.enabled = true
cb_3.enabled = true
cb_4.enabled = true
cb_5.enabled = true
cb_6.enabled = true
cb_7.enabled = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )
return 0
end event

type uo_status from w_origin_sheet01`uo_status within w_bpm105u
integer y = 2480
end type

type tv_1 from treeview within w_bpm105u
integer x = 14
integer y = 312
integer width = 1467
integer height = 2144
integer taborder = 130
boolean bringtotop = true
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
boolean disabledragdrop = false
boolean hideselection = false
boolean tooltips = false
string picturename[] = {"Custom039!","Custom050!","","","","","","","","","","","","","",""}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event itempopulate;Integer			l_n_Level
TreeViewItem	l_tvi_Current, l_tvi_root
Treeview			l_tv_current
String         l_s_data 
long           l_n_rows

if l_s_populate_no = 1 then
	l_s_populate_no = 0
	return 
end if

// Determine the level
tv_1.GetItem(handle, l_tvi_Current)
l_n_Level = l_tvi_Current.Level

if l_n_level >= 30 then 
	return
end if
if l_s_populate <> 0 then		
	wf_itempopulate(handle, tv_1)
end if
l_s_populate = 1

end event

event constructor;treeview	l_tv_current

l_tv_current	= this

wf_add_picture(l_tv_current)
end event

event selectionchanged;call super::selectionchanged;treeviewitem l_tvi_current
integer l_n_level, net
string  l_s_div, l_s_plant, l_s_rtncd

uo_status.st_message.text = ""

tv_1.getitem(newhandle,l_tvi_current)
l_n_level = l_tvi_current.level

l_s_rtncd = uo_1.uf_return()
l_s_plant = mid(l_s_rtncd,1,1)
l_s_div = mid(l_s_rtncd,2,1)

dw_edit.reset()

sle_1.text = l_tvi_current.data
if l_n_level = 1 and f_spacechk(sle_1.text) <> -1 then
	l_tvi_current.data = sle_1.text
end if
if l_n_level <> 1 or f_spacechk(sle_1.text) <> -1  then
	if rb_1.checked = true then
		dw_2.reset()
		dw_2.retrieve(l_s_plant,l_s_div,l_tvi_current.data,g_s_date)
	end if
	if rb_2.checked = true then
		dw_3.reset()
		dw_3.retrieve(l_s_plant,l_s_div,l_tvi_current.data,g_s_date)
	end if
end if


end event

event rightclicked;menubpm NewMenu

NewMenu = CREATE menubpm
newmenu.m_kew.m_delete.enabled = false
newmenu.m_kew.m_save.enabled = false

NewMenu.m_kew.PopMenu( parent.PointerX(), parent.PointerY() + 200 )
destroy menubpm











end event

type st_3 from statictext within w_bpm105u
integer x = 2610
integer y = 36
integer width = 160
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "품번"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_bpm105u
event ue_keydown pbm_keydown
integer x = 2766
integer y = 24
integer width = 553
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if key = keyenter! then
	parent.triggerevent("ue_retrieve")
end if
end event

type cb_1 from commandbutton within w_bpm105u
integer x = 55
integer y = 176
integer width = 302
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입 력"
end type

event clicked;window l_s_wsheet

l_s_wsheet = w_frame.GetActiveSheet()
l_s_wsheet.TriggerEvent("ue_insert")

end event

type cb_2 from commandbutton within w_bpm105u
integer x = 402
integer y = 176
integer width = 302
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "수 정"
end type

event clicked;call super::clicked;
string l_s_plant,l_s_div, l_s_itno1, l_s_itno2, l_s_date, l_s_rtncd
integer  l_n_row, net

l_s_sel = "C"

l_s_rtncd = uo_1.uf_return()
l_s_plant = mid(l_s_rtncd,1,1)
l_s_div = mid(l_s_rtncd,2,1)

if rb_1.checked = true then
	l_n_row = dw_2.getrow()
	if l_n_row < 1 then
		uo_status.st_message.text = f_message("E030")
		return
	end if
	l_s_itno1 = dw_2.getitemstring(l_n_row,"ppitn") 
   l_s_itno2 = dw_2.getitemstring(l_n_row,"pcitn")
	l_s_date = dw_2.getitemstring(l_n_row,"pchdt")
end if
if rb_2.checked = true then
	l_n_row = dw_3.getrow()
	if l_n_row < 1 then
		uo_status.st_message.text = f_message("E030")
		return
	end if
	l_s_itno1 = dw_3.getitemstring(l_n_row,"ppitn") 
   l_s_itno2 = dw_3.getitemstring(l_n_row,"pcitn")
	l_s_date = dw_3.getitemstring(l_n_row,"pchdt")
end if

wf_rgbclear()
dw_edit.retrieve(l_s_plant,l_s_div, l_s_itno1, l_s_itno2,l_s_date)
dw_edit.setcolumn("pqtym")
dw_edit.object.pcitn.protect = true
dw_edit.object.pqtym.protect = false
dw_edit.object.pwkct.protect = false
dw_edit.object.pexdv.protect = false
dw_edit.object.pedtm.protect = false
dw_edit.object.pedte.protect = false

dw_edit.object.pcitn.border = 0
dw_edit.object.pqtym.border = 5
dw_edit.object.pwkct.border = 5
dw_edit.object.pexdv.border = 5
dw_edit.object.pedtm.border = 5
dw_edit.object.pedte.border = 5
uo_status.st_message.text = ""
i_b_retrieve = true  
i_b_insert = true
i_b_delete = true
i_b_save = true
cb_1.enabled = true
cb_2.enabled = true
cb_3.enabled = true
cb_4.enabled = true
cb_5.enabled = true
cb_6.enabled = true
cb_7.enabled = true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )

end event

type cb_5 from commandbutton within w_bpm105u
integer x = 1454
integer y = 176
integer width = 320
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "상위복사"
end type

event clicked;call super::clicked;call super::clicked;long l_s_handle
treeviewitem l_tvi_item
string l_s_ppitn, l_s_plant, l_s_div, l_s_ppitn_01, l_s_errchk, l_s_parm,  l_s_chkitno
string l_s_rtncd
integer l_n_rows, i, net

f_sysdate()

l_s_rtncd = uo_1.uf_return()
l_s_plant = mid(l_s_rtncd,1,1)
l_s_div = mid(l_s_rtncd,2,1)

l_s_handle = tv_1.finditem(CurrentTreeItem!, 0)
if l_s_handle = -1 or l_s_handle = 1 then
	l_s_ppitn = upper(trim(sle_1.text))
else
	tv_1.getitem(l_s_handle,l_tvi_item)
   l_s_ppitn = upper(trim(l_tvi_item.data))
end if
l_s_ppitn_01 = mid(l_s_ppitn,1,12)
l_s_parm = l_s_plant + l_s_div + l_s_ppitn_01 + l_s_errchk

openwithparm(w_bpm105u_res_02, l_s_parm)

l_s_parm = message.stringparm
l_s_plant = mid(l_s_parm,1,1)
l_s_div = mid(l_s_parm,2,1)
l_s_ppitn = mid(l_s_parm,3,12)
l_s_errchk = mid(l_s_parm,15,1)

if l_s_errchk = "C" then
	uo_status.st_message.text = f_message("A030")
	return
end if
if l_s_errchk = "E" then
	uo_status.st_message.text = f_message("E330")
	return
end if

uo_status.st_message.text = f_message("A010")

l_s_chkitno = f_option_chk_after_bpm(l_s_plant,l_s_div,l_s_ppitn,g_s_date) 	

if l_s_chkitno <> "" then
	l_s_parm = ""
   if f_option_check_bpm(l_s_plant,l_s_div,l_s_chkitno) = 1 then
		l_s_parm = l_s_plant + l_s_div + l_s_chkitno 
      openwithparm(w_bpm105u_res_04, l_s_parm)	
	end if
end if

i_b_retrieve = true  
i_b_insert = true
i_b_delete = true
i_b_save = false
cb_1.enabled = true
cb_2.enabled = true
cb_3.enabled = true
cb_4.enabled = true
cb_5.enabled = true
cb_6.enabled = true
cb_7.enabled = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )

end event

type cb_3 from commandbutton within w_bpm105u
integer x = 736
integer y = 176
integer width = 302
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭 제"
end type

event clicked;window l_s_wsheet

l_s_wsheet = w_frame.GetActiveSheet()
l_s_wsheet.TriggerEvent("ue_delete")

end event

type cb_4 from commandbutton within w_bpm105u
integer x = 1093
integer y = 176
integer width = 320
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "하위복사"
end type

event clicked;call super::clicked;long l_s_handle
treeviewitem l_tvi_item
string l_s_ppitn, l_s_plant,l_s_div, l_s_ppitn_01, l_s_errchk, l_s_parm, l_s_rtncd
string l_d_div, l_d_ppitn, l_d_prout, l_d_pcitn, l_d_pchdt, l_d_pwkct, l_d_pedtm,  &
       l_d_pedte,  l_d_pexdv, l_d_poscd, l_d_pebst, l_d_pindt, l_d_pemno
long   l_d_pqtym, l_d_pqtye		 
integer l_n_rows, i, net

f_sysdate()
l_s_rtncd = uo_1.uf_return()
l_s_plant = mid(l_s_rtncd,1,1)
l_s_div = mid(l_s_rtncd,2,1)

l_s_handle = tv_1.finditem(CurrentTreeItem!, 0)
if l_s_handle = -1 or l_s_handle = 1 then
	l_s_ppitn = upper(trim(sle_1.text))
else
	tv_1.getitem(l_s_handle,l_tvi_item)
   l_s_ppitn = upper(trim(l_tvi_item.data))
end if
l_s_ppitn_01 = mid(l_s_ppitn,1,12)
l_s_parm = l_s_plant + l_s_div + l_s_ppitn_01 + l_s_errchk

openwithparm(w_bpm105u_res_01, l_s_parm)

l_s_parm = message.stringparm
l_s_div = mid(l_s_parm,1,1)
l_s_ppitn = mid(l_s_parm,2,12)
l_s_errchk = mid(l_s_parm,14,1)

if l_s_errchk = "C" then
	uo_status.st_message.text = f_message("A030")
	return
end if
if l_s_errchk = "E" then
	uo_status.st_message.text = f_message("E330")
	return
end if

uo_status.st_message.text = f_message("A010")

i_b_retrieve = true  
i_b_insert = true
i_b_delete = true
i_b_save = false
cb_1.enabled = true
cb_2.enabled = true
cb_3.enabled = true
cb_4.enabled = true
cb_5.enabled = true
cb_6.enabled = true
cb_7.enabled = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )

end event

type dw_edit from datawindow within w_bpm105u
event keydown pbm_keydown
event ue_keydown pbm_keydown
integer x = 1504
integer y = 1792
integer width = 3095
integer height = 672
integer taborder = 150
boolean bringtotop = true
string dataobject = "d_BPM001_105u_update"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;menubpm NewMenu

NewMenu = CREATE menubpm
newmenu.m_kew.m_insert.enabled = false
newmenu.m_kew.m_delete.enabled = false
newmenu.m_kew.m_retrieve.enabled = false
NewMenu.m_kew.PopMenu( parent.pointerx(), parent.pointery() + 200)
destroy menubpm

end event

event itemchanged;integer li_rtn
window l_s_wsheet

if KeyDown(KeyEnter!) = true then
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_save")
end if

if dwo.name = 'pexplant' then
	dw_edit.getchild("pexdv",i_dwc_dvsn)
	i_dwc_dvsn.settransobject(sqlca)
	i_dwc_dvsn.retrieve(data)
end if
end event

event constructor;dw_edit.settransobject(sqlca)

dw_edit.getchild("pexplant",i_dwc_plant)
i_dwc_plant.settransobject(sqlca)
i_dwc_plant.retrieve('SLE220')

dw_edit.getchild("pexdv",i_dwc_dvsn)
i_dwc_dvsn.settransobject(sqlca)
i_dwc_dvsn.retrieve('D')
end event

type rb_1 from radiobutton within w_bpm105u
integer x = 3141
integer y = 192
integer width = 389
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "하위 조회"
boolean checked = true
end type

type rb_2 from radiobutton within w_bpm105u
integer x = 2665
integer y = 192
integer width = 389
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "상위 조회"
end type

type cb_6 from commandbutton within w_bpm105u
integer x = 2162
integer y = 176
integer width = 302
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조 회"
end type

event clicked;call super::clicked;window l_s_wsheet

l_s_wsheet = w_frame.GetActiveSheet()
l_s_wsheet.TriggerEvent("ue_retrieve")

end event

type cb_7 from commandbutton within w_bpm105u
integer x = 1824
integer y = 176
integer width = 302
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저 장"
end type

event clicked;window l_s_wsheet

l_s_wsheet = w_frame.GetActiveSheet()
l_s_wsheet.TriggerEvent("ue_save")

end event

type pb_1 from picturebutton within w_bpm105u
integer x = 3342
integer y = 12
integer width = 238
integer height = 108
integer taborder = 150
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
vtextalign vtextalign = top!
end type

event clicked;string l_s_parm, l_s_div, l_s_pdcd, l_s_plant
int net
l_s_plant = uo_1.uf_return()
l_s_div = mid(l_s_plant,2,1)
l_s_pdcd  = mid(l_s_plant,3)
l_s_plant = mid(l_s_plant,1,1)

l_s_parm = l_s_plant + l_s_div + l_s_pdcd

openwithparm(w_bpm105u_res_03,l_s_parm)

l_s_parm = message.stringparm
sle_1.text = l_s_parm

end event

type gb_1 from groupbox within w_bpm105u
integer x = 18
integer y = 120
integer width = 2478
integer height = 168
integer taborder = 140
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_bpm105u
integer x = 2610
integer y = 128
integer width = 974
integer height = 164
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회구분"
end type

type gb_framemove from groupbox within w_bpm105u
event ue_gbmousedown pbm_lbuttondown
event ue_gbmousemove pbm_mousemove
event ue_gbmouseup pbm_lbuttonup
boolean visible = false
integer x = 9
integer y = 304
integer width = 1499
integer height = 2176
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
end type

event ue_gbmousedown;setpointer(sizeWE!)
end event

event ue_gbmousemove;integer li_border, li_curwidth
li_border = this.x + this.width
//if (li_border - 20) <= xpos and (li_border + 20) >= xpos then
setpointer(sizeWE!)
//end if
if flags = 1 then
	li_curwidth = this.width + (xpos - this.width)
	this.resize( li_curwidth,this.height)
end if
end event

event ue_gbmouseup;integer li_tvwidth,li_lvwidth
li_tvwidth = xpos - (tv_1.x + tv_1.width) 
tv_1.resize((tv_1.width + li_tvwidth - 20),tv_1.height)
li_lvwidth = 3607 - (xpos + 9)
dw_2.x = xpos + 9
dw_2.width = li_lvwidth
dw_3.x = xpos + 9
dw_3.width = li_lvwidth
dw_edit.x = xpos + 9
dw_edit.width = li_lvwidth

end event

event constructor;this.x = 14
this.y = 224
this.width = 1499
this.height = 1650
end event

type dw_2 from datawindow within w_bpm105u
integer x = 1504
integer y = 308
integer width = 3095
integer height = 1468
integer taborder = 120
string title = "none"
string dataobject = "d_BPM001_explo_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string l_s_div,l_s_plant, l_s_itno1, l_s_itno2, l_s_chdt, l_s_rtncd
int    net

this.selectrow(row,true)

l_s_sel = "C"

l_s_rtncd = uo_1.uf_return()
l_s_div = mid(l_s_rtncd,2,1)
l_s_plant = mid(l_s_rtncd,1,1)

l_s_itno1 = dw_2.getitemstring(row,"ppitn") 
l_s_itno2 = dw_2.getitemstring(row,"pcitn")
l_s_chdt = dw_2.getitemstring(row,"pchdt")
wf_rgbclear()
dw_edit.retrieve(l_s_plant,l_s_div, l_s_itno1, l_s_itno2,l_s_chdt)

dw_edit.object.pcitn.protect = true
dw_edit.object.pqtym.protect = false
dw_edit.object.pwkct.protect = false
dw_edit.object.pexplant.protect = false
dw_edit.object.pexdv.protect = false
dw_edit.object.pedtm.protect = false
dw_edit.object.pedte.protect = false
dw_edit.setfocus()
dw_edit.setcolumn("pqtym")
dw_edit.object.pcitn.border = 0
dw_edit.object.pqtym.border = 5
dw_edit.object.pwkct.border = 5
dw_edit.object.pexdv.border = 5
dw_edit.object.pedtm.border = 5
dw_edit.object.pedte.border = 5
uo_status.st_message.text = ""
i_b_retrieve = true  
i_b_insert = true
i_b_delete = true
i_b_save = true
cb_1.enabled = true
cb_2.enabled = true
cb_3.enabled = true
cb_4.enabled = true
cb_5.enabled = true
cb_6.enabled = true
cb_7.enabled = true

wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )



end event

event clicked;if row <= 0 then
	return
end if
dw_edit.reset()
If Keydown(KeyShift!) then
	wf_Shift_Highlight(row, this)
ElseIf Keydown(KeyControl!) then
	i_i_LastRow = row
	if this.IsSelected(row) Then
		this.SelectRow(row,FALSE)
	else
		this.SelectRow(row,TRUE)
	end if	
Else
	i_i_LastRow = row
	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
End If
end event

event rbuttondown;menubpm NewMenu

NewMenu = CREATE menubpm
newmenu.m_kew.m_retrieve.enabled = false
newmenu.m_kew.m_insert.enabled = false
newmenu.m_kew.m_save.enabled = false

NewMenu.m_kew.PopMenu( parent.pointerx(), parent.pointery() + 200 )
destroy menubpm

end event

event constructor;dw_2.settransobject(sqlca)

end event

event retrieveend;string ls_midval
integer i

for i = 1 to rowcount
	ls_midval = f_option_chk_after_BPM(this.object.plant[i],this.object.pdvsn[i],trim(this.object.pcitn[i]),g_s_date) 
	if f_spacechk(ls_midval) <> -1 then
		if trim(ls_midval) = trim(this.object.pcitn[i]) then
			ls_midval = '*'
		end if
	end if
	this.object.opt_itno[i] = ls_midval
next


end event

type dw_3 from datawindow within w_bpm105u
boolean visible = false
integer x = 1504
integer y = 316
integer width = 3099
integer height = 1460
integer taborder = 160
string dataobject = "d_BPM001_implo_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string l_s_div,l_s_plant, l_s_itno1, l_s_itno2, l_s_chdt
integer net

this.selectrow(row,true)
l_s_sel = "C"

l_s_plant = uo_1.uf_return()
l_s_div = mid(l_s_plant,2,1)
l_s_plant = mid(l_s_plant,1,1)

l_s_itno1 = dw_3.getitemstring(row,"ppitn") 
l_s_itno2 = dw_3.getitemstring(row,"pcitn")
l_s_chdt = dw_3.getitemstring(row,"pchdt")
wf_rgbclear()
dw_edit.retrieve(l_s_plant,l_s_div, l_s_itno1, l_s_itno2,l_s_chdt)

dw_edit.object.pcitn.protect = true
dw_edit.object.pqtym.protect = false
dw_edit.object.pwkct.protect = false
dw_edit.object.pexdv.protect = false
dw_edit.object.pexplant.protect = false
dw_edit.object.pedtm.protect = false
dw_edit.object.pedte.protect = false
dw_edit.setfocus()
dw_edit.setcolumn("pqtym")
dw_edit.object.pcitn.border = 0
dw_edit.object.pqtym.border = 5
dw_edit.object.pwkct.border = 5
dw_edit.object.pexdv.border = 5
dw_edit.object.pedtm.border = 5
dw_edit.object.pedte.border = 5
uo_status.st_message.text = ""
i_b_retrieve = true  
i_b_insert = true
i_b_delete = true
i_b_save = true
cb_1.enabled = true
cb_2.enabled = true
cb_3.enabled = true
cb_4.enabled = true
cb_5.enabled = true
cb_6.enabled = true
cb_7.enabled = true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, i_b_dprint, i_b_dchar )



end event

event clicked;if row <= 0 then
	return
end if
dw_edit.reset()
If Keydown(KeyShift!) then
	wf_Shift_Highlight(row, this)
ElseIf Keydown(KeyControl!) then
	i_i_LastRow = row
	if this.IsSelected(row) Then
		this.SelectRow(row,FALSE)
	else
		this.SelectRow(row,TRUE)
	end if	
Else
	i_i_LastRow = row
	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
End If
end event

event rbuttondown;menubpm NewMenu

NewMenu = CREATE menubpm
newmenu.m_kew.m_retrieve.enabled = false
newmenu.m_kew.m_insert.enabled = false
newmenu.m_kew.m_save.enabled = false
NewMenu.m_kew.PopMenu( parent.pointerx(), parent.pointery() + 200 )
destroy menubpm

end event

event constructor;dw_3.settransobject(sqlca)

end event

event retrieveend;string ls_midval
integer i

for i = 1 to rowcount
	ls_midval = f_option_chk_after_BPM(this.object.plant[i],this.object.pdvsn[i],trim(this.object.pcitn[i]),g_s_date) 
	if f_spacechk(ls_midval) <> -1 then
		if trim(ls_midval) = trim(this.object.pcitn[i]) then
			ls_midval = '*'
		end if
	end if
	this.object.opt_itno[i] = ls_midval
next

end event

type uo_1 from uo_plandiv_pdcd within w_bpm105u
integer x = 27
integer y = 4
integer taborder = 30
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

