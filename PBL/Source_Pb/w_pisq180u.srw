$PBExportHeader$w_pisq180u.srw
$PBExportComments$�����ҷ����
forward
global type w_pisq180u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq180u
end type
type uo_division from u_pisc_select_division within w_pisq180u
end type
type dw_pisq180u_01 from u_vi_std_datawindow within w_pisq180u
end type
type dw_pisq180u_02 from u_vi_std_datawindow within w_pisq180u
end type
type dw_pisq180u_03 from u_vi_std_datawindow within w_pisq180u
end type
type gb_2 from groupbox within w_pisq180u
end type
type gb_3 from groupbox within w_pisq180u
end type
type gb_1 from groupbox within w_pisq180u
end type
type dw_pisq180u_04 from u_vi_std_datawindow within w_pisq180u
end type
type cb_allins from commandbutton within w_pisq180u
end type
type cb_regtotal from commandbutton within w_pisq180u
end type
end forward

global type w_pisq180u from w_ipis_sheet01
integer width = 4709
integer height = 2700
string title = "�����ҷ� ���"
uo_area uo_area
uo_division uo_division
dw_pisq180u_01 dw_pisq180u_01
dw_pisq180u_02 dw_pisq180u_02
dw_pisq180u_03 dw_pisq180u_03
gb_2 gb_2
gb_3 gb_3
gb_1 gb_1
dw_pisq180u_04 dw_pisq180u_04
cb_allins cb_allins
cb_regtotal cb_regtotal
end type
global w_pisq180u w_pisq180u

type variables

String	is_AreaCode, is_DivisionCode
datawindowchild	idwc_largegroup, idwc_middlegroup, idwc_smallgroup
datawindowchild	idwc_badreason, idwc_badtype

end variables

forward prototypes
public function boolean wf_getprocesscost ()
public subroutine wf_detail_temp_insert ()
public function boolean wf_checkcolumn ()
public subroutine wf_detail_temp_delete ()
end prototypes

public function boolean wf_getprocesscost ();
String	ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_processcode
Long		ll_processcost = 0

IF dw_pisq180u_01.AcceptText() <> 1 THEN RETURN FALSE

// ����Ʈ ������ �ڷḦ ���Ѵ�
//
ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_01.GetItemString(1, 'smallgroupcode')
ls_processcode		= dw_pisq180u_02.GetItemString(dw_pisq180u_02.GetSelectedRow(0), 'processcode')

// ��������� ���Ѵ�(��ǰ�Һз��� ���������� ��������)
//
SELECT A.PROCESSCOST  
  INTO :ll_processcost  
  FROM TQSMALLGROUPTOPROCESS  A
 WHERE A.AREACODE				= :is_areacode
   AND A.DIVISIONCODE		= :is_divisioncode
	AND A.LARGEGROUPCODE		= :ls_largegroupcode
	AND A.MIDDLEGROUPCODE	= :ls_middlegroupcode
	AND A.SMALLGROUPCODE		= :ls_smallgroupcode
	AND A.FINALPROCESSFLAG	= '1' 
USING SQLPIS;

IF SQLPIS.SQLCode = 0 THEN
	dw_pisq180u_01.SetItem(1, 'processcost', ll_processcost)
ELSE
	MessageBox('Ȯ ��', '��������� ���ϴµ� �����߽��ϴ�', StopSign!)
	RETURN FALSE
END IF

// ������ ���������� ���Ѵ�
//
SELECT A.PROCESSCOST  
  INTO :ll_processcost  
  FROM TQSMALLGROUPTOPROCESS  A
 WHERE A.AREACODE				= :is_areacode
   AND A.DIVISIONCODE		= :is_divisioncode
	AND A.LARGEGROUPCODE		= :ls_largegroupcode
	AND A.MIDDLEGROUPCODE	= :ls_middlegroupcode
	AND A.SMALLGROUPCODE		= :ls_smallgroupcode
	AND A.PROCESSCODE			= :ls_processcode
USING SQLPIS;

IF SQLPIS.SQLCode = 0 THEN
	dw_pisq180u_04.SetItem(1, 'processcost', ll_processcost)
ELSE
	MessageBox('Ȯ ��', '������ ���������� ���ϴµ� �����߽��ϴ�', StopSign!)
	RETURN FALSE
END IF

RETURN TRUE
end function

public subroutine wf_detail_temp_insert ();
String	ls_originationdate, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode
String	ls_processcode, ls_badreasoncode, ls_badtypecode, ls_memo
Long		ll_repairqty, ll_disuseqty, ll_totalqty, ll_processcost, ll_reccnt = 0

// ���忡 �ʿ��� �⺻�ڷḦ ���Ѵ�
//
ls_originationdate= dw_pisq180u_01.GetItemString(1, 'originationdate')
ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_01.GetItemString(1, 'smallgroupcode')
ls_processcode		= dw_pisq180u_02.GetItemString(dw_pisq180u_02.GetSelectedRow(0), 'processcode')
ls_badreasoncode	= dw_pisq180u_04.GetItemString(1, 'badreasoncode')
ls_badtypecode		= dw_pisq180u_04.GetItemString(1, 'badtypecode')
ls_memo				= dw_pisq180u_04.GetItemString(1, 'memo')
ll_repairqty		= dw_pisq180u_04.GetItemNumber(1, 'repairqty')
ll_disuseqty		= dw_pisq180u_04.GetItemNumber(1, 'disuseqty')
ll_totalqty			= dw_pisq180u_04.GetItemNumber(1, 'totalqty')
ll_processcost		= dw_pisq180u_04.GetItemNumber(1, 'processcost')

