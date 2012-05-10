$PBExportHeader$w_seq113u.srw
$PBExportComments$서열품 일괄출하
forward
global type w_seq113u from w_origin_sheet09
end type
type dw_1 from datawindow within w_seq113u
end type
type uo_2 from u_pisc_date_applydate_1 within w_seq113u
end type
type uo_1 from u_pisc_date_firstday within w_seq113u
end type
type st_1 from statictext within w_seq113u
end type
type cb_ship from commandbutton within w_seq113u
end type
type st_2 from statictext within w_seq113u
end type
type em_1 from editmask within w_seq113u
end type
type em_2 from editmask within w_seq113u
end type
type gb_1 from groupbox within w_seq113u
end type
type dw_sle302 from datawindow within w_seq113u
end type
type dw_tsrorder from datawindow within w_seq113u
end type
type dw_sle301 from datawindow within w_seq113u
end type
type dw_tsrheader from datawindow within w_seq113u
end type
type pb_excel from picturebutton within w_seq113u
end type
type uo_area from u_pisc_select_area within w_seq113u
end type
type uo_division from u_pisc_select_division within w_seq113u
end type
type uo_productgroup from u_seq_select_productgroup within w_seq113u
end type
type uo_rackgroup from u_seq_select_rackgroup within w_seq113u
end type
end forward

global type w_seq113u from w_origin_sheet09
integer height = 2724
string title = "서열품일괄출하"
dw_1 dw_1
uo_2 uo_2
uo_1 uo_1
st_1 st_1
cb_ship cb_ship
st_2 st_2
em_1 em_1
em_2 em_2
gb_1 gb_1
dw_sle302 dw_sle302
dw_tsrorder dw_tsrorder
dw_sle301 dw_sle301
dw_tsrheader dw_tsrheader
pb_excel pb_excel
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
uo_rackgroup uo_rackgroup
end type
global w_seq113u w_seq113u

type variables
string is_areacode,is_divisioncode,is_productgroup,is_rackgroup,is_shipdate,is_shipdate1,is_checkdate,is_checkseq
transaction sql1
 
end variables

forward prototypes
public subroutine wf_save (string fs_areacode, string fs_divisioncode, string fs_itemcode, long fn_shipqty)
public function boolean wf_ipis_tsrorder_insert (string fs_checksrno)
end prototypes

public subroutine wf_save (string fs_areacode, string fs_divisioncode, string fs_itemcode, long fn_shipqty);
end subroutine

public function boolean wf_ipis_tsrorder_insert (string fs_checksrno);long 		ln_rowcount,i,ln_shipqty,ln_status
string 	ls_areacode,ls_divisioncode,ls_shipdate,ls_max_shipsheetno,ls_seq,ls_srno
string	ls_custcode,ls_shipgubun,ls_shipsheetno,ls_checksrno,ls_return,ls_today,ls_time
datetime ld_nowtime

ld_nowtime 		= f_pisc_get_date_nowtime()
ls_today		 	= mid(string(ld_nowtime,'YYYY.MM.DD HH:MM:SS'),1,10)
ls_time		 	= mid(string(ld_nowtime,'YYYY.MM.DD HH:MM:SS'),12,5)
dw_sle302.reset()
dw_tsrorder.reset()
dw_sle301.reset()
dw_tsrheader.reset()
ln_rowcount	=	dw_sle302.retrieve(fs_checksrno)
if ln_rowcount < 1 then
	return false
