$PBExportHeader$w_pisr010u.srw
$PBExportComments$외주간판기본정보 관리( 조회등록,수정,삭제, 출력)
forward
global type w_pisr010u from w_ipis_sheet01
end type
type dw_pisr010u_01 from u_vi_std_datawindow within w_pisr010u
end type
type dw_pisr010u_03 from datawindow within w_pisr010u
end type
type st_hsplitbar from u_pism_splitbar within w_pisr010u
end type
type st_vsplitbar from u_pism_splitbar within w_pisr010u
end type
type uo_area from u_pisc_select_area within w_pisr010u
end type
type uo_division from u_pisc_select_division within w_pisr010u
end type
type tv_partkb from u_pisr_treeview within w_pisr010u
end type
type cb_edit from commandbutton within w_pisr010u
end type
type cb_search from commandbutton within w_pisr010u
end type
type cb_supplier from commandbutton within w_pisr010u
end type
type gb_1 from groupbox within w_pisr010u
end type
type dw_temp from datawindow within w_pisr010u
end type
type dw_pisr010u_02 from datawindow within w_pisr010u
end type
type cb_filter from commandbutton within w_pisr010u
end type
type gb_2 from groupbox within w_pisr010u
end type
end forward

global type w_pisr010u from w_ipis_sheet01
string title = ""
event ue_edit ( )
event ue_itemsearch ( )
event ue_init ( )
event ue_partkbcycle ( )
event ue_partkbsearch ( )
dw_pisr010u_01 dw_pisr010u_01
dw_pisr010u_03 dw_pisr010u_03
st_hsplitbar st_hsplitbar
st_vsplitbar st_vsplitbar
uo_area uo_area
uo_division uo_division
tv_partkb tv_partkb
cb_edit cb_edit
cb_search cb_search
cb_supplier cb_supplier
gb_1 gb_1
dw_temp dw_temp
dw_pisr010u_02 dw_pisr010u_02
cb_filter cb_filter
gb_2 gb_2
end type
global w_pisr010u w_pisr010u

type variables
Treeview 	itv_partKB
str_pisr_partKB 	istr_partkb

Boolean 	ib_saveFlag, ib_hisFlag, ib_modelidchangeFlag
Boolean 	ib_prFlag, ib_useFlag, ib_applyfilter = true
Date 		id_applyFrom
String 	is_inputApplyFrom


String 	is_saveStatus		// '0':조회 '1':신규 '2':수정
end variables

forward prototypes
public function integer wf_suppliervalid_chk (string as_colname, string as_suppcode)
public function integer wf_usecentervalid_chk (string as_colname, string as_usecode)
public function string wf_get_applyfrom (string as_areacode, string as_divcode, string as_suppcode, string as_itemcode)
public function string wf_data_chk (datawindow ad_dw, ref string as_colname)
public function long wf_set_tmstpartkb ()
public function integer wf_divisionvalid_chk (string as_colname, string as_divcode)
public function integer wf_insertrow ()
public function boolean wf_tmstpartkb_interface (string as_falg, ref datetime adt_nowtime)
public function integer wf_tmstpartkb_del (string as_arcacode, string as_divcode, string as_suppcode, string as_itemcode)
public function integer wf_partkbhis_save (string as_applyfrom)
public function integer wf_rackvalid_chk (string as_colname, string as_rackcode)
public function integer wf_initvalue (long al_insrow)
public function long wf_set_saveflag ()
end prototypes

event ue_edit();///////////////////////////////////
//  		신규 간판 등록 
///////////////////////////////////
If IsNull(istr_partkb.itemCode) Then 
	MessageBox( "수정실패", "수정하실 간판항목이 선택되지 않았습니다.", Information! )
	Return 
End If 

Long 		ll_Row
String	ls_areaCode, ls_divCode, ls_suppCode, ls_itemCode, ls_applyFrom

dw_pisr010u_02.AcceptText()
dw_pisr010u_02.SetItem( dw_pisr010u_02.GetRow(), 'inschk', 0 )
ll_Row 			= dw_pisr010u_02.GetRow()
ls_areaCode		= dw_pisr010u_02.GetItemString( ll_row, 'areacode' )
ls_divCode		= dw_pisr010u_02.GetItemString( ll_row, 'divisioncode' )
ls_suppCode		= dw_pisr010u_02.GetItemString( ll_row, 'suppliercode' )
ls_itemCode		= dw_pisr010u_02.GetItemString( ll_row, 'itemcode' )
ls_applyFrom	= wf_get_applyfrom( ls_areaCode, ls_divCode, ls_suppCode, ls_itemCode )
dw_pisr010u_02.SetItem( dw_pisr010u_02.GetRow(), 'applyfrom', ls_applyFrom )

if dw_pisr010u_02.GetItemString( ll_row, 'usecentergubun') = 'I' then
	dw_pisr010u_02.Object.costgubun.Protect = 1
	dw_pisr010u_02.Object.BuyBackFlag.Protect = 1
else
	dw_pisr010u_02.Object.costgubun.Protect = 0
	dw_pisr010u_02.Object.BuyBackFlag.Protect = 0
end if

end event

event ue_itemsearch();//Open( w_pisr011i )
end event

event ue_init();dw_temp.Visible 		= False
cb_edit.Enabled		= m_frame.m_action.m_save.Enabled
cb_supplier.Enabled	= m_frame.m_action.m_save.Enabled

Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 
//splitbar 설정
st_vsplitbar.of_Register(tv_partkb, st_vsplitbar.LEFT)
st_vsplitbar.of_Register(dw_pisr010u_01, st_vsplitbar.RIGHT)
st_vsplitbar.of_Register(dw_pisr010u_02, st_vsplitbar.RIGHT)
st_vsplitbar.of_Register(st_hsplitbar, st_vsplitbar.RIGHT)		

st_hsplitbar.of_Register(dw_pisr010u_01, st_hsplitbar.ABOVE)
st_hsplitbar.of_Register(dw_pisr010u_02, st_hsplitbar.BELOW)
st_hsplitbar.of_Register(dw_pisr010u_03, st_hsplitbar.BELOW)

SetNull(istr_partkb.areaCode); SetNull(istr_partkb.divCode); SetNull(istr_partkb.suppCode);
SetNull(istr_partkb.itemCode); SetNull(istr_partkb.flag); SetNull(istr_partkb.applydate); 

istr_partkb.areaCode = uo_area.is_uo_areacode
istr_partkb.divCode 	= uo_division.is_uo_divisioncode
istr_partkb.suppCode	= '%'
istr_partkb.itemCode	= '%'
istr_partkb.flag		= 1		//조회
//dw_pisr010u_02.Object.Enabled = False

// TreeView 설정
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode, true)


end event

event ue_partkbcycle();Long 	ll_Return

OpenWithParm ( w_pisr012u, istr_partkb )

ll_Return	= integer(Message.StringParm)

If ll_Return > 0 Then 
	tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode, true)
End If


end event

event ue_partkbsearch();OpenWithParm ( w_pisr011i, istr_partkb )
end event

public function integer wf_suppliervalid_chk (string as_colname, string as_suppcode);Integer li_Chk
String ls_Null

SetNull(ls_Null)

  SELECT count(SupplierCode)  
    INTO :li_Chk  
    FROM TMSTSUPPLIER  
   WHERE TMSTSUPPLIER.SupplierCode = :as_suppCode   
	USING sqlpis	;
If li_Chk > 0 Then Return 1

dw_pisr010u_02.SetItem( dw_pisr010u_02.GeTrow(), as_colName, ls_Null ) 

Return -1 
end function

public function integer wf_usecentervalid_chk (string as_colname, string as_usecode);String ls_useGubun, ls_Null
Integer li_Chk 

SetNull(ls_Null)
ls_useGubun = dw_pisr010u_02.GetItemString( dw_pisr010u_02.GetRow(), 'usecentergubun' )
If ls_useGubun = 'I' Then 	//조
 	SELECT	count(WorkCenter)  
 	INTO 		:li_Chk  
  	FROM 		TMSTWORKCENTER  
 	WHERE 	TMSTWORKCENTER.AreaCode			= :uo_area.is_uo_areacode  AND  
        		TMSTWORKCENTER.DivisionCode	= :uo_division.is_uo_divisioncode  AND  
        		TMSTWORKCENTER.WorkCenter 		= :as_useCode    
	USING		sqlpis	;
	
   If li_Chk > 0 Then Return 1 
ElseIf ls_useGubun = 'E' Then 	//외주업체 
	Return wf_suppliervalid_Chk( as_colName, as_useCode )
End If

dw_pisr010u_02.SetItem( dw_pisr010u_02.Getrow(), as_colName, ls_Null )

Return -1 
end function

public function string wf_get_applyfrom (string as_areacode, string as_divcode, string as_suppcode, string as_itemcode);////////////////////////////////////////////////////////////
//     선택한 품목이 변경된 경우 적용시작가능일자  구하기
////////////////////////////////////////////////////////////
String	ls_yesterDay, ls_Null
String 	ls_oldDate, ls_orderDate, ls_applyFrom
String	ls_maxDate = '9999.12.31'
setNull(ls_Null)
ls_yesterDay = f_pisr_getdaybefore( f_pisr_get_today(), -1)	//시스템기준의 어제일자

  SELECT TMSTPARTKBHIS.ApplyFrom   									//최종 수정된 마스터적용시작일자
    INTO :ls_oldDate  
    FROM TMSTPARTKBHIS  
   WHERE TMSTPARTKBHIS.AreaCode 		= :as_areacode  AND  
         TMSTPARTKBHIS.DivisionCode = :as_divcode   AND  
         TMSTPARTKBHIS.SupplierCode = :as_suppcode  AND
         TMSTPARTKBHIS.ItemCode 		= :as_itemcode  AND  
			TMSTPARTKBHIS.ApplyTo		= :ls_maxDate
   USING sqlpis      ;
	IF sqlpis.SqlCode <> 0 THEN
		ls_oldDate = ls_yesterDay
	END IF

  SELECT Max( TPARTLASTEDIT.PartLastEditDate )  				//최종 발주일자
    INTO :ls_orderDate  
    FROM TPARTLASTEDIT  
   WHERE TPARTLASTEDIT.AreaCode 		= :as_areacode  AND  
         TPARTLASTEDIT.DivisionCode = :as_divcode   AND  
         TPARTLASTEDIT.SupplierCode = :as_suppcode	 AND  
         TPARTLASTEDIT.ItemCode 		= :as_itemcode	 AND  
         TPARTLASTEDIT.OrderGubun 	= 'A'    
   USING sqlpis      ;

	IF isNull(ls_orderDate) THEN
		ls_orderDate = ls_yesterDay
	END IF

IF ls_oldDate 	 > ls_yesterDay THEN ls_yesterDay = ls_oldDate
IF ls_orderDate > ls_yesterDay THEN ls_yesterDay = ls_orderDate
ls_applyFrom = f_pisr_getdaybefore( ls_yesterDay, 1)

return ls_applyFrom

end function

public function string wf_data_chk (datawindow ad_dw, ref string as_colname);Long ll_getRow 
String ls_Data, ls_message 
Integer li_Data 

ll_getRow = ad_dw.GetRow()

ls_Data = ad_dw.GetItemString(ll_getRow, "divisioncode")
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '공장코드' 
as_colname = 'divisioncode'; If ls_message <> '' Then Return ls_message

ls_Data = ad_dw.GetItemString(ll_getRow, "suppliercode") 
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '업체코드'
as_colname = 'suppliercode';If ls_message <> '' Then Return ls_message

ls_Data = ad_dw.GetItemString(ll_getRow, "itemcode")
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '품번코드'
as_colname = 'itemcode';If ls_message <> '' Then Return ls_message

ls_Data = ad_dw.GetItemString(ll_getRow, "applyfrom")
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '적용시작일자'
as_colname = 'applyfrom';If ls_message <> '' Then Return ls_message

ls_Data = ad_dw.GetItemString(ll_getRow, "parttype")
If IsNull(ls_data) or trim(ls_data) = '' then ls_message = '부품구분'
as_colname = 'parttype';If ls_message <> '' Then Return ls_message

ls_Data = ad_dw.GetItemString(ll_getRow, "partmodelid")
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '배번호'
as_colname = 'partmodelid';If ls_message <> '' Then Return ls_message

ls_Data = ad_dw.GetItemString(ll_getRow, "usecentergubun")
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '사용처구분'
as_colname = 'usecentergubun';If ls_message <> '' Then Return ls_message
if ls_Data = 'E' then
	ls_Data = ad_dw.GetItemString(ll_getRow, "costgubun")
	If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '유무상구분'
	as_colname = 'costgubun';If ls_message <> '' Then Return ls_message
end if

ls_Data = ad_dw.GetItemString(ll_getRow, "usecenter")
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '사용처'
as_colname = 'usecenter';If ls_message <> '' Then Return ls_message

li_Data = ad_dw.GetItemNumber(ll_getRow, "rackqty")
If IsNull(li_Data) or trim(ls_data) = '' Then ls_message = '수용수'
as_colname = 'rackqty';If ls_message <> '' Then Return ls_message

ls_Data = ad_dw.GetItemString(ll_getRow, "rackcode")
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '용기코드'
as_colname = 'rackcode';If ls_message <> '' Then Return ls_message

ls_Data = ad_dw.GetItemString(ll_getRow, "stockgubun")
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '저장위치구분'
as_colname = 'stockgubun';If ls_message <> '' Then Return ls_message

ls_Data = ad_dw.GetItemString(ll_getRow, "receiptlocation")
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '저장위치'
as_colname = 'receiptlocation';If ls_message <> '' Then Return ls_message

li_Data = ad_dw.GetItemNumber(ll_getRow, "safetystock")
If IsNull(li_Data) or trim(ls_data) = '' Then ls_message = '안전재고일'
as_colname = 'safetystock';If ls_message <> '' Then Return ls_message

ls_Data = ad_dw.GetItemString(ll_getRow, "useflag")
If IsNull(ls_data) or trim(ls_data) = '' Then ls_message = '사용여부'
as_colname = 'useflag';If ls_message <> '' Then Return ls_message

li_Data = ad_dw.GetItemNumber(ll_getRow, "mailboxno")
If IsNull(li_Data) or trim(ls_data) = '' Then ls_message = 'MailBox번호' 
as_colname = 'mailboxno';If ls_message <> '' Then Return ls_message

Return '' 
end function

public function long wf_set_tmstpartkb ();///////////////////////////////////////////////////////
//		간판 마스터의 편집외 항목을 셋팅한다.
///////////////////////////////////////////////////////
IF uo_area.is_uo_areacode = '%' THEN 
	MessageBox("등록불가능", "지역코드선택이 올바르지 않습니다. ", StopSign! )
	Return -1
