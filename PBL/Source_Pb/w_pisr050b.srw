$PBExportHeader$w_pisr050b.srw
$PBExportComments$���Ǹż������߰�����
forward
global type w_pisr050b from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr050b
end type
type uo_division from u_pisc_select_division within w_pisr050b
end type
type tab_main from tab within w_pisr050b
end type
type tabpage_1 from userobject within tab_main
end type
type st_jobdays from statictext within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type dw_pisr050b_01 from u_vi_std_datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_main
st_jobdays st_jobdays
st_2 st_2
dw_pisr050b_01 dw_pisr050b_01
end type
type tabpage_2 from userobject within tab_main
end type
type gb_2 from groupbox within tabpage_2
end type
type dw_pisr050b_03 from u_vi_std_datawindow within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type sle_nomalqty from singlelineedit within tabpage_2
end type
type gb_3 from groupbox within tabpage_2
end type
type st_4 from statictext within tabpage_2
end type
type sle_tempqty from singlelineedit within tabpage_2
end type
type st_5 from statictext within tabpage_2
end type
type sle_rackqty from singlelineedit within tabpage_2
end type
type tabpage_2 from userobject within tab_main
gb_2 gb_2
dw_pisr050b_03 dw_pisr050b_03
st_3 st_3
sle_nomalqty sle_nomalqty
gb_3 gb_3
st_4 st_4
sle_tempqty sle_tempqty
st_5 st_5
sle_rackqty sle_rackqty
end type
type tabpage_3 from userobject within tab_main
end type
type dw_pisr050b_06 from u_vi_std_datawindow within tabpage_3
end type
type cbx_all from checkbox within tabpage_3
end type
type st_printcnt from statictext within tabpage_3
end type
type st_printcnt_t from statictext within tabpage_3
end type
type dw_parttype from datawindow within tabpage_3
end type
type st_tpg3_vsplitbar from u_pism_splitbar within tabpage_3
end type
type rb_tab3_1 from radiobutton within tabpage_3
end type
type rb_tab3_2 from radiobutton within tabpage_3
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_pisr050b_05 from u_vi_std_datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_main
dw_pisr050b_06 dw_pisr050b_06
cbx_all cbx_all
st_printcnt st_printcnt
st_printcnt_t st_printcnt_t
dw_parttype dw_parttype
st_tpg3_vsplitbar st_tpg3_vsplitbar
rb_tab3_1 rb_tab3_1
rb_tab3_2 rb_tab3_2
gb_4 gb_4
dw_pisr050b_05 dw_pisr050b_05
end type
type tab_main from tab within w_pisr050b
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type tv_partkb from u_pisr_treeview within w_pisr050b
end type
type st_vsplitbar from u_pism_splitbar within w_pisr050b
end type
type cb_aschange from commandbutton within w_pisr050b
end type
type cb_5 from commandbutton within w_pisr050b
end type
type uo_month from u_pisc_date_scroll_month within w_pisr050b
end type
type gb_1 from groupbox within w_pisr050b
end type
type gb_5 from groupbox within w_pisr050b
end type
type gb_6 from groupbox within w_pisr050b
end type
end forward

global type w_pisr050b from w_ipis_sheet01
integer width = 5001
event ue_init ( )
event ue_partkbasconvert ( )
uo_area uo_area
uo_division uo_division
tab_main tab_main
tv_partkb tv_partkb
st_vsplitbar st_vsplitbar
cb_aschange cb_aschange
cb_5 cb_5
uo_month uo_month
gb_1 gb_1
gb_5 gb_5
gb_6 gb_6
end type
global w_pisr050b w_pisr050b

type variables
str_pisr_partkb istr_partkb
DataStore ids_prkblist, ids_reprkblist
//String is_today

end variables

forward prototypes
public subroutine wf_settag (integer ai_index)
public function integer wf_setreprkblist (datawindow adw)
public function integer wf_setprkbcnt (datawindow adw)
public function integer wf_setkbprlist (datawindow adw, long al_row, string as_prchk)
public function integer wf_setkbprcnt (datawindow adw, integer ai_prcnt, datawindow adw_tar)
public function long wf_cr_kbno (string as_itemcode, string as_kbgubun, long al_kbcnt, long al_rackqty)
end prototypes

event ue_init();cb_aschange.Enabled	= m_frame.m_action.m_save.Enabled

Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 

//splitbar ����
st_vsplitbar.of_Register(tv_partkb, st_vsplitbar.LEFT)
st_vsplitbar.of_Register(tab_main.tabpage_1.dw_pisr050b_01, st_vsplitbar.RIGHT)
st_vsplitbar.of_Register(tv_partkb, st_vsplitbar.LEFT)
st_vsplitbar.of_Register(tab_main.tabpage_2.dw_pisr050b_03, st_vsplitbar.RIGHT)
st_vsplitbar.of_Register(tv_partkb, st_vsplitbar.LEFT)
st_vsplitbar.of_Register(tab_main.tabpage_3.dw_pisr050b_05, st_vsplitbar.RIGHT)		
//st_tpg3_vsplitbar
tab_main.tabpage_3.st_tpg3_vsplitbar.of_Register(tab_main.tabpage_3.dw_pisr050b_05, tab_main.tabpage_3.st_tpg3_vsplitbar.LEFT)
tab_main.tabpage_3.st_tpg3_vsplitbar.of_Register(tab_main.tabpage_3.dw_pisr050b_06, tab_main.tabpage_3.st_tpg3_vsplitbar.RIGHT)

//tab_main.tabpage_2.dw_crkbno_input.ScrollToRow(tab_main.tabpage_2.dw_crkbno_input.InsertRow(0))
//tab_main.tabpage_3.dw_parttype.ScrollToRow(tab_main.tabpage_3.dw_parttype.InsertRow(0))
//
////is_today = f_get_today()
//
//tab_main.tabpage_1.st_yymm.Text = Left(is_today, 7)

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//��ȸ

// TreeView ����
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode, true)


end event

event ue_partkbasconvert();str_pisr_partKb lstr_partKb 
Long 		ll_row 
String	ls_Result

lstr_partKb = istr_partkb

If lstr_partKb.itemcode = '' OR isNull( lstr_partKb.itemcode ) Then
	MessageBox("���ý���", "Active/Sleeping��ȯ�� ǰ���� ���õ��� �ʾҽ��ϴ�.", Information!)
	return
End if
openWithParm(w_pisr051b, lstr_partKb)
ls_Result	= Message.StringParm

If ls_Result = 'CHANGE' Then 
	This.TriggerEvent( "ue_retrieve" )
End If
end event

public subroutine wf_settag (integer ai_index);
Choose Case ai_index
	Case 1
		tab_main.tabpage_2.Tag = 'N'
		tab_main.tabpage_3.Tag = 'N'		
	Case 2
		tab_main.tabpage_1.Tag = 'N'
		tab_main.tabpage_3.Tag = 'N'				
	Case 3
		tab_main.tabpage_1.Tag = 'N'
		tab_main.tabpage_2.Tag = 'N'				
End Choose 
		
end subroutine

public function integer wf_setreprkblist (datawindow adw);Integer I 

For I = 1 To adw.RowCount() 
	wf_setkbprlist(adw, I, 'Y') 
Next 

Return 1 
end function

public function integer wf_setprkbcnt (datawindow adw);Integer I, li_kbCnt 

adw.AcceptText()