end if 
//ln_status = dw_sle302.RowsCopy(1,ln_rowcount,Primary!, dw_tsrorder, 1, Primary!)
//ln_status = dw_sle302.RowsCopy(1,ln_rowcount,Primary!, dw_test, 1, Primary!)
for i = 1 to ln_rowcount
	dw_tsrorder.insertrow(0)
	dw_tsrorder.object.SRNo[i] = dw_sle302.object.compute_0001[i]
	dw_tsrorder.object.PCGubun[i] = dw_sle302.object.compute_0002[i]
	dw_tsrorder.object.PSRNo[i] = dw_sle302.object.compute_0003[i]
	dw_tsrorder.object.KitGubun[i] = dw_sle302.object.compute_0004[i]
	dw_tsrorder.object.SRAreaCode[i] = dw_sle302.object.compute_0005[i]
	dw_tsrorder.object.SRDivisionCode[i] = dw_sle302.object.compute_0006[i]
	dw_tsrorder.object.ShipGubun[i] = dw_sle302.object.compute_0007[i]
	dw_tsrorder.object.SRYear[i] = dw_sle302.object.compute_0008[i]
	dw_tsrorder.object.SRMonth[i] = dw_sle302.object.compute_0009[i]
	dw_tsrorder.object.SRSerial[i] = dw_sle302.object.compute_0010[i]
	dw_tsrorder.object.SRSplitCount[i] = dw_sle302.object.compute_0011[i]
	dw_tsrorder.object.AreaCode[i] = dw_sle302.object.compute_0012[i]
	dw_tsrorder.object.DivisionCode[i] = dw_sle302.object.compute_0013[i]
	dw_tsrorder.object.ProductGroup[i] = dw_sle302.object.compute_0014[i]
	dw_tsrorder.object.ModelGroup[i] = dw_sle302.object.compute_0015[i]
	dw_tsrorder.object.ProductCode[i] = dw_sle302.object.compute_0016[i]
	dw_tsrorder.object.ItemCode[i] = dw_sle302.object.compute_0017[i]
	dw_tsrorder.object.CustCode[i] = dw_sle302.object.compute_0018[i]
	dw_tsrorder.object.ApplyFrom[i] = dw_sle302.object.compute_0019[i]
	dw_tsrorder.object.ShipEditNo[i] = dw_sle302.object.compute_0020[i]
	dw_tsrorder.object.ShipOrderQty[i] = dw_sle302.object.compute_0021[i]
	dw_tsrorder.object.ShipRemainQty[i] = 0
	dw_tsrorder.object.ShipEndGubun[i] = 'Y'
	dw_tsrorder.object.SRCancelGubun[i] = dw_sle302.object.compute_0024[i]
	dw_tsrorder.object.CustomerItemNo[i] = dw_sle302.object.compute_0025[i]
	dw_tsrorder.object.ShipUsage[i] = dw_sle302.object.compute_0026[i]
	dw_tsrorder.object.CheckSRNo[i] = dw_sle302.object.compute_0027[i]
	dw_tsrorder.object.stcd[i] = dw_sle302.object.compute_0028[i]
	dw_tsrorder.object.orderno[i] = dw_sle302.object.compute_0029[i]
	dw_tsrorder.object.LastEmp[i] = dw_sle302.object.compute_0030[i]
	dw_tsrorder.object.Extd[i] = dw_sle302.object.compute_0031[i]
	dw_tsrorder.object.luprc[i] = dw_sle302.object.compute_0032[i]
	dw_tsrorder.object.Luamt[i] = dw_sle302.object.compute_0033[i]
	dw_tsrorder.object.Shipdate[i] = dw_sle302.object.compute_0019[i]
next
dw_tsrorder.accepttext()
if dw_tsrorder.update() <> 1 then
	messagebox("확인",sql1.sqlerrtext)
	return false
end if

ln_rowcount	=	0
ln_rowcount	=	dw_sle301.retrieve(fs_checksrno)
if ln_rowcount < 1 then
	return false
