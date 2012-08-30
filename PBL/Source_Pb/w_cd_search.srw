$PBExportHeader$w_cd_search.srw
$PBExportComments$코드,코드명 참조
forward
global type w_cd_search from window
end type
type cb_4 from commandbutton within w_cd_search
end type
type st_msg from statictext within w_cd_search
end type
type cb_3 from commandbutton within w_cd_search
end type
type cb_2 from commandbutton within w_cd_search
end type
type cb_1 from commandbutton within w_cd_search
end type
type dw_1 from datawindow within w_cd_search
end type
type st_1 from statictext within w_cd_search
end type
type sle_nm from singlelineedit within w_cd_search
end type
type gb_1 from groupbox within w_cd_search
end type
end forward

global type w_cd_search from window
integer x = 640
integer y = 524
integer width = 2583
integer height = 1992
boolean titlebar = true
string title = "코드찾기"
windowtype windowtype = response!
long backcolor = 79216776
event ue_retrieve ( )
cb_4 cb_4
st_msg st_msg
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
st_1 st_1
sle_nm sle_nm
gb_1 gb_1
end type
global w_cd_search w_cd_search

type variables
string	is_class		//기타코드구분
string	is_col_nm		//컬럼명
string	is_where		//조건절
string	is_head_nm	//컬럼헤드

long il_check

string is_sort_updown
end variables

event ue_retrieve();string old_select,new_select,where_clause,ls_sle_nm,ls_where
long ll_row
int li_pos

st_msg.text = ""

//조회조건 결정
If IsNull(sle_nm.text) or trim(sle_nm.text) = "" Then
	ls_sle_nm = ' '
Else
	ls_sle_nm = sle_nm.text
End if

//새로운 조회조건을 만든다.
old_select = dw_1.GetSQLSelect( )
li_pos = pos(UPPER(old_select),'WHERE',1)

ls_where = is_where

if trim(is_where) <> "" then
	ls_where = ls_where + ' AND '
end if
	
If li_pos > 0 Then
	ls_where = ' AND ' + ls_where
Else
	ls_where = 'WHERE ' + ls_where
End if

if il_check = 1 or il_check = 2 or il_check = 3 or il_check = 4 or il_check = 6 then
	where_clause =   ls_where + " (("+is_col_nm+" LIKE '%"+ls_sle_nm+"%' ) or " + &
									" (' ' = '"+ls_sle_nm+"')) and area_code='"+gs_kmarea+"' and factory_code='"+gs_kmdivision+"'"
elseif il_check = 5 then
	where_clause =   ls_where + " (("+is_col_nm+" LIKE '%"+ls_sle_nm+"%' ) or " + &
									" (' ' = '"+ls_sle_nm+"')) and (area_code='"+gs_kmarea+"' or area_code='X')  and (factory_code='"+gs_kmdivision+"' or factory_code='X')"
//	where_clause = ls_where + " (area_code='"+gs_kmarea+"' or area_code='X')  and (factory_code='"+gs_kmdivision+"' or area_code='X')"
else
	where_clause =   ls_where + " (("+is_col_nm+" LIKE '%"+ls_sle_nm+"%' ) or " + &
									" (' ' = '"+ls_sle_nm+"')) "
end if

// Add the new where clause to old_select
new_select = old_select + ' ' + where_clause

dw_1.SetSQLSelect(new_select)

if il_check = 1 or il_check = 2 or il_check = 3 or il_check = 4 then
	ll_row = dw_1.retrieve()
else
	ll_row = dw_1.retrieve()
end if

//원래의 sql문장을 복원
dw_1.SetSQLSelect(old_select)

if  ll_row > 0 then
   dw_1.Sort()
else
	st_msg.text =  "해당자료가 없습니다...!!"
	SetFocus(sle_nm)
	return
end if

dw_1.SelectRow(0,False)
dw_1.SelectRow(dw_1.GetRow(),True)
dw_1.setfocus()
end event

event open;int li_chk
string ls_cd,Col_nm
str_parm get_str_parm

//중앙에 Open
f_win_center(this)

//Argument Setting
get_str_parm = message.powerobjectParm

if get_str_parm.s_parm[1] = 'd_lookup_part' then
	il_check =1
elseif get_str_parm.s_parm[1] = 'd_lookup_equip' then
	il_check =2
elseif get_str_parm.s_parm[1] = 'd_lookup_emp' then	
	il_check =3
elseif get_str_parm.s_parm[1] = 'd_lookup_cc' then	
	il_check =4
elseif get_str_parm.s_parm[1] = 'd_lookup_cc_a' or &
			get_str_parm.s_parm[1] = 'd_lookup_cc_inv' then	
	il_check =5
elseif get_str_parm.s_parm[1] = 'd_lookup_line' then	
	il_check =6
elseif get_str_parm.s_parm[1] = 'd_lookup_comp' or &
			get_str_parm.s_parm[1] = 'd_lookup_comp_div' then	
	il_check =0
elseif get_str_parm.s_parm[1] = 'd_lookup_dept' then	
	il_check =0
else
	il_check =1
end if

dw_1.dataobject = get_str_parm.s_parm[1]
is_where 		 = get_str_parm.s_parm[2]

dw_1.SetTransObject(sqlcmms);

ls_cd = dw_1.Describe("#2" +  ".Tag")

//제목 및 검색조건
st_1.text = ls_cd
//this.title = ls_cd + " 검색"
is_col_nm = dw_1.Describe("#2" +  ".dbName")

