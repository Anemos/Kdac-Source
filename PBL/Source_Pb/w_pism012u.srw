$PBExportHeader$w_pism012u.srw
$PBExportComments$일일근태내역
forward
global type w_pism012u from w_pism_resp01
end type
type ids_tmhlabtac from datawindow within w_pism012u
end type
type ids_labtac from datawindow within w_pism012u
end type
type cb_labtac from commandbutton within w_pism012u
end type
type cb_remakedaily from commandbutton within w_pism012u
end type
type st_wcname from statictext within w_pism012u
end type
type st_wccode from statictext within w_pism012u
end type
type st_2 from statictext within w_pism012u
end type
type cb_close from commandbutton within w_pism012u
end type
type st_wday from statictext within w_pism012u
end type
type st_1 from statictext within w_pism012u
end type
type gb_1 from groupbox within w_pism012u
end type
type dw_labtac from u_pism_dw within w_pism012u
end type
type gb_2 from groupbox within w_pism012u
end type
end forward

global type w_pism012u from w_pism_resp01
integer width = 3886
integer height = 2500
string title = "일일근태 내역"
ids_tmhlabtac ids_tmhlabtac
ids_labtac ids_labtac
cb_labtac cb_labtac
cb_remakedaily cb_remakedaily
st_wcname st_wcname
st_wccode st_wccode
st_2 st_2
cb_close cb_close
st_wday st_wday
st_1 st_1
gb_1 gb_1
dw_labtac dw_labtac
gb_2 gb_2
end type
global w_pism012u w_pism012u

type variables
Constant String MKLABTACOK = '1', MKDAILYOK = '2', MKLABTACNOT = '3', MKDAILYNOT = '4' 
end variables

on w_pism012u.create
int iCurrent
call super::create
this.ids_tmhlabtac=create ids_tmhlabtac
this.ids_labtac=create ids_labtac
this.cb_labtac=create cb_labtac
this.cb_remakedaily=create cb_remakedaily
this.st_wcname=create st_wcname
this.st_wccode=create st_wccode
this.st_2=create st_2
this.cb_close=create cb_close
this.st_wday=create st_wday
this.st_1=create st_1
this.gb_1=create gb_1
this.dw_labtac=create dw_labtac
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ids_tmhlabtac
this.Control[iCurrent+2]=this.ids_labtac
this.Control[iCurrent+3]=this.cb_labtac
this.Control[iCurrent+4]=this.cb_remakedaily
this.Control[iCurrent+5]=this.st_wcname
this.Control[iCurrent+6]=this.st_wccode
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.st_wday
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.dw_labtac
this.Control[iCurrent+13]=this.gb_2
end on

on w_pism012u.destroy
call super::destroy
destroy(this.ids_tmhlabtac)
destroy(this.ids_labtac)
destroy(this.cb_labtac)
destroy(this.cb_remakedaily)
destroy(this.st_wcname)
destroy(this.st_wccode)
destroy(this.st_2)
destroy(this.cb_close)
destroy(this.st_wday)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.dw_labtac)
destroy(this.gb_2)
end on

event resize;call super::resize;dw_labtac.Width = newwidth - ( dw_labtac.x + 10 )
dw_labtac.Height = newheight - ( dw_labtac.y + 10 )

cb_labtac.x = dw_labtac.x + dw_labtac.Width - ( cb_labtac.width + cb_remakedaily.width + cb_close.Width + 10 )
cb_remakedaily.x = dw_labtac.x + dw_labtac.Width - ( cb_remakedaily.width + cb_close.Width + 10 ) 
cb_close.x = dw_labtac.x + dw_labtac.Width - ( cb_close.Width + 10 )
end event

event open;call super::open;
st_wday.Text = istr_mh.wday 
st_wccode.Text = istr_mh.wc; st_wcname.Text = f_pism_getwcname(istr_mh) 
If istr_mh.dailyStatus = MKDAILYOK Then 
	cb_remakedaily.Enabled = m_frame.m_action.m_save.Enabled 
 	cb_labtac.Enabled      = m_frame.m_action.m_save.Enabled
end if

This.TriggerEvent("ue_retrieve")

end event

event ue_retrieve;call super::ue_retrieve;dw_labtac.SetTransObject(SqlPIS)
dw_labtac.reset()
dw_labtac.Retrieve( istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday ) 
end event

type ids_tmhlabtac from datawindow within w_pism012u
boolean visible = false
integer x = 1696
integer y = 832
integer width = 686
integer height = 400
integer taborder = 50
string title = "none"
string dataobject = "d_pism012u_tmhlabtac"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlpis)
end event

type ids_labtac from datawindow within w_pism012u
boolean visible = false
integer x = 1719
integer y = 356
integer width = 686
integer height = 400
integer taborder = 40
string title = "none"
string dataobject = "d_pism012u_labtac"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_labtac from commandbutton within w_pism012u
integer x = 2249
integer y = 44
integer width = 526
integer height = 88
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "근태정보생성"
end type

