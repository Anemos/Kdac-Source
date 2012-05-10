$PBExportHeader$w_bpm421i.srw
$PBExportComments$사업계획 BOM 조회
forward
global type w_bpm421i from w_ipis_sheet01
end type
type uo_1 from uo_plandiv_pdcd within w_bpm421i
end type
type st_2 from statictext within w_bpm421i
end type
type sle_1 from singlelineedit within w_bpm421i
end type
type dw_bpm421i_01 from datawindow within w_bpm421i
end type
type uo_2 from uo_ccyy_mps within w_bpm421i
end type
type st_1 from statictext within w_bpm421i
end type
type ddlb_gubun from dropdownlistbox within w_bpm421i
end type
type pb_down from picturebutton within w_bpm421i
end type
type uo_3 from u_bpm_select_arev within w_bpm421i
end type
type st_3 from statictext within w_bpm421i
end type
type ddlb_divcode from dropdownlistbox within w_bpm421i
end type
type st_4 from statictext within w_bpm421i
end type
type tab_work from tab within w_bpm421i
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tab_work from tab within w_bpm421i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_bpm421i_02 from datawindow within w_bpm421i
end type
type dw_down from datawindow within w_bpm421i
end type
type dw_report from datawindow within w_bpm421i
end type
type gb_1 from groupbox within w_bpm421i
end type
end forward

global type w_bpm421i from w_ipis_sheet01
integer width = 4855
integer height = 3208
uo_1 uo_1
st_2 st_2
sle_1 sle_1
dw_bpm421i_01 dw_bpm421i_01
uo_2 uo_2
st_1 st_1
ddlb_gubun ddlb_gubun
pb_down pb_down
uo_3 uo_3
st_3 st_3
ddlb_divcode ddlb_divcode
st_4 st_4
tab_work tab_work
dw_bpm421i_02 dw_bpm421i_02
dw_down dw_down
dw_report dw_report
gb_1 gb_1
end type
global w_bpm421i w_bpm421i

on w_bpm421i.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.st_2=create st_2
this.sle_1=create sle_1
this.dw_bpm421i_01=create dw_bpm421i_01
this.uo_2=create uo_2
this.st_1=create st_1
this.ddlb_gubun=create ddlb_gubun
this.pb_down=create pb_down
this.uo_3=create uo_3
this.st_3=create st_3
this.ddlb_divcode=create ddlb_divcode
this.st_4=create st_4
this.tab_work=create tab_work
this.dw_bpm421i_02=create dw_bpm421i_02
this.dw_down=create dw_down
this.dw_report=create dw_report
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.dw_bpm421i_01
this.Control[iCurrent+5]=this.uo_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.ddlb_gubun
this.Control[iCurrent+8]=this.pb_down
this.Control[iCurrent+9]=this.uo_3
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.ddlb_divcode
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.tab_work
this.Control[iCurrent+14]=this.dw_bpm421i_02
this.Control[iCurrent+15]=this.dw_down
this.Control[iCurrent+16]=this.dw_report
this.Control[iCurrent+17]=this.gb_1
end on

on w_bpm421i.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.dw_bpm421i_01)
destroy(this.uo_2)
destroy(this.st_1)
destroy(this.ddlb_gubun)
destroy(this.pb_down)
destroy(this.uo_3)
destroy(this.st_3)
destroy(this.ddlb_divcode)
destroy(this.st_4)
destroy(this.tab_work)
destroy(this.dw_bpm421i_02)
destroy(this.dw_down)
destroy(this.dw_report)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

tab_work.Width = newwidth - ( tab_work.x + 20 )
dw_bpm421i_01.Width = newwidth	- (ls_gap * 5)
dw_bpm421i_01.Height= newheight - (dw_bpm421i_01.y + ls_status)

dw_bpm421i_02.x = dw_bpm421i_01.x
dw_bpm421i_02.y = dw_bpm421i_01.y
dw_bpm421i_02.Width = dw_bpm421i_01.Width
dw_bpm421i_02.Height= dw_bpm421i_01.Height
end event

event ue_retrieve;call super::ue_retrieve;SetPointer(HourGlass!)

string  ls_plant,ls_div,ls_pdcd,ls_itno,ls_rtncd,ls_year,ls_gubun = 'D'
string  ls_divcode,ls_expcode,ls_revno

ls_rtncd 	= uo_1.uf_return()
ls_plant 	= trim(mid(ls_rtncd,1,1)) + '%' 
ls_div   	= trim(mid(ls_rtncd,2,1)) + '%' 
ls_pdcd  	= trim(mid(ls_rtncd,3,2)) + '%' 
ls_itno  	= trim(sle_1.text) + '%'
ls_year  	= uo_2.uf_return()
if ddlb_gubun.text	=	'수출(E)'	then
	ls_gubun = 'E'
