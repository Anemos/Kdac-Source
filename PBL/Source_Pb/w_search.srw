$PBExportHeader$w_search.srw
$PBExportComments$가동율(시간별,일자별,모델별) 조회
forward
global type w_search from window
end type
type pb_setup from picturebutton within w_search
end type
type pb_close from picturebutton within w_search
end type
type st_5 from statictext within w_search
end type
type tab_1 from tab within w_search
end type
type tabpage_1 from userobject within tab_1
end type
type pb_time_excel from picturebutton within tabpage_1
end type
type st_8 from statictext within tabpage_1
end type
type st_7 from statictext within tabpage_1
end type
type dw_time_night from datawindow within tabpage_1
end type
type pb_search_time from picturebutton within tabpage_1
end type
type dw_time_day from datawindow within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type uo_date_time from uo_today_over within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
pb_time_excel pb_time_excel
st_8 st_8
st_7 st_7
dw_time_night dw_time_night
pb_search_time pb_search_time
dw_time_day dw_time_day
st_1 st_1
uo_date_time uo_date_time
gb_1 gb_1
end type
type tabpage_2 from userobject within tab_1
end type
type pb_date_excel from picturebutton within tabpage_2
end type
type pb_search_date from picturebutton within tabpage_2
end type
type dw_date from datawindow within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type uo_date_day_to from uo_today_over within tabpage_2
end type
type uo_date_day_from from uo_today_over within tabpage_2
end type
type gb_2 from groupbox within tabpage_2
end type
type tabpage_2 from userobject within tab_1
pb_date_excel pb_date_excel
pb_search_date pb_search_date
dw_date dw_date
st_3 st_3
st_2 st_2
uo_date_day_to uo_date_day_to
uo_date_day_from uo_date_day_from
gb_2 gb_2
end type
type tabpage_3 from userobject within tab_1
end type
type pb_model_excel from picturebutton within tabpage_3
end type
type pb_search_model from picturebutton within tabpage_3
end type
type dw_model from datawindow within tabpage_3
end type
type st_6 from statictext within tabpage_3
end type
type st_4 from statictext within tabpage_3
end type
type uo_date_model_to from uo_today_over within tabpage_3
end type
type uo_date_model_from from uo_today_over within tabpage_3
end type
type gb_3 from groupbox within tabpage_3
end type
type tabpage_3 from userobject within tab_1
pb_model_excel pb_model_excel
pb_search_model pb_search_model
dw_model dw_model
st_6 st_6
st_4 st_4
uo_date_model_to uo_date_model_to
uo_date_model_from uo_date_model_from
gb_3 gb_3
end type
type tab_1 from tab within w_search
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_search from window
integer width = 4718
integer height = 3060
boolean titlebar = true
string title = "가동율 조회"
boolean controlmenu = true
windowtype windowtype = popup!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "Form!"
boolean center = true
pb_setup pb_setup
pb_close pb_close
st_5 st_5
tab_1 tab_1
end type
global w_search w_search

type variables
String	is_time_dt								// 시간대별 선택일자 
String	is_date_fromdt, is_date_todt		// 일자별 선택일자 
String	is_model_fromdt, is_model_todt	// 모델별 선택일자 




end variables

forward prototypes
public subroutine wf_sum_current_rate ()
end prototypes

public subroutine wf_sum_current_rate ();// 금일 가동율 집계처리
// 
String	ls_DAY_START_TIME, ls_YMD, ls_errortext 
Long 		ll_errorcode


SetPointer(HourGlass!)

// 주간 SHIFT 시작시간을 조회 
// 
SELECT LEFT(REMARK,5)
  INTO :ls_DAY_START_TIME
  FROM TM_CODE
 WHERE MCD = '10'
  AND  SCD = '1';


// 주간시작 이전은 전일 날짜로 처리 
// 
If String(Now(), 'hh:mm') <= ls_DAY_START_TIME Then
	ls_YMD = String(RelativeDate(today(), -1), 'yyyymmdd')
Else
	ls_YMD = String(today(), 'yyyymmdd')
End if

// 가동율 집계처리 
// 
DECLARE SP_JOB_DATA_SUM PROCEDURE FOR SP_JOB_DATA_SUM
		@parm_YMD	= :ls_YMD,
		@parm_TYPE	= 'T';						
		
EXECUTE SP_JOB_DATA_SUM;
		
