$PBExportHeader$w_mpm220u_01.srw
$PBExportComments$부품에 대한 공정복사
forward
global type w_mpm220u_01 from window
end type
type dw_target from u_vi_std_datawindow within w_mpm220u_01
end type
type cbx_total from checkbox within w_mpm220u_01
end type
type uo_2 from u_mpms_select_orderno within w_mpm220u_01
end type
type uo_1 from u_mpms_select_orderno within w_mpm220u_01
end type
type dw_source from u_vi_std_datawindow within w_mpm220u_01
end type
type pb_1 from picturebutton within w_mpm220u_01
end type
type cb_close from commandbutton within w_mpm220u_01
end type
type st_1 from statictext within w_mpm220u_01
end type
type gb_1 from groupbox within w_mpm220u_01
end type
type gb_2 from groupbox within w_mpm220u_01
end type
end forward

global type w_mpm220u_01 from window
integer width = 3392
integer height = 1788
boolean titlebar = true
string title = "공정복사"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
dw_target dw_target
cbx_total cbx_total
uo_2 uo_2
uo_1 uo_1
dw_source dw_source
pb_1 pb_1
cb_close cb_close
st_1 st_1
gb_1 gb_1
gb_2 gb_2
end type
global w_mpm220u_01 w_mpm220u_01

forward prototypes
public function integer wf_copy_each ()
public function integer wf_copy_total ()
end prototypes

public function integer wf_copy_each ();//----------------
// 성공하면 return 0, 실패하면 return -1
//----------------
long	ll_row, ll_LastRow, ll_index = 1, ll_select_row, ll_count
long	ll_SaveRow[] 
string ls_src_orderno, ls_src_partno, ls_tar_orderno, ls_tar_partno

setpointer(hourglass!)
// 선택된 행이 있는지 체크한다
//
ll_row = dw_target.GetSelectedRow(0)
IF ll_row = 0 THEN
	// 선택된 행이 없으면 리턴
	//
	RETURN 0
ELSE
	// 선택된 행을 찾아서 배열에 선택된행의 행번호를 저장한다
	//
	do
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_target.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

ll_select_row = dw_source.getselectedrow(0)

ls_src_orderno = uo_1.is_uo_orderno
ls_tar_orderno = uo_2.is_uo_orderno
ls_src_partno  = dw_source.getitemstring( ll_select_row, 'partno')

sqlmpms.AutoCommit = False
// 좌측화면의 선택된 자료를 우측화면으로 이동한다
// 
FOR ll_row = 1 TO ll_index - 1
	// 우측화면에 한행씩을 만들면서 좌측화면의 자료를 우측화면에 셋트한다
	ls_tar_partno   = dw_target.getitemstring(ll_SaveRow[ll_row],'partno')
	
	// 해당부품의 공순존재여부 체크. 존제 => 미반영
	SELECT COUNT(*) INTO :ll_count FROM TROUTING
	WHERE ORDERNO = :ls_tar_orderno AND PARTNO = :ls_tar_partno
	using sqlmpms;
	
	if ll_count > 0 then
		continue
	end if
	
	INSERT INTO TROUTING  
   ( OperNo, OrderNo, PartNo, WcCode, WorkStatus, OutFlag,  
     WorkStart, StdTime, StdHeatCost, StdOutCost, WorkMatter, ResultFlag, LastEmp, LastDate )  
   SELECT OperNo, :ls_tar_orderno, :ls_tar_partno, WcCode, 'N', OutFlag,
		getdate(), StdTime, StdHeatCost, StdOutCost, WorkMatter, 'N', :g_s_empno,
		getdate()
	FROM TROUTING
	WHERE OrderNo = :ls_src_orderno AND PartNo = :ls_src_partno
	using sqlmpms;

	if sqlmpms.sqlcode <> 0 then
		RollBack using sqlmpms;
		sqlmpms.AutoCommit = True
		return -1 
	end if
NEXT

Commit using sqlmpms;
sqlmpms.Autocommit = True
return 0
end function

public function integer wf_copy_total ();//----------------
// 성공하면 return 0, 실패하면 return -1
//----------------
long ll_rowcnt, ll_cnt, ll_findrow, ll_count
string ls_src_orderno, ls_src_partno, ls_tar_orderno, ls_tar_partno

ll_rowcnt = dw_source.rowcount()

ls_src_orderno = uo_1.is_uo_orderno
ls_tar_orderno = uo_2.is_uo_orderno

sqlmpms.Autocommit = False
for ll_cnt = 1 to ll_rowcnt
	ls_src_partno  = dw_source.getitemstring( ll_cnt, 'partno')
	
	// 우측화면에 같은 부품번호 찾기
	ll_findrow = dw_target.find("partno = '" + ls_src_partno + "'", 1, dw_target.rowcount())
	if ll_findrow < 1 then
		continue
	end if
	ls_tar_partno   = dw_target.getitemstring(ll_findrow,'partno')
	
	// 해당부품의 공순존재여부 체크. 존제 => 미반영
	SELECT COUNT(*) INTO :ll_count FROM TROUTING
	WHERE ORDERNO = :ls_tar_orderno AND PARTNO = :ls_tar_partno
	using sqlmpms;
	
	if ll_count > 0 then
		continue
	end if
	
	INSERT INTO TROUTING  
   ( OperNo, OrderNo, PartNo, WcCode, WorkStatus, OutFlag,   
     WorkStart, StdTime, StdHeatCost, StdOutCost, WorkMatter, ResultFlag, LastEmp, LastDate )  
   SELECT OperNo, :ls_tar_orderno, :ls_tar_partno, WcCode, 'N', OutFlag,
		getdate(), StdTime, StdHeatCost, StdOutCost, WorkMatter, 'N', :g_s_empno,
		getdate()
	FROM TROUTING
	WHERE OrderNo = :ls_src_orderno AND PartNo = :ls_src_partno
	using sqlmpms;

	if sqlmpms.sqlcode <> 0 then
		RollBack using sqlmpms;
		sqlmpms.AutoCommit = True
		return -1 
	end if
