$PBExportHeader$w_pisr136u.srw
$PBExportComments$���ǰ�������
forward
global type w_pisr136u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr136u
end type
type uo_division from u_pisc_select_division within w_pisr136u
end type
type dw_condition from datawindow within w_pisr136u
end type
type dw_2 from u_vi_std_datawindow within w_pisr136u
end type
type dw_3 from u_vi_std_datawindow within w_pisr136u
end type
type st_hsplitbar from u_pism_splitbar within w_pisr136u
end type
type pb_1 from picturebutton within w_pisr136u
end type
type pb_2 from picturebutton within w_pisr136u
end type
type gb_1 from groupbox within w_pisr136u
end type
type gb_2 from groupbox within w_pisr136u
end type
type gb_3 from groupbox within w_pisr136u
end type
end forward

global type w_pisr136u from w_ipis_sheet01
integer width = 4242
event ue_init ( )
event ue_ok ( )
event ue_cancel ( )
uo_area uo_area
uo_division uo_division
dw_condition dw_condition
dw_2 dw_2
dw_3 dw_3
st_hsplitbar st_hsplitbar
pb_1 pb_1
pb_2 pb_2
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_pisr136u w_pisr136u

type variables
Boolean	ib_Open
str_pisr_partkb istr_partkb
end variables

event ue_init();Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 
//splitbar ����
st_hsplitbar.of_Register(dw_2, st_hsplitbar.ABOVE)
st_hsplitbar.of_Register(dw_3, st_hsplitbar.BELOW)

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//��ȸ


String	ls_deptname, ls_Null

SetNull(ls_Null)

  SELECT TMSTDEPT.DeptName  
	 INTO :ls_deptname  
	 FROM TMSTDEPT  
	WHERE TMSTDEPT.DeptCode = :g_s_deptcd
	USING	sqlpis	;

If sqlpis.SqlCode <> 0 Then 
	dw_condition.SetItem( dw_condition.GetRow(), 'deptcode', ls_Null )
	dw_condition.SetItem( dw_condition.GetRow(), 'deptname', ls_Null )
	Return 
End If
dw_condition.SetItem( dw_condition.GetRow(), 'deptcode', g_s_deptcd )
dw_condition.SetItem( dw_condition.GetRow(), 'deptname', ls_deptname )

end event

event ue_ok();           
Long 		ll_RowCnt, ll_selectChk
Integer	I, li_Cnt
DateTime	ldt_nowTime
Integer	li_Net
String	ls_Jikchek  

  SELECT TMSTEMP.EmpJikchek  
    INTO :ls_Jikchek  
    FROM TMSTEMP  
   WHERE TMSTEMP.EmpNo = :g_s_empno   
	USING	sqlpis	;

If sqlpis.SqlCode <> 0 Then ls_Jikchek = ''

If ls_Jikchek <> '3' Then 
	MessageBox( "���κҴ�", "���� ������ �ο����� ���� ����Դϴ�.", Information! )
	Return 
End If

ll_RowCnt	= dw_2.RowCount()

If ll_RowCnt < 1 Then Return

ldt_nowTime	= f_pisc_get_date_nowtime()									//���� �ý��۽ð�
li_Cnt		= 0

For I = 1 To ll_RowCnt Step 1
	ll_selectChk	= dw_2.GetItemNumber( I, 'selectchk' )
	If ll_selectChk = 0 Then Continue
	li_Cnt			= li_Cnt + 1
	dw_2.SetItem(I, 'approvalemp'	, g_s_empno )
	dw_2.SetItem(I, 'approvaltime', ldt_nowTime )
	dw_2.SetItem(I, 'statusflag'	, 'C' )
	dw_2.SetItem(I, 'lastemp'		, 'Y' )	//Interface Flag Ȱ��
	dw_2.SetItem(I, 'lastdate'		, ldt_nowTime )
Next

