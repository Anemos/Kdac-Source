$PBExportHeader$w_tmm210u.srw
$PBExportComments$의뢰서접수관리(의뢰자용)
forward
global type w_tmm210u from w_ipis_sheet01
end type
type dw_tmm210u_02 from datawindow within w_tmm210u
end type
type dw_report from datawindow within w_tmm210u
end type
type st_1 from statictext within w_tmm210u
end type
type sle_orderno from singlelineedit within w_tmm210u
end type
type st_2 from statictext within w_tmm210u
end type
type st_3 from statictext within w_tmm210u
end type
type sle_dept from singlelineedit within w_tmm210u
end type
type pb_finddept from picturebutton within w_tmm210u
end type
type st_4 from statictext within w_tmm210u
end type
type uo_tmgubun from u_tmm_select_tmgubun within w_tmm210u
end type
type dw_tmm210u_01 from u_vi_std_datawindow within w_tmm210u
end type
type pb_down from picturebutton within w_tmm210u
end type
type gb_1 from groupbox within w_tmm210u
end type
end forward

global type w_tmm210u from w_ipis_sheet01
integer width = 4448
integer height = 2136
dw_tmm210u_02 dw_tmm210u_02
dw_report dw_report
st_1 st_1
sle_orderno sle_orderno
st_2 st_2
st_3 st_3
sle_dept sle_dept
pb_finddept pb_finddept
st_4 st_4
uo_tmgubun uo_tmgubun
dw_tmm210u_01 dw_tmm210u_01
pb_down pb_down
gb_1 gb_1
end type
global w_tmm210u w_tmm210u

forward prototypes
public function integer wf_delete_chk (string ag_orderno)
end prototypes

public function integer wf_delete_chk (string ag_orderno);//-------------
// 의뢰건에 대한 결과정보가 있는경우 return -1, 없으면 return 0
//-------------
integer li_count

SELECT COUNT(*) INTO :li_count FROM PBGMS.TMM003
WHERE ORDERNO = :ag_orderno
using sqlca;

if sqlca.sqlcode <> 0 or li_count > 0 then
	return -1
else
	return 0
end if
end function

on w_tmm210u.create
int iCurrent
call super::create
this.dw_tmm210u_02=create dw_tmm210u_02
this.dw_report=create dw_report
this.st_1=create st_1
this.sle_orderno=create sle_orderno
this.st_2=create st_2
this.st_3=create st_3
this.sle_dept=create sle_dept
this.pb_finddept=create pb_finddept
this.st_4=create st_4
this.uo_tmgubun=create uo_tmgubun
this.dw_tmm210u_01=create dw_tmm210u_01
this.pb_down=create pb_down
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tmm210u_02
this.Control[iCurrent+2]=this.dw_report
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_orderno
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.sle_dept
this.Control[iCurrent+8]=this.pb_finddept
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.uo_tmgubun
this.Control[iCurrent+11]=this.dw_tmm210u_01
this.Control[iCurrent+12]=this.pb_down
this.Control[iCurrent+13]=this.gb_1
end on

on w_tmm210u.destroy
call super::destroy
destroy(this.dw_tmm210u_02)
destroy(this.dw_report)
destroy(this.st_1)
destroy(this.sle_orderno)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_dept)
destroy(this.pb_finddept)
destroy(this.st_4)
destroy(this.uo_tmgubun)
destroy(this.dw_tmm210u_01)
destroy(this.pb_down)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_tmm210u_01.Width = newwidth 	- ( ls_gap * 4 )
dw_tmm210u_01.Height= ( newheight * 3 / 7 ) - dw_tmm210u_01.y

dw_tmm210u_02.x = dw_tmm210u_01.x
dw_tmm210u_02.y = dw_tmm210u_01.y + dw_tmm210u_01.Height + ls_split
dw_tmm210u_02.Width = dw_tmm210u_01.Width
dw_tmm210u_02.Height = newheight - ( dw_tmm210u_01.y + dw_tmm210u_01.Height + ls_split + ls_status)


end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc
dw_tmm210u_01.SetTransObject(sqlca)
dw_tmm210u_02.SetTransObject(sqlca)
dw_report.settransobject(sqlca)

dw_tmm210u_01.GetChild('ingstatus', ldwc)
ldwc.settransobject(sqlca)
ldwc.retrieve('TMM005')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_tmm210u_02.GetChild('ingstatus', ldwc)
ldwc.settransobject(sqlca)
ldwc.retrieve('TMM005')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_tmm210u_02,'ingstatus',ldwc,'codename',5)

