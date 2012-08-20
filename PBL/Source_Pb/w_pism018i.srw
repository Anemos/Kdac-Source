$PBExportHeader$w_pism018i.srw
$PBExportComments$�۾��Ϻ� �ۼ� ��Ȳ
forward
global type w_pism018i from w_pism_sheet03
end type
type dw_dailystatus from u_pism_dw within w_pism018i
end type
type rb_all from radiobutton within w_pism018i
end type
type rb_ok from radiobutton within w_pism018i
end type
type rb_notok from radiobutton within w_pism018i
end type
type rb_not from radiobutton within w_pism018i
end type
type cb_dailycreate from commandbutton within w_pism018i
end type
type cb_all_down from commandbutton within w_pism018i
end type
type dw_all_down from datawindow within w_pism018i
end type
type gb_3 from groupbox within w_pism018i
end type
end forward

global type w_pism018i from w_pism_sheet03
integer width = 4471
dw_dailystatus dw_dailystatus
rb_all rb_all
rb_ok rb_ok
rb_notok rb_notok
rb_not rb_not
cb_dailycreate cb_dailycreate
cb_all_down cb_all_down
dw_all_down dw_all_down
gb_3 gb_3
end type
global w_pism018i w_pism018i

forward prototypes
public function integer wf_dailyfilter ()
end prototypes

public function integer wf_dailyfilter ();String ls_Filter 

If rb_all.Checked Then 
	ls_Filter = '' 
ElseIf rb_ok.Checked Then 
	ls_Filter = "dailystatus = '1'" 
ElseIf rb_notok.Checked Then 
	ls_Filter = "dailystatus = '0'" 
ElseIf rb_not.Checked Then 
	ls_Filter = "dailystatus = 'X'" 
End If 

dw_dailystatus.SetFilter(ls_Filter)
dw_dailystatus.Filter() 

Return 1
end function

event open;call super::open;wf_setRetCondition(STFROMTODATE) 

ib_wcallview = True 
cb_dailycreate.Enabled = False 

end event

on w_pism018i.create
int iCurrent
call super::create
this.dw_dailystatus=create dw_dailystatus
this.rb_all=create rb_all
this.rb_ok=create rb_ok
this.rb_notok=create rb_notok
this.rb_not=create rb_not
this.cb_dailycreate=create cb_dailycreate
this.cb_all_down=create cb_all_down
this.dw_all_down=create dw_all_down
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_dailystatus
this.Control[iCurrent+2]=this.rb_all
this.Control[iCurrent+3]=this.rb_ok
this.Control[iCurrent+4]=this.rb_notok
this.Control[iCurrent+5]=this.rb_not
this.Control[iCurrent+6]=this.cb_dailycreate
this.Control[iCurrent+7]=this.cb_all_down
this.Control[iCurrent+8]=this.dw_all_down
this.Control[iCurrent+9]=this.gb_3
end on

on w_pism018i.destroy
call super::destroy
destroy(this.dw_dailystatus)
destroy(this.rb_all)
destroy(this.rb_ok)
destroy(this.rb_notok)
destroy(this.rb_not)
destroy(this.cb_dailycreate)
destroy(this.cb_all_down)
destroy(this.dw_all_down)
destroy(this.gb_3)
end on

event ue_retrieve;call super::ue_retrieve;Long ll_ret 

dw_dailystatus.SetRedraw(False) 
f_pism_working_msg(istr_mh.From_Date + "��" + istr_mh.To_Date + " �Ⱓ��" + & 
						 uo_wc.is_uo_workcentername + " ��", dw_dailystatus.Title + "�� ��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�.") 

dw_dailystatus.Reset(); dw_dailystatus.SetTransObject(SqlPIS); dw_dailystatus.SetFilter('') 
ll_ret = dw_dailystatus.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.from_date, istr_mh.to_date) 
If ll_ret > 0 Then wf_dailyFilter() 

If IsValid(w_pism_working) Then Close(w_pism_working) 
dw_dailystatus.SetRedraw(True); dw_dailystatus.Setfocus() 
end event

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_dailystatus, FULL)

