$PBExportHeader$w_seq122u.srw
$PBExportComments$출하취소의뢰(서열보급품)
forward
global type w_seq122u from w_origin_sheet01
end type
type dw_2 from datawindow within w_seq122u
end type
type dw_3 from datawindow within w_seq122u
end type
type dw_4 from datawindow within w_seq122u
end type
type st_1 from statictext within w_seq122u
end type
type uo_1 from u_pisc_date_applydate within w_seq122u
end type
type st_2 from statictext within w_seq122u
end type
type uo_2 from u_pisc_date_applydate_1 within w_seq122u
end type
type st_3 from statictext within w_seq122u
end type
type ddlb_custcode from dropdownlistbox within w_seq122u
end type
type gb_1 from groupbox within w_seq122u
end type
end forward

global type w_seq122u from w_origin_sheet01
string title = "출하취소의뢰"
event ue_download pbm_custom01
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
st_1 st_1
uo_1 uo_1
st_2 st_2
uo_2 uo_2
st_3 st_3
ddlb_custcode ddlb_custcode
gb_1 gb_1
end type
global w_seq122u w_seq122u

type variables
String  is_col_nm, is_gubun, is_shipdate, is_shipdate1, is_custcode
Integer il_lastclickedrow, ii_tab_idx
end variables

forward prototypes
public function integer wf_inv101_search (string as_xplant, string as_div, string as_itno)
public function integer wf_insert_sle502 (string as_comltd, string as_csrno, string as_csrno1, string as_csrno2, string as_comment, string as_gubun)
public function integer wf_delete_sle502 (string as_comltd, string as_csrno, string as_csrno1, string as_csrno2)
public function boolean wf_update_tseqinv (string fs_customercode, string fs_custitemcode, string fs_date, long fl_shipqty, string fs_srno, string fs_gubun)
end prototypes

event ue_download;GraphicObject which_control

which_control = GetFocus()

f_save_to_excel(which_control)
end event

public function integer wf_inv101_search (string as_xplant, string as_div, string as_itno);/* INV101 Table에서 계정/Source을 가져온다 */
String  ls_cls, ls_srce, ls_pdcd

SELECT "CLS", "SRCE", "PDCD"
  INTO :ls_cls, :ls_srce, :ls_pdcd
  FROM "PBINV"."INV101"
 WHERE "COMLTD" = '01' AND
		 "XPLANT" = :as_xplant AND
		 "DIV"    = :as_div AND
		 "ITNO"   = :as_itno;

IF Sqlca.Sqlcode = 100  THEN
   uo_status.st_message.text = "품목재고(INV101)에 등록하십시오."      //품목재고(INV101)에 등록하십시오.
	RETURN -1
ELSEIF Sqlca.Sqlcode = 0  THEN
	dw_3.SetItem(1,"accd",ls_cls)
	dw_3.SetItem(1,"srce",ls_srce)
ELSE
   uo_status.st_message.text	= 	"정보시스템팀으로 연락바랍니다." 
END IF

RETURN 1

end function

public function integer wf_insert_sle502 (string as_comltd, string as_csrno, string as_csrno1, string as_csrno2, string as_comment, string as_gubun);IF as_gubun = '1' THEN//수정

	UPDATE PBSLE.SLE502
	SET COMMENT = :as_comment, UPDTID = :g_s_empno, UPDTDT = :g_s_date,	
		 IPADDR = :g_s_ipaddr, MACADDR = :g_s_macaddr
	WHERE COMLTD = :as_comltd AND
			CSRNO = :as_csrno AND
			CSRNO1 = :as_csrno1 AND
			CSRNO2 = :as_csrno2 ;
			 
	IF SQLCA.SQLCode <> 0 THEN
		Return 0
	ELSE
		Return 1
	END IF