END IF

String	ls_partID, ls_next_partID, ls_nomalSN, ls_tempSN
Long		ll_currentRow,ll_printCnt, ll_activeCnt, ll_planCnt
String	ls_autoFalg, ls_toDay

ll_currentRow = dw_pisr010u_02.Getrow()
IF dw_pisr010u_02.GetItemString( ll_currentRow, "parttype") = "R" THEN	//후보충품은 입고동시발주
	ls_AutoFalg = "Y"
ELSE
	ls_AutoFalg = "N"
END IF
ls_toDay = f_pisr_get_today()

dw_pisr010u_02.SetItem( ll_currentRow, "areacode"			, uo_area.is_uo_areacode )
dw_pisr010u_02.SetItem( ll_currentRow, "changeflag"		, "Y" )
dw_pisr010u_02.SetItem( ll_currentRow, "autoreorderflag"	, ls_AutoFalg )
dw_pisr010u_02.SetItem( ll_currentRow, "kbuseflag"			, "Y" )			//간판품목만 처리
dw_pisr010u_02.SetItem( ll_currentRow, "changedate"		, ls_toDay )

  SELECT TMSTPARTKB.PartID,   
         TMSTPARTKB.NormalKBSN,   
         TMSTPARTKB.TempKBSN,   
         TMSTPARTKB.PartKBPrintCount,   
         TMSTPARTKB.PartKBActiveCount,   
         TMSTPARTKB.PartKBPlanCount  
    INTO :ls_partID,   
         :ls_nomalSN,   
         :ls_tempSN,   
         :ll_printCnt,   
         :ll_activeCnt,   
         :ll_planCnt  
    FROM TMSTPARTKB  
   WHERE TMSTPARTKB.AreaCode 		= :uo_area.is_uo_areacode  AND  
         TMSTPARTKB.DivisionCode = :istr_partkb.divcode   AND  
         TMSTPARTKB.SupplierCode = :istr_partkb.suppcode  AND  
         TMSTPARTKB.ItemCode 		= :istr_partkb.itemcode 
	USING sqlpis;

IF sqlpis.SqlCode = 0 THEN
	is_savestatus	= '2'		//마스터수정
	dw_pisr010u_02.SetItem( ll_currentRow, "partid"				, ls_partID )
	dw_pisr010u_02.SetItem( ll_currentRow, "normalkbsn"		, ls_nomalSN )
	dw_pisr010u_02.SetItem( ll_currentRow, "tempkbsn"			, ls_tempSN )
	dw_pisr010u_02.SetItem( ll_currentRow, "partkbprintcount", ll_printCnt )
	dw_pisr010u_02.SetItem( ll_currentRow, "partkbactivecount",ll_activeCnt )
	dw_pisr010u_02.SetItem( ll_currentRow, "partkbplancount"	, ll_planCnt )
	dw_pisr010u_02.SetItem( ll_currentRow, "lastemp"			, 'Y' )	//Interface Flag 활용
ELSE
	is_savestatus	= '1'		//신규마스터생성
	SELECT 	max(TMSTPARTKB.PartID) INTO :ls_partID 
	  FROM 	TMSTPARTKB  
	 WHERE 	TMSTPARTKB.AreaCode 		= :uo_area.is_uo_areacode AND  
				TMSTPARTKB.DivisionCode = :istr_partkb.divCode  AND  
				TMSTPARTKB.SupplierCode = :istr_partkb.suppCode
	 USING 	sqlpis	;
	 
	IF sqlpis.SqlCode <> 0 OR IsNull(ls_partID) OR trim(ls_partID) = '' THEN 
		ls_next_partID = '01'
	ELSE
//		ls_partID = f_pisr_string1add( ls_partID )
		If Not f_pisc_get_string_add(ls_partID, ls_next_partID) Then 
			MessageBox("등록불가능", "해당 업체에 등록할 수 있는 항목의 최대치를 초과하였습니다.", StopSign! )
			Return -1
		End If
	END IF
	ls_nomalSN = uo_area.is_uo_areacode + istr_partkb.divCode + Mid( istr_partkb.suppCode, 2, 5 ) + &
	             ls_next_partID + '000'
	ls_tempSN = left( ls_nomalSN, 8 ) + 'X00'
	dw_pisr010u_02.SetItem( ll_currentRow, "partid"				, ls_next_partID )
	dw_pisr010u_02.SetItem( ll_currentRow, "normalkbsn"		, ls_nomalSN )
	dw_pisr010u_02.SetItem( ll_currentRow, "tempkbsn"			, ls_tempSN )
	dw_pisr010u_02.SetItem( ll_currentRow, "partkbprintcount", 0 )
	dw_pisr010u_02.SetItem( ll_currentRow, "partkbactivecount",0 )
	dw_pisr010u_02.SetItem( ll_currentRow, "partkbplancount"	, 0 )
	dw_pisr010u_02.SetItem( ll_currentRow, "lastemp"			, 'Y' )	//Interface flag 활용
END IF

Return 1
end function

public function integer wf_divisionvalid_chk (string as_colname, string as_divcode);Integer li_Chk
String  ls_areaCode, ls_Null

SetNull(ls_Null)
ls_areaCode = uo_area.is_uo_areacode

  SELECT count(DivisionCode)  
    INTO :li_Chk  
    FROM TMSTDIVISION  
   WHERE TMSTDIVISION.AreaCode 		= :ls_areaCode  AND
	   	TMSTDIVISION.DivisionCode 	= :as_divCode  
	USING	sqlpis	;
	
If li_Chk > 0 Then Return 1

dw_pisr010u_02.SetItem( dw_pisr010u_02.Getrow(), as_colName, ls_Null )

Return -1

end function

public function integer wf_insertrow ();////////////////////////////////////////////////////
//      기존 간판정보 Retrieve
////////////////////////////////////////////////////
String	ls_areaCode, ls_divCode, ls_suppCode, ls_itemCode, ls_applyFrom
String	ls_partType, ls_changeFlag, ls_modelID, ls_partID, ls_centerGubun 
String	ls_useCenter, ls_costGubun, ls_rackCode, ls_stockGubun, ls_Lacation
String	ls_useFlag
long		ll_rackQty, ll_mailboxNo, ll_safetyStock, ll_Row
DateTime	ldt_lastdate

ll_Row 			= dw_pisr010u_02.GetRow()
ls_divCode 		= dw_pisr010u_02.GetItemString( ll_Row, 'divisioncode' )
ls_suppCode 	= dw_pisr010u_02.GetItemString( ll_Row, 'suppliercode' )
ls_itemCode 	= dw_pisr010u_02.GetItemString( ll_Row, 'itemcode' )
ls_applyFrom 	= f_pisr_get_today()
ls_partType 	= dw_pisr010u_02.GetItemString( ll_Row, 'parttype' )
//ls_modelID 		= dw_pisr010u_02.GetItemString( ll_Row, 'partmodelid' )
ls_centerGubun	= dw_pisr010u_02.GetItemString( ll_Row, 'usecentergubun' )
ls_useCenter 	= dw_pisr010u_02.GetItemString( ll_Row, 'usecenter' )
ls_costGubun 	= dw_pisr010u_02.GetItemString( ll_Row, 'costgubun' )
ls_rackCode 	= dw_pisr010u_02.GetItemString( ll_Row, 'rackcode' )
ls_stockGubun 	= dw_pisr010u_02.GetItemString( ll_Row, 'stockgubun' )
ls_Lacation 	= dw_pisr010u_02.GetItemString( ll_Row, 'receiptlocation' )
ls_useFlag 		= dw_pisr010u_02.GetItemString( ll_Row, 'useflag' )
ll_rackQty 		= dw_pisr010u_02.GetItemNumber( ll_Row, 'rackqty' )
ll_mailboxNo 	= dw_pisr010u_02.GetItemNumber( ll_Row, 'mailboxno' )
ll_safetyStock = dw_pisr010u_02.GetItemNumber( ll_Row, 'safetystock' )

dw_pisr010u_02.SetRedraw(False)
dw_pisr010u_02.Reset()
dw_pisr010u_02.InsertRow(0)
dw_pisr010u_02.SetItem(ll_Row, "areacode"				, uo_area.is_uo_areacode)
dw_pisr010u_02.SetItem(ll_Row, "divisioncode"		, ls_divCode)
dw_pisr010u_02.SetItem(ll_Row, "suppliercode"		, ls_suppCode)
dw_pisr010u_02.SetItem(ll_Row, "itemcode"				, ls_itemCode)
dw_pisr010u_02.SetItem(ll_Row, "applyfrom"			, ls_applyFrom)
dw_pisr010u_02.SetItem(ll_Row, "parttype"				, ls_partType)
dw_pisr010u_02.SetItem(ll_Row, "usecentergubun"		, ls_centerGubun)
dw_pisr010u_02.SetItem(ll_Row, "usecenter"			, ls_useCenter)
dw_pisr010u_02.SetItem(ll_Row, "costgubun"			, ls_costGubun)
dw_pisr010u_02.SetItem(ll_Row, "rackqty"				, ll_rackQty)
dw_pisr010u_02.SetItem(ll_Row, "rackcode"				, ls_rackCode)
dw_pisr010u_02.SetItem(ll_Row, "stockgubun"			, ls_stockGubun)
dw_pisr010u_02.SetItem(ll_Row, "receiptlocation"	, ls_Lacation)
dw_pisr010u_02.SetItem(ll_Row, "mailboxno"			, ll_mailboxNo)
dw_pisr010u_02.SetItem(ll_Row, "safetystock"			, ll_safetyStock)
dw_pisr010u_02.SetItem(ll_Row, "useflag"				, ls_useFlag)
dw_pisr010u_02.SetItem(ll_Row, "inschk"				, 0)	//수정불가능처리(0이면 수정가능)
dw_pisr010u_02.SetRedraw(True)
 
Return(0)

end function

public function boolean wf_tmstpartkb_interface (string as_falg, ref datetime adt_nowtime);/////////////////////////////////////////////////////////
//			외주간판 사용등록/중단 유무 Interface 생성
/////////////////////////////////////////////////////////
String	ls_suppcode, ls_itemcode, ls_applyfrom
String	ls_useflag, ls_Today
Long		ll_useCnt, ll_Seq
//DateTime	ldt_nowtime

adt_nowtime	= f_pisc_get_date_nowtime()									//현재 시스템시간
ls_Today 	= Left(String(adt_nowtime, "yyyy.mm.dd hh:mm"), 10)

ls_suppcode		= Upper(dw_pisr010u_02.GetItemString( 1, 'suppliercode' ))
ls_itemcode		= Upper(dw_pisr010u_02.GetItemString( 1, 'itemcode' ))
ls_applyfrom	= dw_pisr010u_02.GetItemString( 1, 'applyfrom' )
ls_useflag 		= dw_pisr010u_02.GetItemString( 1, 'useflag' )

CHOOSE CASE as_falg
	CASE 'Delete'		//삭제
		If ls_useflag = 'N' Then//10
			  SELECT Count(*)
				 INTO :ll_useCnt  
				 FROM TMSTPARTKB  
				WHERE AreaCode 	 	= :istr_partkb.areacode AND  
						DivisionCode 	= :istr_partkb.divcode  AND  
						SupplierCode 	<> :ls_suppcode 			AND
						ItemCode 	 	= :ls_itemcode   			AND
						UseFlag			= 'N'
				USING	sqlpis	;
			If ll_useCnt < 1 Then//11
				  SELECT Count(*)
					 INTO :ll_Seq  
					 FROM TMSTPARTKB_INTERFACE  
					WHERE AreaCode 	 	= :istr_partkb.areacode AND  
							DivisionCode 	= :istr_partkb.divcode  AND  
							ItemCode 	 	= :ls_itemcode   			AND
							ApplyFrom		= :ls_Today					AND
							MISFlag			= 'D'
					USING	sqlpis	;
	
				ll_Seq = ll_Seq + 1	
				
				  INSERT INTO TMSTPARTKB_INTERFACE  
							( AreaCode,DivisionCode,ItemCode,ApplyFrom,SeqNo,MISFlag,InterfaceFlag,LastEmp,LastDate )  
				  VALUES ( :istr_partkb.areacode,   
							  :istr_partkb.divcode,   
							  :ls_itemcode,   
							  :ls_Today,   
							  :ll_Seq,   
							  'D',   
							  'Y',
							  :g_s_empno,
							  :adt_nowtime )  
					USING	sqlpis	;
				If sqlpis.SqlCode <> 0 Then Return False
			End If//11
		End If//10
	CASE ELSE	//'Edit' 수정 or 등록
		If as_falg = 'Restore' Then//8 
			If ls_useflag = 'Y' Then//9 
				ls_useflag = 'N'
			Else 
				ls_useflag = 'Y'
			End If//9	
		End If//8
		If ls_useflag = 'Y' Then//1					//사용중단처리 간판 사용'N' -> 사용중단'Y'로수정
			IF is_savestatus <> '1' THEN//2			//'0'조회, '1'신규, '2'수정
				  SELECT Count(*)
					 INTO :ll_useCnt  
					 FROM TMSTPARTKB  
					WHERE AreaCode 	 	= :istr_partkb.areacode AND  
							DivisionCode 	= :istr_partkb.divcode  AND  
							SupplierCode 	<> :ls_suppcode 			AND
							ItemCode 	 	= :ls_itemcode   			AND
							UseFlag			= 'N'
					USING	sqlpis	;
				If ll_useCnt < 1 Then//3
					  SELECT Count(*)
						 INTO :ll_Seq  
						 FROM TMSTPARTKB_INTERFACE  
						WHERE AreaCode 	 	= :istr_partkb.areacode AND  
								DivisionCode 	= :istr_partkb.divcode  AND  
								ItemCode 	 	= :ls_itemcode   			AND
								ApplyFrom		= :ls_applyfrom			AND
								MISFlag			= 'D'
						USING	sqlpis	;

					ll_Seq = ll_Seq + 1	
					
					  INSERT INTO TMSTPARTKB_INTERFACE  
								( AreaCode,DivisionCode,ItemCode,ApplyFrom,SeqNo,MISFlag,InterfaceFlag,LastEmp,LastDate )  
					  VALUES ( :istr_partkb.areacode,   
								  :istr_partkb.divcode,   
								  :ls_itemcode,   
								  :ls_applyfrom,   
								  :ll_Seq,   
								  'D',   
								  'Y',
								  :g_s_empno,
								  :adt_nowtime )  
						USING	sqlpis	;
					If sqlpis.SqlCode <> 0 Then Return False
				End If//3
			End If//2
		Else//1	//간판 사용중단'Y' -> 사용'N'으로수정
			  SELECT Count(*)
				 INTO :ll_useCnt  
				 FROM TMSTPARTKB  
				WHERE AreaCode 	 	= :istr_partkb.areacode AND  
						DivisionCode 	= :istr_partkb.divcode  AND  
						SupplierCode 	<> :ls_suppcode 			AND
						ItemCode 	 	= :ls_itemcode   			AND
						UseFlag			= 'N'
				USING	sqlpis	;
			If ll_useCnt < 1 Then//5
				  SELECT Count(*)
					 INTO :ll_Seq  
					 FROM TMSTPARTKB_INTERFACE  
					WHERE AreaCode 	 	= :istr_partkb.areacode AND  
							DivisionCode 	= :istr_partkb.divcode  AND  
							ItemCode 	 	= :ls_itemcode   			AND
							ApplyFrom		= :ls_applyfrom			AND
							MISFlag			= 'A'
					USING	sqlpis	;

				ll_Seq = ll_Seq + 1	
				
				  INSERT INTO TMSTPARTKB_INTERFACE  
							( AreaCode,DivisionCode,ItemCode,ApplyFrom,SeqNo,MISFlag,InterfaceFlag,LastEmp,LastDate )  
				  VALUES ( :istr_partkb.areacode,   
							  :istr_partkb.divcode,   
							  :ls_itemcode,   
							  :ls_applyfrom,   
							  :ll_Seq,   
							  'A',   
							  'Y',
							  :g_s_empno,
							  :adt_nowtime )  
					USING	sqlpis	;
				If sqlpis.SqlCode <> 0 Then Return False
			End If//5
		End If//1