For I = 1 To adw.RowCount()
	If adw.GetItemString(I, "prkbChk") = 'Y' Then li_kbCnt++
Next 

Return li_kbCnt 
end function

public function integer wf_setkbprlist (datawindow adw, long al_row, string as_prchk);Integer I, li_prkbCnt
String ls_kbNo, ls_prChk 
Long ll_findRow 
//DataStore ids_prkblist, ids_reprkblist	//	
//String is_today									//

adw.AcceptText()
If al_row > 0 Then 
	ls_prChk = as_prChk 
	ls_kbNo = adw.GetItemString(al_row, "partkbno")
	ll_findRow = ids_prkblist.Find("partkbno = '" + ls_kbNo + "'", 1, ids_prkblist.RowCount())
	If ls_prChk = 'Y' Then 
		If ll_findRow <= 0 Then adw.RowsCopy(al_row, al_row, Primary!, ids_prkblist, 1, Primary!)
	Else
		If ll_findRow > 0 Then ids_prkblist.DeleteRow(ll_findRow) 
	End If 	
	adw.SetItem(al_row, "prkbchk", ls_prChk)
	li_prkbCnt = wf_setprKbCnt(adw)
Else
	For I = 1 To adw.RowCount()
		ls_prChk = 'N' 
		ls_kbNo = adw.GetItemString(I, "partkbno")
		ll_findRow = ids_prkblist.Find("partkbno = '" + ls_kbNo + "'", 1, ids_prkblist.RowCount())
		If ll_findRow > 0 Then ls_prChk = 'Y' 
		adw.SetItem(I, "prkbchk", ls_prChk)
		If ls_prChk = 'Y' Then li_prkbCnt++ 
	Next 
End If 

Return li_prkbCnt 
end function

public function integer wf_setkbprcnt (datawindow adw, integer ai_prcnt, datawindow adw_tar);Integer I, li_prkbCnt
Long ll_findRow

ll_findRow = adw.Find("prkbchk = 'Y'", 1, adw.RowCount())
Do while ll_findRow > 0 
	li_prkbCnt++
	If ll_findRow = adw.RowCount() Then Exit 
	ll_findRow++ 
	ll_findRow = adw.Find("prkbchk = 'Y'", ll_findRow, adw.RowCount())
Loop 

If li_prkbCnt > ai_prcnt Then 
	For i = li_prkbCnt To ai_prcnt Step -1 
		adw.SetItem(i, 'prkbchk', 'N')
		wf_setkbprlist(adw, I, 'N')
	Next	
Else
	For i = li_prkbCnt To ai_prcnt
		adw.SetItem(i, 'prkbchk', 'Y')
		wf_setkbprlist(adw, I, 'Y')
	Next
End If 

adw_tar.SetItem(adw_tar.GetRow(), "prkbCnt", ai_prcnt)

Return 1 
end function

public function long wf_cr_kbno (string as_itemcode, string as_kbgubun, long al_kbcnt, long al_rackqty);
Integer 	ri_errcode 
istr_partkb.suppCode = Upper(istr_partkb.suppCode)
as_itemCode				= Upper(as_itemCode)

Declare proc_crKbNo Procedure For sp_pisr050b_kbcreate &
 :istr_partkb.areaCode, :istr_partkb.divCode, :istr_partkb.suppCode, :as_itemCode, &
 :as_kbGubun, :al_kbCnt, :al_rackQty, :g_s_empno, @ri_errcode = 0 Output  
USING sqlpis ;

Execute proc_crKbNo ;
If f_pisr_Errorhandler(Sqlpis, "Execute proc_crKbNo", "Faild") = 0 Then 
	Fetch proc_crKbNo Into :ri_errcode ;
	If f_pisr_Errorhandler(Sqlpis, "Fetch proc_crKbNo", "Failed") <> 0 Then
		Messagebox( "���ǹ�ȣ���� ����", "�ش� ǰ���� ���ǹ�ȣ������ �����߽��ϴ�.", StopSign!)
		Close proc_crKbNo ;
		Return -1 
	End If
Else
	Return -1 
End If
Close proc_crKbNo ;

Return 1 

end function

on w_pisr050b.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.tab_main=create tab_main
this.tv_partkb=create tv_partkb
this.st_vsplitbar=create st_vsplitbar
this.cb_aschange=create cb_aschange
this.cb_5=create cb_5
this.uo_month=create uo_month
this.gb_1=create gb_1
this.gb_5=create gb_5
this.gb_6=create gb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.tab_main
this.Control[iCurrent+4]=this.tv_partkb
this.Control[iCurrent+5]=this.st_vsplitbar
this.Control[iCurrent+6]=this.cb_aschange
this.Control[iCurrent+7]=this.cb_5
this.Control[iCurrent+8]=this.uo_month
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.gb_5
this.Control[iCurrent+11]=this.gb_6
end on

on w_pisr050b.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.tab_main)
destroy(this.tv_partkb)
destroy(this.st_vsplitbar)
destroy(this.cb_aschange)
destroy(this.cb_5)
destroy(this.uo_month)
destroy(this.gb_1)
destroy(this.gb_5)
destroy(this.gb_6)
end on

event open;call super::open;this.PostEvent ( "ue_init" )

ids_prkblist = Create DataStore; ids_reprkblist = Create DataStore 
ids_prkblist.DataObject 	= tab_main.tabpage_3.dw_pisr050b_06.DataObject 
ids_reprkblist.DataObject 	= tab_main.tabpage_3.dw_pisr050b_06.DataObject 
ids_prkblist.SetTransObject(sqlpis); ids_reprkblist.SetTransObject(sqlpis) 
end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 5 		// window �� dw_control �� Gap�� 5
Integer ls_status = 120 // statusbar �� ���̴� 120 ( Gap ���� )

tab_main.Width 	= newwidth - ( tab_main.x + ls_gap ) 
tab_main.Height 	= newheight - ( tab_main.y + ls_status )
//MessageBox( "������", string(newwidth)+','+string(newheight))

end event

event ue_retrieve;call super::ue_retrieve;tab_main.Control[tab_main.SelectedTab].TriggerEvent("tpgu_retrieve") 


end event

event ue_save;call super::ue_save;tab_main.Control[tab_main.SelectedTab].TriggerEvent("tpgu_save") 

end event

event ue_print;call super::ue_print;tab_main.Control[tab_main.SelectedTab].TriggerEvent("tpgu_print") 
end event

event ue_delete;call super::ue_delete;tab_main.Control[tab_main.SelectedTab].TriggerEvent("tpgu_delete") 
end event

event close;call super::close;DESTROY ids_prkblist ; DESTROY ids_reprkblist
end event

event ue_postopen;call super::ue_postopen;
f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
									
uo_month.uf_setdata(date(f_pisc_get_date_nowtime()))
uo_month.uf_setfocus()

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr050b
end type

type uo_area from u_pisc_select_area within w_pisr050b
event destroy ( )
integer x = 750
integer y = 80
integer taborder = 40
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event constructor;call super::constructor;//ib_allflag = True
end event

event ue_select;call super::ue_select;//messagebox("", is_uo_areacode + ' ' + is_uo_areaname)

istr_partkb.areacode = is_uo_areacode

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
istr_partkb.divcode = uo_division.is_uo_divisioncode
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode, true)
end event

type uo_division from u_pisc_select_division within w_pisr050b
event destroy ( )
integer x = 1257
integer y = 80
integer taborder = 60
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode, true)
end event