//조회
this.triggerevent("ue_retrieve")
sle_nm.setfocus()
end event

on w_cd_search.create
this.cb_4=create cb_4
this.st_msg=create st_msg
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.st_1=create st_1
this.sle_nm=create sle_nm
this.gb_1=create gb_1
this.Control[]={this.cb_4,&
this.st_msg,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.st_1,&
this.sle_nm,&
this.gb_1}
end on

on w_cd_search.destroy
destroy(this.cb_4)
destroy(this.st_msg)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.sle_nm)
destroy(this.gb_1)
end on

type cb_4 from commandbutton within w_cd_search
integer x = 1888
integer y = 1708
integer width = 325
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
string text = "출력"
end type

event clicked;long li_cur
str_print lstr_print

//set instance variable lstr_print(structure)
lstr_print.dw_prt = dw_1 	// assign DW
lstr_print.s_success = '0' // initialize success flag
lstr_print.s_document = 'datawindow' // assign window title to document name

// open w_print and send message to w_print
//openwithparm(w_set_print,dw_1)
openwithparm(w_set_print, lstr_print)
end event

type st_msg from statictext within w_cd_search
integer x = 9
integer y = 1812
integer width = 2542
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "선택하세요..."
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_cd_search
integer x = 2213
integer y = 1708
integer width = 325
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
string text = "종료"
boolean cancel = true
end type

event clicked;str_parm s_parm

s_parm.s_parm[1]  = ""
s_parm.s_parm[2]  = ""
closewithreturn(parent,s_parm)

end event

type cb_2 from commandbutton within w_cd_search
integer x = 1563
integer y = 1708
integer width = 325
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
string text = "선택"
end type

event clicked;int ii, li_ColNbr
long ll_row
Decimal ld_data
String ls_col_type, ls_col_nm
str_parm s_parm

ll_row = dw_1.getrow()
If ll_row < 1 Then Return

li_colnbr = Integer(dw_1.object.datawindow.column.count)
For ii = 1 To li_colnbr
	ls_col_type = dw_1.Describe('#'+String(ii)+".ColType")
	If ls_col_type = "number" or ls_col_type = "long" or left(ls_col_type,7) = "decimal" OR left(ls_col_type,7) = "real"  then
	   s_parm.s_parm[ii] = String(dw_1.getitemnumber(ll_row,ii))
	Elseif ls_col_type = 'datetime' then
		s_parm.s_parm[ii] = string(dw_1.GetItemdatetime(ll_row,ii))
	Else	
		s_parm.s_parm[ii]  = trim(dw_1.GetItemString(ll_row,ii))
	End IF
Next
closewithreturn(parent,s_parm)

end event

type cb_1 from commandbutton within w_cd_search
integer x = 2194
integer y = 40
integer width = 325
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
string text = "보기"
end type

event clicked;parent.triggerevent("ue_retrieve")

end event

type dw_1 from datawindow within w_cd_search
event keydown pbm_dwnkey
event ue_lbuttonup pbm_lbuttonup
integer x = 23
integer y = 152
integer width = 2510
integer height = 1544
integer taborder = 30
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event keydown;str_parm  s_parm

if KeyDown(KeyEnter!) then
	cb_2.triggerevent(clicked!)
elseif	KeyDown(KeyEscape!) then
	cb_3.triggerevent(clicked!)
end if
end event

event ue_lbuttonup;this.Modify(is_head_nm + ".Border = 6")

end event

event clicked;dw_1.setredraw(false)

if row < 1 then
	is_head_nm = dwo.name	//Head 명
   if f_getobjectpoint_head(dw_1,is_col_nm) = 1 then

		st_1.text = dw_1.Describe(is_head_nm + ".text")		
//	   st_1.text = dw_1.Describe(is_col_nm + ".Tag")		
		is_col_nm = dw_1.Describe(is_col_nm + ".dbName")
		
		If is_sort_updown = ' a' then
			is_sort_updown = ' d' 
		elseif is_sort_updown = ' d' then
			is_sort_updown = ' a'
		else
			is_sort_updown = ' a'
		End If	
		//f_dw_sort(This, is_sort_updown)
   	//f_dw_sort(dw_1,is_col_nm)
		f_dw_sort(This, is_col_nm + is_sort_updown)
		

		
   end if
end if

if row > 0  then
	this.SelectRow(0, FALSE)
   this.SelectRow(row, TRUE)
end if
dw_1.setredraw(true)	


end event

event doubleclicked;Parent.cb_2.TriggerEvent(Clicked!)
end event

event losefocus;dw_1.SelectRow(0,False)
end event

event rowfocuschanged;// 방향키에 따라서 Row가 선택된다.
this.selectrow(0,false)
this.selectrow(getrow(),true)
end event

type st_1 from statictext within w_cd_search
integer x = 32
integer y = 52
integer width = 571
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long backcolor = 79216776
boolean enabled = false
string text = "조회내용"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_nm from singlelineedit within w_cd_search
event keydwn pbm_keydown
integer x = 608
integer y = 40
integer width = 1577
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long backcolor = 27699859
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event keydwn;if key = keyenter! then
	parent.triggerevent("ue_retrieve")
end if
end event

type gb_1 from groupbox within w_cd_search
integer x = 23
integer width = 2510
integer height = 144
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long backcolor = 79216776
end type