If li_Cnt < 1 Then 
	MessageBox("Ȯ��", "���õ� �׸��� �������� �ʽ��ϴ�. ", Information! )
	Return
End If

li_Net = MessageBox("�������Ȯ��", String(li_Cnt) + " ���� �������� ����ó���Ϸ��� �մϴ�.~r~n" &
		                         + "~r~n���� ó���Ͻðڽ��ϱ�?", Question!, YesNo!, 2)
IF li_Net <> 1 THEN
	MessageBox("����������", "���� �۾��� ��ҵǾ����ϴ�.", Information! )
	Return 
END IF

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

dw_2.SetTransObject(Sqlpis)									//���ǻ���
If dw_2.Update() = -1 Then 
//	MessageBox("������ο���", "���������� Update���� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)
MessageBox("������οϷ�", String(li_Cnt) + " ���� ������ ����ó���� �Ϸ�Ǿ����ϴ�.", Information! )
This.TriggerEvent( "ue_retrieve" )

Return  

RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

MessageBox("������ο���", "���������� Update���� ������ �߻��Ͽ����ϴ�.", StopSign! )

return 

end event

event ue_cancel();           
Long 		ll_RowCnt, ll_selectChk
Integer	I, li_Cnt
DateTime	ldt_nowTime
Integer	li_Net

String	ls_Jikchek  

  SELECT TMSTEMP.EmpJikchek  
    INTO :ls_Jikchek  
    FROM TMSTEMP  
   WHERE TMSTEMP.EmpNo = :g_s_empno   
	USING	sqlpis	;

If sqlpis.SqlCode <> 0 Then ls_Jikchek = ''
	
If ls_Jikchek <> '3' Then 
	MessageBox( "���κҴ�", "���� ������ �ο����� ���� ����Դϴ�.", Information! )
	Return 
End If

ll_RowCnt	= dw_2.RowCount()

If ll_RowCnt < 1 Then Return

ldt_nowTime	= f_pisc_get_date_nowtime()									//���� �ý��۽ð�
li_Cnt		= 0

For I = 1 To ll_RowCnt Step 1
	ll_selectChk	= dw_2.GetItemNumber( I, 'selectchk' )
	If ll_selectChk = 0 Then Continue
	li_Cnt			= li_Cnt + 1
	dw_2.SetItem(I, 'approvalemp'	, g_s_empno )
	dw_2.SetItem(I, 'approvaltime', ldt_nowTime )
	dw_2.SetItem(I, 'statusflag'	, 'B' )
	dw_2.SetItem(I, 'lastemp'		, 'Y' )	//Interface Flag Ȱ��
	dw_2.SetItem(I, 'lastdate'		, ldt_nowTime )
Next

If li_Cnt < 1 Then 
	MessageBox("Ȯ��", "���õ� �׸��� �������� �ʽ��ϴ�. ", Information! )
	Return
End If

li_Net = MessageBox("Ȯ��", String(li_Cnt) + " ���� �������� �ݷ�ó���Ϸ��� �մϴ�.~r~n" &
		                         + "~r~n�ݷ� ó���Ͻðڽ��ϱ�?", Question!, YesNo!, 2)
IF li_Net <> 1 THEN
	MessageBox("����ݷ����", "�ݷ� �۾��� ��ҵǾ����ϴ�.", Information! )
	Return 
END IF

sqlpis.AutoCommit = False
SetPointer(HourGlass!)

dw_2.SetTransObject(Sqlpis)									//���ǻ���
If dw_2.Update() = -1 Then 
//	MessageBox("����ݷ�����", "���������� Update���� ������ �߻��Ͽ����ϴ�.", StopSign! )
	Goto RollBack_			
End If

//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

MessageBox("Ȯ��", String(li_Cnt) + " ���� ������ �ݷ�ó�� �Ǿ����ϴ�.", Information! )
This.TriggerEvent( "ue_retrieve" )

