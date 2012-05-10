$PBExportHeader$w_piss611u.srw
$PBExportComments$Container Shipping Label
forward
global type w_piss611u from w_ipis_sheet01
end type
type gb_2 from groupbox within w_piss611u
end type
type uo_area from u_pisc_select_area within w_piss611u
end type
type uo_division from u_pisc_select_division within w_piss611u
end type
type gb_1 from groupbox within w_piss611u
end type
type dw_2 from u_vi_std_datawindow within w_piss611u
end type
type st_3 from statictext within w_piss611u
end type
type em_1 from editmask within w_piss611u
end type
type dw_3 from datawindow within w_piss611u
end type
type em_2 from editmask within w_piss611u
end type
type st_2 from statictext within w_piss611u
end type
type st_4 from statictext within w_piss611u
end type
type em_3 from editmask within w_piss611u
end type
type st_5 from statictext within w_piss611u
end type
type em_4 from editmask within w_piss611u
end type
type dw_print from datawindow within w_piss611u
end type
end forward

global type w_piss611u from w_ipis_sheet01
integer width = 3666
gb_2 gb_2
uo_area uo_area
uo_division uo_division
gb_1 gb_1
dw_2 dw_2
st_3 st_3
em_1 em_1
dw_3 dw_3
em_2 em_2
st_2 st_2
st_4 st_4
em_3 em_3
st_5 st_5
em_4 em_4
dw_print dw_print
end type
global w_piss611u w_piss611u

type variables
Boolean	ib_open
int ii_currentrow
end variables

forward prototypes
public subroutine wf_label_ford (integer ag_printcount)
public subroutine wf_label_form (integer ag_printcount)
end prototypes

public subroutine wf_label_ford (integer ag_printcount);boolean	lb_null = False
int		li_currow, li_selectedcount, li_currentprintcount, li_currentserial, li_shipqty,&
			li_serialnofrom, li_serialnofrom1, li_labelcount, li_printcount, li_codecount
int		li_grosswgt, li_standardpackqty, li_shift, li_lotsize
long		ll_rowcount, ll_weightheader, ll_weightdetail, ll_rackcount
string 	ls_suppliername, ls_segment1, ls_segment2, ls_suppliercity, ls_countryoforigin
string	ls_customerdivision, ls_customaddr, ls_customaddr2, ls_customeritemcode
string	ls_customercity, ls_customerstate, ls_plantdock, ls_deliverylocation, ls_bar2d
string 	ls_customerno, ls_engalert, ls_supplierno, ls_containerno, ls_partdesc
string	ls_workcenter, ls_tracedate, ls_dockcode, ls_pkgid, ls_itemcode, ls_unit
string   ls_areacode, ls_divisioncode, ls_customercode, ls_invoiceno, ls_partitemcode

//	BARCODE PRINT <TABPAGE-2>	
ll_rowcount = dw_2.rowcount()
dw_print.reset()

li_printcount = 0

For li_selectedcount = 1 To ll_rowcount
	if dw_2.isselected(li_selectedcount) <> true then
		continue
	end if
	// 세부 라벨품목 조회하기
	ls_customercode		= 	dw_2.getitemstring(li_selectedcount, 'customercode')
	ls_areacode				= 	dw_2.getitemstring(li_selectedcount, 'areacode')
	ls_divisioncode 		= 	dw_2.getitemstring(li_selectedcount, 'divisioncode')
	ls_customeritemcode	=	Trim(dw_2.getitemstring(li_selectedcount, 'customeritemcode'))
	ls_invoiceno 			= 	Trim(dw_2.getitemstring(li_selectedcount, 'invoiceno'))
	li_serialnofrom		= 	dw_2.getitemnumber(li_selectedcount, 'serialnofrom')

	li_codecount	=	dw_3.retrieve(ls_areacode,			ls_divisioncode,&
									  ls_customercode,	ls_customeritemcode,&
									  ls_invoiceno,		li_serialnofrom)
	if li_codecount < 1 then
		continue
	end if
	//Null Value Check
	ls_suppliername		= dw_3.getitemstring(1,'suppliername')		
	ls_segment1				= dw_3.getitemstring(1,'segment1')
	ls_segment2				= dw_3.getitemstring(1,'segment2')
	ls_suppliercity			= trim(dw_3.getitemstring(1,'suppliercity')) + ", " + dw_3.getitemstring(1,'countryoforigin')
	ls_customeritemcode	= dw_3.getitemstring(1,'partno')
//	ls_countryoforigin	= dw_3.getitemstring(1,'countryoforigin')
	ls_customerdivision	= dw_3.getitemstring(1,'customerdivision')
	ls_customaddr			= dw_3.getitemstring(1,'customerplantaddress')
	ls_customaddr2			= dw_3.getitemstring(1,'customerplantaddress2')
	ls_customercity		= dw_3.getitemstring(1,'customercity')
	ls_customerstate		= dw_3.getitemstring(1,'customerstate')
	ls_plantdock			= dw_3.getitemstring(1,'plantdock')
	ls_deliverylocation	= dw_3.getitemstring(1,'deliverylocation')
	ls_customerno			= dw_3.getitemstring(1,'customerno')
	ls_itemcode				= dw_3.getitemstring(1,'itemcode')
	ls_engalert				= dw_3.getitemstring(1,'engalert')
	ls_supplierno			= dw_3.getitemstring(1,'supplierno')
	ls_containerno			= dw_3.getitemstring(1,'containerno')
	ls_partdesc				= dw_3.getitemstring(1,'partdesc')
	ls_workcenter			= dw_3.getitemstring(1,'workcenter')
	ls_tracedate			= dw_3.getitemstring(1,'tracedate')
	ls_dockcode				= dw_3.getitemstring(1,'dockcode')
	ls_unit					= dw_3.getitemstring(1,'unit')
	li_shipqty				= dw_3.getitemnumber(1,'shipqty')
	li_grosswgt				= ( dw_3.getitemnumber(1, 'grosswgt') * 2.25 )
	li_standardpackqty	= dw_3.getitemnumber(1,'standardpackqty')
	li_shift					= dw_3.getitemnumber(1,'shift')
	li_lotsize				= dw_3.getitemnumber(1,'lotsize')
