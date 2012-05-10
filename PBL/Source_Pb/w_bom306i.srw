$PBExportHeader$w_bom306i.srw
$PBExportComments$가공관리비 M-BOM 조회(일일결산용)
forward
global type w_bom306i from w_origin_sheet02
end type
type pb_excel from picturebutton within w_bom306i
end type
type uo_1 from uo_plandiv_pdcd within w_bom306i
end type
type st_1 from statictext within w_bom306i
end type
type st_2 from statictext within w_bom306i
end type
type sle_1 from singlelineedit within w_bom306i
end type
type pb_1 from picturebutton within w_bom306i
end type
type dw_bom_print from datawindow within w_bom306i
end type
type tab_1 from tab within w_bom306i
end type
type tabpage_1 from userobject within tab_1
end type
type dw_bom from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_bom dw_bom
end type
type tabpage_2 from userobject within tab_1
end type
type ddlb_srce from dropdownlistbox within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type dw_knockdown from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
ddlb_srce ddlb_srce
st_3 st_3
dw_knockdown dw_knockdown
end type
type tabpage_3 from userobject within tab_1
end type
type dw_partlist_fta from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_partlist_fta dw_partlist_fta
end type
type tab_1 from tab within w_bom306i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type st_4 from statictext within w_bom306i
end type
type rb_pre from radiobutton within w_bom306i
end type
type rb_post from radiobutton within w_bom306i
end type
type st_5 from statictext within w_bom306i
end type
type st_itnm from statictext within w_bom306i
end type
type dw_1 from datawindow within w_bom306i
end type
type gb_1 from groupbox within w_bom306i
end type
end forward

global type w_bom306i from w_origin_sheet02
integer width = 4809
integer height = 3104
string title = "BOM 이력 조회 ( 전체 )"
event ue_postopen ( )
pb_excel pb_excel
uo_1 uo_1
st_1 st_1
st_2 st_2
sle_1 sle_1
pb_1 pb_1
dw_bom_print dw_bom_print
tab_1 tab_1
st_4 st_4
rb_pre rb_pre
rb_post rb_post
st_5 st_5
st_itnm st_itnm
dw_1 dw_1
gb_1 gb_1
end type
global w_bom306i w_bom306i

forward prototypes
public function integer wf_create_fta (ref string arg_message)
end prototypes

event ue_postopen();//dddw ldw_1
//
//dw_1.GetChild('zdate', ldwc)
//ldwc.settransobject(sqlca)
//ldwc.retrieve()
//if ldwc.RowCount() < 1 then
//	ldwc.InsertRow(0)
//end if
end event

public function integer wf_create_fta (ref string arg_message);// * BOM이 존재하면서
// * 제품모델로 BOM113, BOM115에 내역이 존재하지 않는경우에 수동생성
string ls_rtncd, ls_yyyymm, ls_plant, ls_div, ls_pdcd, ls_itno, ls_applygubun
string ls_applydate
int li_count

ls_rtncd 	= uo_1.uf_return()
ls_plant 	= trim(mid(ls_rtncd,1,1))
ls_div   	= trim(mid(ls_rtncd,2,1))
ls_pdcd  	= trim(mid(ls_rtncd,3,2))
ls_itno  	= trim(sle_1.text)
if rb_pre.checked then 
	ls_applygubun = 'A'
else
	ls_applygubun = 'B'
end if

ls_applydate = dw_1.getitemstring(1,"zdate")

select count(*) into :li_count
from pbpdm.bom001 a
where a.pcmcd = :g_s_company AND a.plant = :ls_plant AND
	a.pdvsn = :ls_div AND a.ppitn = :ls_itno AND
	(( a.pedte = ' '  and a.pedtm <= :ls_applydate ) or
	( a.pedte <> ' ' and a.pedtm <= :ls_applydate
						 and a.pedte >= :ls_applydate ))
using sqlca;

if li_count > 0 then
	select pdcd into :ls_pdcd
	from pbinv.inv101
	where comltd = :g_s_company and xplant = :ls_plant and
		div = :ls_div and itno = :ls_itno 
	using sqlca;
else
	arg_message = "원소재품이거나 BOM미등록품입니다."
	return -1
end if

//월간재료비계산(고객사유상 공제분제외) 호출
f_creation_bom_sf(g_s_company,ls_plant,ls_div,ls_itno,ls_applydate,'C')
 
 DECLARE SP_BOM_103 PROCEDURE FOR PBPDM.SP_BOM_103  
		A_COMLTD = :g_s_company,   
		A_PLANT = :ls_plant,   
		A_DVSN = :ls_div,   
		A_PDCD = :ls_pdcd,   
		A_APPLYDATE = :ls_applydate,
		A_CREATEDATE = :g_s_date
 using sqlca;
