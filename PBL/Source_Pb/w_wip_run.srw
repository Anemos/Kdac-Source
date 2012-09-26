$PBExportHeader$w_wip_run.srw
$PBExportComments$Interface main
forward
global type w_wip_run from window
end type
type cb_option_post from commandbutton within w_wip_run
end type
type cb_down from commandbutton within w_wip_run
end type
type cbx_check from checkbox within w_wip_run
end type
type uo_parameter from u_parameter_wip within w_wip_run
end type
type dw_2 from datawindow within w_wip_run
end type
type dw_1 from datawindow within w_wip_run
end type
type dw_interface from datawindow within w_wip_run
end type
type st_horizontal from u_st_horizontal within w_wip_run
end type
type uo_option from u_interface_option within w_wip_run
end type
type uo_pipe from u_interface_error within w_wip_run
end type
type uo_button from u_interface_button within w_wip_run
end type
type st_vertical from u_st_vertical within w_wip_run
end type
type st_date from statictext within w_wip_run
end type
type uo_date from u_today within w_wip_run
end type
type ddlb_1 from dropdownlistbox within w_wip_run
end type
end forward

global type w_wip_run from window
integer width = 3909
integer height = 1592
boolean titlebar = true
string title = "wip_execute"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event ue_postopen pbm_custom01
cb_option_post cb_option_post
cb_down cb_down
cbx_check cbx_check
uo_parameter uo_parameter
dw_2 dw_2
dw_1 dw_1
dw_interface dw_interface
st_horizontal st_horizontal
uo_option uo_option
uo_pipe uo_pipe
uo_button uo_button
st_vertical st_vertical
st_date st_date
uo_date uo_date
ddlb_1 ddlb_1
end type
global w_wip_run w_wip_run

type variables
int ii_error_num = 9300
int ii_window_border = 15
long il_hidden_color
int ii_first_y, ii_first_parameter_y, ii_first_pipe_y
boolean ib_max, ib_min, ib_open, ib_auto

int ii_interface_id
string is_wip_plant, is_wip_gubun, is_wip_id, is_wip_desc

Transaction it_source, it_destination

string is_action_name, is_interface_gubun
string is_applydate, is_yyyymmdd
long ii_yyyymmdd

boolean ib_upload_stop = False

string	is_sp_name
boolean	ib_cancel = False, ib_interface = False

string	is_cycle, is_currentdate, is_currenttime
end variables

forward prototypes
public subroutine wf_upload_stop ()
public subroutine wf_dw_init (integer fs_option)
public subroutine wf_resize_bar ()
public function boolean wf_raiserror (string fs_pipeline_name)
public subroutine wf_disconnect ()
public subroutine wf_download_stop ()
public function boolean wf_qtymodify (string ag_plant, string ag_dvsn)
public subroutine wf_resize_panel (integer fi_win_w, integer fi_win_h, integer fi_vertical_x)
public subroutine wf_resize_horizontal ()
public function boolean wf_cross_pre (string ag_plant, string ag_dvsn)
public function boolean wf_option_pre (string ag_plant, string ag_dvsn)
public function boolean wf_cross_post_update (datawindow arg_dw)
public function boolean wf_cross_pre_update (datawindow arg_dw)
public function boolean wf_get_prejob ()
public subroutine wf_flag_update ()
public subroutine wf_quater_qtycheck (string arg_year, string arg_month)
public function boolean wf_cross_post (string ag_plant, string ag_dvsn)
public function string wf_get_host_datetime ()
public function boolean wf_inout_pre (string ag_plant, string ag_dvsn)
public function boolean wf_wiprun ()
public function boolean wf_auto_download ()
public function boolean wf_average_post (string ag_plant, string ag_dvsn)
public function boolean wf_connect (string fs_ini_file, string fs_source, string fs_destination, ref transaction rt_source, ref transaction rt_destination)
public function boolean wf_connect_check (ref transaction rt_source, ref transaction rt_destination)
public function boolean wf_transfer (string ag_plant, string ag_dvsn)
public function boolean wf_inout_post (string ag_plant, string ag_dvsn)
public function integer wf_create_wip014 (string ag_plant, string ag_dvsn, string ag_applydate)
end prototypes

event ue_postopen;ib_open = True

If IsValid(w_select_inifile) Then
	Close(w_select_inifile)
End If

dw_1.settransobject(sqlca)
// Horizontal Resize의 한계값을 설정한다.
// st_vertical의 Y 값이 아래 두값의 사이값일 경우에만 Resize  수행
ii_first_parameter_y = uo_parameter.Y + (uo_parameter.Height / 2)
ii_first_pipe_y		= uo_pipe.Y + (uo_pipe.Height / 2)
ddlb_1.text = '이월전마감'
is_cycle = 'PRE'
cbx_check.checked = True

wf_connect(gs_ini_file, 'MIS', 'IPIS', it_source, it_destination)
g_s_datetime = wf_get_host_datetime()

end event

public subroutine wf_upload_stop ();
end subroutine

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

public function boolean wf_raiserror (string fs_pipeline_name);// BOX 포장, 제조조건, 거래처 변경 Column 확인 후 처리할것 2000.03.31

String ls_mysql, ls_error

//CHOOSE CASE Upper(fs_pipeline_name)
//	CASE 'P_ITEM_MASTER'
//		ls_mysql = 'RAISERROR (50001, 10, 1)'
//	CASE 'P_BOXPACK_MASTER'
//		ls_mysql = 'RAISERROR (50002, 10, 1)'
//	CASE 'P_EMP_MASTER'
//		ls_mysql = 'RAISERROR (50003, 10, 1)'
//	CASE 'P_BOM_MASTER'
//		ls_mysql = 'RAISERROR (50004, 10, 1)'
//	CASE 'P_CUSTOMER_MASTER'
//		ls_mysql = 'RAISERROR (50005, 10, 1)'
//	CASE 'P_PRDCONDITION_MASTER'
//		ls_mysql = 'RAISERROR (50006, 10, 1)'
//END CHOOSE
//
//If Len(ls_mysql) > 0 Then
//	EXECUTE IMMEDIATE :ls_mysql ;
//End If
//
//CHOOSE CASE Upper(fs_pipeline_name)
//	CASE 'P_ITEM_MASTER'
//		UPDATE AMFLIB.ITEMAST  
//			SET CHPRS = ' '  
//		 WHERE AMFLIB.ITEMAST.ITEMS = 'CE'
//			AND AMFLIB.ITEMAST.CHPRS = 'Y'
//		Using it_source;
//		
//		ls_error = it_source.sqlerrtext
//		
//		If it_source.sqlcode = 0 Then
//			Commit Using it_source;
//			Return True
//		Else
//			RollBack Using it_source;
//			MessageBox("AS-400 Error", "Item Master 변경 중 오류가 발생하였습니다.~r~n" + ls_error, StopSign!)
//			Return False
//		End If
//	CASE 'P_BOM_MASTER'
//		UPDATE IMSLIB.MASBOMF
//			SET LOWCH = ' '  
//		 WHERE IMSLIB.MASBOMF.LOWCH = 'Y'
//		Using it_source;
//		
//		ls_error = it_source.sqlerrtext
//		
//		If it_source.sqlcode = 0 Then
//			Commit Using it_source;
//			Return True
//		Else
//			RollBack Using it_source;
//			MessageBox("AS-400 Error", "BOM Master 변경 중 오류가 발생하였습니다.~r~n" + ls_error, StopSign!)
//			Return False
//		End If
//	CASE 'P_EMP_MASTER'
//		UPDATE DHPDBF.HP13PF00
//			SET REMARK = ' '  
//		 WHERE DHPDBF.HP13PF00.REMARK = 'Y'
//		Using it_source;
//		
//		ls_error = it_source.sqlerrtext
//		
//		If it_source.sqlcode = 0 Then
//			Commit Using it_source;
//			Return True
//		Else
//			RollBack Using it_source;
//			MessageBox("AS-400 Error", "사원 Master 변경 중 오류가 발생하였습니다.~r~n" + ls_error, StopSign!)
//			Return False
//		End If
//	CASE 'P_PIPE_TEST'
//		UPDATE MSTFLAG
//			SET FLAG = 'N'
//		 Where ActionName = 'INTERFACE_TEST';
//		If SQLCA.SQLCODE = 0 Then
//			Return True
//		Else
//			Return False
//		End If
//END CHOOSE

Return True
end function

public subroutine wf_disconnect ();If IsValid(it_source) Then
	Disconnect using it_source;
End If

If IsValid(it_destination) Then
	Disconnect using it_destination;
End If

If IsValid(it_source) Then
	Destroy	it_source
End If

If IsValid(it_destination) Then
	Destroy	it_destination
End If
end subroutine

public subroutine wf_download_stop ();String ls_pipeline_name

//If IsValid(ip_pipe) Then
//	If ip_pipe.Cancel() = 1 Then
//		Select PipeLineName
//		  Into :ls_pipeline_name
//		  From tINTERFACE
//		 Where InterfaceID = :ii_interface_id ;
//		If Integer(uo_pipe.st_read.Text) > 0 Then
//			wf_raiserror(ls_pipeline_name)
//		ELse
//			wf_flag_update(is_action_name)
//		End If
//	End If
//End If
end subroutine

public function boolean wf_qtymodify (string ag_plant, string ag_dvsn);// 재공 사용량수정

return true
end function

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

dw_1.Resize(li_uo_w , li_pipe_h - uo_pipe.Height - (2 * ii_window_border))
dw_1.Move(li_uo_x, uo_pipe.Y + uo_pipe.Height)

dw_2.Resize(li_uo_w , li_pipe_h - uo_pipe.Height - (2 * ii_window_border))
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

public function boolean wf_cross_pre (string ag_plant, string ag_dvsn);// 이월전 크로스체크 로직
string ls_fromdt, ls_todt

ls_fromdt = is_applydate + '01'
ls_todt = f_relativedate( uf_wip_addmonth(is_applydate,1) + '01', -1)

If ag_dvsn = 'ALL' Then
	If Not f_wip_cross_check01('01',ls_fromdt,ls_todt,dw_2) Then
		Return False
	End If
Else
	If Not f_wip_cross_check('01',ag_plant,mid(ag_dvsn,4,1),ls_fromdt,ls_todt,dw_2) Then
		Return False
	End If
End If

// Error Update
If Not wf_cross_pre_update(dw_2) Then
	Return False
End If

Return True
end function

