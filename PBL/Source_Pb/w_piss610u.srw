$PBExportHeader$w_piss610u.srw
$PBExportComments$Shpping Label(공통-전장)
forward
global type w_piss610u from w_ipis_sheet01
end type
type tab_1 from tab within w_piss610u
end type
type tabpage_1 from userobject within tab_1
end type
type dw_2 from u_vi_std_datawindow within tabpage_1
end type
type dw_3 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_2 dw_2
dw_3 dw_3
end type
type tabpage_2 from userobject within tab_1
end type
type dw_4 from u_vi_std_datawindow within tabpage_2
end type
type dw_5 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_4 dw_4
dw_5 dw_5
end type
type tab_1 from tab within w_piss610u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_area from u_pisc_select_area within w_piss610u
end type
type uo_division from u_pisc_select_division within w_piss610u
end type
type uo_customer from u_piss_select_custcode within w_piss610u
end type
type st_2 from statictext within w_piss610u
end type
type em_1 from editmask within w_piss610u
end type
type gb_1 from groupbox within w_piss610u
end type
type cb_1 from commandbutton within w_piss610u
end type
type em_2 from editmask within w_piss610u
end type
type st_3 from statictext within w_piss610u
end type
type st_4 from statictext within w_piss610u
end type
type em_3 from editmask within w_piss610u
end type
type dw_print from datawindow within w_piss610u
end type
type st_5 from statictext within w_piss610u
end type
type sle_itno from singlelineedit within w_piss610u
end type
type st_6 from statictext within w_piss610u
end type
type em_date from editmask within w_piss610u
end type
end forward

global type w_piss610u from w_ipis_sheet01
integer height = 2164
tab_1 tab_1
uo_area uo_area
uo_division uo_division
uo_customer uo_customer
st_2 st_2
em_1 em_1
gb_1 gb_1
cb_1 cb_1
em_2 em_2
st_3 st_3
st_4 st_4
em_3 em_3
dw_print dw_print
st_5 st_5
sle_itno sle_itno
st_6 st_6
em_date em_date
end type
global w_piss610u w_piss610u

type variables
Boolean	ib_open
int i_n_tab_index
end variables

forward prototypes
public subroutine wf_label_form (integer ag_printcount)
end prototypes

public subroutine wf_label_form (integer ag_printcount);string	ls_customername, ls_customercode, ls_customeritemcode, ls_customeritemname, ls_suppliercode,ls_vessel, &
			ls_uselocation, ls_inventorycode, ls_printdate, ls_itemcode, ls_revisionno, &
			ls_traceno, ls_puchaseno, &
			ls_areacode, ls_divisioncode
boolean	lb_null = False
int		li_row, li_selectedcount, li_currentprintcount, li_currentserial, li_lotqty,&
			li_serialnofrom,	li_labelcount, li_serialnoto
long		ll_rowcount, ll_weightheader, ll_weightdetail, ll_rackcount

//	BARCODE PRINT <TABPAGE-2>	
ll_rowcount = tab_1.tabpage_2.dw_4.rowcount()
dw_print.reset()
dw_print.Modify("datawindow.print.margin.left   = " + String( Integer(Trim(em_2.Text))*100 )  )
dw_print.Modify("datawindow.print.margin.Top    = " + String( Integer(Trim(em_3.Text))*100 ) )
dw_print.Modify("datawindow.print.margin.bottom  = " + String(0*100 ))
For li_selectedcount = 1 To ll_rowcount
	   if tab_1.tabpage_2.dw_4.isselected(li_selectedcount) <> true then
			continue
		end if
		//Null Value Check
		ls_customercode		= tab_1.tabpage_2.dw_4.getitemstring(li_selectedcount,'customercode')
		SELECT custname
		 INTO :ls_customername
		 FROM tmstcustomer
		WHERE custcode = :ls_customercode using sqlpis  ;
		ls_areacode				= tab_1.tabpage_2.dw_4.getitemstring(li_selectedcount,'areacode')
		ls_divisioncode		= tab_1.tabpage_2.dw_4.getitemstring(li_selectedcount,'divisioncode')
		ls_customercode		= tab_1.tabpage_2.dw_4.getitemstring(li_selectedcount,'customercode')
		ls_puchaseno	 		= tab_1.tabpage_2.dw_4.getitemstring(li_selectedcount,'puchaseno')
		ls_customeritemcode	= tab_1.tabpage_2.dw_4.getitemstring(li_selectedcount,'customeritemcode')
		//ls_customeritemname	= tab_1.tabpage_2.dw_4.getitemstring(li_selectedcount,'customeritemname')
		li_lotqty  				= tab_1.tabpage_2.dw_4.getitemnumber(li_selectedcount,'lotqty')
		ls_vessel				= tab_1.tabpage_2.dw_4.getitemstring(li_selectedcount,'vessel')
		ll_weightdetail		= tab_1.tabpage_2.dw_4.getitemnumber(li_selectedcount,'weightdetail')
		ll_rackcount			= tab_1.tabpage_2.dw_4.getitemnumber(li_selectedcount,'rackcount')
		ls_printdate   	 	= tab_1.tabpage_2.dw_4.getitemstring(li_selectedcount,'printdate')
		ls_traceno				= tab_1.tabpage_2.dw_4.getitemstring(li_selectedcount,'traceno')
	   li_serialnofrom  	   = tab_1.tabpage_2.dw_4.getitemnumber(li_selectedcount,'serialnofrom')
	   li_labelcount      	= tab_1.tabpage_2.dw_4.getitemnumber(li_selectedcount,'labelcount')
   	SELECT suppliercode, inventorycode, weight, uselocation, itemcode, revisionno
		  into :ls_suppliercode, :ls_inventorycode, :ll_weightheader, :ls_uselocation, :ls_itemcode, :ls_revisionno
		 FROM tshiplabelheader
		WHERE areacode 		  = :ls_areacode and
		      divisioncode	  = :ls_divisioncode and
				customercode 	  = :ls_customercode and
				customeritemcode = :ls_customeritemcode and
		      lotqty			  = :li_lotqty
		using sqlpis  ;
		