end if
//dw_sle301.RowsCopy(1,ln_rowcount,Primary!, dw_tsrheader, 1, Primary!)
for i = 1 to ln_rowcount
	dw_tsrheader.insertrow(0)
	dw_tsrheader.object.SRAreaCode[i] = dw_sle301.object.compute_0001[i]
	dw_tsrheader.object.SRDivisionCode[i] = dw_sle301.object.compute_0002[i]
	dw_tsrheader.object.ShipGubun[i] = dw_sle301.object.compute_0003[i]
	dw_tsrheader.object.SRYear[i] = dw_sle301.object.compute_0004[i]
	dw_tsrheader.object.SRMonth[i] = dw_sle301.object.compute_0005[i]
	dw_tsrheader.object.SRSerial[i] = dw_sle301.object.compute_0006[i]
	dw_tsrheader.object.SRSplitCount[i] = dw_sle301.object.compute_0007[i]
	dw_tsrheader.object.ShipDate[i] = dw_sle301.object.compute_0008[i]
	dw_tsrheader.object.SRConfirmDate[i] = dw_sle301.object.compute_0009[i]
	dw_tsrheader.object.InvoiceNo[i] = dw_sle301.object.compute_0010[i]
	dw_tsrheader.object.InvoiceDate[i] = dw_sle301.object.compute_0011[i]
	dw_tsrheader.object.MasterLCNo[i] = dw_sle301.object.compute_0012[i]
	dw_tsrheader.object.MasterDate[i] = dw_sle301.object.compute_0013[i]
	dw_tsrheader.object.LocalLCNo[i] = dw_sle301.object.compute_0014[i]
	dw_tsrheader.object.LocalLCDate[i] = dw_sle301.object.compute_0015[i]
	dw_tsrheader.object.ELNo1[i] = dw_sle301.object.compute_0016[i]
	dw_tsrheader.object.ELDate1[i] = dw_sle301.object.compute_0017[i]
	dw_tsrheader.object.ELNo2[i] = dw_sle301.object.compute_0018[i]
	dw_tsrheader.object.ELDate2[i] = dw_sle301.object.compute_0019[i]
	dw_tsrheader.object.CostGubun[i] = dw_sle301.object.compute_0020[i]
	dw_tsrheader.object.CheckSRNo[i] = dw_sle301.object.compute_0021[i]
	dw_tsrheader.object.PRTCd[i] = dw_sle301.object.compute_0022[i]
	dw_tsrheader.object.LastEmp[i] = dw_sle301.object.compute_0023[i]
	dw_tsrheader.object.seller[i] = dw_sle301.object.compute_0024[i]
	dw_tsrheader.object.consig[i] = dw_sle301.object.compute_0025[i]
	dw_tsrheader.object.buyer[i] = dw_sle301.object.compute_0026[i]
	dw_tsrheader.object.trans[i] = dw_sle301.object.compute_0027[i]
	dw_tsrheader.object.trdl[i] = dw_sle301.object.compute_0028[i]
	dw_tsrheader.object.dstn[i] = dw_sle301.object.compute_0029[i]
	dw_tsrheader.object.inputdate[i] = ls_today
	dw_tsrheader.object.inputtime[i] = ls_time
next
dw_tsrheader.accepttext()
if dw_tsrheader.update() <> 1 then
	messagebox("BB",sql1.sqlerrtext)
	return false
end if
// tshipsheet insert 및 자재 출하 insert
ln_rowcount	=	0
ln_rowcount	=	dw_tsrorder.rowcount()
for i = 1 to ln_rowcount 
	ls_custcode			=	dw_tsrorder.object.custcode[i]
	ls_areacode			=	dw_tsrorder.object.areacode[i]
	ls_divisioncode	=	dw_tsrorder.object.divisioncode[i]	
	ls_shipdate			=	dw_tsrorder.object.applyfrom[i]	
	ls_shipgubun 		= 	"O" // OEM 출하
	ls_srno 				= 	dw_tsrorder.object.srno[i]
	ln_shipqty 			= 	dw_tsrorder.object.shiporderqty[i]	
	if i = 1 then
		select max(shipsheetno)
		  into :ls_max_shipsheetno
		  from tshipsheet a,tsrorder b
		 where a.areacode = :ls_areacode
			and a.divisioncode = :ls_divisioncode
			and a.shipdate like substring(:ls_shipdate,1,7) + '%'
			and a.areacode = b.areacode
			and a.divisioncode = b.divisioncode
			and substring(a.shipsheetno,3,1) = :ls_shipgubun
			and a.srno = b.srno
		  using sql1;
		if ls_max_shipsheetno = '' or isnull(ls_max_shipsheetno) then
			ls_seq = '0000'
		else
			ls_seq = right(ls_max_shipsheetno,4) 
		end if
		f_pisc_get_string_add(ls_seq,ls_seq)
		ls_shipsheetno = ls_areacode + ls_divisioncode + ls_shipgubun + mid(ls_shipdate,4,1)  + mid(ls_shipdate,6,2) + ls_seq
	end if
	
	INSERT INTO TSHIPSHEET  
				 (ShipDate,AreaCode,DivisionCode,SRNo,TruckOrder,ShipSheetNo,
				  TruckNo,CustCode,PrintCount,shipqty,SheetPrintDate,
				  ConfirmFlag,ConfirmDate,SaleConfirmFlag,SaleConfirmDate,
				  LastEmp,LastDate,Deliveryflag)  
		VALUES (:ls_shipdate,:ls_areacode,:ls_divisioncode,:ls_srno,0,:ls_shipsheetno,
				  'zzzz',:ls_custcode,1,:ln_shipqty,:ls_shipdate,   
				  'Y',getdate(),'Y',getdate(),
				  'Y',getdate(),'Y' )
   using sql1;
	if sql1.sqlcode <> 0 then
		uo_status.st_message.text = "Tshipsheet insert시 오류가 발생하였습니다."
		return false
 	end if
