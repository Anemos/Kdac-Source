$PBExportHeader$w_piss460u_test.srw
$PBExportComments$생관SR확정
forward
global type w_piss460u_test from w_ipis_sheet01
end type
type gb_4 from groupbox within w_piss460u_test
end type
type dw_sheet from u_vi_std_datawindow within w_piss460u_test
end type
type uo_division from u_pisc_select_division within w_piss460u_test
end type
type uo_area from u_pisc_select_area within w_piss460u_test
end type
type dw_2 from u_vi_std_datawindow within w_piss460u_test
end type
type st_v_bar from uo_xc_splitbar within w_piss460u_test
end type
type rb_1 from radiobutton within w_piss460u_test
end type
type rb_2 from radiobutton within w_piss460u_test
end type
type rb_3 from radiobutton within w_piss460u_test
end type
type gb_2 from groupbox within w_piss460u_test
end type
type gb_3 from groupbox within w_piss460u_test
end type
type gb_1 from groupbox within w_piss460u_test
end type
type sle_custcode from singlelineedit within w_piss460u_test
end type
end forward

global type w_piss460u_test from w_ipis_sheet01
integer width = 4517
integer height = 2700
string title = "생관SR확정"
event ue_postopen ( )
gb_4 gb_4
dw_sheet dw_sheet
uo_division uo_division
uo_area uo_area
dw_2 dw_2
st_v_bar st_v_bar
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
gb_2 gb_2
gb_3 gb_3
gb_1 gb_1
sle_custcode sle_custcode
end type
global w_piss460u_test w_piss460u_test

type variables
string is_date, is_today
int ii_window_border = 10
boolean ib_open
string is_security, is_pgmid, is_pgmname

datawindow idw_srorder, idw_public, idw_nodaewoo, &
                     idw_srorder1, idw_current
integer ii_selectrow
string is_modelcode, is_custcode, is_modelgubun,  is_mod[],is_custgubun
string is_shipoemgubun,is_areacode,is_divisioncode
datawindowchild idwc_rpt1
Long il_purple = 8388736, il_text = 33554432
string is_itemcode
int ii_net
end variables

forward prototypes
public function boolean wf_update_tsrcancel ()
public function boolean wf_update_db2_cancel (string fs_confirmflag, string fs_srno, string fs_checksrno, string fs_canceldate)
public function boolean wf_update_db2 (string fs_checksrno)
public function boolean wf_update_tsrheader ()
end prototypes

event ue_postopen;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)


end event

public function boolean wf_update_tsrcancel ();long ll_count,i,ll_cnt,ll_found
string ls_srcancelgubun,ls_srno,ls_canceldate,ls_cancelgubun,ls_divisioncode,ls_checksrno,ls_itemcode,ls_custcode
string ls_org_srno,ls_find_string
boolean lb_commit
lb_commit = true
ll_count = dw_sheet.rowcount()
for i = 1 to ll_count step 1
	 ls_srcancelgubun = dw_sheet.object.srcancelgubun[i]
	 if ls_srcancelgubun = 'Y' then
      ls_srno = dw_sheet.object.srno[i]
      ls_checksrno = dw_sheet.object.checksrno[i]
		ls_cancelgubun  = dw_sheet.object.cancelgubun[1]
		ls_canceldate   = dw_sheet.object.canceldate[i]
		ls_itemcode     = dw_sheet.object.itemcode[i]
		ls_divisioncode = dw_sheet.object.divisioncode[i]
		ls_custcode     = dw_sheet.object.custcode[i]		
		ls_find_string = 'divisioncode = ' + "'" + ls_divisioncode + "'"
		ls_find_string = ls_find_string + ' and checksrno = ' + "'" + ls_checksrno + "'"
		ll_found = dw_2.find(ls_find_string,1,dw_2.rowcount())
		if ll_found <= 0 then
			dw_2.insertrow(1)
			dw_2.object.divisioncode[1] = ls_divisioncode
			dw_2.object.checksrno[1] = ls_checksrno
		end if
		update tsrcancel_hongsick
		   set confirmflag = 'Y',
             lastemp = 'Y',
				 lastdate = getdate()
		 where areacode = :is_areacode
		   and divisioncode = :is_divisioncode
			and canceldate = :ls_canceldate
			and srno       = :ls_srno
			and checksrno  = :ls_checksrno
			and cancelgubun = :ls_cancelgubun
			using sqlpis;
		if sqlpis.sqlcode <> 0 then
		   uo_status.st_message.text = "tsrcancel update error : " + sqlpis.sqlerrtext
			lb_commit = false
			exit
		end if
	   lb_commit = wf_update_db2_cancel('Y',left(ls_srno,8),left(ls_checksrno,11),mid(ls_canceldate,1,4) + mid(ls_canceldate,6,2) + mid(ls_canceldate,9,2))
