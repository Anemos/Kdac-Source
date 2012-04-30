$PBExportHeader$w_bom204i.srw
$PBExportComments$EPL BOM 품목비교
forward
global type w_bom204i from w_ipis_sheet01
end type
type st_3 from statictext within w_bom204i
end type
type sle_itno from singlelineedit within w_bom204i
end type
type st_4 from statictext within w_bom204i
end type
type ddlb_choice from dropdownlistbox within w_bom204i
end type
type pb_itemfind from picturebutton within w_bom204i
end type
type st_8 from statictext within w_bom204i
end type
type uo_today from uo_today_bom within w_bom204i
end type
type pb_print from picturebutton within w_bom204i
end type
type pb_excel from picturebutton within w_bom204i
end type
type dw_print from datawindow within w_bom204i
end type
type uo_plant from uo_plandiv_bom within w_bom204i
end type
type sle_osinv from singlelineedit within w_bom204i
end type
type st_7 from statictext within w_bom204i
end type
type st_6 from statictext within w_bom204i
end type
type sle_outinv from singlelineedit within w_bom204i
end type
type sle_ininv from singlelineedit within w_bom204i
end type
type st_5 from statictext within w_bom204i
end type
type st_1 from statictext within w_bom204i
end type
type rb_pre from radiobutton within w_bom204i
end type
type rb_post from radiobutton within w_bom204i
end type
type st_2 from statictext within w_bom204i
end type
type st_itnm from statictext within w_bom204i
end type
type dw_bom_indent from datawindow within w_bom204i
end type
type dw_epl_indent from datawindow within w_bom204i
end type
type gb_2 from groupbox within w_bom204i
end type
type gb_3 from groupbox within w_bom204i
end type
type str_bomdata_info from structure within w_bom204i
end type
end forward

type str_bomdata_info from structure
	string		it_wkct
	string		it_opcd
	string		it_edtm
	string		it_edte
end type

global type w_bom204i from w_ipis_sheet01
integer width = 4841
integer height = 3236
string title = "History 조회"
st_3 st_3
sle_itno sle_itno
st_4 st_4
ddlb_choice ddlb_choice
pb_itemfind pb_itemfind
st_8 st_8
uo_today uo_today
pb_print pb_print
pb_excel pb_excel
dw_print dw_print
uo_plant uo_plant
sle_osinv sle_osinv
st_7 st_7
st_6 st_6
sle_outinv sle_outinv
sle_ininv sle_ininv
st_5 st_5
st_1 st_1
rb_pre rb_pre
rb_post rb_post
st_2 st_2
st_itnm st_itnm
dw_bom_indent dw_bom_indent
dw_epl_indent dw_epl_indent
gb_2 gb_2
gb_3 gb_3
end type
global w_bom204i w_bom204i

type variables
decimal{3}	id_dom_moveamount		=	0,id_exp_moveamount	=	0,id_out_moveamount	=	0,id_fos_moveamount	=	0,&
				id_dom_inputamount	=	0,id_exp_inputamount	=	0,id_out_inputamount	=	0,id_fos_inputamount	=	0,&
				id_dom_outamount		=	0,id_exp_outamount	=	0,id_out_outamount	=	0,id_fos_outamount	=	0

end variables

forward prototypes
public subroutine wf_reset ()
end prototypes

public subroutine wf_reset ();dw_bom_indent.reset()
dw_epl_indent.reset()
sle_ininv.text		= 	''
sle_outinv.text	= 	''
sle_osinv.text	= 	''
end subroutine