ll_errorcode = SQLCA.SQLCode
ls_errortext = SQLCA.SQLErrText

CLOSE SP_JOB_DATA_SUM;

SetPointer(Arrow!)
end subroutine

on w_search.create
this.pb_setup=create pb_setup
this.pb_close=create pb_close
this.st_5=create st_5
this.tab_1=create tab_1
this.Control[]={this.pb_setup,&
this.pb_close,&
this.st_5,&
this.tab_1}
end on

on w_search.destroy
destroy(this.pb_setup)
destroy(this.pb_close)
destroy(this.st_5)
destroy(this.tab_1)
end on

event open;
// 현재시간까지의 금일 가동율 집계처리 
wf_sum_current_rate()

end event

type pb_setup from picturebutton within w_search
integer x = 14
integer y = 2680
integer width = 3776
integer height = 292
integer taborder = 30
integer textsize = -26
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string pointer = "HyperLink!"
string text = "설정"
string picturename = ".\IMAGE\Button.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 설정버턴 클릭시
//		비밀번호 입력화면으로 이동
// 
Open(w_check_pass)



end event

type pb_close from picturebutton within w_search
integer x = 3799
integer y = 2680
integer width = 873
integer height = 304
integer taborder = 30
integer textsize = -26
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string pointer = "HyperLink!"
string text = "닫기"
string picturename = ".\IMAGE\Button.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 닫기 
Close(Parent) 


end event

type st_5 from statictext within w_search
integer y = 2656
integer width = 4690
integer height = 352
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 0
boolean focusrectangle = false
end type

type tab_1 from tab within w_search
integer x = 55
integer y = 28
integer width = 4594
integer height = 2608
integer taborder = 10
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 196
integer width = 4558
integer height = 2396
long backcolor = 67108864
string text = "  시간대별  "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
pb_time_excel pb_time_excel
st_8 st_8
st_7 st_7
dw_time_night dw_time_night
pb_search_time pb_search_time
dw_time_day dw_time_day
st_1 st_1
uo_date_time uo_date_time
gb_1 gb_1
end type

on tabpage_1.create
this.pb_time_excel=create pb_time_excel
this.st_8=create st_8
this.st_7=create st_7
this.dw_time_night=create dw_time_night
this.pb_search_time=create pb_search_time
this.dw_time_day=create dw_time_day
this.st_1=create st_1
this.uo_date_time=create uo_date_time
this.gb_1=create gb_1
this.Control[]={this.pb_time_excel,&
this.st_8,&
this.st_7,&
this.dw_time_night,&
this.pb_search_time,&
this.dw_time_day,&
this.st_1,&
this.uo_date_time,&
this.gb_1}
end on

on tabpage_1.destroy
destroy(this.pb_time_excel)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.dw_time_night)
destroy(this.pb_search_time)
destroy(this.dw_time_day)
destroy(this.st_1)
destroy(this.uo_date_time)
destroy(this.gb_1)
end on

type pb_time_excel from picturebutton within tabpage_1
integer x = 1243
integer y = 60
integer width = 347
integer height = 156
integer taborder = 50
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string pointer = "HyperLink!"
string text = " EXCEL"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;String	ls_return, ls_filename, ls_fullpath
Integer	li_ok
String	ls_tmpfile
Integer	li_pos

ls_fullpath	= "시간대별 가동율-주간" 
ls_fullpath = f_replace_string(ls_fullpath)
li_ok = GetFileSaveName(" Save As File Name", ls_fullpath, ls_filename, "XLS", "Excel Files (*.XLS),*.XLS")

IF li_ok = 1 THEN
	li_pos		= Pos(ls_fullpath, '.XLS', 1)
	ls_tmpfile	= Replace(ls_fullpath, li_pos, 4, '.TXT')	
	
	If dw_time_day.SaveAsAscii(ls_tmpfile, "~t" , "") = 1 Then
		If f_file_convert('1', ls_tmpfile, ls_fullpath) = True Then
			MessageBox("Save OK", "File Save Success", Information!)
		Else
			MessageBox("File Convert", "Data does not saved as file!", StopSign!)
		End If
		FileDelete(ls_tmpfile)
	Else
		MessageBox("File Save Error", "Data does not saved as file!", StopSign!)
	End If
Else
	//Cancel
	MessageBox("Cancel", "File save is canceled!", Information!)
	Return
End If

