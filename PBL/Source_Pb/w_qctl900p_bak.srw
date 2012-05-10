$PBExportHeader$w_qctl900p_bak.srw
$PBExportComments$각종자료 출력
forward
global type w_qctl900p_bak from w_origin_sheet07
end type
type em_frdt from editmask within w_qctl900p_bak
end type
type st_2 from statictext within w_qctl900p_bak
end type
type st_1 from statictext within w_qctl900p_bak
end type
type ddlb_1 from dropdownlistbox within w_qctl900p_bak
end type
type ddlb_2 from dropdownlistbox within w_qctl900p_bak
end type
type st_3 from statictext within w_qctl900p_bak
end type
type em_todt from editmask within w_qctl900p_bak
end type
end forward

global type w_qctl900p_bak from w_origin_sheet07
string title = "재고관리 출력"
em_frdt em_frdt
st_2 st_2
st_1 st_1
ddlb_1 ddlb_1
ddlb_2 ddlb_2
st_3 st_3
em_todt em_todt
end type
global w_qctl900p_bak w_qctl900p_bak

on w_qctl900p_bak.create
int iCurrent
call super::create
this.em_frdt=create em_frdt
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.ddlb_2=create ddlb_2
this.st_3=create st_3
this.em_todt=create em_todt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_frdt
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.ddlb_1
this.Control[iCurrent+5]=this.ddlb_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.em_todt
end on

on w_qctl900p_bak.destroy
call super::destroy
destroy(this.em_frdt)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.ddlb_2)
destroy(this.st_3)
destroy(this.em_todt)
end on

event open;// 자료선택항목 not display
st_1.visible    = false
st_2.visible    = false
em_frdt.visible = false
em_todt.visible = false
ddlb_1.visible  = false
ddlb_2.visible  = false
end event

type r_1 from w_origin_sheet07`r_1 within w_qctl900p_bak
end type

type uo_status from w_origin_sheet07`uo_status within w_qctl900p_bak
end type

type lb_1 from w_origin_sheet07`lb_1 within w_qctl900p_bak
integer textsize = -11
string item[] = {"1. 공장별 완제품 매출 현황","2. 업체/공장별 완제품 매출현황","3. 공장별 매출 현황","4. 업체/공장별 매출 현황"}
end type

event lb_1::selectionchanged;i_s_report	= 	string(index)

st_1.visible    = false
st_2.visible    = false
em_frdt.visible = false
em_todt.visible = false
ddlb_1.visible  = false
ddlb_2.visible  = false

Choose case i_s_report
	case "1", "3"
		st_1.visible    = true
		st_2.visible    = true
		em_frdt.visible = true
		em_todt.visible = true
      ddlb_1.visible  = true
		em_frdt.setfocus()
	case "2", "4"
		st_1.visible    = true
		st_2.visible    = true
		em_frdt.visible = true
		em_todt.visible = true
      ddlb_2.visible  = true
		em_frdt.setfocus()	
end Choose

end event

type cb_cancel from w_origin_sheet07`cb_cancel within w_qctl900p_bak
end type