execute SP_BOM_103;

f_creation_bom_sf(g_s_company,ls_plant,ls_div,ls_itno,ls_applydate,'A')
 DECLARE SP_BOM_104 PROCEDURE FOR PBPDM.SP_BOM_104  
		A_COMLTD = :g_s_company,   
		A_PLANT = :ls_plant,   
		A_DVSN = :ls_div,   
		A_PDCD = :ls_pdcd,   
		A_APPLYDATE = :ls_applydate,
		A_CREATEDATE = :g_s_date 
 using sqlca;
execute SP_BOM_104;

return 0
end function

on w_bom306i.create
int iCurrent
call super::create
this.pb_excel=create pb_excel
this.uo_1=create uo_1
this.st_1=create st_1
this.st_2=create st_2
this.sle_1=create sle_1
this.pb_1=create pb_1
this.dw_bom_print=create dw_bom_print
this.tab_1=create tab_1
this.st_4=create st_4
this.rb_pre=create rb_pre
this.rb_post=create rb_post
this.st_5=create st_5
this.st_itnm=create st_itnm
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_excel
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.dw_bom_print
this.Control[iCurrent+8]=this.tab_1
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.rb_pre
this.Control[iCurrent+11]=this.rb_post
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.st_itnm
this.Control[iCurrent+14]=this.dw_1
this.Control[iCurrent+15]=this.gb_1
end on

on w_bom306i.destroy
call super::destroy
destroy(this.pb_excel)
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.pb_1)
destroy(this.dw_bom_print)
destroy(this.tab_1)
destroy(this.st_4)
destroy(this.rb_pre)
destroy(this.rb_post)
destroy(this.st_5)
destroy(this.st_itnm)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;SetPointer(HourGlass!)
string  ls_plant,ls_div,ls_pdcd,ls_itno,ls_rtncd,ls_srce,ls_applygubun,ls_message,ls_applydate
ls_rtncd 	= uo_1.uf_return()
ls_applydate = dw_1.getitemstring(1,"zdate")

st_itnm.text = mid(f_bom_get_itemname(sle_1.text),1,30)
if tab_1.selectedtab = 1 then
	ls_plant 	= trim(mid(ls_rtncd,1,1)) + '%' 
	ls_div   	= trim(mid(ls_rtncd,2,1)) + '%' 
	ls_pdcd  	= trim(mid(ls_rtncd,3,2)) + '%' 
	ls_itno  	= trim(sle_1.text) + '%'
	if rb_pre.checked then 
		ls_applygubun = 'A'
	else
		ls_applygubun = 'B'
	end if
	tab_1.tabpage_1.dw_bom.reset()
	if tab_1.tabpage_1.dw_bom.retrieve(ls_applydate,ls_plant,ls_div,ls_pdcd,ls_itno,ls_applygubun) < 1 then
		uo_status.st_message.text = f_message("I020")
		pb_excel.enabled  = false
		pb_excel.visible  = false
	else
		uo_status.st_message.text = f_message("I010")
		pb_excel.enabled  = true
		pb_excel.visible  = true
	end if
elseif tab_1.selectedtab = 2 then
	ls_plant 	= trim(mid(ls_rtncd,1,1)) + '%' 
	ls_div   	= trim(mid(ls_rtncd,2,1)) + '%' 
	ls_pdcd  	= trim(mid(ls_rtncd,3,2)) + '%' 
	ls_itno  	= trim(sle_1.text) + '%'
	tab_1.tabpage_2.dw_knockdown.reset()
	Choose Case	tab_1.tabpage_2.ddlb_srce.text
		case	'외자'
			ls_srce	=	'01%'
		case	'내자'
			ls_srce	=	'02%'
		case	'자가'
			ls_srce	=	'03%'
		case	'사급'
			ls_srce	=	'04%'
		case	'타공장이체'
			ls_srce	=	'05%'
		case	'타공장사급'
			ls_srce	=	'06%'			
		case else
			ls_srce	=	'%'
	End Choose		
	if tab_1.tabpage_2.dw_knockdown.retrieve(ls_applydate,ls_plant,ls_div,ls_pdcd,ls_srce,ls_itno) < 1 then
		uo_status.st_message.text = f_message("I020")
		pb_excel.enabled  = false
		pb_excel.visible  = false
	else
		uo_status.st_message.text = f_message("I010")
		pb_excel.enabled  = true
		pb_excel.visible  = true
	end if
