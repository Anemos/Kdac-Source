$PBExportHeader$w_piss614u.srw
forward
global type w_piss614u from w_ipis_sheet01
end type
type gb_2 from groupbox within w_piss614u
end type
type uo_area from u_pisc_select_area within w_piss614u
end type
type uo_division from u_pisc_select_division within w_piss614u
end type
type gb_1 from groupbox within w_piss614u
end type
type dw_2 from u_vi_std_datawindow within w_piss614u
end type
type dw_3 from datawindow within w_piss614u
end type
type em_2 from editmask within w_piss614u
end type
type st_2 from statictext within w_piss614u
end type
type st_4 from statictext within w_piss614u
end type
type em_3 from editmask within w_piss614u
end type
type st_5 from statictext within w_piss614u
end type
type em_4 from editmask within w_piss614u
end type
type dw_print from datawindow within w_piss614u
end type
type st_6 from statictext within w_piss614u
end type
type st_7 from statictext within w_piss614u
end type
type sle_itno from singlelineedit within w_piss614u
end type
type em_1 from editmask within w_piss614u
end type
type uo_customer from u_piss_select_custcode within w_piss614u
end type
end forward

global type w_piss614u from w_ipis_sheet01
gb_2 gb_2
uo_area uo_area
uo_division uo_division
gb_1 gb_1
dw_2 dw_2
dw_3 dw_3
em_2 em_2
st_2 st_2
st_4 st_4
em_3 em_3
st_5 st_5
em_4 em_4
dw_print dw_print
st_6 st_6
st_7 st_7
sle_itno sle_itno
em_1 em_1
uo_customer uo_customer
end type
global w_piss614u w_piss614u

type variables
Boolean	ib_open
int ii_currentrow
string is_revno
end variables

forward prototypes
public subroutine wf_label_form (integer ag_printcount)
end prototypes