//	if ls_customeritemcode = '892940' then
//		ls_lotno = 'C02' + ls_lotno + '1'
//	end if
	li_serialnofrom			= dw_3.getitemnumber(1,'serialnofrom')
	li_labelcount				= dw_3.getitemnumber(1, 'labelcount')

	if li_labelCount	<= 0 then
		continue
	end if
	li_Printcount ++
	
	for li_currentserial = 1	to Integer (li_labelcount)
		li_serialnofrom1 = li_serialnofrom + li_currentserial - 1
		//ls_pkgid = string(li_serialnofrom1)
		for li_currentprintcount = 1 to ag_printcount
			li_currow = dw_print.insertrow(0)
			dw_print.setitem(li_currow,'suppliername',ls_suppliername)
			dw_print.setitem(li_currow,'segment1',ls_segment1)
			dw_print.setitem(li_currow,'segment2',ls_segment2)
			dw_print.setitem(li_currow,'suppliercity',ls_suppliercity)
//			dw_print.setitem(li_currow,'countryoforigin',ls_countryoforigin)
			dw_print.setitem(li_currow,'customerdivision',ls_customerdivision)
			dw_print.setitem(li_currow,'customerplantaddress',ls_customaddr)
			dw_print.setitem(li_currow,'customerplantaddress2',ls_customaddr2)
			dw_print.setitem(li_currow,'customerplantcity',ls_customercity)
			dw_print.setitem(li_currow,'customerstate',ls_customerstate)
			dw_print.setitem(li_currow,'plantdock',ls_plantdock)
			dw_print.setitem(li_currow,'deliverylocation',ls_deliverylocation)
			dw_print.setitem(li_currow,'customerno',ls_customerno)
			dw_print.setitem(li_currow,'customeritemcode',ls_customeritemcode)
			dw_print.setitem(li_currow,'engalert',ls_engalert)
			dw_print.setitem(li_currow,'supplierno',ls_supplierno)
			dw_print.setitem(li_currow,'containerno',ls_containerno)
			dw_print.setitem(li_currow,'itemcode',ls_itemcode)
			dw_print.setitem(li_currow,'partdesc',ls_partdesc)
			dw_print.setitem(li_currow,'workcenter',ls_workcenter)
			dw_print.setitem(li_currow,'shift',li_shift)
			dw_print.setitem(li_currow,'lotsize',li_lotsize)
			dw_print.setitem(li_currow,'dockcode',ls_dockcode)
			dw_print.setitem(li_currow,'unit',ls_unit)
			dw_print.setitem(li_currow,'tracedate', upper(string(date(string(ls_tracedate,"@@@@-@@-@@")),"DDMMMYYYY")))
			dw_print.setitem(li_currow,'shipqty',li_shipqty)
			dw_print.setitem(li_currow,'grosswgt',li_grosswgt)
			dw_print.setitem(li_currow,'standardpackqty',li_standardpackqty)
			ls_pkgid = upper(ls_divisioncode) + upper(right(ls_invoiceno,4)) +'-'+string(li_serialnofrom1,'000')
			dw_print.setitem(li_currow,'serialnofrom',ls_pkgid)
			// Calculate Barcode by code128
			ls_partitemcode = f_replace_dash_blank(trim(ls_customeritemcode))
			dw_print.setitem(li_currow,'customeritemcodebar', &
				char(204) + f_piss_convert_code128( 'B', 'P' + ls_partitemcode ) + char(206))
			dw_print.setitem(li_currow,'shipqtybar', &
				char(204) + f_piss_convert_code128( 'B', 'Q' + String(li_shipqty) ) + char(206))
			dw_print.setitem(li_currow,'suppliernobar', &
				char(204) + f_piss_convert_code128( 'B', 'V' + trim(ls_supplierno) ) + char(206))
			dw_print.setitem(li_currow,'serialnofrombar', &
				char(204) + f_piss_convert_code128( 'B', '3S' + trim(ls_pkgid) ) + char(206))
			// Calculate Barcode by BAR2D
			string ls_data
			ls_data =	char(91) + char(41) + char(62) + char(30) + "06" + char(29) +  &  
						"P" + mid(ls_customeritemcode,1,4) + " " + mid(ls_customeritemcode,6,6) + " " + mid(ls_customeritemcode,13,2) + char(29) + & 
						"Q" + String(li_shipqty)       + char(29) + &
						"V" +  trim(ls_supplierno)    + char(29) + &
						"D" +  upper(string(date(string(ls_tracedate,"@@@@-@@-@@")),"YYMMDD")) +  char(29) + &
						"3S" + trim(ls_pkgid) + char(30) + char(04)
			ls_bar2d = f_get_2dbarcode( ls_data )
			dw_print.setitem(li_currow,'bar2d',ls_bar2d)
		next
	next
Next

if li_printcount > 0 then

//	Long	ll_printjob
//	ll_printjob	= PrintOPen()
//	dw_print.modify("datawindow.Print.Orientation = 1" )
//	dw_print.Modify("datawindow.print.margin.left   = " + String( Integer(Trim(em_3.Text))*100 ))
//	dw_print.Modify("datawindow.print.margin.Top    = " + String( Integer(Trim(em_4.Text))*100 ))
//	
//	PrintDataWindow(ll_printjob, dw_print)
//	PrintClose(ll_printjob)
//	messagebox('확인', '출력하였습니다')

