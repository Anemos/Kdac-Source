$PBExportHeader$w_seq102u.srw
$PBExportComments$제품군 등록
forward
global type w_seq102u from w_origin_sheet09
end type
type dw_1 from datawindow within w_seq102u
end type
type uo_division from u_pisc_select_division within w_seq102u
end type
type uo_area from u_pisc_select_area within w_seq102u
end type
type gb_1 from groupbox within w_seq102u
end type
end forward

global type w_seq102u from w_origin_sheet09
integer height = 2724
string title = "제품군 등록"
dw_1 dw_1
uo_division uo_division
uo_area uo_area
gb_1 gb_1
end type
global w_seq102u w_seq102u

type variables
string is_areacode,is_divisioncode ,is_selected
end variables

forward prototypes
public subroutine wf_protect (string ag_s_column, integer ag_n_number, datawindow ag_dw_1)
end prototypes

public subroutine wf_protect (string ag_s_column, integer ag_n_number, datawindow ag_dw_1);string l_s_command
//--	Argument	=> ag_s_column = column 명, 
//---             ag_n_number = column 순서,
ag_dw_1.setredraw(False)
l_s_command	=	ag_s_column + ".Protect = '1" &            
					+	"~tIf(mid(pt_chk," + string(ag_n_number) + ", 1) = " + "~~'1~~'," &
					+  " 1, 0 )'"
					
ag_dw_1.Modify(l_s_command)
ag_dw_1.setredraw(True)
 
end subroutine

on w_seq102u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_division=create uo_division
this.uo_area=create uo_area
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.gb_1
end on

on w_seq102u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.gb_1)
end on

event open;call super::open;//wf_icon_onoff(true,true,true,true,false,false,false,false,false)

end event
event ue_retrieve;call super::ue_retrieve;integer ln_row
is_Selected = 'R'
ln_row = dw_1.retrieve(is_areacode,is_divisioncode)
dw_1.object.productgroup.protect = true
if ln_row < 1 then
	uo_status.st_message.text = '조회할 정보가 없습니다'
else
	uo_status.st_message.text = '조회 완료'
	dw_1.setfocus()
	dw_1.setrow(1)
	dw_1.setcolumn("productname")
end if

end event

event ue_insert;call super::ue_insert;integer ln_row

if f_spacechk(is_divisioncode) = -1 or is_divisioncode = '%' then
	messagebox("확인","제품군 입력시에는 공장코드를 반드시 선택해야 합니다")
	return
end if
ln_row = dw_1.insertrow(0)
dw_1.object.pt_chk[ln_row] 		= '   '
dw_1.object.areacode[ln_row] 		= is_areacode
dw_1.object.divisioncode[ln_row] = is_divisioncode
wf_protect("productgroup",1,dw_1)
//wf_protect("productgroup",2,dw_1)
//wf_protect("productgroup",3,dw_1)
dw_1.setfocus()
dw_1.setrow(ln_row)
dw_1.setcolumn("productgroup")
is_Selected = 'A'

end event

event activate;call super::activate;dw_1.settransobject(sqlpis)
wf_icon_onoff(true,true,true,true,false,false,false,false,false)
end event
event ue_save;call super::ue_save;long ln_rowcount,i,ln_count,ln_savecount
dwItemStatus ls_status
datetime ld_nowtime
string ls_productgroup,ls_divisioncode,ls_productname
 
ld_nowtime = f_pisc_get_date_nowtime()
ln_rowcount = dw_1.rowcount()
if ln_rowcount < 1 then
	messagebox("확인","저장할 정보가 없습니다")
	return 1
end if
dw_1.accepttext()
for i = 1 to ln_rowcount
	ls_productgroup 	= trim(dw_1.object.productgroup[i])
	ls_productname		= trim(dw_1.object.productname[i])
	if f_spacechk(ls_productgroup) = -1 and f_spacechk(ls_productname) = -1 then
		dw_1.deleterow(i)
		i = i - 1
		ln_rowcount = ln_rowcount - 1
		continue
	end if
next
if f_mandatory_chk(dw_1) = -1 then
	return 1