public subroutine wf_label_form (integer ag_printcount);string	ls_suppliername, ls_suppliercity, ls_supplierpostal, ls_suppliercode
string   ls_customername, ls_customeraddr1, ls_customeraddr2, ls_plantdock, ls_deliverylocation
string   ls_customeritemcode, ls_customeritemname, ls_revisionno, ls_tracedate, ls_countryoforigin
string   ls_purchaseno, ls_pkgid, ls_pkglistno, ls_lotno, ls_plantno, ls_suppliercity1
boolean	lb_null = False
int		li_currow, li_selectedcount, li_currentprintcount, li_currentserial, li_shipqty,&
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
	ls_suppliername			= dw_2.getitemstring(li_selectedcount,'suppliername')		
	ls_suppliercity			= dw_2.getitemstring(li_selectedcount,'suppliercity')
	ls_suppliercity1			= dw_2.getitemstring(li_selectedcount,'suppliercity1')
	ls_suppliercode			= dw_2.getitemstring(li_selectedcount,'suppliercode')
	ls_customername			= dw_2.getitemstring(li_selectedcount,'customername')
	ls_customeraddr1			= dw_2.getitemstring(li_selectedcount,'customeraddr1')
	ls_customeraddr2			= dw_2.getitemstring(li_selectedcount,'customeraddr2')
	ls_plantdock				= dw_2.getitemstring(li_selectedcount,'plantdock')
	ls_plantno					= dw_2.getitemstring(li_selectedcount,'customerdivision')
	ls_deliverylocation		= dw_2.getitemstring(li_selectedcount,'deliverylocation')
	ls_customeritemcode		= dw_2.getitemstring(li_selectedcount,'customeritemcode')
	ls_customeritemname		= dw_2.getitemstring(li_selectedcount,'customeritemname')
	ls_revisionno				= dw_2.getitemstring(li_selectedcount,'revisionno')
	ls_tracedate				= dw_2.getitemstring(li_selectedcount,'tracedate')
	ls_countryoforigin		= dw_2.getitemstring(li_selectedcount,'countryoforigin')
	li_shipqty					= dw_2.getitemnumber(li_selectedcount,'shipqty')
	ls_purchaseno				= dw_2.getitemstring(li_selectedcount,'purchaseno')
	ls_pkgid						= trim(dw_2.getitemstring(li_selectedcount,'pkgid'))
	ls_pkglistno				= trim(dw_2.getitemstring(li_selectedcount,'packinglistno'))
	ls_lotno						= dw_2.getitemstring(li_selectedcount,'lotno')
	if is_revno = 'R01' then
		if ls_customeritemcode = '19020618' or ls_customeritemcode = '892940' then
			ls_lotno = 'A02' + ls_lotno + '1'
		elseif ls_customeritemcode = '19020706' or ls_customeritemcode = '889955' then
			ls_lotno = 'C02' + ls_lotno + '1'
		elseif ls_customeritemcode = '19020707' or ls_customeritemcode = '889956' then
			ls_lotno = 'C02' + ls_lotno + '1'
		elseif ls_customeritemcode = '8400080' or ls_customeritemcode = '897755' then
			ls_lotno = 'D02' + ls_lotno + '1'
		else
			Messagebox("알림", "라벨 Revision에 맞지 않는 품번이 선택되어 있습니다.")
			dw_print.reset()
			li_printcount = 0
			exit
		end if
	else
		ls_lotno = 'C02' + ls_lotno + '1'
	end if
	
	li_serialnofrom			= dw_2.getitemnumber(li_selectedcount,'serialnofrom')
	li_labelcount				= dw_2.getitemnumber(li_selectedcount, 'labelcount')

	if li_labelCount	<= 0 then
		continue
	end if
	li_Printcount ++
	
	for li_currentserial = 1	to Integer (li_labelcount)
		li_serialnofrom1 = li_serialnofrom + li_currentserial - 1
		ls_pkgid = string(li_serialnofrom1)
		for li_currentprintcount = 1 to ag_printcount
			li_currow = dw_print.insertrow(0)
			dw_print.setitem(li_currow,'suppliername',ls_suppliername)
			dw_print.setitem(li_currow,'suppliercity',ls_suppliercity)
			dw_print.setitem(li_currow,'supplierpostal',ls_suppliercity1)
			dw_print.setitem(li_currow,'suppliercode',ls_suppliercode)
			dw_print.setitem(li_currow,'customername',ls_customername)
			dw_print.setitem(li_currow,'customeraddr1',ls_customeraddr1)
			dw_print.setitem(li_currow,'customeraddr2',ls_customeraddr2)
			dw_print.setitem(li_currow,'plantdock',ls_plantdock)
			dw_print.setitem(li_currow,'customerdivision',ls_plantno)
			dw_print.setitem(li_currow,'deliverylocation',ls_deliverylocation)
			dw_print.setitem(li_currow,'customeritemname',ls_customeritemname)
			dw_print.setitem(li_currow,'revisionno',ls_revisionno)
			dw_print.setitem(li_currow,'tracedate', string(date(string(ls_tracedate,"@@@@-@@-@@")),"MM/DD/YY"))
			dw_print.setitem(li_currow,'countryoforigin',ls_countryoforigin)
			dw_print.setitem(li_currow,'customeritemcode',ls_customeritemcode)
			dw_print.setitem(li_currow,'shipqty',li_shipqty)
			dw_print.setitem(li_currow,'purchaseno',ls_purchaseno)
			dw_print.setitem(li_currow,'pkgid',String(Integer(ls_pkgid), "00000"))
			dw_print.setitem(li_currow,'pkglistno',ls_pkglistno)
			dw_print.setitem(li_currow,'lotno',ls_lotno)
			// Calculate Barcode by code128
			dw_print.setitem(li_currow,'customeritemcodebar', &
				char(204) + f_piss_convert_code128( 'B', 'P' + trim(ls_customeritemcode) ) + char(206))
			dw_print.setitem(li_currow,'shipqtybar', &
				char(204) + f_piss_convert_code128( 'B', 'Q' + String(li_shipqty) ) + char(206))
			dw_print.setitem(li_currow,'purchasenobar', &
				char(204) + f_piss_convert_code128( 'B', 'K' + trim(ls_purchaseno) ) + char(206))
			if is_revno = 'R01' then
				dw_print.setitem(li_currow,'pkglistnobar', &
					char(204) + f_piss_convert_code128( 'B', '3S' + trim(ls_pkglistno) ) + char(206))
			else
				dw_print.setitem(li_currow,'pkgidbar', &
					char(204) + f_piss_convert_code128( 'B', '3S' + ls_pkgid ) + char(206))
				dw_print.setitem(li_currow,'pkglistnobar', &
					char(204) + f_piss_convert_code128( 'B', '11K' + trim(ls_pkglistno) ) + char(206))
			end if
			dw_print.setitem(li_currow,'lotnobar', &
				char(204) + f_piss_convert_code128( 'B', '1T' + trim(ls_lotno) ) + char(206))
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
on w_piss614u.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.uo_area=create uo_area
this.uo_division=create uo_division
this.gb_1=create gb_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.em_2=create em_2
this.st_2=create st_2
this.st_4=create st_4
this.em_3=create em_3
this.st_5=create st_5
this.em_4=create em_4
this.dw_print=create dw_print
this.st_6=create st_6
this.st_7=create st_7
this.sle_itno=create sle_itno
this.em_1=create em_1
this.uo_customer=create uo_customer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.em_2
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.em_3
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.em_4
this.Control[iCurrent+13]=this.dw_print
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.st_7
this.Control[iCurrent+16]=this.sle_itno
this.Control[iCurrent+17]=this.em_1
this.Control[iCurrent+18]=this.uo_customer
end on