else
	messagebox('확인', 'Label정보가 존재 하지 않는 품목을 선택 하셨습니다.')
end if

return
				


end subroutine

public subroutine wf_label_form (integer ag_printcount);string	ls_customercode, ls_customeritemcode, ls_customeritemname, ls_suppliercode,&
			ls_deliverylocation,	ls_revisionno, ls_plantdock, ls_lotno, ls_segment1,&
			ls_segment2, ls_segment3,	ls_tracedate, ls_puchaseno, ls_suppliername,&
			ls_areacode, ls_divisioncode, ls_suppliercity, ls_supplierpostal, ls_countryoforigin,&
			ls_invoiceno, ls_unit, ls_customeritemcodebar, ls_lotnobar
boolean	lb_null = False
int		li_row, li_selectedcount, li_currentprintcount, li_currentserial, li_shipqty,&
			li_serialnofrom, li_serialnofrom1, li_labelcount, li_printcount, li_codecount
int			li_sumitemcode, li_sumitemcode1, li_remainitemcode
int			li_sumlotno, li_sumlotno1, li_remainlotno
long		ll_rowcount, ll_weightheader, ll_weightdetail, ll_rackcount

//	BARCODE PRINT <TABPAGE-2>	
ll_rowcount = dw_2.rowcount()
dw_print.reset()

li_printcount = 0

For li_selectedcount = 1 To ll_rowcount
	   if dw_2.isselected(li_selectedcount) <> true then
			continue
		end if
		
		//Null Value Check
		ls_customeritemcode		= dw_2.getitemstring(li_selectedcount,'customeritemcode')
		ls_customeritemname		= dw_2.getitemstring(li_selectedcount,'customeritemname')
		li_shipqty					= dw_2.getitemnumber(li_selectedcount,'shipqty')
		ls_puchaseno				= dw_2.getitemstring(li_selectedcount,'puchaseno')
		ls_revisionno				= dw_2.getitemstring(li_selectedcount,'revisionno')
		ls_divisioncode			= dw_2.getitemstring(li_selectedcount,'Divisioncode')
		ls_deliverylocation		= dw_2.getitemstring(li_selectedcount,'deliverylocation')
		li_serialnofrom			= dw_2.getitemnumber(li_selectedcount,'serialnofrom')
		ls_plantdock				= dw_2.getitemstring(li_selectedcount,'plantdock')
		ls_lotno						= dw_2.getitemstring(li_selectedcount,'lotno')
		ls_segment1					= dw_2.getitemstring(li_selectedcount,'segment1')
		ls_segment2					= dw_2.getitemstring(li_selectedcount,'segment2')
		ls_segment3					= dw_2.getitemstring(li_selectedcount,'segment3')
		ls_suppliercode			= dw_2.getitemstring(li_selectedcount,'suppliercode')
		ls_tracedate				= dw_2.getitemstring(li_selectedcount,'tracedate')
	   ls_suppliername			= dw_2.getitemstring(li_selectedcount,'suppliername')		
	   ls_suppliercity			= dw_2.getitemstring(li_selectedcount,'suppliercity')
	   ls_supplierpostal			= dw_2.getitemstring(li_selectedcount,'supplierpostal')   	
	   ls_countryoforigin		= dw_2.getitemstring(li_selectedcount,'countryoforigin')
		li_labelcount				= dw_2.getitemnumber(li_selectedcount, 'labelcount')
		ls_invoiceno				= dw_2.getitemstring(li_selectedcount, 'invoiceno')
		ls_unit						= dw_2.getitemstring(li_selectedcount, 'unit')
//		SELECT suppliercode, inventorycode, weight, uselocation, itemcode, revisionno
//		  into :ls_suppliercode, :ls_inventorycode, :ll_weightheader, :ls_uselocation, :ls_itemcode, :ls_revisionno
//		 FROM tshiplabelheader
//		WHERE areacode 		  = :ls_areacode and
//		      divisioncode	  = :ls_divisioncode and
//				customercode 	  = :ls_customercode and
//				customeritemcode = :ls_customeritemcode and
//		      lotqty			  = :li_lotqty
//		using sqlpis  ;
//		
	if li_labelCount	<= 0 then
		continue
	end if
	li_Printcount ++
	
	li_row = 0
	for li_currentserial = 1	to Integer (li_labelcount)
		li_serialnofrom1 = li_serialnofrom + li_currentserial - 1
		for li_currentprintcount = 1 to ag_printcount
			li_row ++	
			li_sumitemcode = 104
			ls_customeritemcodebar = 'P'+ls_customeritemcode
//			for li_codeCount	= 1 to len(ls_CustomerItemCodebar)
//				if len(trim(mid(ls_customeritemcodebar,li_codecount,1))) = 0 then
//					li_sumitemcode = li_sumitemcode + (00 * li_codecount)
//				else
//					li_sumitemcode = li_sumitemcode + ((asc(mid(ls_customeritemcodebar,li_codecount,1))-32) * li_codecount)
//				end if
//			next
//			li_sumitemcode1 = li_sumitemcode / 103
////			li_remainitemcode = (li_sumitemcode - (li_sumitemcode1*103))+32
//			li_remainitemcode = (li_sumitemcode - (li_sumitemcode1*103))
//			if li_remainitemcode = 00 then
//				li_remainitemcode =	li_remainitemcode + 194
//			elseif li_remainitemcode > 194 then
//						li_remainitemcode =	li_remainitemcode + 100
//			else
//						li_remainitemcode =	li_remainitemcode + 32
//			end if
			li_remainitemcode = f_piss_convert_code128_remainder( 'B', trim(ls_customeritemcodebar) )
			dw_print.insertrow(li_row)
			dw_print.setitem(li_row,'customeritemcode',ls_customeritemcode)
			dw_print.setitem(li_row,'divisioncode',ls_divisioncode)
			dw_print.setitem(li_row,'remainitemcode',li_remainitemcode)
			dw_print.setitem(li_row,'customeritemname',ls_customeritemname)
			dw_print.setitem(li_row,'shipqty',li_shipqty)
			dw_print.setitem(li_row,'puchaseno',ls_puchaseno)
			dw_print.setitem(li_row,'revisionno',ls_revisionno)
			dw_print.setitem(li_row,'deliverylocation',ls_deliverylocation)
			dw_print.setitem(li_row,'divisioncode',ls_divisioncode)
			dw_print.setitem(li_row,'invoiceno',ls_invoiceno)
			dw_print.setitem(li_row,'serialnofrom',li_serialnofrom1)
			dw_print.setitem(li_row,'plantdock',ls_plantdock)
			dw_print.setitem(li_row,'lotno',ls_lotno)
			li_sumlotno = 104
			ls_lotnobar = '1T'+ls_lotno
