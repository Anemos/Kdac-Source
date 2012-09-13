$PBExportHeader$w_tmm230u.srw
$PBExportComments$의뢰서완료현황
forward
global type w_tmm230u from w_ipis_sheet01
end type
type dw_tmm230u_02 from datawindow within w_tmm230u
end type
type dw_report from datawindow within w_tmm230u
end type
type uo_startdate from u_tmm_date_applydate within w_tmm230u
end type
type uo_enddate from u_tmm_date_applydate_1 within w_tmm230u
end type
type st_2 from statictext within w_tmm230u
end type
type st_3 from statictext within w_tmm230u
end type
type sle_dept from singlelineedit within w_tmm230u
end type
type pb_finddept from picturebutton within w_tmm230u
end type
type uo_tmgubun from u_tmm_select_tmgubun within w_tmm230u
end type
type st_1 from statictext within w_tmm230u
end type
type sle_orderno from singlelineedit within w_tmm230u
end type
type dw_tmm230u_01 from u_vi_std_datawindow within w_tmm230u
end type
type gb_1 from groupbox within w_tmm230u
end type
end forward

global type w_tmm230u from w_ipis_sheet01
integer width = 4247
integer height = 2136
dw_tmm230u_02 dw_tmm230u_02
dw_report dw_report
uo_startdate uo_startdate
uo_enddate uo_enddate
st_2 st_2
st_3 st_3
sle_dept sle_dept
pb_finddept pb_finddept
uo_tmgubun uo_tmgubun
st_1 st_1
sle_orderno sle_orderno
dw_tmm230u_01 dw_tmm230u_01
gb_1 gb_1
end type
global w_tmm230u w_tmm230u

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

on w_tmm230u.create
int iCurrent
call super::create
this.dw_tmm230u_02=create dw_tmm230u_02
this.dw_report=create dw_report
this.uo_startdate=create uo_startdate
this.uo_enddate=create uo_enddate
this.st_2=create st_2
this.st_3=create st_3
this.sle_dept=create sle_dept
this.pb_finddept=create pb_finddept
this.uo_tmgubun=create uo_tmgubun
this.st_1=create st_1
this.sle_orderno=create sle_orderno
this.dw_tmm230u_01=create dw_tmm230u_01
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tmm230u_02
this.Control[iCurrent+2]=this.dw_report
this.Control[iCurrent+3]=this.uo_startdate
this.Control[iCurrent+4]=this.uo_enddate
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.sle_dept
this.Control[iCurrent+8]=this.pb_finddept
this.Control[iCurrent+9]=this.uo_tmgubun
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.sle_orderno
this.Control[iCurrent+12]=this.dw_tmm230u_01
this.Control[iCurrent+13]=this.gb_1
end on

on w_tmm230u.destroy
call super::destroy
destroy(this.dw_tmm230u_02)
destroy(this.dw_report)
destroy(this.uo_startdate)
destroy(this.uo_enddate)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_dept)
destroy(this.pb_finddept)
destroy(this.uo_tmgubun)
destroy(this.st_1)
destroy(this.sle_orderno)
destroy(this.dw_tmm230u_01)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_tmm230u_01.Width = newwidth 	- ( ls_gap * 4 )
dw_tmm230u_01.Height= ( newheight * 3 / 6 ) - dw_tmm230u_01.y

dw_tmm230u_02.x = dw_tmm230u_01.x
dw_tmm230u_02.y = dw_tmm230u_01.y + dw_tmm230u_01.Height + ls_split
dw_tmm230u_02.Width = dw_tmm230u_01.Width
dw_tmm230u_02.Height = newheight - ( dw_tmm230u_01.y + dw_tmm230u_01.Height + ls_split + ls_status)


end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc
dw_tmm230u_01.SetTransObject(sqlca)
dw_tmm230u_02.SetTransObject(sqlca)
dw_report.settransobject(sqlca)

dw_tmm230u_01.GetChild('ingstatus', ldwc)
ldwc.settransobject(sqlca)
ldwc.retrieve('TMM005')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_tmm230u_01,'ingstatus',ldwc,'codename',5)
end event

event ue_retrieve;call super::ue_retrieve;long ll_rowcnt
string ls_startdate, ls_enddate, ls_orderdept, ls_orderno, ls_tmgubun

dw_tmm230u_01.reset()
dw_tmm230u_02.reset()

ls_startdate = string(date(uo_startdate.is_uo_date),"yyyymmdd")
ls_enddate = string(date(uo_enddate.is_uo_date),"yyyymmdd")
ls_orderdept = trim(sle_dept.text)
ls_orderno = trim(sle_orderno.text)
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

ll_rowcnt = dw_tmm230u_01.retrieve(ls_startdate, ls_enddate, ls_orderno, ls_orderdept, ls_tmgubun)

if ll_rowcnt < 1 then
	uo_status.st_message.text = "조회된 의뢰정보가 없습니다."
