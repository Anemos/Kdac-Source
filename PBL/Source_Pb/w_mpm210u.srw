$PBExportHeader$w_mpm210u.srw
$PBExportComments$도면설계관리
forward
global type w_mpm210u from w_ipis_sheet01
end type
type dw_mpm210u_01 from datawindow within w_mpm210u
end type
type dw_mpm210u_02 from u_vi_std_datawindow within w_mpm210u
end type
type uo_1 from u_mpms_select_orderno within w_mpm210u
end type
type dw_mpm210u_03 from datawindow within w_mpm210u
end type
type pb_1 from picturebutton within w_mpm210u
end type
type st_2 from statictext within w_mpm210u
end type
type cb_confirm from commandbutton within w_mpm210u
end type
type dw_report from datawindow within w_mpm210u
end type
type st_3 from statictext within w_mpm210u
end type
type gb_1 from groupbox within w_mpm210u
end type
end forward

global type w_mpm210u from w_ipis_sheet01
dw_mpm210u_01 dw_mpm210u_01
dw_mpm210u_02 dw_mpm210u_02
uo_1 uo_1
dw_mpm210u_03 dw_mpm210u_03
pb_1 pb_1
st_2 st_2
cb_confirm cb_confirm
dw_report dw_report
st_3 st_3
gb_1 gb_1
end type
global w_mpm210u w_mpm210u

forward prototypes
public function integer wf_delete_chk (string ag_orderno, string ag_partno)
end prototypes

public function integer wf_delete_chk (string ag_orderno, string ag_partno);//--------------------
// 공정설계 데이타의 존재유 => return -1, 존재무 => return 0
//--------------------
integer li_count

SELECT COUNT(*) INTO :li_count FROM TROUTING
WHERE ORDERNO = :ag_orderno AND PARTNO = :ag_partno
using sqlmpms;

if li_count > 0 then
	return -1
else
	return 0
end if
end function

on w_mpm210u.create
int iCurrent
call super::create
this.dw_mpm210u_01=create dw_mpm210u_01
this.dw_mpm210u_02=create dw_mpm210u_02
this.uo_1=create uo_1
this.dw_mpm210u_03=create dw_mpm210u_03
this.pb_1=create pb_1
this.st_2=create st_2
this.cb_confirm=create cb_confirm
this.dw_report=create dw_report
this.st_3=create st_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm210u_01
this.Control[iCurrent+2]=this.dw_mpm210u_02
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.dw_mpm210u_03
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cb_confirm
this.Control[iCurrent+8]=this.dw_report
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.gb_1
end on

on w_mpm210u.destroy
call super::destroy
destroy(this.dw_mpm210u_01)
destroy(this.dw_mpm210u_02)
destroy(this.uo_1)
destroy(this.dw_mpm210u_03)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.cb_confirm)
destroy(this.dw_report)
destroy(this.st_3)
destroy(this.gb_1)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm210u_01.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm210u_01.Height= ( newheight * 1 / 5 ) - ls_split

dw_mpm210u_02.x = dw_mpm210u_01.x
dw_mpm210u_02.y = dw_mpm210u_01.y + dw_mpm210u_01.Height + ls_split
dw_mpm210u_02.Width = dw_mpm210u_01.Width
dw_mpm210u_02.Height = ( newheight * 3 / 5 ) - dw_mpm210u_01.Height

dw_mpm210u_03.x = dw_mpm210u_02.x
dw_mpm210u_03.y = dw_mpm210u_02.y + dw_mpm210u_02.Height + ls_split
dw_mpm210u_03.Width = dw_mpm210u_02.Width
dw_mpm210u_03.Height = newheight - (dw_mpm210u_02.y + dw_mpm210u_02.Height + ls_split + ls_status)
end event

event ue_postopen;call super::ue_postopen;
dw_mpm210u_01.settransobject(sqlmpms)
dw_mpm210u_02.settransobject(sqlmpms)
dw_mpm210u_03.settransobject(sqlmpms)
dw_report.settransobject(sqlmpms)

dw_mpm210u_01.insertrow(0)

end event