on w_piss614u.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.em_3)
destroy(this.st_5)
destroy(this.em_4)
destroy(this.dw_print)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.sle_itno)
destroy(this.em_1)
destroy(this.uo_customer)
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

f_piss_retrieve_dddw_custcode(uo_customer.dw_1,'%','%',true,uo_customer.is_uo_custcode,uo_customer.is_uo_custname)
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
int li_selcount

If ii_currentrow <= 0 Then
	if uo_customer.is_uo_custcode = '%' then
		uo_status.st_message.text = "거래처를 선택하십시요"
		return -1
	end if
	dw_3.reset()
	dw_3.reset()
	dw_3.insertrow(0)
	dw_3.Object.customeritemcode.Protect=0
	dw_3.Modify("customeritemcode.background.color = 16777215")
	dw_3.setitem(1,'customercode',	uo_customer.is_uo_custcode)
	dw_3.setitem(1,'areacode',			uo_area.is_uo_areacode)
	dw_3.setitem(1,'divisioncode',	uo_division.is_uo_divisioncode)
	dw_3.setitem(1,'customeritemcode', sle_itno.text)
	
	dw_3.setitem(1,'serialnofrom',0)
	dw_3.setitem(1,'labelcount',0)
	dw_3.setitem(1,'shipqty',0)
	dw_3.setitem(1,'puchaseno','')
	dw_3.setitem(1,'tracedate','')
	dw_3.setfocus() 
 
	uo_status.st_message.text = "해당정보를 입력하십시오"
	return 0
end if


dw_3.reset()
li_selcount = dw_3.retrieve(uo_area.is_uo_areacode,uo_division.is_uo_divisioncode, &
				dw_2.object.customercode[ii_currentrow], &
				dw_2.object.customeritemcode[ii_currentrow], &
				dw_2.object.serialnofrom[ii_currentrow])
if li_selcount = 0 then
	dw_3.reset()
	dw_3.insertrow(0)
	dw_3.Object.customeritemcode.Protect=1
	dw_3.Modify("customeritemcode.background.color = 12632256")
else
	dw_3.Object.customeritemcode.Protect=0
	dw_3.Modify("customeritemcode.background.color = 16777215")
end if

ls_customercode		= dw_2.getitemstring(ii_currentrow, 'customercode')
ls_areacode				= dw_2.getitemstring(ii_currentrow, 'areacode')
ls_divisioncode 		= dw_2.getitemstring(ii_currentrow, 'divisioncode')
ls_customeritemcode	= dw_2.getitemstring(ii_currentrow, 'customeritemcode')

dw_3.setitem(1,'customercode',	ls_customercode)
dw_3.setitem(1,'areacode',			ls_areacode)
dw_3.setitem(1,'divisioncode',	ls_divisioncode)
dw_3.setitem(1,'customeritemcode',' ')

dw_3.setitem(1,'serialnofrom',0)
dw_3.setitem(1,'labelcount',0)
dw_3.setitem(1,'shipqty',0)
dw_3.setitem(1,'puchaseno','')
dw_3.setitem(1,'tracedate','')



dw_3.setfocus() 
 
uo_status.st_message.text = "해당정보를 입력하십시오"

end event

event ue_print;integer li_printcount, li_selectedrow
string ls_customeritemcode

li_printcount = integer(em_2.text)
li_selectedrow = dw_2.getselectedrow(0)

if isnull(li_printcount) or li_selectedrow < 1 then
	messagebox('확인','출력데이타선택 또는 인쇄 매수 확인 하세요')
	return 0
end if

