$PBExportHeader$w_per_textup.srw
$PBExportComments$텍스트업로드
forward
global type w_per_textup from window
end type
type dw_text from datawindow within w_per_textup
end type
type dw_title from datawindow within w_per_textup
end type
type p_1 from picture within w_per_textup
end type
type st_2 from statictext within w_per_textup
end type
type mle_1 from multilineedit within w_per_textup
end type
type cb_4 from commandbutton within w_per_textup
end type
type sle_2 from singlelineedit within w_per_textup
end type
type cb_3 from commandbutton within w_per_textup
end type
type cb_create from commandbutton within w_per_textup
end type
type st_7 from statictext within w_per_textup
end type
type uo_1 from uo_progress_bar within w_per_textup
end type
type st_6 from statictext within w_per_textup
end type
type st_5 from statictext within w_per_textup
end type
type st_4 from statictext within w_per_textup
end type
type gb_1 from groupbox within w_per_textup
end type
type gb_2 from groupbox within w_per_textup
end type
type gb_4 from groupbox within w_per_textup
end type
type dw_1 from datawindow within w_per_textup
end type
end forward

global type w_per_textup from window
integer width = 4347
integer height = 2232
boolean titlebar = true
string title = "텍스트자료 업로드"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
dw_text dw_text
dw_title dw_title
p_1 p_1
st_2 st_2
mle_1 mle_1
cb_4 cb_4
sle_2 sle_2
cb_3 cb_3
cb_create cb_create
st_7 st_7
uo_1 uo_1
st_6 st_6
st_5 st_5
st_4 st_4
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
dw_1 dw_1
end type
global w_per_textup w_per_textup

type prototypes
Function Long SetCurrentDirectoryA (ref String lpPathName) LIBRARY "KERNEL32.DLL"
end prototypes

type variables
//String is_xplant, is_div, is_cls[], is_itno
//


DataStore	ids_text

String is_gubun, is_yy, is_mm


end variables

forward prototypes
public function long wf_errchk (datawindow adw_1)
public function integer wf_month_carcheck (string ag_ym, string ag_ficode)
public function integer wf_month_unbancheck (string ag_ym, string ag_ficode)
public function integer wf_existchk (string ag_empno, string ag_yy, string ag_no, string ag_xdate)
end prototypes

public function long wf_errchk (datawindow adw_1);//여기에서 모든 에러를 경우에 따라서 걸러내는 작업을 하는 곳이다.
string ls_xdate, ls_empno, ls_tdate
Long ll_cnt, ll_errcnt, ll_cnt2, ll_complete, ll_insertrow
string ls_penamek, ls_peclass, ls_pebonbu, ls_pedept, ls_PEJIKCHEK, ls_pepaypart, ls_gubun1
Int li_row, i
string ls_ori_zipcode, ls_zipcode, ls_sido, ls_gubun, ls_dong, ls_bunji, ls_seq, ls_temp
int li_cnt = 0, ll_row
string ls_code, ls_name, ls_fname
		
SetPointer(HourGlass!)

IF adw_1.RowCount() = 0 Then
	Messagebox('확인','UPLOAD할 자료가 없습니다!',Exclamation!)
	Return -1 
End IF

//Error Checking 
//Target_DataWindow로 엑셀 Sheet의 데이타를 Upload시 타입 체킹이 전부이다.

//If f_Mandatory_Chk( adw_1 ) = -1 Then // 필수입력항목 Check...
//	Return 1 
//End If

ll_errcnt = 0

dw_1.reset()