type tab_main from tab within w_pisr050b
event resize pbm_size
integer x = 9
integer y = 196
integer width = 4503
integer height = 1700
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean createondemand = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

event resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 5 		// window �� dw_control �� Gap�� 5
Integer ls_status = 120 // statusbar �� ���̴� 120 ( Gap ���� )
Integer tab_name 		= 100 // TabpageTitle 
Integer tab_control 	= 160 // Tabpage��� Control ����
Integer I 

//MessageBox( "��������", string(newwidth)+','+string(newheight))
tv_partkb.y				= tab_main.y + tab_name + tab_control
tv_partkb.Height 		= newheight - ( tab_name + ls_gap * 4 + tab_control)
st_vsplitbar.y 		= tv_partkb.y
st_vsplitbar.Height 	= tv_partkb.Height 

For I = 1 To UpperBound(tab_main.Control[])
	tab_main.Control[I].Event Dynamic tpgu_resize(newwidth, newheight) 
Next 
end event

on tab_main.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_main.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;
If Control[newindex].Tag = 'N' Then parent.PostEvent("ue_retrieve")

end event

type tabpage_1 from userobject within tab_main
event tpgu_resize ( integer newwidth,  integer newheight )
event tpgu_retrieve ( )
event tpgu_partkbcreate ( )
event tpgu_save ( )
event tpgu_print ( )
event tpgu_deletere ( )
integer x = 18
integer y = 100
integer width = 4466
integer height = 1584
long backcolor = 12632256
string text = "���ǿ�ż����"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_jobdays st_jobdays
st_2 st_2
dw_pisr050b_01 dw_pisr050b_01
end type

event tpgu_resize(integer newwidth, integer newheight);Integer ls_split 		= 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap 		= 5 	// window �� dw_control �� Gap�� 5
Integer ls_status 	= 120 // statusbar �� ���̴� 120 ( Gap ���� )
Integer tab_name 		= 100 // TabpageTitle 
Integer tab_control 	= 160 // Tabpage��� Control ����

dw_pisr050b_01.Height 	= newheight - ( tab_name + ls_gap * 4 + tab_control) 
dw_pisr050b_01.x 			= tv_partkb.Width + ls_split
dw_pisr050b_01.Width 	= newwidth - ( dw_pisr050b_01.x + ls_gap * 8)

//st_workdays.X = newwidth - ( st_workdays.Width + 40 )
//st_workdays_.X = newwidth - ( st_workdays_.Width + st_workdays.Width + 40 )

end event

event tpgu_retrieve();//MessageBox( "tab_1", istr_partKB.areaCode+','+istr_partKB.divCode+','+istr_partKB.suppCode+','+uo_month.is_uo_month)

dw_pisr050b_01.SetRedraw(False)
dw_pisr050b_01.SetTransObject(Sqlpis)
dw_pisr050b_01.Retrieve(istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode, uo_month.is_uo_month)
dw_pisr050b_01.SetRedraw(True)

This.Tag = ''
end event

event tpgu_partkbcreate();//Integer I, li_prQty, li_nRackQty, li_prCnt
//String ls_itemCode
//
//If rb_all.Checked Then 
//	If f_MessageBox3(Question!, 999, "���ǹ�ȣ����", "�����ʿ�ż��� 0 ���� ū �׸� ���Ͽ� ���԰��ǹ�ȣ�� " + &
//												"�����մϴ�. ����Ͻðڽ��ϱ�?", "��", "�ƴϿ�") <> 1 Then Return 
//Else
//	If dw_monthqty_grid.GetSelectedRow(0) = 0 Then 
//		f_MessageBox(Information!, 999, "���ǹ�ȣ���� ����", "���ǹ�ȣ�� ������ ǰ���� ���õ��� �ʾҽ��ϴ�.")
//		Return 
//	End If
//End If 
//
//Sqlca.AutoCommit = False
//For I = 1 To dw_monthqty_grid.RowCount() 
//	ls_itemCode = dw_monthqty_grid.GetItemString(I, "itemcode")
//	li_prQty = dw_monthqty_grid.GetItemNumber(I, "prQty")	
//	li_nRackQty = dw_monthqty_grid.GetItemNumber(I, "RackQty")
//	
//	If li_prQty = 0 Then Continue
//	If rb_item.Checked And Not dw_monthqty_grid.IsSelected(I) Then Continue 
//	If wf_cr_kbNo(ls_itemCode, 'N', li_nRackQty, li_prQty) = -1 Then Goto RollBack_
//	li_prCnt++
//Next 
//
//If li_prCnt = 0 Then 
//	f_MessageBox(Information!, 999, "���ǹ�ȣ ����", "���� �ʿ�ż��� 0 �̻��� �׸��� �������� �ʽ��ϴ�.")
//Else
//	f_sql_chkopt(Sqlca, True)
//	f_MessageBox(Information!, 999, "���ǹ�ȣ ����", "�ش� ǰ���� ���ǹ�ȣ�� ���������� �����Ͽ����ϴ�.")
//	
//	pb_disp.TriggerEvent(Clicked!)	
//End If
//
//Return 
//
//RollBack_:
//f_MessageBox(StopSign!, 999, "���ǹ�ȣ���� ����", "�ش� ǰ���� ���ǹ�ȣ�� �����ϴµ� �����߽��ϴ�.")
//
//RollBack Using Sqlca;
//Sqlca.AutoCommit = True 
end event

event tpgu_save();Long 		ll_printCnt, ll_activeCnt, ll_planCnt
Long		ll_rowCnt, ll_insCnt, ll_newCnt, ll_partKBR
String	ls_itemChk, ls_suppCode, ls_itemCode
String	ls_modelID, ls_NormalSN, ls_partKBL
Integer	I, J, ls_Net
DateTime	ldt_nowTime
String	ls_message, ls_message1

ls_message = ''; ls_message1 = ''

ll_rowCnt = dw_pisr050b_01.RowCount()
IF ll_rowCnt < 1 THEN Return 

ldt_nowTime	= f_pisc_get_date_nowtime()

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

FOR I = 1 TO ll_rowCnt STEP 1
	ls_suppCode 	= dw_pisr050b_01.GetItemString( I, 'suppliercode' )
	ls_itemCode 	= dw_pisr050b_01.GetItemString( I, 'itemcode' )
	ls_modelID	 	= dw_pisr050b_01.GetItemString( I, 'partmodelid' )
	ls_NormalSN		= dw_pisr050b_01.GetItemString( I, 'normalkbsn' )
	ls_partKBL 		= Left( ls_NormalSN, 8 )
	ll_partKBR 		= long( Right( ls_NormalSN, 3 ))
	ll_printCnt 	= dw_pisr050b_01.GetItemNumber( I, 'partkbprintcount' )
	ll_activeCnt 	= dw_pisr050b_01.GetItemNumber( I, 'partkbactivecount' )
	ll_planCnt 		= dw_pisr050b_01.GetItemNumber( I, 'partkbplancount' )
	ll_insCnt		= ll_planCnt - ll_printCnt		//�����ʿ�ż�
	ll_newCnt		= ll_planCnt - ll_partKBR		//�űԻ����ż�

//	ls_Net = MessageBox("Ȯ�ο�û", ls_modelID +" �׸��� ���� ��µ��� ���� ������ �����մϴ�." &
//			Exclamation!, OKCancel!, 2)
//	IF ls_Net = 1 THEN
//	ELSE
//	END IF	
	
	IF ll_newCnt < 1 THEN Continue
	FOR J = 1 TO ll_newCnt STEP 1
		ls_NormalSN = ls_partKBL + String( ll_partKBR + J, "000" )
	  INSERT INTO TPARTKBSTATUS  
	  SELECT :ls_NormalSN,			//���簣�ǹ�ȣ
				A.AreaCode,   			//�����ڵ�
				A.DivisionCode,   	//�����ڵ�
				A.SupplierCode,   	//��ü�����ȣ
				A.ItemCode,   			//ǰ��
				A.ApplyFrom,   		//Master���������
				A.PartType,   			//�����ǰ����
				'Y',   					//����� �ʿ� Flag
				0,   						//����� ȸ��
				'N',   					//���簣�Ǳ��� 'N'����, 'T'�ӽ�
				'S',   					//���� Active ����
				'D',   					//���� ���� 'D'���ִ��
				'N',   					//���ְ��ɱ���
				A.RackQty,   			//�����
				'N',						//���ֺ��汸��  
				'N',						//������ұ���  
				'N',						//���԰���ұ���  
				A.UseCenterGubun,   	//���ó����
				A.UseCenter,   		//���ó
				0,							//���������ؼ�
				0,							//����ð��ؼ�
				Null,						//��������
				Null,						//���ֽð�
				Null,						//���Կ�������
				Null,						//���Կ������
				Null,						//���Կ����ð�
				Null,						//��������
				Null,						//�������
				Null,						//���԰�ð�
				Null,						//�԰�����
				Null,						//�԰�ð�
				Null,						//���ֹ�ȣ
				Null,						//��ǰǥ��ȣ
				Null,						//���ǰ��������ȣ
				:ldt_nowTime,			//���ǻ�������
				Null,						//���ǹ�������
				Null,						//���ֺ���Ⱒ
				Null,						//���ֺ�������ڵ�
				Null,						//���泳�Կ�����
				Null,						//���泳�Կ������
				Null,						//���泳�Կ����ð�
				Null,						//���ֹ�ȣ(KDAC Upload��)
				'Y',				//Interface Flag Ȱ��
				:ldt_nowTime
		 FROM TMSTPARTKB A
		Where A.AreaCode 		= :istr_partkb.areacode 	And
				A.DivisionCode = :istr_partkb.divcode 		And
				A.SupplierCode = :ls_suppCode 				And
				A.itemCode 		= :ls_itemCode
		USING sqlpis	;
		IF sqlpis.SqlCode <> 0 THEN 
//			MessageBox( "���ǻ�������" + string(sqlpis.SqlCode), ls_modelID + " �׸��� " + &
//											ls_NormalSN + " ������ ������ ���� �߽��ϴ�.", StopSign! )
			ls_message = 'TPARTKBSTATUS_Err'
			ls_message1 = '[' + string(sqlpis.SqlCode) + ']' + ls_modelID + " �׸��� " + ls_NormalSN 
			GoTo RollBack_
		END IF
	NEXT	//J

  UPDATE TMSTPARTKB  
     SET NormalKBSN 			= :ls_NormalSN,
	      partkbplancount 	= :ll_planCnt,
			LastEmp				= 'Y',
			LastDate				= Getdate()
   WHERE TMSTPARTKB.AreaCode 		= :istr_partkb.areaCode AND  
         TMSTPARTKB.DivisionCode = :istr_partkb.divCode  AND  
         TMSTPARTKB.SupplierCode = :ls_suppCode  			AND  
         TMSTPARTKB.ItemCode 		= :ls_itemCode    
	USING sqlpis	;
	IF sqlpis.SqlCode <> 0 THEN 
//		MessageBox( "�������", ls_itemCode + " ǰ���� ���Ǹż����� ������ ���� �߽��ϴ�.", &
//											 StopSign! )
		ls_message = 'TMSTPARTKB_Err'
		ls_message1 = ls_itemCode
		GoTo RollBack_
	END IF
NEXT	//I

//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)
MessageBox( "����Ϸ�", "�ű԰��� ���� �� ������ ���ƽ��ϴ�.", Information! )
this.TriggerEvent( "tpgu_retrieve" )

Return 

RollBack_:
Rollback Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

CHOOSE CASE ls_message
	CASE 'TPARTKBSTATUS_Err'
		MessageBox( "���ǻ�������", ls_message1 + " ������ ������ ���� �߽��ϴ�.", StopSign! )
	CASE 'TMSTPARTKB_Err'
		MessageBox( "�������", ls_message1 + " ǰ���� ���Ǹż����� ������ ���� �߽��ϴ�.", StopSign! )
	CASE ELSE
		MessageBox( "�������", "���� ������ ���� �߽��ϴ�.", StopSign! )
END CHOOSE

Return 

end event

event tpgu_print();return
end event

event tpgu_deletere();return
end event

on tabpage_1.create
this.st_jobdays=create st_jobdays
this.st_2=create st_2
this.dw_pisr050b_01=create dw_pisr050b_01
this.Control[]={this.st_jobdays,&
this.st_2,&
this.dw_pisr050b_01}
end on

on tabpage_1.destroy
destroy(this.st_jobdays)
destroy(this.st_2)
destroy(this.dw_pisr050b_01)
end on

type st_jobdays from statictext within tabpage_1
integer x = 1198
integer y = 56
integer width = 457
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 255
long backcolor = 12632256
string text = "0"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_1
integer x = 727
integer y = 64
integer width = 466
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "�Ϳ��۾��ϼ� : "
boolean focusrectangle = false
end type

type dw_pisr050b_01 from u_vi_std_datawindow within tabpage_1
integer x = 722
integer y = 160
integer width = 2853
integer height = 1424
integer taborder = 11
string dataobject = "d_pisr050b_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;//If row > 0 Then pb_qtyedit.TriggerEvent(Clicked!)
end event

event retrieveend;call super::retrieveend;long ll_jobDays 

//ll_jobDays = f_getjabdays(tv_partkb.uistr_partKb.divCode, Left(is_today, 7))

if rowcount < 1 then
	return 0
end if
ll_jobDays = dw_pisr050b_01.GetItemNumber( 1, 'jabdays' )
st_jobdays.Text = String(ll_jobDays) 
If rowcount = 0 Then This.Tag = '' 
end event

event rowfocuschanged;call super::rowfocuschanged;If currentrow <= 0 Or This.RowCount() = 0 Then Return 
String ls_itemCode 

ls_itemCode = This.GetItemString(currentrow, "itemcode")
If IsNull(ls_itemCode) Then ls_itemCode = ''

This.Tag = trim(ls_itemCode) 
istr_partkb.itemcode = ls_itemCode
end event

event itemchanged;call super::itemchanged;this.AcceptText()

end event

type tabpage_2 from userobject within tab_main
event tpgu_resize ( integer newwidth,  integer newheight )
event tpgu_retrieve ( )
event tpgu_add ( )
event tpgu_delete ( )
event tpgu_save ( )
event tpgu_print ( )
integer x = 18
integer y = 100
integer width = 4466
integer height = 1584
long backcolor = 12632256
string text = "���Ǹż��߰�"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
gb_2 gb_2
dw_pisr050b_03 dw_pisr050b_03
st_3 st_3
sle_nomalqty sle_nomalqty
gb_3 gb_3
st_4 st_4
sle_tempqty sle_tempqty
st_5 st_5
sle_rackqty sle_rackqty
end type