public function boolean wf_option_pre (string ag_plant, string ag_dvsn);//-- 이월전 옵션 체크

f_wip_option_summary('01',ag_plant,ag_dvsn,is_applydate,dw_2)

// Error Update
dw_2.accepttext()
f_wip_null_chk(dw_2)
f_wip_inptid(dw_2)
If dw_2.Update() = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean wf_cross_post_update (datawindow arg_dw);// 이월후 크로스체크 에러 업데이트
integer li_cntx, li_rowcnt, li_chk
string ls_errorcd, ls_cmcd, ls_srty, ls_srno, ls_srno1, ls_srno2, ls_plant, ls_dvsn, ls_xuse, ls_rtngubun
string ls_slno, ls_itno, ls_usge, ls_vsrno, ls_date, ls_date2, ls_adjdate, ls_srce, ls_cls, ls_nextdt
dec{4} lc_qty, lc_qty2
decimal{4} l_n_wdchqt,l_n_wausqt1,l_n_wausqt2,l_n_wausqt3,l_n_wausqt4,l_n_wausqt5,l_n_wausqt6,l_n_wausqt7,&
			  l_n_wausqt8,l_n_wausqta,l_n_chkqty
decimal{5} l_n_waavrg1,l_n_waavrg2,l_n_costav
decimal{0} l_n_wausat1,l_n_wausat2,l_n_wausat3,l_n_wausat4,&
           l_n_wausat5,l_n_wausat6,l_n_wausat7,l_n_wausat8,l_n_wausata
string ls_wdslty, ls_wdsrno

ls_adjdate = is_applydate
ls_nextdt = uf_wip_addmonth(ls_adjdate,1)

arg_dw.accepttext()
li_rowcnt = arg_dw.rowcount()

for li_cntx = 1 to li_rowcnt
	ls_errorcd = arg_dw.getitemstring(li_cntx,"errorcode")
	choose case ls_errorcd
		case '1'     //Child Not Found
			ls_cmcd = arg_dw.getitemstring(li_cntx,"inv401_comltd")
			ls_srty = arg_dw.getitemstring(li_cntx,"inv401_sliptype")
			ls_srno = arg_dw.getitemstring(li_cntx,"inv401_srno")
			ls_srno1 = arg_dw.getitemstring(li_cntx,"inv401_srno1")
			ls_srno2 = arg_dw.getitemstring(li_cntx,"inv401_srno2")
			ls_plant = arg_dw.getitemstring(li_cntx,"inv401_xplant")
			ls_dvsn = arg_dw.getitemstring(li_cntx,"inv401_div")
			
			SELECT COUNT(*) INTO :li_chk
				FROM PBWIP.WIP004
				WHERE WDCMCD = :ls_cmcd AND WDPRSRTY = :ls_srty AND WDPRSRNO = :ls_srno AND
						WDPRSRNO1 = :ls_srno1 AND WDPRSRNO2 = :ls_srno2
				using sqlca;
			
			if li_chk > 0 then
				continue
			end if
			ls_slno = arg_dw.getitemstring(li_cntx,"inv401_slno")
			ls_cls = arg_dw.getitemstring(li_cntx,"inv401_cls")
			ls_srce = arg_dw.getitemstring(li_cntx,"inv401_srce")
			ls_itno = trim(arg_dw.getitemstring(li_cntx,"inv401_itno"))
			ls_usge = arg_dw.getitemstring(li_cntx,"inv401_xuse")
			ls_rtngubun = arg_dw.getitemstring(li_cntx,"inv401_rtngub")
			ls_date = arg_dw.getitemstring(li_cntx,"inv401_tdte4")
			lc_qty = arg_dw.getitemdecimal(li_cntx,"inv401_tqty4")
			if (ls_srty = 'RP') OR (ls_srty = 'SS' AND ls_srce = '04') then
				ls_vsrno = trim(arg_dw.getitemstring(li_cntx,"inv401_vsrno"))
				if mid(ls_vsrno,1,1) <> 'D' then
					continue
				end if
				// BOM001 CHECK (LOGIC ADD 2003.04.19)
				select count(*) into :li_chk from pbpdm.bom001
					where pcmcd = :ls_cmcd AND plant = :ls_plant AND
							pdvsn = :ls_dvsn AND ppitn = :ls_itno AND
							(( pedte = ' '  and pedtm <= :ls_date ) or
							( pedte <> ' ' and pedtm <= :ls_date and pedte >= :ls_date ))
					using sqlca;
				if li_chk < 1 then
					//messagebox("BOM ERROR","해당날짜에 BOM미적용 품번 : " + ls_itno)
					continue
				end if
				// END
				DECLARE up_wip_11 PROCEDURE FOR PBWIP.SP_WIP_11  
					A_COMLTD = :ls_cmcd,   
					A_PRSRTY = :ls_srty,   
					A_PRSRNO = :ls_srno,   
					A_PRSRNO1 = :ls_srno1,   
					A_PRSRNO2 = :ls_srno2,   
					A_IPADDR = ' ',   
					A_MACADDR = ' ',   
					A_INPTID = ' ',   
					A_INPTDT = :is_currentdate,   
					A_INPTTM = :g_s_datetime,   
					A_ADJDT = :ls_adjdate,   
					A_NEXTDT = :ls_nextdt  using sqlca;

				execute up_wip_11;
			elseif (ls_srty = 'RM' or ls_srty = 'SM' or ls_srty = 'IS' or ls_srty = 'RS') then
				if ls_srty = 'IS' or ls_srty = 'RS' then
					ls_vsrno = trim(arg_dw.getitemstring(li_cntx,"inv401_vsrno"))
					if mid(ls_vsrno,1,1) <> 'D' then
						continue
					end if
				else
					ls_vsrno = trim(arg_dw.getitemstring(li_cntx,"inv401_dept"))
				end if
				if ls_cls = '30' or ls_srce = '03' then
					//pass
				else
					continue
				end if
				// BOM001 CHECK (LOGIC ADD 2003.04.19)
				select count(*) into :li_chk from pbpdm.bom001
					where pcmcd = :ls_cmcd AND plant = :ls_plant AND
							pdvsn = :ls_dvsn AND ppitn = :ls_itno AND
							(( pedte = ' '  and pedtm <= :ls_date ) or
							( pedte <> ' ' and pedtm <= :ls_date and pedte >= :ls_date ))
					using sqlca;
				if li_chk < 1 then
					//messagebox("BOM ERROR","해당날짜에 BOM미적용 품번 : " + ls_itno)
					continue
				end if
				// END
				DECLARE up_wip_10 PROCEDURE FOR PBWIP.SP_WIP_10  
					A_COMLTD = :ls_cmcd,   
					A_PRSRTY = :ls_srty,   
					A_PRSRNO = :ls_srno,   
					A_PRSRNO1 = :ls_srno1,   
					A_PRSRNO2 = :ls_srno2,   
					A_IPADDR = ' ',   
					A_MACADDR = ' ',   
					A_INPTID = ' ',   
					A_INPTDT = :is_currentdate,   
					A_INPTTM = :g_s_datetime,   
					A_ADJDT = :ls_adjdate,   
					A_NEXTDT = :ls_nextdt  using sqlca;
			
				execute up_wip_10;
			end if		
		case '2'		 //Parent Not Found => 재공트랜스 레코드 삭제
			ls_cmcd = arg_dw.getitemstring(li_cntx,"inv401_comltd")
			ls_srty = arg_dw.getitemstring(li_cntx,"inv401_sliptype")
			ls_srno = arg_dw.getitemstring(li_cntx,"inv401_srno")
			ls_srno1 = arg_dw.getitemstring(li_cntx,"inv401_srno1")
			ls_srno2 = arg_dw.getitemstring(li_cntx,"inv401_srno2")
			ls_plant = arg_dw.getitemstring(li_cntx,"inv401_xplant")
			ls_dvsn = arg_dw.getitemstring(li_cntx,"inv401_div")
			ls_date = arg_dw.getitemstring(li_cntx,"inv401_tdte4")
			
			//재공트랜스 삭제
			 DECLARE up_wip_12 PROCEDURE FOR PBWIP.SP_WIP_12  
				A_COMLTD = :ls_cmcd,   
				A_PRSRTY = :ls_srty,   
				A_PRSRNO = :ls_srno,   
				A_PRSRNO1 = :ls_srno1,   
				A_PRSRNO2 = :ls_srno2,   
				A_ADJDT = :ls_adjdate,   
				A_NEXTDT = :ls_nextdt  using sqlca;
			execute up_wip_12;
			
		case '3'		 //Date, QTY Error
			ls_cmcd = arg_dw.getitemstring(li_cntx,"inv401_comltd")
			ls_srty = arg_dw.getitemstring(li_cntx,"inv401_sliptype")
			ls_srno = arg_dw.getitemstring(li_cntx,"inv401_srno")
			ls_srno1 = arg_dw.getitemstring(li_cntx,"inv401_srno1")
			ls_srno2 = arg_dw.getitemstring(li_cntx,"inv401_srno2")
			ls_plant = arg_dw.getitemstring(li_cntx,"inv401_xplant")
			ls_dvsn = arg_dw.getitemstring(li_cntx,"inv401_div")
			ls_slno = arg_dw.getitemstring(li_cntx,"inv401_slno")
			ls_itno = trim(arg_dw.getitemstring(li_cntx,"inv401_itno"))
			ls_usge = arg_dw.getitemstring(li_cntx,"inv401_xuse")
			ls_rtngubun = arg_dw.getitemstring(li_cntx,"inv401_rtngub")
			ls_date = arg_dw.getitemstring(li_cntx,"inv401_tdte4")
			ls_date2 = arg_dw.getitemstring(li_cntx,"chgdate")     //변경전 날짜
			lc_qty = arg_dw.getitemdecimal(li_cntx,"inv401_tqty4")
			lc_qty2 = arg_dw.getitemdecimal(li_cntx,"chgqty")     //변경전 수량
			ls_vsrno = trim(arg_dw.getitemstring(li_cntx,"inv401_vsrno"))
			if f_wip_use_replace02(ls_cmcd, ls_srty, ls_srno, ls_srno1, ls_srno2, ls_plant, ls_dvsn , &
					ls_slno, ls_itno, ls_usge, ls_rtngubun, ls_vsrno, ls_date2, ls_date, lc_qty2, lc_qty, ls_adjdate) = 'N' then
				messagebox("에러", ls_date + " 일자 : " + ls_itno + "QTY, DATE 수정 에러")
			end if		
	end choose