choose case is_gubun
	case 'acnt01'
		For ll_cnt = 1 To adw_1.RowCount()
			
			ll_complete = ll_cnt * 100 / adw_1.RowCount()	
			uo_1.uf_set_position (ll_complete)
			st_7.text = string(ll_cnt,"###,### ")
			
			ll_insertrow = dw_1.insertrow(0)
			
			ls_xdate = adw_1.object.pay254_xdate[ll_cnt]
			ls_empno = adw_1.object.pay254_empno[ll_cnt]
			
			dw_1.object.pay254_xdate[ll_insertrow]   = ls_xdate
			ls_empno = string(dec(ls_empno), '000000')
			dw_1.object.pay254_empno[ll_insertrow]   = ls_empno
			
			select penamek, peclass, pebonbu, pedept, PEJIKCHEK, pepaypart
			 into :ls_penamek, :ls_peclass, :ls_pebonbu, :ls_pedept, :ls_PEJIKCHEK, :ls_pepaypart
			from pbper.per001
			where peempno = :ls_empno and peout <> '*' using sqlcc;
			
			if sqlcc.sqlnrows <> 1 then
				dw_1.object.errcol[ll_insertrow] = 'AL'
				dw_1.object.errtext[ll_insertrow] = "해당 사번 확인"
				ll_errcnt ++
			End if			
			
			dw_1.object.per001_penamek[ll_insertrow]   = ls_penamek
			dw_1.object.per001_peclass[ll_insertrow]   = ls_peclass
			dw_1.object.per001_pebonbu[ll_insertrow]   = ls_pebonbu 
			dw_1.object.per001_pedept[ll_insertrow]    = ls_pedept
			dw_1.object.per001_PEJIKCHEK[ll_insertrow] = ls_PEJIKCHEK
			dw_1.object.pay254_paypart[ll_insertrow]   = ls_pepaypart
			dw_1.object.pay254_status[ll_insertrow]    = 'R'
			dw_1.object.pay254_cdr[ll_insertrow]       = 'L2'
			
			//이중체크
			if ll_cnt <> adw_1.RowCount() then
				li_row = adw_1.Find("pay254_empno = '" + ls_empno + "' and pay254_xdate = '" + ls_xdate + "'", &
											ll_cnt + 1, adw_1.RowCount())
	
				if li_row > 0 then
					dw_1.object.errcol[ll_insertrow] = 'AL'
					dw_1.object.errtext[ll_insertrow] = "텍스트파일 중복데이타 존재"
					ll_errcnt ++
				end if
			end if
			
			//기입력된 정보체크
			select count(empno) into :li_row
			from pbpay.pay254
			where empno = :ls_empno and xdate = :ls_xdate using sqlcc;
			
			if li_row > 0 then
				dw_1.object.errcol[ll_insertrow] = 'AL'
				dw_1.object.errtext[ll_insertrow] = "기 계획근태 정보 존재"
				ll_errcnt ++
			End if					
		Next
	
	case 'acnt02'	
		For ll_cnt = 1 To adw_1.RowCount()
			
			ll_complete = ll_cnt * 100 / adw_1.RowCount()	
			uo_1.uf_set_position (ll_complete)
			st_7.text = string(ll_cnt,"###,### ")
			
			ll_insertrow = dw_1.insertrow(0)
			
			ls_xdate = adw_1.object.pay255_xdate[ll_cnt]
			ls_empno = adw_1.object.pay255_empno[ll_cnt]
			
			dw_1.object.pay255_xdate[ll_insertrow]   = ls_xdate
			ls_empno = string(dec(ls_empno), '000000')
			dw_1.object.pay255_empno[ll_insertrow]   = ls_empno
			
			select penamek, peclass, pebonbu, pedept, PEJIKCHEK, pepaypart
			 into :ls_penamek, :ls_peclass, :ls_pebonbu, :ls_pedept, :ls_PEJIKCHEK, :ls_pepaypart
			from pbper.per001
			where peempno = :ls_empno and peout <> '*' using sqlcc;
			
			if sqlcc.sqlnrows <> 1 then
				dw_1.object.errcol[ll_insertrow] = 'AL'
				dw_1.object.errtext[ll_insertrow] = "해당 사번 확인"
				ll_errcnt ++
				
			End if			
			
			dw_1.object.per001_penamek[ll_insertrow]   = ls_penamek
			dw_1.object.per001_peclass[ll_insertrow]   = ls_peclass
			dw_1.object.per001_pebonbu[ll_insertrow]   = ls_pebonbu 
			dw_1.object.per001_pedept[ll_insertrow]    = ls_pedept
			dw_1.object.per001_PEJIKCHEK[ll_insertrow] = ls_PEJIKCHEK
			dw_1.object.pay255_paypart[ll_insertrow]   = ls_pepaypart
			dw_1.object.pay255_status[ll_insertrow]    = 'I'
			
			//이중체크
			if ll_cnt <> adw_1.RowCount() then
				li_row = adw_1.Find("pay255_empno = '" + ls_empno + "' and pay255_xdate = '" + ls_xdate + "'", &
											ll_cnt + 1, adw_1.RowCount())
	
				if li_row > 0 then
					dw_1.object.errcol[ll_insertrow] = 'AL'
					dw_1.object.errtext[ll_insertrow] = "텍스트파일 중복데이타 존재"
					ll_errcnt ++
					
				end if
			end if
			
			//기입력된 정보체크
			select count(empno) into :li_row
			from pbpay.pay255
			where empno = :ls_empno and xdate = :ls_xdate using sqlcc;
			
			if li_row > 0 then
				dw_1.object.errcol[ll_insertrow] = 'AL'
				dw_1.object.errtext[ll_insertrow] = "기 훈련일 정보 존재"
				ll_errcnt ++
				
			End if			
			
		Next
	case 'acnt03'	
		For ll_cnt = 1 To adw_1.RowCount()
			
			ll_complete = ll_cnt * 100 / adw_1.RowCount()	
			uo_1.uf_set_position (ll_complete)
			st_7.text = string(ll_cnt,"###,### ")
			
			ll_insertrow = dw_1.insertrow(0)
			
			ls_empno = adw_1.object.empno[ll_cnt]
			ls_empno = string(dec(ls_empno), '000000')
			
			
			select penamek, peclass, pebonbu, pedept, PEJIKCHEK, pegubun1
			 into :ls_penamek, :ls_peclass, :ls_pebonbu, :ls_pedept, :ls_PEJIKCHEK, :ls_gubun1
			from pbper.per001
			where peempno = :ls_empno and peout <> '*' using sqlcc;
			
			if sqlcc.sqlnrows <> 1 then
				dw_1.object.errcol[ll_insertrow] = 'AL'
				dw_1.object.errtext[ll_insertrow] = "해당 사번 확인"
				ll_errcnt ++
				
			End if	
	
			dw_1.object.per001_pedept[ll_insertrow]    = ls_pedept
			dw_1.object.per001_penamek[ll_insertrow]   = ls_penamek
			dw_1.object.per001_peclass[ll_insertrow]   = ls_peclass
			
			dw_1.object.pay256_xyear[ll_insertrow]   = is_yy
			dw_1.object.pay256_empno[ll_insertrow]   = ls_empno
			dw_1.object.pay256_ymgubun[ll_insertrow] = 'Y'
			dw_1.object.pay256_gubun[ll_insertrow]   = ls_gubun1
			
			dw_1.object.pay256_pln01[ll_insertrow]   = adw_1.object.pln01[ll_cnt]
			dw_1.object.pay256_pln02[ll_insertrow]   = adw_1.object.pln02[ll_cnt]
			dw_1.object.pay256_pln03[ll_insertrow]   = adw_1.object.pln03[ll_cnt]
			dw_1.object.pay256_pln04[ll_insertrow]   = adw_1.object.pln04[ll_cnt]
			dw_1.object.pay256_pln05[ll_insertrow]   = adw_1.object.pln05[ll_cnt]
			dw_1.object.pay256_pln06[ll_insertrow]   = adw_1.object.pln06[ll_cnt]
			dw_1.object.pay256_pln07[ll_insertrow]   = adw_1.object.pln07[ll_cnt]
			dw_1.object.pay256_pln08[ll_insertrow]   = adw_1.object.pln08[ll_cnt]
			dw_1.object.pay256_pln09[ll_insertrow]   = adw_1.object.pln09[ll_cnt]
			dw_1.object.pay256_pln10[ll_insertrow]   = adw_1.object.pln10[ll_cnt]
			dw_1.object.pay256_pln11[ll_insertrow]   = adw_1.object.pln11[ll_cnt]
			dw_1.object.pay256_pln12[ll_insertrow]   = adw_1.object.pln12[ll_cnt]
			dw_1.object.pay256_plnt[ll_insertrow]   = adw_1.object.pln01[ll_cnt] + adw_1.object.pln02[ll_cnt] + &
				adw_1.object.pln03[ll_cnt] + adw_1.object.pln04[ll_cnt] +adw_1.object.pln05[ll_cnt] + adw_1.object.pln06[ll_cnt] +&
				adw_1.object.pln07[ll_cnt] + adw_1.object.pln08[ll_cnt] +adw_1.object.pln09[ll_cnt] + adw_1.object.pln10[ll_cnt] +&
				adw_1.object.pln11[ll_cnt] + adw_1.object.pln12[ll_cnt] 
			
			//이중체크
			if ll_cnt <> adw_1.RowCount() then
				li_row = adw_1.Find("empno = '" + ls_empno + "'", &
											ll_cnt + 1, adw_1.RowCount())
	
				if li_row > 0 then
					dw_1.object.errcol[ll_insertrow] = 'AL'
					dw_1.object.errtext[ll_insertrow] = "텍스트파일 중복데이타 존재"
					ll_errcnt ++
					
				end if
			end if
			
			//기입력된 정보체크
			select count(empno) into :li_row
			from pbpay.pay256
			where empno = :ls_empno and xyear = :is_yy and ymgubun = 'Y' using sqlcc;
			
			if li_row > 0 then
				delete from pbpay.pay256
				where empno = :ls_empno and xyear = :is_yy and ymgubun = 'Y' using sqlcc;