event tpgu_resize(integer newwidth, integer newheight);Integer ls_split 		= 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap 		= 5 	// window �� dw_control �� Gap�� 5
Integer ls_status 	= 120 // statusbar �� ���̴� 120 ( Gap ���� )
Integer tab_name 		= 100 // TabpageTitle 
Integer tab_control 	= 160 // Tabpage��� Control ����

dw_pisr050b_03.Height 	= newheight - ( tab_name + ls_gap * 4 + tab_control ) 
dw_pisr050b_03.x 			= tv_partkb.Width + ls_split
dw_pisr050b_03.Width 	= newwidth - ( dw_pisr050b_03.x + ls_gap * 8)

end event

event tpgu_retrieve();
dw_pisr050b_03.SetRedraw(False)
dw_pisr050b_03.SetTransObject(sqlpis)
dw_pisr050b_03.Retrieve(istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode)
dw_pisr050b_03.SetRedraw(True)

This.Tag = ''
end event

event tpgu_add();//Long ll_Row
//Integer li_nKBQty, li_tKBQty, li_nRackQty, li_tRackQty
//String ls_itemCode 
//
//ls_itemCode = dw_itemtotal_grid.Tag 
//If ls_itemCode = '' Then
//	f_MessageBox(Information!, 999, "���ǹ�ȣ����", "�����ϰ��� �ϴ� ǰ���� ���� �����Ͻʽÿ�")
//	Return 
//End If 
//
//ll_Row = dw_crkbno_input.GetRow() 
//li_nKBQty = dw_crkbno_input.GetItemNumber(ll_Row, "nomalqty")
//li_tKBQty = dw_crkbno_input.GetItemNumber(ll_Row, "tempqty")
//li_nRackQty = dw_itemtotal_grid.GetItemNumber(dw_itemtotal_grid.GetRow(), "rackqty") 
//li_tRackQty = dw_crkbno_input.GetItemNumber(ll_Row, "rackqty")
//
//Sqlca.AutoCommit = False
//If li_nKBQty > 0 Then 
//	If wf_cr_kbNo(ls_itemCode, 'N', li_nRackQty, li_nKBQty) = -1 Then Goto RollBack_
//End If
//If li_tKBQty > 0 Then 
//	If wf_cr_kbNo(ls_itemCode, 'T', li_tRackQty, li_tKBQty) = -1 Then Goto RollBack_
//End If 
//f_sql_chkopt(Sqlca, True)
//f_MessageBox(Information!, 999, "���ǹ�ȣ ����", "�ش� ǰ���� ���ǹ�ȣ�� ���������� �����Ͽ����ϴ�.")
//
//dw_crkbno_input.Reset(); dw_crkbno_input.ScrollToRow(dw_crkbno_input.InsertRow(0))
//
//Parent.TriggerEvent("tpgu_ret_partkbcnt") 
//Return 
//
//RollBack_:
//RollBack Using Sqlca;
//Sqlca.AutoCommit = True 
end event

event tpgu_delete();//If dw_itemtotal_grid.Tag = '' Then 
//	f_MessageBox(Information!, 999, "���ý���", "�̹��ణ�� ������ ���Ͻô� ǰ���� ���� �����Ͻʽÿ�.")
//	Return
//End If 
//
////If f_MessageBox3(Question!, 999, "�̹��ణ�� ����", "�̹��� ������ ��� �����Ͻðڽ��ϱ�?", "��", "�ƴϿ�") <> 1 Then Return 
//
//String ls_itemCode, ls_chgFlag 
//str_partKb lstr_partKb 
//
//lstr_partKb = istr_partkb
//lstr_partKb.itemCode = dw_itemtotal_grid.Tag 
//
//OpenWithParm(w_r_notprkb_res, lstr_partKb) 
////ls_chgFlag = message.StringParm 
////If ls_chgFlag = '1' Then Parent.TriggerEvent("tpgu_ret_partkbcnt") 
end event

event tpgu_save();Long 		ll_Row, ll_tKBActiveCnt
Long 		ll_nKBQty, ll_tKBQty, ll_nRackQty, ll_tRackQty
String 	ls_nKBQty, ls_tKBQty, ls_tRackQty, ls_itemCode, ls_modelID 
String	ls_nKBSN , ls_tKBSN
Long		ll_nKBCnt, ll_tKBCnt
String	ls_message, ls_message1

ls_message = ''; ls_message1 = ''

//ls_itemCode = dw_pisr050b_03.Tag 
ll_Row 		= dw_pisr050b_03.GetRow() 
ls_itemCode = dw_pisr050b_03.GetItemString(ll_Row, 'itemcode' )

If ls_itemCode = '' Then
	MessageBox("���ǹ�ȣ��������", "�ش� ǰ���� ���� �����Ͻʽÿ�", StopSign!)
	Return 
End If 

ls_nKBQty 	= sle_nomalqty.Text  
If isNull(ls_nKBQty) Or trim(ls_nKBQty) = '' Then ls_nKBQty = '0'
IF Not isNumber( ls_nKBQty ) THEN
	MessageBox( "�Է¿���", "���԰��� �ż��� Ȯ���ϼ���." , StopSign! )
	Return
END IF
ll_nKBQty 	= long(ls_nKBQty)

ls_tKBQty 	= sle_tempqty.Text  
If isNull(ls_tKBQty) Or trim(ls_tKBQty) = '' Then ls_tKBQty = '0'
IF Not isNumber( ls_tKBQty ) THEN
	MessageBox( "�Է¿���", "�ӽð��� �ż��� Ȯ���ϼ���." , StopSign! )
	Return
END IF
ll_tKBQty 	= long(ls_tKBQty)

ll_nRackQty = dw_pisr050b_03.GetItemNumber(ll_Row, "rackqty")
ls_tRackQty = sle_rackqty.Text  
If isNull(ls_tRackQty) Or trim(ls_tRackQty) = '' Then ls_tRackQty = '0'
IF Not isNumber( ls_tRackQty ) THEN
	MessageBox( "�Է¿���", "�ӽð��� ������� Ȯ���ϼ���." , StopSign! )
	Return
END IF
ll_tRackQty = long(ls_tRackQty)

IF ll_tKBQty > 0 AND ll_tRackQty < 1 THEN
	MessageBox( "�Է¿���", "�ӽð��� ������� Ȯ���ϼ���." , StopSign! )
	Return
END IF
IF ll_tKBQty < 1 AND ll_tRackQty > 0 THEN
	MessageBox( "�Է¿���", "�ӽð��� �ż��� Ȯ���ϼ���." , StopSign! )
	Return
END IF


ls_modelID 	= dw_pisr050b_03.GetItemString(ll_Row, "partmodelid")
ls_nKBSN		= dw_pisr050b_03.GetItemString(ll_Row, "normalkbsn")
ls_tKBSN		= dw_pisr050b_03.GetItemString(ll_Row, "tempkbsn")

ll_nKBCnt	= Long(Right(ls_nKBSN, 2))
If ll_nKBQty > 0 And (ll_nKBCnt + ll_nKBQty) > 999 Then 
	ll_nKBCnt = 999 - ll_nKBCnt
	MessageBox( "ó���Ҵ�", "���԰��� �߸��Ѱ踦 �ʰ��Ͽ����ϴ�.~r~n" &
	                      + "���԰����� ��� 999�Ÿ� �ʰ��Ͽ� �߸��� �� �����ϴ�.~r~n" &
								 + "����" + String(ll_nKBCnt,"#,##0") + " �� �߰����డ���մϴ�.~r~n", StopSign! )
	Return
