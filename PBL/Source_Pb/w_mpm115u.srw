$PBExportHeader$w_mpm115u.srw
$PBExportComments$단말기/작업장관리
forward
global type w_mpm115u from w_ipis_sheet01
end type
type dw_mpm115u_01 from u_vi_std_datawindow within w_mpm115u
end type
type dw_mpm115u_02 from u_vi_std_datawindow within w_mpm115u
end type
type st_1 from statictext within w_mpm115u
end type
type st_2 from statictext within w_mpm115u
end type
type st_3 from statictext within w_mpm115u
end type
type pb_delete from picturebutton within w_mpm115u
end type
type pb_add from picturebutton within w_mpm115u
end type
type dw_mpm115u_03 from u_vi_std_datawindow within w_mpm115u
end type
end forward

global type w_mpm115u from w_ipis_sheet01
dw_mpm115u_01 dw_mpm115u_01
dw_mpm115u_02 dw_mpm115u_02
st_1 st_1
st_2 st_2
st_3 st_3
pb_delete pb_delete
pb_add pb_add
dw_mpm115u_03 dw_mpm115u_03
end type
global w_mpm115u w_mpm115u

type variables
datawindow id_dw_current
end variables

on w_mpm115u.create
int iCurrent
call super::create
this.dw_mpm115u_01=create dw_mpm115u_01
this.dw_mpm115u_02=create dw_mpm115u_02
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.pb_delete=create pb_delete
this.pb_add=create pb_add
this.dw_mpm115u_03=create dw_mpm115u_03
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm115u_01
this.Control[iCurrent+2]=this.dw_mpm115u_02
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.pb_delete
this.Control[iCurrent+7]=this.pb_add
this.Control[iCurrent+8]=this.dw_mpm115u_03
end on

on w_mpm115u.destroy
call super::destroy
destroy(this.dw_mpm115u_01)
destroy(this.dw_mpm115u_02)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.pb_delete)
destroy(this.pb_add)
destroy(this.dw_mpm115u_03)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm115u_01.Width = (newwidth * 55 / 100)	- (ls_gap * 3)
dw_mpm115u_01.Height= ( newheight * 2 / 5 )

dw_mpm115u_02.x = (ls_gap * 4) + dw_mpm115u_01.Width
dw_mpm115u_02.y = dw_mpm115u_01.y
dw_mpm115u_02.Width = (newwidth * 45 / 100) - (ls_gap * 4)
dw_mpm115u_02.Height= dw_mpm115u_01.Height

st_2.x = dw_mpm115u_02.x
 
dw_mpm115u_03.y = dw_mpm115u_01.y + dw_mpm115u_01.Height + 150
dw_mpm115u_03.Width = newwidth 	- ( ls_gap * 5 )
dw_mpm115u_03.Height= ( newheight * 3 / 5 ) - 350

st_3.y = dw_mpm115u_01.y + dw_mpm115u_01.Height + 50
pb_add.y = dw_mpm115u_01.y + dw_mpm115u_01.Height + 20
pb_delete.y = dw_mpm115u_01.y + dw_mpm115u_01.Height + 20
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc
dw_mpm115u_01.SetTransObject(sqlmpms)
dw_mpm115u_02.SetTransObject(sqlmpms)
dw_mpm115u_03.SetTransObject(sqlmpms)

//dw_mpm111u_01.GetChild('wcgubun', ldwc)
//ldwc.settransobject(sqlmpms)
//ldwc.retrieve('MPM001')
//if ldwc.RowCount() < 1 then
//	ldwc.InsertRow(0)
//end if
//
//f_pisc_set_dddw_width(dw_mpm111u_01,'wcgubun',ldwc,'codename',5)

This.Triggerevent("ue_retrieve")
end event

event ue_retrieve;call super::ue_retrieve;integer li_rowcnt
string ls_wccode

dw_mpm115u_01.reset()
dw_mpm115u_02.reset()
dw_mpm115u_03.reset()

dw_mpm115u_01.retrieve()
dw_mpm115u_02.retrieve()
dw_mpm115u_03.retrieve()
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

event ue_insert;call super::ue_insert;choose case id_dw_current.dataobject
	case 'd_mpm115u_01'
		dw_mpm115u_01.insertrow(0)
	case 'd_mpm115u_02'
		dw_mpm115u_02.insertrow(0)
end choose
end event

event ue_save;call super::ue_save;integer li_error_code
string ls_message

li_error_code = 0
dw_mpm115u_01.accepttext()
dw_mpm115u_02.accepttext()

sqlmpms.Autocommit = False

if dw_mpm115u_01.modifiedcount() < 1 and dw_mpm115u_01.deletedcount() < 1 then
	//pass
else
	if dw_mpm115u_01.update() <> 1 then
		ls_message = "ERR01"
		goto RollBack_
	end if
end if

if dw_mpm115u_02.modifiedcount() < 1 and dw_mpm115u_02.deletedcount() < 1 then
	//pass
else
	if dw_mpm115u_02.update() <> 1 then
		ls_message = "ERR02"
		goto RollBack_
	end if
end if

Commit using sqlmpms;
sqlmpms.Autocommit = True

uo_status.st_message.text = '저장되었습니다.'
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.AutoCommit = True

choose case ls_message
	case 'ERR01'
		uo_status.st_message.text = "단말기정보등록시에 에러가 발생하였습니다."
	case 'ERR02'
		uo_status.st_message.text = "작업장정보등록시에 에러가 발생하였습니다."
end choose

return 0
end event

event ue_delete;call super::ue_delete;long ll_selrow, ll_count
string ls_code

