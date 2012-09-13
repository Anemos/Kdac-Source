$PBExportHeader$w_bpm102u.srw
$PBExportComments$부대비율관리
forward
global type w_bpm102u from w_origin_sheet01
end type
type tab_1 from tab within w_bpm102u
end type
type tabpage_1 from userobject within tab_1
end type
type pb_3 from picturebutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type dw_10 from datawindow within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type dw_11 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
pb_3 pb_3
cb_1 cb_1
cb_3 cb_3
st_3 st_3
dw_10 dw_10
cb_2 cb_2
dw_11 dw_11
end type
type tabpage_2 from userobject within tab_1
end type
type pb_1 from picturebutton within tabpage_2
end type
type dw_21 from datawindow within tabpage_2
end type
type dw_20 from datawindow within tabpage_2
end type
type pb_2 from picturebutton within tabpage_2
end type
type tabpage_2 from userobject within tab_1
pb_1 pb_1
dw_21 dw_21
dw_20 dw_20
pb_2 pb_2
end type
type tab_1 from tab within w_bpm102u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_bpm102u from w_origin_sheet01
string title = "기 본 정 보 유 지 관 리"
event ue_open_after ( )
tab_1 tab_1
end type
global w_bpm102u w_bpm102u

type variables
string is_xplant, is_div, is_orgsql,is_orgsql1
String is_action, is_col_nm
long   il_LastClickedRow
int    i_n_tab_index
Boolean ib_Insert = False

datawindow  idw_10, idw_11, idw_12, idw_20, idw_21, idw_22
// DataWindow 선언...
datawindowchild idwc_1
// Window 선언...
Window	iw_Sheet


end variables

event ue_open_after();String ls_div 
iw_Sheet = w_frame.GetActiveSheet( )

//f_AutDiv_Set( idw_20 )
//f_Autmlan_set( idw_22 )
////comm121의 지역/공장 가져오기
//f_pur_getxplantdiv(is_xplant,is_div)
//
//idw_20.object.xplant[1] = is_xplant
//idw_20.object.div[1] = is_div
//
//
////ls_div = idw_20.GetItemString(1,'div')
//ls_div = trim(idw_20.object.div[1])
//
//idw_20.GetChild('pdcd', idwc_1)
//idwc_1.SetTransObject(Sqlca)
//idwc_1.Retrieve(ls_Div)


string ls_xyear
select coalesce(max(xyear || revno),'')
into :ls_xyear
from pbbpm.bpm519;

idw_10.object.xyear[1] = mid(ls_xyear,1,4)
idw_10.object.revno[1] = mid(ls_xyear,5,2)

idw_20.object.xyear[1] = mid(ls_xyear,1,4)
idw_20.object.revno[1] = mid(ls_xyear,5,2)
end event

on w_bpm102u.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_bpm102u.destroy
call super::destroy
destroy(this.tab_1)
end on

event ue_retrieve;string ls_xyear, ls_revno, ls_itno, ls_itnm, ls_spec, ls_gubun, ls_xplant, ls_div, ls_pdcd, ls_cls, ls_srce, ls_itno2
int    ll_row, ll_rcnt

uo_status.st_message.text	=	"조회중입니다."
setpointer(HourGlass!)


choose case i_n_tab_index
	case 1   //부대비율관리
			  
		if idw_10.accepttext() = -1 then
			messagebox('확인','조회조건중 데이타 오류난 자료있습니다.')
			uo_status.st_message.text	=	'조회조건중 데이타 오류난 자료있습니다.'
			return
		end if
		
		ls_xyear = trim(idw_10.object.xyear[1])
		ls_revno = trim(idw_10.object.revno[1])
		if trim(ls_xyear) = '' or isnumber(ls_xyear) = false then
			messagebox('확인','사업계획 년도를 확인하세요.')
			uo_status.st_message.text	=	'사업계획 년도를 확인하세요.'
			return
		end if
		if trim(ls_revno) = '' then
			messagebox('확인','사업계획 년도/버전을 확인하세요.')
			uo_status.st_message.text	=	'사업계획 년도/버전을 확인하세요.'
			return
		end if
		
		uo_status.st_message.text	= '조회중입니다...'   
		idw_11.reset() 
		if idw_11.retrieve(ls_xyear,ls_revno, 'A') > 0 then
			uo_status.st_message.text	=	f_message("I010")		// 조회되었습니다.
			wf_icon_onoff(true,false,true,false,false,false,true) //I,A,U,D,P
		else
			uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
			wf_icon_onoff(true,false,false,false,false,false,true) //I,A,U,D,P
		end if
			
	case 2	//결제조건별 부대비율관리
			  
		if idw_20.accepttext() = -1 then
			messagebox('확인','조회조건중 데이타 오류난 자료있습니다.')
			uo_status.st_message.text	=	'조회조건중 데이타 오류난 자료있습니다.'
			return
		end if
		
		ls_xyear = trim(idw_20.object.xyear[1])
		ls_revno = trim(idw_20.object.revno[1])
		if trim(ls_xyear) = '' or isnumber(ls_xyear) = false then
			messagebox('확인','사업계획 년도를 확인하세요.')
			uo_status.st_message.text	=	'사업계획 년도를 확인하세요.'
			return
		end if
		if trim(ls_revno) = '' then
			messagebox('확인','사업계획 년도/버전을 확인하세요.')
			uo_status.st_message.text	=	'사업계획 년도/버전을 확인하세요.'
			return
		end if
		
		uo_status.st_message.text	= '조회중입니다...'   
		idw_21.reset() 
		if idw_21.retrieve(ls_xyear, ls_revno, 'B') > 0 then
			uo_status.st_message.text	=	f_message("I010")		// 조회되었습니다.
			wf_icon_onoff(true,false,true,false,false,false,true) //I,A,U,D,P
		else
			uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
			wf_icon_onoff(true,false,false,false,false,false,true) //I,A,U,D,P
		end if
		