// �ű����� �������� Ȯ���Ѵ�
//
SELECT count(*)
  INTO :ll_reccnt
  FROM TQPROGRESSBADDETAIL_TEMP
 WHERE AREACODE			= :is_areacode
	AND DIVISIONCODE		= :is_divisioncode
	AND ORIGINATIONDATE	= :ls_originationdate
	AND LARGEGROUPCODE	= :ls_largegroupcode
	AND MIDDLEGROUPCODE	= :ls_middlegroupcode
	AND SMALLGROUPCODE	= :ls_smallgroupcode
	AND PROCESSCODE		= :ls_processcode
	AND BADREASONCODE		= :ls_badreasoncode
	AND BADTYPECODE		= :ls_badtypecode
USING SQLPIS;

IF ll_reccnt = 0 THEN
	// �ű�
	//
	INSERT INTO TQPROGRESSBADDETAIL_TEMP  
				 ( AREACODE,   
					DIVISIONCODE,   
					ORIGINATIONDATE,   
					LARGEGROUPCODE,   
					MIDDLEGROUPCODE,   
					SMALLGROUPCODE,   
					PROCESSCODE,   
					BADREASONCODE,   
					BADTYPECODE,   
					MEMO,   
					REPAIRQTY,   
					DISUSEQTY,   
					TOTALQTY,   
					PROCESSCOST,   
					LastEmp	)  
		VALUES ( :is_areacode,
					:is_divisioncode,
					:ls_originationdate,
					:ls_largegroupcode,
					:ls_middlegroupcode,
					:ls_smallgroupcode,
					:ls_processcode,
					:ls_badreasoncode,
					:ls_badtypecode,
					:ls_memo,
					:ll_repairqty,
					:ll_disuseqty,
					:ll_totalqty,
					:ll_processcost,
					'Y')
	USING SQLPIS;
ELSE
	// ����
	//
	UPDATE TQPROGRESSBADDETAIL_TEMP  
		SET MEMO			= :ls_memo,
			 REPAIRQTY	= :ll_repairqty,
			 DISUSEQTY	= :ll_disuseqty,
			 TOTALQTY	= :ll_totalqty,
			 PROCESSCOST= :ll_processcost,
			 LastEmp		= 'Y'  
	 WHERE AREACODE			= :is_areacode
		AND DIVISIONCODE		= :is_divisioncode
		AND ORIGINATIONDATE	= :ls_originationdate
		AND LARGEGROUPCODE	= :ls_largegroupcode
		AND MIDDLEGROUPCODE	= :ls_middlegroupcode
		AND SMALLGROUPCODE	= :ls_smallgroupcode
		AND PROCESSCODE		= :ls_processcode
		AND BADREASONCODE		= :ls_badreasoncode
		AND BADTYPECODE		= :ls_badtypecode
	USING SQLPIS;
END IF

end subroutine

public function boolean wf_checkcolumn ();
Long		ll_repairqty, ll_disuseqty
Boolean	lb_rtn = TRUE

IF dw_pisq180u_01.AcceptText() <> 1 THEN RETURN FALSE
IF dw_pisq180u_04.AcceptText() <> 1 THEN RETURN FALSE

//// ������� üũ
////
//IF dw_pisq180u_01.GetItemNumber(1, 'productqty') = 0 OR &
//	IsNull(dw_pisq180u_01.GetItemNumber(1, 'productqty')) = TRUE THEN
//	MessageBox('Ȯ ��', '��������� �Է��ϼ���', StopSign!)
//	dw_pisq180u_01.SetColumn('productqty')
//	dw_pisq180u_01.SetFocus()
//	RETURN FALSE
//END IF

// �Է��� ������ üũ���� ����
//
IF dw_pisq180u_04.RowCount() < 1 THEN
	RETURN TRUE
END IF

// �ҷ����� üũ
//
IF f_checknullorspace(dw_pisq180u_04.GetItemString(1, 'badreasoncode')) = TRUE THEN
	MessageBox('Ȯ ��', '�ҷ������� �Է��ϼ���', StopSign!)
	dw_pisq180u_04.SetColumn('badreasoncode')
	dw_pisq180u_04.SetFocus()
	RETURN FALSE
END IF

// �ҷ����� üũ
//
IF f_checknullorspace(dw_pisq180u_04.GetItemString(1, 'badtypecode')) = TRUE THEN
	MessageBox('Ȯ ��', '�ҷ������� �Է��ϼ���', StopSign!)
	dw_pisq180u_04.SetColumn('badtypecode')
	dw_pisq180u_04.SetFocus()
	RETURN FALSE
END IF

// ����/��� üũ
//
ll_repairqty = dw_pisq180u_04.GetItemNumber(1, 'repairqty') 
ll_disuseqty = dw_pisq180u_04.GetItemNumber(1, 'disuseqty') 

IF IsNull(ll_repairqty) = TRUE THEN
	ll_repairqty = 0
END IF
IF IsNull(ll_disuseqty) = TRUE THEN
	ll_disuseqty = 0
END IF

IF ll_repairqty = 0 AND ll_disuseqty = 0 THEN
	MessageBox('Ȯ ��', '����/����� �����̶� �ԷµǾ�� �մϴ�', StopSign!)
	dw_pisq180u_04.SetColumn('repairqty')
	dw_pisq180u_04.SetFocus()
	RETURN FALSE
ELSE
	// �հ踦 ��Ʈ�Ѵ�
	//
	dw_pisq180u_04.SetItem(1, 'totalqty', ll_repairqty + ll_disuseqty)
END IF

RETURN lb_rtn

end function

public subroutine wf_detail_temp_delete ();
String	ls_originationdate, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode
String	ls_processcode, ls_badreasoncode, ls_badtypecode