event ue_insert;call super::ue_insert;string ls_orderno, ls_outflag
integer li_totcnt

ls_orderno = uo_1.is_uo_orderno
if f_spacechk(ls_orderno) = -1 or ls_orderno = '%' then
	uo_status.st_message.text = "금형의뢰번호를 선택바랍니다."
	return -1
end if

ls_outflag = dw_mpm210u_01.getitemstring(1,"outflag")

dw_mpm210u_03.reset()
dw_mpm210u_03.insertrow(0)
dw_mpm210u_03.setitem( 1, "orderno", ls_orderno )
if ls_outflag = 'P' then
	dw_mpm210u_03.Modify("outflag.background.color='12632256'")
	dw_mpm210u_03.object.outflag.background.color
	dw_mpm210u_03.object.outflag.protect = 1
	dw_mpm210u_03.setitem( 1, "outflag", 'P' )
else
	dw_mpm210u_03.Modify("outflag.background.color='15780518'")
	dw_mpm210u_03.object.outflag.protect = 0
	dw_mpm210u_03.setitem( 1, "outflag", 'N' )
end if

select Max(DetailNo) into :li_totcnt from tpartlist
where orderno = :ls_orderno
using sqlmpms;
dw_mpm210u_03.setitem( 1, "detailno", li_totcnt + 1 )

select count(*) into :li_totcnt from tpartlist
where orderno = :ls_orderno
using sqlmpms;
dw_mpm210u_03.setitem( 1, "serialno", li_totcnt + 1 )

dw_mpm210u_03.setitem( 1, "revno", '00' )
dw_mpm210u_03.setitem( 1, "outstatus", 'A' )
dw_mpm210u_03.setitem( 1, "outmaterialflag", 'Y' )
dw_mpm210u_03.object.detailno.protect = 0
dw_mpm210u_03.object.sheetno.protect = 0
dw_mpm210u_03.setcolumn("sheetno")
dw_mpm210u_03.setfocus()
end event

event ue_retrieve;call super::ue_retrieve;string ls_status

//ls_status = f_mpms_get_orderstatus(uo_1.is_uo_orderno)
//if ls_status < '2' then
//	uo_status.st_message.text = '해당금형은 의뢰접수상태입니다.'
//	return 0
//else
//	if ls_status = 'C' then
//		// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
//		wf_icon_onoff(true,  false,  false,  false,  i_b_print, & 
//					  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
//	end if
//end if
dw_mpm210u_01.reset()
dw_mpm210u_02.reset()
dw_mpm210u_03.reset()
dw_mpm210u_01.retrieve(uo_1.is_uo_orderno)
dw_mpm210u_02.retrieve(uo_1.is_uo_orderno)
end event

event ue_save;call super::ue_save;string ls_chkrevno, ls_chkorderno, ls_message, ls_outflag, ls_outmaterialflag
string ls_partno, ls_orderno, ls_revno, ls_partname, ls_spec, ls_material, ls_remark
integer li_detailno, li_chkno, li_sheetno, li_selrow, li_serialno, li_count, li_error_code
integer li_position, li_midpos
string ls_spec2, ls_spec4, ls_sizeflag
dec{0}  lc_qty1, lc_qty2
dec{3}  lc_weight, lc_weight2, lc_spec1, lc_spec3, lc_spec5
dec{2}  lc_partcost, lc_gravity, lc_unitprice

ls_message = " "
dw_mpm210u_03.Accepttext()

if dw_mpm210u_03.modifiedcount() < 1 or dw_mpm210u_03.rowcount() = 0 then
	uo_status.st_message.text = "변경된 데이타가 없습니다."
	return 0
end if

if f_mpms_mandantory_chk(dw_mpm210u_03) = -1 then
	uo_status.st_message.text = "필수 입력사항이 누락되었습니다."
	return 0
end if