ll_selrow = id_dw_current.getselectedrow(0)
if ll_selrow < 1 then
	uo_status.st_message.text = "선택된 데이타가 없습니다."
	return 0
end if

choose case id_dw_current.dataobject
	case 'd_mpm115u_01'
		ls_code = id_dw_current.getitemstring(ll_selrow,"trmcode")
		
		SELECT COUNT(*) INTO :ll_count
		FROM TTERMINALWORKGROUP
		WHERE TrmCode = :ls_code
		using sqlmpms;
		
		if ll_count > 0 then
			uo_status.st_message.text = "단말기/작업장정보가 존재합니다."
			return 0
		else
			id_dw_current.deleterow(ll_selrow)
		end if
	case 'd_mpm115u_02'
		ls_code = id_dw_current.getitemstring(ll_selrow,"wgcode")
		
		SELECT COUNT(*) INTO :ll_count
		FROM TTERMINALWORKGROUP
		WHERE WgCode = :ls_code
		using sqlmpms;
		
		if ll_count > 0 then
			uo_status.st_message.text = "단말기/작업장정보가 존재합니다."
			return 0
		else
			id_dw_current.deleterow(ll_selrow)
		end if
end choose

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm115u
end type

type dw_mpm115u_01 from u_vi_std_datawindow within w_mpm115u
integer x = 23
integer y = 124
integer width = 1166
integer height = 844
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm115u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;id_dw_current = this
end event

type dw_mpm115u_02 from u_vi_std_datawindow within w_mpm115u
integer x = 1632
integer y = 124
integer width = 1367
integer height = 860
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mpm115u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;id_dw_current = this
end event

type st_1 from statictext within w_mpm115u
integer x = 27
integer y = 28
integer width = 489
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 128
string text = "단말기정보"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_2 from statictext within w_mpm115u
integer x = 1650
integer y = 32
integer width = 489
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 128
string text = "작업장정보"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_3 from statictext within w_mpm115u
integer x = 23
integer y = 1060
integer width = 631
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 128
string text = "단말기/작업장"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type pb_delete from picturebutton within w_mpm115u
integer x = 1134
integer y = 1040
integer width = 315
integer height = 120
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\맨앞.bmp"
end type

event clicked;integer li_selectrow
string ls_message, ls_trmcode, ls_wgcode

li_selectrow = dw_mpm115u_03.getselectedrow(0)

if li_selectrow < 1 then
	uo_status.st_message.text = "연결을 취소할  작업장/단말기를 선택해 주십시요."
	return 0
end if

ls_trmcode = dw_mpm115u_03.getitemstring(li_selectrow,"trmcode")
ls_wgcode = dw_mpm115u_03.getitemstring(li_selectrow,"wgcode")

sqlmpms.Autocommit = False

DELETE FROM TTERMINALWORKGROUP
WHERE TrmCode = :ls_trmcode AND WgCode = :ls_wgcode
using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	ls_message = "ERR01"
	goto RollBack_
end if

Commit using sqlmpms;
sqlmpms.Autocommit = True

iw_this.Triggerevent("ue_retrieve")

uo_status.st_message.text = '단말기/작업장 정보에서 삭제되었습니다.'
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.AutoCommit = True

choose case ls_message
	case 'ERR01'
		uo_status.st_message.text = "삭제시에 에러가 발생하였습니다."
	case 'ERR02'
		uo_status.st_message.text = "삭제시에 에러가 발생하였습니다."
end choose

return 0
end event

type pb_add from picturebutton within w_mpm115u
integer x = 773
integer y = 1040
integer width = 315
integer height = 120
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\맨뒤.bmp"
end type

event clicked;integer li_select_trm, li_select_wg, li_count
string ls_message, ls_trmcode, ls_wgcode

li_select_trm = dw_mpm115u_01.getselectedrow(0)
li_select_wg = dw_mpm115u_02.getselectedrow(0)

if li_select_trm < 1 or li_select_wg < 1 then
	uo_status.st_message.text = "연결할 작업장과 단말기를 선택해 주십시요."
	return 0
end if

ls_trmcode = dw_mpm115u_01.getitemstring(li_select_trm,"trmcode")
ls_wgcode = dw_mpm115u_02.getitemstring(li_select_wg,"wgcode")

SELECT COUNT(*) INTO :li_count
FROM TTERMINALWORKGROUP
WHERE TrmCode = :ls_trmcode AND WgCode = :ls_wgcode
using sqlmpms;

if li_count = 1 then
	uo_status.st_message.text = "연결할 작업장과 단말기가 이미 존재합니다."
	return 0
end if

sqlmpms.Autocommit = False

INSERT INTO TTERMINALWORKGROUP( TrmCode, WgCode, LastEmp )
VALUES( :ls_trmcode, :ls_wgcode, :g_s_empno )
using sqlmpms;

if sqlmpms.sqlcode <> 0 then
	ls_message = "ERR01"
	goto RollBack_
end if

Commit using sqlmpms;
sqlmpms.Autocommit = True

iw_this.Triggerevent("ue_retrieve")

uo_status.st_message.text = '단말기/작업장 정보에 추가되었습니다.'
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.AutoCommit = True

choose case ls_message
	case 'ERR01'
		uo_status.st_message.text = "등록시에 에러가 발생하였습니다."
	case 'ERR02'
		uo_status.st_message.text = "등록시에 에러가 발생하였습니다."
end choose

return 0
end event

type dw_mpm115u_03 from u_vi_std_datawindow within w_mpm115u
integer x = 37
integer y = 1172
integer width = 2958
integer height = 692
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mpm115u_03"
boolean hscrollbar = true
boolean vscrollbar = true
end type