// Label DWO Setup
ls_customeritemcode		= dw_2.getitemstring(li_selectedrow,'customeritemcode')
if ls_customeritemcode = '19020618' or ls_customeritemcode = '892940' or &
		ls_customeritemcode = '8400080' or ls_customeritemcode = '897755' or &
		ls_customeritemcode = '19020706' or ls_customeritemcode = '889955' or &
		ls_customeritemcode = '19020707' or ls_customeritemcode = '889956' then
	dw_print.dataobject = 'd_piss614u_04p'
	is_revno = 'R01'
else
	dw_print.dataobject = 'd_piss614u_03p'
	is_revno = 'R00'
end if

wf_label_form(li_printcount)

window 	l_to_open
str_easy l_str_prt

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_print
//l_str_prt.title = "완성품별 사용실적"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)	

end event
event ue_retrieve;call super::ue_retrieve;string ls_tracedate, ls_custitno, ls_custcode
long    l_n_row, l_n_currow

em_1.getdata(ls_tracedate)
if f_dateedit(ls_tracedate) = space(8) then
	ls_tracedate = '%'
else
	ls_tracedate = ls_tracedate + '%'
end if
ls_custitno = trim(sle_itno.text)
if f_spacechk(ls_custitno) = -1 then
	ls_custitno = '%'
else
	ls_custitno = ls_custitno + '%'
end if
ls_custcode = uo_customer.is_uo_custcode

uo_status.st_message.text	=	"조회중입니다."

dw_2.reset()
l_n_row = dw_2.retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode,ls_custcode, ls_custitno,ls_tracedate)

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
			ls_customeritemcode,	ls_packinglistno,				ls_lotno,&
			ls_puchaseno,			ls_tracedate,					ls_customerplantaddress1,&
			ls_customerdivision,	ls_customerplantaddress,	ls_suppliercode,&
			ls_suppliername,		ls_customerplantcity,		ls_customerstate,&
			ls_customerpostal,	ls_plantdock,					ls_deliverylocation,&
			ls_revisionno, 		ls_suppliercity,				ls_suppliercity1,&
			ls_supplierpostal,	ls_countryoforigin, 			ls_error, &
			ls_customeritemname
integer	li_serialnofrom,	li_labelcount,	li_shipqty, li_selcount
dw_3.accepttext()

ls_error = 'ok'

ls_customercode			= dw_3.getitemstring(1, 'customercode')
ls_suppliercode			= dw_3.getitemstring(1, 'suppliercode')
ls_suppliername			= dw_3.getitemstring(1, 'suppliername')
ls_areacode					= dw_3.getitemstring(1, 'areacode')
ls_divisioncode 			= dw_3.getitemstring(1, 'divisioncode')
ls_customeritemcode 		= dw_3.getitemstring(1, 'customeritemcode')
ls_customeritemname 		= dw_3.getitemstring(1, 'customeritemname')
ls_customerdivision		= dw_3.getitemstring(1, 'customerdivision')
ls_customerplantaddress = dw_3.getitemstring(1, 'customerplantaddress')
ls_customerplantaddress1 = dw_3.getitemstring(1, 'customerplantaddress1')
ls_customerplantcity		= dw_3.getitemstring(1, 'customerplantcity')
ls_customerstate			= dw_3.getitemstring(1, 'customerstate')
ls_customerpostal			= dw_3.getitemstring(1, 'customerpostal')
ls_plantdock				= dw_3.getitemstring(1, 'plantdock')
ls_deliverylocation		= dw_3.getitemstring(1, 'deliverylocation')
ls_revisionno				= dw_3.getitemstring(1, 'revisionno')
ls_suppliercity			= dw_3.getitemstring(1, 'suppliercity')
ls_suppliercity1			= dw_3.getitemstring(1, 'suppliercity1')
ls_supplierpostal			= dw_3.getitemstring(1, 'supplierpostal')
ls_countryoforigin		= dw_3.getitemstring(1, 'countryoforigin')
li_serialnofrom			= dw_3.getitemnumber(1, 'serialnofrom')
ls_lotno						= dw_3.getitemstring(1, 'lotno')
li_shipqty					= dw_3.getitemnumber(1, 'shipqty')
li_labelcount				= dw_3.getitemnumber(1, 'labelcount')
ls_puchaseno				= dw_3.getitemstring(1, 'puchaseno')
ls_tracedate				= dw_3.getitemstring(1, 'tracedate')
ls_packinglistno			= dw_3.getitemstring(1, 'packinglistno')