li_selrow = dw_mpm210u_02.getselectedrow(0)
//데이타 가져오기
ls_partno   = dw_mpm210u_03.getitemstring( 1, 'partno')
ls_revno   	= dw_mpm210u_03.getitemstring( 1, 'revno')
ls_orderno  = dw_mpm210u_03.getitemstring( 1, 'orderno')
ls_partname = dw_mpm210u_03.getitemstring( 1, 'partname')
ls_spec   	= Trim(dw_mpm210u_03.getitemstring( 1, 'spec'))
ls_material = Trim(dw_mpm210u_03.getitemstring( 1, 'material'))
ls_remark  	= dw_mpm210u_03.getitemstring( 1, 'remark')
li_detailno = dw_mpm210u_03.getitemnumber( 1, 'detailno')
li_sheetno  = dw_mpm210u_03.getitemnumber( 1, 'sheetno')
li_serialno = dw_mpm210u_03.getitemnumber( 1, 'serialno')
lc_qty1     = dw_mpm210u_03.getitemnumber( 1, 'qty1')
lc_qty2     = dw_mpm210u_03.getitemnumber( 1, 'qty2')
lc_weight   = dw_mpm210u_03.getitemnumber( 1, 'weight')
lc_weight2	= dw_mpm210u_03.getitemnumber( 1, 'weight2')
lc_partcost = dw_mpm210u_03.getitemnumber( 1, 'partcost')
ls_outflag  = dw_mpm210u_03.getitemstring( 1, 'outflag')
ls_outmaterialflag = dw_mpm210u_03.getitemstring( 1, 'outmaterialflag')

// 규격 및 사이즈 계산, Weight(열처리), Weight2(소재)
li_position = POS(ls_spec,"X")
if li_position = 0 then
	dw_mpm210u_03.setitem(1,'weight',0)
	dw_mpm210u_03.setitem(1,'weight2',0)
	dw_mpm210u_03.setitem(1,'partcost',0)
end if
		
// 소재에 대한 비중값 가져오기
SELECT Gravity, UnitPrice, SizeFlag INTO :lc_gravity, :lc_unitprice, :ls_sizeflag
FROM TMATERIALPRICE
WHERE Material = :ls_material
using sqlmpms;
if sqlmpms.sqlcode <> 0 then
	dw_mpm210u_03.setitem(1,'weight',0)
	dw_mpm210u_03.setitem(1,'weight2',0)
	dw_mpm210u_03.setitem(1,'partcost',0)
	if MessageBox("확인", "소재가격표에 존재하지 않습니다. 저장하시겠습니까?", &
			Exclamation!, OKCancel!, 1) = 2 then
		return 1
	end if
else
	lc_spec1 = Dec(Mid(ls_spec,1,li_position - 1))
	ls_spec2 = 'X'
	li_midpos = li_position + 1
	li_position = POS(ls_spec,"X",li_midpos)
	if li_position = 0 then
		// 봉재인 경우
		lc_spec3 = Dec(Mid(ls_spec,li_midpos))
		lc_weight = Round((Pi((lc_spec1^2) / 4) * lc_spec3 * lc_gravity) / (10^6),3)
		if ls_sizeflag = 'Y' then
			lc_weight2 = lc_weight
		else
			lc_weight2 = Round((Pi(((lc_spec1 + 5)^2) / 4) * (lc_spec3 + 5) * lc_gravity) / (10^6),3)
		end if
	else
		// 각재인 경우
		lc_spec3 = Dec(Mid(ls_spec,li_midpos,li_position - li_midpos))
		ls_spec4 = 'X'
		lc_spec5 = Dec(Mid(ls_spec,li_position + 1))
		lc_weight = Round((lc_spec1 * lc_spec3 * lc_spec5 * lc_gravity) / (10^6),3)
		if ls_sizeflag = 'Y' then
			lc_weight2 = lc_weight
		else
			lc_weight2 = Round(((lc_spec1 + 5) * (lc_spec3 + 5) * (lc_spec5 + 5) * lc_gravity) / (10^6),3)
		end if
	end if
	// 예상단가 계산 
	lc_partcost		= lc_weight2 * lc_unitprice
	dw_mpm210u_03.setitem(1,'weight',lc_weight)
	dw_mpm210u_03.setitem(1,'weight2',lc_weight2)
	dw_mpm210u_03.setitem(1,'partcost',lc_partcost)
end if
// 금액계산 END

