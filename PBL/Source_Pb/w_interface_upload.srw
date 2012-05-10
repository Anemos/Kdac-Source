$PBExportHeader$w_interface_upload.srw
$PBExportComments$Interface main
forward
global type w_interface_upload from window
end type
type ddlb_1 from dropdownlistbox within w_interface_upload
end type
type dw_2 from datawindow within w_interface_upload
end type
type dw_1 from datawindow within w_interface_upload
end type
type dw_interface from datawindow within w_interface_upload
end type
type st_horizontal from u_st_horizontal within w_interface_upload
end type
type uo_option from u_interface_option within w_interface_upload
end type
type uo_pipe from u_interface_error within w_interface_upload
end type
type uo_button from u_interface_button within w_interface_upload
end type
type st_vertical from u_st_vertical within w_interface_upload
end type
type uo_parameter from u_parameter_set within w_interface_upload
end type
type st_date from statictext within w_interface_upload
end type
type uo_date from u_today within w_interface_upload
end type
end forward

global type w_interface_upload from window
integer width = 3909
integer height = 1612
boolean titlebar = true
string title = "Interface - Upload"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event ue_postopen pbm_custom01
ddlb_1 ddlb_1
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
end type
global w_interface_upload w_interface_upload

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
datetime idt_currdatetime
long ii_yyyymmdd

boolean ib_upload_stop = False

string	is_sp_name
uo_transaction		mis_sp
boolean	ib_cancel, ib_interface = False, ib_dayrun = False

String	is_cycle
end variables

