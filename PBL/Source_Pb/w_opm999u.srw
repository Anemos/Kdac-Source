$PBExportHeader$w_opm999u.srw
$PBExportComments$관리자작업용
forward
global type w_opm999u from w_origin_sheet09
end type
type tab_1 from tab within w_opm999u
end type
type tabpage_1 from userobject within tab_1
end type
type cb_9 from commandbutton within tabpage_1
end type
type cb_6 from commandbutton within tabpage_1
end type
type cb_5 from commandbutton within tabpage_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type dw_12 from datawindow within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_11 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_9 cb_9
cb_6 cb_6
cb_5 cb_5
cb_3 cb_3
dw_12 dw_12
cb_1 cb_1
dw_11 dw_11
end type
type tabpage_2 from userobject within tab_1
end type
type cb_8 from commandbutton within tabpage_2
end type
type st_1 from statictext within tabpage_2
end type
type cb_7 from commandbutton within tabpage_2
end type
type cb_4 from commandbutton within tabpage_2
end type
type dw_22 from datawindow within tabpage_2
end type
type cb_2 from commandbutton within tabpage_2
end type
type dw_21 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cb_8 cb_8
st_1 st_1
cb_7 cb_7
cb_4 cb_4
dw_22 dw_22
cb_2 cb_2
dw_21 dw_21
end type
type tabpage_3 from userobject within tab_1
end type
type dw_31 from datawindow within tabpage_3
end type
type dw_30 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_31 dw_31
dw_30 dw_30
end type
type tabpage_4 from userobject within tab_1
end type
type dw_41 from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_41 dw_41
end type
type tabpage_5 from userobject within tab_1
end type
type cb_17 from commandbutton within tabpage_5
end type
type cb_10 from commandbutton within tabpage_5
end type
type dw_51 from datawindow within tabpage_5
end type
type tabpage_5 from userobject within tab_1
cb_17 cb_17
cb_10 cb_10
dw_51 dw_51
end type
type tabpage_6 from userobject within tab_1
end type
type cb_12 from commandbutton within tabpage_6
end type
type cb_11 from commandbutton within tabpage_6
end type
type dw_61 from datawindow within tabpage_6
end type
type tabpage_6 from userobject within tab_1
cb_12 cb_12
cb_11 cb_11
dw_61 dw_61
end type
type tabpage_7 from userobject within tab_1
end type
type cb_21 from commandbutton within tabpage_7
end type
type cb_20 from commandbutton within tabpage_7
end type
type cb_16 from commandbutton within tabpage_7
end type
type cb_15 from commandbutton within tabpage_7
end type
type cb_14 from commandbutton within tabpage_7
end type
type cb_13 from commandbutton within tabpage_7
end type
type dw_71 from datawindow within tabpage_7
end type
type tabpage_7 from userobject within tab_1
cb_21 cb_21
cb_20 cb_20
cb_16 cb_16
cb_15 cb_15
cb_14 cb_14
cb_13 cb_13
dw_71 dw_71
end type
type tabpage_8 from userobject within tab_1
end type
type cb_18 from commandbutton within tabpage_8
end type
type dw_81 from datawindow within tabpage_8
end type
type cb_19 from commandbutton within tabpage_8
end type
type tabpage_8 from userobject within tab_1
cb_18 cb_18
dw_81 dw_81
cb_19 cb_19
end type
type tab_1 from tab within w_opm999u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
end type
end forward

global type w_opm999u from w_origin_sheet09
integer width = 4745
integer height = 2724
string title = ""
event ue_open_after ( )
event ue_keydown pbm_keydown
tab_1 tab_1
end type
global w_opm999u w_opm999u

type prototypes
FUNCTION boolean SetCurrentDirectoryA(ref string cdir) LIBRARY "Kernel32.dll"
end prototypes

type variables
datawindowchild  idwc_1
integer  ii_tabindex
window  iw_sheet
datawindow idw_11, idw_12, idw_13, idw_14, idw_21, idw_22, idw_23, idw_24,idw_25,idw_26
datawindow idw_10, idw_20, idw_30, idw_31, idw_32, idw_40, idw_41, idw_42
datawindow idw_50, idw_51, idw_60, idw_61, idw_62, idw_temp, idw_70, idw_71, idw_81
string is_colnm, is_mail_body, is_rempno
str_easy i_str_prt
Long   il_lastclickedrow
end variables

forward prototypes
public subroutine wf_save_tabpage3 ()
public subroutine wf_save_tabpage4 ()
end prototypes

event ue_open_after();iw_sheet = w_frame.getactivesheet()

//iw_sheet.triggerevent('ue_retrieve')
end event

event ue_keydown;if key=keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

public subroutine wf_save_tabpage3 ();string ls_yymm
long ll_row,ll_rcnt, ll_srno

setpointer(hourglass!)

IF idw_31.accepttext() = -1 THEN
	messagebox('확인','저장할 자료에 데이타 오류발생, 에러난곳 수정후 저장하세요!',Exclamation!)
	Return
END IF


//f_pur040_nullchk03(idw_31)
//f_inptid(idw_31)

if idw_31.modifiedcount() = 0 then
	messagebox('확인','수정내역없음',Exclamation!)
	Return
end if
uo_status.st_message.text	= '저장중입니다...'

IF idw_31.Update(true,false) = 1 THEN
	idw_31.ResetUpdate()
	COMMIT USING SQLCA;
	uo_status.st_message.text	=  f_message("U010")	// 입력되었습니다. 
ELSE
	ROLLBACK USING SQLCA;
	uo_status.st_message.text	=  f_message("U020") // [저장실패] 정보시스템팀으로 연락바랍니다.
END IF
setpointer(arrow!)



end subroutine

public subroutine wf_save_tabpage4 ();long ll_row, ll_rcnt
int li_rtn
string ls_vsrno, ls_vndnm,ls_bank,ls_bankaddr, ls_count,ls_swift,ls_curr,ls_feegubun

If idw_41.AcceptText( ) = -1  Then
		MessageBox("확인!", "에러가 난곳을 수정한 후 저장하십시요.", Exclamation!)
		Return
End If
IF idw_41.RowCount() = 0 Then
	MessageBox("확인!", "업로드내역이 없습니다.", Exclamation!)
	Return
End IF
	
//	f_null_chk(idw_41)
//	if f_pur040_mandchk03(idw_41) = -1 then return  //필수항목 Check
	
			
//messagebox('',string(idw_12.object.pur101_vsrno.protect))
for ll_row = 1 to idw_41.rowcount()	
	ls_vsrno = trim(idw_41.object.vsrno[ll_row])
	if ls_vsrno = '' then
		continue
	end if
	ll_rcnt = 0
	SELECT count(*)  INTO :ll_rcnt
	FROM  pbpur.pur102
	WHERE comltd = '01'      
	and   dept = 'I'
	and	vsrno  = :ls_vsrno 
			using sqlca;
	if ll_rcnt = 0 then
		MessageBox("확인!",'행:' + string(ll_row) + '업체:' + ls_vsrno +  " 업체내역이 없습니다!", Exclamation!)
		Return
	end if
	
	
//	SELECT count(*)  INTO :ll_rcnt
//	FROM  pbpur.opm111
//	WHERE comltd = '01'      and
//			vsrno  = :ls_vsrno 
//			using sqlca;
//	if ll_rcnt > 0 then
//		MessageBox("확인!",'행:' + string(ll_row) + '업체:' + ls_vsrno +  " 은행입력내역 있습니다. 조회후 수정하세요!", Exclamation!)
////		Return
//	end if
next	
//return

for ll_row = 1 to idw_41.rowcount()	
	ls_vsrno = trim(idw_41.object.vsrno[ll_row])
	if ls_vsrno = '' then
		continue
	end if
	ll_rcnt = 0
	SELECT count(*)  INTO :ll_rcnt
	FROM  pbpur.opm111
	WHERE comltd = '01'      and
			vsrno  = :ls_vsrno 
			using sqlca;
	if ll_rcnt > 0 then
		MessageBox("확인!",'행:' + string(ll_row) + '업체:' + ls_vsrno +  " 은행입력내역 있습니다. 조회후 수정하세요!", Exclamation!)
		continue
	end if
	
	ls_vndnm = trim(idw_41.object.vndnm[ll_row])
	ls_vndnm = mid(ls_vndnm,1,50)
	ls_bank  = mid(trim(idw_41.object.bank[ll_row]),1,50)
	ls_bankaddr = mid(trim(idw_41.object.bankaddr[ll_row]),1,150)
	ls_count = mid(trim(idw_41.object.count[ll_row]),1,30)
	ls_swift = mid(trim(idw_41.object.swift[ll_row]),1,30)
	
	ls_curr  = trim(idw_41.object.curr[ll_row])
	ls_feegubun = trim(idw_41.object.feegubun[ll_row])
	insert into pbpur.opm111
	values(
         '01',  //COMLTD,   
         :ls_vsrno,  //VSRNO,   
         '20060101', //ADJDT,   
         '', //CONDT,   
         :ls_bank,  //BANK,   
         :ls_bankaddr,  //BANKADDR,   
         :ls_count, //COUNT,   
         :ls_swift, //SWIFT,   
         '',   //ROUTNO,   
         '',  //RBANK,   
         '',  //RBANKADDR,   
         '',  //RSWIFT,   
         '', //RROUTNO,   
		   case when :ls_feegubun = '분담' then 'B' else 'A' end,  //FEEGUBUN,   
         :ls_curr,  //CURR,   
         'A',  //STCD,   
         '',  //EXTD,   
         '', //INPTID,   
         '',  //INPTDT,   
         '',  //UPDTID,   
         '',  //UPDTDT,   
         '',  //IPADDR,   
         '', //MACADDR,   
         :ls_vndnm, // VNDNM,   
         '은행일괄 업로드' //XDESC
			);
	if sqlca.sqlcode <> 0 then
		MessageBox("확인!",'행:' + string(ll_row) + '업체:' + ls_vsrno +  " OPM111입력오류", Exclamation!)
		Return
	end if
	insert into pbpur.opm112
	values(
         '01',  //COMLTD,   
         :ls_vsrno,  //VSRNO,   
         '20060101', //ADJDT,   
         '', //CONDT,   
         :ls_bank,  //BANK,   
         :ls_bankaddr,  //BANKADDR,   
         :ls_count, //COUNT,   
         :ls_swift, //SWIFT,   
         '',   //ROUTNO,   
         '',  //RBANK,   
         '',  //RBANKADDR,   
         '',  //RSWIFT,   
         '', //RROUTNO,   
		   case when :ls_feegubun = '분담' then 'B' else 'A' end,  //FEEGUBUN,   
         :ls_curr,  //CURR,   
         'A',  //STCD,   
         '',  //EXTD,   
         '', //INPTID,   
         '',  //INPTDT,   
         '',  //UPDTID,   
         '',  //UPDTDT,   
         '',  //IPADDR,   
         '', //MACADDR,   
         :ls_vndnm, // VNDNM,   
         '은행일괄 업로드' //XDESC
			);
	if sqlca.sqlcode <> 0 then
		MessageBox("확인!",'행:' + string(ll_row) + '업체HIS:' + ls_vsrno +  " OPM112입력오류", Exclamation!)
		Return
	end if
   uo_status.st_message.text = '행:' + string(ll_row) + ' 처리완료..'
next	 
wf_icon_onoff(true,true,false,false,false,false,false,true,false) //I,A,U,D,P



end subroutine

on w_opm999u.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_opm999u.destroy
call super::destroy
destroy(this.tab_1)
end on

event ue_retrieve;call super::ue_retrieve;String  ls_purno, ls_vsrno, ls_yymm, ls_tfdate, ls_vsrno1, ls_stcd, ls_rdept, ls_rempno
string  ls_vndnm, ls_vndnm1
long    ll_row, ll_rcnt 
//
SetPointer(hourglass!)
//
string ls_pathname = 'C:\Documents and Settings\sjb\바탕 화면'
SetCurrentDirectorya(ls_pathname)
CHOOSE CASE ii_tabindex  // 
	CASE 3
		IF idw_30.AcceptText() = -1 THEN
			MessageBox('확인','에러난 곳 수정후 조회하세요!',Exclamation!)
			Return
		END IF
		
		IF f_mandantory_chk(idw_30) = -1 THEN Return
			
		ls_purno   = trim(idw_30.object.purno[1])
	
		uo_status.st_message.text = "조회중입니다"
		
   	idw_31.reset()
		IF idw_31.Retrieve(ls_purno) > 0 THEN
			wf_icon_onoff(true,false,true,true,false,true,false,true,false)  //I,A,U,D,P
			uo_status.st_message.text = "조회완료"
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false)
			uo_status.st_message.text = "해당정보없음"
		END IF
	case 4
      idw_41.reset()
		uo_status.st_message.text	= '업로드중입니다...'
		f_pur040_getexcel(idw_41)  //숫자가 널이면 0으로 변경
		
		if idw_41.rowcount() = 0 then
			return
		end if
		uo_status.st_message.text	= '업로드자료 확인중입니다...'
		f_pur040_nullchk03(idw_41)
		for ll_row = 1 to idw_41.rowcount()

//			ls_vndnm = trim(mid(idw_41.object.vndnm[ll_row],1,10))
//			select coalesce(max(vsrno),''),coalesce(max(vndnm),'')  
//			into :ls_vsrno, :ls_vndnm1
//			from pbpur.pur101
//			where comltd = '01'
//			and   vndnm like :ls_vndnm || '%'
//			and  scgubun = 'S'
//			and  digubun = 'I' ;
			
//			idw_41.object.vsrno[ll_row]  = ls_vsrno
//			idw_41.object.vndnm1[ll_row] = ls_vndnm1
//			if ls_vsrno = '' then
//				ls_vndnm = mid(ls_vndnm,1,5)
//				select coalesce(max(vsrno),''),coalesce(max(vndnm),'')  
//				into :ls_vsrno, :ls_vndnm1
//				from pbpur.pur101
//				where comltd = '01'
//				and   vndnm like :ls_vndnm || '%'
//				and  scgubun = 'S'
//				and  digubun = 'I' ;
//				idw_41.object.vsrno[ll_row]  = ls_vsrno
//				idw_41.object.vndnm1[ll_row] = ls_vndnm1
//			end if
//			
		next
		wf_icon_onoff(true,false,true,false,false,true,false,true,false)
		uo_status.st_message.text = "업로드완료"
	case 5
      idw_51.reset()
		uo_status.st_message.text	= '업로드중입니다...'
		f_pur040_getexcel(idw_51)  //숫자가 널이면 0으로 변경
		
//		if idw_41.rowcount() = 0 then
//			return
//		end if
//		uo_status.st_message.text	= '업로드자료 확인중입니다...'
//		f_pur040_nullchk03(idw_41)
//		for ll_row = 1 to idw_41.rowcount()
//
//
//		next
		wf_icon_onoff(true,false,true,false,false,true,false,true,false)
		uo_status.st_message.text = "업로드완료"	
	case 6
      idw_61.reset()
		uo_status.st_message.text	= '업로드중입니다...'
		f_pur040_getexcel(idw_61)  //숫자가 널이면 0으로 변경
	

		wf_icon_onoff(true,false,true,false,false,true,false,true,false)
		uo_status.st_message.text = "업로드완료"		
END CHOOSE	
//
SetPointer(arrow!)
//
end event

event ue_dprint;call super::ue_dprint;f_screen_print(this)
end event

event open;call super::open;this.event post ue_open_after()
end event

event ue_save;call super::ue_save;//SetPointer(hourglass!)
//Long     ll_row, ll_rcnt, ll_srno, ll_rtn
//string ls_yymm
//
//
CHOOSE CASE ii_tabindex
	CASE 3  
//		if idw_11.getitemstatus(1,0,Primary!) = Newmodified! then //입력이다
		   wf_save_tabpage3()
	CASE 4  
//		if idw_11.getitemstatus(1,0,Primary!) = Newmodified! then //입력이다
		   wf_save_tabpage4()		

END CHOOSE		

end event

event ue_print;call super::ue_print;//String    ls_yymm
//Integer   li_rtn, ii, jj, li_cnt
//Long      ll_cur_row,ll_row,ll_rcnt
//Window l_to_open
//
//SetPointer(Hourglass!)
//CHOOSE CASE ii_tabindex
//	CASE 7
//		if idw_70.accepttext() = -1 then
//			MessageBox("확인","기준년월을 확인하세요!")
//		   Return
//		end if
//		ls_yymm = trim(idw_70.object.yymm[1])
//		if f_pur040_chkyymm(ls_yymm) <> 1 then
//			MessageBox("확인","기준년월을 확인하세요!")
//		   Return
//		end if
//		
//      idw_temp.dataobject = 'd_opm802u_71p'
//		idw_temp.settransobject(sqlca)
//		idw_temp.Retrieve(ls_yymm)
//	   if idw_temp.rowcount() = 0 then
//			MessageBox("확인","발행할 자료 없습니다!")
//		   Return
//		end if
////		
//		IF idw_temp.print() <> 1 Then
//			uo_status.st_message.Text	=	'부대비용 요약리스트 발행취소 및 실패'			//발행할 자료가 없습니다.
//			RETURN
//		else
//			idw_temp.dataobject = 'd_opm802u_72p'
//			idw_temp.settransobject(sqlca)
//			idw_temp.Retrieve(ls_yymm)
//			idw_temp.print()
//			idw_temp.dataobject = 'd_opm802u_77p'
//			idw_temp.settransobject(sqlca)
//			idw_temp.Retrieve(ls_yymm)
//			idw_temp.print()
//			idw_temp.dataobject = 'd_opm802u_73p'
//			idw_temp.settransobject(sqlca)
//			idw_temp.Retrieve(ls_yymm)
//			idw_temp.print()
//			idw_temp.dataobject = 'd_opm802u_74p'
//			idw_temp.settransobject(sqlca)
//			idw_temp.Retrieve(ls_yymm)
//			idw_temp.print()
//			idw_temp.dataobject = 'd_opm802u_75p'
//			idw_temp.settransobject(sqlca)
//			idw_temp.Retrieve(ls_yymm)
//			idw_temp.print()
//			idw_temp.dataobject = 'd_opm802u_76p'
//			idw_temp.settransobject(sqlca)
//			idw_temp.Retrieve(ls_yymm)
//			idw_temp.print()
//			uo_status.st_message.text = '발행완료'
//			return
//		End IF	
//
//	
////	//-- 인쇄 DataWindow 저장  "str_easy" 사용
////	i_str_prt.transaction   =	sqlca
////	i_str_prt.datawindow		= 	idw_temp
////	
////	//i_str_prt.dwsyntax      =  ls_syntax
////	//i_str_prt.tag			  = 	Parent.ClassName()
////	f_close_report("2", i_str_prt.title) // Open된 출력Window 닫기
////	Opensheetwithparm(l_to_open, i_str_prt, "w_prt", w_frame, 0, Layered!)
//
//END CHOOSE
//		
//SetPointer(Arrow!)
//
//
end event

event ue_bcreate;call super::ue_bcreate;CHOOSE CASE ii_tabindex
	CASE 1
		IF idw_12.rowcount() > 0 THEN
			uo_status.st_message.text	=	'자료생성중입니다.잠시만 기다리세요'
			f_save_to_excel(idw_12)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'생성할 자료가 없습니다'
		END IF
	CASE 2
		IF idw_22.rowcount() > 0 THEN
			uo_status.st_message.text	=	'자료생성중입니다.잠시만 기다리세요'
			f_save_to_excel(idw_22)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'생성할 자료가 없습니다'
		END IF
	CASE 3
		IF idw_31.rowcount() > 0 THEN
			uo_status.st_message.text	=	'자료생성중입니다.잠시만 기다리세요'
			f_save_to_excel(idw_31)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'생성할 자료가 없습니다'
		END IF
	CASE 4
		IF idw_41.rowcount() > 0 THEN
			uo_status.st_message.text	=	'자료생성중입니다.잠시만 기다리세요'
			f_save_to_excel(idw_41)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'생성할 자료가 없습니다'
		END IF
	CASE 5
		IF idw_51.rowcount() > 0 THEN
			uo_status.st_message.text	=	'자료생성중입니다.잠시만 기다리세요'
			f_save_to_excel(idw_51)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'생성할 자료가 없습니다'
		END IF
	CASE 6
		IF idw_61.rowcount() > 0 THEN
			uo_status.st_message.text	=	'자료생성중입니다.잠시만 기다리세요'
			f_save_to_excel(idw_61)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'생성할 자료가 없습니다'
		END IF	
	CASE 7
		IF idw_71.rowcount() > 0 THEN
			uo_status.st_message.text	=	'자료생성중입니다.잠시만 기다리세요'
			f_save_to_excel(idw_71)
			uo_status.st_message.text	=	' '
		ELSE
			uo_status.st_message.text	=	'생성할 자료가 없습니다'
		END IF		
END CHOOSE


end event