//				dw_1.object.errcol[ll_insertrow] = 'AL'
//				dw_1.object.errtext[ll_insertrow] = "기 훈련일 정보 존재"
//				ll_errcnt ++
//				
			End if			
			
		Next	
	case 'acnt04'
		For ll_cnt = 1 To adw_1.RowCount()
			
			ll_complete = ll_cnt * 100 / adw_1.RowCount()	
			uo_1.uf_set_position (ll_complete)
			st_7.text = string(ll_cnt,"###,### ")
			
			ll_insertrow = dw_1.insertrow(0)
			
			ls_xdate = adw_1.object.pay254_xdate[ll_cnt]
			
			if f_daynumber(ls_xdate) <> '1' then
				dw_1.object.errcol[ll_insertrow] = '1'
				dw_1.object.errtext[ll_insertrow] = "시작요일확인"
				ll_errcnt ++
			End if
			
			ls_empno = adw_1.object.pay254_empno[ll_cnt]
			
			dw_1.object.pay254_xdate[ll_insertrow]   = ls_xdate
			ls_empno = string(dec(ls_empno), '000000')
			dw_1.object.pay254_empno[ll_insertrow]   = ls_empno
			
			select penamek, peclass, pebonbu, pedept, PEJIKCHEK, pepaypart
			 into :ls_penamek, :ls_peclass, :ls_pebonbu, :ls_pedept, :ls_PEJIKCHEK, :ls_pepaypart
			from pbper.per001
			where peempno = :ls_empno and peout <> '*' using sqlcc;
			
			if sqlcc.sqlnrows <> 1 then
				dw_1.object.errcol[ll_insertrow] = 'AL'
				dw_1.object.errtext[ll_insertrow] = "해당 사번 확인"
				ll_errcnt ++
			End if			
			
			dw_1.object.per001_penamek[ll_insertrow]   = ls_penamek
			dw_1.object.per001_peclass[ll_insertrow]   = ls_peclass
			dw_1.object.per001_pebonbu[ll_insertrow]   = ls_pebonbu 
			dw_1.object.per001_pedept[ll_insertrow]    = ls_pedept
			dw_1.object.per001_PEJIKCHEK[ll_insertrow] = ls_PEJIKCHEK
			dw_1.object.pay254_paypart[ll_insertrow]   = ls_pepaypart
			dw_1.object.pay254_status[ll_insertrow]    = 'R'
			dw_1.object.pay254_cdr[ll_insertrow]       = 'M4'
			
			//이중체크
			if ll_cnt <> adw_1.RowCount() then
				li_row = adw_1.Find("pay254_empno = '" + ls_empno + "' and pay254_xdate = '" + ls_xdate + "'", &
											ll_cnt + 1, adw_1.RowCount())
	
				if li_row > 0 then
					dw_1.object.errcol[ll_insertrow] = 'AL'
					dw_1.object.errtext[ll_insertrow] = "텍스트파일 중복데이타 존재"
					ll_errcnt ++
				end if
			end if
			
			//기입력된 정보체크
			select count(empno) into :li_row
			from pbpay.pay254
			where empno = :ls_empno and xdate = :ls_xdate using sqlcc;
			
			if li_row > 0 then
				dw_1.object.errcol[ll_insertrow] = 'AL'
				dw_1.object.errtext[ll_insertrow] = "기 계획근태 정보 존재"
				ll_errcnt ++
			End if	
			
			for i = 1 to 6
				ls_tdate = f_relativedate(ls_xdate, i)
				ll_insertrow = dw_1.insertrow(0)
				dw_1.object.pay254_xdate[ll_insertrow]     = ls_tdate
				dw_1.object.pay254_empno[ll_insertrow]     = ls_empno
				dw_1.object.per001_penamek[ll_insertrow]   = ls_penamek
				dw_1.object.per001_peclass[ll_insertrow]   = ls_peclass
				dw_1.object.per001_pebonbu[ll_insertrow]   = ls_pebonbu 
				dw_1.object.per001_pedept[ll_insertrow]    = ls_pedept
				dw_1.object.per001_PEJIKCHEK[ll_insertrow] = ls_PEJIKCHEK
				dw_1.object.pay254_paypart[ll_insertrow]   = ls_pepaypart
				dw_1.object.pay254_status[ll_insertrow]    = 'R'
				dw_1.object.pay254_cdr[ll_insertrow]       = 'M4'
			next			
			
		Next

	case 'per90'	
		
		For ll_cnt = 1 To adw_1.RowCount()
			
			ll_complete = ll_cnt * 100 / adw_1.RowCount()	
			uo_1.uf_set_position (ll_complete)
			st_7.text = string(ll_cnt,"###,### ")
			
			ll_insertrow = dw_1.insertrow(0)
			
			ls_ori_zipcode = trim(adw_1.object.zipcode[ll_cnt])
			ls_ori_zipcode = mid(ls_ori_zipcode,1,3) + mid(ls_ori_zipcode,5,3)
			
			ls_sido    = trim(adw_1.object.sido[ll_cnt])
			ls_gubun   = trim(adw_1.object.gubun[ll_cnt])
			ls_dong    = trim(adw_1.object.dong[ll_cnt])
			ls_bunji   = trim(adw_1.object.bunji[ll_cnt])
			ls_seq     = trim(adw_1.object.seq[ll_cnt])			
			
			if ls_ori_zipcode = ls_temp then
				li_cnt++
				ls_zipcode = ls_ori_zipcode +'-' + string(li_cnt)
			else
				li_cnt = 0
				ls_zipcode = ls_ori_zipcode 				
			End if	
			
			if len(ls_dong) > 37 then
				ll_row = len(ls_dong)
				Do while true 
					if ll_row <= 37 then
						exit
					end if
					if asc(mid(ls_dong,ll_row,1)) >= 161 then  //두바이트문자다 2byte shift 이동
						ll_row = ll_row - 2
					else
						ll_row = ll_row - 1
					end if
				Loop
				ls_dong = mid(ls_dong,1,ll_row)
			end if
			
			dw_1.object.comltd[ll_insertrow]    = '01'
			dw_1.object.cogubun[ll_insertrow]   = 'PER335'
			dw_1.object.cocode[ll_insertrow]    = ls_zipcode 
			dw_1.object.coitname[ll_insertrow]  = ls_sido
			dw_1.object.coitnamee[ll_insertrow] = ls_gubun
			dw_1.object.coflname[ll_insertrow]  = ls_dong
			dw_1.object.coflnamee[ll_insertrow] = ls_bunji
			dw_1.object.coextend[ll_insertrow]  = ls_seq
			dw_1.object.coadpdt[ll_insertrow]   = g_s_date
			
			ls_temp = ls_ori_zipcode
		Next	
	case 'per91'	
		
		For ll_cnt = 1 To adw_1.RowCount()
			
			ll_complete = ll_cnt * 100 / adw_1.RowCount()	
			uo_1.uf_set_position (ll_complete)
			st_7.text = string(ll_cnt,"###,### ")
			
			ll_insertrow = dw_1.insertrow(0)
			
			ls_code  = trim(adw_1.object.code[ll_cnt])
			ls_name  = trim(adw_1.object.name[ll_cnt])
			ls_fname = trim(adw_1.object.name[ll_cnt])
			
			if len(ls_name) > 24 then
				ll_row = len(ls_name)
				Do while true 
					if ll_row <= 24 then
						exit
					end if
					if asc(mid(ls_name,ll_row,1)) >= 161 then  //두바이트문자다 2byte shift 이동
						ll_row = ll_row - 2
					else
						ll_row = ll_row - 1
					end if
				Loop
				ls_name = mid(ls_name,1,ll_row)
			end if
			if len(ls_fname) > 41 then
				ll_row = len(ls_fname)
				Do while true 
					if ll_row <= 41 then
						exit
					end if
					if asc(mid(ls_fname,ll_row,1)) >= 161 then  //두바이트문자다 2byte shift 이동
						ll_row = ll_row - 2
					else
						ll_row = ll_row - 1
					end if
				Loop
				ls_fname = mid(ls_fname,1,ll_row)
			end if
			
			dw_1.object.comltd[ll_insertrow]    = '01'
			dw_1.object.cogubun[ll_insertrow]   = 'PAY212'
			dw_1.object.cocode[ll_insertrow]    = ls_code 
			dw_1.object.coitname[ll_insertrow]  = ls_name
			dw_1.object.coitnamee[ll_insertrow] = ls_name
			dw_1.object.coflname[ll_insertrow]  = ls_fname
			dw_1.object.coflnamee[ll_insertrow] = ls_fname
			dw_1.object.coadpdt[ll_insertrow]   = g_s_date
			
		Next	
	case else
		