ELSE//입력
	INSERT INTO PBSLE.SLE502
	VALUES(:as_comltd, :as_csrno, :as_csrno1, :as_csrno2, :as_comment, '' , :g_s_empno,
			 :g_s_date,'','', :g_s_ipaddr, :g_s_macaddr);
			 
	IF SQLCA.SQLCode <> 0 THEN
		Return 0
	ELSE
		Return 1
	END IF	
END IF


end function

public function integer wf_delete_sle502 (string as_comltd, string as_csrno, string as_csrno1, string as_csrno2);DELETE FROM PBSLE.SLE502
WHERE COMLTD = :as_comltd AND
		CSRNO = :as_csrno AND
		CSRNO1 = :as_csrno1 AND
		CSRNO2 = :as_csrno2 ;
		 
IF SQLCA.SQLCode <> 0 THEN
	Return 0
ELSE
	Return 1
END IF
end function

public function boolean wf_update_tseqinv (string fs_customercode, string fs_custitemcode, string fs_date, long fl_shipqty, string fs_srno, string fs_gubun);string ls_Areacode,ls_Divisioncode,ls_itemcode,ls_partid,ls_date
long ln_rowcount,ln_stockqty

if mid(fs_date,1,6) = mid(g_s_date,1,6) then
	ls_date 		= mid(fs_date,1,4) + '.' + mid(fs_date,5,2) + '.' + mid(fs_date,7,2) 
else
	ls_date 		= mid(g_s_date,1,4) + '.' + mid(g_s_date,5,2) + '.' + mid(g_s_date,7,2)
end if

if fs_gubun = 'A' then
	insert into tseqshipback
	  values (:fs_srno,:fs_customercode,:fs_custitemcode,:ls_date,:fl_shipqty,:g_s_empno,getdate())
	using sqlpis ;
elseif fs_gubun = 'D' then
		if mid(fs_date,1,6) = mid(g_s_date,1,6) then
			delete from tseqshipback
			where srno = :fs_srno and customercode = :fs_customercode and customeritemcode = :fs_custitemcode and tracedate = :ls_date
			using sqlpis ;
		else
			insert into tseqshipback
				values (:fs_srno,:fs_customercode,:fs_custitemcode,:ls_date,:fl_shipqty,:g_s_empno,getdate())
			using sqlpis ;
		end if
end if


select areacode,divisioncode,itemcode,partid into :ls_areacode,:ls_divisioncode,:ls_itemcode,:ls_partid from tseqmstitem
	where customeritemcode = :fs_custitemcode and 
			productgroup in ( select productgroup from tseqmstprod where seqgubun = 'B' ) 
using sqlpis ;
if sqlpis.sqlcode <> 0 then
	return false
end if
select stockqty into :ln_stockqty from tseqinv
	where 	areacode = :ls_areacode and divisioncode = :ls_divisioncode 
	and	 	itemcode = :ls_itemcode and partid = :ls_partid
using sqlpis ;
if isnull(ln_stockqty) or ( ln_stockqty + fl_shipqty ) < 0 then
	return false
else
	update	tseqinv
		set	stockqty	=	stockqty	+ :fl_shipqty
	where	areacode = :ls_areacode and divisioncode 	= 	:ls_divisioncode	
	and 	itemcode = :ls_itemcode and partid			= 	:ls_partid
	using sqlpis ;
	if sqlpis.sqlnrows <> 1 then
		return false
	end if
end if

ln_rowcount = 0
select count(*) into :ln_rowcount from tseqtrans
	where 	areacode = :ls_areacode and divisioncode = :ls_divisioncode 
	and	 	itemcode = :ls_itemcode and partid = :ls_partid and tracedate	=	:ls_date 
using sqlpis ;

if isnull(ln_rowcount) or ln_rowcount = 0 then
		insert into tseqtrans
		values	( :ls_date,:ls_areacode,:ls_divisioncode,:ls_itemcode,:ls_partid,:fl_shipqty,0,0,:g_s_empno,getdate())
		using	sqlpis ;
		if sqlpis.sqlcode <> 0 then
			return false
		end if