//		select count(*)
//		  into :ll_cnt
//		  from tsrcancel_interface
//		  where srno      = :ls_srno
//		    and areacode  = :is_areacode
//			 and divisioncode = :ls_divisioncode
//			 and canceldate   = :ls_canceldate
//			 and cancelgubun  = :ls_cancelgubun
//		  using sqlpis;
//
//		ll_cnt = ll_cnt + 1
//		INSERT INTO TSRCANCEL_INTERFACE  
//                 (CancelDate,AreaCode,DivisionCode,SRNo,CancelGubun,SeqNo,   
//		            MISFlag,InterfaceFlag,ItemCode,ConfirmFlag,
//                  LastEmp,LastDate )  
//          VALUES (:ls_canceldate,:is_areacode,:ls_divisioncode,:ls_srno,:ls_cancelgubun,:ll_cnt, 
//                  'A','Y',:ls_itemcode,'Y',
//				      :g_s_empno,getdate() ) 
//			 using sqlpis;
//		if sqlpis.sqlcode <> 0 then
//		   uo_status.st_message.text = "tsrcancel_interface insert error : " + sqlpis.sqlerrtext
//			lb_commit = false
//			exit
//		end if
	end if
next
if lb_commit = false then
	return lb_commit
end if	
dw_2.accepttext()

//for i = 1 to dw_2.rowcount() step 1
//	ls_divisioncode = dw_2.object.divisioncode[i]
//	ls_checksrno = dw_2.object.checksrno[i]
//   
//	dw_print.retrieve(is_areacode,ls_divisioncode,ls_checksrno)
//	if dw_print.rowcount() > 0 then
//		dw_print.print()
//	end if
//next 
return lb_commit

end function

public function boolean wf_update_db2_cancel (string fs_confirmflag, string fs_srno, string fs_checksrno, string fs_canceldate);//If fs_confirmflag = 'Y' Then
long ln_count 

select count(*) into :ln_count from pbsle.sle303
where comltd = '01' and srno = :fs_checksrno using sqlca ;
if ln_count > 0 then
	UPDATE	pbsle.sle303
		SET		prtcd = '4'
	WHERE		comltd = '01'
	and		srno = :fs_checksrno using sqlca ;
else
	messagebox("A","SLE303 Not Found")
	return false
end if
if sqlca.sqlcode <> 0 then
	messagebox("A","SLE303 Update Error")
	return false
end if 

ln_count = 0

select count(*) into :ln_count from pbsle.sle304
where comltd = '01' and csrno = :fs_srno using sqlca ;
if ln_count > 0 then
	UPDATE	pbsle.sle304
		SET	stcd = 'C',
				srdt = :fs_canceldate
	WHERE		comltd = '01'
	and		csrno = :fs_srno using sqlca ;
else
	messagebox("A","SLE304 Not Found")
	return false
end if
if sqlca.sqlcode <> 0 then
	messagebox("A","SLE304 Update Error")
	return false
end if 

ln_count = 0