// ������ �ʿ��� �⺻�ڷḦ ���Ѵ�
//
ls_originationdate= dw_pisq180u_01.GetItemString(1, 'originationdate')
ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_01.GetItemString(1, 'smallgroupcode')
ls_processcode		= dw_pisq180u_02.GetItemString(dw_pisq180u_02.GetSelectedRow(0), 'processcode')
ls_badreasoncode	= dw_pisq180u_04.GetItemString(1, 'badreasoncode')
ls_badtypecode		= dw_pisq180u_04.GetItemString(1, 'badtypecode')

// ����(�����δ� ���� �ʱ�ȭ�Ѵ�)
//
UPDATE TQPROGRESSBADDETAIL_TEMP  
	SET MEMO			= '',
		 REPAIRQTY	= 0,
		 DISUSEQTY	= 0,
		 TOTALQTY	= 0,
		 PROCESSCOST= 0,
		 LastEmp		= 'Y'  
 WHERE AREACODE			= :is_areacode
	AND DIVISIONCODE		= :is_divisioncode
	AND ORIGINATIONDATE	= :ls_originationdate
	AND LARGEGROUPCODE	= :ls_largegroupcode
	AND MIDDLEGROUPCODE	= :ls_middlegroupcode
	AND SMALLGROUPCODE	= :ls_smallgroupcode
	AND PROCESSCODE		= :ls_processcode
	AND BADREASONCODE		= :ls_badreasoncode
	AND BADTYPECODE		= :ls_badtypecode
USING SQLPIS;

end subroutine

on w_pisq180u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq180u_01=create dw_pisq180u_01
this.dw_pisq180u_02=create dw_pisq180u_02
this.dw_pisq180u_03=create dw_pisq180u_03
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_1=create gb_1
this.dw_pisq180u_04=create dw_pisq180u_04
this.cb_allins=create cb_allins
this.cb_regtotal=create cb_regtotal
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_pisq180u_01
this.Control[iCurrent+4]=this.dw_pisq180u_02
this.Control[iCurrent+5]=this.dw_pisq180u_03
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.dw_pisq180u_04
this.Control[iCurrent+10]=this.cb_allins
this.Control[iCurrent+11]=this.cb_regtotal
end on

on w_pisq180u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq180u_01)
destroy(this.dw_pisq180u_02)
destroy(this.dw_pisq180u_03)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.dw_pisq180u_04)
destroy(this.cb_allins)
destroy(this.cb_regtotal)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq080i, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
String	ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_date, ls_processcode
Long		ll_retrieverow

uo_status.st_message.text = ""
IF dw_pisq180u_01.AcceptText() <> 1 THEN RETURN

// ��ȸ�� �ʿ��� �⺻�ڷḦ ���Ѵ�
//
ls_date 				= dw_pisq180u_01.GetItemString(1, 'originationdate')
ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_01.GetItemString(1, 'smallgroupcode')

// �����ҷ� ��� �ڷḦ ��ȸ�Ѵ�
//
ll_retrieverow = dw_pisq180u_01.Retrieve(is_AreaCode, is_DivisionCode, ls_date, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode)

IF ll_retrieverow = 0 THEN
	dw_pisq180u_01.ReSet()
	dw_pisq180u_01.InsertRow(0)
	dw_pisq180u_01.SetItem(1, 'originationdate', ls_date)
	dw_pisq180u_01.SetItem(1, 'largegroupcode' , ls_largegroupcode)
	dw_pisq180u_01.SetItem(1, 'middlegroupcode', ls_middlegroupcode)
	dw_pisq180u_01.SetItem(1, 'smallgroupcode' , ls_smallgroupcode)
	dw_pisq180u_01.SetColumn('productqty')
END IF

// ������ ��ȸ�Ѵ�
//
dw_pisq180u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode)
ls_processcode		= dw_pisq180u_02.GetItemString(1, 'processcode')

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq180u_02, 1, True)	

// �����ҷ� ������ �ڷḦ ��ȸ�Ѵ�
//
dw_pisq180u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_date, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_processcode)

IF ll_retrieverow <> 0 THEN
	dw_pisq180u_03.SetColumn('badreasoncode')
	dw_pisq180u_03.SetFocus()
END IF

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq180u_03, 1, True)	

end event

event open;call super::open;
// Ʈ������� �����Ѵ�
//
dw_pisq180u_01.SetTransObject(SQLPIS)
dw_pisq180u_02.SetTransObject(SQLPIS)
dw_pisq180u_03.SetTransObject(SQLPIS)
dw_pisq180u_04.SetTransObject(SQLPIS)

// Child Datawindow ����(��ǰ ��/��/�� �з�)
//
dw_pisq180u_01.GetChild ('largegroupcode' , idwc_largegroup)
dw_pisq180u_01.GetChild ('middlegroupcode', idwc_middlegroup)
dw_pisq180u_01.GetChild ('smallgroupcode' , idwc_smallgroup)
dw_pisq180u_04.GetChild ('badreasoncode' 	, idwc_badreason)
dw_pisq180u_04.GetChild ('badtypecode' 	, idwc_badtype)

idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )
idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )

uo_division.PostEvent('ue_select')


end event

event ue_insert;
uo_status.st_message.text = ""
dw_pisq180u_04.ReSet()
dw_pisq180u_04.InsertRow(0)

end event

event ue_delete;call super::ue_delete;
String	ls_date, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_processcode
Long		ll_save, ll_selcount = 0

uo_status.st_message.text = ""
// ��ȸ�� �ʿ��� �⺻�ڷḦ ���Ѵ�
//
ls_date 				= dw_pisq180u_01.GetItemString(1, 'originationdate')
ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_01.GetItemString(1, 'smallgroupcode')
if dw_pisq180u_02.GetSelectedRow(0) < 1 then
	uo_status.st_message.text = "������ ����Ÿ�� �����Ͻʽÿ�"
	return 0