if isnull(ls_packinglistno) or ls_packinglistno = '' then
	messagebox('확인','Packing List No를 입력 바랍니다')
	return
end if

if isnull(ls_suppliercode) or ls_suppliercode = '' then
	messagebox('확인','공급자코드 입력 바랍니다')
	return
end if
			
if isnull(ls_suppliername) or ls_suppliername = '' then
	messagebox('확인','공급자명 입력 바랍니다')
	return
end if

if isnull(ls_revisionno) or ls_revisionno = '' then
	messagebox('확인','Revision No 입력 바랍니다')
	return
end if

if isnull(ls_customerdivision) or ls_customerdivision = '' then
	messagebox('확인','Plant No를 입력 바랍니다')
	return
end if

if isnull(ls_Customerplantaddress) or ls_Customerplantaddress = '' then
	messagebox('확인','거래처 주소1 입력 바랍니다')
	return
end if

if isnull(ls_suppliercity) or ls_suppliercity = '' then
	messagebox('확인','공급자 주소1 입력 바랍니다')
	return
end if

if isnull(ls_countryoforigin) or ls_countryoforigin = '' then
	messagebox('확인','원산지 입력 바랍니다')
	return
end if

if isnull(li_labelcount) or li_labelcount = 0 then
	messagebox('확인','Label 매수 입력 바랍니다')
	return
end if

if isnull(li_shipqty) or li_shipqty = 0 then
	messagebox('확인','수용수 입력 바랍니다')
	return
end if

if isnull(ls_puchaseno) or ls_puchaseno = '' then
	messagebox('확인','P/O No 입력 바랍니다')
	return
end if


if isnull(ls_tracedate) or ls_tracedate = '' then
	messagebox('확인','제조일 입력 바랍니다')
	return
end if
if trim(f_dateedit(ls_tracedate)) = ''	then
	messagebox('확인','날짜 체계가 틀립니다.')
	return -1
end if

select isnull(count(*),0) into :li_selcount
from tmstcustomer
where custcode = :ls_customercode 
using sqlpis;
if li_selcount < 1 then
	messagebox('확인','해당거래처가 존재하지 않습니다.')
	return -1
end if

select isnull(count(*),0) into :li_selcount
from TDRACUSTOMER
WHERE customercode = :ls_customercode  using sqlpis ;

if sqlpis.sqlcode <> 0 then
	li_selcount = 0
end if

if li_selcount > 0 then
	update TDRACUSTOMER
	set	suppliercode	= :ls_suppliercode,
			suppliername	= :ls_suppliername
	where	customercode = :ls_customercode  using sqlpis ;
else
	insert into
	TDRACUSTOMER(customercode, suppliercode,	suppliername)
	values(:ls_customercode,	:ls_suppliercode, :ls_suppliername)
				using sqlpis ;
end if
	
select count(*) into :li_selcount
from TDRAITEM
WHERE areacode				= :ls_areacode and
		divisioncode		= :ls_divisioncode and
		customercode		= :ls_customercode and
		customeritemcode	= :ls_customeritemcode
		using sqlpis ;

if sqlpis.sqlcode <> 0 then
	li_selcount = 0
end if

Sqlpis.Autocommit = false
if li_selcount > 0 then
	update TDRAITEM
	set	customeritemname			= :ls_customeritemname,
			customerdivision			= :ls_customerdivision,
			customerplantaddress		= :ls_customerplantaddress,
			customerplantaddress1	= :ls_customerplantaddress1,
			customerplantcity			= :ls_customerplantcity,
			customerstate				= :ls_customerstate,
			customerpostal				= :ls_customerpostal,
			plantdock					= :ls_plantdock,
			deliverylocation			= :ls_deliverylocation,
			revisionno					= :ls_revisionno,
			suppliercity				= :ls_suppliercity,
			suppliercity1				= :ls_suppliercity1,
			supplierpostal				= :ls_supplierpostal,
			countryoforigin			= :ls_countryoforigin
	where areacode				= :ls_areacode		 and
			divisioncode		= :ls_divisioncode and
			customercode		= :ls_customercode and
			customeritemcode	= :ls_customeritemcode  using sqlpis ;