End If

ll_tKBCnt	= Long(Right(ls_tKBSN, 2))
If ll_tKBQty > 0 And (ll_tKBCnt + ll_tKBQty) > 99 Then 
	ll_tKBCnt = 99 - ll_tKBCnt
	MessageBox( "ó���Ҵ�", "�ӽð��� �߸��Ѱ踦 �ʰ��Ͽ����ϴ�.~r~n" &
	                      + "�ӽð����� ��� 99�Ÿ� �ʰ��Ͽ� �߸��� �� �����ϴ�.~r~n" &
								 + "����" + String(ll_tKBCnt,"#,##0") + " �� �߰����డ���մϴ�.~r~n" &
								 + "���̻��� ������ �ʿ��Ұ�� �޸����� ���������� ������� �����Ͽ� ����ϼ���.", StopSign! )
	Return
End If


//���ǻ��� ����
sqlpis.AutoCommit = FALSE
SetPointer(HourGlass!)

IF ll_nKBQty > 0 THEN 
	IF wf_cr_kbNo(ls_itemCode, 'N', ll_nKBQty, ll_nRackQty) = -1 THEN 
//		MessageBox( "���ǻ�������", ls_modelID + "�׸��� ���԰��� ������ �����߽��ϴ�." , StopSign! )
		ls_message = 'NormalKB_Err'
		ls_message1 = ls_modelID
		Goto RollBack_
	END IF
END IF
If ll_tKBQty > 0 Then
	If ll_tRackQty < 1 Then 
//		MessageBox( "�Է¿���", "�ӽð��� ������� Ȯ���ϼ���." , StopSign! )
		ls_message = 'll_tRackQty'
		Goto RollBack_
	End IF		
	If wf_cr_kbNo(ls_itemCode, 'T', ll_tKBQty, ll_tRackQty) = -1 THEN
//		MessageBox( "���ǻ�������", ls_modelID + "�׸��� �ӽð��� ������ �����߽��ϴ�." , StopSign! )
		ls_message = 'TempKB_Err'
		ls_message1 = ls_modelID
		Goto RollBack_
	END IF
End If 

// ���ǻ��� ����
//f_pisr_sqlchkopt(sqlpis, True)
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

MessageBox("���ǹ�ȣ ����", ls_modelID + " �� ���ǹ�ȣ ������ �����Ͽ����ϴ�.", Information!)
this.TriggerEvent("tpgu_retrieve") 
sle_nomalqty.Text	= ''
sle_tempqty.Text	= ''
sle_rackqty.Text	= ''
Return 

RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True 
SetPointer(Arrow!)

CHOOSE CASE ls_message
	CASE 'NormalKB_Err'
		MessageBox( "���ǻ�������", ls_message1 + "�׸��� ���԰��� ������ �����߽��ϴ�." , StopSign! )
	CASE 'TempKB_Err'
		MessageBox( "���ǻ�������", ls_message1 + "�׸��� �ӽð��� ������ �����߽��ϴ�." , StopSign! )
	CASE 'll_tRackQty'
		MessageBox( "�Է¿���", "�ӽð��� ������� Ȯ���ϼ���." , StopSign! )
	CASE ELSE
		MessageBox( "���ǻ�������", "���� ������ �����߽��ϴ�." , StopSign! )
END CHOOSE
return

end event

event tpgu_print();return
end event

on tabpage_2.create
this.gb_2=create gb_2
this.dw_pisr050b_03=create dw_pisr050b_03
this.st_3=create st_3
this.sle_nomalqty=create sle_nomalqty
this.gb_3=create gb_3
this.st_4=create st_4
this.sle_tempqty=create sle_tempqty
this.st_5=create st_5
this.sle_rackqty=create sle_rackqty
this.Control[]={this.gb_2,&
this.dw_pisr050b_03,&
this.st_3,&
this.sle_nomalqty,&
this.gb_3,&
this.st_4,&
this.sle_tempqty,&
this.st_5,&
this.sle_rackqty}
end on

on tabpage_2.destroy
destroy(this.gb_2)
destroy(this.dw_pisr050b_03)
destroy(this.st_3)
destroy(this.sle_nomalqty)
destroy(this.gb_3)
destroy(this.st_4)
destroy(this.sle_tempqty)
destroy(this.st_5)
destroy(this.sle_rackqty)
end on

event constructor;
sle_nomalqty.Text = ''
sle_tempqty.Text = ''
sle_rackqty.Text = ''

end event

type gb_2 from groupbox within tabpage_2
integer x = 741
integer width = 713
integer height = 152
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_pisr050b_03 from u_vi_std_datawindow within tabpage_2
integer x = 727
integer y = 160
integer width = 3598
integer height = 1424
integer taborder = 11
string dataobject = "d_pisr050b_03"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;//If row <= 0 Then Return 
//
//pb_statuschg.TriggerEvent(Clicked!)
end event

event retrieveend;call super::retrieveend;//Boolean lb_Chk 
//
//If rowcount = 0 Then This.Tag = '' 
//If rowcount > 0 Then lb_Chk = True 
//pb_add.uf_Enabled(lb_Chk)
//pb_statuschg.uf_Enabled(lb_Chk)
//pb_delete.uf_Enabled(lb_Chk) 
end event

event rowfocuschanged;call super::rowfocuschanged;If currentrow <= 0 Or This.RowCount() = 0 Then Return 

String ls_itemCode 

ls_itemCode = This.GetItemString(currentrow, "itemcode")
If IsNull(ls_itemCode) Then ls_itemCode = ''

This.Tag = trim(ls_itemCode) 
istr_partkb.itemcode = ls_itemCode
end event

type st_3 from statictext within tabpage_2
integer x = 786
integer y = 68
integer width = 645
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���԰���:        ��"
boolean focusrectangle = false
end type

type sle_nomalqty from singlelineedit within tabpage_2
integer x = 1097
integer y = 52
integer width = 215
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within tabpage_2
integer x = 1467
integer width = 1234
integer height = 152
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type st_4 from statictext within tabpage_2
integer x = 1509
integer y = 68
integer width = 654
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "�ӽð���:        ��,"
boolean focusrectangle = false
end type

type sle_tempqty from singlelineedit within tabpage_2
integer x = 1819
integer y = 52
integer width = 215
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within tabpage_2
integer x = 2149
integer y = 68
integer width = 261
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "�����:"
boolean focusrectangle = false
end type

type sle_rackqty from singlelineedit within tabpage_2
integer x = 2405
integer y = 52
integer width = 261
integer height = 76
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type tabpage_3 from userobject within tab_main
event tpgu_resize ( integer newwidth,  integer newheight )
event tpgu_retrieve ( )
event tpgu_print ( )
event tpgu_save ( )
event tpgu_delete ( )
integer x = 18
integer y = 100
integer width = 4466
integer height = 1584
long backcolor = 12632256
string text = "���ְ������"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_pisr050b_06 dw_pisr050b_06
cbx_all cbx_all
st_printcnt st_printcnt
st_printcnt_t st_printcnt_t
dw_parttype dw_parttype
st_tpg3_vsplitbar st_tpg3_vsplitbar
rb_tab3_1 rb_tab3_1
rb_tab3_2 rb_tab3_2
gb_4 gb_4
dw_pisr050b_05 dw_pisr050b_05
end type