end choose

setpointer(arrow!)
end event

event ue_save;string ls_xyear, ls_revno, ls_msg
integer li_rtncnt, li_rtn, Net
//INTERFACE
Int li_index, rtn, ll_insert
long ll_rcnt, ll_row
dec ld_dper, ld_eper
//String ls_message, ls_areadivision[]
//str_ipis_server lstr_ipis[]
string  ls_xplant, ls_div, ls_fob
Choose case i_n_tab_index
		
		case 1
			IF idw_10.accepttext() = -1 THEN
				messagebox('확인','조회조건 항목중 에러난곳 수정후 저장하세요!')
				uo_status.st_message.text	= '조회조건 항목중 에러난곳 수정후 저장하세요!'
				Return
			END IF
			ls_xyear = trim(idw_10.object.xyear[1])
			ls_revno = trim(idw_10.object.revno[1])
			IF idw_11.accepttext() = -1 THEN
				messagebox('확인','입력항목중 에러난곳 수정후 저장하세요!',Exclamation!)
				uo_status.st_message.text	= '입력항목중 에러난곳 수정후 저장하세요!'
				Return
			END IF
			IF f_bpmstcd_chk('110',ls_xyear,ls_revno, ls_msg) = -1  THEN   //tab별 진행상태확인
			   messagebox('확인',ls_msg)
				uo_status.st_message.text	= ls_msg
				Return
			END IF
						
			uo_status.st_message.text	= '자료 확인중...'
			IF idw_11.ModifiedCount() < 1 THEN
			   messagebox('확인','변경된 내역이 없습니다!')
				uo_status.st_message.text = '변경된 내역이 없습니다!'
				RETURN
			END IF
			
			f_null_chk(idw_11)                                    
			if f_mandantory_chk(idw_11) = -1 then return    
			if idw_11.rowcount() = 0 then
				return
			end if
						
			for ll_row = idw_11.rowcount() to 1 step -1
				 if ls_xyear <> trim(idw_11.object.xyear[ll_row]) &
				 or ls_revno <> trim(idw_11.object.revno[ll_row]) then	
					 MessageBox("확인",'행:' + string(ll_row) +  '번 사업계획년도/버전 확인하세요!')
				    uo_status.st_message.Text = '행:' + string(ll_row) +  '번 사업계획년도/버전 확인하세요!'
					 return
				end if
				ls_xplant = trim(idw_11.object.xplant[ll_row])
				ls_div = trim(idw_11.object.div[ll_row])
				ld_dper = idw_11.object.dper[ll_row]
				ld_eper = idw_11.object.eper[ll_row]
				select count(*) 
				  into :ll_rcnt
				from pbbpm.bpm507
				where  xyear = :ls_xyear
				and    revno = :ls_revno
				and    gubun = 'A'
				and    xplant = :ls_xplant
				and    div    = :ls_div;
				if ll_rcnt = 0 then
					insert into pbbpm.bpm507
								( XYEAR,         revno,             gubun,            XPLANT,            DIV,               DPER,   
								EPER,            EXTD,              INPTID,           INPTDT,   
								UPDTID,          UPDTDT,            IPADDR,           MACADDR  )
					values   (:ls_xyear,      :ls_revno,         'A',            :ls_xplant,        :ls_div,       :ld_dper, 
								:ld_eper,             '',           :g_s_empno,       :g_s_date,
								'',            :g_s_datetime,      :g_s_ipaddr,      :g_s_macaddr )
					;
					if sqlca.sqlcode <> 0 then
						MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율(BPM507) 자료 생성중 오류발생! 급히 연락바랍니다.')
						uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율(BPM507) 자료 생성중 오류발생! 급히 연락바랍니다.'
						messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
						rollback using sqlca;
						sqlca.autocommit = true
						Return
					end if
				else
					update pbbpm.bpm507
					   set dper = :ld_dper,
						    eper = :ld_eper,
							 updtid = :g_s_empno,
							 updtdt = :g_s_datetime,
							 ipaddr = :g_s_ipaddr,
							 macaddr = :g_s_macaddr
					where  xyear = :ls_xyear
					and    revno = :ls_revno
					and    gubun = 'A'
					and    xplant = :ls_xplant
					and    div    = :ls_div; 
				end if
			next
			uo_status.st_message.Text = '저장완료.'
			wf_icon_onoff(true,false,true,false,false,false,true) //I,A,U,D,P