//		SELECT custname
//		  into :ls_customername
//		 FROM tmstcustomer
//		WHERE custcode 	 = :ls_customercode
//		using sqlpis  ;
	
	li_serialnoto = li_serialnofrom	+	li_labelcount - 1
	for li_currentserial = li_serialnofrom to li_serialnoto
		for li_currentprintcount = 1 to ag_printcount

			li_row ++			
			dw_print.insertrow(li_row)
			
	//		dw_print.setitem(li_row,'customername',ls_customername)
			dw_print.setitem(li_row,'puchaseno',ls_puchaseno)
			dw_print.setitem(li_row,'itemcode',ls_customeritemcode)
			dw_print.setitem(li_row,'lotqty',li_lotqty)
			dw_print.setitem(li_row,'suppliercode',ls_suppliercode)
			dw_print.setitem(li_row,'vessel',ls_vessel)
			dw_print.setitem(li_row,'inventorycode',ls_inventorycode)
			dw_print.setitem(li_row,'weightheader',ll_weightheader)
			dw_print.setitem(li_row,'weightdetail',ll_weightdetail)
			dw_print.setitem(li_row,'rackcount',ll_rackcount)
			dw_print.setitem(li_row,'uselocation',ls_uselocation)
		//	dw_print.setitem(li_row,'customeritemname',ls_customeritemname)
		//	dw_print.setitem(li_row,'itemcode',ls_itemcode)
			dw_print.setitem(li_row,'printdate',ls_printdate)
			dw_print.setitem(li_row,'revisionno',ls_revisionno)
			dw_print.setitem(li_row,'traceno',ls_traceno)
			dw_print.setitem(li_row,'serialnofrom', li_currentserial)
		
		next
	next
Next
	
Long	ll_printjob
////ll_printjob	= PrintOPen()
////printSetup()
//ll_printjob	= PrintOPen()
//PrintDataWindow(ll_printjob, dw_print)
//PrintClose(ll_printjob)
//messagebox('확인','발행 되었습니다')
return
				


end subroutine
on w_piss610u.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_customer=create uo_customer
this.st_2=create st_2
this.em_1=create em_1
this.gb_1=create gb_1
this.cb_1=create cb_1
this.em_2=create em_2
this.st_3=create st_3
this.st_4=create st_4
this.em_3=create em_3
this.dw_print=create dw_print
this.st_5=create st_5
this.sle_itno=create sle_itno
this.st_6=create st_6
this.em_date=create em_date
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_customer
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_1
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.em_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.em_3
this.Control[iCurrent+13]=this.dw_print
this.Control[iCurrent+14]=this.st_5
this.Control[iCurrent+15]=this.sle_itno
this.Control[iCurrent+16]=this.st_6
this.Control[iCurrent+17]=this.em_date
end on

on w_piss610u.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_customer)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.em_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.em_3)
destroy(this.dw_print)
destroy(this.st_5)
destroy(this.sle_itno)
destroy(this.st_6)
destroy(this.em_date)
end on

event ue_postopen;call super::ue_postopen;tab_1.tabpage_1.dw_2.SetTransObject(SQLPIS)
tab_1.tabpage_1.dw_3.SetTransObject(SQLPIS)
tab_1.tabpage_2.dw_4.SetTransObject(SQLPIS)
tab_1.tabpage_2.dw_5.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
f_piss_retrieve_dddw_custcode(uo_customer.dw_1,'%','%',True,uo_customer.is_uo_custcode,uo_customer.is_uo_custname)

ib_open = True
iw_this.PostEvent("ue_reset")
end event