end if
ls_processcode		= dw_pisq180u_02.GetItemString(dw_pisq180u_02.GetSelectedRow(0), 'processcode')

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

// InterFace�� �������ϵ� �����Ѵ�(�����δ� ������ UPDATE)
//
wf_detail_temp_delete()

// ���õ� ���� �����Ѵ�
//
dw_pisq180u_04.DeleteRow(1)

// �����ҷ� �������� �����Ѵ�
//
ll_save = dw_pisq180u_04.Update()
IF ll_save = 1 THEN
//	// �����ִ� ���� ���ڵ���� ���Ѵ�
//	//
//	SELECT COUNT(*)
//     INTO :ll_selcount
//     FROM TQPROGRESSBADDETAIL 
//    WHERE AREACODE			= :is_AreaCode
//      AND DIVISIONCODE		= :is_DivisionCode
//      AND ORIGINATIONDATE	= :ls_date
//      AND LARGEGROUPCODE	= :ls_largegroupcode
//      AND MIDDLEGROUPCODE	= :ls_middlegroupcode
//      AND SMALLGROUPCODE	= :ls_smallgroupcode
//	 USING SQLPIS;
//
//	// ������ ������ ����Ÿ �ڷᵵ �����Ѵ�
//	//
//	IF ll_selcount = 0 THEN
//		DELETE 
//		  FROM TQPROGRESSBADMASTER 
//		 WHERE AREACODE			= :is_AreaCode
//			AND DIVISIONCODE		= :is_DivisionCode
//			AND ORIGINATIONDATE	= :ls_date
//			AND LARGEGROUPCODE	= :ls_largegroupcode
//			AND MIDDLEGROUPCODE	= :ls_middlegroupcode
//			AND SMALLGROUPCODE	= :ls_smallgroupcode
//		 USING SQLPIS;
//	END IF
	// Commit ó��
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack ó��
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
	RETURN
END IF

// �����ҷ� ������ �ڷḦ ��ȸ�Ѵ�
//
dw_pisq180u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_date, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_processcode)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq180u_03, 1, True)	

dw_pisq180u_04.ReSet()

end event

event ue_save;call super::ue_save;
String	ls_date, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_processcode
Int	li_save

uo_status.st_message.text = ""
ls_date = dw_pisq180u_01.GetItemString(1, 'originationdate')

IF Len(Trim((ls_date))) <> 10 THEN
	MessageBox('Ȯ ��', '���ڴ� ������ ���� ���·� �Է��ϼ��� ==> 2002.01.01', StopSign!)
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

IF f_checknullorspace(ls_date) = TRUE THEN
	MessageBox('Ȯ ��', '���ڸ� �Է��ϼ���', StopSign!)
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

IF IsDate(ls_date) = FALSE THEN
	MessageBox('Ȯ ��', '���ڸ� �ٸ��� �Է��ϼ���', StopSign!)
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

// �ʼ��Է� �׸��� üũ�Ѵ�
//
IF wf_checkcolumn() = FALSE THEN RETURN 0

// ��������� ������ ���������� ���Ѵ�
//
IF wf_getprocesscost() = FALSE THEN RETURN 0

// ���忡 �ʿ��� �⺻�ڷḦ ���Ѵ�
//
ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_01.GetItemString(1, 'smallgroupcode')
ls_processcode		= dw_pisq180u_02.GetItemString(dw_pisq180u_02.GetSelectedRow(0), 'processcode')

// ���̺� Ű�κ��� ��Ʈ�Ѵ�
//
dw_pisq180u_01.SetItem(1, 'areacode'			, is_areacode)
dw_pisq180u_01.SetItem(1, 'divisioncode'		, is_divisioncode)

dw_pisq180u_04.SetItem(1, 'areacode'			, is_areacode)
dw_pisq180u_04.SetItem(1, 'divisioncode'		, is_divisioncode)
dw_pisq180u_04.SetItem(1, 'originationdate'	, ls_date)
dw_pisq180u_04.SetItem(1, 'largegroupcode'	, ls_largegroupcode)
dw_pisq180u_04.SetItem(1, 'middlegroupcode'	, ls_middlegroupcode)
dw_pisq180u_04.SetItem(1, 'smallgroupcode'	, ls_smallgroupcode)
dw_pisq180u_04.SetItem(1, 'processcode'		, ls_processcode)

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

// �����ҷ� ��带 �����Ѵ�
//
li_save = dw_pisq180u_01.Update()
IF li_save <> 1 THEN
	// RollBack ó��
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
	RETURN
END IF

// �����ҷ� �����ϸ� �����Ѵ�
//
li_save = dw_pisq180u_04.Update()
IF li_save = 1 THEN
	// Commit ó��
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	uo_status.st_message.text = "���������� ó���Ǿ����ϴ�."
ELSE 
	// RollBack ó��
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
	RETURN
END IF

// InterFace�� �������Ͽ��� �����Ѵ�
//
wf_detail_temp_insert()

SQLPIS.AUTOCommit = TRUE

// �����ҷ� ������ �ڷḦ ��ȸ�Ѵ�
//
dw_pisq180u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_date, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_processcode)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq180u_03, 1, True)	

dw_pisq180u_04.ReSet()

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq180u_01.SetTransObject(SQLPIS)
dw_pisq180u_02.SetTransObject(SQLPIS)
dw_pisq180u_03.SetTransObject(SQLPIS)
dw_pisq180u_04.SetTransObject(SQLPIS)

idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )
idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq180u
integer x = 18
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq180u
integer x = 59
integer y = 60
integer taborder = 10
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_division
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						��ȸ�ϰ��� �ϴ� DDDW Object
//						string			fs_empno					��ȸ�ϰ��� �ϴ� ��� (������/���庰 ���ѿ� ���� ��ȸ�� ���Ͽ�)
//						string			fs_areacode				��ȸ�ϰ��� �ϴ� ����
//						string			fs_divisioncode		��ȸ�ϰ��� �ϴ� ���� �ڵ� (�Ϲ������� '%' �� ����ϵ���)
//						boolean			fb_allflag				��ȸ�� ���� ������ 2�� �̻��� Record �� ���
//																		True : '��ü' �׸� ���� (�����ڵ�� '%', ������� '��ü')
//																		False : '��ü' �׸� �� ����
//						string			rs_divisioncode		���õ� ���� �ڵ� (reference)
//						string			rs_divisionname		���õ� ���� �� (reference)
//						string			rs_divisionnameeng	���õ� ���� ���� �� (reference)
//	Returns		: none
//	Description	: ������ �����ϱ� ���� DDDW �� ��ȸ�ϱ� ���Ͽ�
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////

string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

// Ʈ������� �����Ѵ�
//
dw_pisq180u_01.SetTransObject(SQLPIS)
dw_pisq180u_02.SetTransObject(SQLPIS)
dw_pisq180u_03.SetTransObject(SQLPIS)
dw_pisq180u_04.SetTransObject(SQLPIS)

idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )
idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )

uo_division.PostEvent('ue_select')

end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow ldw_division
ldw_division = uo_division.dw_1
ls_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq180u
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;
String	ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_date, ls_processcode, ls_badreasoncode
Long		ll_retrieverow 

// Ʈ������� �����Ѵ�
//
dw_pisq180u_01.SetTransObject(SQLPIS)
dw_pisq180u_02.SetTransObject(SQLPIS)
dw_pisq180u_03.SetTransObject(SQLPIS)
dw_pisq180u_04.SetTransObject(SQLPIS)

// ���ϵ� ������ Ʈ������� �����Ѵ�
//
idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )
idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )
//
if uo_area.dw_1.GetRow() < 1 then
	return 
end if
is_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
is_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')

//����Ÿ������ ����
dw_pisq180u_01.reset()
dw_pisq180u_02.reset()
dw_pisq180u_03.reset()

// Child Retrieve(��з�)
//
ll_retrieverow = idwc_largegroup.Retrieve(is_AreaCode, is_DivisionCode)
if ll_retrieverow > 0 then
	// Child Window���� ��з� �ڵ带 ���Ѵ�
	//
	ls_largegroupcode = idwc_largegroup.GetItemString(1, 'largegroupcode')
else
	ls_largegroupcode = ' '
end if
// Child Retrieve(�ߺз�)
//
ll_retrieverow = idwc_middlegroup.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode)
if ll_retrieverow > 0 then
	// Child Window���� �ߺз� �ڵ带 ���Ѵ�
	//
	ls_middlegroupcode = idwc_middlegroup.GetItemString(1, 'middlegroupcode')
else
	ls_middlegroupcode = ' '
end if
// Child Retrieve(�Һз�)
//
ll_retrieverow = idwc_smallgroup.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode)
if ll_retrieverow > 0 then
	// Child Window���� �Һз� �ڵ带 ���Ѵ�
	//
	ls_smallgroupcode = idwc_smallgroup.GetItemString(1, 'smallgroupcode')
else
	ls_smallgroupcode = ' '
end if

dw_pisq180u_01.InsertRow(0)
dw_pisq180u_01.SetItem(1, 'originationdate', String(f_getsysdatetime(), 'yyyy.mm.dd'))
dw_pisq180u_01.SetItem(1, 'largegroupcode' , ls_largegroupcode)
dw_pisq180u_01.SetItem(1, 'middlegroupcode', ls_middlegroupcode)
dw_pisq180u_01.SetItem(1, 'smallgroupcode' , ls_smallgroupcode)

// �ҷ�����/�ҷ����� ���ϵ������츦  ��ȸ�Ѵ�
//
idwc_badreason.Retrieve('QCPR01')
ls_badreasoncode = idwc_badreason.GetItemString(1, 'codeid')
idwc_badtype.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_badreasoncode)

// ������ ��ȸ�Ѵ�
//
dw_pisq180u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode)
f_SetHighlight(dw_pisq180u_02, 1, True)	

// ������ �Է��� �����ϰ� 1 ROW�� �̸� �����صд�
//
//cb_ins.TriggerEvent(Clicked!)



end event

type dw_pisq180u_01 from u_vi_std_datawindow within w_pisq180u
integer x = 46
integer y = 212
integer width = 4169
integer height = 188
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_pisq180u_01"
boolean livescroll = false
end type

event rowfocuschanged;
//
end event

event clicked;
//
end event

event itemchanged;
String	ls_colname, ls_coldata, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode
long ll_rowcnt