SELECT isnull(SERIALNO,0) INTO :li_chkno
FROM TPARTLIST
WHERE ORDERNO = :ls_orderno AND DETAILNO = :li_detailno
using sqlmpms;
if li_chkno <> li_serialno then
	SELECT COUNT(*) INTO :li_count
	FROM TPARTLIST
	WHERE ORDERNO = :ls_orderno AND SERIALNO = :li_serialno
	using sqlmpms;
	
	if li_count > 0 then
		uo_status.st_message.text = " 이미 존재하는 Serial No가 있습니다."
		return 0
	end if
end if

sqlmpms.Autocommit = False

if dw_mpm210u_03.update() = 1 then
	if li_selrow < 1 then
		INSERT INTO TPARTLISTHIST  
		 ( DetailNo, OrderNo, RevNo, RevEmp, RevDate, PartName, PartNo, SheetNo,   
			Spec, Material, Qty1, Qty2, Weight, Weight2, PartCost, Remark, SerialNo, 
			OutFlag, OutMaterialFlag, LastEmp, LastDate )  
		VALUES ( :li_detailno, :ls_orderno, :ls_revno, :g_s_empno, :g_s_date,   
				  :ls_partname, :ls_partno, :li_sheetno, :ls_spec, :ls_material,   
				  :lc_qty1, :lc_qty2, :lc_weight, :lc_weight2, :lc_partcost, :ls_remark, :li_serialno,  
				  :ls_outflag, :ls_outmaterialflag, :g_s_empno, getdate() )  
		using sqlmpms;
		if sqlmpms.sqlcode <> 0 then
			ls_message = "parthist_new"
			goto RollBack_
		end if
	else
		ls_chkrevno = dw_mpm210u_02.getitemstring(li_selrow,'revno')
		ls_chkorderno = dw_mpm210u_02.getitemstring(li_selrow,'orderno')
		li_chkno = dw_mpm210u_02.getitemnumber(li_selrow,'detailno')
		if ls_revno <> ls_chkrevno then		
			INSERT INTO TPARTLISTHIST  
			 ( DetailNo, OrderNo, RevNo, RevEmp, RevDate, PartName, PartNo, SheetNo,   
				Spec, Material, Qty1, Qty2, Weight, Weight2, PartCost, Remark, SerialNo, 
				OutFlag, OutMaterialFlag, LastEmp, LastDate )  
			VALUES ( :li_detailno, :ls_orderno, :ls_revno, :g_s_empno, :g_s_date,   
					  :ls_partname, :ls_partno, :li_sheetno, :ls_spec, :ls_material,   
					  :lc_qty1, :lc_qty2, :lc_weight, :lc_weight2, :lc_partcost, :ls_remark, :li_serialno,  
					  :ls_outflag, :ls_outmaterialflag, :g_s_empno, getdate() )  
			using sqlmpms;
			if sqlmpms.sqlcode <> 0 then
				ls_message = "parthist_insert"
				goto RollBack_
			end if
		else
			DELETE FROM TPARTLISTHIST
			WHERE ORDERNO = :ls_chkorderno AND DETAILNO = :li_chkno AND
					REVNO = :ls_chkrevno
			using sqlmpms;
			
			if sqlmpms.sqlcode <> 0 then
				ls_message = "parthist_delete"
				goto RollBack_
			end if
			
			INSERT INTO TPARTLISTHIST  
			 ( DetailNo, OrderNo, RevNo, RevEmp, RevDate, PartName, PartNo, SheetNo,   
				Spec, Material, Qty1, Qty2, Weight, Weight2, PartCost, Remark, SerialNo, 
				OutFlag, OutMaterialFlag, LastEmp, LastDate )  
			VALUES ( :li_detailno, :ls_orderno, :ls_revno, :g_s_empno, :g_s_date,   
					  :ls_partname, :ls_partno, :li_sheetno, :ls_spec, :ls_material,   
					  :lc_qty1, :lc_qty2, :lc_weight, :lc_weight2, :lc_partcost, :ls_remark, :li_serialno,  
					  :ls_outflag, :ls_outmaterialflag, :g_s_empno, getdate() )  
			using sqlmpms;
			if sqlmpms.sqlcode <> 0 then
				ls_message = "parthist_insert"
				goto RollBack_
			end if
		end if
		
		// 외주가공인자가 수정된 경우 외주가공데이타 재생성
		if ls_spec <> dw_mpm210u_02.getitemstring(li_selrow,"spec") or &
			ls_material <> dw_mpm210u_02.getitemstring(li_selrow,"material") or &
			lc_qty1 <> dw_mpm210u_02.getitemnumber(li_selrow,"qty1") or &
			lc_qty2 <> dw_mpm210u_02.getitemnumber(li_selrow,"qty2") or &
			ls_outmaterialflag <> dw_mpm210u_02.getitemstring(li_selrow,"outmaterialflag") then
			
			DECLARE actual_recording procedure for sp_mpm220u_05
				@ps_orderno  	= :ls_orderno,
				@ps_partno 		= :ls_partno,
				@ps_empno 		= :g_s_empno,
				@pi_err_code		= :li_error_code	output
			USING	SQLMPMS ;
		
			EXECUTE actual_recording ;
		
			FETCH actual_recording
				INTO :li_error_code ;
			CLOSE	actual_recording ;
		
			if li_error_code <> 0 then
				ls_message = "toutprocess"
				goto RollBack_
			end if
		end if
	end if