//			for li_codeCount	= 1 to len(ls_lotnobar)
//				if len(trim(mid(ls_lotnobar,li_codecount,1))) = 0 then
//					li_sumlotno = li_sumlotno + (0 * li_codecount)
//				else
//					li_sumlotno = li_sumlotno + ((asc(mid(ls_lotnobar,li_codecount,1))-32) * li_codecount)
//				end if
//			next
//			li_sumlotno1 = li_sumlotno / 103
////			li_remainlotno = (li_sumlotno - (li_sumlotno1*103))+32
//			li_remainlotno = (li_sumlotno - (li_sumlotno1*103))
//			if li_remainlotno = 0 then
//				li_remainlotno =	li_remainlotno + 194
//			elseif li_remainlotno > 194 then
//						li_remainlotno =	li_remainlotno + 100
//			else
//						li_remainlotno =	li_remainlotno + 32
//			end if	
			li_remainlotno = f_piss_convert_code128_remainder( 'B', trim(ls_lotnobar) )
			dw_print.setitem(li_row,'remainlotno',li_remainlotno)
			dw_print.setitem(li_row,'segment1',ls_segment1)
			dw_print.setitem(li_row,'segment2',ls_segment2)
			dw_print.setitem(li_row,'segment3',ls_segment3)
			dw_print.setitem(li_row,'suppliercode',ls_suppliercode)
			dw_print.setitem(li_row,'tracedate',ls_tracedate)
			dw_print.setitem(li_row,'suppliername',ls_suppliername)
			dw_print.setitem(li_row,'suppliercity',ls_suppliercity)
			dw_print.setitem(li_row,'supplierpostal',ls_supplierpostal)
			dw_print.setitem(li_row,'countryoforigin',ls_countryoforigin)
			dw_print.setitem(li_row,'unit',ls_unit)
		next
	next
Next
if li_printcount > 0 then	

//	Long	ll_printjob
//	////ll_printjob	= PrintOPen()
//	////printSetup()
//	ll_printjob	= PrintOPen()
//	dw_print.modify("datawindow.Print.Orientation = 1" )
//	dw_print.Modify("datawindow.print.margin.left   = " + String( Integer(Trim(em_3.Text))*100 ))
//	dw_print.Modify("datawindow.print.margin.Top    = " + String( Integer(Trim(em_4.Text))*100 ))
//	
//	PrintDataWindow(ll_printjob, dw_print)
//	PrintClose(ll_printjob)
//	messagebox('확인', '출력하였습니다')

else
	messagebox('확인', 'Label정보가 존재 하지 않는 품목을 선택 하셨습니다.')
end if

return
				


end subroutine

on w_piss611u.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.uo_area=create uo_area
this.uo_division=create uo_division
this.gb_1=create gb_1
this.dw_2=create dw_2
this.st_3=create st_3
this.em_1=create em_1
this.dw_3=create dw_3
this.em_2=create em_2
this.st_2=create st_2
this.st_4=create st_4
this.em_3=create em_3
this.st_5=create st_5
this.em_4=create em_4
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.em_1
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.em_2
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.em_3
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.em_4
this.Control[iCurrent+15]=this.dw_print
end on

on w_piss611u.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.st_3)
destroy(this.em_1)
destroy(this.dw_3)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.em_3)
destroy(this.st_5)
destroy(this.em_4)
destroy(this.dw_print)
end on

event ue_postopen;call super::ue_postopen;dw_2.SetTransObject(SQLPIS)
dw_3.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

ib_open = True
iw_this.PostEvent("ue_reset")
em_2.text = '2'
em_3.text = '11'
em_4.text = '0'
end event

event ue_reset;call super::ue_reset;dw_2.ReSet()
dw_3.ReSet()

end event

event activate;call super::activate;dw_2.SetTransObject(SQLPIS)
dw_3.SetTransObject(SQLPIS)

end event

event resize;call super::resize;dw_2.Width = newwidth - ( dw_2.x + 20 ) 
dw_2.Height = newheight - ( dw_2.y + 1290 ) 
dw_3.Width = newwidth - ( dw_3.x + 20 ) 
dw_3.y = newheight - 1280
dw_3.Height = newheight - ( dw_3.y + 80 ) 
end event

event ue_insert;call super::ue_insert;string ls_customercode, ls_areacode, ls_divisioncode, ls_customeritemcode
string ls_itemname, ls_itemcode, ls_suppliercode, ls_suppliername, ls_segment1, ls_segment2
int li_selcount, li_rtn

If ii_currentrow <= 0 Then
	return
end if

li_rtn = MessageBox("라벨선택", "DELPHI용 : 확인, FORD용 : 취소 ~r " &
	+ " 를 선택하십시요.",Exclamation!, OKCancel!, 1)
if li_rtn = 1 then
	dw_3.dataobject = "d_piss611u_02"
	dw_3.settransobject(sqlpis)
