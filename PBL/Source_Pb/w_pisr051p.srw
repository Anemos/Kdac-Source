$PBExportHeader$w_pisr051p.srw
$PBExportComments$개별간판 출력 ( 페이지당 3매 간판출력 )
forward
global type w_pisr051p from window
end type
type st_5 from statictext within w_pisr051p
end type
type sle_left from singlelineedit within w_pisr051p
end type
type sle_top from singlelineedit within w_pisr051p
end type
type st_4 from statictext within w_pisr051p
end type
type st_3 from statictext within w_pisr051p
end type
type pb_print from picturebutton within w_pisr051p
end type
type st_ingkbcnt from statictext within w_pisr051p
end type
type st_prkbno from statictext within w_pisr051p
end type
type st_2 from statictext within w_pisr051p
end type
type st_totkbcnt from statictext within w_pisr051p
end type
type st_1 from statictext within w_pisr051p
end type
type st_6 from statictext within w_pisr051p
end type
type dw_partkb from datawindow within w_pisr051p
end type
end forward

global type w_pisr051p from window
integer width = 3255
integer height = 1496
boolean titlebar = true
string title = "외주간판출력"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
st_5 st_5
sle_left sle_left
sle_top sle_top
st_4 st_4
st_3 st_3
pb_print pb_print
st_ingkbcnt st_ingkbcnt
st_prkbno st_prkbno
st_2 st_2
st_totkbcnt st_totkbcnt
st_1 st_1
st_6 st_6
dw_partkb dw_partkb
end type
global w_pisr051p w_pisr051p

type variables
DataStore 	ids_partkbprlist
Boolean 		ib_stop
end variables

forward prototypes
public function integer wf_prpartkb ()
end prototypes

public function integer wf_prpartkb ();string  	ls_ppartKbNo[4]
String  	ls_partKbNo, ls_areaCode, ls_divCode, ls_suppCode, ls_itemCode 
Integer 	I, ll_prKbCnt
DateTime ldt_now 
Long 		ll_row 
Integer 	li_Net
DataWindowChild ldwc 
Integer 	li_onepage, J, li_jobcnt
Long 		ll_allCnt, ll_reprintCnt
Long 		ll_top, ll_left

ll_top	= 0
ll_left	= 0
If isNumber(sle_top.Text) 	Then ll_top		= long(sle_top.Text) * 100
If isNumber(sle_left.Text) Then ll_left	= long(sle_left.Text)* 100

li_onepage 	= 3		// 1 page에 출력할 간판매수
li_jobcnt	= 0

ldt_now	= f_pisc_get_date_nowtime()

If pb_print.Tag = 'STOP' Then
	ib_stop	= True
Else
	sqlpis.AutoCommit = False

	ll_prKbCnt = ids_partkbprlist.RowCount() 
	
	st_totkbcnt.Text = String(ll_prKbCnt, "#,##0")
	
//	dw_partkb.SetTransObject(sqlpis)
	pb_print.Text	= '발행 중지 (&P)'
	pb_print.Tag	= 'STOP'
	ll_allCnt		= ids_partkbprlist.RowCount()
	For J = 1 to 4				//출력할 간판번호 초기화
		ls_ppartKbNo[J] = ''
	Next
	
	For I = 1 To ll_allCnt Step 3 	//Step li_onepage
		Yield()
		
		If ib_stop Then
			li_Net = MessageBox('발행 중지', '간판 발행을 중지하시겠습니까?', &
					Question!, OKCancel!, 2)
			IF li_Net = 1 THEN 
//			If f_MessageBox3(Question!, 999, '발행 중지', '간판 발행을 중지하시겠습니까?', "예", "아니오") = 1 Then
				pb_print.Text	= '발행 계속(&P)'
				pb_print.Tag	= 'START'
				ib_stop			= False
				Exit
			End If
			ib_stop = False
		End If

		For J = 1 to li_onepage				//페이지별 출력할 간판 번호 Reset
			ls_ppartKbNo[J] = ''
		Next
		
		For J = 1 to li_onepage
			li_jobcnt = li_jobcnt + 1		//출력된 간판매수 표시
			If li_jobcnt > ll_allCnt Then 
				li_jobcnt = li_jobcnt - 1	//출력된 간판매수 표시
				EXIT
			End If
			ls_ppartKbNo[J] = ids_partkbprlist.GetItemString( li_jobcnt, "partkbno")
		Next	//J = 1 to li_onepage