event ue_reset;call super::ue_reset;tab_1.tabpage_1.dw_2.ReSet()
tab_1.tabpage_1.dw_3.ReSet()
tab_1.tabpage_2.dw_4.ReSet()
tab_1.tabpage_2.dw_5.ReSet()

end event

event activate;call super::activate;tab_1.tabpage_1.dw_2.SetTransObject(SQLPIS)
tab_1.tabpage_1.dw_3.SetTransObject(SQLPIS)
tab_1.tabpage_2.dw_4.SetTransObject(SQLPIS)
tab_1.tabpage_2.dw_5.SetTransObject(SQLPIS)
em_2.enabled = false
em_3.enabled = false
end event

event resize;call super::resize;il_resize_count ++
of_resize_register(tab_1, full)

//of_resize_register(tab_1.tabpage_1.dw_2, ABOVE)
//of_resize_register(tab_1.tabpage_1.dw_3, BELOW)
//of_resize_register(tab_1.tabpage_2.dw_4, above)
//of_resize_register(tab_1.tabpage_2.dw_5, below)
//
of_resize()


end event

event ue_insert;call super::ue_insert;String ls_customercode, ls_itemcode
int    l_n_row, net

choose case i_n_tab_index
		 case 1
			l_n_row = tab_1.tabpage_1.dw_2.getselectedrow(0)
			if l_n_row < 1 then
				ls_customercode  = uo_customer.is_uo_custcode
				if f_spacechk(ls_customercode) = -1 then
					uo_status.st_message.text = "거래처를 선택해 주십시요"
					return 0
				end if
				ls_customercode = ls_customercode
				ls_itemcode = '%'
				tab_1.tabpage_1.dw_2.reset()
				l_n_row = tab_1.tabpage_1.dw_2.retrieve(uo_area.is_uo_areacode, &
					uo_division.is_uo_divisioncode,ls_customercode + '%',ls_itemcode)
			else
				ls_customercode = tab_1.tabpage_1.dw_2.getitemstring(l_n_row,"customercode")
			end if
			tab_1.tabpage_1.dw_3.reset()
			tab_1.tabpage_1.dw_3.insertrow(0)
			tab_1.tabpage_1.dw_3.object.customeritemcode.protect = false
			tab_1.tabpage_1.dw_3.object.lotqty.protect = false
			tab_1.tabpage_1.dw_3.setitem(1,"customercode",ls_customercode)
			tab_1.tabpage_1.dw_3.setfocus() 
		  	tab_1.tabpage_1.dw_3.setcolumn("customeritemcode")
		  	uo_status.st_message.text = "해당정보를 입력하십시오"
		case 2
			l_n_row = tab_1.tabpage_2.dw_4.getselectedrow(0)
			if l_n_row < 1 then
				ls_customercode = uo_customer.is_uo_custcode
				if f_spacechk(ls_customercode) = -1 then
					uo_status.st_message.text = "거래처를 선택해 주십시요"
					return 0
				end if
				ls_customercode = ls_customercode
				ls_itemcode = '%'
				tab_1.tabpage_2.dw_4.reset()
		   	l_n_row = tab_1.tabpage_2.dw_4.retrieve(uo_area.is_uo_areacode, &
					uo_division.is_uo_divisioncode,ls_customercode + '%',ls_itemcode)
			else
				ls_customercode = tab_1.tabpage_2.dw_4.getitemstring(l_n_row,"customercode")
			end if
			
			tab_1.tabpage_2.dw_5.reset()
			tab_1.tabpage_2.dw_5.insertrow(0)
			tab_1.tabpage_2.dw_5.object.customeritemcode.protect = false
			tab_1.tabpage_2.dw_5.object.lotqty.protect = false
			tab_1.tabpage_2.dw_5.object.LabelCount.protect = false
			tab_1.tabpage_2.dw_5.setitem(1,"customercode",ls_customercode)
			tab_1.tabpage_2.dw_5.setfocus() 
  		   tab_1.tabpage_2.dw_5.setcolumn("customeritemcode")
			uo_status.st_message.text = "해당정보를 입력하십시오"
end choose

end event

event ue_print;integer li_printcount

li_printcount = integer(em_1.text)

if isnull(li_printcount) then
	messagebox('확인','인쇄 매수 확인 하세요')
	return
end if

wf_label_form(li_printcount)

// 라벨 인쇄 테스트
	window 	l_to_open
	str_easy l_str_prt
	
	//인쇄 DataWindow 저장
	//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
	l_str_prt.transaction  = sqlpis
	l_str_prt.datawindow   = dw_print
	//l_str_prt.title = "완성품별 사용실적"
	l_str_prt.tag			  = This.ClassName()
		
	f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
	Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)

end event

event ue_retrieve;string ls_areacode, ls_divisioncode, ls_customercode, ls_customeritemcode, ls_serialfrom
string ls_itno, ls_prtdate
long    l_n_row, l_n_ret, l_n_currow

