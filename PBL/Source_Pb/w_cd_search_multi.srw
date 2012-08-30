$PBExportHeader$w_cd_search_multi.srw
$PBExportComments$조건검색 및 선택(다중선택)
forward
global type w_cd_search_multi from window
end type
type cb_add from commandbutton within w_cd_search_multi
end type
type cb_search from commandbutton within w_cd_search_multi
end type
type cb_print from commandbutton within w_cd_search_multi
end type
type dw_1 from datawindow within w_cd_search_multi
end type
type st_message from statictext within w_cd_search_multi
end type
type cb_retrieve from commandbutton within w_cd_search_multi
end type
type sle_1 from singlelineedit within w_cd_search_multi
end type
type st_2 from statictext within w_cd_search_multi
end type
type cb_2 from commandbutton within w_cd_search_multi
end type
type cb_select from commandbutton within w_cd_search_multi
end type
type gb_1 from groupbox within w_cd_search_multi
end type
end forward

global type w_cd_search_multi from window
integer x = 631
integer y = 368
integer width = 2775
integer height = 2028
boolean titlebar = true
string title = "자료검색(다중)"
windowtype windowtype = response!
long backcolor = 79741120
cb_add cb_add
cb_search cb_search
cb_print cb_print
dw_1 dw_1
st_message st_message
cb_retrieve cb_retrieve
sle_1 sle_1
st_2 st_2
cb_2 cb_2
cb_select cb_select
gb_1 gb_1
end type
global w_cd_search_multi w_cd_search_multi

type variables
string is_arg, is_col, is_col_nm

long il_check
end variables

forward prototypes
public function string wf_set_title (string col_cnt)
end prototypes

public function string wf_set_title (string col_cnt);string ls_col_nm

is_col_nm = dw_1.Describe("#"+col_cnt+".dbName")
ls_col_nm = dw_1.Describe("#"+col_cnt+".Name")
st_2.text = dw_1.Describe(ls_col_nm+".Tag")
return is_col_nm
end function

on w_cd_search_multi.create
this.cb_add=create cb_add
this.cb_search=create cb_search
this.cb_print=create cb_print
this.dw_1=create dw_1
this.st_message=create st_message
this.cb_retrieve=create cb_retrieve
this.sle_1=create sle_1
this.st_2=create st_2
this.cb_2=create cb_2
this.cb_select=create cb_select
this.gb_1=create gb_1
this.Control[]={this.cb_add,&
this.cb_search,&
this.cb_print,&
this.dw_1,&
this.st_message,&
this.cb_retrieve,&
this.sle_1,&
this.st_2,&
this.cb_2,&
this.cb_select,&
this.gb_1}
end on

on w_cd_search_multi.destroy
destroy(this.cb_add)
destroy(this.cb_search)
destroy(this.cb_print)
destroy(this.dw_1)
destroy(this.st_message)
destroy(this.cb_retrieve)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.cb_select)
destroy(this.gb_1)
end on

event open;str_parm st_get_temp

//중앙에 Open
f_win_center(this)

st_get_temp 		= message.powerobjectparm

dw_1.dataobject 	= st_get_temp.s_parm[1]
is_arg 				= st_get_temp.s_parm[2]
is_col 				= trim(st_get_temp.s_parm[3])

if st_get_temp.s_parm[1] = 'd_lookup_part' then
	il_check =1
	if gs_kmarea = 'D' and gs_kmDivision = 'R' then
		cb_search.visible = true
		cb_add.visible = true
		cb_add.Enabled = False
	else
		cb_search.visible = false
		cb_add.visible = false
	end if
elseif st_get_temp.s_parm[1] = 'd_lookup_equip' then
	il_check =2
elseif st_get_temp.s_parm[1] = 'd_lookup_emp' then
	il_check =3
elseif st_get_temp.s_parm[1] = 'd_lookup_comp' or &
			st_get_temp.s_parm[1] = 'd_lookup_comp_div' then	
	il_check =0