END CHOOSE

return True
end function

public function integer wf_tmstpartkb_del (string as_arcacode, string as_divcode, string as_suppcode, string as_itemcode);
Integer ri_err

Declare proc_delPARTKB Procedure For sp_pisr010u_partkbdel
:istr_partkb.areaCode, :istr_partkb.divCode, :istr_partkb.suppCode, :istr_partkb.itemCode, @ri_err = 0 Output 
Using	sqlpis;
Execute proc_delPARTKB ;
If f_pisr_Errorhandler(sqlpis, "Execute proc_delPARTKB", "Faild") = 0 Then 
	Fetch proc_delPARTKB Into :ri_err ;
	If f_pisr_ErrorHandler(sqlpis, "Fetch proc_delPARTKB", "Failed") <> 0 Then
//		MessageBox ( "외주간판기본정보 삭제실패", "해당 외주간판의 삭제에 실패했습니다.", StopSign! )
		Close proc_delPARTKB ;
		Return -1 
	End If
Else
	Return -1 
End If
Close proc_delPARTKB ;

Return 1 
end function

public function integer wf_partkbhis_save (string as_applyfrom);////////////////////////////////////////////////////
//			간판마스터 History생성 
////////////////////////////////////////////////////
long 		ll_kbhisCnt
String 	ls_maxDate, ls_applyTo
ls_maxDate = '9999.12.31'

IF is_savestatus = '1' THEN				//신규 간판마스터
	Return 1
ELSEIF is_savestatus = '2' THEN			//수정 간판마스터
	ls_applyTo = f_pisr_getdaybefore( as_applyfrom, -1 )
  UPDATE TMSTPARTKBHIS  
     SET ApplyTo = :ls_applyTo,
			LastEmp		= 'Y',
			LastDate		= Getdate()
   WHERE TMSTPARTKBHIS.AreaCode 		= :istr_partkb.areacode  AND  
         TMSTPARTKBHIS.DivisionCode = :istr_partkb.divcode   AND  
         TMSTPARTKBHIS.SupplierCode = :istr_partkb.suppcode  AND  
         TMSTPARTKBHIS.ItemCode 		= :istr_partkb.itemcode  AND  
         TMSTPARTKBHIS.ApplyTo 		= :ls_maxDate    
   USING sqlpis       ;
	IF sqlpis.SqlCode <> 0 THEN 
//		Messagebox("외주간판이력생성실패", "해당 간판의 History저장에 실패했습니다.", StopSign!)
		Return -1 
	END IF
	Return 1
ELSEIF is_savestatus = '0' THEN			//조회 간판마스터
	Return -1 
END IF


////Integer ri_err
////
////Declare proc_crPARTKBHIS Procedure For sp_pisr_partkbhis_cr 
////:istr_partkb.areaCode, :istr_partkb.divCode, :istr_partkb.suppCode, :istr_partkb.itemCode, :as_applyFrom, :g_s_empno, @ri_err = 0 Output ;
////Execute proc_crPARTKBHIS ;
////If f_Error_handler(Sqlca, "Execute proc_crPARTKBHIS", "Faild") = 0 Then 
////	Fetch proc_crPARTKBHIS Into :ri_err ;
////	If f_Error_Handler(Sqlca, "Fetch proc_crPARTKBHIS", "Failed") <> 0 Then
////		Messagebox("외주간판이력생성실패", "해당 간판의 History저장에 실패했습니다.", StopSign!)
////		Close proc_crPARTKBHIS ;
////		Return -1 
////	End If
////Else
////	Return -1 
////End If
////Close proc_crPARTKBHIS ;
////
////Return 1 
//

end function

public function integer wf_rackvalid_chk (string as_colname, string as_rackcode);Integer li_Chk 
String ls_Null

SetNull(ls_Null) 

  SELECT count(RackCode)  
    INTO :li_Chk  
    FROM TMSTRACK  
   WHERE TMSTRACK.RackCode = :as_rackCode 
	USING	sqlpis	;
If li_Chk > 0 Then Return 1 
dw_pisr010u_02.SetItem( dw_pisr010u_02.Getrow(), as_colName, ls_Null ) 

Return -1 
end function

public function integer wf_initvalue (long al_insrow);///////////////////////////////////////////////////////////////
//		dw_pisr010u_02 데이타 윈도우 기본값설정 
///////////////////////////////////////////////////////////////
DataWindowChild ldwc
String 	ls_Null 
Long 		ll_Row
String	ls_divName, ls_suppName, ls_suppNo, ls_itemName, ls_itemSpec

ll_Row = dw_pisr010u_02.GetRow()
SetNull(ls_Null)//; SetNull(ls_suppName); SetNull(ls_itemName);

  SELECT TMSTDIVISION.DivisionName  
    INTO :ls_divName  
    FROM TMSTDIVISION  
   WHERE TMSTDIVISION.AreaCode 		= :uo_area.is_uo_areacode  AND  
         TMSTDIVISION.DivisionCode 	= :uo_division.is_uo_divisioncode 
	USING	sqlpis 	;

  SELECT TMSTSUPPLIER.SupplierNo,   
         TMSTSUPPLIER.SupplierKorName  
    INTO :ls_suppNo,   
         :ls_suppName  
    FROM TMSTSUPPLIER  
   WHERE TMSTSUPPLIER.SupplierCode = :istr_partkb.suppcode   
	USING	sqlpis 	;


IF al_insrow = 0 THEN		// 신규항목  생성시
	SetNull(istr_partkb.itemCode) 
   dw_pisr010u_02.SetItem(ll_row, "AreaCode"			, uo_area.is_uo_areacode)
   dw_pisr010u_02.SetItem(ll_row, "DivisionCode"	, uo_division.is_uo_divisioncode)
	dw_pisr010u_02.SetItem(ll_row, "SupplierCode"	, istr_partkb.suppcode)
	dw_pisr010u_02.SetItem(ll_row, "UseFlag"			, 'Y')
	dw_pisr010u_02.SetItem(ll_row, "lastemp"			, 'Y')	//Interface Flag 활용
   dw_pisr010u_02.Object.t_divname.Text 	= ls_divName
   dw_pisr010u_02.Object.t_suppno.Text 	= string(ls_suppNo, "@@@-@@-@@@@@")
   dw_pisr010u_02.Object.t_suppname.Text 	= ls_suppName
   dw_pisr010u_02.Object.t_itemname.Text 	= ''
   dw_pisr010u_02.Object.t_itemspec.Text 	= ''
   dw_pisr010u_02.Object.t_centername.Text= ''
END IF	

If dw_pisr010u_02.GetChild('rack_name', ldwc) <> -1 Then 
	ldwc.SetTransObject(Sqlpis); ldwc.ReSet() 
	If ldwc.Retrieve('%') = 0 Then ldwc.InsertRow(1)
End If 
Return 1


end function

public function long wf_set_saveflag ();long 		ll_row, ll_row2, ll_data, ll_data2
Integer	li_changeCnt
String 	ls_data, ls_data2
Dec{1}	lc_data, lc_data2
boolean 	lb_stockflag

li_changeCnt 	= 0
ib_prFlag		= False
ib_useflag		= False
lb_stockflag	= False

dw_pisr010u_02.AcceptText ( )
dw_temp.AcceptText ( )

ll_row 	= dw_pisr010u_02.GetRow()
ll_row2 	= dw_temp.GetRow()

//	1'parttype' 
if ll_row < 1 then
	ls_data = ''
else
	ls_data 	= dw_pisr010u_02.GetItemString( ll_row		, 'parttype' ) 
end if
if ll_row2 < 1 then
	ls_data2 = ''
else
	ls_data2 = 			dw_temp.GetItemString( ll_row2	, 'parttype' ) 
end if
IF isNull(ls_data)		THEN ls_data 	= ''
IF isNull(ls_data2) 		THEN ls_data2 	= ''
IF Trim(ls_data) <> Trim(ls_data2)	THEN 
	li_changeCnt++
	ib_prFlag	= True
End If
// 2'partmodelid' 
if ll_row < 1 then
	ls_data = ''
else
	ls_data 	= dw_pisr010u_02.GetItemString( ll_row		, 'partmodelid' ) 
end if
if ll_row2 < 1 then
	ls_data2 = ''
else
	ls_data2 = 			dw_temp.GetItemString( ll_row2	, 'partmodelid' ) 
end if
IF isNull(ls_data)		THEN ls_data 	= ''
IF isNull(ls_data2) 		THEN ls_data2 	= ''
IF Trim(ls_data) <> Trim(ls_data2)	THEN
	li_changeCnt++
	ib_modelidchangeflag = True
	ib_prFlag				= True
END IF
// 3'stockgubun'
if ll_row < 1 then
	ls_data = ''
else
	ls_data 	= dw_pisr010u_02.GetItemString( ll_row		, 'stockgubun' ) 
end if
if ll_row2 < 1 then
	ls_data2 = ''
else
	ls_data2 = 			dw_temp.GetItemString( ll_row2	, 'stockgubun' ) 
end if
IF isNull(ls_data)		THEN ls_data 	= ''
IF isNull(ls_data2) 		THEN ls_data2 	= ''
IF Trim(ls_data) <> Trim(ls_data2)	THEN li_changeCnt++
// 4'usecentergubun'
if ll_row < 1 then
	ls_data = ''
else
	ls_data 	= dw_pisr010u_02.GetItemString( ll_row		, 'usecentergubun' ) 
end if
if ll_row2 < 1 then
	ls_data2 = ''
else
	ls_data2 = 			dw_temp.GetItemString( ll_row2	, 'usecentergubun' ) 
end if
IF isNull(ls_data)		THEN ls_data 	= ''
IF isNull(ls_data2) 		THEN ls_data2 	= ''
IF Trim(ls_data) <> Trim(ls_data2)	THEN li_changeCnt++
// 5'usecenter'
if ll_row < 1 then
	ls_data = ''
else
	ls_data 	= dw_pisr010u_02.GetItemString( ll_row		, 'usecenter' ) 
end if
if ll_row2 < 1 then
	ls_data2 = ''
else
	ls_data2 = 			dw_temp.GetItemString( ll_row2	, 'usecenter' ) 
end if
IF isNull(ls_data)		THEN ls_data 	= ''
IF isNull(ls_data2) 		THEN ls_data2 	= ''
IF Trim(ls_data) <> Trim(ls_data2)	THEN li_changeCnt++
// 6'costgubun' 
if ll_row < 1 then
	ls_data = ''
else
	ls_data 	= dw_pisr010u_02.GetItemString( ll_row		, 'costgubun' ) 
end if
if ll_row2 < 1 then
	ls_data2 = ''
else
	ls_data2 = 			dw_temp.GetItemString( ll_row2	, 'costgubun' ) 
end if
IF isNull(ls_data)		THEN ls_data 	= ''
IF isNull(ls_data2) 		THEN ls_data2 	= ''
IF Trim(ls_data) <> Trim(ls_data2)	THEN li_changeCnt++
// 7'rackqty' 
if ll_row < 1 then
	ll_data = 0
else
	ll_data 	= dw_pisr010u_02.GetItemNumber( ll_row		, 'rackqty' ) 
end if
if ll_row2 < 1 then
	ll_data2 = 0
else
	ll_data2 = 			dw_temp.GetItemNumber( ll_row2	, 'rackqty' ) 
end if
IF isNull(ll_data)		THEN ll_data 	= 0
IF isNull(ll_data2) 		THEN ll_data2 	= 0
IF ll_data <> ll_data2	THEN
	li_changeCnt++
	ib_prFlag = True
End If
// 8'rackcode' 
if ll_row < 1 then
	ls_data = ''
else
	ls_data 	= dw_pisr010u_02.GetItemString( ll_row		, 'rackcode' ) 
end if
if ll_row2 < 1 then
	ls_data2 = ''
else
	ls_data2 = 			dw_temp.GetItemString( ll_row2	, 'rackcode' ) 
end if
IF isNull(ls_data)		THEN ls_data 	= ''
IF isNull(ls_data2) 		THEN ls_data2 	= ''
IF Trim(ls_data) <> Trim(ls_data2)	THEN
	li_changeCnt++
	ib_prFlag = True
End If
//	9'safetystock' 
if ll_row < 1 then
	lc_data = 0
else
	lc_data 	= dw_pisr010u_02.GetItemNumber( ll_row		, 'safetystock' ) 
end if
if ll_row2 < 1 then
	lc_data2 = 0
else
	lc_data2 = 			dw_temp.GetItemNumber( ll_row2	, 'safetystock' ) 
end if
IF isNull(lc_data)		THEN lc_data 	= 0
IF isNull(lc_data2) 		THEN lc_data2 	= 0
IF lc_data <> lc_data2	THEN 
	li_changeCnt++
	lb_stockflag = True
End If
//	10'receiptlocation' 
if ll_row < 1 then
	ls_data = ''
else
	ls_data 	= dw_pisr010u_02.GetItemString( ll_row		, 'receiptlocation' ) 
end if
if ll_row2 < 1 then
	ls_data2 = ''
else
	ls_data2 = 			dw_temp.GetItemString( ll_row2	, 'receiptlocation' ) 