else
	ls_gubun = 'D'
end if

ls_revno = uo_3.is_uo_revno

if ddlb_divcode.text = '배분전' then
	ls_divcode = 'B'
	ls_expcode = 'B'
else
	ls_divcode = 'A'
	ls_expcode = 'D'
end if

choose case tab_work.selectedtab
	case 1
		dw_bpm421i_01.reset()
		if dw_bpm421i_01.retrieve(ls_gubun,ls_year,ls_revno,ls_divcode,ls_plant,ls_div,ls_pdcd,ls_itno) < 1 then
			uo_status.st_message.text = f_message("I020")
		else
			uo_status.st_message.text = f_message("I010")
		end if
	case 2
		dw_bpm421i_02.reset()
		if dw_bpm421i_02.retrieve(ls_gubun,ls_year,ls_revno,ls_divcode,ls_plant,ls_div,ls_pdcd,ls_itno) < 1 then
			uo_status.st_message.text = f_message("I020")
		else
			uo_status.st_message.text = f_message("I010")
		end if
end choose

return 0


end event

event ue_postopen;call super::ue_postopen;string ls_refyear, ls_message, ls_revno, ls_chkrevno

dw_bpm421i_01.settransobject(sqlca)
dw_bpm421i_02.settransobject(sqlca)

ls_message = right(message.stringparm,6)
ls_revno = mid(ls_message,1,2)
ls_refyear = mid(ls_message,3,4)

SELECT REVNO INTO :ls_chkrevno
FROM PBBPM.BPM519
WHERE COMLTD = '01' AND XYEAR = :ls_refyear AND REVNO = :ls_revno
ORDER BY XYEAR DESC, REVNO DESC, SEQNO ASC
FETCH FIRST 1 ROW ONLY
using sqlca;

if f_spacechk(ls_chkrevno) = -1 then
	SELECT XYEAR, REVNO INTO :ls_refyear,:ls_revno
	FROM PBBPM.BPM519
	WHERE COMLTD = '01'
	ORDER BY XYEAR DESC, REVNO DESC, SEQNO ASC
	FETCH FIRST 1 ROW ONLY
	using sqlca;
	
	uo_2.uf_reset(integer(mid(f_relativedate(mid(g_s_date,1,4) + '1231',1),1,4)))
	ls_revno = '%'
else
	uo_2.uf_reset(integer(ls_refyear))
end if

ddlb_divcode.text = '배분후'

f_bpm_retrieve_dddw_arev(uo_3.dw_1, &
										uo_2.uf_return(), &
										ls_revno, &
										False, &
										uo_3.is_uo_revno, &
										uo_3.is_uo_refyear )
										
uo_3.Triggerevent('ue_select')
end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

event ue_print;call super::ue_print;integer l_n_rowcnt, i
string mod_string, ls_prtdate

window 	l_to_open
str_easy l_str_prt

								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

string  ls_plant,ls_div,ls_pdcd,ls_itno,ls_rtncd,ls_year,ls_gubun = 'D'
string  ls_divcode,ls_expcode,ls_revno

ls_rtncd 	= uo_1.uf_return()
ls_plant 	= trim(mid(ls_rtncd,1,1)) + '%' 
ls_div   	= trim(mid(ls_rtncd,2,1)) + '%' 
ls_pdcd  	= trim(mid(ls_rtncd,3,2)) + '%' 
ls_itno  	= trim(sle_1.text) + '%'
ls_year  	= uo_2.uf_return()
if ddlb_gubun.text	=	'수출(E)'	then
	ls_gubun = 'E'
else
	ls_gubun = 'D'
end if

ls_revno = uo_3.is_uo_revno

if ddlb_divcode.text = '배분전' then
	ls_divcode = 'B'
	ls_expcode = 'B'
else
	ls_divcode = 'A'
	ls_expcode = 'D'
end if

choose case tab_work.selectedtab
	case 1
		dw_report.dataobject = 'd_bpm421i_02_print'
		dw_report.settransobject(sqlca)
	case 2
		dw_report.dataobject = 'd_bpm421i_01_print'
		dw_report.settransobject(sqlca)
end choose

dw_report.reset()
if dw_report.retrieve(ls_gubun,ls_year,ls_revno,ls_divcode,ls_plant,ls_div,ls_pdcd,ls_itno,g_s_date) < 1 then
	uo_status.st_message.text = "인쇄할 자료가 없습니다."
	return 0
end if