of_resize()

end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//�������

lstr_prt.Transaction = SqlPIS 

lstr_prt.datawindow = dw_dailystatus
lstr_prt.DataObject = 'd_pism018i_01_p' 
lstr_prt.title = istr_mh.From_Date + "��" + istr_mh.To_Date + " �Ⱓ�� " + dw_dailystatus.Title 
lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + "'" + & 
							 " " + uo_wc.is_uo_workcenterName + " ��'	"

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )

end event

event ue_postopen;call super::ue_postopen;//This.TriggerEvent("ue_retrieve") 
end event

type uo_status from w_pism_sheet03`uo_status within w_pism018i
end type

type uo_wc from w_pism_sheet03`uo_wc within w_pism018i
end type

type st_fromto from w_pism_sheet03`st_fromto within w_pism018i
end type

type gb_1 from w_pism_sheet03`gb_1 within w_pism018i
end type

type uo_fromdate from w_pism_sheet03`uo_fromdate within w_pism018i
end type

type uo_year from w_pism_sheet03`uo_year within w_pism018i
end type

type uo_month from w_pism_sheet03`uo_month within w_pism018i
end type

type uo_frmonth from w_pism_sheet03`uo_frmonth within w_pism018i
end type

type gb_2 from w_pism_sheet03`gb_2 within w_pism018i
end type

type uo_tomonth from w_pism_sheet03`uo_tomonth within w_pism018i
end type

type st_fromtomonth from w_pism_sheet03`st_fromtomonth within w_pism018i
end type

type uo_todate from w_pism_sheet03`uo_todate within w_pism018i
end type

type uo_area from w_pism_sheet03`uo_area within w_pism018i
end type

type uo_div from w_pism_sheet03`uo_div within w_pism018i
end type

type dw_dailystatus from u_pism_dw within w_pism018i
integer x = 5
integer y = 280
integer width = 2578
integer height = 1308
integer taborder = 11
boolean bringtotop = true
string title = "�۾��Ϻ� �ۼ���Ȳ"
string dataobject = "d_pism018i_01"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 1
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_wcName, ls_wDay, ls_dailystatus 

If currentrow <= 0 Then  
	cb_dailycreate.Text = "�۾��Ϻ� �ۼ� �� ��ȸ" 
	cb_dailycreate.Enabled = False 
Else
	ls_WCName = This.GetitemString(currentrow, "workcentername") 
	ls_wDay = This.GetItemString(currentrow, "workday") 
	ls_dailystatus = This.GetItemString(currentrow, "dailystatus") 
	cb_dailycreate.Text = ls_wcName + "�� " + ls_wDay + " ���� �۾��Ϻ� " 
	If ls_dailystatus = '0' or ls_dailystatus = '1' Then 
		cb_dailycreate.Text += "��ȸ"
	Else
		cb_dailycreate.Text += "�ۼ�"
	End If 
	cb_dailycreate.Enabled = m_frame.m_action.m_save.Enabled 
End If 
end event

event retrieveend;call super::retrieveend;If rowcount > 0 Then 
	This.ScrollToRow(1); This.SelectRow(1, True)
End If 

end event

event doubleclicked;call super::doubleclicked;If This.GetRow() <= 0 Or Not cb_dailycreate.Enabled Then Return 
cb_dailycreate.TriggerEvent(Clicked!) 
end event

type rb_all from radiobutton within w_pism018i
integer x = 78
integer y = 200
integer width = 283
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "��ü"
boolean checked = true
end type

type rb_ok from radiobutton within w_pism018i
integer x = 407
integer y = 200
integer width = 283
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "Ȯ��"
end type

type rb_notok from radiobutton within w_pism018i
integer x = 763
integer y = 200
integer width = 283
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "��Ȯ��"
end type

type rb_not from radiobutton within w_pism018i
integer x = 1184
integer y = 200
integer width = 283
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "���ۼ�"
end type

type cb_dailycreate from commandbutton within w_pism018i
integer x = 1577
integer y = 184
integer width = 1275
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�۾��Ϻ� �ۼ� �� ��ȸ"
end type