uo_status.st_message.text	=	"조회중입니다."
ls_areacode = uo_area.is_uo_areacode
ls_divisioncode = uo_division.is_uo_divisioncode
ls_customercode = uo_customer.is_uo_custcode
if f_spacechk(ls_customercode) = -1 then
	ls_customercode = '%'
else
	ls_customercode = ls_customercode + '%'
end if
ls_itno = sle_itno.text
if f_spacechk( ls_itno ) = -1 then
	ls_itno = '%'
else
	ls_itno = trim(ls_itno) + '%'
end if
choose case i_n_tab_index
		case 1
			tab_1.tabpage_1.dw_2.reset()
			l_n_row = tab_1.tabpage_1.dw_2.retrieve(ls_areacode, ls_divisioncode,ls_customercode,ls_itno)
			if l_n_row > 0 then
//			// 처음 retrieve시 dw_2의 default data는 first row
				l_n_currow 	= tab_1.tabpage_1.dw_2.getrow()
				tab_1.tabpage_1.dw_2.selectrow(0,false)
				tab_1.tabpage_1.dw_2.selectrow(l_n_currow,true)	
 		  	   uo_status.st_message.text	=	'조회되었습니다.'
			else
			   uo_status.st_message.text	=	'조회할 자료가 없습니다.'  	
			end if		
			
//			// 처음 retrieve시 dw_2의 default data는 first row
			l_n_currow 	= tab_1.tabpage_1.dw_2.getrow()
			tab_1.tabpage_1.dw_2.selectrow(0,false)
			tab_1.tabpage_1.dw_2.selectrow(l_n_currow,true)	
		case 2
			em_date.getdata(ls_prtdate)
			if f_spacechk(ls_prtdate) = -1 then
				ls_prtdate = '%'
			else
				if f_dateedit(ls_prtdate) = space(8) then
					messagebox("알림","발행일이 잘못 입력되었습니다.")
					return 0
				end if
			end if
			tab_1.tabpage_2.dw_4.reset()

		   l_n_row = tab_1.tabpage_2.dw_4.retrieve(ls_areacode, ls_divisioncode,ls_customercode,ls_itno,ls_prtdate)
			
			if l_n_row > 0 then
				// 처음 retrieve시 dw_4의 default data는 first row
				l_n_currow = tab_1.tabpage_2.dw_4.getrow()
				tab_1.tabpage_2.dw_4.selectrow(0,false)
				tab_1.tabpage_2.dw_4.selectrow(l_n_currow,true)
		  	   uo_status.st_message.text	=	'조회되었습니다.'
			else
			   uo_status.st_message.text	=	'조회할 자료가 없습니다.'  	
			end if		
end choose

setpointer(arrow!)


end event

event ue_save;string ls_areacode, ls_divisioncode, ls_customercode, ls_customeritemcode, ls_itemcode 
string ls_printdate
integer li_rtncnt, li_copies, li_lotqty, li_headercount, li_count, li_maxlabelcount, li_SerialNoFrom
long	 ll_find
choose case i_n_tab_index
		case 1
			tab_1.tabpage_1.dw_3.accepttext()
		   tab_1.tabpage_1.dw_3.setitem(1,'areacode',uo_area.is_uo_areacode)
         tab_1.tabpage_1.dw_3.setitem(1,'divisioncode',uo_division.is_uo_divisioncode)
			//tab_1.tabpage_1.dw_3.setitem(1,'CustomerCode',uo_customer.is_uo_custcode)
			ls_customercode  = tab_1.tabpage_1.dw_3.getitemstring(1,'customercode')
			ls_customeritemcode = tab_1.tabpage_1.dw_3.getitemstring(1,'customeritemcode')
	
			if (isnull(tab_1.tabpage_1.dw_3.getitemstring(1, 'customeritemcode')) or &
			   tab_1.tabpage_1.dw_3.getitemstring(1, 'customeritemcode') = '') then
				messagebox('확인','거래처품번을 입력 하시오')
				return
			end if
						
			if isnull(tab_1.tabpage_1.dw_3.getitemnumber(1, 'lotqty')) or &
			   tab_1.tabpage_1.dw_3.getitemnumber(1, 'lotqty') <= 0 then
				messagebox('확인','수용수를 입력 하시오')
				return
			end if	
						
			if isnull(tab_1.tabpage_1.dw_3.getitemstring(1, 'suppliercode')) or &
			   tab_1.tabpage_1.dw_3.getitemstring(1, 'suppliercode') = '' then
				messagebox('확인','공급자를 입력 하시오')
				return
			end if	
						
			if isnull(tab_1.tabpage_1.dw_3.getitemnumber(1, 'weight')) or &
			   tab_1.tabpage_1.dw_3.getitemnumber(1, 'weight') <= 0 then
				messagebox('확인','실중량을 입력 하시오')
				return
			end if	
			