Return  

RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True
SetPointer(Arrow!)

MessageBox("����ݷ�����", "���������� Update���� ������ �߻��Ͽ����ϴ�.", StopSign! )

return 

end event

on w_pisr136u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_condition=create dw_condition
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_hsplitbar=create st_hsplitbar
this.pb_1=create pb_1
this.pb_2=create pb_2
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_condition
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.st_hsplitbar
this.Control[iCurrent+7]=this.pb_1
this.Control[iCurrent+8]=this.pb_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
end on

on w_pisr136u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_condition)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_hsplitbar)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event ue_postopen;call super::ue_postopen;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
ib_open = True
istr_partkb.areacode = uo_area.is_uo_areacode
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

end event

event open;call super::open;
dw_condition.SetTransObject(sqlpis)
dw_condition.Reset()
dw_condition.InsertRow(1)

This.TriggerEvent( "ue_init" )
end event

event ue_retrieve;call super::ue_retrieve;String	ls_deptcode
Long 		ll_Row

dw_condition.AcceptText()
ls_deptcode	= dw_condition.GetItemString(1, 'deptcode')

If isNull(ls_deptcode) Or Trim(ls_deptcode) = '' Then 
	ls_deptcode	= '%'
//	MessageBox('Ȯ��', '��ȸ�� �μ��ڵ带 �Է��ϼ���.', Information! )
//	return
End If

dw_2.SetTransObject(sqlpis)
ll_Row = dw_2.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_deptcode)

If ll_Row < 1 Then 
//	MessageBox('Ȯ��', '���ο�û�� ���ǰ������LIST�� �������� �ʽ��ϴ�.', Information! )
	Return
End If	

dw_2.Event RowfocusChanged(1)
Return

end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 5 		// window �� dw_control �� Gap�� 5
Integer ls_status = 120 // statusbar �� ���̴� 120 ( Gap ���� )

dw_2.Width = newwidth 	- ( dw_2.x + ls_gap * 2 )

dw_3.Width = newwidth 	- ( dw_3.x + ls_gap * 2 )
dw_3.Height= newheight - ( dw_3.y + ls_status )

st_hsplitbar.x 		= dw_3.x
st_hsplitbar.y 		= dw_3.y - ls_split
st_hsplitbar.Width 	= dw_3.Width 

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr136u
end type

type uo_area from u_pisc_select_area within w_pisr136u
integer x = 59
integer y = 72
integer height = 68
integer taborder = 20
boolean bringtotop = true
end type

event ue_select;If ib_open Then
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)

End If

istr_partkb.areacode = is_uo_areacode
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

dw_condition.Reset()
dw_condition.InsertRow(1)
dw_2.Reset()
dw_3.Reset()


end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisr136u
integer x = 571
integer y = 72
integer width = 539
integer height = 68
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;
istr_partkb.divcode 	= uo_division.is_uo_divisioncode

dw_condition.Reset()
dw_condition.InsertRow(1)

dw_2.Reset()
dw_3.Reset()

end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type dw_condition from datawindow within w_pisr136u
integer x = 1216
integer y = 60
integer width = 2139
integer height = 104
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr_condition5"
boolean border = false
end type

event itemchanged;String 	ls_colName, ls_suppcode, ls_suppno, ls_suppname
String	ls_deptcode, ls_deptname
String	ls_Null 
//DataWindowChild ldwc

this.AcceptText ( )