next
SELECT PBSLE.SF_SEQ_03(:ls_shipsheetno,:fs_checksrno)
	INTO :ls_return from comm000 
WHERE aa = '1111'  Using sqlca ;
if sqlca.sqlcode <> 0 or trim(ls_return) <> '00000000000' then
	messagebox("CC",sqlca.sqlerrtext + ls_return + ls_shipsheetno )			
	return false
end if
return true
end function

on w_seq113u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_2=create uo_2
this.uo_1=create uo_1
this.st_1=create st_1
this.cb_ship=create cb_ship
this.st_2=create st_2
this.em_1=create em_1
this.em_2=create em_2
this.gb_1=create gb_1
this.dw_sle302=create dw_sle302
this.dw_tsrorder=create dw_tsrorder
this.dw_sle301=create dw_sle301
this.dw_tsrheader=create dw_tsrheader
this.pb_excel=create pb_excel
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.uo_rackgroup=create uo_rackgroup
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_2
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_ship
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.em_1
this.Control[iCurrent+8]=this.em_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.dw_sle302
this.Control[iCurrent+11]=this.dw_tsrorder
this.Control[iCurrent+12]=this.dw_sle301
this.Control[iCurrent+13]=this.dw_tsrheader
this.Control[iCurrent+14]=this.pb_excel
this.Control[iCurrent+15]=this.uo_area
this.Control[iCurrent+16]=this.uo_division
this.Control[iCurrent+17]=this.uo_productgroup
this.Control[iCurrent+18]=this.uo_rackgroup
end on

on w_seq113u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.cb_ship)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.gb_1)
destroy(this.dw_sle302)
destroy(this.dw_tsrorder)
destroy(this.dw_sle301)
destroy(this.dw_tsrheader)
destroy(this.pb_excel)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.uo_rackgroup)
end on

event ue_retrieve;call super::ue_retrieve;setpointer(hourglass!)

datetime ld_fromtime,ld_totime
string	ls_seqfrom,ls_seqto
string	ls_seqdate, ls_seqdate1
string 	ls_msg

ls_seqfrom	=	string(integer(em_1.text),"0000")
ls_seqto		=	string(integer(em_2.text),"0000")
SetNull(ld_fromtime); SetNull(ld_totime);

select Top 1 seqtime into :ld_fromtime from tseqprodlog
where convert(varchar(10), seqtime, 102) = :is_shipdate 
		and productgroup = :is_productgroup and seqno = :ls_seqfrom 
		and shipyn = 'Y' and status <> 'SKIP'
Order By SeqTime
using sql1 ;

if sql1.sqlcode = -1 then
	ls_msg = " 일괄 출하 기준일 체크중 DB 에러가 발생했읍니다.~r~n 에러내용: " + sql1.SQLErrText
	MessageBox("에러", ls_msg, Exclamation!)
	return
end if

if isNull(ld_fromtime) then
	ls_msg = " 기준일: "+is_shipdate+"(SEQTIME 기준)~r~n SEQNO:" +ls_seqfrom &
						+"~r~n는 존재하지 않거나 출하되지 않았읍니다."
	messagebox("확인", ls_msg)
	return
end if