End choose

return ll_errcnt
end function

public function integer wf_month_carcheck (string ag_ym, string ag_ficode);int li_cnt

	SELECT count(*)
	  Into :li_cnt
    FROM "PBGEN"."GEN210" LEFT OUTER JOIN "PBFIA"."FIA030"  
        ON "PBGEN"."GEN210"."FICODE" = "PBFIA"."FIA030"."FICODE"
   WHERE  "PBGEN"."GEN210"."CUSE" = 'Y'  AND
        ( 
         (SUBSTRING("PBGEN"."GEN210"."FICODE",1,3) IN ( 'E11','E12','E13','E14') AND
         ( "PBFIA"."FIA030"."FISTAGU" IN ( '1','4','6')   or
           ( "PBFIA"."FIA030"."FISTAGU"  IN ( '2','3') and   SUBSTRING("PBFIA"."FIA030"."FIACCDATE",1,6) >= :ag_ym  )
         )
         ) OR SUBSTRING("PBGEN"."GEN210"."FICODE",1,3) = 'Z11'
        ) AND "PBGEN"."GEN210"."FICODE" = :ag_ficode
	Using sqlcc;
	
if sqlcc.sqlcode <> 0 then
	Return 0
else
	Return li_cnt
End if
end function

public function integer wf_month_unbancheck (string ag_ym, string ag_ficode);int li_cnt

	SELECT count(*)
	  Into :li_cnt
    FROM "PBGEN"."GEN210" , "PBFIA"."FIA030" 
   WHERE "PBGEN"."GEN210"."FICODE" = "PBFIA"."FIA030"."FICODE" AND
         "PBGEN"."GEN210"."CUSE"   = 'Y'  AND
         SUBSTRING("PBGEN"."GEN210"."FICODE",1,3) IN ( 'E31','E33','E35','E39') AND
         ( "PBFIA"."FIA030"."FISTAGU"  IN ( '1','4','6')   or
           ("PBFIA"."FIA030"."FISTAGU"  IN ( '2','3') and   SUBSTRING("PBFIA"."FIA030"."FIACCDATE",1,6) >= :ag_ym  )
         ) AND
         "PBGEN"."GEN210"."FICODE" = :ag_ficode
	Using sqlcc;
	
