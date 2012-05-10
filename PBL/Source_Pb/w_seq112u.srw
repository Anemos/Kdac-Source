$PBExportHeader$w_seq112u.srw
$PBExportComments$물류센터입고관리
forward
global type w_seq112u from w_origin_sheet09
end type
type sle_1 from singlelineedit within w_seq112u
end type
type dw_1 from datawindow within w_seq112u
end type
type dw_tsrorder from datawindow within w_seq112u
end type
type dw_inv601 from datawindow within w_seq112u
end type
type st_text from statictext within w_seq112u
end type
type pb_excel from picturebutton within w_seq112u
end type
type gb_1 from groupbox within w_seq112u
end type
end forward

global type w_seq112u from w_origin_sheet09
integer height = 2724
string title = "물류센터입고관리"
sle_1 sle_1
dw_1 dw_1
dw_tsrorder dw_tsrorder
dw_inv601 dw_inv601
st_text st_text
pb_excel pb_excel
gb_1 gb_1
end type
global w_seq112u w_seq112u

type variables
string is_areacode,is_divisioncode 
transaction sql1
end variables

forward prototypes
public function boolean wf_tsrorder_insert (string fs_checkslno, string fs_date)
end prototypes

public function boolean wf_tsrorder_insert (string fs_checkslno, string fs_date);long 		ln_rowcount,i,j=10,ln_shipqty,ln_status
string 	ls_areacode,ls_divisioncode,ls_shipdate,ls_max_shipsheetno,ls_seq,ls_srno,ls_today,ls_time
string	ls_custcode,ls_shipgubun,ls_shipsheetno,ls_checksrno,ls_return,ls_xplant1,ls_div1,ls_xplant,ls_dudt
datetime ld_nowtime

dw_Inv601.reset()
dw_tsrorder.reset()
dw_Inv601.SETTRANSOBJECT(sQLCA)
dw_tsrorder.SETTRANSOBJECT(sQLPIS)

ln_rowcount	=	dw_Inv601.retrieve(fs_checkslno)
if ln_rowcount < 1 then
//	rs_errmsg = "이체번호: "+fs_checkslno+"에 대한 데이터가 생성되지 않았읍니다.(Inv601)"
	return false
end if 

for i = 1 to ln_rowcount
	dw_tsrorder.insertrow(0)
	dw_tsrorder.object.SRNo[i] = dw_Inv601.object.compute_0001[i]
	dw_tsrorder.object.PCGubun[i] = dw_Inv601.object.compute_0002[i]
	dw_tsrorder.object.PSRNo[i] = dw_Inv601.object.compute_0003[i]
	dw_tsrorder.object.KitGubun[i] = dw_Inv601.object.compute_0004[i]
	dw_tsrorder.object.SRAreaCode[i] = dw_Inv601.object.compute_0005[i]
	dw_tsrorder.object.SRDivisionCode[i] = dw_Inv601.object.compute_0006[i]
	dw_tsrorder.object.ShipGubun[i] = dw_Inv601.object.compute_0007[i]
	dw_tsrorder.object.SRYear[i] = dw_Inv601.object.compute_0008[i]
	dw_tsrorder.object.SRMonth[i] = dw_Inv601.object.compute_0009[i]
	dw_tsrorder.object.SRSerial[i] = dw_Inv601.object.compute_0010[i]
	dw_tsrorder.object.SRSplitCount[i] = dw_Inv601.object.compute_0011[i]
	dw_tsrorder.object.AreaCode[i] = dw_Inv601.object.compute_0012[i]
	dw_tsrorder.object.DivisionCode[i] = dw_Inv601.object.compute_0013[i]
	dw_tsrorder.object.ProductGroup[i] = dw_Inv601.object.compute_0014[i]
	dw_tsrorder.object.ModelGroup[i] = dw_Inv601.object.compute_0015[i]
	dw_tsrorder.object.ProductCode[i] = dw_Inv601.object.compute_0016[i]
	dw_tsrorder.object.ItemCode[i] = dw_Inv601.object.compute_0017[i]
	dw_tsrorder.object.CustCode[i] = dw_Inv601.object.compute_0018[i]
	dw_tsrorder.object.ApplyFrom[i] = fs_date
	dw_tsrorder.object.ShipEditNo[i] = dw_Inv601.object.compute_0020[i]
	dw_tsrorder.object.ShipOrderQty[i] = dw_Inv601.object.compute_0021[i]
	dw_tsrorder.object.ShipRemainQty[i] = dw_Inv601.object.compute_0022[i]
	dw_tsrorder.object.ShipEndGubun[i] = dw_Inv601.object.compute_0023[i]
	dw_tsrorder.object.SRCancelGubun[i] = dw_Inv601.object.compute_0024[i]
	dw_tsrorder.object.CustomerItemNo[i] = dw_Inv601.object.compute_0025[i]
	dw_tsrorder.object.ItemClass[i] = dw_Inv601.object.compute_0026[i]
	dw_tsrorder.object.ItemBuySource[i] = dw_Inv601.object.compute_0027[i]
	dw_tsrorder.object.MoveLotQty[i] = dw_Inv601.object.compute_0028[i]
	dw_tsrorder.object.MoveRequireNo[i] = dw_Inv601.object.compute_0029[i]
	dw_tsrorder.object.MoveAreaCode[i] = dw_Inv601.object.compute_0030[i]
	dw_tsrorder.object.MoveDivisionCode[i] = dw_Inv601.object.compute_0031[i]
	dw_tsrorder.object.ShipUsage[i] = dw_Inv601.object.compute_0032[i]
	dw_tsrorder.object.CheckSRNo[i] = dw_Inv601.object.compute_0033[i]
	dw_tsrorder.object.stcd[i] = dw_Inv601.object.compute_0034[i]
	dw_tsrorder.object.LastEmp[i] = dw_Inv601.object.compute_0035[i]