event tpgu_resize(integer newwidth, integer newheight);Integer ls_split 		= 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap 		= 5 	// window �� dw_control �� Gap�� 5
Integer ls_status 	= 120 // statusbar �� ���̴� 120 ( Gap ���� )
Integer tab_name 		= 100 // TabpageTitle 
Integer tab_control 	= 160 // Tabpage��� Control ����

dw_pisr050b_05.Height 	= newheight - ( tab_name + ls_gap * 4 + tab_control ) 
dw_pisr050b_05.x 			= tv_partkb.Width + ls_split
//dw_pisr050b_05.Width 	= newwidth - ( dw_pisr050b_05.x + ls_gap * 8)
st_tpg3_vsplitbar.X		= dw_pisr050b_05.x + dw_pisr050b_05.width
st_tpg3_vsplitbar.Height= tv_partkb.Height
dw_pisr050b_06.x		 	= dw_pisr050b_05.x + dw_pisr050b_05.width + ls_split 
dw_pisr050b_06.Width 	= newwidth - ( dw_pisr050b_06.x + ls_gap * 8 )
dw_pisr050b_06.Height 	= tv_partkb.Height

cbx_all.x					= dw_pisr050b_06.x
st_printcnt_t.x			= cbx_all.x + cbx_all.Width + ls_gap * 4
st_printcnt.x				= st_printcnt_t.x + st_printcnt_t.Width + ls_gap * 4

tab_main.tabpage_3.st_tpg3_vsplitbar.of_Register(tab_main.tabpage_3.dw_pisr050b_05, tab_main.tabpage_3.st_tpg3_vsplitbar.LEFT)
tab_main.tabpage_3.st_tpg3_vsplitbar.of_Register(tab_main.tabpage_3.dw_pisr050b_06, tab_main.tabpage_3.st_tpg3_vsplitbar.RIGHT)

end event

event tpgu_retrieve();String	ls_parttype

ls_parttype = dw_parttype.GetitemString( dw_parttype.GetRow(), 'parttype' )
dw_pisr050b_05.SetRedraw(False)
dw_pisr050b_05.SetTransObject(Sqlpis)
dw_pisr050b_05.Retrieve(istr_partkb.areaCode, istr_partkb.divCode, istr_partkb.suppCode, ls_parttype )
dw_pisr050b_05.SetRedraw(True)

This.Tag = ''

end event

event tpgu_print();
Integer 	li_Net
String	ls_rtnValue
If ids_prkblist.RowCount() = 0 Then 
	MessageBox("��½���", "������ ������ �����ϴ�.", Information! )
	Return 
End If 

OpenWithParm( w_pisr051p, ids_prkblist)
ls_rtnValue = Message.StringParm

If ls_rtnValue = 'Close' Then TriggerEvent("tpgu_retrieve")

Return

end event

event tpgu_save();return

end event

event tpgu_delete();return
end event

on tabpage_3.create
this.dw_pisr050b_06=create dw_pisr050b_06
this.cbx_all=create cbx_all
this.st_printcnt=create st_printcnt
this.st_printcnt_t=create st_printcnt_t
this.dw_parttype=create dw_parttype
this.st_tpg3_vsplitbar=create st_tpg3_vsplitbar
this.rb_tab3_1=create rb_tab3_1
this.rb_tab3_2=create rb_tab3_2
this.gb_4=create gb_4
this.dw_pisr050b_05=create dw_pisr050b_05
this.Control[]={this.dw_pisr050b_06,&
this.cbx_all,&
this.st_printcnt,&
this.st_printcnt_t,&
this.dw_parttype,&
this.st_tpg3_vsplitbar,&
this.rb_tab3_1,&
this.rb_tab3_2,&
this.gb_4,&
this.dw_pisr050b_05}
end on

on tabpage_3.destroy
destroy(this.dw_pisr050b_06)
destroy(this.cbx_all)
destroy(this.st_printcnt)
destroy(this.st_printcnt_t)
destroy(this.dw_parttype)
destroy(this.st_tpg3_vsplitbar)
destroy(this.rb_tab3_1)
destroy(this.rb_tab3_2)
destroy(this.gb_4)
destroy(this.dw_pisr050b_05)
end on

event constructor;
dw_parttype.ScrollToRow(dw_parttype.InsertRow(0))

rb_tab3_1.Weight = 700
rb_tab3_2.Weight = 400
rb_tab3_1.Checked = True

end event

type dw_pisr050b_06 from u_vi_std_datawindow within tabpage_3
integer x = 3566
integer y = 160
integer width = 425
integer height = 1424
integer taborder = 11
string dataobject = "d_pisr050b_06"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;Long 		ll_prkbCnt, ll_Row
String	ls_partkbno

This.AcceptText()
CHOOSE CASE Upper(String(dwo.name))
	CASE 'PRKBCHK'
		If Data = 'Y' Then
			cbx_all.Checked	= False
			ll_Row		= dw_pisr050b_05.GetRow()
			If ll_row < 1 Then ll_Row = 1
			ll_prkbCnt 	= dw_pisr050b_05.GetItemNumber(ll_row, 'prkbcnt' )
			ll_prkbCnt 	= ll_prkbCnt + 1
			If ll_prkbCnt > 0 Then 
				dw_pisr050b_05.SetItem(ll_row, 'prkbchk', 'Y' )
			Else
				dw_pisr050b_05.SetItem(ll_row, 'prkbchk', 'N' )
			End If
			dw_pisr050b_05.SetItem( ll_row, 'prkbcnt', ll_prkbCnt )
			st_printcnt.Text = String(ll_prkbCnt, '#,##0')
		ElseIf Data = 'N' Then
			cbx_all.Checked	= False
			ll_Row		= dw_pisr050b_05.GetRow()
			If ll_row < 1 Then ll_Row = 1
			ll_prkbCnt = dw_pisr050b_05.GetItemNumber( ll_row, 'prkbcnt' )
			ll_prkbCnt = ll_prkbCnt - 1
			If ll_prkbCnt > 0 Then 
				dw_pisr050b_05.SetItem(ll_row, 'prkbchk', 'Y' )
			Else
				dw_pisr050b_05.SetItem(ll_row, 'prkbchk', 'N' )
			End If
			dw_pisr050b_05.SetItem( ll_row, 'prkbcnt', ll_prkbCnt )
			st_printcnt.Text = String(ll_prkbCnt, '#,##0')
		End If
		wf_setkbprlist(This, row, Data)
	CASE 'RACKQTY'
		If isNumber(data) Then
			ls_partkbno = this.GetItemString(row, 'partkbno')
			sqlpis.AutoCommit = False
			  UPDATE TPARTKBSTATUS  
				  SET RackQty 	= :data,   
						LastEmp 	= 'Y',	//Interface Flag Ȱ��   
						LastDate = GetDate()  
				WHERE TPARTKBSTATUS.PartKBNo = :ls_partkbno
				USING sqlpis	  ;
			If sqlpis.SqlCode = 0 Then
				Commit Using sqlpis;
			Else
				RollBack Using sqlpis;
			End If	
			sqlpis.AutoCommit = True
		Else
			Return 1			
		End If	
END CHOOSE

//wf_butEnabled()
end event

event retrieveend;call super::retrieveend;Integer li_prCnt 

If rowcount > 0 Then 
	li_prCnt = wf_setkbprlist(This, 0, '')
	st_printcnt.Text = String(li_prCnt, "#,##0") 