//			f_inptid(idw_11)       // 등록자,등록일,수정자,수정일,ip,mac address
//			if idw_11.update(true,false) = 1 then
//				commit using sqlca;
//				This.TriggerEvent('ue_retrieve')
//				uo_status.st_message.text = f_message("U010")    //저장이 되었습니다.
//			else 
//				uo_status.st_message.text = f_message("U020")   
//				rollback using sqlca;
//			end if
////결제조건별 부대비율					
		case 2
			IF idw_20.accepttext() = -1 THEN
				messagebox('확인','조회조건 항목중 에러난곳 수정후 저장하세요!')
				uo_status.st_message.text	= '조회조건 항목중 에러난곳 수정후 저장하세요!'
				Return
			END IF
			ls_xyear = trim(idw_20.object.xyear[1])
			ls_revno = trim(idw_20.object.revno[1])
			IF idw_21.accepttext() = -1 THEN
				messagebox('확인','입력항목중 에러난곳 수정후 저장하세요!',Exclamation!)
				uo_status.st_message.text	= '입력항목중 에러난곳 수정후 저장하세요!'
				Return
			END IF
			IF f_bpmstcd_chk('110',ls_xyear,ls_revno, ls_msg) = -1  THEN   //tab별 진행상태확인
			   messagebox('확인',ls_msg)
				uo_status.st_message.text	= ls_msg
				Return
			END IF
						
			uo_status.st_message.text	= '자료 확인중...'
			IF idw_21.ModifiedCount() < 1 THEN
			   messagebox('확인','변경된 내역이 없습니다!')
				uo_status.st_message.text = '변경된 내역이 없습니다!'
				RETURN
			END IF
			
			f_null_chk(idw_21)                                    
//			if f_mandantory_chk(idw_21) = -1 then return    
         for ll_row = idw_21.rowcount() to 1 step -1
				 if ls_xyear <> trim(idw_21.object.xyear[ll_row]) &
				 or ls_revno <> trim(idw_21.object.revno[ll_row]) then	
					 MessageBox("확인",'행:' + string(ll_row) +  '번 사업계획년도/버전 확인하세요!')
				    uo_status.st_message.Text = '행:' + string(ll_row) +  '번 사업계획년도/버전 확인하세요!'
					 return
				end if
				ls_fob = trim(idw_21.object.extd[ll_row])
				ls_xplant = trim(idw_21.object.xplant[ll_row])
				//ls_div = trim(idw_21.object.div[ll_row])
				ld_dper = idw_21.object.dper[ll_row]
				ld_eper = idw_21.object.eper[ll_row]
				select count(*) 
				  into :ll_rcnt
				from pbbpm.bpm507
				where  xyear = :ls_xyear
				and    revno = :ls_revno
				and    gubun = 'B'
				and    xplant = :ls_xplant
				and    div    = '';
				if ll_rcnt = 0 then
					insert into pbbpm.bpm507
								( XYEAR,         revno,             gubun,            XPLANT,            DIV,               DPER,   
								EPER,            EXTD,              INPTID,           INPTDT,   
								UPDTID,          UPDTDT,            IPADDR,           MACADDR  )
					values   (:ls_xyear,      :ls_revno,           'B',            :ls_xplant,        '',       :ld_dper, 
								:ld_eper,         :ls_fob,           :g_s_empno,       :g_s_date,
								'',            :g_s_datetime,      :g_s_ipaddr,      :g_s_macaddr )
					;
					if sqlca.sqlcode <> 0 then
						MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율(BPM507) 자료 생성중 오류발생! 급히 연락바랍니다.')
						uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율(BPM507) 자료 생성중 오류발생! 급히 연락바랍니다.'
						messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
						rollback using sqlca;
						sqlca.autocommit = true
						Return
					end if
				else
					update pbbpm.bpm507
					   set dper = :ld_dper,
						    eper = :ld_eper,
							 extd = :ls_fob, 
							 updtid = :g_s_empno,
							 updtdt = :g_s_datetime,
							 ipaddr = :g_s_ipaddr,
							 macaddr = :g_s_macaddr
					where  xyear = :ls_xyear
					and    revno = :ls_revno
					and    gubun = 'B'
					and    xplant = :ls_xplant
					and    div    = ''; 
				end if
			next
			uo_status.st_message.Text = '저장완료.'
			wf_icon_onoff(true,false,true,false,false,false,true) //I,A,U,D,P