elseif tab_1.selectedtab = 3 then
	ls_plant 	= trim(mid(ls_rtncd,1,1))
	ls_div   	= trim(mid(ls_rtncd,2,1))
	ls_pdcd  	= trim(mid(ls_rtncd,3,2))
	ls_itno  	= trim(sle_1.text)
	if rb_pre.checked then 
		ls_applygubun = 'A'
	else
		ls_applygubun = 'B'
	end if
	if f_spacechk(ls_itno) = -1 then
		ls_itno = '%'
	else
		ls_itno = ls_itno + '%'
	end if
	
	tab_1.tabpage_3.dw_partlist_fta.reset()
	tab_1.tabpage_3.dw_partlist_fta.settransobject(sqlca)
	if tab_1.tabpage_3.dw_partlist_fta.retrieve(ls_applydate,ls_plant,ls_div,ls_itno,ls_applygubun) < 1 then
		//생성로직 추가
		if wf_create_fta(ls_message) = -1 then
			uo_status.st_message.text = ls_message
			pb_excel.enabled  = false
			pb_excel.visible  = false
		else
			if tab_1.tabpage_3.dw_partlist_fta.retrieve(ls_applydate,ls_plant,ls_div,ls_itno,ls_applygubun) < 1 then
				uo_status.st_message.text = f_message("I020")
				pb_excel.enabled  = false
				pb_excel.visible  = false
			else
				uo_status.st_message.text = f_message("I010")
				pb_excel.enabled  = true
				pb_excel.visible  = true
			end if
		end if
		//생성로직 끝
	else
		uo_status.st_message.text = f_message("I010")
		pb_excel.enabled  = true
		pb_excel.visible  = true
	end if
end if
	


end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

event ue_print;call super::ue_print;uo_status.st_message.text = ''
if tab_1.selectedtab = 1 then
	SetPointer(HourGlass!)
	string	ls_plant,ls_div,ls_pdcd,ls_itno,ls_rtncd,ls_applydate,ls_applygubun
	
	ls_rtncd 	= uo_1.uf_return()
	ls_plant 	= trim(mid(ls_rtncd,1,1)) + '%' 
	ls_div   	= trim(mid(ls_rtncd,2,1)) + '%' 
	ls_pdcd  	= trim(mid(ls_rtncd,3,2)) + '%' 
	ls_itno  	= trim(sle_1.text) + '%'
	ls_applydate = dw_1.getitemstring(1,"zdate")

	if rb_pre.checked then 
		ls_applygubun = 'A'
	else
		ls_applygubun = 'B'
	end if
	dw_bom_print.reset()
	if dw_bom_print.retrieve(ls_applydate,ls_plant,ls_div,ls_pdcd,ls_itno,string(g_s_date,'@@@@.@@.@@'),ls_applygubun) < 1 then
		uo_status.st_message.text = "출력할 자료가 없습니다"
	else
		uo_status.st_message.text = "출력이 완료되었습니다'"
		dw_bom_print.print()
	end if
elseif tab_1.selectedtab = 2 then
	uo_status.st_message.text = "Knock-Down 정보는 출력 포맷이 없습니다.엑셀로 다운로드 하십시오."
elseif tab_1.selectedtab = 3 then
	uo_status.st_message.text = "원재료명세서(FTA) 정보는 출력 포맷이 없습니다.엑셀로 다운로드 하십시오."
end if


end event

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.insertrow(0)

i_b_print = true
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)
end event