else
	dw_3.dataobject = "d_piss611u_04"
	dw_3.settransobject(sqlpis)
end if
dw_3.reset()
li_selcount = dw_3.retrieve(uo_area.is_uo_areacode,uo_division.is_uo_divisioncode,&
				dw_2.object.customercode[ii_currentrow],&
				dw_2.object.customeritemcode[ii_currentrow],&
				dw_2.object.invoiceno[ii_currentrow],&
				dw_2.object.serialnofrom[ii_currentrow])
if li_selcount = 0 then
	dw_3.reset()
	dw_3.insertrow(0)
end if

ls_customercode		= dw_2.getitemstring(ii_currentrow, 'customercode')
ls_areacode				= dw_2.getitemstring(ii_currentrow, 'areacode')
ls_divisioncode 		= dw_2.getitemstring(ii_currentrow, 'divisioncode')
ls_customeritemcode	= dw_2.getitemstring(ii_currentrow, 'customeritemcode')
ls_itemcode 			= dw_2.getitemstring(ii_currentrow, 'itemcode')
ls_suppliercode 		= dw_2.getitemstring(ii_currentrow, 'suppliercode')
ls_suppliername 		= dw_2.getitemstring(ii_currentrow, 'suppliername')
ls_segment1 			= dw_2.getitemstring(ii_currentrow, 'segment1')
ls_segment2 			= dw_2.getitemstring(ii_currentrow, 'segment2')

dw_3.setitem(1,'customercode',	ls_customercode)
dw_3.setitem(1,'areacode',			ls_areacode)
dw_3.setitem(1,'divisioncode',	ls_divisioncode)
dw_3.setitem(1,'customeritemcode',ls_customeritemcode)

dw_3.setitem(1,'serialnofrom',0)
dw_3.setitem(1,'labelcount',0)
dw_3.setitem(1,'shipqty',0)
//dw_3.setitem(1,'puchaseno','')
dw_3.setitem(1,'tracedate','')
if li_rtn = 2 then
	select itemname into :ls_itemname
	from tmstitem
	where itemcode = :ls_itemcode using sqlpis;
	
	dw_3.setitem(1,'labelgubun','F')
	dw_3.setitem(1,'itemcode', ls_itemcode)
	dw_3.setitem(1,'partdesc', ls_itemname)
	dw_3.setitem(1,'suppliercode', ls_suppliercode)
	dw_3.setitem(1,'suppliername', ls_suppliername)
	dw_3.setitem(1,'segment1', ls_segment1)
	dw_3.setitem(1,'segment2', ls_segment2)
else
	dw_3.setitem(1,'labelgubun','G')
end if
dw_3.setfocus() 
 
uo_status.st_message.text = "해당정보를 입력하십시오"

end event

event ue_print;integer li_printcount, li_currow, li_rowcnt
string ls_labelgubun

li_printcount = integer(em_2.text)
li_rowcnt = dw_2.rowcount()

if li_rowcnt < 1 then
	return 0
end if

if isnull(li_printcount) then
	messagebox('확인','인쇄 매수 확인 하세요')
	return
end if

li_currow = dw_2.getselectedrow(0)
if li_currow < 1 then
	return 0
end if
ls_labelgubun = dw_2.getitemstring(li_currow,'labelgubun')
For li_currow = 1 To li_rowcnt
	if dw_2.isselected(li_currow) <> true then
		continue
	end if
	if ls_labelgubun <> dw_2.getitemstring(li_currow,'labelgubun') then
		Messagebox("확인","라벨구분이 동일한 것만 선택해 주십시요")
		return 0
	end if
Next

if ls_labelgubun = 'F' then
	dw_print.dataobject = 'd_piss611u_04p'
	wf_label_ford(li_printcount)
//	dw_print.print()
else
	dw_print.dataobject = 'd_piss611u_03p'
	wf_label_form(li_printcount)
end if	

//화면표시
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
	//끝


end event
event ue_retrieve;call super::ue_retrieve;string ls_invoiceno
long    l_n_row, l_n_currow

ls_invoiceno = em_1.text

uo_status.st_message.text	=	"조회중입니다."

dw_2.reset()
l_n_row = dw_2.retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode,ls_invoiceno)

if l_n_row > 0 then
	l_n_currow 	= dw_2.getrow()
	dw_2.selectrow(0,false)
	dw_2.selectrow(l_n_currow,true)	
	uo_status.st_message.text	=	'조회되었습니다.'
else
	uo_status.st_message.text	=	'조회할 자료가 없습니다.'  	
end if		
			
l_n_currow 	= dw_2.getrow()
dw_2.selectrow(0,false)
dw_2.selectrow(l_n_currow,true)	

setpointer(arrow!)


end event

event ue_save;call super::ue_save;
string	ls_areacode,			ls_divisioncode,				ls_customercode,&
			ls_customeritemcode,	ls_invoiceno,					ls_lotno,&
			ls_puchaseno,			ls_tracedate,					ls_unit,&
			ls_customerdivision,	ls_customerplantaddress,	ls_suppliercode,&
			ls_suppliername, 		ls_segment1, 					ls_segment2,&
			ls_segment3,			ls_customerplantcity,		ls_customerstate,&
			ls_customerpostal,	ls_plantdock,					ls_deliverylocation,&
			ls_revisionno, 		ls_suppliercity,				ls_supplierpostal,&
			ls_countryoforigin
integer	li_serialnofrom, li_serial, li_labelcount,	li_shipqty, li_selcount
string ls_customerplantaddress2, ls_customerno, ls_itemcode, ls_engalert
string ls_supplierno, ls_containerno, ls_partdesc, ls_partno
int li_grosswgt, li_standardpackqty, li_shift, li_lotsize
string ls_workcenter, ls_dockcode, ls_labelgubun, ls_message

