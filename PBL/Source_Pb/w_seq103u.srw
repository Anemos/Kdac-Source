$PBExportHeader$w_seq103u.srw
$PBExportComments$서열품목 등록
forward
global type w_seq103u from w_origin_sheet09
end type
type uo_division from u_pisc_select_division within w_seq103u
end type
type uo_area from u_pisc_select_area within w_seq103u
end type
type dw_2 from datawindow within w_seq103u
end type
type uo_productgroup from u_seq_select_productgroup within w_seq103u
end type
type dw_3 from datawindow within w_seq103u
end type
type pb_excel from picturebutton within w_seq103u
end type
type gb_1 from groupbox within w_seq103u
end type
end forward

global type w_seq103u from w_origin_sheet09
integer height = 2724
string title = "서열품목등록"
uo_division uo_division
uo_area uo_area
dw_2 dw_2
uo_productgroup uo_productgroup
dw_3 dw_3
pb_excel pb_excel
gb_1 gb_1
end type
global w_seq103u w_seq103u

type variables
string is_areacode,is_divisioncode,is_productgroup
end variables

forward prototypes
public subroutine wf_protect (string ag_s_column, integer ag_n_number, datawindow ag_dw_1)
public function boolean wf_sle703_update (datawindow a_dw)
end prototypes

public subroutine wf_protect (string ag_s_column, integer ag_n_number, datawindow ag_dw_1);string l_s_command
//--	Argument	=> ag_s_column = column 명, 
//---             ag_n_number = column 순서,
ag_dw_1.setredraw(False)
l_s_command	=	ag_s_column + ".Protect = '1" &            
					+	"~tIf(mid(pt_chk," + string(ag_n_number) + ", 1) = " + "~~'1~~'," &
					+  " 1, 0 )'"
					
ag_dw_1.Modify(l_s_command)
ag_dw_1.setredraw(True)
 
end subroutine

public function boolean wf_sle703_update (datawindow a_dw);
long i,ln_count
string ls_custcd,ls_seid,ls_pdcd,ls_citno,ls_xplant,ls_div,ls_itno,ls_costdiv
string ls_extd,ls_delivery
dwItemStatus ls_status

ln_count = a_dw.rowcount()
for i = 1 to ln_count
	ls_status =  a_dw.GetItemStatus(i, 0,Primary!)
	if ( ls_status 	= 	datamodified! or ls_status = newmodified! ) and (trim(a_dw.object.seqgubun[i]) = 'FA') then
		ls_custcd 	= 	trim(a_dw.object.customercode[i])
		ls_seid		= 	trim(a_dw.object.partid[i])
		ls_citno	 	= 	trim(a_dw.object.customeritemcode[i])		
		ls_xplant	=	trim(a_dw.object.xplant[i])		
		ls_div		=	trim(a_dw.object.div[i])				
		ls_itno		=	trim(a_dw.object.itemcode[i])						
		select pdcd,costdiv into :ls_pdcd,:ls_costdiv from pbinv.inv101
			where comltd = '01' and xplant = :ls_xplant and div = :ls_div and itno = :ls_itno
		using sqlca ;
		if sqlca.sqlcode <> 0 then
			return false
		end if
		update pbsle.sle703
			set citno = :ls_citno , xplant = :ls_xplant , div = :ls_div , itno = :ls_itno ,
				 costdiv = :ls_costdiv , updtid = :g_s_empno , updtdt = :g_s_date ,
				 ipaddr  = :g_s_ipaddr  , macaddr = :g_s_macaddr
		where comltd = '01' and custcd = :ls_custcd and pdcd = :ls_pdcd and seid = :ls_seid
		using sqlca ;
		if sqlca.sqlnrows < 1 then
			insert into pbsle.sle703
			values ( '01',:ls_custcd,:ls_pdcd,:ls_seid,:ls_citno,:ls_xplant,:ls_div,:ls_itno,:ls_costdiv,
			         ' ' ,:g_s_empno,:g_s_date,:g_s_empno,:g_s_date,:g_s_ipaddr,:g_s_macaddr )
			using sqlca ;
			if sqlca.sqlcode <> 0 then
				return false
			end if
		end if
	else
		continue
	end if