dw_tmm210u_02.GetChild('productid', ldwc)
ldwc.settransobject(sqlca)
ldwc.retrieve()
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_tmm210u_02,'productid',ldwc,'displayname',5)


sle_orderno.setfocus()
end event

event ue_retrieve;call super::ue_retrieve;long ll_rowcnt
string ls_orderno, ls_orderdept, ls_tmgubun

dw_tmm210u_01.reset()
dw_tmm210u_02.reset()

ls_orderno = trim(sle_orderno.text)
ls_orderdept = trim(sle_dept.text)
ls_tmgubun = uo_tmgubun.is_uo_cocode

if f_spacechk(ls_orderdept) <> -1 then
	SELECT COUNT(*) INTO :ll_rowcnt
	FROM "PBCOMMON"."DAC001"  
	WHERE ( "PBCOMMON"."DAC001"."DCODE" = :ls_orderdept ) AND
			( "PBCOMMON"."DAC001"."DUSE" = ' ' ) AND
			( "PBCOMMON"."DAC001"."DTODT" = 0 ) AND
			( "PBCOMMON"."DAC001"."DACTTODT" = 0  )
	using sqlca;
	if ll_rowcnt = 0 then
		uo_status.st_message.text = "의뢰부서가 잘못 입력되었습니다."
		return 0
	end if
else
	ls_orderdept = '%'
end if

if f_spacechk(ls_orderno) = -1 then
	ls_orderno = '%'
else
	ls_orderno = ls_orderno + '%'
end if

ll_rowcnt = dw_tmm210u_01.retrieve(ls_orderno, ls_orderdept, ls_tmgubun)

if ll_rowcnt < 1 then
	uo_status.st_message.text = "조회된 의뢰정보가 없습니다."
else
	uo_status.st_message.text = "조회되었습니다."
end if

return 0
end event

event ue_insert;call super::ue_insert;long ll_selrow

ll_selrow = dw_tmm210u_01.getselectedrow(0)
dw_tmm210u_02.reset()
dw_tmm210u_02.insertrow(0)
if ll_selrow > 0 then
	dw_tmm210u_02.setitem( 1, "TMGUBUN", dw_tmm210u_01.getitemstring(ll_selrow,"TMGUBUN") )
	dw_tmm210u_02.setitem( 1, "DEPTGUBUN", dw_tmm210u_01.getitemstring(ll_selrow,"DEPTGUBUN") )
	dw_tmm210u_02.setitem( 1, "ORDERMAN", dw_tmm210u_01.getitemstring(ll_selrow,"ORDERMAN") )
	dw_tmm210u_02.setitem( 1, "ORDERDEPT", dw_tmm210u_01.getitemstring(ll_selrow,"ORDERDEPT") )
	dw_tmm210u_02.setitem( 1, "PRODUCTID", dw_tmm210u_01.getitemstring(ll_selrow,"PRODUCTID") )
	dw_tmm210u_02.setitem( 1, "ITEMCODE", dw_tmm210u_01.getitemstring(ll_selrow,"ITEMCODE") )
	dw_tmm210u_02.setitem( 1, "ITEMNAME", dw_tmm210u_01.getitemstring(ll_selrow,"ITEMNAME") )
	dw_tmm210u_02.setitem( 1, "PROJECTNO", dw_tmm210u_01.getitemstring(ll_selrow,"PROJECTNO") )
	dw_tmm210u_02.setitem( 1, "ITEMSPEC", dw_tmm210u_01.getitemstring(ll_selrow,"ITEMSPEC") )
	dw_tmm210u_02.setitem( 1, "TESTITEM", dw_tmm210u_01.getitemstring(ll_selrow,"TESTITEM") )
	dw_tmm210u_02.setitem( 1, "RELATIVENAME", dw_tmm210u_01.getitemstring(ll_selrow,"RELATIVENAME") )
	dw_tmm210u_02.setitem( 1, "FOREDATE", dw_tmm210u_01.getitemstring(ll_selrow,"FOREDATE") )
	dw_tmm210u_02.setitem( 1, "ORDERCONTENT", dw_tmm210u_01.getitemstring(ll_selrow,"ORDERCONTENT") )
	dw_tmm210u_02.setitem( 1, "URGENTFLAG", dw_tmm210u_01.getitemstring(ll_selrow,"URGENTFLAG") )
	dw_tmm210u_02.setitem( 1, "MEMO", dw_tmm210u_01.getitemstring(ll_selrow,"MEMO") )