select count(*) into :ln_count from pbsle.sle301
where comltd = '01' and srno = :fs_checksrno using sqlca ;
if ln_count > 0 then
	UPDATE	pbsle.sle301
		SET	prtcd= '4'                                  
	WHERE		comltd = '01'
	and		srno = :fs_checksrno using sqlca ;
else
	messagebox("A","SLE301 Not Found")
	return false
end if
if sqlca.sqlcode <> 0 then
	messagebox("A","SLE301 Update Error")
	return false
end if 

ln_count = 0

select count(*) into :ln_count from pbsle.sle302
where comltd = '01' and csrno = :fs_srno using sqlca ;
if ln_count > 0 then
	UPDATE	pbsle.sle302
		SET		stcd = 'C'                                  
	WHERE		comltd = '01'
	and		csrno = :fs_srno using sqlca ;
else
	messagebox("A","SLE302 Not Found")
	return false
end if
if sqlca.sqlcode <> 0 then
	messagebox("A","SLE302 Update Error")
	return false
end if 
//Else                                                                   
//	UPDATE	pbsle.sle303
//	SET 		prtcd = '2'                                 
//	WHERE		comltd = '01'
//	and		srno = :fs_checksrno ;
//	
//	UPDATE	pbsle.sle304
//	SET		stcd = ' ', 
//				srdt = ' '                      
//	WHERE		comltd = '01'
//	and		csrno = :fs_srno ;
//	
//	UPDATE	pbsle.sle301
//	SET		prtcd= '4'                                  
//	WHERE		comltd = '01'
//	and		srno = :fs_checksrno ;
//	
//	UPDATE	pbsle.sle302
//	SET		stcd = ' '                                  
//	WHERE		comltd = '01'
//	and		csrno = :fs_srno ;
//End If
return true
end function

public function boolean wf_update_db2 (string fs_checksrno);string ls_checksrno_test
boolean lb_commit

If Left(fs_checksrno, 2) = 'EX' Then	// 이놈은 이체다...
	select distinct slno
	  into :ls_checksrno_test
	from pbinv.inv601
	where slno = :fs_checksrno
	and stcd = '3';
	if f_spacechk(ls_checksrno_test) = -1 then
		lb_commit = false
		messagebox("A","이체전표없음")
		return lb_commit
	end if
	
	update	pbinv.inv601
		set		stcd	= '4'
	where		slno	= :fs_checksrno
		and	stcd	= '3'
	using sqlca ;
	
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = "inv601 update error : " + sqlca.sqlerrtext
		lb_commit = false
		return lb_commit
	end if
		
//			Else
//				select stcd into :ls_chkstcd 
//					from pbinv.inv601
//					where slno = :ls_srno ;
//				if ls_chkstcd > '3' then
//					Update	tsrconfirm01_interface
//					Set		interfaceflag = 'N',
//							lastdate	= getdate()
//					Where		logid = :ll_logid
//					Using		it_source;
//				end if
//			End If			
	
Else		/* 이체 아닌놈 */

	select	srno
	into		:ls_checksrno_test
	from		pbsle.sle301
	where		srno	= :fs_checksrno
	and		prtcd	= '2';
	if f_spacechk(ls_checksrno_test) = -1 then
		lb_commit = false
		messagebox("A","SLE301 Not Found")
		return lb_commit
	end if

	update	pbsle.sle301
		set		prtcd	= '3'
	where		srno	= :fs_checksrno
		and	prtcd	= '2'
	using sqlca ;
	
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = "sle301 update error : " + sqlca.sqlerrtext
		lb_commit = false
		return lb_commit
	end if
End if

return true

end function

public function boolean wf_update_tsrheader ();string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