select Top 1 seqtime into :ld_totime from tseqprodlog
where convert(varchar(10), seqtime, 102) = :is_shipdate1
		and productgroup = :is_productgroup and seqno = :ls_seqto 
		and shipyn = 'Y' and status <> 'SKIP'
Order By SeqTime
using sql1;

if sql1.sqlcode = -1 then
	ls_msg = " 일괄 출하 종료일 체크중 DB 에러가 발생했읍니다.~r~n 에러내용: " + sql1.SQLErrText
	MessageBox("에러", ls_msg, Exclamation!)
	return
end if

if isNull(ld_totime) then
	ls_msg = " 종료일: "+is_shipdate1+"(SEQTIME 기준)~r~n SEQNO:"+ls_seqto &
						+"~r~n는 존재하지 않거나 출하되지 않았읍니다."
	messagebox("확인", ls_msg)
	return
end if

dw_1.reset()
if dw_1.retrieve(is_Areacode,is_divisioncode,is_productgroup,is_rackgroup,ld_fromtime,ld_totime) > 0 then
	cb_ship.visible = true
	cb_ship.enabled = true
	uo_status.st_message.text = "해당 기간 서열생산품의 출하 Scan 실적이 집계되었습니다."
else
	cb_ship.visible = false
	cb_ship.enabled = false
	uo_status.st_message.text = "해당 기간 서열생산품의 출하 Scan 실적이 없습니다."
end if

////테스트 용도
//cb_ship.visible = false
//cb_ship.enabled = false
////
end event

event open;call super::open;long ln_position
string ls_ipaddr,ls_database,ls_logpass,ls_computer
ln_position = lastpos(g_s_ipaddr,'.')
ls_ipaddr   = mid(g_s_ipaddr,1,ln_position - 1)
ls_ipaddr   = ProfileString(gs_inifile,"IPADDR",ls_ipaddr," ")
if ls_ipaddr <> 'KUN' and ls_ipaddr <> 'BUP' then
	close(this)
end if
RegistryGet("HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\VxD\VNETSUP", "ComputerName", ls_computer)
ls_database    	= trim(ProfileString(gs_inifile,ls_ipaddr,"DataBase",			" "))
ls_logpass     	= trim(ProfileString(gs_inifile,ls_ipaddr,"LogPass",		" "))
gs_servername	 	= ProfileString(gs_inifile,ls_ipaddr,"ServerName",	" ")
sql1 = CREATE transaction 
SQL1.ServerName 	= gs_servername
SQL1.DBMS       	= ProfileString(gs_inifile,ls_ipaddr,"DBMS",			" ")
SQL1.Database   	= ls_database
SQL1.LogID      	= ProfileString(gs_inifile,ls_ipaddr,"LogId",			" ")
SQL1.LogPass    	= ls_logpass
SQL1.DbParm     	= "appname='IPIS for KDAC', host='" + ls_computer + "'"
SQL1.AutoCommit 	= True
gs_appname	    	= ProfileString(gs_inifile,"PARAMETER","AppName",            " ")
connect using SQL1;

select top 1 isnull(todate,''),isnull(toseq,'') into :is_checkdate,:is_checkseq from tseqlastship
order by todate desc ,toseq desc
using sql1 ;
if is_checkseq <> '' then
	if is_checkseq = '9999' then
		em_1.text = '1'
	else
		em_1.text = string(integer(is_checkseq) + 1,"0000")
	end if
end if
if is_checkdate <> '' then
	uo_1.sle_date.text = is_checkdate
	is_shipdate			 = is_checkdate
end if


end event

event close;call super::close;disconnect using sql1 ;
destroy sql1 
end event

event activate;call super::activate;dw_1.settransobject(sql1)
dw_tsrheader.settransobject(sql1)
dw_tsrorder.settransobject(sql1)
end event