type uo_status from w_origin_sheet09`uo_status within w_opm999u
integer y = 2484
end type

type tab_1 from tab within w_opm999u
event create ( )
event destroy ( )
integer y = 12
integer width = 4617
integer height = 2460
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
end on

event selectionchanged;ii_tabindex = newindex
g_n_tabno = newindex
CHOOSE CASE newindex
	CASE 1
		IF idw_11.rowcount() > 0 THEN
			wf_icon_onoff(true,false,true,true,false,true,false,true,false)  //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P
		END IF
	CASE 2
		IF idw_21.rowcount() > 0 THEN
			wf_icon_onoff(true,false,true,true,false,true,false,true,false)  //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P
		END IF
	CASE 3
		IF idw_31.rowcount() > 0 THEN
			wf_icon_onoff(true,false,true,true,false,true,false,true,false)  //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P
		END IF
	CASE 4
		IF idw_41.rowcount() > 0 THEN
			wf_icon_onoff(true,false,true,true,false,true,false,true,false) //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P
		END IF	
	CASE 5
		IF idw_51.rowcount() > 0 THEN
			wf_icon_onoff(true,false,true,true,false,true,false,true,false)  //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,false,false,false,false,false,true,false) //I,A,U,D,P
		END IF	
	CASE 6
		IF idw_61.rowcount() > 0 THEN
			wf_icon_onoff(true,false,true,false,false,true,false,true,false)  //I,A,U,D,P
		ELSE
			wf_icon_onoff(true,false,true,false,false,false,false,true,false) //I,A,U,D,P
		END IF		
//	CASE 7
//		IF idw_71.rowcount() > 0 THEN
//			wf_icon_onoff(true,false,false,false,true,true,false,true,false)  //I,A,U,D,P
//		ELSE
//			wf_icon_onoff(true,false,false,false,true,false,false,true,false) //I,A,U,D,P
//		END IF		
END CHOOSE

end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4581
integer height = 2344
long backcolor = 12632256
string text = "선송금맞추기"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_9 cb_9
cb_6 cb_6
cb_5 cb_5
cb_3 cb_3
dw_12 dw_12
cb_1 cb_1
dw_11 dw_11
end type

on tabpage_1.create
this.cb_9=create cb_9
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_3=create cb_3
this.dw_12=create dw_12
this.cb_1=create cb_1
this.dw_11=create dw_11
this.Control[]={this.cb_9,&
this.cb_6,&
this.cb_5,&
this.cb_3,&
this.dw_12,&
this.cb_1,&
this.dw_11}
end on

on tabpage_1.destroy
destroy(this.cb_9)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_3)
destroy(this.dw_12)
destroy(this.cb_1)
destroy(this.dw_11)
end on

type cb_9 from commandbutton within tabpage_1
integer x = 3721
integer y = 504
integer width = 640
integer height = 92
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "인도조건데이타전환"
end type

event clicked;string ls_pathname, ls_yymm
long ll_row, ll_rcnt, ll_ecnt
long  ll_vat, ll_temp


//ls_pathname = 'C:\Documents and Settings\sam1\바탕 화면'
//SetCurrentDirectorya(ls_pathname)
//
//idw_11.reset()
//idw_12.reset()
//uo_status.st_message.text	= '업로드중입니다...'
//f_pur040_getexcel(idw_11)  //숫자가 널이면 0으로 변경

select count(*) into :ll_rcnt
from pbpur.opm101 ;

string ls_purno, ls_srno, ls_srno1, ls_tod,ls_tod1,ls_tod2,ls_tod_old
dec {2} ld_pamt, ld_ofamt, ld_lcamt, ld_lcamtbl, ld_blamt, ld_samt, ld_hc

setpointer(hourglass!)
	
	DECLARE CUR_1 CURSOR FOR
	 select trim(purno), trim(tod)
	 from pbpur.opm101 ;
	 		  
	 OPEN CUR_1;
	 DO WHILE TRUE
		FETCH CUR_1 INTO  :ls_purno, :ls_tod_old;
		if sqlca.sqlcode <> 0  then
			exit
		end if
		if ls_tod_old = '' then
			continue
		end if
		
		Choose case ls_tod_old
			case 'A'
				ls_tod = '11';ls_tod1 = '27';ls_tod2 = ''
			case 'B'
				ls_tod = '11';ls_tod1 = '';ls_tod2 = '11'
			case 'C'
				ls_tod = '13';ls_tod1 = '23';ls_tod2 = ''
			case 'D'
				ls_tod = '12';ls_tod1 = '11';ls_tod2 = '11'
			case 'E'
				ls_tod = '12';ls_tod1 = '11';ls_tod2 = '12'
			case 'F'
				ls_tod = '12';ls_tod1 = '11';ls_tod2 = '13'
			case 'G'
				ls_tod = '12';ls_tod1 = '12';ls_tod2 = '11'
			case 'H'
				ls_tod = '12';ls_tod1 = '12';ls_tod2 = '12'
			case 'I'
				ls_tod = '12';ls_tod1 = '12';ls_tod2 = '13'
			case 'J'
				ls_tod = '12';ls_tod1 = '13';ls_tod2 = '11'
			case 'K'
				ls_tod = '12';ls_tod1 = '13';ls_tod2 = '12'
			case 'L'
				ls_tod = '12';ls_tod1 = '13';ls_tod2 = '13'
			case 'M'
				ls_tod = '12';ls_tod1 = '14';ls_tod2 = '11'
			case 'N'
				ls_tod = '12';ls_tod1 = '14';ls_tod2 = '12'
			case 'O'
				ls_tod = '12';ls_tod1 = '15';ls_tod2 = '13'
			case 'P'
				ls_tod = '12';ls_tod1 = '16';ls_tod2 = '12'
			case 'Q'
				ls_tod = '12';ls_tod1 = '25';ls_tod2 = ''
			case 'R'
				ls_tod = '13';ls_tod1 = '22';ls_tod2 = '12'
			case 'S'
				ls_tod = '12';ls_tod1 = '16';ls_tod2 = '11'
			case 'T'
				ls_tod = '12';ls_tod1 = '17';ls_tod2 = '13'
			case 'U'
				ls_tod = '12';ls_tod1 = '18';ls_tod2 = '13'
			case 'V'
				ls_tod = '12';ls_tod1 = '26';ls_tod2 = ''
			case 'W'
				ls_tod = '14';ls_tod1 = '23';ls_tod2 = ''
			case 'X'
				ls_tod = '14';ls_tod1 = '30';ls_tod2 = '12'
			case 'Y'
				ls_tod = '15';ls_tod1 = '31';ls_tod2 = ''
			case 'Z'
				ls_tod = '12';ls_tod1 = '15';ls_tod2 = '13'	
			//***************	
			case '0'
				ls_tod = '12';ls_tod1 = '32';ls_tod2 = '13'
			case '1'
				ls_tod = '15';ls_tod1 = '11';ls_tod2 = '11'
			case '11'
				ls_tod = '12';ls_tod1 = '19';ls_tod2 = '11'
			case '12'
				ls_tod = '12';ls_tod1 = '19';ls_tod2 = '11'
			case '2'
				ls_tod = '11';ls_tod1 = '';ls_tod2 = '13'		
			case '3'
				ls_tod = '16';ls_tod1 = '12';ls_tod2 = '12'
			case '4'
				ls_tod = '16';ls_tod1 = '11';ls_tod2 = '12'
			case '5'
				ls_tod = '16';ls_tod1 = '13';ls_tod2 = '12'
			case '6'
				ls_tod = '16';ls_tod1 = '12';ls_tod2 = '11'
			case '7'
				ls_tod = '16';ls_tod1 = '13';ls_tod2 = '11'	
			case '8'
				ls_tod = '16';ls_tod1 = '11';ls_tod2 = '11'
			case '9'
				ls_tod = '12';ls_tod1 = '27';ls_tod2 = ''
			case '13'
				ls_tod = '14';ls_tod1 = '22';ls_tod2 = ''
			case '14'
				ls_tod = '16';ls_tod1 = '14';ls_tod2 = ''
			case '15'
				ls_tod = '17';ls_tod1 = '24';ls_tod2 = ''		
			case '16'
				ls_tod = '12';ls_tod1 = '20';ls_tod2 = '13'
			case '17'
				ls_tod = '16';ls_tod1 = '28';ls_tod2 = ''
			case '18'
				ls_tod = '12';ls_tod1 = '21';ls_tod2 = '13'		
			case else
				messagebox(ls_purno,ls_tod_old)
		End choose
				
	   
		update pbpur.opm101
		 set tod = :ls_tod, tod1 = :ls_tod1, tod2 = :ls_tod2,
		     extd = :ls_tod_old
		where comltd = '01'
		and   purno = :ls_purno ;
		
		update pbpur.opm103
		 set tod = :ls_tod, tod1 = :ls_tod1, tod2 = :ls_tod2
		where comltd = '01'
		and   purno = :ls_purno ;
      
		update pbpur.opm113
		 set tod = :ls_tod, tod1 = :ls_tod1, tod2 = :ls_tod2,
		     todp = :ls_tod, todp1 = :ls_tod1, todp2 = :ls_tod2
		where comltd = '01'
		and   purno = :ls_purno ;
      ll_row = ll_row + 1
		uo_status.st_message.text	= string(ll_row) + '/' + string(ll_rcnt) + '개 처리완료.'
		
	LOOP
CLOSE CUR_1;
				
setpointer(arrow!)

//uo_status.st_message.text	= '업로드 확인완료, 오류내역 있는 행은 노란색으로 표시됩니다.'
wf_icon_onoff(true,true,true,true,false,true,false,true,false) //I,A,U,D,P
return



end event

type cb_6 from commandbutton within tabpage_1
integer x = 3182
integer y = 368
integer width = 475
integer height = 92
integer taborder = 210
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "발주별산출"
end type

event clicked;string ls_pathname, ls_yymm
long ll_row, ll_rcnt, ll_ecnt
long  ll_vat, ll_temp

//if g_s_empno = '970077' then
//	ls_PathName = 'C:\Documents and Settings\sam1\My Documents\2005외자구매process개선\'
//	//ls_FileName = 'C:\Documents and Settings\sam1\My Documents\2005외자구매process개선\화면설계서및관련프로그램.xls'
//else
//	ls_PathName = 'C:\'
//end if
//if g_s_empno = '030022' then
//	ls_PathName = 'D:\2005운임지불내역'
//end if
//SetCurrentDirectorya(ls_pathname)

ls_pathname = 'C:\Documents and Settings\sam1\바탕 화면'
SetCurrentDirectorya(ls_pathname)

idw_11.reset()
idw_12.reset()
uo_status.st_message.text	= '업로드중입니다...'
f_pur040_getexcel(idw_11)  //숫자가 널이면 0으로 변경

if idw_11.rowcount() = 0 then
	return
end if

uo_status.st_message.text	= '업로드자료 확인중입니다...'
f_pur040_nullchk03(idw_11)

string ls_purno, ls_srno, ls_srno1, ls_srno2, ls_tlgubun, ls_opendt, ls_first_cd
dec {2} ld_pamt, ld_ofamt, ld_lcamt, ld_lcamtbl, ld_blamt, ld_samt, ld_hc

for ll_row = 1 to idw_11.rowcount()
	uo_status.st_message.text	= '행:' + string(ll_row) + ' 자료확인중입니다...'
	ls_purno = trim(idw_11.object.purno[ll_row])
	//ls_srno  = trim(idw_11.object.srno[ll_row])
	ll_rcnt = idw_12.insertrow(0)
	idw_12.object.purno[ll_rcnt] = ls_purno
	//idw_12.object.srno[ll_rcnt]  = ls_srno
	ls_first_cd = 'Y'
	
//	DECLARE CUR_1 CURSOR FOR
//	 select srno, srno1, trim(tlgubun) 
//	 from pbpur.opm103
//	 where comltd = '01'
//	 and  purno = :ls_purno ;
	 //and  srno  = :ls_srno ;
	 	 
//	 OPEN CUR_1;
//	 DO WHILE TRUE
//		FETCH CUR_1 INTO  :ls_srno, :ls_srno1, :ls_tlgubun;
//		if sqlca.sqlcode <> 0  then
//			exit
//		end if
//		if ls_first_cd = 'Y' then
//		   ls_first_cd = 'N'
//		else	
//			ll_rcnt = idw_12.insertrow(0)
//	   end if
		
	   idw_12.object.tlgubun[ll_rcnt] = ls_tlgubun
	   idw_12.object.purno[ll_rcnt] = ls_purno
//		idw_12.object.srno[ll_rcnt]  = ls_srno
//		idw_12.object.srno1[ll_rcnt]  = ls_srno1
		select coalesce(sum(pamt),0),coalesce(max(srno),'') into :ld_pamt, :ls_srno
		from pbpur.opm102
		where comltd = '01'
		and   purno = :ls_purno;
		//and   srno = :ls_srno ;
		
		select coalesce(sum(hc),0) into :ld_hc
		from pbpur.opm101
		where comltd = '01'
		and   purno = :ls_purno;
		//and   srno = :ls_srno ;
		
		select coalesce(sum(ofamt),0) into :ld_ofamt
		from pbpur.opm103
		where comltd = '01'
		and   purno = :ls_purno ;
		//and   srno  = :ls_srno 
		//and   srno1 = :ls_srno1 ;
					
		select coalesce(sum(lcamt+lcamtu),0),coalesce(sum(lcamtbl),0) into :ld_lcamt,:ld_lcamtbl
		from  pbacc.fex020
		where comltd = '01'
		and   lcpono = :ls_purno ;
				
		select coalesce(sum(fobamt),0) into :ld_blamt
		from pbpur.opm106
		where comltd = '01'
		and   purno = :ls_purno;
		//and   srno  = :ls_srno ;
		
		//송금내역 오퍼의 전체합
		select coalesce(sum(amt + inc - dec),0) into :ld_samt
		from pbpur.opm115
		where comltd = '01'
		and   purno = :ls_purno;
		//and   srno  = :ls_srno 
		//and   srno1 = :ls_srno1 ;
		
		select coalesce(max(srno2),'') into :ls_srno2
		from pbpur.opm115
		where comltd = '01'
		and   purno = :ls_purno;
		//and   srno  = :ls_srno 
		//and   srno1 = :ls_srno1 ;
		
		idw_12.object.srno[ll_rcnt]   = ls_srno
		idw_12.object.srno2[ll_rcnt]  = ls_srno2
		idw_12.object.pamt[ll_rcnt]   = ld_pamt + ld_hc
		idw_12.object.ofamt[ll_rcnt]  = ld_ofamt
		idw_12.object.lcamt[ll_rcnt]    = ld_lcamt
		idw_12.object.lcamtbl[ll_rcnt]  = ld_lcamtbl
		idw_12.object.blamt[ll_rcnt]  = ld_blamt
		idw_12.object.samt[ll_rcnt]   = ld_samt
		idw_12.object.amt[ll_rcnt]    = idw_11.object.amt[ll_row]
		
		ls_opendt = trim(idw_11.object.opendt[ll_row])
		if ls_opendt = '' or ls_opendt <= g_s_date then
			ls_opendt = g_s_date
		end if
		idw_12.object.opendt[ll_rcnt]  = ls_opendt 
		
		if ld_pamt + ld_hc = 0 then  //발주없으면제외
			idw_12.object.yn[ll_rcnt] = 'N'
		end if
		//발주 = 오퍼다르면제외
		if ld_pamt + ld_hc <> ld_ofamt then
			idw_12.object.yn[ll_rcnt] = 'N'
		end if
		//송금요청액없으면서 개설금액과 오퍼금액다르면 제외
		if  idw_11.object.amt[ll_row] = 0 &
		and ld_lcamt <> ld_ofamt then
			idw_12.object.yn[ll_rcnt] = 'N'
		end if
		//분리된 발주제외  ==>수기처리
		if ls_srno <> '' then
			idw_12.object.yn[ll_rcnt] = 'N'
		end if
		
//	LOOP
//CLOSE CUR_1;
				

next


uo_status.st_message.text	= '업로드 확인완료, 오류내역 있는 행은 노란색으로 표시됩니다.'
wf_icon_onoff(true,true,true,true,false,true,false,true,false) //I,A,U,D,P



end event

type cb_5 from commandbutton within tabpage_1
integer x = 3182
integer y = 504
integer width = 475
integer height = 92
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "TT미송금처리"
end type

event clicked;string ls_yymm
long ll_row,ll_rcnt, ll_srno

setpointer(hourglass!)

IF idw_12.accepttext() = -1 THEN
	messagebox('확인','저장할 자료에 데이타 오류발생, 에러난곳 수정후 저장하세요!',Exclamation!)
	Return
END IF

//자료체크
string ls_purno, ls_srno, ls_srno1, ls_srno2, ls_srno2_new, ls_opendt,ls_opmstcd
dec {2} ld_ofamt, ld_lcamt, ld_lcamtbl, ld_blamt, ld_amt, ld_payamt

for ll_row = 1 to idw_12.rowcount()
	uo_status.st_message.text	= '행:' + string(ll_row) + ' 처리중입니다...'
	if idw_12.object.yn[ll_row] <> 'Y' then
		continue
	end if
	ls_purno = trim(idw_12.object.purno[ll_row])
	ls_srno  = '' //trim(idw_12.object.srno[ll_row])
	ls_srno1 = '01'
	ls_srno2 = '01'
	ls_srno2_new = string(long(ls_srno2) + 1, "00")
	
	ld_blamt = idw_12.object.blamt[ll_row]
	ld_lcamt = idw_12.object.lcamt[ll_row]
	ld_lcamtbl = idw_12.object.lcamtbl[ll_row]
	ld_amt     = idw_12.object.amt[ll_row]   //요청액
	ls_opendt = '20060112'
//	select count(*) into :ll_rcnt
//	from pbpur.opm115
//	where comltd = '01'
//	and   purno = :ls_purno
//	and   srno = :ls_srno
//	and   srno1 = :ls_srno1 ;
//	if ll_rcnt = 0 then
//		insert into pbpur.opm115
//			select '01', purno, srno, srno1 , '01',
//					 tlgubun, 'N',ofdt, :ls_opendt, :ld_amt,0,0,
//					 'N',:ld_amt,'Y','C', //선송금코드,Bl결제금액,코드, 진행상태
//					 '정상송금 200601월 일괄작업-1월첫주02번 처리종류2번','','','','','',:ls_opendt,'','','',
//					 '','',:g_s_date,'','','',''
//			from pbpur.opm103 a
//			where comltd = '01'
//			and  purno = :ls_purno
//			and  srno  = :ls_srno
//			and  srno1 = :ls_srno1 ;
//	end if
	
	
	//해당주 요청금액있음
	if ld_amt > 0 then
		//1번 자금결제내역없고 선송금아님, 최초정상송금
		if ld_lcamtbl = 0 &
		and ld_blamt >= ld_lcamtbl + ld_amt then
		   select count(*) into :ll_rcnt
			from pbpur.opm115
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			if ll_rcnt <> 1 then
				messagebox(string(ll_row),'송금:' + string(ll_rcnt) + '개 1번조건 송금내역확인!')
			end if
			
			select count(*) into :ll_rcnt
			from pbpur.opm106
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			
			if ll_rcnt = 0 then
				messagebox(string(ll_row),'1번조건 BL내역없음!')
			end if
			continue
		end if  
		//***********************************************************
		//2번 자금결제내역있고, BL입고액 >= 자금결제금액 + 요청금액
		if ld_lcamtbl > 0 & 
		and ld_blamt >= ld_lcamtbl + ld_amt then
			select count(*) into :ll_rcnt
			from pbpur.opm115
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			if ll_rcnt <> 1 then
				messagebox(string(ll_row),'송금:' + string(ll_rcnt) + '개 2번조건 송금내역확인!')
			end if
			
			select count(*) into :ll_rcnt
			from pbpur.opm106
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			
			if ll_rcnt = 0 then
				messagebox(string(ll_row),'2번조건 BL내역없음!')
			end if
			
			continue
		end if
		//*********************************************
	   //3번 자금결제내역및 BL입고내역 없고 최초선송금
		if ld_lcamtbl = 0 &
		and ld_blamt = 0 then
			select count(*) into :ll_rcnt
			from pbpur.opm115
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			if ll_rcnt <> 1 then
				messagebox(string(ll_row),'송금:' + string(ll_rcnt) + '개 3번조건 송금내역확인!')
			end if
			
			select count(*) into :ll_rcnt
			from pbpur.opm106
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			
			if ll_rcnt > 0 then
				messagebox(string(ll_row),'3번조건 BL내역없어야됨, BL있음!')
			end if
			
			continue
		end if  
      //***********************************************************
		//4번 자금결제내역있고, BL입고액 <= 자금결제금액 
		if ld_lcamtbl > 0 &
		and ld_blamt <= ld_lcamtbl then
		  select count(*) into :ll_rcnt
			from pbpur.opm115
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			if ll_rcnt <> 1 then
				messagebox(string(ll_row),'송금:' + string(ll_rcnt) + '개 4번조건 송금내역확인!')
			end if
			
			select count(*) into :ll_rcnt
			from pbpur.opm106
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			
			if ll_rcnt = 0 then
				messagebox(string(ll_row),'4번조건 BL내역없음!')
			end if
			
			continue
		end if
       //***********************************************************
		//5번 자금결제내역있고, BL입고액 > 자금결제금액 
		if ld_lcamtbl > 0 &
		and ld_blamt > ld_lcamtbl then
		  
		select count(*) into :ll_rcnt
			from pbpur.opm115
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			if ll_rcnt <> 1 then
				messagebox(string(ll_row),'송금:' + string(ll_rcnt) + '개 5번조건 송금내역확인!')
			end if
			
			select count(*) into :ll_rcnt
			from pbpur.opm106
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			
			if ll_rcnt = 0 then
				messagebox(string(ll_row),'5번조건 BL내역없음!')
			end if
			
			continue
		end if
		 //***********************************************************
		//6번 자금결제내역있고, BL입고액 < 자금결제금액 + 요청금액 
		if ld_lcamtbl = 0 &
		and ld_blamt < ld_lcamtbl + ld_amt then
		  
			select count(*) into :ll_rcnt
			from pbpur.opm115
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			if ll_rcnt <> 1 then
				messagebox(string(ll_row),'송금:' + string(ll_rcnt) + '개 6번조건 송금내역확인!')
			end if
			
			select count(*) into :ll_rcnt
			from pbpur.opm106
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			
			if ll_rcnt = 0 then
				messagebox(string(ll_row),'6번조건 BL내역없음!')
			end if
			
			continue
		end if
		messagebox('행:' + string(ll_row),'요청처리안됨! 발주:' + string(ls_purno))
	
end if
	
//********************//
//해당요청금액 없을때 //
//********************//
if ld_amt = 0 then
		 //***********************************************************
		//11번 자금결제내역있고, BL입고액 = 자금결제금액 
		if ld_lcamtbl > 0 &
		and ld_blamt = ld_lcamtbl then
		  	select count(*) into :ll_rcnt
			from pbpur.opm115
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			if ll_rcnt <> 1 then
				messagebox(string(ll_row),'송금:' + string(ll_rcnt) + '개 11번조건 송금내역확인!')
			end if
			
			select count(*) into :ll_rcnt
			from pbpur.opm106
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			
			if ll_rcnt = 0 then
				messagebox(string(ll_row),'11번조건 BL내역없음!')
			end if
			
			continue
		end if
		//12번 자금결제내역있고, BL입고액 > 자금결제금액 
		if ld_lcamtbl > 0 &
		and ld_blamt > ld_lcamtbl + 0.1 then
		  	select count(*) into :ll_rcnt
			from pbpur.opm115
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			if ll_rcnt <> 1 then
				messagebox(string(ll_row),'송금:' + string(ll_rcnt) + '개 12번조건 송금내역확인!')
			end if
			
			select count(*) into :ll_rcnt
			from pbpur.opm106
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			
			if ll_rcnt = 0 then
				messagebox(string(ll_row),'12번조건 BL내역없음!')
			end if
			
			continue
		end if
		//13번 자금결제내역있고, BL입고액 < 자금결제금액 
		if ld_lcamtbl > 0 &
		and ld_blamt + 0.1 < ld_lcamtbl then
		   select count(*) into :ll_rcnt
			from pbpur.opm115
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			if ll_rcnt <> 1 then
				messagebox(string(ll_row),'송금:' + string(ll_rcnt) + '개 13번조건 송금내역확인!')
			end if
			
			select count(*) into :ll_rcnt
			from pbpur.opm106
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			
			if ld_blamt > 0 and ll_rcnt = 0 then
				messagebox(string(ll_row),'13번조건 BL내역없음!')
			end if
			
			continue
		end if
		
		//14번 자금결제내역없음 송금요청삭제
		if ld_lcamtbl = 0 then
//		  select count(*) into :ll_rcnt
//			from pbpur.opm115
//			where comltd = '01'
//			and   purno = :ls_purno
//			and   srno = :ls_srno
//			and   srno1 = :ls_srno1 ;
//			
//			if ll_rcnt = 0 then
//				messagebox(string(ll_row),'14번조건 삭제할 송금요청없음!')
//			end if
						
			
			continue
		end if
		
      messagebox('행:' + string(ll_row),'자료정리안됨! 발주:' + string(ls_purno) +  '금액차:' + string(ld_blamt - ld_lcamtbl))

end if

uo_status.st_message.text	= '행:' + string(ll_row) + '번 작업완료..'	
next


return

//********************************************************************************************
for ll_row = 1 to idw_12.rowcount()
	uo_status.st_message.text	= '행:' + string(ll_row) + ' 처리중입니다...'
	if idw_12.object.yn[ll_row] <> 'Y' then
		continue
	end if
	ls_purno = trim(idw_12.object.purno[ll_row])
	ls_srno  = '' //trim(idw_12.object.srno[ll_row])
	ls_srno1 = '01'
	ls_srno2 = '01'
	ls_srno2_new = string(long(ls_srno2) + 1, "00")
	
	ld_blamt = idw_12.object.blamt[ll_row]
	ld_lcamt = idw_12.object.lcamt[ll_row]
	ld_lcamtbl = idw_12.object.lcamtbl[ll_row]
	ld_amt     = idw_12.object.amt[ll_row]   //요청액
	ls_opendt = '20060112'
	
	//해당주 요청금액있음
	if ld_amt > 0 then
		//1번 자금결제내역없고 선송금아님, 최초정상송금
		if ld_lcamtbl = 0 &
		and ld_blamt >= ld_lcamtbl + ld_amt then
			//자금결제금액으로 01생성
			update pbpur.opm115
			set amt = :ld_amt,
				 blamt = :ld_amt,
				 opmstcd = 'Y',
				 opendt = condt,
				 stcd = 'C',
				 opmdesc = '정상송금요청200601월 일괄작업-1월첫주최초요청 처리종류1번'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1
			and   srno2 = :ls_srno2 ;
			//관련BL전부 0101및 정상송금 처리
			update pbpur.opm106
			set srno1 = '01',
				 srno2 = '01',
				 bkno  = 'T'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			
			//오퍼송금 잔액처리
//			select coalesce(sum(amt + inc - dec),0) into :ld_payamt
//			from pbpur.opm115
//			where comltd = '01'
//			and   purno = :ls_purno
//			and   srno = :ls_srno
//			and   srno1 = :ls_srno1 ;
			ld_payamt = ld_amt  //위와동일금액
			
			update pbpur.opm103
			  set payamt = :ld_payamt
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			continue
		end if  
		//***********************************************************
		//2번 자금결제내역있고, BL입고액 >= 자금결제금액 + 요청금액
		if ld_lcamtbl > 0 & 
		and ld_blamt >= ld_lcamtbl + ld_amt then
			//자금결제금액으로 01생성
			update pbpur.opm115
			set amt = :ld_lcamtbl,
				 blamt = :ld_lcamtbl,
				 opmstcd = 'Y',
				 opendt = condt,
				 stcd = 'G',
				 opmdesc = '정상송금요청200601월-일괄작업-자금결제금액을 01번 처리종류2번'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1
			and   srno2 = :ls_srno2 ;
			//요청금액으로 송금요청생성 02
			insert into pbpur.opm115
			select '01', purno, srno, srno1 , :ls_srno2_new,
					 tlgubun, 'N',ofdt, :ls_opendt, :ld_amt,0,0,
					 'N',:ld_amt,'Y','C', //선송금코드,Bl결제금액,코드, 진행상태
					 '정상송금 200601월 일괄작업-1월첫주02번 처리종류2번','','','','','',:ls_opendt,'','','',
					 '','',:g_s_date,'','','',''
			from pbpur.opm103 a
			where comltd = '01'
			and  purno = :ls_purno
			and  srno  = :ls_srno
			and  srno1 = :ls_srno1 ;
			//관련BL전부 0101및 정상송금 처리
			update pbpur.opm106
			set srno1 = '01',
				 srno2 = '01',
				 bkno  = 'T'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			//오퍼-송금요청액처리
			ld_payamt = ld_lcamtbl + ld_amt
			update pbpur.opm103
			  set payamt = :ld_payamt
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			continue
		end if
		//*********************************************
	   //3번 자금결제내역및 BL입고내역 없고 최초선송금
		if ld_lcamtbl = 0 &
		and ld_blamt = 0 then
			//자금결제금액으로 01생성
			update pbpur.opm115
			set amt = :ld_amt,
				 blamt = 0,
				 prepay = 'Y',
				 opmstcd = 'N',
				 opendt = condt,
				 stcd = 'C',
				 opmdesc = '선송금요청200601월 일괄작업-1월첫주최초요청 처리종류3번'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1
			and   srno2 = :ls_srno2 ;
			//관련BL전부 0101및 정상송금 처리
//			update pbpur.opm106
//			set srno1 = '01',
//				 srno2 = '01',
//				 bkno  = 'T'
//			where comltd = '01'
//			and   purno = :ls_purno
//			and   srno = :ls_srno;
						
			ld_payamt = ld_amt  
			
			update pbpur.opm103
			  set payamt = :ld_payamt
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			continue
		end if  
      //***********************************************************
		//4번 자금결제내역있고, BL입고액 <= 자금결제금액 
		if ld_lcamtbl > 0 &
		and ld_blamt <= ld_lcamtbl then
		   if ld_blamt = ld_lcamtbl then
				ls_opmstcd = 'Y'
			else
				ls_opmstcd = 'N'
			end if
			//자금결제금액으로 01생성
			update pbpur.opm115
			set amt = :ld_lcamtbl,
				 blamt = :ld_blamt,
				 opmstcd = :ls_opmstcd,
				 prepay = 'Y',
				 opendt = condt,
				 stcd = 'G',
				 opmdesc = '선송금요청200601월-일괄작업-자금결제금액을 01번 처리종류4번'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1
			and   srno2 = :ls_srno2 ;
			//요청금액으로 선송금요청생성 02
			insert into pbpur.opm115
			select '01', purno, srno, srno1 , :ls_srno2_new,
					 tlgubun, 'N',ofdt, :ls_opendt, :ld_amt,0,0,
					 'Y', 0, 'N','C',   //선송금코드,Bl결제금액,코드, 진행상태
					 '선송금 200601월 일괄작업-1월첫주02번 처리종류4번','','','','','',:ls_opendt,'','','',
					 '','',:g_s_date,'','','',''
			from pbpur.opm103 a
			where comltd = '01'
			and  purno = :ls_purno
			and  srno  = :ls_srno
			and  srno1 = :ls_srno1 ;
			//관련BL전부 0101및 선송금 처리
			update pbpur.opm106
			set srno1 = '01',
				 srno2 = '01',
				 bkno  = 'Y'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			//오퍼-송금요청액처리
			ld_payamt = ld_lcamtbl + ld_amt
			update pbpur.opm103
			  set payamt = :ld_payamt
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			continue
		end if
       //***********************************************************
		//5번 자금결제내역있고, BL입고액 > 자금결제금액 
		if ld_lcamtbl > 0 &
		and ld_blamt > ld_lcamtbl then
		  
			//자금결제금액으로 01생성
			update pbpur.opm115
			set amt = :ld_lcamtbl,
				 blamt = :ld_lcamtbl,
				 opmstcd = 'Y',
				 prepay = 'Y',
				 opendt = condt,
				 stcd = 'G',
				 opmdesc = '선송금요청200601월-일괄작업-자금결제금액을 01번 처리종류5번'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1
			and   srno2 = :ls_srno2 ;
			//요청금액으로 선송금요청생성 02
			insert into pbpur.opm115
			select '01', purno, srno, srno1 , :ls_srno2_new,
					 tlgubun, 'N',ofdt, :ls_opendt, :ld_amt,0,0,
					 'Y', :ld_blamt - :ld_lcamtbl, 'N','C',   //선송금코드,Bl결제금액,코드, 진행상태
					 '선송금 200601월 일괄작업-1월첫주02번 처리종류5번','','','','','',:ls_opendt,'','','',
					 '','',:g_s_date,'','','',''
			from pbpur.opm103 a
			where comltd = '01'
			and  purno = :ls_purno
			and  srno  = :ls_srno
			and  srno1 = :ls_srno1 ;
			//관련BL전부 0101및 선송금 처리
			update pbpur.opm106
			set srno1 = '01',
				 srno2 = '01',
				 bkno  = 'Y'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			//오퍼-송금요청액처리
			ld_payamt = ld_lcamtbl + ld_amt
			update pbpur.opm103
			  set payamt = :ld_payamt
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			continue
		end if
		 //***********************************************************
		//6번 자금결제내역있고, BL입고액 < 자금결제금액 + 요청금액 
		if ld_lcamtbl = 0 &
		and ld_blamt < ld_lcamtbl + ld_amt then
		  
			//자금결제금액으로 01생성
			update pbpur.opm115
			set amt = :ld_amt,
				 blamt = :ld_blamt,
				 opmstcd = 'N',
				 prepay = 'Y',
				 opendt = condt,
				 stcd = 'C',
				 opmdesc = '선송금요청200601월-일괄작업-요청금액을 01번 처리종류6번'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1
			and   srno2 = :ls_srno2 ;
			
			//관련BL전부 0101및 선송금 처리
			update pbpur.opm106
			set srno1 = '01',
				 srno2 = '01',
				 bkno  = 'Y'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			//오퍼-송금요청액처리
			ld_payamt = ld_lcamtbl + ld_amt
			update pbpur.opm103
			  set payamt = :ld_payamt
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			continue
		end if
		messagebox('행:' + string(ll_row),'요청처리안됨! 발주:' + string(ls_purno))
	
end if


//********************//
//해당요청금액 없을때 //
//********************//
if ld_amt = 0 then
		 //***********************************************************
		//11번 자금결제내역있고, BL입고액 = 자금결제금액 
		if ld_lcamtbl > 0 &
		and ld_blamt = ld_lcamtbl then
		  	//자금결제금액으로 01생성
			update pbpur.opm115
			set amt = :ld_lcamtbl,
				 blamt = :ld_blamt,
				 opmstcd = 'Y',
				 prepay = 'N',
				 opendt = condt,
				 stcd = 'G',
				 opmdesc = '정상요청200601월-일괄작업-결제금액을 01번 처리종류11번'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1
			and   srno2 = :ls_srno2 ;
			
			//관련BL전부 0101및 정상금 처리
			update pbpur.opm106
			set srno1 = '01',
				 srno2 = '01',
				 bkno  = 'T'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			//오퍼-송금요청액처리
			ld_payamt = ld_lcamtbl + ld_amt
			update pbpur.opm103
			  set payamt = :ld_payamt
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			continue
		end if
		//12번 자금결제내역있고, BL입고액 > 자금결제금액 
		if ld_lcamtbl > 0 &
		and ld_blamt > ld_lcamtbl + 0.1 then
		  	//자금결제금액으로 01생성
			update pbpur.opm115
			set amt = :ld_lcamtbl,
				 blamt = :ld_lcamtbl,
				 opmstcd = 'Y',
				 prepay = 'N',
				 opendt = condt,
				 stcd = 'G',
				 opmdesc = '정상요청200601월-일괄작업-결제금액을 01번 처리종류12번'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1
			and   srno2 = :ls_srno2 ;
			
			//관련BL전부 0101및 송금 처리
			update pbpur.opm106
			set srno1 = '01',
				 srno2 = '01',
				 bkno  = 'T'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			//오퍼-송금요청액처리
			ld_payamt = ld_lcamtbl + ld_amt
			update pbpur.opm103
			  set payamt = :ld_payamt,
			      stcd = 'E' 
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			continue
		end if
		//13번 자금결제내역있고, BL입고액 < 자금결제금액 
		if ld_lcamtbl > 0 &
		and ld_blamt + 0.1 < ld_lcamtbl then
		   //자금결제금액으로 01생성
			update pbpur.opm115
			set amt = :ld_lcamtbl,
				 blamt = :ld_blamt,
				 opmstcd = 'N',
				 prepay = 'Y',
				 opendt = condt,
				 stcd = 'G',
				 opmdesc = '선송금요청200601월-일괄작업-결제금액을 01번 처리종류13번'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1
			and   srno2 = :ls_srno2 ;
			
			//관련BL전부 0101및 송금 처리
			update pbpur.opm106
			set srno1 = '01',
				 srno2 = '01',
				 bkno  = 'Y'
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno;
			//오퍼-송금요청액처리
			ld_payamt = ld_lcamtbl + ld_amt
			update pbpur.opm103
			  set payamt = :ld_payamt,
			      stcd = 'E' 
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			continue
		end if
		
		//14번 자금결제내역없음 송금요청삭제
		if ld_lcamtbl = 0 then
		   //자금결제금액으로 01생성
			delete from  pbpur.opm115
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1
			and   srno2 = :ls_srno2 ;
			
			//관련BL전부 0101및 송금 처리
//			update pbpur.opm106
//			set srno1 = '01',
//				 srno2 = '01',
//				 bkno  = 'Y'
//			where comltd = '01'
//			and   purno = :ls_purno
//			and   srno = :ls_srno;
			//오퍼-송금요청액처리
//			ld_payamt = ld_lcamtbl + ld_amt
			update pbpur.opm103
			  set payamt = 0, 
			      stcd = 'D' 
			where comltd = '01'
			and   purno = :ls_purno
			and   srno = :ls_srno
			and   srno1 = :ls_srno1 ;
			
			continue
		end if
		
      messagebox('행:' + string(ll_row),'자료정리안됨! 발주:' + string(ls_purno) +  '금액차:' + string(ld_blamt - ld_lcamtbl))

end if

uo_status.st_message.text	= '행:' + string(ll_row) + '번 작업완료..'	
next

uo_status.st_message.text	= '작업완료.'
setpointer(arrow!)



end event

type cb_3 from commandbutton within tabpage_1
integer x = 3182
integer y = 124
integer width = 475
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "선송금요청생성"
end type

event clicked;string ls_yymm
long ll_row,ll_rcnt, ll_srno

setpointer(hourglass!)

IF idw_12.accepttext() = -1 THEN
	messagebox('확인','저장할 자료에 데이타 오류발생, 에러난곳 수정후 저장하세요!',Exclamation!)
	Return
END IF

//자료체크
string ls_purno, ls_srno, ls_srno1, ls_srno2, ls_srno2_new, ls_opendt
dec {2} ld_blamt, ld_amt, ld_payamt

for ll_row = 1 to idw_12.rowcount()
	uo_status.st_message.text	= '행:' + string(ll_row) + ' 처리중입니다...'
//	if idw_12.object.samt[ll_row] = idw_12.object.amt[ll_row] then
//		continue
//	end if
	ls_purno = trim(idw_12.object.purno[ll_row])
	ls_srno  = trim(idw_12.object.srno[ll_row])
	ls_srno1 = trim(idw_12.object.srno1[ll_row])
	ls_srno2 = trim(idw_12.object.srno2[ll_row])
	ls_srno2_new = string(long(ls_srno2) + 1, "00")
	
	ld_blamt = idw_12.object.blamt[ll_row]
	ld_amt = idw_12.object.amt[ll_row]
	ls_opendt = trim(idw_12.object.opendt[ll_row])
	
	if ld_blamt > 0 then
		update pbpur.opm115
		set amt = :ld_blamt,
		    blamt = :ld_blamt,
			 opmstcd = 'Y',
			 opendt = condt,
			 stcd = 'G'
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno
		and   srno1 = :ls_srno1
		and   srno2 = :ls_srno2 ;
		
		insert into pbpur.opm115
		select '01', purno, srno, srno1 , :ls_srno2_new,
				 tlgubun, 'N',ofdt, shdt, :ld_amt,0,0,
				 'Y',0,
				 'N','F','선송금 200601월 일괄작업으로 생성','','','','','',:ls_opendt,'','','',
				 '','','20060105','','','',''
		from pbpur.opm103 a
		where comltd = '01'
		and  purno = :ls_purno
		and  srno  = :ls_srno
		and  srno1 = :ls_srno1 ;
		
		select coalesce(sum(amt + inc - dec),0) into :ld_payamt
		from pbpur.opm115
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno
		and   srno1 = :ls_srno1 ;
		
		update pbpur.opm103
		  set payamt = :ld_payamt
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno
		and   srno1 = :ls_srno1 ;
	else	
		update pbpur.opm115
		set amt = :ld_amt,
		    //blamt = :ld_blamt,
			 //opmstcd = 'Y',
			 //opendt = condt,
			 stcd = 'F'
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno
		and   srno1 = :ls_srno1
		and   srno2 = :ls_srno2 ;
		
		select coalesce(sum(amt + inc - dec),0) into :ld_payamt
		from pbpur.opm115
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno
		and   srno1 = :ls_srno1 ;
		
		update pbpur.opm103
		  set payamt = :ld_payamt
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno
		and   srno1 = :ls_srno1 ;
		
	end if
	
next

uo_status.st_message.text	= '작업완료.'
//
//IF idw_11.Update(true,false) = 1 THEN
//	idw_11.ResetUpdate()
//	COMMIT USING SQLCA;
//	uo_status.st_message.text	=  f_message("U010")	// 입력되었습니다. 
//ELSE
//	ROLLBACK USING SQLCA;
//	uo_status.st_message.text	=  f_message("U020") // [저장실패] 정보시스템팀으로 연락바랍니다.
//END IF
setpointer(arrow!)



end event

type dw_12 from datawindow within tabpage_1
integer x = 14
integer y = 688
integer width = 4544
integer height = 1644
integer taborder = 50
string title = "none"
string dataobject = "d_opm999u_12"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
idw_12 = this

//this.insertrow(0)
end event

type cb_1 from commandbutton within tabpage_1
integer x = 3182
integer y = 16
integer width = 475
integer height = 84
integer taborder = 190
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "오퍼별산출"
end type

event clicked;string ls_pathname, ls_yymm
long ll_row, ll_rcnt, ll_ecnt
long  ll_vat, ll_temp

//if g_s_empno = '970077' then
//	ls_PathName = 'C:\Documents and Settings\sam1\My Documents\2005외자구매process개선\'
//	//ls_FileName = 'C:\Documents and Settings\sam1\My Documents\2005외자구매process개선\화면설계서및관련프로그램.xls'
//else
//	ls_PathName = 'C:\'
//end if
//if g_s_empno = '030022' then
//	ls_PathName = 'D:\2005운임지불내역'
//end if
//SetCurrentDirectorya(ls_pathname)

ls_pathname = 'C:\Documents and Settings\sam1\바탕 화면'
SetCurrentDirectorya(ls_pathname)

idw_11.reset()
idw_12.reset()
uo_status.st_message.text	= '업로드중입니다...'
f_pur040_getexcel(idw_11)  //숫자가 널이면 0으로 변경

if idw_11.rowcount() = 0 then
	return
end if

uo_status.st_message.text	= '업로드자료 확인중입니다...'
f_pur040_nullchk03(idw_11)

string ls_purno, ls_srno, ls_srno1, ls_srno2, ls_tlgubun, ls_opendt,ls_first_cd
dec {2} ld_pamt, ld_ofamt, ld_lcamt, ld_lcamtbl, ld_blamt, ld_samt, ld_hc

for ll_row = 1 to idw_11.rowcount()
	uo_status.st_message.text	= '행:' + string(ll_row) + ' 자료확인중입니다...'
	ls_purno = trim(idw_11.object.purno[ll_row])
	ls_srno  = trim(idw_11.object.srno[ll_row])
	ll_rcnt = idw_12.insertrow(0)
	idw_12.object.purno[ll_rcnt] = ls_purno
	//idw_12.object.srno[ll_rcnt]  = ls_srno
	ls_first_cd = 'Y'
	
	DECLARE CUR_1 CURSOR FOR
	 select srno, srno1, trim(tlgubun) 
	 from pbpur.opm103
	 where comltd = '01'
	 and  purno = :ls_purno ;
	 //and  srno  = :ls_srno ;
		  
	 OPEN CUR_1;
	 DO WHILE TRUE
		FETCH CUR_1 INTO  :ls_srno, :ls_srno1, :ls_tlgubun;
		if sqlca.sqlcode <> 0  then
			exit
		end if
		if ls_first_cd = 'Y' then
		   ls_first_cd = 'N'
		else	
			ll_rcnt = idw_12.insertrow(0)
	   end if
		
	   idw_12.object.tlgubun[ll_rcnt] = ls_tlgubun
	   idw_12.object.purno[ll_rcnt] = ls_purno
		idw_12.object.srno[ll_rcnt]  = ls_srno
		idw_12.object.srno1[ll_rcnt]  = ls_srno1
		select coalesce(sum(pamt),0) into :ld_pamt
		from pbpur.opm102
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno ;
		
		select coalesce(sum(hc),0) into :ld_hc
		from pbpur.opm101
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno ;
		
		select coalesce(sum(ofamt),0) into :ld_ofamt
		from pbpur.opm103
		where comltd = '01'
		and   purno = :ls_purno
		and   srno  = :ls_srno 
		and   srno1 = :ls_srno1 ;
					
		select coalesce(sum(lcamt+lcamtu),0),coalesce(sum(lcamtbl),0) into :ld_lcamt,:ld_lcamtbl
		from  pbacc.fex020
		where comltd = '01'
		and   lcpono = :ls_purno ;
				
		select coalesce(sum(fobamt),0) into :ld_blamt
		from pbpur.opm106
		where comltd = '01'
		and   purno = :ls_purno
		and   srno  = :ls_srno ;
		
		//송금내역 오퍼의 전체합
		select coalesce(sum(amt + inc - dec),0) into :ld_samt
		from pbpur.opm115
		where comltd = '01'
		and   purno = :ls_purno
		and   srno  = :ls_srno 
		and   srno1 = :ls_srno1 ;
		
		select coalesce(max(srno2),'') into :ls_srno2
		from pbpur.opm115
		where comltd = '01'
		and   purno = :ls_purno
		and   srno  = :ls_srno 
		and   srno1 = :ls_srno1 ;
		
		idw_12.object.srno2[ll_rcnt]  = ls_srno2
		idw_12.object.pamt[ll_rcnt]   = ld_pamt + ld_hc
		idw_12.object.ofamt[ll_rcnt]  = ld_ofamt
		idw_12.object.lcamt[ll_rcnt]    = ld_lcamt
		idw_12.object.lcamtbl[ll_rcnt]  = ld_lcamtbl
		idw_12.object.blamt[ll_rcnt]  = ld_blamt
		idw_12.object.samt[ll_rcnt]   = ld_samt
		idw_12.object.amt[ll_rcnt]    = idw_11.object.amt[ll_row]
		
		ls_opendt = trim(idw_11.object.opendt[ll_row])
		if ls_opendt = '' or ls_opendt <= g_s_date then
			ls_opendt = g_s_date
		end if
		idw_12.object.opendt[ll_rcnt]  = ls_opendt 
		
	LOOP
CLOSE CUR_1;
				

next


uo_status.st_message.text	= '업로드 확인완료, 오류내역 있는 행은 노란색으로 표시됩니다.'
wf_icon_onoff(true,true,true,true,false,true,false,true,false) //I,A,U,D,P



end event

type dw_11 from datawindow within tabpage_1
integer x = 18
integer y = 16
integer width = 3077
integer height = 664
integer taborder = 60
string title = "none"
string dataobject = "d_opm999u_11a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//This.SelectRow(0,False)
//This.SelectRow(row,True)
f_pur040_mselect(this, row)  //reference 'this'사용불가,변수값지정

//자료없는 부분 클릭시 선택 해제
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)


end event

event constructor;this.settransobject(sqlca)
idw_11 = this

//this.insertrow(0)
end event

event itemchanged;string ls_yymm, ls_vsrno, ls_vsrno1,ls_temp,ls_ablno,ls_rblno,ls_itno
string ls_eta,ls_costdiv,ls_itno3
dec {2} ld_blqty, ld_weight1
long ll_vat
long ll_row,ll_rcnt
ll_row = row	
//idw_11.object.chk[ll_row] = 0
if this.object.mblcd[row] = 'Y' then
	messagebox('확인','행:' + string(ll_row) + ' Mater BL운임은 수정불가능합니다!,등록안됨')
	return 1
end if
Choose case dwo.name
case 'vsrno'
	ls_vsrno = trim(data)  //업체확인
	select count(*) into :ll_rcnt
	from pbpur.pur101
	where comltd = '01'
	and  vsrno = :ls_vsrno 
	and  substr(vsrno,1,1) = 'I';
	if ll_rcnt = 0 then
		messagebox('확인','행:' + string(ll_row) + ' 발행업체오류!,등록안됨')
		idw_11.object.chk[ll_row] = 1
		return 1
	end if
case 'vsrno1'	
	ls_vsrno1 = trim(data)
	if ls_vsrno1 = '' then
		idw_11.object.vsrno1[ll_row] = idw_11.object.vsrno[ll_row]
	else
	   select count(*) into :ll_rcnt
		from pbpur.pur101
		where comltd = '01'
		and  vsrno = :ls_vsrno1 
		and  substr(vsrno,1,1) = 'I';
		if ll_rcnt = 0 then
			messagebox('확인','행:' + string(ll_row) + ' 청구업체오류!,등록안됨')
			idw_11.object.chk[ll_row] = 1
			return 1
		end if
	end if
case 'idate'	
	ls_temp = trim(data)
	if trim(f_dateedit(ls_temp)) = '' then  //계산서발행일
	   messagebox('확인','행:' + string(ll_row) + ' 계산서발행일오류!')
		idw_11.object.chk[ll_row] = 1.
		return 1
	end if
case 'ablno','rblno'  //청구용BL/전산BL
	if dwo.name = 'ablno' then
		ls_ablno = trim(data)
		ls_rblno = trim(idw_11.object.rblno[ll_row])
	else
		ls_ablno = trim(idw_11.object.ablno[ll_row])
		ls_rblno = trim(data)
	end if
	
	if ls_rblno = '' then
		ls_rblno = ls_ablno
	   idw_11.object.rblno[ll_row] = ls_ablno
	end if
	select count(*), coalesce(max(ardt),'') into :ll_rcnt, :ls_eta
	from pbpur.opm105
	where comltd = '01'
	and  (blno = :ls_ablno 
	  or  blno  = :ls_rblno) ;
	if ll_rcnt = 0 then
		messagebox('확인','행:' + string(ll_row) + ' B/L오류!, 등록안됨')
		idw_11.object.chk[ll_row] = 1
		return 1
	else
		select coalesce(max(xplant || costdiv),''), coalesce(max(itno),''),  
		       coalesce(sum(blqty + ovqty),'')  
		into :ls_costdiv, :ls_itno, :ld_blqty
		from pbpur.opm106
		where comltd = '01'
		and  (blno = :ls_ablno 
		  or  blno  = :ls_rblno) ;
		idw_11.object.eta[ll_row] = ls_eta    //도착일
		idw_11.object.costdiv[ll_row] = ls_costdiv  //원가사업장
		select coalesce(max(convqty1),0) into :ld_weight1  //전산선적중량계산
		from pbinv.inv101
		where  comltd = '01'
		and  itno = :ls_itno ;
		idw_11.object.weight1[ll_row] = round(ld_weight1 * ld_blqty,2) 
	end if
case 'mblno'  //Master BL
case 'country'	
	ls_temp = trim(data)
	select count(*)  into :ll_rcnt
	from pbcommon.dac002
	where  comltd = '01'
	and   cogubun = 'DAC050'
	and  cocode = :ls_temp ;
	if ll_rcnt = 0  then  //수입국가
	   messagebox('확인','행:' + string(ll_row) + ' 수입국가오류!')
		idw_11.object.chk[ll_row] = 1
		return 1
	end if
case 'country1'	
	if trim(data) = '' then
		idw_11.object.country1[ll_row] = idw_11.object.country[ll_row]
	else
		ls_temp = trim(data)
		select count(*)  into :ll_rcnt
		from pbcommon.dac002
		where comltd = '01'
		and  cogubun = 'DAC050'
		and  cocode = :ls_temp ;
		if ll_rcnt = 0  then  //선적국가
		   messagebox('확인','행:' + string(ll_row) + ' 선적국가오류!')
			idw_11.object.chk[ll_row] = 1
			return 1
		end if
	end if
case 'state'	
	//*****USA zone
	ls_temp = trim(data)
	if ls_temp <> '' then
		select count(*)  into :ll_rcnt
		from pbcommon.dac002
		where  comltd = '01'
		and   cogubun = 'PUR600'
		and  cocode = :ls_temp ;
		if ll_rcnt = 0  then  
			messagebox('확인','행:' + string(ll_row) + ' USA ZONE오류!')
			idw_11.object.chk[ll_row] = 1
			return 1
		end if
	end if
	//*****결제대분류
case 'xpay'	
	ls_temp = trim(data)
	select count(*)  into :ll_rcnt
	from pbcommon.dac002
	where  comltd = '01'
	and   cogubun = 'PUR601'
	and  cocode = :ls_temp ;
	if ll_rcnt = 0  then  
		messagebox('확인','행:' + string(ll_row) + ' 결제대분류오류!')
		idw_11.object.chk[ll_row] = 1
		return 1
	end if
case 'gubun'	
	//*****중량요금구분
	ls_temp = trim(data)
	select count(*)  into :ll_rcnt
	from pbcommon.dac002
	where  comltd = '01'
	and   cogubun = 'PUR602'
	and  cocode = :ls_temp ;
	if ll_rcnt = 0  then  
		messagebox('확인','행:' + string(ll_row) + ' 중량요금구분오류!')
		idw_11.object.chk[ll_row] = 1
		return 1
	end if
case 'weight'	
	//운임중량
	if dec(data) <= 0 then
		messagebox('확인','행:' + string(ll_row) + ' 운임중량오류!')
		idw_11.object.chk[ll_row] = 1
		return 1
	end if
case 'weight1'
case 'stotal1'  //영세율원금
	if isnull(data) then
		data = '0'
	end if
   idw_11.object.stotal2[ll_row] = idw_11.object.stotal[ll_row] - idw_11.object.stotal3[ll_row] - dec(data)
	ll_vat = idw_11.object.stotal2[ll_row]
	//ll_vat = ll_vat / 100
	ll_vat = ll_vat / 10
	idw_11.object.vat[ll_row] = ll_vat
	idw_11.object.total[ll_row] = idw_11.object.stotal[ll_row] + ll_vat
case 'stotal2'	 //일반원금=>부가세발생
	if isnull(data) then
		data = '0'
	end if
	idw_11.object.stotal1[ll_row] = idw_11.object.stotal[ll_row] - idw_11.object.stotal2[ll_row] - dec(data)
	ll_vat = dec(data)
	//ll_vat = ll_vat / 100
	ll_vat = ll_vat / 10
	idw_11.object.vat[ll_row] = ll_vat
	idw_11.object.total[ll_row] = idw_11.object.stotal[ll_row] + ll_vat
case 'stotal3'	 //비부가세원금
	if isnull(data) then
		data = '0'
	end if
	idw_11.object.stotal2[ll_row] = idw_11.object.stotal[ll_row] - idw_11.object.stotal1[ll_row] - dec(data)
	ll_vat = idw_11.object.stotal2[ll_row]
	//ll_vat = ll_vat / 100
	ll_vat = ll_vat / 10
	idw_11.object.vat[ll_row] = ll_vat
	idw_11.object.total[ll_row] = idw_11.object.stotal[ll_row] + ll_vat	
case else	  //나머지 전체 금액관련
	//운임합계 = 각항목합계 
	idw_11.accepttext()
	   idw_11.object.stotal[ll_row] = &
	   idw_11.object.ofrt[ll_row] + idw_11.object.baf[ll_row] + idw_11.object.caf[ll_row] + & 
		idw_11.object.exwc[ll_row] + idw_11.object.ohc[ll_row] + idw_11.object.ooc1[ll_row] + & 
		idw_11.object.ooc2[ll_row] + idw_11.object.thc[ll_row] + idw_11.object.cfs[ll_row] + & 
		idw_11.object.ctx[ll_row] + idw_11.object.wf[ll_row]   + idw_11.object.dfee[ll_row] + & 
		idw_11.object.cln[ll_row] + idw_11.object.dhc[ll_row] + idw_11.object.doc1[ll_row] + & 
		idw_11.object.doc2[ll_row] 
End choose



end event

event itemerror;return 1
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4581
integer height = 2344
long backcolor = 12632256
string text = "LC셋팅"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_8 cb_8
st_1 st_1
cb_7 cb_7
cb_4 cb_4
dw_22 dw_22
cb_2 cb_2
dw_21 dw_21
end type

on tabpage_2.create
this.cb_8=create cb_8
this.st_1=create st_1
this.cb_7=create cb_7
this.cb_4=create cb_4
this.dw_22=create dw_22
this.cb_2=create cb_2
this.dw_21=create dw_21
this.Control[]={this.cb_8,&
this.st_1,&
this.cb_7,&
this.cb_4,&
this.dw_22,&
this.cb_2,&
this.dw_21}
end on

on tabpage_2.destroy
destroy(this.cb_8)
destroy(this.st_1)
destroy(this.cb_7)
destroy(this.cb_4)
destroy(this.dw_22)
destroy(this.cb_2)
destroy(this.dw_21)
end on

type cb_8 from commandbutton within tabpage_2
integer x = 2990
integer y = 436
integer width = 576
integer height = 92
integer taborder = 220
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "전체분리오퍼결합"
end type

event clicked;string ls_yymm
long ll_row,ll_rcnt, ll_srno

setpointer(hourglass!)


//자료체크
string ls_purno, ls_srno, ls_srno1, ls_srno2, ls_srno2_new, ls_opendt,ls_tlgubun
dec {2} ld_ofamt, ld_samt, ld_pamt, ld_payamt, ld_hc, ld_blamt

    DECLARE CUR_1 CURSOR FOR
	 select purno
	 from pbpur.opm101
	 where comltd = '01'
	 and  trim(srno) <> '';
	 
	 OPEN CUR_1;
	 DO WHILE TRUE
		FETCH CUR_1 INTO  :ls_purno;
		if sqlca.sqlcode <> 0  then
			exit
		end if
	   
		
				//오퍼
		select coalesce(sum(ofamt),0) into :ld_ofamt
		from pbpur.opm104
		where comltd = '01'
		and  purno = :ls_purno ;
		
		select coalesce(max(hc),0) into :ld_hc
		from pbpur.opm101
		where comltd = '01'
		and  purno = :ls_purno ;
		
		update pbpur.opm103
		  set  ofamt = :ld_ofamt + :ld_hc,
				 payamt = :ld_ofamt + :ld_hc
		where comltd = '01'
		and  purno = :ls_purno 
		and  trim(srno) = '' ;
		
		delete from pbpur.opm103
		where comltd = '01'
		and  purno = :ls_purno 
		and  trim(srno) <> '' ;
		//발주
		select coalesce(sum(pamt),0) into :ld_pamt
		from pbpur.opm102
		where comltd = '01'
		and  purno = :ls_purno ;
			
		update pbpur.opm101
		  set  pamt = :ld_pamt 
		where comltd = '01'
		and  purno = :ls_purno 
		and  trim(srno) = '' ;
		
		delete from pbpur.opm101
		where comltd = '01'
		and  purno = :ls_purno 
		and  trim(srno) <> '' ;
		
		//송금/오픈요청내역
//		select coalesce(sum(fobamt),0) into :ld_blamt
//		from pbpur.opm106
//		where comltd = '01'
//		and  purno = :ls_purno ;
//		
//		update pbpur.opm115
//		  set  amt = :ld_ofamt + :ld_hc,
//				 blamt = :ld_blamt,
//				 opmstcd = (case when blamt <= :ld_blamt then 'Y' else 'N' end)
//		where comltd = '01'
//		and  purno = :ls_purno 
//		and  trim(srno) = '' 
//		and  srno1 = '01';
//		
//		delete from pbpur.opm115
//		where comltd = '01'
//		and  purno = :ls_purno 
//		and  trim(srno) <> '' ;
//		
//		update pbpur.opm106
//		  set  srno1 = '01',
//				 srno2 = '01', 
//				 bkno = 'L'
//		where comltd = '01'
//		and  purno = :ls_purno ;
		uo_status.st_message.text	= '행:' + string(ll_row) + '개 완료.'
	
	LOOP
CLOSE CUR_1;

//for ll_row = 1 to idw_21.rowcount()
//	uo_status.st_message.text	= '행:' + string(ll_row) + ' 처리중입니다...'
//	ls_purno = trim(idw_21.object.purno[ll_row])
//	//오퍼
//	select coalesce(sum(ofamt),0) into :ld_ofamt
//	from pbpur.opm104
//	where comltd = '01'
//	and  purno = :ls_purno ;
//	
//	select coalesce(max(hc),0) into :ld_hc
//	from pbpur.opm101
//	where comltd = '01'
//	and  purno = :ls_purno ;
//		
//	//발주
//	select coalesce(sum(pamt),0) into :ld_pamt
//	from pbpur.opm102
//	where comltd = '01'
//	and  purno = :ls_purno ;
//		
//	//송금/오픈요청내역
//	select coalesce(sum(fobamt),0) into :ld_blamt
//	from pbpur.opm106
//	where comltd = '01'
//	and  purno = :ls_purno ;
//	
//	if ld_ofamt <> ld_pamt then
//		messagebox('발주<>오퍼금액',ls_purno + ':' + string(ld_pamt) + ':' + string(ld_ofamt)) 
//   end if
//	if ld_ofamt <> ld_blamt then
//		messagebox('오퍼<>BL금액',ls_purno + ':' + string(ld_pamt) + ':' + string(ld_blamt)) 
//   end if
//next
//return



//uo_status.st_message.text	= '작업완료.'
//
//IF idw_21.Update(true,false) = 1 THEN
//	idw_21.ResetUpdate()
//	COMMIT USING SQLCA;
//	uo_status.st_message.text	=  f_message("U010")	// 입력되었습니다. 
//ELSE
//	ROLLBACK USING SQLCA;
//	uo_status.st_message.text	=  f_message("U020") // [저장실패] 정보시스템팀으로 연락바랍니다.
//END IF
setpointer(arrow!)



end event

type st_1 from statictext within tabpage_2
integer x = 3456
integer y = 288
integer width = 955
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "idw_21발주번호만으로 작업"
boolean focusrectangle = false
end type

type cb_7 from commandbutton within tabpage_2
integer x = 2976
integer y = 296
integer width = 457
integer height = 92
integer taborder = 220
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "분할LC결합"
end type

event clicked;string ls_yymm
long ll_row,ll_rcnt, ll_srno

setpointer(hourglass!)

IF idw_21.accepttext() = -1 THEN
	messagebox('확인','저장할 자료에 데이타 오류발생, 에러난곳 수정후 저장하세요!',Exclamation!)
	Return
END IF

//자료체크
string ls_purno, ls_srno, ls_srno1, ls_srno2, ls_srno2_new, ls_opendt
dec {2} ld_ofamt, ld_samt, ld_pamt, ld_payamt, ld_hc, ld_blamt
for ll_row = 1 to idw_21.rowcount()
	uo_status.st_message.text	= '행:' + string(ll_row) + ' 처리중입니다...'
	ls_purno = trim(idw_21.object.purno[ll_row])
	//오퍼
	select coalesce(sum(ofamt),0) into :ld_ofamt
	from pbpur.opm104
	where comltd = '01'
	and  purno = :ls_purno ;
	
	select coalesce(max(hc),0) into :ld_hc
	from pbpur.opm101
	where comltd = '01'
	and  purno = :ls_purno ;
		
	//발주
	select coalesce(sum(pamt),0) into :ld_pamt
	from pbpur.opm102
	where comltd = '01'
	and  purno = :ls_purno ;
		
	//송금/오픈요청내역
	select coalesce(sum(fobamt),0) into :ld_blamt
	from pbpur.opm106
	where comltd = '01'
	and  purno = :ls_purno ;
	
	if ld_ofamt <> ld_pamt then
		messagebox('발주<>오퍼금액',ls_purno + ':' + string(ld_pamt) + ':' + string(ld_ofamt)) 
   end if
	if ld_ofamt <> ld_blamt then
		messagebox('오퍼<>BL금액',ls_purno + ':' + string(ld_pamt) + ':' + string(ld_blamt)) 
   end if
next
//return

for ll_row = 1 to idw_21.rowcount()
	uo_status.st_message.text	= '행:' + string(ll_row) + ' 처리중입니다...'
	ls_purno = trim(idw_21.object.purno[ll_row])
	//오퍼
	select coalesce(sum(ofamt),0) into :ld_ofamt
	from pbpur.opm104
	where comltd = '01'
	and  purno = :ls_purno ;
	
	select coalesce(max(hc),0) into :ld_hc
	from pbpur.opm101
	where comltd = '01'
	and  purno = :ls_purno ;
	
	update pbpur.opm103
	  set  ofamt = :ld_ofamt + :ld_hc,
	       payamt = :ld_ofamt + :ld_hc
	where comltd = '01'
	and  purno = :ls_purno 
	and  trim(srno) = '' ;
	
	delete from pbpur.opm103
   where comltd = '01'
	and  purno = :ls_purno 
	and  trim(srno) <> '' ;
	//발주
	select coalesce(sum(pamt),0) into :ld_pamt
	from pbpur.opm102
	where comltd = '01'
	and  purno = :ls_purno ;
		
	update pbpur.opm101
	  set  pamt = :ld_pamt 
	where comltd = '01'
	and  purno = :ls_purno 
	and  trim(srno) = '' ;
	
	delete from pbpur.opm101
   where comltd = '01'
	and  purno = :ls_purno 
	and  trim(srno) <> '' ;
	
	//송금/오픈요청내역
	select coalesce(sum(fobamt),0) into :ld_blamt
	from pbpur.opm106
	where comltd = '01'
	and  purno = :ls_purno ;
	
	update pbpur.opm115
	  set  amt = :ld_ofamt + :ld_hc,
	       blamt = :ld_blamt,
			 opmstcd = (case when blamt <= :ld_blamt then 'Y' else 'N' end)
	where comltd = '01'
	and  purno = :ls_purno 
	and  trim(srno) = '' 
	and  srno1 = '01';
	
	delete from pbpur.opm115
   where comltd = '01'
	and  purno = :ls_purno 
	and  trim(srno) <> '' ;
   
	update pbpur.opm106
	  set  srno1 = '01',
	       srno2 = '01', 
			 bkno = 'L'
	where comltd = '01'
	and  purno = :ls_purno ;
	
next

uo_status.st_message.text	= '작업완료.'
//
//IF idw_21.Update(true,false) = 1 THEN
//	idw_21.ResetUpdate()
//	COMMIT USING SQLCA;
//	uo_status.st_message.text	=  f_message("U010")	// 입력되었습니다. 
//ELSE
//	ROLLBACK USING SQLCA;
//	uo_status.st_message.text	=  f_message("U020") // [저장실패] 정보시스템팀으로 연락바랍니다.
//END IF
setpointer(arrow!)



end event

type cb_4 from commandbutton within tabpage_2
integer x = 2971
integer y = 144
integer width = 517
integer height = 92
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "개설의뢰저장"
end type

event clicked;string ls_yymm
long ll_row,ll_rcnt, ll_srno

setpointer(hourglass!)

IF idw_22.accepttext() = -1 THEN
	messagebox('확인','저장할 자료에 데이타 오류발생, 에러난곳 수정후 저장하세요!',Exclamation!)
	Return
END IF

//자료체크
string ls_purno, ls_srno, ls_srno1, ls_srno2, ls_srno2_new, ls_opendt
dec {2} ld_blamt, ld_samt, ld_amt, ld_payamt

for ll_row = 1 to idw_22.rowcount()
	uo_status.st_message.text	= '행:' + string(ll_row) + ' 처리중입니다...'
//	if idw_22.object.samt[ll_row] = idw_22.object.amt[ll_row] then
//		continue
//	end if
	ls_purno = trim(idw_22.object.purno[ll_row])
	ls_srno  = trim(idw_22.object.srno[ll_row])
	ls_srno1 = trim(idw_22.object.srno1[ll_row])
	ls_srno2 = trim(idw_22.object.srno2[ll_row])
	ls_srno2_new = string(long(ls_srno2) + 1, "00")
	
	ld_blamt = idw_22.object.blamt[ll_row]
	ld_samt  = idw_22.object.samt[ll_row]
	ld_amt = idw_22.object.amt[ll_row]
	ls_opendt = trim(idw_22.object.opendt[ll_row])
	
	if ld_samt = 0 then
//		update pbpur.opm115
//		set amt = :ld_blamt,
//		    blamt = :ld_blamt,
//			 opmstcd = 'Y',
//			 opendt = condt,
//			 stcd = 'G'
//		where comltd = '01'
//		and   purno = :ls_purno
//		and   srno = :ls_srno
//		and   srno1 = :ls_srno1
//		and   srno2 = :ls_srno2 ;
		
		insert into pbpur.opm115
		select '01', purno, srno, srno1 , :ls_srno2_new,
				 tlgubun, 'N',ofdt, :ls_opendt, :ld_amt,0,0,
				 'N',0,
				 'N','C','LC개설 200601월 일괄작업으로 생성','','','','','', 
				 //오픈일자
				 '  ' ,'','','',
				 '','','20060105','','','',''
		from pbpur.opm103 a
		where comltd = '01'
		and  purno = :ls_purno
		and  srno  = :ls_srno
		and  srno1 = :ls_srno1 ;
		
		select coalesce(sum(amt + inc - dec),0) into :ld_payamt
		from pbpur.opm115
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno
		and   srno1 = :ls_srno1 ;
		
		update pbpur.opm103
		  set payamt = :ld_payamt
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno
		and   srno1 = :ls_srno1 ;
	else	
		update pbpur.opm115
		set //amt = :ld_amt,
		    //blamt = :ld_blamt,
			 //opmstcd = 'Y',
			 reqdt = :ls_opendt,
			 opendt = ' ',
			 stcd = 'C'
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno
		and   srno1 = :ls_srno1
		and   srno2 = :ls_srno2 ;
		
		select coalesce(sum(amt + inc - dec),0) into :ld_payamt
		from pbpur.opm115
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno
		and   srno1 = :ls_srno1 ;
		
		update pbpur.opm103
		  set payamt = :ld_payamt
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno
		and   srno1 = :ls_srno1 ;
		
	end if
	
next

uo_status.st_message.text	= '작업완료.'
//
//IF idw_21.Update(true,false) = 1 THEN
//	idw_21.ResetUpdate()
//	COMMIT USING SQLCA;
//	uo_status.st_message.text	=  f_message("U010")	// 입력되었습니다. 
//ELSE
//	ROLLBACK USING SQLCA;
//	uo_status.st_message.text	=  f_message("U020") // [저장실패] 정보시스템팀으로 연락바랍니다.
//END IF
setpointer(arrow!)



end event

type dw_22 from datawindow within tabpage_2
integer x = 9
integer y = 760
integer width = 4562
integer height = 1572
integer taborder = 60
string title = "none"
string dataobject = "d_opm999u_12"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
idw_22 = this





end event

type cb_2 from commandbutton within tabpage_2
integer x = 2967
integer y = 32
integer width = 338
integer height = 84
integer taborder = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Upload"
end type

event clicked;string ls_pathname, ls_yymm
long ll_row, ll_rcnt, ll_ecnt
long  ll_vat, ll_temp

//if g_s_empno = '970077' then
//	ls_PathName = 'C:\Documents and Settings\sam1\My Documents\2005외자구매process개선\'
//	//ls_FileName = 'C:\Documents and Settings\sam1\My Documents\2005외자구매process개선\화면설계서및관련프로그램.xls'
//else
//	ls_PathName = 'C:\'
//end if
//if g_s_empno = '030022' then
//	ls_PathName = 'D:\2005운임지불내역'
//end if
ls_pathname = 'C:\Documents and Settings\sam1\바탕 화면'
SetCurrentDirectorya(ls_pathname)

idw_21.reset()
idw_22.reset()
uo_status.st_message.text	= '업로드중입니다...'
f_pur040_getexcel(idw_21)  //숫자가 널이면 0으로 변경

if idw_21.rowcount() = 0 then
	return
end if

uo_status.st_message.text	= '업로드자료 확인중입니다...'
f_pur040_nullchk03(idw_21)

string ls_purno, ls_srno, ls_srno1, ls_srno2, ls_tlgubun
dec {2} ld_pamt, ld_ofamt, ld_lcamt, ld_lcamtbl, ld_blamt, ld_samt, ld_hc

for ll_row = 1 to idw_21.rowcount()
	uo_status.st_message.text	= '행:' + string(ll_row) + ' 자료확인중입니다...'
	ls_purno = trim(idw_21.object.purno[ll_row])
	ls_srno  = trim(idw_21.object.srno[ll_row])
	
	DECLARE CUR_1 CURSOR FOR
	 select srno1, trim(tlgubun) 
	 from pbpur.opm103
	 where comltd = '01'
	 and  purno = :ls_purno
	 and  srno  = :ls_srno ;
	 
	 OPEN CUR_1;
	 DO WHILE TRUE
		FETCH CUR_1 INTO  :ls_srno1, :ls_tlgubun;
		if sqlca.sqlcode <> 0  then
			exit
		end if
	   ll_rcnt = idw_22.insertrow(0)
		idw_22.object.tlgubun[ll_rcnt] = ls_tlgubun
	   idw_22.object.purno[ll_rcnt] = ls_purno
		idw_22.object.srno[ll_rcnt]  = ls_srno
		idw_22.object.srno1[ll_rcnt]  = ls_srno1
		select coalesce(sum(pamt),0) into :ld_pamt
		from pbpur.opm102
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno ;
		
		select coalesce(sum(hc),0) into :ld_hc
		from pbpur.opm101
		where comltd = '01'
		and   purno = :ls_purno
		and   srno = :ls_srno ;
		
		select coalesce(sum(ofamt),0) into :ld_ofamt
		from pbpur.opm103
		where comltd = '01'
		and   purno = :ls_purno
		and   srno  = :ls_srno 
		and   srno1 = :ls_srno1 ;
		
			
		select coalesce(sum(lcamt+lcamtu),0),coalesce(sum(lcamtbl),0) into :ld_lcamt,:ld_lcamtbl
		from  pbacc.fex020
		where comltd = '01'
		and   lcpono = :ls_purno ;
				
		select coalesce(sum(fobamt),0) into :ld_blamt
		from pbpur.opm106
		where comltd = '01'
		and   purno = :ls_purno
		and   srno  = :ls_srno ;
		
		//송금내역 오퍼의 전체합
		select coalesce(sum(amt + inc - dec),0) into :ld_samt
		from pbpur.opm115
		where comltd = '01'
		and   purno = :ls_purno
		and   srno  = :ls_srno 
		and   srno1 = :ls_srno1 ;
		
		select coalesce(max(srno2),'') into :ls_srno2
		from pbpur.opm115
		where comltd = '01'
		and   purno = :ls_purno
		and   srno  = :ls_srno 
		and   srno1 = :ls_srno1 ;
		
		idw_22.object.srno2[ll_rcnt]  = ls_srno2
		idw_22.object.pamt[ll_rcnt]   = ld_pamt + ld_hc
		idw_22.object.ofamt[ll_rcnt]  = ld_ofamt
		idw_22.object.lcamt[ll_rcnt]    = ld_lcamt
		idw_22.object.lcamtbl[ll_rcnt]  = ld_lcamtbl
		idw_22.object.blamt[ll_rcnt]  = ld_blamt
		idw_22.object.samt[ll_rcnt]   = ld_samt
		idw_22.object.amt[ll_rcnt]    = idw_21.object.amt[ll_row]
		idw_22.object.opendt[ll_rcnt]  = idw_21.object.opendt[ll_row]
	LOOP
CLOSE CUR_1;
				

next


uo_status.st_message.text	= '업로드 확인완료, 오류내역 있는 행은 노란색으로 표시됩니다.'
wf_icon_onoff(true,true,true,true,false,true,false,true,false) //I,A,U,D,P



end event

type dw_21 from datawindow within tabpage_2
integer x = 9
integer y = 20
integer width = 2930
integer height = 720
integer taborder = 40
string title = "none"
string dataobject = "d_opm999u_11a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
idw_21 = this





end event

event clicked;//This.SelectRow(0,False)
//This.SelectRow(row,True)
f_pur040_mselect(this, row)  //reference 'this'사용불가,변수값지정

//자료없는 부분 클릭시 선택 해제
IF dwo.name = "datawindow" Then
	This.SelectRow(0,false)
End IF
this.SetRedraw(False)
IF row < 1 THEN
   IF f_pur040_getobjph(this,is_colnm) = 1 THEN
		this.setsort(is_colnm)
      this.sort()
	 END IF
	 this.SetRedraw(True)
	 RETURN
END IF
this.SetRedraw(True)



end event

event itemchanged;string ls_yymm, ls_vsrno, ls_vsrno1,ls_temp,ls_ablno,ls_rblno,ls_itno
string ls_eta,ls_costdiv,ls_itno3,ls_itnm
dec {2} ld_blqty, ld_weight1,ld_fobamt
long ll_vat
long ll_row,ll_rcnt
ll_row = row	

Choose case dwo.name
case 'vsrno'
	ls_vsrno = trim(data)  //업체확인
	select count(*) into :ll_rcnt
	from pbpur.pur101
	where comltd = '01'
	and  vsrno = :ls_vsrno 
	and  substr(vsrno,1,1) = 'I';
	if ll_rcnt = 0 then
		messagebox('확인','행:' + string(ll_row) + ' 발행업체오류!,등록안됨')
		idw_21.object.chk[ll_row] = 1
		return 1
	end if
case 'vsrno1'	
	ls_vsrno1 = trim(data)
	if ls_vsrno1 = '' then
		idw_21.object.vsrno1[ll_row] = idw_21.object.vsrno[ll_row]
	else
	   select count(*) into :ll_rcnt
		from pbpur.pur101
		where comltd = '01'
		and  vsrno = :ls_vsrno1 
		and  substr(vsrno,1,1) = 'I';
		if ll_rcnt = 0 then
			messagebox('확인','행:' + string(ll_row) + ' 청구업체오류!,등록안됨')
			idw_21.object.chk[ll_row] = 1
			return 1
		end if
	end if
case 'idate'	
	ls_temp = trim(data)
	if trim(f_dateedit(ls_temp)) = '' then  //계산서발행일
	   messagebox('확인','행:' + string(ll_row) + ' 계산서발행일오류!')
		idw_21.object.chk[ll_row] = 1.
		return 1
	end if
case 'ablno','rblno'  //청구용BL/전산BL
	if dwo.name = 'ablno' then
		ls_ablno = trim(data)
		ls_rblno = trim(idw_21.object.rblno[ll_row])
	else
		ls_ablno = trim(idw_21.object.ablno[ll_row])
		ls_rblno = trim(data)
	end if
	
	if ls_rblno = '' then
		ls_rblno = ls_ablno
	   idw_21.object.rblno[ll_row] = ls_ablno
	end if
	select count(*), coalesce(max(ardt),'') into :ll_rcnt, :ls_eta
	from pbpur.opm105
	where comltd = '01'
	and  (blno = :ls_ablno 
	  or  blno  = :ls_rblno) ;
	if ll_rcnt = 0 then
		messagebox('확인','행:' + string(ll_row) + ' B/L오류!, 등록안됨')
		idw_21.object.chk[ll_row] = 1
		return 1
	else
		ls_costdiv = ''; ls_itno = ''; ld_blqty =0 ;
		select fobamt, xplant || costdiv, itno, itnm, 
		       blqty + ovqty  
		into :ld_fobamt, :ls_costdiv, :ls_itno, :ls_itnm, :ld_blqty
		from pbpur.opm106
		where comltd = '01'
		and  (blno = :ls_ablno 
		  or  blno  = :ls_rblno)
		 order by fobamt desc
		 fetch first 1 rows only;
		  
		idw_21.object.eta[ll_row] = ls_eta    //도착일
		idw_21.object.costdiv[ll_row] = ls_costdiv  //원가사업장
		idw_21.object.itnm[ll_row] = ls_itnm  //대표품명
		select coalesce(max(convqty1),0) into :ld_weight1  //전산선적중량계산
		from pbinv.inv101
		where  comltd = '01'
		and  itno = :ls_itno ;
		idw_21.object.weight1[ll_row] = round(ld_weight1 * ld_blqty,2) 
	end if
case 'country'	
	ls_temp = trim(data)
	select count(*)  into :ll_rcnt
	from pbcommon.dac002
	where  comltd = '01'
	and   cogubun = 'DAC050'
	and  cocode = :ls_temp ;
	if ll_rcnt = 0  then  //수입국가
	   messagebox('확인','행:' + string(ll_row) + ' 수입국가오류!')
		idw_21.object.chk[ll_row] = 1
		return 1
	end if
case 'country1'	
	if trim(data) = '' then
		idw_21.object.country1[ll_row] = idw_21.object.country[ll_row]
	else
		ls_temp = trim(data)
		select count(*)  into :ll_rcnt
		from pbcommon.dac002
		where comltd = '01'
		and  cogubun = 'DAC050'
		and  cocode = :ls_temp ;
		if ll_rcnt = 0  then  //선적국가
		   messagebox('확인','행:' + string(ll_row) + ' 선적국가오류!')
			idw_21.object.chk[ll_row] = 1
			return 1
		end if
	end if
case 'state'	
	//*****USA zone
	ls_temp = trim(data)
	if ls_temp <> '' then
		select count(*)  into :ll_rcnt
		from pbcommon.dac002
		where  comltd = '01'
		and   cogubun = 'PUR600'
		and  cocode = :ls_temp ;
		if ll_rcnt = 0  then  
			messagebox('확인','행:' + string(ll_row) + ' USA ZONE오류!')
			idw_21.object.chk[ll_row] = 1
			return 1
		end if
	end if
//*****항공운송사유
//case 'aircode'	
//	ls_temp = trim(data)
//	select count(*)  into :ll_rcnt
//	from pbcommon.dac002
//	where  comltd = '01'
//	and   cogubun = 'PUR601'
//	and  cocode = :ls_temp ;
//	if ll_rcnt = 0  then  
//		messagebox('확인','행:' + string(ll_row) + ' 항공운송사유 오류!')
//		idw_21.object.chk[ll_row] = 1
//		return 1
//	end if	
	//*****결제대분류
case 'xpay'	
	ls_temp = trim(data)
	select count(*)  into :ll_rcnt
	from pbcommon.dac002
	where  comltd = '01'
	and   cogubun = 'PUR601'
	and  cocode = :ls_temp ;
	if ll_rcnt = 0  then  
		messagebox('확인','행:' + string(ll_row) + ' 결제대분류오류!')
		idw_21.object.chk[ll_row] = 1
		return 1
	end if
case 'gubun'	
	//*****중량요금구분
	ls_temp = trim(data)
	select count(*)  into :ll_rcnt
	from pbcommon.dac002
	where  comltd = '01'
	and   cogubun = 'PUR602'
	and  cocode = :ls_temp ;
	if ll_rcnt = 0  then  
		messagebox('확인','행:' + string(ll_row) + ' 중량요금구분오류!')
		idw_21.object.chk[ll_row] = 1
		return 1
	end if
case 'weight'	
	//운임중량
	if dec(data) <= 0 then
		messagebox('확인','행:' + string(ll_row) + ' 운임중량오류!')
		idw_21.object.chk[ll_row] = 1
		return 1
	end if
case 'weight1'
case 'stotal1'  //영세율원금
	if isnull(data) then
		data = '0'
	end if
   idw_21.object.stotal2[ll_row] = idw_21.object.stotal[ll_row] - idw_21.object.stotal3[ll_row] - dec(data)
	ll_vat = idw_21.object.stotal2[ll_row]
	//ll_vat = ll_vat / 100
	ll_vat = ll_vat / 10
	idw_21.object.vat[ll_row] = ll_vat
	idw_21.object.total[ll_row] = idw_21.object.stotal[ll_row] + ll_vat
case 'stotal2'	 //일반원금=>부가세발생
	if isnull(data) then
		data = '0'
	end if
	idw_21.object.stotal1[ll_row] = idw_21.object.stotal[ll_row] - idw_21.object.stotal2[ll_row] - dec(data)
	ll_vat = dec(data)
	//ll_vat = ll_vat / 100
	ll_vat = ll_vat / 10
	idw_21.object.vat[ll_row] = ll_vat
	idw_21.object.total[ll_row] = idw_21.object.stotal[ll_row] + ll_vat
case 'stotal3'	 //비부가세원금
	if isnull(data) then
		data = '0'
	end if
	idw_21.object.stotal2[ll_row] = idw_21.object.stotal[ll_row] - idw_21.object.stotal1[ll_row] - dec(data)
	ll_vat = idw_21.object.stotal2[ll_row]
	//ll_vat = ll_vat / 100
	ll_vat = ll_vat / 10
	idw_21.object.vat[ll_row] = ll_vat
	idw_21.object.total[ll_row] = idw_21.object.stotal[ll_row] + ll_vat	
case else	  //나머지 전체 금액관련
	//운임합계 = 각항목합계 
	idw_21.accepttext()
	  idw_21.object.stotal[ll_row] = &
	   idw_21.object.afrt[ll_row] + idw_21.object.fsc[ll_row] + idw_21.object.ssc[ll_row] + & 
		idw_21.object.exwc[ll_row] + idw_21.object.ohc[ll_row] + idw_21.object.ccfee[ll_row] + & 
		idw_21.object.ooc[ll_row] + idw_21.object.dhc[ll_row] + idw_21.object.doc[ll_row]  
End choose



end event

event itemerror;return 1
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4581
integer height = 2344
long backcolor = 12632256
string text = "BL셋팅"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_31 dw_31
dw_30 dw_30
end type

on tabpage_3.create
this.dw_31=create dw_31
this.dw_30=create dw_30
this.Control[]={this.dw_31,&
this.dw_30}
end on

on tabpage_3.destroy
destroy(this.dw_31)
destroy(this.dw_30)
end on

type dw_31 from datawindow within tabpage_3
integer x = 14
integer y = 132
integer width = 4549
integer height = 2200
integer taborder = 60
string title = "none"
string dataobject = "d_opm999u_31"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
idw_31 = this

end event

type dw_30 from datawindow within tabpage_3
event ue_dwnkey pbm_dwnkey
integer x = 9
integer y = 16
integer width = 910
integer height = 96
integer taborder = 70
string title = "none"
string dataobject = "d_opm999u_30"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwnkey;if key=keyenter! then
	iw_sheet.triggerevent('ue_retrieve')
end if
end event

event constructor;this.settransobject(sqlca)
idw_30 = this

THIS.INSERTROW(0)
F_PUR040_NULLCHK03(THIS)





end event

event getfocus;f_pur040_toggle(handle(this),'ENG')
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4581
integer height = 2344
long backcolor = 12632256
string text = "결제은행 업로드"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_41 dw_41
end type

on tabpage_4.create
this.dw_41=create dw_41
this.Control[]={this.dw_41}
end on

on tabpage_4.destroy
destroy(this.dw_41)
end on

type dw_41 from datawindow within tabpage_4
integer x = 27
integer y = 88
integer width = 4526
integer height = 2236
integer taborder = 80
string title = "none"
string dataobject = "d_opm999u_41"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
idw_41 = this

end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4581
integer height = 2344
long backcolor = 12632256
string text = "메일보내기"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_17 cb_17
cb_10 cb_10
dw_51 dw_51
end type

on tabpage_5.create
this.cb_17=create cb_17
this.cb_10=create cb_10
this.dw_51=create dw_51
this.Control[]={this.cb_17,&
this.cb_10,&
this.dw_51}
end on

on tabpage_5.destroy
destroy(this.cb_17)
destroy(this.cb_10)
destroy(this.dw_51)
end on

type cb_17 from commandbutton within tabpage_5
integer x = 800
integer y = 40
integer width = 512
integer height = 92
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "메일발송테스트"
end type

event clicked;//********************각담당자에게 메일발송
long ll_row
string ls_name, ls_mail
int li_rtn
//uo_status.st_message.text = ''

setpointer(hourglass!)
string as_mailaddr = 'adelia@paran.com'
string as_subject, as_mail_body

as_subject = '메일테스트'
as_mail_body = '메일테스트' + &
              '~r~r테스트완료...'

OLEobject	Mail  // 등록한 컴포넌트를  OLE 객체로 선언.
Mail = Create OLEobject // OLE 객체 생성.

///f_pur041_mailsend_name(ls_vname,ls_mail, ls_subject,ls_mail_body) ////메일주소로 보내기

// 레지스트리에 등록된 외부 컴포넌트(AspEmail.dll)에 Access해서 파워빌더에서 사용가능한
// OLE 객체로 생성.
li_rtn = Mail.ConnectToNewObject("Persits.MailSender")

If li_rtn <> 0 Then // Access에 실패하면...
	//MessageBox("Error", "Could not create Mail Object!")
	MessageBox("Error", "[GWP > 도우미 > 공개자료실 > 전체보기]에서 kdac용 메일발송 프로그램 설치하세요!")
//	uo_status.st_message.text = "메일 컴포넌트를 설치하시고 작업하시기 바랍니다(노츠자료실참조)."
   destroy Mail
	Return -1
End If

//if trim(as_mailaddr) = '' then
//	MessageBox("확인",'이름:' + ls_name + " 메일수신자 메일주소 확인요!",&
//									  exclamation!)	
//	Mail.DisConnectObject( )
//	destroy Mail								  
//	return -3
//end if

//  **담당자 메일보내기 *** //
Mail.Reset // Mail객체 초기화.
Mail.IsHTML 	= True    //메일 내용을 HTML 형식으로 보낼것인가 여부를 결정.
//Mail.Host   	= "mail.kdac.co.kr"  // SMTP 서버(우리는 Notes!!) 설정.
Mail.Host   	= "121.182.131.132"  //홈페이지 서버.외부메일

ls_mail = f_pur040_get_mailaddr(g_s_empno ,'1')  //1-본인, 2-부서장
//if match(trim(ls_mail), '@kdac.co.kr') = false or trim(ls_mail) = '@kdac.co.kr' then
//	select coalesce(max(penamek),'') into :ls_name
//	from pbcommon.dac003
//	where peempno = :g_s_empno ;
//	MessageBox("확인",'이름:' + ls_name + " 메일발신자 메일주소 확인요! kdac메일만 됩니다(....@kdac.co.kr)!",&
//									  exclamation!)	
//	Mail.DisConnectObject( )
//	destroy Mail								  
//	return -3
//end if
ls_mail = f_pur040_get_mailaddr(g_s_empno ,'1')  // 보내는 사람 주소 설정.
Mail.From		= ls_mail   // 보내는 사람 주소 설정.
Mail.FromName  = g_s_empno + " " + ls_name  // 보내는 사람 이름 설정.


Mail.AddAddress( as_mailaddr ) // 받는 사람 메일주소 설정.	
Mail.Subject   = as_subject    // 메일 제목 설정.

Mail.Body	 = as_mail_body
 // 메일 내용 설정.	
Mail.Send  //   --->  메일 발송.


Mail.DisConnectObject( )
destroy Mail	
uo_status.st_message.text = '메일발송 완료'

setpointer(arrow!)
return 1




end event

type cb_10 from commandbutton within tabpage_5
integer x = 50
integer y = 52
integer width = 457
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "메일발송"
end type

event clicked;string ls_empno, ls_mail
string ls_subject, ls_mail_body
long ll_rtn, ll_row
uo_status.st_message.text = '메일 발송중..'
setpointer(hourglass!)
//ls_empno = f_pur040_get_empno(g_s_empno)
//if ls_empno = '' then
//	messagebox('확인','팀장사번 조회 오류! 확인 및 연락바랍니다.',Exclamation!)
//	uo_status.st_message.text = '팀장사번 조회 오류! 확인 및 연락바랍니다.'
//	return
//end if

ls_subject = '한국델파이 협력업체 전산시스템 파악관련 요청메일입니다.'  
ls_mail_body = '  ' + &
               '~r~r  안녕하세요? 한국델파이 시스템개발팀(전산실) 심재범입니다.' + &
               '~r~r  갑자기 메일 드려 죄송합니다.' + & 
				    '~r~r  다름이 아니라 아래와 같이 ' + &
					 '~r~r  저희 부서에서 협력업체 전산시스템 현황파악 및 관리목적으로  몇가지 내역을 참고하고자 합니다.' + &
					  '~r~r  잠깐의 시간을 내시어 회신을 주시면 정말 감사하겠습니다.' + &
					   '~r~r~r  *************** 아         래 ***************' + &
					   '~r~r  전산실 인원:' + &
					   '~r~r  전산시스템(자체ERP,SAP등):' + &
						'~r~r  *******************************************' + &
					   '~r~r  다시 한번 바쁜신데 불편을 드려 죄송합니다.' + &
					   '~r~r===========================' + &
						'~rKDAC IS&S' + &
						'~rTEL : 053-610-2234' + &
						'~rMobile : 010-2811-6127' + &
						'~rE-mail : jbshim@kdac.co.kr' + &
                  '~r===========================' 
for ll_row = 1 to idw_51.rowcount()
	ls_empno = trim(idw_51.object.f[ll_row])
	ls_mail = trim(idw_51.object.g[ll_row])
	ll_rtn = f_pur041_mailsend1(ls_empno,ls_mail,ls_subject,ls_mail_body) 
	//ll_rtn = f_pur041_mailsend(g_s_empno,'970077',ls_subject,ls_mail_body) 
	if ll_rtn <> 1 then
	  uo_status.st_message.text = '행:' + string(ll_row) + ' 메일발송 기능설치 또는 메일주소 확인후 재작업하세요.'
	  //return
	end if
	uo_status.st_message.text = '행:' + string(ll_row) + '메일 발송완료.'
next
uo_status.st_message.text = '메일 발송완료.'
setpointer(arrow!)
return

end event

type dw_51 from datawindow within tabpage_5
integer x = 41
integer y = 172
integer width = 4507
integer height = 2148
integer taborder = 80
string title = "none"
string dataobject = "d_opm999u_51"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;idw_51 = this

end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4581
integer height = 2344
long backcolor = 12632256
string text = "어음연장업체등록"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_12 cb_12
cb_11 cb_11
dw_61 dw_61
end type

on tabpage_6.create
this.cb_12=create cb_12
this.cb_11=create cb_11
this.dw_61=create dw_61
this.Control[]={this.cb_12,&
this.cb_11,&
this.dw_61}
end on

on tabpage_6.destroy
destroy(this.cb_12)
destroy(this.cb_11)
destroy(this.dw_61)
end on

type cb_12 from commandbutton within tabpage_6
integer x = 2830
integer y = 20
integer width = 475
integer height = 92
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "PUR102기준"
end type

event clicked;long ll_row, ll_rcnt, ll_srno,ll_ok
setpointer(hourglass!)

//자료체크
string ls_dept, ls_vsrno, ls_vndr, ls_vndnm, ls_xstop,ls_pdate 
ls_pdate = '20090131'  //마감일

declare cur_1 cursor for
 select a.dept, a.vsrno, b.vndr, b.vndnm
 from  pbpur.pur102 a, pbpur.pur101 b
 where a.comltd = '01'
 and  b.comltd = '01'
 and  a.vsrno = b.vsrno
 and  a.xstop = 'O'
 and  a.dept = 'R'
 and  a.vdl = '5'
// and  a.vsrno = 'D3167'
 order by 1,2,3;

OPEN cur_1;
DO WHILE TRUE
	FETCH cur_1 INTO  :ls_dept, :ls_vsrno, :ls_vndr, :ls_vndnm;
	if sqlca.sqlcode <> 0 then
		exit
	end if
//   if ls_dept = 'P' then
//		ls_dept = 'L'
//	end if
	select count(*) into :ll_rcnt
	from  pbacc.acc518
	where comltd = '01'
	and  pdate = :ls_pdate
	and  pcode = :ls_vndr
	and  pdept = (case when :ls_dept = 'P' then 'L' else :ls_dept end);
	if ll_rcnt > 0 then
		continue
	end if
	ll_row = +1
   insert into pbacc.acc518
	SELECT '01',    //COMLTD,   
         :ls_pdate,   //PDATE,   
         a.vndr,       //PCODE,   
         B.XPAY1,        //PTYPE,   
		   (case when b.dept = 'P' then 'L' else b.dept end),   //PDEPT,   
         'Y',    //PYN,   
         '5',    //PMCNT,   
         '',     //EXTD,   
         'PBATCH',  //INPTID,   
         :g_s_date,  //INPTDT,   
         'UPLOAD',   //UPDTID,   
         '',   //UPDTDT,   
         '',   //IPADDR,   
         ''    //MACADDR  
    FROM PBpur.pur101 a, pbpur.pur102 b
	 where a.comltd = '01'
	 and   b.comltd = '01'
	 and   a.vsrno = b.vsrno
	 and   a.vsrno = :ls_vsrno
	 and   b.dept = :ls_dept
	 and   b.xstop = 'O';
	uo_status.st_message.text	= '행:' + string(ll_row) +  '개 작업완료..'	
LOOP
CLOSE cur_1;

setpointer(arrow!)



end event

type cb_11 from commandbutton within tabpage_6
integer x = 2249
integer y = 16
integer width = 475
integer height = 92
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "자료수정"
end type

event clicked;string ls_yymm
long ll_row, ll_rcnt, ll_srno,ll_ok

setpointer(hourglass!)

IF idw_61.accepttext() = -1 THEN
	messagebox('확인','저장할 자료에 데이타 오류발생, 에러난곳 수정후 저장하세요!',Exclamation!)
	Return
END IF

//자료체크
string ls_dept, ls_vsrno, ls_vndr, ls_vndnm, ls_xstop 


for ll_row = 1 to idw_61.rowcount()
//	uo_status.st_message.text	= '행:' + string(ll_row) + ' 처리중입니다...'
//	if idw_12.object.yn[ll_row] <> 'Y' then
//		continue
//	end if
   ls_dept  = trim(idw_61.object.dept[ll_row])
	ls_vsrno = trim(idw_61.object.a[ll_row])
	ls_vndr  = trim(idw_61.object.b[ll_row])
	ls_vndnm = trim(idw_61.object.c[ll_row])
	
	select count(*), coalesce(max(xstop),'X') 
	 into :ll_rcnt, :ls_xstop
	from pbpur.pur102
	where comltd = '01'
	and   dept  = :ls_dept
	and   vsrno = :ls_vsrno
	and   xstop = 'O';
	if ll_rcnt <> 1  then
		messagebox('확인','행:' + string(ll_row) + ' 업체명:' + ls_vndnm + ' 업체상세정보없음!')
		uo_status.st_message.text	= '행:' + string(ll_row) + ' 업체명:' + ls_vndnm + ' 업체상세정보없음!'
//		return
	end if

//	if ls_xstop <> 'O' then
//		messagebox('확인','행:' + string(ll_row) + ' 업체명:' + ls_vndnm + ' 중단된업체!')
//		uo_status.st_message.text	= '행:' + string(ll_row) + ' 업체명:' + ls_vndnm + ' 중단된업체!'
////		return
//	end if
	
//	select count(*) into :ll_rcnt
//	from pbpur.pur101
//	where comltd = '01'
//	and   scgubun = 'S'
//	and   digubun = 'D'
//	and   vsrno = :ls_vsrno
//	and   vndr  = :ls_vndr;
//	if ll_rcnt = 0 then
//		messagebox('확인','행:' + string(ll_row) + ' 업체명:' + ls_vndnm + ' 업체전산번호와 사업자번호 상이!')
//		uo_status.st_message.text	= '행:' + string(ll_row) + ' 업체명:' + ls_vndnm + ' 업체전산번호와 사업자번호 상이!'
//		return
//	end if
	uo_status.st_message.text	= '행:' + string(ll_row) + '/' + string(idw_61.rowcount()) + '번 확인완료..'	
next


//return
ll_ok = MessageBox("확인", ' 자료확정합니다. 확인키를 누르세요!', &
		Exclamation!, OKCancel!, 2)
IF ll_ok <> 1 THEN
	 uo_status.st_message.text = '작업취소'
	 return
END IF

for ll_row = 1 to idw_61.rowcount()
	ls_dept  = trim(idw_61.object.dept[ll_row])
	ls_vsrno = trim(idw_61.object.a[ll_row])
	ls_vndr  = trim(idw_61.object.b[ll_row])
	ls_vndnm  = trim(idw_61.object.c[ll_row])
	
	update pbpur.pur102
	   set vdl = '5'
	where comltd = '01'
	and  dept = :ls_dept
	and  vsrno = :ls_vsrno
	and  xstop = 'O';
//	if sqlca.sqlcode <> 0 then
//		messagebox('업체상세수정오류','행:' + string(ll_row) + + ' 업체명:' + ls_vndnm + ' 수정중 오류발생!')
//		messagebox('확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
//		uo_status.st_message.text = '행:' + string(ll_row) + + ' 업체명:' + ls_vndnm + ' 수정중 오류발생!'
//		RETURN
//	end if
	
	insert into pbacc.acc518
	SELECT '01',    //COMLTD,   
         '20081130',  //PDATE,   
         a.vndr,       //PCODE,   
         B.XPAY1,        //PTYPE,   
         b.dept,   //PDEPT,   
         'Y',    //PYN,   
         '5',    //PMCNT,   
         '',     //EXTD,   
         'BATCH',  //INPTID,   
         :g_s_date,  //INPTDT,   
         '',   //UPDTID,   
         '',   //UPDTDT,   
         '',   //IPADDR,   
         ''    //MACADDR  
    FROM PBpur.pur101 a, pbpur.pur102 b
	 where a.comltd = '01'
	 and   b.comltd = '01'
	 and   a.vsrno = b.vsrno
	 and   a.vsrno = :ls_vsrno
	 and   b.dept = :ls_dept
	 and   b.xstop = 'O';
	 uo_status.st_message.text	= '행:' + string(ll_row) + '/' + string(idw_61.rowcount()) + '번 생성완료..'	
next


//uo_status.st_message.text	= '작업완료'
setpointer(arrow!)



end event

type dw_61 from datawindow within tabpage_6
integer y = 136
integer width = 4265
integer height = 2176
integer taborder = 230
string title = "none"
string dataobject = "d_opm999u_61"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;idw_61 = this

end event

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4581
integer height = 2344
long backcolor = 12632256
string text = "검사기준/성적서작업"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_21 cb_21
cb_20 cb_20
cb_16 cb_16
cb_15 cb_15
cb_14 cb_14
cb_13 cb_13
dw_71 dw_71
end type

on tabpage_7.create
this.cb_21=create cb_21
this.cb_20=create cb_20
this.cb_16=create cb_16
this.cb_15=create cb_15
this.cb_14=create cb_14
this.cb_13=create cb_13
this.dw_71=create dw_71
this.Control[]={this.cb_21,&
this.cb_20,&
this.cb_16,&
this.cb_15,&
this.cb_14,&
this.cb_13,&
this.dw_71}
end on

on tabpage_7.destroy
destroy(this.cb_21)
destroy(this.cb_20)
destroy(this.cb_16)
destroy(this.cb_15)
destroy(this.cb_14)
destroy(this.cb_13)
destroy(this.dw_71)
end on

type cb_21 from commandbutton within tabpage_7
integer x = 2066
integer y = 52
integer width = 553
integer height = 92
integer taborder = 240
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "검사기준서삭제"
end type

event clicked;long  ll_row, ll_rcnt, ll_rcnt1, ll_rtn
string ls_database
string ls_revno_from, ls_revno_to, ls_xplant, ls_div, ls_vsrno, ls_itno , ls_date
string ls_plant[]
transaction lt_ipis
////검사기준서 업체코드누락된 내역 삭제
//ls_revno_from = '01' ////현재살아있는 내역..최종
//ls_revno_to  = '00'
//ls_xplant = 'D'
//ls_div = 'S'
//ls_vsrno = 'D3817'
//ls_itno = '522908'
////DM,DS 192.168.108.249,1433
////DA    192.168.103.249,1433
////DV,DH 192.168.109.249,1433
ls_plant[1] = 'DM'
ls_plant[2] = 'DS'
ls_plant[3] = 'DA'
ls_plant[4] = 'DV'
ls_plant[5] = 'DH'
ls_plant[6] = 'JH'
ls_plant[7] = 'JM'
ls_plant[8] = 'JS'
ls_plant[9] = 'KH'
ls_plant[10] = 'KM'
ls_plant[11] = 'KS'
ls_plant[12] = 'KV'
ls_plant[13] = 'BH'
ls_plant[14] = 'BM'
ls_plant[15] = 'BS'
ls_plant[16] = 'BV'
ls_plant[17] = 'BY'
ls_plant[18] = 'BA'

for ll_row = 1 to 16
ls_xplant = mid(ls_plant[ll_row],1,1)	
ls_div = mid(ls_plant[ll_row],2,1)	

ls_database = 'IPIS'
Choose case ls_xplant + ls_div
	case 'DM','DS'
		gs_servername = '192.168.108.249,1433'
	case 'DA'
		gs_servername = '192.168.103.249,1433'
	case 'DV','DH'
		gs_servername = '192.168.109.249,1433'
	case 	'JH','JM','JS'
		gs_servername = '192.168.112.72,1433'
	case 	'KH','KM','KS','KV'
		gs_servername = '192.168.113.248,1433'	
	case 	'BH','BM','BS','BV','BY','BA'
		gs_servername = '192.168.113.248,1433'		
End choose

lt_ipis 					= 	CREATE transaction
lt_ipis.ServerName 	= 	gs_servername
lt_ipis.DBMS       	= 	ProfileString(gs_inifile,g_s_serverarea,"DBMS",			" ")
lt_ipis.Database   	= 	ls_database
lt_ipis.LogID      	= 	ProfileString(gs_inifile,g_s_serverarea,"LogId",			" ")
lt_ipis.LogPass    	= 	'goipis'
lt_ipis.DBParm 		   = 	"CommitOnDisconnect='No'"
lt_ipis.AutoCommit 	= 	True
gs_appname	         = ProfileString(gs_inifile,"PARAMETER","AppName",            " ")

connect using lt_ipis;

If lt_ipis.sqlcode <> 0 then
	disconnect using lt_ipis ;
	destroy lt_ipis
	if g_l_connect = -1 then
		messagebox("확인","데이타베이스 연결 오류 [정보시스템팀]으로 연락바랍니다.")
      return
	end if
//	lt_ipis	= 	CREATE transaction
//	lt_ipis 	=	sqlca
//	connect using lt_ipis;
//	g_l_connect = -2
end if

lt_ipis.autocommit = true

setpointer(hourglass!)
uo_status.st_message.text	= '삭제중....'

  select count(*) into :ll_rcnt
  from  tqqcstandard
	 where areacode = :ls_xplant
	 and   divisioncode = :ls_div
	 and   suppliercode = ''
	 using lt_ipis;	
	
  select count(*) into :ll_rcnt1
  from  tqqcstandarddetail
	 where areacode = :ls_xplant
	 and   divisioncode = :ls_div
	 and   suppliercode = ''
	 using lt_ipis;		


ll_rtn = MessageBox("확인", ' 삭제합니다.' + ls_plant[ll_row] + string(ll_rcnt) + ';' + string(ll_rcnt1), &
		Exclamation!, OKCancel!, 2)
IF ll_rtn <> 1 THEN
	disconnect using lt_ipis ;
	uo_status.st_message.text = '작업취소'
	return
END IF
 delete
  from  tqqcstandard
	 where areacode = :ls_xplant
	 and   divisioncode = :ls_div
	 and   suppliercode = ''
	 using lt_ipis;	
	
  delete
  from  tqqcstandarddetail
	 where areacode = :ls_xplant
	 and   divisioncode = :ls_div
	 and   suppliercode = ''
	 using lt_ipis;		


disconnect using lt_ipis ;
destroy lt_ipis
uo_status.st_message.text	= ls_plant[ll_row] + ':' + string(ll_rcnt) + ' 삭제완료.'
//Sleep ( 3 )
next

setpointer(arrow!)
return 


end event

type cb_20 from commandbutton within tabpage_7
integer x = 640
integer y = 52
integer width = 846
integer height = 92
integer taborder = 240
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "검사기준서복구(01=>00)"
end type

event clicked;////검사기준서 업데이트 01에서 00으로 전환
long  ll_row, ll_rcnt, ll_rtn
string ls_database
string ls_revno_from, ls_revno_to, ls_xplant, ls_div, ls_vsrno, ls_itno , ls_date

////리비젼 00에서 01 전환.  승인시 문제발생한 듯....
////승인요청할때 이전내역 삭제됨 또는 승인요청후 qc반송될때 문제가 발생하는 듯...
ls_revno_from = '00' ////현재살아있는 내역..최종
ls_revno_to  = '01'
ls_xplant = 'D'
ls_div = 'S'
ls_vsrno = 'D3817'
ls_itno = '522908'
////DM,DS 192.168.108.249,1433
////DA    192.168.103.249,1433
////DV,DH 192.168.109.249,1433

ls_database = 'IPIS'
Choose case ls_xplant + ls_div
	case 'DM','DS'
		gs_servername = '192.168.108.249,1433'
	case 'DA'
		gs_servername = '192.168.103.249,1433'
	case 'DV','DH'
		gs_servername = '192.168.109.249,1433'
	case 	'JH','JM','JS'
		gs_servername = '192.168.112.72,1433'
	case 	'KH','KM','KS','KV'
		gs_servername = '192.168.113.248,1433'	
	case 	'BH','BM','BS','BV','BY','BA'
		gs_servername = '192.168.113.248,1433'		
End choose

SQLPIS 					= 	CREATE transaction
SQLPIS.ServerName 	= 	gs_servername
SQLPIS.DBMS       	= 	ProfileString(gs_inifile,g_s_serverarea,"DBMS",			" ")
SQLPIS.Database   	= 	ls_database
SQLPIS.LogID      	= 	ProfileString(gs_inifile,g_s_serverarea,"LogId",			" ")
SQLPIS.LogPass    	= 	'goipis'
SQLPIS.DBParm 		   = 	"CommitOnDisconnect='No'"
SQLPIS.AutoCommit 	= 	True
gs_appname	         = ProfileString(gs_inifile,"PARAMETER","AppName",            " ")

connect using SQLPIS;

If SQLPIS.sqlcode <> 0 then
	disconnect using sqlpis ;
	destroy sqlpis
	if g_l_connect = -1 then
		messagebox("확인","데이타베이스 연결 오류 [정보시스템팀]으로 연락바랍니다.")
      return
	end if
//	SQLPIS	= 	CREATE transaction
//	SQLPIS 	=	sqlca
//	connect using SQLPIS;
//	g_l_connect = -2
end if

sqlpis.autocommit = true

setpointer(hourglass!)
uo_status.st_message.text	= '조회중....'

	uo_status.st_message.text	= string(ll_row) + '건 조회중....'
//   ////데이타수정
//	UPDATE tqqcstandard
//	   SET CHARGECONSERTFLAG = 'Y',
//	       SANCTIONCONSERTFLAG = 'Y',
//	       CONSERTDATE = APPLYDATE
//	 where areacode = :ls_xplant
//	 and   divisioncode = :ls_div
//	 and   suppliercode = :ls_vsrno
//	 and   itemcode     = :ls_itno
//	 and   standardrevno = :ls_revno_to
//	 using sqlpis;		 
//	 
//	 continue
////FROM-00을 지우고 TO-01을 삽입
  delete from  tqqcstandard
	 where areacode = :ls_xplant
	 and   divisioncode = :ls_div
	 and   suppliercode = :ls_vsrno
	 and   itemcode     = :ls_itno
	 and   standardrevno = :ls_revno_from
	 using sqlpis;	
	//  delete from  tqqcstandardchange
//	 where areacode = :ls_xplant
//	 and   divisioncode = :ls_div
//	 and   suppliercode = :ls_vsrno
//	 and   itemcode     = :ls_itno
//	 and   standardrevno = :ls_revno_from
//	 using sqlpis;	
//  ////최신것은 스탠다드에만...나머지는 전부 change에 있어야 한다.
//***************************************승인요청중 성적서등록할때 가장 많이 발생change에 현재 사용중인
//                                        기준서없음.  이전개정번호 또는 승인요청중인 것만 있다
//검사기준서헤드  항상 한개만 있어야 된다. ==> 초기,개정중 상관없음
		 
		 insert into tqqcstandard
		 SELECT AREACODE,   
         DIVISIONCODE,   
         SUPPLIERCODE,   
         ITEMCODE,   
         STANDARDREVNO,    //:ls_revno_to,   //STANDARDREVNO,   
         CHARGENAME,   
         ENACTMENTDATE,   
         ITEMRANK,   
         QUALITY,   
         HEATTREATMENT,   
         SURFACETREATMENT,   
         QCCONCEPTIONREFERENCE,   
         BADTREATMENT,   
         CONSERTDEPENDENCEFLAG,   
			drawingname, 
         CHARGECODE,   
         CHARGECONSERTFLAG,   //'Y',  //CHARGECONSERTFLAG,   
         SANCTIONCODE,   
         SANCTIONCONSERTFLAG,    //'Y',  //SANCTIONCONSERTFLAG,   
         CONSERTDATE,   //(case when :ls_date <> '' then :ls_date else APPLYDATE end),  //CONSERTDATE,   
         RETURNREASON,   
         MODIFYCONTENT,   
         CHANGEFLAG,   //'N',   //CHANGEFLAG,   
		   APPLYDATE,   //(case when :ls_date <> '' then :ls_date else APPLYDATE end),  //APPLYDATE,   
         LastEmp,   
         LastDate,   
         ItemRevno 
		 from tqqcstandardchange
		 where areacode = :ls_xplant
		 and   divisioncode = :ls_div
		 and   suppliercode = :ls_vsrno
		 and   itemcode = :ls_itno
		 and   standardrevno = :ls_revno_to
		 using sqlpis;	
		 uo_status.st_message.text	= '품번:' + ls_itno + ':' + ls_revno_to  + ' 기준서내역 처리완료....'
	
	 ////*******************************************************검사기준서변경헤드 내역
	
//	 
//	 select count(*) into :ll_rcnt
//	 from tqqcstandardchange
//	 where areacode     = :ls_xplant
//	 and   divisioncode = :ls_div
//	 and   suppliercode = :ls_vsrno
//	 and   itemcode = :ls_itno
//	 and   standardrevno = :ls_revno_to
//	 using sqlpis;
//	 //검사기준서변경이력헤드 삽입
//	 if ll_rcnt = 0 then
//		 insert into tqqcstandardchange
//		 SELECT AREACODE,   
//				DIVISIONCODE,   
//				SUPPLIERCODE,   
//				ITEMCODE,   
//				:ls_revno_to,   //STANDARDREVNO,   
//				CHARGENAME,   
//				ENACTMENTDATE,   
//				CONSERTDATE,   
//				ITEMRANK,   
//				QUALITY,   
//				HEATTREATMENT,   
//				SURFACETREATMENT,   
//				QCCONCEPTIONREFERENCE,   
//				BADTREATMENT,   
//				CONSERTDEPENDENCEFLAG,  
//				drawingname,  
//				CHARGECODE,   
//				CHARGECONSERTFLAG,   
//				SANCTIONCODE,   
//				SANCTIONCONSERTFLAG,   
//				RETURNREASON,   
//				CHANGEFLAG,   
//				REJECTTREATMENT,   
//				MODIFYCONTENT,   
//				MODIFYDATE,   
//				APPLYDATE,   
//				LastEmp,   
//				LastDate,   
//				ItemRevno  
//		 FROM TQQCSTANDARDCHANGE  
//		 where areacode = :ls_xplant
//		 and   divisioncode = :ls_div
//		 and   suppliercode = :ls_vsrno
//		 and   itemcode = :ls_itno
//		 and   standardrevno = :ls_revno_from
//		 using sqlpis;	
//		 uo_status.st_message.text	= '품번:' + ls_itno + ':' + ls_revno_to  + ' 기준서변경내역 처리완료....'
//	 end if
	  ////*******************************************************검사기준서디테일 내역
	delete
	FROM TQQCSTANDARDDETAIL  
	 where areacode = :ls_xplant
	 and   divisioncode = :ls_div
	 and   suppliercode = :ls_vsrno
	 and   itemcode = :ls_itno
	 and   standardrevno = :ls_revno_from
	
	 insert into TQQCSTANDARDDETAIL
	 (AREACODE,   	DIVISIONCODE,   	SUPPLIERCODE,   
		ITEMCODE,   		STANDARDREVNO,  		ORDERNO,   
		QCITEM,   		DECISIONRANK,   		ITEMSPECQUALITY,   
		SAMPLE,   		QCSTRUCTURE,   		QCSTIPULATION,   
		LastEmp,   		LastDate  )
	 SELECT AREACODE,   
		DIVISIONCODE,   
		SUPPLIERCODE,   
		ITEMCODE,   
		STANDARDREVNO,   //:ls_revno_to,  //STANDARDREVNO,   
		ORDERNO,   
		QCITEM,   
		DECISIONRANK,   
		ITEMSPECQUALITY,   
		SAMPLE,   
		QCSTRUCTURE,   
		QCSTIPULATION,   
		LastEmp,   
		LastDate  
	 FROM TQQCSTANDARDDETAIL  
	 where areacode = :ls_xplant
	 and   divisioncode = :ls_div
	 and   suppliercode = :ls_vsrno
	 and   itemcode = :ls_itno
	 and   standardrevno = :ls_revno_to
	 using sqlpis;
//	 and   orderno not in (select orderno 
//									 from  tqqcstandarddetail
//									 where areacode = :ls_xplant
//									 and   divisioncode = :ls_div
//									 and   suppliercode = :ls_vsrno
//									 and   itemcode = :ls_itno
//									 and   standardrevno = :ls_revno_to)
	
	 uo_status.st_message.text	= '품번:' + ls_itno + ':' + ls_revno_to  + ' 기준서디테일내역 처리완료....'
	 ////개정번호별로 없는 것은 전부 채워줘야 됨.
//	 insert into TQQCSTANDARDCHANGEDETAIL
//	 SELECT AREACODE,   
//		DIVISIONCODE,   
//		SUPPLIERCODE,   
//		ITEMCODE,   
//		:ls_revno_to,  //STANDARDREVNO,   
//		ORDERNO,   
//		QCITEM,   
//		DECISIONRANK,   
//		ITEMSPECQUALITY,   
//		SAMPLE,   
//		QCSTRUCTURE,   
//		QCSTIPULATION,   
//		LastEmp,   
//		LastDate  
//	 FROM TQQCSTANDARDCHANGEDETAIL  
//	 where areacode = :ls_xplant
//	 and   divisioncode = :ls_div
//	 and   suppliercode = :ls_vsrno
//	 and   itemcode = :ls_itno
//	 and   standardrevno = :ls_revno_from
//	 and   orderno not in (select orderno 
//								  from  TQQCSTANDARDCHANGEDETAIL
//									 where areacode = :ls_xplant
//									 and   divisioncode = :ls_div
//									 and   suppliercode = :ls_vsrno
//									 and   itemcode = :ls_itno
//									 and   standardrevno = :ls_revno_to)
//	 using sqlpis;	
//	 uo_status.st_message.text	= '품번:' + ls_itno + ':' + ls_revno_to  + ' 기준서디테일변경내역 처리완료....'

disconnect using sqlpis ;
destroy sqlpis
setpointer(arrow!)
return 


end event

type cb_16 from commandbutton within tabpage_7
integer x = 3794
integer y = 56
integer width = 517
integer height = 92
integer taborder = 210
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "구매요구삭제"
end type

event clicked;long ll_row, ll_rcnt
setpointer(hourglass!)

//select count(*) from pbpur.pur302
//where comltd = '01'
//and  rqno = '41009010009';

//delete from pbpur.pur302
//where comltd = '01'
//and  srno in ('910016DA','910017DA','910019DA','910194DA','910195DA');
//


uo_status.st_message.text	= '작업완료'
setpointer(arrow!)

end event

type cb_15 from commandbutton within tabpage_7
integer x = 3255
integer y = 52
integer width = 517
integer height = 92
integer taborder = 210
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "발주테스트"
end type

event clicked;setpointer(hourglass!)

sqlca.autocommit = false

//delete from pbpur.pur401
//where comltd = '01'
//and  purno in (
//'23009030034',
//
//'23009030035',
//
//'23009030036',
//
//'23009030037',
//
//'23009030038',
//
//'23009030039',
//
//'23009030040',
//
//'23009030041',
//
//'23009030042',
//
//'23009030043',
//
//'23009030044',
//
//'23009030045',
//
//'23009030046',
//
//'23009030047',
//
//'23009030048'
//);
string ls_purno, ls_msg

//f_pur041_crtpur(

rollback using sqlca;

uo_status.st_message.text	= '작업완료'

sqlca.autocommit = true
setpointer(arrow!)

end event

type cb_14 from commandbutton within tabpage_7
integer x = 41
integer y = 52
integer width = 553
integer height = 92
integer taborder = 240
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "검사기준서조회"
end type

event clicked;long  ll_row, ll_rcnt, ll_rtn
string ls_database
string ls_revno_from, ls_revno_to, ls_xplant, ls_div, ls_vsrno, ls_itno , ls_date

////리비젼 01에서 00 복사
////승인요청할때 이전내역 삭제됨 또는 승인요청후 qc반송될때 문제가 발생하는 듯...
//ls_revno_from = '01' 
//ls_revno_to  = '00'
ls_xplant = 'D'
ls_div = 'S'
//ls_vsrno = 'D2883'
////DM,DS 192.168.108.249,1433
////DA    192.168.103.249,1433
////DV,DH 192.168.109.249,1433

ls_database = 'IPIS'
Choose case ls_xplant + ls_div
	case 'DM','DS'
		gs_servername = '192.168.108.249,1433'
	case 'DA'
		gs_servername = '192.168.103.249,1433'
	case 'DV','DH'
		gs_servername = '192.168.109.249,1433'
	case 	'JH','JM','JS'
		gs_servername = '192.168.112.72,1433'
	case 	'KH','KM','KS','KV'
		gs_servername = '192.168.113.248,1433'	
	case 	'BH','BM','BS','BV','BY','BA'
		gs_servername = '192.168.113.248,1433'		
End choose



SQLPIS 					= 	CREATE transaction
SQLPIS.ServerName 	= 	gs_servername
SQLPIS.DBMS       	= 	ProfileString(gs_inifile,g_s_serverarea,"DBMS",			" ")
SQLPIS.Database   	= 	ls_database
SQLPIS.LogID      	= 	ProfileString(gs_inifile,g_s_serverarea,"LogId",			" ")
SQLPIS.LogPass    	= 	'goipis'
SQLPIS.DBParm 		   = 	"CommitOnDisconnect='No'"
SQLPIS.AutoCommit 	= 	True
gs_appname	         = ProfileString(gs_inifile,"PARAMETER","AppName",            " ")

connect using SQLPIS;

If SQLPIS.sqlcode <> 0 then
	disconnect using sqlpis ;
	destroy sqlpis
	if g_l_connect = -1 then
		messagebox("확인","데이타베이스 연결 오류 [정보시스템팀]으로 연락바랍니다.")
      return
	end if
//	SQLPIS	= 	CREATE transaction
//	SQLPIS 	=	sqlca
//	connect using SQLPIS;
//	g_l_connect = -2
end if

sqlpis.autocommit = true

setpointer(hourglass!)
uo_status.st_message.text	= '조회중....'
declare cur_1 cursor for
 select suppliercode, itemcode
 from  tqqcstandard a
 where a.areacode = :ls_xplant
 and   a.divisioncode = :ls_div
 and   a.standardrevno in (select coalesce(max(b.standardrevno),'') from tqqcstandardchange b
                           where a.areacode = b.areacode
									 and   a.divisioncode = b.divisioncode
									 and   a.suppliercode = b.suppliercode
									 and   a.itemcode = b.itemcode)
 using sqlpis;
 
open cur_1;
DO WHILE TRUE
	FETCH cur_1 INTO  :ls_vsrno, :ls_itno;
	if sqlpis.sqlcode <> 0 then
		exit
	end if
	ll_row = ll_row + 1
	uo_status.st_message.text	= string(ll_row) + '건 조회중....'
//   ////데이타수정
//	UPDATE tqqcstandard
//	   SET CHARGECONSERTFLAG = 'Y',
//	       SANCTIONCONSERTFLAG = 'Y',
//	       CONSERTDATE = APPLYDATE
//	 where areacode = :ls_xplant
//	 and   divisioncode = :ls_div
//	 and   suppliercode = :ls_vsrno
//	 and   itemcode     = :ls_itno
//	 and   standardrevno = :ls_revno_to
//	 using sqlpis;		 
//	 
//	 continue

//  delete from  tqqcstandard
//	 where areacode = :ls_xplant
//	 and   divisioncode = :ls_div
//	 and   suppliercode = :ls_vsrno
//	 and   itemcode     = :ls_itno
//	 and   standardrevno = :ls_revno_to
//	 using sqlpis;	
//	 continue
//  ////최신것은 스탠다드에만...나머지는 전부 change에 있어야 한다.
//  delete from  tqqcstandardchange
//	 where areacode = :ls_xplant
//	 and   divisioncode = :ls_div
//	 and   suppliercode = :ls_vsrno
//	 and   itemcode     = :ls_itno
//	 and   standardrevno = :ls_revno_from
//	 using sqlpis;	
//	 continue
	
//검사기준서헤드 삽입하면 안됨 항상 한개만 있어야 된다. ==> 초기,개정중 상관없음
//	select count(*) into :ll_rcnt
//	from tqqcstandard
//	 where areacode = :ls_xplant
//	 and   divisioncode = :ls_div
//	 and   suppliercode = :ls_vsrno
//	 and   itemcode     = :ls_itno
//	 and   standardrevno = :ls_revno_to
//	 using sqlpis;
//	 if ll_rcnt <> 0 then
//		 continue
//	 end if
//	 //검사기준서헤드 삽입
//	
//		 select coalesce(min(makedate),'') 
//		 into :ls_date
//		 from tqqcresult
//		 where areacode = :ls_xplant
//		 and   divisioncode = :ls_div
//		 and   suppliercode = :ls_vsrno
//		 and   itemcode = :ls_itno
//		 and   standardrevno = :ls_revno_to
//		 using sqlpis;	
//		 
//		 insert into tqqcstandard
//		 SELECT AREACODE,   
//         DIVISIONCODE,   
//         SUPPLIERCODE,   
//         ITEMCODE,   
//         :ls_revno_to,   //STANDARDREVNO,   
//         CHARGENAME,   
//         ENACTMENTDATE,   
//         ITEMRANK,   
//         QUALITY,   
//         HEATTREATMENT,   
//         SURFACETREATMENT,   
//         QCCONCEPTIONREFERENCE,   
//         BADTREATMENT,   
//         CONSERTDEPENDENCEFLAG,   
//			drawingname, 
//         CHARGECODE,   
//         'Y',  //CHARGECONSERTFLAG,   
//         SANCTIONCODE,   
//         'Y',  //SANCTIONCONSERTFLAG,   
//         (case when :ls_date <> '' then :ls_date else APPLYDATE end),  //CONSERTDATE,   
//         RETURNREASON,   
//         MODIFYCONTENT,   
//         'N',   //CHANGEFLAG,   
//		   (case when :ls_date <> '' then :ls_date else APPLYDATE end),  //APPLYDATE,   
//         LastEmp,   
//         LastDate,   
//         ItemRevno 
//		 from tqqcstandard
//		 where areacode = :ls_xplant
//		 and   divisioncode = :ls_div
//		 and   suppliercode = :ls_vsrno
//		 and   itemcode = :ls_itno
//		 and   standardrevno = :ls_revno_from
//		 using sqlpis;	
//		 uo_status.st_message.text	= '품번:' + ls_itno + ':' + ls_revno_to  + ' 기준서내역 처리완료....'
	
	 ////*******************************************************검사기준서변경헤드 내역
	 select count(*) into :ll_rcnt
	from tqqcstandardchange
	 where areacode = :ls_xplant
	 and   divisioncode = :ls_div
	 and   suppliercode = :ls_vsrno
	 and   itemcode     = :ls_itno
	 and   standardrevno = :ls_revno_to
	 using sqlpis;
	 if ll_rcnt <> 0 then
		 continue
	 end if
	 
	 select count(*) into :ll_rcnt
	 from tqqcstandardchange
	 where areacode     = :ls_xplant
	 and   divisioncode = :ls_div
	 and   suppliercode = :ls_vsrno
	 and   itemcode = :ls_itno
	 and   standardrevno = :ls_revno_to
	 using sqlpis;
	 //검사기준서변경헤드 삽입
	 if ll_rcnt = 0 then
		 insert into tqqcstandardchange
		 SELECT AREACODE,   
				DIVISIONCODE,   
				SUPPLIERCODE,   
				ITEMCODE,   
				:ls_revno_to,   //STANDARDREVNO,   
				CHARGENAME,   
				ENACTMENTDATE,   
				CONSERTDATE,   
				ITEMRANK,   
				QUALITY,   
				HEATTREATMENT,   
				SURFACETREATMENT,   
				QCCONCEPTIONREFERENCE,   
				BADTREATMENT,   
				CONSERTDEPENDENCEFLAG,  
				drawingname,  
				CHARGECODE,   
				CHARGECONSERTFLAG,   
				SANCTIONCODE,   
				SANCTIONCONSERTFLAG,   
				RETURNREASON,   
				CHANGEFLAG,   
				REJECTTREATMENT,   
				MODIFYCONTENT,   
				MODIFYDATE,   
				APPLYDATE,   
				LastEmp,   
				LastDate,   
				ItemRevno  
		 FROM TQQCSTANDARDCHANGE  
		 where areacode = :ls_xplant
		 and   divisioncode = :ls_div
		 and   suppliercode = :ls_vsrno
		 and   itemcode = :ls_itno
		 and   standardrevno = :ls_revno_from
		 using sqlpis;	
		 uo_status.st_message.text	= '품번:' + ls_itno + ':' + ls_revno_to  + ' 기준서변경내역 처리완료....'
	 end if
	  ////*******************************************************검사기준서디테일 내역
	
				 
	 insert into TQQCSTANDARDDETAIL
	 SELECT AREACODE,   
		DIVISIONCODE,   
		SUPPLIERCODE,   
		ITEMCODE,   
		:ls_revno_to,  //STANDARDREVNO,   
		ORDERNO,   
		QCITEM,   
		DECISIONRANK,   
		ITEMSPECQUALITY,   
		SAMPLE,   
		QCSTRUCTURE,   
		QCSTIPULATION,   
		LastEmp,   
		LastDate  
	 FROM TQQCSTANDARDDETAIL  
	 where areacode = :ls_xplant
	 and   divisioncode = :ls_div
	 and   suppliercode = :ls_vsrno
	 and   itemcode = :ls_itno
	 and   standardrevno = :ls_revno_from
	 and   orderno not in (select orderno 
									 from  tqqcstandarddetail
									 where areacode = :ls_xplant
									 and   divisioncode = :ls_div
									 and   suppliercode = :ls_vsrno
									 and   itemcode = :ls_itno
									 and   standardrevno = :ls_revno_to)
	 using sqlpis;	
	 uo_status.st_message.text	= '품번:' + ls_itno + ':' + ls_revno_to  + ' 기준서디테일내역 처리완료....'
	 
	 insert into TQQCSTANDARDCHANGEDETAIL
	 SELECT AREACODE,   
		DIVISIONCODE,   
		SUPPLIERCODE,   
		ITEMCODE,   
		:ls_revno_to,  //STANDARDREVNO,   
		ORDERNO,   
		QCITEM,   
		DECISIONRANK,   
		ITEMSPECQUALITY,   
		SAMPLE,   
		QCSTRUCTURE,   
		QCSTIPULATION,   
		LastEmp,   
		LastDate  
	 FROM TQQCSTANDARDCHANGEDETAIL  
	 where areacode = :ls_xplant
	 and   divisioncode = :ls_div
	 and   suppliercode = :ls_vsrno
	 and   itemcode = :ls_itno
	 and   standardrevno = :ls_revno_from
	 and   orderno not in (select orderno 
								  from  TQQCSTANDARDCHANGEDETAIL
									 where areacode = :ls_xplant
									 and   divisioncode = :ls_div
									 and   suppliercode = :ls_vsrno
									 and   itemcode = :ls_itno
									 and   standardrevno = :ls_revno_to)
	 using sqlpis;	
	 uo_status.st_message.text	= '품번:' + ls_itno + ':' + ls_revno_to  + ' 기준서디테일변경내역 처리완료....'
LOOP
CLOSE cur_1;

disconnect using sqlpis ;
destroy sqlpis
setpointer(arrow!)
return 


end event

type cb_13 from commandbutton within tabpage_7
integer x = 1527
integer y = 56
integer width = 512
integer height = 92
integer taborder = 230
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "검사기준서복구"
end type

event clicked;//long  ll_row, ll_rcnt, ll_rtn
//string ls_database
//string ls_revno_from, ls_revno_to, ls_xplant, ls_div, ls_vsrno, ls_itno , ls_date
//
//////리비젼 01에서 00 복사
//////승인요청할때 이전내역 삭제됨 또는 승인요청후 qc반송될때 문제가 발생하는 듯...
//ls_revno_from = '01' ////현재살아있는 내역..최종
//ls_revno_to  = '00'
//ls_xplant = 'D'
//ls_div = 'S'
//ls_vsrno = 'D3817'
//ls_itno = '522908'
//////DM,DS 192.168.108.249,1433
//////DA    192.168.103.249,1433
//////DV,DH 192.168.109.249,1433
//
//ls_database = 'IPIS'
//Choose case ls_xplant + ls_div
//	case 'DM','DS'
//		gs_servername = '192.168.108.249,1433'
//	case 'DA'
//		gs_servername = '192.168.103.249,1433'
//	case 'DV','DH'
//		gs_servername = '192.168.109.249,1433'
//	case 	'JH','JM','JS'
//		gs_servername = '192.168.112.72,1433'
//	case 	'KH','KM','KS','KV'
//		gs_servername = '192.168.113.248,1433'	
//	case 	'BH','BM','BS','BV','BY','BA'
//		gs_servername = '192.168.113.248,1433'		
//End choose
//
//SQLPIS 					= 	CREATE transaction
//SQLPIS.ServerName 	= 	gs_servername
//SQLPIS.DBMS       	= 	ProfileString(gs_inifile,g_s_serverarea,"DBMS",			" ")
//SQLPIS.Database   	= 	ls_database
//SQLPIS.LogID      	= 	ProfileString(gs_inifile,g_s_serverarea,"LogId",			" ")
//SQLPIS.LogPass    	= 	'goipis'
//SQLPIS.DBParm 		   = 	"CommitOnDisconnect='No'"
//SQLPIS.AutoCommit 	= 	True
//gs_appname	         = ProfileString(gs_inifile,"PARAMETER","AppName",            " ")
//
//connect using SQLPIS;
//
//If SQLPIS.sqlcode <> 0 then
//	disconnect using sqlpis ;
//	destroy sqlpis
//	if g_l_connect = -1 then
//		messagebox("확인","데이타베이스 연결 오류 [정보시스템팀]으로 연락바랍니다.")
//      return
//	end if
////	SQLPIS	= 	CREATE transaction
////	SQLPIS 	=	sqlca
////	connect using SQLPIS;
////	g_l_connect = -2
//end if
//
//sqlpis.autocommit = true
//
//setpointer(hourglass!)
//uo_status.st_message.text	= '조회중....'
//declare cur_1 cursor for
// select itemcode
// from  tqqcstandard
// where areacode = :ls_xplant
// and   divisioncode = :ls_div
// and   suppliercode = :ls_vsrno
// and   standardrevno = :ls_revno_from
// and   itemcode like :ls_itno + '%'
// using sqlpis;
// 
// select count(*) into :ll_rcnt
// from  tqqcstandard
// where areacode = :ls_xplant
// and   divisioncode = :ls_div
// and   suppliercode = :ls_vsrno
// and   standardrevno = :ls_revno_from
// and   itemcode like :ls_itno + '%'
// using sqlpis;
// if ll_rcnt = 0 then
//	 messagebox('확인',ls_vsrno + ':' + ls_itno + ':자료없음')
//	 return
// end if
// 
//open cur_1;
//DO WHILE TRUE
//	FETCH cur_1 INTO  :ls_itno;
//	if sqlpis.sqlcode <> 0 then
//		exit
//	end if
//	ll_row = ll_row + 1
//	uo_status.st_message.text	= string(ll_row) + '건 조회중....'
////   ////데이타수정
////	UPDATE tqqcstandard
////	   SET CHARGECONSERTFLAG = 'Y',
////	       SANCTIONCONSERTFLAG = 'Y',
////	       CONSERTDATE = APPLYDATE
////	 where areacode = :ls_xplant
////	 and   divisioncode = :ls_div
////	 and   suppliercode = :ls_vsrno
////	 and   itemcode     = :ls_itno
////	 and   standardrevno = :ls_revno_to
////	 using sqlpis;		 
////	 
////	 continue
//
////  delete from  tqqcstandard
////	 where areacode = :ls_xplant
////	 and   divisioncode = :ls_div
////	 and   suppliercode = :ls_vsrno
////	 and   itemcode     = :ls_itno
////	 and   standardrevno = :ls_revno_to
////	 using sqlpis;	
////	 continue
////  ////최신것은 스탠다드에만...나머지는 전부 change에 있어야 한다.
////***************************************승인요청중 성적서등록할때 가장 많이 발생change에 현재 사용중인
////                                        기준서없음.  이전개정번호 또는 승인요청중인 것만 있다
////  delete from  tqqcstandardchange
////	 where areacode = :ls_xplant
////	 and   divisioncode = :ls_div
////	 and   suppliercode = :ls_vsrno
////	 and   itemcode     = :ls_itno
////	 and   standardrevno = :ls_revno_from
////	 using sqlpis;	
////	 continue
//	
////검사기준서헤드 삽입하면 안됨 항상 한개만 있어야 된다. ==> 초기,개정중 상관없음
////	select count(*) into :ll_rcnt
////	from tqqcstandard
////	 where areacode = :ls_xplant
////	 and   divisioncode = :ls_div
////	 and   suppliercode = :ls_vsrno
////	 and   itemcode     = :ls_itno
////	 and   standardrevno = :ls_revno_to
////	 using sqlpis;
////	 if ll_rcnt <> 0 then
////		 continue
////	 end if
////	 //검사기준서헤드 삽입
////	
////		 select coalesce(min(makedate),'') 
////		 into :ls_date
////		 from tqqcresult
////		 where areacode = :ls_xplant
////		 and   divisioncode = :ls_div
////		 and   suppliercode = :ls_vsrno
////		 and   itemcode = :ls_itno
////		 and   standardrevno = :ls_revno_to
////		 using sqlpis;	
////		 
////		 insert into tqqcstandard
////		 SELECT AREACODE,   
////         DIVISIONCODE,   
////         SUPPLIERCODE,   
////         ITEMCODE,   
////         :ls_revno_to,   //STANDARDREVNO,   
////         CHARGENAME,   
////         ENACTMENTDATE,   
////         ITEMRANK,   
////         QUALITY,   
////         HEATTREATMENT,   
////         SURFACETREATMENT,   
////         QCCONCEPTIONREFERENCE,   
////         BADTREATMENT,   
////         CONSERTDEPENDENCEFLAG,   
////			drawingname, 
////         CHARGECODE,   
////         'Y',  //CHARGECONSERTFLAG,   
////         SANCTIONCODE,   
////         'Y',  //SANCTIONCONSERTFLAG,   
////         (case when :ls_date <> '' then :ls_date else APPLYDATE end),  //CONSERTDATE,   
////         RETURNREASON,   
////         MODIFYCONTENT,   
////         'N',   //CHANGEFLAG,   
////		   (case when :ls_date <> '' then :ls_date else APPLYDATE end),  //APPLYDATE,   
////         LastEmp,   
////         LastDate,   
////         ItemRevno 
////		 from tqqcstandard
////		 where areacode = :ls_xplant
////		 and   divisioncode = :ls_div
////		 and   suppliercode = :ls_vsrno
////		 and   itemcode = :ls_itno
////		 and   standardrevno = :ls_revno_from
////		 using sqlpis;	
////		 uo_status.st_message.text	= '품번:' + ls_itno + ':' + ls_revno_to  + ' 기준서내역 처리완료....'
//	
//	 ////*******************************************************검사기준서변경헤드 내역
//	 select count(*) into :ll_rcnt
//	from tqqcstandardchange
//	 where areacode = :ls_xplant
//	 and   divisioncode = :ls_div
//	 and   suppliercode = :ls_vsrno
//	 and   itemcode     = :ls_itno
//	 and   standardrevno = :ls_revno_to
//	 using sqlpis;
//	 if ll_rcnt <> 0 then
//		 continue
//	 end if
//	 
//	 select count(*) into :ll_rcnt
//	 from tqqcstandardchange
//	 where areacode     = :ls_xplant
//	 and   divisioncode = :ls_div
//	 and   suppliercode = :ls_vsrno
//	 and   itemcode = :ls_itno
//	 and   standardrevno = :ls_revno_to
//	 using sqlpis;
//	 //검사기준서변경이력헤드 삽입
//	 if ll_rcnt = 0 then
//		 insert into tqqcstandardchange
//		 SELECT AREACODE,   
//				DIVISIONCODE,   
//				SUPPLIERCODE,   
//				ITEMCODE,   
//				:ls_revno_to,   //STANDARDREVNO,   
//				CHARGENAME,   
//				ENACTMENTDATE,   
//				CONSERTDATE,   
//				ITEMRANK,   
//				QUALITY,   
//				HEATTREATMENT,   
//				SURFACETREATMENT,   
//				QCCONCEPTIONREFERENCE,   
//				BADTREATMENT,   
//				CONSERTDEPENDENCEFLAG,  
//				drawingname,  
//				CHARGECODE,   
//				CHARGECONSERTFLAG,   
//				SANCTIONCODE,   
//				SANCTIONCONSERTFLAG,   
//				RETURNREASON,   
//				CHANGEFLAG,   
//				REJECTTREATMENT,   
//				MODIFYCONTENT,   
//				MODIFYDATE,   
//				APPLYDATE,   
//				LastEmp,   
//				LastDate,   
//				ItemRevno  
//		 FROM TQQCSTANDARDCHANGE  
//		 where areacode = :ls_xplant
//		 and   divisioncode = :ls_div
//		 and   suppliercode = :ls_vsrno
//		 and   itemcode = :ls_itno
//		 and   standardrevno = :ls_revno_from
//		 using sqlpis;	
//		 uo_status.st_message.text	= '품번:' + ls_itno + ':' + ls_revno_to  + ' 기준서변경내역 처리완료....'
//	 end if
//	  ////*******************************************************검사기준서디테일 내역
//	
//				 
//	 insert into TQQCSTANDARDDETAIL
//	 SELECT AREACODE,   
//		DIVISIONCODE,   
//		SUPPLIERCODE,   
//		ITEMCODE,   
//		:ls_revno_to,  //STANDARDREVNO,   
//		ORDERNO,   
//		QCITEM,   
//		DECISIONRANK,   
//		ITEMSPECQUALITY,   
//		SAMPLE,   
//		QCSTRUCTURE,   
//		QCSTIPULATION,   
//		LastEmp,   
//		LastDate  
//	 FROM TQQCSTANDARDDETAIL  
//	 where areacode = :ls_xplant
//	 and   divisioncode = :ls_div
//	 and   suppliercode = :ls_vsrno
//	 and   itemcode = :ls_itno
//	 and   standardrevno = :ls_revno_from
//	 and   orderno not in (select orderno 
//									 from  tqqcstandarddetail
//									 where areacode = :ls_xplant
//									 and   divisioncode = :ls_div
//									 and   suppliercode = :ls_vsrno
//									 and   itemcode = :ls_itno
//									 and   standardrevno = :ls_revno_to)
//	 using sqlpis;	
//	 uo_status.st_message.text	= '품번:' + ls_itno + ':' + ls_revno_to  + ' 기준서디테일내역 처리완료....'
//	 ////개정번호별로 없는 것은 전부 채워줘야 됨.
//	 insert into TQQCSTANDARDCHANGEDETAIL
//	 SELECT AREACODE,   
//		DIVISIONCODE,   
//		SUPPLIERCODE,   
//		ITEMCODE,   
//		:ls_revno_to,  //STANDARDREVNO,   
//		ORDERNO,   
//		QCITEM,   
//		DECISIONRANK,   
//		ITEMSPECQUALITY,   
//		SAMPLE,   
//		QCSTRUCTURE,   
//		QCSTIPULATION,   
//		LastEmp,   
//		LastDate  
//	 FROM TQQCSTANDARDCHANGEDETAIL  
//	 where areacode = :ls_xplant
//	 and   divisioncode = :ls_div
//	 and   suppliercode = :ls_vsrno
//	 and   itemcode = :ls_itno
//	 and   standardrevno = :ls_revno_from
//	 and   orderno not in (select orderno 
//								  from  TQQCSTANDARDCHANGEDETAIL
//									 where areacode = :ls_xplant
//									 and   divisioncode = :ls_div
//									 and   suppliercode = :ls_vsrno
//									 and   itemcode = :ls_itno
//									 and   standardrevno = :ls_revno_to)
//	 using sqlpis;	
//	 uo_status.st_message.text	= '품번:' + ls_itno + ':' + ls_revno_to  + ' 기준서디테일변경내역 처리완료....'
//LOOP
//CLOSE cur_1;
//
//disconnect using sqlpis ;
//destroy sqlpis
//setpointer(arrow!)
//return 
//
//
end event

type dw_71 from datawindow within tabpage_7
integer x = 18
integer y = 184
integer width = 4530
integer height = 2112
integer taborder = 80
string title = "none"
string dataobject = "d_opm999u_71"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;idw_71 = this

end event

type tabpage_8 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4581
integer height = 2344
long backcolor = 12632256
string text = "재료비단가업로드"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_18 cb_18
dw_81 dw_81
cb_19 cb_19
end type

on tabpage_8.create
this.cb_18=create cb_18
this.dw_81=create dw_81
this.cb_19=create cb_19
this.Control[]={this.cb_18,&
this.dw_81,&
this.cb_19}
end on

on tabpage_8.destroy
destroy(this.cb_18)
destroy(this.dw_81)
destroy(this.cb_19)
end on

type cb_18 from commandbutton within tabpage_8
integer x = 681
integer y = 24
integer width = 512
integer height = 92
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "예상단가업로드"
end type

event clicked;string ls_yymm
long ll_row, ll_rcnt, ll_srno,ll_ok

setpointer(hourglass!)



//자료체크
string ls_xplant, ls_div, ls_itno, ls_tdte4, ls_vsrno, ls_vsrno1
dec {2} ld_bcost, ld_ncost

 idw_81.reset()
uo_status.st_message.text	= '업로드중입니다...'
f_pur040_getexcel(idw_81)  //숫자가 널이면 0으로 변경
		
if idw_81.rowcount() = 0 then
	return
end if
uo_status.st_message.text	= '업로드자료 확인중입니다...'
//f_pur040_nullchk03(idw_81)

IF idw_81.accepttext() = -1 THEN
	messagebox('확인','저장할 자료에 데이타 오류발생, 에러난곳 수정후 저장하세요!',Exclamation!)
	Return
END IF
for ll_row = 1 to idw_81.rowcount()
	uo_status.st_message.text	= '행:' + string(ll_row) + ' 처리중입니다...'

// ls_xplant  = trim(idw_81.object.xplant[ll_row])
//	ls_div = trim(idw_81.object.div[ll_row])
	ls_itno  = trim(idw_81.object.itno[ll_row])
	ls_vsrno  = trim(idw_81.object.vsrno[ll_row])
	ld_ncost = idw_81.object.ncost[ll_row]  //예상단가
	ld_bcost = idw_81.object.bcost[ll_row]
	
	
	update pbpur.pur901
	  set ncost = :ld_ncost,
	      bcost = (case when bcost = 0 then :ld_bcost else bcost end),
	     	vsrno1 = :ls_vsrno
	where xyear = '200906'
	and   itno = :ls_itno;

	uo_status.st_message.text	= '행:' + string(ll_row) + '/' + string(idw_81.rowcount()) + '번 확인완료..'	
next


//return
//ll_ok = MessageBox("확인", ' 자료확정합니다. 확인키를 누르세요!', &
//		Exclamation!, OKCancel!, 2)
//IF ll_ok <> 1 THEN
//	 uo_status.st_message.text = '작업취소'
//	 return
//END IF


//uo_status.st_message.text	= '작업완료'
setpointer(arrow!)



end event

type dw_81 from datawindow within tabpage_8
integer y = 136
integer width = 4265
integer height = 2176
integer taborder = 240
string title = "none"
string dataobject = "d_opm999u_81"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;idw_81 = this

end event

type cb_19 from commandbutton within tabpage_8
integer x = 50
integer y = 24
integer width = 576
integer height = 92
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "최종단가업데이트"
end type

event clicked;////최종단가 업데이트 van9c01b '200906' 실행후 작업
string ls_yymm
long ll_row, ll_rcnt, ll_srno,ll_ok

setpointer(hourglass!)


string ls_xplant, ls_div, ls_itno, ls_tdte4, ls_vsrno, ls_vndr, ls_vsrno1,ls_srce, ls_sliptype
dec {2} ld_bcost, ld_ncost

 select count(distinct xplant || div || itno) into :ll_rcnt
 from  pbpur.pur901
 where srce = '01';
 

declare cur_1 cursor for
  select distinct xplant, div, itno, srce
  from  pbpur.pur901
  where srce = '01'
  order by 1,2,3;
  
 OPEN cur_1;
 DO WHILE TRUE
	FETCH cur_1 INTO  :ls_xplant, :ls_div, :ls_itno, :ls_srce;
	if sqlca.sqlcode <> 0 then
		exit
	end if
	ll_row = ll_row + 1
	uo_status.st_message.text	= string(ll_row) + '/' + string(ll_rcnt) + '  처리중...'
	if ls_srce = '01' then
		ls_sliptype = 'RF'
	else
		ls_sliptype = 'RP'
	end if
   select coalesce(max(tdte4),'') into :ls_tdte4
	from  pbinv.inv401
	where comltd = '01'
	and   sliptype = :ls_sliptype
	and   xplant = :ls_xplant
	and   div = :ls_div
	and   itno = :ls_itno;
	if ls_tdte4 >= '20090601' then
		select coalesce(max(tdte4),'') into :ls_tdte4
		from  pbinv.inv401
		where comltd = '01'
		and   sliptype = :ls_sliptype
		and   rtngub = ''
		and   xuse = 'D'
		and   tdte4 <= '20090531'
		and   xplant = :ls_xplant
		and   div = :ls_div
		and   itno = :ls_itno
		;
	end if
	ls_vsrno = '' 
	ld_bcost = 0
	if ls_tdte4 <> '' then  //최종입고있다
		select coalesce(max(case when srce = '01' then vndr else vsrno end),''), coalesce(max(xcost),0)
		  into :ls_vsrno, :ld_bcost
		from  pbinv.inv401
		where comltd = '01'
		and   sliptype = :ls_sliptype
		and   xplant = :ls_xplant
		and   div = :ls_div
		and   itno = :ls_itno
		and   tdte4 = :ls_tdte4;
	else
		select vsrno, dcost
		//(case when dcost = 0 then ecost else dcost end)  
		  into :ls_vsrno, :ld_bcost
		from  pbpur.pur103
		where comltd = '01'
		and   itno = :ls_itno
		order by dadjdt desc
		fetch first 1 rows only
		;
	end if
	
	update pbpur.pur901
	   set vsrno = :ls_vsrno,
		    bcost = :ld_bcost,
			 tdte4 = :ls_tdte4
	where  xyear = '200906'
	and   xplant = :ls_xplant
	and   div = :ls_div
	and   itno = :ls_itno;
LOOP
CLOSE cur_1;
uo_status.st_message.text	= string(ll_row) + '/' + string(ll_rcnt) + '  작업완료.'
setpointer(arrow!)



end event