next
return True

end function

on w_seq103u.create
int iCurrent
call super::create
this.uo_division=create uo_division
this.uo_area=create uo_area
this.dw_2=create dw_2
this.uo_productgroup=create uo_productgroup
this.dw_3=create dw_3
this.pb_excel=create pb_excel
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_division
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.uo_productgroup
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.pb_excel
this.Control[iCurrent+7]=this.gb_1
end on

on w_seq103u.destroy
call super::destroy
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.dw_2)
destroy(this.uo_productgroup)
destroy(this.dw_3)
destroy(this.pb_excel)
destroy(this.gb_1)
end on

event open;call super::open;//dw_3.insertrow(0)
end event

event activate;call super::activate;dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
wf_icon_onoff(true,true,true,true,false,false,false,false,false)

end event

event ue_retrieve;call super::ue_retrieve;integer ln_row

ln_row = dw_2.retrieve(is_areacode,is_divisioncode,is_productgroup)
//dw_3.object.customeritemcode.protect = true
end event

event ue_insert;call super::ue_insert;string ls_customercode,ls_areaname,ls_divisionname

if f_spacechk(is_divisioncode) = -1 or trim(is_divisioncode) = '%' then
	messagebox("확인","입력기능을 사용하실때에는 공장은 반드시 입력하셔야 합니다")
	return
end if
dw_3.reset()
DataWindowChild ldwc 
If dw_3.GetChild('seqgubun', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlpis); ldwc.Retrieve('SEQASSY','F%')
End If
If dw_3.GetChild('productgroup', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlpis); ldwc.Retrieve(is_areacode,is_divisioncode,is_productgroup,'F%')
End If
If dw_3.GetChild('linecode', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlpis); ldwc.Retrieve('SEQLINE','%')
End If
//If dw_3.GetChild('rackgroup', ldwc) <> -1 Then 
//	ldwc.SetTransObject(sqlpis); ldwc.Retrieve(is_productgroup)
//End If
//If dw_3.GetChild('cartype', ldwc) <> -1 Then 
//	ldwc.SetTransObject(sqlpis); ldwc.Retrieve('SEQCAR','%')
//End If
dw_3.insertrow(0)
dw_3.object.areacode[1] 		= is_areacode
dw_3.object.divisioncode[1] 	= is_divisioncode
//select areaname into :ls_areaname from tmstarea
//	where areacode = :is_areacode
//using sqlpis ;
//select divisionname into :ls_divisionname from tmstdivision
//	where areacode = :is_areacode and divisioncode = :is_divisioncode
//using sqlpis ;
//
if is_areacode 		= 'B' then
	ls_customercode 	= 'L10500'
elseif is_areacode 	= 'K' then
	ls_customercode 	= 'L10502'
end if

dw_3.object.pt_chk[1] 		= '            '
wf_protect("assygubun",1,dw_3)
wf_protect("seqgubun",1,dw_3)
wf_protect("customercode",1,dw_3)
wf_protect("customeritemcode",1,dw_3)
wf_protect("productgroup",1,dw_3)
wf_protect("partid",1,dw_3)
dw_3.object.assygubun.background.color 			= 15780518
dw_3.object.seqgubun.background.color 				= 15780518
dw_3.object.customercode.background.color 		= 15780518
dw_3.object.customeritemcode.background.color 	= 15780518
dw_3.object.productgroup.background.color 		= 15780518
dw_3.object.partid.background.color 				= 15780518

//dw_3.object.areaname[1] 		= ls_areaname
//dw_3.object.divisionname[1] = ls_divisionname
dw_3.object.customercode[1] 	= ls_customercode
dw_3.setfocus()
dw_3.setrow(1)
dw_3.setcolumn("assygubun")