//		   f_inptid(idw_21)       // 등록자,등록일,수정자,수정일,ip,mac address
//			if idw_21.update(true,false) = 1 then
//				commit using sqlca;
//				This.TriggerEvent('ue_retrieve')
//				uo_status.st_message.text = f_message("U010")    //저장이 되었습니다.
//			else 
//				uo_status.st_message.text = f_message("U020")   
//				rollback using sqlca;
//			end if
end choose

COMMIT USING SQLCA;       
return
SetPointer(Arrow!)


end event

event ue_insert;call super::ue_insert;//int    l_n_row, net
//string ls_xyear, ls_xplant,ls_div
//
//choose case i_n_tab_index
////		 case 1
////			IF wf_stcd_chk(1) = -1  THEN   //tab별 진행상태확인
////				Return
////			END IF
////			
////
////         ls_xyear = trim(idw_10.object.xyear[1])
////			idw_12.reset()
////			idw_12.insertrow(0)
////			idw_12.object.xyear[1] = ls_xyear
////			
////			idw_12.SetItemStatus(1, 0, Primary!, NotModified!)
////			  
////			
////			f_Color_Protect( idw_12 )
////			
////  		   idw_12.setcolumn('itno')
////			idw_12.setfocus( ) 
////			wf_icon_onoff(true,true,true,true,false,false,false)
////			uo_status.st_message.text = f_message('A070')  // 해당정보를 입력하십시오
//		 
//		case 2
//			IF wf_stcd_chk(2) = -1  THEN   //tab별 진행상태확인
//				Return
//			END IF
//			idw_20.accepttext()
//			idw_20.setitemstatus(1,0,primary!,datamodified!)
// 			if f_mandantory_chk(idw_20) = -1  then              // 필수입력 항목 Editing
//				return
//			end if
//         ls_xyear = trim(idw_20.object.xyear[1])						
//			ls_xplant = trim(idw_20.object.xplant[1])
//			ls_div = trim(idw_20.object.div[1])						
//
//			idw_22.insertrow(0)
//			idw_22.object.xyear[1] = ls_xyear
//			////// 제품 선택 
//			idw_22.getchild("pdcd",idwc_1)      
//			idwc_1.SetTransObject(sqlca)	
//			idwc_1.retrieve(ls_xplant,ls_div)
//			idw_22.setfocus() 
//  		   idw_22.setcolumn("itno")
//			wf_icon_onoff(true,true,true,true,false,false,false)
//			uo_status.st_message.text = f_message('A070')  // 해당정보를 입력하십시오
//
//end choose
//
end event

event open;call super::open;This.Event Post ue_open_after()

end event

event ue_dprint;call super::ue_dprint;f_screen_print(This)
end event