else
	dw_tmm210u_02.setitem( 1, "deptgubun", '1' )
	dw_tmm210u_02.setitem( 1, "testitem", 'R' )
	dw_tmm210u_02.setitem( 1, "urgentflag", 'N' )
end if

dw_tmm210u_02.setitem( 1, "ingstatus", 'A' )
dw_tmm210u_02.setitem( 1, "orderdate", g_s_date )
dw_tmm210u_02.setitem( 1, "orderempno", g_s_empno )
dw_tmm210u_02.setitem( 1, "lastemp", g_s_empno )
dw_tmm210u_02.setitem( 1, "lastdate", g_s_datetime )

dw_tmm210u_02.object.tmgubun.protect = 0
dw_tmm210u_02.object.tmgubun.Background.Color = 15780518

// Project No 필드 초기화
//dw_tmm210u_02.object.projectno.protect = 1
//dw_tmm210u_02.object.projectno.background.color = rgb(192,192,192)
dw_tmm210u_02.object.b_order.enabled = false
dw_tmm210u_02.object.projectno.protect = 0
dw_tmm210u_02.object.projectno.background.color = rgb(255,255,255)

uo_status.st_message.text = "시험/측정 의뢰정보를 입력하십시요."

end event

event ue_save;call super::ue_save;String ls_orderno, ls_tmgubun, ls_error
integer li_findrow

dw_tmm210u_02.accepttext()
if dw_tmm210u_02.modifiedcount() < 1 then
	uo_status.st_message.text = "저장할 정보가 없습니다."
	return -1
end if
if f_tmm_mandantory_chk(dw_tmm210u_02) = -1 then
	uo_status.st_message.text = "필수입력사항을 입력하십시요."
	return -1
end if

// Project Code 체크

// 끝
ls_orderno = dw_tmm210u_02.getitemstring( 1, "orderno")
ls_tmgubun = dw_tmm210u_02.getitemstring( 1, "tmgubun")

if f_spacechk(ls_orderno) = -1 then
	// 신규금형에 대한 OrderNo 가져오기
	if ls_tmgubun = 'T' then
		ls_orderno = f_tmm_get_serialno('COT', ls_error)
	else
		ls_orderno = f_tmm_get_serialno('COM', ls_error)
	end if
	if ls_orderno = 'X' then
		uo_status.st_message.text = ls_error
		return 0
	end if
	ls_orderno = ls_tmgubun + ls_orderno
	dw_tmm210u_02.setitem(1, "orderno", ls_orderno)
end if

sqlca.AutoCommit = False

if dw_tmm210u_02.update() = 1 then
	Commit using sqlca;
	sqlca.AutoCommit = True
	
	uo_tmgubun.wf_select_item(ls_tmgubun)
	
	This.Triggerevent("ue_retrieve")
	li_findrow = dw_tmm210u_01.find("orderno = '" + ls_orderno + "'", 1, dw_tmm210u_01.rowcount())
	if li_findrow > 0 then
		dw_tmm210u_01.Post Event RowFocusChanged(li_findrow)
		dw_tmm210u_01.scrolltorow(li_findrow)
		dw_tmm210u_01.setrow(li_findrow)
	end if

	uo_status.st_message.text = "저장되었습니다."
else
	RollBack using sqlca;
	sqlca.AutoCommit = True
	uo_status.st_message.text = "저장이 실패했습니다."
end if

return 0
end event

event ue_delete;call super::ue_delete;//-------------------------------------------------------------
// 금형의뢰건은 진행상태가 의뢰접수인 경우에만 삭제할 수 있다.
//-------------------------------------------------------------
integer li_selrow, li_rtn
string ls_orderno, ls_ingstatus

li_selrow = dw_tmm210u_01.getselectedrow(0)

if li_selrow < 1 then
	uo_status.st_message.text = '선택된 데이타가 없습니다.'
	return 0
end if

ls_orderno = dw_tmm210u_01.getitemstring(li_selrow,'orderno')
ls_ingstatus = dw_tmm210u_01.getitemstring(li_selrow,'ingstatus')