next

return true
end function

public function boolean wf_cross_pre_update (datawindow arg_dw);integer li_cntx, li_rowcnt, li_chk
string ls_errorcd, ls_cmcd, ls_srty, ls_srno, ls_srno1, ls_srno2, ls_plant, ls_dvsn, ls_xuse, ls_rtngubun
string ls_slno, ls_itno, ls_usge, ls_vsrno, ls_date, ls_date2, ls_cls, ls_srce
dec{4} lc_qty, lc_qty2
string ls_wdslty, ls_wdsrno
arg_dw.accepttext()
li_rowcnt = arg_dw.rowcount()

for li_cntx = 1 to li_rowcnt
	ls_errorcd = arg_dw.getitemstring(li_cntx,"errorcode")
	choose case ls_errorcd
		case '1'     //Child Not Found
			ls_cmcd = arg_dw.getitemstring(li_cntx,"inv401_comltd")
			ls_srty = arg_dw.getitemstring(li_cntx,"inv401_sliptype")
			ls_srno = arg_dw.getitemstring(li_cntx,"inv401_srno")
			ls_srno1 = arg_dw.getitemstring(li_cntx,"inv401_srno1")
			ls_srno2 = arg_dw.getitemstring(li_cntx,"inv401_srno2")
			ls_plant = arg_dw.getitemstring(li_cntx,"inv401_xplant")
			ls_dvsn = arg_dw.getitemstring(li_cntx,"inv401_div")
			
			SELECT COUNT(*) INTO :li_chk
				FROM PBWIP.WIP004
				WHERE WDCMCD = :ls_cmcd AND WDPRSRTY = :ls_srty AND WDPRSRNO = :ls_srno AND
						WDPRSRNO1 = :ls_srno1 AND WDPRSRNO2 = :ls_srno2
				using sqlca;
			
			if li_chk > 0 then
				continue
			end if
			ls_cls = arg_dw.getitemstring(li_cntx,"inv401_cls")
			ls_srce = arg_dw.getitemstring(li_cntx,"inv401_srce")
			ls_slno = arg_dw.getitemstring(li_cntx,"inv401_slno")
			ls_itno = trim(arg_dw.getitemstring(li_cntx,"inv401_itno"))
			ls_usge = arg_dw.getitemstring(li_cntx,"inv401_xuse")
			ls_rtngubun = arg_dw.getitemstring(li_cntx,"inv401_rtngub")
			ls_date = arg_dw.getitemstring(li_cntx,"inv401_tdte4")
			lc_qty = arg_dw.getitemdecimal(li_cntx,"inv401_tqty4")
			if (ls_srty = 'RP') OR (ls_srty = 'SS' AND ls_srce = '04') then
				ls_vsrno = trim(arg_dw.getitemstring(li_cntx,"inv401_vsrno"))
				if mid(ls_vsrno,1,1) <> 'D' then
					continue
				end if
				// BOM001 CHECK (LOGIC ADD 2003.04.19)
				select count(*) into :li_chk from pbpdm.bom001
					where pcmcd = :ls_cmcd AND plant = :ls_plant AND
							pdvsn = :ls_dvsn AND ppitn = :ls_itno AND
							(( pedte = ' '  and pedtm <= :ls_date ) or
							( pedte <> ' ' and pedtm <= :ls_date and pedte >= :ls_date ))
					using sqlca;
				if li_chk < 1 then
					messagebox("BOM ERROR","해당날짜에 BOM미적용 품번 : " + ls_itno)
					continue
				end if
				// END
				DECLARE up_wip07 PROCEDURE FOR PBWIP.SP_WIP_07  
         		A_COMLTD = :ls_cmcd,   
         		A_PRSRTY = :ls_srty,   
         		A_PRSRNO = :ls_srno,   
         		A_PRSRNO1 = :ls_srno1,   
         		A_PRSRNO2 = :ls_srno2,   
         		A_IPADDR = ' ',   
         		A_MACADDR = ' ',   
         		A_INPTID = '000030',   
         		A_INPTDT = :is_currentdate,   
         		A_INPTTM = :g_s_datetime  using sqlca;
				
				execute up_wip07;
				//uo_status.st_message.text = ls_srty + ls_srno + ls_srno1 + ls_srno2 + " 데이타생성 완료"
			elseif (ls_srty = 'RM' or ls_srty = 'SM' or ls_srty = 'IS' or ls_srty = 'RS') then
				if ls_srty = 'IS' or ls_srty = 'RS' then
					ls_vsrno = trim(arg_dw.getitemstring(li_cntx,"inv401_vsrno"))
					if mid(ls_vsrno,1,1) <> 'D' then
						continue
					end if
				else
					ls_vsrno = trim(arg_dw.getitemstring(li_cntx,"inv401_dept"))
				end if
				if ls_cls = '30' or ls_srce = '03' then
					//pass
				else
					continue
				end if
				// BOM001 CHECK (LOGIC ADD 2003.04.19)
				select count(*) into :li_chk from pbpdm.bom001
					where pcmcd = :ls_cmcd AND plant = :ls_plant AND
							pdvsn = :ls_dvsn AND ppitn = :ls_itno AND
							(( pedte = ' '  and pedtm <= :ls_date ) or
							( pedte <> ' ' and pedtm <= :ls_date and pedte >= :ls_date ))
					using sqlca;
				if li_chk < 1 then
					//messagebox("BOM ERROR","해당날짜에 BOM미적용 품번 : " + ls_itno)
					continue
				end if
				// END
				 DECLARE up_wip06 PROCEDURE FOR PBWIP.SP_WIP_06  
         			A_COMLTD = :ls_cmcd,   
						A_PRSRTY = :ls_srty,   
						A_PRSRNO = :ls_srno,   
						A_PRSRNO1 = :ls_srno1,   
						A_PRSRNO2 = :ls_srno2,   
						A_IPADDR = ' ',   
						A_MACADDR = ' ',   
						A_INPTID = '000030',   
						A_INPTDT = :is_currentdate,   
						A_INPTTM = :g_s_datetime  using sqlca;
				
				execute up_wip06;
//				//uo_status.st_message.text = ls_srty + ls_srno + ls_srno1 + ls_srno2 + " 데이타생성 완료"
			end if		
		case '2'		 //Parent Not Found => 재공트랜스 레코드 삭제
			ls_cmcd = arg_dw.getitemstring(li_cntx,"inv401_comltd")
			ls_srty = arg_dw.getitemstring(li_cntx,"inv401_sliptype")
			ls_srno = arg_dw.getitemstring(li_cntx,"inv401_srno")
			ls_srno1 = arg_dw.getitemstring(li_cntx,"inv401_srno1")
			ls_srno2 = arg_dw.getitemstring(li_cntx,"inv401_srno2")
			ls_plant = arg_dw.getitemstring(li_cntx,"inv401_xplant")
			ls_dvsn = arg_dw.getitemstring(li_cntx,"inv401_div")
			ls_date = arg_dw.getitemstring(li_cntx,"inv401_tdte4")
			
			 DECLARE up_wip08 PROCEDURE FOR PBWIP.SP_WIP_08  
					A_COMLTD = :ls_cmcd,   
					A_PRSRTY = :ls_srty,   
					A_PRSRNO = :ls_srno,   
					A_PRSRNO1 = :ls_srno1,   
					A_PRSRNO2 = :ls_srno2  using sqlca;
			
			execute up_wip08;
		case '3'		 //Date, QTY Error
			ls_cmcd = arg_dw.getitemstring(li_cntx,"inv401_comltd")
			ls_srty = arg_dw.getitemstring(li_cntx,"inv401_sliptype")
			ls_srno = arg_dw.getitemstring(li_cntx,"inv401_srno")
			ls_srno1 = arg_dw.getitemstring(li_cntx,"inv401_srno1")
			ls_srno2 = arg_dw.getitemstring(li_cntx,"inv401_srno2")
			ls_plant = arg_dw.getitemstring(li_cntx,"inv401_xplant")
			ls_dvsn = arg_dw.getitemstring(li_cntx,"inv401_div")
			ls_slno = arg_dw.getitemstring(li_cntx,"inv401_slno")
			ls_itno = trim(arg_dw.getitemstring(li_cntx,"inv401_itno"))
			ls_usge = arg_dw.getitemstring(li_cntx,"inv401_xuse")
			ls_rtngubun = arg_dw.getitemstring(li_cntx,"inv401_rtngub")
			ls_date = arg_dw.getitemstring(li_cntx,"inv401_tdte4")
			ls_date2 = arg_dw.getitemstring(li_cntx,"chgdate")     //변경전 날짜
			lc_qty = arg_dw.getitemdecimal(li_cntx,"inv401_tqty4")
			lc_qty2 = arg_dw.getitemdecimal(li_cntx,"chgqty")     //변경전 수량
			ls_vsrno = trim(arg_dw.getitemstring(li_cntx,"inv401_vsrno"))
			if f_wip_use_replace(ls_cmcd, ls_srty, ls_srno, ls_srno1, ls_srno2, ls_plant, ls_dvsn , &
					ls_slno, ls_itno, ls_usge, ls_rtngubun, ls_vsrno, ls_date2, ls_date, lc_qty2, lc_qty) = 'N' then
				//messagebox("에러", ls_srty + ls_srno + " QTY, DATE 수정 에러")
			end if		
	end choose
next

return true
end function

public function boolean wf_get_prejob ();String ls_wzplant, ls_wzcttp, ls_prejob, ls_stscd
integer li_value

li_value = integer(mid(is_wip_id,2,1))
if is_wip_id = '010' then
	return true
else
	li_value = li_value - 1
end if

IF is_wip_gubun = 'ALL' Then
	ls_wzplant = 'D'
	ls_prejob = 'WIPA0' + string(li_value) + '0'
Else
	ls_wzplant = is_wip_plant
	ls_prejob = mid(is_wip_gubun,1,4) + '0' + string(li_value) + '0'
End If

//이전 작업상태코드 가져오기
SELECT WZSTSCD INTO :ls_stscd 
FROM PBWIP.WIP090
WHERE WZCMCD = '01' AND WZPLANT = :ls_wzplant AND
 		WZCTTP = :ls_prejob using sqlca;

If sqlca.sqlcode <> 0 or ls_stscd = '2' then
	return False
Else
	return True
End If
end function

public subroutine wf_flag_update ();String ls_wzplant, ls_wzcttp, ls_nextjob
integer li_value

