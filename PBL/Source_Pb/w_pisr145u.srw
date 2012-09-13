$PBExportHeader$w_pisr145u.srw
$PBExportComments$외주간판 Warning 품번 등록
forward
global type w_pisr145u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr145u
end type
type uo_division from u_pisc_select_division within w_pisr145u
end type
type uo_product from u_pisc_select_productgroup within w_pisr145u
end type
type rb_all from radiobutton within w_pisr145u
end type
type rb_yes from radiobutton within w_pisr145u
end type
type rb_none from radiobutton within w_pisr145u
end type
type dw_pisr145u_01 from u_vi_std_datawindow within w_pisr145u
end type
type gb_1 from groupbox within w_pisr145u
end type
type gb_2 from groupbox within w_pisr145u
end type
end forward

global type w_pisr145u from w_ipis_sheet01
uo_area uo_area
uo_division uo_division
uo_product uo_product
rb_all rb_all
rb_yes rb_yes
rb_none rb_none
dw_pisr145u_01 dw_pisr145u_01
gb_1 gb_1
gb_2 gb_2
end type
global w_pisr145u w_pisr145u

type variables
str_pisr_partkb istr_partkb
end variables

on w_pisr145u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_product=create uo_product
this.rb_all=create rb_all
this.rb_yes=create rb_yes
this.rb_none=create rb_none
this.dw_pisr145u_01=create dw_pisr145u_01
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_product
this.Control[iCurrent+4]=this.rb_all
this.Control[iCurrent+5]=this.rb_yes
this.Control[iCurrent+6]=this.rb_none
this.Control[iCurrent+7]=this.dw_pisr145u_01
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
end on

on w_pisr145u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_product)
destroy(this.rb_all)
destroy(this.rb_yes)
destroy(this.rb_none)
destroy(this.dw_pisr145u_01)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisr145u_01.Width = newwidth 	- ( dw_pisr145u_01.x + ls_gap * 2 )
dw_pisr145u_01.Height= newheight - ( dw_pisr145u_01.y + ls_status )
end event

event open;call super::open;dw_pisr145u_01.settransobject(sqlpis)
end event

event ue_postopen;call super::ue_postopen;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
f_pisc_retrieve_dddw_productgroup(uo_product.dw_1,uo_area.is_uo_areacode, &
	uo_division.is_uo_divisioncode,'%',true,uo_product.is_uo_productgroup, &
	uo_product.is_uo_productgroupname)
	
rb_all.checked = true
end event

event ue_retrieve;call super::ue_retrieve;long ll_row
string ls_chk

dw_pisr145u_01.SetRedraw(False)
dw_pisr145u_01.SetTransObject(sqlpis)

if rb_none.checked then
	ls_chk = 'C'
elseif rb_yes.checked then
	ls_chk = 'B'
else
	ls_chk = 'A'
end if
ll_Row = dw_pisr145u_01.Retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
	uo_product.is_uo_productgroup, ls_chk )
dw_pisr145u_01.SetRedraw(True)
end event

event ue_save;call super::ue_save;long ll_rowcnt, ll_cnt
string ls_message, ls_gubun, ls_areacode, ls_divisioncode, ls_itemcode

dw_pisr145u_01.accepttext()
ll_rowcnt = dw_pisr145u_01.rowcount()

setpointer(hourglass!)
sqlpis.Autocommit = False

DECLARE up_truncate PROCEDURE FOR sp_pisi_truncate_table  
         @ps_table = 'tpartwarningno'  using sqlpis;

Execute up_truncate;

if sqlpis.sqlcode < 0 then
	ls_message = "Truncate Error"
	goto RollBack_
end if

for ll_cnt = 1 to ll_rowcnt
	ls_gubun = dw_pisr145u_01.getitemstring(ll_cnt,'gubun')
	if ls_gubun = 'Y' then
		ls_areacode = dw_pisr145u_01.getitemstring(ll_cnt,'areacode')
		ls_divisioncode = dw_pisr145u_01.getitemstring(ll_cnt,'divisioncode')
		ls_itemcode = dw_pisr145u_01.getitemstring(ll_cnt,'itemcode')
		INSERT INTO TPARTWARNINGNO  
      ( AreaCode, DivisionCode, ItemCode, LastEmp, LastDate )  
  		VALUES ( :ls_areacode, :ls_divisioncode, :ls_itemcode, :g_s_empno, getdate() )
		using sqlpis;
		
		if sqlpis.sqlcode <> 0 then
			ls_message = "Insert Error"
			goto RollBack_
		end if
	end if
next

Commit using sqlpis;
sqlpis.AutoCommit = True

uo_status.st_message.text = "저장되었습니다."
return 0

RollBack_:
Rollback using sqlpis;
sqlpis.AutoCommit = True

Messagebox("경고","저장시에 에러가 발생하였습니다." + ls_message)

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr145u
end type

type uo_area from u_pisc_select_area within w_pisr145u
integer x = 91
integer y = 52
integer taborder = 20
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;istr_partkb.areacode = is_uo_areacode

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
istr_partkb.divcode = uo_division.is_uo_divisioncode

dw_pisr145u_01.Reset()
end event

type uo_division from u_pisc_select_division within w_pisr145u
integer x = 640
integer y = 52
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;istr_partkb.divcode = is_uo_divisioncode

dw_pisr145u_01.Reset()

f_pisc_retrieve_dddw_productgroup(uo_product.dw_1,uo_area.is_uo_areacode, &
	uo_division.is_uo_divisioncode,'%',true,uo_product.is_uo_productgroup, &
	uo_product.is_uo_productgroupname)
end event

type uo_product from u_pisc_select_productgroup within w_pisr145u
integer x = 1257
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

on uo_product.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;call super::ue_select;dw_pisr145u_01.reset()
end event

type rb_all from radiobutton within w_pisr145u
integer x = 2290
integer y = 64
integer width = 247
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "전체"
end type

type rb_yes from radiobutton within w_pisr145u
integer x = 2569
integer y = 64
integer width = 247
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "대상"
end type

type rb_none from radiobutton within w_pisr145u
integer x = 2848
integer y = 64
integer width = 306
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "비대상"
end type

type dw_pisr145u_01 from u_vi_std_datawindow within w_pisr145u
integer x = 32
integer y = 176
integer width = 3122
integer height = 1680
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisr145u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event buttonclicked;call super::buttonclicked;string ls_colname
long ll_rowcnt, ll_cnt
ls_colname = dwo.name

if ls_colname = 'b_none' then
	ll_rowcnt = This.rowcount()
	for ll_cnt = 1 to ll_rowcnt
		This.setitem(ll_cnt,'gubun','Y')
	next
	This.object.b_none.visible = False
	This.object.b_yes.visible = True
elseif ls_colname = 'b_yes' then
	ll_rowcnt = This.rowcount()
	for ll_cnt = 1 to ll_rowcnt
		This.setitem(ll_cnt,'gubun','N')
	next
	This.object.b_none.visible = True
	This.object.b_yes.visible = False
end if
end event

type gb_1 from groupbox within w_pisr145u
integer x = 32
integer width = 2181
integer height = 156
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisr145u
integer x = 2231
integer width = 933
integer height = 156
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