IF dw_pisq180u_01.AcceptText() <> 1 OR ROW < 1 THEN RETURN 0

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	CASE 'originationdate'
		IF Len(Trim((ls_coldata))) <> 10 THEN
			MessageBox('Ȯ ��', '���ڴ� ������ ���� ���·� �Է��ϼ��� ==> 2002.01.01', StopSign!)
			dw_pisq180u_01.SetColumn('originationdate')		
			dw_pisq180u_01.SetFocus()
			RETURN 1
		END IF			

		IF f_checknullorspace(ls_coldata) = TRUE THEN
			MessageBox('Ȯ ��', '���ڸ� �Է��ϼ���', StopSign!)
			dw_pisq180u_01.SetColumn('originationdate')		
			dw_pisq180u_01.SetFocus()
			RETURN 1
		END IF			

		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('Ȯ ��', '���ڸ� �ٸ��� �Է��ϼ���', StopSign!)
			dw_pisq180u_01.SetColumn('originationdate')		
			dw_pisq180u_01.SetFocus()
			RETURN 1
		END IF			
		
		Parent.TriggerEvent('ue_retrieve')
	// ��з��� �����
	//
	CASE 'largegroupcode'
		dw_pisq180u_02.reset()
		dw_pisq180u_03.reset()
		// ����� ��з� �ڵ带 ���Ѵ�
		//
		ls_largegroupcode = ls_coldata
		
		// Child Retrieve(�ߺз�)
		//
		ll_rowcnt = idwc_middlegroup.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode)
		if ll_rowcnt < 1 then
			This.setitem(1,'middlegroupcode', '')
			This.setitem( 1, 'smallgroupcode', '')
			return 0
		end if
		// Child Window���� �ߺз� �ڵ带 ���Ѵ�
		//
		ls_middlegroupcode = idwc_middlegroup.GetItemString(1, 'middlegroupcode')
		
		// Child Retrieve(�Һз�)
		//
		ll_rowcnt = idwc_smallgroup.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode)
		if ll_rowcnt < 1 then
			This.setitem( 1, 'smallgroupcode', '')
			return 0
		end if
		// Child Window���� �Һз� �ڵ带 ���Ѵ�
		//
		ls_smallgroupcode  = idwc_smallgroup.GetItemString(1, 'smallgroupcode')

		dw_pisq180u_01.SetItem(1, 'middlegroupcode', ls_middlegroupcode)
		dw_pisq180u_01.SetItem(1, 'smallgroupcode' , ls_smallgroupcode)
		// ������ ��ȸ�Ѵ�
		//
		dw_pisq180u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_coldata)
		// �Һз� ���濡 ���� ���� �� �����ҷ� ������ �ڷḦ ǥ���ϱ� ���Ͽ� ó���� �ѱ��
		//
		Parent.TriggerEvent('ue_retrieve')

	// �ߺз��� �����
	//
	CASE 'middlegroupcode'
		dw_pisq180u_02.reset()
		dw_pisq180u_03.reset()
		// ��/�ߺз� �ڵ带 ���Ѵ�
		//
		ls_largegroupcode  = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
		ls_middlegroupcode = ls_coldata
	
		// Child Retrieve(�Һз�)
		//
		ll_rowcnt = idwc_smallgroup.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode)
		if ll_rowcnt < 1 then
			This.setitem( 1, 'smallgroupcode', '')
			return 0
		end if
		// Child Window���� �Һз� �ڵ带 ���Ѵ�
		//
		ls_smallgroupcode  = idwc_smallgroup.GetItemString(1, 'smallgroupcode')
		dw_pisq180u_01.SetItem(1, 'smallgroupcode' , ls_smallgroupcode)
		// ������ ��ȸ�Ѵ�
		//
		dw_pisq180u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_coldata)
		// �Һз� ���濡 ���� ���� �� �����ҷ� ������ �ڷḦ ǥ���ϱ� ���Ͽ� ó���� �ѱ��
		//
		Parent.TriggerEvent('ue_retrieve')

	// �Һз��� �����
	//
	CASE 'smallgroupcode'
		dw_pisq180u_02.reset()
		dw_pisq180u_03.reset()
		ls_largegroupcode  = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
		ls_middlegroupcode = dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
		// ������ ��ȸ�Ѵ�
		//
		dw_pisq180u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_coldata)
		// �Һз� ���濡 ���� ���� �� �����ҷ� ������ �ڷḦ ǥ���ϱ� ���Ͽ� ó���� �ѱ��
		//
		Parent.TriggerEvent('ue_retrieve')
END CHOOSE

return 0

end event

type dw_pisq180u_02 from u_vi_std_datawindow within w_pisq180u
integer x = 46
integer y = 416
integer width = 1408
integer height = 2124
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_pisq180u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;
String	ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_date, ls_processcode

// ��ȸ�� �ʿ��� �⺻�ڷḦ ���Ѵ�
//
if dw_pisq180u_01.rowcount() < 1 then
	return 0
end if
ls_date 				= dw_pisq180u_01.GetItemString(1, 'originationdate')
ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_01.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_01.GetItemString(1, 'smallgroupcode')
if dw_pisq180u_02.GetSelectedRow(0) < 1 then
	return 0
end if
ls_processcode		= dw_pisq180u_02.GetItemString(dw_pisq180u_02.GetSelectedRow(0), 'processcode')

// �����ҷ� ������ �ڷḦ ��ȸ�Ѵ�
//
dw_pisq180u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_date, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode, ls_processcode)
dw_pisq180u_03.SetColumn('badreasoncode')
dw_pisq180u_03.SetFocus()

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq180u_03, 1, True)	

dw_pisq180u_02.SetFocus()

end event

event clicked;call super::clicked;
TriggerEvent(RowFocusChanged!)
end event

type dw_pisq180u_03 from u_vi_std_datawindow within w_pisq180u
integer x = 1467
integer y = 416
integer width = 2747
integer height = 1936
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisq180u_03"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
String	ls_originationdate, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode
String	ls_processcode, ls_badreasoncode, ls_badtypecode