if sqlcc.sqlcode <> 0 then
	Return 0
else
	Return li_cnt
End if
end function

public function integer wf_existchk (string ag_empno, string ag_yy, string ag_no, string ag_xdate);int li_cnt

	SELECT count(*)
	  Into :li_cnt
    FROM "PBMED"."MED130"    
	 WHERE "PBMED"."MED130"."CEMPNO" = :ag_empno AND
			 "PBMED"."MED130"."CYEAR"    = :ag_yy     AND
			 "PBMED"."MED130"."CNO"    = :ag_no AND
			 "PBMED"."MED130"."CEXAMDATE"    = :ag_xdate
	Using sqlcc;
	
if li_cnt > 0 then
	Return 1
else
	Return 0
End if
end function

on w_per_textup.create
this.dw_text=create dw_text
this.dw_title=create dw_title
this.p_1=create p_1
this.st_2=create st_2
this.mle_1=create mle_1
this.cb_4=create cb_4
this.sle_2=create sle_2
this.cb_3=create cb_3
this.cb_create=create cb_create
this.st_7=create st_7
this.uo_1=create uo_1
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
this.dw_1=create dw_1
this.Control[]={this.dw_text,&
this.dw_title,&
this.p_1,&
this.st_2,&
this.mle_1,&
this.cb_4,&
this.sle_2,&
this.cb_3,&
this.cb_create,&
this.st_7,&
this.uo_1,&
this.st_6,&
this.st_5,&
this.st_4,&
this.gb_1,&
this.gb_2,&
this.gb_4,&
this.dw_1}
end on

on w_per_textup.destroy
destroy(this.dw_text)
destroy(this.dw_title)
destroy(this.p_1)
destroy(this.st_2)
destroy(this.mle_1)
destroy(this.cb_4)
destroy(this.sle_2)
destroy(this.cb_3)
destroy(this.cb_create)
destroy(this.st_7)
destroy(this.uo_1)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.dw_1)
end on

event open;////st_12.text = mid(g_s_date,1,6)
//
//Str_Open_Parm	lStr_Parm

String ls_parm

ls_Parm = Message.StringParm	

is_gubun = Mid(ls_parm, 1, 6)
is_yy    = Mid(ls_parm, 7, 4)
//is_yy    = Mid(ls_parm, 2, 4)
//is_mm	   = Mid(ls_parm, 6, 2)
//
//if is_gubun = 'A' then //차량유지비
//   st_1.text = is_yy + "년 " + is_mm + "월 차량유지비 일괄 입력" 
//	rb_2.checked = true
//	rb_1.enabled = false
//	dw_1.DataObject = "d_gen220b_01"
//	dw_1.SetTransObject( SQLCC )
//else 
//	st_1.text = is_yy + "년 " + is_mm + "월 운반구유지비 일괄 입력" 
//	rb_1.checked = true
//	rb_2.enabled = false
//	dw_1.DataObject = "d_gen220b_011"
//	dw_1.SetTransObject( SQLCC )
//End if
//
choose case is_gubun
	case 'acnt01'
		dw_text.Reset()
		dw_text.DataObject = "d_per_textup_acnt01t"
		dw_text.SetTransObject( sqlcc )
		
		dw_1.Reset()
		dw_1.DataObject = "d_per_textup_acnt01"
		dw_1.SetTransObject( sqlcc )
	case 'acnt02'
		dw_text.Reset()
		dw_text.DataObject = "d_per_textup_acnt02t"
		dw_text.SetTransObject( sqlcc )
		
		dw_1.Reset()
		dw_1.DataObject = "d_per_textup_acnt02"
		dw_1.SetTransObject( sqlcc )
	case 'acnt03'
		dw_text.Reset()
		dw_text.DataObject = "d_per_textup_acnt03t"
		dw_text.SetTransObject( sqlcc )
		
		dw_1.Reset()
		dw_1.DataObject = "d_per_textup_acnt03"
		dw_1.SetTransObject( sqlcc )
	case 'acnt04'
		dw_text.Reset()
		dw_text.DataObject = "d_per_textup_acnt04t"
		dw_text.SetTransObject( sqlcc )
		
		dw_1.Reset()
		dw_1.DataObject = "d_per_textup_acnt04"
		dw_1.SetTransObject( sqlcc )	
	case 'per90'
		dw_text.Reset()
		dw_text.DataObject = "d_per_textup_per90t"
		dw_text.SetTransObject( sqlcc )
		
		dw_1.Reset()
		dw_1.DataObject   = "d_per_textup_per90"
		dw_1.SetTransObject( sqlcc )
	case 'per91'
		dw_text.Reset()
		dw_text.DataObject = "d_per_textup_per91"
		dw_text.SetTransObject( sqlcc )
		
		dw_1.Reset()
		dw_1.DataObject   = "d_per_textup_per90"
		dw_1.SetTransObject( sqlcc )	
	case else
End choose

end event

event activate;f_center_window(This)
end event