ls_fullpath	= "시간대별 가동율-야간" 
ls_fullpath = f_replace_string(ls_fullpath)
li_ok = GetFileSaveName(" Save As File Name", ls_fullpath, ls_filename, "XLS", "Excel Files (*.XLS),*.XLS")

IF li_ok = 1 THEN
	li_pos		= Pos(ls_fullpath, '.XLS', 1)
	ls_tmpfile	= Replace(ls_fullpath, li_pos, 4, '.TXT')	
	
	If dw_time_night.SaveAsAscii(ls_tmpfile, "~t" , "") = 1 Then
		If f_file_convert('1', ls_tmpfile, ls_fullpath) = True Then
			MessageBox("Save OK", "File Save Success", Information!)
		Else
			MessageBox("File Convert", "Data does not saved as file!", StopSign!)
		End If
		FileDelete(ls_tmpfile)
	Else
		MessageBox("File Save Error", "Data does not saved as file!", StopSign!)
	End If
Else
	//Cancel
	MessageBox("Cancel", "File save is canceled!", Information!)
	Return
End If
end event

type st_8 from statictext within tabpage_1
integer x = 2290
integer y = 264
integer width = 238
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "야간"
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_1
integer x = 37
integer y = 264
integer width = 238
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "주간"
boolean focusrectangle = false
end type

type dw_time_night from datawindow within tabpage_1
integer x = 2281
integer y = 368
integer width = 2240
integer height = 2000
integer taborder = 70
string title = "none"
string dataobject = "d_search_time"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_search_time from picturebutton within tabpage_1
integer x = 891
integer y = 60
integer width = 347
integer height = 156
integer taborder = 30
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string pointer = "HyperLink!"
string text = " 조회"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;// 시간대별 조회 

If is_time_dt = '' Then
	is_time_dt = String(today(), 'yyyymmdd')
End If

SetPointer(HourGlass!)

// 주간 
dw_time_day.SetTransObject(SQLCA)
dw_time_day.SetRedraw(False)
dw_time_day.Reset()
dw_time_day.Retrieve(is_time_dt, '1')
dw_time_day.SetRedraw(True)

// 야간 
dw_time_night.SetTransObject(SQLCA)
dw_time_night.SetRedraw(False)
dw_time_night.Reset()
dw_time_night.Retrieve(is_time_dt, '2')
dw_time_night.SetRedraw(True)

SetPointer(Arrow!)


end event

type dw_time_day from datawindow within tabpage_1
integer x = 23
integer y = 368
integer width = 2217
integer height = 2000
integer taborder = 60
string title = "none"
string dataobject = "d_search_time"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within tabpage_1
integer x = 73
integer y = 84
integer width = 352
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "기준일자: "
boolean focusrectangle = false
end type

type uo_date_time from uo_today_over within tabpage_1
integer x = 425
integer y = 92
integer taborder = 50
end type

on uo_date_time.destroy
call uo_today_over::destroy
end on

event ue_valid_check;call super::ue_valid_check;String	ls_tempdate

ls_tempdate	= This.sle_date.Text
is_time_dt	= Mid(ls_tempdate, 1, 4) + &
				  Mid(ls_tempdate, 6, 2) + &
				  Mid(ls_tempdate, 9, 2)

end event

type gb_1 from groupbox within tabpage_1
integer x = 18
integer width = 4507
integer height = 248
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 196
integer width = 4558
integer height = 2396
long backcolor = 67108864
string text = "  일자별  "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
pb_date_excel pb_date_excel
pb_search_date pb_search_date
dw_date dw_date
st_3 st_3
st_2 st_2
uo_date_day_to uo_date_day_to
uo_date_day_from uo_date_day_from
gb_2 gb_2
end type

on tabpage_2.create
this.pb_date_excel=create pb_date_excel
this.pb_search_date=create pb_search_date
this.dw_date=create dw_date
this.st_3=create st_3
this.st_2=create st_2
this.uo_date_day_to=create uo_date_day_to
this.uo_date_day_from=create uo_date_day_from
this.gb_2=create gb_2
this.Control[]={this.pb_date_excel,&
this.pb_search_date,&
this.dw_date,&
this.st_3,&
this.st_2,&
this.uo_date_day_to,&
this.uo_date_day_from,&
this.gb_2}
end on

on tabpage_2.destroy
destroy(this.pb_date_excel)
destroy(this.pb_search_date)
destroy(this.dw_date)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.uo_date_day_to)
destroy(this.uo_date_day_from)
destroy(this.gb_2)
end on