//		ls_partKbNo = ids_partkbprlist.GetItemString(I, "partkbno")
		dw_partkb.SetTransObject( sqlpis )
		ll_row = dw_partkb.Retrieve(ls_ppartKbNo[1],ls_ppartKbNo[2],ls_ppartKbNo[3],ls_ppartKbNo[4]) 
		dw_partkb.Modify("DataWindow.Print.Margin.Top=" + string(ll_top) )
		dw_partkb.Modify("DataWindow.Print.Margin.Left=" + string(ll_left) )
		
		If ll_row < 1 Then Goto  RollBack_
		
		For J = 1 to ll_row
			ls_areaCode 	= dw_partkb.GetItemString(J, "areacode")
			ls_divCode 		= dw_partkb.GetItemString(J, "divisioncode")
			ls_suppCode 	= dw_partkb.GetItemString(J, "supplierCode")
			ls_itemCode 	= dw_partkb.GetItemString(J, "itemCode")
			ll_reprintCnt 	= dw_partkb.GetItemNumber(J, "reprintcount")
			dw_partkb.SetItem( J, 'reprintflag'		, 'N')
			dw_partkb.SetItem( J, 'reprintcount'	, ll_reprintCnt + 1)
			dw_partkb.Setitem( J, 'partkbprintdate', ldt_now)
			dw_partkb.SetItem( J, 'lastemp'			, 'Y')	//Interface Flag 활용
			dw_partkb.SetItem( J, 'lastdate'			, ldt_now)

			If ll_reprintCnt < 1 Then 
			  UPDATE TMSTPARTKB  
				  SET PartKBPrintCount 	= PartKBPrintCount + 1, 
						LastEmp 				= 'Y', //Interface Flag 활용
						LastDate 			= :ldt_now   
				WHERE AreaCode 		= :ls_areaCode  	AND  
						DivisionCode 	= :ls_divCode  	AND  
						SupplierCode 	= :ls_suppCode  	AND  
						ItemCode 		= :ls_itemCode  
				USING sqlpis	;
				If sqlpis.Sqlcode <> 0 Then Goto RollBack_
			End If
		Next	//J = 1 to ll_row
	
		// 출력 
		If f_pisr_dwupdate(sqlpis, dw_partkb, False) = -1 Then Goto RollBack_
		
		st_ingkbcnt.Text = String(li_jobcnt , "#,##0")
		st_prkbno.Text = ls_partKbNo
///////////////////////////////////
		dw_partkb.Print()
///////////////////////////////////
	Next 
	
	pb_print.Text = "종 료"
	
//	f_pisr_sqlchkopt(sqlpis, True)
	Commit Using sqlpis;
	sqlpis.AutoCommit = True
	MessageBox('발행완료', '외주간판 발행이 완료되었습니다.', Information!)
	
End If 


Return 1

RollBack_:
RollBack Using sqlpis;
Sqlca.AutoCommit = True 

MessageBox('발행실패', '외주간판 발행작업에 실패했습니다.', StopSign!)

Return -1 


end function

on w_pisr051p.create
this.st_5=create st_5
this.sle_left=create sle_left
this.sle_top=create sle_top
this.st_4=create st_4
this.st_3=create st_3
this.pb_print=create pb_print
this.st_ingkbcnt=create st_ingkbcnt
this.st_prkbno=create st_prkbno
this.st_2=create st_2
this.st_totkbcnt=create st_totkbcnt
this.st_1=create st_1
this.st_6=create st_6
this.dw_partkb=create dw_partkb
this.Control[]={this.st_5,&
this.sle_left,&
this.sle_top,&
this.st_4,&
this.st_3,&
this.pb_print,&
this.st_ingkbcnt,&
this.st_prkbno,&
this.st_2,&
this.st_totkbcnt,&
this.st_1,&
this.st_6,&
this.dw_partkb}
end on