next
ls_xplant1 	= 	dw_tsrorder.object.SRAreaCode[ln_rowcount]
ls_div1 		= 	dw_tsrorder.object.SRDivisionCode[ln_rowcount]
ls_xplant   = 	dw_tsrorder.object.MoveAreaCode[ln_rowcount] + dw_tsrorder.object.MoveDivisionCode[ln_rowcount]
ls_dudt		=	dw_tsrorder.object.ApplyFrom[ln_rowcount]

dw_tsrorder.accepttext()
if dw_tsrorder.update() <> 1 then
//	rs_errmsg = "이체번호: "+fs_checkslno+"에 대한 S/R ORDER 업데이트중 에러가 발생했읍니다.(TSROrder)"&
//					+"~r~n에러내용:"+SQLPIS.sqlerrtext
	return false
end if
ld_nowtime 		= f_pisc_get_date_nowtime()
ls_today		 	= mid(string(ld_nowtime,'YYYY.MM.DD HH:MM:SS'),1,10)
ls_time		 	= mid(string(ld_nowtime,'YYYY.MM.DD HH:MM:SS'),12,5)
insert into tsrheader
(	SRAreaCode,		SRDivisionCode,		ShipGubun, 		
	SRYear, 		SRMonth, 		SRSerial,		SRSplitCount,
	ShipDate, 		CheckSRNo,		LastEmp , inputdate, inputtime	)
values	( :ls_xplant1,		:ls_div1,		'M',			
          '0','0','001',:ls_xplant,:ls_dudt,:fs_checkslno,'SYSTEM' ,:ls_today,:ls_time )
using sqlpis ;
if sqlpis.sqlcode <> 0 then
	messagebox("확인",SQLPIS.sqlerrtext)
	return false
end if

return true

end function

on w_seq112u.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.dw_1=create dw_1
this.dw_tsrorder=create dw_tsrorder
this.dw_inv601=create dw_inv601
this.st_text=create st_text
this.pb_excel=create pb_excel
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_tsrorder
this.Control[iCurrent+4]=this.dw_inv601
this.Control[iCurrent+5]=this.st_text
this.Control[iCurrent+6]=this.pb_excel
this.Control[iCurrent+7]=this.gb_1
end on