elseif ln_rowcount = 1 then
		update	tseqtrans
			set	inqty	=	inqty + :fl_shipqty
		where	areacode = :ls_areacode and divisioncode 	= 	:ls_divisioncode	
		and 	itemcode = :ls_itemcode and partid			= 	:ls_partid and tracedate = :ls_date
		using sqlpis ;
		if sqlpis.sqlcode <> 0 then
			return false
		end if
end if
return true
end function

on w_seq122u.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.st_1=create st_1
this.uo_1=create uo_1
this.st_2=create st_2
this.uo_2=create uo_2
this.st_3=create st_3
this.ddlb_custcode=create ddlb_custcode
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.uo_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.ddlb_custcode
this.Control[iCurrent+10]=this.gb_1
end on

on w_seq122u.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.st_2)
destroy(this.uo_2)
destroy(this.st_3)
destroy(this.ddlb_custcode)
destroy(this.gb_1)
end on

event open;call super::open;datawindowchild cdw_1

ddlb_custcode.text = "대우자동차(군산)"
is_custcode = 'L10502'
f_connection_Sqlserver('K','S')
dw_2.SetTransObject(Sqlca)
dw_3.SetTransObject(Sqlca)
dw_3.GetChild("div",cdw_1)   //공장
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve('D')
dw_3.InsertRow(0)
is_gubun = 'I'
wf_icon_onoff(true, true, true, false, false, false, false)

end event

event ue_retrieve;call super::ue_retrieve;Long    ll_row_cnt

is_gubun = 'R'
//필수항목 CHECK
dw_2.Reset()
dw_3.Reset()
dw_4.Reset()
ll_row_cnt = dw_2.Retrieve(is_custcode, '%', '%', is_shipdate, is_shipdate1)

IF ll_row_cnt > 0 THEN
  	uo_status.st_message.text = f_message('I010')     //조회되었습니다.
	wf_icon_onoff(true, true, true, true, false, false, false)
ELSE
  	uo_status.st_message.text = f_message('I020')     //조회데이타가 없습니다.
	wf_icon_onoff(true, true, false, false, false, false, false)
END IF




end event

event ue_insert;call super::ue_insert;String     ls_custcd, ls_xplant, ls_div, ls_dkdt, ls_todt
Long       ll_row

is_gubun = 'I'

dw_3.Reset()
ll_row = dw_3.InsertRow(0)
dw_3.Enabled = True
dw_4.Reset()
ll_row = dw_4.InsertRow(0)
dw_4.Enabled = True

dw_3.Setfocus()
dw_3.SetRow(ll_row)
dw_3.SetColumn("citno")
dw_3.SetItem(ll_row,"custcd", is_custcode)
dw_3.SetItem(ll_row,"scustcd",is_custcode)

wf_icon_onoff(true, true, true, false, false, false,  false)
uo_status.st_message.text = f_message('A070')     //해당정보를 입력하십시오.




end event

event ue_save;call super::ue_save;String  ls_yy, ls_mm, ls_dkdt, ls_csrno_serl, ls_xplant, ls_citno ,&
        ls_div, ls_srno, ls_srno_serl, ls_stype, ls_csrno, ls_custcd 
Integer li_rtn, li_srno, li_csrno, li_rtn2,ln_shipcancelqty
String  ls_csrno1, ls_csrno2, ls_comment, ls_type

SetPointer(HourGlass!)