SetNull(ls_Null)
ls_colName = This.GetcolumnName()
Choose Case ls_colName
	Case 'suppliercode'
			ls_suppcode	= data
		  SELECT A.SupplierNo,   
					A.SupplierKorName  
			 INTO :ls_suppno,   
					:ls_suppname  
			 FROM TMSTSUPPLIER	A  
			WHERE A.SupplierCode = :ls_suppcode 
			Using	sqlpis	;
			
			If sqlpis.SqlCode <> 0 Then 
				This.SetItem( This.GetRow(), 'suppliercode'		, ls_Null )
				This.SetItem( This.GetRow(), 'supplierno'			, ls_Null )
				This.SetItem( This.GetRow(), 'supplierkorname'	, ls_Null )
				istr_partkb.suppcode = '%'
				Return 1
			End If
			This.SetItem( This.GetRow(), 'supplierno'			, ls_suppno )
			This.SetItem( This.GetRow(), 'supplierkorname'	, ls_suppname )
			istr_partkb.suppcode = ls_suppcode
	Case 'deptcode' 
			ls_deptcode	= data
		  SELECT TMSTDEPT.DeptName  
			 INTO :ls_deptname  
			 FROM TMSTDEPT  
			WHERE TMSTDEPT.DeptCode = :ls_deptcode
			USING	sqlpis	;

			If sqlpis.SqlCode <> 0 Then 
				This.SetItem( This.GetRow(), 'deptcode', ls_Null )
				This.SetItem( This.GetRow(), 'deptname', ls_Null )
				Return 1
			End If
			This.SetItem( This.GetRow(), 'deptname', ls_deptname )
End Choose 


end event

event buttonclicked;str_pisr_return lstr_Rtn
String	ls_buttonname

ls_buttonname 	= dwo.name

CHOOSE CASE ls_buttonname
	CASE 'b_supplier'
			istr_partkb.flag = 2			//���־�ü(��ü)
			OpenWithParm ( w_pisr012i, istr_partkb )
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return
			This.SetItem(row,'suppliercode'		, lstr_Rtn.code)
			This.SetItem(row,'supplierkorname'	, lstr_Rtn.name)
			This.SetItem(row,'supplierno'			, lstr_Rtn.nicname)
	CASE 'b_dept'
			OpenWithParm ( w_pisr016i, istr_partkb )
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return
			This.SetItem(row,'deptcode'			, lstr_Rtn.code)
			This.SetItem(row,'deptname'			, lstr_Rtn.name)
	CASE ELSE
			Return
END CHOOSE

Return

end event

event itemerror;
return 1
end event

type dw_2 from u_vi_std_datawindow within w_pisr136u
integer x = 23
integer y = 208
integer width = 3058
integer height = 748
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr136u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;
If currentrow <= 0 Or RowCount() = 0 Then Return 

String	ls_buybackno, ls_buybackdate
DateTime	ldt_buybacktime

ls_buybackno 		= This.GetItemString(currentrow, "buybackno") 
ldt_buybacktime 	= This.GetItemDateTime(currentrow, "buybacktime") 
ls_buybackdate		= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, ldt_buybacktime )	//�������� -8�ð������

dw_3.SetRedraw(False)
dw_3.SetTransObject(Sqlpis)
dw_3.Retrieve(ls_buybackno, ls_buybackdate)
dw_3.SetRedraw(True)

end event

type dw_3 from u_vi_std_datawindow within w_pisr136u
integer x = 23
integer y = 972
integer width = 3054
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr135i_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_hsplitbar from u_pism_splitbar within w_pisr136u
integer x = 18
integer y = 952
boolean bringtotop = true
end type

type pb_1 from picturebutton within w_pisr136u
integer x = 3442
integer y = 64
integer width = 288
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
boolean originalsize = true
end type

event clicked;
parent.TriggerEvent( "ue_ok" )
end event

type pb_2 from picturebutton within w_pisr136u
integer x = 3758
integer y = 64
integer width = 288
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�ݷ�"
boolean originalsize = true
end type

event clicked;
parent.TriggerEvent( "ue_cancel" )
end event

type gb_1 from groupbox within w_pisr136u
integer x = 23
integer width = 1147
integer height = 192
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisr136u
integer x = 3397
integer width = 690
integer height = 192
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisr136u
integer x = 1189
integer width = 2185
integer height = 192
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