li_value = integer(mid(is_wip_id,2,1))

if is_wip_gubun = 'ALL' then
	ls_wzplant = '%'
	ls_wzcttp = '%' + is_wip_id + '%'
	//현재 작업완료 업데이트
	Update PBWIP.WIP090
		Set WZSTSCD = 'C', WZUPDTDT = :is_currentdate
	 Where WZCMCD = '01' AND WZPLANT LIKE :ls_wzplant AND
			WZCTTP LIKE :ls_wzcttp using sqlca;
else
	ls_wzplant = is_wip_plant
	ls_wzcttp = trim(is_wip_gubun)
	//현재 작업완료 업데이트
	Update PBWIP.WIP090
		Set WZSTSCD = 'C', WZUPDTDT = :is_currentdate
	 Where WZCMCD = '01' AND WZPLANT = :ls_wzplant AND
			WZCTTP = :ls_wzcttp using sqlca;
end if


end subroutine

public subroutine wf_quater_qtycheck (string arg_year, string arg_month);string ls_part

choose case arg_month
	case '03'
		ls_part = '1'
	case '06'
		ls_part = '2'
	case '09'
		ls_part = '3'
	case '12'
		ls_part = '4'
end choose

// 업체정상 중간 DB(wip009) 와 사급보관증(wip008) 데이타 삭제
delete from pbwip.wip009
where wfcmcd = '01' and wfyear = :arg_year and
		wfmonth = :arg_month
		using sqlca;
		
delete from pbwip.wip008
where wfcmcd = '01' and wfyear = :arg_year and
		wfpart = :ls_part
		using sqlca;
		
DECLARE up_wip_023 PROCEDURE FOR PBWIP.SP_WIP_023  
         A_CMCD = '01',   
         A_YEAR = :arg_year,   
         A_MONTH = :arg_month,   
         A_IPADDR = ' ',   
         A_MACADDR = ' ',   
         A_INPTDT = :is_currentdate,   
         A_UPDTDT = ' '  ;
			
execute up_wip_023;

DECLARE up_wip_021 PROCEDURE FOR PBWIP.SP_WIP_021  
         A_CMCD = '01',   
         A_YYYY = :arg_year,   
         A_MM = :arg_month,   
         A_INPTID = ' ',   
         A_INPTDT = :is_currentdate  ;

execute up_wip_021;

Close up_wip_021;
Close up_wip_023;

update pbwip.wip090
set wzvstscd = '2'
using sqlca;
end subroutine

public function boolean wf_cross_post (string ag_plant, string ag_dvsn);//- 이월후 공장별 크로스 체크
string ls_fromdt, ls_todt

ls_fromdt = is_applydate + '01'
ls_todt = f_relativedate( uf_wip_addmonth(is_applydate,1) + '01', -1)

if ag_dvsn = 'ALL' then
	If Not f_wip_cross_check01('01',ls_fromdt,ls_todt,dw_2) Then		// 전공장
		Return False
	End If
else
	If Not f_wip_cross_check('01',ag_plant,mid(ag_dvsn,4,1),ls_fromdt,ls_todt,dw_2) Then
		Return False
	End If
end if

//Error Update
If Not wf_cross_post_update(dw_2) Then
	Return False
End if

return true
end function

public function string wf_get_host_datetime ();// host 일자 시간 가져오기

String		ls_date, ls_time


select	current date , current time 
into		:ls_date, :ls_time 
from		pbcommon.comm000
using		it_source;

g_s_datetime	= mid(ls_date + ' ' + ls_time,1,19)

is_currentdate	=	string(date(ls_date),"YYYYMMDD")
g_s_date = is_currentdate
is_currenttime	=	ls_time
g_s_time = is_currenttime

Return g_s_datetime

end function

public function boolean wf_inout_pre (string ag_plant, string ag_dvsn);//이월전 재공BOM사용량 확인로직
string ls_fromdate, ls_todate, ls_mysql

ls_fromdate = is_applydate + '01'
ls_todate = f_relativedate(is_currentdate,-1)

 DECLARE up_wip_051 PROCEDURE FOR PBWIP.SP_WIP_051  
         A_COMLTD = '01',   
         A_PLANT = :ag_plant,   
         A_DVSN = :ag_dvsn,   
         A_FROMDATE = :ls_fromdate,
			A_TODATE = :ls_todate using sqlca;

 execute up_wip_051;

ls_mysql = " DROP TABLE QTEMP.WIPTEMP02"
Execute Immediate :ls_mysql ;
ls_mysql = " DROP TABLE QTEMP.BOMTEMP01"
Execute Immediate :ls_mysql ;

Close up_wip_051;

//--이월전 수불체크
If Not f_wip_inout_wip001('01',ag_plant,ag_dvsn,is_applydate,dw_2) Then
	Return False
End If

// Error Update
dw_2.accepttext()

If dw_2.rowcount() > 0 Then
	If dw_2.Update() = 1 Then
		Return True
	Else
		Return False
	End If
Else
	Return True
End If
end function

public function boolean wf_wiprun ();//----------------------
// 이월전작업 : 010 ~ 040,  이월후작업 : 050 ~ 080
//----------------------
Boolean  lb_rtn 
Int		li_return, rowcount, li_second,	li_cycletime
Long		ll_start_time, ll_end_time, ll_currow
String	ls_interface_gubun, ls_source, ls_destination
String	ls_pipeline_name, ls_interface_name, ls_parm, ls_fail_gubun
String	ls_today, ls_nextmonth, ls_century, ls_year, ls_month, ls_date,&
			ls_yesterday,	ls_YesterMonth
String	ls_lastdate, ls_lasttime, ls_datetime,	ls_EndDateTime
DateTime	ldt_lastdatetime
Date		ld_lastdate, ld_currentDate
Time		lt_lasttime, lt_currenttime, lt_jobtime


SetPointer(HourGlass!)

// Host 시간 
ls_datetime = wf_get_host_datetime()

ld_CurrentDate	=	Date(is_currentdate)
lt_CurrentTime	=	Time(is_currenttime)
//get time for a total elapsed time
ll_start_time = Cpu ()

uo_pipe.st_read.Text		= '0'
uo_pipe.st_written.Text = '0'
uo_pipe.st_error.Text	= '0'
uo_pipe.st_time.Text		= ''

dw_1.SetPosition(ToTop!)
st_horizontal.SetPosition(ToTop!)
st_vertical.SetPosition(ToTop!)

//ls_today			=	String(Date(f_pisc_get_date_nowtime()), 'yyyy.mm.dd')
//ls_nextmonth	=	f_pisc_get_date_nextmonth(Left(ls_today, 7))					// 2003.02
//ls_yesterday	=	String(RelativeDate(Date(ls_today), -1), 'yyyymmdd')
//ls_lastdate		=	String(ldt_lastdatetime, 'yyyymmdd')
//ls_lasttime		=	String(ldt_lastdatetime, 'hh:mm')
//ls_YesterMonth	=	left(String(RelativeDate(Date(left(ls_today,7)+'.01'), -1), 'yyyymmdd'),6)
If is_cycle = 'POST' then
	is_applydate = uo_parameter.dw_1.getItemString( 1, 'wzeddt')
Else
	is_applydate = uo_parameter.dw_1.getItemString( 1, 'wzdate')
End If

//insert result
ll_currow = dw_1.insertrow(0)
dw_1.setitem(ll_currow,'job_desc',is_wip_plant + ' : ' + is_wip_gubun)
dw_1.setitem(ll_currow,'job_start', ls_datetime)

g_s_plant = is_wip_plant
g_s_gubun = is_wip_gubun
dw_2.reset()

CHOOSE CASE is_wip_id
	CASE '010'
		dw_2.dataobject = 'd_wip_cross_error'
		dw_2.settransobject(sqlca)
		lb_rtn = wf_cross_pre(is_wip_plant, is_wip_gubun)
	CASE '020'
		dw_2.dataobject = 'd_wip_inout_wip001error'
		dw_2.settransobject(sqlca)
		lb_rtn = wf_inout_pre(is_wip_plant, mid(is_wip_gubun,4,1))
	CASE '030'
		dw_2.dataobject = 'd_wip_option_wip004'
		dw_2.settransobject(sqlca)
		lb_rtn = wf_option_pre(is_wip_plant, mid(is_wip_gubun,4,1))
	CASE '040'
		dw_2.dataobject = ''
		lb_rtn = wf_transfer(is_wip_plant, is_wip_gubun)
	CASE '050'
		dw_2.dataobject = ''
		lb_rtn = wf_qtymodify(is_wip_plant, is_wip_gubun)
	CASE '060'
		dw_2.dataobject = 'd_wip_cross_error'
		dw_2.settransobject(sqlca)
		lb_rtn = wf_cross_post(is_wip_plant, is_wip_gubun)
	CASE '070'
		dw_2.dataobject = 'd_wip_inout_wip002error'
		dw_2.settransobject(sqlca)
		lb_rtn = wf_inout_post(is_wip_plant, mid(is_wip_gubun,4,1))
	CASE '080'
		dw_2.dataobject = "d_wip_cost_error"
		dw_2.settransobject(sqlca)
		lb_rtn = wf_average_post(is_wip_plant, mid(is_wip_gubun,4,1))
END CHOOSE

//get ending time
ll_end_time = Cpu ()
uo_pipe.st_time.text = string((ll_end_time - ll_start_time)/1000,"##0.0") + " Secs"

ls_Enddatetime = wf_get_host_datetime()

dw_1.setitem(ll_currow,'job_error', dw_2.rowcount() )
dw_1.setitem(ll_currow,'job_end', ls_Enddatetime)
dw_1.setitem(ll_currow,'job_time', (ll_end_time - ll_start_time)/1000 )

// wip090 flag update
if lb_rtn then
	wf_flag_update()
end if

Return true
end function

public function boolean wf_auto_download (); 
Long		ll_row, i
Int		rowcount
String   ls_plant, ls_gubun

ll_row	= dw_interface.Rowcount()