//			SELECT itemcode
//			  INTO :ls_itemcode
//		   FROM tmstcustitem
//		   WHERE custcode = :ls_customercode AND
//					custitemcode = :ls_customeritemcode  using sqlpis ;
//			
//			if sqlpis.sqlcode <> 0 then
//				messagebox('확인','거래처 품번을 확인 바랍니다.')
//				return
//			end if	
			
//			tab_1.tabpage_1.dw_3.setitem(1,'itemcode',ls_itemcode)
			f_inptid(tab_1.tabpage_1.dw_3)
        	li_rtncnt = tab_1.tabpage_1.dw_3.update()
			if li_rtncnt = 1 then
				commit using sqlpis;
				uo_status.st_message.text = '저장이 되었습니다.'
			else 
				uo_status.st_message.text = '저장 실패'
				rollback using sqlpis;
			end if	
		case 2
			tab_1.tabpage_2.dw_5.accepttext()
			ls_areacode			= uo_area.is_uo_areacode
			ls_divisioncode	= uo_division.is_uo_divisioncode
			ls_customercode	= tab_1.tabpage_2.dw_5.getitemstring(1,'customercode')
			tab_1.tabpage_2.dw_5.setitem(1,'areacode',ls_areacode)
         tab_1.tabpage_2.dw_5.setitem(1,'divisioncode',ls_divisioncode)
			//tab_1.tabpage_2.dw_5.setitem(1,'customercode',ls_customercode)
			ls_customeritemcode	  = tab_1.tabpage_2.dw_5.getitemstring(1,'customeritemcode') 
			li_lotqty 				  = tab_1.tabpage_2.dw_5.getitemnumber(1,'lotqty') 
			li_SerialNoFrom		  = tab_1.tabpage_2.dw_5.getitemnumber(1,'SerialNoFrom') 
			ls_printdate			  = tab_1.tabpage_2.dw_5.getitemstring(1,'printdate') 	
			if isnull(tab_1.tabpage_2.dw_5.getitemstring(1, 'customeritemcode')) or &
			   tab_1.tabpage_2.dw_5.getitemstring(1, 'customeritemcode') = '' then
				messagebox('확인','거래처 품번을 입력 하시오')
				return
			end if
			
			if isnull(tab_1.tabpage_2.dw_5.getitemnumber(1, 'lotqty')) or &
			   tab_1.tabpage_2.dw_5.getitemnumber(1, 'lotqty') <= 0 then
				messagebox('확인','수용수를 입력 하시오')
				return
			end if	
			
			if isnull(tab_1.tabpage_2.dw_5.getitemstring(1, 'puchaseno')) or &
			   tab_1.tabpage_2.dw_5.getitemstring(1, 'puchaseno') = '' then
				messagebox('확인','발주번호를 입력 하시오')
				return
			end if	

			if trim(ls_printdate) = '' or isnull(ls_printdate) then
			//
			else
				if trim(f_dateedit(ls_printdate)) = ''	then
					messagebox('확인','날짜 체계가 틀립니다.')
					return
				end if
			end if	
//			if isnull(tab_1.tabpage_2.dw_5.getitemnumber(1, 'weight')) or &
//			   tab_1.tabpage_2.dw_5.getitemnumber(1, 'weight') <= 0 then
//				messagebox('확인','총중량을 입력 하시오')
//				return
//			end if	
//
//			if isnull(tab_1.tabpage_2.dw_5.getitemnumber(1, 'rackcount')) or &
//			   tab_1.tabpage_2.dw_5.getitemnumber(1, 'rackcount') <= 0 then
//				messagebox('확인','랙수를 입력 하시오')
//				return
//			end if	
//
			li_copies = tab_1.tabpage_2.dw_5.getitemnumber(1,'labelcount') 
			if tab_1.tabpage_2.dw_5.getitemnumber(1, 'serialnofrom') = 0 or	&
				isnull(tab_1.tabpage_2.dw_5.getitemnumber(1, 'serialnofrom'))	then
				if li_copies <= 0 then
					uo_status.st_message.text = '매수를 입력하십시오'
					messagebox('확인','매수를 입력하십시오')
					return
				end if
			end if	
			
			SELECT count(*) into :li_count
		   FROM tshiplabelheader
		   WHERE ( areacode         = :ls_areacode) AND
			      ( divisioncode 	 = :ls_divisioncode ) and
					( customercode 	 = :ls_customercode ) and
					( customeritemcode = :ls_customeritemcode ) and
					( lotqty           = :li_lotqty )	using sqlpis ;
			
			if sqlpis.sqlcode <> 0 or li_count = 0 then
				uo_status.st_message.text = '기본정보 등록후 작업 하시오'
				messagebox('확인','기본정보 등록후 작업 하시오')
				return
			end if
			
			if li_SerialNoFrom	<=	0	or isnull(li_SerialNoFrom)	then
				SELECT sum(LabelCount)  
		        INTO :li_maxlabelcount
		   	FROM tshiplabeldetail
		  		WHERE ( areacode         = :ls_areacode) AND
			   	   ( divisioncode 	 = :ls_divisioncode ) and
						( customercode 	 = :ls_customercode ) and
						( customeritemcode = :ls_customeritemcode ) and
						( lotqty           = :li_lotqty )	using sqlpis ;

				if sqlpis.sqlcode <> 0 or isnull(li_maxlabelcount) = true then
   				li_maxlabelcount = 0
				end if
			
				li_maxlabelcount++
				tab_1.tabpage_2.dw_5.setitem(1,'serialnofrom',li_maxlabelcount)
			end if
			
			f_inptid(tab_1.tabpage_2.dw_5)
			li_rtncnt = tab_1.tabpage_2.dw_5.update(true,false)
			if li_rtncnt = 1 then
				commit using sqlpis;
				uo_status.st_message.text = '저장이 되었습니다.'
			else 
				uo_status.st_message.text = '저장 실패'
				rollback using sqlpis;
			end if
