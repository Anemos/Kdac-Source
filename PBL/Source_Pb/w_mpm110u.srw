$PBExportHeader$w_mpm110u.srw
$PBExportComments$사외업체정보
forward
global type w_mpm110u from w_ipis_sheet01
end type
type dw_mpm110u_01 from u_vi_std_datawindow within w_mpm110u
end type
type dw_mpm110u_02 from datawindow within w_mpm110u
end type
end forward

global type w_mpm110u from w_ipis_sheet01
dw_mpm110u_01 dw_mpm110u_01
dw_mpm110u_02 dw_mpm110u_02
end type
global w_mpm110u w_mpm110u

forward prototypes
public function string wf_get_custcode ()
end prototypes

public function string wf_get_custcode ();String ls_custcd

DECLARE up_get_custcode PROCEDURE FOR sp_get_moldcode  
    @ps_codeid = 'CID'  
	 using sqlmpms;

Execute up_get_custcode;

if sqlmpms.sqlcode = 0 then
	fetch up_get_custcode into :ls_custcd;
	close up_get_custcode;
end if

return 'M' + ls_custcd



end function

on w_mpm110u.create
int iCurrent
call super::create
this.dw_mpm110u_01=create dw_mpm110u_01
this.dw_mpm110u_02=create dw_mpm110u_02
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm110u_01
this.Control[iCurrent+2]=this.dw_mpm110u_02
end on

on w_mpm110u.destroy
call super::destroy
destroy(this.dw_mpm110u_01)
destroy(this.dw_mpm110u_02)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm110u_01.Width = newwidth 	- ( ls_gap * 2 )
dw_mpm110u_01.Height= ( newheight * 2 / 3 ) - dw_mpm110u_01.y

dw_mpm110u_02.x = dw_mpm110u_01.x
dw_mpm110u_02.y = dw_mpm110u_01.Height + dw_mpm110u_01.y + ls_gap
dw_mpm110u_02.Width = newwidth - ( ls_gap * 2 )
dw_mpm110u_02.Height = newheight - ( dw_mpm110u_02.y + ls_status )

end event

event ue_postopen;call super::ue_postopen;
dw_mpm110u_01.SetTransObject(sqlmpms)
dw_mpm110u_02.SetTransObject(sqlmpms)

This.Triggerevent('ue_retrieve')
end event

event ue_retrieve;call super::ue_retrieve;long ll_rowcnt
string ls_custcd

dw_mpm110u_01.reset()
dw_mpm110u_02.reset()

ll_rowcnt = dw_mpm110u_01.retrieve()
if ll_rowcnt < 1 then
	dw_mpm110u_02.insertrow(0)
end if
end event

event ue_insert;call super::ue_insert;
dw_mpm110u_02.reset()
dw_mpm110u_02.insertrow(0)
end event

event ue_save;call super::ue_save;int    li_findrow
string ls_custcode

ls_custcode = dw_mpm110u_02.getitemstring( 1, "custcode")

if dw_mpm110u_02.modifiedcount() <= 0 then
	uo_status.st_message.text = "저장할 데이타가 없습니다."
	return -1
end if

if f_spacechk(ls_custcode) = -1 then
	ls_custcode = wf_get_custcode()
	if f_spacechk(ls_custcode) = -1 then
		Messagebox("알림", "업체코드를 가져오는데 실패했습니다.")
		return -1
	end if
	dw_mpm110u_02.setitem( 1, "custcode", ls_custcode )
end if

sqlmpms.AutoCommit = False

if dw_mpm110u_02.update() = 1 then
	Commit using sqlmpms;
	sqlmpms.AutoCommit = True
	This.Triggerevent("ue_retrieve")
	li_findrow = dw_mpm110u_01.find("custcode = '" + ls_custcode + "'", 1, dw_mpm110u_01.rowcount())
	if li_findrow > 0 then
		dw_mpm110u_01.Post Event RowFocusChanged(li_findrow)
		dw_mpm110u_01.scrolltorow(li_findrow)
		dw_mpm110u_01.setrow(li_findrow)
	end if
	uo_status.st_message.text = "저장되었습니다."
else
	Rollback using sqlmpms;
	sqlmpms.AutoCommit = False
	uo_status.st_message.text = "저장이 실패했습니다."
end if


end event

event ue_delete;call super::ue_delete;int    li_rtn, li_totcnt
string ls_custcode

ls_custcode = dw_mpm110u_02.getitemstring( 1, "custcode")

if f_spacechk(ls_custcode) = -1 then
	Messagebox("알림", "삭제할 업체코드를 선택바랍니다.")
	return -1
end if

li_rtn = MessageBox("확인", ls_custcode + " 업체를 삭제하시겠습니까?",Exclamation!, OKCancel!, 2)
if li_rtn = 2 then
	return -1
end if
// 해당업체에서 의뢰건이 접수된 적이 있는지 여부
SELECT COUNT(*) INTO :li_totcnt FROM TORDER
WHERE ORDERDEPT = :ls_custcode using sqlmpms;

if li_totcnt > 0 then
	uo_status.st_message.text = "해당업체로 금형의뢰가 접수된 내역이 있습니다."
	return -1
end if

sqlmpms.AutoCommit = False

DELETE FROM TCUSTOMER
WHERE CUSTCODE = :ls_custcode using sqlmpms;

if sqlmpms.sqlcode = 0 then
	Commit using sqlmpms;
	sqlmpms.AutoCommit = True
	This.Triggerevent("ue_retrieve")
	uo_status.st_message.text = "삭제되었습니다."
else
	Rollback using sqlmpms;
	sqlmpms.AutoCommit = False
	uo_status.st_message.text = "삭제시에 에러가 발생하였습니다."
end if
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= True
i_b_save 		= True
i_b_delete 		= True
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm110u
end type

type dw_mpm110u_01 from u_vi_std_datawindow within w_mpm110u
integer x = 9
integer y = 12
integer width = 2958
integer height = 708
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm110u_01"
end type

event rowfocuschanged;call super::rowfocuschanged;integer li_rowcnt
String ls_custcode

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )

ls_custcode = This.getitemstring(currentrow,'custcode')

dw_mpm110u_02.retrieve(ls_custcode)
end event

type dw_mpm110u_02 from datawindow within w_mpm110u
integer x = 14
integer y = 744
integer width = 2953
integer height = 776
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm110u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

