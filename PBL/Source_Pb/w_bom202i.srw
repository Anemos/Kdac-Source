$PBExportHeader$w_bom202i.srw
$PBExportComments$M-BOM History 조회 For 영업(실사)
forward
global type w_bom202i from w_origin_sheet02
end type
type dw_1 from datawindow within w_bom202i
end type
type pb_excel from picturebutton within w_bom202i
end type
type uo_1 from uo_plandiv_pdcd within w_bom202i
end type
type st_2 from statictext within w_bom202i
end type
type sle_1 from singlelineedit within w_bom202i
end type
type pb_1 from picturebutton within w_bom202i
end type
type dw_2 from datawindow within w_bom202i
end type
type dw_3 from datawindow within w_bom202i
end type
type st_1 from statictext within w_bom202i
end type
type em_refdate from editmask within w_bom202i
end type
type gb_1 from groupbox within w_bom202i
end type
end forward

global type w_bom202i from w_origin_sheet02
dw_1 dw_1
pb_excel pb_excel
uo_1 uo_1
st_2 st_2
sle_1 sle_1
pb_1 pb_1
dw_2 dw_2
dw_3 dw_3
st_1 st_1
em_refdate em_refdate
gb_1 gb_1
end type
global w_bom202i w_bom202i

on w_bom202i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.pb_excel=create pb_excel
this.uo_1=create uo_1
this.st_2=create st_2
this.sle_1=create sle_1
this.pb_1=create pb_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_1=create st_1
this.em_refdate=create em_refdate
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.pb_excel
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.em_refdate
this.Control[iCurrent+11]=this.gb_1
end on

on w_bom202i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.pb_excel)
destroy(this.uo_1)
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.pb_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_1)
destroy(this.em_refdate)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;string  ls_plant,ls_div,ls_pdcd,ls_itno,ls_rtncd,ls_yyyymm,ls_gubun
integer l_n_count

SetPointer(HourGlass!)
ls_rtncd = uo_1.uf_return()
ls_plant = trim(mid(ls_rtncd,1,1)) + '%' 
ls_div   = trim(mid(ls_rtncd,2,1)) + '%' 
ls_pdcd  = trim(mid(ls_rtncd,3,2)) + '%' 
ls_itno  = trim(sle_1.text) + '%'

dw_1.reset()

select	bb	into	:ls_gubun		from	pbcommon.comm000
using	sqlca	;
if	f_spacechk(ls_gubun)	=	-1	or	trim(ls_gubun)	<>	'A'	then
	ls_gubun	=	'I'
end	if

em_refdate.getdata(ls_yyyymm)
l_n_count = dw_1.retrieve(ls_yyyymm,ls_plant,ls_div,ls_pdcd,ls_itno,ls_gubun)

if l_n_count < 1 then
	uo_status.st_message.text = f_message("I020")
//	pb_excel.enabled  	=	false
//	pb_excel.visible  	= 	false
else
	uo_status.st_message.text = f_message("I010")
//	pb_excel.enabled  	= 	true
//	pb_excel.visible  	= 	true
end if


end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

event ue_print;call super::ue_print;string  ls_plant,ls_div,ls_pdcd,ls_itno,ls_rtncd,ls_yyyymm
integer l_n_count, li_rtn

SetPointer(HourGlass!)
ls_rtncd = uo_1.uf_return()
ls_plant = trim(mid(ls_rtncd,1,1)) + '%' 
ls_div   = trim(mid(ls_rtncd,2,1)) + '%' 
ls_pdcd  = trim(mid(ls_rtncd,3,2)) + '%' 
ls_itno  = trim(sle_1.text) + '%'

li_rtn = MessageBox("확인","A3용지크기로 바로 출력합니다. 출력하시겠습니까?",Exclamation!, OKCancel!, 2)
if li_rtn = 2 then
	uo_status.st_message.text = '출력할 자료가 취소되었습니다.'
	return 0
end if

dw_2.reset()
em_refdate.getdata(ls_yyyymm)

l_n_count = dw_2.retrieve(ls_yyyymm,ls_plant,ls_div,ls_pdcd,ls_itno,string(g_s_date,'@@@@.@@.@@'))
if l_n_count < 1 then
	uo_status.st_message.text = '출력할 자료가 없습니다'
else
	uo_status.st_message.text = '출력완료'
	dw_2.print()
end if


end event