end event

event ue_save;call super::ue_save;long ln_rowcount,i,ln_count,ln_savecount
dwItemStatus ls_status
datetime ld_nowtime
string ls_productgroup,ls_customercode,ls_customeritemcode,ls_divisioncode,ls_areacode,ls_itemcode,ls_partid
string ls_old_productgroup,ls_old_partid,ls_assy_gubun,ls_old_assy_gubun

ld_nowtime = f_pisc_get_date_nowtime()
ln_rowcount = dw_3.rowcount()
if ln_rowcount < 1 then
	messagebox("확인","저장할 정보가 없습니다")
	return 1
end if
dw_3.accepttext()
if f_mandatory_chk(dw_3) = -1 then
	return 1
end if
sqlpis.autocommit = false
for i = 1 to ln_rowcount
	ls_status =  dw_3.GetItemStatus(i, 0,Primary!)
	if ls_status = datamodified! or ls_status = newmodified! then
		ls_customercode 		= trim(dw_3.object.customercode[i])
		ls_assy_gubun			= trim(dw_3.getitemstring(i,"assygubun",primary!,false))
		ls_old_assy_gubun	 	= trim(dw_3.getitemstring(i,"assygubun",primary!,true))
		ls_customeritemcode 	= trim(dw_3.object.customeritemcode[i])
		ls_partid		 		= trim(dw_3.getitemstring(i,"partid",primary!,false))
		ls_productgroup		= trim(dw_3.getitemstring(i,"productgroup",primary!,false))
		ls_old_partid	 		= trim(dw_3.getitemstring(i,"partid",primary!,true))
		ls_old_productgroup	= trim(dw_3.getitemstring(i,"productgroup",primary!,true))
		
//		messagebox("AA","식별ID: " +ls_partid + " | " + ls_old_partid  + "  제품군: " + ls_productgroup +  " | " + ls_old_productgroup)
		if ( ls_old_partid <> ls_partid or ls_old_productgroup <> ls_productgroup or ls_old_assy_gubun <> ls_assy_gubun) or ls_status = newmodified! then
			select count(*) into :ln_count from tseqmstitem
				where productgroup = :ls_productgroup and partid = :ls_partid and assygubun = :ls_assy_gubun
			using sqlpis ;
			if ln_count > 0 then
				sqlpis.autocommit = true
				messagebox("확인",ls_productgroup + " 에서 식별 ID (" + ls_partid + ") 를 현재 사용중입니다")
				return 1
			end if
		end if
		ln_count = 0
		if ls_status = newmodified! then			
			select count(*) into :ln_count from tseqmstitem
//				where customercode = :ls_customercode and customeritemcode = :ls_customeritemcode 
				where customeritemcode = :ls_customeritemcode 				
			using sqlpis ;
			if ln_count > 0 then
				sqlpis.autocommit = true
				messagebox("확인",ls_customeritemcode + " 은 이미 등록된 고객사 품번입니다")
				return 1
			end if
		end if
		ln_count = 0
		if trim(dw_3.object.seqgubun[i]) <> 'FB' then
			select areacode,divisioncode,itemcode,isnull(count(*),0) into :ls_areacode,:ls_divisioncode,:ls_itemcode,:ln_count 
				from tmstcustitem
//			where custcode = :ls_customercode and custitemcode = :ls_customeritemcode 
			where custitemcode = :ls_customeritemcode 			
			group by areacode,divisioncode,itemcode
			using sqlpis ;
			if isnull(ln_count) = true or ln_count = 0 then
				sqlpis.autocommit = true					
				messagebox("확인",ls_customeritemcode + " 은 고객사 품번으로 등록되어 있지 않은 품번입니다")
				return 1
			end if
		else
			ls_areacode = is_areacode
			ls_divisioncode = is_divisioncode
			ls_itemcode = ls_customeritemcode
		end if
		dw_3.object.xplant[1] 	= ls_areacode
		dw_3.object.div[1] 		= ls_divisioncode
		dw_3.object.itemcode[1] = ls_itemcode
		dw_3.setitem(i,"lastemp",g_s_empno)	
		dw_3.setitem(i,"lastdate",ld_nowtime)	
		ln_savecount 	= 1
	end if
