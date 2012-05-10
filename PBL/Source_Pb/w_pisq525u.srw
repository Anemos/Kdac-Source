$PBExportHeader$w_pisq525u.srw
$PBExportComments$정비딜러코드등록(내수)
forward
global type w_pisq525u from w_ipis_sheet01
end type
type dw_pisq525u_01 from u_vi_std_datawindow within w_pisq525u
end type
type gb_2 from groupbox within w_pisq525u
end type
end forward

global type w_pisq525u from w_ipis_sheet01
integer width = 4695
integer height = 2700
string title = "정비딜러코드등록(내수)"
dw_pisq525u_01 dw_pisq525u_01
gb_2 gb_2
end type
global w_pisq525u w_pisq525u

type variables

String	is_AreaCode, is_DivisionCode
Long		il_selectcnt

end variables

on w_pisq525u.create
int iCurrent
call super::create
this.dw_pisq525u_01=create dw_pisq525u_01
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq525u_01
this.Control[iCurrent+2]=this.gb_2
end on

on w_pisq525u.destroy
call super::destroy
destroy(this.dw_pisq525u_01)
destroy(this.gb_2)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq080i, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
dw_pisq525u_01.Retrieve()

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq525u_01, 1, True)	


end event

event ue_postopen;
// 트랜잭션을 연결한다
//
dw_pisq525u_01.SetTransObject(SQLEIS)

This.TriggerEvent('ue_retrieve')
end event

event ue_save;call super::ue_save;
Int	li_save

// AUTO COMMIT을 FASLE로 지정
//
SQLEIS.AUTOCommit = FALSE

li_save = dw_pisq525u_01.Update()

IF li_save = 1 THEN
	// Commit 처리
	//
	COMMIT USING SQLEIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack 처리
	//
	ROLLBACK USING SQLEIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
END IF

end event

event ue_insert;call super::ue_insert;
Long	ll_ins_row

// 최종 입력행을 구한다
//
ll_ins_row = dw_pisq525u_01.InsertRow(0)

// 포커스를 이동한다
//
dw_pisq525u_01.SetColumn('dealercode')
dw_pisq525u_01.SetFocus()

// 최종 입력행에 반전표시를 한다
//
f_SetHighlight(dw_pisq525u_01, ll_ins_row, True)	


end event

event ue_delete;call super::ue_delete;
Long	ll_select_row

// 선택된 행값을 구한다
//
ll_select_row = dw_pisq525u_01.GetSelectedRow(0)

// 선택된 행을 삭제한다
//
dw_pisq525u_01.DeleteRow(dw_pisq525u_01.GetSelectedRow(0))

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisq525u_01.RowCount() THEN
	f_SetHighlight(dw_pisq525u_01, dw_pisq525u_01.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq525u_01, ll_select_row, True)	
END IF

end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("확인","EIS 서버에 연결하는데 실패했습니다.")
end if

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

event ue_print;call super::ue_print;if dw_pisq525u_01.rowcount() < 1 then
	uo_status.st_message.text = "다운로드할 자료가 없습니다."
end if

f_save_to_excel_number(dw_pisq525u_01)

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq525u
integer x = 18
integer width = 3598
end type

type dw_pisq525u_01 from u_vi_std_datawindow within w_pisq525u
integer x = 46
integer y = 44
integer width = 4562
integer height = 2504
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq525u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_2 from groupbox within w_pisq525u
integer x = 18
integer y = 12
integer width = 4622
integer height = 2560
integer taborder = 90
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

