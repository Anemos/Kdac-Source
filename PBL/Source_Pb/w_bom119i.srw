$PBExportHeader$w_bom119i.srw
forward
global type w_bom119i from w_origin_sheet02
end type
type st_8 from statictext within w_bom119i
end type
type uo_2 from uo_ccyymm_mps within w_bom119i
end type
type st_1 from statictext within w_bom119i
end type
type dw_retrieve from datawindow within w_bom119i
end type
type pb_excel from picturebutton within w_bom119i
end type
type ddlb_choice from dropdownlistbox within w_bom119i
end type
type uo_1 from uo_plandiv_pdcd within w_bom119i
end type
type gb_1 from groupbox within w_bom119i
end type
type str_bomdata_info from structure within w_bom119i
end type
end forward

type str_bomdata_info from structure
	string		it_wkct
	string		it_opcd
	string		it_edtm
	string		it_edte
end type

global type w_bom119i from w_origin_sheet02
string title = "History 조회"
st_8 st_8
uo_2 uo_2
st_1 st_1
dw_retrieve dw_retrieve
pb_excel pb_excel
ddlb_choice ddlb_choice
uo_1 uo_1
gb_1 gb_1
end type
global w_bom119i w_bom119i

type variables
datastore ids_data1[],ids_data2,ids_data3
protected:
string root_nm , i_s_setdate ,i_s_plant[],i_s_div[], li_chk_option
integer i_n_pos,i_l_mid ,i_n_curlevel,i_n_tabindex1,li_chk_level,i_n_first
integer i_n_hold,i_n_wkhold   //재료비계산에서 쓰이는 변수
dec{3} ic_set_pqtym[]      //[a,b] a:레벨 b:자동핸들부여값
dec{6} i_dc_ininv,i_dc_outinv,i_dc_osinv,i_dc_fosinv			//이동평균재료비
dec{6} i_dc_inmasa,i_dc_outmasa,i_dc_osmasa,i_dc_fosmasa		//불출평균재료비
dec{6} i_dc_inucan,i_dc_outucan,i_dc_osucan,i_dc_fosucan		//최종입고재료비
long i_l_cnt


end variables

on w_bom119i.create
int iCurrent
call super::create
this.st_8=create st_8
this.uo_2=create uo_2
this.st_1=create st_1
this.dw_retrieve=create dw_retrieve
this.pb_excel=create pb_excel
this.ddlb_choice=create ddlb_choice
this.uo_1=create uo_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_8
this.Control[iCurrent+2]=this.uo_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_retrieve
this.Control[iCurrent+5]=this.pb_excel
this.Control[iCurrent+6]=this.ddlb_choice
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.gb_1
end on

on w_bom119i.destroy
call super::destroy
destroy(this.st_8)
destroy(this.uo_2)
destroy(this.st_1)
destroy(this.dw_retrieve)
destroy(this.pb_excel)
destroy(this.ddlb_choice)
destroy(this.uo_1)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;string ls_parm,ls_xplant,ls_div,ls_pdcd,ls_date,ls_gubun

ls_parm		=	uo_1.uf_return()
ls_xplant  	= 	mid(ls_parm,1,1)
ls_div		= 	mid(ls_parm,2,1)
ls_pdcd    	= 	mid(ls_parm,3,4)
ls_date    	= 	uo_2.uf_yyyymm()
if	ddlb_choice.text	=	'전체 전개'	then
	ls_gubun	=	'A'
else
	ls_gubun = 	'B'
end if
if	f_spacechk(ls_xplant) = -1 then
	ls_xplant	= 	'%'
end if
if	f_spacechk(ls_div) = -1 then
	ls_div	= 	'%'
end if
if	f_spacechk(ls_pdcd) = -1 then
	ls_pdcd	= 	'%'
end if
dw_retrieve.reset()
if	dw_retrieve.retrieve(ls_gubun,ls_date,ls_xplant,ls_div,ls_pdcd)	>	0	then
	pb_excel.visible		=	true
	pb_excel.enabled	=	true
else
	pb_excel.visible		=	false
	pb_excel.enabled	=	false
end if
	





end event

type uo_status from w_origin_sheet02`uo_status within w_bom119i
end type

type st_8 from statictext within w_bom119i
integer x = 82
integer y = 80
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

type uo_2 from uo_ccyymm_mps within w_bom119i
integer x = 1065
integer y = 64
integer taborder = 30
boolean bringtotop = true
end type

on uo_2.destroy
call uo_ccyymm_mps::destroy
end on

event constructor;call super::constructor;string l_s_date
l_s_date = uf_add_month_mps(mid(g_s_date,1,6),-1)
this.uf_reset(integer(mid(l_s_date,1,4)),integer(mid(l_s_date,5,2)))

end event

type st_1 from statictext within w_bom119i
integer x = 777
integer y = 76
integer width = 270
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

type dw_retrieve from datawindow within w_bom119i
integer x = 46
integer y = 220
integer width = 4247
integer height = 2256
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_bom016_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca) 
end event

type pb_excel from picturebutton within w_bom119i
boolean visible = false
integer x = 4119
integer y = 48
integer width = 160
integer height = 132
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.jpg"
alignment htextalign = left!
end type

event clicked;dw_retrieve.object.fcomcd.visible		=	true
dw_retrieve.object.fcomcd_t.visible	=	true
f_save_to_excel(dw_retrieve)
dw_retrieve.object.fcomcd.visible		=	false
dw_retrieve.object.fcomcd_t.visible	=	false
end event

type ddlb_choice from dropdownlistbox within w_bom119i
integer x = 238
integer y = 60
integer width = 512
integer height = 224
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
boolean sorted = false
string item[] = {"공장별 전개","전체 전개"}
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text	=	"공장별 전개"
end event

type uo_1 from uo_plandiv_pdcd within w_bom119i
integer x = 1641
integer y = 40
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

type gb_1 from groupbox within w_bom119i
integer x = 46
integer width = 4256
integer height = 192
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