elseif st_get_temp.s_parm[1] = 'd_lookup_dept' then	
	il_check =0
else
	il_check =1
end if

dw_1.settransobject(sqlcmms);
wf_set_title(is_col)

if st_get_temp.check then
	cb_retrieve.triggerevent(clicked!)
end if

sle_1.setfocus()
end event

type cb_add from commandbutton within w_cd_search_multi
boolean visible = false
integer x = 928
integer y = 1744
integer width = 325
integer height = 92
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
string text = "추 가"
end type

event clicked;String ls_part_code, ls_part_unit, ls_comp_code, ls_part_name, ls_part_spec
decimal ld_part_cost

if dw_1.getrow() < 0 then 
	messagebox('알림', "추가할 품목을 선택하세요!!")
	return
end if

cb_add.Enabled = false

ls_part_code = dw_1.object.part_code[dw_1.GetRow()]
ls_part_unit = dw_1.object.part_unit[dw_1.GetRow()]
ls_comp_code = dw_1.object.comp_code[dw_1.GetRow()]
ls_part_name = dw_1.object.part_name[dw_1.GetRow()]
ls_part_spec = dw_1.object.part_spec[dw_1.GetRow()]
ld_part_cost = dw_1.object.part_cost[dw_1.GetRow()]

SQLCMMS.AutoCommit = False
INSERT INTO Part_Master (part_code, normal_qty, repair_qty, etc_qty, part_unit, 
								part_cost, comp_code, part_name, part_spec, area_code, 
								factory_code, scram_qty, part_location)
		VALUES (:ls_part_code, 0, 0, 0, :ls_part_unit, :ld_part_cost, :ls_comp_code,
					:ls_part_name, :ls_part_spec, :gs_kmArea, :gs_kmdivision, 0, ' ')
USING SQLCMMS ;

if SQLCMMS.SqlCode <> 0 then
	messagebox("품목 추가 에러", SQLCMMS.sqlerrtext)
	Rollback USING SQLCMMS;
	return
end if

Commit USING SQLCMMS;
st_message.text =  "해당 품목이 등록되었읍니다.."

cb_retrieve.triggerevent(clicked!)

end event

type cb_search from commandbutton within w_cd_search_multi
boolean visible = false
integer x = 544
integer y = 1744
integer width = 384
integer height = 92
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
string text = "타공장조회"
end type

event clicked;String ls_sle_nm
String ls_PART_CODE, ls_PART_UNIT, ls_COMP_CODE, ls_PART_NAME, ls_PART_SPEC
decimal ld_PART_COST
long ll_row

st_message.text = ""

//조회조건 결정
If IsNull(sle_1.text) or trim(sle_1.text) = "" Then
	messagebox("입력 오류", "조건에 품번을 입력하세요!!")
	Return
Else
	ls_sle_nm = trim(sle_1.text)
End if

setpointer(HourGlass!)

ls_sle_nm = ls_sle_nm + '%'
DECLARE CUR_LABPART PROCEDURE For SP_LAB_PART @ps_partcode = :ls_sle_nm
Using sqlcmms ;

EXECUTE CUR_LABPART;
if sqlcmms.sqlcode <> 0 then
	setpointer(Arrow!)
	messagebox('품번찾기 오류', sqlcmms.sqlerrtext)
	return
end if