type pb_date_excel from picturebutton within tabpage_2
integer x = 1737
integer y = 60
integer width = 347
integer height = 156
integer taborder = 60
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string pointer = "HyperLink!"
string text = " EXCEL"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;String	ls_return, ls_filename, ls_fullpath
Integer	li_ok
String	ls_tmpfile
Integer	li_pos

ls_fullpath	= "일자별 가동율" 
ls_fullpath = f_replace_string(ls_fullpath)
li_ok = GetFileSaveName(" Save As File Name", ls_fullpath, ls_filename, "XLS", "Excel Files (*.XLS),*.XLS")

IF li_ok = 1 THEN
	li_pos		= Pos(ls_fullpath, '.XLS', 1)
	ls_tmpfile	= Replace(ls_fullpath, li_pos, 4, '.TXT')	
	
	If dw_date.SaveAsAscii(ls_tmpfile, "~t" , "") = 1 Then
		If f_file_convert('1', ls_tmpfile, ls_fullpath) = True Then
			MessageBox("Save OK", "File Save Success", Information!)
		Else
			MessageBox("File Convert", "Data does not saved as file!", StopSign!)
		End If
		FileDelete(ls_tmpfile)
	Else
		MessageBox("File Save Error", "Data does not saved as file!", StopSign!)
	End If	
Else
	//Cancel
	MessageBox("Cancel", "File save is canceled!", Information!)
	Return
End If
end event

type pb_search_date from picturebutton within tabpage_2
integer x = 1385
integer y = 60
integer width = 347
integer height = 156
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string pointer = "HyperLink!"
string text = " 조회"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;// 일자별 조회  

If is_date_fromdt = '' Then
	is_date_fromdt = String(today(), 'yyyymmdd')
End If
If is_date_todt = '' Then
	is_date_todt = String(today(), 'yyyymmdd')
End If

SetPointer(HourGlass!)

dw_date.SetTransObject(SQLCA)
dw_date.SetRedraw(False)
dw_date.Reset()
dw_date.Retrieve(is_date_fromdt, is_date_todt)
dw_date.SetRedraw(True)

SetPointer(Arrow!)



end event

type dw_date from datawindow within tabpage_2
integer x = 23
integer y = 256
integer width = 4507
integer height = 2104
integer taborder = 70
string title = "none"
string dataobject = "d_search_date"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within tabpage_2
integer x = 855
integer y = 84
integer width = 59
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "~~"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_2
integer x = 73
integer y = 84
integer width = 352
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "기준일자: "
boolean focusrectangle = false
end type

type uo_date_day_to from uo_today_over within tabpage_2
integer x = 914
integer y = 92
integer taborder = 40
end type

on uo_date_day_to.destroy
call uo_today_over::destroy
end on

event ue_valid_check;call super::ue_valid_check;String	ls_tempdate

ls_tempdate		= This.sle_date.Text
is_date_todt	= Mid(ls_tempdate, 1, 4) + &
				  	  Mid(ls_tempdate, 6, 2) + &
				     Mid(ls_tempdate, 9, 2)

end event

type uo_date_day_from from uo_today_over within tabpage_2
integer x = 425
integer y = 92
integer taborder = 40
end type

on uo_date_day_from.destroy
call uo_today_over::destroy
end on

event ue_valid_check;call super::ue_valid_check;String	ls_tempdate

ls_tempdate		= This.sle_date.Text
is_date_fromdt	= Mid(ls_tempdate, 1, 4) + &
				  	  Mid(ls_tempdate, 6, 2) + &
				     Mid(ls_tempdate, 9, 2)

end event

type gb_2 from groupbox within tabpage_2
integer x = 18
integer width = 4507
integer height = 248
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 196
integer width = 4558
integer height = 2396
long backcolor = 67108864
string text = "  모델별  "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
pb_model_excel pb_model_excel
pb_search_model pb_search_model
dw_model dw_model
st_6 st_6
st_4 st_4
uo_date_model_to uo_date_model_to
uo_date_model_from uo_date_model_from
gb_3 gb_3
end type