if wf_delete_chk(ls_orderno) = -1 or ls_ingstatus <> 'A' then
	uo_status.st_message.text = '해당 의뢰건은 접수되어 절차가 진행중에 있습니다. 삭제할수 없습니다.'
	return 0
end if

li_rtn = MessageBox("확인", ls_orderno + " 의뢰건을 삭제하시겠습니까?" &
				, Exclamation!, OKCancel!, 2)
if li_rtn = 2 then
	return 0
end if

sqlca.Autocommit = False

DELETE FROM PBGMS.TMM002
WHERE ORDERNO = :ls_orderno
		using sqlca;
		
if sqlca.sqlcode = 0 then
	Commit using sqlca;
	sqlca.Autocommit = True
	
	iw_this.Triggerevent('ue_retrieve')
	uo_status.st_message.text = '정상적으로 처리되었습니다.'
else
	RollBack using sqlca;
	sqlca.Autocommit = True
	li_selrow = dw_tmm210u_01.find("orderno = '" + ls_orderno + "'", 1, dw_tmm210u_01.rowcount())
	if li_selrow > 0 then
		dw_tmm210u_01.Post Event RowFocusChanged(li_selrow)
		dw_tmm210u_01.scrolltorow(li_selrow)
		dw_tmm210u_01.setrow(li_selrow)
	end if
	uo_status.st_message.text = '삭제시에 에러가 발생하였습니다.'
end if
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= True
i_b_save 		= True
i_b_delete 		= True
i_b_print 		= True
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event ue_print;call super::ue_print;long ll_selrow
string ls_orderno, mod_string, ls_ingstatus
window 	l_to_open
str_easy l_str_prt

ll_selrow = dw_tmm210u_01.getselectedrow(0)
if ll_selrow > 0 then
	ls_orderno = dw_tmm210u_01.getitemstring(ll_selrow,"orderno")
	ls_ingstatus = dw_tmm210u_01.getitemstring(ll_selrow,"ingstatus")
	if ls_ingstatus = 'A' then
		sqlca.autocommit = false
		
		UPDATE PBGMS.TMM002
		SET Ingstatus = 'B',
			Orderdate = :g_s_date
		WHERE OrderNo = :ls_orderno 
		using sqlca;
		
		if sqlca.sqlnrows > 0 then
			commit using sqlca;
			sqlca.autocommit = true
		else
			rollback using sqlca;
			sqlca.autocommit = true
			uo_status.st_message.text = "진행상태 저장중에 에러가 발생했습니다."
			return 0
		end if	
	end if
else
	uo_status.st_message.text = "출력할 의뢰건이 선택되지 않았습니다."
	return 0
end if

//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

dw_report.reset()
dw_report.retrieve(ls_orderno)

l_str_prt.title = "시험/측정의뢰서 출력"
if mid(ls_orderno,1,1) = 'T' then
	mod_string =  "t_3.text = '시험의뢰서'"	
else
	mod_string =  "t_3.text = '측정의뢰서'"
end if

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax     = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		

uo_status.st_message.Text = ""
return 0

end event