end if
IF isNull(ls_data)		THEN ls_data 	= ''
IF isNull(ls_data2) 		THEN ls_data2 	= ''
IF Trim(ls_data) <> Trim(ls_data2)	THEN
	li_changeCnt++
	ib_prFlag = True
End If	
//	11'mailboxno' 
if ll_row < 1 then
	ll_data = 0
else
	ll_data 	= dw_pisr010u_02.GetItemNumber( ll_row		, 'mailboxno' ) 
end if
if ll_row2 < 1 then
	ll_data2 = 0
else
	ll_data2 = 			dw_temp.GetItemNumber( ll_row2	, 'mailboxno' ) 
end if
IF isNull(ll_data)		THEN ll_data 	= 0
IF isNull(ll_data2) 		THEN ll_data2 	= 0
IF ll_data <> ll_data2	THEN
	li_changeCnt++
	ib_prFlag = True
End If	
//	12'useflag' 
if ll_row < 1 then
	ls_data = ''
else
	ls_data 	= dw_pisr010u_02.GetItemString( ll_row		, 'useflag' ) 
end if
if ll_row2 < 1 then
	ls_data2 = ''
else
	ls_data2 = 			dw_temp.GetItemString( ll_row2	, 'useflag' ) 
end if
IF isNull(ls_data)		THEN ls_data 	= ''
IF isNull(ls_data2) 		THEN ls_data2 	= ''
IF Trim(ls_data) <> Trim(ls_data2)	THEN
	li_changeCnt++
	ib_useflag = True
End If

//	13'buybackflag' 
if ll_row < 1 then
	ls_data = ''
else
	ls_data 	= dw_pisr010u_02.GetItemString( ll_row		, 'buybackflag' ) 
end if
if ll_row2 < 1 then
	ls_data2 = ''
else
	ls_data2 = 			dw_temp.GetItemString( ll_row2	, 'buybackflag' ) 
end if
IF isNull(ls_data)		THEN ls_data 	= ''
IF isNull(ls_data2) 		THEN ls_data2 	= ''
IF ls_data <> ls_data2	THEN 
	li_changeCnt++
	lb_stockflag = True
End If

IF li_changeCnt < 1 THEN
	MessageBox( "저장 안함" , "수정된 항목이 없습니다." , Information! )
	Return -1 
ELSEIF li_changeCnt = 1 AND ib_modelidchangeflag THEN
   ib_hisflag = False; ib_saveflag = True
ELSEIF li_changeCnt = 1 AND lb_stockflag THEN
	ib_hisflag = False; ib_saveflag = True; ib_prFlag = False
ELSE
	ib_hisflag = True ; ib_saveflag = True
END IF
	
Return 1	
end function

on w_pisr010u.create
int iCurrent
call super::create
this.dw_pisr010u_01=create dw_pisr010u_01
this.dw_pisr010u_03=create dw_pisr010u_03
this.st_hsplitbar=create st_hsplitbar
this.st_vsplitbar=create st_vsplitbar
this.uo_area=create uo_area
this.uo_division=create uo_division
this.tv_partkb=create tv_partkb
this.cb_edit=create cb_edit
this.cb_search=create cb_search
this.cb_supplier=create cb_supplier
this.gb_1=create gb_1
this.dw_temp=create dw_temp
this.dw_pisr010u_02=create dw_pisr010u_02
this.cb_filter=create cb_filter
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisr010u_01
this.Control[iCurrent+2]=this.dw_pisr010u_03
this.Control[iCurrent+3]=this.st_hsplitbar
this.Control[iCurrent+4]=this.st_vsplitbar
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_division
this.Control[iCurrent+7]=this.tv_partkb
this.Control[iCurrent+8]=this.cb_edit
this.Control[iCurrent+9]=this.cb_search
this.Control[iCurrent+10]=this.cb_supplier
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.dw_temp
this.Control[iCurrent+13]=this.dw_pisr010u_02
this.Control[iCurrent+14]=this.cb_filter
this.Control[iCurrent+15]=this.gb_2
end on

on w_pisr010u.destroy
call super::destroy
destroy(this.dw_pisr010u_01)
destroy(this.dw_pisr010u_03)
destroy(this.st_hsplitbar)
destroy(this.st_vsplitbar)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.tv_partkb)
destroy(this.cb_edit)
destroy(this.cb_search)
destroy(this.cb_supplier)
destroy(this.gb_1)
destroy(this.dw_temp)
destroy(this.dw_pisr010u_02)
destroy(this.cb_filter)
destroy(this.gb_2)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

tv_partkb.Height 		= newheight - ( tv_partkb.y + ls_status )
dw_pisr010u_01.Width = newwidth - ( dw_pisr010u_01.x + ls_gap )
dw_pisr010u_01.Height= newheight - ( dw_pisr010u_01.y + dw_pisr010u_02.Height + ls_status + ls_split )
dw_pisr010u_02.y 		= dw_pisr010u_01.y + dw_pisr010u_01.Height + ls_split
dw_pisr010u_02.Width = newwidth - ( dw_pisr010u_02.x + dw_pisr010u_03.Width + ls_gap * 2 )
dw_pisr010u_03.x 		= dw_pisr010u_02.x + dw_pisr010u_02.Width 
dw_pisr010u_03.y 		= dw_pisr010u_02.y
dw_pisr010u_03.Height= dw_pisr010u_02.Height 

st_vsplitbar.y 		= tv_partkb.y
st_vsplitbar.Height 	= tv_partkb.Height
st_hsplitbar.x 		= dw_pisr010u_01.x
st_hsplitbar.y 		= dw_pisr010u_02.y - ls_split
st_hsplitbar.Width 	= dw_pisr010u_01.Width 

end event

event ue_insert;call super::ue_insert;///////////////////////////////////
//  		신규 간판 등록 
///////////////////////////////////
dw_pisr010u_02.Reset()
dw_pisr010u_02.ScrolltoRow(dw_pisr010u_02.InsertRow(0))
IF wf_initvalue(0) = -1 THEN RETURN -1

Return 1

end event

event ue_delete;call super::ue_delete;//dw_pisr010u_01.TriggerEvent("ue_deleterow") 
Long 		ll_Row
String	ls_suppCode, ls_itemCode, ls_applyFrom, ls_oldFrom, ls_applyTo
String 	ls_ActionFlag
Integer  li_Net
String	ls_suppName, ls_itemName
String	ls_MaxDate = '9999.12.31'
String	ls_DeleteKey
DateTime ldt_nowtime
String	ls_olduseflag
String	ls_message = ''

dw_pisr010u_01.AcceptText()
ll_Row	= dw_pisr010u_01.GetRow()
If ll_Row < 1 Then 
	MessageBox("확인","삭제할 간판마스타를 선택하세요", Information!)
	Return 0
End If

ls_suppCode		= dw_pisr010u_01.GetItemString(ll_Row, 'tmstpartkb_suppliercode')
ls_itemCode		= dw_pisr010u_01.GetItemString(ll_Row, 'tmstpartkb_itemcode')
ls_itemName		= dw_pisr010u_01.GetItemString(ll_Row, 'tmstitem_itemname')
ls_applyFrom	= dw_pisr010u_01.GetItemString(ll_Row, 'tmstpartkb_applyfrom')
ls_applyTo		= f_pisr_getdaybefore(ls_applyFrom, -1)

//간판 삭제 ValidChk
	Select count(PartKBNo) 
	  Into :li_Net 
	  FROM TPARTKBSTATUS  
	 WHERE TPARTKBSTATUS.AreaCode 	 = :istr_partkb.AreaCode And 
			 TPARTKBSTATUS.DivisionCode = :istr_partkb.divCode  AND
			 TPARTKBSTATUS.SupplierCode = :ls_suppCode 			 AND
			 TPARTKBSTATUS.ItemCode 	 = :ls_itemCode 			 And
			 TPARTKBSTATUS.ApplyFrom 	 >= :ls_applyFrom 
	 Using sqlpis ;

If li_Net > 0 Then 
	MessageBox( "삭제실패", "해당업체의 " + ls_itemName + " 품목에대한 개별간판이 존재하므로 삭제할 수 없습니다.", Information! )
	Return 0 
End If 
//

//History 정보 검색
  SELECT TMSTPARTKBHIS.ApplyFrom,
  			TMSTPARTKBHIS.UseFlag
    INTO :ls_oldFrom,
	 		:ls_olduseflag
    FROM TMSTPARTKBHIS  
   WHERE TMSTPARTKBHIS.AreaCode 		= :istr_partkb.areacode AND  
         TMSTPARTKBHIS.DivisionCode = :istr_partkb.divcode	AND  
         TMSTPARTKBHIS.SupplierCode = :ls_suppCode				AND  
         TMSTPARTKBHIS.ItemCode 		= :ls_itemCode				AND  
         TMSTPARTKBHIS.ApplyTo 		= :ls_applyTo  
	USING	sqlpis	;
	
If sqlpis.SqlCode <> 0 	Then
	ls_ActionFlag	 = 'Delete'
Else
	ls_ActionFlag	 = 'Restore'
End If

	SELECT TMSTSUPPLIER.SupplierKorName  
	  INTO :ls_suppName  
	  FROM TMSTSUPPLIER  
	 WHERE TMSTSUPPLIER.SupplierCode = :ls_suppCode
	 USING sqlpis	;

CHOOSE CASE ls_ActionFlag
	CASE 'Delete'
		li_Net = MessageBox("확인요청", 	ls_suppName + " 의 ~r~n" + & 
												 	ls_itemName + " 항목의 ~r~n" + & 
												 	"간판기본정보를 삭제 하시겠습니까 ? ",& 
													Question!, YesNo!, 2)
		IF li_Net = 1 THEN
			sqlpis.AutoCommit = False
			///////////////////////////////////////////////////////
			//		외주간판대상 등록 및 사용중단 Interface 처리
			///////////////////////////////////////////////////////
			If Not wf_tmstpartkb_interface( 'Delete', ldt_nowtime ) Then 
				ls_message = 'interface_Err'
//				MessageBox( "오류", "간판적용유무정보의 Interface처리에 실패했습니다.", StopSign! )
				Goto RollBack_
			End If
			///
			
			////If wf_tmstpartkb_del(istr_partkb.AreaCode, tv_partkb.uistr_partKb.divCode, tv_partkb.uistr_partKb.suppCode, ls_itemCode) = -1 Then Goto RollBack_
			//	TMSTPARTKB 항목 삭제
			ls_DeleteKey = Trim(istr_partkb.areacode) +'/'+ Trim(istr_partkb.divcode) +'/'+ Trim(ls_suppCode) +'/'+ Trim(ls_itemCode) 
			  INSERT INTO TDELETE  
						( TableName, DeleteData, DeleteTime, LastEmp, LastDate )  
			  VALUES ( 'TMSTPARTKB', :ls_DeleteKey, :ldt_nowtime, :g_s_empno, :ldt_nowtime )  
	 			USING sqlpis	;
			IF sqlpis.SqlCode <> 0 Then 
				ls_message = 'TMSTPARTKB_Err'
//				MessageBox("간판삭제오류","간판기본정보삭제에서 오류가 발생했습니다.", StopSign!)
				Goto RollBack_		
			End If
			  DELETE FROM TMSTPARTKB  
				WHERE TMSTPARTKB.AreaCode 		= :istr_partkb.areacode AND  
						TMSTPARTKB.DivisionCode = :istr_partkb.divcode	AND  
						TMSTPARTKB.SupplierCode = :ls_suppCode				AND  
						TMSTPARTKB.ItemCode 		= :ls_itemCode				
	 			USING sqlpis	;
			IF sqlpis.SqlCode <> 0 Then 
				ls_message = 'TMSTPARTKB_Err'
//				MessageBox("간판삭제오류","간판기본정보삭제에서 오류가 발생했습니다.", StopSign!)
				Goto RollBack_		
			End If

			//	TMSTORDERRATE 항목 삭제
			  INSERT INTO TDELETE  
						( TableName, DeleteData, DeleteTime, LastEmp, LastDate )  
			  VALUES ( 'TMSTORDERRATE', :ls_DeleteKey, :ldt_nowtime, :g_s_empno, :ldt_nowtime )  
	 			USING sqlpis	;
			IF sqlpis.SqlCode <> 0 Then 
				ls_message = 'TMSTORDERRATE_Err'
//				MessageBox("간판삭제오류","자재 이원화비율 정보 삭제에서 오류가 발생했습니다.", StopSign!)
				Goto RollBack_		
			End If
			  DELETE FROM TMSTORDERRATE
				WHERE TMSTORDERRATE.AreaCode 		= :istr_partkb.areacode AND  
						TMSTORDERRATE.DivisionCode = :istr_partkb.divcode	AND  
						TMSTORDERRATE.SupplierCode = :ls_suppCode				AND  
						TMSTORDERRATE.ItemCode 		= :ls_itemCode				
	 			USING sqlpis	;
			IF sqlpis.SqlCode <> 0 Then 
				ls_message = 'TMSTORDERRATE_Err'
//				MessageBox("간판삭제오류","자재 이원화비율 정보 삭제에서 오류가 발생했습니다.", StopSign!)
				Goto RollBack_		
			End If

			//	TMSTPARTKBHIS 항목 삭제
			ls_DeleteKey = Trim(istr_partkb.areacode) +'/'+ Trim(istr_partkb.divcode) +'/'+ Trim(ls_suppCode) +'/'+ Trim(ls_itemCode) +'/'+ Trim(ls_applyFrom) 
			  INSERT INTO TDELETE  
						( TableName, DeleteData, DeleteTime, LastEmp, LastDate )  
			  VALUES ( 'TMSTPARTKBHIS', :ls_DeleteKey, :ldt_nowtime, :g_s_empno, :ldt_nowtime )  
	 			USING sqlpis	;
			IF sqlpis.SqlCode <> 0 Then 
				ls_message = 'TMSTPARTKBHIS_Err'
//				MessageBox("간판삭제오류","간판기본정보HISTORY삭제에서 오류가 발생했습니다.", StopSign!)
				Goto RollBack_		
			End If
			  DELETE FROM TMSTPARTKBHIS  
				WHERE TMSTPARTKBHIS.AreaCode 		= :istr_partkb.areacode AND  
						TMSTPARTKBHIS.DivisionCode = :istr_partkb.divcode	AND  
						TMSTPARTKBHIS.SupplierCode = :ls_suppCode				AND  
						TMSTPARTKBHIS.ItemCode 		= :ls_itemCode				AND  
						TMSTPARTKBHIS.ApplyFrom 	= :ls_applyFrom  
	 			USING sqlpis	;
			IF sqlpis.SqlCode <> 0 Then 
				ls_message = 'TMSTPARTKBHIS_Err'
