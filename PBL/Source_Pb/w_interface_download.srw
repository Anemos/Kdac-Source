$PBExportHeader$w_interface_download.srw
$PBExportComments$Interface main
forward
global type w_interface_download from window
end type
type dw_2 from datawindow within w_interface_download
end type
type dw_1 from datawindow within w_interface_download
end type
type dw_interface from datawindow within w_interface_download
end type
type st_horizontal from u_st_horizontal within w_interface_download
end type
type uo_option from u_interface_option within w_interface_download
end type
type uo_pipe from u_interface_error within w_interface_download
end type
type uo_button from u_interface_button within w_interface_download
end type
type st_vertical from u_st_vertical within w_interface_download
end type
type uo_parameter from u_parameter_set within w_interface_download
end type
type st_date from statictext within w_interface_download
end type
type uo_date from u_today within w_interface_download
end type
type ddlb_1 from dropdownlistbox within w_interface_download
end type
end forward

global type w_interface_download from window
integer width = 3909
integer height = 1592
boolean titlebar = true
string title = "Interface - Download"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event ue_postopen pbm_custom01
dw_2 dw_2
dw_1 dw_1
dw_interface dw_interface
st_horizontal st_horizontal
uo_option uo_option
uo_pipe uo_pipe
uo_button uo_button
st_vertical st_vertical
uo_parameter uo_parameter
st_date st_date
uo_date uo_date
ddlb_1 ddlb_1
end type
global w_interface_download w_interface_download

type variables
int ii_error_num = 9300
int ii_window_border = 15
long il_hidden_color
int ii_first_y, ii_first_parameter_y, ii_first_pipe_y
boolean ib_max, ib_min, ib_open, ib_auto

int ii_interface_id

Transaction it_source, it_destination
p_pipe_wmeter ip_pipe

string is_action_name, is_interface_gubun
string is_applydate, is_yyyymmdd
long ii_yyyymmdd

boolean ib_upload_stop = False

string	is_sp_name
uo_transaction		mis_sp
boolean	ib_cancel = False, ib_interface = False

string	is_cycle, is_currentdate, is_currenttime
end variables

