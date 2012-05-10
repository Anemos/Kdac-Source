$PBExportHeader$w_wip034u.srw
$PBExportComments$재공사용내역 체크윈도우
forward
global type w_wip034u from w_origin_sheet02
end type
type st_1 from statictext within w_wip034u
end type
type dw_1 from datawindow within w_wip034u
end type
type dw_2 from datawindow within w_wip034u
end type
type cb_1 from commandbutton within w_wip034u
end type
type uo_1 from uo_wip_plandiv within w_wip034u
end type
type pb_1 from picturebutton within w_wip034u
end type
type uo_2 from uo_ccyymm_mps within w_wip034u
end type
end forward

global type w_wip034u from w_origin_sheet02
event ue_postevent ( )
st_1 st_1
dw_1 dw_1
dw_2 dw_2
cb_1 cb_1
uo_1 uo_1
pb_1 pb_1
uo_2 uo_2
end type
global w_wip034u w_wip034u

event ue_postevent();uo_2.uf_reset(integer(mid(g_s_date,1,4)),integer(mid(g_s_date,5,2)))
end event

on w_wip034u.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.uo_1=create uo_1
this.pb_1=create pb_1
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.uo_2
end on

on w_wip034u.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.uo_1)
destroy(this.pb_1)
destroy(this.uo_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)

This.triggerevent('ue_postevent')
end event

event ue_retrieve;call super::ue_retrieve;string ls_date, ls_plant, ls_dvsn, ls_mysql
long ll_rowcnt

setpointer(hourglass!)
ls_plant = trim(uo_1.dw_1.getitemstring(1,'xplant'))
ls_dvsn  = trim(uo_1.dw_1.getitemstring(1,'div'))
ls_date = string(uo_2.uf_yyyymm())

if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
	return 0
end if

 DECLARE up_wip_05 PROCEDURE FOR PBWIP.SP_WIP_05  
         A_COMLTD = :g_s_company,   
         A_PLANT = :ls_plant,   
         A_DVSN = :ls_dvsn,   
         A_DATE = :ls_date  using sqlca;

 execute up_wip_05;

// Test return code. Allow for +100 since you
// do not expect a result set.
if SQLCA.sqlcode = -1 then
	// Issue an error message since it failed.
	MessageBox("Stored Procedure Error!",SQLCA.sqlerrtext)
else
	//MessageBox("Stored Procedure check",string(SQLCA.sqlcode))
end if

ll_rowcnt = dw_1.retrieve()

ls_mysql = " DROP TABLE QTEMP.WIPTEMP02"
Execute Immediate :ls_mysql ;
ls_mysql = " DROP TABLE QTEMP.BOMTEMP01"
Execute Immediate :ls_mysql ;

Close up_wip_05;

if ll_rowcnt > 1 then
	uo_status.st_message.text = "검색되었습니다."
else
	uo_status.st_message.text = "검색할 자료가 없습니다."
end if
end event