CHOOSE CASE is_gubun
	CASE 'I'
		dw_3.AcceptText()
		//필수항목 Check
		IF f_mandantory_chk(dw_3) = -1 THEN RETURN           
		
		//Null Check ===> Null값은 ' ' OR 0으로 Setting
		f_null_chk(dw_3)                                    
		
		//Data 입력/수정일자 Update
		f_inptid(dw_3)
		
		//전산번호,취소발행번호  CREATE//////////////////////////////////////////////////////////////////////
		ls_xplant 			= dw_3.GetItemString(1, "xplant")
		ls_div    			= dw_3.GetItemString(1, "div")
		ls_stype  			= dw_3.GetItemString(1, "stype")
		ls_dkdt   			= dw_3.GetItemString(1, "dkdt")
		
		ls_custcd			= dw_3.GetItemString(1, "custcd")
		ls_citno				= dw_3.GetItemString(1, "citno")
		ln_shipcancelqty	= dw_3.GetItemNumber(1, "dcqty")
		ls_yy = Mid(ls_dkdt, 4, 1)
		ls_mm = Mid(ls_dkdt, 5, 2)
		
		//IF uf_srno_create(ls_xplant, ls_div, ls_yy, ls_mm, ls_srno_serl) = -1 THEN RETURN //취소발행번호
		//ls_srno  = ls_xplant + ls_div + ls_stype + ls_yy + ls_mm + ls_srno_serl
		
		SELECT VALUE(MAX(INTEGER(SUBSTR("INVOICE",7,5))),0) + 1
		  INTO :li_srno
		  FROM "PBSLE"."SLE501"
		 WHERE "COMLTD" = '01' AND
				 "DTYPE"  = 'C'  AND
				 "XPLANT" = :ls_xplant AND
				 "DIV"    = :ls_div  AND
				 SUBSTR("INVOICE",4,1)  = :ls_yy  AND
				 SUBSTR("INVOICE",5,2)  = :ls_mm  AND
				 LENGTH(RTRIM("INVOICE"))  = 11;
		ls_srno = ls_xplant + ls_div + ls_stype + ls_yy + ls_mm + String(li_srno,'00000')
		dw_3.SetItem(1,"invoice",ls_srno)
		
		//IF uf_csrno_create(ls_yy, ls_mm, ls_csrno_serl) = -1 THEN RETURN
		SELECT VALUE(MAX(INTEGER(SUBSTR("CSRNO",4,5))),0) + 1
		  INTO :li_csrno
		  FROM "PBSLE"."SLE501"
		 WHERE "COMLTD" = '01' AND
				 "DTYPE"  IN ('C','A')  AND
				 SUBSTR("CSRNO",1,1)  = :ls_yy  AND
				 SUBSTR("CSRNO",2,2)  = :ls_mm;
		ls_csrno = String(li_csrno,'00000')
		dw_3.SetItem(1, "csrno", ls_yy + ls_mm + ls_csrno)
		
		ls_custcd = dw_3.GetItemString(1,"custcd")
		dw_3.SetItem(1, "scustcd", ls_custcd )
		dw_3.AcceptText()
		li_rtn = dw_3.Update()                              //출하취소의뢰 입력
		IF li_rtn = 1 THEN
			ls_csrno   = dw_3.GetItemString(1, "csrno")
			ls_csrno1  = dw_3.GetItemString(1, "csrno1")
			ls_csrno2  = dw_3.GetItemString(1, "csrno2")
			
			dw_4.AcceptText()
			ls_comment = dw_4.GetItemString(1,'comment')
			
			ls_type = '2'
		
			IF wf_insert_sle502('01',ls_csrno, ls_csrno1, ls_csrno2, ls_comment, ls_type) = 1 THEN
				sqlpis.autocommit = false
				if wf_update_tseqinv(ls_custcd,ls_citno,ls_dkdt,ln_shipcancelqty,ls_csrno + ls_csrno1 + ls_csrno2,'A') then
					COMMIT USING SQLCA;
					COMMIT USING SQLPIS;
					uo_status.st_message.text = f_message('U010')    //저장되었습니다.
					This.TriggerEvent("ue_retrieve")	
				else
					ROLLBACK USING SQLCA;
					ROLLBACK USING SQLPIS;
					uo_status.st_message.text	= 	f_message("U020")	// [저장실패] 정보시스템팀으로 연락바랍니다. 	
				end if
			ELSE
				ROLLBACK USING SQLCA;
				uo_status.st_message.text	= 	f_message("U020")	// [저장실패] 정보시스템팀으로 연락바랍니다. 				
			END IF
		ELSE
			ROLLBACK USING SQLCA;
			uo_status.st_message.text	= 	f_message("U020")	// [저장실패] 정보시스템팀으로 연락바랍니다. 
		END IF