dw_3.accepttext()
// Common Data Gathering
ls_unit						= dw_3.getitemstring(1, 'unit')
ls_customercode			= dw_3.getitemstring(1, 'customercode')
ls_suppliercode			= dw_3.getitemstring(1, 'suppliercode')
ls_suppliername			= dw_3.getitemstring(1, 'suppliername')
ls_segment1					= dw_3.getitemstring(1, 'segment1')
ls_segment2					= dw_3.getitemstring(1, 'segment2')
ls_areacode					= dw_3.getitemstring(1, 'areacode')
ls_divisioncode 			= dw_3.getitemstring(1, 'divisioncode')
ls_customeritemcode 		= dw_3.getitemstring(1, 'customeritemcode')
ls_customerdivision		= dw_3.getitemstring(1, 'customerdivision')
ls_customerplantaddress = dw_3.getitemstring(1, 'customerplantaddress')
ls_customerplantcity		= dw_3.getitemstring(1, 'customercity')
ls_customerstate			= dw_3.getitemstring(1, 'customerstate')
ls_plantdock				= dw_3.getitemstring(1, 'plantdock')
ls_deliverylocation		= dw_3.getitemstring(1, 'deliverylocation')
ls_suppliercity			= dw_3.getitemstring(1, 'suppliercity')
ls_countryoforigin		= dw_3.getitemstring(1, 'countryoforigin')
li_serialnofrom			= dw_3.getitemnumber(1, 'serialnofrom')
li_shipqty					= dw_3.getitemnumber(1, 'shipqty')
li_labelcount				= dw_3.getitemnumber(1, 'labelcount')
ls_tracedate				= dw_3.getitemstring(1, 'tracedate')
ls_labelgubun				= dw_3.getitemstring(1, 'labelgubun')
ls_invoiceno				= dw_2.object.invoiceno[ii_currentrow]
// Special Data Gathering
if dw_3.getitemstring(1, 'labelgubun') = 'F' then
	ls_customerplantaddress2 = dw_3.getitemstring(1, 'customerplantaddress2')
	ls_customerno				= dw_3.getitemstring(1, 'customerno')
	ls_engalert					= dw_3.getitemstring(1, 'engalert')
	ls_supplierno				= dw_3.getitemstring(1, 'supplierno')
	ls_containerno				= dw_3.getitemstring(1, 'containerno')
	ls_itemcode					= dw_3.getitemstring(1, 'itemcode')
	ls_partno					= dw_3.getitemstring(1, 'partno')
	ls_partdesc					= dw_3.getitemstring(1, 'partdesc')
	ls_workcenter				= dw_3.getitemstring(1, 'workcenter')
	ls_dockcode					= dw_3.getitemstring(1, 'dockcode')
	li_grosswgt					= dw_3.getitemnumber(1, 'grosswgt')
	li_standardpackqty		= dw_3.getitemnumber(1, 'standardpackqty')
	li_shift						= dw_3.getitemnumber(1, 'shift')
	li_lotsize					= dw_3.getitemnumber(1, 'lotsize')
else
	ls_customerpostal			= dw_3.getitemstring(1, 'customerpostal')
	ls_supplierpostal			= dw_3.getitemstring(1, 'supplierpostal')
	ls_segment3					= dw_3.getitemstring(1, 'segment3')
	ls_revisionno				= dw_3.getitemstring(1, 'revisionno')
	ls_lotno						= dw_3.getitemstring(1, 'lotno')
	ls_puchaseno				= dw_3.getitemstring(1, 'puchaseno')
end if
// Data Gathering End
if trim(f_dateedit(ls_tracedate)) = ''	then
	messagebox('확인','날짜 체계가 틀립니다.')
	return -1
end if

sqlpis.Autocommit = False

select isnull(count(*),0) into :li_selcount
from tlabelcustomer
WHERE customercode = :ls_customercode  using sqlpis ;

if sqlpis.sqlcode <> 0 then
	li_selcount = 0
end if

if li_selcount > 0 then
	update tlabelcustomer
	set	suppliercode	= :ls_suppliercode,
			suppliername	= :ls_suppliername,
			segment1			= :ls_segment1,
			segment2			= :ls_segment2,
			segment3			= :ls_segment3
	where	customercode = :ls_customercode  using sqlpis ;
	if sqlpis.sqlnrows = 0 then
		ls_message = "ERR01 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
else
	insert into
	tlabelcustomer(customercode, suppliercode,	suppliername,
						segment1,		segment2,			segment3)
	values(:ls_customercode,	:ls_suppliercode, :ls_suppliername,
				:ls_segment1, :ls_segment2, :ls_segment3)
				using sqlpis ;
	if sqlpis.sqlcode <> 0 then
		ls_message = "ERR02 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
end if
	
select count(*) into :li_selcount
from tlabelitem
WHERE areacode				= :ls_areacode and
		divisioncode		= :ls_divisioncode and
		customercode		= :ls_customercode and
		customeritemcode	= :ls_customeritemcode
		using sqlpis ;

if sqlpis.sqlcode <> 0 then
	li_selcount = 0
end if