end if
return 0
end event

event ue_save;call super::ue_save;String ls_orderno, ls_tmgubun, ls_error
integer li_findrow

dw_tmm230u_01.accepttext()
if dw_tmm230u_01.modifiedcount() < 1 then
	uo_status.st_message.text = "저장할 정보가 없습니다."
	return -1
end if

sqlca.AutoCommit = False

if dw_tmm230u_01.update() = 1 then
	Commit using sqlca;
	sqlca.AutoCommit = True
	
	This.Triggerevent("ue_retrieve")
	li_findrow = dw_tmm230u_01.find("orderno = '" + ls_orderno + "'", 1, dw_tmm230u_01.rowcount())
	if li_findrow > 0 then
		dw_tmm230u_01.Post Event RowFocusChanged(li_findrow)
		dw_tmm230u_01.scrolltorow(li_findrow)
		dw_tmm230u_01.setrow(li_findrow)
	end if

	uo_status.st_message.text = "저장되었습니다."
else
	RollBack using sqlca;
	sqlca.AutoCommit = True
	uo_status.st_message.text = "저장이 실패했습니다."
end if

return 0
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= True
i_b_delete 		= False
i_b_print 		= False
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

type uo_status from w_ipis_sheet01`uo_status within w_tmm230u
end type

type dw_tmm230u_02 from datawindow within w_tmm230u
integer x = 18
integer y = 944
integer width = 3525
integer height = 860
boolean bringtotop = true
string dataobject = "d_tmm230u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;string ls_gubun, ls_rtnparm, ls_rtn, ls_divcode
datawindowchild ldwc
//str_mpms_xy str_lxy
//
choose case dwo.name 
	case 'b_dept'
		ls_gubun = This.getitemstring(1, 'deptgubun')
		
		openwithparm(w_tmm_find_dept,ls_gubun)
		ls_rtnparm = message.stringparm
		if f_spacechk(ls_rtnparm) <> -1 then
			This.setitem( 1, 'orderdept', ls_rtnparm )
			
			SELECT  "PBCOMMON"."DAC001"."DNAME", "PBCOMMON"."DAC001"."DDIV1" 
			INTO :ls_rtn, :ls_divcode
    		FROM "PBCOMMON"."DAC001"  
   		WHERE ( "PBCOMMON"."DAC001"."DCODE" = :ls_rtnparm ) AND
	   			( "PBCOMMON"."DAC001"."DUSE" = ' ' ) AND
	   			( "PBCOMMON"."DAC001"."DTODT" = 0 ) AND
	   			( "PBCOMMON"."DAC001"."DACTTODT" = 0  )
			using sqlca;
			
			This.Setitem( row, 'deptnm', ls_rtn )

			This.GetChild('productid', ldwc)
			ldwc.settransobject(sqlca)
			ldwc.retrieve(ls_divcode)
			if ldwc.RowCount() < 1 then
				ldwc.InsertRow(0)
			end if
			
			f_pisc_set_dddw_width(This,'productid',ldwc,'displayname',5)
		end if	
//	case 'b_foredate'
//		str_lxy.lx = iw_This.PointerX() - 645
//		str_lxy.ly = iw_This.PointerY() - 270
//		openwithparm(w_mpms_today,str_lxy)
//		If isnull(message.Stringparm) Or message.Stringparm = '' then
//			return 0
//		Else
//			ls_rtnparm = Message.StringParm   // powerobject
//		End If	
//		
//		This.SetItem(row, 'foredate', date(ls_rtnparm))
//	case 'b_duedate'
//		str_lxy.lx = iw_This.PointerX() - 645
//		str_lxy.ly = iw_This.PointerY() - 270
//		openwithparm(w_mpms_today,str_lxy)
//		If isnull(message.Stringparm) Or message.Stringparm = '' then
//			return 0
//		Else
//			ls_rtnparm = Message.StringParm   // powerobject
//		End If	
//		
//		This.SetItem(row, 'duedate', date(ls_rtnparm))
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

//ls_colName = This.GetcolumnName()
ls_colName = dwo.name
Choose Case ls_colName
	Case 'deptgubun'
		This.Setitem( row, 'orderdept', '' )
	Case 'orderdept'
		ls_deptgubun = This.getitemstring(row, 'deptgubun')
		if ls_deptgubun = '1' then
			ls_chkdata = trim(data)
			
			SELECT  "PBCOMMON"."DAC001"."DNAME", "PBCOMMON"."DAC001"."DDIV1" 
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
				messagebox("담당코드", ls_divcode)
				This.GetChild('productid', ldwc)
				ldwc.settransobject(sqlca)
				ldwc.retrieve(ls_divcode)
				if ldwc.RowCount() < 1 then
					ldwc.InsertRow(0)
				end if
				
				f_pisc_set_dddw_width(This,'productid',ldwc,'displayname',5)
				
				// 담당이 연구소이면 Project No는 필히 입력해야 함.
				// 연구지원('K'), 기계기술('N'),공조기술('S'),전장기술('T'),전자기술('Y')
//				if ls_divcode = 'K' or ls_divcode = 'N' or ls_divcode = 'S' or &
//					ls_divcode = 'T' or ls_divcode = 'Y' then
//					This.modify("projectno.Background.Color = 15780518")
//				else
//					this.object.projectno.background.color = rgb(255,255,255)
//				end if
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
			this.object.ordercontent.protect = 1
			this.object.ordercontent.background.color = rgb(192,192,192)
		else
			this.object.b_order.enabled = false
			this.object.ordercontent.protect = 0
			this.object.ordercontent.background.color = rgb(255,255,255)
		end if
End Choose
end event

type dw_report from datawindow within w_tmm230u
boolean visible = false
integer x = 2793
integer y = 156
integer width = 686
integer height = 400
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_mpm120u_03p"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_startdate from u_tmm_date_applydate within w_tmm230u
integer x = 69
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_startdate.destroy
call u_tmm_date_applydate::destroy
end on

type uo_enddate from u_tmm_date_applydate_1 within w_tmm230u
integer x = 841
integer y = 60
integer taborder = 30
boolean bringtotop = true
end type

on uo_enddate.destroy
call u_tmm_date_applydate_1::destroy
end on

type st_2 from statictext within w_tmm230u
integer x = 745
integer y = 68
integer width = 96
integer height = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_tmm230u
integer x = 3136
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

type sle_dept from singlelineedit within w_tmm230u
integer x = 3461
integer y = 48
integer width = 293
integer height = 88
integer taborder = 40
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

type pb_finddept from picturebutton within w_tmm230u
integer x = 3776
integer y = 40
integer width = 238
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\KDAC\bmp\search.gif"
end type

event clicked;string ls_rtnparm

openwithparm(w_tmm_find_dept,'1')
ls_rtnparm = message.stringparm
if f_spacechk(ls_rtnparm) <> -1 then
	sle_dept.text = ls_rtnparm	
end if	
end event

type uo_tmgubun from u_tmm_select_tmgubun within w_tmm230u
integer x = 1339
integer y = 48
integer height = 92
integer taborder = 50
boolean bringtotop = true
end type

on uo_tmgubun.destroy
call u_tmm_select_tmgubun::destroy
end on

type st_1 from statictext within w_tmm230u
integer x = 2199
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

type sle_orderno from singlelineedit within w_tmm230u
integer x = 2514
integer y = 48
integer width = 544
integer height = 88
integer taborder = 50
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

type dw_tmm230u_01 from u_vi_std_datawindow within w_tmm230u
integer x = 18
integer y = 176
integer width = 3525
integer height = 752
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_tmm230u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event itemchanged;call super::itemchanged;string ls_colname, ls_orderno, ls_enddate, ls_tmgubun, ls_signflag

this.AcceptText ( )

ls_colName = dwo.name
Choose Case ls_colName
	Case 'ingstatus'
		ls_tmgubun = dw_tmm230u_01.getitemstring(row,"tmgubun")
		ls_orderno = dw_tmm230u_01.getitemstring(row,"orderno")
		ls_enddate = dw_tmm230u_01.getitemstring(row,"enddate")
		
		if ls_tmgubun = 'T' then
			SELECT Confirmflag INTO :ls_signflag
			FROM PBGMS.TMM007
			WHERE Workdate = :ls_enddate AND Tmgubun = :ls_tmgubun
			using sqlca;
		else
			SELECT Sanctionflag INTO :ls_signflag
			FROM PBGMS.TMM007
			WHERE Workdate = :ls_enddate AND Tmgubun = :ls_tmgubun
			using sqlca;
		end if
		
		if Not isnull(ls_signflag) and ls_signflag = 'Y' then
			uo_status.st_message.text = "결재가 완료된 날짜입니다."
			This.Setitem( row, 'ingstatus', 'D' )
			return 1
		else
			if data <> 'D' then
				This.setitem( row, "lastemp", g_s_empno )
				This.setitem( row, "lastdate", g_s_datetime )
				This.setitem( row, "enddate", '' )
			end if
		end if
End Choose

return 0
end event

event rowfocuschanged;call super::rowfocuschanged;String ls_orderno, ls_tmgubun
datawindowchild ldwc

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )

ls_orderno = This.getitemstring( currentrow, "orderno")
ls_tmgubun = This.getitemstring( currentrow, "tmgubun")

dw_tmm230u_02.GetChild('toolid', ldwc)
ldwc.settransobject(sqlca)
ldwc.retrieve(ls_tmgubun)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_tmm230u_02,'toolid',ldwc,'codename',5)

dw_tmm230u_02.retrieve(ls_orderno)
end event

type gb_1 from groupbox within w_tmm230u
integer x = 18
integer width = 4069
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