end choose

triggerevent("ue_retrieve")

//choose case i_n_tab_index
//		Case 1
//			ll_find	= tab_1.tabpage_1.dw_2.Find("Customeritemcode = '" + ls_Customeritemcode + "' And " + &
//								"lotqty = '" + li_lotqty + "'", 1, tab_1.tabpage_1.dw_2.RowCount())
//			If ll_find > 0 Then
//				tab_1.tabpage_1.dw_2.SetRow(ll_find)
//				tab_1.tabpage_1.dw_2.Trigger Event RowFocusChanged(ll_find)
//				tab_1.tabpage_1.dw_2.ScrollToRow(ll_find)
//			End If
//		Case 2
//			ll_find	= tab_1.tabpage_2.dw_4.Find("AreaCode = '" + ls_areacode + "' And " + &
//								"DivisionCode = '" + ls_divisioncode + "' And " + &
//								"Customercode = '" + ls_Customercode + "' And " + &
//								"Customeritemcode = '" + ls_Customeritemcode + "' And " + &
//								"lotqty = '" + li_lotqty + "' And " + &
//								"serialnofrom = '" + li_maxlabelcount + "'", 1, tab_1.tabpage_2.dw_4.RowCount())
//			If ll_find > 0 Then
//				tab_1.tabpage_2.dw_4.SetRow(ll_find)
//				tab_1.tabpage_2.dw_4.Trigger Event RowFocusChanged(ll_find)
//				tab_1.tabpage_2.dw_4.ScrollToRow(ll_find)
//			End If
//end choose
end event

event ue_delete;call super::ue_delete;long ll_cntsum,ll_currow, li_count
integer li_rtn
string ls_areacode, ls_divisioncode, ls_customercode, ls_customeritemcode
integer li_lotqty, li_serialnofrom

choose case i_n_tab_index
		case 1
			ll_currow = tab_1.tabpage_1.dw_2.getselectedrow(0)
			ls_customeritemcode   = tab_1.tabpage_1.dw_2.object.customeritemcode[ll_currow]
			ls_customercode		= tab_1.tabpage_1.dw_2.object.customercode[ll_currow]
			li_lotqty   = tab_1.tabpage_1.dw_2.object.lotqty[ll_currow]
			li_rtn = messagebox("알림", ls_customeritemcode + " 를 정말 삭제 하시겠습니까?",question!,yesno!,1)   //정말삭제하시겠습니까?
			if li_rtn = 2 then
				uo_status.st_message.text = "삭제가 취소되었습니다."
				return 0
			end if
			ls_areacode = uo_area.is_uo_areacode
			ls_divisioncode = uo_division.is_uo_divisioncode
			//ls_customercode = uo_customer.is_uo_custcode
			
			select count(*) into :li_count
			from	tshiplabeldetail
			where areacode				=	:ls_areacode and
				   divisioncode		=	:ls_divisioncode and
					customercode		=	:ls_customercode and
					customeritemcode	=	:ls_customeritemcode and
					lotqty				=	:li_lotqty	using sqlpis;
			if li_count > 0 then
				messagebox("알림", "발행 정보가 존재 하여 삭제 할수 없습니다.")   //정말삭제하시겠습니까?
				return 0
			end if
				
			delete from tshiplabelheader
				where areacode				=	:ls_areacode			and
				      divisioncode		=	:ls_divisioncode		and
						customercode		=	:ls_customercode		and
						customeritemcode	=	:ls_customeritemcode	and
						lotqty				=	:li_lotqty				using sqlpis;
			
			if sqlpis.sqlcode = 0 then
				commit using sqlpis;
				uo_status.st_message.text = "삭제되었습니다."
			else
				rollback using sqlpis;
				uo_status.st_message.text = "err_d1; " + "삭제실패 정보시스템으로 연락바랍니다."
			end if
		case 2
			ll_currow = tab_1.tabpage_2.dw_4.getselectedrow(0)
			ls_areacode		 	  = tab_1.tabpage_2.dw_4.object.areacode[ll_currow]
			ls_divisioncode	  = tab_1.tabpage_2.dw_4.object.divisioncode[ll_currow]
			ls_customercode 	  = tab_1.tabpage_2.dw_4.object.customercode[ll_currow]
			ls_customeritemcode = tab_1.tabpage_2.dw_4.object.customeritemcode[ll_currow]
			li_lotqty			  = tab_1.tabpage_2.dw_4.object.lotqty[ll_currow]
			li_serialnofrom     = tab_1.tabpage_2.dw_4.object.serialnofrom[ll_currow]
			li_rtn = messagebox("알림", ls_customeritemcode + " 를 정말 삭제 하시겠습니까?",question!,yesno!,1)   //정말삭제하시겠습니까?
			if li_rtn = 2 then
				uo_status.st_message.text = "삭제가 취소되었습니다."
				return 0
			end if
			delete from tshiplabeldetail
				where areacode 			= :ls_areacode and
				      divisioncode 		= :ls_divisioncode and
						customercode 		= :ls_customercode and
						customeritemcode 	= :ls_customeritemcode and
						lotqty           	= :li_lotqty and
						serialnofrom 		= :li_serialnofrom using sqlpis;
			if sqlpis.sqlcode = 0 then
				commit using sqlpis;
				uo_status.st_message.text = "삭제되었습니다."
			else
				rollback using sqlpis;
				uo_status.st_message.text = "err_d1; " + "삭제실패 정보시스템으로 연락바랍니다."
			end if
			
	end choose
	this.triggerevent("ue_retrieve")