if li_selcount > 0 then
	update tlabelitem
	set	itemcode					= :ls_itemcode,
			unit						= :ls_unit,
			customerdivision		= :ls_customerdivision,
			customerplantaddress	= :ls_customerplantaddress,
			customerplantaddress2 = :ls_customerplantaddress2,
			customerplantcity		= :ls_customerplantcity,
			customerstate			= :ls_customerstate,
			customerpostal			= :ls_customerpostal,
			plantdock				= :ls_plantdock,
			deliverylocation		= :ls_deliverylocation,
			revisionno				= :ls_revisionno,
			suppliercity			= :ls_suppliercity,
			supplierpostal			= :ls_supplierpostal,
			countryoforigin		= :ls_countryoforigin,
			labelgubun				= :ls_labelgubun,
			customerno				= :ls_customerno,
			supplierno				= :ls_supplierno,
			partno					= :ls_partno,
			partdesc					= :ls_partdesc,
			engalert					= :ls_engalert,
			containerno				= :ls_containerno,
			grosswgt					= :li_grosswgt,
			dockcode					= :ls_dockcode,
			standardpackqty		= :li_standardpackqty,
			workcenter				= :ls_workcenter,
			shift						= :li_shift,
			lotsize					= :li_lotsize
	where areacode				= :ls_areacode		 and
			divisioncode		= :ls_divisioncode and
			customercode		= :ls_customercode and
			customeritemcode	= :ls_customeritemcode  using sqlpis ;
	if sqlpis.sqlnrows = 0 then
		ls_message = "ERR03 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
else
	insert into tlabelitem
			(areacode,						divisioncode,				customercode,
			 customeritemcode,			unit,							customerdivision,
			 customerplantaddress,		customerplantcity,		customerstate,
			 customerpostal,				plantdock,					deliverylocation,
			 revisionno,					suppliercity,				supplierpostal,
		 	 countryoforigin,				labelgubun,					customerno,
			 supplierno,					itemcode,					partdesc,
			 engalert,						containerno,				grosswgt,
			 dockcode,						standardpackqty,			workcenter,
			 shift,							lotsize,						customerplantaddress2,
			 partno)		 
	values(:ls_areacode,					:ls_divisioncode,			:ls_customercode,
			 :ls_customeritemcode,		:ls_unit,					:ls_customerdivision,
			 :ls_customerplantaddress,	:ls_customerplantcity,	:ls_customerstate,
			 :ls_customerpostal,			:ls_plantdock,				:ls_deliverylocation,
			 :ls_revisionno,				:ls_suppliercity,			:ls_supplierpostal,
			 :ls_countryoforigin,		:ls_labelgubun,			:ls_customerno,
			 :ls_supplierno,				:ls_itemcode,				:ls_partdesc,
			 :ls_engalert,					:ls_containerno,			:li_grosswgt,
			 :ls_dockcode,					:li_standardpackqty,		:ls_workcenter,
			 :li_shift,						:li_lotsize,				:ls_customerplantaddress2,
			 :ls_partno)  
	using sqlpis ;
	if sqlpis.sqlcode <> 0 then
		ls_message = "ERR04 : " + sqlpis.sqlerrtext
		goto RollBack_
	end if
end if

//if li_serialnofrom = 0 or isnull(li_serialnofrom) then
	select isnull(sum(labelcount),0)	into :li_serial from tlabelcontainer
	where areacode				= 	:ls_areacode		 and
			divisioncode		=	:ls_divisioncode and
			customercode		=	:ls_customercode and
			customeritemcode	=	:ls_customeritemcode and
			invoiceno			=	:ls_invoiceno	using sqlpis ;
	
	if sqlpis.sqlcode <> 0 then
		li_serial = 0
	end if
	
	if li_serialnofrom = 0 then
		li_serialnofrom = li_serial + 1
	else
		li_serialnofrom = li_serialnofrom
	end if
	
	select count(*) into :li_selcount
	from tlabelcontainer
	where areacode				= :ls_areacode		 and
			divisioncode		= :ls_divisioncode and
			customercode		= :ls_customercode and
			customeritemcode	= :ls_customeritemcode and
			invoiceno			=	:ls_invoiceno		and
			serialnofrom		=	:li_serialnofrom	using sqlpis ;
	
	if sqlpis.sqlcode <> 0 then
		li_selcount = 0
	end if
	
	if li_selcount = 0 then
		insert	into tlabelcontainer
				(areacode,				divisioncode,			customercode,		customeritemcode,
				 invoiceno,				serialnofrom,			labelcount,			lotno,
				 shipqty,				puchaseno,				tracedate)		 
		values(:ls_areacode,			:ls_divisioncode,		:ls_customercode, :ls_customeritemcode,
				 :ls_invoiceno,		:li_serialnofrom,		:li_labelcount,	:ls_lotno,
				 :li_shipqty,			:ls_puchaseno,			:ls_tracedate)  using sqlpis ;
		if sqlpis.sqlcode <> 0 then
			ls_message = "ERR05 : " + sqlpis.sqlerrtext
			goto RollBack_
		end if
	else
		update	tlabelcontainer
		set	lotno					=	:ls_lotno,
				shipqty				=	:li_shipqty,
				labelcount			=  :li_labelcount,
				puchaseno			=	:ls_puchaseno,
				tracedate			=	:ls_tracedate
		where areacode				= :ls_areacode		 and
				divisioncode		= :ls_divisioncode and
				customercode		= :ls_customercode and
				customeritemcode	= :ls_customeritemcode and
				invoiceno			=	:ls_invoiceno		and
				serialnofrom		=	:li_serialnofrom	using sqlpis ;
		if sqlpis.sqlnrows = 0 then
			ls_message = "ERR06 : " + sqlpis.sqlerrtext
			goto RollBack_
		end if
	end if
//end if
Commit using sqlpis;
sqlpis.Autocommit = True
uo_status.st_message.text = '정상적으로 처리되었습니다.'
triggerevent("ue_retrieve")

RollBack_:
Rollback using sqlpis;
sqlpis.Autocommit = True
uo_status.st_message.text = ls_message

return 0
end event

event ue_delete;call super::ue_delete;long 	ll_currow
integer li_rtn
string ls_areacode, ls_divisioncode, ls_customercode, ls_customeritemcode, ls_invoiceno
integer li_serialnofrom