type uo_status from w_origin_sheet09`uo_status within w_seq113u
end type

type dw_1 from datawindow within w_seq113u
integer x = 27
integer y = 276
integer width = 4325
integer height = 2196
boolean bringtotop = true
string title = "none"
string dataobject = "d_seq_endship_01"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_2 from u_pisc_date_applydate_1 within w_seq113u
event destroy ( )
integer x = 1495
integer y = 56
boolean bringtotop = true
end type

on uo_2.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;is_shipdate1 = is_uo_date

end event

type uo_1 from u_pisc_date_firstday within w_seq113u
integer x = 59
integer y = 56
integer height = 84
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_date_firstday::destroy
end on

event ue_select;call super::ue_select;is_shipdate = is_uo_date
end event

type st_1 from statictext within w_seq113u
integer x = 1079
integer y = 68
integer width = 91
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
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_ship from commandbutton within w_seq113u
boolean visible = false
integer x = 3456
integer y = 88
integer width = 654
integer height = 128
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "일괄출하"
end type

event clicked;uo_status.st_message.text = ""

if messagebox("확인","서열정보 일괄출하를 실행하시겠습니까 ? ",question!,yesno!,2) = 2 then
	uo_status.st_message.text = "서열정보 일괄출하가 취소되었습니다."
   return 
end if

setpointer(hourglass!)

long 		ln_rowcount,i,ln_shipqty,ln_count,ln_unitcost,ln_sno 
string 	ls_seqfrom,ls_seqto
string	ls_areacode,ls_divisioncode,ls_itemcode,ls_custcode,ls_custitemcode,ls_old_areacode,ls_old_divisioncode
string 	ls_close_date ,ls_item_check,ls_return,ls_checksrno='',ls_comparesrno='0',ls_rmreturn,ls_applymonth

ls_applymonth	=	mid(is_shipdate,1,7)
ls_seqfrom		=	string(integer(em_1.text),"0000")
ls_seqto			=	string(integer(em_2.text),"0000")
select count(*) into :ln_count from tseqlastship
	where	applymonth	=	:ls_applymonth	and	productgroup = :is_rackgroup and 
			(	(	fromdate	> :is_shipdate	or (	fromdate	=	:is_shipdate	and	fromseq	>=	:ls_seqfrom	)	)	or
				(	todate	> :is_shipdate	or (	todate	=	:is_shipdate	and	toseq		>=	:ls_seqfrom)	)	)	
using sql1	;
if ln_count > 0 then
	messagebox("확인","해당기간의 서열번호는 이미 일괄 출하 작업이 완료됐습니다.")
	return
end if

ln_rowcount		=	dw_1.rowcount()
ls_close_date 	= 	f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
f_sysdate()
if (mid(g_s_date,1,4) + "." + mid(g_s_date,5,2))  <> mid(ls_close_date,1,7) then
	messagebox("확인","이미 마감된 월입니다.")
	return
end if

sqlca.autocommit 	= false
sql1.autocommit = false
for i = 1 to ln_rowcount
	ls_areacode			=	dw_1.object.tseqmstitem_areacode[i]	
	ls_divisioncode	=	dw_1.object.tseqmstitem_divisioncode[i]	
	ls_itemcode			=	dw_1.object.tseqmstitem_itemcode[i]	
	ls_custcode			=	dw_1.object.tseqmstitem_customercode[i]		
	ls_custitemcode	=	dw_1.object.tseqmstitem_customeritemcode[i]		
	ln_shipqty			=	dw_1.object.compute_0011[i]		
	//제품입고 IPIS S/P 호출 시작
	declare exec_tstock procedure for sp_seq_tstock_insert
		@ps_empno		=	:g_s_empno,
		@ps_area			=	:ls_areacode,
		@ps_div			=	:ls_divisioncode,
		@ps_itemcode	=	:ls_itemcode,
		@ps_dept			=	:g_s_deptcd,
		@ps_inputqty	=	:ln_shipqty,
		@ps_return		=	'' OutPut Using sql1 ;
		
	execute exec_tstock ;
	FETCH exec_tstock into :ls_return ;
	CLOSE exec_tstock ;
	
	if len(ls_return) <> 11 then
		messagebox("제품입고 Error","품번: " + ls_itemcode + "에러코드: " + ls_return)
		rollback using sqlca ;
		rollback using sql1 	;
		sqlca.autocommit 	= true		
		sql1.autocommit 	= true
		uo_status.st_message.text = "서열정보 일괄출하 작업중 오류발생.시스템개발팀으로 문의바랍니다(1)"
		return
	end if
//제품입고 IPIS S/P 호출 끝 	

//제품입고 AS/400 S/P 호출 시작 
	SELECT PBINV.SF_SEQ_RM(	:ls_areacode,:ls_divisioncode,:ls_itemcode,:g_s_deptcd,:ls_return,:ln_shipqty,
									:g_s_date,:g_s_date,'1',:g_s_empno)
		INTO :ls_rmreturn from comm000 
	WHERE aa = '1111'  Using sqlca ;
	if sqlca.sqlcode <> 0 or ls_rmreturn <> '0' then
		messagebox("SF_SEQ_RM",sqlca.sqlerrtext)
		rollback using sqlca ;		
		rollback using sql1 	;
		sqlca.autocommit 	= true		
		sql1.autocommit 	= true
		uo_status.st_message.text = "서열정보 일괄출하 작업중 오류발생.시스템개발팀으로 문의바랍니다(2)"		
		return 
	end if
//제품입고 AS/400 S/P 호출 끝


//S/R AS/400 S/P 호출 시작 
//	if ls_areacode <> ls_old_areacode or ls_divisioncode <> ls_old_divisioncode then
//		if i > 1 then
//			if wf_ipis_tsrorder_insert(ls_checksrno) = false then
//				rollback using sqlca ;		
//				rollback using sql1 ;
//				sqlca.autocommit 	= true		
//				sql1.autocommit = true
//				uo_status.st_message.text = "서열정보 일괄출하 작업중 오류발생.시스템개발팀으로 문의바랍니다(3)"				
//				return 
//			end if
//		end if
//		ln_sno 			= 1
//		ls_checksrno 	= ''
//	else
		ln_sno ++
//	end if
		
	SELECT PBSLE.SF_SEQ_01(	:ls_areacode,:ls_divisioncode,:ls_custcode,:ls_custitemcode,:ln_shipqty,:g_s_date,:ln_sno,
									:g_s_empno,:g_s_date,:g_s_ipaddr,:g_s_macaddr,'1','4','C',:ls_checksrno )
		INTO :ls_checksrno from comm000 
	WHERE aa = '1111'  Using sqlca ;
	if sqlca.sqlcode <> 0  then
		messagebox("SF_SEQ_01",sqlca.sqlerrtext)
		rollback using sqlca 	;		
		rollback using sql1 	;
		sqlca.autocommit 	= true		
		sql1.autocommit = true
		uo_status.st_message.text = "서열정보 일괄출하 작업중 오류발생.시스템개발팀으로 문의바랍니다(4)"		
		return 
	end if
	ls_old_areacode		=	ls_areacode
	ls_old_divisioncode	=	ls_divisioncode
//S/R AS/400 S/P 호출 끝
next
//	if i = ln_rowcount then 
if wf_ipis_tsrorder_insert(ls_checksrno) = false then
	rollback using sqlca ;		
	rollback using sql1 ;
	sqlca.autocommit 	= true		
	sql1.autocommit 	= true
	uo_status.st_message.text = "서열정보 일괄출하 작업중 오류발생.시스템개발팀으로 문의바랍니다(5)"			
	return
end if
//	end if
insert into tseqlastship
values ( :ls_applymonth,:is_rackgroup,:is_shipdate,:ls_seqfrom,:is_shipdate1,:ls_seqto,:g_s_empno,getdate())
using sql1 ;
if sql1.sqlcode <> 0  then
	rollback using sqlca 	;		
	rollback using sql1 	;
	sqlca.autocommit 	= true		
	sql1.autocommit = true
	uo_status.st_message.text = "서열정보 일괄출하 작업중 오류발생.시스템개발팀으로 문의바랍니다(6)"	
	return 
end if
commit using sqlca ;		
commit using sql1 ;
sqlca.autocommit 	= true		
sql1.autocommit = true
uo_status.st_message.text = "서열정보 일괄출하 작업이 정상적으로 완료되었습니다."
end event
type st_2 from statictext within w_seq113u
integer x = 1239
integer y = 68
integer width = 261
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "종료일:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_1 from editmask within w_seq113u
integer x = 754
integer y = 56
integer width = 242
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean autoskip = true
end type

event constructor;this.text = '1'
end event

type em_2 from editmask within w_seq113u
integer x = 1957
integer y = 56
integer width = 242
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean autoskip = true
end type

event constructor;this.text = '9999'
end event

type gb_1 from groupbox within w_seq113u
integer x = 27
integer width = 4325
integer height = 264
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_sle302 from datawindow within w_seq113u
integer x = 311
integer y = 340
integer width = 686
integer height = 400
boolean enabled = false
string title = "none"
string dataobject = "d_seq_endship_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_tsrorder from datawindow within w_seq113u
integer x = 1074
integer y = 340
integer width = 686
integer height = 400
boolean enabled = false
string title = "none"
string dataobject = "d_seq_endship_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;//MESSAGEBOX("aa",SQLSYNTAX)
end event

type dw_sle301 from datawindow within w_seq113u
integer x = 315
integer y = 760
integer width = 686
integer height = 400
boolean enabled = false
string title = "none"
string dataobject = "d_seq_endship_05"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_tsrheader from datawindow within w_seq113u
integer x = 1061
integer y = 756
integer width = 686
integer height = 400
boolean enabled = false
string dataobject = "d_seq_endship_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_excel from picturebutton within w_seq113u
integer x = 4146
integer y = 88
integer width = 155
integer height = 132
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_1)



end event

type uo_area from u_pisc_select_area within w_seq113u
event destroy ( )
integer x = 123
integer y = 164
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;//idw_normal.SetTransObject(sqlseq)
//idw_minap.SetTransObject(sqlseq)
//idw_sennap.SetTransObject(sqlseq)
//idw_move.SetTransObject(sqlseq)
//dw_truckorder.SetTransObject(sqlseq)
//idw_normal.reset()
//idw_minap.reset()
//idw_sennap.reset()
//idw_move.reset()
//dw_truckorder.reset()
//
string ls_divisionname,ls_divisionnameeng,ls_productname, ls_rackname
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_seq_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',false,is_productgroup,ls_productname)
f_seq_retrieve_dddw_rackgroup(uo_rackgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',True,is_rackgroup,ls_rackname)

//
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng,ls_productname
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)




end event

type uo_division from u_pisc_select_division within w_seq113u
event destroy ( )
integer x = 718
integer y = 164
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;string ls_productname, ls_rackname
is_divisioncode = is_uo_divisioncode
f_seq_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',false,is_productgroup,ls_productname)
f_seq_retrieve_dddw_rackgroup(uo_rackgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',True,is_rackgroup,ls_rackname)

end event

event ue_post_constructor;call super::ue_post_constructor;string ls_productname
is_divisioncode = is_uo_divisioncode
if is_areacode = 'B' or is_areacode = 'K' then
	f_seq_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productname)
end if
end event

type uo_productgroup from u_seq_select_productgroup within w_seq113u
event destroy ( )
integer x = 1390
integer y = 164
integer taborder = 50
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_seq_select_productgroup::destroy
end on

event ue_select;call super::ue_select;string ls_rackname
is_productgroup = is_uo_productgroup
//select top 1 isnull(todate,''),isnull(toseq,'') into :is_checkdate,:is_checkseq from tseqlastship
//where productgroup = :is_productgroup
//order by todate desc ,toseq desc
//using sql1 ;
//if is_checkseq <> '' then
//	if is_checkseq = '9999' then
//		em_1.text = '1'
//	else
//		em_1.text = string(integer(is_checkseq) + 1,"0000")
//	end if
//end if
//if is_checkdate <> '' then
//	uo_1.sle_date.text = is_checkdate
//end if


f_seq_retrieve_dddw_rackgroup(uo_rackgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',True,is_rackgroup,ls_rackname)


end event

type uo_rackgroup from u_seq_select_rackgroup within w_seq113u
integer x = 2405
integer y = 164
integer height = 76
integer taborder = 30
boolean bringtotop = true
end type

on uo_rackgroup.destroy
call u_seq_select_rackgroup::destroy
end on

event ue_select;call super::ue_select;string ls_rackname

is_rackgroup = is_uo_rackgroup

end event

event destructor;call super::destructor;call u_seq_select_rackgroup::destroy
end event