next
if ln_savecount = 1 then
	if wf_sle703_update(dw_3) = true then
		if dw_3.update() <> 1 then
			rollback using sqlpis;
			messagebox("확인","시스템개발팀에 문의바랍니다-SQLPIS")
		else
			commit using sqlpis;			
			messagebox("확인","저장성공")
		end if
	else
		messagebox("확인","시스템개발팀에 문의바랍니다-SQLCA")
	end if
end if
sqlpis.autocommit = true
this.triggerevent("ue_retrieve")

end event
event ue_delete;call super::ue_delete;long ln_row,ln_count
string ls_custcode,ls_customeritemno,ls_pdcd,ls_partid,ls_itemcode,ls_xplant,ls_div,ls_areacode,ls_divisioncode
setpointer(hourglass!)
ln_row = dw_3.getrow()
if ln_row < 1 then
	messagebox("삭제확인","품번을 선택 후 삭제가 가능합니다")
	return
end if
ls_xplant				=	dw_3.object.xplant[ln_row]
ls_div					=	dw_3.object.div[ln_row]
ls_areacode				=	dw_3.object.areacode[ln_row]
ls_divisioncode		=	dw_3.object.divisioncode[ln_row]
ls_custcode				=	dw_3.object.customercode[ln_row]
ls_customeritemno		=	dw_3.object.customeritemcode[ln_row]
ls_itemcode				=	dw_3.object.itemcode[ln_row]
ls_partid				=	dw_3.object.partid[ln_row]
select count(tracedate) into :ln_count from tseqtrans
	where areacode = :ls_areacode and divisioncode = :ls_divisioncode and itemcode = :ls_itemcode and partid = :ls_partid
using sqlpis ;
if ln_count = 0 or isnull(ln_count) then
	select pdcd into :ls_pdcd from pbinv.inv101
		where comltd = '01' and xplant = :ls_xplant and div = :ls_div and itno = :ls_itemcode
	using sqlca ;
	sqlpis.autocommit = false
	delete from tseqmstitem
		where customercode = :ls_custcode and customeritemcode = :ls_customeritemno 
	using sqlpis ;
	delete from PBSLE.SLE703
		where comltd = '01' and pdcd = :ls_pdcd and seid = :ls_partid 
	using sqlca ;
	commit using sqlpis ;
	sqlpis.autocommit = true
	this.triggerevent("ue_retrieve")
	messagebox("확인","삭제성공")
else
	messagebox("확인","현재 수불실적이 존재하는 품번입니다. 삭제 불가 ")
	return
end if



end event