next

Commit using sqlmpms;
sqlmpms.AutoCommit = True
return 0
end function

on w_mpm220u_01.create
this.dw_target=create dw_target
this.cbx_total=create cbx_total
this.uo_2=create uo_2
this.uo_1=create uo_1
this.dw_source=create dw_source
this.pb_1=create pb_1
this.cb_close=create cb_close
this.st_1=create st_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_target,&
this.cbx_total,&
this.uo_2,&
this.uo_1,&
this.dw_source,&
this.pb_1,&
this.cb_close,&
this.st_1,&
this.gb_1,&
this.gb_2}
end on

on w_mpm220u_01.destroy
destroy(this.dw_target)
destroy(this.cbx_total)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.dw_source)
destroy(this.pb_1)
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;string ls_orderno

dw_source.settransobject(sqlmpms)
dw_target.settransobject(sqlmpms)

ls_orderno = message.Stringparm


end event

type dw_target from u_vi_std_datawindow within w_mpm220u_01
integer x = 1897
integer y = 388
integer width = 1385
integer height = 1216
integer taborder = 50
string dataobject = "d_mpm220u_01"
end type

type cbx_total from checkbox within w_mpm220u_01
integer x = 1211
integer y = 276
integer width = 361
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "전체공정"
end type

type uo_2 from u_mpms_select_orderno within w_mpm220u_01
integer x = 1915
integer y = 260
integer taborder = 50
end type

on uo_2.destroy
call u_mpms_select_orderno::destroy
end on

event ue_select;call super::ue_select;dw_target.reset()
dw_target.retrieve(uo_2.is_uo_orderno)
end event

type uo_1 from u_mpms_select_orderno within w_mpm220u_01
integer x = 50
integer y = 268
integer taborder = 40
end type

on uo_1.destroy
call u_mpms_select_orderno::destroy
end on

event ue_select;call super::ue_select;
dw_source.reset()
dw_source.retrieve(uo_1.is_uo_orderno)
end event

type dw_source from u_vi_std_datawindow within w_mpm220u_01
integer x = 73
integer y = 388
integer width = 1472
integer height = 1216
integer taborder = 40
string dataobject = "d_mpm220u_01"
end type

event constructor;call super::constructor;ii_selection = 1
end event

type pb_1 from picturebutton within w_mpm220u_01
integer x = 1605
integer y = 664
integer width = 238
integer height = 472
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\KDAC\bmp\userright.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;integer li_selrow, li_rtn
string  ls_src_orderno, ls_tar_orderno, ls_src_partno

ls_src_orderno = uo_1.is_uo_orderno
ls_tar_orderno = uo_2.is_uo_orderno

if f_spacechk(ls_src_orderno) = -1 or f_spacechk(ls_tar_orderno) = -1 then
	messagebox("경고","금형의뢰번호를 선택해 주십시요")
	return 0
end if

if cbx_total.checked then
	if ls_src_orderno = ls_tar_orderno then
		messagebox("경고", " 전체이동은 다른 의뢰번호로 가능합니다.")
		return 0
	end if
	li_rtn = MessageBox("알림", ls_src_orderno + " => " + ls_tar_orderno + " 의뢰번호로 " &
		+ " 공정전체를 이동하시겠습니까?",Exclamation!, OKCancel!, 2)
	if li_rtn = 2 then
		return 0
	end if
	
	if wf_copy_total() = -1 then
		messagebox("알림","작업이 실패했습니다.")
		return 0
	end if
else
	li_selrow = dw_source.getselectedrow(0)
	ls_src_partno = dw_source.getitemstring(li_selrow, 'partno')
	li_rtn = MessageBox("알림", ls_src_partno + " 부품의 공정을 " &
		+ " 선택된 TARGET으로 이동하시겠습니까?",Exclamation!, OKCancel!, 2)
	if li_rtn = 2 then
		return 0
	end if
	if wf_copy_each() = -1 then
		messagebox("알림","작업이 실패했습니다.")
		return 0
	end if
end if

messagebox("알림","정상적으로 처리되었습니다.")
return 0
end event

type cb_close from commandbutton within w_mpm220u_01
integer x = 2898
integer y = 40
integer width = 398
integer height = 108
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;close(w_mpm220u_01)
end event

type st_1 from statictext within w_mpm220u_01
integer x = 32
integer y = 56
integer width = 1550
integer height = 92
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "◎  부품에 대한 공정복사  ◎"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_mpm220u_01
integer x = 41
integer y = 192
integer width = 1536
integer height = 1440
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "SOURCE"
end type

type gb_2 from groupbox within w_mpm220u_01
integer x = 1865
integer y = 192
integer width = 1454
integer height = 1440
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "TARGET"
end type