else
	ls_message = "partlist_new"
	goto RollBack_
end if

Commit using sqlmpms;
sqlmpms.AutoCommit = True

This.Triggerevent("ue_retrieve")
li_selrow = dw_mpm210u_02.find("partno = '" + ls_partno + "'", 1, dw_mpm210u_02.rowcount())
if li_selrow > 0 then
	dw_mpm210u_02.Post Event RowFocusChanged(li_selrow)
	dw_mpm210u_02.scrolltorow(li_selrow)
	dw_mpm210u_02.setrow(li_selrow)
end if

uo_status.st_message.text = "저장되었습니다."
return 0

RollBack_:
Rollback using sqlmpms;
sqlmpms.AutoCommit = True

choose case ls_message
	case 'partlist_new'
		Messagebox("경고","품목리스트에서 에러가 발생하였습니다.")
	case 'parthist_new'
		Messagebox("경고","품목이력에서 에러가 발생하였습니다.")
	case 'parthist_delete'
		Messagebox("경고","품목이력에서 에러가 발생하였습니다.")
	case 'parthist_insert'
		Messagebox("경고","품목이력에서 에러가 발생하였습니다.")
	case 'toutprocess'
		Messagebox("경고","외주가공재료비 재계산시에 에러가 발생하였습니다.")
end choose

return 0
end event

event ue_delete;call super::ue_delete;string ls_revno, ls_partno, ls_orderno, ls_message, ls_chkrevno
integer li_selrow, li_rtn

li_selrow = dw_mpm210u_02.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = "삭제할 데이타를 선택하십시요."
	return 0
end if

ls_orderno = dw_mpm210u_02.getitemstring( li_selrow, 'orderno')
ls_partno = dw_mpm210u_02.getitemstring( li_selrow, 'partno')
ls_revno = dw_mpm210u_02.getitemstring( li_selrow, 'revno')

if wf_delete_chk( ls_orderno, ls_partno ) = -1 then
	uo_status.st_message.text = "공정설계가 이루어진 품목입니다."
	return 0
end if