//				MessageBox("간판삭제오류","간판기본정보HISTORY삭제에서 오류가 발생했습니다.", StopSign!)
				Goto RollBack_		
			End If
			ls_message = 'Undo_Ok'
//			MessageBox("간판삭제성공","해당간판의 기본정보를 삭제 하였습니다.", Information!)
		ELSE
			MessageBox("간판삭제","간판 기본정보삭제가 취소되었습니다.", Information!)
			Return 0
		END IF
	CASE 'Restore'
		li_Net = MessageBox("확인요청", 	ls_suppName + " 의 ~r~n" + & 
												 	ls_itemName + " 항목의 기본정보를 ~r~n" + & 
												 	ls_oldFrom + " 일자의 정보로 복원하시겠습니까 ? ",& 
													Question!, YesNo!, 2)
		IF li_Net = 1 THEN
			sqlpis.AutoCommit = False
			///////////////////////////////////////////////////////
			//		외주간판대상 등록 및 사용중단 Interface 처리
			///////////////////////////////////////////////////////
			String	ls_useflag
			ib_useflag = False
			ls_useflag = dw_pisr010u_02.GetItemString( 1, 'useflag' )
			If ls_useflag <> ls_olduseflag Then ib_useflag = True
			If ib_useflag Then
				If Not wf_tmstpartkb_interface( 'Restore', ldt_nowtime ) Then 
					ls_message = 'interface_Err2'
//					MessageBox( "오류", "간판적용유무정보의 Interface처리에 실패했습니다.", StopSign! )
					Goto RollBack_
				End If
			Else 
				ldt_nowtime	= f_pisc_get_date_nowtime()				//현재 시스템시간
			End If
			///
			
			// TMSTPARTKB 삭제
			ls_DeleteKey = Trim(istr_partkb.areacode) +'/'+ Trim(istr_partkb.divcode) +'/'+ Trim(ls_suppCode) +'/'+ Trim(ls_itemCode) 
			  INSERT INTO TDELETE  
						( TableName, DeleteData, DeleteTime, LastEmp, LastDate )  
			  VALUES ( 'TMSTPARTKB', :ls_DeleteKey, :ldt_nowtime, :g_s_empno, :ldt_nowtime )  
	 			USING sqlpis	;
			IF sqlpis.SqlCode <> 0 Then 
				ls_message = 'TMSTPARTKB_Err2'
//				MessageBox("간판복원오류","간판기본정보삭제에서 오류가 발생했습니다.", StopSign!)
				Goto RollBack_		
			End If
			  DELETE FROM TMSTPARTKB  
				WHERE TMSTPARTKB.AreaCode 		= :istr_partkb.areacode AND  
						TMSTPARTKB.DivisionCode = :istr_partkb.divcode	AND  
						TMSTPARTKB.SupplierCode = :ls_suppCode				AND  
						TMSTPARTKB.ItemCode 		= :ls_itemCode		
	 			USING sqlpis	;
			IF sqlpis.SqlCode <> 0 Then 
				ls_message = 'TMSTPARTKB_Err2'
//				MessageBox("간판복원오류","간판기본정보삭제에서 오류가 발생했습니다.", StopSign!)
				Goto RollBack_		
			End If

			  INSERT INTO TMSTPARTKB  
			  SELECT A.AreaCode,   
						A.DivisionCode,   
						A.SupplierCode,   
						A.ItemCode,   
						A.ApplyFrom,   
						A.PartType,   
						A.ChangeFlag,   
						A.PartModelID,   
						A.PartID,   
						A.UseCenterGubun,   
						A.UseCenter,   
						A.CostGubun,   
						A.RackQty,   
						A.RackCode,   
						A.StockGubun,   
						A.ReceiptLocation,   
						A.MailBoxNo,   
						A.SafetyStock,   
						A.UseFlag,   
						A.AutoReorderFlag,   
						A.KBUseFlag,   
						A.ChangeDate,   
						A.NormalKBSN,   
						A.TempKBSN,   
						A.PartKBPrintCount,   
						A.PartKBActiveCount,   
						A.PartKBPlanCount,
						A.BuyBackFlag,
						'Y',	//Interface flag 활용
						:ldt_nowtime
				 FROM TMSTPARTKBHIS A
				WHERE A.AreaCode 		= :istr_partkb.areacode AND  
						A.DivisionCode = :istr_partkb.divcode	AND  
						A.SupplierCode = :ls_suppCode				AND  
						A.ItemCode 		= :ls_itemCode				AND  
						A.ApplyFrom 	= :ls_oldFrom  
	 			USING sqlpis	;
			IF sqlpis.SqlCode <> 0 Then 
				ls_message = 'TMSTPARTKB_Err3'
//				MessageBox("간판복원오류","간판기본정보복원에서 오류가 발생했습니다.", StopSign!)
				Goto RollBack_		
			End If
			
			// TMSTPARTKB 삭제
			ls_DeleteKey = Trim(istr_partkb.areacode) +'/'+ Trim(istr_partkb.divcode) +'/'+ Trim(ls_suppCode) +'/'+ Trim(ls_itemCode) +'/'+ Trim(ls_applyFrom) 
			  INSERT INTO TDELETE  
						( TableName, DeleteData, DeleteTime, LastEmp, LastDate )  
			  VALUES ( 'TMSTPARTKBHIS', :ls_DeleteKey, :ldt_nowtime, :g_s_empno, :ldt_nowtime )  
	 			USING sqlpis	;
			IF sqlpis.SqlCode <> 0 Then 
				ls_message = 'TMSTPARTKBHIS_Err2'
//				MessageBox("간판삭제오류","간판기본정보HISTORY삭제에서 오류가 발생했습니다.", StopSign!)
				Goto RollBack_		
			End If
				 
			  DELETE FROM TMSTPARTKBHIS  
				WHERE TMSTPARTKBHIS.AreaCode 		= :istr_partkb.areacode AND  
						TMSTPARTKBHIS.DivisionCode = :istr_partkb.divcode	AND  
						TMSTPARTKBHIS.SupplierCode = :ls_suppCode				AND  
						TMSTPARTKBHIS.ItemCode 		= :ls_itemCode				AND  
						TMSTPARTKBHIS.ApplyFrom 	= :ls_applyFrom  
	 			USING sqlpis	;
			IF sqlpis.SqlCode <> 0 Then 
				ls_message = 'TMSTPARTKBHIS_Err2'
//				MessageBox("간판삭제오류","간판기본정보HISTORY삭제에서 오류가 발생했습니다.", StopSign!)
				Goto RollBack_		
			End If

			  UPDATE TMSTPARTKBHIS  
				  SET ApplyTo = :ls_MaxDate,
				  		LastEmp = 'Y',		//Interface Flag 활용
				  		Lastdate= :ldt_nowtime
				WHERE TMSTPARTKBHIS.AreaCode 		= :istr_partkb.areacode AND  
						TMSTPARTKBHIS.DivisionCode = :istr_partkb.divcode	AND  
						TMSTPARTKBHIS.SupplierCode = :ls_suppCode				AND  
						TMSTPARTKBHIS.ItemCode 		= :ls_itemCode				AND  
						TMSTPARTKBHIS.ApplyFrom 	= :ls_oldFrom  
	 			USING sqlpis	;
			IF sqlpis.SqlCode <> 0 Then 
				ls_message = 'TMSTPARTKBHIS_Err3'
//				MessageBox("간판복원오류","간판기본정보History복원에서 오류가 발생했습니다.", StopSign!)
				Goto RollBack_		
			End If
			ls_message = 'Undo_Ok2'
//			MessageBox("간판복원성공","해당간판의 기본정보를 복원 하였습니다.", Information!)
		ELSE
			MessageBox("간판삭제","간판 기본정보복원이 취소되었습니다.", Information!)
			Return 0
		END IF
END CHOOSE

//성공
//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True

If	ls_message = 'Undo_Ok' Then
	MessageBox("삭제성공","해당간판의 기본정보를 삭제 하였습니다.", Information!)
ElseIf ls_message = 'Undo_Ok2' Then
	MessageBox("복원성공","해당간판의 기본정보를 복원 하였습니다.", Information!)
Else
	MessageBox("복원성공","해당간판의 기본정보를 복원 하였습니다.", Information!)
End If

This.TriggerEvent( "ue_retrieve" )

Return 0 

//실패
RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True

If	ls_message = 'interface_Err' Then
	MessageBox("삭제실패", "간판적용유무정보의 Interface처리에 실패했습니다.", StopSign! )
ElseIf ls_message = 'TMSTPARTKB_Err' Then
	MessageBox("삭제실패","간판삭제에서 오류가 발생했습니다.", StopSign!)
ElseIf ls_message = 'TMSTORDERRATE_Err' Then
	MessageBox("삭제실패","이원화비율 정보 삭제에서 오류가 발생했습니다.", StopSign!)
ElseIf ls_message = 'TMSTPARTKBHIS_Err' Then
	MessageBox("삭제실패","간판 HISTORY삭제에서 오류가 발생했습니다.", StopSign!)
ElseIf ls_message = 'interface_Err2' Then
	MessageBox("복원실패","간판적용유무정보의 Interface처리에 실패했습니다.", StopSign! )
ElseIf ls_message = 'TMSTPARTKB_Err2' Then
	MessageBox("복원실패","간판삭제에서 오류가 발생했습니다.", StopSign!)
ElseIf ls_message = 'TMSTPARTKB_Err3' Then
	MessageBox("복원실패","간판복원에서 오류가 발생했습니다.", StopSign!)
ElseIf ls_message = 'TMSTPARTKBHIS_Err2' Then
	MessageBox("복원실패","간판 HISTORY삭제에서 오류가 발생했습니다.", StopSign!)
ElseIf ls_message = 'TMSTPARTKBHIS_Err3' Then
	MessageBox("복원실패","간판 History복원에서 오류가 발생했습니다.", StopSign!)
Else 
	MessageBox("복원실패","간판복원에서 오류가 발생했습니다.", StopSign!)
End If

return -1

end event

event ue_retrieve;call super::ue_retrieve;//tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode)
dw_pisr010u_01.reset()
dw_pisr010u_02.reset()
dw_pisr010u_03.reset()

if ib_applyfilter then
	dw_pisr010u_01.SetRedraw(False)
	dw_pisr010u_01.SetTransObject(Sqlpis)
	dw_pisr010u_01.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode )
	dw_pisr010u_01.SetFilter("tmstpartkb_useflag = 'N'")
	dw_pisr010u_01.filter( );
	dw_pisr010u_01.SetRedraw(True)
	
	dw_pisr010u_03.SetRedraw(False)
	dw_pisr010u_03.SetTransObject(Sqlpis)
	dw_pisr010u_03.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode )
	dw_pisr010u_03.SetRedraw(True)
else
	dw_pisr010u_01.SetRedraw(False)
	dw_pisr010u_01.SetTransObject(Sqlpis)
	dw_pisr010u_01.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode )
	dw_pisr010u_01.SetFilter("tmstpartkb_useflag = 'Y'")
	dw_pisr010u_01.filter( );
	dw_pisr010u_01.SetRedraw(True)
	
	dw_pisr010u_03.SetRedraw(False)
	dw_pisr010u_03.SetTransObject(Sqlpis)
	dw_pisr010u_03.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode )
	dw_pisr010u_03.SetRedraw(True)
end if
end event

event open;call super::open;
//itv_partkb = Create TreeView;    
//itv_partkb = tv_partkb

this.PostEvent ( "ue_init" )
end event

event ue_save;call super::ue_save;dw_pisr010u_02.TriggerEvent( "ue_savedata" )
end event

event ue_postopen;call super::ue_postopen;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr010u
end type

type dw_pisr010u_01 from u_vi_std_datawindow within w_pisr010u
event ue_deleterow ( )
integer x = 800
integer y = 196
integer width = 2802
integer height = 812
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisr010u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ib_multiselection = false
integer ii_selection = 1
end type

event ue_deleterow();//Long ll_delRow[]
//Integer I, li_delChk, li_kbChk 
//String ls_itemCode, ls_itemName 
//
////this.AcceptText()
////ll_delRow = This.GetRow()
////
////If ll_delrow = 0 Then
////	MessageBox("삭제실패", "삭제할 외주간판 항목이 선택되지 않았습니다", Information!)
////	Return 
////End If 
//If f_pisr_return_selected(This, ll_delRow ) = 0 Then
//	MessageBox("삭제실패", "삭제할 외주간판 항목이 선택되지 않았습니다", Information!)
//	Return 
//End If 
//
//Sqlpis.AutoCommit = False
//For I = 1 To UpperBound(ll_delRow[])
//	ls_itemCode = This.GetItemString(I, "tmstpartkb_itemcode")
//	
//	Select	count(PartKBNo) Into :li_kbChk 
//	FROM 		TPARTKBSTATUS  
//	WHERE		AreaCode 		= :istr_partkb.AreaCode And 
//	 			DivisionCode 	= :tv_partkb.uistr_partKb.divCode AND
//				SupplierCode 	= :tv_partkb.uistr_partKb.suppCode AND
//	 		 	ItemCode 		= :ls_itemCode 
//	Using	sqlpis ;
//	
//	If li_kbChk > 0 Then 
//		ls_itemName = This.GeTitemString(I, "tmstitem_itemname")
//		MessageBox( "삭제실패", "해당업체의 " + ls_itemName + " 품목에 대한 개별간판이 존재하므로 삭제할 수 없습니다.", Information! )
//		Continue 
//	Else
//		li_delChk++ 
//	End If 
//	
//   If wf_tmstpartkb_del(istr_partkb.AreaCode, tv_partkb.uistr_partKb.divCode, tv_partkb.uistr_partKb.suppCode, ls_itemCode) = -1 Then Goto RollBack_
//Next 
////If li_delChk = 0 Then 
////	Sqlpis.AutoCommit = True 
////	Return 
////End If
//Messagebox("간판기본정보삭제 성공", String( li_delChk ) + " 항목의 간판(들)이 삭제되었습니다.", Information!)
//
//f_pisr_sqlchkopt(Sqlpis, True)
//Parent.TriggerEvent("ue_retrieve") 
//
////Sqlpis.AutoCommit = True 
//Return 
//
//RollBack_:
//RollBack Using sqlpis;
//Sqlpis.AutoCommit = True 
//return
//
end event

event rowfocuschanged;long ll_rowcnt
If currentrow <= 0 Or RowCount() = 0 Then Return 0

istr_partkb.itemCode = This.GetItemString(currentrow, "tmstpartkb_itemcode") 