event clicked;str_pism_daily lstr_daily 
Long ll_getRow 
String ls_dailystatus 

If f_pism_MessageBox(Question!, 999, "ȭ�� �̵�", cb_dailycreate.Text + " �Ͻðڽ��ϱ�?") <> 1 Then Return 

lstr_daily.area = istr_mh.area
lstr_daily.div  = istr_mh.div 

ll_getRow = dw_dailystatus.Getrow() 
If ll_getRow <= 0 Then Return 
lstr_daily.wc   = dw_dailystatus.GetItemString(ll_getRow, "workcenter") 
lstr_daily.wday = dw_dailystatus.GetItemString(ll_getRow, "workday") 
ls_dailystatus = dw_dailystatus.GetItemString(ll_getRow, "dailystatus") 
If ls_dailystatus = 'X' Then 
	lstr_daily.longparm = 1		// �ۼ� 
Else
	lstr_daily.longparm = 2		// ��ȸ 
End If

if f_open_sheet('w_pism010u') = 0 then
	OpenSheetWithParm(w_pism010u, lstr_daily, w_frame, 0, Layered!) 
	If IsValid(w_pism010u) Then w_pism010u.Title = '�۾��Ϻ��ۼ�'
Else
	w_frame.GetActiveSheet().Dynamic wf_selectDaily(lstr_daily) 
End If 

end event

type cb_all_down from commandbutton within w_pism018i
integer x = 2944
integer y = 184
integer width = 512
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "������ �ٿ�ε�"
end type

event clicked;string l_s_docname, l_s_named
int l_n_value, li_chk

// EIS DB
SQLEIS 							= 	CREATE transaction
SQLEIS.DBMS       			= 	ProfileString(gs_inifile,"DATABASE_EIS","DBMS",			" ")
SQLEIS.ServerName 			= 	ProfileString(gs_inifile,"DATABASE_EIS","ServerName",	" ")
SQLEIS.Database   			= 	ProfileString(gs_inifile,"DATABASE_EIS","Database",		" ")
SQLEIS.LogID      				= 	ProfileString(gs_inifile,"DATABASE_EIS","LogId",			" ")
SQLEIS.LogPass    			= 	ProfileString(gs_inifile,"DATABASE_EIS","LogPass",		" ")
SQLEIS.DBParm 				= 	"CommitOnDisconnect='No'"
SQLEIS.AutoCommit 			= 	True

gs_appname						= 	ProfileString(gs_inifile,"PARAMETER","AppName"," ")

connect using SQLEIS;

If SQLEIS.sqlcode <> 0 then
	disconnect using sqleis ;
	destroy sqleis
	uo_status.st_message.text = "EIS ������ �����Ҽ� �����ϴ�."
	return -1
end if

dw_all_down.settransobject(sqleis)

