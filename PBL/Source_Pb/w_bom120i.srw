$PBExportHeader$w_bom120i.srw
$PBExportComments$BOM 승인 및 승인내역 조회
forward
global type w_bom120i from w_origin_sheet02
end type
type dw_retrieve from datawindow within w_bom120i
end type
type st_date from statictext within w_bom120i
end type
type uo_from from uo_today_bom within w_bom120i
end type
type uo_to from uo_today_bom within w_bom120i
end type
type st_date_1 from statictext within w_bom120i
end type
type st_2 from statictext within w_bom120i
end type
type ddlb_gubun from dropdownlistbox within w_bom120i
end type
type dw_detail from datawindow within w_bom120i
end type
type cb_accept from commandbutton within w_bom120i
end type
type cb_cancel from commandbutton within w_bom120i
end type
type gb_1 from groupbox within w_bom120i
end type
type str_bomdata_info from structure within w_bom120i
end type
end forward

type str_bomdata_info from structure
	string		it_wkct
	string		it_opcd
	string		it_edtm
	string		it_edte
end type

global type w_bom120i from w_origin_sheet02
integer width = 4658
integer height = 2752
string title = "History 조회"
dw_retrieve dw_retrieve
st_date st_date
uo_from uo_from
uo_to uo_to
st_date_1 st_date_1
st_2 st_2
ddlb_gubun ddlb_gubun
dw_detail dw_detail
cb_accept cb_accept
cb_cancel cb_cancel
gb_1 gb_1
end type
global w_bom120i w_bom120i

type variables
string	is_inchk,	is_plchk,	is_dlchk,	is_emp_in,	 is_emp_pl,	is_emp_dl,	is_in_empno	=	'',		is_pl_empno	=	'',		is_dl_empno	=	''

end variables

forward prototypes
public function integer wf_sendmail (string as_mailaddress, string as_subject, string as_body, string as_attach)
end prototypes

public function integer wf_sendmail (string as_mailaddress, string as_subject, string as_body, string as_attach);////////////////////////////////////////////////////////////////////////////////////////////
// * 메일 보내기 *                                                  
//
// Argument: {MailAddress(보낼사람 메일주소), Subject(제목), Body(내용), Attach(첨부파일)}
////////////////////////////////////////////////////////////////////////////////////////////

//메일 주소 Check
If Len(as_MailAddress) < 1 Or Pos(as_MailAddress, "@") = 0 Or Pos(as_MailAddress, ".") = 0 Then
	MessageBox("Error", "이메일 주소가 잘못되었습니다.")
	Return 1
End If

If Match( lower(as_MailAddress), "@kdac.co.kr") = False Then		
	MessageBox("확인", "받는사람 이메일 주소가 잘못되었습니다." &
				+ "~n~r종합정보시스템-관리-인사관리-개인정보수정 개인정보수정화면에서 " &
				+ "~n~받는사람 e-mail주소를 kdac.co.kr메일로 수정토록 조치바람.", Exclamation!)
	Return 1
End If


OLEobject	Mail  // 등록한 컴포넌트를  OLE 객체로 선언.

Mail = Create OLEobject // OLE 객체 생성.

Int Rtn

// 레지스트리에 등록된 외부 컴포넌트(sasmtp.dll)에 Access해서 파워빌더에서 사용가능한
// OLE 객체로 생성.
Rtn = Mail.ConnectToNewObject("SoftArtisans.SMTPMail")

If Rtn <> 0 Then      // Access에 실패하면...
	MessageBox("확인", "자동메일발송 기능을 실행할 수 없습니다. ~n~r GWP에서 KDAC종합정보시스템 메일발송 관련 파일을 다운받아 설치바랍니다!", Exclamation!)
	Return 1
End If


Mail.ContentType 	= 'html'                        // 메일 내용을 HTML 형식으로 보낼것인가 여부를 결정.
Mail.CustomCharSet 	= 	'euc-kr'   					// 문자셋(여기서 한글 관련 
Mail.ContentTransferEncoding =	4						// 본문 내용을 Encoding
Mail.RemoteHost 		=	'smf.kdac.co.kr'              // SMTP 서버(우리는 Notes!!) 설정.
Mail.FromAddress		= f_Empno_MailAddr( g_s_empno )  // 보내는 사람 주소 설정.
Mail.FromName  = g_s_empno + " " + g_s_kornm    // 보내는 사람 이름 설정.
Mail.AddRecipient('', as_MailAddress ) // 받는 사람 메일주소 설정.