dw_pisr010u_02.SetRedraw(False)
dw_pisr010u_02.SetTransObject(Sqlpis)
ll_rowcnt = dw_pisr010u_02.Retrieve(istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode, istr_partkb.itemCode)
dw_pisr010u_02.SetRedraw(True)
dw_temp.settransobject(sqlpis)
dw_temp.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode, istr_partkb.itemCode )

//dw_pisr010u_02.Reset()
//dw_pisr010u_02.ScrolltoRow(dw_pisr010u_02.InsertRow(0))
//IF wf_initvalue( currentrow ) = -1 THEN 
//	RETURN 
//End If

end event

event retrieveend;call super::retrieveend;If rowcount = 0 Then 
	dw_pisr010u_02.Reset()
	dw_pisr010u_02.ScrolltoRow(dw_pisr010u_02.InsertRow(0))
	IF wf_initvalue(0) = -1 THEN RETURN
//	dw_pisr010u_02.SetItem(1, "areacode", istr_partkb.areacode )
//	dw_pisr010u_02.SetItem(1, "divisioncode", istr_partkb.divcode )
//	dw_pisr010u_02.SetItem(1, "suppliercode", istr_partkb.suppcode )
	RETURN 
End If

This.Event RowfocusChanged(1)
end event

type dw_pisr010u_03 from datawindow within w_pisr010u
integer x = 2775
integer y = 1024
integer width = 827
integer height = 880
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisr010u_03"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_hsplitbar from u_pism_splitbar within w_pisr010u
integer x = 800
integer y = 1004
integer width = 2802
boolean bringtotop = true
end type

type st_vsplitbar from u_pism_splitbar within w_pisr010u
integer x = 786
integer y = 200
integer width = 18
integer height = 1700
boolean bringtotop = true
end type

type uo_area from u_pisc_select_area within w_pisr010u
integer x = 82
integer y = 76
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_areacode + ' ' + is_uo_areaname)

istr_partkb.areacode = is_uo_areacode

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
istr_partkb.divcode = uo_division.is_uo_divisioncode
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode, true)
end event

type uo_division from u_pisc_select_division within w_pisr010u
integer x = 631
integer y = 76
integer taborder = 80
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//messagebox("", is_uo_divisioncode + ' ' + is_uo_divisionname + ' ' + is_uo_divisionnameeng)
istr_partkb.divcode = is_uo_divisioncode
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode, true)
end event

type tv_partkb from u_pisr_treeview within w_pisr010u
integer x = 5
integer y = 196
integer width = 782
integer height = 1700
integer taborder = 40
boolean bringtotop = true
end type

event selectionchanged;call super::selectionchanged;istr_partkb = uistr_partKB

//messagebox( '', istr_partkb.suppcode )
Parent.TriggerEvent( "ue_retrieve" )

end event

event constructor;call super::constructor;uf_setLevelGubun(2)

end event

type cb_edit from commandbutton within w_pisr010u
integer x = 1294
integer y = 60
integer width = 242
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "수정"
end type

event clicked;parent.TriggerEvent("ue_edit")
end event

type cb_search from commandbutton within w_pisr010u
integer x = 1993
integer y = 60
integer width = 439
integer height = 100
integer taborder = 160
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "간판품목검색"
end type

event clicked;parent.TriggerEvent( "ue_partkbsearch" )
end event

type cb_supplier from commandbutton within w_pisr010u
integer x = 1541
integer y = 60
integer width = 448
integer height = 100
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "납입주기등록"
end type

event clicked;parent.TriggerEvent( "ue_partkbcycle" )
end event

type gb_1 from groupbox within w_pisr010u
integer x = 18
integer width = 1221
integer height = 188
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type dw_temp from datawindow within w_pisr010u
integer x = 1696
integer y = 1248
integer width = 411
integer height = 432
boolean enabled = false
string title = "none"
string dataobject = "d_pisr010u_04"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_pisr010u_02 from datawindow within w_pisr010u
event ue_insertrow ( )
event keydown pbm_dwnkey
event type integer ue_savedata ( )
integer x = 800
integer y = 1024
integer width = 1970
integer height = 880
integer taborder = 20
string title = "none"
string dataobject = "d_pisr010u_02"
borderstyle borderstyle = stylelowered!
end type

event ue_insertrow();Long ll_insRow 
Integer li_Chk
//DataWindowChild ldwc

//If This.GetChild('use_workcenter_dd', ldwc) <> -1 Then 
//	ldwc.SetTransObject(Sqlpis); ldwc.Retrieve( istr_partkb.divCode ); ldwc.InsertRow(1)
//End If 
//
//If This.GetChild('item_name', ldwc) <> -1 Then 
//	ldwc.SetTransObject(Sqlpis); ldwc.ReSet() 
//	ldwc.Retrieve(istr_partkb.suppCode); ldwc.InsertRow(1)
//End If 

ll_insRow = This.InsertRow(0)

wf_initValue(ll_insRow)

this.Setcolumn("suppliercode")
This.Setfocus()

end event

event keydown;
If key = KeyEnter! or key = KeyDownArrow! Then 
	send(handle(this), 256, 9, long(0,0))
	Return 1
End If 
end event

event type integer ue_savedata();String 	ls_mess, ls_chkColNm, ls_modelID, ls_orgFrom, ls_chkgubun, ls_buybackflag
Long 		ll_twoCnt
String	ls_maxDate = '9999.12.31'
DateTime ldt_nowtime
String	ls_message = ""
Dec{1}	lc_safetystock

this.AcceptText()

//유무상전환시 유상단가 테이블 업데이트 로직추가 : 2003.10.21
ls_chkgubun = This.getitemstring( 1, 'costgubun')
if ls_chkgubun = 'Y' then
	if f_pisr_check_inv304(g_s_company,istr_partkb.areacode,istr_partkb.divcode, &
				istr_partkb.itemcode, 'A' ) then
		//pass		
	else
		messagebox("유무상전환오류","외주기획담당자에게 해당품번에 대해서 " &
			+ "유상단가등록요청이 필요합니다")
		return -1
	end if
else
	if f_pisr_check_inv304(g_s_company,istr_partkb.areacode,istr_partkb.divcode, &
				istr_partkb.itemcode, 'B' ) then
		//pass		
	else
		messagebox("유무상전환오류","시스템개발팀으로 연락바랍니다.")
		return -1
	end if
end if

If wf_set_saveflag() = -1 Then Return -1 			//수정항목 확인 및 Flag설정

ls_mess = wf_data_chk( This, ls_chkColNm )		//입력완료 확인
If ls_mess <> '' Then 
	MessageBox("입력부족", ls_mess + " 이(가) 입력되지 않았습니다.", Information!)
	This.Setcolumn( ls_chkColNm ); This.SetFocus() 
	Return -1 
End If

If wf_set_tmstpartkb() = -1 Then Return -1 		//기타항목 설정

is_inputapplyfrom = this.GetItemString(1, 'applyfrom')

sqlpis.AutoCommit = False

///////////////////////////////////////////////////////
//		외주간판대상 등록 및 사용중단 Interface 처리
///////////////////////////////////////////////////////
If ib_useflag Then
	If Not wf_tmstpartkb_interface( 'Edit', ldt_nowtime ) Then 
//		MessageBox( "오류", "간판적용유무정보의 Interface처리에 실패했습니다.", StopSign! )
		ls_message = "Interface_Err"
		Goto RollBack_
	End If
Else
	ldt_nowtime	= f_pisc_get_date_nowtime()			//현재 시스템시간
End If

//***************************************
//* 수정 : If ib_hisflag = false 이면 적용일자를 원래일자로 되돌림.
//* 수정일자 : 2006.10.11
//***************************************
If ib_hisflag Then 											//History 저장
	If wf_partkbhis_save(is_inputapplyfrom) = -1 Then Goto RollBack_
//ELSEIF ib_modelidchangeflag AND ib_saveFlag THEN 	//배번호만 수정할 경우: 적용시작일자를 원래일자로 복원
Else
	SELECT TMSTPARTKB.ApplyFrom
    	INTO :ls_orgFrom  
   FROM TMSTPARTKB  
   WHERE TMSTPARTKB.AreaCode 		= :istr_partkb.areacode  	AND  
         TMSTPARTKB.DivisionCode = :istr_partkb.divcode  	AND  
         TMSTPARTKB.SupplierCode = :istr_partkb.suppcode 	AND
         TMSTPARTKB.ItemCode 		= :istr_partkb.itemcode   
	USING	sqlpis	;
	dw_pisr010u_02.SetItem( dw_pisr010u_02.GetRow(), 'applyfrom', ls_orgFrom )
End If 

ls_modelID = dw_pisr010u_02.GetItemString( dw_pisr010u_02.GetRow(), 'partmodelid' )
lc_safetystock = dw_pisr010u_02.GetItemNumber( dw_pisr010u_02.GetRow(), 'safetystock' )
ls_buybackflag = dw_pisr010u_02.GetItemString( dw_pisr010u_02.GetRow(), 'buybackflag' )

IF ib_modelidchangeflag THEN								//배번호 변경시 이원화된업체의 마스터도 수정한다.
  SELECT Count( TMSTPARTKB.PartModelID )
    INTO :ll_twoCnt  
    FROM TMSTPARTKB  
   WHERE TMSTPARTKB.AreaCode 		= :istr_partkb.areacode  	AND  
         TMSTPARTKB.DivisionCode = :istr_partkb.divcode  	AND  
         TMSTPARTKB.SupplierCode <> :istr_partkb.suppcode 	AND
         TMSTPARTKB.ItemCode 		= :istr_partkb.itemcode   
	USING	sqlpis	;
	IF ll_twoCnt > 0 THEN
//		MessageBox( "배번호변경", "해당 항목은 " + String( ll_twoCnt+1 ) + "개의 업체에 이원화되어 있습니다.~r~n" + &
//					   				  "각 업체 간판기본정보의 배번호가 모두 수정됩니다. ", Information! )
		ls_message = "ModelID_Ok"											  
	  	UPDATE TMSTPARTKB  
		  SET PartModelID = :ls_modelID,
				LastEmp		= 'Y',
				LastDate		= :ldt_nowtime
		WHERE TMSTPARTKB.AreaCode 		= :istr_partkb.areacode  	AND  
				TMSTPARTKB.DivisionCode = :istr_partkb.divcode  	AND  
				TMSTPARTKB.SupplierCode <> :istr_partkb.suppcode  	AND  
				TMSTPARTKB.ItemCode 		= :istr_partkb.itemcode    
		USING sqlpis  ;
		IF sqlpis.SqlCode <> 0 THEN
//				MessageBox( "배번호변경오류", "이원화 업체의 배번호변경에 실패했습니다.", StopSign! )
			ls_message = "ModelID_Err1"
			Goto RollBack_
		END IF
	  	UPDATE TMSTPARTKBHIS  
		  SET PartModelID = :ls_modelID,  
				LastEmp		= 'Y',
				LastDate		= :ldt_nowtime
		WHERE TMSTPARTKBHIS.AreaCode 		= :istr_partkb.areacode  	AND  
				TMSTPARTKBHIS.DivisionCode = :istr_partkb.divcode  	AND  
				TMSTPARTKBHIS.SupplierCode <> :istr_partkb.suppcode  	AND  
				TMSTPARTKBHIS.ItemCode 		= :istr_partkb.itemcode    AND
				TMSTPARTKBHIS.ApplyTo 		= :ls_maxDate    
		USING sqlpis  ;
		IF sqlpis.SqlCode <> 0 THEN
//				MessageBox( "배번호변경오류", "이원화 업체의 배번호변경에 실패했습니다.", StopSign! )
			ls_message = "ModelID_Err2"
			Goto RollBack_
		END IF
	  	UPDATE TPARTKBSTATUS  
		  SET RePrintFlag = 'Y',
				LastEmp		= 'Y',
				LastDate		= :ldt_nowtime
		WHERE TPARTKBSTATUS.AreaCode 		= :istr_partkb.areacode AND  
				TPARTKBSTATUS.DivisionCode = :istr_partkb.divcode 	AND  
				TPARTKBSTATUS.ItemCode 		= :istr_partkb.itemcode
		USING	sqlpis        ;
		If sqlpis.SqlCode = -1 Then 
//				MessageBox( "간판정보수정오류", "개별 간판정보 수정에서 오류가 발생하였습니다.", StopSign! )
			ls_message = "PartKBStatus_Err1"
			goto RollBack_	//개별 간판 재출력 요구
		End If
	END IF
END IF

This.SetTransObject(Sqlpis)							//마스터 저장
If This.Update() = -1 Then Goto RollBack_			

////////////////////////////////////////////////////
//      저장된마스터 내용 History Table에 저장
////////////////////////////////////////////////////
If ib_hisflag Then 											//History 저장
	
	Long 		ll_row
	String	ls_areacode, ls_divcode, ls_suppcode, ls_itemcode, ls_applyfrom, ls_empno
	
	dw_pisr010u_02.AcceptText()
	ll_row = dw_pisr010u_02.GetRow()
	ls_areacode		= dw_pisr010u_02.GetItemString( ll_row, 'areacode')
	ls_divcode		= dw_pisr010u_02.GetItemString( ll_row, 'divisioncode')
	ls_suppcode		= dw_pisr010u_02.GetItemString( ll_row, 'suppliercode')
	ls_itemcode		= dw_pisr010u_02.GetItemString( ll_row, 'itemcode')
	ls_applyfrom	= dw_pisr010u_02.GetItemString( ll_row, 'applyfrom')
	
	  INSERT INTO TMSTPARTKBHIS  
	  SELECT A.AreaCode,   
				A.DivisionCode,   
				A.SupplierCode,   
				A.ItemCode,   
				A.ApplyFrom,   
				:ls_maxDate, 
				A.PartType,   
				A.ChangeFlag,   
				A.PartModelID,   
				A.PartID,   
				A.UseCenterGubun,   
				A.UseCenter,   
				A.CostGubun,   
				A.RackQty,   
				A.RackCode,   
				A.StockGubun,   
				A.ReceiptLocation,   
				A.MailBoxNo,   
				A.SafetyStock,   
				A.UseFlag,   
				A.AutoReorderFlag,   
				A.KBUseFlag,   
				A.ChangeDate,   
				A.NormalKBSN,   
				A.TempKBSN,   
				A.PartKBPrintCount,   
				A.PartKBActiveCount,   
				A.PartKBPlanCount,
				A.BuyBackFlag,
				'Y',		//Interface Flag 활용
				:ldt_nowtime
		 FROM TMSTPARTKB A
		Where A.AreaCode 		= :ls_areacode And
				A.DivisionCode = :ls_divcode 	And
				A.SupplierCode = :ls_suppcode And
				A.itemCode 		= :ls_itemcode 
		USING sqlpis	;
	IF sqlpis.SqlCode <> 0 THEN