on w_bom204i.create
int iCurrent
call super::create
this.st_3=create st_3
this.sle_itno=create sle_itno
this.st_4=create st_4
this.ddlb_choice=create ddlb_choice
this.pb_itemfind=create pb_itemfind
this.st_8=create st_8
this.uo_today=create uo_today
this.pb_print=create pb_print
this.pb_excel=create pb_excel
this.dw_print=create dw_print
this.uo_plant=create uo_plant
this.sle_osinv=create sle_osinv
this.st_7=create st_7
this.st_6=create st_6
this.sle_outinv=create sle_outinv
this.sle_ininv=create sle_ininv
this.st_5=create st_5
this.st_1=create st_1
this.rb_pre=create rb_pre
this.rb_post=create rb_post
this.st_2=create st_2
this.st_itnm=create st_itnm
this.dw_bom_indent=create dw_bom_indent
this.dw_epl_indent=create dw_epl_indent
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.sle_itno
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.ddlb_choice
this.Control[iCurrent+5]=this.pb_itemfind
this.Control[iCurrent+6]=this.st_8
this.Control[iCurrent+7]=this.uo_today
this.Control[iCurrent+8]=this.pb_print
this.Control[iCurrent+9]=this.pb_excel
this.Control[iCurrent+10]=this.dw_print
this.Control[iCurrent+11]=this.uo_plant
this.Control[iCurrent+12]=this.sle_osinv
this.Control[iCurrent+13]=this.st_7
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.sle_outinv
this.Control[iCurrent+16]=this.sle_ininv
this.Control[iCurrent+17]=this.st_5
this.Control[iCurrent+18]=this.st_1
this.Control[iCurrent+19]=this.rb_pre
this.Control[iCurrent+20]=this.rb_post
this.Control[iCurrent+21]=this.st_2
this.Control[iCurrent+22]=this.st_itnm
this.Control[iCurrent+23]=this.dw_bom_indent
this.Control[iCurrent+24]=this.dw_epl_indent
this.Control[iCurrent+25]=this.gb_2
this.Control[iCurrent+26]=this.gb_3
end on

on w_bom204i.destroy
call super::destroy
destroy(this.st_3)
destroy(this.sle_itno)
destroy(this.st_4)
destroy(this.ddlb_choice)
destroy(this.pb_itemfind)
destroy(this.st_8)
destroy(this.uo_today)
destroy(this.pb_print)
destroy(this.pb_excel)
destroy(this.dw_print)
destroy(this.uo_plant)
destroy(this.sle_osinv)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.sle_outinv)
destroy(this.sle_ininv)
destroy(this.st_5)
destroy(this.st_1)
destroy(this.rb_pre)
destroy(this.rb_post)
destroy(this.st_2)
destroy(this.st_itnm)
destroy(this.dw_bom_indent)
destroy(this.dw_epl_indent)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;setpointer(HourGlass!)
this.uo_status.st_winid.text 	= this.classname()
this.uo_status.st_kornm.text 	= g_s_kornm
this.uo_status.st_date.text 	= string(g_s_date, "@@@@-@@-@@")
sle_itno.setfocus()
i_b_insert 	= false
i_b_print	= false
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)


end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

event ue_retrieve;call super::ue_retrieve;string  	ls_plant,ls_div,ls_itno,ls_date,ls_mysql
integer 	ln_count

SetPointer(HourGlass!)
ls_plant 	= 	trim(uo_plant.dw_1.getitemstring(1,'xplant'))
ls_div   	= 	trim(uo_plant.dw_1.getitemstring(1,'div'))
ls_itno  	= 	upper(trim(sle_itno.text))
ls_date		=	f_dateedit(uo_today.is_uo_date)
sle_ininv.text		= 	''
sle_outinv.text	= 	''
sle_osinv.text		= 	''
id_dom_moveamount		=	0
id_dom_inputamount	=	0
id_dom_outamount		=	0
id_exp_moveamount		=	0
id_exp_inputamount	=	0	
id_exp_outamount		=	0
id_fos_moveamount		=	0
id_fos_inputamount	=	0
id_fos_outamount		=	0
id_out_moveamount		=	0
id_out_inputamount	=	0
id_out_outamount		=	0

if f_spacechk(ls_itno) = -1 then
	uo_status.st_message.text = f_message("I020")
	sle_itno.setfocus()
	return 0
end if
dw_bom_indent.reset()
dw_epl_indent.reset()

st_itnm.text = mid(f_bom_get_itemname(sle_itno.text),1,30)

if trim(ddlb_choice.text) = "전체 전개" then
	f_creation_bom_sf(g_s_company,ls_plant,ls_div,ls_itno,ls_date,'A')
else
	f_creation_bom_sf(g_s_company,ls_plant,ls_div,ls_itno,ls_date,'C')
end if
if mid(ls_date,1,6) >= mid(g_s_date,1,6) then
	dw_bom_indent.dataobject	=	'd_bom204i_indent_current'
	dw_bom_indent.settransobject(sqlca)
	ln_count = 	dw_bom_indent.retrieve()
else
	dw_bom_indent.dataobject	=	'd_bom204i_indent_history'
	dw_bom_indent.settransobject(sqlca)
	ln_count = 	dw_bom_indent.retrieve(mid(ls_date,1,6))
end if