For i = 1 To ll_row
	// server 연결이 안되었거나 야간엔 돌지 않는다...
	If Not wf_connect_check(SQLCA, it_destination) Then	
		// 10분 간격으로 변경
		Timer(600)
		Exit
	End If

	is_wip_plant = dw_interface.GetItemString( i, 'wip_plant')
	is_wip_gubun = dw_interface.GetItemString( i, 'wip_gubun')
	is_wip_id = dw_interface.GetItemString( i, 'wip_id')
	is_wip_desc = dw_interface.GetItemString( i, 'wzdesc')
	
	If is_cycle = 'PRE' and cbx_check.checked Then
		If is_wip_id <> '010' and is_wip_id <> '020' Then
			continue
		End If
	End If
	
	If is_wip_gubun ='ALL' then
		ls_plant = 'D'
		ls_gubun = 'WIPA' + is_wip_id
	Else
		if is_wip_id = '010' or is_wip_id = '060' then
			continue
		end if
		ls_plant = is_wip_plant
		ls_gubun = is_wip_gubun
	End If
	
	dw_interface.SelectRow(0, False)
	dw_interface.SelectRow(i, True)	
	dw_interface.ScrollToRow(i)
	
	uo_parameter.Event Trigger ue_retrieve(ls_plant, ls_gubun, rowcount)
	
	If is_cycle = 'PRE' and cbx_check.checked Then
		ib_interface = False
		uo_pipe.cb_repair.Enabled	= False
		uo_pipe.cb_cancel.Enabled	= True
		uo_button.uf_button_enable(False, False, False)
		uo_parameter.Enabled	= False
		dw_interface.Enabled	= False
		uo_option.Enabled		= False
		uo_date.Enabled		= False
		if wf_wiprun() then
			//wf_dw_init(1)
		end if
		uo_button.uf_button_enable(True, False, True)
		uo_parameter.Enabled	= True
		dw_interface.Enabled	= True
		uo_option.Enabled		= True
		uo_date.Enabled		= True
		
		ib_interface = False
	Else
		If (uo_parameter.dw_1.GetItemString(1, 'wzstscd') = '2' and wf_get_prejob()) then
			ib_interface = True
			uo_pipe.cb_repair.Enabled	= False
			uo_pipe.cb_cancel.Enabled	= True
			uo_button.uf_button_enable(False, False, False)
			uo_parameter.Enabled	= False
			dw_interface.Enabled	= False
			uo_option.Enabled		= False
			uo_date.Enabled		= False
			
			if wf_wiprun() then
				//wf_dw_init(1)
			end if
	
			uo_button.uf_button_enable(True, False, True)
			uo_parameter.Enabled	= True
			dw_interface.Enabled	= True
			uo_option.Enabled		= True
			uo_date.Enabled		= True
			
			ib_interface = False
		end if
	End If
	
//	Yield()	
//	If ib_cancel Then 
//		ib_cancel = False
//		Exit
//	End If
Next	

return true
end function

public function boolean wf_average_post (string ag_plant, string ag_dvsn);//****************
//* 재공 단가계산
//****************
string ls_year, ls_month, ls_mm01, ls_adjdate, ls_postdate, ls_currentdate
string ls_postyy, ls_postmm
string ls_pbdiv, ls_pdcd, ls_xplant, ls_div
integer li_cnt, li_rowcnt
dec{0} lc_pbmatw, lc_bgat
datastore ds_cost_pcc950

if ag_plant = 'Y' then
	return true
end if

ls_year 		= mid(is_applydate,1,4)
ls_month 	= mid(is_applydate,5,2)
ls_adjdate = left(is_applydate,6)                                     //마감월

ls_postdate = uf_wip_addmonth(ls_adjdate, 1)                          //이월
ls_postyy = mid(ls_postdate,1,4)
ls_postmm = mid(ls_postdate,5,2)
ls_currentdate = is_currentdate + is_currenttime

// 무상사급정산 추가품번 생성
If ls_month = '03' or ls_month = '06' or ls_month = '09' or ls_month = '12' then
	Choose Case ls_month
		Case '03'
			ls_mm01 = '01'
		Case '06'
			ls_mm01 = '04'
		Case '09'
			ls_mm01 = '07'
		Case '12'
			ls_mm01 = '10'
	End choose
	
	insert into pbwip.wip009
   (wfyear,wfmonth,wfcmcd,wfplant,wfdvsn,wfvendor,wfitno,
    wfunit,wfscrp,wfretn,wfavrg,wfbgqt,wfbgat,wfinqt,wfinat,
    wfusqt1,wfusat1,wfusqt2,wfusat2,wfusqt3,wfusat3,
    wfohqt,wfohat,wfphqt,wfphat,wfdefqt,wfdefat,wflautqt,
    wflautat,wfrautqt,wfrautat,wfclqt,wfclat,wfplan,wfstscd,
    wfipaddr,wfmacaddr,wfinptdt,wfupdtdt)
  	select :ls_year,:ls_month,tmp.wbcmcd,tmp.wbplant,tmp.wbdvsn,tmp.wborct,
  		tmp.wbitno,tmp.xunit,0,0,0,0,0,
  		0,0,0,0,0,0,0,0,
  		0,0,0,0,0,0,0,0,
  		0,0,0,0,' ',' ',
  			' ',' ',' ',' '
	from ( select distinct wbcmcd,wbplant,wbdvsn,wborct,
            wbitno,xunit from pbwip.wip002, pbinv.inv101
          where comltd = wbcmcd and xplant = wbplant and div = wbdvsn and
            itno = wbitno and wbcmcd = '01' and wbyear = :ls_year and
            wbiocd = '2' and 
            wbmonth >= :ls_mm01 and wbmonth <= :ls_month and
            not (wbbgqt = 0 and wbinqt = wbusqt3 and
              wbusqt1 = 0 and wbusqt2 = 0 and wbusqt4 = 0 and
              wbusqt5 = 0 and wbusqt6 = 0 and wbusqt7 = 0 and
              wbusqt8 = 0 ) ) tmp
	  where  not exists ( select * from pbwip.wip009
					where wfcmcd = tmp.wbcmcd and wfvendor = tmp.wborct and wfitno = tmp.wbitno and
					  wfyear = :ls_year and wfmonth = :ls_month)
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		return false
	end if
end if
//창고재공 수량 계산
if Not f_wip_calc_qtyinv('01',ag_plant,ag_dvsn,is_applydate) then
	return False
end if
//재공단가 계산
f_wip_cost_calc('01',ag_plant,ag_dvsn,is_applydate,dw_2)

if dw_2.rowcount() > 0 then
	return False
else
	if ag_plant = 'D' and ag_dvsn = 'A' then
		if f_wip_cost_asitem(is_applydate) = -1 then
			return False
		end if
	end if
end if

//원가계산관리 기말재공금액 생성 : 2007.06.20
ds_cost_pcc950 = create datastore                  			              
ds_cost_pcc950.dataobject = "d_wip_cost_pcc950"
ds_cost_pcc950.settransobject(sqlca)

li_rowcnt = ds_cost_pcc950.retrieve('01',ag_plant,ag_dvsn, ls_postdate, ls_adjdate)
if li_rowcnt > 0 then
	for li_cnt = 1 to li_rowcnt
		ls_xplant = ds_cost_pcc950.getitemstring(li_cnt,"xplant")
		ls_div = ds_cost_pcc950.getitemstring(li_cnt,"div")
		ls_pdcd = ds_cost_pcc950.getitemstring(li_cnt,"pdcd")
		lc_pbmatw = ds_cost_pcc950.getitemnumber(li_cnt,"bgat")
		ls_pbdiv = ls_xplant + f_get_accdiv(ls_xplant, ls_div, ls_pdcd)
		
		DELETE FROM PBACC.PCC950
		WHERE COMLTD = '01' AND PBYY = :ls_year AND PBMM = :ls_month AND
			PBDIV = :ls_pbdiv AND PBPRCD = :ls_pdcd AND PBGUBUN = 'A'
		using sqlca;
		
		INSERT INTO PBACC.PCC950( COMLTD, PBGUBUN, PBYY, PBMM, PBDIV, PBPRCD, PBMATW, EXTD,
			INPTID, INPTDT, UPDTID, UPDTDT, IPADDR, MACADDR )
		VALUES('01', 'A', :ls_year,:ls_month,:ls_pbdiv,:ls_pdcd,:lc_pbmatw,' ',
			'WIP',:ls_currentdate, 'WIP',:ls_currentdate, ' ', '')
		using sqlca;
		if sqlca.sqlcode <> 0 then
			return false
		end if
	next
end if
destroy ds_cost_pcc950

// 재공수불금액 재공구분별 합계
DELETE FROM PBWIP.WIP018
WHERE WBCMCD = '01' AND WBYYMMDD = :is_currentdate AND 
		WBYEAR = :ls_year AND WBMONTH = :ls_month AND
		WBPLANT = :ag_plant AND WBDVSN = :ag_dvsn
using sqlca;

INSERT INTO PBWIP.WIP018
( WBCMCD,WBYYMMDD,WBYEAR,WBMONTH,WBPLANT,WBDVSN,WBIOCD,
WBBGAT1,WBINAT1,WBINAT2,WBINAT3,WBINAT4,
WBUSAT1,WBUSAT2,WBUSAT3,WBUSAT4,WBUSAT5,WBUSAT6,WBUSAT7,WBUSAT8,
WBUSAT9,WBUSATA,WBOHAT1,WBOHATA,WBINPTDT )
SELECT wbcmcd,:is_currentdate,wbyear,wbmonth,wbplant,wbdvsn,wbiocd,
SUM(wbbgat1) as bgat1,SUM(wbinat1) as inat1,SUM(wbinat2) as inat2,SUM(wbinat3) as inat3,SUM(wbinat4) as inat4,
SUM(wbusat1) as usat1,SUM(wbusat2) as usat2,SUM(wbusat3) as usat3,SUM(wbusat4) as usat4,SUM(wbusat5) as usat5,
SUM(wbusat6) as usat6,SUM(wbusat7) as usat7,SUM(wbusat8) as usat8,
SUM(wbusat9) as usat9,SUM(wbusata) as usata,
SUM( wbbgat1 + wbinat1 + wbinat2 +
       wbinat3 + wbinat4 -
       (wbusat1 + wbusat2 + wbusat3 + wbusat4 + wbusat5 +
       wbusat6 + wbusat7 + wbusat8 + wbusat9 + wbusata)) as ohat1,
0,
''
FROM PBWIP.WIP002
WHERE WBCMCD = '01' AND WBYEAR = :ls_year AND WBMONTH = :ls_month AND
		WBPLANT = :ag_plant AND WBDVSN = :ag_dvsn AND WBIOCD <> '3'
GROUP BY WBCMCD,WBYEAR,WBMONTH,WBPLANT,WBDVSN,WBIOCD
using sqlca;