dw_1.Reset()
Do
	FETCH CUR_LABPART into :ls_PART_CODE, :ls_PART_UNIT, :ld_PART_COST, 
									:ls_COMP_CODE, :ls_PART_NAME, :ls_PART_SPEC;
	if sqlcmms.sqlcode <> 0 then exit
	ll_row = dw_1.InsertRow(0)			
	dw_1.SetItem(ll_row, 'part_code', ls_PART_CODE)
	dw_1.SetItem(ll_row, 'normal_qty', 0)
	dw_1.SetItem(ll_row, 'repair_qty', 0)
	dw_1.SetItem(ll_row, 'etc_qty', 0)
	dw_1.SetItem(ll_row, 'part_unit', ls_PART_UNIT)
	dw_1.SetItem(ll_row, 'part_cost', ld_PART_COST)
	dw_1.SetItem(ll_row, 'comp_code', ls_COMP_CODE)
	dw_1.SetItem(ll_row, 'part_name', ls_PART_NAME)
	dw_1.SetItem(ll_row, 'part_spec', ls_PART_SPEC)
//	dw_1.SetItem(ll_row, 'area_code', gs_kmArea)
//	dw_1.SetItem(ll_row, 'factory_code', gs_kmDivision)
//	dw_1.SetItem(ll_row, 'scram_qty', 0)
	
Loop While True
CLOSE CUR_LABPART ;

setpointer(Arrow!)

if dw_1.RowCount() > 0 then
	dw_1.AcceptText()
	cb_add.Enabled = true
	st_message.text =  "해당 품목선택 후 추가 하세요!!"
	dw_1.SetRowFocusIndicator(FocusRect!)
	dw_1.setfocus()
else
	st_message.text =  "해당자료가 없습니다...!!"
	SetFocus(sle_1)
end if

return
end event

type cb_print from commandbutton within w_cd_search_multi
integer x = 2080
integer y = 1744
integer width = 325
integer height = 92
integer taborder = 70
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

type dw_1 from datawindow within w_cd_search_multi
event ue_keyprocess pbm_dwnkey
integer x = 37
integer y = 156
integer width = 2688
integer height = 1572
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keyprocess;if keydown(keyenter!) then cb_select.triggerevent(clicked!)
end event

event doubleclicked;//if row > 0 then
//   cb_select.triggerevent(clicked!)
//end if
end event

event clicked;long cur_row
integer ii

dw_1.setredraw(false)

if row < 1 then
   if f_getobjectpoint_head(dw_1,is_col_nm) = 1 then
   	f_dw_sort(dw_1,is_col_nm)
	   st_2.text = dw_1.Describe(is_col_nm+".Tag")
   end if
Else
	If KeyDown(KeyControl!) then
		If dw_1.isselected(row) then
			dw_1.SelectRow(row, FALSE)
		else
			dw_1.SelectRow(row, TRUE)
		end if
	Else
		If KeyDown(KeyShift!) Then
			Cur_row = This.GetRow()
			For ii = Min(Row,Cur_row) To Max(Row,Cur_Row)
				This.SelectRow(ii,True)
			Next
		Else
			This.SelectRow(0,False)
			This.SelectRow(row,True)
		End If	
	End if
End If
dw_1.setredraw(true)	






	
end event

type st_message from statictext within w_cd_search_multi
integer x = 5
integer y = 1844
integer width = 2752
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long backcolor = 12632256
boolean enabled = false
string text = "선택하세요"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_retrieve from commandbutton within w_cd_search_multi
integer x = 2382
integer y = 40
integer width = 325
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
boolean underline = true
string text = "보 기"
end type

event clicked;string old_select,new_select,ls_sle_nm,ls_where
string select_clause, where_clause, order_clause, group_clause
long ll_row
int li_pos

st_message.text = ""
cb_add.Enabled = false

//조회조건 결정
If IsNull(sle_1.text) or trim(sle_1.text) = "" Then
	ls_sle_nm = ' '
Else
	ls_sle_nm = sle_1.text
End if

//새로운 조회조건을 만든다.
old_select = dw_1.GetSQLSelect( )
li_pos = pos(UPPER(old_select),'WHERE',1)

ls_where = is_arg

if trim(is_arg) <> "" then
	ls_where = ls_where + ' AND '
end if
	
If li_pos > 0 Then
	ls_where = ' AND ' + ls_where
Else
	ls_where = 'WHERE ' + ls_where