type uo_status from w_origin_sheet01`uo_status within w_bpm102u
integer y = 2492
integer width = 4617
integer height = 88
integer taborder = 20
end type

type tab_1 from tab within w_bpm102u
integer x = 5
integer y = 36
integer width = 4599
integer height = 2448
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
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;i_n_tab_index = newindex

Choose Case newindex
			
	case 1
		if idw_11.rowcount() > 0 then
         wf_icon_onoff(true,false,true,false,false,false,true) //I,A,U,D,P    
		else
			wf_icon_onoff(true,false,false,false,false,false,true) //I,A,U,D,P
		end if
	case 2	
		if idw_21.rowcount() > 0 then
          wf_icon_onoff(true,false,true,false,false,false,true) //I,A,U,D,P
		else
			wf_icon_onoff(true,false,false,false,false,false,true) //I,A,U,D,P
		end if
				
End Choose


end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4562
integer height = 2332
long backcolor = 12632256
string text = "부대비율관리"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
pb_3 pb_3
cb_1 cb_1
cb_3 cb_3
st_3 st_3
dw_10 dw_10
cb_2 cb_2
dw_11 dw_11
end type

on tabpage_1.create
this.pb_3=create pb_3
this.cb_1=create cb_1
this.cb_3=create cb_3
this.st_3=create st_3
this.dw_10=create dw_10
this.cb_2=create cb_2
this.dw_11=create dw_11
this.Control[]={this.pb_3,&
this.cb_1,&
this.cb_3,&
this.st_3,&
this.dw_10,&
this.cb_2,&
this.dw_11}
end on

on tabpage_1.destroy
destroy(this.pb_3)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.st_3)
destroy(this.dw_10)
destroy(this.cb_2)
destroy(this.dw_11)
end on

type pb_3 from picturebutton within tabpage_1
integer x = 4009
integer y = 44
integer width = 155
integer height = 132
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;string ls_xyear, ls_xyear_chk
If idw_10.AcceptText( ) = -1 Then
	MessageBox("확인", "에러가 난곳을 수정한 후 저장하십시요.")
	uo_status.st_message.Text = "에러가 난곳을 수정한 후 저장하십시요."
	Return
End If

//idw_10.SetItemStatus(1, 0, Primary!, DataModified!)
//If f_mandantory_chk( idw_10 ) = -1 Then  // 필수입력항목 check
//	Return
//End If
ls_xyear = trim(idw_10.object.xyear[1])
idw_11.reset()
f_pur040_GetExcel( idw_11 )
if idw_11.rowcount() = 0 then
	return
end if
//long  ll_row, ll_rcnt
//string  ls_xplant, ls_div
//for ll_row = idw_11.rowcount() to 1 step -1
//	 if ls_xyear <> trim(idw_11.object.xyear[ll_row]) then
//		 MessageBox("확인",'행:' + string(ll_row) +  '번 사업계획년도 확인하세요!')
//	    uo_status.st_message.Text = '행:' + string(ll_row) +  '번 사업계획년도 확인하세요!'
//		 return
//	end if
//	ls_xplant = trim(idw_11.object.xplant[ll_row])
//	ls_div = trim(idw_11.object.div[ll_row])
//	select count(*) 
//	  into :ll_rcnt
//	from pbbpm.bpm507
//	where  xyear = :ls_xyear
//	and    gubun = 'A'
//	and    xplant = :ls_xplant
//	and    div    = :ls_div;
//	if ll_rcnt = 0 then
//		MessageBox('참고','행:' + string(ll_row) +  '번 ' + ls_xplant + ls_div + ' 사업계획대상 지역/공장이 아닙니다!')
//	   uo_status.st_message.Text = '참고:' + string(ll_row) +  '번 ' + ls_xplant + ls_div + ' 사업계획대상 지역/공장이 아닙니다!'
//		//return
//	else
//		idw_11.SetItemStatus(ll_row,0,Primary!,Datamodified!)
//		idw_11.SetItemStatus(ll_row,0,Primary!,Datamodified!)
//	end if
//next
uo_status.st_message.Text = '확인후 저장하세요.'
wf_icon_onoff(true,false,true,false,false,false,true) //I,A,U,D,P
	


		
	

end event

type cb_1 from commandbutton within tabpage_1
integer x = 3607
integer y = 56
integer width = 361
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "확정취소"
end type

event clicked;SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_xyear, ls_revno, ls_itnm
Long     ll_row, ll_rcnt
Integer  li_rtn, li_ok

////부서코드확인
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('확인','작업에 대한 권한이 없습니다!')
	uo_status.st_message.text = '작업에 대한 권한이 없습니다!'
	Return
END IF


IF dw_10.accepttext() = -1  THEN
	MessageBox('확인','조회조건자료에 오류발생! 확인하세요!')
	uo_status.st_message.text = '조회조건자료에 오류발생! 확인하세요!'
	Return
END IF

ls_xyear = trim(dw_10.object.xyear[1])
ls_revno = trim(dw_10.object.revno[1])

select coalesce(max(ingflag),''),coalesce(max(taskstatus),'') 
		into :ls_stcd, :ls_stcd1
	from pbbpm.bpm519
	where comltd = '01'
	and   xyear = :ls_xyear
	and   revno = :ls_revno
	and   seqno = '110';  //전체상태는 아무자료나 가져와도 됨.
	
IF ls_stcd <> 'G'  THEN
	MessageBox('작업불가',ls_xyear + '년 REV:' + ls_revno + '번 사업계획전체 작업이 종료되었습니다!')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획전체 작업이 종료되었습니다!'
	Return -1
END IF
IF ls_stcd1 <> 'C'  THEN
	MessageBox('작업불가',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 해당작업이 진행중입니다!')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 해당작업이 진행중입니다!'
	Return -1
END IF


li_ok = MessageBox('확인','확정취소합니다! 확인키를 누르세요!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '작업이 취소되었습니다.'
	Return
END IF					 


update pbbpm.bpm519
   set taskstatus = 'G'
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '110';

if sqlca.sqlcode <> 0 then
	MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율상태(BPM519) 자료 확정중 오류발생! 급히 연락바랍니다.')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율상태(BPM519) 자료 확정중 오류발생! 급히 연락바랍니다.'
	messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if

uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율 확정완료.'
SetPointer(arrow!)
return

end event

type cb_3 from commandbutton within tabpage_1
integer x = 3209
integer y = 60
integer width = 361
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "자료확정"
end type

event clicked;SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_xyear, ls_revno, ls_msg
Long     ll_row, ll_rcnt
Integer  li_rtn, li_ok

////부서코드확인
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('확인','작업에 대한 권한이 없습니다!')
	uo_status.st_message.text = '작업에 대한 권한이 없습니다!'
	Return
END IF


IF dw_10.accepttext() = -1  THEN
	MessageBox('확인','조회조건자료에 오류발생! 확인하세요!')
	uo_status.st_message.text = '조회조건자료에 오류발생! 확인하세요!'
	Return
END IF

ls_xyear = trim(dw_10.object.xyear[1])
ls_revno = trim(dw_10.object.revno[1])

IF f_bpmstcd_chk('110',ls_xyear,ls_revno, ls_msg) = -1  THEN  //상태확인
   MessageBox('확인',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

select count(*)
   into :ll_rcnt
from pbbpm.bpm507
where xyear = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('확인','확정할 자료가 없습니다! 확인하세요!')
	uo_status.st_message.text = '확정할 자료가 없습니다! 확인하세요!'
	Return
end if


li_ok = MessageBox('확인','확정합니다! 확인키를 누르세요!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '작업이 취소되었습니다.'
	Return
END IF					 


update pbbpm.bpm519
   set taskstatus = 'C'
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '110';

if sqlca.sqlcode <> 0 then
	MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율상태(BPM519) 자료 확정중 오류발생! 급히 연락바랍니다.')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율상태(BPM519) 자료 확정중 오류발생! 급히 연락바랍니다.'
	messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if

uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율 확정완료.'
SetPointer(arrow!)
return

end event

type st_3 from statictext within tabpage_1
boolean visible = false
integer x = 1897
integer y = 80
integer width = 1298
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "(입력전에 기초자료 생성을 먼저하세요)"
boolean focusrectangle = false
end type

type dw_10 from datawindow within tabpage_1
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 36
integer width = 978
integer height = 156
integer taborder = 20
string title = "none"
string dataobject = "d_bpm101u_10"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;If key = KeyEnter! Then
	iw_sheet.TriggerEvent('ue_retrieve')
End If
end event

event constructor;idw_10 = this
this.settransobject(sqlca)

//This.GetChild('div', idwc_1)
//idwc_1.SetTransObject(SQLCA)
//idwc_1.Retrieve('D')
This.InsertRow(0)
f_pur040_nullchk03(this)

//오픈에서 처리




end event

event itemerror;return 1
end event

event getfocus;f_pur040_toggle(handle(this),'ENG')
end event

type cb_2 from commandbutton within tabpage_1
boolean visible = false
integer x = 997
integer y = 72
integer width = 869
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "기초자료(지역/공장)생성"
end type

event clicked;SetPointer(hourglass!)

String   ls_stcd, ls_stcd1, ls_xyear, ls_revno, ls_itnm, ls_msg
Long     ll_row, ll_rcnt
Integer  li_rtn, li_ok

////부서코드확인
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('확인','생성작업에 대한 권한이 없습니다!')
	uo_status.st_message.text = '생성작업에 대한 권한이 없습니다!'
	Return
END IF

IF idw_10.accepttext() = -1  THEN
	MessageBox('확인','조회조건자료에 오류발생! 확인하세요!')
	uo_status.st_message.text = '조회조건자료에 오류발생! 확인하세요!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])

if f_bpmstcd_chk('110',ls_xyear,ls_revno, ls_msg) = -1 then
	MessageBox('확인',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

select count(*)
   into :ll_rcnt
from pbbpm.bpm507
where xyear = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt > 0  THEN
	li_ok = MessageBox('확인','기존자료가 있습니다. 반드시 확인하세요! 재생성작업을 시작하려면 확인키를 누르세요!', &
						 Exclamation!, OKCancel!, 2)
	IF li_ok <> 1 THEN
		uo_status.st_message.text = '재생성작업이 취소되었습니다.'
		Return
	END IF					 
else
	li_ok = MessageBox('확인','생성작업을 시작합니다! 확인키를 누르세요!', &
						 Exclamation!, OKCancel!, 2)
	IF li_ok <> 1 THEN
		uo_status.st_message.text = '생성작업이 취소되었습니다.'
		Return
	END IF					 
END IF

uo_status.st_message.text = ls_xyear + '년 사업계획 해당자료 생성중...'
sqlca.autocommit = false

if ll_rcnt > 0 then
	delete from pbbpm.bpm507
	where xyear = :ls_xyear
	and   revno = :ls_revno;
	if sqlca.sqlcode <> 0 then
		MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율(BPM507) 기존자료 삭제중 오류발생! 급히 연락바랍니다.')
		uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율(BPM507) 기존자료 삭제중 오류발생! 급히 연락바랍니다.'
		messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
		rollback using sqlca;
		sqlca.autocommit = true
		Return
	end if
end if

insert into pbbpm.bpm507
         ( XYEAR,         revno,             gubun,            XPLANT,            DIV,               DPER,   
         EPER,            EXTD,              INPTID,           INPTDT,   
         UPDTID,          UPDTDT,            IPADDR,           MACADDR  )
SELECT  :ls_xyear,        :ls_revno,          'A',          substr(x.xdiv,1,1),    substr(x.xdiv,2,1),     0, 
         0,             '',                 :g_s_empno,       :g_s_date,
         '',            :g_s_datetime,      :g_s_ipaddr,      :g_s_macaddr 
from (select distinct xplant || div as xdiv
      FROM PBinv.inv101 
      where comltd = '01'
      and   cls in ('10','20','24','30','50')) x
;
if sqlca.sqlcode <> 0 then
	MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율(BPM507) 자료 생성중 오류발생! 급히 연락바랍니다.')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율(BPM507) 자료 생성중 오류발생! 급히 연락바랍니다.'
	messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if
////매출계획기준 지역/공장 추가
insert into pbbpm.bpm507
       ( XYEAR,          revno,              gubun,               XPLANT,            DIV,                DPER,   
         EPER,            EXTD,              INPTID,           INPTDT,   
         UPDTID,          UPDTDT,            IPADDR,           MACADDR  )
SELECT  :ls_xyear,       :ls_revno,           'A',          substr(x.xdiv,1,1),    substr(x.xdiv,2,1),     0, 
         0,             '',                 :g_s_empno,       :g_s_date,
         '',            :g_s_datetime,      :g_s_ipaddr,      :g_s_macaddr 
from (select distinct xplant || div as xdiv
      FROM PBsle.sle201 
      where comltd = '01'
		and   gubun = 'A'
		and   cym =  :ls_xyear || :ls_revno
     ) x
where x.xdiv not in (select xplant || div from pbbpm.bpm507
                   where  xyear = :ls_xyear
						 and    revno = :ls_revno )
;
if sqlca.sqlcode <> 0 then
	MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율(BPM507) 자료 생성중 오류발생! 급히 연락바랍니다.')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율(BPM507) 자료 생성중 오류발생! 급히 연락바랍니다.'
	messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if

insert into pbbpm.bpm507
         ( XYEAR,         revno,             gubun,            XPLANT,            DIV,               DPER,   
         EPER,            EXTD,              INPTID,           INPTDT,   
         UPDTID,          UPDTDT,            IPADDR,           MACADDR  )
SELECT  :ls_xyear,        :ls_revno,          'B',                cocode,               '',     0, 
         0,              trim(coitname),    :g_s_empno,       :g_s_date,
         '',            :g_s_datetime,      :g_s_ipaddr,      :g_s_macaddr 
FROM PBcommon.dac002 
where comltd = '01'
and   cogubun = 'BPM050';
if sqlca.sqlcode <> 0 then
	MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율(BPM507) 자료 생성중 오류발생! 급히 연락바랍니다.')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율(BPM507) 자료 생성중 오류발생! 급히 연락바랍니다.'
	messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if

sqlca.autocommit = true

select count(*)
   into :ll_rcnt
from pbbpm.bpm507
where xyear = :ls_xyear
and   revno = :ls_revno;

uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 부대비율 기초자료 생성완료. ' + string(ll_rcnt) + '개.' 
SetPointer(arrow!)
return

end event

type dw_11 from datawindow within tabpage_1
integer y = 216
integer width = 4544
integer height = 2104
integer taborder = 90
string title = "none"
string dataobject = "d_bpm102u_11"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;// column별 sorting
THIS.SetRedraw(False)
IF row < 1 THEN
   IF f_getobjectpoint_head(THIS,is_col_nm) = 1 THEN
   	f_dw_sort(THIS,is_col_nm)
   END IF
END IF
THIS.SetRedraw(True) 

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
end if	





end event

event constructor;idw_11 = this
this.settransobject(sqlca)

//// BOM 단위 선택
//This.getchild("xunit",i_dwc_unit) 
//i_dwc_unit.SetTransObject(sqlca)	
//i_dwc_unit.retrieve('DAC070')
//
//// ITEM TYPE 선택
//This.getchild("xtype",i_dwc_type) 
//i_dwc_type.SetTransObject(sqlca)	
//i_dwc_type.retrieve('INV220')

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4562
integer height = 2332
long backcolor = 12632256
string text = "외자결제조건별부대비율"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
pb_1 pb_1
dw_21 dw_21
dw_20 dw_20
pb_2 pb_2
end type

on tabpage_2.create
this.pb_1=create pb_1
this.dw_21=create dw_21
this.dw_20=create dw_20
this.pb_2=create pb_2
this.Control[]={this.pb_1,&
this.dw_21,&
this.dw_20,&
this.pb_2}
end on

on tabpage_2.destroy
destroy(this.pb_1)
destroy(this.dw_21)
destroy(this.dw_20)
destroy(this.pb_2)
end on

type pb_1 from picturebutton within tabpage_2
integer x = 1079
integer y = 44
integer width = 155
integer height = 132
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;string ls_xyear, ls_xyear_chk
If idw_20.AcceptText( ) = -1 Then
	MessageBox("확인", "에러가 난곳을 수정한 후 저장하십시요.")
	uo_status.st_message.Text = "에러가 난곳을 수정한 후 저장하십시요."
	Return
End If

//idw_10.SetItemStatus(1, 0, Primary!, DataModified!)
//If f_mandantory_chk( idw_10 ) = -1 Then  // 필수입력항목 check
//	Return
//End If
ls_xyear = trim(idw_20.object.xyear[1])
idw_21.reset()
f_pur040_GetExcel( idw_21 )
if idw_21.rowcount() = 0 then
	return
end if
//long  ll_row, ll_rcnt
//string  ls_xplant, ls_div
//for ll_row = idw_11.rowcount() to 1 step -1
//	 if ls_xyear <> trim(idw_11.object.xyear[ll_row]) then
//		 MessageBox("확인",'행:' + string(ll_row) +  '번 사업계획년도 확인하세요!')
//	    uo_status.st_message.Text = '행:' + string(ll_row) +  '번 사업계획년도 확인하세요!'
//		 return
//	end if
//	ls_xplant = trim(idw_11.object.xplant[ll_row])
//	ls_div = trim(idw_11.object.div[ll_row])
//	select count(*) 
//	  into :ll_rcnt
//	from pbbpm.bpm507
//	where  xyear = :ls_xyear
//	and    gubun = 'A'
//	and    xplant = :ls_xplant
//	and    div    = :ls_div;
//	if ll_rcnt = 0 then
//		MessageBox('참고','행:' + string(ll_row) +  '번 ' + ls_xplant + ls_div + ' 사업계획대상 지역/공장이 아닙니다!')
//	   uo_status.st_message.Text = '참고:' + string(ll_row) +  '번 ' + ls_xplant + ls_div + ' 사업계획대상 지역/공장이 아닙니다!'
//		//return
//	else
//		idw_11.SetItemStatus(ll_row,0,Primary!,Datamodified!)
//		idw_11.SetItemStatus(ll_row,0,Primary!,Datamodified!)
//	end if
//next
uo_status.st_message.Text = '확인후 저장하세요.'
wf_icon_onoff(true,false,true,false,false,false,true) //I,A,U,D,P
	


		
	

end event

type dw_21 from datawindow within tabpage_2
integer x = 18
integer y = 212
integer width = 4544
integer height = 2104
integer taborder = 100
string title = "none"
string dataobject = "d_bpm102u_21"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;// column별 sorting
THIS.SetRedraw(False)
IF row < 1 THEN
   IF f_getobjectpoint_head(THIS,is_col_nm) = 1 THEN
   	f_dw_sort(THIS,is_col_nm)
   END IF
END IF
THIS.SetRedraw(True) 

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
end if	





end event

event constructor;idw_21 = this
this.settransobject(sqlca)

//// BOM 단위 선택
//This.getchild("xunit",i_dwc_unit) 
//i_dwc_unit.SetTransObject(sqlca)	
//i_dwc_unit.retrieve('DAC070')
//
//// ITEM TYPE 선택
//This.getchild("xtype",i_dwc_type) 
//i_dwc_type.SetTransObject(sqlca)	
//i_dwc_type.retrieve('INV220')

end event

type dw_20 from datawindow within tabpage_2
event ue_dwnkey pbm_dwnkey
integer y = 44
integer width = 978
integer height = 156
integer taborder = 30
string title = "none"
string dataobject = "d_bpm101u_10"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;If key = KeyEnter! Then
	iw_sheet.TriggerEvent('ue_retrieve')
End If
end event

event constructor;idw_20 = this
this.settransobject(sqlca)

//This.GetChild('div', idwc_1)
//idwc_1.SetTransObject(SQLCA)
//idwc_1.Retrieve('D')
This.InsertRow(0)
f_pur040_nullchk03(this)




end event

event getfocus;f_pur040_toggle(handle(this),'ENG')
end event

event itemerror;return 1
end event

type pb_2 from picturebutton within tabpage_2
boolean visible = false
integer x = 4297
integer y = 16
integer width = 238
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string picturename = "C:\KDAC\bmp\search.gif"
string disabledname = "C:\KDAC\bmp\not_search.gif"
alignment htextalign = left!
end type

event clicked;
String ls_plant, ls_div, ls_itno

ls_plant = idw_20.getitemstring(1,"xplant")
ls_div	= idw_20.getitemstring(1,"div")
ls_itno  = Trim( idw_20.Object.itno[1] )

String ls_parm

If f_spacechk(ls_itno) = -1 Then
	ls_parm = ls_plant + ls_div
Else
	ls_parm = ls_plant + ls_div + ls_itno
End If

//OpenWithParm(w_itno_search_invres, ls_parm)
idw_20.Object.itno[1] = Message.StringParm
end event