//	CASE 'R'
//		dw_3.AcceptText()
//		//필수항목 Check
//		IF f_mandantory_chk(dw_3) = -1 THEN RETURN           
//		
//		//Null Check ===> Null값은 ' ' OR 0으로 Setting
//		f_null_chk(dw_3)                                    
//		
//		//Data 입력/수정일자 Update
//		f_inptid(dw_3)
//		li_rtn = dw_3.Update()                              //출하취소의뢰 입력
//		
//		IF li_rtn = 1 THEN
//			ls_csrno   = dw_3.GetItemString(1, "csrno")
//			ls_csrno1  = dw_3.GetItemString(1, "csrno1")
//			ls_csrno2  = dw_3.GetItemString(1, "csrno2")
//			
//			dw_4.AcceptText()
//			ls_comment = dw_4.GetItemString(1,'comment')
//			
//			ls_type = '1'
//		
//			IF wf_insert_sle502('01',ls_csrno, ls_csrno1, ls_csrno2, ls_comment, ls_type) = 1 THEN
//				COMMIT USING SQLCA;
//				uo_status.st_message.text = f_message('U010')    //저장되었습니다.
//				This.TriggerEvent("ue_retrieve")	
//			ELSE
//				ROLLBACK USING SQLCA;
//				uo_status.st_message.text	= 	f_message("U020")	// [저장실패] 정보시스템팀으로 연락바랍니다. 				
//			END IF
//		ELSE
//			ROLLBACK USING SQLCA;
//			uo_status.st_message.text	= 	f_message("U020")	// [저장실패] 정보시스템팀으로 연락바랍니다. 
//		END IF
		
	CASE 'D'
		dw_3.AcceptText()
		//먼저 DELETE! 버퍼에 있는 값을 받아 두자 UPDATE하면 값을 가져 오지 못한다.
		ls_csrno   			= dw_3.GetItemString(1, "csrno", Delete!, true)
		ls_csrno1  			= dw_3.GetItemString(1, "csrno1", Delete!, true)
		ls_csrno2  			= dw_3.GetItemString(1, "csrno2", Delete!, true)
		ls_dkdt   			= dw_3.GetItemString(1, "dkdt", Delete!, true)
		 
		ls_custcd			= dw_3.GetItemString(1, "custcd", Delete!, true)
		ls_citno				= dw_3.GetItemString(1, "citno", Delete!, true)
		ln_shipcancelqty	= dw_3.GetItemNumber(1, "dcqty", Delete!, true) * (-1)
		li_rtn = dw_3.Update()                              //출하취소의뢰 입력
		IF li_rtn = 1 THEN
			IF wf_delete_sle502('01',ls_csrno, ls_csrno1, ls_csrno2) = 1 THEN
				sqlpis.autocommit = false
				if wf_update_tseqinv(ls_custcd,ls_citno,ls_dkdt,ln_shipcancelqty,ls_csrno + ls_csrno1 + ls_csrno2,'D') then
					COMMIT USING SQLCA;
					COMMIT USING SQLPIS;
					uo_status.st_message.text = f_message('U010')    //저장되었습니다.
					This.TriggerEvent("ue_retrieve")	
				else
					ROLLBACK USING SQLCA;
					ROLLBACK USING SQLPIS;
					uo_status.st_message.text	= 	f_message("U020")	// [저장실패] 정보시스템팀으로 연락바랍니다. 	
				end if
			ELSE
				ROLLBACK USING SQLCA;
				uo_status.st_message.text	= 	f_message("U020")	// [저장실패] 정보시스템팀으로 연락바랍니다. 				
			END IF
		ELSE
			ROLLBACK USING SQLCA;
			uo_status.st_message.text	= 	f_message("U020")	// [저장실패] 정보시스템팀으로 연락바랍니다. 
		END IF
		//SetRedraw(true)