type uo_status from w_ipis_sheet01`uo_status within w_tmm210u
end type

type dw_tmm210u_02 from datawindow within w_tmm210u
integer x = 18
integer y = 944
integer width = 3525
integer height = 860
boolean bringtotop = true
string title = "none"
string dataobject = "d_tmm210u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;string ls_gubun, ls_rtnparm, ls_rtn, ls_divcode
datawindowchild ldwc

choose case dwo.name 
	case 'b_dept'
		ls_gubun = This.getitemstring(1, 'deptgubun')
		
		openwithparm(w_tmm_find_dept,ls_gubun)
		ls_rtnparm = message.stringparm
		if f_spacechk(ls_rtnparm) <> -1 then
			This.setitem( 1, 'orderdept', ls_rtnparm )
			
			if ls_gubun = '1' then
				SELECT  "PBCOMMON"."DAC001"."DNAME", "PBCOMMON"."DAC001"."DDIV3" 
				INTO :ls_rtn, :ls_divcode
				FROM "PBCOMMON"."DAC001"  
				WHERE ( "PBCOMMON"."DAC001"."DCODE" = :ls_rtnparm ) AND
						( "PBCOMMON"."DAC001"."DUSE" = ' ' ) AND
						( "PBCOMMON"."DAC001"."DTODT" = 0 ) AND
						( "PBCOMMON"."DAC001"."DACTTODT" = 0  )
				using sqlca;
				
				// 담당이 연구소이면 Project No는 필히 입력해야 함.
				// 연구지원('K'), 기계기술('N'),공조기술('S'),전장기술('T')
				if ls_divcode = 'K' or ls_divcode = 'N' or ls_divcode = 'S' or &
					ls_divcode = 'T' then
					this.object.projectno.protect = 0
					this.object.projectno.background.color = 15780518
				else
					this.object.projectno.protect = 1
					this.object.projectno.background.color = rgb(192,192,192)
				end if
			else
				SELECT Suppliername INTO :ls_rtn
				FROM PBGMS.TMM001
				WHERE SupplierCode = :ls_rtnparm
				using sqlca;
				
				ls_divcode = '0'
			end if
			This.Setitem( row, 'deptnm', ls_rtn )
			
//			This.GetChild('productid', ldwc)
//			ldwc.settransobject(sqlca)
//			ldwc.retrieve(ls_divcode)
//			if ldwc.RowCount() < 1 then
//				ldwc.InsertRow(0)
//			end if
//			
//			f_pisc_set_dddw_width(This,'productid',ldwc,'displayname',5)
		end if	
	case 'b_order'
		openwithparm(w_tmm_find_testlist, ' ')
		If isnull(message.Stringparm) Or message.Stringparm = '' then
			return 0
		Else
			ls_rtnparm = Message.StringParm   // powerobject
		End If	
		
		This.SetItem(row, 'ordercontent', ls_rtnparm)
end choose
end event

event itemchanged;String 	ls_colName, ls_deptgubun, ls_chkdata, ls_rtn, ls_divcode
datawindowchild ldwc

this.AcceptText ( )

This.setitem( row, "lastemp", g_s_empno )
This.setitem( row, "lastdate", g_s_datetime )

ls_colName = dwo.name
Choose Case ls_colName
	Case 'deptgubun'
		This.Setitem( row, 'orderdept', '' )
	Case 'orderdept'
		ls_deptgubun = This.getitemstring(row, 'deptgubun')
		if ls_deptgubun = '1' then
			ls_chkdata = trim(data)
			
			SELECT  "PBCOMMON"."DAC001"."DNAME", "PBCOMMON"."DAC001"."DDIV3" 
			INTO :ls_rtn, :ls_divcode
    		FROM "PBCOMMON"."DAC001"  
   		WHERE ( "PBCOMMON"."DAC001"."DCODE" = :ls_chkdata ) AND
	   			( "PBCOMMON"."DAC001"."DUSE" = ' ' ) AND
	   			( "PBCOMMON"."DAC001"."DTODT" = 0 ) AND
	   			( "PBCOMMON"."DAC001"."DACTTODT" = 0  )
			using sqlca;
			if sqlca.sqlcode <> 0 then
				Messagebox("확인","해당 사내부서가 존제하지 않습니다.")
				This.Setitem( row, 'orderdept', '' )
				This.Setitem( row, 'deptnm', '' )
				return 1
			else
				This.Setitem( row, 'deptnm', ls_rtn )
				
				// 담당이 연구소이면 Project No는 필히 입력해야 함.
				// 연구지원('K'), 기계기술('N'),공조기술('S'),전장기술('T')
				// rgb(255,255,255), 15780518, 65535
				if ls_divcode = 'K' or ls_divcode = 'N' or ls_divcode = 'S' or &
					ls_divcode = 'T' then
					this.object.projectno.protect = 0
					this.object.projectno.background.color = 15780518
				else
					this.object.projectno.protect = 1
					this.object.projectno.background.color = rgb(192,192,192)
				end if
			end if
		elseif ls_deptgubun = '2' then
			SELECT  SupplierName INTO :ls_rtn
    		FROM PBGMS.TMM001
   		WHERE SupplierCode = :ls_chkdata
			using sqlca;
			
			if f_spacechk(ls_chkdata) = -1 then
				Messagebox("확인","해당 사외업체가 존제하지 않습니다.")
				This.Setitem( row, 'orderdept', '' )
				This.Setitem( row, 'deptnm', '' )
				return 1
			else
				This.Setitem( row, 'deptnm', ls_rtn )
			end if
		end if
	Case 'tmgubun'
		if trim(data) = 'T' then
			// 시험분석에 대한 필드 초기화
			// 1. 의뢰내용직접입력 불가
			this.object.b_order.enabled = true
//			this.object.ordercontent.protect = 1
//			this.object.ordercontent.background.color = rgb(192,192,192)
		else
			this.object.b_order.enabled = false
//			this.object.ordercontent.protect = 0
//			this.object.ordercontent.background.color = rgb(255,255,255)
		end if
End Choose
end event

type dw_report from datawindow within w_tmm210u
boolean visible = false
integer x = 2793
integer y = 156
integer width = 686
integer height = 400
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_tmm210u_03p"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_tmm210u
integer x = 928
integer y = 64
integer width = 334
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "접수번호:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_orderno from singlelineedit within w_tmm210u
integer x = 1248
integer y = 48
integer width = 635
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 0
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_tmm210u
integer x = 3141
integer y = 36
integer width = 1189
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 16777215
string text = "의뢰서출력은 인쇄아이콘 클릭!"
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_3 from statictext within w_tmm210u
integer x = 1906
integer y = 68
integer width = 325
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "의뢰부서:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_dept from singlelineedit within w_tmm210u
integer x = 2226
integer y = 48
integer width = 293
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type pb_finddept from picturebutton within w_tmm210u
integer x = 2537
integer y = 40
integer width = 238
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\KDAC\bmp\search.gif"
end type

event clicked;string ls_rtnparm

openwithparm(w_tmm_find_dept,'1')
ls_rtnparm = message.stringparm
if f_spacechk(ls_rtnparm) <> -1 then
	sle_dept.text = ls_rtnparm	
end if	
end event

type st_4 from statictext within w_tmm210u
integer x = 3141
integer y = 104
integer width = 1189
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 16777215
string text = "의뢰서를 출력해야 접수처리됩니다."
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type uo_tmgubun from u_tmm_select_tmgubun within w_tmm210u
integer x = 46
integer y = 48
integer height = 92
integer taborder = 40
boolean bringtotop = true
end type

on uo_tmgubun.destroy
call u_tmm_select_tmgubun::destroy
end on

type dw_tmm210u_01 from u_vi_std_datawindow within w_tmm210u
integer x = 18
integer y = 176
integer width = 3525
integer height = 752
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_tmm210u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_orderno, ls_deptgubun, ls_orderdept, ls_rtn, ls_divcode, ls_tmgubun
datawindowchild ldwc

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )

ls_orderno = This.getitemstring( currentrow, "orderno")
ls_deptgubun = This.getitemstring( currentrow, "deptgubun")
ls_orderdept = This.getitemstring( currentrow, "orderdept")
ls_tmgubun = This.getitemstring( currentrow, "tmgubun")

if ls_deptgubun = '1' then
	SELECT  "PBCOMMON"."DAC001"."DNAME", "PBCOMMON"."DAC001"."DDIV3" 
	INTO :ls_rtn, :ls_divcode
	FROM "PBCOMMON"."DAC001"  
	WHERE ( "PBCOMMON"."DAC001"."DCODE" = :ls_orderdept ) AND
			( "PBCOMMON"."DAC001"."DUSE" = ' ' ) AND
			( "PBCOMMON"."DAC001"."DTODT" = 0 ) AND
			( "PBCOMMON"."DAC001"."DACTTODT" = 0  )
	using sqlca;

	// 담당이 연구소이면 Project No는 필히 입력해야 함.
	// 연구지원('K'), 기계기술('N'),공조기술('S'),전장기술('T')
	if ls_divcode = 'K' or ls_divcode = 'N' or ls_divcode = 'S' or &
		ls_divcode = 'T' then
		dw_tmm210u_02.object.projectno.protect = 0
		dw_tmm210u_02.object.projectno.background.color = rgb(255,255,255)
	else
		dw_tmm210u_02.object.projectno.protect = 1
		dw_tmm210u_02.object.projectno.background.color = rgb(192,192,192)
	end if
end if

dw_tmm210u_02.object.tmgubun.protect = 1
dw_tmm210u_02.object.tmgubun.background.color = rgb(192,192,192)

dw_tmm210u_02.retrieve(ls_orderno)

if ls_tmgubun = 'T' then
	dw_tmm210u_02.object.b_order.enabled = true
else
	dw_tmm210u_02.object.b_order.enabled = false
end if


end event

type pb_down from picturebutton within w_tmm210u
integer x = 2903
integer y = 36
integer width = 155
integer height = 116
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_tmm210u_01)
end event

type gb_1 from groupbox within w_tmm210u
integer x = 18
integer width = 3099
integer height = 164
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

