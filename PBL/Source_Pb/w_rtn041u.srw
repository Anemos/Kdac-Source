$PBExportHeader$w_rtn041u.srw
$PBExportComments$결재담당관리
forward
global type w_rtn041u from w_ipis_sheet01
end type
type dw_rtn041u_01 from u_vi_std_datawindow within w_rtn041u
end type
end forward

global type w_rtn041u from w_ipis_sheet01
dw_rtn041u_01 dw_rtn041u_01
end type
global w_rtn041u w_rtn041u

on w_rtn041u.create
int iCurrent
call super::create
this.dw_rtn041u_01=create dw_rtn041u_01
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_rtn041u_01
end on

on w_rtn041u.destroy
call super::destroy
destroy(this.dw_rtn041u_01)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_rtn041u_01.Width = newwidth	- (ls_gap * 4)
dw_rtn041u_01.Height= newheight - (dw_rtn041u_01.y + ls_status)
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= True
i_b_save 		= False
i_b_delete 		= True
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_postopen;call super::ue_postopen;dw_rtn041u_01.settransobject(sqlca)

this.triggerevent("ue_retrieve")
end event

event ue_retrieve;call super::ue_retrieve;dw_rtn041u_01.reset()
dw_rtn041u_01.retrieve()
end event

event ue_insert;call super::ue_insert;long ll_rowcnt

SELECT COUNT(*) INTO :ll_rowcnt
FROM PBRTN.RTN019
WHERE Xcmcd = '01' AND Xinemp = :g_s_empno
using sqlca;

if ll_rowcnt > 0 then
	uo_status.st_message.text = "결재할 PL이 지정되어 있습니다."
	return 0
end if

openwithparm(w_rtn_select_pl, '')

This.triggerevent("ue_retrieve")
end event

event ue_delete;call super::ue_delete;long ll_selrow, ll_rowcnt
string ls_xinemp, ls_xplemp

ll_selrow = dw_rtn041u_01.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = "삭제할 행을 선택해 주십시요"
	return -1
end if

ls_xinemp = dw_rtn041u_01.getitemstring(ll_selrow,"xinemp")
ls_xplemp = dw_rtn041u_01.getitemstring(ll_selrow,"xplemp")

if g_s_empno <> '000030' then
	if ls_xinemp <> g_s_empno then
		uo_status.st_message.text = "등록된 담당자와 로그인한 사번이 동일하지 않습니다."
		return -1
	end if
end if

SELECT COUNT(*) INTO :ll_rowcnt
FROM PBRTN.RTN011
WHERE Raplemp = :ls_xplemp AND Raplchk = 'N'
using sqlca;

if ll_rowcnt > 0 then
	uo_status.st_message.text = "해당 PL이 결재해야될 유사품목정보가 존재합니다."
	return -1
end if

SELECT COUNT(*) INTO :ll_rowcnt
FROM PBRTN.RTN013
WHERE Rcplemp = :ls_xplemp AND Rcplchk = 'N'
using sqlca;

if ll_rowcnt > 0 then
	uo_status.st_message.text = "해당 PL이 결재해야될 공정정보가 존재합니다."
	return -1
end if

dw_rtn041u_01.deleterow(ll_selrow)

this.postevent("ue_save")
return 0
end event

event ue_save;call super::ue_save;
dw_rtn041u_01.accepttext()

if dw_rtn041u_01.modifiedcount() < 1 and dw_rtn041u_01.deletedcount() < 1 then
	uo_status.st_message.text = "변경된 데이타가 없습니다."
	return 0
end if

sqlca.AutoCommit = False

if dw_rtn041u_01.update() = 1 then
	Commit using sqlca;
	sqlca.AutoCommit = True
	uo_status.st_message.text = "저장되었습니다."
else
	RollBack using sqlca;
	sqlca.AutoCommit = True
	uo_status.st_message.text = "저장이 실패했습니다."
end if
end event

type uo_status from w_ipis_sheet01`uo_status within w_rtn041u
end type

type dw_rtn041u_01 from u_vi_std_datawindow within w_rtn041u
integer x = 27
integer y = 24
integer width = 2601
integer height = 1476
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_rtn041u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;String 	ls_colName, ls_xinemp
Long		ll_rowcnt

ls_colName = dwo.name
Choose Case ls_colName
	Case 'xplemp'
		ls_xinemp = this.getitemstring(row,"xinemp")
		if ls_xinemp <> g_s_empno then
			Messagebox("확인","등록된 담당과 로그인 사번이 동일하지 않습니다.")
			return 1
		end if
End Choose

return 0
end event