event clicked;if isnull(sqlca.dbhandle()) or sqlca.dbhandle() <= 0 then
	messagebox("확인","현재 KDAC 시스템이 사용불가 상태이므로 근태 정보를 생성할 수 없습니다")
	return 1
end if 

long ll_retrieve,i
string ls_day

ls_day = mid(istr_mh.wday,1,4) + mid(istr_mh.wday,6,2) + mid(istr_mh.wday,9,2) 
ll_retrieve = ids_labtac.retrieve( istr_mh.wc,ls_day )
if ll_retrieve < 1 then
	messagebox("확인", string(istr_mh.wday) + " 일자의 근태 정보가 확정되지 않았습니다")
	destroy ids_labtac 
	return 1
end if
SqlPIS.AutoCommit = False 
delete from tmhlabtac
	where dgdepte = :istr_mh.wc  and dgday = :istr_mh.wday 
using sqlpis ;
// Clipboard 방식
//ids_labtac.SaveAs("", Clipboard!, False)
//ids_tmhlabtac.ImportClipboard()
// Reference 방식
ids_tmhlabtac.object.data = ids_labtac.object.data
if ids_tmhlabtac.update() = 1 then
   Update TMHLABTAC 
   Set excFlag = Case IsNull(A.excFlag,'') When '0' Then '' Else IsNull(A.excFlag,'') End  
    FROM TMHDAILYEXCEMP A, 
         TMHLABTAC B  
   WHERE ( B.DGEMPNO *= A.excEmpNo ) and  
         ( B.DGDEPTE *= A.WorkCenter ) and  
         ( ( A.AreaCode = :istr_mh.area ) AND  
           ( A.DivisionCode = :istr_mh.div ) And 
           ( B.DGDEPTE = :istr_mh.wc ) And 
	        ( B.DGDAY = :istr_mh.wday ) )
	using sqlpis ;
	if sqlpis.sqlcode = 0 then
		commit using sqlpis;
	else
		rollback using sqlpis;
		SqlPIS.AutoCommit = true
		f_pism_messagebox(Information!, 999, "작업오류", String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + st_wcname.Text + " 조~n~n" + & 
											 "의 근태정보 Upload 실패 ") 
		return 1
	end if
else
	rollback using sqlpis;
	SqlPIS.AutoCommit = true
	f_pism_messagebox(Information!, 999, "작업오류", String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + st_wcname.Text + " 조~n~n" + & 
											 "의 근태정보 Upload 실패 ") 
	return 1
end if
SqlPIS.AutoCommit = true
Parent.TriggerEvent("ue_retrieve")
cb_remakedaily.triggerevent("clicked")

end event

type cb_remakedaily from commandbutton within w_pism012u
integer x = 2775
integer y = 44
integer width = 526
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "작업일보갱신"
end type

event clicked;Integer ll_error 

If f_pism_messagebox(Question!, 999, "작업일보갱신", String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + st_wcname.Text + " 조~n~n" + & 
												 "의 작업일보를 갱신하시겠습니까?") <> 1 Then Return 

SqlPIS.AutoCommit = False 

f_pism_working_msg(String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + &
						 st_wcname.Text + " 조", "작업일보를 갱신중입니다. 잠시만 기다려 주십시오.") 

//ll_error = sqlPIS.sp_pism010u_loadLabTac(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday) 
If f_pism_loadlabtac(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday, g_s_empno) = -1 Then Goto Exit_pr 
If IsValid(w_pism_working) Then Close(w_pism_working) 
f_pism_messagebox(Information!, 999, "작업완료", String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + st_wcname.Text + " 조~n~n" + & 
												 "의 작업일보 갱신을 완료하였습니다.") 	

CloseWithReturn(Parent, '1') 

Return 

Exit_pr:
If IsValid(w_pism_working) Then Close(w_pism_working) 
f_pism_messagebox(Information!, 999, "작업오류", String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + st_wcname.Text + " 조~n~n" + & 
											 "의 작업일보 갱신에 실패하였습니다. ") 

end event

type st_wcname from statictext within w_pism012u
integer x = 457
integer y = 48
integer width = 709
integer height = 76
integer textsize = -10
integer weight = 700
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

type st_wccode from statictext within w_pism012u
integer x = 197
integer y = 48
integer width = 261
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pism012u
integer x = 64
integer y = 60
integer width = 142
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조:"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_pism012u
integer x = 3305
integer y = 44
integer width = 526
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;Close(Parent) 
end event

type st_wday from statictext within w_pism012u
integer x = 1591
integer y = 48
integer width = 421
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_pism012u
integer x = 1262
integer y = 60
integer width = 338
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "작업일자:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_pism012u
integer x = 1230
integer width = 809
integer height = 140
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_labtac from u_pism_dw within w_pism012u
integer x = 14
integer y = 148
integer width = 3826
integer height = 1852
integer taborder = 30
string dataobject = "d_pism010u_07"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 1
end type

event save_data;call super::save_data;Return f_pism_dwupdate(This, False) 
end event

type gb_2 from groupbox within w_pism012u
integer x = 14
integer width = 1211
integer height = 140
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