End If

cbx_all.Enabled	= True; cbx_all.Checked	= False

end event

event ue_key;call super::ue_key;
If key = KeyEnter! Then 
	send(handle(this), 256, 9, long(0,0))
	Return 1
End If 
end event

event clicked;call super::clicked;CHOOSE CASE Upper(String(dwo.name))
	CASE 'RACKQTY'
		This.setcolumn('RACKQTY')
		This.setfocus()
END CHOOSE
end event

type cbx_all from checkbox within tabpage_3
integer x = 2702
integer y = 56
integer width = 384
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "��ü���"
end type

event clicked;Long 	ll_Row, ll_prkbCnt

wf_setKBprCnt(dw_pisr050b_06, dw_pisr050b_06.RowCount(), dw_pisr050b_05)

Enabled	= False
st_printcnt.Text = String(dw_pisr050b_06.RowCount(), "#,##0") 

ll_Row		= dw_pisr050b_05.GetRow()
If ll_row < 1 Then ll_Row = 1
ll_prkbCnt 	= dw_pisr050b_05.GetItemNumber(ll_row, 'prkbcnt' )
If ll_prkbCnt > 0 Then 
	dw_pisr050b_05.SetItem(ll_row, 'prkbchk', 'Y' )
Else
	dw_pisr050b_05.SetItem(ll_row, 'prkbchk', 'N' )
End If

//wf_butEnabled()
end event

type st_printcnt from statictext within tabpage_3
integer x = 3401
integer y = 44
integer width = 165
integer height = 88
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 255
long backcolor = 12632256
string text = "0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_printcnt_t from statictext within tabpage_3
integer x = 3104
integer y = 60
integer width = 311
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "��¸ż�:"
boolean focusrectangle = false
end type

type dw_parttype from datawindow within tabpage_3
integer x = 718
integer y = 28
integer width = 846
integer height = 124
integer taborder = 60
string title = "none"
string dataobject = "dddw_rparttypec_01"
boolean border = false
boolean livescroll = true
end type

event itemchanged;Long		ll_rowCnt
dw_parttype.AcceptText()
ids_prkblist.SetTransObject(sqlpis)
ll_rowCnt = ids_prkblist.GetRow()
If ll_rowCnt > 0 Then 
	MessageBox( '�����������', '������ ���õ� ���ǵ��� ���� ��ҵ˴ϴ�.', Information!)
	ids_prkblist.Reset()
	ids_reprkblist.Reset()
End If
tab_main.tabpage_3.TriggerEvent( "tpgu_retrieve" )
end event

type st_tpg3_vsplitbar from u_pism_splitbar within tabpage_3
integer x = 3547
integer y = 160
integer width = 18
integer height = 1424
long backcolor = 12632256
end type

type rb_tab3_1 from radiobutton within tabpage_3
integer x = 1609
integer y = 64
integer width = 352
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "�̹���"
end type

event clicked;
rb_tab3_1.Weight = 700
rb_tab3_2.Weight = 400

dw_parttype.AcceptText()
tab_main.tabpage_3.TriggerEvent( "tpgu_retrieve" )
end event

type rb_tab3_2 from radiobutton within tabpage_3
integer x = 1984
integer y = 64
integer width = 352
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "�����"
end type

event clicked;
rb_tab3_1.Weight = 400
rb_tab3_2.Weight = 700

dw_parttype.AcceptText()
tab_main.tabpage_3.TriggerEvent( "tpgu_retrieve" )
end event

type gb_4 from groupbox within tabpage_3
integer x = 1568
integer y = 8
integer width = 786
integer height = 140
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type dw_pisr050b_05 from u_vi_std_datawindow within tabpage_3
integer x = 722
integer y = 160
integer width = 2830
integer height = 1424
integer taborder = 11
string dataobject = "d_pisr050b_05"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;//This.AcceptText()
//
//If Upper(String(dwo.name)) = 'PRKBCHK' And Data = 'Y' Then
//	cbx_all.Enabled	= True
//ElseIf Upper(String(dwo.name)) = 'PRKBCHK' And Data = 'N' Then
//	cbx_all.Checked	= False
//End If
//
//wf_setkbprlist(This, row, Data)
////wf_butEnabled()
end event

event retrieveend;call super::retrieveend;
If rowcount = 0 Then 
	This.Tag = ''; dw_pisr050b_06.Reset()
End If 

If rowcount > 0 Then This.Event RowFocusChanged(1)

end event

event rowfocuschanged;call super::rowfocuschanged;If currentrow <= 0 Or This.RowCount() = 0 Then 
	dw_pisr050b_06.ReSet()
	Return 
End If

String ls_itemCode, ls_reprFlag = 'Y' 					//�̹���

ls_itemCode = This.GetItemString(currentrow, "itemcode")
If IsNull(ls_itemCode) Then ls_itemCode = ''
This.Tag = trim(ls_itemCode) 
istr_partkb.itemcode = ls_itemCode

If Not rb_tab3_1.Checked Then ls_reprFlag = 'N' 	//�����

dw_pisr050b_06.SetRedraw(False)
dw_pisr050b_06.SetTransObject(Sqlpis)
dw_pisr050b_06.Retrieve(istr_partkb.areaCode, istr_partkb.divCode, istr_partkb.suppCode, ls_itemCode, ls_reprFlag)
dw_pisr050b_06.SetRedraw(True)
end event

type tv_partkb from u_pisr_treeview within w_pisr050b
integer x = 23
integer y = 460
integer height = 1424
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
end type

event selectionchanged;call super::selectionchanged;istr_partkb = uistr_partKB

Parent.TriggerEvent("ue_retrieve") 

//istr_partkb = uistr_partKb 
//
//pb_disp.TriggerEvent(Clicked!)
//
//wf_setTag(tab_main.SelectedTab)
//
end event

event constructor;call super::constructor;uf_setLevelGubun(2)
end event

type st_vsplitbar from u_pism_splitbar within w_pisr050b
integer x = 731
integer y = 460
integer width = 18
integer height = 1424
boolean bringtotop = true
long backcolor = 10789024
end type

type cb_aschange from commandbutton within w_pisr050b
integer x = 1879
integer y = 56
integer width = 544
integer height = 108
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���� Active��ȯ"
end type

event clicked;parent.TriggerEvent( "ue_partkbasconvert" )
end event

type cb_5 from commandbutton within w_pisr050b
integer x = 2446
integer y = 56
integer width = 640
integer height = 108
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��µɰ��Ǹż�Ȯ��"
end type

event clicked;long ll_rowcnt

ids_prkblist.SetTransObject(sqlpis)
ll_rowcnt = ids_prkblist.RowCount()

MessageBox( '��°��Ǹż�', String(ll_rowcnt) + '���� ������ ��µ� �����Դϴ�.', Information!)
end event

type uo_month from u_pisc_date_scroll_month within w_pisr050b
integer x = 46
integer y = 72
integer height = 80
integer taborder = 90
boolean bringtotop = true
end type

event ue_select;call super::ue_select;//If ib_open Then
//	iw_this.TriggerEvent("ue_reset")
//End If
end event

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type gb_1 from groupbox within w_pisr050b
integer x = 1833
integer width = 1289
integer height = 192
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_5 from groupbox within w_pisr050b
integer x = 14
integer width = 663
integer height = 192
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_6 from groupbox within w_pisr050b
integer x = 686
integer width = 1138
integer height = 192
integer taborder = 11
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