forward prototypes
public subroutine wf_resize_panel (integer fi_win_w, integer fi_win_h, integer fi_vertical_x)
public subroutine wf_resize_horizontal ()
public subroutine wf_disconnect ()
public subroutine wf_download_stop ()
public function boolean wf_raiserror (string fs_pipeline_name)
public subroutine wf_flag_update (string fs_action_name)
public subroutine wf_upload_stop ()
public subroutine wf_dw_init (integer fs_option)
public function datetime wf_get_date_nowtime ()
public function string wf_get_date_lastday_of_month (integer fi_month, integer fi_year)
public function boolean wf_check_server_date (string fs_date)
public subroutine wf_resize_bar ()
public function string wf_get_host_datetime ()
public subroutine wf_mis_flag_change (string fs_sp_name)
public function boolean wf_connect_check (ref transaction rt_source, ref transaction rt_destination)
public function boolean wf_upload_tmstpartkb (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tpartkbdayorder (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tplanday (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tqqcitem_temp (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tsrcancel_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tsrconfirm01_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tsrconfirm02_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tmcmaster (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tmstpartkb_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_flag_check (string fs_pipeline_name, ref string rs_action_name, ref string rs_fail_gubun)
public function boolean wf_last_execute_update ()
public function boolean wf_upload ()
public function boolean wf_auto_upload ()
public subroutine wf_upload_sp (string fs_sp)
public function boolean wf_upload_ybomtemp (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tqbusinesstemp (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tstockcancel_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tshipsheet_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tshipback_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tshipetc_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tshipinv_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tmcpartrelease (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tpartreturn_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tpartin_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tpartcancel_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_yinv002temp (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_yinv101temp (string fs_dataobject, ref string rs_return_option)
public function boolean wf_connect (string fs_ini_file, string fs_source, string fs_destination, ref transaction rt_source, ref transaction rt_destination)
public function boolean wf_upload_tpartkborder_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tpartrelease_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tstock_interface (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tmcpartreturn (string fs_dataobject, ref string rs_return_option)
public function boolean wf_upload_tpartkbincome_interface (string fs_dataobject, ref string rs_return_option)
end prototypes

event ue_postopen;ib_open = True

If IsValid(w_select_inifile) Then
	Close(w_select_inifile)
End If

Update MSTFLAG
	Set Flag = 'N'
 Where ActionName like 'UPLOAD%'
 Using it_source;
 
 Commit Using it_source ;

// Horizontal Resize의 한계값을 설정한다.
// st_vertical의 Y 값이 아래 두값의 사이값일 경우에만 Resize  수행
ii_first_parameter_y = uo_parameter.Y + (uo_parameter.Height / 2)
ii_first_pipe_y		= uo_pipe.Y + (uo_pipe.Height / 2)

wf_connect(gs_ini_file, 'IPIS', 'MIS', it_source, it_destination)

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

public subroutine wf_download_stop ();String ls_pipeline_name

If IsValid(ip_pipe) Then
	If ip_pipe.Cancel() = 1 Then
		Select PipeLineName
		  Into :ls_pipeline_name
		  From TINTERFACE
		 Where InterfaceID = :ii_interface_id ;

		If Integer(uo_pipe.st_read.Text) > 0 Then
			wf_raiserror(ls_pipeline_name)
		ELse
			wf_flag_update(is_action_name)
		End If
	End If
End If
end subroutine

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

public subroutine wf_flag_update (string fs_action_name);Update MSTFLAG
	Set Flag			= 'N',
		 LastEmp		= 'INTERFACE',
		 LastDate	= GetDate()
 Where ActionName = :fs_action_name
 using it_source;
end subroutine

public subroutine wf_upload_stop ();
end subroutine

public subroutine wf_dw_init (integer fs_option);If fs_option = 1 Then
	dw_1.DataObject	= 'd_description'
	dw_1.InsertRow(1)
	dw_1.SetItem(1,1, 'Download Error Area')
	Return
End If

If fs_option = 2 Then
	dw_2.DataObject	= 'd_description'
	dw_2.InsertRow(1)
	dw_2.SetItem(1,1, 'Upload Data')
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

public function datetime wf_get_date_nowtime ();
DateTime ldt_now

Select Top 1 GetDate() 
Into :ldt_now 
From sysusers
Using	it_source;

Return ldt_now
end function

public function string wf_get_date_lastday_of_month (integer fi_month, integer fi_year);
Int		li_lastday_of_month
String	ls_month, ls_lastday

ls_month = String(fi_year) + "." + Right('0' + String(fi_month), 2)

Select Top 1 Convert(Char(8), DateAdd(DD, -1, DateAdd(MM, 1, Convert(DateTime, :ls_month + '.01'))), 112)
  Into :ls_lastday
  From sysusers
Using it_source;

Return ls_lastday

end function

public function boolean wf_check_server_date (string fs_date);// 매월말일일때 IPIS Server 시간을 체크해서 데이타 일자와 같을 경우에만 upload 한다.
// 그러나, 월초(1일)일때는 08:00 이전까지는 서버 시간과 데이타 같더라도 upload 몬한다.

Datetime		ldt_serverdate
String		ls_serverdate, ls_checkdate, ls_lastdate, ls_servertime
Int			li_lastdate, li_month, li_year

ldt_serverdate	= wf_get_date_nowtime()
ls_serverdate	= String(ldt_serverdate, 'yyyymmdd')
ls_servertime	= String(ldt_serverdate, 'hh')
li_month			= Integer(Left(ls_serverdate, 4))
li_year			= Integer(Mid(ls_serverdate, 6, 2))
ls_lastdate		= wf_get_date_lastday_of_month(li_month, li_year)

///messagebox('', ls_serverdate+'/'+ls_servertime)

If ls_serverdate = ls_lastdate Then		// 말일일때
	If Left(ls_serverdate, 6) = Left(fs_date, 6) Then
		Return True
	Else
		Return False
	End If
ElseIf Right(ls_serverdate, 2) = '01' Then	// 월초일때
	If ls_servertime < '08' Then
		Return False
	Else
		Return True
	End If	
Else
	Return True
End If	

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

public function string wf_get_host_datetime ();// host 일자 시간 가져오기

String		ls_datetime, ls_date, ls_time


select	current date , current time 
into		:ls_date, :ls_time 
from		pbcommon.comm000
using		it_source;

ls_datetime	= ls_date + ' ' + ls_time

Return ls_datetime
end function

public subroutine wf_mis_flag_change (string fs_sp_name);// Download후 MIS table 상태코드 update

String	ls_date, ls_error
Long		ll_error


ls_date = String(Today(), 'yyyy.mm.dd hh:mm:ss')

Choose case Upper(fs_sp_name)
	Case 'SP_PISI_D_TMSTMODEL'
		Update	PBIPIS.PDINV101
		Set		stscd = 'Y',
					downdate = :ls_date
		Where		stscd = 'N'
		and		chgdate >= '2002-11-27'
		Using		it_source;
		
		ll_error	= it_source.SQLCODE
		ls_error	= it_source.SQLErrText
		
		If ll_error = 0 Then
			Commit Using it_source ;
		Else
			RollBack Using it_source ;
			if ll_error < 0 then
				f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_mis_flag_change : ' + ls_error,it_source)
			end if
//			MessageBox(string(it_source.sqldbcode),ls_error, StopSign!)
//			rs_return_option = 'E'
//			Return False
		End If
		
End Choose

end subroutine

public function boolean wf_connect_check (ref transaction rt_source, ref transaction rt_destination);// Host와 IPIS server connection check & 실행가능시간 check

UnsignedLong ul_handle1, ul_handle2
Boolean			lb_connect

ul_handle1 = rt_source.DBHandle()
ul_handle2 = rt_destination.DBHandle()

If ul_handle1 > 0 and ul_handle2 > 0 Then
//	If String(Today(), 'hhmmss') >= '080000' and String(Today(), 'hhmmss') <= '200000' Then
//		Return True
//	Else
//		Return False
//	End If
	Return true
Else
	lb_connect = wf_connect(gs_ini_file, 'IPIS', 'MIS', it_source, it_destination)
	Return lb_connect
End If
end function

public function boolean wf_upload_tmstpartkb (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_misflag, ls_area, ls_division, ls_item, ls_slno, ls_flag
String	ls_supplier, ls_loc, ls_box
String	ls_stockdate, ls_seqno, ls_rc
Long		ll_logid, ll_goodqty, ll_badqty
String	ls_lib, ls_pgm, ls_parm
String	ls_usecenter, ls_costgubun

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tmstpartkb')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
	Delete	
	From		PBIPIS.JIT001;	
	
	Update	PBPUR.PUR102
	Set		KBCD = ''
	Where		KBCD <> '';
	
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
		
		ls_area				= dw_2.GetItemString(i, 'AreaCode')
		ls_division			= dw_2.GetItemString(i, 'DivisionCode')
		ls_supplier			= dw_2.GetItemString(i, 'SupplierCode')
		ls_item				= Left(dw_2.GetItemString(i, 'ItemCode') + Space(10), 12)
		ls_flag				= dw_2.GetItemString(i, 'UseFlag')
		If ls_flag = 'Y' Then
			ls_flag = 'C'
		Else
			ls_flag = ''
		End If
		ls_loc				= dw_2.GetItemString(i, 'ReceiptLocation')
		ls_box				= String(dw_2.GetItemNumber(i, 'MailBoxNo'))
		ls_costgubun		= Left(dw_2.GetItemString(i,	'CostGubun') + Space(2), 1)
		ls_usecenter		= Left(dw_2.GetItemString(i, 'UseCenter') + space(5), 5)
		If ls_costgubun = 'Y' or ls_costgubun = 'N' Then
		Else
			ls_costgubun = ''
		End If
		
		Insert	Into	PBIPIS.JIT001
				(COMLTD,	XPLANT,		DIV,				VSRNO,			ITNO,			ITOUT,	
				WLOC,		BOXCD,		GUBUN,			DEPT,				EXTD,			INPTID,
				INPTDT,	UPDTID,		UPDTDT,	IPADDR,		MACADDR)
		Values('01',	:ls_area,	:ls_division,	:ls_supplier,	:ls_item,	:ls_flag,
				:ls_loc,	:ls_box,		:ls_costgubun,	:ls_usecenter,	'',			'',
				'',			'',		'',		'',			'');
		
		Update	PBPUR.PUR102
		Set		KBCD = 'K'
		Where		VSRNO = :ls_supplier;	
		
		ll_error	= SQLCA.SQLCODE
		ls_error	= SQLCA.SQLErrText
		
		If ll_error = 0 Then
			Commit;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")

		Else
			RollBack;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tmstpartkb_interface : ' + ls_error,it_source)
			end if
		End If
		
	Next
	
	ll_end_time = Cpu ()
	uo_pipe.st_time.text = String((ll_end_time - ll_start_time)/1000,"#,##0") + " Secs"
	If ll_error_cnt > 1 Then
		rs_return_option = 'F'
	Else
		rs_return_option = 'S'
	End If
	
	Delete	
	From		tmstpartkb
	Using		it_source;
	
	ll_error	= it_source.SQLCODE
	ls_error	= it_source.SQLErrText
	
	If ll_error = 0 Then
		Commit Using it_source ;
	Else
		Rollback Using it_source ;
	End If	
	
	Return True
Else
	dw_2.SetRedraw(True)
	ll_end_time = Cpu ()
	uo_pipe.st_time.text = string((ll_end_time - ll_start_time)/1000,"##0.0") + " Secs"
	uo_pipe.st_written.Text = '0'
	uo_pipe.st_error.Text	= '0'
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tpartkbdayorder (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ls_changeqty
String	ls_error, ls_today
String	ls_supplier, ls_partkbno, ls_area, ls_division, ls_item, ls_orderseq, ls_rack
String	ls_term, ls_editno, ls_cycle, ls_usecenter, ls_orderdate, ls_date, ls_time, ls_receiptdate
Long		ll_logid, ll_goodqty, ll_badqty, ll_qty
String	ls_lib, ls_pgm, ls_parm

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tpartkbdayorder_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	Delete From	PBPUR.PVMT23V	;
	
//	commit;
	
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
/*		
	[SupplierCode]		[varchar] (5)		NOT NULL ,
	[PartKBNo]		[varchar] (11)		NOT NULL ,
	[OrderSeq]		[varchar] (10)		NOT NULL ,
	[AreaCode]		[char] (1)		NOT NULL ,
	[DivisionCode]		[char] (1)		NOT NULL ,
	[ItemCode]		[varchar] (12)		NOT NULL ,
	[RackCode]		[varchar] (5)		NOT NULL ,
	[SupplyTerm]		[Smallint]		NOT NULL ,
	[SupplyEditNo]		[Smallint]		NOT NULL ,
	[SupplyCycle]		[Smallint]		NOT NULL ,
	[UseCenter]		[varchar] (5)		NOT NULL ,
	[RackQty]		[int]			NOT NULL ,
	[PartOrderDate]		[char] (10)		NOT NULL ,
	[PartForecastDate]	[char] (10)		NOT NULL ,
	[PartForecastTime]	[datetime] 		NOT NULL ,
	[PartReceiptDate]    [char] (10)    NOT NULL
*/		
		ls_supplier			= dw_2.GetItemString(i, 'SupplierCode')
		ls_partkbno			= dw_2.GetItemString(i, 'PartKBNo')
		ls_orderseq			= dw_2.GetItemString(i, 'OrderSeq')
		ls_area				= dw_2.GetItemString(i, 'AreaCode')
		ls_division			= dw_2.GetItemString(i, 'DivisionCode')
		ls_item				= Left(dw_2.GetItemString(i, 'ItemCode') + Space(10), 12)
		ls_rack				= Left(dw_2.GetItemString(i, 'RackCode') + Space(10), 5)
		ls_term				= Left(String(dw_2.GetItemNumber(i, 'SupplyTerm')) + Space(10), 2)
		ls_editno			= Left(String(dw_2.GetItemNumber(i, 'SupplyEditNo')) + Space(10), 2)
		ls_cycle				= Left(String(dw_2.GetItemNumber(i, 'SupplyCycle')) + Space(10), 2)
		ls_usecenter		= Left(dw_2.GetItemString(i, 'UseCenter') + Space(10), 5)
		ll_qty				= dw_2.GetItemNumber(i, 'RackQty')
		ls_orderdate		= dw_2.GetItemString(i, 'PartOrderDate')
		ls_orderdate		= Left(ls_orderdate, 4) + Mid(ls_orderdate, 6, 2) + Right(ls_orderdate, 2)
		ls_date				= dw_2.GetItemString(i, 'PartForecastDate')
		ls_date				= Left(ls_date, 4) + Mid(ls_date, 6, 2) + Right(ls_date, 2)
		ls_time				= String(dw_2.GetItemDatetime(i, 'PartForecastTime'), 'hhss')
		ls_receiptdate		= dw_2.GetItemString(i, 'PartReceiptDate')
		if isnull(ls_receiptdate) then
			ls_receiptdate = ' '
		else
			ls_receiptdate = Left(ls_receiptdate, 4) + Mid(ls_receiptdate, 6, 2) + Right(ls_receiptdate, 2)
		end if
		
		Insert	Into	PBPUR.PVMT23V
				(VFVSRNO,		VFKBNO,			VFSRNO,			XPLANT,			VFDIV,
				VFITNO,			VFITNM,			VFSPEC,			VFUNT,			VFBOXCD,
				VFCYLE1,			VFCYLE2,			VFCYLE3,		VFWRKCD,			VFQTY,
				VFCOST,			VFAMT,			VFORDT,			VFDFDT,			VFDTTM,	VFRDT)
		Values(:ls_supplier,	:ls_partkbno,	:ls_orderseq,	:ls_area,		:ls_division,
				:ls_item,		' ',				' ',				' ',				:ls_rack,
				:ls_term,		:ls_editno,		:ls_cycle,		:ls_usecenter,	:ll_qty,
				0,					0,					:ls_orderdate,	:ls_date,		:ls_time,	:ls_receiptdate);

//		Insert	Into	PBPUR.PVMT23V
//				(VFVSRNO,		VFKBNO,			VFSRNO,			XPLANT,			VFDIV,
//				VFITNO,			VFITNM,			VFSPEC,			VFUNT,			VFBOXCD,
//				VFCYLE1,			VFCYLE2,			VFCYLE3,		VFWRKCD,			VFQTY,
//				VFCOST,			VFAMT,			VFORDT,			VFDFDT,			VFDTTM,	VFRDT)
//		Values('D0383',	'DA038301002',	'3070033ZDA',	'D',		'A',
//				'10490833W',		' ',				' ',				' ',				'P422A',
//				'1',		'2',		'2',		'421E',	800,
//				0,					0,					'20030708',	'20030709',		'1000',	'20030710');
            
		
		ll_error	= SQLCA.SQLCODE
		ls_error	= SQLCA.SQLErrText
		If ll_error = 0 Then
			//Commit;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
		Else
			//RollBack;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tpartkbdayorder : ' + ls_error,it_source)
				exit
			end if
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tplanday (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ls_changeqty
String	ls_error, ls_today
String	ls_misflag, ls_area, ls_division, ls_item, ls_slno, ls_flag
String	ls_planday
Long		ll_logid, ll_goodqty, ll_badqty
String	ls_lib, ls_pgm, ls_parm

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tplanday_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
	Delete From	PBIPIS.JIT002
	Where		edate > :ls_today;
	
	commit;
	
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
		
		ls_planday			= dw_2.GetItemString(i, 'PlanDay')
		ls_area				= dw_2.GetItemString(i, 'AreaCode')
		ls_division			= dw_2.GetItemString(i, 'DivisionCode')
		ls_item				= Left(dw_2.GetItemString(i, 'ItemCode') + Space(10), 12)
		ls_changeqty		= dw_2.GetItemNumber(i, 'ChangeQty')
		
		Insert	Into	PBIPIS.JIT002
				(COMLTD,		XPLANT,			DIV,				ITNO,			EDATE,		
				PQTY,			RQTY)
		Values('01',		:ls_area,		:ls_division,	:ls_item,	:ls_planday,
				:ls_changeqty, 0);
		
		ll_error	= SQLCA.SQLCODE
		ls_error	= SQLCA.SQLErrText
		
		If ll_error = 0 Then
//			Commit;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")

		Else
//			RollBack;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tplanday : ' + ls_error,it_source)
			end if
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tqqcitem_temp (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_recstatus, ls_itemcode, ls_supplier, ls_applyfrom, ls_applyto, ls_qcgubun

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tqqcitem_temp')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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

		ls_recstatus	= dw_2.GetItemString(i, 'RecStatus')
		ls_itemcode		= dw_2.GetItemString(i, 'ItemCode')
		ls_supplier		= dw_2.GetItemString(i, 'SupplierCode')
		ls_applyfrom	= dw_2.GetItemString(i, 'ApplyDateFrom')
		ls_applyfrom	= Left(ls_applyfrom, 4) + Mid(ls_applyfrom, 6, 2) + Right(ls_applyfrom, 2)
		ls_applyto		= dw_2.GetItemString(i, 'ApplyDateTo')
		ls_applyto		= Left(ls_applyto, 4) + Mid(ls_applyto, 6, 2) + Right(ls_applyto, 2)
		ls_qcgubun		= dw_2.GetItemString(i, 'QCGubun')

//		If ls_recstatus = 'I' or ls_recstatus = 'A' Then		// insert - 아니란다.
//			Insert Into PBPUR.PUR103
//				(COMLTD, VSRC, DEPT, VSRNO, ITNO, ITNO1, ITNM1, SPEC1, UNIT1, 
//				WSRC, CONVQTY1, DADJDT, DCURR, DCOST, DSHEET, EADJDT, ECURR,
//				ECOST, ESHEET, ARR, XPAY, VZERO, QCCD, ADJDT, FRPDT,
//				PQTY, XRATE, SHRT, XPLAN, STRT, CHCS, FPURNO, FPINDT,
//				FCOST, PURNO, PINDT, RQNO, SRNO, SRNO1, DKDT, LCOST,
//				XSTOP, EXTD, INPTID, INPTDT, UPDTID, UPDTDT, IPADDR, MACADDR)		
//			Values('01', 'D', 'D', :ls_supplier, :ls_itemcode, '', '', '' , '',
//					'', 0, '', '', 0, '', '', '',
//					0, '', '', '', '', :ls_qcgubun, :ls_applyfrom, :ls_applyto,
//					0, 0, 0, '', '', 0, '', '',
//					0, '', '', '', '', '', '', 0,
//					'', '', 'IPIS', :ls_today, 'IPIS', :ls_today, '', '')
//			Using it_destination;
//
//		Else
		
		if ls_today < ls_applyfrom then
			continue
		end if
		
		If ls_recstatus = 'I' or ls_recstatus = 'A' or ls_recstatus = 'R' Then		// replace or insert
			Update	PBPUR.PUR103
			Set		QCCD = :ls_qcgubun,
						ADJDT = :ls_applyfrom,
						UPDTID = 'IPIS',
						UPDTDT = :ls_today
			Where		VSRNO = :ls_supplier
			And		ITNO = :ls_itemcode
			Using SQLCA;
			
		ElseIf ls_recstatus = 'D' Then		// delete	
			If ls_qcgubun = 'A' Then			// 양산초도품 - 최초입고일 clear
				Update	PBPUR.PUR103
				Set		QCCD = '',
							ADJDT = '',
							FRPDT = '',
							UPDTID = 'IPIS',
							UPDTDT = :ls_today
				Where		VSRNO = :ls_supplier
				And		ITNO = :ls_itemcode
				Using SQLCA;
			Else
				Update	PBPUR.PUR103
				Set		QCCD = '',
							ADJDT = '',
							UPDTID = 'IPIS',
							UPDTDT = :ls_today
				Where		VSRNO = :ls_supplier
				And		ITNO = :ls_itemcode
				Using SQLCA;
			End If	
		End If
		
		ll_error	= SQLCA.SQLCODE
		ls_error	= SQLCA.SQLErrText
		
		If ll_error = 0 Then
			Commit Using SQLCA ;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
			
			Update	tqqcitem_temp
			Set		uploadflag = 'Y'
			Where		itemcode = :ls_itemcode
			And		suppliercode = :ls_supplier
			Using		it_source;
			
			ll_error	= it_source.SQLCODE
			ls_error	= it_source.SQLErrText
			
			If ll_error = 0 Then
				Commit Using it_source ;
			Else
				Rollback Using it_source ;
			End If	

		Else
			RollBack Using SQLCA ;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tqqcitem_temp : ' + ls_error,it_source)
			end if
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tsrcancel_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_flag, ls_srno, ls_checksrno, ls_canceldate
String	ls_supplier, ls_goodqty, ls_badqty, ls_userid, ls_inputdate, ls_qty
String	ls_stockdate, ls_seqno, ls_rc
Long		ll_logid, ll_goodqty, ll_badqty
String	ls_lib, ls_pgm, ls_parm

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tsrcancel_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_flag				= dw_2.GetItemString(i, 'ConfirmFlag')
		If ls_flag = 'Y' Then
			ls_flag = 'V'
		End If
		
		// 확인필요 SR, SR전산번호
		ls_srno				= Left(dw_2.GetItemString(i, 'SRNo') + Space(10), 8)			
		ls_checksrno		= Left(dw_2.GetItemString(i, 'CheckSRNo') + Space(10), 11)
		ls_canceldate		= dw_2.GetItemString(i, 'CancelDate')		// 취소일
		ls_canceldate		= Left(ls_canceldate, 4) + Mid(ls_canceldate, 6, 2) + Right(ls_canceldate, 2)
		ls_userid			= Left(dw_2.GetItemString(i, 'LastEmp') + Space(10), 6)
		ls_inputdate		= String(dw_2.GetItemDatetime(i, 'LastDate'), 'yyyymmdd')

		// 취소SR확정 parmameter 
		// 구분(1)/SR번호(11)/SR전산번호(8)/확정일(8)/확정자(6)/수정일(8)/Flag(Y,N)
//		ls_rc = String(' ', '@')
//		SQLCA.P_CNSR_CON(ls_flag, ls_checksrno, ls_srno, ls_canceldate, ls_userid, ls_inputdate, ls_rc)

		// DB/2 procedure 호출에서 직접 update로 변경		
		If ls_flag = 'V' Then
			UPDATE	pbsle.sle303
			SET		prtcd = '4'
			WHERE		comltd = '01'
			and		srno = :ls_checksrno;
			
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText

			UPDATE	pbsle.sle304
			SET		stcd = 'C',
						srdt = :ls_canceldate
			WHERE		comltd = '01'
			and		csrno = :ls_srno;
			
			ll_error	= ll_error + SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText

			UPDATE	pbsle.sle301
			SET		prtcd= '4'                                  
			WHERE		comltd = '01'
			and		srno = :ls_checksrno ;
			
			ll_error	= ll_error + SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText

			UPDATE	pbsle.sle302
			SET		stcd = 'C'                                  
			WHERE		comltd = '01'
			and		csrno = :ls_srno ;
			
			ll_error	= ll_error + SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText			
		Else                                                                   
			UPDATE	pbsle.sle303
			SET 		prtcd = '2'                                 
			WHERE		comltd = '01'
			and		srno = :ls_checksrno ;
			
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText

			UPDATE	pbsle.sle304
			SET		stcd = ' ', 
						srdt = ' '                      
			WHERE		comltd = '01'
			and		csrno = :ls_srno ;
			
			ll_error	= ll_error + SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText

			UPDATE	pbsle.sle301
			SET		prtcd= '4'                                  
			WHERE		comltd = '01'
			and		srno = :ls_checksrno ;
			
			ll_error	= ll_error + SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText

			UPDATE	pbsle.sle302
			SET		stcd = ' '                                  
			WHERE		comltd = '01'
			and		csrno = :ls_srno ;
			
			ll_error	= ll_error + SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
		End If
		
		ll_error	= SQLCA.SQLCODE
		ls_error	= SQLCA.SQLErrText
		
		If ll_error = 0 Then
			Commit;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
			
			Update	tsrcancel_interface
			Set		interfaceflag = 'N',
						lastdate	= getdate()
			Where		logid = :ll_logid
			Using		it_source;
			
			ll_error	= it_source.SQLCODE
			ls_error	= it_source.SQLErrText
			
			If ll_error = 0 Then
				Commit Using it_source ;
			Else
				Rollback Using it_source ;
			End If	

		Else
			RollBack;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tsrcancel_interface : ' + ls_error,it_source)
			end if
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tsrconfirm01_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_flag, ls_srno, ls_checksrno, ls_canceldate
String	ls_supplier, ls_goodqty, ls_badqty, ls_userid, ls_inputdate, ls_qty
String	ls_stockdate, ls_seqno, ls_rc
Long		ll_logid, ll_goodqty, ll_badqty, ll_count
String	ls_lib, ls_pgm, ls_parm, ls_chkstcd

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tsrconfirm01_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_srno				= Left(dw_2.GetItemString(i, 'SRNo') + Space(10), 11)			
//		if left(ls_srno, 2) = 'EX' then
//			ls_srno = left(ls_srno,10)
//		end if	
		ls_userid			= Left(dw_2.GetItemString(i, 'LastEmp') + Space(10), 6)
		ls_inputdate		= String(dw_2.GetItemDatetime(i, 'LastDate'), 'yyyymmdd')
		
//		messagebox(ls_srno, len(ls_srno))
//		messagebox(ls_userid, len(ls_userid))
//		messagebox(ls_inputdate, len(ls_inputdate))
		
		// SR 확정 parmameter 
		// SR번호(11)/입력자(6)/입력일(8)/Flag(Y,N)
//		ls_rc = String(' ', '@')		
//		SQLCA.P_SR_CON(ls_srno, ls_userid, ls_inputdate, ls_rc)

		// 현재 데이타가 불안정한 관계로, 임시로 prtcd가 '2'인 경우에만 적용. 
		// 향후에는 prtcd = '2' 조건 삭제한다!!!
		// data가 없어도 update는 sqlcode = 0이다. 먼저 select 해서 있는지 확인한다 !!!
		
		If Left(ls_srno, 2) = 'EX' Then	// 이놈은 이체다...
			select distinct slno 
			  into :ls_checksrno
			from pbinv.inv601
			where slno = :ls_srno
			and stcd = '3';
//			select	distinct slno 
//			into		:ls_checksrno
//			from		pbinv.inv601
//			where		slno	= :ls_srno
//			and		stcd	= '3';
//
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
	     
			If ll_error = 0 Then			
				update	pbinv.inv601
				set		stcd	= '4'
				where		slno	= :ls_srno
				and		stcd	= '3';
				
				ll_error	= SQLCA.SQLCODE
				ls_error	= SQLCA.SQLErrText
				if ll_error = 0 Then
					Commit;
					dw_2.DeleteRow(i)
					uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
					
//					Update	tsrconfirm01_interface
//					Set		interfaceflag = 'N',
//								lastdate	= getdate()
//					Where		logid = :ll_logid
//					Using		it_source;
					
					ll_error	= it_source.SQLCODE
					ls_error	= it_source.SQLErrText
					
					If ll_error = 0 Then
						Commit Using it_source ;
					Else
						Rollback Using it_source ;
					End If	
		
				Else
					RollBack;
					uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
					ll_error_cnt ++
					if ll_error < 0 then
						f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tsrconfirm01_interface : ' + ls_error,it_source)
					end if
				End If
			Else
				select stcd into :ls_chkstcd 
					from pbinv.inv601
					where slno = :ls_srno ;
				if ls_chkstcd > '3' then
					Update	tsrconfirm01_interface
					Set		interfaceflag = 'N',
								lastdate	= getdate()
					Where		logid = :ll_logid
					Using		it_source;
				else
					uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
					ll_error_cnt ++
					if ll_error < 0 then
						f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tsrconfirm01_interface : ' + ls_error,it_source)
					end if
				end if
			End If			
			
		Else		// 이체 아니놈
		
			select	srno
			into		:ls_checksrno
			from		pbsle.sle301
			where		srno	= :ls_srno
			and		prtcd	= '2';
	
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
	
			If ll_error = 0 Then			
				update	pbsle.sle301
				set		prtcd	= '3'
				where		srno	= :ls_srno
				and		prtcd	= '2';
				
				ll_error	= SQLCA.SQLCODE
				ls_error	= SQLCA.SQLErrText
				
				If ll_error = 0 Then
					Commit;
					dw_2.DeleteRow(i)
					uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
					
					Update	tsrconfirm01_interface
					Set		interfaceflag = 'N',
								lastdate	= getdate()
					Where		logid = :ll_logid
					Using		it_source;
					
					ll_error	= it_source.SQLCODE
					ls_error	= it_source.SQLErrText
					
					If ll_error = 0 Then
						Commit Using it_source ;
					Else
						Rollback Using it_source ;
					End If	
		
				Else
					RollBack;
					uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
					ll_error_cnt ++
					if ll_error < 0 then
						f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tsrconfirm01_interface : ' + ls_error,it_source)
					end if
				End If
			Else
				select prtcd into :ls_chkstcd
					from		pbsle.sle301
					where		srno	= :ls_srno ;
				if ls_chkstcd > '2' then
					Update	tsrconfirm01_interface
					Set		interfaceflag = 'N',
								lastdate	= getdate()
					Where		logid = :ll_logid
					Using		it_source;
				else
					uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
					ll_error_cnt ++
					if ll_error < 0 then
						f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tsrconfirm01_interface : ' + ls_error,it_source)
					end if
				end if
			End If			
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tsrconfirm02_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_flag, ls_srno, ls_checksrno, ls_canceldate
String	ls_supplier, ls_goodqty, ls_badqty, ls_userid, ls_inputdate, ls_qty
String	ls_stockdate, ls_seqno, ls_rc
Long		ll_logid, ll_goodqty, ll_badqty
String	ls_lib, ls_pgm, ls_parm

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tsrconfirm02_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_srno				= Left(dw_2.GetItemString(i, 'SRNo') + Space(10), 11)			
		ls_userid			= Left(dw_2.GetItemString(i, 'LastEmp') + Space(10), 6)
		ls_inputdate		= String(dw_2.GetItemDatetime(i, 'LastDate'), 'yyyymmdd')

		// SR 취소입력 parmameter 
		// SR번호(11)/입력자(6)/입력일(8)/Flag(Y,N)		
		ls_rc = String(' ', '@')
		SQLCA.P_SR_CAN(ls_srno, ls_userid, ls_inputdate, ls_rc)
		
		ll_error	= SQLCA.SQLCODE
		ls_error	= SQLCA.SQLErrText
		
		If ll_error = 0 and ls_rc = 'Y' Then
			Commit;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
			
			Update	tsrconfirm02_interface
			Set		interfaceflag = 'N',
						lastdate	= getdate()
			Where		logid = :ll_logid
			Using		it_source;
			
			ll_error	= it_source.SQLCODE
			ls_error	= it_source.SQLErrText
			
			If ll_error = 0 Then
				Commit Using it_source ;
			Else
				Rollback Using it_source ;
			End If	

		Else
			RollBack;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tsrconfirm02_interface : ' + ls_error,it_source)
			end if
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tmcmaster (string fs_dataobject, ref string rs_return_option);// 공무자재(설비) 장비 Master upload

Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today 
String	ls_misflag, ls_area, ls_division, ls_mccode, ls_mcname, ls_mcname1, ls_spec
String	ls_usage, ls_cccode, ls_status, ls_asset
String	ls_stockdate, ls_seqno, ls_rc
Long		ll_logid, ll_goodqty, ll_badqty
String	ls_lib, ls_pgm, ls_parm


ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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

		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_misflag			= Upper(dw_2.GetItemString(i, 'MISFlag'))
		ls_area				= Upper(dw_2.GetItemString(i, 'AreaCode'))
		ls_division			= Upper(dw_2.GetItemString(i, 'DivisionCode'))
		ls_mccode			= Upper( Trim(dw_2.GetItemString(i, 'MCCode')))
		ls_mcname			= Upper( Trim(dw_2.GetItemString(i, 'MCName')))
		ls_mcname1			= Upper( Trim(dw_2.GetItemString(i, 'MCShortName')))
		ls_spec				= Upper( Trim(dw_2.GetItemString(i, 'MCSpec')))
		ls_usage				= Upper( Trim(dw_2.GetItemString(i, 'MCUsage')))
		ls_cccode			= Upper( Trim(dw_2.GetItemString(i, 'CCCode')))
		
		if isnull( ls_mcname ) then ls_mcname = ''
		if len(ls_mcname) >= 30 then ls_mcname = mid(ls_mcname,1,20)
		if isnull( ls_mcname1 ) then ls_mcname1 = ''
		if isnull( ls_spec ) then ls_spec = ''
		if isnull( ls_usage ) then ls_usage = ''
		if isnull( ls_cccode ) then ls_cccode = ''
		
		If Left(ls_cccode, 1) = 'D' Then
			ls_cccode	= Right(ls_cccode, 4)
		End If	
		
		ls_status			= Upper( Trim(dw_2.GetItemString(i, 'Status')))
		ls_asset				= Upper( Trim(dw_2.GetItemString(i, 'AssetCode')))
		if isnull( ls_status ) then ls_status = ''
		if isnull( ls_asset ) then ls_asset = ''

		If ls_misflag = 'A' or ls_misflag = 'R' Then		// Add - Insert
		
			Delete From PBIPIS.TPM001
			Where COMLTD = '01' And XPLANT = :ls_area And
					DIV = :ls_division And MCHNO = :ls_mccode
			using sqlca;

			Insert	Into	PBIPIS.TPM001
					(COMLTD,		XPLANT,		DIV,				MCHNO,			MCHNM,			MCHNM1,
					SPEC,			XUSE,			WCCD,				XTYPE,			MGRDE,			MCODE,
					MSEQ,			EXTD,			INPTID,			INPTDT,			UPDTID,			UPDTDT,		
					IPADDR,		MACADDR)
			Values('01',		:ls_area,	:ls_division,	:ls_mccode,		:ls_mcname,		:ls_mcname1,
					:ls_spec,	:ls_usage,	:ls_cccode,		:ls_status,		'',				:ls_asset,
					'',			'',			'',				'',				'',				'',
					'',			'') using sqlca;
			
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
//		ElseIf ls_misflag = 'R' Then	// Replace - Update
//
//			Update	PBIPIS.TPM001
//			Set		MCHNM		= :ls_mcname,
//						MCHNM1	= :ls_mcname1,
//						SPEC		= :ls_spec,
//						XUSE		= :ls_usage,
//						WCCD		= :ls_cccode,
//						XTYPE		= :ls_status,
//						MCODE		= :ls_asset
//			Where		comltd	= '01'
//			and		xplant	= :ls_area
//			and		div		= :ls_division
//			and		mchno		= :ls_mccode using sqlca;
//
//			ll_error	= SQLCA.SQLCODE
//			ls_error	= SQLCA.SQLErrText

		ElseIf ls_misflag = 'D' Then	// Delete - Delete
			
			Delete	
			From		PBIPIS.TPM001
			Where		comltd	= '01'
			and		xplant	= :ls_area
			and		div		= :ls_division
			and		mchno		= :ls_mccode using sqlca;

			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
			
		End If	
	
		If ll_error = 0 Then
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
			
			Update	TMCMASTER
			Set		UploadFlag	= 'Y'
			Where		LogID	= :ll_logid
			Using		it_source;

			ll_error	= it_source.SQLCODE
			ls_error	= it_source.SQLErrText
			
//			If ll_error = 0 Then
//				Commit Using it_source ;
//			Else
//				Rollback Using it_source ;
//			End If	

		Else
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tmcmaster_interface : ' + ls_error,it_source)
			end if
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
	rs_return_option = 'S'
	Return True
End If

end function

public function boolean wf_upload_tmstpartkb_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_area, ls_division, ls_item, ls_kbcd
String	ls_supplier, ls_goodqty, ls_badqty, ls_userid, ls_inputdate, ls_qty
String	ls_stockdate, ls_seqno, ls_rc, ls_misflag, ls_applyfrom
Long		ll_logid, ll_goodqty, ll_badqty
String	ls_lib, ls_pgm, ls_parm

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tmstpartkb_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_misflag			= dw_2.GetItemString(i, 'MISFlag') 
		ls_area				= dw_2.GetItemString(i, 'AreaCode')
		ls_division			= dw_2.GetItemString(i, 'DivisionCode')
		ls_applyfrom		= dw_2.GetItemString(i, 'ApplyFrom')
		ls_applyfrom      = Mid(ls_applyfrom,1,4) + Mid(ls_applyfrom,6,2) + Mid(ls_applyfrom,9,2)
		ls_item				= left(dw_2.GetItemString(i, 'ItemCode') + Space(12), 12)
		ls_userid			= Left(dw_2.GetItemString(i, 'LastEmp') + Space(10), 6)
		ls_inputdate		= String(dw_2.GetItemDatetime(i, 'LastDate'), 'yyyymmdd')

		// 간판정보 update parmameter 
		// 지역(1)/공장(1)/품번(12)/입력자(6)/입력일(8)/Flag(Y,N)
		ls_rc = String(' ', '@')		
//		SQLCA.P_KB_CON(ls_misflag, ls_area, ls_division, ls_item, ls_userid, ls_inputdate, ls_rc)
		if ls_today < ls_applyfrom then
			continue
		end if
		if ls_misflag = 'A' or ls_misflag = 'D' then
			ls_rc = 'Y'
			if ls_misflag = 'A' then
			   ls_kbcd = 'K'
			else
				ls_kbcd = ' '
			end if	
		   UPDATE	PBinv.inv101
			SET		kbcd = :ls_kbcd
			WHERE		comltd = '01' 
			AND		xplant = :ls_area 
			and		div    = :ls_division
			and      itno   = :ls_item ;
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
		else
		   ls_rc = 'N'
		end if 
		If ll_error = 0 and ls_rc = 'Y' Then
			Commit;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
			
			Update	tmstpartkb_interface
			Set		interfaceflag = 'N',
						lastdate	= getdate()
			Where		logid = :ll_logid
			Using		it_source;
			
			ll_error	= it_source.SQLCODE
			ls_error	= it_source.SQLErrText
			
			If ll_error = 0 Then
				Commit Using it_source ;
			Else
				Rollback Using it_source ;
			End If	

		Else
			RollBack;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tmstpartkb_interface : ' + ls_error,it_source)
			end if
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_flag_check (string fs_pipeline_name, ref string rs_action_name, ref string rs_fail_gubun);String ls_flag, ls_note

SetNull(ls_flag)

CHOOSE CASE Upper(fs_pipeline_name)
	CASE 'D_UPLOAD_TQQCITEM_TEMP'
		rs_action_name = 'UPLOAD_QCITEM_TEMP'
		ls_note			= 'QC Item Interface Flag For Upload'
	CASE 'D_UPLOAD_TQBUSINESSTEMP'
		rs_action_name = 'UPLOAD_TQBUSINESSTEMP'
		ls_note			= '검사정보 Interface Flag For Upload'
	CASE 'D_UPLOAD_TSRCONFIRM01_INTERFACE'
		rs_action_name = 'UPLOAD_SR확정'
		ls_note			= 'SR 확정 Interface Flag For Upload'
	CASE 'D_UPLOAD_TSRCANCEL_INTERFACE'
		rs_action_name = 'UPLOAD_SRCANCEL'
		ls_note			= '취소 SR확정 Interface Flag For Upload'
	CASE 'D_UPLOAD_TSRCONFIRM02_INTERFACE'
		rs_action_name = 'UPLOAD_SR취소입력'
		ls_note			= 'SR 취소입력 Interface Flag For Upload'
	CASE 'D_UPLOAD_TSTOCK_INTERFACE'
		rs_action_name = 'UPLOAD_STOCK'
		ls_note			= 'Stock Interface Flag For Upload'
	CASE 'D_UPLOAD_TSTOCKCANCEL_INTERFACE'
		rs_action_name = 'UPLOAD_STOCKCANCEL'
		ls_note			= 'Stock Cancel Interface Flag For Upload'
	CASE 'D_UPLOAD_TSHIPSHEET_INTERFACE'
		rs_action_name = 'UPLOAD_SHIPSHEET'
		ls_note			= '출하정보  Interface Flag For Upload'
	CASE 'D_UPLOAD_TSHIPBACK_INTERFACE'
		rs_action_name = 'UPLOAD_SHIPBACK'
		ls_note			= '출하취소정보  Interface Flag For Upload'
	CASE 'D_UPLOAD_TSHIPETC_INTERFACE'
		rs_action_name = 'UPLOAD_SHIPETC'
		ls_note			= '사내출하 및 반납정보 Interface Flag For Upload'
	CASE 'D_UPLOAD_TSHIPINV_INTERFACE'
		rs_action_name = 'UPLOAD_SHIPINV'
		ls_note			= '이체입고정보 Interface Flag For Upload'
	CASE 'D_UPLOAD_TMCPARTRELEASE'
		rs_action_name = 'UPLOAD_MCPARTRELEASE'
		ls_note			= '공무자재불출 Interface Flag For Upload'
	CASE 'D_UPLOAD_TMCPARTRETURN'
		rs_action_name = 'UPLOAD_MCPARTRETURN'
		ls_note			= '공무자재반납 Interface Flag For Upload'
	CASE 'D_UPLOAD_TPARTKBORDER_INTERFACE'
		rs_action_name = 'UPLOAD_PARTKBORDER'
		ls_note			= 'Part KB Order Interface Flag For Upload'
	CASE 'D_UPLOAD_TPARTKBINCOME_INTERFACE'
		rs_action_name = 'UPLOAD_PARTKBINCOME'
		ls_note			= 'Part KB Income Interface Flag For Upload'
	CASE 'D_UPLOAD_TMSTPARTKB'
		rs_action_name = 'UPLOAD_TMSTPARTKB'
		ls_note			= '간판 UPDATE정보 Interface Flag For Upload'
	CASE 'D_UPLOAD_TPLANDAY_INTERFACE'
		rs_action_name = 'UPLOAD_TPLANDAY'
		ls_note			= 'PLANDAY Interface Flag For Upload'
	CASE 'D_UPLOAD_TPARTKBDAYORDER_INTERFACE'
		rs_action_name = 'UPLOAD_TPARTKBDAYORDER'
		ls_note			= '발주현황 Interface Flag For Upload'
	CASE 'D_UPLOAD_TMCMASTER'
		rs_action_name = 'UPLOAD_TMCMASTER'
		ls_note			= '장비 MASTER Interface Flag For Upload'
	CASE 'D_UPLOAD_YINV002TEMP'
		rs_action_name = 'UPLOAD_YINV002TEMP'
		ls_note			= '여주 품목기본정보 Interface Flag For Upload'
	CASE 'D_UPLOAD_YINV101TEMP'
		rs_action_name = 'UPLOAD_YINV101TEMP'
		ls_note			= '여주 품목상세정보 Interface Flag For Upload'
	CASE 'D_UPLOAD_YBOMTEMP'
		rs_action_name = 'UPLOAD_TBOMTEMP'
		ls_note			= '여주 BOM정보 Interface Flag For Upload'
	CASE 'D_UPLOAD_TPARTIN_INTERFACE'
		rs_action_name = 'UPLOAD_TPARTIN'
		ls_note			= '여주 입고 Interface Flag For Upload'
	CASE 'D_UPLOAD_TPARTCANCEL_INTERFACE'
		rs_action_name = 'UPLOAD_TPARTCANCEL'
		ls_note			= '여주 입고취소 Interface Flag For Upload'
	CASE 'D_UPLOAD_TPARTRELEASE_INTERFACE'
		rs_action_name = 'UPLOAD_TPARTRELEASE'
		ls_note			= '여주 자재불출 Interface Flag For Upload'
	CASE 'D_UPLOAD_TPARTRETURN_INTERFACE'
		rs_action_name = 'UPLOAD_TPARTRETURN'
		ls_note			= '여주 자재반납 Interface Flag For Upload'
END CHOOSE

Select Flag Into :ls_flag
  From MSTFLAG
 Where ActionName = :rs_action_name
 using it_source;
 
it_source.AutoCommit	= False
If IsNull(ls_flag) Then
	Insert into MSTFLAG (ActionName, Flag, Note, LastEmp, LastDate)
	Values(:rs_action_name, 'Y', :ls_note, 'INTERFACE', GetDate())
	using it_source;
	
	If it_source.SQLCODE = 0 Then
		commit using it_source;
		it_source.AutoCommit	= True
		Return True
	Else
		rollback using it_source;
		it_source.AutoCommit	= True
		rs_fail_gubun = 'E'
		Return False
	End If
Else
	If ls_flag = 'Y' Then
		it_source.AutoCommit	= True
		rs_fail_gubun	= 'Y'
		Return False
	Else
		Update MSTFLAG
			Set Flag			= 'Y',
				 LastEmp		= 'INTERFACE',
				 LastDate	= GetDate()
		 Where ActionName = :rs_action_name
		 using it_source;

		If it_source.SQLCODE = 0 Then
			commit using it_source;
			it_source.AutoCommit	= True
			Return True
		Else
			rollback using it_source;
			it_source.AutoCommit	= True
			rs_fail_gubun = 'E'
			Return False
		End If
	End If
End If
end function

public function boolean wf_last_execute_update ();it_source.AutoCommit	= False

Update TINTERFACE
   Set StartTime = :idt_currdatetime, LastExecuted = GetDate()
 Where InterfaceID = :ii_interface_id 
 using it_source;

If it_source.SQLCODE = 0 Then
	Commit using it_source;
Else
	RollBack using it_source;
End If

it_source.AutoCommit	= True
Return True
end function

public function boolean wf_upload ();Int rowcount, li_cycletime, li_second
String ls_interface_gubun, ls_source, ls_destination, ls_datetime
String ls_datawindow_name, ls_interface_name, ls_fail_gubun, ls_return_option
DateTime ldt_lastdatetime
date 		ld_lastdate, ld_currentdate
time		lt_lasttime, lt_currenttime, lt_jobtime
Boolean	lb_upload = False

SetPointer(HourGlass!)

Select InterfaceGubun,
		 Source,
		 Destination,
		 CycleTime,
		 PipeLineName,
		 InterfaceName,
		 StartTime
  Into :ls_interface_gubun,
  		 :ls_source,
		 :ls_destination,
		 :li_CycleTime,
		 :ls_datawindow_name,
		 :ls_interface_name,
		 :ldt_lastdatetime
  From TINTERFACE
 Where InterfaceID = :ii_interface_id
 using it_source ;

//If Not wf_flag_check(ls_datawindow_name, is_action_name, ls_fail_gubun) Then
//	If ls_fail_gubun = 'Y' Then
//		MessageBox("UpLoad", "현재 해당 정보의 Upload를 수행중입니다.")
//	End If
//	If ls_fail_gubun = 'E' Then
//		MessageBox("UpLoad", "Upload Flag 정보 Update중 오류가 발생하였습니다.")
//	End If
//	Return False
//End If

If Not wf_connect(gs_ini_file, ls_source, ls_destination, it_source, it_destination) Then
	wf_flag_update(is_action_name)
	Return False
End If

// Host 시간 읽어서 마지막 실행시간 update(근태 데이타 다운로드 땜시...)
//ls_datetime = wf_get_host_datetime()
//wf_last_execute_update()

ld_lastdate	=	Date(ldt_lastdatetime)
lt_lasttime	=	Time(ldt_lastdatetime)
idt_currdatetime = f_pisc_get_date_nowtime(it_source)
ld_CurrentDate	=	Date(idt_currdatetime)
lt_CurrentTime	=	Time(idt_currdatetime)

if is_cycle = 'MI' or is_cycle = 'HH' then
	if	is_cycle	=	'MI' Then
		li_second	=	li_cycletime	*	60
	ElseIf is_Cycle	=	'HH' Then
		li_second	=	li_cycletime	*	3600
	End if
	if ld_lastdate = ld_currentdate then
		lt_jobtime	= RelativeTime(lt_lasttime, li_second)
		if lt_jobtime > lt_currenttime then
			wf_flag_update(is_action_name)
			Return false
		end if
	end if
end if

uo_pipe.st_read.Text = '0'
uo_pipe.st_written.Text = '0'
uo_pipe.st_error.Text = '0'
uo_pipe.st_time.Text = ''

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

CHOOSE CASE Upper(ls_datawindow_name)
	CASE 'D_UPLOAD_TQQCITEM_TEMP'
		lb_upload = wf_upload_tqqcitem_temp(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TQBUSINESSTEMP'
		lb_upload = wf_upload_tqbusinesstemp(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TPARTKBORDER_INTERFACE'
		lb_upload = wf_upload_tpartkborder_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TPARTKBINCOME_INTERFACE'
		lb_upload = wf_upload_tpartkbincome_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TSTOCK_INTERFACE'
		lb_upload = wf_upload_tstock_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TSTOCKCANCEL_INTERFACE'
		lb_upload = wf_upload_tstockcancel_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TSHIPSHEET_INTERFACE'
		lb_upload = wf_upload_tshipsheet_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TSHIPINV_INTERFACE'
		lb_upload = wf_upload_tshipinv_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TSHIPBACK_INTERFACE'
		lb_upload = wf_upload_tshipback_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TSHIPETC_INTERFACE'
		lb_upload = wf_upload_tshipetc_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TSRCANCEL_INTERFACE'
		lb_upload = wf_upload_tsrcancel_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TMSTPARTKB_INTERFACE'
		lb_upload = wf_upload_tmstpartkb_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TMSTPARTKB'
		lb_upload = wf_upload_tmstpartkb(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TSRCONFIRM01_INTERFACE'
		lb_upload = wf_upload_tsrconfirm01_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TSRCONFIRM02_INTERFACE'
		lb_upload = wf_upload_tsrconfirm02_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TMCPARTRELEASE'
		lb_upload = wf_upload_tmcpartrelease(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TMCPARTRETURN'
		lb_upload = wf_upload_tmcpartreturn(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TPLANDAY_INTERFACE'
		lb_upload = wf_upload_tplanday(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TPARTKBDAYORDER_INTERFACE'
		lb_upload = wf_upload_tpartkbdayorder(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TMCMASTER'
		lb_upload = wf_upload_tmcmaster(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_YINV002TEMP'
		lb_upload = wf_upload_yinv002temp(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_YINV101TEMP'
		lb_upload = wf_upload_yinv101temp(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_YBOMTEMP'
		lb_upload = wf_upload_ybomtemp(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TPARTIN_INTERFACE'
		lb_upload = wf_upload_tpartin_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TPARTCANCEL_INTERFACE'
		lb_upload = wf_upload_tpartcancel_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TPARTRELEASE_INTERFACE'
		lb_upload = wf_upload_tpartrelease_interface(ls_datawindow_name, ls_return_option)
	CASE 'D_UPLOAD_TPARTRETURN_INTERFACE'
		lb_upload = wf_upload_tpartreturn_interface(ls_datawindow_name, ls_return_option)
END CHOOSE

If ls_return_option = 'S' Then
	wf_last_execute_update()
End if

uo_parameter.Event Trigger ue_retrieve(ii_interface_id, rowcount, it_source)

wf_flag_update(is_action_name)

Return False
end function

public function boolean wf_auto_upload ();
Long		ll_row, i
Int		rowcount
Datetime ld_lastexecuted

ll_row	= dw_interface.Rowcount()

For i = 1 To ll_row	
	// server 연결이 안되었거나 야간엔 돌지 않는다...
	If Not wf_connect_check(SQLCA, it_source) Then
		// 일간단위 timer를 다시 10분 간격으로 변경
		If is_cycle = 'DD' Then
			Timer(600)
		End If	
		
		Exit
	else
		If is_cycle <> 'DD' then
			If String(Today(), 'hhmmss') >= '080000' and String(Today(), 'hhmmss') <= '200000' Then
				//pass
			Else
				Exit
			End If
		Else
			If String(Today(), 'hhmmss') >= '080000' and String(Today(), 'hhmmss') <= '230000' Then
				//pass
			Else
				Timer(600)
				Exit
			End If
		End if
	End If
	
	ii_interface_id = dw_interface.GetItemNumber(i, 'InterfaceID')
	is_sp_name = dw_interface.GetItemString(i, 'ProcedureName')
	
	dw_interface.SelectRow(0, False)
	dw_interface.SelectRow(i, True)	
	dw_interface.ScrollToRow(i)
	uo_parameter.Event Trigger ue_retrieve(ii_interface_id, rowcount, it_source)
	
	// 초단위/시간단위일 경우에 수행, 일간단위일때는 저녁 6시에서 8시 사이에만 수행
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
				
				If wf_upload() Then
					wf_dw_init(2)
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

	// 일간단위일때는 저녁 6시에서  한번 수행
	If (is_cycle = 'DD') and (String(Today(), 'hhmmss') >= '200000') Then
		//최종실행시간 가져오기
		  SELECT TINTERFACE.LastExecuted  
    			INTO :ld_lastexecuted  
    			FROM TINTERFACE  
   			WHERE TINTERFACE.InterfaceID = :ii_interface_id 
				using it_source;
				
		If String(ld_lastexecuted,'yyyymmddhh') > (String(Today(),'yyyymmdd') + '20') then
			// pass
		Else
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
					
					If wf_upload() Then
						wf_dw_init(2)
					End If
						
					uo_button.uf_button_enable(True, False, True)
					uo_parameter.Enabled	= True
					dw_interface.Enabled	= True
					uo_option.Enabled		= True
					uo_date.Enabled		= True
					ib_interface = False
				End If			
			End If
		End if
	
		Yield()	
		If ib_cancel Then 
			ib_cancel = False
			Exit
		End If
		
		// 일간단위 전체 수행한후 0.5h지연...
		If i = ll_row Then
			Timer(600)
		End If	
		
	End If	
Next	

return true
end function

public subroutine wf_upload_sp (string fs_sp);// procedure가 sqlca에서만 정상적으로 동작한다... 쓰벌

String	ls_today

ls_today = String(Today(), 'yyyy.mm.dd')

Disconnect Using SQLCA;

SQLCA.DBMS       	= ProfileString(gs_ini_file, 'IPIS', "DBMS",             "X")
SQLCA.Database   	= ProfileString(gs_ini_file, 'IPIS', "DataBase",         " ")
SQLCA.LogID      	= ProfileString(gs_ini_file, 'IPIS', "LogID",            " ")
SQLCA.LogPass    	= ProfileString(gs_ini_file, 'IPIS', "LogPassword",      " ")
SQLCA.ServerName 	= ProfileString(gs_ini_file, 'IPIS', "ServerName",       " ")
SQLCA.UserID     	= ProfileString(gs_ini_file, 'IPIS', "UserID",           " ")
SQLCA.DBPass     	= ProfileString(gs_ini_file, 'IPIS', "DatabasePassword", " ")
SQLCA.Lock       	= ProfileString(gs_ini_file, 'IPIS', "Lock",             " ")
SQLCA.DbParm     	= ProfileString(gs_ini_file, 'IPIS', "DbParm",           " ")

Connect Using SQLCA;

// 각 공장 데이타 통합 DB로 복사

Choose Case Upper(fs_sp)
	Case 'SP_PISI_U_TPARTKBINCOME_INTERFACE'	
		DECLARE u_tpartkbincome_interface procedure for sp_pisi_u_tpartkbincome_interface;
		EXECUTE u_tpartkbincome_interface;
	Case 'SP_PISI_U_TPARTKBORDER_INTERFACE'
		DECLARE u_tpartkborder_interface procedure for sp_pisi_u_tpartkborder_interface;
		EXECUTE u_tpartkborder_interface;
	Case 'SP_PISI_U_TSTOCK_INTERFACE'	
		DECLARE u_tstock_interface procedure for sp_pisi_u_tstock_interface;
		EXECUTE u_tstock_interface;
	Case 'SP_PISI_U_TSTOCKCANCEL_INTERFACE'	
		DECLARE u_tstockcancel_interface procedure for sp_pisi_u_tstockcancel_interface;
		EXECUTE u_tstockcancel_interface;		
	Case 'SP_PISI_U_TSHIPSHEET_INTERFACE'	
		DECLARE u_tshipsheet_interface procedure for sp_pisi_u_tshipsheet_interface;
		EXECUTE u_tshipsheet_interface;
	Case 'SP_PISI_U_TSHIPBACK_INTERFACE'	
		DECLARE u_tshipback_interface procedure for sp_pisi_u_tshipback_interface;
		EXECUTE u_tshipback_interface;
	Case 'SP_PISI_U_TSHIPETC_INTERFACE'	
		DECLARE u_tshipetc_interface procedure for sp_pisi_u_tshipetc_interface;
		EXECUTE u_tshipetc_interface;
	Case 'SP_PISI_U_TSHIPINV_INTERFACE'	
		DECLARE u_tshipinv_interface procedure for sp_pisi_u_tshipinv_interface;
		EXECUTE u_tshipinv_interface;
	Case 'SP_PISI_U_TQBUSINESSTEMP'	
		DECLARE u_tqbusinesstemp procedure for sp_pisi_u_tqbusinesstemp;
		EXECUTE u_tqbusinesstemp;
	Case 'SP_PISI_U_TQQCITEM_TEMP'
		DECLARE u_tqqcitem_temp procedure for sp_pisi_u_tqqcitem_temp;
		EXECUTE u_tqqcitem_temp ;
	Case 'SP_PISI_U_TSRCANCEL_INTERFACE'
		DECLARE u_tsrcancel_interface procedure for sp_pisi_u_tsrcancel_interface;
		EXECUTE u_tsrcancel_interface ;
	Case 'SP_PISI_U_TMSTPARTKB_INTERFACE'
		DECLARE u_tmstpartkb_interface procedure for sp_pisi_u_tmstpartkb_interface;
		EXECUTE u_tmstpartkb_interface ;
	Case 'SP_PISI_U_TSRCONFIRM01_INTERFACE'
		DECLARE u_tsrconfirm01_interface procedure for sp_pisi_u_tsrconfirm01_interface;
		EXECUTE u_tsrconfirm01_interface ;
	Case 'SP_PISI_U_TSRCONFIRM02_INTERFACE'
		DECLARE u_tsrconfirm02_interface procedure for sp_pisi_u_tsrconfirm02_interface;
		EXECUTE u_tsrconfirm02_interface ;
	Case 'SP_PISI_U_TMSTPARTKB'
		DECLARE u_tmstpartkb procedure for sp_pisi_u_tmstpartkb;
		EXECUTE u_tmstpartkb ;
	Case 'SP_PISI_U_TPLANDAY_INTERFACE'
		DECLARE u_tplanday_interface procedure for sp_pisi_u_tplanday_interface
			@ps_date = :ls_today;	
		EXECUTE u_tplanday_interface ;
	Case 'SP_PISI_U_TPARTKBDAYORDER_INTERFACE'
		DECLARE u_tpartkbdayorder_interface procedure for sp_pisi_u_tpartkbdayorder_interface;	
		EXECUTE u_tpartkbdayorder_interface ;
	Case 'SP_PISI_U_TPARTIN_INTERFACE'
		DECLARE u_tpartin_interface procedure for sp_pisi_u_tpartin_interface;	
		EXECUTE u_tpartin_interface ;
	Case 'SP_PISI_U_TPARTCANCEL_INTERFACE'
		DECLARE u_tpartcancel_interface procedure for sp_pisi_u_tpartcancel_interface;	
		EXECUTE u_tpartcancel_interface ;
	Case 'SP_PISI_U_TPARTRELEASE_INTERFACE'
		DECLARE u_tpartrelease_interface procedure for sp_pisi_u_tpartrelease_interface;	
		EXECUTE u_tpartrelease_interface ;
	Case 'SP_PISI_U_TPARTRETURN_INTERFACE'
		DECLARE u_tpartreturn_interface procedure for sp_pisi_u_tpartreturn_interface;	
		EXECUTE u_tpartreturn_interface ;
End Choose


Disconnect Using SQLCA;

SQLCA.DBMS       	= ProfileString(gs_ini_file, "MIS", "DBMS",             "X")
SQLCA.Database   	= ProfileString(gs_ini_file, "MIS", "DataBase",         " ")
SQLCA.LogID      	= ProfileString(gs_ini_file, "MIS", "LogID",            " ")
SQLCA.LogPass    	= ProfileString(gs_ini_file, "MIS", "LogPassword",      " ")
SQLCA.ServerName 	= ProfileString(gs_ini_file, "MIS", "ServerName",       " ")
SQLCA.UserID     	= ProfileString(gs_ini_file, "MIS", "UserID",           " ")
SQLCA.DBPass     	= ProfileString(gs_ini_file, "MIS", "DatabasePassword", " ")
SQLCA.Lock       	= ProfileString(gs_ini_file, "MIS", "Lock",             " ")
SQLCA.DbParm     	= ProfileString(gs_ini_file, "MIS", "DbParm",           " ")
SQLCA.AutoCommit	= True

Connect Using SQLCA;

end subroutine

public function boolean wf_upload_ybomtemp (string fs_dataobject, ref string rs_return_option);// 여주 BOM 정보 upload
Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today, ls_applyday, ls_lastday, ls_firstday
String	ls_prout, ls_pchdt, ls_pwkct, ls_pedtm, ls_pedte, ls_popcd, ls_pexplant
String   ls_pexdv, ls_pchcd, ls_poscd, ls_pebst, ls_pmacaddr, ls_pipaddr
String   ls_pindt, ls_pemno, ls_premk
Dec{3}   lc_pqtym, lc_pqtye
String	ls_lib, ls_clp
Datastore lds_bom001

//월말일자 가져오기
ls_today = String(Today(), 'yyyymmdd')
ls_firstday = MID(ls_today,1,6) + '01'
ls_applyday = Mid( ls_today, 1, 4) + "." + Mid( ls_today, 5, 2)
Select Top 1 Convert(Char(8), DateAdd(DD, -1, DateAdd(MM, 1, Convert(DateTime, :ls_applyday + '.01'))), 112)
  Into :ls_lastday
  From sysusers
Using it_source;

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

lds_bom001 = create datastore
lds_bom001.dataobject = 'd_upload_bom001'
lds_bom001.settransobject(sqlca)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then	
	// 기존 여주 BOM 삭제
	If ls_today <> ls_lastday Then
		DELETE FROM "PBPDM"."BOM001"  
		WHERE ( "PBPDM"."BOM001"."PCMCD" = '01' ) AND  
				( "PBPDM"."BOM001"."PLANT" = 'Y' ) AND  
				( "PBPDM"."BOM001"."PDVSN" = 'Y' ) AND
				( "PBPDM"."BOM001"."PEDTM" >= :ls_firstday )
		using sqlca;
	Else
		UPDATE "PBPDM"."BOM001" 
		SET "PEDTE" = :ls_lastday
		WHERE ( "PBPDM"."BOM001"."PCMCD" = '01' ) AND  
				( "PBPDM"."BOM001"."PLANT" = 'Y' ) AND  
				( "PBPDM"."BOM001"."PDVSN" = 'Y' ) AND
				( "PBPDM"."BOM001"."PEDTM" >= :ls_firstday )
		using sqlca;
	End If
	
	dw_2.RowsCopy(1, ll_rowcount, Primary!, lds_bom001, 1, Primary!)
	
	if lds_bom001.update() = 1 then
		ll_end_time = Cpu ()
		uo_pipe.st_time.text = String((ll_end_time - ll_start_time)/1000,"#,##0") + " Secs"
		rs_return_option = 'S'
	else
		ll_error = sqlca.sqlcode
		ls_error = sqlca.sqlerrtext
		f_errorlog_insert('UPLOAD', 1, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_ybomtemp : ' + ls_error,it_source)
		rs_return_option = 'F'
	End If
	
	ls_lib = 'PBPDM'
	ls_clp = 'BOM001'
	
	SQLCA.SP_RGZPF01(ls_lib, ls_clp)
	
	ll_error	= SQLCA.SQLCODE
	ls_error	= SQLCA.SQLErrText
	
	if ll_error <> 0 then
		f_errorlog_insert('UPLOAD', 2, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_ybomtemp : ' + ls_error,it_source)
	end if
	
Else
	dw_2.SetRedraw(True)
	ll_end_time = Cpu ()
	uo_pipe.st_time.text = string((ll_end_time - ll_start_time)/1000,"##0.0") + " Secs"
	uo_pipe.st_written.Text = '0'
	uo_pipe.st_error.Text	= '0'
	rs_return_option = 'S'
End If

Destroy lds_bom001
Return True
end function

public function boolean wf_upload_tqbusinesstemp (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_misflag, ls_area, ls_division, ls_item, ls_slno, ls_judge
String	ls_supplier, ls_goodqty, ls_badqty, ls_userid, ls_inputdate, ls_qty
String	ls_stockdate, ls_seqno, ls_rc
Long		ll_logid
Decimal	ld_goodqty, ld_badqty, ld_temp
String	ls_lib, ls_pgm, ls_parm
String	l_s_srno, l_s_srno1, l_s_srno2
Decimal	l_n_dckqt

//Int		li_goodqty, li_badqty

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tqbusinesstemp')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_area				= dw_2.GetItemString(i, 'AreaCode')
		ls_division			= dw_2.GetItemString(i, 'DivisionCode')
		ls_slno				= dw_2.GetItemString(i, 'SlNo')
		ls_supplier			= dw_2.GetItemString(i, 'SupplierCode')
		ls_item				= Left(dw_2.GetItemString(i, 'ItemCode') + Space(10), 12)
		ls_judge				= dw_2.GetItemString(i, 'JudgeFlag')
		ld_goodqty			= dw_2.GetItemNumber(i, 'GoodQty')
//		ls_goodqty			= Right(Fill('0', 10) + String(dw_2.GetItemNumber(i, 'GoodQty')), 10) + '0'
		ld_badqty			= dw_2.GetItemNumber(i, 'BadQty')
//		ls_badqty			= Right(Fill('0', 10) + String(dw_2.GetItemNumber(i, 'BaddQty')), 10) + '0'
		ls_userid			= Left(dw_2.GetItemString(i, 'LastEmp') + Space(10), 6)
		ls_inputdate		= String(dw_2.GetItemDatetime(i, 'LastDate'), 'yyyymmdd')

		// 검사정보 update parmameter 
		// 지역(1)/공장(1)/증빙번호(12)/업체번호(5)/품번(12)/
		// 판정결과(1)/합격량(10.1)/불합격량(10.1)/입력자(6)/입력일(8)/Flag(Y,N)


		Choose Case ls_judge
			Case '1'
				UPDATE	pbinv.inv201 
				SET		dexqt = dckqt, ndexqt = 0
				WHERE		COMLTD = '01' 
				and		xplant = :ls_area 
				and		div  = :ls_division 
				and		slno   = :ls_slno     
				and		vndr = :ls_supplier 
				and		itno   = :ls_item ;                                                                        
				ll_error	= SQLCA.SQLCODE
				ls_error	= SQLCA.SQLErrText
						
			Case '2'
				UPDATE	pbinv.inv201 
				SET		ndexqt = dckqt, dexqt = 0
				WHERE		COMLTD = '01' 
				and		xplant = :ls_area 
				and		div  = :ls_division 
				and		slno   = :ls_slno     
				and		vndr = :ls_supplier 
				and		itno   = :ls_item ;                                                                        
				ll_error	= SQLCA.SQLCODE
				ls_error	= SQLCA.SQLErrText

			Case Else
				DECLARE c1 CURSOR FOR
				SELECT	SRNO, SRNO1, SRNO2, DCKQT 
				from		pbinv.inv201                                                      
				WHERE		comltd = '01'       
				and		xplant = :ls_area 
				and		div    = :ls_division  
				and		slno   = :ls_slno 
				and		vndr   = :ls_supplier 
				and		itno   = :ls_item ;   
			
				OPEN c1 ;

				FETCH c1 INTO :l_s_srno, :l_s_srno1, :l_s_srno2, :l_n_dckqt ;
				ll_error	= SQLCA.SQLCODE
				ls_error	= SQLCA.SQLErrText

				DO WHILE  SQLCA.SQLCODE = 0

					If l_n_dckqt > ld_badqty Then
						ld_temp = l_n_dckqt - ld_badqty
						
						UPDATE	PBinv.inv201
						SET		ndexqt = :ld_badqty,
									dexqt = :ld_temp,
									updtid = :ls_userid
						WHERE		srno = :l_s_srno 
						AND		srno1 = :l_s_srno1 
						and		srno2 = :l_s_srno2 ;
	
						ld_badqty = 0
						ll_error	= SQLCA.SQLCODE
						ls_error	= SQLCA.SQLErrText
					  
					Else
						UPDATE 	PBinv.inv201
						SET		ndexqt = :l_n_dckqt,
									dexqt = 0,
									updtid = :ls_userid
						WHERE		srno = :l_s_srno 
						AND		srno1 = :l_s_srno1 
						and		srno2 = :l_s_srno2 ;
						
						ld_badqty = ld_badqty - l_n_dckqt
						ll_error	= SQLCA.SQLCODE
						ls_error	= SQLCA.SQLErrText
	
					End If

					FETCH c1 INTO :l_s_srno,:l_s_srno1,:l_s_srno2, :l_n_dckqt;
				LOOP
      
				CLOSE c1 ;                                                                                           
		END Choose                                                                                                     

//		SQLCA.P_QC_CON(ls_area, ls_division, ls_slno, ls_supplier, ls_item, ls_judge, + &
//					li_goodqty, li_badqty, ls_userid, ls_inputdate, ls_rc)
				
//		ll_error	= SQLCA.SQLCODE
//		ls_error	= SQLCA.SQLErrText

		If ll_error = 0 Then
			Commit;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
			
			Update	tqbusinesstemp
			Set		interfaceflag = 'N',
						lastdate	= getdate()
			Where		logid = :ll_logid
			Using		it_source;
			
			ll_error	= it_source.SQLCODE
			ls_error	= it_source.SQLErrText
			
			If ll_error = 0 Then
				Commit Using it_source ;
			Else
				Rollback Using it_source ;
			End If	

		Else
			RollBack;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tqbusinesstemp : ' + ls_error,it_source)
			end if
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tstockcancel_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_misflag, ls_areacode, ls_divisioncode, ls_itemcode, ls_workcenter, ls_kbno
String	ls_partkbno, ls_orderseq, ls_deliverydate, ls_userid, ls_orderdate, ls_qty
String	ls_stockdate, ls_seqno, ls_stockgubun
Long		ll_logid
String	ls_lib, ls_pgm, ls_parm

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tstockcancel_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_misflag			= dw_2.GetItemString(i, 'MISFlag')
		ls_areacode			= dw_2.GetItemString(i, 'AreaCode')
		ls_divisioncode	= dw_2.GetItemString(i, 'DivisionCode')
		ls_itemcode			= Left(dw_2.GetItemString(i, 'ItemCode') + Space(10), 12)
		ls_workcenter		= Left(dw_2.GetItemString(i, 'WorkCenter'), 4)
		ls_kbno				= dw_2.GetItemString(i, 'KBNo')
		ls_qty				= Right(Fill('0', 10) + String(dw_2.GetItemNumber(i, 'StockQty')), 7)
		ls_stockdate		= dw_2.GetItemString(i, 'StockDate')		// 입고일
		ls_stockdate		= Left(ls_stockdate, 4) + Mid(ls_stockdate, 6, 2) + Right(ls_stockdate, 2)		
		ls_orderdate		= dw_2.GetItemString(i, 'KBReleaseDate')	// 취소일
		ls_orderdate		= Left(ls_orderdate, 4) + Mid(ls_orderdate, 6, 2) + Right(ls_orderdate, 2)
		ls_stockgubun		= dw_2.GetItemString(i, 'LineCode')

      if mid(ls_kbno, 3, 1) = 'Z' then
			If ls_stockgubun = 'N' Then	// 정상
				ls_stockgubun = 'U'
			ElseIf ls_stockgubun = 'D' Then	// 불량
				ls_stockgubun = 'S'
			ElseIf ls_stockgubun = 'R' Then	// 요수리
				ls_stockgubun = 'R'
			Else
				ls_stockgubun = ls_stockgubun
			End If
		else
			ls_stockgubun = 'U'
		end if	
			
		ls_seqno				= Left(String(dw_2.GetItemNumber(i, 'SeqNo')) + Space(10), 10)
		ls_userid			= Left(dw_2.GetItemString(i, 'LastEmp') + Space(10), 6)

		// 매월말일일때 IPIS Server 시간을 체크해서 데이타 일자와 같을 경우에만 upload 한다.
		// 그러나, 월초(1일)일때는 08:00 이전까지는 서버 시간과 데이타 같더라도 upload 몬한다.
		If wf_check_server_date(ls_stockdate) Then

			ls_lib	= 'PBJIT'
			ls_pgm	= 'JIT5B41'
			// 제품입고취소정보 parmameter 
			// 구분(1)/지역(1)/공장(1)/품번(12)/
			// 간판번호(11)/취소량(7.0)/취소일(8)/재고상태(1)/등록순번(10)/사용자ID(6)
			ls_parm	= ls_misflag + ls_areacode + ls_divisioncode + ls_itemcode + &
							ls_kbno + ls_qty + ls_stockdate + ls_stockgubun + ls_seqno + ls_userid
		
//			messagebox(ls_misflag,		string(len(ls_misflag)))
//			messagebox(ls_areacode,		string(len(ls_areacode)))
//			messagebox(ls_divisioncode,		len(ls_divisioncode))
//			messagebox(ls_itemcode,		len(ls_itemcode))
//			messagebox(ls_kbno,		len(ls_kbno))
//			messagebox(ls_qty,		len(ls_qty))
//			messagebox(ls_stockdate,		len(ls_stockdate))
//			messagebox(ls_stockgubun,		len(ls_stockgubun))
//			messagebox(ls_seqno,		len(ls_seqno))
//			messagebox(ls_userid,		len(ls_userid))
			
	//		// 데이타 upload procedure 호출
	//		DECLARE mis_sp_ipis procedure for dejito.jit5b00sp :ls_lib, :ls_pgm, :ls_parm;
	//		EXECUTE mis_sp_ipis;
			
			ls_parm = String(ls_parm, '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
			SQLCA.JIT5B00SP(ls_lib, ls_pgm, ls_parm)
			
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
			
	//		messagebox(string(ll_error), ls_parm)
			If ll_error = 0 and Right(Trim(ls_parm), 1) = 'Y' Then
				Commit Using SQLCA ;
				dw_2.DeleteRow(i)
				uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
				
				Update	tstockcancel_interface
				Set		interfaceflag = 'N',
							lastdate	= getdate()
				Where		logid = :ll_logid
				Using		it_source;
				
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
				
				If ll_error = 0 Then
					Commit Using it_source ;
				Else
					Rollback Using it_source ;
				End If	
	
			Else
				RollBack Using SQLCA ;
				uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
				ll_error_cnt ++
				if ll_error < 0 then
					f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tstockcancel_interface : ' + ls_error,it_source)
				end if
			End If
		End If	// 서버 시간 체크 로직 end
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tshipsheet_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_misflag, ls_srno, ls_shipdate, ls_sheetno, ls_kit
String	ls_partkbno, ls_orderseq, ls_deliverydate, ls_userid, ls_orderdate, ls_qty
String	ls_stockdate, ls_seqno
Long		ll_logid
String	ls_lib, ls_pgm, ls_parm

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tshipsheet_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_misflag			= dw_2.GetItemString(i, 'MISFlag')
		ls_srno				= Left(dw_2.GetItemString(i, 'SRNo') + Space(10), 8)	//////////////// 확인(OK)
		
		ls_shipdate			= dw_2.GetItemString(i, 'ShipDate')		// 출하일
		ls_shipdate			= Left(ls_shipdate, 4) + Mid(ls_shipdate, 6, 2) + Right(ls_shipdate, 2)
		ls_qty				= Right(Fill('0', 10) + String(dw_2.GetItemNumber(i, 'ShipQty')), 7)
		ls_sheetno			= Left(dw_2.GetItemString(i, 'ShipSheetNo') + Space(10), 10)

		If Mid(ls_sheetno, 3, 1) <> 'M' Then	// 이체 데이타 건너뛰고...
			ls_kit				= Left(dw_2.GetItemString(i, 'KitGubun') + Space(5), 1)	/////////////////// 확인
			ls_userid			= Left(dw_2.GetItemString(i, 'LastEmp') + Space(10), 6)
	
			// 매월말일일때 IPIS Server 시간을 체크해서 데이타 일자와 같을 경우에만 upload 한다.
			// 그러나, 월초(1일)일때는 08:00 이전까지는 서버 시간과 데이타 같더라도 upload 몬한다.
			If wf_check_server_date(ls_shipdate) Then

				ls_lib	= 'PBJIT'
				ls_pgm	= 'JIT5B42'
				// 출하정보 parmameter 
				// 구분(1)/SR전산번호(8)/출하일(8)/출하량(7.0)/
				// 출하전표번호(10)/KIT구분(1)/사용자ID(6)
				ls_parm	= ls_misflag + ls_srno + ls_shipdate + ls_qty + &
								ls_sheetno + ls_kit + ls_userid
		
		//		messagebox(ls_misflag,		len(ls_misflag))
		//		messagebox(ls_srno,		len(ls_srno))
		//		messagebox(ls_shipdate,		len(ls_shipdate))
		//		messagebox(ls_qty,		len(ls_qty))
		//		messagebox(ls_sheetno,		len(ls_sheetno))
		//		messagebox(ls_kit,		len(ls_kit))
		//		messagebox(ls_userid,		len(ls_userid))
								
		//		// 데이타 upload procedure 호출
		//		DECLARE mis_sp_ipis procedure for dejito.jit5b00sp :ls_lib, :ls_pgm, :ls_parm;
		//		EXECUTE mis_sp_ipis;
		
				ls_parm = String(ls_parm, '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
				SQLCA.JIT5B00SP(ls_lib, ls_pgm, ls_parm)
				
				ll_error	= SQLCA.SQLCODE
				ls_error	= SQLCA.SQLErrText
				
		//		messagebox(string(ll_error), ls_parm)
				If ll_error = 0 and Right(TRIM(ls_parm), 1) = 'Y' Then
					Commit Using SQLCA ;
					dw_2.DeleteRow(i)
					uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
					
					Update	tshipsheet_interface
					Set		interfaceflag = 'N',
								lastdate	= getdate()
					Where		logid = :ll_logid
					Using		it_source;
					
					ll_error	= it_source.SQLCODE
					ls_error	= it_source.SQLErrText
					
					If ll_error = 0 Then
						Commit Using it_source ;
					Else
						Rollback Using it_source ;
					End If	
		
				Else
					RollBack Using SQLCA ;
					uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
					ll_error_cnt ++
					if ll_error < 0 then
						f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tshipsheet_interface : ' + ls_error,it_source)
					end if
				End If
			End If	// 이체 데이타 건너뛰고...
		End If	// 서버 시간 체크 로직 end	
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tshipback_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_misflag, ls_csrno, ls_csrno1, ls_csrno2, ls_canceldate, ls_billno
String	ls_invflag, ls_userid, ls_orderdate, ls_qty
String	ls_stockdate, ls_seqno, ls_shipgubun, ls_itno
Long		ll_logid
String	ls_lib, ls_pgm, ls_parm

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tshipback_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_misflag			= dw_2.GetItemString(i, 'MISFlag')
		ls_csrno				= Left(dw_2.GetItemString(i, 'CSRNO') + Space(10), 8)	//////////////// 확인 csrno, srno
		ls_csrno1			= Left(dw_2.GetItemString(i, 'CSRNO1') + Space(10), 2)		// 출하분할횟수
		ls_csrno2			= Left(dw_2.GetItemString(i, 'CSRNO2') + Space(10), 2)		// 납품분할횟수
		ls_billno			= Left(dw_2.GetItemString(i, 'BillNo') + Space(10), 10)
		ls_canceldate		= dw_2.GetItemString(i, 'CancelConfirmDate')		// 취소일
		ls_canceldate		= Left(ls_canceldate, 4) + Mid(ls_canceldate, 6, 2) + Right(ls_canceldate, 2)
		ls_invflag			= dw_2.GetItemString(i, 'InvGubunFlag')
		If ls_invflag = 'N' Then
			ls_invflag = 'U'
		ElseIf ls_invflag = 'D' Then
			ls_invflag = 'S'
		End If	
		ls_qty				= Right(Fill('0', 10) + String(dw_2.GetItemNumber(i, 'CancelQty')), 7)
		ls_userid			= Left(dw_2.GetItemString(i, 'LastEmp') + Space(10), 6)
		ls_shipgubun		= dw_2.GetItemString(i, 'ShipGubun')
		ls_itno		= dw_2.GetItemString(i, 'Itno')

		// 매월말일일때 IPIS Server 시간을 체크해서 데이타 일자와 같을 경우에만 upload 한다.
		// 그러나, 월초(1일)일때는 08:00 이전까지는 서버 시간과 데이타 같더라도 upload 몬한다.
		If wf_check_server_date(ls_canceldate) Then
			// 역이체건 추가 ( 2003.11.10 )
			If ls_shipgubun = 'M' then
				ls_qty				= ls_qty + Fill('0', 1)
				ls_lib	= 'PBJIT'
				ls_pgm	= 'JIT5B47'
				// 출하취소정보 parmameter 
				// 구분(1)/취소의뢰전산번호(8)/출하분할횟수(2)/납품분할횟수(2)/
				// 취소일(8)/취소량(7.0)/사용자ID(6)
				ls_parm	= ls_misflag + ls_csrno + ls_csrno1 + ls_csrno2 + &
								ls_canceldate + ls_qty + ls_userid
			Else
				ls_lib	= 'PBJIT'
				ls_pgm	= 'JIT5B43'
				// 출하취소정보 parmameter 
				// 구분(1)/취소의뢰전산번호(8)/출하분할횟수(2)/납품분할횟수(2)/
				// 전표번호(10)/취소일(8)/재고상태(1)/취소량(7.0)/사용자ID(6)
				ls_parm	= ls_misflag + ls_csrno + ls_csrno1 + ls_csrno2 + &
								ls_billno + ls_canceldate + ls_invflag + ls_qty + ls_userid
			End If
	
	//		messagebox(ls_misflag,		len(ls_misflag))
	//		messagebox(ls_csrno,		len(ls_csrno))
	//		messagebox(ls_csrno1,		len(ls_csrno1))
	//		messagebox(ls_csrno2,		len(ls_csrno2))
	//		messagebox(ls_billno,		len(ls_billno))
	//		messagebox(ls_canceldate,		len(ls_canceldate))
	//		messagebox(ls_invflag,		len(ls_invflag))
	//		messagebox(ls_qty,		len(ls_qty))
	//		messagebox(ls_userid,		len(ls_userid))
			
		
	//		// 데이타 upload procedure 호출
	//		DECLARE mis_sp_ipis procedure for dejito.jit5b00sp :ls_lib, :ls_pgm, :ls_parm;
	//		EXECUTE mis_sp_ipis;
			
			ls_parm = String(ls_parm, '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
			SQLCA.JIT5B00SP(ls_lib, ls_pgm, ls_parm)
			
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
			
	//		messagebox(string(ll_error), ls_parm)
			If ll_error = 0 and Right(TRIM(ls_parm), 1) = 'Y' Then
				Commit Using SQLCA ;
				dw_2.DeleteRow(i)
				uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
				
				Update	tshipback_interface
				Set		interfaceflag = 'N',
							lastdate	= getdate()
				Where		logid = :ll_logid
				Using		it_source;
				
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
				
				If ll_error = 0 Then
					Commit Using it_source ;
				Else
					Rollback Using it_source ;
				End If	
	
			Else
				RollBack Using SQLCA ;
				uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
				ll_error_cnt ++
				if ll_error < 0 then
					f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tshipback_interface : ' + ls_error,it_source)
				end if
			End If
		End If	// 서버 시간 체크 로직 end
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tshipetc_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_misflag, ls_area, ls_division, ls_dept, ls_inputdate, ls_item
String	ls_invflag, ls_userid, ls_inputflag, ls_confirmno, ls_project, ls_qty
String	ls_stockdate, ls_seqno
Long		ll_logid
String	ls_lib, ls_pgm, ls_parm

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tshipetc_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_misflag			= dw_2.GetItemString(i, 'MISFlag')
		ls_inputflag		= dw_2.GetItemString(i, 'InputFlag')		// 출하반납구분
		ls_area				= dw_2.GetItemString(i, 'AreaCode')
		ls_division			= dw_2.GetItemString(i, 'DivisionCode')
		ls_item				= Left(dw_2.GetItemString(i, 'ItemCode') + Space(10), 12)
		ls_confirmno		= Left(dw_2.GetItemString(i, 'ConfirmNo') + Space(10), 10)	// 전표
		ls_inputdate		= dw_2.GetItemString(i, 'InputDate')		// 전표일
		ls_inputdate		= Left(ls_inputdate, 4) + Mid(ls_inputdate, 6, 2) + Right(ls_inputdate, 2)
		ls_dept				= dw_2.GetItemString(i, 'DeptCode')			// 사용부서
		ls_project			= Left(dw_2.GetItemString(i, 'ProjectNo') + Space(10), 5)
		If IsNull(ls_project) Then
			ls_project = '     '
		End If	

		ls_invflag			= dw_2.GetItemString(i, 'InvGubunFlag')
		If ls_invflag = 'N' Then
			ls_invflag = 'U'
		ElseIf ls_invflag = 'D' Then
			ls_invflag = 'S'
		End If	
		ls_qty				= Right(Fill('0', 10) + String(dw_2.GetItemNumber(i, 'EtcQty')), 7) + Fill('0', 1)
		ls_userid			= Left(dw_2.GetItemString(i, 'LastEmp') + Space(10), 6)

		// 매월말일일때 IPIS Server 시간을 체크해서 데이타 일자와 같을 경우에만 upload 한다.
		// 그러나, 월초(1일)일때는 08:00 이전까지는 서버 시간과 데이타 같더라도 upload 몬한다.
		If wf_check_server_date(ls_inputdate) Then

			ls_lib	= 'PBJIT'
			ls_pgm	= 'JIT5B44'
			// 사내출하 및 반납정보 parmameter 
			// 구분(1)/출하반납구분(1)/지역(1)/공장(1)/품번(12)/전표번호(10)/
			// 전표일(8)/사용부서(4)/project번호(5)/재고상태(1)/수량(7.1)/사용자ID(6)
			ls_parm	= ls_misflag + ls_inputflag + ls_area + ls_division + ls_item + ls_confirmno + &
							ls_inputdate + ls_dept + ls_project + ls_invflag + ls_qty + ls_userid
			
	//		messagebox(ls_misflag,		len(ls_misflag))
	//		messagebox(ls_inputflag,		len(ls_inputflag))
	//		messagebox(ls_area,		len(ls_area))
	//		messagebox(ls_division,		len(ls_division))
	//		messagebox(ls_item,		len(ls_item))
	//		messagebox(ls_confirmno,		len(ls_confirmno))
	//		messagebox(ls_inputdate,		len(ls_inputdate))
	//		messagebox(ls_dept,		len(ls_dept))
	//		messagebox(ls_project,		len(ls_project))
	//		messagebox(ls_invflag,		len(ls_invflag))
	//		messagebox(ls_qty,		len(ls_qty))
	//		messagebox(ls_userid,		len(ls_userid))
	//		
	//		messagebox(string(len(ls_parm)), ls_parm)
		
	//		// 데이타 upload procedure 호출
	//		DECLARE mis_sp_ipis procedure for dejito.jit5b00sp :ls_lib, :ls_pgm, :ls_parm;
	//		EXECUTE mis_sp_ipis;
					
			ls_parm = String(ls_parm, '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
			SQLCA.JIT5B00SP(ls_lib, ls_pgm, ls_parm)
			
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
			
	//		messagebox(string(ll_error), ls_parm)
			If ll_error = 0 and Right(TRIM(ls_parm), 1) = 'Y' Then
				Commit Using SQLCA ;
				dw_2.DeleteRow(i)
				uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
				
				Update	tshipetc_interface
				Set		interfaceflag = 'N',
							lastdate	= getdate()
				Where		logid = :ll_logid
				Using		it_source;
				
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
				
				If ll_error = 0 Then
					Commit Using it_source ;
				Else
					Rollback Using it_source ;
				End If	
	
			Else
				RollBack Using SQLCA ;
				uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
				ll_error_cnt ++
				if ll_error < 0 then
					f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tshipetc_interface : ' + ls_error,it_source)
				end if
			End If
		End If	// 서버 시간 체크 로직 end
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tshipinv_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_misflag, ls_moveno, ls_movedate, ls_item
String	ls_invflag, ls_userid, ls_inputflag, ls_confirmno, ls_project, ls_qty
String	ls_stockdate, ls_seqno
Long		ll_logid
String	ls_lib, ls_pgm, ls_parm

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tshipinv_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_misflag			= dw_2.GetItemString(i, 'MISFlag')
		ls_moveno			= dw_2.GetItemString(i, 'MoveRequireNo')

		If Right(ls_moveno, 3) = 'P00' Then		// 기존 데이타 1	'2Z036000P00'
			ls_moveno	= Left(Left(ls_moveno, 8) + Space(20), 12)
		ElseIf Len(ls_moveno) = 8 Then			// 기존 데이타 2	'2Z008300'		
			ls_moveno	= Left(Left(ls_moveno, 8) + Space(20), 12)
//		ElseIf Len(ls_moveno) = 10 Then			// 기존 데이타 3	2120003110'	-- 데이타 수정하자
		
		ElseIf Len(ls_moveno) = 11 Then			// 기존 데이타 4	'2Z008300JH1'		
			ls_moveno	= ls_moveno + '0'
		End If
			
		ls_movedate			= dw_2.GetItemString(i, 'MoveConfirmDate')		// 이체입고일
		ls_movedate			= Left(ls_movedate, 4) + Mid(ls_movedate, 6, 2) + Right(ls_movedate, 2)
		ls_qty				= Right(Fill('0', 10) + String(dw_2.GetItemNumber(i, 'TruckLoadQty')), 7) + Fill('0', 1)
		ls_userid			= Left(dw_2.GetItemString(i, 'LastEmp') + Space(10), 6)

		// 매월말일일때 IPIS Server 시간을 체크해서 데이타 일자와 같을 경우에만 upload 한다.
		// 그러나, 월초(1일)일때는 08:00 이전까지는 서버 시간과 데이타 같더라도 upload 몬한다.
		If wf_check_server_date(ls_movedate) Then

			ls_lib	= 'PBJIT'
			ls_pgm	= 'JIT5B45'
			// 이체입고정보 parmameter 
			// 구분(1)/이체의뢰전산번호(12)/이체입고일(8)/이체입고량(7.1)/사용자ID(6)
			ls_parm	= ls_misflag + ls_moveno + ls_movedate + ls_qty + ls_userid
		
	//		messagebox(ls_misflag,		len(ls_misflag))
	//		messagebox(ls_moveno,		len(ls_moveno))
	//		messagebox(ls_movedate,		len(ls_movedate))
	//		messagebox(ls_qty,		len(ls_qty))
	//		messagebox(ls_userid,		len(ls_userid))
			
	//		// 데이타 upload procedure 호출
	//		DECLARE mis_sp_ipis procedure for dejito.jit5b00sp :ls_lib, :ls_pgm, :ls_parm;
	//		EXECUTE mis_sp_ipis;
			
			ls_parm = String(ls_parm, '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
			SQLCA.JIT5B00SP(ls_lib, ls_pgm, ls_parm)
			
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
			
	//		messagebox(string(ll_error), ls_parm)
			If ll_error = 0 and Right(TRIM(ls_parm), 1) = 'Y' Then
				Commit Using SQLCA ;
				dw_2.DeleteRow(i)
				uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
				
				Update	tshipinv_interface
				Set		interfaceflag = 'N',
							lastdate	= getdate()
				Where		logid = :ll_logid
				Using		it_source;
				
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
				
				If ll_error = 0 Then
					Commit Using it_source ;
				Else
					Rollback Using it_source ;
				End If	
	
			Else
				RollBack Using SQLCA ;
				uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
				ll_error_cnt ++
				if ll_error < 0 then
					f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tshipinv_interface : ' + ls_error,it_source)
				end if
			End If
		End If	// 서버 시간 체크 로직 end
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tmcpartrelease (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_status, ls_areacode, ls_divisioncode, ls_itemcode, ls_slipno, ls_dept
String	ls_usage, ls_mcno, ls_releasedate, ls_userid, ls_stockstatus, ls_qty
String	ls_stockdate, ls_seqno, ls_orderno, ls_serialno
Long		ll_logid
String	ls_lib, ls_pgm, ls_parm
Int		li_check
Decimal	ld_qty

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_status			= dw_2.GetItemString(i, 'DataStatus')		
		ls_areacode			= dw_2.GetItemString(i, 'AreaCode')
		ls_divisioncode	= dw_2.GetItemString(i, 'DivisionCode')		
		ls_itemcode			= Left(dw_2.GetItemString(i, 'ItemCode') + Space(20), 12)
		ls_slipno			= Left(dw_2.GetItemString(i, 'SlipNo') + Space(20), 12)
		ls_orderno			= Left(dw_2.GetItemString(i, 'OrderNo') + Space(20), 16)
		ls_dept				= Left(dw_2.GetItemString(i, 'DeptCode') + Space(10), 5)
		If IsNull(ls_dept) Then
			ls_dept	= '     '
		End If
		ls_usage				= Left(dw_2.GetItemString(i, 'Usage') + Space(10), 2)
		If IsNull(ls_usage) Then
			ls_usage	= '  '
		End If
		ls_mcno				= Left(dw_2.GetItemString(i, 'MCNo') + Space(10), 9)
		If IsNull(ls_mcno) Then
			ls_mcno	= '         '
		End If
		ls_releaseDate		= dw_2.GetItemString(i, 'ReleaseDate')		
		ls_stockstatus		= dw_2.GetItemString(i, 'StockStatus')		
		ld_qty				= dw_2.GetItemNumber(i, 'ReleaseQty')
		ls_qty				= string(ld_qty, "0000000.0")
		li_check				= Len(ls_qty)
		ls_qty				= Right(Left(ls_qty, li_check - 2), 7) + Right(ls_qty, 1)
		ls_serialno			= Left(dw_2.GetItemString(i, 'SerialNo')	+ Space(10), 10)	
		ls_userid			= Left(dw_2.GetItemString(i, 'LastEmp') + Space(10), 6)
		If IsNull(ls_userid) Then
			ls_userid	= '      '
		End If

		// 매월말일일때 IPIS Server 시간을 체크해서 데이타 일자와 같을 경우에만 upload 한다.
		// 그러나, 월초(1일)일때는 08:00 이전까지는 서버 시간과 데이타 같더라도 upload 몬한다.
		If wf_check_server_date(ls_releasedate) Then

			ls_lib	= 'PBJIT'
			ls_pgm	= 'JIT5B33'
			// 공무자재 불출정보 parmameter 
			// 구분(1)/지역(1)/공장(1)/품번(12)/불출전표번호(12)/
			// 작업지시번호(16)/사용부서(10)/불출용도(2)/장비번호(9)/
			// 불출일자(8)/재고상태(1)/불출량(7.1)/등록순번(10)/사용자ID(6)
			ls_parm	= ls_status + ls_areacode + ls_divisioncode + ls_itemcode + ls_slipno +&
							ls_orderno + ls_dept + ls_usage + ls_mcno + &
							ls_releasedate + ls_stockstatus + ls_qty + ls_serialno + ls_userid
	
			ls_parm = String(ls_parm, '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
			
	//		messagebox(ls_status,		len(ls_status))
	//		messagebox(ls_areacode,		len(ls_areacode))
	//		messagebox(ls_divisioncode,		len(ls_divisioncode))
	//		messagebox(ls_itemcode,		len(ls_itemcode))
	//		messagebox(ls_slipno,		len(ls_slipno))
	//		messagebox(ls_orderno,		len(ls_orderno))
	//		messagebox(ls_dept,		len(ls_dept))
	//		messagebox(ls_usage,		len(ls_usage))
	//		messagebox(ls_mcno,		len(ls_mcno))
	//		messagebox(ls_releasedate,		len(ls_releasedate))
	//		messagebox(ls_stockstatus,		len(ls_stockstatus))
	//		messagebox(ls_qty,		len(ls_qty))
	//		messagebox(ls_serialno,		len(ls_serialno))
	//		messagebox(ls_userid,		len(ls_userid))
					
	//		// 데이타 upload procedure 호출
	//		DECLARE mis_sp_ipis procedure for dejito.jit5b00sp :ls_lib, :ls_pgm, :ls_parm;
	//		EXECUTE mis_sp_ipis;
			
			SQLCA.JIT5B00SP(ls_lib, ls_pgm, ls_parm)
			
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
			
	//		messagebox(string(ll_error), ls_parm)
			If ll_error = 0 and Right(Trim(ls_parm), 1) = 'Y' Then
				Commit Using SQLCA ;
				dw_2.DeleteRow(i)
				uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
				
				Update	tmcpartrelease
				Set		uploadflag = 'Y',
							lastdate	= getdate()
				Where		logid = :ll_logid
				Using		it_source;
				
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
				
				If ll_error = 0 Then
					Commit Using it_source ;
				Else
					Rollback Using it_source ;
				End If	
	
			Else
				RollBack Using SQLCA ;
				uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
				ll_error_cnt ++
				if ll_error < 0 then
					f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tmcpartrelease : ' + ls_error,it_source)
				end if
			End If
		End If	// 서버 시간 체크 로직 end
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tpartreturn_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_gubun, ls_area, ls_division, ls_itemcode, ls_rtndept, ls_rtnusage, ls_rtngubun
String	ls_rtndate, ls_tidno, ls_userid, ls_inputdate, ls_suppliercode
Long		ll_logid
dec{1} 	ld_uqty, ld_rqty, ld_sqty

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tpartreturn_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_gubun 			= dw_2.GetItemString(i, 'Gubun')
		ls_area				= dw_2.GetItemString(i, 'AreaCode')
		ls_division			= dw_2.GetItemString(i, 'DivisionCode')
		ls_itemcode			= dw_2.GetItemString(i, 'ItemCode')
		ls_rtndept			= dw_2.GetItemString(i, 'RtnDept')
		if isnull(ls_rtndept) then ls_rtndept = ''
		ls_rtnusage			= dw_2.GetItemString(i, 'RtnUsage')
		ls_rtngubun			= dw_2.GetItemString(i,	'RtnGubun')
		ls_rtndate			= dw_2.GetItemString(i, 'RtnDate')
		ls_suppliercode	= dw_2.GetItemString(i, 'SupplierCode')
		if isnull(ls_suppliercode) then ls_suppliercode = ''
		ld_uqty				= dw_2.GetItemDecimal(i, 'Uqty')
		ld_rqty				= dw_2.GetItemDecimal(i, 'Rqty')
		ld_sqty				= dw_2.GetItemDecimal(i, 'Sqty')
		ls_tidno				= dw_2.GetItemString(i, 'TidNo')
		ls_userid			= dw_2.GetItemString(i, 'LastEmp')
		ls_inputdate		= String(dw_2.GetItemDatetime(i, 'LastDate'), 'yyyymmdd')
		if isnull(ls_inputdate) then ls_inputdate = ''

		// 반납정보 update parmameter 
		// 구분(1)/지역(1)/공장(1)/품번(12)/반납부서(4)/반납용도(2)/반납구분(2)/반납일(8)/Uqty(11,1)
		//			/Rqty(11,1)/Sqty(11,1)/업체번호(5)/Tidno(12)/사용자(6)
		
		ll_error = f_inv_out_rtn( ls_gubun, ls_area, ls_division, ls_itemcode, ls_rtndept, &
				ls_rtnusage, ls_rtngubun, ls_rtndate, ld_uqty, ld_rqty, ld_sqty, ls_suppliercode, &
				mid(ls_tidno,4,12), ls_userid, ls_inputdate, ls_error) 

		If ll_error = 0 Then
			Commit;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
			
			Update	tpartreturn_interface
			Set		interfaceflag = 'N',
						lastdate	= getdate()
			Where		logid = :ll_logid
			Using		it_source;
			
			ll_error	= it_source.SQLCODE
			ls_error	= it_source.SQLErrText
			
			If ll_error = 0 Then
				Commit Using it_source ;
			Else
				Rollback Using it_source ;
			End If	

		Else
			RollBack;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_yeoju('UPLOAD', ii_interface_id, ll_logid, ls_error,it_source)
			end if
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tpartin_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_gubun, ls_area, ls_division, ls_itemcode, ls_slno, ls_incomedate
String	ls_itemsource, ls_tidno, ls_userid, ls_inputdate
Long		ll_logid

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tpartin_interface')

ls_error = "에러초기화"
ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_gubun 			= dw_2.GetItemString(i, 'Gubun')
		ls_area				= dw_2.GetItemString(i, 'AreaCode')
		ls_division			= dw_2.GetItemString(i, 'DivisionCode')
		ls_slno				= dw_2.GetItemString(i, 'SlNo')
		ls_itemcode			= dw_2.GetItemString(i, 'ItemCode')
		ls_incomedate		= dw_2.GetItemString(i, 'IncomeDate')
		ls_itemsource		= dw_2.GetItemString(i, 'ItemSource')
		ls_tidno				= dw_2.GetItemString(i, 'TidNo')
		ls_userid			= dw_2.GetItemString(i, 'LastEmp')
		ls_inputdate		= String(dw_2.GetItemDatetime(i, 'LastDate'), 'yyyymmdd')
		if isnull(ls_inputdate) then ls_inputdate = ''
		// 입고정보 update parmameter 
		// 구분(1)/거래명세표번호(12)/지역(1)/공장(1)/품번(12)/입고일(8)/Tidno(12)
		If ls_itemsource = '01' Then
			ll_error = f_inv_expin( ls_gubun, ls_slno, ls_area, ls_division, ls_itemcode, &
					ls_incomedate, mid(ls_tidno,4,12), ls_userid, ls_inputdate, ls_error) 
		Else
			ll_error = f_inv_domin( ls_gubun, ls_slno, ls_area, ls_division, ls_itemcode, &
					ls_incomedate, mid(ls_tidno,4,12), ls_userid, ls_inputdate, ls_error)
		End If

		If ll_error = 0 Then
			Commit;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
			
			Update	tpartin_interface
			Set		interfaceflag = 'N',
						lastdate	= getdate()
			Where		logid = :ll_logid
			Using		it_source;
			
			ll_error	= it_source.SQLCODE
			ls_error	= it_source.SQLErrText
			
			If ll_error = 0 Then
				Commit Using it_source ;
			Else
				Rollback Using it_source ;
			End If	

		Else
			RollBack;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_yeoju('UPLOAD', ii_interface_id, ll_logid, ls_error,it_source)
			end if
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tpartcancel_interface (string fs_dataobject, ref string rs_return_option);integer  li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_gubun, ls_area, ls_division, ls_itemcode, ls_invstatus, ls_canceldate
String	ls_itemsource, ls_tidno, ls_userid, ls_inputdate, ls_suppliercode, ls_blno
Long		ll_logid
dec{1} 	ld_cancelqty
dec{0}   ld_cancelamt

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tpartcancel_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_gubun 			= dw_2.GetItemString(i, 'Gubun')
		ls_area				= dw_2.GetItemString(i, 'AreaCode')
		ls_division			= dw_2.GetItemString(i, 'DivisionCode')
		ls_invstatus		= dw_2.GetItemString(i, 'InvStatus')
		ls_itemcode			= dw_2.GetItemString(i, 'ItemCode')
		ls_canceldate		= dw_2.GetItemString(i, 'CancelDate')
		ls_itemsource		= dw_2.GetItemString(i, 'ItemSource')
		ls_suppliercode	= dw_2.GetItemString(i, 'SupplierCode')
		if isnull(ls_suppliercode) then ls_suppliercode = ''
		ls_blno				= dw_2.GetItemString(i, 'Blno')
		if isnull(ls_blno) then ls_blno = ''
		ld_cancelqty		= dw_2.GetItemDecimal(i, 'CancelQty')
		ld_cancelamt		= dw_2.GetItemDecimal(i, 'CancelAmt')
		ls_tidno				= dw_2.GetItemString(i, 'TidNo')
		ls_userid			= dw_2.GetItemString(i, 'LastEmp')
		ls_inputdate		= String(dw_2.GetItemDatetime(i, 'LastDate'), 'yyyymmdd')
		if isnull(ls_inputdate) then ls_inputdate = ''
		// 취소정보 update parmameter 
		// 내자 : 구분(1)/지역(1)/공장(1)/품번(12)/취소입고일(8)/재고상태(1)/업체번호(5)
		//			/취소량(11,1)/Tidno(12)/사용자(6)
		// 외자 : 구분(1)/지역(1)/공장(1)/품번(12)/취소입고일(8)/재고상태(1)/Blno(22)
		//			/취소량(11,1)/취소금액(13)/Tidno(12)/사용자(6)

		If ls_itemsource = '01' Then
			ll_error = f_inv_expin_cancel( ls_gubun, ls_area, ls_division, ls_itemcode, ls_canceldate, &
					ls_invstatus, ls_blno, ld_cancelqty, ld_cancelamt, mid(ls_tidno,4,12), ls_userid, ls_inputdate, ls_error) 
		Else
			ll_error = f_inv_domin_cancel( ls_gubun, ls_area, ls_division, ls_itemcode, ls_canceldate, &
					ls_invstatus, ls_suppliercode, ld_cancelqty, mid(ls_tidno,4,12), ls_userid, ls_inputdate, ls_error) 			
		End If

		If ll_error = 0 Then
			Commit;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
			
			Update	tpartcancel_interface
			Set		interfaceflag = 'N',
						lastdate	= getdate()
			Where		logid = :ll_logid
			Using		it_source;
			
			ll_error	= it_source.SQLCODE
			ls_error	= it_source.SQLErrText
			
			If ll_error = 0 Then
				Commit Using it_source ;
			Else
				Rollback Using it_source ;
			End If	

		Else
			RollBack;
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_yeoju('UPLOAD', ii_interface_id, ll_logid, ls_error,it_source)
			end if
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_yinv002temp (string fs_dataobject, ref string rs_return_option);// 여주품번 기본정보 upload

Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today 
String	ls_misflag, ls_itno, ls_itnm, ls_spec, ls_xunit, ls_xtype
String 	ls_rvno, ls_rrogb, ls_inptid, ls_inptdt
String	ls_lib, ls_pgm, ls_parm
long 		ll_logid


ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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

		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_misflag			= Upper(dw_2.GetItemString(i, 'Chgcd'))
		ls_itno				= Upper(dw_2.GetItemString(i, 'Itno'))
		ls_itnm				= Upper(dw_2.GetItemString(i, 'Itnm'))
		ls_spec				= Upper( Trim(dw_2.GetItemString(i, 'Spec')))
		ls_xunit				= Upper( Trim(dw_2.GetItemString(i, 'Xunit')))
		ls_xtype				= Upper( Trim(dw_2.GetItemString(i, 'Xtype')))
		ls_rvno				= Upper( Trim(dw_2.GetItemString(i, 'Rvno')))
		ls_rrogb				= Upper( Trim(dw_2.GetItemString(i, 'Rrogb')))
		ls_inptid			= Upper( Trim(dw_2.GetItemString(i, 'Inptid')))
		ls_inptdt			= Upper( Trim(dw_2.GetItemString(i, 'Inptdt')))
		
		if isnull( ls_itnm ) then ls_itnm = ''
		if isnull( ls_spec ) then ls_spec = ''
		if isnull( ls_xunit ) then ls_xunit = ''
		if isnull( ls_xtype ) then ls_xtype = ''
		if isnull( ls_rvno ) then ls_rvno = ''
		if isnull( ls_rrogb ) then ls_rvno = ''
		if isnull( ls_inptid ) then ls_inptid = ''
		if isnull( ls_inptdt ) then ls_inptdt = ''
		
		If ls_misflag = 'A' Then		// Add - Insert
		
			INSERT INTO "PBINV"."INV002"  
         ( "COMLTD","ITNO","ITNM","SPEC","XUNIT","MAKER","GUBUN","XPLAN",   
           "RVNO","XTYPE","ITNO1","LOLEVEL","RROGB","FIXGB","BKDESN01","BKDESN02",   
           "XSTOP","INL","FST","SND","THD","EXTD","INPTID","INPTDT",   
           "UPDTID","UPDTDT","IPADDR","MACADDR" )  
  			VALUES ('01', :ls_itno, :ls_itnm, :ls_spec, :ls_xunit, ' ','2',' ',
			  :ls_rvno, :ls_xtype, ' ', 0, :ls_rrogb, ' ', ' ', ' ',
			  ' ', ' ', ' ', ' ', ' ', ' ', :ls_inptid, :ls_inptdt,
			  ' ',' ',' ',' ')  
			using sqlca;
			
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
		
		ElseIf ls_misflag = 'R' Then
			UPDATE "PBINV"."INV002"  
     			SET "ITNM" = :ls_itnm,   
         		"SPEC" = :ls_spec,   
         		"XUNIT" = :ls_xunit,   
         		"RVNO" = :ls_rvno,   
         		"XTYPE" = :ls_xtype, 
					"RROGB" = :ls_rrogb,
         		"INPTID" = :ls_inptid,   
         		"INPTDT" = :ls_inptdt  
   		WHERE ( "PBINV"."INV002"."COMLTD" = '01' ) AND  
         		( "PBINV"."INV002"."ITNO" = :ls_itno )   
         using sqlca;

		ElseIf ls_misflag = 'D' Then	// Delete - Delete
			
			Delete	
			From		PBINV.INV002
			Where		comltd	= '01'
			and		itno = :ls_itno
			using sqlca;

			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
			
		End If	
	
		If ll_error = 0 Then
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
			
			Update	YINV002TEMP_LOG
			Set		Ipisflag	= 'Y'
			Where		LogID	= :ll_logid
			Using		it_source;

			ll_error	= it_source.SQLCODE
			ls_error	= it_source.SQLErrText
			
			If ll_error = 0 Then
				Commit Using it_source ;
			Else
				Rollback Using it_source ;
			End If	

		Else
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_yinv002temp : ' + ls_error,it_source)
			end if
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_yinv101temp (string fs_dataobject, ref string rs_return_option);// 여주품번 기본정보 upload

Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today 
String	ls_xplant, ls_div, ls_misflag, ls_itno, ls_cls, ls_srce, ls_pdcd, ls_xunit
String 	ls_abccd, ls_wloc, ls_mlan, ls_mass, ls_inptid, ls_inptdt, ls_costdiv
String	ls_lib, ls_pgm, ls_parm
long 		ll_logid
Dec{4}	lc_convqty
Dec{0}   lc_saud


ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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

		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_misflag			= Upper(dw_2.GetItemString(i, 'Chgcd'))
		ls_xplant			= Upper(dw_2.GetItemString(i, 'Xplant'))
		ls_div				= Upper(dw_2.GetItemString(i, 'Div'))
		ls_itno				= Upper(dw_2.GetItemString(i, 'Itno'))
		ls_cls				= Upper(dw_2.GetItemString(i, 'Cls'))
		ls_srce				= Upper(dw_2.GetItemString(i, 'Srce'))
		if isnull(ls_srce) then ls_srce = ' '
		ls_pdcd				= Upper( Trim(dw_2.GetItemString(i, 'Pdcd')))
		ls_xunit				= Upper( Trim(dw_2.GetItemString(i, 'Xunit')))
		if isnull(ls_xunit) then ls_xunit = ' '
		ls_abccd				= Upper( Trim(dw_2.GetItemString(i, 'Abccd')))
		if isnull(ls_abccd) then ls_abccd = ' '
		lc_convqty			= dw_2.GetItemNumber(i, 'Convqty')
		if isnull(lc_convqty) or lc_convqty = 0 then lc_convqty = 1
		ls_wloc				= Upper( Trim(dw_2.GetItemString(i, 'Wloc')))
		if isnull(ls_wloc) then ls_wloc = ' '
		lc_saud				= dw_2.GetItemNumber(i, 'Saud')
		if isnull(lc_saud) then lc_saud = 0
		ls_mlan				= dw_2.GetItemString(i, 'Mlan')
		if isnull(ls_mlan) then ls_mlan = ''
		ls_mass				= dw_2.GetItemString(i, 'Mass')
		if isnull(ls_mass) then ls_mass = ' '
		ls_inptid			= Upper( Trim(dw_2.GetItemString(i, 'Inptid')))
		if isnull(ls_inptid) then ls_inptid = ' '
		ls_inptdt			= Upper( Trim(dw_2.GetItemString(i, 'Inptdt')))
		if isnull(ls_inptdt) then ls_inptdt = ' '
		ls_costdiv 			= f_get_accdiv(ls_xplant,ls_div,ls_pdcd)
		
		If ls_misflag = 'A' Then		// Add - Insert

			INSERT INTO "PBINV"."INV101"  
         ( "COMLTD", "XPLANT", "DIV", "ITNO", "CLS", "SRCE", "PDCD", "XUNIT", "UNIT1",   
           "COSTDIV", "XPLAN", "MLAN", "CONVQTY", "CONVQTY1", "AUTCD", "MDNO", "WLOC",   
           "WCCD", "ISCD", "ISBOX", "NUSE", "ABCCD", "KBCD", "MASS", "IRTCD", "MAXQ",   
           "MINQ", "SAFT", "SFWQ", "ADJQTY", "ORPT", "PULS", "ISLS", "PULT",   
           "BGQTY", "BGAMT", "INTQTY", "INTAMT", "OUTQTY", "OUTAMT", "OHUQTY", "OHRQTY",   
           "OHSQTY", "OHAMT", "EXQTY", "COSTAV", "COSTLS", "SAUP", "SAUD", "IUNPR",   
           "IUNRC", "ISPQT", "IPERP", "IPEIS", "IPERP1", "PKSZ", "SHPCD", "ILUDT",   
           "LPDT", "MCNO", "FOBCOST", "CURR", "CHKCD", "HSCD", "TXRT", "FSTDT",   
           "INDUS", "COMCD", "EXTD", "INPTID", "INPTDT", "UPDTID", "UPDTDT",   
           "IPADDR", "MACADDR" )  
  			VALUES ('01', :ls_xplant, :ls_div, :ls_itno, :ls_cls, :ls_srce, :ls_pdcd, :ls_xunit, ' ',
			  :ls_costdiv, ' ', :ls_mlan, :lc_convqty, 0, ' ', ' ', :ls_wloc,
			  'N', ' ', ' ', ' ', :ls_abccd, ' ', :ls_mass, ' ', 0,
			  0, 0, 0, 0, 0, 0, 0, 0,
			  0, 0, 0, 0, 0, 0, 0, 0,
			  0, 0, 0, 0, 0, 0, :lc_saud, 0,
			  0, 0, 0, 0, 0, 0, ' ', ' ',
			  ' ', ' ', 0, ' ', ' ', ' ', 0, ' ',
			  ' ', ' ', ' ', :ls_inptid, :ls_inptdt, ' ', ' ',
			  ' ', ' ')  
			using sqlca;

			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
		ElseIf ls_misflag = 'R' Then
			UPDATE "PBINV"."INV101"  
			  SET "XUNIT" = :ls_xunit,   
					"CONVQTY" = :lc_convqty,   
					"WLOC" = :ls_wloc,   
					"ABCCD" = :ls_abccd, 
					"MLAN" = :ls_mlan,
					"MASS" = :ls_mass,
					"INPTID" = :ls_inptid,   
					"INPTDT" = :ls_inptdt  
			WHERE ( "PBINV"."INV101"."COMLTD" = '01' ) AND  
					( "PBINV"."INV101"."XPLANT" = :ls_xplant ) AND  
					( "PBINV"."INV101"."DIV" = :ls_div ) AND  
					( "PBINV"."INV101"."ITNO" = :ls_itno )   
			using sqlca;
		ElseIf ls_misflag = 'D' Then	// Delete - Delete
			
			Delete	
			From		PBINV.INV101
			Where COMLTD = '01' And XPLANT = :ls_xplant And
					DIV = :ls_div And ITNO = :ls_itno
			using sqlca;

			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
			
		End If	
	
		If ll_error = 0 Then
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
			
			Update	YINV101TEMP_LOG
			Set		Ipisflag	= 'Y'
			Where		LogID	= :ll_logid
			Using		it_source;

			ll_error	= it_source.SQLCODE
			ls_error	= it_source.SQLErrText
			
			If ll_error = 0 Then
				Commit Using it_source ;
			Else
				Rollback Using it_source ;
			End If	

		Else
			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_yinv101temp : ' + ls_error,it_source)
			end if
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
	rs_return_option = 'S'
	Return True
End If
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
rt_destination.AutoCommit	= True

Connect Using rt_destination;

If rt_destination.sqlcode <> 0 then 
	Messagebox("Destination Connect Error", rt_destination.sqlerrtext)
	Return False
End If

If li_error = 0 Then
	Return True
Else
	Return False
End If

end function

public function boolean wf_upload_tpartkborder_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_misflag, ls_areacode, ls_divisioncode, ls_itemcode, ls_supplier
String	ls_partkbno, ls_orderseq, ls_deliverydate, ls_userid, ls_orderdate, ls_qty
Long		ll_logid
String	ls_lib, ls_pgm, ls_parm

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tpartkborder_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_misflag			= dw_2.GetItemString(i, 'MISFlag')
		ls_areacode			= dw_2.GetItemString(i, 'AreaCode')
		ls_divisioncode	= dw_2.GetItemString(i, 'DivisionCode')
		ls_supplier			= dw_2.GetItemString(i, 'SupplierCode')
		ls_itemcode			= Left(dw_2.GetItemString(i, 'ItemCode') + Space(10), 12)
		ls_partkbno			= dw_2.GetItemString(i, 'PartKBNo')
		ls_orderdate		= dw_2.GetItemString(i, 'PartOrderDate')
		ls_orderdate		= Left(ls_orderdate, 4) + Mid(ls_orderdate, 6, 2) + Right(ls_orderdate, 2)
		ls_qty				= Right(Fill('0', 10) + String(dw_2.GetItemNumber(i, 'RackQty')), 7) + Fill('0', 1)
		ls_orderseq			= dw_2.GetItemString(i, 'OrderSeq')
		ls_deliverydate	= dw_2.GetItemString(i, 'PartForecastDate')
		ls_deliverydate	= Left(ls_deliverydate, 4) + Mid(ls_deliverydate, 6, 2) + Right(ls_deliverydate, 2)
		ls_userid			= Left(dw_2.GetItemString(i, 'LastEmp') + Space(10), 6)
		
		// 매월말일일때 IPIS Server 시간을 체크해서 데이타 일자와 같을 경우에만 upload 한다.
		// 그러나, 월초(1일)일때는 08:00 이전까지는 서버 시간과 데이타 같더라도 upload 몬한다.
		If wf_check_server_date(ls_orderdate) Then

			ls_lib	= 'PBJIT'
			ls_pgm	= 'JIT5B30'
			// 발주정보 parmameter 
			// 구분(1)/지역(1)/공장(1)/업체전산번호(5)/
			// 품번(12)/간판번호(11)/발주일자(8)/발주량(7.1)/발주전산번호(10)/
			// 납기일(8)/사용자ID(6)
			
			ls_parm	= ls_misflag + ls_areacode + ls_divisioncode + ls_supplier + &
							ls_itemcode + ls_partkbno + ls_orderdate + ls_qty + ls_orderseq + &
							ls_deliverydate + ls_userid
			ls_parm	= String(ls_parm, '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
	//		// 데이타 upload procedure 호출
	//		DECLARE mis_sp_ipis procedure for DEJITO.JIT5B00SP :ls_lib, :ls_pgm, :ls_parm ;
	//		EXECUTE mis_sp_ipis;
	
			SQLCA.JIT5B00SP(ls_lib, ls_pgm, ls_parm)
	
	//		messagebox('Parm', ls_parm)
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
			
			If ll_error = 0 and Right(Trim(ls_parm), 1) = 'Y' Then
				Commit Using SQLCA ;
				dw_2.DeleteRow(i)
				uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
				
				Update	tpartkborder_interface
				Set		interfaceflag = 'N',
							lastdate	= getdate()
				Where		logid = :ll_logid
				Using		it_source;
				
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
				
				If ll_error = 0 Then
					Commit Using it_source ;
				Else
					Rollback Using it_source ;
				End If	
	
			Else
				RollBack Using SQLCA ;
				uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
				ll_error_cnt ++
				if ll_error < 0 then
					f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tpartkborder_interface : ' + ls_error,it_source)
				end if
			End If
		End If	// 서버 시간 체크 로직 end
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tpartrelease_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_gubun, ls_area, ls_division, ls_itemcode, ls_usedept, ls_usage, ls_releasedate
String	ls_invstatus, ls_tidno, ls_userid, ls_inputdate, ls_suppliercode, ls_projectno
Long		ll_logid
dec{1} 	ld_releaseqty

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tpartrelease_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_gubun 			= dw_2.GetItemString(i, 'Gubun')
		ls_area				= dw_2.GetItemString(i, 'AreaCode')
		ls_division			= dw_2.GetItemString(i, 'DivisionCode')
		ls_itemcode			= dw_2.GetItemString(i, 'ItemCode')
		ls_usedept			= dw_2.GetItemString(i, 'UseDept')
		ls_usage				= dw_2.GetItemString(i, 'Usage')
		ls_releasedate		= dw_2.GetItemString(i, 'ReleaseDate')
		ls_invstatus		= dw_2.GetItemString(i, 'InvStatus')
		ls_projectno		= dw_2.GetItemString(i, 'ProjectNo')
		if isnull(ls_projectno) then ls_projectno = ''
		ls_suppliercode	= dw_2.GetItemString(i, 'SupplierCode')
		if isnull(ls_suppliercode) then ls_suppliercode = ''
		ld_releaseqty		= dw_2.GetItemDecimal(i, 'ReleaseQty')
		ls_tidno				= dw_2.GetItemString(i, 'TidNo')
		ls_userid			= dw_2.GetItemString(i, 'LastEmp')
		ls_inputdate		= String(dw_2.GetItemDatetime(i, 'LastDate'), 'yyyymmdd')
		if isnull(ls_inputdate) then ls_inputdate = ''
		// 불출정보 update parmameter 
		// 구분(1)/지역(1)/공장(1)/품번(12)/사용부서(4)/불출용도(2)/불출일(8)/재고상태(1)/불출량(11,1)
		//			/Projectno(5)/업체번호(5)/Tidno(12)/사용자(6)
		
		ll_error = f_inv_out( ls_gubun, ls_area, ls_division, ls_itemcode, ls_usedept, ls_usage, &
				ls_releasedate, ls_invstatus, ld_releaseqty, ls_projectno, ls_suppliercode, &
				mid(ls_tidno,4,12), ls_userid, ls_inputdate, ls_error) 
		If ll_error = 0 Then
			Commit;
			dw_2.DeleteRow(i)
			uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
			
			Update	tpartrelease_interface
			Set		interfaceflag = 'N',
						lastdate	= getdate()
			Where		logid = :ll_logid
			Using		it_source;
			
			ll_error	= it_source.SQLCODE
			ls_error	= it_source.SQLErrText
			
			If ll_error = 0 Then
				Commit Using it_source ;
			Else
				Rollback Using it_source ;
			End If	

		Else
			RollBack;

			uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
			ll_error_cnt ++
			if ll_error < 0 then
				f_errorlog_yeoju('UPLOAD', ii_interface_id, ll_logid, ls_error,it_source)
			end if
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tstock_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_misflag, ls_areacode, ls_divisioncode, ls_itemcode, ls_workcenter, ls_kbno
String	ls_partkbno, ls_orderseq, ls_deliverydate, ls_userid, ls_orderdate, ls_qty
String	ls_stockdate, ls_seqno
Long		ll_logid
String	ls_lib, ls_pgm, ls_parm

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tstock_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_misflag			= dw_2.GetItemString(i, 'MISFlag')
		ls_areacode			= dw_2.GetItemString(i, 'AreaCode')
		ls_divisioncode	= dw_2.GetItemString(i, 'DivisionCode')
		ls_itemcode			= Left(dw_2.GetItemString(i, 'ItemCode') + Space(10), 12)
		ls_workcenter		= Left(dw_2.GetItemString(i, 'WorkCenter'), 4)
		ls_kbno				= dw_2.GetItemString(i, 'KBNo')
		ls_qty				= Right(Fill('0', 10) + String(dw_2.GetItemNumber(i, 'StockQty')), 7)
		ls_stockdate		= dw_2.GetItemString(i, 'StockDate')		// 입고일
		ls_stockdate		= Left(ls_stockdate, 4) + Mid(ls_stockdate, 6, 2) + Right(ls_stockdate, 2)		
		ls_orderdate		= dw_2.GetItemString(i, 'KBReleaseDate')	// 조립지시일
		ls_orderdate		= Left(ls_orderdate, 4) + Mid(ls_orderdate, 6, 2) + Right(ls_orderdate, 2)
		ls_seqno				= Left(String(dw_2.GetItemNumber(i, 'SeqNo')) + Space(10), 10)
		ls_userid			= Left(dw_2.GetItemString(i, 'LastEmp') + Space(10), 6)

		// 매월말일일때 IPIS Server 시간을 체크해서 데이타 일자와 같을 경우에만 upload 한다.
		// 그러나, 월초(1일)일때는 08:00 이전까지는 서버 시간과 데이타 같더라도 upload 몬한다.
		If wf_check_server_date(ls_stockdate) Then

			ls_lib	= 'PBJIT'
			ls_pgm	= 'JIT5B40'
			// 제품입고정보 parmameter 
			// 구분(1)/지역(1)/공장(1)/품번(12)/
			// 조립라인(4)/간판번호(11)/입고량(7.0)/입고일(8)/
			// 조립지시일(8)/등록순번(10)/사용자ID(6)
			ls_parm	= ls_misflag + ls_areacode + ls_divisioncode + ls_itemcode + &
							ls_workcenter + ls_kbno + ls_qty + ls_stockdate + &
							ls_orderdate + ls_seqno + ls_userid
			
	//		messagebox(ls_misflag,		len(ls_misflag))
	//		messagebox(ls_areacode,		len(ls_areacode))
	//		messagebox(ls_divisioncode,		len(ls_divisioncode))
	//		messagebox(ls_itemcode,		len(ls_itemcode))
	//		messagebox(ls_workcenter,		len(ls_workcenter))
	//		messagebox(ls_kbno,		len(ls_kbno))
	//		messagebox(ls_qty,		len(ls_qty))
	//		messagebox(ls_stockdate,		len(ls_stockdate))
	//		messagebox(ls_orderdate,		len(ls_orderdate))
	//		messagebox(ls_seqno,		len(ls_seqno))
	//		messagebox(ls_userid,		len(ls_userid))
	//
	
	//		// 데이타 upload procedure 호출
	//		DECLARE mis_sp_ipis procedure for dejito.jit5b00sp :ls_lib, :ls_pgm, :ls_parm;
	//		EXECUTE mis_sp_ipis;
	
			ls_parm = String(ls_parm, '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
			SQLCA.JIT5B00SP(ls_lib, ls_pgm, ls_parm)
			
	//		messagebox('Parm', ls_parm)
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText

			If ll_error = 0 and Right(Trim(ls_parm), 1) = 'Y' Then
				Commit Using SQLCA ;
				dw_2.DeleteRow(i)
				uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
				
				Update	tstock_interface
				Set		interfaceflag = 'N',
							lastdate	= getdate()
				Where		logid = :ll_logid
				Using		it_source;
				
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
				
				If ll_error = 0 Then
					Commit Using it_source ;
				Else
					Rollback Using it_source ;
				End If	
	
			Else
				RollBack Using SQLCA ;
				uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
				ll_error_cnt ++
				if ll_error <> 0 then
					f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_new.wf_upload_tstock_interface : ' + ls_error,it_source)
				end if
			End If
		End If	// 서버 시간 체크 로직 end
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tmcpartreturn (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_status, ls_areacode, ls_divisioncode, ls_itemcode, ls_slipno, ls_dept
String	ls_usage, ls_mcno, ls_returndate, ls_userid, ls_stockstatus, ls_qty
String	ls_stockdate, ls_seqno, ls_orderno, ls_serialno
Long		ll_logid
String	ls_lib, ls_pgm, ls_parm
Int		li_check
Decimal	ld_qty

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_status			= dw_2.GetItemString(i, 'DataStatus')		
		ls_areacode			= dw_2.GetItemString(i, 'AreaCode')
		ls_divisioncode	= dw_2.GetItemString(i, 'DivisionCode')		
		ls_itemcode			= Left(dw_2.GetItemString(i, 'ItemCode') + Space(20), 12)
		ls_slipno			= Left(dw_2.GetItemString(i, 'SlipNo') + Space(20), 12)		
		ls_orderno			= Left(dw_2.GetItemString(i, 'OrderNo') + Space(20), 16)		
		ls_dept				= Left(dw_2.GetItemString(i, 'DeptCode') + Space(10), 5)		
		If IsNull(ls_dept) Then
			ls_dept	= '     '
		End If
		ls_usage				= Left(dw_2.GetItemString(i, 'Usage') + Space(10), 2)		
		If IsNull(ls_usage) Then
			ls_usage	= '          '
		End If
		ls_mcno				= Left(dw_2.GetItemString(i, 'MCNo') + Space(10), 9)		
		If IsNull(ls_mcno) Then
			ls_mcno	= '          '
		End If		
		ls_returndate		= dw_2.GetItemString(i, 'ReturnDate')		
		ls_stockstatus		= dw_2.GetItemString(i, 'StockStatus')		
		ld_qty				= dw_2.GetItemNumber(i, 'ReturnQty')
		ls_qty				= string(ld_qty, "0000000.0")
		li_check				= Len(ls_qty)
		ls_qty				= Right(Left(ls_qty, li_check - 2), 7) + Right(ls_qty, 1)

		// 재고상태(U:사용가, R:수리품, S:폐품, X:부외)		
		If ls_stockstatus = 'U' Then
			ls_qty	= ls_qty + '00000000' + '00000000' + '00000000'
		ElseIf ls_stockstatus = 'R' Then
			ls_qty	= '00000000' + ls_qty + '00000000' + '00000000'
		ElseIf ls_stockstatus = 'S' Then
			ls_qty	= '00000000' + '00000000' + ls_qty + '00000000'
		Else
			ls_qty	= '00000000' + '00000000' + '00000000' + ls_qty
		End If	
		
		ls_serialno			= Left(dw_2.GetItemString(i, 'SerialNo')	+ Space(10), 10)	
		ls_userid			= Left(dw_2.GetItemString(i, 'LastEmp') + Space(10), 6)
		If IsNull(ls_userid) Then
			ls_userid	= '      '
		End If

		// 매월말일일때 IPIS Server 시간을 체크해서 데이타 일자와 같을 경우에만 upload 한다.
		// 그러나, 월초(1일)일때는 08:00 이전까지는 서버 시간과 데이타 같더라도 upload 몬한다.
		If wf_check_server_date(ls_returndate) Then

			ls_lib	= 'PBJIT'
			ls_pgm	= 'JIT5B34'
			// 공무자재 반납정보 parmameter 
			// 구분(1)/지역(1)/공장(1)/품번(12)/반납전표번호(12)/
			// 작업지시번호(16)/반납부서(5)/반납용도(2)/장비번호(9)/
			// 반납일자(8)/반납량(사용가)(7.1)/반납량(요수리)/반납량(폐품)/반납량(부외재고)/
			// 등록순번(10)/사용자ID(6)
			ls_parm	= ls_status + ls_areacode + ls_divisioncode + ls_itemcode + ls_slipno +&
							ls_orderno + ls_dept + ls_usage + ls_mcno + &
							ls_returndate + ls_qty + ls_serialno + ls_userid
	
			ls_parm = String(ls_parm, '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
			
	//		messagebox(ls_status,		len(ls_status))
	//		messagebox(ls_areacode,		len(ls_areacode))
	//		messagebox(ls_divisioncode,		len(ls_divisioncode))
	//		messagebox(ls_itemcode,		len(ls_itemcode))
	//		messagebox(ls_slipno,		len(ls_slipno))
	//		messagebox(ls_orderno,		len(ls_orderno))
	//		messagebox(ls_dept,		len(ls_dept))
	//		messagebox(ls_usage,		len(ls_usage))
	//		messagebox(ls_mcno,		len(ls_mcno))
	//		messagebox(ls_returndate,		len(ls_returndate))
	//		messagebox(ls_qty,		len(ls_qty))
	//		messagebox(ls_serialno,		len(ls_serialno))
	//		messagebox(ls_userid,		len(ls_userid))
			
			
	//		// 데이타 upload procedure 호출
	//		DECLARE mis_sp_ipis procedure for dejito.jit5b00sp :ls_lib, :ls_pgm, :ls_parm;
	//		EXECUTE mis_sp_ipis;
			
			SQLCA.JIT5B00SP(ls_lib, ls_pgm, ls_parm)
			
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
			
	//		messagebox(Sqlca.Sqlerrtext, ls_parm)
			If ll_error = 0 and Right(Trim(ls_parm), 1) = 'Y' Then
				Commit Using SQLCA ;
				dw_2.DeleteRow(i)
				uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
				
				Update	tmcpartreturn
				Set		uploadflag = 'Y',
							lastdate	= getdate()
				Where		logid = :ll_logid
				Using		it_source;
				
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
				
				If ll_error = 0 Then
					Commit Using it_source ;
				Else
					Rollback Using it_source ;
				End If	
	
			Else
				RollBack Using SQLCA ;
				uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
				ll_error_cnt ++
				if ll_error < 0 then
					f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tmcpartreturn : ' + ls_error,it_source)
				end if
			End If
		End If	// 서버 시간 체크 로직 end
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
	rs_return_option = 'S'
	Return True
End If
end function

public function boolean wf_upload_tpartkbincome_interface (string fs_dataobject, ref string rs_return_option);Int		li_return
Long		i, ll_start_time, ll_end_time, ll_rowcount, ll_error_cnt = 1, ll_error
Long		ll_pymd, ll_sysdat, ll_systim, ll_incsdt
String	ls_error, ls_today
String	ls_misflag, ls_receiptdate, ls_incomedate, ls_costgubun, ls_usecenter, ls_deliveryno
String	ls_orderseq, ls_userid, ls_orderdate, ls_qty
Long		ll_logid
String	ls_lib, ls_pgm, ls_parm

// rs_return_option
// 'S' : Success 성공
// 'C' : Stop, 중지
// 'F' : Fail, 일부 Error 발생
// 'E' : Error, Interface 불가 Error

// Return True		: 끝까지 수행
// Return False	: 중간에서 Return

wf_upload_sp('sp_pisi_u_tpartkbincome_interface')

ls_today = String(Today(), 'yyyymmdd')

dw_2.DataObject	= fs_dataobject
dw_2.SetTransObject(it_source)

rs_return_option	= 'S'
ll_start_time		= Cpu ()

dw_2.SetRedraw(False)
ll_rowcount				= dw_2.Retrieve()

uo_pipe.st_read.Text		= String(ll_rowcount, "#,##0")
uo_pipe.st_written.Text	= '0'

If ll_rowcount > 0 Then
	dw_2.ScrollToRow(ll_rowcount)
	dw_2.SetRedraw(True)

	// RecStatus이 
	// A or I : insert
	// R : update
	// D : delete -> data space로 변경
	
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
		
		ll_logid				= dw_2.GetItemNumber(i, 'LogID')
		ls_misflag			= dw_2.GetItemString(i, 'MISFlag')
		ls_orderseq			= dw_2.GetItemString(i, 'OrderSeq')
		ls_receiptdate		= dw_2.GetItemString(i, 'PartReceiptDate')	// 납품일
		ls_receiptdate		= Left(ls_receiptdate, 4) + Mid(ls_receiptdate, 6, 2) + Right(ls_receiptdate, 2)
		ls_incomedate		= dw_2.GetItemString(i, 'PartIncomeDate')		// 입고일
		ls_incomedate		= Left(ls_incomedate, 4) + Mid(ls_incomedate, 6, 2) + Right(ls_incomedate, 2)
		ls_costgubun		= dw_2.GetItemString(i, 'CostGubun')	 
		If ls_costgubun = 'Y' Then		// 유상 - 07, 무상 -04	-> 권과장한테 확인!
			ls_costgubun = '07'
		ElseIf ls_costgubun = 'N' Then
			ls_costgubun = '04'
		Else
			ls_costgubun = '01'
		End If
		
		ls_usecenter = dw_2.GetItemString(i, 'UseCenter')
		If isnull(ls_usecenter) then ls_usecenter = ''
		ls_usecenter		= Left(ls_usecenter + Space(10), 5)
		
		ls_deliveryno = dw_2.GetItemString(i, 'DeliveryNo')
		if isnull(ls_deliveryno) then ls_deliveryno = ''
		ls_deliveryno		= Left(ls_deliveryno + Space(20), 12)
		
		ls_userid = dw_2.GetItemString(i, 'LastEmp')
		if isnull(ls_userid) then ls_userid = ''
		ls_userid			= Left(ls_userid + Space(10), 6)

		// 매월말일일때 IPIS Server 시간을 체크해서 데이타 일자와 같을 경우에만 upload 한다.
		// 그러나, 월초(1일)일때는 08:00 이전까지는 서버 시간과 데이타 같더라도 upload 몬한다.
		If wf_check_server_date(ls_incomedate) Then

			ls_lib	= 'PBJIT'
			ls_pgm	= 'JIT5B32'
			// 자재입고정보 parmameter 
			// 구분(1)/발주전산번호(10)/납품일(8)/
			// 입고일(8)/유무상구분(2)/사용처(5)/사용자ID(6)
			ls_parm	= ls_misflag + ls_orderseq + ls_receiptdate + &
							ls_incomedate + ls_costgubun + ls_usecenter + ls_deliveryno + ls_userid
	
			ls_parm	= String(ls_parm, '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
			SQLCA.JIT5B00SP(ls_lib, ls_pgm, ls_parm)
							
	//		// 데이타 upload procedure 호출
	//		DECLARE mis_sp_ipis procedure for DEJITO.JIT5B00SP :ls_lib, :ls_pgm, :ls_parm;
	//		EXECUTE mis_sp_ipis;
	
			ll_error	= SQLCA.SQLCODE
			ls_error	= SQLCA.SQLErrText
	//		messagebox('확인', ls_parm)
			If ll_error = 0 and Right(Trim(ls_parm), 1) = 'Y' Then
				Commit Using SQLCA ;
				dw_2.DeleteRow(i)
				uo_pipe.st_written.Text	= String(Long(uo_pipe.st_written.Text) + 1, "#,##0")
				
				Update	tpartkbincome_interface
				Set		interfaceflag = 'N',
							lastdate	= getdate()
				Where		logid = :ll_logid
				Using		it_source;
				
				ll_error	= it_source.SQLCODE
				ls_error	= it_source.SQLErrText
				
				If ll_error = 0 Then
					Commit Using it_source ;
				Else
					Rollback Using it_source ;
				End If	
	
			Else
				RollBack Using SQLCA ;
				uo_pipe.st_error.Text	= String(ll_error_cnt, "#,##0")
				ll_error_cnt ++
				if ll_error < 0 then
					f_errorlog_insert('UPLOAD', ii_error_num, 'Error Code('+ string(ll_error) + ') - w_interface_upload.wf_upload_tpartkbincome_interface : ' + ls_error,it_source)
				end if
			End If
		End If	// 서버 시간 체크 로직 end
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
	rs_return_option = 'S'
	Return True
End If
end function

on w_interface_upload.create
this.ddlb_1=create ddlb_1
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
this.Control[]={this.ddlb_1,&
this.dw_2,&
this.dw_1,&
this.dw_interface,&
this.st_horizontal,&
this.uo_option,&
this.uo_pipe,&
this.uo_button,&
this.st_vertical,&
this.uo_parameter,&
this.st_date,&
this.uo_date}
end on

on w_interface_upload.destroy
destroy(this.ddlb_1)
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
end on

event closequery;UnsignedLong ul_handle

ul_handle = it_source.DBHandle()

If IsNull(ul_handle) Or ul_handle < 0 Then
	Connect Using it_source;
End If

Update MSTFLAG
	Set Flag = 'N'
 Where ActionName like 'UPLOAD%'
 Using it_source;
 
 Commit Using it_source ;

wf_disconnect()
end event

event open;il_hidden_color = BackColor
st_horizontal.BackColor	= il_hidden_color
st_vertical.BackColor	= il_hidden_color

wf_dw_init(3)

wf_connect(gs_ini_file, 'IPIS', 'MIS', it_source, it_destination)

//Update MSTFLAG
//	Set Flag = 'N'
// Where ActionName like 'UPLOAD%'
// Using it_source;

ddlb_1.text = 'Second'
is_cycle = 'SS'

dw_interface.SetTransObject(it_source)
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

li_option_h	= uo_option.Height
uo_option.Resize(li_uo_w, li_option_h)
uo_option.Move(li_uo_x, li_button_h + (2 * ii_window_border))
uo_option.Post Event Resize(sizetype, li_uo_w, li_option_h)

ddlb_1.Move(dw_interface.x + dw_interface.width + 1700, ddlb_1.y)

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

event timer;
If ib_interface = False Then
	wf_auto_upload()
End If	
end event

type ddlb_1 from dropdownlistbox within w_interface_upload
integer x = 2939
integer y = 20
integer width = 480
integer height = 300
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
string text = "none"
boolean sorted = false
string item[] = {"Second","Minute","Hour","Day"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
If index = 1 Then
	is_cycle = 'SS'
ElseIf index = 2 Then
	is_cycle = 'MI'
ElseIf index = 3 Then
	is_cycle = 'HH'
ElseIf index = 4 Then
	is_cycle = 'DD'
End If	

end event

type dw_2 from datawindow within w_interface_upload
integer x = 1979
integer y = 1072
integer width = 1097
integer height = 404
integer taborder = 60
string dataobject = "d_description"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(currentrow, True)
End If
end event

type dw_1 from datawindow within w_interface_upload
integer x = 1257
integer y = 1072
integer width = 699
integer height = 404
integer taborder = 50
string dataobject = "d_description"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(currentrow, True)
End If
end event

type dw_interface from datawindow within w_interface_upload
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

CHOOSE CASE uo_parameter.Event Trigger ue_retrieve(ii_interface_id, rowcount, it_source)
	CASE 'Y', 'N'
		Return 0
	CASE 'C', 'F'
		Return 1
END CHOOSE
	
	
end event

type st_horizontal from u_st_horizontal within w_interface_upload
integer x = 3319
integer y = 64
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

type uo_option from u_interface_option within w_interface_upload
integer x = 1243
integer y = 120
integer taborder = 40
boolean border = false
long backcolor = 79741120
end type

on uo_option.destroy
call u_interface_option::destroy
end on

event ue_button_click;call super::ue_button_click;boolean lb_rtn
ib_auto	= ab_auto

If ib_auto Then
	lb_rtn = wf_auto_upload()

	If is_cycle = 'SS' Then
		Timer(60)
	ElseIf is_cycle = 'MI' Then
		Timer(120)
	ElseIf is_cycle = 'HH' Then   //매 10분마다 확인하고 08시에서 20시까지 수행
		Timer(600)
	ElseIf is_cycle = 'DD' Then	//매 10분마다 확인하고 18시에 수행
		Timer(600)
	End If			
Else
	Timer(0)
End If	

end event

type uo_pipe from u_interface_error within w_interface_upload
integer x = 1253
integer y = 828
integer taborder = 80
boolean border = false
end type

on uo_pipe.destroy
call u_interface_error::destroy
end on

event ue_cancel;call super::ue_cancel;ib_upload_stop = True
end event

type uo_button from u_interface_button within w_interface_upload
integer x = 1243
integer y = 4
integer taborder = 30
boolean border = false
long backcolor = 79741120
end type

on uo_button.destroy
call u_interface_button::destroy
end on

event ue_click_start;call super::ue_click_start;If ib_auto Then		// 전체 Interface 항목에 대해서 Interface 수행
	Timer(120)
Else
	// 선택된 Interface 항목에 대해서 Interface 수행
	If ii_interface_id > 0 Then
		ib_interface = True
		uo_pipe.cb_repair.Enabled	= False
		uo_pipe.cb_cancel.Enabled	= True
		uf_button_enable(False, False, False)
		uo_parameter.Enabled	= False
		dw_interface.Enabled	= False
		uo_option.Enabled		= False
		uo_date.Enabled		= False
		
		If is_interface_gubun = 'U' Then			// DownLoad
			If wf_upload() Then
				wf_dw_init(2)
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

type st_vertical from u_st_vertical within w_interface_upload
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

type uo_parameter from u_parameter_set within w_interface_upload
integer x = 1253
integer y = 256
integer taborder = 20
boolean border = false
long backcolor = 79741120
end type

on uo_parameter.destroy
call u_parameter_set::destroy
end on

type st_date from statictext within w_interface_upload
integer x = 2158
integer y = 1000
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

type uo_date from u_today within w_interface_upload
integer x = 2633
integer y = 984
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