end event

event open;call super::open;//i_n_tab_index =  1
em_1.text = '1'
em_2.text = '4'
em_3.text = '0'


end event

type uo_status from w_ipis_sheet01`uo_status within w_piss610u
end type

type tab_1 from tab within w_piss610u
event resize pbm_size
integer x = 18
integer y = 316
integer width = 3584
integer height = 1552
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
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event resize;tabpage_1.dw_3.Width = newwidth - ( tabpage_1.dw_3.x + 40 ) 
tabpage_1.dw_3.y = newheight - 380
tabpage_1.dw_2.Width = newwidth - ( tabpage_1.dw_2.x + 40 ) 
tabpage_1.dw_2.Height = newheight - ( tabpage_1.dw_2.y + 395 ) 

tabpage_2.dw_5.Width = newwidth - ( tabpage_2.dw_5.x + 40 ) 
tabpage_2.dw_5.y = newheight - 550
tabpage_2.dw_4.Width = newwidth - ( tabpage_2.dw_4.x + 40 ) 
tabpage_2.dw_4.Height = newheight - ( tabpage_2.dw_4.y + 565 ) 

end event

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

em_1.enabled = false
if i_n_tab_index = 2 then
	em_date.enabled = true
	em_1.enabled = true
else
	em_date.enabled = false
end if	
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3547
integer height = 1436
long backcolor = 12632256
string text = "Label 기본정보 등록"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_2 dw_2
dw_3 dw_3
end type

on tabpage_1.create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.Control[]={this.dw_2,&
this.dw_3}
end on

on tabpage_1.destroy
destroy(this.dw_2)
destroy(this.dw_3)
end on

type dw_2 from u_vi_std_datawindow within tabpage_1
integer x = 9
integer y = 12
integer width = 3538
integer height = 1264
integer taborder = 30
string dataobject = "d_piss610u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;If currentrow <= 0 Then
	return
end if

tab_1.tabpage_1.dw_3.reset()
tab_1.tabpage_1.dw_3.retrieve(uo_area.is_uo_areacode,uo_division.is_uo_divisioncode,&
										tab_1.tabpage_1.dw_2.object.customercode[currentrow], &
										tab_1.tabpage_1.dw_2.object.customeritemcode[currentrow])

tab_1.tabpage_1.dw_3.setfocus() 
tab_1.tabpage_1.dw_3.setcolumn("suppliercode")

tab_1.tabpage_1.dw_3.object.customeritemcode.protect = true
tab_1.tabpage_1.dw_3.object.lotqty.protect = true
uo_status.st_message.text	=	'조회되었습니다.'

end event

type dw_3 from datawindow within tabpage_1
integer x = 9
integer y = 1296
integer width = 3538
integer height = 260
integer taborder = 20
string title = "none"
string dataobject = "d_piss610u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3547
integer height = 1436
long backcolor = 12632256
string text = "Label 발행정보 등록"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_4 dw_4
dw_5 dw_5
end type

on tabpage_2.create
this.dw_4=create dw_4
this.dw_5=create dw_5
this.Control[]={this.dw_4,&
this.dw_5}
end on

on tabpage_2.destroy
destroy(this.dw_4)
destroy(this.dw_5)
end on

type dw_4 from u_vi_std_datawindow within tabpage_2
integer y = 16
integer width = 3547
integer height = 1128
integer taborder = 11
string dataobject = "d_piss610u_03"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_areacode, ls_divisioncode, ls_customercode, ls_customeritemcode
integer li_lotqty, li_serialnofrom

If currentrow > 0 Then
	tab_1.tabpage_2.dw_5.reset()
	ls_areacode				 = tab_1.tabpage_2.dw_4.object.areacode[currentrow]
	ls_divisioncode  		 = tab_1.tabpage_2.dw_4.object.divisioncode[currentrow]
	ls_customercode 		 = tab_1.tabpage_2.dw_4.object.customercode[currentrow]
	ls_customeritemcode 	 = tab_1.tabpage_2.dw_4.object.customeritemcode[currentrow]
	li_lotqty		 		 = tab_1.tabpage_2.dw_4.object.lotqty[currentrow]
	li_serialnofrom 		 = tab_1.tabpage_2.dw_4.object.serialnofrom[currentrow]
	tab_1.tabpage_2.dw_5.retrieve(ls_areacode,ls_divisioncode,ls_customercode,ls_customeritemcode,li_lotqty,li_serialnofrom)
	tab_1.tabpage_2.dw_5.object.customeritemcode.protect = true
	tab_1.tabpage_2.dw_5.object.lotqty.protect = true
	tab_1.tabpage_2.dw_5.object.labelcount.protect = true
	
	tab_1.tabpage_2.dw_5.setfocus() 
	tab_1.tabpage_2.dw_5.setcolumn("puchaseno")

	uo_status.st_message.text	=	'조회되었습니다.'
End If	
end event

type dw_5 from datawindow within tabpage_2
integer y = 1156
integer width = 3547
integer height = 416
integer taborder = 30
string title = "none"
string dataobject = "d_piss610u_04"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_area from u_pisc_select_area within w_piss610u
integer x = 46
integer y = 76
integer taborder = 10
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;If ib_open Then
	tab_1.tabpage_1.dw_2.SetTransObject(SQLPIS)
	tab_1.tabpage_1.dw_3.SetTransObject(SQLPIS)
	tab_1.tabpage_2.dw_4.SetTransObject(SQLPIS)
	tab_1.tabpage_2.dw_5.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
f_piss_retrieve_dddw_custcode(uo_customer.dw_1,'%','%',false,uo_customer.is_uo_custcode,uo_customer.is_uo_custname)

End If

end event

type uo_division from u_pisc_select_division within w_piss610u
integer x = 562
integer y = 76
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
	tab_1.tabpage_1.dw_2.SetTransObject(SQLPIS)
	tab_1.tabpage_1.dw_3.SetTransObject(SQLPIS)
	tab_1.tabpage_2.dw_4.SetTransObject(SQLPIS)
	tab_1.tabpage_2.dw_5.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_piss_retrieve_dddw_custcode(uo_customer.dw_1,'%','%',false,uo_customer.is_uo_custcode,uo_customer.is_uo_custname)

End If

end event

type uo_customer from u_piss_select_custcode within w_piss610u
integer x = 1143
integer y = 76
integer taborder = 30
boolean bringtotop = true
end type

on uo_customer.destroy
call u_piss_select_custcode::destroy
end on

type st_2 from statictext within w_piss610u
integer x = 2222
integer y = 84
integer width = 146
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "매수"
boolean focusrectangle = false
end type

type em_1 from editmask within w_piss610u
integer x = 2363
integer y = 76
integer width = 105
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type gb_1 from groupbox within w_piss610u
integer x = 18
integer width = 3575
integer height = 292
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_1 from commandbutton within w_piss610u
integer x = 2528
integer y = 64
integer width = 315
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "여백조정"
end type

event clicked;em_2.enabled = true
em_3.enabled = true
end event

type em_2 from editmask within w_piss610u
integer x = 3045
integer y = 76
integer width = 142
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####0"
end type

type st_3 from statictext within w_piss610u
integer x = 2885
integer y = 84
integer width = 137
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "왼쪽"
boolean focusrectangle = false
end type

type st_4 from statictext within w_piss610u
integer x = 3241
integer y = 84
integer width = 82
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "위"
boolean focusrectangle = false
end type

type em_3 from editmask within w_piss610u
integer x = 3310
integer y = 76
integer width = 146
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####0"
end type

type dw_print from datawindow within w_piss610u
boolean visible = false
integer x = 690
integer y = 708
integer width = 2373
integer height = 732
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss610p_06"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_piss610u
integer x = 46
integer y = 176
integer width = 379
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "거래처품번:"
boolean focusrectangle = false
end type

type sle_itno from singlelineedit within w_piss610u
integer x = 434
integer y = 164
integer width = 658
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_piss610u
integer x = 1175
integer y = 176
integer width = 279
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "발행일 :"
boolean focusrectangle = false
end type

type em_date from editmask within w_piss610u
integer x = 1445
integer y = 164
integer width = 466
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####.##.##"
end type