type cb_ok from w_origin_sheet07`cb_ok within w_qctl900p_bak
end type

event cb_ok::clicked;Setpointer(hourglass!)

window l_to_open
int	 l_n_rcnt, l_n_forcnt
string l_s_frdt, l_s_duse

if f_spacechk(i_s_report)	=	-1	then
	uo_status.st_message.text = f_message("P060")
	return
end if

//-- 인쇄물별 조건 Editing Routine
l_s_frdt	 = em_frdt.text
if f_spacechk(l_s_frdt)	=	-1	then
	em_frdt.setfocus()
	uo_status.st_message.text = "해당년도를 입력후 확인버튼 클릭"
	return
end if
Choose case i_s_report
	case "1", "3"
		if ddlb_1.text = "내수" then
			l_s_duse = 'D'
		elseif ddlb_1.text = "수출" then
				 l_s_duse = 'E'
		elseif ddlb_1.text = "전체" then
				 l_s_duse = '%'
		else
			ddlb_1.setfocus()
			uo_status.st_message.text = "내수수출구분을 선택후 확인버튼 클릭"
			return
		end if
   Case "2", "4"
		if ddlb_2.text = "내수" then
			l_s_duse = 'D'
		elseif ddlb_2.text = "수출" then
				 l_s_duse = 'E'
		else
			ddlb_2.setfocus()
			uo_status.st_message.text = "내수수출구분을 선택후 확인버튼 클릭"
			return
		end if
end Choose
uo_status.st_message.text = f_message("P070") //잠시만 기다리세요....//

////인쇄물별 DataWindow Modify

Choose Case i_s_report
	Case "1"
		i_str_prt.title	= 	"공장별 완제품매출 현황"		
		dw_1.DataObject	= 	"d_qctl901p_01"
	Case "2"
		i_str_prt.title	= 	"업체/공장별 완제품매출 현황"		
		dw_1.DataObject	= 	"d_qctl901p_02"
	Case "3"
		i_str_prt.title	= 	"공장별 매출 현황"		
		dw_1.DataObject	= 	"d_qctl901p_03"
	Case "4"
		i_str_prt.title	= 	"업체/공장별 매출 현황"		
		dw_1.DataObject	= 	"d_qctl901p_04"
end Choose

dw_1.SetTransObject(sqlca)
l_n_rcnt  = dw_1.Retrieve(l_s_duse, l_s_frdt)

//if i_s_report = "1" then
//   l_n_rcnt  = dw_1.Retrieve(l_s_duse, l_s_frdt)
//elseIf i_s_report = "2" then
//   	 l_n_rcnt	=	dw_1.Retrieve(l_s_duse, l_s_frdt)
//end if

if l_n_rcnt	< 1 then
	uo_status.st_message.Text	=	f_message("P020")		// 출력할 자료가 없습니다.
	return
end if

//-- 인쇄 DataWindow 저장
i_str_prt.transaction   =	sqlca
i_str_prt.datawindow		= 	dw_1
i_str_prt.tag				= 	Parent.ClassName()

f_close_report("2", i_str_prt.title)						// Open된 출력Window 닫기
Opensheetwithparm(l_to_open, i_str_prt, "w_prt", w_frame, 0, Layered!)
uo_status.st_message.text = ""

end event

type dw_1 from w_origin_sheet07`dw_1 within w_qctl900p_bak
integer x = 2866
end type

type gb_01 from w_origin_sheet07`gb_01 within w_qctl900p_bak
end type

type gb_00 from w_origin_sheet07`gb_00 within w_qctl900p_bak
end type

type ln_1 from w_origin_sheet07`ln_1 within w_qctl900p_bak
end type

type ln_2 from w_origin_sheet07`ln_2 within w_qctl900p_bak
end type

type ln_4 from w_origin_sheet07`ln_4 within w_qctl900p_bak
end type

type ln_3 from w_origin_sheet07`ln_3 within w_qctl900p_bak
end type

type st_0 from w_origin_sheet07`st_0 within w_qctl900p_bak
end type

type em_frdt from editmask within w_qctl900p_bak
integer x = 1349
integer y = 1392
integer width = 430
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
boolean autoskip = true
end type

type st_2 from statictext within w_qctl900p_bak
integer x = 914
integer y = 1408
integer width = 430
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "기        간"
boolean focusrectangle = false
end type

type st_1 from statictext within w_qctl900p_bak
integer x = 914
integer y = 1508
integer width = 398
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "내수수출구분"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_qctl900p_bak
integer x = 1349
integer y = 1492
integer width = 293
integer height = 324
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
string text = "none"
string item[] = {"내수","수출","전체"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_2 from dropdownlistbox within w_qctl900p_bak
integer x = 1349
integer y = 1492
integer width = 293
integer height = 324
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
string text = "none"
string item[] = {"내수","수출"}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_qctl900p_bak
integer x = 1783
integer y = 1404
integer width = 91
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_todt from editmask within w_qctl900p_bak
integer x = 1870
integer y = 1392
integer width = 430
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
boolean autoskip = true
end type