// ���õ� �ڷḦ ���Ѵ�
//
ls_originationdate= dw_pisq180u_03.GetItemString(dw_pisq180u_03.GetSelectedRow(0), 'originationdate')
ls_largegroupcode	= dw_pisq180u_03.GetItemString(dw_pisq180u_03.GetSelectedRow(0), 'largegroupcode')
ls_middlegroupcode= dw_pisq180u_03.GetItemString(dw_pisq180u_03.GetSelectedRow(0), 'middlegroupcode')
ls_smallgroupcode	= dw_pisq180u_03.GetItemString(dw_pisq180u_03.GetSelectedRow(0), 'smallgroupcode')
ls_processcode		= dw_pisq180u_03.GetItemString(dw_pisq180u_03.GetSelectedRow(0), 'processcode')
ls_badreasoncode	= dw_pisq180u_03.GetItemString(dw_pisq180u_03.GetSelectedRow(0), 'badreasoncode')
ls_badtypecode		= dw_pisq180u_03.GetItemString(dw_pisq180u_03.GetSelectedRow(0), 'badtypecode')

dw_pisq180u_04.Retrieve(is_areacode, is_divisioncode, ls_originationdate, ls_largegroupcode, &
			ls_middlegroupcode, ls_smallgroupcode, ls_processcode, ls_badreasoncode, ls_badtypecode)

end event

type gb_2 from groupbox within w_pisq180u
integer x = 18
integer y = 188
integer width = 4224
integer height = 2384
integer taborder = 40
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_3 from groupbox within w_pisq180u
integer x = 18
integer y = 12
integer width = 4224
integer height = 168
integer taborder = 60
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisq180u
integer x = 1838
integer y = 1252
integer width = 549
integer height = 1300
integer taborder = 70
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type dw_pisq180u_04 from u_vi_std_datawindow within w_pisq180u
integer x = 1467
integer y = 2364
integer width = 2747
integer height = 176
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq180u_04"
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;
String	ls_colname, ls_coldata, ls_largegroupcode, ls_badtypecode

IF dw_pisq180u_03.AcceptText() <> 1 THEN RETURN

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// ��з��� �����
	//
	CASE 'badreasoncode'
		ls_largegroupcode = dw_pisq180u_01.GetItemString(1, 'largegroupcode')
		
		// �ҷ����� ���ϵ������츦  ��ȸ�Ѵ�
		//
		idwc_badtype.Retrieve(is_AreaCode, is_DivisionCode, ls_largegroupcode, ls_coldata)

		ls_badtypecode = idwc_badtype.GetItemString(row, 'badtypecode')

		dw_pisq180u_04.SetItem(row, 'badtypecode', ls_badtypecode)
END CHOOSE

end event

event clicked;//
end event

event rowfocuschanged;//
end event

type cb_allins from commandbutton within w_pisq180u
integer x = 2629
integer y = 44
integer width = 722
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�߻��ϻ���������"
end type

event clicked;
String	ls_date

ls_date = dw_pisq180u_01.GetitemString(1, 'originationdate')

IF Len(Trim((ls_date))) <> 10 THEN
	MessageBox('Ȯ ��', '���ڴ� ������ ���� ���·� �Է��ϼ��� ==> 2002.01.01')
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

IF f_checknullorspace(ls_date) = TRUE THEN
	MessageBox('Ȯ ��', '���ڸ� �Է��ϼ���')
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

IF IsDate(ls_date) = FALSE THEN
	MessageBox('Ȯ ��', '���ڸ� �ٸ��� �Է��ϼ���')
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			


SQLPIS.AUTOCommit = FALSE

// ������� �ϰ���� ���ν����� �����Ѵ�
//
DECLARE declare_sp_pisq180u_01 PROCEDURE for sp_pisq180u_01
	@ps_AreaCode        = :is_areacode   	,
	@ps_DivisionCode    = :is_divisioncode ,
   @ps_Date    		  = :ls_date
USING SQLPIS;

// ������� �ϰ���� ���ν����� �����Ѵ�
//
EXECUTE declare_sp_pisq180u_01 ;

SQLPIS.AUTOCommit = TRUE

MessageBox('Ȯ ��', '�߻��� ������� ����� �Ϸ� �Ǿ����ϴ�')