else
	insert into TDRAITEM
			(areacode,						divisioncode,				customercode,
			 customeritemcode,			customerdivision,			customerplantaddress1,
			 customerplantaddress,		customerplantcity,		customerstate,
			 customerpostal,				plantdock,					deliverylocation,
			 revisionno,					suppliercity,				suppliercity1,			
			 supplierpostal,				countryoforigin, 			customeritemname)		 
	values(:ls_areacode,					:ls_divisioncode,			:ls_customercode,
			 :ls_customeritemcode,		:ls_customerdivision,	:ls_customerplantaddress1,
			 :ls_customerplantaddress,	:ls_customerplantcity,	:ls_customerstate,
			 :ls_customerpostal,			:ls_plantdock,				:ls_deliverylocation,
			 :ls_revisionno,				:ls_suppliercity,			:ls_suppliercity1,
			 :ls_supplierpostal,			:ls_countryoforigin,		:ls_customeritemname )  
	using sqlpis ;
end if

if sqlpis.sqlcode <> 0 then
	ls_error = 'err'
end if

if li_serialnofrom = 0 or isnull(li_serialnofrom) then
	select isnull(max(serialnofrom + labelcount),0)	into :li_serialnofrom from TDRADETAIL
	where areacode				= 	:ls_areacode		 and
			divisioncode		=	:ls_divisioncode and
			customercode		=	:ls_customercode and
			customeritemcode	=	:ls_customeritemcode
	using sqlpis ;

	if sqlpis.sqlcode <> 0 then
		li_serialnofrom = 0
	end if

	li_serialnofrom = li_serialnofrom + 1

	insert	into TDRADETAIL
			(areacode,				divisioncode,			customercode,		customeritemcode,
			 packinglistno,		serialnofrom,			labelcount,			lotno,
			 shipqty,				puchaseno,				tracedate)		 
	values(:ls_areacode,			:ls_divisioncode,		:ls_customercode, :ls_customeritemcode,
			 :ls_packinglistno,	:li_serialnofrom,		:li_labelcount,	:ls_lotno,
			 :li_shipqty,			:ls_puchaseno,			:ls_tracedate)  using sqlpis ;
else
	update	TDRADETAIL
	set	packinglistno		= :ls_packinglistno,
			lotno					=	:ls_lotno,
			shipqty				=	:li_shipqty,
			puchaseno			=	:ls_puchaseno,
			tracedate			=	:ls_tracedate
	where areacode				= :ls_areacode		 and
			divisioncode		= :ls_divisioncode and
			customercode		= :ls_customercode and
			customeritemcode	= :ls_customeritemcode and
			serialnofrom		=	:li_serialnofrom	using sqlpis ;
end if

if sqlpis.sqlcode =	0 and ls_error = 'ok' then
	commit using sqlpis;
	sqlpis.Autocommit = True
	uo_status.st_message.text = '저장이 되었습니다.'
	triggerevent("ue_retrieve")
else 
	rollback using sqlpis;
	sqlpis.Autocommit = True
	uo_status.st_message.text = '저장이 실패했습니다.'
end if	

end event

event ue_delete;call super::ue_delete;long 	ll_currow
integer li_rtn
string ls_areacode, ls_divisioncode, ls_customercode, ls_customeritemcode
integer li_serialnofrom

ll_currow = dw_2.getselectedrow(0)
ls_customercode			= dw_2.getitemstring(ll_currow, 'customercode')
ls_areacode					= dw_2.getitemstring(ll_currow, 'areacode')
ls_divisioncode			= dw_2.getitemstring(ll_currow, 'divisioncode')
ls_customeritemcode		= dw_2.getitemstring(ll_currow, 'customeritemcode')
li_serialnofrom			= dw_2.getitemnumber(ll_currow, 'serialnofrom')
li_rtn = messagebox("알림", "정말 삭제 하시겠습니까?",question!,yesno!,1)   //정말삭제하시겠습니까?
if li_rtn = 2 then
	uo_status.st_message.text = "삭제가 취소되었습니다."
	return 0
end if

Sqlpis.Autocommit = False
delete from TDRADETAIL
	where areacode = :ls_areacode and
			divisioncode = :ls_divisioncode and
			customercode = :ls_customercode and
			customeritemcode = :ls_customeritemcode and
			serialnofrom 		= :li_serialnofrom	
using sqlpis;

if sqlpis.sqlcode = 0 then
	commit using sqlpis;
	Sqlpis.Autocommit = True
	uo_status.st_message.text = "삭제되었습니다."
