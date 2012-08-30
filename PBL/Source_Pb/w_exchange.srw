$PBExportHeader$w_exchange.srw
$PBExportComments$이체단가계산 Window
forward
global type w_exchange from w_origin_sheet02
end type
type st_1 from statictext within w_exchange
end type
type uo_from from uo_comm_yymm within w_exchange
end type
type cb_1 from commandbutton within w_exchange
end type
type dw_1 from datawindow within w_exchange
end type
type st_2 from statictext within w_exchange
end type
type sle_fromdt from singlelineedit within w_exchange
end type
type sle_todt from singlelineedit within w_exchange
end type
end forward

global type w_exchange from w_origin_sheet02
st_1 st_1
uo_from uo_from
cb_1 cb_1
dw_1 dw_1
st_2 st_2
sle_fromdt sle_fromdt
sle_todt sle_todt
end type
global w_exchange w_exchange

on w_exchange.create
int iCurrent
call super::create
this.st_1=create st_1
this.uo_from=create uo_from
this.cb_1=create cb_1
this.dw_1=create dw_1
this.st_2=create st_2
this.sle_fromdt=create sle_fromdt
this.sle_todt=create sle_todt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.uo_from
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.sle_fromdt
this.Control[iCurrent+7]=this.sle_todt
end on

on w_exchange.destroy
call super::destroy
destroy(this.st_1)
destroy(this.uo_from)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.sle_fromdt)
destroy(this.sle_todt)
end on

event open;call super::open;string mysql
dw_1.settransobject(Sqlca)

end event

event ue_retrieve;call super::ue_retrieve;dec{0} ld_yyyymm
string ls_year1,ls_month1

// user object 에서 필요한 값 가져오기 - start
ld_yyyymm 	= uo_from.uf_yyyymm()
ls_year1 	= mid(string(ld_yyyymm),1,4)
ls_month1 	= mid(string(ld_yyyymm),5,2)

if dw_1.retrieve(ls_year1,ls_month1) < 1 then
	uo_status.st_message.text = f_message("I020")
else
	uo_status.st_message.text = f_message("I010")
end if

end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

type uo_status from w_origin_sheet02`uo_status within w_exchange
end type

type st_1 from statictext within w_exchange
integer x = 18
integer y = 40
integer width = 270
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
string text = "기준년월"
boolean focusrectangle = false
end type

type uo_from from uo_comm_yymm within w_exchange
integer x = 306
integer y = 20
integer height = 100
integer taborder = 10
boolean bringtotop = true
end type

event constructor;call super::constructor;//현재월보다 한달적은 달을 기준월로 설정
if integer(mid(g_s_date,5,2)) = 1 then
	uo_from.uf_reset(integer(mid(g_s_date,1,4)) - 1,12)
else
	uo_from.uf_reset(integer(mid(g_s_date,1,4)),integer(mid(g_s_date,5,2)) - 1)
end if

end event

on uo_from.destroy
call uo_comm_yymm::destroy
end on

event ue_modify;call super::ue_modify;string 	ls_year,ls_month

ls_year  = string(yyyy,"0000")
ls_month = string(mm  ,"00")

if ls_year + ls_month >= mid(g_s_date,1,6) then
	cb_1.enabled = false
else
	cb_1.enabled = true
end if
end event

type cb_1 from commandbutton within w_exchange
integer x = 2949
integer y = 28
integer width = 457
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "이체단가계산"
end type

event clicked;dec{0} ld_yyyymm
string ls_year1,ls_month1,ls_yearmonth1,ls_applydate,ls_comltd, ls_curtime
long   ln_count

SetPointer(HourGlass!)

SELECT CAST(CURRENT TIME AS VARCHAR(10)) 
into :ls_curtime
FROM PBCOMMON.COMM000
using sqlca;
sle_fromdt.text = ls_curtime
// user object 에서 필요한 값 가져오기 - start
ls_comltd = '01'
ld_yyyymm 		= uo_from.uf_yyyymm()
ls_year1 		= mid(string(ld_yyyymm),1,4)
ls_month1 		= mid(string(ld_yyyymm),5,2)
ls_yearmonth1 	= ls_year1 + ls_month1 + '31'
ls_applydate = f_relativedate(f_relative_month(ls_year1 + ls_month1 + '01',1),-1)

if ls_year1 + ls_month1 >= mid(g_s_date,1,6) then
	messagebox("확인","현재월 또는 그 이상의 월에 대해서는 작업이 불가합니다.")
	return
end if

select count(*) into: ln_count from "PBPDM"."BOM010"
	WHERE "PBPDM"."BOM010"."ACMCD" = '01' AND "PBPDM"."BOM010"."AYEAR" = :ls_year1 AND
			"PBPDM"."BOM010"."AMONT" = :ls_month1
USING SQLCA;

if ln_count > 0 then
	DELETE FROM "PBPDM"."BOM010"
		WHERE "PBPDM"."BOM010"."ACMCD" = '01' AND "PBPDM"."BOM010"."AYEAR" = :ls_year1 AND
				"PBPDM"."BOM010"."AMONT" = :ls_month1
	USING SQLCA;
	
	DELETE FROM "PBPDM"."BOM010A"
		WHERE "PBPDM"."BOM010A"."ACMCD" = '01' AND "PBPDM"."BOM010A"."AYEAR" = :ls_year1 AND
				"PBPDM"."BOM010A"."AMONT" = :ls_month1
	USING SQLCA;
end if

//이체단가계산 함수 호출
f_exchange_danga(ls_yearmonth1)

//월간재료비계산(고객사유상 공제분제외) 호출
DECLARE SP_BOM_002 PROCEDURE FOR PBPDM.SP_BOM_002  
         A_COMLTD = :ls_comltd,   
         A_APPLYDATE = :ls_applydate,   
         A_CREATEDATE = :g_s_date,   
         A_CHK = 'A'  
			using sqlca;

execute SP_BOM_002;

SELECT CAST(CURRENT TIME AS VARCHAR(10))
into :ls_curtime
FROM PBCOMMON.COMM000
using sqlca;
sle_todt.text = ls_curtime
dw_1.retrieve(ls_year1,ls_month1)



end event

type dw_1 from datawindow within w_exchange
integer x = 562
integer y = 224
integer width = 2327
integer height = 1336
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_exchange"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_exchange
integer x = 910
integer y = 32
integer width = 338
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "작업시간:"
boolean focusrectangle = false
end type

type sle_fromdt from singlelineedit within w_exchange
integer x = 1253
integer y = 32
integer width = 809
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_todt from singlelineedit within w_exchange
integer x = 2085
integer y = 32
integer width = 809
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