if ls_revno > '00' then
	//품목이력 존재
	li_rtn = MessageBox("경고", ls_orderno + " : " + ls_partno + " 변경이력이 존재합니다. ~r" &
					+ "이전버전으로 변경하시겠습니까?" , Exclamation!, OKCancel!, 2)
	if li_rtn = 2 then
		return 0
	end if
	ls_chkrevno = String( integer(ls_revno) -1, "00" )
	sqlmpms.AutoCommit = False
	
	DELETE FROM TPARTLISTHIST
	WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
			REVNO = :ls_revno
	using sqlmpms;
	
	if sqlmpms.sqlcode <> 0 then
		ls_message = "parthist_delete"
		goto RollBack_
	end if
	
	DELETE FROM TPARTLIST
	WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno
	using sqlmpms;
	
	if sqlmpms.sqlcode <> 0 then
		ls_message = "partlist_delete"
		goto RollBack_
	end if
	
	INSERT INTO TPARTLIST  
   ( DetailNo, OrderNo, RevNo, PartName, PartNo, SheetNo, Spec, Material,   
     Qty1, Qty2, Weight, PartCost, Remark, LastEmp, LastDate )  
  	SELECT A.DETAILNO, A.ORDERNO, A.REVNO, A.PARTNAME, A.PARTNO,   
     A.SHEETNO, A.SPEC, A.MATERIAL, A.QTY1, A.QTY2, A.WEIGHT, A.PARTCOST,   
     A.REMARK, :g_s_empno, getdate()
	FROM TPARTLISTHIST A
	WHERE A.ORDERNO = :ls_orderno AND A.PARTNO = :ls_partno AND
			A.REVNO = :ls_chkrevno
	using sqlmpms;
	
	if sqlmpms.sqlcode <> 0 then
		ls_message = "partlist_insert"
		goto RollBack_
	end if

else
	//품목이력 미존재
	li_rtn = MessageBox("경고", "해당품목정보를 삭제하시겠습니까?" &
					, Exclamation!, OKCancel!, 2)
	if li_rtn = 2 then
		return 0
	end if
	
	sqlmpms.AutoCommit = False
	
	DELETE FROM TPARTLISTHIST
	WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno AND
			REVNO = :ls_revno
	using sqlmpms;
	
	if sqlmpms.sqlcode <> 0 then
		ls_message = "parthist_delete"
		goto RollBack_
	end if
	
	DELETE FROM TPARTLIST
	WHERE ORDERNO = :ls_orderno AND PARTNO = :ls_partno
	using sqlmpms;
	
	if sqlmpms.sqlcode <> 0 then
		ls_message = "partlist_delete"
		goto RollBack_
	end if
end if

Commit using sqlmpms;
sqlmpms.AutoCommit = True

This.Triggerevent("ue_retrieve")
li_selrow = dw_mpm210u_02.find("partno = '" + ls_partno + "'", 1, dw_mpm210u_02.rowcount())
if li_selrow > 0 then
	dw_mpm210u_02.Post Event RowFocusChanged(li_selrow)
	dw_mpm210u_02.scrolltorow(li_selrow)
	dw_mpm210u_02.setrow(li_selrow)
end if

uo_status.st_message.text = "정상적으로 처리되었습니다."
return 0

RollBack_:
RollBack using sqlmpms;
sqlmpms.AutoCommit = True

choose case ls_message
	case 'partlist_delete'
		Messagebox("경고", "품목리스트 삭제시에 에러가 발생하였습니다.")
	case 'parthist_delete'
		Messagebox("경고", "품목이력 삭제시에 에러가 발생하였습니다.")
	case 'partlist_insert'
		Messagebox("경고", "품목리스트 입력시에 에러가 발생하였습니다.")
end choose

return 0
end event

event ue_print;call super::ue_print;integer li_rowcnt
string  mod_string, ls_orderno

window 	l_to_open
str_easy l_str_prt

ls_orderno = uo_1.is_uo_orderno
if f_spacechk(ls_orderno) = -1 then
	uo_status.st_message.text = "금형의뢰번호를 선택해 주십시요."
	return 0
end if
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

dw_report.reset()
dw_report.retrieve(uo_1.is_uo_orderno)

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax     = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0

end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= True
i_b_save 		= True
i_b_delete 		= True
i_b_print 		= True
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm210u
end type

type dw_mpm210u_01 from datawindow within w_mpm210u
integer x = 18
integer y = 196
integer width = 3077
integer height = 312
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpms_comm_order"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_mpm210u_02 from u_vi_std_datawindow within w_mpm210u
integer x = 18
integer y = 564
integer width = 3081
integer height = 752
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_mpm210u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_orderno, ls_partno, ls_outflag
Integer li_detailno

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )

ls_orderno = This.getitemstring(currentrow,"orderno")
li_detailno = This.getitemnumber(currentrow,"detailno")
ls_partno = This.getitemstring(currentrow,"partno")
ls_outflag = dw_mpm210u_01.getitemstring(1,"outflag")

dw_mpm210u_03.retrieve(li_detailno, ls_orderno)
if wf_delete_chk(ls_orderno, ls_partno) = -1 then
	dw_mpm210u_03.object.sheetno.protect = 1
	dw_mpm210u_03.object.detailno.protect = 1
	if ls_outflag = 'P' then
		dw_mpm210u_03.Modify("outflag.background.color='12632256'")
		dw_mpm210u_03.object.outflag.protect = 1
	else
		dw_mpm210u_03.Modify("outflag.background.color='15780518'")
		dw_mpm210u_03.object.outflag.protect = 0
	end if
	dw_mpm210u_03.setcolumn("partname")
	dw_mpm210u_03.setfocus()
else
	dw_mpm210u_03.object.detailno.protect = 1
	dw_mpm210u_03.object.sheetno.protect = 0
	if ls_outflag = 'P' then
		dw_mpm210u_03.Modify("outflag.background.color='12632256'")
		dw_mpm210u_03.object.outflag.protect = 1
	else
		dw_mpm210u_03.Modify("outflag.background.color='15780518'")
		dw_mpm210u_03.object.outflag.protect = 0
	end if
	dw_mpm210u_03.setcolumn("sheetno")
	dw_mpm210u_03.setfocus()
end if
end event

event rbuttondown;call super::rbuttondown;////////////////////////////////////////////////////////
// 오른쪽 마우스버튼을 눌렀을 때 POPUP MENU를 띄운다.
////////////////////////////////////////////////////////

m_pop_mpms NewMenu
string ls_name, ls_data, ls_type, ls_col_type
str_mpms_parm lstr_1

ls_type = dwo.type
If ls_type = 'column' Then
	ls_name = dwo.name
	ls_col_type = this.Describe(ls_name+".ColType")
	If pos(ls_col_type,'char',1) > 0 Then
		ls_data = dwo.Primary[row]
	Else
		ls_data = ''
	End if
End if

If row > 0 Then
	this.SelectRow(0,False)
	this.SelectRow(row, True)
	this.setfocus()
Else
	return 0
End if

lstr_1.dw_parm[1] = dw_mpm210u_03
Message.PowerObjectParm = lstr_1

NewMenu = CREATE m_pop_mpms
//NewMenu.mf_get_dw(this, row, ls_name, ls_data)
//Popup Menu 조정

NewMenu.m_action.m_copy.enabled = False
NewMenu.m_action.m_matadd.enabled = False
NewMenu.m_action.m_subadd.enabled = False
NewMenu.m_action.m_modify.enabled = True
NewMenu.m_action.m_wccode.enabled = False
NewMenu.m_action.m_workstatus.enabled = False
NewMenu.m_action.m_outcal.enabled = False

NewMenu.m_action.PopMenu(w_frame.PointerX(), w_frame.PointerY())

destroy NewMenu
end event

type uo_1 from u_mpms_select_orderno within w_mpm210u
integer x = 41
integer y = 48
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call u_mpms_select_orderno::destroy
end on

event ue_select;call super::ue_select;
iw_this.Triggerevent('ue_retrieve')


end event

type dw_mpm210u_03 from datawindow within w_mpm210u
integer x = 18
integer y = 1340
integer width = 3081
integer height = 400
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm210u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;String 	ls_colName, ls_null, ls_partno, ls_orderno
integer  li_detailno, li_sheetno, li_serialno, li_count, li_chkno, li_position

this.AcceptText ( )

SetNull(ls_Null)

