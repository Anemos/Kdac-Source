$PBExportHeader$w_bom203i.srw
$PBExportComments$EPL 조회
forward
global type w_bom203i from w_origin_sheet01
end type
type dw_epl201_01 from datawindow within w_bom203i
end type
type dw_epl201_02 from datawindow within w_bom203i
end type
type st_1 from statictext within w_bom203i
end type
type sle_itno from singlelineedit within w_bom203i
end type
type st_last from statictext within w_bom203i
end type
type st_before from statictext within w_bom203i
end type
end forward

global type w_bom203i from w_origin_sheet01
integer width = 4667
string icon = "C:\KDAC\kdac.ico"
boolean i_b_retrieve = true
dw_epl201_01 dw_epl201_01
dw_epl201_02 dw_epl201_02
st_1 st_1
sle_itno sle_itno
st_last st_last
st_before st_before
end type
global w_bom203i w_bom203i

on w_bom203i.create
int iCurrent
call super::create
this.dw_epl201_01=create dw_epl201_01
this.dw_epl201_02=create dw_epl201_02
this.st_1=create st_1
this.sle_itno=create sle_itno
this.st_last=create st_last
this.st_before=create st_before
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_epl201_01
this.Control[iCurrent+2]=this.dw_epl201_02
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_itno
this.Control[iCurrent+5]=this.st_last
this.Control[iCurrent+6]=this.st_before
end on

on w_bom203i.destroy
call super::destroy
destroy(this.dw_epl201_01)
destroy(this.dw_epl201_02)
destroy(this.st_1)
destroy(this.sle_itno)
destroy(this.st_last)
destroy(this.st_before)
end on

event ue_retrieve;call super::ue_retrieve;dw_epl201_01.reset()
dw_epl201_02.reset()
st_last.text	=	''
st_before.text	=	''
string	ls_itno,ls_ecnnumber_last,ls_ecnnumber_before
integer	ln_count	
dw_epl201_01.setfocus()
ls_itno	=	trim(sle_itno.text)
select	ecnnumber	into	:	ls_ecnnumber_last	from	pbpdm.epl001
	where	itemcode	=	:ls_itno	//and	partgubun	=	'M'
order	by	ecnnumber desc
using sqlca ;
if	sqlca.sqlcode	<>	0	then
	messagebox("확인","조회 할 정보가 없습니다")
	return
end if
f_creation_epl_dw(ls_itno,'Y')
ln_count	=	dw_epl201_01.retrieve(ls_ecnnumber_last)
st_last.text	=	ls_ecnnumber_last
select	ecnnumber	into	:	ls_ecnnumber_before	from	pbpdm.epl001
	where	itemcode	=	:ls_itno	and 	ecnnumber	<	:ls_ecnnumber_last //and	partgubun	=	'M'
order	by	ecnnumber desc
using sqlca ;
//if	sqlca.sqlcode	<>	0	then
//	messagebox("확인","해당 품번의 설변통보번호는 하나만 존재합니다")
//	return
//end if
ln_count					=	dw_epl201_02.retrieve(ls_ecnnumber_before)
st_before.text			=	ls_ecnnumber_before



end event

type uo_status from w_origin_sheet01`uo_status within w_bom203i
integer y = 2464
end type

type dw_epl201_01 from datawindow within w_bom203i
integer y = 128
integer width = 2304
integer height = 2336
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_epl_retrieve"
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "C:\KDAC\kdac.ico"
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_epl201_02 from datawindow within w_bom203i
integer x = 2341
integer y = 128
integer width = 2267
integer height = 2336
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_epl_retrieve"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type st_1 from statictext within w_bom203i
integer x = 37
integer y = 32
integer width = 329
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "적용모델 :"
boolean focusrectangle = false
end type

type sle_itno from singlelineedit within w_bom203i
event ue_keydown pbm_keydown
integer x = 366
integer y = 20
integer width = 475
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if	key 	=	keyenter!	then
	parent.triggerevent("ue_retrieve")
end if

end event

type st_last from statictext within w_bom203i
integer x = 1719
integer y = 40
integer width = 585
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long textcolor = 128
long backcolor = 12632256
alignment alignment = right!
boolean focusrectangle = false
end type

type st_before from statictext within w_bom203i
integer x = 4023
integer y = 40
integer width = 585
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long textcolor = 128
long backcolor = 12632256
alignment alignment = right!
boolean focusrectangle = false
end type