//String	ls_date
//
//// �ϰ���� ���ڸ� ���Ѵ�
////
//ls_date = dw_pisq180u_01.GetitemString(1, 'originationdate')
//
//// AUTO COMMIT�� FASLE�� ����
////
//SQLPIS.AUTOCommit = FALSE
//
//// ���ϵ� �ڷḦ �����Ѵ�
////
//DELETE FROM TQPROGRESSBADMASTER  
//		WHERE AREACODE				= :is_areacode
//		  AND DIVISIONCODE		= :is_divisioncode
//		  AND ORIGINATIONDATE	= :ls_date 
//USING SQLPIS;
//
//// QC�Һз��� ǰ������� ���̺� ��ϵ� ǰ���� ������ �۾��Ϻ��� ��������� ��������
//// ���������� ��������� �Բ����Ͽ� �����ҷ�����Ÿ�� �Է��Ѵ�
////
//INSERT INTO TQPROGRESSBADMASTER  
//         ( AREACODE,   
//           DIVISIONCODE,   
//           ORIGINATIONDATE,   
//           LARGEGROUPCODE,   
//           MIDDLEGROUPCODE,   
//           SMALLGROUPCODE,   
//           PRODUCTQTY,   
//           PROCESSCOST )  
//			( SELECT AS_AREACODE,   
//						AS_DIVISIONCODE,   
//						AS_DATE,
//						AS_LARGEGROUPCODE,   
//						AS_MIDDLEGROUPCODE,   
//						AS_SMALLGROUPCODE,   
//						SUM(AS_QTY),
//						SUM(AS_AMT)
//				FROM (  SELECT A.AREACODE									AS AS_AREACODE,   
//									A.DIVISIONCODE								AS AS_DIVISIONCODE,   
//									:ls_date 									AS AS_DATE,
//									A.LARGEGROUPCODE							AS AS_LARGEGROUPCODE,   
//									A.MIDDLEGROUPCODE							AS AS_MIDDLEGROUPCODE,   
//									A.SMALLGROUPCODE							AS AS_SMALLGROUPCODE,   
//									SUM(B.DAYPQTY) + SUM(B.NIGHTPQTY)	AS AS_QTY,
//									0												AS AS_AMT
//							 FROM TQSMALLGROUPTOITEM	A,
//									TMHREALPROD				B
//							WHERE A.AREACODE		= B.AREACODE
//							  AND A.DIVISIONCODE	= B.DIVISIONCODE
//							  AND A.WORKCENTER	= B.WORKCENTER
//							  AND A.ITEMCODE		= B.ITEMCODE
//							  AND A.SUBLINECODE	= B.SUBLINECODE
//							  AND A.SUBLINENO		= B.SUBLINENO
//							  AND A.AREACODE		= :is_areacode
//							  AND A.DIVISIONCODE	= :is_divisioncode
//							  AND B.WORKDAY		= :ls_date
//						GROUP BY A.AREACODE			,
//									A.DIVISIONCODE		,
//									A.LARGEGROUPCODE	,
//									A.MIDDLEGROUPCODE	,
//									A.SMALLGROUPCODE
//							UNION ALL
//					
//						  SELECT A.AREACODE   								AS AS_AREACODE,       
//									A.DIVISIONCODE                      AS AS_DIVISIONCODE,   
//									:ls_date										AS AS_DATE,           
//									A.LARGEGROUPCODE                    AS AS_LARGEGROUPCODE, 
//									A.MIDDLEGROUPCODE                   AS AS_MIDDLEGROUPCODE,
//									A.SMALLGROUPCODE                    AS AS_SMALLGROUPCODE, 
//									0					                     AS AS_QTY,            
//									B.PROCESSCOST                       AS AS_AMT             
//							 FROM TQSMALLGROUPTOITEM		A,   
//									TQSMALLGROUPTOPROCESS	B 
//							WHERE A.AREACODE			= B.AREACODE
//							  AND A.DIVISIONCODE		= B.DIVISIONCODE
//							  AND A.LARGEGROUPCODE	= B.LARGEGROUPCODE
//							  AND A.MIDDLEGROUPCODE	= B.MIDDLEGROUPCODE
//							  AND A.SMALLGROUPCODE	= B.SMALLGROUPCODE
//							  AND A.AREACODE		= :is_areacode
//							  AND A.DIVISIONCODE	= :is_divisioncode
//							  AND B.FINALPROCESSFLAG= '1'
//						GROUP BY A.AREACODE,   
//									A.DIVISIONCODE,   
//									A.LARGEGROUPCODE,   
//									A.MIDDLEGROUPCODE,   
//									A.SMALLGROUPCODE,
//									B.PROCESSCOST
//					  ) TMP
//			 GROUP BY AS_AREACODE,   
//						 AS_DATE,
//						 AS_DIVISIONCODE,   
//						 AS_LARGEGROUPCODE,   
//						 AS_MIDDLEGROUPCODE,   
//						 AS_SMALLGROUPCODE
//			)
//USING SQLPIS;
//
//IF SQLPIS.SQLCode <> 0 THEN
//	MessageBox('Ȯ ��', '������� �ϰ���Ͽ� �����߽��ϴ�')
//END IF
//
//SQLPIS.AUTOCommit = TRUE
//
end event

type cb_regtotal from commandbutton within w_pisq180u
integer x = 3433
integer y = 44
integer width = 722
integer height = 112
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��������ϰ����"
end type

event clicked;String	ls_datefrom, ls_dateto

ls_dateto = dw_pisq180u_01.GetitemString(1, 'originationdate')

IF Len(Trim((ls_dateto))) <> 10 THEN
	MessageBox('Ȯ ��', '�߻��� ���ڴ� ������ ���� ���·� �Է��ϼ��� ==> 2002.01.01')
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

IF f_checknullorspace(ls_dateto) = TRUE THEN
	MessageBox('Ȯ ��', '�߻��� ���ڸ� �Է��ϼ���')
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

IF IsDate(ls_dateto) = FALSE THEN
	MessageBox('Ȯ ��', '�߻��� ���ڸ� �ٸ��� �Է��ϼ���')
	dw_pisq180u_01.SetColumn('originationdate')		
	dw_pisq180u_01.SetFocus()
	RETURN 1
END IF			

ls_datefrom = mid(ls_dateto,1,8) + '01'

if messagebox('Ȯ��', ls_datefrom + '�Ϻ��� ' + ls_dateto + ' �ϱ��� ������� ' &
		+ '�ϰ������ �����Ͻðڽ��ϱ�?',Question!,YesNo!,2) = 2 then
	return 0
end if

SQLPIS.AUTOCommit = FALSE

// ������� �ϰ���� ���ν����� �����Ѵ�
//
 DECLARE procedure_sp_pisq180u_02 PROCEDURE FOR sp_pisq180u_02  
         @ps_AreaCode = :is_areacode,   
         @ps_DivisionCode = :is_divisioncode,   
         @ps_DateFrom = :ls_datefrom,   
         @ps_DateTo = :ls_dateto  
			USING SQLPIS;

//// ������� �ϰ���� ���ν����� �����Ѵ�
EXECUTE procedure_sp_pisq180u_02 ;

SQLPIS.AUTOCommit = TRUE

MessageBox('Ȯ ��', '������� �ϰ������ �Ϸ� �Ǿ����ϴ�')
end event