end if
sqlpis.autocommit = false
for i = 1 to ln_rowcount
	ls_status =  dw_1.GetItemStatus(i, 0,Primary!)
	if ls_status = datamodified! or ls_status = newmodified! then
 		ls_productgroup 	= trim(dw_1.object.productgroup[i])
//		ls_prodcutname		= trim(dw_1.object.productname[i])
//		ls_seqgubun			= trim(dw_1.object.seqgubun[i])
		ls_divisioncode	= trim(dw_1.object.divisioncode[i])
 		if ls_status = newmodified! then
			select count(*) into :ln_count from tseqmstprod
				where areacode = :is_Areacode and divisioncode = :ls_divisioncode and productgroup = :ls_productgroup
			using sqlpis ;
			if ln_count > 0 then
				messagebox("확인",ls_productgroup + " 은 이미 등록된 제품군입니다")
				dw_1.deleterow(i)
				sqlpis.autocommit = true
				return 1
			end if
		end if
		dw_1.setitem(i,"lastemp",g_s_empno)	
		dw_1.setitem(i,"lastdate",ld_nowtime)	
		ln_savecount 	= 1
	else
		continue
	end if
next
if ln_savecount = 1 then
	if dw_1.update() <> 1 then
		messagebox("확인2","시스템개발팀에 문의바랍니다")
		rollback using sqlpis;
	else
		commit using sqlpis;
		messagebox("확인","저장성공")
	end if
end if
sqlpis.autocommit = true
this.triggerevent("ue_retrieve")





end event

event ue_delete;call super::ue_delete;long ln_row,ln_count=0,ln_yesno
string ls_areacode,ls_divisioncode,ls_productgroup

is_Selected = 'D'
ln_row = dw_1.getselectedrow(0)

if ln_row < 1 then
	messagebox("확인","삭제하고자 하는 제품군을 선택한 후 작업바랍니다")
	return
end if

ls_areacode			= 	trim(dw_1.object.areacode[ln_row])
ls_divisioncode	=	trim(dw_1.object.divisioncode[ln_row])
ls_productgroup	=	trim(dw_1.object.productgroup[ln_row])

select count(*) into :ln_count from tseqmstitem
	where areacode = :ls_areacode and divisioncode = :ls_divisioncode and
			productgroup = :ls_productgroup
using sqlpis ;
if ln_count > 0 then
	messagebox("확인","서열품목마스터 정보에서 해당 제품군을 사용중입니다")
	return 
end if

ln_yesno = messagebox("삭제확인", "선택된 제품군을 삭제하시겠습니까 ?",Question!,OkCancel!,2)
if ln_yesno <> 1 then
	uo_status.st_message.text = f_message("D030")
	return 0
end if

delete from tseqmstprod
where areacode = :ls_areacode and divisioncode = :ls_divisioncode and productgroup = :ls_productgroup
using sqlpis ;
if sqlpis.sqlnrows < 1 then
	uo_status.st_message.text = "삭제 실패.시스템 개발팀으로 연락바랍니다"
	return
else
	uo_status.st_message.text = "삭제 성공"
end if
dw_1.reset()
this.triggerevent("ue_retrieve")





end event

type uo_status from w_origin_sheet09`uo_status within w_seq102u
end type

type dw_1 from datawindow within w_seq102u
integer x = 5
integer y = 184
integer width = 3346
integer height = 2284
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_tseqmstprod_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_1.settransobject(sqlpis)
end event

event clicked;if row <= 0 then
	return
end if
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)
end event

event losefocus;if is_selected <> "A" then
	return
end if

if keydown(keytab!) = false then
	return
end if
this.insertrow(0)
end event

type uo_division from u_pisc_select_division within w_seq102u
event destroy ( )
integer x = 590
integer y = 68
integer taborder = 70
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;is_divisioncode = is_uo_divisioncode
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode

end event

type uo_area from u_pisc_select_area within w_seq102u
event destroy ( )
integer x = 46
integer y = 68
integer taborder = 80
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)


end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)



end event

type gb_1 from groupbox within w_seq102u
integer x = 9
integer width = 3346
integer height = 164
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