long ll_count,i,ll_cnt
string ls_stcd,ls_checksrno,ls_checksrno_test,ls_divisioncode,ls_areacode,ls_custcode,ls_shipgubun
ll_count = dw_sheet.rowcount()
boolean lb_commit
lb_commit = true
for i = 1 to ll_count step 1
	 ls_stcd = dw_sheet.object.stcd[i]
	 if ls_stcd = 'Y' then
		ls_areacode  = is_areacode
      ls_checksrno = dw_sheet.object.srno[i]
      ls_divisioncode = dw_sheet.object.divisioncode[i]
		ls_shipgubun = dw_sheet.object.shipgubun[i]
		ls_custcode  = dw_sheet.object.custcode[i]
//		if left(ls_custcode,1) = 'E' then
//			dw_print.dataobject = 'd_piss460u_04'
//		else
//			dw_print.dataobject = 'd_piss460u_03'
//		end if
//		dw_print.settransobject(sqlpis)
//		if ii_net = 1 then
//		   dw_print.retrieve(is_areacode,ls_divisioncode,ls_custcode,ls_checksrno)
//		   dw_print.print()
//		end if
		if ls_shipgubun = 'M' then
			ls_areacode = left(ls_custcode,1)
			ls_divisioncode = mid(ls_custcode,2,1)
   	else
			ls_areacode = is_areacode
		end if
		update tsrheader_hongsick
		   set prtcd         = 'Y',
			    srconfirmdate = convert(char(10),getdate(),102),
             lastemp       = 'Y',
				 lastdate      = getdate()
		 where srareacode      = :ls_areacode
		   and srdivisioncode  = :ls_divisioncode
			and checksrno     = :ls_checksrno
			using sqlpis;
		if sqlpis.sqlcode <> 0 then
		   uo_status.st_message.text = "tsrheader update error : " + sqlpis.sqlerrtext
			lb_commit = false
			exit
		end if
		update tsrorder_hongsick
		   set stcd         = 'Y',
             lastemp       = 'Y',
				 lastdate      = getdate()
		 where areacode      = :ls_areacode
		   and divisioncode  = :ls_divisioncode
			and checksrno     like :ls_checksrno
			using sqlpis;
		if sqlpis.sqlcode <> 0 then
		   uo_status.st_message.text = "tsrorder update error : " + sqlpis.sqlerrtext
         lb_commit = false
			exit
		end if
		lb_commit = wf_update_db2(ls_checksrno)
//		select count(*)
//		  into :ll_cnt
//		  from tsrconfirm01_interface
//		  where srno         = :ls_checksrno
//		    and areacode     = :ls_areacode
//			 and divisioncode = :ls_divisioncode
//			 using sqlpis;
//	   ll_cnt = ll_cnt + 1
//      INSERT INTO TSRCONFIRM01_interface
//                ( confirmdate,SRNO,seqno,
//                  AREACODE,DivisionCode,
//						MISFLAG,INTERFACEFLAG,lastemp,lastdate)  
//        VALUES ( :ls_close_date,:ls_checksrno,:ll_cnt,   
//                 :ls_areacode,:ls_divisioncode,
//                 'A','Y',:g_s_empno,getdate() )  using sqlpis;
//		if sqlpis.sqlcode <> 0 then
//			uo_status.st_message.text = "tsrconfirm01_interface insert error : "+ sqlpis.sqlerrtext
//			lb_commit = false
//			exit
//		end if
	end if
next
return lb_commit

end function

on w_piss460u_test.create
int iCurrent
call super::create
this.gb_4=create gb_4
this.dw_sheet=create dw_sheet
this.uo_division=create uo_division
this.uo_area=create uo_area
this.dw_2=create dw_2
this.st_v_bar=create st_v_bar
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_1=create gb_1
this.sle_custcode=create sle_custcode
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.dw_sheet
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_area
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.st_v_bar
this.Control[iCurrent+7]=this.rb_1
this.Control[iCurrent+8]=this.rb_2
this.Control[iCurrent+9]=this.rb_3
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.sle_custcode
end on

on w_piss460u_test.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.dw_sheet)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.dw_2)
destroy(this.st_v_bar)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.sle_custcode)
end on