End if
if il_check = 1 or il_check = 2 or il_check = 3 then
	where_clause =   ls_where + " (("+is_col_nm+" LIKE '%"+ls_sle_nm+"%' ) or " + &
									" (' ' = '"+ls_sle_nm+"')) and area_code='"+gs_kmarea+"' and factory_code='"+gs_kmdivision+"' "
else
	where_clause =   ls_where + " (("+is_col_nm+" LIKE '%"+ls_sle_nm+"%' ) or " + &
									" (' ' = '"+ls_sle_nm+"')) "
end if

li_pos = pos(UPPER(old_select),'ORDER BY',1)
if li_pos > 0 then
	select_clause = Mid(old_select, 1, li_pos - 1)
	order_clause = Mid(old_select, li_pos)
else 
	select_clause = old_select
end if

new_select = select_clause + where_clause + order_clause

dw_1.SetSQLSelect(new_select)

if il_check = 1 or il_check = 2 or il_check = 3 then
	
	ll_row = dw_1.retrieve()
else
	ll_row = dw_1.retrieve()
end if
//원래의 sql문장을 복원
dw_1.SetSQLSelect(old_select)

if  ll_row > 0 then
   dw_1.Sort()
else
	st_message.text =  "해당자료가 없습니다...!!"
	SetFocus(sle_1)
	return
end if

dw_1.SetRowFocusIndicator(FocusRect!)
dw_1.setfocus()
end event

type sle_1 from singlelineedit within w_cd_search_multi
event ue_keyprocess pbm_keydown
integer x = 741
integer y = 40
integer width = 1632
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 16777215
long backcolor = 27699859
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event ue_keyprocess;if keydown(keyenter!) then cb_retrieve.triggerevent(clicked!)
end event

type st_2 from statictext within w_cd_search_multi
integer x = 46
integer y = 52
integer width = 690
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long backcolor = 80263328
boolean enabled = false
string text = "조 건"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_cd_search_multi
integer x = 2405
integer y = 1744
integer width = 325
integer height = 92
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
string text = "종 료"
end type

event clicked;str_parm st_give_temp

st_give_temp.i_parm[1] = 0
closewithreturn(parent,st_give_temp)
end event

type cb_select from commandbutton within w_cd_search_multi
integer x = 1755
integer y = 1744
integer width = 325
integer height = 92
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
string text = "선 택"
end type

event clicked;str_parm st_give_temp
int m,i,li_column_count,li_counter
long j=0
string ls_col_type,ls_give[100,50],ls_column_name

li_column_count = Integer(dw_1.Object.DataWindow.Column.Count)

if dw_1.rowcount() > 0 then
	for m = 1 to dw_1.rowcount() 
		if dw_1.IsSelected(m) then
			j++
			For li_counter = 1 to li_column_count step 1
			   ls_column_name = dw_1.Describe("#"+string(li_counter)+".Name")
		   	ls_col_type    = dw_1.Describe(ls_column_name+".ColType")
			   If left(ls_col_type,4) = "char" then
				   ls_give[j,li_counter] = dw_1.getitemstring(m,li_counter)
			   ElseIf ls_col_type = "number" or ls_col_type = "long" or left(ls_col_type,7) = "decimal" then
				       ls_give[j,li_counter] = string(dw_1.getitemnumber(m,li_counter))
			   End If
		   Next
	
			if mid(trim(ls_give[j,1]),1,1) = '*' then
				st_give_temp.s_array[j,1] = ""
			else
				for i = 1 to li_column_count
					st_give_temp.s_array[j,i] = ls_give[j,i]
				next
			end if
		end if
	next
	st_give_temp.i_parm[1] = j
else
	st_give_temp.i_parm[1] = 0
end if

closewithreturn(parent,st_give_temp)
end event

type gb_1 from groupbox within w_cd_search_multi
integer x = 37
integer width = 2688
integer height = 144
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long backcolor = 80263328
end type