pb_print.visible		=	false
pb_print.enabled		=	false
if ln_count < 1 then
	pb_excel.visible	=	false
	pb_excel.enabled	=	false
	uo_status.st_message.text 	= f_message("I020")
else
	pb_excel.visible	=	true
	pb_excel.enabled	=	true
	uo_status.st_message.text 	= f_message("I010")
end if


end event

type uo_status from w_ipis_sheet01`uo_status within w_bom204i
end type

type st_3 from statictext within w_bom204i
integer x = 1317
integer y = 52
integer width = 137
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

type sle_itno from singlelineedit within w_bom204i
event ue_slekeydown pbm_keydown
integer x = 1463
integer y = 40
integer width = 512
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
textcase textcase = upper!
integer limit = 15
borderstyle borderstyle = stylelowered!
end type

event modified;st_itnm.text = mid(f_bom_get_itemname(this.text),1,30)
end event

type st_4 from statictext within w_bom204i
integer x = 2327
integer y = 56
integer width = 274
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
string text = "기준일자"
boolean focusrectangle = false
end type

type ddlb_choice from dropdownlistbox within w_bom204i
integer x = 2601
integer y = 140
integer width = 489
integer height = 336
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
string text = "공장별 전개"
boolean sorted = false
string item[] = {"공장별 전개","전체 전개"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;wf_reset()
end event

type pb_itemfind from picturebutton within w_bom204i
integer x = 2002
integer y = 32
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
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string ls_parm, ls_plant,ls_div,ls_rtncd

ls_rtncd 		= uo_plant.uf_return()
ls_plant 		= mid(ls_rtncd,1,1)
ls_div 			= mid(ls_rtncd,2,1)
ls_parm 			= ls_plant + ls_div + '%'
openwithparm(w_bom110u_res_03,ls_parm)
ls_parm 			= message.stringparm
sle_itno.text	= ls_parm
st_itnm.text = mid(f_bom_get_itemname(ls_parm),1,30)
end event

type st_8 from statictext within w_bom204i
integer x = 2327
integer y = 152
integer width = 274
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
string text = "전개구분"
boolean focusrectangle = false
end type

type uo_today from uo_today_bom within w_bom204i
event ue_keydown pbm_keydown
integer x = 2601
integer y = 40
integer width = 489
integer taborder = 70
boolean bringtotop = true
end type

on uo_today.destroy
call uo_today_bom::destroy
end on

event ue_select;call super::ue_select;wf_reset()
end event

type pb_print from picturebutton within w_bom204i
boolean visible = false
integer x = 270
integer y = 144
integer width = 155
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;treeviewitem l_tvi_cur
window 	l_to_open
str_easy	l_str_prt
string  	ls_plant,ls_div,ls_pdcd,ls_itno,ls_date,mod_string,mod_costring
string 	ls_refdate,ls_divnm,ls_itnm,ls_prtdate, ls_comcd
integer 	ln_row,ln_rowcount,ln_currentrow
dec{0}	ldc_total,ldc_total1,ldc_total2

SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."
ls_plant 		= 	trim(uo_plant.dw_1.getitemstring(1,'xplant'))
ls_div   		= 	trim(uo_plant.dw_1.getitemstring(1,'div'))
ls_itno  		= 	upper(trim(sle_itno.text))
SELECT 	"PBINV"."INV101"."PDCD"  INTO :ls_pdcd  	FROM "PBINV"."INV101"  
	WHERE "PBINV"."INV101"."COMLTD" 		= '01'  		AND  
			"PBINV"."INV101"."XPLANT" 		= :ls_plant AND  
			"PBINV"."INV101"."DIV" 			= :ls_div  	AND  
			"PBINV"."INV101"."ITNO"			= :ls_itno    
using sqlca;
ls_pdcd 			= mid(ls_pdcd,1,2)
ls_date			=	f_dateedit(uo_today.is_uo_date)
ls_refdate 		= 	string(mid(ls_date,1,8),"@@@@.@@.@@")
ls_divnm 		= 	f_bom_get_divname(ls_plant,ls_div)
ls_itnm 			=	mid(f_bom_get_itemname(ls_itno),1,30)
ls_prtdate 		= 	string(g_s_date,"@@@@.@@.@@")
mod_costring 	= "refdate_t.text = '" + ls_refdate +"'~tdivnm_t.text = '" + ls_divnm &
						+ "'~tmodelno_t.text = '" + ls_itno + "'~titpdcd_t.text = '" + ls_pdcd &
						+ "'~tprtdate_t.text = '" + ls_prtdate + "'"

dw_print.reset()
dw_print.dataobject = "d_report_indented"
if rb_pre.checked then
	ls_comcd = '공제전 - 가공관리비'
else
	ls_comcd = '공제후 - 가공관리비'
end if
ldc_total	= truncate(id_dom_moveamount,0)  + truncate(id_exp_moveamount,0)  + truncate(id_fos_moveamount,0)
ldc_total1 	= truncate(id_dom_outamount,0) 	+ truncate(id_exp_outamount,0) 	+ truncate(id_fos_outamount,0)
ldc_total2 	= truncate(id_dom_inputamount,0) + truncate(id_exp_inputamount,0) + truncate(id_fos_inputamount,0)
mod_string 	= mod_costring &
				+ "~tinucav_t.text 	= '" + string(truncate(id_dom_moveamount,0),"#,##0") + "'~toutucav_t.text = '" + string(truncate(id_exp_moveamount,0),"#,##0") +"'~t" &
				+ "fosucav_t.text 	= '" + string(truncate(id_fos_moveamount,0),"#,##0") + "'~ttotalucav_t.text = '" &
				+ string(truncate(ldc_total,0),"#,##0") + "'~tosucav_t.text = '" + string(truncate(id_out_moveamount,0),"#,##0") + "'~t" &
				+ "inmasa_t.text 		= '" + string(truncate(id_dom_outamount,0),"#,##0") + "'~toutmasa_t.text = '" + string(truncate(id_exp_outamount,0),"#,##0") +"'~t" &
				+ "fosmasa_t.text 	= '" + string(truncate(id_fos_outamount,0),"#,##0") + "'~ttotalmasa_t.text = '" &
				+ string(truncate(ldc_total1,0),"#,##0") + "'~tosmasa_t.text = '" + string(truncate(id_out_outamount,0),"#,##0") + "'~t" &
				+ "inucan_t.text 		= '" + string(truncate(id_dom_inputamount,0),"#,##0") + "'~toutucan_t.text = '" + string(truncate(id_exp_inputamount,0),"#,##0") +"'~t" &
				+ "fosucan_t.text 	= '" + string(truncate(id_fos_inputamount,0),"#,##0") + "'~ttotalucan_t.text = '" &
				+ string(truncate(ldc_total2,0),"#,##0") + "'~tosucan_t.text = '" + string(truncate(id_out_inputamount,2),"#,##0") + "'~tmodelnm_t.text = '" + ls_itnm + "'" &
				+ "~tcomcd_t.text 	= '" + ls_comcd + "'"
ln_rowcount = dw_bom_indent.rowcount()
for	ln_row	=	1	to	ln_rowcount
	ln_currentrow	= dw_print.insertrow(0)
	dw_print.object.lev[ln_currentrow] 			= right(dw_bom_indent.object.lev[ln_row],6)
	dw_print.object.itemno[ln_currentrow] 		= dw_bom_indent.object.tcitn[ln_row]
//		dw_print.object.itrev[ln_currentrow] 			= dw_bom_indent.object.rev[ln_row]
	dw_print.object.itrev[ln_currentrow] 			= ''
	dw_print.object.itemnm[ln_currentrow] 		= dw_bom_indent.object.itemname[ln_row]
	dw_print.object.itspec[ln_currentrow] 		= dw_bom_indent.object.spec[ln_row]
	dw_print.object.itunmsr[ln_currentrow] 		= dw_bom_indent.object.xunit[ln_row]
	dw_print.object.itpqtym[ln_currentrow] 		= dw_bom_indent.object.tqty1[ln_row]
	dw_print.object.itiumcv[ln_currentrow] 		= dw_bom_indent.object.convqty[ln_row]
	dw_print.object.itprum[ln_currentrow] 		= dw_bom_indent.object.xunit1[ln_row]
	dw_print.object.itclsb[ln_currentrow] 		= dw_bom_indent.object.cls[ln_row]
	dw_print.object.itsrce[ln_currentrow] 		= dw_bom_indent.object.srce[ln_row]
	dw_print.object.itabc[ln_currentrow] 		= dw_bom_indent.object.abccd[ln_row]
	dw_print.object.itimasa[ln_currentrow] 		= dw_bom_indent.object.outdanga[ln_row]
	dw_print.object.itucav[ln_currentrow] 		= dw_bom_indent.object.movedanga[ln_row]
	dw_print.object.itiucan[ln_currentrow] 		= dw_bom_indent.object.inputdanga[ln_row]
	dw_print.object.itwkct[ln_currentrow] 		= dw_bom_indent.object.twkct[ln_row]
	dw_print.object.itopcd[ln_currentrow] 		= dw_bom_indent.object.toption[ln_row]
	dw_print.object.issueamt[ln_currentrow] 	= dw_bom_indent.object.outamount[ln_row]
	dw_print.object.moveamt[ln_currentrow] 	= dw_bom_indent.object.moveamount[ln_row]
	dw_print.object.receiveamt[ln_currentrow] 	= dw_bom_indent.object.inputamount[ln_row]
	if ( dw_bom_indent.object.topchk[ln_row] = '2') or &
				( dw_bom_indent.object.srce[ln_row] = '03')	then
		dw_print.object.itoption[ln_currentrow] = 'X'
	else
		dw_print.object.itoption[ln_currentrow] = ' '
	end if
	
next
			
//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  	= sqlca
l_str_prt.datawindow   	= dw_print
l_str_prt.title 				= "BOM REPORT 화면"
l_str_prt.dwsyntax 		= mod_string
l_str_prt.tag			  	= This.ClassName()
f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""	
return 0
end event

type pb_excel from picturebutton within w_bom204i
boolean visible = false
integer x = 453
integer y = 144
integer width = 155
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_Save_to_Excel_number(dw_bom_indent)
end event

type dw_print from datawindow within w_bom204i
boolean visible = false
integer x = 2267
integer y = 128
integer width = 219
integer height = 96
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_plant from uo_plandiv_bom within w_bom204i
event destroy ( )
integer x = 32
integer y = 20
integer taborder = 50
boolean bringtotop = true
end type

on uo_plant.destroy
call uo_plandiv_bom::destroy
end on

type sle_osinv from singlelineedit within w_bom204i
integer x = 4142
integer y = 164
integer width = 448
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
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type st_7 from statictext within w_bom204i
integer x = 3854
integer y = 176
integer width = 293
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
string text = "사  급(M)"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_bom204i
integer x = 3854
integer y = 108
integer width = 293
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
string text = "외  자(M)"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_outinv from singlelineedit within w_bom204i
integer x = 4142
integer y = 96
integer width = 448
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
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type sle_ininv from singlelineedit within w_bom204i
integer x = 4142
integer y = 28
integer width = 448
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
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type st_5 from statictext within w_bom204i
integer x = 3854
integer y = 32
integer width = 293
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
string text = "내  자(M)"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_bom204i
integer x = 3205
integer y = 44
integer width = 421
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
string text = "고객사유상"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type rb_pre from radiobutton within w_bom204i
integer x = 3205
integer y = 156
integer width = 288
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

event clicked;wf_reset()
end event

type rb_post from radiobutton within w_bom204i
integer x = 3506
integer y = 156
integer width = 302
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

event clicked;wf_reset()
end event

type st_2 from statictext within w_bom204i
integer x = 649
integer y = 164
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

type st_itnm from statictext within w_bom204i
integer x = 818
integer y = 152
integer width = 1422
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

type dw_bom_indent from datawindow within w_bom204i
integer x = 23
integer y = 376
integer width = 2107
integer height = 2032
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_bom204i_indent_current"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;integer 		i
string ls_option, ls_comcd, ls_xplant, ls_div
for	i	=	1	to	rowcount
	if	(trim(this.object.topchk[i]) <> '2' and this.object.srce[i] <> '03') then
		choose case this.object.cls[i]
			case '10'
				if this.object.srce[i] 		= 	'02' or this.object.srce[i] =	'04' then
					if rb_post.checked and this.object.comcd[i] = 'Y' then
						//고객사유상 공제후 로 대상품 제외
					else
						id_dom_moveamount	=	id_dom_moveamount	+	truncate(this.object.moveamount[i],6)					
						id_dom_inputamount	=	id_dom_inputamount	+	truncate(this.object.inputamount[i],6)					
						id_dom_outamount		=	id_dom_outamount		+	truncate(this.object.outamount[i],6)	
					end if
				elseif this.object.srce[i] 	=	'01' then
					if rb_post.checked and this.object.comcd[i] = 'Y' then
						//고객사유상 공제후 로 대상품 제외
					else
						id_exp_moveamount	=	id_exp_moveamount	+	truncate(this.object.moveamount[i],6)					
						id_exp_inputamount		=	id_exp_inputamount	+	truncate(this.object.inputamount[i],6)					
						id_exp_outamount		=	id_exp_outamount		+	truncate(this.object.outamount[i],6)
					end if
				elseif this.object.srce[i] 	= 	'06' then
					if rb_post.checked and this.object.comcd[i] = 'Y' then
						//고객사유상 공제후 로 대상품 제외
					else
						id_fos_moveamount		=	id_fos_moveamount		+	truncate(this.object.moveamount[i],6)					
						id_fos_inputamount		=	id_fos_inputamount		+	truncate(this.object.inputamount[i],6)					
						id_fos_outamount		=	id_fos_outamount		+	truncate(this.object.outamount[i],6)
					end if
				end if
			case '40','50'
				if this.object.srce[i] 		= '04' then
					if rb_post.checked and this.object.comcd[i] = 'Y' then
						//고객사유상 공제후 로 대상품 제외
					else
						id_out_moveamount		=	id_out_moveamount		+	truncate(this.object.moveamount[i],6)					
						id_out_inputamount		=	id_out_inputamount	+	truncate(this.object.inputamount[i],6)					
						id_out_outamount		=	id_out_outamount		+	truncate(this.object.outamount[i],6)
					end if
				end if
		end choose
	else
		if rb_post.checked and this.object.comcd[i] = 'Y' then
			//*** 호환부품번이 고객사유상대상이면서 호환주품번이 대상품이 아닌경우
			//*** 재료비계산에서 대상금액을 제외시킴
			ls_option = this.object.toption[i]
			ls_xplant = this.object.tplnt[i]
			ls_div = this.object.tdvsn[i]
			
			select comcd into :ls_comcd
			from pbinv.inv101
			where comltd = '01' and xplant = :ls_xplant and 
				div = :ls_div and itno = :ls_option
			using sqlca;
			
			if isnull(ls_comcd) then ls_comcd = ''
			if ls_comcd <> 'Y' then
				choose case this.object.cls[i]
					case '10'
						if this.object.srce[i] 		= 	'02' or this.object.srce[i] =	'04' then
								id_dom_moveamount	=	id_dom_moveamount	-	truncate(this.object.moveamount[i],6)					
								id_dom_inputamount	=	id_dom_inputamount	-	truncate(this.object.inputamount[i],6)					
								id_dom_outamount		=	id_dom_outamount		-	truncate(this.object.outamount[i],6)	
						elseif this.object.srce[i] 	=	'01' then
								id_exp_moveamount	=	id_exp_moveamount	-	truncate(this.object.moveamount[i],6)					
								id_exp_inputamount		=	id_exp_inputamount	-	truncate(this.object.inputamount[i],6)					
								id_exp_outamount		=	id_exp_outamount		-	truncate(this.object.outamount[i],6)
						elseif this.object.srce[i] 	= 	'06' then
								id_fos_moveamount		=	id_fos_moveamount		-	truncate(this.object.moveamount[i],6)					
								id_fos_inputamount		=	id_fos_inputamount		-	truncate(this.object.inputamount[i],6)					
								id_fos_outamount		=	id_fos_outamount		-	truncate(this.object.outamount[i],6)
						end if
					case '40','50'
						if this.object.srce[i] 		= '04' then
								id_out_moveamount		=	id_out_moveamount		-	truncate(this.object.moveamount[i],6)					
								id_out_inputamount		=	id_out_inputamount	-	truncate(this.object.inputamount[i],6)					
								id_out_outamount		=	id_out_outamount		-	truncate(this.object.outamount[i],6)
						end if
				end choose
			end if
		end if
	end if
next
sle_ininv.text		= 	string(truncate(id_dom_moveamount,0),"###,###")
sle_outinv.text	= 	string(truncate(id_exp_moveamount,0),"###,###")
sle_osinv.text	= 	string(truncate(id_out_moveamount,0),"###,###")
end event

event clicked;this.selectrow(0,false)
this.selectrow(row,true)
end event

type dw_epl_indent from datawindow within w_bom204i
integer x = 2158
integer y = 380
integer width = 855
integer height = 692
integer taborder = 60
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;this.selectrow(0,false)
this.selectrow(row,true)
end event

type gb_2 from groupbox within w_bom204i
integer x = 9
integer y = 8
integer width = 3141
integer height = 244
integer taborder = 90
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within w_bom204i
integer x = 3159
integer y = 8
integer width = 1445
integer height = 244
integer taborder = 60
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