type uo_status from w_origin_sheet09`uo_status within w_seq103u
integer x = 37
integer width = 4581
end type

type uo_division from u_pisc_select_division within w_seq103u
event destroy ( )
integer x = 608
integer y = 64
integer taborder = 70
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;string ls_productname
is_divisioncode = is_uo_divisioncode
f_seq_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productname)

end event

event ue_post_constructor;call super::ue_post_constructor;string ls_productname
is_divisioncode = is_uo_divisioncode
if is_areacode = 'B' or is_areacode = 'K' then
	f_seq_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productname)
end if
end event

type uo_area from u_pisc_select_area within w_seq103u
event destroy ( )
integer x = 69
integer y = 64
integer taborder = 70
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
string ls_divisionname,ls_divisionnameeng,ls_productname
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_seq_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productname)
//
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng,ls_productname
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)




end event

type dw_2 from datawindow within w_seq103u
integer x = 46
integer y = 184
integer width = 4517
integer height = 1688
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_tseqmstitem_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlpis)
end event

event clicked;setpointer(hourglass!)
uo_status.st_message.text = ''

string 	ls_customercode,ls_customeritemcode
int 		li_rowcnt

this.selectrow(0, false)
li_rowcnt = this.rowcount()
dw_3.reset()

if row > 0 and row <= li_rowcnt then
	this.selectrow(row,true)
else
	return 0
end if

ls_customercode 		= trim(this.object.customercode[row])
ls_customeritemcode 	= trim(this.object.customeritemcode[row])

if dw_3.retrieve(ls_customercode,ls_customeritemcode) >= 1 then
	uo_status.st_message.text = '조회 완료'
	dw_3.setfocus()
	dw_3.setrow(1)
	dw_3.setcolumn("assygubun")
end if
end event

event retrievestart;DataWindowChild ldwc
If this.GetChild('seqgubun', ldwc) <> -1 Then 
//	ls_gubun = trim(dw_2.object.assygubun[ln_row])
	ldwc.SetTransObject(sqlpis); ldwc.Retrieve('SEQASSY','%')
End If
end event

type uo_productgroup from u_seq_select_productgroup within w_seq103u
integer x = 1198
integer y = 68
integer taborder = 80
boolean bringtotop = true
end type

event ue_select;call super::ue_select;is_productgroup = is_uo_productgroup
end event

on uo_productgroup.destroy
call u_seq_select_productgroup::destroy
end on

type dw_3 from datawindow within w_seq103u
integer x = 46
integer y = 1884
integer width = 4517
integer height = 584
integer taborder = 80
string title = "none"
string dataobject = "d_tseqmstitem_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlpis)
end event

event retrievestart;DataWindowChild ldwc
string 	ls_gubun,ls_partid,ls_areacode,ls_divisioncode,ls_itemcode
long		ln_row,ln_count

ln_row = dw_2.getclickedrow()

If this.GetChild('seqgubun', ldwc) <> -1 Then 
	ls_gubun = trim(dw_2.object.assygubun[ln_row])
	ldwc.SetTransObject(sqlpis); ldwc.Retrieve('SEQASSY',ls_gubun + '%')
End If
If This.GetChild('productgroup', ldwc) <> -1 Then
	ldwc.SetTransObject(sqlpis); ldwc.Retrieve(is_areacode,is_divisioncode,is_productgroup,'%')
End If
If this.GetChild('linecode', ldwc) <> -1 Then 
	ldwc.SetTransObject(sqlpis); ldwc.Retrieve('SEQLINE','%')
End If
//If this.GetChild('cartype', ldwc) <> -1 Then 
//	ldwc.SetTransObject(sqlpis); ldwc.Retrieve('SEQCAR','%')
//End If
//If this.GetChild('rackgroup', ldwc) <> -1 Then 
//	ls_gubun = trim(dw_2.object.productgroup[ln_row])
//	ldwc.SetTransObject(sqlpis); ldwc.Retrieve(ls_gubun)
//End If

ls_areacode			=	trim(dw_2.object.areacode[ln_row])
ls_divisioncode	=	trim(dw_2.object.divisioncode[ln_row])
ls_itemcode			=	trim(dw_2.object.itemcode[ln_row])
ls_partid			=	trim(dw_2.object.partid[ln_row])

select count(tracedate) into :ln_count from tseqtrans
	where areacode = :ls_areacode and divisioncode = :ls_divisioncode and itemcode = :ls_itemcode and partid = :ls_partid
using sqlpis ;
if ln_count = 0 or isnull(ln_count) then
	dw_3.object.assygubun.protect 						= false
	dw_3.object.seqgubun.protect 							= false
	dw_3.object.customeritemcode.protect 				= false
	dw_3.object.customercode.protect 					= false
	dw_3.object.productgroup.protect 					= false
	dw_3.object.partid.protect 							= false
	
	dw_3.object.assygubun.background.color 			= 15780518
	dw_3.object.seqgubun.background.color 				= 15780518
	dw_3.object.customercode.background.color       = 15780518
	dw_3.object.customeritemcode.background.color   = 15780518
	dw_3.object.productgroup.background.color       = 15780518
	dw_3.object.partid.background.color             = 15780518
else
	dw_3.object.assygubun.protect 						= true
	dw_3.object.seqgubun.protect 							= true
	dw_3.object.customeritemcode.protect 				= true
	dw_3.object.customercode.protect 					= true
	dw_3.object.productgroup.protect 					= true
	dw_3.object.partid.protect 							= true
	
	dw_3.object.assygubun.background.color 			= rgb(192,192,192)
	dw_3.object.seqgubun.background.color 				= rgb(192,192,192)
	dw_3.object.customercode.background.color 		= rgb(192,192,192)
	dw_3.object.customeritemcode.background.color 	= rgb(192,192,192)
	dw_3.object.productgroup.background.color 		= rgb(192,192,192)
	dw_3.object.partid.background.color 				= rgb(192,192,192)
end if
 

end event

event itemchanged;this.accepttext()
string ls_gubun//,ls_areacode,ls_divisioncode

DataWindowChild ldwc
if dwo.name = 'assygubun' then
	this.object.seqgubun[1] = ''
	If this.GetChild('seqgubun', ldwc) <> -1 Then 
		ls_gubun = this.object.assygubun[1]
		ldwc.SetTransObject(sqlpis); ldwc.Retrieve('SEQASSY',ls_gubun + '%')
		if ls_gubun	=	'C'	then
//			dw_3.object.rackgroup[1] 					=	''
			dw_3.object.linecode[1] 					=	''
		end if
	End If
end if
if dwo.name = 'seqgubun' then
	this.object.productgroup[1] = ''
	If this.GetChild('productgroup', ldwc) <> -1 Then 
		if this.object.seqgubun[1] = 'FA' then
			ls_gubun = '%'
		elseif this.object.seqgubun[1] = 'FB' then
			ls_gubun = 'B%'
		else
			ls_gubun = 'C%'
		end if
		ldwc.SetTransObject(sqlpis); ldwc.Retrieve(is_Areacode,is_divisioncode,is_productgroup,ls_gubun)
	End If
end if
if dwo.name = 'productgroup' then
	ls_gubun = this.object.productgroup[1]	
//	ls_assy	= this.object.assygubun[1]		
	if ls_gubun = 'B' then
		dw_3.object.linecode[1] 					=	''		
		dw_3.object.linecode.background.color	= rgb(255,255,255)
		dw_3.object.linecode.visible				= false
//		dw_3.object.rackgroup.background.color	= 15780518
//		dw_3.object.rackgroup.visible				= true		
	elseif ls_gubun = 'C' then
		dw_3.object.linecode.background.color  = 15780518
		dw_3.object.linecode.visible				= true
//		dw_3.object.rackgroup.background.color	= rgb(255,255,255)
//		dw_3.object.rackgroup.visible				= false	
//		dw_3.object.rackgroup[1] 					=	''
	elseif ls_gubun = 'A' then
		dw_3.object.linecode.background.color  = 15780518
		dw_3.object.linecode.visible				= true
//		dw_3.object.rackgroup.background.color	= 15780518
//		dw_3.object.rackgroup.visible				= true	
	end if
//	this.object.rackgroup[1] = ''
//	If this.GetChild('rackgroup', ldwc) <> -1 Then 
//		ldwc.SetTransObject(sqlpis); ldwc.Retrieve(ls_gubun)
//	End If
end if
end event

type pb_excel from picturebutton within w_seq103u
integer x = 4297
integer y = 36
integer width = 155
integer height = 132
integer taborder = 40
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

event clicked;f_save_to_excel(dw_2)



end event

type gb_1 from groupbox within w_seq103u
integer x = 46
integer width = 4206
integer height = 164
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