SELECT SUM(WBBGAT1) INTO :lc_bgat
FROM PBWIP.WIP002
WHERE WBCMCD = '01' AND WBYEAR = :ls_postyy AND WBMONTH = :ls_postmm AND
		WBPLANT = :ag_plant AND WBDVSN = :ag_dvsn AND WBIOCD = '1'
using sqlca;

UPDATE PBWIP.WIP018
SET WBOHATA = :lc_bgat
WHERE WBCMCD = '01' AND WBYYMMDD = :is_currentdate AND WBYEAR = :ls_year AND WBMONTH = :ls_month AND
		WBPLANT = :ag_plant AND WBDVSN = :ag_dvsn AND WBIOCD = '1'
using sqlca;

SELECT SUM(WBBGAT1) INTO :lc_bgat
FROM PBWIP.WIP002
WHERE WBCMCD = '01' AND WBYEAR = :ls_postyy AND WBMONTH = :ls_postmm AND
		WBPLANT = :ag_plant AND WBDVSN = :ag_dvsn AND WBIOCD = '2'
using sqlca;

UPDATE PBWIP.WIP018
SET WBOHATA = :lc_bgat
WHERE WBCMCD = '01' AND WBYYMMDD = :is_currentdate AND WBYEAR = :ls_year AND WBMONTH = :ls_month AND
		WBPLANT = :ag_plant AND WBDVSN = :ag_dvsn AND WBIOCD = '2'
using sqlca;

INSERT INTO PBWIP.WIP018
( WBCMCD,WBYYMMDD,WBYEAR,WBMONTH,WBPLANT,WBDVSN,WBIOCD,
WBBGAT1,WBINAT1,WBINAT2,WBINAT3,WBINAT4,
WBUSAT1,WBUSAT2,WBUSAT3,WBUSAT4,WBUSAT5,WBUSAT6,WBUSAT7,WBUSAT8,
WBUSAT9,WBUSATA,WBOHAT1,WBOHATA,WBINPTDT )
SELECT wccmcd,:is_currentdate,wcyear,wcmonth,wcplant,wcdvsn,'4',
SUM(wcbgat1) as bgat1,SUM(wcinat1) as inat1,SUM(0) as inat2,SUM(0) as inat3,SUM(0) as inat4,
SUM(wcusat1) as usat1,SUM(wcusat2) as usat2,SUM(wcusat3) as usat3,SUM(wcusat4) as usat4,SUM(wcusat5) as usat5,
SUM(wcusat6) as usat6,SUM(wcusat7) as usat7,SUM(wcusat8) as usat8,
SUM(wcusat9) as usat9,SUM(0) as usata,
SUM(WCBGAT1 + WCINAT1 - ( WCUSAT1 + WCUSAT2 + WCUSAT3 +
WCUSAT4 + WCUSAT5 + WCUSAT6 + WCUSAT7 + WCUSAT8 + WCUSAT9)) as ohat1,
0,
''
FROM PBWIP.WIP003
WHERE WCCMCD = '01' AND WCYEAR = :ls_year AND WCMONTH = :ls_month AND
		WCPLANT = :ag_plant AND WCDVSN = :ag_dvsn
GROUP BY WCCMCD,WCYEAR,WCMONTH,WCPLANT,WCDVSN
using sqlca;

SELECT SUM(WCBGAT1) INTO :lc_bgat
FROM PBWIP.WIP003
WHERE WCCMCD = '01' AND WCYEAR = :ls_postyy AND WCMONTH = :ls_postmm AND
		WCPLANT = :ag_plant AND WCDVSN = :ag_dvsn
using sqlca;

UPDATE PBWIP.WIP018
SET WBOHATA = :lc_bgat
WHERE WBCMCD = '01' AND WBYYMMDD = :is_currentdate AND WBYEAR = :ls_year AND WBMONTH = :ls_month AND
		WBPLANT = :ag_plant AND WBDVSN = :ag_dvsn AND WBIOCD = '4'
using sqlca;

return true
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
	//Messagebox("Source Connect Error", rt_source.sqlerrtext)
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
	//Messagebox("Source Connect Error", rt_destination.sqlerrtext)
	Return False
End If

If li_error = 0 Then
	Return True
Else
	Return False
End If

end function

public function boolean wf_connect_check (ref transaction rt_source, ref transaction rt_destination);// Host와 IPIS server connection check & 실행가능시간 check

UnsignedLong	ul_handle1, ul_handle2
Boolean			lb_connect

ul_handle1 = rt_source.DBHandle()
//ul_handle2 = rt_destination.DBHandle()

If ul_handle1 > 0 Then
	If cbx_check.checked and is_cycle = 'PRE' then
		If String(Today(), 'hhmmss') >= '060000' and String(Today(), 'hhmmss') <= '070000' Then
			Return True
		Else
			Return False
		End If
	Else
		Return True	
	End If
Else
	return False
//	lb_connect = wf_connect(gs_ini_file, 'MIS', 'IPIS', it_source, it_destination)
//	If lb_connect Then
//		If cbx_check.checked and is_cycle = 'PRE' then
//			If String(Today(), 'hhmmss') >= '060000' and String(Today(), 'hhmmss') <= '075000' Then
//				Return True
//			Else
//				Return False
//			End If
//		Else
//			return lb_connect
//		End If
//	else
//		Return lb_connect
//	end if
End If	
end function

public function boolean wf_transfer (string ag_plant, string ag_dvsn);//-- 재공이월
string ls_fromdt, ls_todt, ls_lastdate
string ls_curyear, ls_curmonth, ls_nextyear, ls_nextmonth, ls_lastyear, ls_lastmonth
long ll_count
dec{4} lc_sumqty001, lc_sumqty002
dec{0} lc_sumamt001, lc_sumamt002

ls_fromdt = is_applydate + '01'
ls_todt = uf_wip_addmonth(is_applydate,1)
ls_curyear = mid(ls_fromdt,1,4)
ls_curmonth = mid(ls_fromdt,5,2)
ls_nextyear = mid(ls_todt,1,4)
ls_nextmonth = mid(ls_todt,5,2)
ls_lastdate = uf_wip_addmonth(is_applydate,-1)
ls_lastyear = mid(ls_lastdate,1,4)
ls_lastmonth = mid(ls_lastdate,5,2)

 DECLARE up_wip_01 PROCEDURE FOR PBWIP.SP_WIP_01  
	A_YY01 = :ls_curyear,   
	A_MM01 = :ls_curmonth,   
	A_YY02 = :ls_nextyear,   
	A_MM02 = :ls_nextmonth,   
	A_IPADDR = ' ',   
	A_MACADDR = ' ',   
	A_INPTDT = ' ',   
	A_UPDTDT = ' '  using sqlca;
execute up_wip_01;

select sum(wabgqt), sum(wabgat1) into :lc_sumqty001, :lc_sumamt001
from pbwip.wip001, pbinv.inv101
where wacmcd = comltd and waplant = xplant and
      wadvsn = div and waitno = itno and waplant <> 'Y' and
      cls in ('10','40','50')
using sqlca;

if sqlca.sqlcode <> 0 then
	Messagebox("경고", "데이타 이월시에 에러가 발생하였습니다.01")
	return false
end if

select sum(wbbgqt), sum(wbbgat1) into :lc_sumqty002, :lc_sumamt002
from pbwip.wip002
where wbcmcd = '01' and wbplant <> 'Y' and wbyear = :ls_curyear and
      wbmonth = :ls_curmonth
using sqlca;

if sqlca.sqlcode <> 0 or lc_sumqty001 <> lc_sumqty002 or lc_sumamt001 <> lc_sumamt002 then
	Messagebox("경고", "데이타 이월시에 에러가 발생하였습니다.02")
	return false
end if 

select count(*) into :ll_count
from pbwip.wip002
where wbcmcd = '01' and wbyear = :ls_nextyear and
      wbmonth = :ls_nextmonth
using sqlca;

if ll_count < 1 then
	Messagebox("경고", "데이타 이월시에 에러가 발생하였습니다.03")
	return false
end if

//창고재고 이월 - 전공장
If f_carry_over_stock('01', is_applydate) = -1 then
	Messagebox("경고", "창고재공 이월시에 에러가 발생하였습니다.")
	Return False
End If

// 이체단가정보 이월
select count(*) into :ll_count from pbpdm.bom010
where acmcd = '01' and ayear = :ls_curyear and amont = :ls_curmonth
using sqlca;

if ll_count < 1 then
	insert into pbpdm.bom010
	( acmcd,ayear,amont,aplant,advsn,aitno,aclsb,asrce,
	acost,aeitno,acitno,aqtym,aqty,aempno,alastdate )
	select acmcd,:ls_curyear,:ls_curmonth,aplant,advsn,aitno,aclsb,asrce,
	acost,aeitno,acitno,aqtym,aqty,aempno,alastdate
	from pbpdm.bom010
	where acmcd = '01' and ayear = :ls_lastyear and amont = :ls_lastmonth
	using sqlca;
end if

// 고객사유상사급 공제단가 이월
select count(*) into :ll_count from pbpdm.bom016
where fcmcd = '01' and fdate =:is_applydate
using sqlca;

if ll_count < 1 then
	insert into pbpdm.bom016
	( fcmcd,fgubun,fdate,fplant,fdvsn,fpdcd,fmdno,
	fcmcst,fcicst,fcocst,fcostdiv,fcrdt,fcomcd,fxcost,fwcost )
	select fcmcd,fgubun,:is_applydate,fplant,fdvsn,fpdcd,fmdno,
	fcmcst,fcicst,fcocst,fcostdiv,fcrdt,fcomcd,fxcost,fwcost
	from pbpdm.bom016
	where fcmcd = '01' and fdate =:ls_lastdate
	using sqlca;
end if

//재공밸런스 초기화 - 전공장
If f_carry_over_wip001('01') = -1 Then
	Return False
End If
//사급보관증 데이타 생성
if ls_curmonth = '03' or ls_curmonth = '06' or ls_curmonth = '09' or ls_curmonth = '12' then
	wf_quater_qtycheck(ls_curyear, ls_curmonth)
end if
//컨트로코드 업데이트 - 전공장
If f_wip090_update(' ', ' ', '040', ' ') <> 0 Then
	Return False
End If

Return True
end function