event open;call super::open;//f_creation_bom_dw_mor()
//dw_3.dataobject = 'd_bom_retrieve_mor'
//dw_3.settransobject(sqlca) ;
//dw_3.retrieve()

i_b_print = true
i_b_save = true
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)
end event

event ue_save;call super::ue_save;long		ln_rowcount,i
dec{6}	ld_zrcpcost 

ln_rowcount	=	dw_1.rowcount()

if	ln_rowcount	<	1	or	dw_1.modifiedcount()	=	0	then
	messagebox("확인","수정한 정보가 없습니다")
	return
end if

string		ls_zplant,ls_zdiv,ls_zitno,ls_zrcpcost

dw_1.accepttext()

for	i	=	1	to	ln_rowcount
	ld_zrcpcost	=	0
	ls_zrcpcost	=	"0"
	ls_zplant	=	""
	ls_zdiv		=	""
	ls_zitno		=	""	
	if	dw_1.getitemstatus(i,"zrcpcost",primary!)	=	DataModified!	then
		ld_zrcpcost	=		dec(trim(dw_1.object.zrcpcost[i]))
		ls_zrcpcost	=		string(ld_zrcpcost,"#,##0.000000")
//		ls_zrcpcost	=		trim(dw_1.object.zrcpcost[i])	
		ls_zplant		=		trim(dw_1.object.zplant[i])
		ls_zdiv		=		trim(dw_1.object.zdiv[i])
		ls_zitno		=		trim(dw_1.object.zitno[i])
		update	pbpdm.BOM013T
			set		zrcpcost	=	:ls_zrcpcost	
		where		zcmcd	=	'01'		and	zdate	=	'200807'	and	zplant	=	:ls_zplant	and
					zdiv		=	:ls_zdiv	and	zitno	=	:ls_zitno
		using	sqlca	;
		if	sqlca.sqlcode	<>	0	then
			messagebox("확인","품번 " + ls_zitno + "을 저장중 오류발생~r~n 시스템 개발팀으로 문의바랍니다.")
			return
		end if
	end if
next

messagebox("확인","저장 성공")


end event

type uo_status from w_origin_sheet02`uo_status within w_bom202i
integer y = 2468
end type

type dw_1 from datawindow within w_bom202i
integer x = 32
integer y = 212
integer width = 4571
integer height = 2228
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_bom202_save"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca);

end event

event clicked;if row <= 0 then
	return
end if
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

end event

type pb_excel from picturebutton within w_bom202i
boolean visible = false
integer x = 4439
integer y = 40
integer width = 155
integer height = 132
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = right!
end type

event clicked;f_Save_to_Excel(dw_1)
end event

type uo_1 from uo_plandiv_pdcd within w_bom202i
integer x = 882
integer y = 40
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

type st_2 from statictext within w_bom202i
integer x = 3355
integer y = 76
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

type sle_1 from singlelineedit within w_bom202i
event ue_keydown pbm_keydown
integer x = 3515
integer y = 60
integer width = 594
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;//if key = keyenter! then
//	parent.triggerevent("ue_retrieve")
//end if
end event

type pb_1 from picturebutton within w_bom202i
integer x = 4123
integer y = 52
integer width = 238
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
vtextalign vtextalign = top!
end type

event clicked;string ls_return,ls_parm, ls_div, ls_pdcd, ls_plant

ls_return	 	= uo_1.uf_return()
ls_div 			= mid(ls_return,2,1)
ls_pdcd  		= mid(ls_return,3,2)
ls_plant 		= mid(ls_return,1,1)

ls_parm = ls_plant + ls_div + ls_pdcd

openwithparm(w_bom110u_res_03,ls_parm)

ls_parm = message.stringparm
sle_1.text = ls_parm

end event

type dw_2 from datawindow within w_bom202i
boolean visible = false
integer x = 827
integer y = 356
integer width = 686
integer height = 400
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_bom202_print"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca) ;

end event

type dw_3 from datawindow within w_bom202i
boolean visible = false
integer x = 2537
integer y = 212
integer width = 2085
integer height = 2228
integer taborder = 80
boolean bringtotop = true
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)

end event

event retrieveend;f_save_to_Excel(this)
end event

type st_1 from statictext within w_bom202i
integer x = 87
integer y = 76
integer width = 279
integer height = 72
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

type em_refdate from editmask within w_bom202i
integer x = 379
integer y = 60
integer width = 457
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####.##"
end type

type gb_1 from groupbox within w_bom202i
integer x = 23
integer width = 4590
integer height = 188
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