event close;//Destroy ids_carinfo_ins
end event

type dw_text from datawindow within w_per_textup
boolean visible = false
integer x = 1426
integer y = 756
integer width = 1723
integer height = 824
integer taborder = 20
string title = "none"
string dataobject = "d_per_textup_per91"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_title from datawindow within w_per_textup
integer x = 1819
integer y = 72
integer width = 1737
integer height = 144
integer taborder = 40
string title = "none"
string dataobject = "d_per_excelup_title"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type p_1 from picture within w_per_textup
integer x = 306
integer y = 1844
integer width = 133
integer height = 72
string picturename = "C:\KDAC\bmp\blink1.gif"
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_2 from statictext within w_per_textup
integer x = 18
integer y = 1840
integer width = 407
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12639424
string text = "정보화면:"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_per_textup
integer x = 425
integer y = 1840
integer width = 3895
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 134217858
long backcolor = 15793151
string text = "text 파일자료는 화면의 하늘색 표시부분만 순서대로 만들어 주세요. "
integer tabstop[] = {0}
boolean displayonly = true
borderstyle borderstyle = styleshadowbox!
end type

type cb_4 from commandbutton within w_per_textup
integer x = 3945
integer y = 116
integer width = 379
integer height = 104
integer taborder = 70
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "궁서"
string pointer = "HyperLink!"
string text = "닫기"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, "")

////close(w_frame.GetActiveSheet())
//
//close(w_inv101b)
end event

type sle_2 from singlelineedit within w_per_textup
integer x = 297
integer y = 72
integer width = 1513
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_per_textup
integer x = 41
integer y = 72
integer width = 261
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "자료경로"
end type

event clicked;String ls_pathname,ls_filename, ls_msg
long li_Rtn
Long ll_cnt, ll_rowcnt

IF dw_1.RowCount() > 0 Then		
	IF MessageBox("UPLOAD","작업중인 자료가 존재합니다. ~r~n~r~n무시하고 UPLOAD작업을 진행하시겠습니까?",Question!,YesNo!, 2)  =  2 THEN
		RETURN
	End IF	
END IF

dw_1.Reset()

GetFileOpenName("Select File", ls_pathname, ls_filename, "txt","Text Files (*.txt),*.txt,")

sle_2.text = ls_pathname

if trim(sle_2.text) = '' then
	messagebox('자료경로 확인', '자료경로를 지정해주세요')
	return
end if

SetPointer(HourGlass!)

li_rtn = dw_text.importfile(ls_pathname)

if li_rtn <> -1 then
    
  st_5.text = string(li_rtn)
  
  ll_cnt = wf_Errchk(dw_text)
  
	if ll_cnt = 0 then
		cb_create.enabled = True
		mle_1.text = "[정보생성]을 클릭하면 자료가 저장됩니다."
	else 
//		dw_1.scrolltorow(ll_cnt)
//		dw_1.selectrow(ll_cnt,true)
		mle_1.text = "텍스트 파일 오류 수정 후 재업로드 해주세요. "
		cb_create.enabled = False
		Return -1
	End if  
	SetPointer(ARROW!)
   return 0
end if
	
MessageBox( '확인!', 'text UpLoad중 에러 발생! UpLoad 양식을 확인바랍니다.' )
Return -1
end event

type cb_create from commandbutton within w_per_textup
integer x = 3561
integer y = 116
integer width = 379
integer height = 104
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "궁서"
boolean enabled = false
string text = "정보생성"
end type

event clicked;long 	 ll_rowcnt, ll_currow, ll_complete, ll_rtncnt, ll_savecnt, ll_InsertRow
Int    li_Rtn
Int    li_index, rtn, ll_insert
String ls_message, ls_cexamdate, ls_empno, ls_dept, ls_class


If f_Mandatory_Chk( dw_1 ) = -1 Then // 필수입력항목 Check...
	Return 1 
End If

dw_1.accepttext()

ll_savecnt = 0

ll_rowcnt = dw_1.rowcount()

if ll_rowcnt < 1 then
	return 0
end if