//		MessageBox("저장실패", "간판마스터 등록에 실패 했습니다. " , StopSign! )
		ls_message = "TMSTPARTKB_Err1"
		Goto RollBack_
	END IF
Else 
  UPDATE TMSTPARTKBHIS  
	  SET PartModelID = :ls_modelID,
	  		SafetyStock = :lc_safetystock,
			BuybackFlag = :ls_buybackflag,
			LastEmp		= 'Y',
			LastDate		= :ldt_nowtime
	WHERE TMSTPARTKBHIS.AreaCode 		= :istr_partkb.areacode  	AND  
			TMSTPARTKBHIS.DivisionCode = :istr_partkb.divcode  	AND  
			TMSTPARTKBHIS.SupplierCode = :istr_partkb.suppcode  	AND  
			TMSTPARTKBHIS.ItemCode 		= :istr_partkb.itemcode    AND
			TMSTPARTKBHIS.ApplyTo 		= :ls_maxDate    
	USING sqlpis  ;
	IF sqlpis.SqlCode <> 0 THEN
//		MessageBox( "배번호변경오류", "이원화 업체의 배번호변경에 실패했습니다.", StopSign! )
		ls_message = "ModelID_Err3"
		Goto RollBack_
	END IF
End IF
////////////////////////////////////////////////////
//  	신규항목 일 경우 이원화 Table 생성 
////////////////////////////////////////////////////
IF is_savestatus = '1' THEN		//'0'조회, '1'신규, '2'수정
	INSERT INTO TMSTORDERRATE  
			( AreaCode, DivisionCode, ItemCode, SupplierCode, OrderRate, LastEmp, LastDate )  
	VALUES ( :istr_partkb.areacode, :istr_partkb.divcode, :istr_partkb.itemcode, 
			  :istr_partkb.suppcode, 100, 'Y', :ldt_nowtime )  
	USING sqlpis;
	IF sqlpis.SqlCode <> 0 THEN
//		MessageBox( "이원화정보 등록실패", "이원화 정보 Table등록에 실패했습니다.", StopSign! )
		ls_message = "TMSTORDERRATE_Err"
		Goto RollBack_
	END IF
END IF

/////////////////////////////////////////////////////
//	간판 출력내용이 변경될 경우 개별간판 재발행 설정
/////////////////////////////////////////////////////
IF is_savestatus <> '1' And ib_prflag THEN	//'0'조회, '1'신규, '2'수정
	  UPDATE TPARTKBSTATUS  
		  SET RePrintFlag = 'Y',  
				LastEmp		= 'Y',
				LastDate		= :ldt_nowtime
		WHERE TPARTKBSTATUS.AreaCode 		= :istr_partkb.areacode AND  
				TPARTKBSTATUS.DivisionCode = :istr_partkb.divcode 	AND  
				TPARTKBSTATUS.SupplierCode = :istr_partkb.suppcode	AND
				TPARTKBSTATUS.ItemCode 		= :istr_partkb.itemcode
		USING	sqlpis        ;
	If sqlpis.SqlCode = -1 Then 
//		MessageBox( "간판정보수정오류", "개별 간판정보 수정에서 오류가 발생하였습니다.", StopSign! )
		ls_message = "PartKBStatus_Err2"
		goto RollBack_	//개별 간판 재출력 요구
	End If
End If

//f_pisr_sqlchkopt( sqlpis, True )
Commit Using sqlpis;
sqlpis.AutoCommit = True

ib_prflag				= False
ib_saveflag 			= False
ib_hisflag 				= False
ib_modelidchangeflag = False
If ls_message = "ModelID_Ok" Then
	MessageBox( "배번호변경", "해당 항목은 " + String( ll_twoCnt+1 ) + "개의 업체에 이원화되어 있습니다.~r~n" + &
									  "각 업체 간판기본정보의 배번호가 모두 수정됩니다. ", Information! )
End IF
MessageBox("저장완료", "간판 마스터의 내용을 저장하였습니다." , Information! )

If is_savestatus = '1'	Then
	//parent.TriggerEvent( "ue_retrieve" )
	dw_pisr010u_01.SetRedraw(False)
	dw_pisr010u_01.SetTransObject(Sqlpis)
	dw_pisr010u_01.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode )
	dw_pisr010u_01.SetRedraw(True)
	
	long ll_handle
	ll_handle = tv_partkb.FindItem(CurrentTreeItem!, 0)
	tv_partkb.uf_finditem( istr_partkb, ll_handle )
End IF

is_savestatus	='0'		//조회
This.SetItem( 1, 'inschk', 1 )
Return 1 

//dw_pisr010u_02.Modify("flag.Expression = '" + '1' + "'") 
//dw_pisr010u_02.Modify("hisflag.Expression = '" + '1' + "'") 

RollBack_:
RollBack Using sqlpis;
sqlpis.AutoCommit = True

CHOOSE CASE ls_message
	CASE "Interface_Err"
		MessageBox( "오류", "간판적용유무정보의 Interface처리에 실패했습니다.", StopSign! )
	CASE "ModelID_Err1", "ModelID_Err2", "ModelID_Err3"
		MessageBox( "배번호변경오류", "이원화 업체의 배번호변경에 실패했습니다.", StopSign! )
	CASE "PartKBStatus_Err1", "PartKBStatus_Err2"
		MessageBox( "간판정보수정오류", "개별 간판정보 수정에서 오류가 발생하였습니다.", StopSign! )
	CASE "TMSTPARTKB_Err1"
		MessageBox("저장실패", "간판마스터 등록에 실패 했습니다. " , StopSign! )
	CASE "TMSTORDERRATE_Err"
		MessageBox( "이원화정보 등록실패", "이원화 정보 Table등록에 실패했습니다.", StopSign! )
	Case Else
		MessageBox( "실패", "간판기본정보 저장에 실패했습니다.", StopSign! )
END CHOOSE

return -1

end event

event itemfocuschanged;This.SelectText(1, 30) 
end event

event itemchanged;String 	ls_colName, ls_stockgubun, ls_Mask, ls_Tag, ls_pkChgChk
String	ls_centerGubun, ls_useCenter, ls_CenterName
String	ls_Null 
String	ls_modelID, ls_lastFrom
Integer	li_pNo, I
Long 		ll_ModelidCnt
String	ls_suppno, ls_suppkorname, ls_itemname, ls_itemspec

str_pisr_partkb lstr_partkb

this.AcceptText ( )
lstr_partkb.areacode 	= this.GetItemString( row, "areacode" )
lstr_partkb.divcode 		= this.GetItemString( row, "divisioncode" )
lstr_partkb.suppcode 	= this.GetItemString( row, "suppliercode" )
lstr_partkb.itemcode 	= this.GetItemString( row, "itemcode" )
lstr_partkb.applydate 	= this.GetItemString( row, "applyfrom" )

SetNull(ls_Null)
ls_colName = This.GetcolumnName()
Choose Case ls_colName
	Case 'suppliercode', 'itemcode', 'applyfrom'
		If ls_colName = 'suppliercode' Then 
			If wf_suppliervalid_Chk(ls_colName, data) = -1 Then 
				this.SetItem( row, "suppliercode"	, ls_Null )
				This.Object.t_suppname.Text 		= ls_Null
				This.Object.t_suppno.Text 			= String('          ', '@@@-@@-@@@@@')
				Return 1
			End If
			lstr_partkb.suppCode = data
			istr_partkb.suppCode = data

		  SELECT Top 1
					A.SupplierNo,   
					A.SupplierKorName  
			 INTO :ls_suppno,   
					:ls_suppkorname  
			 FROM TMSTSUPPLIER	A,  
			 		TMSTPARTCYCLE	B
			WHERE A.SupplierCode = B.SupplierCode			AND
					B.AreaCode 		= :lstr_partkb.areacode	AND
					B.DivisionCode = :lstr_partkb.divcode	AND
					B.SupplierCode = :data	
			USING	sqlpis	;
			If sqlpis.SqlCode <> 0 Then 
				MessageBox( "확인", "업체코드가 잘못되었거나 납입주기가 등록되지 않은 업체입니다.", Information! )
				Return 1
			End If

			This.Object.t_suppname.Text 		= ls_suppkorname
			This.Object.t_suppno.Text 			= String(ls_suppno, '@@@-@@-@@@@@')
			
			dw_pisr010u_03.SetRedraw(False)
			dw_pisr010u_03.SetTransObject(Sqlpis)
			dw_pisr010u_03.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, istr_partKB.suppCode )
			dw_pisr010u_03.SetRedraw(True)

			ls_pkChgChk = 'Y' 
			
		ElseIf ls_colName = 'itemcode' then 
			If IsNull(lstr_partKB.suppCode) Then 
				MessageBox( "입력오류", "해당업체가 선택되지 않았습니다.", Information! )
				Return 1
			End If
			If f_pisr_partkbitemvalid( istr_partKB.areaCode, istr_partKB.divCode, data) Then 
				lstr_partkb.itemCode = data
				istr_partkb.itemCode = data
			  SELECT TMSTITEM.ItemName,   
						TMSTITEM.ItemSpec  
				 INTO :ls_itemname,   
						:ls_itemspec  
				 FROM TMSTITEM  
				WHERE TMSTITEM.ItemCode = :data  
				USING	sqlpis	;

				This.Object.t_itemname.Text 		= ls_itemname
				This.Object.t_itemspec.Text 		= ls_itemspec
				
				is_inputapplyfrom = wf_get_applyfrom(lstr_partkb.areaCode, lstr_partkb.divCode, lstr_partkb.suppCode, lstr_partkb.itemCode)			
				this.SetItem( row, "applyfrom"	, is_inputapplyfrom )
			Else
				this.SetItem(dw_pisr010u_02.Getrow(), 'itemcode', ls_Null)
				return 1
			End If
		  SELECT Distinct TMSTPARTKB.PartModelID  
			 INTO :ls_modelID  
			 FROM TMSTPARTKB  
			WHERE TMSTPARTKB.AreaCode 		= :istr_partkb.areacode	AND  
					TMSTPARTKB.DivisionCode = :istr_partkb.divcode  AND  
					TMSTPARTKB.ItemCode 		= :istr_partkb.itemCode    
			USING sqlpis;
			IF sqlpis.SqlCode <> 0 THEN SetNull( ls_modelID )
			this.SetItem( row, "partmodelid"	, ls_modelID )
			
			ls_pkChgChk = 'Y' 
			
		ElseIf ls_colName = 'applyfrom' Then
			is_inputapplyfrom = Left(data, 10) 
			f_pisc_get_date_convert(is_inputapplyfrom, "YYYY.MM.DD", is_inputapplyfrom) 
			
			ls_lastFrom = wf_get_applyfrom(lstr_partkb.areaCode, lstr_partkb.divCode, lstr_partkb.suppCode, lstr_partkb.itemCode)			
			IF ls_lastFrom > is_inputapplyfrom THEN 
				MessageBox( "입력오류", "적용시작일자는 현재시스템일자,최근기본정보수정일자, ~r~n " + &
								"최근발주일자들보다 이후여야 합니다." )		
				is_inputapplyfrom = ls_lastFrom				
			END IF				
			This.SetItem(row, "applyFrom", is_inputapplyfrom)
		End If 
	Case 'partmodelid' 
		  SELECT Count( TMSTPARTKB.PartModelID )  
			 INTO :ll_ModelidCnt  
			 FROM TMSTPARTKB  
			WHERE TMSTPARTKB.AreaCode 		= :istr_partkb.areacode 	AND  
					TMSTPARTKB.DivisionCode = :istr_partkb.divcode 		AND  
					TMSTPARTKB.ItemCode 		<> :lstr_partkb.itemcode	AND  
					TMSTPARTKB.PartModelID	= :data 	   
			USING sqlpis ;
		IF ll_ModelidCnt > 0 THEN 
			MessageBox( "입력오류", "이미 사용중인 배번호 입니다.", StopSign! )		
			SetNull( ls_modelID )
			this.SetItem( row, "partmodelid"	, ls_modelID )
			Return 1
		END IF			
//		ib_modelidchangeFlag = True
	Case 'stockgubun'
		ls_stockgubun = Data 
		ls_Mask = 'X-X-X' // 창고 
		If ls_stockgubun = 'L' Then ls_Mask = 'XX-X-X' //라인 
 		This.Modify("receiptlocation.EditMask.Mask='" + ls_Mask + "'") 

		This.SetItem(row, "receiptlocation", ls_Null) 
	Case 'receiptlocation'
		Data = Upper(Data)
		This.SetItem(row, "receiptlocation", Data) 
	Case 'usecentergubun'
		If data = 'I' Then	//사용처 구분 'I'사내, 'E'외주업체
		  SELECT Top 1
		  			A.BOMWorkCenter,   
					B.WorkCenterName  
			 INTO :ls_useCenter,   
					:ls_CenterName  
			 FROM TMSTBOM			A,   
					TMSTWORKCENTER B 
			WHERE A.AreaCode 				= B.AreaCode 				and  
					A.DivisionCode 		= B.DivisionCode 			and  
					A.BOMWorkCenter		= B.WorkCenter 			and  
					A.AreaCode 				= :lstr_partkb.areacode AND  
					A.DivisionCode 		= :lstr_partkb.divcode 	AND  
					A.BOMCItemNo 			= :lstr_partkb.itemcode AND  
					B.WorkCenterGubun1 	= 'K' 						AND  
					B.WorkCenterGubun2 	= 'A' 
			USING	sqlpis	;
			This.SetItem( row, "usecenter", ls_useCenter )
			This.Object.t_centername.Text = ls_CenterName
			This.SetItem(row, "costgubun", ls_Null) 
			This.Object.costgubun.Protect = 1
			This.setitem( row, "buybackflag", 'N')
			This.Object.buybackflag.Protect = 1
			This.Object.b_use.visible = 1
			This.Object.usecenter.Protect = 0
		Else
			SetNull(ls_useCenter)
			This.SetItem(row, "usecenter", ls_useCenter) 
			This.Object.t_centername.Text = ''
			This.Object.costgubun.Protect = 0
			This.Object.buybackflag.Protect = 0
			This.Object.b_use.visible = 1
			This.Object.usecenter.Protect = 0
		End If

	Case 'usecenter'
		If wf_usecentervalid_Chk(ls_colName, data) = -1 Then Return 1
		ls_centerGubun	= this.GetItemString( row, "usecentergubun" )
		IF ls_centerGubun = 'I' THEN		//사용처 사내(I)
		  SELECT TMSTWORKCENTER.WorkCenterName
			 INTO :ls_useCenter   
			 FROM TMSTWORKCENTER
			WHERE TMSTWORKCENTER.AreaCode 		= :lstr_partkb.areacode AND  
					TMSTWORKCENTER.DivisionCode 	= :lstr_partkb.divcode	AND
					TMSTWORKCENTER.WorkCenter		= :data
			USING	sqlpis 	;
		ELSE										//사용처 외주업체(E)
		  SELECT TMSTSUPPLIER.SupplierKorName  
			 INTO :ls_useCenter   
			 FROM TMSTSUPPLIER  
			WHERE TMSTSUPPLIER.SupplierCode 		= :data   
			USING	sqlpis 	;
		END IF
		this.Object.t_centername.Text = ls_useCenter
	Case 'rackcode' 
		If wf_rackvalid_Chk(ls_colName, data) = -1 Then Return 1 