event resize;call super::resize;il_resize_count ++
if rb_1.checked = true then
	of_resize_register(dw_sheet, LEFT)
	of_resize_register(st_v_bar, SPLIT)
	of_resize_register(dw_2, RIGHT)
else
	of_resize_register(dw_sheet, full)
end if
of_resize()
end event

event ue_retrieve;setpointer(hourglass!)
long ll_count,i
string ls_gubun,ls_custcode
dw_2.reset()
dw_sheet.reset()
ls_custcode = trim(sle_custcode.text)
if ls_custcode = '' or isnull(ls_custcode) then
   	ls_custcode = '%'
else
	ls_custcode = ls_custcode + '%'
end if	

if rb_2.checked = true then
	ls_gubun = '2'
	dw_sheet.retrieve(is_areacode,is_divisioncode,ls_custcode,ls_gubun)
elseif rb_3.checked = true then
	ls_gubun = '3'
	dw_sheet.retrieve(is_areacode,is_divisioncode,ls_custcode,ls_gubun)	
else	
	dw_sheet.retrieve(is_areacode,is_divisioncode,ls_custcode)
end if	

setpointer(arrow!)
if dw_sheet.rowcount() = 0 then
	messagebox("확인","조회할 자료가 없읍니다.")
	return
end if
ll_count = dw_sheet.rowcount()
for i = 1 to ll_count step 1
	 dw_sheet.object.stcd[i] = 'Y'
next
end event

event ue_save;
ii_Net = MessageBox("확인","출력하시겠읍니까.",Exclamation!, OKCancel!,1)

setpointer(hourglass!)

sqlpis.autocommit = false
sqlca.autocommit = false

if rb_1.checked = true then
	if wf_update_tsrheader() then
		commit using sqlpis;
		sqlpis.autocommit = true	
		commit using sqlca;
		sqlca.autocommit = true
		messagebox("확인","작업이 완료되었읍니다.")
	else
		rollback using sqlpis;
		sqlpis.autocommit = true
		rollback using sqlca;
		sqlca.autocommit = true
		messagebox("확인","작업중 오류가 발생했읍니다.")
	end if
else
	if wf_update_tsrcancel() then
		commit using sqlpis;
		sqlpis.autocommit = true
		commit using sqlca;
		sqlca.autocommit = true
		messagebox("확인","작업이 완료되었읍니다")
	else
		rollback using sqlpis;
		sqlpis.autocommit = true
		rollback using sqlca;
		sqlca.autocommit = true
		messagebox("확인","작업중 오류가 발생했읍니다.")		
	end if
end if	
setpointer(arrow!)
postevent('ue_retrieve')

end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss460u_test
end type

type gb_4 from groupbox within w_piss460u_test
integer x = 1271
integer y = 72
integer width = 311
integer height = 168
integer taborder = 210
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "거래처"
end type

type dw_sheet from u_vi_std_datawindow within w_piss460u_test
integer x = 18
integer y = 288
integer width = 2414
integer height = 2176
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss460u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;string ls_checksrno,ls_divisioncode,ls_custcode
if row > 0 then
	ls_checksrno    = dw_sheet.object.srno[row]
	ls_divisioncode = dw_sheet.object.divisioncode[row]
	ls_custcode     = dw_sheet.object.custcode[row]
	dw_2.retrieve(is_areacode,ls_divisioncode,ls_custcode,ls_checksrno)
end if	
end event