ls_colName = dwo.name
Choose Case ls_colName
	Case 'detailno', 'sheetno'
		li_detailno = This.getitemnumber(row, 'detailno')
		li_sheetno = This.getitemnumber(row, 'sheetno')
		
		ls_partno = String(li_detailno,"000") + String(li_sheetno,"000")
		This.Setitem( row, 'partno', ls_partno)
		return 0
	Case 'serialno'
		li_serialno = This.getitemnumber( row, 'serialno')
		li_detailno = This.getitemnumber(row, 'detailno')
		ls_orderno  = This.getitemstring( row, 'orderno')
		
		SELECT isnull(SERIALNO,0) INTO :li_chkno
		FROM TPARTLIST
		WHERE ORDERNO = :ls_orderno AND DETAILNO = :li_detailno
		using sqlmpms;
		if li_chkno <> li_serialno then
			SELECT COUNT(*) INTO :li_count
			FROM TPARTLIST
			WHERE ORDERNO = :ls_orderno AND SERIALNO = :li_serialno
			using sqlmpms;
			
			if li_count > 0 then
				MessageBox("알림"," 이미 존재하는 Serial No가 있습니다.")
				return 1
			end if
		end if
	Case 'spec'
		li_position = POS(Trim(data),"*")
		if li_position > 0 then
			This.Setitem( row, 'spec', '')
			uo_status.st_message.text = "Spec은 1.000X1.000X1.0000 으로 입력되어야 합니다."
			return 1
		end if
End Choose
end event

type pb_1 from picturebutton within w_mpm210u
integer x = 2597
integer y = 88
integer width = 283
integer height = 108
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
vtextalign vtextalign = vcenter!
end type

event clicked;string ls_parm, ls_status
integer li_count

uo_status.st_message.text = ""
ls_parm = uo_1.is_uo_orderno

if f_spacechk(ls_parm) = -1 then
	uo_status.st_message.text = "금형의뢰번호를 선택하십시요"
	return -1
end if

ls_status = f_mpms_get_orderstatus(uo_1.is_uo_orderno)
if ls_status < '2' or ls_status = 'C' then
	choose case ls_status
		case '1'
			uo_status.st_message.text = '의뢰접수 상태입니다.'
		case 'C'
			uo_status.st_message.text = '제작완료된 금형입니다.'
		case else
			uo_status.st_message.text = '해당작업을 수행할 수 없습니다.'
	end choose
	return 0
end if

//** 주석처리 : 공정설계중이더라도 품목추가시에도 가능하도록 변경 (2010.11.18)
//SELECT COUNT(*) INTO :li_count FROM TROUTING
//WHERE ORDERNO = :ls_parm
//using sqlmpms;
//
//if li_count > 0 then
//	uo_status.st_message.text = "금형의뢰번호에 대한 공정설계가 진행중이므로 " &
//		+ " PartList Upload는 할 수 없습니다."
//	return -1
//end if

openwithparm(w_mpm210u_01, ls_parm)

iw_this.Triggerevent('ue_retrieve')
return 0
end event

type st_2 from statictext within w_mpm210u
integer x = 1979
integer y = 92
integer width = 603
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "PartList Upload :"
boolean focusrectangle = false
end type

type cb_confirm from commandbutton within w_mpm210u
integer x = 1330
integer y = 52
integer width = 489
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "공정설계요청"
end type

event clicked;integer li_selrow
string ls_orderno, ls_status

li_selrow = dw_mpm210u_01.rowcount()
if li_selrow < 1 then
	uo_status.st_message.text = "선택된 데이타가 없습니다."
	return 0
end if

ls_orderno = dw_mpm210u_01.getitemstring(1,'orderno')

ls_status = f_mpms_get_orderstatus(ls_orderno)
if ls_status = '2' then
	if f_mpms_set_orderstatus(ls_orderno, '3') = 0 then
		iw_this.Triggerevent("ue_retrieve")
		uo_status.st_message.text = "정상적으로 처리되었습니다."
		return 0
	else
		uo_status.st_message.text = "처리중에 에러가 발생하였습니다."
	end if
else
	uo_status.st_message.text = "처리를 할 수 없는 상태입니다."
end if

return 0
end event

type dw_report from datawindow within w_mpm210u
boolean visible = false
integer x = 3136
integer y = 24
integer width = 251
integer height = 352
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm210u_04"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_mpm210u
integer x = 1966
integer y = 24
integer width = 1070
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 15793151
string text = "설계변경 => 오른쪽마우스버튼 사용"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_mpm210u
integer x = 27
integer width = 1879
integer height = 176
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