Mail.Subject 				= 	as_subject					// 제목
Mail.Live 					= 	TRUE 							// 
Mail.HtmlText 				= 	as_Body 						//본문 내용
Mail.SMTPLog 			=	"c:\kdac\smtplog.txt"		// 메일 전송 Log파일을 해당 PC에 기록(현재 버전에서는 전체 Log 관리가 아닌 1회 Log만 관리)

If as_Attach <> "" Then Mail.AddAttachment( as_Attach )  // 파일 첨부.

Mail.SendMail                         //   --->  메일 발송.

//버퍼를 지운다. 
Mail.ClearAllRecipients() 
Mail.ClearAttachments() 
Mail.ClearBCCs() 
Mail.ClearBodyText() 
Mail.ClearCCs() 
Mail.ClearExtraHeaders() 
Mail.ClearRecipients() 
Destroy Mail

MessageBox("확인!"," 승인요청 메일이 발송 되었습니다.")

Return 0
end function

on w_bom120i.create
int iCurrent
call super::create
this.dw_retrieve=create dw_retrieve
this.st_date=create st_date
this.uo_from=create uo_from
this.uo_to=create uo_to
this.st_date_1=create st_date_1
this.st_2=create st_2
this.ddlb_gubun=create ddlb_gubun
this.dw_detail=create dw_detail
this.cb_accept=create cb_accept
this.cb_cancel=create cb_cancel
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_retrieve
this.Control[iCurrent+2]=this.st_date
this.Control[iCurrent+3]=this.uo_from
this.Control[iCurrent+4]=this.uo_to
this.Control[iCurrent+5]=this.st_date_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.ddlb_gubun
this.Control[iCurrent+8]=this.dw_detail
this.Control[iCurrent+9]=this.cb_accept
this.Control[iCurrent+10]=this.cb_cancel
this.Control[iCurrent+11]=this.gb_1
end on

on w_bom120i.destroy
call super::destroy
destroy(this.dw_retrieve)
destroy(this.st_date)
destroy(this.uo_from)
destroy(this.uo_to)
destroy(this.st_date_1)
destroy(this.st_2)
destroy(this.ddlb_gubun)
destroy(this.dw_detail)
destroy(this.cb_accept)
destroy(this.cb_cancel)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;string	ls_in_from	=	' ',ls_pl_from	=	' ',ls_dl_from	=	' ',ls_in_to	=	'9999-12-31',ls_pl_to	=	'9999-12-31',ls_dl_to	=	'9999-12-31'

uo_from.triggerevent("ue_movefocus")
uo_to.triggerevent("ue_movefocus")

if	is_inchk	=	'Y%'	then
	ls_in_from	=	string(f_dateedit(uo_from.is_uo_date),"@@@@-@@-@@ 00:00:01") 
	ls_in_to		=	string(f_dateedit(uo_to.is_uo_date),"@@@@-@@-@@ 23:59:59")	
end if
if	is_plchk	=	'Y%'	or	is_plchk	=	'C%'	then
	ls_pl_from	=	string(f_dateedit(uo_from.is_uo_date),"@@@@-@@-@@ 00:00:01") 
	ls_pl_to		=	string(f_dateedit(uo_to.is_uo_date),"@@@@-@@-@@ 23:59:59")	
end if
if	is_dlchk	=	'Y%'	or	is_dlchk	=	'C%'	then
	ls_dl_from	=	string(f_dateedit(uo_from.is_uo_date),"@@@@-@@-@@ 00:00:01") 
	ls_dl_to		=	string(f_dateedit(uo_to.is_uo_date),"@@@@-@@-@@ 23:59:59")	
end if

if	dw_retrieve.retrieve(ls_in_from,ls_in_to,ls_pl_from,ls_pl_to,ls_dl_from,ls_dl_to,is_inchk,is_plchk,is_dlchk,is_in_empno,is_pl_empno,is_dl_empno)	<	1	then
	messagebox("확인","조회할 항목이 없습니다.")