END CHOOSE
sqlpis.autocommit = true
SetPointer(Arrow!)

end event

event ue_delete;call super::ue_delete;String ls_stcd
Long   ll_getrow

is_gubun = 'D'
ll_getrow = dw_2.GetRow()
ls_stcd = dw_2.GetItemString(ll_getrow, "sle501_stcd")

IF ls_stcd = '1' THEN
   uo_status.st_message.text = "확정된 Data는 삭제가 불가능합니다."
	RETURN
END IF

//SetRedraw(false)
dw_3.DeleteRow(0)
dw_4.DeleteRow(0)

end event

type uo_status from w_origin_sheet01`uo_status within w_seq122u
integer y = 2472
end type

type dw_2 from datawindow within w_seq122u
integer x = 9
integer y = 148
integer width = 4599
integer height = 1144
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_seq122u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;String  ls_csrno, ls_csrno1, ls_csrno2, ls_stcd

IF row < 1 THEN
   IF f_getobjectpoint_head(dw_2,is_col_nm) = 1 THEN
   	f_dw_sort(dw_2,is_col_nm)
   END IF
	dw_2.SetRedraw(True)
   RETURN
END IF

SelectRow(0, False)
SelectRow(row, True)


dw_3.Reset()
dw_4.Reset()
ls_csrno  = dw_2.GetItemString(row,"sle501_csrno")
ls_csrno1 = dw_2.GetItemString(row,"sle501_csrno1")
ls_csrno2 = dw_2.GetItemString(row,"sle501_csrno2")

dw_3.SetRedraw(False)
dw_3.Retrieve(ls_csrno,ls_csrno1, ls_csrno2)

dw_3.SetRedraw(True)

dw_4.SetRedraw(False)
dw_4.Retrieve(ls_csrno,ls_csrno1, ls_csrno2)

dw_4.SetRedraw(True)

dw_3.Enabled = false
dw_4.Enabled = false
uo_status.st_message.text = f_message('I010')     //조회되었습니다.
//ls_stcd = dw_3.GetItemString(1, "stcd")
//IF ls_stcd = '1' THEN
//   dw_3.Enabled = FALSE
//	  dw_4.Enabled = FALSE
//   uo_status.st_message.text = "확정된 Data는 수정/삭제가 불가능합니다."
//ELSE
//   dw_3.Enabled = TRUE
//	  dw_4.Enabled = TRUE
//   uo_status.st_message.text = f_message('I010')     //조회되었습니다.
//END IF	
	
//wf_icon_onoff(true, true, true, true, false, false, false)



end event

event retrieveend;string ls_citno
long i,ln_count

for i = 1 to rowcount
	ln_count = 0
	ls_citno = trim(this.GetItemString(i,"sle501_citno"))
	select isnull(count(customeritemcode),0) into :ln_count from tseqmstitem
	where customeritemcode = :ls_citno and 
			productgroup in ( select productgroup from tseqmstprod where seqgubun = 'B' ) 
	using sqlpis ;
	if ln_count = 0 then
		this.deleterow(i)
		rowcount = rowcount - 1
		i = i - 1
	end if
next

end event

type dw_3 from datawindow within w_seq122u
integer x = 9
integer y = 1308
integer width = 4599
integer height = 764
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_seq122u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;//항목 입력/수정시 Data Check 
String   ls_data,   ls_null
String   ls_colnm,  ls_custcd, ls_pdcd,  ls_citnm, ls_itno, &
         ls_citno,  ls_kitcd,  ls_xplan, ls_stype, ls_cur, &
			ls_xplant, ls_div,    ls_mkcd,  ls_taxcd, ls_cls, ls_module
Integer  li_rtn ,ln_count
Decimal  ld_price, ld_luprc, ld_dcqty, ld_luamt, ld_docst

This.AcceptText()
ls_colnm = dwo.Name

CHOOSE CASE ls_colnm
	//거래처품번 입력시 품명/KDAC품번/KIT여부/담당자/제품군을 SLE101(품목기본정보)에서 가져온다.
	CASE "citno", "stype", "custcd"
 			ls_custcd = THIS.GetItemString(row,"custcd")
         ls_citno  = THIS.GetItemString(row,"citno")
			select isnull(count(customeritemcode),0) into :ln_count from tseqmstitem
				where customeritemcode = :ls_citno and 
						productgroup in ( select productgroup from tseqmstprod where seqgubun = 'B' ) 
			using sqlpis ;
			if ln_count = 0 then
				uo_status.st_message.text = "거래처품번이 서열보급대상 품번이 아닙니다."
				RETURN	
			end if
         //거래처/거래처품번이 없으면 SKIP////////////////////////////////////////////////////
			IF (IsNull(ls_custcd) OR ls_custcd = "") OR &
			   (IsNull(ls_citno)  OR ls_citno  = "") THEN
				 RETURN
         END IF

			SELECT "CITNM", "ITNO", "XPLANT", "DIV", "KITCD",
			       "XPLAN", "PDCD", "SCTAX", "MODULE"
			  INTO :ls_citnm, :ls_itno, :ls_xplant, :ls_div, :ls_kitcd,
			       :ls_xplan, :ls_pdcd, :ls_taxcd, :ls_module
			  FROM "PBSLE"."SLE101" 
			 WHERE "COMLTD" = '01'       AND
					 "CUSTCD" = :ls_custcd AND
					 "CITNO"  = :ls_citno ;

         IF Sqlca.Sqlcode = 0 THEN
				//배분도 등록 되어야 겠지.(20041021)
				IF ls_kitcd = '' THEN
					ls_kitcd = ls_module
				END IF
 				THIS.SetItem(row,'sle101_citnm', ls_citnm)
 				THIS.SetItem(row,'itno', ls_itno)
 				THIS.SetItem(row,'xplant', ls_xplant)
 				THIS.SetItem(row,'div', ls_div)
 				THIS.SetItem(row,'kitcd', ls_kitcd)
 				THIS.SetItem(row,'xplan', ls_xplan)
 				THIS.SetItem(row,'pdcd', ls_pdcd)
 				THIS.SetItem(row,'taxcd', ls_taxcd)
				
				//계정/Source Select //////////////////////////////////////////////
				IF wf_inv101_search(ls_xplant, ls_div, ls_itno) = -1 THEN RETURN
			ELSE
            uo_status.st_message.text = "거래처품번을 확인하세요."
				RETURN		
			END IF

         ls_stype  = THIS.GetItemString(row,"stype")
         //출하유형이 없으면 SKIP////////////////////////////////////////////////////
			IF IsNull(ls_stype) OR ls_stype = "" THEN
				RETURN
			END IF
			
			li_rtn = uf_price_search(ls_custcd, ls_citno, ls_stype, ld_price, ls_cur, ls_mkcd)  //품목단가를 가져온다
			
			IF li_rtn = 1 THEN
				THIS.SetItem(row,"mkcd",ls_mkcd)
				THIS.SetItem(row,"cur",ls_cur)
				THIS.SetItem(row,"luprc",ld_price)
			END IF
	CASE "luprc", "dcqty"
         ld_dcqty = THIS.GetItemDecimal(row,"dcqty")
         ld_luprc = THIS.GetItemDecimal(row,"luprc")

         //수량/단가가 없으면 SKIP////////////////////////////////////////////////////
			IF (IsNull(ld_dcqty)  OR ld_dcqty = 0) OR &
			   (IsNull(ld_luprc)  OR ld_luprc = 0) THEN
				 RETURN
         END IF
         ld_luamt = ld_dcqty * ld_luprc
         THIS.SetItem(row,"luamt", ld_luamt)

         //입고량에도 취소수량을 입력한다////////////////////////////////////////////// 
         THIS.SetItem(row,"rcqty", ld_dcqty)

         //VAN단가,VAN금액에도 취소단가/금액을 입력한다//////////////////////////////// 
         THIS.SetItem(row,"vanprc", ld_luprc)
         THIS.SetItem(row,"vanamt", ld_luamt)
			
         //금액이 0이면 유무상구분에 무상('N')으로 입력////////////////////////////////
			IF ld_luamt = 0 THEN
	         THIS.SetItem(row,"paycd", 'N')	
			END IF

         //상품인경우(계정 = '35')는 수출용확정단가/금액에도 취소단가/금액을 입력한다//////////////// 
         ls_cls  = THIS.GetItemString(row,"accd")
         ls_itno = THIS.GetItemString(row,"itno")
         IF ls_cls = '35' THEN
				SELECT "DCOST"
				  INTO :ld_docst
				  FROM "PBPUR"."PUR103" 
				 WHERE "COMLTD" = '01'    AND
						 "VSRC"   = 'D'     AND
						 "DEPT"   = 'D'     AND
						 "VSRNO"  = 'D1765' AND
						 "ITNO"   = :ls_itno ;

				THIS.SetItem(row,"vanprc1", ld_docst)
				THIS.SetItem(row,"vanamt1", ld_docst * ld_dcqty)
			END IF
END CHOOSE

end event

type dw_4 from datawindow within w_seq122u
integer x = 14
integer y = 2200
integer width = 4590
integer height = 260
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_seq122u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(SQLCA)
This.InsertRow(0)
end event

type st_1 from statictext within w_seq122u
integer x = 27
integer y = 2116
integer width = 1966
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean underline = true
long textcolor = 134217856
long backcolor = 12632256
string text = "출하취소요청서 출력시 비고에 입력할 내용을 입력하는 란입니다."
boolean focusrectangle = false
end type

type uo_1 from u_pisc_date_applydate within w_seq122u
event destroy ( )
integer x = 46
integer y = 52
integer taborder = 100
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_date_applydate::destroy
end on

event constructor;call super::constructor;is_shipdate = mid(is_uo_date,1,4) + mid(is_uo_date,6,2) + mid(is_uo_date,9,2)  
end event
event ue_losefocus;call super::ue_losefocus;is_shipdate = is_uo_date
end event

event ue_select;is_shipdate = mid(is_uo_date,1,4) + mid(is_uo_date,6,2) + mid(is_uo_date,9,2)  
dw_2.reset()
dw_3.reset()
dw_4.reset()

end event

type st_2 from statictext within w_seq122u
integer x = 713
integer y = 56
integer width = 105
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_2 from u_pisc_date_applydate_1 within w_seq122u
event destroy ( )
integer x = 818
integer y = 52
integer taborder = 110
boolean bringtotop = true
end type

on uo_2.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;is_shipdate1 = mid(is_uo_date,1,4) + mid(is_uo_date,6,2) + mid(is_uo_date,9,2)  
dw_2.reset()
dw_3.reset()
dw_4.reset()
// dw_5.reset()
end event

event constructor;call super::constructor;is_shipdate1 = mid(is_uo_date,1,4) + mid(is_uo_date,6,2) + mid(is_uo_date,9,2)  
end event
type st_3 from statictext within w_seq122u
integer x = 1294
integer y = 60
integer width = 238
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "거래처:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_custcode from dropdownlistbox within w_seq122u
integer x = 1550
integer y = 44
integer width = 896
integer height = 324
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
boolean sorted = false
string item[] = {"대우자동차(부평)","대우자동차(군산)"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if index = 1 then
	is_custcode = 'L10500'
	f_connection_Sqlserver('B','S')
elseif index = 2 then
	is_custcode = 'L10502'
	f_connection_Sqlserver('K','S')
end if

end event

event constructor;is_custcode = 'L10502'
end event

type gb_1 from groupbox within w_seq122u
integer x = 5
integer width = 4599
integer height = 140
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