public function boolean wf_inout_post (string ag_plant, string ag_dvsn);//-- 라인년말 실사년월시차에 따른 수불현황생성
string ls_applyhour, ls_adjdate, ls_postdate, ls_currentdate
string ls_xplant, ls_div, ls_pdcd, ls_pbdiv, ls_year, ls_month
datastore ds_inout_pcc950
integer li_rowcnt, li_cnt
dec{0} lc_pbmatw

//If is_applydate = '200812' then
//	if ag_plant = 'D' then
//		choose case ag_dvsn
//			case 'A'
//				ls_applyhour = '13'
//			case 'M'
//				ls_applyhour = '13'
//			case 'S'
//				ls_applyhour = '13'
//			case 'H'
//				ls_applyhour = '13'
//			case 'V'
//				ls_applyhour = '13'
//		end choose
//	end if
//	if ag_plant = 'J' or ag_plant = 'B' or ag_plant = 'K' then
//		ls_applyhour = '13'
//	end if
//	// cutoff 이후 재공수량 생성
//	if f_wip_create_cutoff('01',ag_plant,ag_dvsn,is_applydate,'19',ls_applyhour) then
//		f_wip_inout_wip013('01',ag_plant,ag_dvsn,is_applydate,'19',ls_applyhour)
//	end if
//	// 실시간 cutoff 실사용재공수량 생성
//	//f_wip_inout_wip014('01',ag_plant,ag_dvsn,'200808','10',ls_applyhour)
//end if

//-- 공장별 이월후 수불체크
If Not f_wip_inout_wip002('01',ag_plant,ag_dvsn,is_applydate,dw_2) Then
	Return False
End If

// Error Update
dw_2.accepttext()

If dw_2.rowcount() > 0 Then
	If dw_2.Update() <> 1 Then
		Return False
	End If
End If

// WIP004 유상사급데이타 생성로직 2008.03.05
if wf_create_wip014(ag_plant, ag_dvsn, is_applydate) = -1 then
	Return False
else
	// 경리용 데이타 Creation PBACC.PCC950 구분 : 'B'
	ls_adjdate = left(is_applydate,6)                                     //마감월
	ls_postdate = uf_wip_addmonth(ls_adjdate, 1)                          //이월
	ls_currentdate = is_currentdate + is_currenttime
	ls_year 		= mid(is_applydate,1,4)
	ls_month 	= mid(is_applydate,5,2)
	
	ds_inout_pcc950 = create datastore                  			              
	ds_inout_pcc950.dataobject = "d_wip_inout_pcc950"
	ds_inout_pcc950.settransobject(sqlca)
	
	li_rowcnt = ds_inout_pcc950.retrieve('01',ag_plant,ag_dvsn, ls_postdate, ls_adjdate)
	if li_rowcnt > 1 then
		for li_cnt = 1 to li_rowcnt
			ls_xplant = ds_inout_pcc950.getitemstring(li_cnt,"xplant")
			ls_div = ds_inout_pcc950.getitemstring(li_cnt,"div")
			ls_pdcd = ds_inout_pcc950.getitemstring(li_cnt,"pdcd")
			lc_pbmatw = ds_inout_pcc950.getitemnumber(li_cnt,"bgat")
			ls_pbdiv = ls_xplant + f_get_accdiv(ls_xplant, ls_div, ls_pdcd)
			
			DELETE FROM PBACC.PCC950
			WHERE COMLTD = '01' AND PBYY = :ls_year AND PBMM = :ls_month AND
				PBDIV = :ls_pbdiv AND PBPRCD = :ls_pdcd AND PBGUBUN = 'B'
			using sqlca;
			
			INSERT INTO PBACC.PCC950( COMLTD, PBGUBUN, PBYY, PBMM, PBDIV, PBPRCD, PBMATW, EXTD,
				INPTID, INPTDT, UPDTID, UPDTDT, IPADDR, MACADDR )
			VALUES('01', 'B', :ls_year,:ls_month,:ls_pbdiv,:ls_pdcd,:lc_pbmatw,' ',
				'WIP',:ls_currentdate, 'WIP',:ls_currentdate, ' ', '')
			using sqlca;
			if sqlca.sqlcode <> 0 then
				return false
			end if
		next
	end if
	destroy ds_inout_pcc950
	// Creation End
	Return True
end if
// 생성로직 끝
end function

public function integer wf_create_wip014 (string ag_plant, string ag_dvsn, string ag_applydate);//************************************************
//* 성공 return 0, 실패 : return -1
//* 1. 기준월에 존재하지 않는 품번 생성
//* 2. 유상사급단가, 투입수량, 투입금액, 유상사급사용수량, 유상사급사용금액 업데이트
//* 3. 이월데이타 재생성, 유상사급단가, 기초수량, 기초금액
//************************************************
string ls_year, ls_month, ls_nextdate, ls_nextmonth, ls_nextyear
string ls_orct, ls_itno
dec{4} lc_wbbgqt, lc_wbinqt, lc_wbusqt3, lc_wbusqt8, lc_ohqt, lc_convqty
dec{5} lc_wbavrg1
dec{0} lc_wbbgat1, lc_wbinat1, lc_wbusat3, lc_wbusat8, lc_ohat, lc_wbusat9
ls_year = mid(ag_applydate,1,4)
ls_month = mid(ag_applydate,5,2)
ls_nextdate = uf_wip_addmonth(ag_applydate,1)
ls_nextyear = mid(ls_nextdate,1,4)
ls_nextmonth = mid(ls_nextdate,5,2)

insert into pbwip.wip014(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
			 wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
			 wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
			 wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
			 wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
			 wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
			 wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
			 wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
			 wbmacaddr,wbinptdt,wbupdtdt)
select aa.wbcmcd,aa.wbplant,aa.wbdvsn,aa.wborct,aa.wbitno,
			 aa.wbyear,aa.wbmonth,aa.wbrev,aa.wbiocd,aa.wbitcl,aa.wbsrce,aa.wbpdcd,
			 aa.wbunit,aa.wbtype,aa.wbdesc,aa.wbspec,aa.wbscrp,aa.wbretn,aa.wbavrg1,
			 0,0, 0,
			 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			 0,0,0,0,0,' ','','',:g_s_date,'' 
from pbwip.wip002 aa
where aa.wbcmcd = '01' and aa.wbplant = :ag_plant and aa.wbdvsn = :ag_dvsn and
	aa.wbyear = :ls_year and aa.wbmonth = :ls_month and aa.wbiocd = '3' and
	NOT EXISTS ( select * from pbwip.wip014 bb
		where bb.wbcmcd = aa.wbcmcd and bb.wbyear = aa.wbyear and bb.wbmonth = aa.wbmonth and
			bb.wbplant = aa.wbplant and bb.wbdvsn = aa.wbdvsn and bb.wborct = aa.wborct and
			bb.wbiocd = aa.wbiocd and bb.wbitno = aa.wbitno )
using sqlca;

if sqlca.sqlcode <> 0 then
	return -1
end if

delete from pbwip.wip014
where wbcmcd = '01' and wbplant = :ag_plant and wbdvsn = :ag_dvsn and
	wbyear = :ls_nextyear and wbmonth = :ls_nextmonth and wbiocd = '3'
using sqlca;

if sqlca.sqlcode <> 0 then
	return -1
end if

DECLARE wip014_cur CURSOR FOR  
	SELECT aa.wborct, aa.wbitno, aa.wbavrg1, aa.wbinqt, aa.wbinat1, aa.wbusqt3, aa.wbusat3, bb.convqty
	FROM pbwip.wip002 aa inner join pbinv.inv101 bb
		ON  aa.wbcmcd = bb.comltd and aa.wbplant = bb.xplant and
			aa.wbdvsn = bb.div and aa.wbitno = bb.itno
	WHERE aa.wbcmcd = '01' and aa.wbplant = :ag_plant and aa.wbdvsn = :ag_dvsn and
		aa.wbyear = :ls_year and aa.wbmonth = :ls_month and aa.wbiocd = '3'
	union all
	SELECT cc.wborct, cc.wbitno, cc.wbavrg1, cc.wbinqt, cc.wbinat1, cc.wbusqt3, cc.wbusat3, -1
	FROM pbwip.wip014 cc
	WHERE cc.wbcmcd = '01' and cc.wbplant = :ag_plant and cc.wbdvsn = :ag_dvsn and
		cc.wbyear = :ls_year and cc.wbmonth = :ls_month and cc.wbiocd = '3' and
		not exists ( select * from pbwip.wip002 dd 
			where dd.wbcmcd = '01' and dd.wbplant = :ag_plant and dd.wbdvsn = :ag_dvsn and
			dd.wbyear = :ls_year and dd.wbmonth = :ls_month and dd.wbiocd = '3' and
			cc.wbcmcd = dd.wbcmcd and cc.wbyear = dd.wbyear and cc.wbmonth = dd.wbmonth and
			cc.wbplant = dd.wbplant and cc.wbdvsn = dd.wbdvsn and cc.wbitno = dd.wbitno and 
			cc.wborct = dd.wborct )
	using sqlca;