type uo_division from u_pisc_select_division within w_piss460u_test
integer x = 631
integer y = 140
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
//dw_print.settransobject(sqlpis)
is_divisioncode = is_uo_divisioncode
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type uo_area from u_pisc_select_area within w_piss460u_test
integer x = 78
integer y = 140
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
//dw_print.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_division
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						조회하고자 하는 DDDW Object
//						string			fs_empno					조회하고자 하는 사번 (지역별/공장별 권한에 따른 조회를 위하여)
//						string			fs_areacode				조회하고자 하는 지역
//						string			fs_divisioncode		조회하고자 하는 공장 코드 (일반적으로 '%' 을 사용하도록)
//						boolean			fb_allflag				조회된 공장 정보가 2개 이상의 Record 일 경우
//																		True : '전체' 항목 삽입 (공장코드는 '%', 공장명은 '전체')
//																		False : '전체' 항목 미 삽입
//						string			rs_divisioncode		선택된 공장 코드 (reference)
//						string			rs_divisionname		선택된 공장 명 (reference)
//						string			rs_divisionnameeng	선택된 공장 영문 명 (reference)
//	Returns		: none
//	Description	: 공장을 선택하기 위한 DDDW 을 조회하기 위하여
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)


end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type dw_2 from u_vi_std_datawindow within w_piss460u_test
integer x = 2478
integer y = 288
integer width = 1984
integer height = 2172
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_piss460u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type st_v_bar from uo_xc_splitbar within w_piss460u_test
integer x = 2455
integer y = 452
integer width = 18
boolean bringtotop = true
integer textsize = -9
end type

event constructor;call super::constructor;of_register(dw_sheet,LEFT)
of_register(dw_2,RIGHT)
	
end event

type rb_1 from radiobutton within w_piss460u_test
integer x = 1705
integer y = 136
integer width = 288
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "SR확정"
boolean checked = true
end type

event clicked;rb_2.checked = false
rb_3.checked = false
dw_sheet.dataobject = 'd_piss460u_01'
//dw_print.dataobject = 'd_piss460u_03'
dw_2.dataobject = 'd_piss460u_02'
dw_sheet.settransobject(sqlpis)
//dw_print.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_sheet.reset()
dw_2.reset()
//dw_print.reset()

dw_2.visible = true
il_resize_count ++

of_resize_register(dw_sheet, LEFT)
of_resize_register(st_v_bar, SPLIT)
of_resize_register(dw_2, RIGHT)

of_resize()
end event

type rb_2 from radiobutton within w_piss460u_test
integer x = 2162
integer y = 132
integer width = 416
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "취소SR확정"
end type

event clicked;rb_1.checked = false
rb_3.checked = false

dw_sheet.dataobject = 'd_piss420u_01'
//dw_print.dataobject = 'd_piss420u_02'
dw_2.dataobject = 'd_piss420u_03'
dw_sheet.settransobject(sqlpis)
//dw_print.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_sheet.reset()
dw_2.reset()
//dw_print.reset()
dw_2.visible = false
il_resize_count ++

of_resize_register(dw_sheet, full)

of_resize()
end event

type rb_3 from radiobutton within w_piss460u_test
integer x = 2606
integer y = 132
integer width = 352
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "확정취소"
end type

event clicked;rb_1.checked = false
rb_2.checked = false
dw_sheet.dataobject = 'd_piss420u_01'
//dw_print.dataobject = 'd_piss420u_02'
dw_2.dataobject = 'd_piss420u_03'
dw_sheet.settransobject(sqlpis)
//dw_print.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_sheet.reset() 
dw_2.reset()
//dw_print.reset()
dw_2.visible = false
il_resize_count ++

of_resize_register(dw_sheet, full)
//of_resize_register(st_v_bar, SPLIT)
//of_resize_register(dw_2, RIGHT)

of_resize()
end event

type gb_2 from groupbox within w_piss460u_test
integer x = 1669
integer y = 72
integer width = 379
integer height = 168
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "정규SR"
end type

type gb_3 from groupbox within w_piss460u_test
integer x = 2135
integer y = 72
integer width = 855
integer height = 168
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "취소SR"
end type

type gb_1 from groupbox within w_piss460u_test
integer x = 23
integer y = 28
integer width = 4421
integer height = 232
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회조건"
end type

type sle_custcode from singlelineedit within w_piss460u_test
integer x = 1312
integer y = 132
integer width = 238
integer height = 80
integer taborder = 180
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