on w_seq112u.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.dw_1)
destroy(this.dw_tsrorder)
destroy(this.dw_inv601)
destroy(this.st_text)
destroy(this.pb_excel)
destroy(this.gb_1)
end on

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
//messagebox("AA",gs_servername)


end event

event close;call super::close;disconnect using sql1 ;
destroy sql1 
end event

event activate;call super::activate;dw_1.settransobject(sqlpis)
dw_tsrorder.SetTransObject(SQLPIS)
dw_Inv601.SetTransObject(SQLCA)

end event

type uo_status from w_origin_sheet09`uo_status within w_seq112u
end type

type sle_1 from singlelineedit within w_seq112u
integer x = 110
integer y = 104
integer width = 992
integer height = 160
integer taborder = 10
boolean bringtotop = true
integer textsize = -26
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 0
textcase textcase = upper!
integer limit = 11
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_shipsheetno,ls_customercode,ls_customeritemcode,ls_itemcode,ls_partid,ls_srnoinv,ls_extd
string ls_areacode,ls_divisioncode,ls_srno,ls_today,ls_checksrno,ls_shipplandate,ls_return,ls_slno 
string ls_bareacode,ls_bdivisioncode,ls_bdate,ls_bdate1,ls_today08,ls_message
long ln_count,ln_shipqty,i,ln_rowcount,ln_truckorder,ln_remainqty,ln_auto_issue
datetime ld_nowtime

setpointer(Hourglass!)
uo_status.st_message.text = ''
st_text.text = ''
ls_shipsheetno = trim(this.text)
if f_connection_sqlserver(mid(ls_shipsheetno,1,1),mid(ls_shipsheetno,2,1)) = false then
   messagebox("확인","서버와의 연결이 끊어졌습니다.잠시후에 재작업하십시오")
	return
end if

ld_nowtime 		= f_pisc_get_date_nowtime()
ls_today		 	= f_pisc_get_date_applydate_close("%", "%",ld_nowtime)
ls_today08     = mid(ls_today,1,4) + mid(ls_today,6,2) + mid(ls_today,9,2)
ln_count = 0

// 출하전표에 있는 지역,공장으로 커넥션 
dw_1.settransobject(sqlpis)
ln_count = dw_1.retrieve(ls_shipsheetno)
if ln_count < 1 then
	messagebox("확인","해당 전표번호로 출하된 품목은 없습니다. ~r~n 확인 후 작업바랍니다.")
	this.text = ''
	this.setfocus()
	return 0
end if

if trim(dw_1.object.tshipsheet_saleconfirmflag[1]) = 'Y' then
	messagebox("확인","해당 전표번호는 이미 영업출장소에서 확인이 완료된 품목입니다.")
	this.text = ''
	this.setfocus()
	return 0
end if

sqlpis.autocommit			=	false
update tshipsheet
	set saleconfirmflag = 'Y',
		 saleconfirmdate = getdate(),
		 lastemp = 'Y',
		 lastdate = getdate()
  where shipsheetno  = :ls_shipsheetno
using sqlpis;
if sqlpis.sqlnrows < 1 then
	ROLLBACK using sqlpis ;
	sqlpis.autocommit			=	true
	messagebox("확인(Shipsheet)","저장 실패. 시스템 개발팀으로 문의 바랍니다")
	this.text = ''
	this.setfocus()
	return 0	
end if

ls_extd = trim(dw_1.object.tsrorder_extd[1])  
if ls_extd <> 'SEQ' and ls_extd <> 'DPI' and mid(trim(dw_1.object.tsrorder_checksrno[1]),1,2) <> 'EX' then
	commit using sqlpis ;
	sqlpis.autocommit			=	true
	st_text.text = '입고 처리 완료'
	this.text = ''
	this.setfocus()
	return 0
end if

sql1.autocommit			=	false
sqlca.autocommit			=	false
for i = 1 to ln_count
	ln_rowcount				=	0
	ln_shipqty				=	dw_1.object.tshipsheet_shipqty[i]
	ln_remainqty			=	dw_1.object.tsrorder_shipremainqty[i]
	ls_shipplandate		=	dw_1.object.tshipsheet_shipdate[i]	
	ln_truckorder			=	dw_1.object.tshipsheet_truckorder[i]	
	ls_customercode		=	dw_1.object.tsrorder_custcode[i]
	ls_srno					=	dw_1.object.tshipsheet_srno[i]
	ls_srnoinv				=	trim(dw_1.object.tshipsheet_srno[i]) + '0'
	ls_customeritemcode	=	dw_1.object.tsrorder_customeritemno[i]
	ls_itemcode				=	dw_1.object.tsrorder_itemcode[i]
	ls_partid				=	dw_1.object.part_id[i]
	ls_areacode				=	dw_1.object.area_code[i]
	ls_divisioncode		=	dw_1.object.division_code[i]	
	ls_bareacode			=	dw_1.object.tsrorder_srareacode[i]
	ls_bdivisioncode		=	dw_1.object.tsrorder_srdivisioncode[i]	
	ls_bdate					=	dw_1.object.tsrorder_applyfrom[i]	
	ls_bdate1				=	mid(ls_bdate,1,4) + mid(ls_bdate,6,2) + mid(ls_bdate,9,2)
	ls_checksrno			=	dw_1.object.tsrorder_checksrno[i]	
	if mid(ls_checksrno,1,2) = 'EX' then
		ls_partid 			= 'EX'
		ls_areacode 		= dw_1.object.tsrorder_moveareacode[i]
		ls_divisioncode 	= dw_1.object.tsrorder_movedivisioncode[i]
	end if 
	if ls_extd = 'DPI' then 
		ls_partid = 'DPI'
	end if
	insert into tseqstock
		values		( 	:ls_srno,:ls_areacode,:ls_divisioncode,:ls_itemcode,:ls_partid,:ls_customeritemcode,:ln_shipqty,
							:ls_shipsheetno,:ls_bdate,:ls_today,:g_s_empno,:ld_nowtime )
	using sql1 ;
	if sql1.sqlcode <> 0 then
		messagebox("확인(Stock)","저장 실패. 시스템 개발팀으로 문의 바랍니다")
		ROLLBACK using sql1 ;
		ROLLBACK using sqlca ;
		ROLLBACK using sqlpis ;
		sqlpis.autocommit			=	true
		sqlca.autocommit			=	true
		sql1.autocommit			=	true
		this.text = ''
		this.setfocus() 
		return 0
	end if
	if mid(ls_checksrno,1,2) = 'EX' then
		update tshipinv
			set moveconfirmflag = 'Y',
				 sendflag        = 'Y',
				 moveconfirmdate = :ls_today,
				 moveconfirmtime = :ld_nowtime,
				 lastdate        = :ld_nowtime,
				 lastemp         = 'Y'
		 where shipplandate = :ls_shipplandate
			and areacode     = :ls_areacode
			and divisioncode = :ls_divisioncode
			and srno         = :ls_srno
			and truckorder   = :ln_truckorder using sql1 ;
		if sql1.sqlnrows < 1 then
			ROLLBACK using sql1 ;
			ROLLBACK using sqlca ;
			ROLLBACK using sqlpis ;
			sqlpis.autocommit			=	true
			sqlca.autocommit			=	true
			sql1.autocommit			=	true
//			messagebox("확인(ShipInv)",ls_shipplandate + ls_areacode + ls_divisioncode + ls_srno + string(ln_truckorder) )
 			messagebox("확인(ShipInv)","저장 실패. 시스템개발팀으로 문의 바랍니다")
			this.text = ''
			this.setfocus()
			return 0
		end if
	
//    
		update TINV
			set moveinvqty 	= moveinvqty - :ln_shipqty,
				 lastdate     	= getdate(),
				 lastemp      	= 'Y'       
		where AreaCode     	= :ls_bareacode
		and divisioncode 		= :ls_bdivisioncode
		and itemcode     		= :ls_itemcode
		using sqlpis ;
		if sqlpis.sqlnrows < 1 then
			ROLLBACK using sql1 	;
			ROLLBACK using sqlca ;
			ROLLBACK using sqlpis ;
			sqlpis.autocommit			=	true
			sqlca.autocommit			=	true
			sql1.autocommit			=	true
//			messagebox("확인(ShipInv)",ls_shipplandate + ls_areacode + ls_divisioncode + ls_srno + string(ln_truckorder) )
 			messagebox("확인(ShipInv2)","저장 실패. 시스템개발팀으로 문의 바랍니다")
			this.text = ''
			this.setfocus()
			return 0
		end if	
		
		update TSHIPINV
			set moveconfirmdate = convert(char(10),getdate(),102),
				 moveconfirmtime = getdate(),
				 lastdate        = getdate(),
				 lastemp        = 'Y'
		where ShipPlanDate   = :ls_shipplandate
		and AreaCode         = :ls_bareacode
		and divisioncode     = :ls_bdivisioncode
		and srno             = :ls_srno
		and truckorder       = :ln_truckorder
		and fromareacode     = :ls_areacode
		and fromdivisioncode = :ls_divisioncode
		using sqlpis ;
		if sqlpis.sqlnrows < 1 then
			ROLLBACK using sql1 ;
			ROLLBACK using sqlca ;
			ROLLBACK using sqlpis ;
			sqlpis.autocommit			=	true
			sqlca.autocommit			=	true
			sql1.autocommit			=	true
 			messagebox("확인(ShipInv3)","저장 실패. 시스템개발팀으로 문의 바랍니다")
			this.text = ''
			this.setfocus()
			return 0
		end if	
//
	
		
			SELECT PBINV.SF_SEQ_EX(:ls_srnoinv,:g_s_date,:ln_shipqty,:g_s_empno)
				INTO :ls_return from comm000 
			WHERE aa = '1111'  Using sqlca ;
			if sqlca.sqlcode <> 0 or trim(ls_return) <> '0' then
				messagebox("이체 " + ls_return ,"저장 실패.시스템개발팀으로 문의 바랍니다")
				ROLLBACK using sql1 ;
				ROLLBACK using sqlca ;
				ROLLBACK using sqlpis ;
				sqlpis.autocommit			=	true
				sqlca.autocommit			=	true
				sql1.autocommit			=	true
				this.text = ''
				this.setfocus()
				return 0
			end if
			ln_auto_issue = f_ex_autois(ls_areacode,ls_divisioncode,ls_itemcode,ln_shipqty,ls_today08)
			
			if ln_auto_issue = 0 then
			
			elseif ln_auto_issue	=	-1	then
				ls_message	=	ls_message	+	ls_itemcode	+	','
			else
				ROLLBACK using sql1 ;
				ROLLBACK using sqlca ;
				ROLLBACK using sqlpis ;
				sqlpis.autocommit			=	true
				sqlca.autocommit			=	true
				sql1.autocommit			=	true
				CHOOSE CASE ln_auto_issue
					CASE 1
						messagebox("확인","마감일이후에는 작업을 할수 없습니다.")
					CASE 2
						messagebox("확인","지역공장 품번 확인.")
					CASE 3
						messagebox("확인","현재고량 체크")
					CASE 4
						messagebox("확인(INV101)","시스템개발팀으로 연락바랍니다.")
					CASE 5
						messagebox("확인(INV401)","시스템개발팀으로 연락바랍니다.")
				END CHOOSE
				this.text = ''
				this.setfocus()
				return 0
			end if
			
			if ln_remainqty > 0 then
				ls_slno = f_ex_request_item(ls_areacode, ls_divisioncode, ls_bAreacode, ls_bDivisioncode, &
													'A', ls_bdate1, ls_ItemCode, ln_remainqty, ls_slno)
				if Left(ls_slno, 2) <> 'EX' Then
					ROLLBACK using sql1 		;
					ROLLBACK using sqlca 	;
					ROLLBACK using sqlpis 	;
					sqlpis.autocommit			=	true
					sqlca.autocommit			=	true
					sql1.autocommit			=	true
					messagebox("확인(ShipInv Request)","저장 실패. 시스템 개발팀으로 문의 바랍니다")
					this.text = ''
					this.setfocus()
					return 0
				End if
			end if
		end if
		continue
	
	if ls_partid	=	'Err' or ls_partid	=	'DPI' then
		if ls_Extd 	<>	'DPI'	then
			messagebox("확인(PartID)","식별 ID 를 확인 후 작업하십시오.")
			ROLLBACK using sql1 		;
			ROLLBACK using sqlca 	;
			ROLLBACK using sqlpis 	;
			sqlpis.autocommit			=	true
			sqlca.autocommit			=	true
			sql1.autocommit			=	true
			this.text = ''
			this.setfocus()
			return 0
		end if
	end if
// 실제 Table Insert 는 서열 서버 시스템
	if ls_extd = 'SEQ' then
		select count(*) into :ln_rowcount from tseqinv
			where 	areacode = :ls_areacode and divisioncode 	= :ls_divisioncode 
			and	 	itemcode = :ls_itemcode and partid 			= :ls_partid
		using sql1 ;
		if isnull(ln_rowcount) or ln_rowcount = 0 then
				insert into tseqinv
				values	( :ls_areacode,:ls_divisioncode,:ls_itemcode,:ls_partid,:ln_shipqty,:g_s_empno,:ld_nowtime )
				using	sql1 ;
				if sql1.sqlcode <> 0 then
					ROLLBACK using sql1 ;
					ROLLBACK using sqlca ;
					ROLLBACK using sqlpis ;
					sqlpis.autocommit			=	true
					sqlca.autocommit			=	true
					sql1.autocommit			=	true
					messagebox("확인(Inv1)","저장 실패. 시스템 개발팀으로 문의 바랍니다")				
					this.text = ''
					this.setfocus()
					return 0
				end if
		elseif ln_rowcount = 1 then
				update	tseqinv
					set	stockqty	=	stockqty	+	:ln_shipqty
				where	areacode = :ls_areacode and divisioncode = :ls_divisioncode	
				and 	itemcode = :ls_itemcode and partid		= 	:ls_partid
				using sql1 ;
				if sql1.sqlcode <> 0 then
					ROLLBACK using sql1 ;
					ROLLBACK using sqlca ;
					ROLLBACK using sqlpis ;
					sqlpis.autocommit			=	true
					sqlca.autocommit			=	true
					sql1.autocommit			=	true
					messagebox("확인(Inv2)","저장 실패. 시스템 개발팀으로 문의 바랍니다")				
					this.text = ''
					this.setfocus()
					return 0
				end if
		else
			ROLLBACK using sql1   ;
			ROLLBACK using sqlca  ;
			ROLLBACK using sqlpis ;
			sqlpis.autocommit			=	true
			sqlca.autocommit			=	true
			sql1.autocommit			=	true
			this.text = ''
			this.setfocus()
			return 0
		end if
		ln_rowcount = 0
		select count(*) into :ln_rowcount from tseqtrans
			where 	areacode = :ls_areacode and divisioncode = :ls_divisioncode 
			and	 	itemcode = :ls_itemcode and partid = :ls_partid and tracedate	=	:ls_today 
		using sql1 ;
		if isnull(ln_rowcount) or ln_rowcount = 0 then
				insert into tseqtrans
				values	( :ls_today,:ls_areacode,:ls_divisioncode,:ls_itemcode,:ls_partid,:ln_shipqty,0,0,:g_s_empno,:ld_nowtime )
				using	sql1 ;
				if sql1.sqlcode <> 0 then
					ROLLBACK using sql1 ;
					ROLLBACK using sqlca ;
					ROLLBACK using sqlpis ;
					sqlpis.autocommit			=	true
					sqlca.autocommit			=	true
					sql1.autocommit			=	true
					messagebox("확인(Trans1)","저장 실패. 시스템 개발팀으로 문의 바랍니다")
					this.text = ''
					this.setfocus()
					return 0
				end if
		elseif ln_rowcount = 1 then
				update	tseqtrans
					set	inqty	=	inqty	+	:ln_shipqty
				where	areacode = :ls_areacode and divisioncode = :ls_divisioncode	
				and 	itemcode = :ls_itemcode and partid		= 	:ls_partid and tracedate = :ls_today
				using sql1 ;
				if sql1.sqlcode <> 0 then
					ROLLBACK using sql1 ;
					ROLLBACK using sqlca ;
					ROLLBACK using sqlpis ;
					sqlpis.autocommit			=	true
					sqlca.autocommit			=	true
					sql1.autocommit			=	true
					messagebox("확인(Trans2)","저장 실패. 시스템 개발팀으로 문의 바랍니다")				
					this.text = ''
					this.setfocus()
					return 0
				end if
		else
			ROLLBACK using sql1 ;
			ROLLBACK using sqlca ;
			ROLLBACK using sqlpis ;
			sqlpis.autocommit			=	true
			sqlca.autocommit			=	true
			sql1.autocommit			=	true
			messagebox("확인","확인")
			this.text = ''
			this.setfocus()
			return 0
		end if
	end if
next
if Left(ls_slno, 2) = 'EX' then
	if wf_tsrorder_insert(ls_slno,ls_bdate) = FALSE then
		ROLLBACK using sql1 ;
		ROLLBACK using sqlca ;
		ROLLBACK using sqlpis ;
		sqlpis.autocommit			=	true
		sqlca.autocommit			=	true
		sql1.autocommit			=	true
		messagebox("확인(TSHIPINV1)","저장 실패. 시스템 개발팀으로 문의 바랍니다")
		this.text = ''
		this.setfocus()
		return 0
	end if
end if
commit using sql1 ;
commit using sqlca ;
commit using sqlpis ;
sqlpis.autocommit			=	true
sqlca.autocommit			=	true
sql1.autocommit			=	true
if len(ls_message) > 0 then
	messagebox("확인",mid(ls_message,1,lastpos(ls_message,',') -1) + "~r~n위의 품번(들)은 협럭업체 반출품목으로 이체 입고시~r~n라인 자동 불출이 되지 않습니다.업체 반출작업을 수행하시기 바랍니다")
end if
st_text.text = '입고 완료(이체품은 입고/불출 동시처리)'
this.text = ''
this.setfocus()

end event
type dw_1 from datawindow within w_seq112u
integer x = 73
integer y = 320
integer width = 4206
integer height = 2144
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_seq_scaninput_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;if rowcount < 1 then
	return
end if

long i
string ls_customercode,ls_customeritemcode,ls_partid,ls_areacode,ls_divisioncode

for i=1 to rowcount
	ls_partid = ''
	ls_areacode = ''
	ls_divisioncode = ''
	ls_customercode 		= trim(this.object.tsrorder_custcode[i]	)
	ls_customeritemcode 	= trim(this.object.tsrorder_customeritemno[i]	)
	select areacode,divisioncode,partid into :ls_areacode,:ls_divisioncode,:ls_partid from tseqmstitem
		where customercode = :ls_customercode and customeritemcode = :ls_customeritemcode
	using sql1 ;
	this.object.part_id[i] 			= ls_partid
	this.object.area_code[i] 		= ls_areacode
	this.object.division_code[i] 	= ls_divisioncode
next
end event

type dw_tsrorder from datawindow within w_seq112u
boolean visible = false
integer x = 2011
integer y = 72
integer width = 302
integer height = 212
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_seq_ex_tsrorder"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_inv601 from datawindow within w_seq112u
boolean visible = false
integer x = 1490
integer y = 40
integer width = 421
integer height = 216
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_seq_inv601_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_text from statictext within w_seq112u
integer x = 1189
integer y = 112
integer width = 2898
integer height = 140
boolean bringtotop = true
integer textsize = -22
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
boolean focusrectangle = false
end type

type pb_excel from picturebutton within w_seq112u
integer x = 4114
integer y = 128
integer width = 155
integer height = 132
integer taborder = 10
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

type gb_1 from groupbox within w_seq112u
integer x = 73
integer y = 36
integer width = 1056
integer height = 260
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "출하전표번호"
end type