setpointer(hourglass!)
//
//choose case is_gubun
//	case 'med001'
//		for ll_currow = 1 to ll_rowcnt
//			dw_1.SelectRow(0, False)
//			dw_1.SelectRow(ll_currow, True)	
//			dw_1.ScrollToRow(ll_currow)
//			
//			ll_savecnt   = ll_savecnt +1	
//			ll_insert    = dw_2.InsertRow(0)
//			
//			dw_2.object.cempno[ll_insert]    = dw_1.object.cempno[ll_currow]
//			dw_2.object.cyear[ll_insert]     = dw_1.object.cyear[ll_currow]
//			dw_2.object.cno[ll_insert]       = dw_1.object.cno[ll_currow]
//			dw_2.object.cexamdate[ll_insert] = dw_1.object.cexamdate[ll_currow]
//			dw_2.object.CDEPTNM[ll_insert]   = f_deptnmrtn(dw_1.object.cempno[ll_currow], 'A')
//			dw_2.object.HEIGHT[ll_insert]    = dec(dw_1.object.HEIGHT[ll_currow])
//			dw_2.object.WEIGHT[ll_insert]    = dec(dw_1.object.WEIGHT[ll_currow])
//			dw_2.object.FAT[ll_insert]       = dw_1.object.FAT[ll_currow]
//			dw_2.object.LEYE[ll_insert]      = dec(dw_1.object.LEYE[ll_currow])
//			dw_2.object.REYE[ll_insert]      = dec(dw_1.object.REYE[ll_currow])
////			dw_2.object.FLEYE[ll_insert]     = dec(dw_1.object.FLEYE[ll_currow])
////			dw_2.object.FREYE[ll_insert]     = dec(dw_1.object.FREYE[ll_currow])
//			dw_2.object.LEAR1000[ll_insert]  = dw_1.object.LEAR1000[ll_currow]
//			dw_2.object.REAR1000[ll_insert]  = dw_1.object.REAR1000[ll_currow]
//			dw_2.object.LEAR4000[ll_insert]  = dec(dw_1.object.LEAR4000[ll_currow])
//			dw_2.object.REAR4000[ll_insert]  = dec(dw_1.object.REAR4000[ll_currow])
//			dw_2.object.EYECOLOR[ll_insert]  = dw_1.object.EYECOLOR[ll_currow]
//			dw_2.object.HBP[ll_insert]       = dec(dw_1.object.HBP[ll_currow])
//			dw_2.object.LBP[ll_insert]       = dec(dw_1.object.LBP[ll_currow])
//			dw_2.object.ABOTYPE[ll_insert]   = dw_1.object.ABOTYPE[ll_currow]
//			dw_2.object.RHTYPE[ll_insert]    = dw_1.object.RHTYPE[ll_currow]
//			dw_2.object.UGLUCOSE[ll_insert]  = dw_1.object.UGLUCOSE[ll_currow]
//			dw_2.object.UPROTEIN[ll_insert]  = dw_1.object.UPROTEIN[ll_currow]
//			dw_2.object.UOCCBLOOD[ll_insert] = dw_1.object.UOCCBLOOD[ll_currow]
//			dw_2.object.UPH[ll_insert]       = dec(dw_1.object.UPH[ll_currow])
//			dw_2.object.BGLUCOSE[ll_insert]  = dec(dw_1.object.BGLUCOSE[ll_currow])
//			dw_2.object.BHEMOGLOBIN[ll_insert] = dec(dw_1.object.BHEMOGLOBIN[ll_currow])
//			dw_2.object.HCT[ll_insert]       = dec(dw_1.object.HCT[ll_currow])
//			dw_2.object.AST[ll_insert]       = dec(dw_1.object.AST[ll_currow])
//			dw_2.object.ALT[ll_insert]       = dec(dw_1.object.ALT[ll_currow])
//			dw_2.object.RGPT[ll_insert]      = dec(dw_1.object.RGPT[ll_currow])
//			dw_2.object.TCHOL[ll_insert]     = dec(dw_1.object.TCHOL[ll_currow])
//			dw_2.object.HBSAG[ll_insert]     = dw_1.object.HBSAG[ll_currow]
//			dw_2.object.HBSAB[ll_insert]     = dw_1.object.HBSAB[ll_currow]
//			dw_2.object.HBSRESULT[ll_insert] = dw_1.object.HBSRESULT[ll_currow]
//			dw_2.object.CHESTPA[ll_insert]   = dw_1.object.CHESTPA[ll_currow]
//			dw_2.object.LUMBARPA[ll_insert]  = dw_1.object.LUMBARPA[ll_currow]
//			dw_2.object.ECG[ll_insert]       = dw_1.object.ECG[ll_currow]
//			dw_2.object.HISTORYA[ll_insert]  = dw_1.object.HISTORYA[ll_currow]
//			dw_2.object.HISTORYB[ll_insert]  = dw_1.object.HISTORYB[ll_currow]
//			dw_2.object.LIFEHABIT[ll_insert] = dw_1.object.LIFEHABIT[ll_currow]
//			dw_2.object.STATUS[ll_insert]    = dw_1.object.STATUS[ll_currow]
//			dw_2.object.DECISION[ll_insert]  = dw_1.object.DECISION[ll_currow]
//			dw_2.object.OPINION[ll_insert]   = dw_1.object.OPINION[ll_currow]
//			dw_2.object.ORDERS[ll_insert]    = dw_1.object.ORDERS[ll_currow]
//			dw_2.object.HOSPITAL[ll_insert]  = dw_1.object.HOSPITAL[ll_currow]
//			
//			if wf_existchk(dw_1.object.cempno[ll_currow], dw_1.object.cyear[ll_currow], dw_1.object.cno[ll_currow],dw_1.object.cexamdate[ll_currow]) = 1 then
//				dw_2.SetitemStatus( ll_insert, 0, primary!, datamodified! )
//				dw_2.SetitemStatus( ll_insert, 0, primary!, NotModified! )
//			End if
//			
//			ll_complete = ll_currow * 100 / ll_rowcnt	
//			uo_1.uf_set_position (ll_complete)
//			st_7.text = string(ll_savecnt,"###,### ")	
//			
//		Next
//	case 'med002'
//		for ll_currow = 1 to ll_rowcnt
//			dw_1.SelectRow(0, False)
//			dw_1.SelectRow(ll_currow, True)	
//			dw_1.ScrollToRow(ll_currow)
//			
//			ll_savecnt   = ll_savecnt +1	
//			ll_insert    = dw_2.InsertRow(0)
//			
//			dw_2.object.cempno[ll_insert]    = dw_1.object.cempno[ll_currow]
//			dw_2.object.cyear[ll_insert]     = dw_1.object.cyear[ll_currow]
//			dw_2.object.cno[ll_insert]       = dw_1.object.cno[ll_currow]
//			dw_2.object.cexamdate[ll_insert] = dw_1.object.cexamdate[ll_currow]
//			dw_2.object.CDEPTNM[ll_insert]   = f_deptnmrtn(dw_1.object.cempno[ll_currow], 'A')
//			dw_2.object.CHESTPA2[ll_insert]  = dw_1.object.CHESTPA2[ll_currow]
//			dw_2.object.TUBERCLE2[ll_insert] = dw_1.object.TUBERCLE2[ll_currow]
//			dw_2.object.TUBERCLE22[ll_insert]= dw_1.object.TUBERCLE22[ll_currow]
//			dw_2.object.HBP2[ll_insert]      = dec(dw_1.object.HBP2[ll_currow])
//			dw_2.object.LBP2[ll_insert]      = dec(dw_1.object.LBP2[ll_currow])
//			dw_2.object.LEYEP2[ll_insert]    = dw_1.object.LEYEP2[ll_currow]
//			dw_2.object.REYEP2[ll_insert]    = dw_1.object.REYEP2[ll_currow]
//			dw_2.object.EYER2[ll_insert]     = dw_1.object.EYER2[ll_currow]
//			dw_2.object.ECG2[ll_insert]      = dw_1.object.ECG2[ll_currow]
//			dw_2.object.TRIGLY2[ll_insert]   = dec(dw_1.object.TRIGLY2[ll_currow])
//			dw_2.object.HDLCHOL2[ll_insert]  = dec(dw_1.object.HDLCHOL2[ll_currow]) 
//			dw_2.object.ALBUMIN2[ll_insert]  = dec(dw_1.object.ALBUMIN2[ll_currow])
//			dw_2.object.TPROTEIN2[ll_insert] = dec(dw_1.object.TPROTEIN2[ll_currow])
//			dw_2.object.TBILIRUBIN2[ll_insert] = dec(dw_1.object.TBILIRUBIN2[ll_currow])
//			dw_2.object.DBILIRUBIN2[ll_insert] = dec(dw_1.object.DBILIRUBIN2[ll_currow])
//			dw_2.object.ALP2[ll_insert]        = dec(dw_1.object.ALP2[ll_currow])
//			dw_2.object.LDH2[ll_insert]        = dec(dw_1.object.LDH2[ll_currow])
//			dw_2.object.AFP2[ll_insert]        = dw_1.object.AFP2[ll_currow]
//			dw_2.object.HBSAG2[ll_insert]      = dw_1.object.HBSAG2[ll_currow]
//			dw_2.object.HBSAB2[ll_insert]      = dw_1.object.HBSAB2[ll_currow]
//			dw_2.object.HBSRESULT2[ll_insert]  = dw_1.object.HBSRESULT2[ll_currow]
//			dw_2.object.RBC2[ll_insert]        = dec(dw_1.object.RBC2[ll_currow])
//			dw_2.object.WBC2[ll_insert]        = dec(dw_1.object.WBC2[ll_currow])
//			dw_2.object.BUN2[ll_insert]        = dec(dw_1.object.BUN2[ll_currow])
//			dw_2.object.CREATININE2[ll_insert] = dec(dw_1.object.CREATININE2[ll_currow])
//			dw_2.object.URICACID2[ll_insert]   = dec(dw_1.object.URICACID2[ll_currow])
//			dw_2.object.HEMATOCRIT2[ll_insert] = dec(dw_1.object.HEMATOCRIT2[ll_currow])
//			dw_2.object.WHITEB2[ll_insert]     = dec(dw_1.object.WHITEB2[ll_currow])
//			dw_2.object.REDB2[ll_insert]       = dec(dw_1.object.REDB2[ll_currow])
//			dw_2.object.BGLUCOSE2[ll_insert]   = dec(dw_1.object.BGLUCOSE2[ll_currow])
//			dw_2.object.AGLUCOSE2[ll_insert]   = dec(dw_1.object.AGLUCOSE2[ll_currow])
//			dw_2.object.GEYE2[ll_insert]       = dw_1.object.GEYE2[ll_currow]
//			dw_2.object.ETC2[ll_insert]        = dw_1.object.ETC2[ll_currow]
//			dw_2.object.DECISION2[ll_insert]   = dw_1.object.DECISION2[ll_currow]
//			dw_2.object.OPINION2[ll_insert]    = dw_1.object.OPINION2[ll_currow]
//			dw_2.object.ORDERS2[ll_insert]     = dw_1.object.ORDERS2[ll_currow]
//			dw_2.object.HOSPITAL2[ll_insert]   = dw_1.object.HOSPITAL2[ll_currow]			
//			
//		   if wf_existchk(dw_1.object.cempno[ll_currow], dw_1.object.cyear[ll_currow], dw_1.object.cno[ll_currow],dw_1.object.cexamdate[ll_currow]) = 1 then
//				dw_2.SetitemStatus( ll_insert, 0, primary!, datamodified! )
//				dw_2.SetitemStatus( ll_insert, 0, primary!, NotModified! )
//			End if
//			
//			ll_complete = ll_currow * 100 / ll_rowcnt	
//			uo_1.uf_set_position (ll_complete)
//			st_7.text = string(ll_savecnt,"###,### ")	
//			
//		Next		
//	case else
//End choose
//
f_per_nullchk( dw_1 )
f_per_inptid( dw_1 )