on tabpage_3.create
this.pb_model_excel=create pb_model_excel
this.pb_search_model=create pb_search_model
this.dw_model=create dw_model
this.st_6=create st_6
this.st_4=create st_4
this.uo_date_model_to=create uo_date_model_to
this.uo_date_model_from=create uo_date_model_from
this.gb_3=create gb_3
this.Control[]={this.pb_model_excel,&
this.pb_search_model,&
this.dw_model,&
this.st_6,&
this.st_4,&
this.uo_date_model_to,&
this.uo_date_model_from,&
this.gb_3}
end on

on tabpage_3.destroy
destroy(this.pb_model_excel)
destroy(this.pb_search_model)
destroy(this.dw_model)
destroy(this.st_6)
destroy(this.st_4)
destroy(this.uo_date_model_to)
destroy(this.uo_date_model_from)
destroy(this.gb_3)
end on

type pb_model_excel from picturebutton within tabpage_3
integer x = 1733
integer y = 60
integer width = 347
integer height = 156
integer taborder = 60
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string pointer = "HyperLink!"
string text = " EXCEL"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;
String	ls_return, ls_filename, ls_fullpath
Integer	li_ok
String	ls_tmpfile
Integer	li_pos

ls_fullpath	= "모델별 가동율" 
ls_fullpath = f_replace_string(ls_fullpath)
li_ok = GetFileSaveName(" Save As File Name", ls_fullpath, ls_filename, "XLS", "Excel Files (*.XLS),*.XLS")

IF li_ok = 1 THEN
	li_pos		= Pos(ls_fullpath, '.XLS', 1)
	ls_tmpfile	= Replace(ls_fullpath, li_pos, 4, '.TXT')	
	
	If dw_model.SaveAsAscii(ls_tmpfile, "~t" , "") = 1 Then
		If f_file_convert('1', ls_tmpfile, ls_fullpath) = True Then
			MessageBox("Save OK", "File Save Success", Information!)
		Else
			MessageBox("File Convert", "Data does not saved as file!", StopSign!)
		End If
		FileDelete(ls_tmpfile)
	Else
		MessageBox("File Save Error", "Data does not saved as file!", StopSign!)
	End If	
Else
	//Cancel
	MessageBox("Cancel", "File save is canceled!", Information!)
	Return
End If
end event

type pb_search_model from picturebutton within tabpage_3
integer x = 1385
integer y = 60
integer width = 347
integer height = 156
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string pointer = "HyperLink!"
string text = " 조회"
string picturename = ".\IMAGE\button-02.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;// 모델별 조회  

If is_model_fromdt = '' Then
	is_model_fromdt = String(today(), 'yyyymmdd')
End If
If is_model_todt = '' Then
	is_model_todt = String(today(), 'yyyymmdd')
End If

SetPointer(HourGlass!)

dw_model.SetTransObject(SQLCA)
dw_model.SetRedraw(False)
dw_model.Reset()
dw_model.Retrieve(is_model_fromdt, is_model_todt)
dw_model.SetRedraw(True)

SetPointer(Arrow!)


end event

type dw_model from datawindow within tabpage_3
integer x = 23
integer y = 256
integer width = 4507
integer height = 1964
integer taborder = 80
string title = "none"
string dataobject = "d_search_model"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within tabpage_3
integer x = 855
integer y = 84
integer width = 59
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "~~"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_3
integer x = 73
integer y = 84
integer width = 352
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
string text = "기준일자: "
boolean focusrectangle = false
end type

type uo_date_model_to from uo_today_over within tabpage_3
integer x = 914
integer y = 92
integer taborder = 50
end type

on uo_date_model_to.destroy
call uo_today_over::destroy
end on

event ue_valid_check;call super::ue_valid_check;String	ls_tempdate

ls_tempdate		= This.sle_date.Text
is_model_todt	= Mid(ls_tempdate, 1, 4) + &
				  	  Mid(ls_tempdate, 6, 2) + &
				     Mid(ls_tempdate, 9, 2)

end event

type uo_date_model_from from uo_today_over within tabpage_3
integer x = 425
integer y = 92
integer taborder = 40
end type

on uo_date_model_from.destroy
call uo_today_over::destroy
end on

event ue_valid_check;call super::ue_valid_check;String	ls_tempdate

ls_tempdate			= This.sle_date.Text
is_model_fromdt	= Mid(ls_tempdate, 1, 4) + &
				  	  	  Mid(ls_tempdate, 6, 2) + &
				     	  Mid(ls_tempdate, 9, 2)

end event

type gb_3 from groupbox within tabpage_3
integer x = 18
integer width = 4507
integer height = 248
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 67108864
end type