type uo_status from w_origin_sheet02`uo_status within w_wip034u
end type

type st_1 from statictext within w_wip034u
integer x = 114
integer y = 40
integer width = 389
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "적용년월:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_wip034u
integer x = 41
integer y = 164
integer width = 2944
integer height = 2304
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip034u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string ls_srty, ls_srno,ls_srno1, ls_srno2, ls_adjdate,ls_nextdt, ls_time
long ll_rtncnt
ls_srty = dw_1.getitemstring(row,"tprsrty")
	ls_srno = dw_1.getitemstring(row,"tprsrno")
	ls_srno1 = dw_1.getitemstring(row,"tprsrno1")
	ls_srno2 = dw_1.getitemstring(row,"tprsrno2")
	ls_adjdate = mid(dw_1.getitemstring(row,"tdate"),1,6)
	ls_nextdt = uf_wip_addmonth(ls_adjdate,1)
	
	
ls_time = mid(g_s_time,1,2) + mid(g_s_time,4,2) + mid(g_s_time,7,2)

//재공트랜스 삭제
		 DECLARE up_wip_12 PROCEDURE FOR PBWIP.SP_WIP_12  
         A_COMLTD = :g_s_company,   
         A_PRSRTY = :ls_srty,   
         A_PRSRNO = :ls_srno,   
         A_PRSRNO1 = :ls_srno1,   
         A_PRSRNO2 = :ls_srno2,   
         A_ADJDT = :ls_adjdate,   
         A_NEXTDT = :ls_nextdt  using sqlca;
		execute up_wip_12;
			
		select ifnull(count(*),0) into :ll_rtncnt
			from pbwip.wip004
			where wdcmcd = :g_s_company and
					wdprsrty = :ls_srty and
					wdprsrno = :ls_srno and
					wdprsrno1 = :ls_srno1 and
					wdprsrno2 = :ls_srno2 using sqlca;
		
		if ll_rtncnt > 0 then
			return 0
		end if
		ls_time = mid(g_s_time,1,2) + mid(g_s_time,4,2) + mid(g_s_time,7,2)
		//재공사용량계산
		if ls_srty = 'RP' then
			 DECLARE up_wip_11 PROCEDURE FOR PBWIP.SP_WIP_11  
					A_COMLTD = :g_s_company,   
					A_PRSRTY = :ls_srty,   
					A_PRSRNO = :ls_srno,   
					A_PRSRNO1 = :ls_srno1,   
					A_PRSRNO2 = :ls_srno2,   
					A_IPADDR = :g_s_ipaddr,   
					A_MACADDR = :g_s_macaddr,   
					A_INPTID = :g_s_empno,   
					A_INPTDT = :g_s_date,   
					A_INPTTM = :ls_time,   
					A_ADJDT = :ls_adjdate,   
					A_NEXTDT = :ls_nextdt  using sqlca;

			execute up_wip_11;
			
			select ifnull(count(*),0) into :ll_rtncnt
				from pbwip.wip004
				where wdcmcd = :g_s_company and
						wdprsrty = :ls_srty and
						wdprsrno = :ls_srno and
						wdprsrno1 = :ls_srno1 and
						wdprsrno2 = :ls_srno2 using sqlca;
		else
			 DECLARE up_wip_10 PROCEDURE FOR PBWIP.SP_WIP_10  
					A_COMLTD = :g_s_company,   
					A_PRSRTY = :ls_srty,   
					A_PRSRNO = :ls_srno,   
					A_PRSRNO1 = :ls_srno1,   
					A_PRSRNO2 = :ls_srno2,   
					A_IPADDR = :g_s_ipaddr,   
					A_MACADDR = :g_s_macaddr,   
					A_INPTID = :g_s_empno,   
					A_INPTDT = :g_s_date,   
					A_INPTTM = :ls_time,   
					A_ADJDT = :ls_adjdate,   
					A_NEXTDT = :ls_nextdt  using sqlca;
			
			execute up_wip_10;
			
			select ifnull(count(*),0) into :ll_rtncnt
				from pbwip.wip004
				where wdcmcd = :g_s_company and
						wdprsrty = :ls_srty and
						wdprsrno = :ls_srno and
						wdprsrno1 = :ls_srno1 and
						wdprsrno2 = :ls_srno2 using sqlca;
		end if
end event

event clicked;integer li_rowcnt
li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if
end event

type dw_2 from datawindow within w_wip034u
integer x = 3008
integer y = 164
integer width = 1586
integer height = 2304
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip034u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_wip034u
integer x = 2533
integer y = 40
integer width = 457
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "에러처리"
end type

event clicked;long ll_rowcnt, ll_cnt, ll_rtncnt, ll_currow
string ls_srty, ls_srno, ls_srno1, ls_srno2, ls_time, ls_adjdate, ls_nextdt

setpointer(hourglass!)
ll_rowcnt = dw_1.rowcount()
if ll_rowcnt < 1 then
	uo_status.st_message.text = "에러가 없습니다."
else
	uo_status.st_message.text = "계산중입니다..."
end if

for ll_cnt = 1 to ll_rowcnt
	if ll_cnt <> 1 then
		dw_1.selectrow(ll_cnt - 1, false)
	end if
	dw_1.selectrow(ll_cnt,true)
	
	ls_srty = dw_1.getitemstring(ll_cnt,"tprsrty")
	ls_srno = dw_1.getitemstring(ll_cnt,"tprsrno")
	ls_srno1 = dw_1.getitemstring(ll_cnt,"tprsrno1")
	ls_srno2 = dw_1.getitemstring(ll_cnt,"tprsrno2")
	ls_adjdate = mid(dw_1.getitemstring(ll_cnt,"tdate"),1,6)
	ls_nextdt = uf_wip_addmonth(ls_adjdate,1)
	
	if ls_adjdate = mid(g_s_date,1,6) then  //현재월
		//재공트랜스 삭제
		DECLARE up_wip08 PROCEDURE FOR PBWIP.SP_WIP_08  
				A_COMLTD = :g_s_company,   
				A_PRSRTY = :ls_srty,   
				A_PRSRNO = :ls_srno,   
				A_PRSRNO1 = :ls_srno1,   
				A_PRSRNO2 = :ls_srno2  using sqlca;
		
		execute up_wip08;
			
		select ifnull(count(*),0) into :ll_rtncnt
			from pbwip.wip004
			where wdcmcd = :g_s_company and
					wdprsrty = :ls_srty and
					wdprsrno = :ls_srno and
					wdprsrno1 = :ls_srno1 and
					wdprsrno2 = :ls_srno2 using sqlca;
		
		if ll_rtncnt > 0 then
			continue
		end if
		ls_time = ''
		//재공사용량계산
		if ls_srty = 'RP' or ls_srty = 'SS' then
			DECLARE up_wip07 PROCEDURE FOR PBWIP.SP_WIP_07  
				A_COMLTD = :g_s_company,   
				A_PRSRTY = :ls_srty,   
				A_PRSRNO = :ls_srno,   
				A_PRSRNO1 = :ls_srno1,   
				A_PRSRNO2 = :ls_srno2,   
				A_IPADDR = :g_s_ipaddr,   
				A_MACADDR = :g_s_macaddr,   
				A_INPTID = :g_s_empno,   
				A_INPTDT = :g_s_date,   
				A_INPTTM = :ls_time  using sqlca;
			
			execute up_wip07;
			
			select ifnull(count(*),0) into :ll_rtncnt
				from pbwip.wip004
				where wdcmcd = :g_s_company and
						wdprsrty = :ls_srty and
						wdprsrno = :ls_srno and
						wdprsrno1 = :ls_srno1 and
						wdprsrno2 = :ls_srno2 using sqlca;
		else
			DECLARE up_wip06 PROCEDURE FOR PBWIP.SP_WIP_06  
					A_COMLTD = :g_s_company,   
					A_PRSRTY = :ls_srty,   
					A_PRSRNO = :ls_srno,   
					A_PRSRNO1 = :ls_srno1,   
					A_PRSRNO2 = :ls_srno2,   
					A_IPADDR = :g_s_ipaddr,   
					A_MACADDR = :g_s_macaddr,   
					A_INPTID = :g_s_empno,   
					A_INPTDT = :g_s_date,   
					A_INPTTM = :ls_time  using sqlca;
			
			execute up_wip06;
			
			select ifnull(count(*),0) into :ll_rtncnt
				from pbwip.wip004
				where wdcmcd = :g_s_company and
						wdprsrty = :ls_srty and
						wdprsrno = :ls_srno and
						wdprsrno1 = :ls_srno1 and
						wdprsrno2 = :ls_srno2 using sqlca;
		end if
	else //이월
		//재공트랜스 삭제
		 DECLARE up_wip_12 PROCEDURE FOR PBWIP.SP_WIP_12  
         A_COMLTD = :g_s_company,   
         A_PRSRTY = :ls_srty,   
         A_PRSRNO = :ls_srno,   
         A_PRSRNO1 = :ls_srno1,   
         A_PRSRNO2 = :ls_srno2,   
         A_ADJDT = :ls_adjdate,   
         A_NEXTDT = :ls_nextdt  using sqlca;
		execute up_wip_12;
			
		select ifnull(count(*),0) into :ll_rtncnt
			from pbwip.wip004
			where wdcmcd = :g_s_company and
					wdprsrty = :ls_srty and
					wdprsrno = :ls_srno and
					wdprsrno1 = :ls_srno1 and
					wdprsrno2 = :ls_srno2 using sqlca;
		
		if ll_rtncnt > 0 then
			continue
		end if
		ls_time = ''
		//재공사용량계산
		if ls_srty = 'RP' or ls_srty = 'SS' then
			 DECLARE up_wip_11 PROCEDURE FOR PBWIP.SP_WIP_11  
					A_COMLTD = :g_s_company,   
					A_PRSRTY = :ls_srty,   
					A_PRSRNO = :ls_srno,   
					A_PRSRNO1 = :ls_srno1,   
					A_PRSRNO2 = :ls_srno2,   
					A_IPADDR = :g_s_ipaddr,   
					A_MACADDR = :g_s_macaddr,   
					A_INPTID = :g_s_empno,   
					A_INPTDT = :g_s_date,   
					A_INPTTM = :ls_time,   
					A_ADJDT = :ls_adjdate,   
					A_NEXTDT = :ls_nextdt  using sqlca;

			execute up_wip_11;
			
			select ifnull(count(*),0) into :ll_rtncnt
				from pbwip.wip004
				where wdcmcd = :g_s_company and
						wdprsrty = :ls_srty and
						wdprsrno = :ls_srno and
						wdprsrno1 = :ls_srno1 and
						wdprsrno2 = :ls_srno2 using sqlca;
		else
			 DECLARE up_wip_10 PROCEDURE FOR PBWIP.SP_WIP_10  
					A_COMLTD = :g_s_company,   
					A_PRSRTY = :ls_srty,   
					A_PRSRNO = :ls_srno,   
					A_PRSRNO1 = :ls_srno1,   
					A_PRSRNO2 = :ls_srno2,   
					A_IPADDR = :g_s_ipaddr,   
					A_MACADDR = :g_s_macaddr,   
					A_INPTID = :g_s_empno,   
					A_INPTDT = :g_s_date,   
					A_INPTTM = :ls_time,   
					A_ADJDT = :ls_adjdate,   
					A_NEXTDT = :ls_nextdt  using sqlca;
			
			execute up_wip_10;
			
			select ifnull(count(*),0) into :ll_rtncnt
				from pbwip.wip004
				where wdcmcd = :g_s_company and
						wdprsrty = :ls_srty and
						wdprsrno = :ls_srno and
						wdprsrno1 = :ls_srno1 and
						wdprsrno2 = :ls_srno2 using sqlca;
		end if
	end if
	//결과 데이타 처리
	ll_currow = dw_2.insertrow(0)
	dw_2.setitem(ll_currow,"prsrty",ls_srty)
	dw_2.setitem(ll_currow,"prsrno",ls_srno)
	dw_2.setitem(ll_currow,"prsrno1",ls_srno1)
	dw_2.setitem(ll_currow,"prsrno2",ls_srno2)
	dw_2.setitem(ll_currow,"sumqty",ll_rtncnt)
next

uo_status.st_message.text = "완료되었습니다."
end event

type uo_1 from uo_wip_plandiv within w_wip034u
integer x = 1111
integer y = 28
integer taborder = 30
boolean bringtotop = true
end type

on uo_1.destroy
call uo_wip_plandiv::destroy
end on

type pb_1 from picturebutton within w_wip034u
integer x = 3013
integer y = 20
integer width = 155
integer height = 132
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_1.rowcount() < 1 then
	uo_status.st_message.text = "저장할 자료가 없습니다."
else
	f_save_to_excel(dw_1)
end if
end event

type uo_2 from uo_ccyymm_mps within w_wip034u
integer x = 489
integer y = 36
integer taborder = 40
boolean bringtotop = true
end type

on uo_2.destroy
call uo_ccyymm_mps::destroy
end on