End Choose 

//ls_Tag = String(dwo.TAG)
//If ls_Tag = 'A' Then 
//	ib_hisFlag = TRUE; ib_prflag = TRUE
//ElseIf ls_Tag = 'H' Then
//	ib_hisFlag = TRUE 
//End If 

If ls_pkChgChk = 'Y' Then 
	dw_temp.SetTransObject (sqlpis)
	IF dw_temp.Retrieve( lstr_partkb.areaCode, lstr_partkb.divCode, lstr_partkb.suppCode, lstr_partkb.itemCode ) = 0 THEN 
		dw_temp.insertRow(0)
		dw_temp.SetItem( 1, "UseFlag", 'Y' )
		wf_insertrow()
	  SELECT Top 1
	  			TMSTPARTKB.PartModelID  
		 INTO :ls_modelID  
		 FROM TMSTPARTKB  
		WHERE TMSTPARTKB.AreaCode 		= :lstr_partkb.areacode	AND  
				TMSTPARTKB.DivisionCode = :lstr_partkb.divcode  AND  
				TMSTPARTKB.ItemCode 		= :lstr_partkb.itemCode    
		USING sqlpis;
		IF sqlpis.SqlCode <> 0 THEN SetNull( ls_modelID )
		dw_temp.SetItem( 1, "partmodelid"	, ls_modelID )		//배번호 설정
		this.SetItem( row, "partmodelid"	, ls_modelID )		//배번호 설정
	ELSE
		this.SetRedraw(False)
		this.SetTransObject(sqlpis)
		this.Retrieve( lstr_partkb.areaCode, lstr_partkb.divCode, lstr_partkb.suppCode, lstr_partkb.itemCode ) 
		this.SetRedraw(True)
	END IF

End If 	//ls_pkChgChk = 'Y' Then 

//This.SetRedraw(True) 
//ib_saveflag = TRUE
//If ib_hisFlag Or lstr_partkb.Flag = 1 Then This.Modify("hisflag.Expression = '" + '0' + "'") 
//If ls_pkChgChk = 'Y' Or lstr_partkb.Flag = 1 Then pb_save.Enabled = True 

end event

event itemerror;SetColumn(String(dwo.Name))
Return 1
end event

event retrieveend;String ls_itemCode, ls_applyFrom 

////////////////////////////////////////////////////////////
//  		기타값 설정 
////////////////////////////////////////////////////////////
String	ls_divCode, ls_suppCode, ls_centeGubun, ls_centerCode//, ls_itemCode
String 	ls_divName, ls_suppName, ls_suppNo, ls_itemName, ls_itemSpec, ls_centerName

ls_divCode		= this.GetItemString( rowcount, 'divisioncode' )
ls_suppCode		= this.GetItemString( rowcount, 'suppliercode' )
ls_itemCode		= this.GetItemString( rowcount, 'itemcode' )
ls_centeGubun	= this.GetItemString( rowcount, 'usecentergubun' )
ls_centerCode	= this.GetItemString( rowcount, 'usecenter' )

//If ls_centeGubun = 'I' Then 
//		This.Object.costgubun.Protect = 1
//Else 
//		This.Object.costgubun.Protect = 0
//End If
  
  SELECT TMSTDIVISION.DivisionName  
    INTO :ls_divName  
    FROM TMSTDIVISION  
   WHERE TMSTDIVISION.AreaCode 		= :uo_area.is_uo_areacode  AND  
         TMSTDIVISION.DivisionCode 	= :ls_divCode 
	USING	sqlpis 	;

  SELECT TMSTSUPPLIER.SupplierNo,   
         TMSTSUPPLIER.SupplierKorName  
    INTO :ls_suppNo,   
         :ls_suppName  
    FROM TMSTSUPPLIER  
   WHERE TMSTSUPPLIER.SupplierCode 	= :ls_suppCode   
	USING	sqlpis 	;

  SELECT TMSTITEM.ItemName, 
         TMSTITEM.ItemSpec  
    INTO :ls_itemName,   
         :ls_itemSpec  
    FROM TMSTITEM
   WHERE TMSTITEM.ItemCode = :ls_itemCode  
	USING	sqlpis 	;

IF ls_centeGubun = 'I' THEN		//사용처 사내(I)
  SELECT TMSTWORKCENTER.WorkCenterName
    INTO :ls_centerName   
    FROM TMSTWORKCENTER
   WHERE TMSTWORKCENTER.AreaCode 		= :uo_area.is_uo_areacode  AND  
         TMSTWORKCENTER.DivisionCode 	= :ls_divCode 					AND
			TMSTWORKCENTER.WorkCenter		= :ls_centerCode
	USING	sqlpis 	;
ELSE										//사용처 외주업체(E)
  SELECT TMSTSUPPLIER.SupplierKorName  
    INTO :ls_centerName   
    FROM TMSTSUPPLIER  
   WHERE TMSTSUPPLIER.SupplierCode 		= :ls_centerCode   
	USING	sqlpis 	;
END IF

dw_pisr010u_02.Object.t_divname.Text 	= ls_divName
dw_pisr010u_02.Object.t_suppno.Text 	= string(ls_suppNo, "@@@-@@-@@@@@")
dw_pisr010u_02.Object.t_suppname.Text 	= ls_suppName
dw_pisr010u_02.Object.t_itemname.Text 	= f_replace_dbquatation(ls_itemName)
dw_pisr010u_02.Object.t_itemspec.Text 	= f_replace_dbquatation(ls_itemSpec)
dw_pisr010u_02.Object.t_centername.Text= ls_centerName







end event

event retrievestart;IF wf_initvalue(1) = -1 THEN RETURN

//DataWindowChild ldwc
//IF ISNull(istr_partkb.suppCode) or trim(istr_partkb.suppCode) = '' THEN istr_partkb.suppCode = '%'
//
//If This.GetChild('div_name', ldwc) <> -1 Then 
//	ldwc.SetTransObject(Sqlpis); ldwc.ReSet(); 
//	If ldwc.Retrieve( g_s_empno, istr_partkb.areacode, istr_partkb.divcode) = 0 Then ldwc.InsertRow(1) 
//End If 
//	
//If this.GetChild('supp_no', ldwc) <> -1 Then 
//	ldwc.SetTransObject(Sqlpis); ldwc.ReSet() 
//	If ldwc.Retrieve(istr_partkb.suppCode) = 0 Then ldwc.InsertRow(1)
//End If 
//
//If this.GetChild('supp_name', ldwc) <> -1 Then 
//	ldwc.SetTransObject(Sqlpis); ldwc.ReSet() 
//	If ldwc.Retrieve(istr_partkb.suppCode) = 0 Then ldwc.InsertRow(1)
//End If 
//	
//If this.GetChild('item_name', ldwc) <> -1 Then 
//	ldwc.SetTransObject(Sqlpis); ldwc.ReSet() 
//	If ldwc.Retrieve(istr_partkb.itemCode) = 0 Then ldwc.InsertRow(1)
//End If 
//
//If this.GetChild('use_supp_name', ldwc) <> -1 Then 
//	ldwc.SetTransObject(Sqlpis); ldwc.ReSet() 
//	If ldwc.Retrieve('%') = 0 Then ldwc.InsertRow(1)
//End If 
//
//If this.GetChild('use_workcenter_name', ldwc) <> -1 Then 
//	ldwc.SetTransObject(Sqlpis); ldwc.ReSet() 
//	If ldwc.Retrieve(istr_partkb.areaCode,istr_partkb.divCode) = 0 Then ldwc.InsertRow(1)
//End If 
//
//
end event

event buttonclicked;str_pisr_return lstr_Rtn
str_pisr_partkb lstr_partkb
String	ls_buttonname
String	ls_useGubun, ls_modelID
String	ls_Null
String	ls_pkChgChk = 'N'

SetNull(ls_Null)

ls_buttonname 	= dwo.name
lstr_partkb 	= istr_partkb

CHOOSE CASE ls_buttonname
	CASE 'b_supplier'
			lstr_partkb.flag = 3			//외주업체(지역,공장)
			OpenWithParm ( w_pisr012i, lstr_partkb )
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return

			If wf_suppliervalid_Chk('suppliercode', lstr_Rtn.code) = -1 Then Return 

			This.SetItem(row,'suppliercode'	, lstr_Rtn.code)
			This.Object.t_suppname.Text 		= lstr_Rtn.name
			This.Object.t_suppno.Text 			= String(lstr_Rtn.nicname, '@@@-@@-@@@@@')
//
			lstr_partkb.suppCode = lstr_Rtn.code
			istr_partkb.suppCode = lstr_Rtn.code
			ls_pkChgChk = 'Y'
//			dw_pisr010u_03.SetRedraw(False)
//			dw_pisr010u_03.SetTransObject(Sqlpis)
//			dw_pisr010u_03.Retrieve( istr_partKB.areaCode, istr_partKB.divCode, lstr_Rtn.code )
//			dw_pisr010u_03.SetRedraw(True)
//
	CASE 'b_item'
			lstr_partkb.flag = 1			//외주자재list (지역,공장)
			lstr_partkb.suppcode = This.GetItemString(row, 'suppliercode')
			If IsNull(lstr_partKB.suppCode) Then 
				MessageBox( "입력오류", "해당업체가 선택되지 않았습니다.", Information! )
				Return 
			End If
			OpenWithParm ( w_pisr013i, lstr_partkb )	//해당업체에서 취급하는 품번검색
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return
			This.SetItem(row,'itemcode'		, lstr_Rtn.code)
			This.Object.t_itemname.Text 		= lstr_Rtn.name
			This.Object.t_itemspec.Text 		= lstr_Rtn.nicname
//
			If f_pisr_partkbitemvalid( istr_partKB.areaCode, istr_partKB.divCode, lstr_Rtn.code) Then 
				lstr_partkb.itemCode = lstr_Rtn.code
				istr_partkb.itemCode = lstr_Rtn.code
				is_inputapplyfrom = wf_get_applyfrom(istr_partkb.areaCode, istr_partkb.divCode, lstr_partkb.suppCode, lstr_Rtn.code)			
				this.SetItem( row, "applyfrom"	, is_inputapplyfrom )
			Else
				this.SetItem(dw_pisr010u_02.Getrow(), 'itemcode', ls_Null)
				This.Object.t_itemname.Text 		= ls_Null
				This.Object.t_itemspec.Text 		= ls_Null
				return 
			End If

//		  SELECT Top 1
//		  			TMSTPARTKB.PartModelID  
//			 INTO :ls_modelID  
//			 FROM TMSTPARTKB  
//			WHERE TMSTPARTKB.AreaCode 		= :istr_partkb.areacode	AND  
//					TMSTPARTKB.DivisionCode = :istr_partkb.divcode  AND  
//					TMSTPARTKB.ItemCode 		= :lstr_Rtn.code    
//			USING sqlpis;
//			IF sqlpis.SqlCode <> 0 THEN SetNull( ls_modelID )
//			this.SetItem( row, "partmodelid"	, ls_modelID )

			ls_pkChgChk = 'Y'
//			
	CASE 'b_use'
			ls_useGubun = This.GetItemString(row, 'usecentergubun')
			If ls_useGubun = 'E' Then
				lstr_partkb.flag = 2		//외주업체(전체)
			Else 
				lstr_partkb.flag = 1		//생산Line
			End If				
			OpenWithParm ( w_pisr012i, lstr_partkb )
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return
			This.SetItem(row, 'usecenter'		, lstr_Rtn.code)
			This.Object.t_centername.Text 	= lstr_Rtn.name
	CASE 'b_rack'
			OpenWithParm ( w_pisr014i, lstr_partkb )
			lstr_Rtn = Message.PowerObjectParm
			IF lstr_Rtn.code = '' Then Return
			This.SetItem(row, 'rackcode'		, lstr_Rtn.code)
//?
			This.Object.rack_name.Text 		= lstr_Rtn.name
	CASE ELSE
END CHOOSE

If ls_pkChgChk = 'Y' Then 
	dw_temp.SetTransObject (sqlpis)
	IF dw_temp.Retrieve( lstr_partkb.areaCode, lstr_partkb.divCode, lstr_partkb.suppCode, lstr_partkb.itemCode ) = 0 THEN 
		dw_temp.insertRow(0)
		dw_temp.SetItem( 1, "UseFlag", 'Y' )
		wf_insertrow()
	  SELECT Top 1
	  			TMSTPARTKB.PartModelID  
		 INTO :ls_modelID  
		 FROM TMSTPARTKB  
		WHERE TMSTPARTKB.AreaCode 		= :lstr_partkb.areacode	AND  
				TMSTPARTKB.DivisionCode = :lstr_partkb.divcode  AND  
				TMSTPARTKB.ItemCode 		= :lstr_partkb.itemCode    
		USING sqlpis;
		IF sqlpis.SqlCode <> 0 THEN SetNull( ls_modelID )
		dw_temp.SetItem( 1, "partmodelid"	, ls_modelID )		//배번호 설정
		this.SetItem( row, "partmodelid"	, ls_modelID )		//배번호 설정
	ELSE
		this.SetRedraw(False)
		this.SetTransObject(sqlpis)
		this.Retrieve( lstr_partkb.areaCode, lstr_partkb.divCode, lstr_partkb.suppCode, lstr_partkb.itemCode ) 
		this.SetRedraw(True)
	END IF

End If 	//ls_pkChgChk = 'Y' Then 


end event

type cb_filter from commandbutton within w_pisr010u
integer x = 2615
integer y = 60
integer width = 567
integer height = 100
integer taborder = 170
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "중단품목보기"
end type

event clicked;if ib_applyfilter then
	cb_filter.text = '거래품목보기'
	ib_applyfilter = false
else
	cb_filter.text = '중단품목보기'
	ib_applyfilter = true
end if
tv_partkb.uf_set_inittv( istr_partkb.areacode, istr_partkb.divcode, ib_applyfilter)
end event

type gb_2 from groupbox within w_pisr010u
integer x = 1262
integer width = 1979
integer height = 188
integer taborder = 170
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