li_Rtn = dw_1.Update(True, False)

If li_Rtn = 1 Then    
	dw_1.ResetUpdate( )	
   mle_1.text = "자료 저장 완료되었습니다."
Else	
	mle_1.text = "자료 저장 실패 되었습니다." 
End if

setpointer(arrow!) 

cb_create.enabled = False

end event

type st_7 from statictext within w_per_textup
integer x = 1637
integer y = 2016
integer width = 407
integer height = 84
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type uo_1 from uo_progress_bar within w_per_textup
event destroy ( )
integer x = 2176
integer y = 2012
integer width = 1408
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type st_6 from statictext within w_per_textup
integer x = 1307
integer y = 2028
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "생성건수"
boolean focusrectangle = false
end type

type st_5 from statictext within w_per_textup
integer x = 846
integer y = 2016
integer width = 389
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_per_textup
integer x = 544
integer y = 2024
integer width = 293
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "대상건수"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_per_textup
integer x = 2126
integer y = 1944
integer width = 1513
integer height = 196
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "[처리상태]"
end type

type gb_2 from groupbox within w_per_textup
integer x = 489
integer y = 1944
integer width = 1614
integer height = 192
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_4 from groupbox within w_per_textup
integer x = 27
integer y = 4
integer width = 1792
integer height = 196
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_1 from datawindow within w_per_textup
integer x = 18
integer y = 224
integer width = 4302
integer height = 1608
integer taborder = 10
string title = "none"
string dataobject = "d_per_textup_per90"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//dw_1.DataObject = "d_mmm203u_04"
THIS.SetTransObject( SQLCC )
end event