if dw_all_down.retrieve(istr_mh.from_date, istr_mh.to_date) > 0 then
	integer li_rowcnt, li_cnt, li_currow
	string ls_areacode
	datastore lds_01

	lds_01 = create datastore
	lds_01.dataobject = "d_pism018i_01_all_jin"
	lds_01.settransobject(sqleis)
	
	li_rowcnt = lds_01.retrieve('J','S','%',istr_mh.from_date, istr_mh.to_date)
	for li_cnt = 1 to li_rowcnt
		li_currow = dw_all_down.insertrow(0)
		dw_all_down.setitem(li_currow,"Areacode",'J')
		dw_all_down.setitem(li_currow,"Divisioncode",'S')
		dw_all_down.setitem(li_currow,"WorkCenter",lds_01.getitemstring(li_cnt,"WorkCenter"))
		dw_all_down.setitem(li_currow,"WorkDay",lds_01.getitemstring(li_cnt,"WorkDay"))
		dw_all_down.setitem(li_currow,"WorkCenterName",lds_01.getitemstring(li_cnt,"WorkCenterName"))
		dw_all_down.setitem(li_currow,"DailyStatus",lds_01.getitemstring(li_cnt,"DailyStatus"))
		dw_all_down.setitem(li_currow,"InputTime",lds_01.getitemdatetime(li_cnt,"InputTime"))
		dw_all_down.setitem(li_currow,"Remark",lds_01.getitemstring(li_cnt,"Remark"))
		dw_all_down.setitem(li_currow,"InputEmp",lds_01.getitemstring(li_cnt,"InputEmp"))
		dw_all_down.setitem(li_currow,"EmpName",lds_01.getitemstring(li_cnt,"EmpName"))
		dw_all_down.setitem(li_currow,"LastDate",lds_01.getitemdatetime(li_cnt,"LastDate"))
	next
	
	lds_01.reset()
	li_rowcnt = lds_01.retrieve('J','H','%',istr_mh.from_date, istr_mh.to_date)
	for li_cnt = 1 to li_rowcnt
		li_currow = dw_all_down.insertrow(0)
		dw_all_down.setitem(li_currow,"Areacode",'J')
		dw_all_down.setitem(li_currow,"Divisioncode",'H')
		dw_all_down.setitem(li_currow,"WorkCenter",lds_01.getitemstring(li_cnt,"WorkCenter"))
		dw_all_down.setitem(li_currow,"WorkDay",lds_01.getitemstring(li_cnt,"WorkDay"))
		dw_all_down.setitem(li_currow,"WorkCenterName",lds_01.getitemstring(li_cnt,"WorkCenterName"))
		dw_all_down.setitem(li_currow,"DailyStatus",lds_01.getitemstring(li_cnt,"DailyStatus"))
		dw_all_down.setitem(li_currow,"InputTime",lds_01.getitemdatetime(li_cnt,"InputTime"))
		dw_all_down.setitem(li_currow,"Remark",lds_01.getitemstring(li_cnt,"Remark"))
		dw_all_down.setitem(li_currow,"InputEmp",lds_01.getitemstring(li_cnt,"InputEmp"))
		dw_all_down.setitem(li_currow,"EmpName",lds_01.getitemstring(li_cnt,"EmpName"))
		dw_all_down.setitem(li_currow,"LastDate",lds_01.getitemdatetime(li_cnt,"LastDate"))
	next

	destroy lds_01

	f_save_to_excel_execute(dw_all_down,'1')
//	// �������� ����
//	
//	If dw_all_down.RowCount() = 0 Then Return 
//
//	l_s_docname = Parent.Title 
//	
//	l_n_value = GetFileSaveName("���� �ϱ�", l_s_docname, l_s_named, "xls", "Excel files (*.xls), *.xls")
//	if l_n_value = 1 then
//		li_Chk = dw_all_down.saveas(l_s_docname, HTMLTABLE!, true) 
////		li_Chk = dw_all_down.saveas(l_s_docname, Excel!, true)
//		If li_Chk = -1 Then 
//			f_pism_messagebox(StopSign!, -1, "Ȯ ��", "�������� ���� �Դϴ�.") 
//		End If 
//	end if
//	
//	if l_n_value = 1 and li_chk <> -1 then
//		OleObject     myOleObject
//		int           i_Result
//		String        excel_title
//		
//		myOleObject = Create OleObject //ole ������Ʈ ����
//		
//		i_Result = myOleObject.ConnectToNewObject( "excel.application" )
//		// ������ ����
//		excel_title = myOleObject.Application.Caption
//		
//		myOleObject.Application.Visible = True
//		
//		myOleObject.WorkBooks.Open(l_s_docname)
//		myOleObject.WindowState = 3 
//		// ������������ ���� ���� 1-normal, 2-min, 3-max
//		
//		myoleobject.DisConnectObject() //��������
//		Destroy myoleobject //������Ʈ ����
//	end if	
else
	uo_status.st_message.text = "��ȸ�� ������ �����ϴ�."
end if

disconnect using sqleis ;
destroy sqleis
	
return 0
end event

type dw_all_down from datawindow within w_pism018i
boolean visible = false
integer x = 2761
integer y = 292
integer width = 686
integer height = 400
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_pism018i_01_all"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pism018i
integer x = 9
integer y = 152
integer width = 1545
integer height = 116
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
end type