OPEN wip014_cur;
do while true
	FETCH wip014_cur INTO :ls_orct, :ls_itno, :lc_wbavrg1, :lc_wbinqt, &
							:lc_wbinat1, :lc_wbusqt3,:lc_wbusat3,:lc_convqty;
		if sqlca.sqlcode <> 0 then
			exit
		end if
		
		select wbbgqt, wbbgat1 
		into :lc_wbbgqt, :lc_wbbgat1
		from pbwip.wip014
		where wbcmcd = '01' and wbplant = :ag_plant and wbdvsn = :ag_dvsn and
			wbyear = :ls_year and wbmonth = :ls_month and wbiocd = '3' and
			wborct = :ls_orct and wbitno = :ls_itno
		using sqlca;
		
		lc_ohqt = lc_wbbgqt + lc_wbinqt - lc_wbusqt3
		lc_ohat = lc_ohqt * lc_wbavrg1
		lc_wbinat1 = lc_wbinqt * lc_wbavrg1
		lc_wbusat3 = lc_wbusqt3 * lc_wbavrg1
		lc_wbusat9 = lc_wbbgat1 + lc_wbinat1 - ( lc_wbusat3 + lc_ohat )
		if lc_convqty = -1 then
			lc_wbusqt8 = lc_ohqt
			lc_wbusat8 = lc_ohat
		else
			lc_wbusqt8 = 0
			lc_wbusat8 = 0
		end if
		
		update pbwip.wip014
		set wbavrg1 = :lc_wbavrg1, wbinqt = :lc_wbinqt, wbinat1 = :lc_wbinat1,
			wbusqt3 = :lc_wbusqt3, wbusat3 = :lc_wbusat3, wbusat9 = :lc_wbusat9,
			wbusqt8 = :lc_wbusqt8, wbusat8 = :lc_wbusat8
		where wbcmcd = '01' and wbplant = :ag_plant and wbdvsn = :ag_dvsn and
			wbyear = :ls_year and wbmonth = :ls_month and wbiocd = '3' and
			wborct = :ls_orct and wbitno = :ls_itno
		using sqlca;
		
		if sqlca.sqlnrows <> 1 then
			return -1
		end if
		
		if lc_convqty <> -1 then
			// 이월데이타 생성
			insert into pbwip.wip014(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
				 wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
				 wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
				 wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
				 wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
				 wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
				 wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
				 wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
				 wbmacaddr,wbinptdt,wbupdtdt)
			select aa.wbcmcd,aa.wbplant,aa.wbdvsn,aa.wborct,aa.wbitno,
					 :ls_nextyear,:ls_nextmonth,aa.wbrev,aa.wbiocd,aa.wbitcl,aa.wbsrce,aa.wbpdcd,
					 aa.wbunit,aa.wbtype,aa.wbdesc,aa.wbspec,aa.wbscrp,aa.wbretn,aa.wbavrg1,
					 0, :lc_ohqt, :lc_ohat,
					 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					 0,0,0,0,0,' ','','',:g_s_date,'' 
			from pbwip.wip014 aa
			where aa.wbcmcd = '01' and aa.wbplant = :ag_plant and aa.wbdvsn = :ag_dvsn and
				aa.wbyear = :ls_year and aa.wbmonth = :ls_month and aa.wbiocd = '3' and
				aa.wborct = :ls_orct and aa.wbitno = :ls_itno
			using sqlca;
			
			if sqlca.sqlcode <> 0 then
				return -1
			end if
		end if
loop
CLOSE wip014_cur;

return 0
end function

on w_wip_run.create
this.cb_option_post=create cb_option_post
this.cb_down=create cb_down
this.cbx_check=create cbx_check
this.uo_parameter=create uo_parameter
this.dw_2=create dw_2
this.dw_1=create dw_1
this.dw_interface=create dw_interface
this.st_horizontal=create st_horizontal
this.uo_option=create uo_option
this.uo_pipe=create uo_pipe
this.uo_button=create uo_button
this.st_vertical=create st_vertical
this.st_date=create st_date
this.uo_date=create uo_date
this.ddlb_1=create ddlb_1
this.Control[]={this.cb_option_post,&
this.cb_down,&
this.cbx_check,&
this.uo_parameter,&
this.dw_2,&
this.dw_1,&
this.dw_interface,&
this.st_horizontal,&
this.uo_option,&
this.uo_pipe,&
this.uo_button,&
this.st_vertical,&
this.st_date,&
this.uo_date,&
this.ddlb_1}
end on

on w_wip_run.destroy
destroy(this.cb_option_post)
destroy(this.cb_down)
destroy(this.cbx_check)
destroy(this.uo_parameter)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.dw_interface)
destroy(this.st_horizontal)
destroy(this.uo_option)
destroy(this.uo_pipe)
destroy(this.uo_button)
destroy(this.st_vertical)
destroy(this.st_date)
destroy(this.uo_date)
destroy(this.ddlb_1)
end on

event closequery;UnsignedLong ul_handle

ul_handle = SQLCA.DBHandle()

If IsNull(ul_handle) Or ul_handle < 0 Then
	Connect Using SQLCA;
End If

wf_disconnect()

end event

event open;il_hidden_color = BackColor
st_horizontal.BackColor	= il_hidden_color
st_vertical.BackColor	= il_hidden_color

wf_dw_init(3)

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

dw_1.Resize(li_uo_w / 2, li_pipe_h - uo_pipe.Height - (2 * ii_window_border))
dw_1.Move(li_uo_x, uo_pipe.Y + uo_pipe.Height)

dw_2.Resize(li_uo_w / 2, li_pipe_h - uo_pipe.Height - (2 * ii_window_border))
dw_2.Move(li_uo_x + (li_uo_w / 2), uo_pipe.Y + uo_pipe.Height)

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

type cb_option_post from commandbutton within w_wip_run
integer x = 3561
integer y = 868
integer width = 256
integer height = 88
integer taborder = 110
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "옵션"
end type

event clicked;//-- 이월후 옵션 체크
string ls_plant, ls_dvsn
integer li_rtn, li_selrow

dw_2.dataobject = 'd_wip_option_wip004'
dw_2.settransobject(sqlca)

li_selrow = dw_interface.getselectedrow(0)
ls_plant= dw_interface.GetItemString( li_selrow, 'wip_plant')
ls_dvsn = mid(dw_interface.GetItemString( li_selrow, 'wip_gubun'),4,1)
is_applydate = uo_parameter.dw_1.getItemString( 1, 'wzeddt')
li_rtn = MessageBox("확인", ls_plant + ls_dvsn + ": 마감월 : " + is_applydate + " 에 대해 호환조정작업을 하시겠습니까" &
			, Exclamation!, OKCancel!, 2)
if li_rtn = 2 then return 0

if f_wip_option_post_summary('01',ls_plant,ls_dvsn,is_applydate,dw_2) then
	// Error Update
	dw_2.accepttext()
	f_wip_null_chk(dw_2)
	f_wip_inptid(dw_2)
	If dw_2.Update() <> 1 Then
		Messagebox("확인","wip004 update 에러")
	End If	
end if

return 0
end event

type cb_down from commandbutton within w_wip_run
integer x = 3255
integer y = 868
integer width = 251
integer height = 88
integer taborder = 100
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "DOWN"
end type

event clicked;f_save_to_excel(dw_2)
end event

type cbx_check from checkbox within w_wip_run
integer x = 2651
integer y = 184
integer width = 635
integer height = 80
integer taborder = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "재공수불체크용"
boolean checked = true
end type

type uo_parameter from u_parameter_wip within w_wip_run
event destroy ( )
integer x = 1248
integer y = 256
integer width = 2601
integer height = 564
integer taborder = 50
end type

on uo_parameter.destroy
call u_parameter_wip::destroy
end on

type dw_2 from datawindow within w_wip_run
integer x = 1979
integer y = 1076
integer width = 1097
integer height = 372
integer taborder = 70
string dataobject = "d_description"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(currentrow, True)
End If
end event

type dw_1 from datawindow within w_wip_run
integer x = 1257
integer y = 1076
integer width = 699
integer height = 372
integer taborder = 60
string dataobject = "d_job_result"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(currentrow, True)
End If
end event

type dw_interface from datawindow within w_wip_run
integer y = 4
integer width = 1225
integer height = 1284
integer taborder = 10
string dataobject = "d_wip_prelist"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;String ls_plant, ls_dvsn
If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(currentrow, True)

	uo_pipe.st_read.Text		= ''
	uo_pipe.st_written.Text	= ''
	uo_pipe.st_error.Text	= ''
	uo_pipe.st_time.Text		= ''

	is_wip_plant = This.GetItemString(currentrow, 'wip_plant')
	is_wip_gubun = This.GetItemString(currentrow, 'wip_gubun')
	is_wip_id = This.GetItemString(currentrow, 'wip_id')
	is_wip_desc = This.GetItemString(currentrow, 'wzdesc')
	
	st_vertical.SetPosition(ToTop!)
	st_horizontal.SetPosition(ToTop!)	
End If
end event

event rowfocuschanging;Int		rowcount
String   ls_plant, ls_gubun
//ii_interface_id = GetItemNumber(newrow, 'InterfaceID')
is_wip_plant = This.GetItemString(newrow, 'wip_plant')
is_wip_gubun = This.GetItemString(newrow, 'wip_gubun')
is_wip_id = This.GetItemString(newrow, 'wip_id')
is_wip_desc = This.GetItemString(newrow, 'wzdesc')

If is_wip_gubun = 'ALL' Then
	ls_plant = 'D'
	ls_gubun = 'WIPA' + This.GetItemString(newrow, 'wip_id')
Else
	ls_plant = is_wip_plant
	ls_gubun = is_wip_gubun
End If

CHOOSE CASE uo_parameter.Event Trigger ue_retrieve(ls_plant, ls_gubun, rowcount)
	CASE 'Y', 'N'
		Return 0
	CASE 'C', 'F'
		Return 1
END CHOOSE
	
	
end event

type st_horizontal from u_st_horizontal within w_wip_run
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

type uo_option from u_interface_option within w_wip_run
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
	Timer(600)
Else
	Timer(0)
End If	

end event

type uo_pipe from u_interface_error within w_wip_run
integer x = 1253
integer y = 832
integer taborder = 90
boolean border = false
end type

on uo_pipe.destroy
call u_interface_error::destroy
end on

event ue_cancel;call super::ue_cancel;ib_upload_stop = True
end event

type uo_button from u_interface_button within w_wip_run
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
	Timer(600)
Else
	// 선택된 Interface 항목에 대해서 Interface 수행
	If dw_interface.getselectedrow(0) > 0 Then

		uo_pipe.cb_repair.Enabled	= False
		uo_pipe.cb_cancel.Enabled	= True
		uf_button_enable(False, False, False)
		uo_parameter.Enabled	= False
		dw_interface.Enabled	= False
		uo_option.Enabled		= False
		uo_date.Enabled		= False
		
		//If (uo_parameter.dw_1.GetItemString(1, 'wzstscd') = '2' And wf_get_prejob()) then
			If wf_wiprun() then
				//pass
			end if
		//End If
		
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

type st_vertical from u_st_vertical within w_wip_run
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

type st_date from statictext within w_wip_run
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
string text = "Work Date :"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_date from u_today within w_wip_run
integer x = 2633
integer y = 988
integer taborder = 80
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

type ddlb_1 from dropdownlistbox within w_wip_run
integer x = 2967
integer y = 28
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
boolean sorted = false
string item[] = {"이월전마감","이월후마감"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
If index = 1 Then
	is_cycle = 'PRE'
	cb_option_post.enabled = false
	dw_interface.dataobject = 'd_wip_prelist'
	dw_interface.settransobject(sqlca)
	dw_interface.retrieve()
ElseIf index = 2 Then
	is_cycle	= 'POST'
	cb_option_post.enabled = true
	dw_interface.dataobject = 'd_wip_postlist'
	dw_interface.settransobject(sqlca)
	dw_interface.retrieve()
End If	

end event