else
	rollback using sqlpis;
	Sqlpis.Autocommit = False
	uo_status.st_message.text = "err_d1; " + "삭제실패 정보시스템으로 연락바랍니다."
end if

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss614u
end type

type gb_2 from groupbox within w_piss614u
integer x = 2757
integer y = 36
integer width = 768
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

type uo_area from u_pisc_select_area within w_piss614u
integer x = 69
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

type uo_division from u_pisc_select_division within w_piss614u
integer x = 613
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

type gb_1 from groupbox within w_piss614u
integer x = 18
integer width = 3589
integer height = 296
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_2 from u_vi_std_datawindow within w_piss614u
integer x = 18
integer y = 348
integer width = 3584
integer height = 288
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_piss614u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_customercode, ls_areacode, ls_divisioncode,&
			ls_customeritemcode, ls_invoiceno
integer	li_row
long ll_count
If currentrow <= 0 Then
	return
end if
ii_currentrow = currentrow

ls_customercode		= dw_2.getitemstring(currentrow, 'customercode')
ls_areacode				= dw_2.getitemstring(currentrow, 'areacode')
ls_divisioncode 		= dw_2.getitemstring(currentrow, 'divisioncode')
ls_customeritemcode	=	dw_2.getitemstring(currentrow, 'customeritemcode')

dw_3.reset()

select count(*) into :ll_count
from TDRADETAIL
where AreaCode				=	:ls_areacode			and
		DivisionCode		=	:ls_Divisioncode		and
		CustomerCode		=	:ls_customercode		and
		CustomerItemCode	=	:ls_customeritemcode	
		using sqlpis ;

if ll_count > 0 then			
	li_row	=	dw_3.retrieve(ls_areacode,			ls_divisioncode,&
									  ls_customercode,	ls_customeritemcode,&
									  dw_2.object.serialnofrom[currentrow])
	if li_row	=	0	then	
		dw_3.setitem(1,'customercode',	ls_customercode)
		dw_3.setitem(1,'areacode',			ls_areacode)
		dw_3.setitem(1,'divisioncode',	ls_divisioncode)
		dw_3.setitem(1,'customeritemcode',ls_customeritemcode)
	end if
	
	dw_3.Object.customeritemcode.Protect=1
	dw_3.Modify("customeritemcode.background.color = 12632256")
	dw_3.setfocus() 
	uo_status.st_message.text	=	'조회되었습니다.'
else
	uo_status.st_message.text	=	'입력된 정보가 없습니다.'
end if	

end event

type dw_3 from datawindow within w_piss614u
integer x = 18
integer y = 1108
integer width = 3584
integer height = 564
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss614u_02"
borderstyle borderstyle = stylelowered!
end type

type em_2 from editmask within w_piss614u
integer x = 2565
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

type st_2 from statictext within w_piss614u
integer x = 2085
integer y = 84
integer width = 462
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

type st_4 from statictext within w_piss614u
integer x = 2903
integer y = 84
integer width = 165
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
string text = "왼쪽:"
boolean focusrectangle = false
end type

type em_3 from editmask within w_piss614u
integer x = 3072
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
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0"
end type

type st_5 from statictext within w_piss614u
integer x = 3246
integer y = 84
integer width = 119
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
string text = "위:"
boolean focusrectangle = false
end type

type em_4 from editmask within w_piss614u
integer x = 3351
integer y = 76
integer width = 142
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

type dw_print from datawindow within w_piss614u
boolean visible = false
integer x = 160
integer y = 716
integer width = 2907
integer height = 372
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss614u_03p"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_piss614u
integer x = 1189
integer y = 188
integer width = 411
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
string text = "거래처품번 :"
boolean focusrectangle = false
end type

type st_7 from statictext within w_piss614u
integer x = 2277
integer y = 188
integer width = 283
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
string text = "발행일 :"
boolean focusrectangle = false
end type

type sle_itno from singlelineedit within w_piss614u
integer x = 1595
integer y = 176
integer width = 599
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
borderstyle borderstyle = stylelowered!
end type

type em_1 from editmask within w_piss614u
integer x = 2555
integer y = 176
integer width = 457
integer height = 80
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
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####.##.##"
end type

type uo_customer from u_piss_select_custcode within w_piss614u
event destroy ( )
integer x = 37
integer y = 184
integer taborder = 40
boolean bringtotop = true
end type

on uo_customer.destroy
call u_piss_select_custcode::destroy
end on