forward prototypes
public subroutine wf_resize_panel (integer fi_win_w, integer fi_win_h, integer fi_vertical_x)
public subroutine wf_resize_horizontal ()
public subroutine wf_upload_stop ()
public function boolean wf_upload_work (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_quality (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_worktime (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_lot (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_foillength (string fs_dataobject, ref string rs_return_option)
public function boolean wf_raiserror (string fs_pipeline_name)
public subroutine wf_dw_init (integer fs_option)
public function boolean wf_upload ()
public subroutine wf_resize_bar ()
public subroutine wf_disconnect ()
public subroutine wf_flag_update (string fs_action_name)
public function string wf_get_host_datetime ()
public function boolean wf_connect_check (ref transaction rt_source, ref transaction rt_destination)
public subroutine wf_download_stop ()
public function boolean wf_pipe_end_update (string fs_datetime)
public function boolean wf_last_execute_update (string fs_datetime)
public function boolean wf_download_sr ()
public function boolean wf_connect (string fs_ini_file, string fs_source, string fs_destination, ref transaction rt_source, ref transaction rt_destination)
protected function boolean wf_historymove (string fs_sp_name)
public function boolean wf_auto_download ()
public function boolean wf_download ()
public function boolean wf_exec_sp (string fs_sp_name)
public function boolean wf_flag_check (string fs_pipeline_name, ref string rs_action_name, ref string rs_fail_gubun)
public subroutine wf_email_warning ()
end prototypes

event ue_postopen;ib_open = True

If IsValid(w_select_inifile) Then
	Close(w_select_inifile)
End If

Update MSTFLAG
	Set Flag = 'N'
 Where ActionName like 'DOWNLOAD%';

// Horizontal Resize의 한계값을 설정한다.
// st_vertical의 Y 값이 아래 두값의 사이값일 경우에만 Resize  수행
ii_first_parameter_y = uo_parameter.Y + (uo_parameter.Height / 2)
ii_first_pipe_y		= uo_pipe.Y + (uo_pipe.Height / 2)

wf_connect(gs_ini_file, 'MIS', 'IPIS', it_source, it_destination)

end event

public subroutine wf_resize_panel (integer fi_win_w, integer fi_win_h, integer fi_vertical_x);int li_dw_w, li_dw_h, li_uo_x, li_uo_w
Int li_button_h, li_option_h, li_parameter_h, li_pipe_h
unsignedlong	sizetype

SetRedraw(False)

li_dw_w	= fi_vertical_x - ii_window_border
li_dw_h	= dw_interface.Height
dw_interface.Resize(li_dw_w, li_dw_h)

li_uo_x	= li_dw_w + (2 * ii_window_border)
li_uo_w	= fi_win_w - li_dw_w - (3 * ii_window_border)

li_button_h	= uo_button.Height
uo_button.Resize(li_uo_w, li_button_h)
uo_button.Move(li_uo_x, ii_window_border)

li_option_h	= uo_option.Height
uo_option.Resize(li_uo_w, li_option_h)

uo_option.Move(li_uo_x, li_button_h + (2 * ii_window_border))
uo_option.Post Event Resize(sizetype, li_uo_w, li_option_h)

li_parameter_h = uo_parameter.Height
uo_parameter.Resize(li_uo_w, li_parameter_h)
uo_parameter.Move(li_uo_x, li_button_h + li_option_h + (3 * ii_window_border))
uo_parameter.Post Event Resize(sizetype, li_uo_w, li_parameter_h)

st_horizontal.Resize(li_uo_w, ii_window_border)
st_horizontal.Move(li_uo_x, li_button_h + li_option_h + li_parameter_h + (3 * ii_window_border))

li_pipe_h	= fi_win_h - (li_button_h + li_option_h + li_parameter_h) - (5 * ii_window_border)
uo_pipe.Resize(li_uo_w, uo_pipe.Height)
uo_pipe.Move(li_uo_x, li_button_h + li_option_h + li_parameter_h + (4 * ii_window_border))

dw_1.Resize(li_uo_w, li_pipe_h - uo_pipe.Height - (2 * ii_window_border))
dw_1.Move(li_uo_x, uo_pipe.Y + uo_pipe.Height)

dw_2.Resize(li_uo_w, li_pipe_h - uo_pipe.Height - (2 * ii_window_border))
dw_2.Move(li_uo_x, uo_pipe.Y + uo_pipe.Height)

uo_date.Move(dw_2.X + dw_2.Width - uo_date.Width - 200 - ii_window_border, dw_2.Y - uo_date.Height - 24)
st_date.Move(dw_2.X + dw_2.Width - uo_date.Width - st_date.Width - 200 - (2 * ii_window_border), uo_date.Y + 16)

st_vertical.SetPosition(ToTop!)
st_horizontal.SetPosition(ToTop!)

SetRedraw(True)

end subroutine

public subroutine wf_resize_horizontal ();Int	li_uo_w, li_uo_h, li_horizontal_y, li_change
Unsignedlong sizetype

SetRedraw(False)

li_uo_w = uo_parameter.Width
li_horizontal_y	= st_horizontal.Y

If li_horizontal_y >= ii_first_parameter_y And li_horizontal_y <= ii_first_pipe_y Then
	li_change = li_horizontal_y - ii_first_y

	li_uo_h = uo_parameter.Height + li_change

	uo_parameter.Resize(li_uo_w, li_uo_h)
	uo_parameter.Post Event Resize(sizetype, li_uo_w, li_uo_h)

	uo_pipe.Move(uo_pipe.X, uo_pipe.Y + li_change)
	dw_1.Resize(dw_1.Width, dw_1.Height - li_change)
	dw_1.Move(dw_1.X, dw_1.Y + li_change)

	dw_2.Resize(dw_2.Width, dw_2.Height - li_change)
	dw_2.Move(dw_2.X, dw_2.Y + li_change)

	uo_date.Move(dw_2.X + dw_2.Width - uo_date.Width - 200 - ii_window_border, dw_2.Y - uo_date.Height - 24)
	st_date.Move(dw_2.X + dw_2.Width - uo_date.Width - st_date.Width - 200 - (2 * ii_window_border), uo_date.Y + 16)

//	uo_pipe.Post Event Resize(sizetype, li_uo_w, uo_pipe.Height - li_change)
// 위와 같이 사용해서는 안된다. Post Event 의 경우 현재의 Script가 종료하고 난 이후에
// 수행을 하기 때문에..위와 같이 하면 현재의 Height 값으로 Risize를 수행해야 되는데....
// 이미 Height 가 변하고 난 후에 uo_pipe.Height를 계산해서 Resize를 수행하게 된다...
Else
	st_horizontal.Y = ii_first_y
End If

st_horizontal.SetPosition(ToTop!)
SetRedraw(True)
end subroutine

public subroutine wf_upload_stop ();
end subroutine

public function boolean wf_upload_work (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
String	ls_error

Long		ll_wg60ym, ll_wg60f1
String	ls_wg60im, ls_wg60sr, ls_wg60cl, ls_wg60sz
Decimal	ld_wg60q1, ld_wg60q2


// rs_return_option
// 'S' : Success 성고
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve(is_applydate)

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)
// 해당 일자의 Data 삭제 (in MIS)
//	마지막 Row부터 Data Upload 성공한 Row는 삭제한다.

  DELETE FROM IMSLIB.WGF60M  
   WHERE IMSLIB.WGF60M.WG60YM = :ii_yyyymmdd
   Using it_destination ;

	ll_error	= it_destination.SQLCODE
	ls_error	= it_destination.SQLErrText
	
	If ll_error = 0 Then
		Commit Using it_destination ;
	Else
		RollBack Using it_destination ;
		f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_work.DELETE IMSLIB.WGF60M : ' + ls_error)
		MessageBox("UPLOAD","Data Upload 도중 오류가 발생하였습니다.", StopSign!)
		rs_return_option = 'E'
		Return False
	End If
	
	For i = ll_rowcount To 1 Step -1
		Yield()
		If ib_upload_stop Then
			ib_upload_stop = False
			li_return = MessageBox("Upload Stop", "Data Upload를 중지 하시겠습니까 ?", Question!, YesNo!, 2)
			If li_return = 1 Then
				rs_return_option = 'C'
				Return False
			End If
		End If
		dw_2.ScrollToRow(i)
		ll_wg60ym	= dw_2.GetItemNumber(i, 'WG60YM')
		ls_wg60im	= dw_2.GetItemString(i, 'WG60IM')
		ls_wg60sr	= dw_2.GetItemString(i, 'WG60SR')
		ls_wg60cl	= dw_2.GetItemString(i, 'WG60CL')
		ls_wg60sz	= dw_2.GetItemString(i, 'WG60SZ')
		ld_wg60q1	= dw_2.GetItemDecimal(i, 'WG60Q1')
		ld_wg60q2	= dw_2.GetItemDecimal(i, 'WG60Q2')
		ll_wg60f1	= dw_2.GetItemNumber(i, 'WG60F1')
		
		Insert Into IMSLIB.WGF60M (WG60YM, WG60IM, WG60SR, WG60CL, WG60SZ, WG60Q1, WG60Q2, WG60F1)
		Values(:ll_wg60ym, :ls_wg60im, :ls_wg60sr, :ls_wg60cl, :ls_wg60sz, :ld_wg60q1, :ld_wg60q2, :ll_wg60f1)
		Using it_destination;
		
		ll_error	= it_destination.SQLCODE
		ls_error	= it_destination.SQLErrText
		
		If ll_error = 0 Then
			Commit Using it_destination ;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
		Else
			RollBack Using it_destination ;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_foillength.INSERT IMSLIB.WGF60M : ' + ls_error)
		End If
	Next
	
	ll_end_time = Cpu ()
	uo_pipe.st_time.text = String((ll_end_time - ll_start_time)/1000,"#,##0") + " Secs"
	If ll_error_cnt > 1 Then
		rs_return_option = 'F'
	Else
		rs_return_option = 'S'
	End If
	Return True
Else
	dw_2.SetRedraw(True)
	ll_end_time = Cpu ()
	uo_pipe.st_time.text = string((ll_end_time - ll_start_time)/1000,"##0.0") + " Secs"
	uo_pipe.st_written.Text = '0'
	uo_pipe.st_error.Text	= '0'
	Return True
End If
end function

public function boolean wf_upload_quality (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
String	ls_error

Long		ll_wg61ym, ll_wg61f1
String	ls_wg61im, ls_wg61sr, ls_wg61cl, ls_wg61sz
Decimal	ld_wg61q1, ld_wg61q2, ld_wg61q3

// rs_return_option
// 'S' : Success 성고
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve(is_applydate)

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)
// 해당 일자의 Data 삭제 (in MIS)
//	마지막 Row부터 Data Upload 성공한 Row는 삭제한다.

  DELETE FROM IMSLIB.WGF61M  
   WHERE IMSLIB.WGF61M.WG61YM = :ii_yyyymmdd
   Using it_destination ;

	ll_error	= it_destination.SQLCODE
	ls_error	= it_destination.SQLErrText
	
	If ll_error = 0 Then
		Commit Using it_destination ;
	Else
		RollBack Using it_destination ;
		f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_quality.DELETE IMSLIB.WGF61M : ' + ls_error)
		MessageBox("UPLOAD","Data Upload 도중 오류가 발생하였습니다.", StopSign!)
		rs_return_option = 'E'
		Return False
	End If
	
	For i = ll_rowcount To 1 Step -1
		Yield()
		If ib_upload_stop Then
			ib_upload_stop = False
			li_return = MessageBox("Upload Stop", "Data Upload를 중지 하시겠습니까 ?", Question!, YesNo!, 2)
			If li_return = 1 Then
				rs_return_option = 'C'
				Return False
			End If
		End If
		dw_2.ScrollToRow(i)
		ll_wg61ym	= dw_2.GetItemNumber(i, 'WG61YM')
		ls_wg61im	= dw_2.GetItemString(i, 'WG61IM')
		ls_wg61sr	= dw_2.GetItemString(i, 'WG61SR')
		ls_wg61cl	= dw_2.GetItemString(i, 'WG61CL')
		ls_wg61sz	= dw_2.GetItemString(i, 'WG61SZ')
		ld_wg61q1	= dw_2.GetItemDecimal(i, 'WG61Q1')
		ld_wg61q2	= dw_2.GetItemDecimal(i, 'WG61Q2')
		ld_wg61q3	= dw_2.GetItemDecimal(i, 'WG61Q3')
		ll_wg61f1	= dw_2.GetItemNumber(i, 'WG61F1')
		
		Insert Into IMSLIB.WGF61M (WG61YM, WG61IM, WG61SR, WG61CL, WG61SZ, WG61Q1, WG61Q2, WG61Q3, WG61F1)
		Values(:ll_wg61ym, :ls_wg61im, :ls_wg61sr, :ls_wg61cl, :ls_wg61sz, :ld_wg61q1, :ld_wg61q2, :ld_wg61q3, :ll_wg61f1)
		Using it_destination;
		
		ll_error	= it_destination.SQLCODE
		ls_error	= it_destination.SQLErrText
		
		If ll_error = 0 Then
			Commit Using it_destination ;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
		Else
			RollBack Using it_destination ;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_quality.INSERT IMSLIB.WGF61MM : ' + ls_error)
		End If
	Next
	
	ll_end_time = Cpu ()
	uo_pipe.st_time.text = String((ll_end_time - ll_start_time)/1000,"#,##0") + " Secs"
	If ll_error_cnt > 1 Then
		rs_return_option = 'F'
	Else
		rs_return_option = 'S'
	End If
	Return True
Else
	dw_2.SetRedraw(True)
	ll_end_time = Cpu ()
	uo_pipe.st_time.text = string((ll_end_time - ll_start_time)/1000,"##0.0") + " Secs"
	uo_pipe.st_written.Text = '0'
	uo_pipe.st_error.Text	= '0'
	Return True
End If
end function

public function boolean wf_upload_worktime (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
String	ls_error

Long		ll_wg62ym, ll_wg62f1
String	ls_wg62im, ls_wg62sr, ls_wg62cl, ls_wg62sz
Decimal	ld_wg62q1, ld_wg62q2, ld_wg62q3

// rs_return_option
// 'S' : Success 성고
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve(is_applydate)

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)
// 해당 일자의 Data 삭제 (in MIS)
//	마지막 Row부터 Data Upload 성공한 Row는 삭제한다.

  DELETE FROM IMSLIB.WGF62M  
   WHERE IMSLIB.WGF62M.WG62YM = :ii_yyyymmdd
   Using it_destination ;

	ll_error	= it_destination.SQLCODE
	ls_error	= it_destination.SQLErrText
	
	If ll_error = 0 Then
		Commit Using it_destination ;
	Else
		RollBack Using it_destination ;
		f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_worktime.DELETE IMSLIB.WGF62M : ' + ls_error)
		MessageBox("UPLOAD","Data Upload 도중 오류가 발생하였습니다.", StopSign!)
		rs_return_option = 'E'
		Return False
	End If
	
	For i = ll_rowcount To 1 Step -1
		Yield()
		If ib_upload_stop Then
			ib_upload_stop = False
			li_return = MessageBox("Upload Stop", "Data Upload를 중지 하시겠습니까 ?", Question!, YesNo!, 2)
			If li_return = 1 Then
				rs_return_option = 'C'
				Return False
			End If
		End If
		dw_2.ScrollToRow(i)
		ll_wg62ym	= dw_2.GetItemNumber(i, 'WG62YM')
		ls_wg62im	= dw_2.GetItemString(i, 'WG62IM')
		ls_wg62sr	= dw_2.GetItemString(i, 'WG62SR')
		ls_wg62cl	= dw_2.GetItemString(i, 'WG62CL')
		ls_wg62sz	= dw_2.GetItemString(i, 'WG62SZ')
		ld_wg62q1	= dw_2.GetItemDecimal(i, 'WG62Q1')
		ld_wg62q2	= dw_2.GetItemDecimal(i, 'WG62Q2')
		ld_wg62q3	= dw_2.GetItemDecimal(i, 'WG62Q3')
		ll_wg62f1	= dw_2.GetItemNumber(i, 'WG62F1')
		
		Insert Into IMSLIB.WGF62M (WG62YM, WG62IM, WG62SR, WG62CL, WG62SZ, WG62Q1, WG62Q2, WG62Q3, WG62F1)
		Values(:ll_wg62ym, :ls_wg62im, :ls_wg62sr, :ls_wg62cl, :ls_wg62sz, :ld_wg62q1, :ld_wg62q2, :ld_wg62q3, :ll_wg62f1)
		Using it_destination;
		
		ll_error	= it_destination.SQLCODE
		ls_error	= it_destination.SQLErrText
		
		If ll_error = 0 Then
			Commit Using it_destination ;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
		Else
			RollBack Using it_destination ;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_worktime.INSERT IMSLIB.WGF62M : ' + ls_error)
		End If
	Next
	
	ll_end_time = Cpu ()
	uo_pipe.st_time.text = String((ll_end_time - ll_start_time)/1000,"#,##0") + " Secs"
	If ll_error_cnt > 1 Then
		rs_return_option = 'F'
	Else
		rs_return_option = 'S'
	End If
	Return True
Else
	dw_2.SetRedraw(True)
	ll_end_time = Cpu ()
	uo_pipe.st_time.text = string((ll_end_time - ll_start_time)/1000,"##0.0") + " Secs"
	uo_pipe.st_written.Text = '0'
	uo_pipe.st_error.Text	= '0'
	Return True
End If
end function

public function boolean wf_upload_lot (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
String	ls_error

Long ll_lotsq2,ll_waqt, ll_stdt, ll_wadt, ll_cust1, ll_nbdt, ll_a08qt1, ll_a08vd
Long ll_a08qt2, ll_a08qt4, ll_a08qt3, ll_a08dt

String ls_a08cd1, ls_plant, ls_items, ls_gubcd, ls_lotno, ls_itnbr, ls_jumn1
String ls_a08rt1, ls_a08fl1, ls_series, ls_size, ls_saletp, ls_lead, ls_a08wc1, ls_a08sq1, ls_a08wc2
String ls_a08cd2, ls_a08fl2, ls_a08no, ls_a08no2

// rs_return_option
// 'S' : Success 성고
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve(is_applydate)

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)
// 해당 일자의 Data 삭제 (in MIS)
//	마지막 Row부터 Data Upload 성공한 Row는 삭제한다.

   DELETE FROM IMSLIB.WGF52M  
   Using it_destination ;

	ll_error	= it_destination.SQLCODE
	ls_error	= it_destination.SQLErrText
	
	If ll_error = 0 Then
		Commit Using it_destination ;
	Else
		RollBack Using it_destination ;
		f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_lot.DELETE IMSLIB.WGF52M : ' + ls_error)
		MessageBox("UPLOAD","Data Upload 도중 오류가 발생하였습니다.", StopSign!)
		rs_return_option = 'E'
		Return False
	End If
	
	//추가1 BY BHJ 
//	DELETE FROM DWOBJLIB.WAF52M  
//       WHERE 
//   Using it_destination ;
//
//	ll_error	= it_destination.SQLCODE
//	ls_error	= it_destination.SQLErrText
//	
//	If ll_error = 0 Then
//		Commit Using it_destination ;
//	Else
//		RollBack Using it_destination ;
//		f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_lot.DELETE IMSLIB.WGF52M : ' + ls_error)
//		MessageBox("UPLOAD","Data Upload 도중 오류가 발생하였습니다.", StopSign!)
//		rs_return_option = 'E'
//		Return False
//	End If
	//추가1 BY BHJ 
	
	For i = ll_rowcount To 1 Step -1
		Yield()
		If ib_upload_stop Then
			ib_upload_stop = False
			li_return = MessageBox("Upload Stop", "Data Upload를 중지 하시겠습니까 ?", Question!, YesNo!, 2)
			If li_return = 1 Then
				rs_return_option = 'C'
				Return False
			End If
		End If
		dw_2.ScrollToRow(i)
		ls_a08cd1	= dw_2.GetItemString(i, 'A08CD1')
		ls_plant		= dw_2.GetItemString(i, 'PLANT')
		ls_items		= dw_2.GetItemString(i, 'ITEMS')
		ls_gubcd		= dw_2.GetItemString(i, 'GUBCD')
		ls_lotno		= dw_2.GetItemString(i, 'LOTNO')
		ll_lotsq2	= dw_2.GetItemNumber(i, 'LOTSQ2')
		ls_itnbr		= dw_2.GetItemString(i, 'ITNBR')
		ll_waqt		= dw_2.GetItemNumber(i, 'WAQT')
		ll_stdt		= dw_2.GetItemNumber(i, 'STDT')
		ll_wadt		= dw_2.GetItemNumber(i, 'WADT')
		ll_cust1		= dw_2.GetItemNumber(i, 'CUST1')
		ls_jumn1		= dw_2.GetItemString(i, 'JUMN1')
		ll_nbdt		= dw_2.GetItemNumber(i, 'NBDT')
		ll_a08qt1	= dw_2.GetItemNumber(i, 'A08QT1')
		ls_a08rt1	= dw_2.GetItemString(i, 'A08RT1')
		ls_a08fl1	= dw_2.GetItemString(i, 'A08FL1')
		ls_series	= dw_2.GetItemString(i, 'SERIES')
		ls_size		= dw_2.GetItemString(i, 'SIZE')
		ls_saletp	= dw_2.GetItemString(i, 'SALETP')
		ls_lead		= dw_2.GetItemString(i, 'LEAD')
		ll_a08vd		= dw_2.GetItemNumber(i, 'A08VD')
		ls_a08wc1	= dw_2.GetItemString(i, 'A08WC1')
		ls_a08sq1	= dw_2.GetItemString(i, 'A08SQ1')
		ls_a08wc2	= dw_2.GetItemString(i, 'A08WC2')
		ll_a08qt2	= dw_2.GetItemNumber(i, 'A08QT2')
		ll_a08qt4	= dw_2.GetItemNumber(i, 'A08QT4')
		ls_a08cd2	= dw_2.GetItemString(i, 'A08CD2')
		ll_a08qt3	= dw_2.GetItemNumber(i, 'A08QT3')
		ls_a08fl2	= dw_2.GetItemString(i, 'A08FL2')
		ll_a08dt		= dw_2.GetItemNumber(i, 'A08DT')
		ls_a08no		= dw_2.GetItemString(i, 'A08NO')
		ls_a08no2	= dw_2.GetItemString(i, 'A08NO2')		

		Insert Into IMSLIB.WGF52M (A08CD1, PLANT, ITEMS, GUBCD, LOTNO, LOTSQ2,
			ITNBR, WAQT, STDT, WADT, CUST1, JUMN1, NBDT, A08QT1, A08RT1, A08FL1,
			SERIES, SIZE, SALETP, LEAD, A08VD, A08WC1, A08SQ1, A08WC2, A08QT2,
			A08QT4, A08CD2, A08QT3, A08FL2, A08DT, A08NO, A08NO2)
		Values(:ls_a08cd1, :ls_plant, :ls_items, :ls_gubcd, :ls_lotno, :ll_lotsq2,
			:ls_itnbr, :ll_waqt, :ll_stdt, :ll_wadt, :ll_cust1, :ls_jumn1,
			:ll_nbdt, :ll_a08qt1, :ls_a08rt1, :ls_a08fl1, :ls_series, :ls_size,
			:ls_saletp, :ls_lead, :ll_a08vd, :ls_a08wc1, :ls_a08sq1, :ls_a08wc2,
			:ll_a08qt2, :ll_a08qt4, :ls_a08cd2, :ll_a08qt3, :ls_a08fl2, :ll_a08dt,
			:ls_a08no, :ls_a08no2)
		Using it_destination;
		
		ll_error	= it_destination.SQLCODE
		ls_error	= it_destination.SQLErrText
		
		If ll_error = 0 Then
			Commit Using it_destination ;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
		Else
			RollBack Using it_destination ;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_foillength.INSERT IMSLIB.WGF18M : ' + ls_error)
		End If
      
		
		//추가2 BY BHJ 
//		Insert Into DWOBJLIB.WAF52M (A08CD1, PLANT, ITEMS, GUBCD, LOTNO, LOTSQ2,
//			ITNBR, WAQT, STDT, WADT, CUST1, JUMN1, NBDT, A08QT1, A08RT1, A08FL1,
//			SERIES, SIZE, SALETP, LEAD, A08VD, A08WC1, A08SQ1, A08WC2, A08QT2,
//			A08QT4, A08CD2, A08QT3, A08FL2, A08DT, A08NO, A08NO2)
//		Values(:ls_a08cd1, :ls_plant, :ls_items, :ls_gubcd, :ls_lotno, :ll_lotsq2,
//			:ls_itnbr, :ll_waqt, :ll_stdt, :ll_wadt, :ll_cust1, :ls_jumn1,
//			:ll_nbdt, :ll_a08qt1, :ls_a08rt1, :ls_a08fl1, :ls_series, :ls_size,
//			:ls_saletp, :ls_lead, :ll_a08vd, :ls_a08wc1, :ls_a08sq1, :ls_a08wc2,
//			:ll_a08qt2, :ll_a08qt4, :ls_a08cd2, :ll_a08qt3, :ls_a08fl2, :ll_a08dt,
//			:ls_a08no, :ls_a08no2)
//		Using it_destination;
//		
//		ll_error	= it_destination.SQLCODE
//		ls_error	= it_destination.SQLErrText
//		
//		If ll_error = 0 Then
//			Commit Using it_destination ;
//			dw_2.DeleteRow(i)
//			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
//		Else
//			RollBack Using it_destination ;
//			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
//			ll_error_cnt ++
//			f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_foillength.INSERT IMSLIB.WGF18M : ' + ls_error)
//		End If
      //추가2 BY BHJ 
		
   Next
	
	ll_end_time = Cpu ()
	uo_pipe.st_time.text = String((ll_end_time - ll_start_time)/1000,"#,##0") + " Secs"
	If ll_error_cnt > 1 Then
		rs_return_option = 'F'
	Else
		rs_return_option = 'S'
	End If
	Return True
Else
	dw_2.SetRedraw(True)
	ll_end_time = Cpu ()
	uo_pipe.st_time.text = string((ll_end_time - ll_start_time)/1000,"##0.0") + " Secs"
	uo_pipe.st_written.Text = '0'
	uo_pipe.st_error.Text	= '0'
	Return True
End If
end function

public function boolean wf_upload_foillength (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error
String	ls_status, ls_mtcode, ls_yalot, ls_pontno, ls_mlotno, ls_nacode, ls_nalot
String	ls_jobpid, ls_dum1
Decimal	ld_inqty, ld_length1, ld_length2, ld_length3

// rs_return_option
// 'S' : Success 성고
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve(is_applydate)

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)
// 해당 일자의 Data 삭제 (in MIS)
//	마지막 Row부터 Data Upload 성공한 Row는 삭제한다.

   DELETE FROM IMSLIB.WGF18M  
   WHERE IMSLIB.WGF18M.PYMD = :ii_yyyymmdd
   Using it_destination ;

	ll_error	= it_destination.SQLCODE
	ls_error	= it_destination.SQLErrText
	
	If ll_error = 0 Then
		Commit Using it_destination ;
	Else
		RollBack Using it_destination ;
		f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_foillength.DELETE IMSLIB.WGF18M : ' + ls_error)
		MessageBox("UPLOAD","Data Upload 도중 오류가 발생하였습니다.", StopSign!)
		rs_return_option = 'E'
		Return False
	End If
	
	//추가1 BY BHJ
//	DELETE FROM IMSLIB.MCF18M  
//   WHERE IMSLIB.MCF18M.PYMD = :ii_yyyymmdd
//         AND             
//   Using it_destination ;
//
//	ll_error	= it_destination.SQLCODE
//	ls_error	= it_destination.SQLErrText
//	
//	If ll_error = 0 Then
//		Commit Using it_destination ;
//	Else
//		RollBack Using it_destination ;
//		f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_foillength.DELETE IMSLIB.WGF18M : ' + ls_error)
//		MessageBox("UPLOAD","Data Upload 도중 오류가 발생하였습니다.", StopSign!)
//		rs_return_option = 'E'
//		Return False
//	End If
	//추가1 BY BHJ
	
	For i = ll_rowcount To 1 Step -1
		Yield()
		If ib_upload_stop Then
			ib_upload_stop = False
			li_return = MessageBox("Upload Stop", "Data Upload를 중지 하시겠습니까 ?", Question!, YesNo!, 2)
			If li_return = 1 Then
				rs_return_option = 'C'
				Return False
			End If
		End If
		dw_2.ScrollToRow(i)
		ls_status	= dw_2.GetItemString(i, 'STATUS')
		ls_mtcode	= dw_2.GetItemString(i, 'MTCODE')
		ls_yalot		= dw_2.GetItemString(i, 'YALOT')
		ll_pymd		= dw_2.GetItemNumber(i, 'PYMD')
		ld_inqty		= dw_2.GetItemDecimal(i, 'INQTY')
		ld_length1	= dw_2.GetItemDecimal(i, 'LENTH1')
		ld_length2	= dw_2.GetItemDecimal(i, 'LENTH2')
		ls_pontno	= dw_2.GetItemString(i, 'PONTNO')
		ls_mlotno	= dw_2.GetItemString(i, 'MLOTNO')
		ls_nacode	= dw_2.GetItemString(i, 'NACODE')
		ls_nalot		= dw_2.GetItemString(i, 'NALOT')
		ld_length3	= dw_2.GetItemDecimal(i, 'LENTH3')
		ls_jobpid	= dw_2.GetItemString(i, 'JOBPID')
		ll_sysdat	= dw_2.GetItemNumber(i, 'SYSDAT')
		ll_systim	= dw_2.GetItemNumber(i, 'SYSTIM')
		ll_incsdt	= dw_2.GetItemNumber(i, 'INCSDT')
		ls_dum1		= dw_2.GetItemString(i, 'DUM1')
		
		Insert Into IMSLIB.WGF18M (STATUS, MTCODE, YALOT#, PYMD, INQTY, LENTH1, LENTH2, PONTNO,
								MLOTNO, NACODE, NALOT#, LENTH3, JOBPID, SYSDAT, SYSTIM, INCSDT, DUM1)
		Values(:ls_status, :ls_mtcode, :ls_yalot, :ll_pymd, :ld_inqty, :ld_length1, :ld_length2,
				 :ls_pontno, :ls_mlotno, :ls_nacode, :ls_nalot, :ld_length3, :ls_jobpid, :ll_sysdat,
				 :ll_systim, :ll_incsdt, :ls_dum1) 
		Using it_destination;
		
		ll_error	= it_destination.SQLCODE
		ls_error	= it_destination.SQLErrText
		
		If ll_error = 0 Then
			Commit Using it_destination ;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
		Else
			RollBack Using it_destination ;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_foillength.INSERT IMSLIB.WGF18M : ' + ls_error)
		End If
		
		//추가2 BY BHJ
//      Insert Into IMSLIB.MCF18M (STATUS, MTCODE, YALOT#, PYMD, INOUCD, INQTY, LENTH1, LENTH2, LENTH3,
//                                 PONTNO, MLOTNO, JOBPID, SYSDAT, SYSTIM, INCSDT, DUM1)
//		Values(:ls_status, :ls_mtcode, :ls_yalot, :ll_pymd, 'IN', :ld_inqty, 0, 0, 0,
//				 :ls_pontno, :ls_mlotno, :ls_jobpid, :ll_sysdat, :ll_systim, :ll_incsdt, :ls_dum1) 
//		Using it_destination;
//		
//		ll_error	= it_destination.SQLCODE
//		ls_error	= it_destination.SQLErrText
//		
//		If ll_error = 0 Then
//			Commit Using it_destination ;
//			dw_2.DeleteRow(i)
//			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
//		Else
//			RollBack Using it_destination ;
//			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
//			ll_error_cnt ++
//			f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_foillength.INSERT IMSLIB.WGF18M : ' + ls_error)
//		End If
		//추가2 BY BHJ
		
	Next
	
	ll_end_time = Cpu ()
	uo_pipe.st_time.text = String((ll_end_time - ll_start_time)/1000,"#,##0") + " Secs"
	If ll_error_cnt > 1 Then
		rs_return_option = 'F'
	Else
		rs_return_option = 'S'
	End If
	Return True
Else
	dw_2.SetRedraw(True)
	ll_end_time = Cpu ()
	uo_pipe.st_time.text = string((ll_end_time - ll_start_time)/1000,"##0.0") + " Secs"
	uo_pipe.st_written.Text = '0'
	uo_pipe.st_error.Text	= '0'
	Return True
End If
end function

public function boolean wf_raiserror (string fs_pipeline_name);// BOX 포장, 제조조건, 거래처 변경 Column 확인 후 처리할것 2000.03.31

String ls_mysql, ls_error

CHOOSE CASE Upper(fs_pipeline_name)
	CASE 'P_ITEM_MASTER'
		ls_mysql = 'RAISERROR (50001, 10, 1)'
	CASE 'P_BOXPACK_MASTER'
		ls_mysql = 'RAISERROR (50002, 10, 1)'
	CASE 'P_EMP_MASTER'
		ls_mysql = 'RAISERROR (50003, 10, 1)'
	CASE 'P_BOM_MASTER'
		ls_mysql = 'RAISERROR (50004, 10, 1)'
	CASE 'P_CUSTOMER_MASTER'
		ls_mysql = 'RAISERROR (50005, 10, 1)'
	CASE 'P_PRDCONDITION_MASTER'
		ls_mysql = 'RAISERROR (50006, 10, 1)'
END CHOOSE

If Len(ls_mysql) > 0 Then
	EXECUTE IMMEDIATE :ls_mysql ;
End If

CHOOSE CASE Upper(fs_pipeline_name)
	CASE 'P_ITEM_MASTER'
		UPDATE AMFLIB.ITEMAST  
			SET CHPRS = ' '  
		 WHERE AMFLIB.ITEMAST.ITEMS = 'CE'
			AND AMFLIB.ITEMAST.CHPRS = 'Y'
		Using it_source;
		
		ls_error = it_source.sqlerrtext
		
		If it_source.sqlcode = 0 Then
			Commit Using it_source;
			Return True
		Else
			RollBack Using it_source;
			MessageBox("AS-400 Error", "Item Master 변경 중 오류가 발생하였습니다.~r~n" + ls_error, StopSign!)
			Return False
		End If
	CASE 'P_BOM_MASTER'
		UPDATE IMSLIB.MASBOMF
			SET LOWCH = ' '  
		 WHERE IMSLIB.MASBOMF.LOWCH = 'Y'
		Using it_source;
		
		ls_error = it_source.sqlerrtext
		
		If it_source.sqlcode = 0 Then
			Commit Using it_source;
			Return True
		Else
			RollBack Using it_source;
			MessageBox("AS-400 Error", "BOM Master 변경 중 오류가 발생하였습니다.~r~n" + ls_error, StopSign!)
			Return False
		End If
	CASE 'P_EMP_MASTER'
		UPDATE DHPDBF.HP13PF00
			SET REMARK = ' '  
		 WHERE DHPDBF.HP13PF00.REMARK = 'Y'
		Using it_source;
		
		ls_error = it_source.sqlerrtext
		
		If it_source.sqlcode = 0 Then
			Commit Using it_source;
			Return True
		Else
			RollBack Using it_source;
			MessageBox("AS-400 Error", "사원 Master 변경 중 오류가 발생하였습니다.~r~n" + ls_error, StopSign!)
			Return False
		End If
	CASE 'P_PIPE_TEST'
		UPDATE MSTFLAG
			SET FLAG = 'N'
		 Where ActionName = 'INTERFACE_TEST';
		If SQLCA.SQLCODE = 0 Then
			Return True
		Else
			Return False
		End If
END CHOOSE

Return True
end function

public subroutine wf_dw_init (integer fs_option);If fs_option = 1 Then
	dw_1.DataObject	= 'd_description'
	dw_1.InsertRow(1)
	If Integer(uo_pipe.st_error.Text) > 0 Then
		dw_1.SetItem(1,1, 'Download Error Area')
	Else
		dw_1.SetItem(1,1, 'Download Complete')
	End If	
	Return
End If

If fs_option = 2 Then
	dw_2.DataObject	= 'd_description'
	dw_2.InsertRow(1)
	dw_2.SetItem(1,1, 'Upload Data Summary Area')
	Return
End If

//dw_1.DataObject	= 'd_description'
//dw_1.InsertRow(1)
//dw_1.SetItem(1,1, 'DownLoad Error Area')
//
//dw_2.DataObject	= 'd_description'
//dw_2.InsertRow(1)
//dw_2.SetItem(1,1, 'Upload Data Summary Area')

Return
end subroutine

public function boolean wf_upload ();Int rowcount
String ls_interface_gubun, ls_source, ls_destination
String ls_datawindow_name, ls_interface_name, ls_fail_gubun, ls_return_option
Boolean	lb_upload = False

SetPointer(HourGlass!)

Select InterfaceGubun,
		 Source,
		 Destination,
		 PipeLineName,
		 InterfaceName
  Into :ls_interface_gubun,
  		 :ls_source,
		 :ls_destination,
		 :ls_datawindow_name,
		 :ls_interface_name
  From tINTERFACE
 Where InterfaceID = :ii_interface_id ;

If Not wf_flag_check(ls_datawindow_name, is_action_name, ls_fail_gubun) Then
	If ls_fail_gubun = 'Y' Then
		MessageBox("UpLoad", "현재 해당 정보의 Upload를 수행중입니다.")
	End If
	If ls_fail_gubun = 'E' Then
		MessageBox("UpLoad", "Upload Flag 정보 Update중 오류가 발생하였습니다.")
	End If
	Return False
End If

If Not wf_connect(gs_ini_file, ls_source, ls_destination, it_source, it_destination) Then
	wf_flag_update(is_action_name)
	Return False
End If

uo_pipe.st_read.Text = '0'
uo_pipe.st_written.Text = '0'
uo_pipe.st_error.Text = '0'
uo_pipe.st_time.Text = ''

// rs_return_option
// 'S' : Success 성고
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

CHOOSE CASE Upper(ls_datawindow_name)
	CASE 'D_UPLOAD_FOILLENGTH'
		lb_upload = wf_upload_foillength(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_LOT'
		lb_upload = wf_upload_lot(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_WORK'
		lb_upload = wf_upload_work(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_QUALITY'
		lb_upload = wf_upload_quality(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_WORKTIME'
		lb_upload = wf_upload_worktime(ls_datawindow_name, ls_return_option)
END CHOOSE

If ls_return_option <> 'E' Then
//	wf_last_execute_update()
	uo_parameter.Event Trigger ue_retrieve(ii_interface_id, rowcount)
End If

wf_flag_update(is_action_name)

Return False
end function

public subroutine wf_resize_bar ();Long li_min, li_max, li_vertical_x, li_win_w, li_win_h

SetRedraw(False)

li_vertical_x	= st_vertical.X
li_win_w	= WorkSpaceWidth()
li_win_h	= WorkSpaceHeight()

li_min 	= li_win_w/8
li_max 	= li_win_w/2

If li_vertical_x < li_min then
	st_vertical.X	= li_min
	If Not ib_min Then
		li_vertical_x	= li_min
		ib_min	= True
		wf_resize_panel(li_win_w, li_win_h, li_vertical_x)
	End If
ElseIf li_vertical_x > li_max then
	st_vertical.X	= li_max
	If Not ib_max Then
		li_vertical_x	= li_max
		ib_max	= True
		wf_resize_panel(li_win_w, li_win_h, li_vertical_x)
	End If
Else
	wf_resize_panel(li_win_w, li_win_h, li_vertical_x)
	ib_min	= False
	ib_max	= False
End if	

ddlb_1.Move(dw_interface.x + dw_interface.width + 1700, ddlb_1.y)

st_vertical.SetPosition(ToTop!)
SetRedraw(True)
end subroutine

public subroutine wf_disconnect ();If IsValid(it_source) Then
	Disconnect using it_source;
End If

If IsValid(it_destination) Then
	Disconnect using it_destination;
End If

If IsValid(ip_pipe) Then
	Destroy	ip_pipe
End If

If IsValid(it_source) Then
	Destroy	it_source
End If

If IsValid(it_destination) Then
	Destroy	it_destination
End If
end subroutine

public subroutine wf_flag_update (string fs_action_name);Update MSTFLAG
	Set Flag			= 'N',
		 LastEmp		= 'INTERFACE',
		 LastDate	= GetDate()
 Where ActionName = :fs_action_name;
end subroutine

public function string wf_get_host_datetime ();// host 일자 시간 가져오기

String		ls_datetime, ls_date, ls_time


select	current date , current time 
into		:ls_date, :ls_time 
from		pbcommon.comm000
using		it_source;

ls_datetime	= ls_date + ' ' + ls_time

is_currentdate	=	ls_date
is_currenttime	=	ls_time

Return ls_datetime

end function

public function boolean wf_connect_check (ref transaction rt_source, ref transaction rt_destination);// Host와 IPIS server connection check & 실행가능시간 check

UnsignedLong	ul_handle1, ul_handle2
Boolean			lb_connect

ul_handle1 = rt_source.DBHandle()
ul_handle2 = rt_destination.DBHandle()

If ul_handle1 > 0 and ul_handle2 > 0 Then
//	If String(Today(), 'hhmmss') >= '080000' and String(Today(), 'hhmmss') <= '200000' Then
		Return True
//	Else
//		Return False
//	End If	
Else
	lb_connect = wf_connect(gs_ini_file, 'MIS', 'IPIS', it_source, it_destination)
	Return lb_connect
End If	
end function

public subroutine wf_download_stop ();String ls_pipeline_name

If IsValid(ip_pipe) Then
	If ip_pipe.Cancel() = 1 Then
		Select PipeLineName
		  Into :ls_pipeline_name
		  From tINTERFACE
		 Where InterfaceID = :ii_interface_id ;
		If Integer(uo_pipe.st_read.Text) > 0 Then
			wf_raiserror(ls_pipeline_name)
		ELse
			wf_flag_update(is_action_name)
		End If
	End If
End If
end subroutine

public function boolean wf_pipe_end_update (string fs_datetime);
SQLCA.AutoCommit	= False

Update tINTERFACE
	Set	EndTime		=	Cast(:fs_datetime as datetime)
 Where InterfaceID = :ii_interface_id ;

If SQLCA.SQLCODE = 0 Then
	Commit;
Else
	RollBack;
End If

SQLCA.AutoCommit	= True
Return True
end function

public function boolean wf_last_execute_update (string fs_datetime);
SQLCA.AutoCommit	= False

Update	TINTERFACE
	Set	StartTime		=	Cast(:fs_datetime as datetime),
			LastExecuted	=	Cast(:fs_datetime as datetime)
Where		InterfaceID		=	:ii_interface_id ;

If SQLCA.SQLCODE = 0 Then
	Commit;
Else
	RollBack;
End If

SQLCA.AutoCommit	= True
Return True
end function

public function boolean wf_download_sr ();
Long		ll_row1, ll_row2, ll_row3
String	ls_srno1, ls_srno2, ls_kitcheck
Int		i, j, k, li_error, li_count

Decimal	ld_srqty, ld_saqty, ld_exqty, ld_muprc, ld_luprc, ld_muamt, ld_luamt, ld_cpcnt
Decimal	ld_cdqt, ld_asrqt1, ld_asrqt2, ld_asrqt3, ld_asrqt4
String	ls_comltd, ls_csrno, ls_srno, ls_xplant, ls_div, ls_stype, ls_citno, ls_suse
String	ls_frdt, ls_ordno, ls_pdcd, ls_itno, ls_custcd, ls_scustcd, ls_cur
String	ls_mkcd, ls_stcd, ls_taxcd, ls_xplan, ls_kitcd, ls_dktm, ls_psrno
String	ls_csngb, ls_ivgb, ls_costdiv, ls_ascsn, ls_epno, ls_epdt, ls_extd
String	ls_chgdate, ls_date, ls_code, ls_error

Datastore	lds_pdsle301, lds_sle302, lds_sle308

lds_pdsle301	= Create Datastore
lds_sle302		= Create Datastore
lds_sle308		= Create Datastore

lds_pdsle301.DataObject	= 'd_download_pdsle301'
lds_sle302.DataObject	= 'd_download_sle302'
lds_sle308.DataObject	= 'd_download_sle308'

lds_pdsle301.SetTransObject(SQLCA)
lds_sle302.SetTransObject(it_source)
lds_sle308.SetTransObject(it_source)

SQLCA.AutoCommit	= False
ls_error	=	'00'

ll_row1	= lds_pdsle301.Retrieve()

Delete from sle302_temp using sqlca;
if sqlca.sqlcode	<>	0 then
	ls_error	=	'11'
End if

Delete from sle308_temp using sqlca;
if sqlca.sqlcode	<>	0 then
	ls_error	=	'11'
End if

if ls_error	<>	'00' then
	rollback using sqlca;
	sqlca.autocommit = true
	return False
end if

If ll_row1 > 0 Then
	For i = 1 To ll_row1	
		// 'D' - 삭제인놈은 detail 조회 불필요
		ls_chgdate	= lds_pdsle301.GetItemString(i, 'ChgDate') 
		ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
		If lds_pdsle301.GetItemString(i, 'ChgCd') = 'A' Then	
			// srno로 lds_sle302 조회
			// for loop 돌려서 kitcd = 'p' 인 놈이 있으면 다시 lds_sle308 조회
			ls_srno1	= lds_pdsle301.GetItemString(i, 'SRNo') 		
			ll_row2	= lds_sle302.Retrieve(trim(ls_srno1))
			
			If ll_row2 <= 0 then
				//SR Detail 데이타가 없는 경우
				//Interface.pdsle301 데이타를 삭제함( 2003.11.25 )
				DELETE FROM PDSLE301  
   				WHERE PDSLE301.CHGDATE = :ls_chgdate   
           		using sqlca;
				
				If sqlca.sqlcode <> 0 Then
					ls_error = '11'
				End If
				
				continue
				
			End If
			
			For j = 1 To ll_row2
				ls_kitcheck	= lds_sle302.GetItemString(j, 'Kitcd')
				
				If ls_kitcheck = 'P' Then
					ls_srno2	= lds_sle302.GetItemString(j, 'Csrno')
	
					ll_row3	= lds_sle308.Retrieve(ls_srno2)
					
					if ll_row3	< 0 then
						ls_error	=	'11'
					end if
			
					For k = 1 To ll_row3
						ls_comltd	= lds_sle308.GetItemString(k, 'comltd')
						ls_csrno		= lds_sle308.GetItemString(k, 'csrno')
						ls_srno		= lds_sle308.GetItemString(k, 'srno')
						ls_xplant	= lds_sle308.GetItemString(k, 'xplant')
						ls_div		= lds_sle308.GetItemString(k, 'div')
						ls_stype		= lds_sle308.GetItemString(k, 'stype')
						ls_citno		= lds_sle308.GetItemString(k, 'citno')
						ls_suse		= lds_sle308.GetItemString(k, 'suse')
						ls_frdt		= lds_sle308.GetItemString(k, 'frdt')
						ls_ordno		= lds_sle308.GetItemString(k, 'ordno')
						ls_pdcd		= lds_sle308.GetItemString(k, 'pdcd')
						ls_itno		= lds_sle308.GetItemString(k, 'itno')
						ls_custcd	= lds_sle308.GetItemString(k, 'custcd')
						ls_scustcd	= lds_sle308.GetItemString(k, 'scustcd')
						ld_srqty		= lds_sle308.GetItemNumber(k, 'srqty')
						ld_saqty		= lds_sle308.GetItemNumber(k, 'saqty')
						ld_exqty		= lds_sle308.GetItemNumber(k, 'exqty')
						ls_cur		= lds_sle308.GetItemString(k, 'cur')
						ld_muprc		= lds_sle308.GetItemNumber(k, 'muprc')
						ld_luprc		= lds_sle308.GetItemNumber(k, 'luprc')
						ld_muamt		= lds_sle308.GetItemNumber(k, 'muamt')
						ld_luamt		= lds_sle308.GetItemNumber(k, 'luamt')
						ld_cpcnt		= lds_sle308.GetItemNumber(k, 'cpcnt')
						ls_mkcd		= lds_sle308.GetItemString(k, 'mkcd')
						ls_stcd		= lds_sle308.GetItemString(k, 'stcd')
						ls_taxcd		= lds_sle308.GetItemString(k, 'taxcd')
						ls_xplan		= lds_sle308.GetItemString(k, 'xplan')
						ls_kitcd		= lds_sle308.GetItemString(k, 'kitcd')
						ld_cdqt		= lds_sle308.GetItemNumber(k, 'cdqt')
						ls_dktm		= lds_sle308.GetItemString(k, 'dktm')
						ls_psrno		= lds_sle308.GetItemString(k, 'psrno')
						ld_asrqt1	= lds_sle308.GetItemNumber(k, 'asrqt1')
						ld_asrqt2	= lds_sle308.GetItemNumber(k, 'asrqt2')
						ld_asrqt3	= lds_sle308.GetItemNumber(k, 'asrqt3')
						ld_asrqt4	= lds_sle308.GetItemNumber(k, 'asrqt4')
						ls_csngb		= lds_sle308.GetItemString(k, 'csngb')
						ls_ivgb		= lds_sle308.GetItemString(k, 'ivgb')
						ls_costdiv	= lds_sle308.GetItemString(k, 'costdiv')
						ls_ascsn		= lds_sle308.GetItemString(k, 'ascsn')
						ls_epno		= lds_sle308.GetItemString(k, 'epno')
						ls_epdt		= lds_sle308.GetItemString(k, 'epdt')
						ls_extd		= lds_sle308.GetItemString(k, 'extd')
						
						select	Count(*)		into :li_Count
						From		sle308_temp
						Where		COMLTD	=	:ls_comltd	and
									CSRNO		=	:ls_csrno	and
									SRNO		=	:ls_srno		Using sqlca;
						if li_count	=	0	then
							Insert into sle308_temp
								(comltd,			csrno,		srno,			xplant,		div,			stype,		citno,	
								suse,				frdt,			ordno,		pdcd,			itno,			custcd,		scustcd,	
								srqty,			saqty,		exqty,		cur,			muprc,		luprc,		muamt,
								luamt,			cpcnt,		mkcd,			stcd,			taxcd,		xplan,		kitcd,
								cdqt,				dktm,			psrno,		asrqt1,		asrqt2,		asrqt3,		asrqt4,
								csngb,			ivgb,			costdiv,		ascsn,		epno,			epdt,			extd)
							Values
								(:ls_comltd,	:ls_csrno,	:ls_srno,	:ls_xplant,	:ls_div,		:ls_stype,	:ls_citno,	
								:ls_suse,		:ls_frdt,	:ls_ordno,	:ls_pdcd,	:ls_itno,	:ls_custcd,	:ls_scustcd,	
								:ld_srqty,		:ld_saqty,	:ld_exqty,	:ls_cur,		:ld_muprc,	:ld_luprc,	:ld_muamt,
								:ld_luamt,		:ld_cpcnt,	:ls_mkcd,	:ls_stcd,	:ls_taxcd,	:ls_xplan,	:ls_kitcd,
								:ld_cdqt,		:ls_dktm,	:ls_psrno,	:ld_asrqt1,	:ld_asrqt2,	:ld_asrqt3,	:ld_asrqt4,
								:ls_csngb,		:ls_ivgb,	:ls_costdiv,:ls_ascsn,	:ls_epno,	:ls_epdt,	:ls_extd)
							Using SQLCA;	
						
							if sqlca.sqlcode	<>	0 then
								ls_error	=	'11'
							End if
						End if
	
					Next	
						
				End If	
	
				ls_comltd	= lds_sle302.GetItemString(j, 'comltd')
				ls_csrno		= lds_sle302.GetItemString(j, 'csrno')
				ls_srno		= lds_sle302.GetItemString(j, 'srno')
				ls_xplant	= lds_sle302.GetItemString(j, 'xplant')
				ls_div		= lds_sle302.GetItemString(j, 'div')
				ls_stype		= lds_sle302.GetItemString(j, 'stype')
				ls_citno		= lds_sle302.GetItemString(j, 'citno')
				ls_suse		= lds_sle302.GetItemString(j, 'suse')
				ls_frdt		= lds_sle302.GetItemString(j, 'frdt')
				ls_ordno		= lds_sle302.GetItemString(j, 'ordno')
				ls_pdcd		= lds_sle302.GetItemString(j, 'pdcd')
				ls_itno		= lds_sle302.GetItemString(j, 'itno')
				ls_custcd	= lds_sle302.GetItemString(j, 'custcd')
				ls_scustcd	= lds_sle302.GetItemString(j, 'scustcd')
				ld_srqty		= lds_sle302.GetItemNumber(j, 'srqty')
				ld_saqty		= lds_sle302.GetItemNumber(j, 'saqty')
				ld_exqty		= lds_sle302.GetItemNumber(j, 'exqty')
				ls_cur		= lds_sle302.GetItemString(j, 'cur')
				ld_muprc		= lds_sle302.GetItemNumber(j, 'muprc')
				ld_luprc		= lds_sle302.GetItemNumber(j, 'luprc')
				ld_muamt		= lds_sle302.GetItemNumber(j, 'muamt')
				ld_luamt		= lds_sle302.GetItemNumber(j, 'luamt')
				ld_cpcnt		= lds_sle302.GetItemNumber(j, 'cpcnt')
				ls_mkcd		= lds_sle302.GetItemString(j, 'mkcd')
				ls_stcd		= lds_sle302.GetItemString(j, 'stcd')
				ls_taxcd		= lds_sle302.GetItemString(j, 'taxcd')
				ls_xplan		= lds_sle302.GetItemString(j, 'xplan')
				ls_kitcd		= lds_sle302.GetItemString(j, 'kitcd')
				ld_cdqt		= lds_sle302.GetItemNumber(j, 'cdqt')
				ls_dktm		= lds_sle302.GetItemString(j, 'dktm')
				ls_psrno		= lds_sle302.GetItemString(j, 'psrno')
				ld_asrqt1	= lds_sle302.GetItemNumber(j, 'asrqt1')
				ld_asrqt2	= lds_sle302.GetItemNumber(j, 'asrqt2')
				ld_asrqt3	= lds_sle302.GetItemNumber(j, 'asrqt3')
				ld_asrqt4	= lds_sle302.GetItemNumber(j, 'asrqt4')
				ls_csngb		= lds_sle302.GetItemString(j, 'csngb')
				ls_ivgb		= lds_sle302.GetItemString(j, 'ivgb')
				ls_costdiv	= lds_sle302.GetItemString(j, 'costdiv')
				ls_ascsn		= lds_sle302.GetItemString(j, 'ascsn')
				ls_epno		= lds_sle302.GetItemString(j, 'epno')
				ls_epdt		= lds_sle302.GetItemString(j, 'epdt')
				ls_extd		= lds_sle302.GetItemString(j, 'extd')
				
				select	Count(*)
				into		:li_count
				From		sle302_temp
				Where		COMLTD	=	:ls_comltd	and
							CSRNO		=	:ls_csrno	and
							SRNO		=	:ls_srno		Using sqlca;
				if li_count =	0 then
					Insert into sle302_temp
						(comltd,			csrno,		srno,			xplant,		div,			stype,		citno,	
						suse,				frdt,			ordno,		pdcd,			itno,			custcd,		scustcd,	
						srqty,			saqty,		exqty,		cur,			muprc,		luprc,		muamt,
						luamt,			cpcnt,		mkcd,			stcd,			taxcd,		xplan,		kitcd,
						cdqt,				dktm,			psrno,		asrqt1,		asrqt2,		asrqt3,		asrqt4,
						csngb,			ivgb,			costdiv,		ascsn,		epno,			epdt,			extd)
					Values
						(:ls_comltd,	:ls_csrno,	:ls_srno,	:ls_xplant,	:ls_div,		:ls_stype,	:ls_citno,	
						:ls_suse,		:ls_frdt,	:ls_ordno,	:ls_pdcd,	:ls_itno,	:ls_custcd,	:ls_scustcd,	
						:ld_srqty,		:ld_saqty,	:ld_exqty,	:ls_cur,		:ld_muprc,	:ld_luprc,	:ld_muamt,
						:ld_luamt,		:ld_cpcnt,	:ls_mkcd,	:ls_stcd,	:ls_taxcd,	:ls_xplan,	:ls_kitcd,
						:ld_cdqt,		:ls_dktm,	:ls_psrno,	:ld_asrqt1,	:ld_asrqt2,	:ld_asrqt3,	:ld_asrqt4,
						:ls_csngb,		:ls_ivgb,	:ls_costdiv,:ls_ascsn,	:ls_epno,	:ls_epdt,	:ls_extd)
					Using SQLCA;	

					if sqlca.sqlcode	<>	0 then
						ls_error	=	'11'
					End if
				End if
			Next	
		End If	
		
// pdsle301 table flag update
//2003.09.22 조태섭 수정 transaction 수정시
//		Update	PBIPIS.PDSLE301
//		Set		stscd = 'Y',
//					downdate = :ls_date
//		Where		chgdate = :ls_chgdate
//		Using		it_source;
//
	Next		
End If

Destroy lds_pdsle301
Destroy lds_sle302
Destroy lds_sle308

if ls_error	= '00' then
	commit using sqlca;
	sqlca.autocommit = true
	Return True
Else
	rollback using sqlca;
	sqlca.autocommit = true
	Return False
end if
	
end function

public function boolean wf_connect (string fs_ini_file, string fs_source, string fs_destination, ref transaction rt_source, ref transaction rt_destination);Int li_error = 0

wf_disconnect()

//rt_source will be the source transaction
rt_source = Create Transaction

rt_source.DBMS       	= ProfileString(fs_ini_file, fs_source, "DBMS",             "X")
rt_source.Database   	= ProfileString(fs_ini_file, fs_source, "DataBase",         " ")
rt_source.LogID      	= ProfileString(fs_ini_file, fs_source, "LogID",            " ")
rt_source.LogPass    	= ProfileString(fs_ini_file, fs_source, "LogPassword",      " ")
rt_source.ServerName 	= ProfileString(fs_ini_file, fs_source, "ServerName",       " ")
rt_source.UserID     	= ProfileString(fs_ini_file, fs_source, "UserID",           " ")
rt_source.DBPass     	= ProfileString(fs_ini_file, fs_source, "DatabasePassword", " ")
rt_source.Lock       	= ProfileString(fs_ini_file, fs_source, "Lock",             " ")
rt_source.DbParm     	= ProfileString(fs_ini_file, fs_source, "DbParm",           " ")
rt_source.AutoCommit		= True

Connect Using rt_source;
If rt_source.sqlcode <> 0 then 
	Messagebox("Source Connect Error", rt_source.sqlerrtext)
	li_error = rt_source.sqlcode
End If

//rt_destination will be the source transaction
rt_destination = Create Transaction

rt_destination.DBMS       	= ProfileString(fs_ini_file, fs_destination, "DBMS",             "X")
rt_destination.Database   	= ProfileString(fs_ini_file, fs_destination, "DataBase",         " ")
rt_destination.LogID      	= ProfileString(fs_ini_file, fs_destination, "LogID",            " ")
rt_destination.LogPass    	= ProfileString(fs_ini_file, fs_destination, "LogPassword",      " ")
rt_destination.ServerName 	= ProfileString(fs_ini_file, fs_destination, "ServerName",       " ")
rt_destination.UserID     	= ProfileString(fs_ini_file, fs_destination, "UserID",           " ")
rt_destination.DBPass     	= ProfileString(fs_ini_file ,fs_destination, "DatabasePassword", " ")
rt_destination.Lock       	= ProfileString(fs_ini_file, fs_destination, "Lock",             " ")
rt_destination.DbParm     	= ProfileString(fs_ini_file, fs_destination, "DbParm",           " ")

Connect Using rt_destination;

If rt_destination.sqlcode <> 0 then 
	Messagebox("Source Connect Error", rt_destination.sqlerrtext)
	Return False
End If

If li_error = 0 Then
	Return True
Else
	Return False
End If

end function

protected function boolean wf_historymove (string fs_sp_name);// Exec SQL Server Procedure (history move)

String	ls_today, ls_nextmonth, ls_yesterday,	ls_chgdate,	ls_Date,	ls_stscd, ls_error
DataStore	lds_datastore
long		ll_row, ll_error
integer	i

ll_row = 0

ls_today			= String(Date(f_pisc_get_date_nowtime()), 'yyyy.mm.dd')
ls_nextmonth	= f_pisc_get_date_nextmonth(Left(ls_today, 7))					// 2003.02
ls_yesterday	= String(RelativeDate(Date(ls_today), -1), 'yyyy.mm.dd')

lds_datastore	= Create DataStore

Choose case Upper(fs_sp_name)
	Case 'SP_PISI_D_TSRHEADER'
		DECLARE d_tsrheader_movelog procedure for sp_pisi_d_tsrheader_movelog;
		EXECUTE d_tsrheader_movelog ;
//		messagebox('download', 'History Move완료')
//		if sqlca.sqlcode	<> 0 then
//			Destroy lds_Datastore
//			return False
//		End if	
//		
		lds_datastore.DataObject	= 'd_download_pdsle301'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()
//		if sqlca.sqlcode	<>	0	then
//			Destroy lds_Datastore
//			Return False
//		End if	
//				
		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	lds_datastore.GetItemString(i, 'stscd') 		
			if ls_stscd = 'Y' then
				Update	PBIPIS.PDSLE301
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;					
			End If
			if it_source.sqlcode <> 0 tHEN
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
			End If
		Next

		Delete	From	pdsle301 using sqlca;
		
		Destroy lds_Datastore
		Return True
		
	Case 'SP_PISI_D_TSHIPBACK'
		DECLARE d_tshipback_movelog procedure for sp_pisi_d_tshipback_movelog ;
		EXECUTE d_tshipback_movelog ;
		
//		if sqlca.sqlcode	<> 0 then
//			Destroy lds_Datastore
//			return False
//		End if	
//		
		lds_datastore.DataObject	= 'd_download_pdsle501'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()
//		if sqlca.sqlcode	<>	0	then
//			Destroy lds_Datastore
//			Return False
//		End if	
				
		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	lds_datastore.GetItemString(i, 'stscd') 		
			if ls_stscd = 'Y' then
				Update	PBIPIS.PDSLE501
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;					
			End If

			if it_source.sqlcode <> 0 tHEN
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
			End If

		Next

		Delete	From	pdsle501 using sqlca;
		Destroy lds_Datastore
		Return True

	Case 'SP_PISI_D_TSRORDER_MOVE'
		DECLARE d_tsrorder_move_movelog procedure for sp_pisi_d_tsrorder_move_movelog ;
		EXECUTE d_tsrorder_move_movelog ;
		
//		if sqlca.sqlcode	<> 0 then
//			Destroy lds_Datastore
//			return False
//		End if	

		
		lds_datastore.DataObject	= 'd_download_pdinv601'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()
//		if sqlca.sqlcode	<>	0	then
//			Destroy lds_Datastore
//			Return False
//		End if	
				
		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	lds_datastore.GetItemString(i, 'stscd') 		
			if ls_stscd = 'Y' then
				Update	PBIPIS.PDINV601
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;					
			End If

			if it_source.sqlcode <> 0 tHEN
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
			End If
		Next
		
		Delete	From	pdinv601 using sqlca;

		Destroy lds_Datastore
		Return True

	Case 'SP_PISI_D_TSRCOMMENT'
		DECLARE d_tSrcomment_movelog procedure for sp_pisi_d_tsrcomment_movelog ;
		EXECUTE d_tSrcomment_movelog ;
		
//		if sqlca.sqlcode	<> 0 then
//			Destroy lds_Datastore
//			return False
//		End if	
		
		lds_datastore.DataObject	= 'd_download_pdsle305'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()

//		if sqlca.sqlcode	<>	0	then
//			Destroy lds_Datastore
//			Return False
//		End if	

		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	lds_datastore.GetItemString(i, 'Stscd') 	

			if ls_stscd = 'Y' then
				Update	PBIPIS.PDSLE305
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;

			End If

			if it_source.sqlcode <> 0 tHEN
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
			End If

		Next

		Delete	From	pdsle305 using sqlca;
		
		Destroy lds_Datastore
			
		Return True

	Case 'SP_PISI_D_TSALESCODE'
		DECLARE d_tsalescode_movelog procedure for sp_pisi_d_tsalescode_movelog	;
		EXECUTE d_tsalescode_movelog;

//		messagebox('Download', 'History Move완료')

//		if sqlca.sqlcode	<> 0 then
//			messagebox('History', string(sqlca.sqlcode)+sqlca.sqlerrtext)
//			Destroy lds_Datastore
//			return False
//		End if	
//		messagebox('History', 'Move 통과')
		
		lds_datastore.DataObject	= 'd_download_pdsle307'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()
		
//		messagebox('retrieve count', string(ll_row))
		
//		if sqlca.sqlcode	<>	0	then
//			messagebox('history retrieve', string(sqlca.sqlcode)+sqlca.sqlerrtext)
//			Destroy lds_Datastore
//			Return False
//		End if	
//
//		messagebox('history retrieve', '통과')

				
		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	lds_datastore.GetItemString(i, 'stscd') 		
			if ls_stscd = 'Y' then
				Update	PBIPIS.PDSLE307
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;					
			End If

			if it_source.sqlcode <> 0 tHEN
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
						messagebox('error', string(ll_error)+ls_error)
			End If

		Next

//		messagebox('download', 'MIS Update완료')
		
		Delete	From	pdsle307 using sqlca;

//		messagebox('download', 'Download 삭제완료')
		Destroy lds_Datastore		
		Return True

Case 'SP_PISI_D_TSRCANCEL'
		DECLARE d_tsrcancel_movelog procedure for sp_pisi_d_tsrcancel_movelog ;
		EXECUTE d_tsrcancel_movelog ;
		
//		if sqlca.sqlcode	<> 0 then
//			Destroy lds_Datastore
//			return False
//		End if	
		
		lds_datastore.DataObject	= 'd_download_pdsle304'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()
//		if sqlca.sqlcode	<>	0	then
//			Destroy lds_Datastore
//			Return False
//		End if	
				
		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	lds_datastore.GetItemString(i, 'stscd') 		
			if ls_stscd = 'Y' then
				Update	PBIPIS.PDSLE304
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;					
			End If

			if it_source.sqlcode <> 0 tHEN
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
			End If

		Next
		
		Delete	From	pdsle304 using sqlca;

		Destroy lds_Datastore
			
		Return True
	
	Case 'SP_PISI_D_TQBUSINESSTEMP'
		DECLARE d_tqbusinesstemp_movelog procedure for 		sp_pisi_d_tqbusinesstemp_movelog ;
		EXECUTE d_tqbusinesstemp_movelog ;
//		if sqlca.sqlcode	<> 0 then
//			Destroy lds_Datastore
//			return False
//		End if	
		
		lds_datastore.DataObject	= 'd_download_pdinv201'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()
//		if sqlca.sqlcode	<>	0	then
//			Destroy lds_Datastore
//			Return False
//		End if	
				
		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	lds_datastore.GetItemString(i, 'stscd') 		
			if ls_stscd = 'Y' then
				Update	PBIPIS.PDINV201
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;					
			End If

			if it_source.sqlcode <> 0 tHEN
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
			End If

		Next

		Delete	From	pdinv201 using sqlca;
		
		Destroy lds_Datastore
			
		Return True
		
	Case 'SP_PISI_D_TMSTITEM'
		DECLARE d_tmstitem_movelog procedure for sp_pisi_d_tmstitem_movelog ;
		EXECUTE d_tmstitem_movelog ;
		
//		if sqlca.sqlcode	<> 0 then
//			Destroy lds_Datastore
//			return False
//		End if	
		
		lds_datastore.DataObject	= 'd_download_pdinv002'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()
//		if sqlca.sqlcode	<>	0	then
//			Destroy lds_Datastore
//			Return False
//		End if	
				
		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	lds_datastore.GetItemString(i, 'stscd') 		
			if ls_stscd = 'Y' then
				Update	PBIPIS.PDINV002
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;					
			End If

			if it_source.sqlcode <> 0 tHEN
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
			End If

		Next

		Delete	From	pdinv002 using sqlca;
		Destroy lds_Datastore
		Return True

	Case 'SP_PISI_D_TMSTMODEL'
		DECLARE d_tmstmodel_movelog procedure for sp_pisi_d_tmstmodel_movelog ;
		EXECUTE d_tmstmodel_movelog ;
		
//		if sqlca.sqlcode	<> 0 then
//			Destroy lds_Datastore
//			return False
//		End if	
		
		lds_datastore.DataObject	= 'd_download_pdinv101'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()
//		if sqlca.sqlcode	<>	0	then
//			Destroy lds_Datastore
//			Return False
//		End if	
				
		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	lds_datastore.GetItemString(i, 'stscd') 		
			if ls_stscd = 'Y' then
				Update	PBIPIS.PDINV101
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;					
			End If

			if it_source.sqlcode <> 0 tHEN
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
			End If

		Next

		Delete	From	pdinv101 using sqlca;
		
		Destroy lds_Datastore
			
		Return True
		
	Case 'SP_PISI_D_TMSTCUSTOMER_TMSTSUPPLIER'		
		DECLARE d_tmstcustomer_tmstsupplier_movelog procedure for sp_pisi_d_tmstcustomer_tmstsupplier_movelog;
		EXECUTE d_tmstcustomer_tmstsupplier_movelog ;

//		if sqlca.sqlcode	<> 0 then
//			Destroy lds_Datastore
//			return False
//		End if	
		
		lds_datastore.DataObject	= 'd_download_pdpur101'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()
//		if sqlca.sqlcode	<>	0	then
//			Destroy lds_Datastore
//			Return False
//		End if	
				
		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	lds_datastore.GetItemString(i, 'stscd') 		
			if ls_stscd = 'Y' then
				Update	PBIPIS.PDPUR101
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;					
			End If

			if it_source.sqlcode <> 0 tHEN
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
			End If

		Next

		Delete	From	pdpur101 using sqlca;
		
		Destroy lds_Datastore
			
		Return True

	Case 'SP_PISI_D_TMSTSUPPLIER'		
		DECLARE d_tmstsupplier_movelog procedure for sp_pisi_d_tmstsupplier_movelog;
		EXECUTE d_tmstsupplier_movelog ;

//		if sqlca.sqlcode	<> 0 then
//			Destroy lds_Datastore
//			return False
//		End if	
		
		lds_datastore.DataObject	= 'd_download_pdpur102'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()
//		if sqlca.sqlcode	<>	0	then
//			Destroy lds_Datastore
//			Return False
//		End if	
	
		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	lds_datastore.GetItemString(i, 'stscd') 		
			if ls_stscd = 'Y' then
				Update	PBIPIS.PDPUR102
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;					
			End If

			if it_source.sqlcode <> 0 tHEN
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
			End If

		Next

		Delete	From	pdpur102 using sqlca;
		
		Destroy lds_Datastore
			
		Return True

	Case 'SP_PISI_D_TMSTCUSTITEM'		
		DECLARE d_tmstcustitem_movelog procedure for sp_pisi_d_tmstcustitem_movelog;
		EXECUTE d_tmstcustitem_movelog ;

//		if sqlca.sqlcode	<> 0 then
//			Destroy lds_Datastore
//			return False
//		End if	
		
		lds_datastore.DataObject	= 'd_download_pdsle101'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()
//		if sqlca.sqlcode	<>	0	then
//			Destroy lds_Datastore
//			Return False
//		End if	
				
		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	lds_datastore.GetItemString(i, 'stscd') 		
			if ls_stscd = 'Y' then
				Update	PBIPIS.PDSLE101
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;					
			End If

			if it_source.sqlcode <> 0 tHEN
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
			End If

		Next

		Delete	From	pdsle101 using sqlca;

		Destroy lds_Datastore
		Return True

	Case 'SP_PISI_D_TMSTPARTCOST'
		DECLARE d_partcost_movelog procedure for sp_pisi_d_tmstpartcost_movelog;
		EXECUTE d_partcost_movelog ;
		
//		if sqlca.sqlcode	<> 0 then
//			Destroy lds_Datastore
//			return False
//		End if	
		
		lds_datastore.DataObject	= 'd_download_pdpur103'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()
//		if sqlca.sqlcode	<>	0	then
//			Destroy lds_Datastore
//			Return False
//		End if	
				
		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	lds_datastore.GetItemString(i, 'stscd') 		
			if ls_stscd = 'Y' then
				Update	PBIPIS.PDPUR103
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;					
			End If

			if it_source.sqlcode <> 0 tHEN
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
			End If

		Next

		Delete	From	pdpur103 using sqlca;
		
		Destroy lds_Datastore
			
		Return True

	Case 'SP_PISI_D_PDSLE401'
		DECLARE d_pdsle401_movelog procedure for sp_pisi_d_pdsle401_movelog;
		EXECUTE d_pdsle401_movelog ;
		
//		if sqlca.sqlcode	<> 0 then
//			Destroy lds_Datastore
//			return False
//		End if	
		
		lds_datastore.DataObject	= 'd_download_pdsle401'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()
//		if sqlca.sqlcode	<>	0	then
//			Destroy lds_Datastore
//			Return False
//		End if	
				
		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	lds_datastore.GetItemString(i, 'stscd') 		
			if ls_stscd = 'Y' then
				Update	PBIPIS.PDSLE401
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;					
			End If

			if it_source.sqlcode <> 0 tHEN
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
			End If

		Next

		Delete	From	pdsle401 using sqlca;

		Destroy lds_Datastore
		
		Return True
		
	Case 'SP_PISI_D_TMHLABTAC'
		DECLARE d_tmhlabtac_movelog procedure for sp_pisi_d_tmhlabtac_movelog;
		EXECUTE d_tmhlabtac_movelog ;
		
//		if sqlca.sqlcode	<> 0 then
//			Destroy lds_Datastore
//			return False
//		End if	
		
		Delete	From	tmislabtac using sqlca;
		
		Destroy lds_Datastore
			
		Return True
	Case Else
		Return True
End Choose
				
If ll_error = 0 Then
	Commit Using it_source ;
Else
	RollBack Using it_source ;
	f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_foillength.DELETE IMSLIB.WGF18M : ' + ls_error)
	MessageBox(string(it_source.sqldbcode),ls_error, StopSign!)
End If
Return True
end function

public function boolean wf_auto_download (); 
Long		ll_row, i
Int		rowcount

ll_row	= dw_interface.Rowcount()

For i = 1 To ll_row
	// server 연결이 안되었거나 야간엔 돌지 않는다...
	If Not wf_connect_check(SQLCA, it_source) Then	
		// 일간 또는 월간단위 timer를 다시 10분 간격으로 변경
		If is_cycle = 'DD' or is_cycle = 'MM' Then
			Timer(600)
		End If	
		
		Exit
	End If

	ii_interface_id = dw_interface.GetItemNumber(i, 'InterfaceID')
	is_sp_name = dw_interface.GetItemString(i, 'ProcedureName')
	
	dw_interface.SelectRow(0, False)
	dw_interface.SelectRow(i, True)	
	dw_interface.ScrollToRow(i)
	
	uo_parameter.Event Trigger ue_retrieve(ii_interface_id, rowcount)

	// 초단위, 분단위(30분), 시간단위 수행
	If is_cycle = 'SS' or is_cycle = 'MI' or is_cycle = 'HH' Then
		If uo_parameter.dw_1.GetItemString(1, 'CycleOption') = is_cycle Then
			If uo_parameter.dw_1.GetItemString(1, 'EnableFlag') = 'Y' Then		
				ib_interface = True
				uo_pipe.cb_repair.Enabled	= False
				uo_pipe.cb_cancel.Enabled	= True
				uo_button.uf_button_enable(False, False, False)
				uo_parameter.Enabled	= False
				dw_interface.Enabled	= False
				uo_option.Enabled		= False
				uo_date.Enabled		= False
				
				If	wf_download()	Then
					If wf_HistoryMove(is_sp_name) Then
						If wf_exec_sp(is_sp_name) Then
								wf_dw_init(1)
						End If
					End If	
				End If
					
				uo_button.uf_button_enable(True, False, True)
				uo_parameter.Enabled	= True
				dw_interface.Enabled	= True
				uo_option.Enabled		= True
				uo_date.Enabled		= True
				
				ib_interface = False
			End If	
		End If
		
		Yield()	
		If ib_cancel Then 
			ib_cancel = False
			Exit
		End If
	
	End If

	// 일간단위일때는 저녁 7시에서 8시 사이에만 한번 수행 
	// 월간단위일때는 매월 20일 이후 저녁 7시에서 8시 사이에만 한번 수행
	If (is_cycle = 'DD' or &
		(is_cycle = 'MM' and (String(Today(), 'dd') >= '20' or String(Today(), 'dd') <= '05')))	Then

		If uo_parameter.dw_1.GetItemString(1, 'CycleOption') = is_cycle Then
			If uo_parameter.dw_1.GetItemString(1, 'EnableFlag') = 'Y' Then		
				ib_interface = True
				uo_pipe.cb_repair.Enabled	= False
				uo_pipe.cb_cancel.Enabled	= True
				uo_button.uf_button_enable(False, False, False)
				uo_parameter.Enabled	= False
				dw_interface.Enabled	= False
				uo_option.Enabled		= False
				uo_date.Enabled		= False
				
				If	wf_download()	Then
					If wf_HistoryMove(is_sp_name) Then
						If wf_exec_sp(is_sp_name) Then
							wf_dw_init(1)
						End If
					End If	
				End If
					
				uo_button.uf_button_enable(True, False, True)
				uo_parameter.Enabled	= True
				dw_interface.Enabled	= True
				uo_option.Enabled		= True
				uo_date.Enabled		= True
				
				ib_interface = False
			End If	
		End If
		
		Yield()	
		If ib_cancel Then 
			ib_cancel = False
			Exit
		End If
		
		// 일간 또는 월간단위 전체 수행한후 당일 재수행을 막기위해서...
//		If i = ll_row Then
//			Timer(3600)
//		End If	
			
	End If	
Next	

return true
end function

public function boolean wf_download ();// return value 0 -> 정상, 1->history작업이외의 작업은 할것 9->next모든 작업 하지말것

Int		li_return, rowcount, li_second,	li_cycletime
Long		ll_start_time, ll_end_time
String	ls_interface_gubun, ls_source, ls_destination
String	ls_pipeline_name, ls_interface_name, ls_parm, ls_fail_gubun
String	ls_today, ls_nextmonth, ls_century, ls_year, ls_month, ls_date,&
			ls_yesterday,	ls_YesterMonth
String	ls_lastdate, ls_lasttime, ls_datetime,	ls_EndDateTime
DateTime	ldt_lastdatetime
Date		ld_lastdate, ld_currentDate
Time		lt_lasttime, lt_currenttime, lt_jobtime


SetPointer(HourGlass!)

Select InterfaceGubun,
		 Source,
		 Destination,
		 CycleTime,
		 PipeLineName,
		 InterfaceName,
		 LastExecuted
  Into :ls_interface_gubun,
  		 :ls_source,
		 :ls_destination,
		 :li_CycleTime,
		 :ls_pipeline_name,
		 :ls_interface_name,
		 :ldt_lastdatetime
  From tINTERFACE
 Where InterfaceID = :ii_interface_id ;

if sqlca.sqlcode <> 0 then
	return False
end if

If Not wf_flag_check(ls_pipeline_name, is_action_name, ls_fail_gubun) Then
	If ls_fail_gubun = 'Y' Then
		MessageBox("DownLoad", "현재 해당 정보의 DownLoad를 수행중입니다.")
	End If
	If ls_fail_gubun = 'E' Then
		MessageBox("DownLoad", "DownLoad Flag 정보 Update중 오류가 발생하였습니다.")
	End If
	Return False
End If

if sqlca.sqlcode <> 0 then
	return False
end if

If Not wf_connect(gs_ini_file, ls_source, ls_destination, it_source, it_destination) Then
	wf_flag_update(is_action_name)
	Return False
End If

if sqlca.sqlcode <> 0 then
	return False
end if

ld_lastdate	=	Date(ldt_lastdatetime)
lt_lasttime	=	Time(ldt_lastdatetime)

if			is_cycle	=	'MI' Then
			li_second	=	li_cycletime	*	60
ElseIf	is_Cycle	=	'HH' Then
			li_second	=	li_cycletime	*	3600
End if			

// Host 시간 읽어서 마지막 실행시간 update(근태 데이타 다운로드 땜시...)
ls_datetime = wf_get_host_datetime()

if it_source.sqlcode <> 0 then
	wf_flag_update(is_action_name)
	return True  // Server는 살아 있다 그러니까 다음 작업은 할수 있게 True값을 준다
end if

ld_CurrentDate	=	Date(is_currentdate)
lt_CurrentTime	=	Time(is_currenttime)

if ib_auto	then
	if is_Cycle	<>	'SS'	Then
		if is_cycle = 'DD' or is_Cycle = 'MM' then
			If Upper(ls_pipeline_name) = 'P_DOWNLOAD_WIP001' Then
				If String(lt_CurrentTime,'hhmmss') > '070000' and String(lt_CurrentTime,'hhmmss') < '080000' Then
					if ld_lastDate	=	ld_CurrentDate	Then
						If String(lt_LastTime,'hhmmss') < '080000'	Then
							wf_flag_update(is_action_name)
							Return False
						End If
					End If
				Else
					wf_flag_update(is_action_name)
					Return False
				End If
			Else
				If String(lt_CurrentTime,'hhmmss') > '200000' Then
					if ld_lastDate	=	ld_CurrentDate	Then
						If String(lt_LastTime,'hhmmss') > '200000'	Then
							wf_flag_update(is_action_name)
							Return True
						End If
					End If
				Else
					If String(lt_CurrentTime,'hhmmss') < '050000' Then
						If ld_lastDate	=	RelativeDate(ld_CurrentDate, -1)	Then
							If String(lt_LastTime,'hhmmss') > '200000'	Then
								wf_flag_update(is_action_name)
								Return True
							End If
						Else
							If ld_lastDate	=	ld_CurrentDate	Then
								If String(lt_LastTime,'hhmmss') < '050000'	Then
									wf_flag_update(is_action_name)
									Return True
								End If
							End If
						End if	
					Else
						wf_flag_update(is_action_name)
						Return True
					End If	
				End If
			End If
		Else
			if ld_lastdate	=	ld_currentdate	then
				lt_jobtime	= RelativeTime(lt_lasttime, li_second)
	
				if	lt_jobtime > lt_currenttime then
					wf_flag_update(is_action_name)
	
					return True  //Pipe Line은 수행 않하더라도 다음 작업은 할수있다...(수행간격과 down간격이 다름므로)
				End if
	
			End If
		End If
	End if
End If
	
wf_last_execute_update(ls_datetime)

//create a instance scope pipeline and set its output objects
//the output objects will allow you to monitor the status during the pipeline 
//execution

ip_pipe = Create p_pipe_wmeter

ip_pipe.st_read    = uo_pipe.st_read
ip_pipe.st_written = uo_pipe.st_written
ip_pipe.st_errors  = uo_pipe.st_error

//pipe object to do the transaction to master updates
ip_pipe.dataobject = ls_pipeline_name

//get time for a total elapsed time
ll_start_time = Cpu ()

uo_pipe.st_read.Text		= '0'
uo_pipe.st_written.Text = '0'
uo_pipe.st_error.Text	= '0'
uo_pipe.st_time.Text		= ''

dw_1.DataObject			= ''

dw_1.SetPosition(ToTop!)
st_horizontal.SetPosition(ToTop!)
st_vertical.SetPosition(ToTop!)

ls_today			=	String(Date(f_pisc_get_date_nowtime()), 'yyyy.mm.dd')
ls_nextmonth	=	f_pisc_get_date_nextmonth(Left(ls_today, 7))					// 2003.02
ls_yesterday	=	String(RelativeDate(Date(ls_today), -1), 'yyyymmdd')
ls_lastdate		=	String(ldt_lastdatetime, 'yyyymmdd')
ls_lasttime		=	String(ldt_lastdatetime, 'hh:mm')
ls_YesterMonth	=	left(String(RelativeDate(Date(left(ls_today,7)+'.01'), -1), 'yyyymmdd'),6)

//execute pipeline

Choose Case Upper(ls_pipeline_name)
	Case 'P_DOWNLOAD_TCALENDARSHOP_NEW'
		ls_nextmonth = Left(ls_nextmonth, 4) + Right(ls_nextmonth, 2)
		li_return = ip_pipe.start (it_source, it_destination, dw_1, ls_nextmonth + '%')
	Case 'P_DOWNLOAD_TMISPLANMONTH_NEW'
		li_return = ip_pipe.start (it_source, it_destination, dw_1, Left(ls_nextmonth, 4), Right(ls_nextmonth, 2))
	Case 'P_DOWNLOAD_TMSTROUTING'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_TMSTROUTING_SUBITEM'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_TPARTMONTHPLAN'
		ls_nextmonth	= Mid(ls_Today, 1, 4) + Mid(ls_Today,6,2)
		li_return = ip_pipe.start (it_source, it_destination, dw_1, ls_NextMonth)
	Case 'P_DOWNLOAD_TMISLABTAC_NEW'
		li_return = ip_pipe.start (it_source, it_destination, dw_1, ls_lastdate + ls_lasttime)
	Case 'P_DOWNLOAD_PDINV101'		// test용으로 날짜 제어 
		ls_date = '2002-11-27'
		li_return = ip_pipe.start (it_source, it_destination, dw_1, ls_date)
	Case 'P_DOWNLOAD_PDSLE101'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_SLE904'
		ls_today = Left(ls_today, 4) + Mid(ls_today, 6, 2) + Right(ls_today, 2)
		li_return = ip_pipe.start (it_source, it_destination, dw_1, ls_today)
	Case 'P_DOWNLOAD_PDPUR101'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_PDPUR102'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_PDINV002'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_PDINV201'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_PDSLE301'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_PDSLE501'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_PDINV601'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_PDINV401'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_PDSLE304'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_PDSLE401'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_PDSLE305'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_PDSLE307'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_PDPUR103'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_TMISDEPT'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_PJT101'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_TMSTBOM'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_TBOMOPTIONITEM'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_FIA030'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_TMISEMP'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_DAC007'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
		if li_return = 1 then
			//pipe object to do the transaction to master updates
			ip_pipe.dataobject = 'P_DOWNLOAD_DAC004'
			
			//get time for a total elapsed time
			ll_start_time = Cpu ()
			
			uo_pipe.st_read.Text 	=	'0'
			uo_pipe.st_written.Text =	'0'
			uo_pipe.st_error.Text 	=	'0'
			uo_pipe.st_time.Text		=	''
			
			dw_1.DataObject			=	''
			li_return = ip_pipe.start (it_source, it_destination, dw_1)
		end if

	Case 'P_DOWNLOAD_SLE201'
		ls_nextmonth = Left(ls_nextmonth, 4) + Right(ls_nextmonth, 2)
		li_return = ip_pipe.start (it_source, it_destination, dw_1, ls_nextmonth)
	Case 'P_DOWNLOAD_MPS003'
		ls_year = Left(ls_nextmonth, 4)
		ls_month = Right(ls_nextmonth, 2)		
		li_return = ip_pipe.start (it_source, it_destination, dw_1, ls_year, ls_month)
	Case 'P_DOWNLOAD_DAC002'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_TMSTBOMDATA'
		li_return = ip_pipe.start (it_source, it_destination, dw_1, ls_YesterMonth)
	Case 'P_DOWNLOAD_WIP001'
		li_return = ip_pipe.start (it_source, it_destination, dw_1)
	Case 'P_DOWNLOAD_RNDITEM'
		ls_today = Left(ls_today, 4) + Mid(ls_today, 6, 2) + Right(ls_today, 2)
		li_return = ip_pipe.start (it_source, it_destination, dw_1, ls_today)
End Choose	

//get ending time
ll_end_time = Cpu ()
uo_pipe.st_time.text = string((ll_end_time - ll_start_time)/1000,"##0.0") + " Secs"

CHOOSE CASE li_return
	CASE 1
		If Integer(uo_pipe.st_error.Text) > 0 Then
			wf_raiserror(ls_pipeline_name)
		ELse
			wf_flag_update(is_action_name)
		End If
		uo_pipe.cb_cancel.Enabled	= False
		uo_parameter.Event Trigger ue_retrieve(ii_interface_id, rowcount)

		If Integer(uo_pipe.st_error.Text) > 0 Then
			uo_pipe.cb_repair.Enabled	= True
			wf_flag_update(is_action_name)
			
			ls_Enddatetime = wf_get_host_datetime()
			wf_pipe_End_update(ls_Enddatetime)
		
			Return False
		Else
			uo_pipe.cb_repair.Enabled	= False
		
			If Integer(uo_pipe.st_read.Text) = 0 Then
				wf_dw_init(1)
				wf_flag_update(is_action_name)
			
				ls_Enddatetime = wf_get_host_datetime()
				wf_pipe_End_update(ls_Enddatetime)
				
				Return True
			End If
		
			If Upper(ls_pipeline_name) = 'P_DOWNLOAD_PDSLE301' Then
				if wf_download_sr()	then
					wf_flag_update(is_action_name)
		
					ls_Enddatetime = wf_get_host_datetime()
					wf_pipe_End_update(ls_Enddatetime)

					Return	True
				Else
					wf_flag_update(is_action_name)
					
					ls_Enddatetime = wf_get_host_datetime()
					wf_pipe_End_update(ls_Enddatetime)

					Return	False
				End If	
			End If	
			wf_flag_update(is_action_name)
			
			ls_Enddatetime = wf_get_host_datetime()
			wf_pipe_End_update(ls_Enddatetime)

			Return True
		End If		
		
	CASE -1
		MessageBox("PipeLine Error", "Pipe open failed")
	CASE -2
		MessageBox("PipeLine Error","Too many columns")
	CASE -3
		MessageBox("PipeLine Error","Table already exists")
	CASE -4
		MessageBox("PipeLine Error","Table does not exist")
	CASE -5
		MessageBox("PipeLine Error","Missing connection")
	CASE -6
		MessageBox("PipeLine Error","Wrong arguments")
	CASE -7
		MessageBox("PipeLine Error","Column mismatch")
	CASE -8
		MessageBox("PipeLine Error","Fatal SQL error in source")
	CASE -9
		MessageBox("PipeLine Error","Fatal SQL error in destination")
	CASE -10
		MessageBox("PipeLine Error","Maximum number of errors exceeded")
	CASE -12
		MessageBox("PipeLine Error","Bad table syntax")
	CASE -13
		MessageBox("PipeLine Error","Key required but not supplied")
	CASE -15
		MessageBox("PipeLine Error","Pipe already in progress")
	CASE -16
		MessageBox("PipeLine Error","Error in source database")
	CASE -17
		MessageBox("PipeLine Error","Error in destination database")
	CASE -18
		MessageBox("PipeLine Error","Destination database is read-only")
END CHOOSE

wf_flag_update(is_action_name)

ls_Enddatetime = wf_get_host_datetime()
wf_pipe_End_update(ls_Enddatetime)

Return false
end function

public function boolean wf_exec_sp (string fs_sp_name);// Exec SQL Server Procedure
long		ll_row
Integer	i
String	ls_today, ls_nextmonth, ls_yesterday
String	ls_ChgDate,	ls_date,	ls_stscd
DataStore	lds_datastore

ls_today = String(Date(f_pisc_get_date_nowtime()), 'yyyy.mm.dd')
ls_nextmonth = f_pisc_get_date_nextmonth(Left(ls_today, 7))					// 2003.02
ls_yesterday = String(RelativeDate(Date(ls_today), -1), 'yyyy.mm.dd')

Choose case Upper(fs_sp_name)
	Case 'SP_PISI_D_TSRHEADER'
		DECLARE d_tsrheader procedure for sp_pisi_d_tsrheader;
		EXECUTE d_tsrheader ;
	Case 'SP_PISI_D_TSRCANCEL'
		DECLARE d_tsrcancel procedure for sp_pisi_d_tsrcancel;
		EXECUTE d_tsrcancel ;
	Case 'SP_PISI_D_TSHIPBACK'
		DECLARE d_tshipback procedure for sp_pisi_d_tshipback;
		EXECUTE d_tshipback ;
	Case 'SP_PISI_D_TSRORDER_MOVE'
		DECLARE d_tsrorder_move procedure for sp_pisi_d_tsrorder_move;
		EXECUTE d_tsrorder_move ;
	Case 'SP_PISI_D_TSRCOMMENT'
		DECLARE d_tsrcomment procedure for sp_pisi_d_tsrcomment;
		EXECUTE d_tsrcomment ;
	Case 'SP_PISI_D_TSALESCODE'
		DECLARE d_tsalescode procedure for sp_pisi_d_tsalescode;
		EXECUTE d_tsalescode ;
	Case 'SP_PISI_D_TQBUSINESSTEMP'
		DECLARE d_tqbusinesstemp procedure for sp_pisi_d_tqbusinesstemp;
		EXECUTE d_tqbusinesstemp ;
	Case 'SP_PISI_D_INVTRANS'
		DECLARE d_invtrans procedure for sp_pisi_d_invtrans;
		EXECUTE d_invtrans ;

		lds_datastore	= Create Datastore
		
		lds_datastore.DataObject	= 'd_download_pdinv401'
		lds_datastore.SetTransObject(SQLCA)
		ll_row	= lds_datastore.Retrieve()
		For i = 1 To ll_row
			ls_chgdate	= lds_datastore.GetItemString(i, 'ChgDate') 
			ls_date 		= String(Today(), 'yyyy.mm.dd hh:mm:ss')
			ls_stscd		=	trim(lds_datastore.GetItemString(i, 'stscd'))
			if ls_stscd = 'Y' then
				Update	PBIPIS.PDINV401
				Set		stscd = 'Y',
							downdate = :ls_date
				Where		Chgdate	=	:ls_chgDate
				Using		it_source;					
			End If
		Next
	Case 'SP_PISI_D_TMSTITEM'
		DECLARE d_tmstitem procedure for sp_pisi_d_tmstitem;
		EXECUTE d_tmstitem ;
	Case 'SP_PISI_D_TMSTMODEL'		
		DECLARE d_tmstmodel procedure for sp_pisi_d_tmstmodel;
		EXECUTE d_tmstmodel ;
	Case 'SP_PISI_D_TMSTCUSTOMER_TMSTSUPPLIER'		
		DECLARE d_tmstcustomer_tmstsupplier procedure for sp_pisi_d_tmstcustomer_tmstsupplier;
		EXECUTE d_tmstcustomer_tmstsupplier ;
	Case 'SP_PISI_D_TMSTSUPPLIER'		
		DECLARE d_tmstsupplier procedure for sp_pisi_d_tmstsupplier;
		EXECUTE d_tmstsupplier ;
	Case 'SP_PISI_D_TMSTCUSTITEM'		
		DECLARE d_tmstcustitem procedure for sp_pisi_d_tmstcustitem;
		EXECUTE d_tmstcustitem ;
	Case 'SP_PISI_D_TMSTPARTCOST'
		DECLARE d_partcost procedure for sp_pisi_d_tmstpartcost;
		EXECUTE d_partcost ;
	Case 'SP_PISI_D_TPLANDDRS'
		DECLARE d_tplanddrs procedure for sp_pisi_d_tplanddrs
			@ps_date = :ls_today;
		EXECUTE d_tplanddrs ;
	Case 'SP_PISI_D_PDSLE401'
		DECLARE d_pdsle401 procedure for sp_pisi_d_pdsle401;
		EXECUTE d_pdsle401 ;
	Case 'SP_PISI_D_TMHLABTAC'
		DECLARE d_tmhlabtac procedure for sp_pisi_d_tmhlabtac;
		EXECUTE d_tmhlabtac ;
	Case 'SP_PISI_D_TMSTBOM'
		DECLARE d_tmstbom procedure for SP_PISI_D_TMSTBOM;
		EXECUTE d_tmstbom ;
	Case 'SP_PISI_D_TBOMOPTIONITEM'
		DECLARE d_tbomoption procedure for SP_PISI_D_TBOMOPTIONITEM;
		EXECUTE d_tbomoption ;
	Case 'SP_PISI_D_TMSTROUTING'		
		DECLARE d_tmstrouting procedure for sp_pisi_d_tmstrouting;
		EXECUTE d_tmstrouting ;
	Case 'SP_PISI_D_TMSTPROJECT'
		DECLARE d_tmstproject procedure for SP_PISI_D_TMSTPROJECT;
		EXECUTE d_tmstproject ;
	Case 'SP_PISI_D_TMSTDEPT'
		DECLARE d_tmstdept procedure for SP_PISI_D_TMSTDEPT;
		EXECUTE d_tmstdept ;
	Case 'SP_MCMASTER_NO_DOWN'
		DECLARE d_fia030 procedure for SP_MCMASTER_NO_DOWN;
		EXECUTE d_fia030 ;
	Case 'SP_PISI_D_TMSTEMP'
		DECLARE d_tmstemp procedure for SP_PISI_D_TMSTEMP;
		EXECUTE d_tmstemp ;
	Case 'SP_PISI_D_TMSTPRODUCT'
		DECLARE d_tmstproduct procedure for SP_PISI_D_TMSTPRODUCT;
		EXECUTE d_tmstproduct ;
	Case 'SP_PISI_D_TMSTCODE'
		DECLARE d_tmstcode procedure for SP_PISI_D_TMSTCODE;
		EXECUTE d_tmstcode ;
	Case 'SP_PISI_D_TCALENDARSHOP_NEW'		
		DECLARE d_tcalendarshop procedure for sp_pisi_d_tcalendarshop_new
			@ps_month = :ls_nextmonth;
		EXECUTE d_tcalendarshop ;
	Case 'SP_PISI_D_TPLANMONTH'		
		DECLARE d_tplanmonth procedure for sp_pisi_d_tplanmonth
			@ps_month = :ls_nextmonth;
		EXECUTE d_tplanmonth ;
	Case 'SP_PISI_D_TPARTMONTHPLAN'
		ls_nextMonth	=	mid(ls_today,1,4)+mid(ls_today,6,2)
		DECLARE d_tpartmonthplan procedure for sp_pisi_d_tpartmonthplan
			@ps_month = :ls_nextmonth;
		EXECUTE d_tpartmonthplan ;
	Case 'SP_PISI_D_TSHIPPLANMONTH'
		DECLARE d_tshipplanmonth procedure for SP_PISI_D_TSHIPPLANMONTH
			@ps_month = :ls_nextmonth;
		EXECUTE d_tshipplanmonth ;
	Case 'SP_PISI_D_TMSTBOMDATA'
		DECLARE d_tmstbomdata procedure for SP_PISI_D_TMSTBOMDATA;
		EXECUTE d_tmstbomdata ;
	Case 'SP_PISI_D_TSEQWIP001'
		DECLARE d_tseqwip001 procedure for SP_PISI_D_TSEQWIP001;
		EXECUTE d_tseqwip001 ;
		
		// 외주간판 단품AS/KD 메일발송로직 추가 ( 2008.06.02 )
		wf_email_warning()
		// 메일발송 로직 끝
		
	Case 'SP_PISI_D_RNDITEM'
		DECLARE d_rnditem procedure for SP_PISI_D_RNDITEM;
		EXECUTE d_rnditem ;
End Choose
Destroy lds_Datastore
//If SQLCA.SQLCode = 0 Then
//	Return True
//Else
//	Return False
//End If

Return True
end function

public function boolean wf_flag_check (string fs_pipeline_name, ref string rs_action_name, ref string rs_fail_gubun);String ls_flag, ls_note

SetNull(ls_flag)

CHOOSE CASE Upper(fs_pipeline_name)
	CASE 'P_DOWNLOAD_TCALENDARSHOP_NEW'
		rs_action_name = 'DOWNLOAD_SHOPCALENDAR'
		ls_note			= 'Shop Calendar Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_TMISPLANMONTH_NEW'
		rs_action_name = 'DOWNLOAD_PLANMONTH'
		ls_note			= 'Plan Month Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_TMSTROUTING'
		rs_action_name = 'DOWNLOAD_ROUTING'
		ls_note			= 'Routing Master Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_TMSTROUTING_SUBITEM'
		rs_action_name = 'DOWNLOAD_ROUTINGSUBITEM'
		ls_note			= 'Routing Subitem Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_TPARTMONTHPLAN'
		rs_action_name = 'DOWNLOAD_PARTMONTHPLAN'
		ls_note			= 'Part Month Plan Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_TMISLABTAC_NEW'
		rs_action_name = 'DOWNLOAD_MANHOUR'
		ls_note			= 'ManHour Data Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_PDINV101'
		rs_action_name = 'DOWNLOAD_MODEL'
		ls_note			= 'Model Master Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_PDSLE101'
		rs_action_name = 'DOWNLOAD_CUSTOMERITEM'
		ls_note			= 'Customer Item Master Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_SLE904'
		rs_action_name = 'DOWNLOAD_DDRSPLAN'
		ls_note			= 'DDRS Plan Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_PDPUR101'
		rs_action_name = 'DOWNLOAD_CUSTOMER_SUPPLIER'
		ls_note			= 'Customer Supplier Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_PDPUR102'
		rs_action_name = 'DOWNLOAD_SUPPLIER'
		ls_note			= 'Supplier Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_PDINV002'
		rs_action_name = 'DOWNLOAD_ITEM'
		ls_note			= 'Item Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_PDINV201'
		rs_action_name = 'DOWNLOAD_TQBUSINESSTEMP'
		ls_note			= '납품현황 Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_PDSLE501'
		rs_action_name = 'DOWNLOAD_TSHIPBACK'
		ls_note			= 'Ship back Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_PDINV601'
		rs_action_name = 'DOWNLOAD_SRMOVE'
		ls_note			= 'SR 이체 Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_PDINV401'
		rs_action_name = 'DOWNLOAD_INVTRANS'
		ls_note			= '공무자재 trans Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_PDSLE304'
		rs_action_name = 'DOWNLOAD_SRCANCEL'
		ls_note			= 'SR 취소 Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_PDSLE301'
		rs_action_name = 'DOWNLOAD_SR'
		ls_note			= 'SR Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_PDSLE401'
		rs_action_name = 'DOWNLOAD_PDSLE401'
		ls_note			= '영업납품확인 Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_PDPUR103'
		rs_action_name = 'DOWNLOAD_PDPUR103'
		ls_note			= 'TMSTPARTCOST Interface Flag For DownLoad'		
	CASE 'P_DOWNLOAD_TMISDEPT'
		rs_action_name = 'DOWNLOAD_TMSTDEPT'
		ls_note			= '부서 MASTER Interface Flag For DownLoad'		
	CASE 'P_DOWNLOAD_TMSTBOM'
		rs_action_name = 'DOWNLOAD_TMSTBOM'
		ls_note			= 'BOM Interface Flag For DownLoad'	
	CASE 'P_DOWNLOAD_TBOMOPTIONITEM'
		rs_action_name = 'DOWNLOAD_TBOMOPTIONITEM'
		ls_note			= 'BOM Option Flag For DownLoad'
	CASE 'P_DOWNLOAD_PJT101'
		rs_action_name = 'DOWNLOAD_TMSTPROJECT'
		ls_note			= 'PROJECT Interface Flag For DownLoad'		
	CASE 'P_DOWNLOAD_FIA030'
		rs_action_name = 'DOWNLOAD_FIA030'
		ls_note			= '장비 MASTER Interface Flag For DownLoad'		
	CASE 'P_DOWNLOAD_TMISEMP'
		rs_action_name = 'DOWNLOAD_TMSTEMP'
		ls_note			= '인원 MASTER Interface Flag For DownLoad'		
	CASE 'P_DOWNLOAD_DAC007'
		rs_action_name = 'DOWNLOAD_TMSTPRODUCT'
		ls_note			= 'PRODUCT MASTER Interface Flag For DownLoad'		
	CASE 'P_DOWNLOAD_SLE201'
		rs_action_name = 'DOWNLOAD_TSHIPPLANYEAR'
		ls_note			= 'TSHIPPLANYEAR(EIS) Interface Flag For DownLoad'		
	CASE 'P_DOWNLOAD_MPS003'
		rs_action_name = 'DOWNLOAD_TSHIPPLANMONTH'
		ls_note			= 'TSHIPPLANMONTH(EIS) MASTER Interface Flag For DownLoad'		
	CASE 'P_DOWNLOAD_DAC002'
		rs_action_name = 'DOWNLOAD_TMSTCODE'
		ls_note			= '공통코드 MASTER Interface Flag For DownLoad'		
	CASE 'P_DOWNLOAD_TMSTBOMDATA'
		rs_action_name = 'DOWNLOAD_TMSTBOMDATA'
		ls_note			= '원단위 정보 Interface Flag For DownLoad'	
	CASE 'P_DOWNLOAD_WIP001'
		rs_action_name = 'DOWNLOAD_WIP001'
		ls_note			= '재공 정보 Interface Flag For DownLoad'
	CASE 'P_DOWNLOAD_RNDITEM'
		rs_action_name = 'DOWNLOAD_RNDITEM'
		ls_note			= '연구소자재 Interface Flag For DownLoad'
END CHOOSE

Select Flag Into :ls_flag
  From MSTFLAG
 Where ActionName = :rs_action_name;
 
SQLCA.AutoCommit	= False
If IsNull(ls_flag) Then
	Insert into MSTFLAG (ActionName, Flag, Note, LastEmp, LastDate)
	Values(:rs_action_name, 'Y', :ls_note, 'INTERFACE', GetDate());
	
	If SQLCA.SQLCODE = 0 Then
		SQLCA.AutoCommit	= True
		Return True
	Else
		SQLCA.AutoCommit	= True
		rs_fail_gubun = 'E'
		Return False
	End If
Else
	If ls_flag = 'Y' Then
		SQLCA.AutoCommit	= True
		rs_fail_gubun	= 'Y'
		Return False
	Else
		Update MSTFLAG
			Set Flag			= 'Y',
				 LastEmp		= 'INTERFACE',
				 LastDate	= GetDate()
		 Where ActionName = :rs_action_name;

		If SQLCA.SQLCODE = 0 Then
			SQLCA.AutoCommit	= True
			Return True
		Else
			SQLCA.AutoCommit	= True
			rs_fail_gubun = 'E'
			Return False
		End If
	End If
End If
end function

public subroutine wf_email_warning ();//***************************
//* 각공장별로 지정된 확정자에게 확정요청메일 발송.
//***************************
datastore lds_datastore, lds_getemail
long ll_row, ll_cnt, ll_logid, ll_shiporderqty, ll_emailcnt, ll_emailrowcnt
string ls_productgroup, ls_itemcode, ls_itemname, ls_applyfrom, ls_emailcontent, ls_email, ls_emailtitle
string ls_areacode, ls_divisioncode, ls_checkproduct, ls_checkarea, ls_checkdivision
string ls_itemclass, ls_itembuysource

lds_getemail = create datastore
lds_getemail.DataObject = 'd_email_empno'
lds_getemail.SetTransObject(SQLCA)

lds_datastore = create datastore
lds_datastore.DataObject	= 'd_email_tpartwarninghistory'
lds_datastore.SetTransObject(SQLCA)
ll_row	= lds_datastore.Retrieve()

if ll_row > 0 then
	ls_checkproduct = lds_datastore.GetItemString(1, 'productgroup')
	ls_checkarea = lds_datastore.GetItemString(1, 'areacode')
	ls_checkdivision = lds_datastore.GetItemString(1, 'divisioncode')
end if

ls_emailtitle = "&nbsp;&nbsp;<FONT size=4 face=굴림 color=#ff7635>시스템에서 단품Warning 정보를 알려드립니다.</font><br><br>"
ls_emailcontent = ""
For ll_cnt = 1 To ll_row
	ll_logid = lds_datastore.GetItemNumber(ll_cnt, 'logid') 
	ll_shiporderqty = lds_datastore.GetItemNumber(ll_cnt, 'shiporderqty')
	ls_productgroup = lds_datastore.GetItemString(ll_cnt, 'productgroup')
	ls_itemcode = lds_datastore.GetItemString(ll_cnt, 'itemcode')
	ls_itemname = lds_datastore.GetItemString(ll_cnt, 'itemname')
	ls_applyfrom = lds_datastore.GetItemString(ll_cnt, 'applyfrom')
	ls_areacode = lds_datastore.GetItemString(ll_cnt, 'areacode')
	ls_divisioncode = lds_datastore.GetItemString(ll_cnt, 'divisioncode')
	ls_itemclass = lds_datastore.GetItemString(ll_cnt, 'itemclass')
	ls_itembuysource = lds_datastore.GetItemString(ll_cnt, 'itembuysource')
	
	if ll_cnt = ll_row then
		// 마지막행 처리로직 시작
		if (ls_productgroup <> ls_checkproduct or ls_areacode <> ls_checkarea or &
				ls_divisioncode <> ls_checkdivision ) then
			//*************************
			//* 이전 지역,공장, 제품군에 해당하는 메일내용 먼저 발송
			if ll_cnt <> 1 then
				//이메일 발송로직
				lds_getemail.reset()
				ll_emailrowcnt = lds_getemail.retrieve(ls_checkarea, ls_checkdivision, ls_checkproduct) 
				for ll_emailcnt = 1 to ll_emailrowcnt
					ls_email = lds_getemail.getitemstring(ll_emailcnt,'empemail')
					if len(trim(ls_email)) > 10 then
						if f_SendMail( trim(ls_email), "(" + is_currentdate + ") 단품AS/KD Warning정보 제품군 : " + ls_checkproduct, ls_emailtitle + ls_emailcontent, "" ) = 1 then
							// pass
						end if
					end if
				next
				
				if ll_emailrowcnt > 0 then
					sqlca.autocommit = false
					
					Update	TPARTWARNINGHISTORY
					Set		SuccessFlag = 'Y'
					Where		AreaCode = :ls_checkarea AND DivisionCode = :ls_checkdivision AND
						ProductGroup = :ls_checkproduct AND SuccessFlag = 'N' using sqlca;
					
					if sqlca.sqlnrows > 0 then
						commit using sqlca;
					else
						rollback using sqlca;
					end if
					sqlca.autocommit = true
				end if
			end if
			//*************************
			ls_emailtitle = "&nbsp;&nbsp;<FONT size=4 face=굴림 color=#ff7635>시스템에서 단품Warning 정보를 알려드립니다.</font><br><br>"
			ls_emailcontent = ""
			ls_emailcontent = ls_emailcontent + "&nbsp;&nbsp;품번: <b>" + ls_itemcode +  "</b>,&nbsp;&nbsp;&nbsp;&nbsp;품명: <b>" + ls_itemname &
				+ "</b>,&nbsp;&nbsp;&nbsp;&nbsp;계정: <b>" + ls_itemclass &
				+ "</b>,&nbsp;&nbsp;&nbsp;&nbsp;구입선: <b>" + ls_itembuysource &
				+ "</b>,&nbsp;&nbsp;&nbsp;&nbsp;납품요구일: <b>" + ls_applyfrom &
				+ "</b>,&nbsp;&nbsp;&nbsp;&nbsp;수량: <b>" + string(ll_shiporderqty) + "</b><br>"
		else
			ls_emailcontent = ls_emailcontent + "&nbsp;&nbsp;품번: <b>" + ls_itemcode +  "</b>,&nbsp;&nbsp;&nbsp;&nbsp;품명: <b>" + ls_itemname &
				+ "</b>,&nbsp;&nbsp;&nbsp;&nbsp;계정: <b>" + ls_itemclass &
				+ "</b>,&nbsp;&nbsp;&nbsp;&nbsp;구입선: <b>" + ls_itembuysource &
				+ "</b>,&nbsp;&nbsp;&nbsp;&nbsp;납품요구일: <b>" + ls_applyfrom &
				+ "</b>,&nbsp;&nbsp;&nbsp;&nbsp;수량: <b>" + string(ll_shiporderqty) + "</b><br>"
		end if
		//이메일 발송로직
		lds_getemail.reset()
		ll_emailrowcnt = lds_getemail.retrieve(ls_areacode, ls_divisioncode, ls_productgroup) 
		for ll_emailcnt = 1 to ll_emailrowcnt
			ls_email = lds_getemail.getitemstring(ll_emailcnt,'empemail')
			if len(trim(ls_email)) > 10 then
				if f_SendMail( trim(ls_email), "(" + is_currentdate + ") 단품AS/KD Warning정보 제품군 : " + ls_productgroup, ls_emailtitle + ls_emailcontent, "" ) = 1 then
					// pass
				end if
			end if
		next
		
		if ll_emailrowcnt > 0 then
			sqlca.autocommit = false
			
			Update	TPARTWARNINGHISTORY
			Set		SuccessFlag = 'Y'
			Where		AreaCode = :ls_areacode AND DivisionCode = :ls_divisioncode AND
				ProductGroup = :ls_productgroup AND SuccessFlag = 'N' using sqlca;
			
			if sqlca.sqlnrows > 0 then
				commit using sqlca;
			else
				rollback using sqlca;
			end if
			sqlca.autocommit = true
		end if
		// 마지막행 처리로직 끝
	else
		// 일반적 처리로직 시작
		if (ls_productgroup <> ls_checkproduct or ls_areacode <> ls_checkarea or &
				ls_divisioncode <> ls_checkdivision ) then
			//이메일 발송로직
			lds_getemail.reset()
			ll_emailrowcnt = lds_getemail.retrieve(ls_checkarea, ls_checkdivision, ls_checkproduct) 
			for ll_emailcnt = 1 to ll_emailrowcnt
				ls_email = lds_getemail.getitemstring(ll_emailcnt,'empemail')
				if len(trim(ls_email)) > 10 then
					if f_SendMail( trim(ls_email), "(" + is_currentdate + ") 단품AS/KD Warning정보 제품군 : " + ls_checkproduct, ls_emailtitle + ls_emailcontent, "" ) = 1 then
						// pass
					end if
				end if
			next
			
			if ll_emailrowcnt > 0 then
				sqlca.autocommit = false
				
				Update	TPARTWARNINGHISTORY
				Set		SuccessFlag = 'Y'
				Where		AreaCode = :ls_checkarea AND DivisionCode = :ls_checkdivision AND
					ProductGroup = :ls_checkproduct AND SuccessFlag = 'N' using sqlca;
				
				if sqlca.sqlnrows > 0 then
					commit using sqlca;
				else
					rollback using sqlca;
				end if
				sqlca.autocommit = true
			end if
			
			ls_checkproduct = ls_productgroup
			ls_checkarea = ls_areacode
			ls_checkdivision = ls_divisioncode
			ls_emailtitle = "&nbsp;&nbsp;<FONT size=4 face=굴림 color=#ff7635>시스템에서 단품Warning 정보를 알려드립니다.</font><br><br>"
			ls_emailcontent = ""
		end if
		ls_emailcontent = ls_emailcontent + "&nbsp;&nbsp;품번: <b>" + ls_itemcode +  "</b>,&nbsp;&nbsp;&nbsp;&nbsp;품명: <b>" + ls_itemname &
			+ "</b>,&nbsp;&nbsp;&nbsp;&nbsp;계정: <b>" + ls_itemclass &
			+ "</b>,&nbsp;&nbsp;&nbsp;&nbsp;구입선: <b>" + ls_itembuysource &
			+ "</b>,&nbsp;&nbsp;&nbsp;&nbsp;납품요구일: <b>" + ls_applyfrom &
			+ "</b>,&nbsp;&nbsp;&nbsp;&nbsp;수량: <b>" + string(ll_shiporderqty) + "</b><br>"	
		// 일반적 처리로직 끝
	end if
Next

destroy lds_datastore
destroy lds_getemail
end subroutine

on w_interface_download.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.dw_interface=create dw_interface
this.st_horizontal=create st_horizontal
this.uo_option=create uo_option
this.uo_pipe=create uo_pipe
this.uo_button=create uo_button
this.st_vertical=create st_vertical
this.uo_parameter=create uo_parameter
this.st_date=create st_date
this.uo_date=create uo_date
this.ddlb_1=create ddlb_1
this.Control[]={this.dw_2,&
this.dw_1,&
this.dw_interface,&
this.st_horizontal,&
this.uo_option,&
this.uo_pipe,&
this.uo_button,&
this.st_vertical,&
this.uo_parameter,&
this.st_date,&
this.uo_date,&
this.ddlb_1}
end on

on w_interface_download.destroy
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.dw_interface)
destroy(this.st_horizontal)
destroy(this.uo_option)
destroy(this.uo_pipe)
destroy(this.uo_button)
destroy(this.st_vertical)
destroy(this.uo_parameter)
destroy(this.st_date)
destroy(this.uo_date)
destroy(this.ddlb_1)
end on

event closequery;UnsignedLong ul_handle

ul_handle = SQLCA.DBHandle()

If IsNull(ul_handle) Or ul_handle < 0 Then
	Connect Using SQLCA;
End If

Update MSTFLAG
	Set Flag = 'N'
 Where ActionName like 'DOWNLOAD%';

wf_disconnect()

end event

event open;il_hidden_color = BackColor
st_horizontal.BackColor	= il_hidden_color
st_vertical.BackColor	= il_hidden_color

wf_dw_init(3)

Update MSTFLAG
	Set Flag = 'N'
 Where ActionName like 'DOWNLOAD%';

ddlb_1.text = 'Second'
is_cycle = 'SS'

dw_interface.SetTransObject(SQLCA)
dw_interface.Retrieve()

PostEvent('ue_postopen')

end event

event resize;Int li_dw_w, li_dw_h, li_uo_x, li_uo_w
Int li_button_h, li_option_h, li_parameter_h, li_pipe_h

SetRedraw(False)

li_dw_w	= dw_interface.Width
li_dw_h	= NewHeight - (2 * ii_window_border)

dw_interface.Resize(li_dw_w, li_dw_h)
dw_interface.Move(ii_window_border, ii_window_border)

st_vertical.Resize(ii_window_border, li_dw_h)
st_vertical.Move(ii_window_border + li_dw_w, ii_window_border)

li_uo_x	= li_dw_w + (2 * ii_window_border)
li_uo_w	= NewWidth - li_dw_w - (3 * ii_window_border)

li_button_h	= uo_button.Height
uo_button.Resize(li_uo_w, li_button_h)
uo_button.Move(li_uo_x, ii_window_border)

ddlb_1.Move(dw_interface.x + dw_interface.width + 1700, ddlb_1.y)

li_option_h	= uo_option.Height
uo_option.Resize(li_uo_w, li_option_h)
uo_option.Move(li_uo_x, li_button_h + (2 * ii_window_border))
uo_option.Post Event Resize(sizetype, li_uo_w, li_option_h)

li_parameter_h = uo_parameter.Height
uo_parameter.Resize(li_uo_w, li_parameter_h)
uo_parameter.Move(li_uo_x, li_button_h + li_option_h + (3 * ii_window_border))
uo_parameter.Post Event Resize(sizetype, li_uo_w, li_parameter_h)

st_horizontal.Resize(li_uo_w, ii_window_border)
st_horizontal.Move(li_uo_x, li_button_h + li_option_h + li_parameter_h + (3 * ii_window_border))

li_pipe_h	= NewHeight - (li_button_h + li_option_h + li_parameter_h) - (5 * ii_window_border)

uo_pipe.Resize(li_uo_w, uo_pipe.Height)
uo_pipe.Move(li_uo_x, li_button_h + li_option_h + li_parameter_h + (4 * ii_window_border))

dw_1.Resize(li_uo_w, li_pipe_h - uo_pipe.Height - (2 * ii_window_border))
dw_1.Move(li_uo_x, uo_pipe.Y + uo_pipe.Height)

dw_2.Resize(li_uo_w, li_pipe_h - uo_pipe.Height - (2 * ii_window_border))
dw_2.Move(li_uo_x, uo_pipe.Y + uo_pipe.Height)

uo_date.Move(dw_2.X + dw_2.Width - uo_date.Width - 200 - ii_window_border, dw_2.Y - uo_date.Height - 24)
st_date.Move(dw_2.X + dw_2.Width - uo_date.Width - st_date.Width - 200 - (2 * ii_window_border), uo_date.Y + 16)

st_vertical.SetPosition(ToTop!)
st_horizontal.SetPosition(ToTop!)

SetRedraw(True)
end event

event timer;If ib_interface = False Then
	wf_auto_download()
End If	

end event

type dw_2 from datawindow within w_interface_download
integer x = 1979
integer y = 1076
integer width = 1097
integer height = 372
integer taborder = 60
string dataobject = "d_description"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0,  = 1 Then
	is_cycle = 'SS'
ElseIf index = 2 Then
	is_cycle	= 'MI'
ElseIf index = 3 Then
	is_cycle = 'HH'
ElseIf index = 4 Then
	is_cycle = 'DD'
ElseIf index = 5 Then
	is_cycle = 'MM'
End If	

end event

tring dataobject = "d_description"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(currentrow, True)
End If
end event

type dw_interface from datawindow within w_interface_download
integer y = 4
integer width = 1225
integer height = 1284
integer taborder = 10
string dataobject = "d_interface_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(currentrow, True)

	uo_pipe.st_read.Text		= ''
	uo_pipe.st_written.Text	= ''
	uo_pipe.st_error.Text	= ''
	uo_pipe.st_time.Text		= ''

	is_interface_gubun = GetItemString(currentrow, 'InterfaceGubun')
	is_sp_name = GetItemString(currentrow, 'ProcedureName')

	If is_interface_gubun = 'D' Then
		st_date.Visible	= False
		uo_date.Visible	= False
		uo_pipe.st_title.Text	= 'Interface Errors :'
		wf_dw_init(1)
		dw_1.SetPosition(ToTop!)
	Else
		st_date.Visible	= True
		uo_date.Visible	= True
		uo_pipe.st_title.Text	= 'Interface Datas :'
		wf_dw_init(2)
		dw_2.SetPosition(ToTop!)
	End If
	
	st_vertical.SetPosition(ToTop!)
	st_horizontal.SetPosition(ToTop!)	
End If
end event

event rowfocuschanging;Int		rowcount

ii_interface_id = GetItemNumber(newrow, 'InterfaceID')

CHOOSE CASE uo_parameter.Event Trigger ue_retrieve(ii_interface_id, rowcount)
	CASE 'Y', 'N'
		Return 0
	CASE 'C', 'F'
		Return 1
END CHOOSE
	
	
end event

type st_horizontal from u_st_horizontal within w_interface_download
integer x = 2921
integer y = 84
integer width = 105
integer height = 92
end type

event ue_mousemove;call super::ue_mousemove;If KeyDown(keyLeftButton!) Then
	This.Y = Parent.PointerY()
End If
end event

event ue_mouseup;call super::ue_mouseup;BackColor = il_hidden_color
wf_resize_horizontal()
end event

event ue_mousedown;call super::ue_mousedown;ii_first_y = Y
end event

type uo_option from u_interface_option within w_interface_download
integer x = 1243
integer y = 120
integer taborder = 40
boolean border = false
long backcolor = 79741120
end type

on uo_option.destroy
call u_interface_option::destroy
end on

event ue_button_click;ib_auto	= ab_auto

If ib_auto Then
	wf_auto_download()
	
	If is_cycle = 'SS' Then	
		Timer(30)
	ElseIf is_cycle = 'MI' Then
		Timer(600)						// 30 마다 이지만 10분마다 확인
	ElseIf is_cycle = 'HH' Then	// 1시간 간격이지만 30마다 수행한다...
		Timer(600)
	ElseIf is_cycle = 'DD' or is_cycle = 'MM' Then	// 매 10분마다 확인하고 19시에 수행
		Timer(600)
	End If	
Else
	Timer(0)
End If	

end event

type uo_pipe from u_interface_error within w_interface_download
integer x = 1253
integer y = 832
integer taborder = 80
boolean border = false
end type

on uo_pipe.destroy
call u_interface_error::destroy
end on

event ue_cancel;call super::ue_cancel;ib_upload_stop = True
end event

type uo_button from u_interface_button within w_interface_download
integer x = 1243
integer y = 4
integer taborder = 30
boolean border = false
long backcolor = 79741120
end type

on uo_button.destroy
call u_interface_button::destroy
end on

event ue_click_start;If ib_auto Then		// 전체 Interface 항목에 대해서 Interface 수행
	Timer(120)
Else
	// 선택된 Interface 항목에 대해서 Interface 수행
	If ii_interface_id > 0 Then

		uo_pipe.cb_repair.Enabled	= False
		uo_pipe.cb_cancel.Enabled	= True
		uf_button_enable(False, False, False)
		uo_parameter.Enabled	= False
		dw_interface.Enabled	= False
		uo_option.Enabled		= False
		uo_date.Enabled		= False

		If is_interface_gubun = 'D' Then			// DownLoad
			If	wf_download()	Then
				If wf_HistoryMove(is_sp_name) Then
						If wf_exec_sp(is_sp_name) Then
//							If wf_mis_flag_change(is_sp_name) Then
								wf_dw_init(1)
//							End If
						End If
					End If	
				End If

		Else												// Upload
			If wf_upload() Then
				wf_dw_init(2)
			End If
		End If
		uo_button.uf_button_enable(True, False, True)
		uo_parameter.Enabled	= True
		dw_interface.Enabled	= True
		uo_option.Enabled		= True
		uo_date.Enabled		= True
	End If
End If

end event

event ue_click_stop;call super::ue_click_stop;If is_interface_gubun = 'D' Then
	wf_download_stop()
	If Integer(uo_pipe.st_error.Text) > 0 Then
		uo_pipe.cb_cancel.Enabled	= True
	Else
		uo_pipe.cb_cancel.Enabled	= False
	End If
	uo_pipe.cb_cancel.Enabled	= False
	uf_button_enable(True, False, True)
End If
end event

event ue_exit;call super::ue_exit;Close(Parent)

end event

type st_vertical from u_st_vertical within w_interface_download
integer x = 1243
integer y = 564
integer width = 105
integer height = 92
boolean bringtotop = true
end type

event ue_mousemove;call super::ue_mousemove;If KeyDown(keyLeftButton!) Then
	This.X = Parent.PointerX()
End If
end event

event ue_mouseup;call super::ue_mouseup;BackColor = il_hidden_color
wf_resize_bar()
end event

type uo_parameter from u_parameter_set within w_interface_download
integer x = 1253
integer y = 256
integer taborder = 20
boolean border = false
long backcolor = 79741120
end type

on uo_parameter.destroy
call u_parameter_set::destroy
end on

type st_date from statictext within w_interface_download
integer x = 2158
integer y = 1004
integer width = 466
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "DownLoad Date :"
boolean focusrectangle = false
end type

type uo_date from u_today within w_interface_download
integer x = 2633
integer y = 988
integer taborder = 70
boolean bringtotop = true
long backcolor = 79741120
end type

on uo_date.destroy
call u_today::destroy
end on

event ue_variable_set;call super::ue_variable_set;// SFC Retrive Argument
is_applydate	= String(Date(sle_date.Text), 'YYYY.MM.DD')	

// MIS Delete Where, MIS에 날자가 숫자 Type이 있을수 있다.
is_yyyymmdd		= String(Date(sle_date.Text), 'YYYYMMDD')
ii_yyyymmdd		= Long(is_yyyymmdd)


end event

type ddlb_1 from dropdownlistbox within w_interface_download
integer x = 2939
integer y = 20
integer width = 480
integer height = 356
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
string text = "none"
boolean sorted = false
string item[] = {"Second","Minute","Hour","Day","Month"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
If index = 1 Then
	is_cycle = 'SS'
ElseIf index = 2 Then
	is_cycle	= 'MI'
ElseIf index = 3 Then
	is_cycle = 'HH'
ElseIf index = 4 Then
	is_cycle = 'DD'
ElseIf index = 5 Then
	is_cycle = 'MM'
End If	

end event