ll_currow = dw_2.getselectedrow(0)
ls_customercode			= dw_2.getitemstring(ll_currow, 'customercode')
ls_areacode					= dw_2.getitemstring(ll_currow, 'areacode')
ls_divisioncode			= dw_2.getitemstring(ll_currow, 'divisioncode')
ls_customeritemcode		= dw_2.getitemstring(ll_currow, 'customeritemcode')
ls_invoiceno				= dw_2.getitemstring(ll_currow, 'invoiceno')
li_serialnofrom			= dw_2.getitemnumber(ll_currow, 'serialnofrom')
li_rtn = messagebox("알림", "정말 삭제 하시겠습니까?",question!,yesno!,1)   //정말삭제하시겠습니까?
if li_rtn = 2 then
	uo_status.st_message.text = "삭제가 취소되었습니다."
	return 0
end if

delete from tlabelcontainer
	where areacode = :ls_areacode and
			divisioncode = :ls_divisioncode and
			customercode = :ls_customercode and
			customeritemcode = :ls_customeritemcode and
			invoiceno			=	:ls_invoiceno	and
			serialnofrom 		= :li_serialnofrom	
using sqlpis;

if sqlpis.sqlcode = 0 then
	commit using sqlpis;
	uo_status.st_message.text = "삭제되었습니다."
else
	rollback using sqlpis;
	uo_status.st_message.text = "err_d1; " + "삭제실패 정보시스템으로 연락바랍니다."
end if

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss611u
end type

type gb_2 from groupbox within w_piss611u
integer x = 2798
integer y = 36
integer width = 759
integer height = 128
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "여백"
end type

type uo_area from u_pisc_select_area within w_piss611u
integer x = 46
integer y = 76
integer taborder = 10
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;If ib_open Then
	dw_2.SetTransObject(SQLPIS)
	dw_3.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)


End If

end event

type uo_division from u_pisc_select_division within w_piss611u
integer x = 535
integer y = 76
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
	dw_2.SetTransObject(SQLPIS)
	dw_3.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
//	f_piss_retrieve_dddw_custcode(uo_customer.dw_1,'%','%',false,uo_customer.is_uo_custcode,uo_customer.is_uo_custname)

End If

end event

type gb_1 from groupbox within w_piss611u
integer x = 18
integer width = 3584
integer height = 192
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_2 from u_vi_std_datawindow within w_piss611u
integer x = 18
integer y = 204
integer width = 3584
integer height = 288
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_piss611u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_customercode, ls_areacode, ls_divisioncode,&
			ls_customeritemcode, ls_invoiceno, ls_labelgubun
integer	li_row
long ll_count
If currentrow <= 0 Then
	return
end if
ii_currentrow = currentrow

ls_customercode		= 	dw_2.getitemstring(currentrow, 'customercode')
ls_areacode				= 	dw_2.getitemstring(currentrow, 'areacode')
ls_divisioncode 		= 	dw_2.getitemstring(currentrow, 'divisioncode')
ls_customeritemcode	=	dw_2.getitemstring(currentrow, 'customeritemcode')
ls_invoiceno 			= 	dw_2.getitemstring(currentrow, 'invoiceno')
ls_labelgubun			= 	dw_2.getitemstring(currentrow, 'labelgubun')

dw_3.reset()
if ls_labelgubun = 'F' then
	dw_3.dataobject = 'd_piss611u_04'
	dw_3.settransobject(sqlpis)
else
	dw_3.dataobject = 'd_piss611u_02'
	dw_3.settransobject(sqlpis)
end if

select count(*) into :ll_count
from tlabelcontainer
where AreaCode				=	:ls_areacode			and
		DivisionCode		=	:ls_Divisioncode		and
		CustomerCode		=	:ls_customercode		and
		CustomerItemCode	=	:ls_customeritemcode	and
		InvoiceNo			=	:ls_invoiceno 			using sqlpis ;

if ll_count > 0 then			
	li_row	=	dw_3.retrieve(ls_areacode,			ls_divisioncode,&
									  ls_customercode,	ls_customeritemcode,&
									  dw_2.object.invoiceno[currentrow],&
									  dw_2.object.serialnofrom[currentrow])
	if li_row	=	0	then
		dw_3.setitem(1,'customercode',	ls_customercode)
		dw_3.setitem(1,'areacode',			ls_areacode)
		dw_3.setitem(1,'divisioncode',	ls_divisioncode)
//		dw_3.setitem(1,'customeritemcode',ls_customeritemcode)
	end if
	
	dw_3.setfocus() 
	uo_status.st_message.text	=	'조회되었습니다.'
else
	uo_status.st_message.text	=	'입력된 정보가 없습니다.'
end if	

end event

type st_3 from statictext within w_piss611u
integer x = 1147
integer y = 84
integer width = 375
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Invoice No:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_piss611u
integer x = 1513
integer y = 76
integer width = 457
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type dw_3 from datawindow within w_piss611u
integer x = 18
integer y = 1108
integer width = 3584
integer height = 564
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss611u_02"
borderstyle borderstyle = stylelowered!
end type

type em_2 from editmask within w_piss611u
integer x = 2551
integer y = 76
integer width = 142
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
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0"
end type

type st_2 from statictext within w_piss611u
integer x = 2094
integer y = 84
integer width = 457
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Label발행매수:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_piss611u
integer x = 2981
integer y = 92
integer width = 165
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "왼쪽:"
boolean focusrectangle = false
end type

type em_3 from editmask within w_piss611u
integer x = 3145
integer y = 76
integer width = 123
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
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0"
end type

type st_5 from statictext within w_piss611u
integer x = 3282
integer y = 92
integer width = 114
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
string text = "위:"
boolean focusrectangle = false
end type

type em_4 from editmask within w_piss611u
integer x = 3383
integer y = 76
integer width = 123
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
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0"
end type

type dw_print from datawindow within w_piss611u
boolean visible = false
integer x = 160
integer y = 516
integer width = 2907
integer height = 996
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss611u_04p"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