ls_prtdate = mid(g_s_date,1,4) + '.' + mid(g_s_date,5,2) + '.' + mid(g_s_date,7,2)
mod_string =  "prtdate_t.text = '" + ls_prtdate + "'"	

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax = mod_string
l_str_prt.title = "사업계획 BOM내역조회"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0

end event

type uo_status from w_ipis_sheet01`uo_status within w_bpm421i
integer x = 18
integer y = 2464
integer height = 88
end type

type uo_1 from uo_plandiv_pdcd within w_bpm421i
event destroy ( )
integer x = 73
integer y = 192
integer taborder = 90
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

type st_2 from statictext within w_bpm421i
integer x = 2592
integer y = 216
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

type sle_1 from singlelineedit within w_bpm421i
event ue_keydown pbm_keydown
integer x = 2747
integer y = 200
integer width = 494
integer height = 88
integer taborder = 40
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

type dw_bpm421i_01 from datawindow within w_bpm421i
integer x = 23
integer y = 504
integer width = 1883
integer height = 1932
integer taborder = 50
boolean bringtotop = true
string title = "가공관리비"
string dataobject = "d_bpm421i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca) ;
end event

type uo_2 from uo_ccyy_mps within w_bpm421i
event destroy ( )
integer x = 370
integer y = 60
integer taborder = 50
boolean bringtotop = true
end type

on uo_2.destroy
call uo_ccyy_mps::destroy
end on

event ue_modify;call super::ue_modify;f_bpm_retrieve_dddw_arev(uo_3.dw_1, &
										uo_2.uf_return(), &
										'%', &
										False, &
										uo_3.is_uo_revno, &
										uo_3.is_uo_refyear )
										
uo_3.Triggerevent('ue_select')
end event

type st_1 from statictext within w_bpm421i
integer x = 3291
integer y = 220
integer width = 155
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
string text = "구분"
boolean focusrectangle = false
end type

type ddlb_gubun from dropdownlistbox within w_bpm421i
integer x = 3474
integer y = 204
integer width = 366
integer height = 324
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
boolean sorted = false
string item[] = {"내수(D)","수출(E)"}
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text = '내수(D)'
end event

type pb_down from picturebutton within w_bpm421i
integer x = 3950
integer y = 168
integer width = 247
integer height = 128
integer taborder = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;
choose case tab_work.selectedtab
	case 1
		dw_down.dataobject = 'd_bpm421i_02_down'
		dw_bpm421i_01.sharedata(dw_down)
	case 2
		dw_down.dataobject = 'd_bpm421i_01_down'
		dw_bpm421i_02.sharedata(dw_down)
end choose

f_Save_to_Excel_number(dw_down)

return 0
end event

type uo_3 from u_bpm_select_arev within w_bpm421i
event destroy ( )
integer x = 814
integer y = 64
integer height = 88
integer taborder = 40
boolean bringtotop = true
end type

on uo_3.destroy
call u_bpm_select_arev::destroy
end on

type st_3 from statictext within w_bpm421i
integer x = 1783
integer y = 72
integer width = 329
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "배부기준:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_divcode from dropdownlistbox within w_bpm421i
integer x = 2117
integer y = 56
integer width = 439
integer height = 324
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string item[] = {"배분전","배분후"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_bpm421i
integer x = 64
integer y = 68
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년도"
boolean focusrectangle = false
end type

type tab_work from tab within w_bpm421i
event create ( )
event destroy ( )
integer x = 23
integer y = 368
integer width = 4283
integer height = 124
integer taborder = 70
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_work.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_work.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;Choose Case newindex 
	Case 1
		dw_bpm421i_01.Visible = True 
		dw_bpm421i_02.Visible = False 
	Case 2
		dw_bpm421i_01.Visible = False 
		dw_bpm421i_02.Visible = True 
End Choose 
end event

type tabpage_1 from userobject within tab_work
integer x = 18
integer y = 112
integer width = 4247
integer height = -4
long backcolor = 12632256
string text = "가공관리비적용 재료비"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_work
integer x = 18
integer y = 112
integer width = 4247
integer height = -4
long backcolor = 12632256
string text = "완성품단가적용(CHECK)"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type dw_bpm421i_02 from datawindow within w_bpm421i
integer x = 1943
integer y = 504
integer width = 1719
integer height = 1932
integer taborder = 60
boolean bringtotop = true
string title = "완성품단가"
string dataobject = "d_bpm421i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_down from datawindow within w_bpm421i
boolean visible = false
integer x = 3712
integer y = 220
integer width = 686
integer height = 400
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_bpm421i_01_down"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from datawindow within w_bpm421i
boolean visible = false
integer x = 3698
integer y = 564
integer width = 603
integer height = 400
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_bpm421i_02_print"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_bpm421i
integer x = 23
integer width = 4215
integer height = 336
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