on w_pisr051p.destroy
destroy(this.st_5)
destroy(this.sle_left)
destroy(this.sle_top)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.pb_print)
destroy(this.st_ingkbcnt)
destroy(this.st_prkbno)
destroy(this.st_2)
destroy(this.st_totkbcnt)
destroy(this.st_1)
destroy(this.st_6)
destroy(this.dw_partkb)
end on

event open;String	ls_partkbno, ls_parttype
Long		ll_Cnt
String	ls_area, ls_div, ls_supp, ls_item

ids_partkbprlist = message.PowerObjectParm 

f_pisc_win_center_move(This)

ll_Cnt		= ids_partkbprlist.RowCount()
st_totkbcnt.Text = String(ll_Cnt, "#,##0")

ls_partkbno = ids_partkbprlist.GetItemString(1, 'partkbno')

  SELECT AreaCode, DivisionCode, SupplierCode, ItemCode
    INTO :ls_area,
	 		:ls_div,
			:ls_supp,
			:ls_item
    FROM TPARTKBSTATUS  
   WHERE PartKBNo = :ls_partkbno
	USING	sqlpis	;

  SELECT PartType
    INTO :ls_parttype
    FROM TMSTPARTKB
   WHERE AreaCode 		= :ls_area 	And
			DivisionCode 	= :ls_div 	And
			SupplierCode 	= :ls_supp 	And
			ItemCode 		= :ls_item 
	USING	sqlpis	;

If ls_parttype = 'P' Then 	//계획품 : 노란색
	st_5.BackColor = RGB(255,255,0)
	st_6.BackColor = RGB(255,255,0)
End If

//pb_print.Post Event Clicked()

end event

type st_5 from statictext within w_pisr051p
integer x = 786
integer y = 544
integer width = 1687
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
string text = "간판 출력 대기중"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_left from singlelineedit within w_pisr051p
integer x = 2327
integer y = 1276
integer width = 302
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "8"
borderstyle borderstyle = stylelowered!
end type

type sle_top from singlelineedit within w_pisr051p
integer x = 2327
integer y = 1184
integer width = 302
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "5"
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_pisr051p
integer x = 2016
integer y = 1304
integer width = 302
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "좌측여백:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisr051p
integer x = 2016
integer y = 1200
integer width = 302
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "상단여백:"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_print from picturebutton within w_pisr051p
string tag = "START"
integer x = 2642
integer y = 1184
integer width = 553
integer height = 188
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "간판발행"
boolean originalsize = true
end type

event clicked;Integer	li_Net

If This.Text <> '종 료' Then 
	li_Net = MessageBox("간판색상확인", "간판발행을 시작합니다.~r~n제품구분과 간판의 색상을 다시 확인한 후 ~r~n" 	+ &
					"색상이 다른 경우, 간판을 교체후 다시 수행하세요~r~n~r~n간판발행을 시작하시겠습니까 ?", &
			Question!, OKCancel!, 2)
	IF li_Net <> 1 THEN	Return
	st_5.Visible = False
	st_6.Visible = False
	wf_prPartKb()
Else
	ids_partkbprlist.Reset()
	CloseWithReturn(Parent, 'Close')
End If 
end event

type st_ingkbcnt from statictext within w_pisr051p
integer x = 571
integer y = 1292
integer width = 197
integer height = 84
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_prkbno from statictext within w_pisr051p
integer x = 795
integer y = 1292
integer width = 814
integer height = 84
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisr051p
integer x = 69
integer y = 1292
integer width = 261
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "출력중:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_totkbcnt from statictext within w_pisr051p
integer x = 571
integer y = 1196
integer width = 197
integer height = 84
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisr051p
integer x = 87
integer y = 1196
integer width = 498
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "발행할간판매수:"
boolean focusrectangle = false
end type

type st_6 from statictext within w_pisr051p
integer x = 768
integer y = 260
integer width = 1714
integer height = 648
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_partkb from datawindow within w_pisr051p
integer x = 5
integer y = 4
integer width = 3205
integer height = 1152
integer taborder = 10
string title = "none"
string dataobject = "d_pisr051p_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