type uo_status from w_origin_sheet02`uo_status within w_bom306i
integer y = 2468
end type

type pb_excel from picturebutton within w_bom306i
boolean visible = false
integer x = 4439
integer y = 40
integer width = 155
integer height = 132
integer taborder = 20
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

event clicked;if tab_1.selectedtab = 1 then
	f_Save_to_Excel_number(tab_1.tabpage_1.dw_bom)
elseif tab_1.selectedtab = 2 then
	f_Save_to_Excel_number(tab_1.tabpage_2.dw_knockdown)
elseif tab_1.selectedtab = 3 then
	f_Save_to_Excel_number(tab_1.tabpage_3.dw_partlist_fta)
end if
end event

type uo_1 from uo_plandiv_pdcd within w_bom306i
integer x = 87
integer y = 40
integer taborder = 60
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

type st_1 from statictext within w_bom306i
integer x = 2560
integer y = 76
integer width = 288
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
string text = "기준일자"
boolean focusrectangle = false
end type

type st_2 from statictext within w_bom306i
integer x = 3374
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

type sle_1 from singlelineedit within w_bom306i
event ue_keydown pbm_keydown
integer x = 3529
integer y = 60
integer width = 594
integer height = 88
integer taborder = 10
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

event modified;st_itnm.text = mid(f_bom_get_itemname(this.text),1,30)
end event

type pb_1 from picturebutton within w_bom306i
integer x = 4137
integer y = 52
integer width = 238
integer height = 108
integer taborder = 70
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

ls_return	= uo_1.uf_return()
ls_div 		= mid(ls_return,2,1)
ls_pdcd  	= mid(ls_return,3,2)
ls_plant 	= mid(ls_return,1,1)
ls_parm 		= ls_plant + ls_div + ls_pdcd
openwithparm(w_bom110u_res_03,ls_parm)

ls_parm 		= message.stringparm
sle_1.text 	= ls_parm
st_itnm.text = mid(f_bom_get_itemname(ls_parm),1,30)

end event

type dw_bom_print from datawindow within w_bom306i
boolean visible = false
integer x = 827
integer y = 356
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_bom306i_print"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca) ;

end event

type tab_1 from tab within w_bom306i
event create ( )
event destroy ( )
integer x = 37
integer y = 336
integer width = 4571
integer height = 2096
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
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
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;if newindex = 1 then
	this.tabpage_1.tabtextcolor = rgb(255,0,0)
	this.tabpage_2.tabtextcolor = rgb(0,0,0)
elseif newindex = 2 then
	this.tabpage_1.tabtextcolor = rgb(0,0,0)
	this.tabpage_2.tabtextcolor = rgb(255,0,0)
else
	this.tabpage_1.tabtextcolor = rgb(0,0,0)
	this.tabpage_2.tabtextcolor = rgb(0,0,0)
end if
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4535
integer height = 1980
long backcolor = 12632256
string text = "Indented-BOM 조회"
long tabtextcolor = 255
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_bom dw_bom
end type

on tabpage_1.create
this.dw_bom=create dw_bom
this.Control[]={this.dw_bom}
end on

on tabpage_1.destroy
destroy(this.dw_bom)
end on

type dw_bom from datawindow within tabpage_1
integer x = 18
integer y = 28
integer width = 4498
integer height = 1936
integer taborder = 80
string dataobject = "d_bom306i_retrieve"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4535
integer height = 1980
long backcolor = 12632256
string text = "Knock-Down조회"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
ddlb_srce ddlb_srce
st_3 st_3
dw_knockdown dw_knockdown
end type

on tabpage_2.create
this.ddlb_srce=create ddlb_srce
this.st_3=create st_3
this.dw_knockdown=create dw_knockdown
this.Control[]={this.ddlb_srce,&
this.st_3,&
this.dw_knockdown}
end on

on tabpage_2.destroy
destroy(this.ddlb_srce)
destroy(this.st_3)
destroy(this.dw_knockdown)
end on

type ddlb_srce from dropdownlistbox within tabpage_2
integer x = 311
integer y = 44
integer width = 375
integer height = 500
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
boolean sorted = false
boolean vscrollbar = true
integer limit = 5
string item[] = {" ","외자","내자","자가","사급","타공장이체","타공장사급"}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within tabpage_2
integer x = 23
integer y = 60
integer width = 283
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
string text = "자재구분"
boolean focusrectangle = false
end type

type dw_knockdown from datawindow within tabpage_2
integer x = 18
integer y = 156
integer width = 4498
integer height = 1812
integer taborder = 90
string dataobject = "d_bom306i_knockdown"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4535
integer height = 1980
boolean enabled = false
long backcolor = 12632256
string text = "원재료명세서(FTA)"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_partlist_fta dw_partlist_fta
end type

on tabpage_3.create
this.dw_partlist_fta=create dw_partlist_fta
this.Control[]={this.dw_partlist_fta}
end on

on tabpage_3.destroy
destroy(this.dw_partlist_fta)
end on

type dw_partlist_fta from datawindow within tabpage_3
integer x = 14
integer y = 24
integer width = 4503
integer height = 1940
integer taborder = 80
string dataobject = "d_bom306i_partlist_fta_allproduct"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_bom306i
integer x = 87
integer y = 196
integer width = 457
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
string text = "고객사유상"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type rb_pre from radiobutton within w_bom306i
integer x = 613
integer y = 200
integer width = 338
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
string text = "공제전"
boolean checked = true
end type

event clicked;tab_1.tabpage_1.dw_bom.reset()
end event

type rb_post from radiobutton within w_bom306i
integer x = 955
integer y = 200
integer width = 338
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
string text = "공제후"
end type

event clicked;tab_1.tabpage_1.dw_bom.reset()
end event

type st_5 from statictext within w_bom306i
integer x = 3049
integer y = 204
integer width = 169
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "품명"
boolean focusrectangle = false
end type

type st_itnm from statictext within w_bom306i
integer x = 3218
integer y = 192
integer width = 1157
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_bom306i
integer x = 2830
integer y = 60
integer width = 471
integer height = 88
integer taborder = 20
boolean bringtotop = true
string dataobject = "dddw_bom306i_select_zdate"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_bom306i
integer x = 23
integer width = 4590
integer height = 316
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