else
	if	is_emp_in		=	'Y'	and	is_inchk	=	'N%'	then
		cb_accept.visible	=	true
		cb_cancel.visible	=	false
		cb_accept.enabled	=	true
		cb_cancel.enabled	=	false
	elseif	is_emp_pl	=	'Y'	and	is_plchk	=	'N%'	then
		cb_accept.visible	=	true
		cb_cancel.visible	=	true
		cb_accept.enabled	=	true
		cb_cancel.enabled	=	true
	elseif	is_emp_dl	=	'Y'	and	is_dlchk	=	'N%'	then
		cb_accept.visible	=	true
		cb_cancel.visible	=	true
		cb_accept.enabled	=	true
		cb_cancel.enabled	=	true		
	end if
	
//	if	 is_inchk	=	'N%'	then
//		cb_accept.visible	=	true
//		cb_cancel.visible	=	false
//		cb_accept.enabled	=	true
//		cb_cancel.enabled	=	false
//	elseif	is_plchk	=	'N%'	then
//		cb_accept.visible	=	true
//		cb_cancel.visible	=	true
//		cb_accept.enabled	=	true
//		cb_cancel.enabled	=	true
//	elseif	is_dlchk	=	'N%'	then
//		cb_accept.visible	=	true
//		cb_cancel.visible	=	true
//		cb_accept.enabled	=	true
//		cb_cancel.enabled	=	true		
//	end if
end if


end event

event open;call super::open;integer	ln_count

this.uo_status.st_winid.text 	= 	this.classname()
this.uo_status.st_kornm.text 	= 	g_s_kornm
this.uo_status.st_date.text 		=	string(g_s_date, "@@@@-@@-@@")

select	count(*)	into	:ln_count	from	pbpdm.bom018
where	xcmcd =	'01'	and	xinemp	=	:g_s_empno
using	sqlca	;
if	ln_count	>=	1	then
	ddlb_gubun.text	=	'담당자 승인요청대기'
	is_inchk			=	'N%'
	is_plchk			=	'%'
	is_dlchk			=	'%'
	is_emp_in		=	'Y'	
	is_in_empno		=	g_s_empno	+	'%'
	is_pl_empno		=	'%'
	is_dl_empno		=	'%'
	if	dw_retrieve.retrieve('','9999-12-31','','9999-12-31','','9999-12-31',is_inchk,is_plchk,is_dlchk,is_in_empno,is_pl_empno,is_dl_empno)	<	1	then
		uo_status.st_message.text =  "현재 승인요청 대기중인 품목이 없습니다"
	else
		cb_accept.visible	=	true
		cb_cancel.visible	=	false
		cb_accept.enabled	=	true
		cb_cancel.enabled	=	false
	end if
end if

ln_count	=	0 

select	count(*)	into	:ln_count	from	pbpdm.bom018
where	xcmcd =	'01'	and	xplemp	=	:g_s_empno
using	sqlca	;
if	ln_count	>=	1	then
	ddlb_gubun.text	=	'P/L 승인대기'
	is_plchk			=	'N%'
	is_inchk			=	'%'
	is_dlchk			=	'%'
	is_emp_pl		=	'Y'
	is_pl_empno		=	g_s_empno	+	'%'
	is_in_empno		=	'%'
	is_dl_empno		=	'%'
	if	dw_retrieve.retrieve('','9999-12-31','','9999-12-31','','9999-12-31',is_inchk,is_plchk,is_dlchk,is_in_empno,is_pl_empno,is_dl_empno)	<	1	then
		uo_status.st_message.text =  "현재 P/L 승인 대기중인 품목이 없습니다"
	else
		cb_accept.visible	=	true
		cb_cancel.visible	=	true
		cb_accept.enabled	=	true
		cb_cancel.enabled	=	true
	end if
end if

ln_count	=	0

SELECT count(*)	into	:ln_count FROM  pbcommon.dac003
WHERE	pedept = :g_s_deptcd and pejikchek = '3' and peout <> '*'	and peempno	=	:g_s_empno
using	sqlca ;
if	ln_count	>=	1	then
	ddlb_gubun.text	=	'팀장 승인대기'
	is_dlchk			=	'N%'
	is_plchk			=	'%'
	is_inchk			=	'%'
	is_emp_dl		=	'Y'
	is_dl_empno		=	g_s_empno	+	'%'
	is_in_empno		=	'%'
	is_pl_empno		=	'%'
	if	dw_retrieve.retrieve('','9999-12-31','','9999-12-31','','9999-12-31',is_inchk,is_plchk,is_dlchk,is_in_empno,is_pl_empno,is_dl_empno)	<	1	then
		uo_status.st_message.text =  "현재 팀장 승인 대기중인 품목이 없습니다"
	else
		cb_accept.visible	=	true
		cb_cancel.visible	=	true
		cb_accept.enabled	=	true
		cb_cancel.enabled	=	true
	end if
end if

wf_icon_onoff(	true,  false,  false,  false,  false, i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,& 
			     		i_b_dprint,    i_b_dchar	)
						  

end event

event key;call super::key;if	key	=	keyenter!	then
	triggerevent("ue_retrieve")
end if
end event

type uo_status from w_origin_sheet02`uo_status within w_bom120i
end type

type dw_retrieve from datawindow within w_bom120i
integer x = 9
integer y = 168
integer width = 2839
integer height = 2308
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_bom120i_check"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;datawindowchild		cdw_1

this.settransobject(Sqlca) ;

this.GetChild("XPLANT",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve('SLE220')

this.GetChild("XDIV",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve('D')

this.GetChild("XEXPLANTB",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve('SLE220')

this.GetChild("XEXDIVB",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve('D')

this.GetChild("XEXPLANTA",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve('SLE220')

this.GetChild("XEXDIVA",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve('D')



end event

event clicked;if	row	<=	0	then
	return
end if
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

dw_detail.reset()
uo_status.st_message.text =  ""

string	ls_xchcd,ls_fromdate,ls_todate,ls_ppitn,ls_pcitn

if		this.object.xgubun[row]	=	'B'	then
		ls_xchcd						=	this.object.xchcd[row]
		dw_detail.dataobject		=	'd_bom120i_bom_detail'
		dw_detail.reset()
		dw_detail.settransobject(sqlca) ;
		if	ls_xchcd					=	'P'	then
			ls_xchcd					=	'A'
			ls_pcitn					=	trim(this.object.xitno[row])	+	'%'
			ls_ppitn					=	'%'
			ls_fromdate				=	trim(this.object.xedtm[row])	+	'%'
			ls_todate					=	'%'
		elseif	ls_xchcd				=	'C'	or	ls_xchcd	=	'S'		then
			ls_xchcd					=	'A'
			ls_ppitn					=	trim(this.object.xitno[row])	+	'%'
			ls_pcitn					=	'%'
			ls_fromdate				=	trim(this.object.xedtm[row])	+	'%'
			ls_todate					=	'%'
		elseif	ls_xchcd				=	'A'	or	ls_xchcd	=	'R'		then
			ls_pcitn					=	trim(this.object.xitno[row])	+	'%'
			ls_ppitn					=	'%'
			ls_fromdate				=	trim(this.object.xedtm[row])	+	'%'
			ls_todate					=	'%'
		elseif	ls_xchcd				=	'D'	then
			ls_pcitn					=	trim(this.object.xitno[row])	+	'%'
			ls_ppitn					=	'%'
			ls_todate					=	trim(this.object.xedte[row])	+	'%'
			ls_fromdate				=	'%'			
		end if
elseif	this.object.xgubun[row]	=	'O'	then 
		ls_xchcd						=	this.object.xchcd[row]
		dw_detail.dataobject		=	'd_bom120i_opt_detail'
		dw_detail.reset()
		dw_detail.settransobject(sqlca) ;
		if	ls_xchcd					=	'X'	then
			ls_xchcd					=	'A'
			ls_ppitn					=	trim(this.object.xitno[row])	+	'%'
			ls_pcitn					=	'%'
			ls_fromdate				=	trim(this.object.xedtm[row])	+	'%'
			ls_todate					=	'%'			
		elseif	ls_xchcd					=	'A'	or	ls_xchcd	=	'R'		then
			ls_pcitn					=	trim(this.object.xitno[row])	+	'%'
			ls_ppitn					=	'%'
			ls_fromdate				=	trim(this.object.xedtm[row])	+	'%'
			ls_todate					=	'%'			
		elseif	ls_xchcd				=	'D'	then
			ls_pcitn					=	trim(this.object.xitno[row])	+	'%'
			ls_ppitn					=	'%'
			ls_todate					=	trim(this.object.xedte[row])	+	'%'
			ls_fromdate				=	'%'						
		end if
end if

if	dw_detail.retrieve(trim(this.object.xplant[row]),trim(this.object.xdiv[row]),ls_ppitn,ls_pcitn,ls_fromdate,ls_todate,ls_xchcd)	<	1	then
else
	uo_status.st_message.text =  "총 " + string(dw_detail.rowcount()) + " 건의 상세내역이 조회되었습니다."		
end if



end event

event retrieveend;if	is_plchk				=	'N%'	or	is_dlchk				=	'N%'	then
	this.object.sel_chk.visible		= 	true
	this.object.sel_chk.x			=	5
else
	this.object.sel_chk.visible		= 	false
	this.object.sel_chk.x			=	11100
end if
end event

type st_date from statictext within w_bom120i
boolean visible = false
integer x = 933
integer y = 60
integer width = 288
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "기준일자 :"
boolean focusrectangle = false
end type

type uo_from from uo_today_bom within w_bom120i
event ue_keydown pbm_keydown
boolean visible = false
integer x = 1230
integer y = 52
integer taborder = 80
boolean bringtotop = true
boolean enabled = false
end type

on uo_from.destroy
call uo_today_bom::destroy
end on

event constructor;call super::constructor;id_uo_date = Date(String(f_pisc_get_date_nowtime(), "YYYY.MM") + ".01")
is_uo_date = String(id_uo_date, 'YYYY.MM.DD')
init_cal(id_uo_date)
set_date_format ('yyyy.mm.dd')
TriggerEvent("ue_variable_set")
TriggerEvent("ue_select")
end event

type uo_to from uo_today_bom within w_bom120i
boolean visible = false
integer x = 1755
integer y = 52
integer taborder = 90
boolean bringtotop = true
boolean enabled = false
end type

on uo_to.destroy
call uo_today_bom::destroy
end on

type st_date_1 from statictext within w_bom120i
boolean visible = false
integer x = 1682
integer y = 60
integer width = 59
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "~~"
boolean focusrectangle = false
end type

type st_2 from statictext within w_bom120i
integer x = 32
integer y = 60
integer width = 174
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "구분 :"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_gubun from dropdownlistbox within w_bom120i
integer x = 215
integer y = 48
integer width = 658
integer height = 504
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long backcolor = 15780518
boolean sorted = false
boolean vscrollbar = true
string item[] = {"전체","담당자 승인요청대기","담당자 승인요청현황","P/L 승인대기","P/L 승인현황","P/L 반려현황","팀장 승인대기","팀장 승인현황","팀장 반려현황"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;dw_retrieve.reset()
dw_detail.reset()
uo_status.st_message.text =  ""
cb_accept.visible	=	false
cb_cancel.visible	=	false
cb_accept.enabled	=	false
cb_cancel.enabled	=	false

if	index		=	1	then
	is_inchk				=	'%'
	is_plchk				=	'%'
	is_dlchk				=	'%'
	st_date.visible		=	false
	st_date_1.visible		=	false
	uo_from.visible		=	false
	uo_to.visible			=	false
	st_date.enabled		=	false
	st_date_1.enabled	=	false
	uo_from.enabled	=	false
	uo_to.enabled		=	false
elseif	index	=	2	then
	is_inchk				=	'N%'
	is_plchk				=	'%'
	is_dlchk				=	'%'
	st_date.visible		=	false
	st_date_1.visible		=	false
	uo_from.visible		=	false
	uo_to.visible			=	false
	st_date.enabled		=	false
	st_date_1.enabled	=	false
	uo_from.enabled	=	false
	uo_to.enabled		=	false
elseif	index	=	3	then
	is_inchk				=	'Y%'
	is_plchk				=	'%'
	is_dlchk				=	'%'	
	st_date.visible		=	true
	st_date_1.visible		=	true
	uo_from.visible		=	true
	uo_to.visible			=	true
	st_date.enabled		=	true
	st_date_1.enabled	=	true
	uo_from.enabled	=	true
	uo_to.enabled		=	true
elseif	index	=	4	then
	is_inchk				=	'%'
	is_plchk				=	'N%'
	is_dlchk				=	'%'
	st_date.visible		=	false
	st_date_1.visible		=	false
	uo_from.visible		=	false
	uo_to.visible			=	false
	st_date.enabled		=	false
	st_date_1.enabled	=	false
	uo_from.enabled	=	false
	uo_to.enabled		=	false
elseif	index	=	5	then
	is_inchk				=	'%'
	is_plchk				=	'Y%'
	is_dlchk				=	'%'	
	st_date.visible		=	true
	st_date_1.visible		=	true
	uo_from.visible		=	true
	uo_to.visible			=	true
	st_date.enabled		=	true
	st_date_1.enabled	=	true
	uo_from.enabled	=	true
	uo_to.enabled		=	true
elseif	index	=	6	then
	is_inchk				=	'%'
	is_plchk				=	'C%'
	is_dlchk				=	'%'	
	st_date.visible		=	true
	st_date_1.visible		=	true
	uo_from.visible		=	true
	uo_to.visible			=	true
	st_date.enabled		=	true
	st_date_1.enabled	=	true
	uo_from.enabled	=	true
	uo_to.enabled		=	true
elseif	index	=	7	then
	is_inchk				=	'%'
	is_plchk				=	'%'
	is_dlchk				=	'N%'
	st_date.visible		=	false
	st_date_1.visible		=	false
	uo_from.visible		=	false
	uo_to.visible			=	false
	st_date.enabled		=	false
	st_date_1.enabled	=	false
	uo_from.enabled	=	false
	uo_to.enabled		=	false
elseif	index	=	8	then
	is_inchk				=	'%'
	is_plchk				=	'%'
	is_dlchk				=	'Y%'
	st_date.visible		=	true
	st_date_1.visible		=	true
	uo_from.visible		=	true
	uo_to.visible			=	true
	st_date.enabled		=	true
	st_date_1.enabled	=	true
	uo_from.enabled	=	true
	uo_to.enabled		=	true	
elseif	index	=	9	then
	is_inchk				=	'%'
	is_plchk				=	'%'
	is_dlchk				=	'C%'
	st_date.visible		=	true
	st_date_1.visible		=	true
	uo_from.visible		=	true
	uo_to.visible			=	true
	st_date.enabled		=	true
	st_date_1.enabled	=	true
	uo_from.enabled	=	true
	uo_to.enabled		=	true		
else
	is_inchk				=	''
	is_plchk				=	''
	is_dlchk				=	''
	st_date.visible		=	false
	st_date_1.visible		=	false
	uo_from.visible		=	false
	uo_to.visible			=	false
	st_date.enabled		=	false
	st_date_1.enabled	=	false
	uo_from.enabled	=	false
	uo_to.enabled		=	false
end if


end event

type dw_detail from datawindow within w_bom120i
integer x = 2862
integer y = 168
integer width = 1737
integer height = 2308
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_bom120i_bom_detail"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_accept from commandbutton within w_bom120i
boolean visible = false
integer x = 3995
integer y = 48
integer width = 279
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
boolean enabled = false
string text = "승 인"
end type

event clicked;setpointer(hourglass!)

integer	i,ln_rowcount
string ls_xplant,ls_xdiv,ls_month,ls_sheetno,ls_serial
string ls_emailtitle,ls_mail_empno = '',ls_mailaddress,ls_mail_subject,ls_mail_body
ln_rowcount			=	dw_retrieve.rowcount()
if	ln_rowcount	<	1	then
	return
end if

sqlca.autocommit	=	false

if	is_emp_pl	=	'Y'	and	is_plchk	=	'N%'	then
	ls_xplant				=	dw_retrieve.object.xplant[1]	
	ls_xdiv				=	dw_retrieve.object.xdiv[1]	
	ls_month				=	mid(g_s_date,5,2)
	ls_sheetno			=	ls_xplant	+	ls_xdiv	+	ls_month	+	'%'
	select	max(substring(xsheetno,5,4))	into :ls_serial	 from	pbpdm.bom017
	where	xcmcd	=		'01'		and
			xsheetno	like		:ls_sheetno
	using	sqlca ;
	if	f_spacechk(ls_serial)	=	-1	then
		ls_serial		=	'0001'
	else
		ls_serial		=	string(integer(ls_serial)	 +	1,"0000")
	end if
end if

for	i	=	1	to	ln_rowcount
	if	dw_retrieve.object.sel_chk[i]	=	'Y'	then
		f_sysdate()
		if	is_emp_in	=	'Y'	and	is_inchk	=	'N%'	then
			dw_retrieve.object.xinchk[i]		=	'Y'
			dw_retrieve.object.xintime[i]		=	g_s_datetime
			dw_retrieve.object.xplchk[i]		=	'N'
			ls_mail_empno						=	dw_retrieve.object.xplemp[i]
		elseif	is_emp_pl	=	'Y'	and	is_plchk	=	'N%'	then
			dw_retrieve.object.xplchk[i]		=	'Y'
			dw_retrieve.object.xpltime[i]		=	g_s_datetime
			dw_retrieve.object.xdlchk[i]		=	'N'
			dw_retrieve.object.xsheetno[i]	=	ls_xplant	+	ls_xdiv	+	ls_month	+	ls_serial
			ls_mail_empno						=	dw_retrieve.object.xdlemp[i]
		elseif	is_emp_dl	=	'Y'	and	is_dlchk	=	'N%'	then	
			dw_retrieve.object.xdlchk[i]		=	'Y'
			dw_retrieve.object.xdltime[i]		=	g_s_datetime
			ls_mail_empno						=	''
		end if
		ls_mail_body =	 ls_mail_body + "<BR>" + + "변경정보 : " + dw_retrieve.object.xdesc[i]
	end if
next

if	dw_retrieve.update() <>	1 then
	rollback 	using	sqlca ;
	sqlca.autocommit	=	true
	messagebox("확인","승인 중 오류 발생. 시스템개발팀으로 연락바랍니다")
else
	commit	using	sqlca ;
	sqlca.autocommit	=	true
	cb_accept.visible	=	false
	cb_cancel.visible	=	false
	cb_accept.enabled	=	false
	cb_cancel.enabled	=	false
	dw_retrieve.reset()
	if	is_emp_in		=	'Y'	or	is_emp_pl	=	'Y'	then
		ls_mail_subject						=	mid(g_s_date,1,4) + '년' +  string(integer(mid(g_s_date,5,2))) + '월' + string(integer(mid(g_s_date,7,2))) + '일자' + ' BOM 변경사항 승인 요청입니다'
	end if
	if	ls_mail_empno	<>	''	then
		ls_mailaddress	=	f_empno_mailaddr(ls_mail_empno)
		ls_emailtitle = "<BR><B> [KDAC종합정보시스템]-[연구]-[BOM관리]-[BOM승인]-[BOM 승인&내역관리] 화면에서 승인하시면 됩니다.</B>" &
		+ "<BR>" + "결재요청내역은 아래와 같습니다."
		ls_mail_body = ls_emailtitle + ls_mail_body + "<BR>" + "상기 변경정보에 대해서 승인요청합니다."
		if	f_spacechk(ls_mailaddress)	<>	-1	then
			wf_sendmail(ls_mailaddress,ls_mail_subject,ls_mail_body,"")
		end if
	end if
	parent.triggerevent("ue_retrieve")
end if



end event

type cb_cancel from commandbutton within w_bom120i
boolean visible = false
integer x = 4288
integer y = 48
integer width = 279
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
boolean enabled = false
string text = "반 려"
end type

event clicked;integer	i,	ln_rowcount

ln_rowcount	=	dw_retrieve.rowcount()

sqlca.autocommit	=	false
for	i	=	1	to	ln_rowcount
	f_sysdate()
	if	dw_retrieve.object.sel_chk[i]	=	'Y'	then
		if	is_emp_pl		=	'Y'	and	is_plchk	=	'N%'	then
			dw_retrieve.object.xinchk[i]	=	'N'
			dw_retrieve.object.xplchk[i]	=	'C'
			dw_retrieve.object.xpltime[i]	=	g_s_datetime
		elseif	is_emp_dl	=	'Y'	and	is_dlchk	=	'N%'	then	
			dw_retrieve.object.xplchk[i]	=	'N'
			dw_retrieve.object.xdlchk[i]	=	'C'
			dw_retrieve.object.xdltime[i]	=	g_s_datetime
		end if
	end if
next

dw_retrieve.update()
if	sqlca.sqlnrows < 1	then
	rollback 	using	sqlca ;
	sqlca.autocommit	=	true
	messagebox("확인","승인 중 오류 발생. 시스템개발팀으로 연락바랍니다 : " + sqlca.sqlerrtext)
else
	commit 	using	sqlca ;
	sqlca.autocommit	=	true
	cb_accept.visible	=	false
	cb_cancel.visible	=	false
	cb_accept.enabled	=	false
	cb_cancel.enabled	=	false
	dw_retrieve.reset()
end if
end event

type gb_1 from groupbox within w_bom120i
integer x = 14
integer width = 4585
integer height = 148
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long textcolor = 33554432
long backcolor = 12632256
end type

