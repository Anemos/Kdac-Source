/*##############################################################################*/
/*## File Name		: sp_pisg050u_02.SQL						##*/
/*## SYSTEM		: KDAC �뱸���� IPIS2000						##*/
/*## Procedure Name	: sp_pisg050u_02							##*/
/*## Description	: ��������� ��������							##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg050u_02							##*/
/*## Parameter		: @ps_plandate, @ps_areacode, @ps_divisioncode,			##*/
/*## Parameter		: @ps_workcenter, @ps_linecode					##*/
/*## Use Table		: TKB, TMSTKB, TPLANRELEASE					##*/
/*## Initial		: 2002. 09. 12							##*/
/*## Last Change	: 2003. 01. 13							##*/
/*## Author		: �ּ���								##*/
/*##############################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg050u_02'))
	Drop Procedure sp_pisg050u_02
Go

/*
EXEC	sp_pisg050u_02
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '422I',
	@ps_linecode		= 'B',
	@ps_kbno		= 'DA140133007',
	@ps_com_code		= 'DAC04',
	@pi_err_code		= 0
*/

Create Procedure sp_pisg050u_02
	@ps_areacode		char(1),			-- �����ڵ�
	@ps_divisioncode	char(1),			-- �����ڵ�
	@ps_workcenter		char(5),			-- ��
	@ps_linecode		char(1),			-- �����ڵ�
	@ps_kbno		varchar(11),		-- ���ǹ�ȣ
	@ps_com_code		varchar(15),		-- �ܸ��� �ڵ�
	@pi_err_code		INT	OUTPUT		-- ERROR �ڵ�
As
Begin				-- Procedure Start
------------------------------------------------------------------------------

Begin	TRAN

Declare	@ldt_systemtime		DateTime,	-- ���� DATETIME
	@ls_applydate		char(10),	-- ������ ������� ����
	@ls_lastdate		char(10),	-- ������ ������ ����
	@ls_applymonth		char(08),	-- ���� ��,��
	@ls_applydate_close	char(10),	-- ������ ������ ����
	@ls_now_time		char(5),		-- ���� �ð�
	@ls_shift			char(1),		-- ��/�� ����
	@ls_lotno		varchar(6),	-- LOTNO
	@ls_present_itemcode	varchar(12),	-- ���� ������ ǰ��
	@li_rackqty		int,		-- �����
	@ls_inspectgubun	char(1),		-- �԰� ����
	@ls_stockgubun		char(1),		-- â�� ��� ����
	@ls_kbreleasedate	char(10),	-- �������� ����
	@ls_krbeleaseseq	int,		-- �������� Sequenc
	@li_present_cycleorder	int,		-- ���� ������ �������� ����
	@li_present_releaseorder	int,		-- ���� ������ �������� ����(����)
	@li_min_cycleorder	int,		-- �̿Ϸ���� �ּ� �������� ����
	@li_min_releaseorder	int,		-- �̿Ϸ���� �ּ� �������� ����(����)
	@ls_applyfrom		char(10),	-- ����Ÿ���� ������
	@ls_timecode		char(10),	-- �ð� �ڵ�
	@li_row_count		int,		-- DATA COUNT
	@ldt_tprdkb_lastdate	datetime,	-- ������ ������� �ð�
	@li_prdorder		int,		-- ���� ����
	@li_prdkborder		int,		-- ���� ����(����)
	@ls_before_itemcode	varchar(12),	-- ���� ���� �Ϸ��� ǰ��
	@li_kb_count		int,		-- ���Ǽ�
	@li_loop_count		int,		-- LOOT COUNT
	@ls_order_itemcode	varchar(12),	-- ������ ǰ��
	@ls_result_itemcode	varchar(12),	-- �Ϸ��� ǰ��
	@li_cycleorder		int,		-- ���ü���
	@li_hitcount		int,		-- ��Ī��
	@ls_productgroup	char(2),		-- ��ǰ��
	@ls_modelgroup		char(3),		-- �𵨱�
	@ls_kbstatuscode	char(1)		-- ���� ����

/*########################################################################################

	ERROR FLAG �ʱ�ȭ

########################################################################################*/

SELECT	@pi_err_code = 0

/*########################################################################################

	�ý��� �ð�

########################################################################################*/

SELECT	@ldt_systemtime		= GETDATE()

EXEC	sp_pisc_get_applydate_close
	@ps_areacode,
	@ps_divisioncode,
	@ldt_systemtime,
	@ls_applydate_close	output

EXEC	sp_pisc_get_applydate
	@ps_areacode,
	@ps_divisioncode,
	@ldt_systemtime,
	@ls_applydate		output

Select	@ls_now_time	= CONVERT(char(5), GETDATE(),108)

/*########################################################################################

	LotNo

########################################################################################*/

EXEC	sp_pisc_get_shift_close
	@ps_areacode,
	@ps_divisioncode,
	@ldt_systemtime,
	@ls_shift		output

EXEC	sp_pisc_get_lotno
	@ps_areacode,
	@ps_divisioncode,
	@ls_applydate_close,
	@ls_shift,
	@ls_lotno	output

/*########################################################################################

	�⺻����

########################################################################################*/

-- ������������, �������� SEQ
SELECT	@li_present_cycleorder	= CycleOrder,
	@li_present_releaseorder	= ReleaseOrder,
	@ls_present_itemcode	= ItemCode,
	@ls_kbreleasedate	= KBReleaseDate,
	@ls_krbeleaseseq	= KBReleaseSeq,
	@li_rackqty		= ReleaseKBQty
  FROM	TPLANRELEASE
 WHERE	PlanDate		= @ls_applydate_close
   AND	AreaCode		= @ps_areacode
   AND	DivisionCode		= @ps_divisioncode
   AND	WorkCenter		= @ps_workcenter
   AND	LineCode		= @ps_linecode
   AND	KBNo			= @ps_kbno
   AND	PrdFlag	 		= 'N' 

-- �԰���, â����
SELECT	@ls_kbstatuscode	= KBStatusCode,
	@ls_inspectgubun	= InspectGubun,
	@ls_stockgubun		= StockGubun
  FROM	TKB
 WHERE	KBNo			= @ps_kbno

/*########################################################################################
	
	�������� ���� ����� ���ǻ��� ����
	
########################################################################################*/
	
-- �ּ� ���ü���
SELECT	@li_min_cycleorder	= MIN(CycleOrder)
  FROM	TPLANRELEASE
 WHERE	PlanDate		= @ls_applydate_close
   AND	AreaCode		= @ps_areacode
   AND	DivisionCode		= @ps_divisioncode
   AND	WorkCenter		= @ps_workcenter
   AND	LineCode 		= @ps_linecode
   AND	ItemCode 		= @ls_present_itemcode
   AND	PrdFlag	 		= 'N' 

-- �ּ� ���ü�������
SELECT	@li_min_releaseorder	= MIN(ReleaseOrder)
  FROM	TPLANRELEASE
 WHERE	PlanDate		= @ls_applydate_close
   AND	AreaCode		= @ps_areacode
   AND	DivisionCode		= @ps_divisioncode
   AND	WorkCenter		= @ps_workcenter
   AND	LineCode 		= @ps_linecode
   AND	CycleOrder 		= @li_min_cycleorder
   AND	ItemCode 		= @ls_present_itemcode
   AND	PrdFlag	 		= 'N' 

IF @li_present_cycleorder		= @li_min_cycleorder	AND
    @li_present_releaseorder	= @li_min_releaseorder
BEGIN
	-- �������� �����Ϸ�� ����
	UPDATE	TPLANRELEASE
	SET	PrdFlag		= 'E',
		LastEmp		= 'Y',
		LastDate		= @ldt_systemtime
	 WHERE	PlanDate	= @ls_applydate_close
	   AND	AreaCode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	WorkCenter	= @ps_workcenter
	   AND	LineCode	= @ps_linecode
	   AND	CycleOrder	= @li_present_cycleorder
	   AND	ReleaseOrder	= @li_present_releaseorder

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
END
ELSE
BEGIN
	-- �ּ� ���ü����� 9999�� �ӽ� ����
	UPDATE	TPLANRELEASE
	SET	CycleOrder	= 9999,
		ReleaseOrder	= 9999
	 WHERE	PlanDate	= @ls_applydate_close
	   AND	AreaCode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	WorkCenter	= @ps_workcenter
	   AND	LineCode	= @ps_linecode
	   AND	CycleOrder	= @li_min_cycleorder
	   AND	ReleaseOrder	= @li_min_releaseorder

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error

	-- �� ���ü����� �ּ� ���ü����� ����
	UPDATE	TPLANRELEASE
	SET	CycleOrder	= @li_min_cycleorder,
		ReleaseOrder	= @li_min_releaseorder,
		PrdFlag		= 'E',
		LastEmp		= 'Y',
		LastDate		= @ldt_systemtime
	 WHERE	PlanDate	= @ls_applydate_close
	   AND	AreaCode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	WorkCenter	= @ps_workcenter
	   AND	LineCode	= @ps_linecode
	   AND	CycleOrder	= @li_present_cycleorder
	   AND	ReleaseOrder	= @li_present_releaseorder

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
	
	-- �ּ� ���ü����� �� ���ü����� ����
	UPDATE	TPLANRELEASE
	SET	CycleOrder	= @li_present_cycleorder,
		ReleaseOrder	= @li_present_releaseorder
	 WHERE	PlanDate	= @ls_applydate_close
	   AND	AreaCode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	WorkCenter	= @ps_workcenter
	   AND	LineCode	= @ps_linecode
	   AND	CycleOrder	= 9999
	   AND	ReleaseOrder	= 9999

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
END
	
/*########################################################################################

	�ð��뺰 �����ȹ(�������� ������ ����)

########################################################################################*/
	
-- ����Ÿ ������ �� TimeCode
SELECT	@ls_applyfrom			= ApplyFrom,
	@ls_timecode			= TimeCode
  FROM	TMSTTIME
 WHERE	AreaCode			=   @ps_areacode
   AND	DivisionCode			=   @ps_divisioncode
   AND	ApplyFrom			<= @ls_applydate
   AND	ApplyTo				>= @ls_applydate
   AND	CONVERT(Char(5),TimeStart,108)	<= @ls_now_time
   AND	CONVERT(Char(5),TimeEnd,108)	>= @ls_now_time

-- COUNT üũ
SELECT	@li_row_count	= COUNT(ItemCode)
  FROM	TPRDTIME
 WHERE	PrdDate		= @ls_applydate
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode
   AND	ItemCode	= @ls_present_itemcode
   AND	ApplyFrom	= @ls_applyfrom
   AND	TimeCode	= @ls_timecode

IF @li_row_count > 0
BEGIN
	-- �ð��뺰 �����ȹ�� ���귮 ����
	UPDATE	TPRDTIME
	SET	PrdQty		= PrdQty + @li_rackqty,
		LastEmp		= 'Y',
		LastDate		= @ldt_systemtime
	 WHERE	PrdDate		= @ls_applydate
	   AND	AreaCode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	WorkCenter	= @ps_workcenter
	   AND	LineCode	= @ps_linecode
	   AND	ItemCode	= @ls_present_itemcode
	   AND	ApplyFrom	= @ls_applyfrom
	   AND	TimeCode	= @ls_timecode

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
END
ELSE
BEGIN
	-- �ð��뺰 �����ȹ�� ���ڵ� ����
	INSERT INTO TPRDTIME
	VALUES
			(@ls_applydate,
			 @ps_areacode,
			 @ps_divisioncode,
			 @ps_workcenter,
			 @ps_linecode,
			 @ls_present_itemcode,
			 @ls_applyfrom,
			 @ls_timecode,
			 0,
			 @li_rackqty,
			 'Y',
			 @ldt_systemtime)
	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
END
	
/*########################################################################################

	����Ϸ�, â���԰� üũ

########################################################################################*/
	
IF @ls_inspectgubun	= 'N'	AND
    @ls_stockgubun	= 'N'

-- â�� �԰�
BEGIN
	-- ���� StatusCode ����
	SELECT @ls_kbstatuscode = 'D'

	-- ���� ���� ��Ȳ
	UPDATE	TKB
	SET	KBStatusCode	= @ls_kbstatuscode,
		PrdFlag		= 'E',
		PrdDate		= @ls_applydate_close,
		PrdAreaCode	= @ps_areacode,
		PrdDivisionCode	= @ps_divisioncode,
		PrdWorkCenter	= @ps_workcenter,
		PrdLineCode	= @ps_linecode,
		TimeApplyFrom	= @ls_applyfrom,
		TimeCode	= @ls_timecode,
		PrdQty		= @li_rackqty,
		LotNo		= @ls_lotno,
		StockDate	= @ls_applydate_close,
		StockQty		= @li_rackqty,
		KBEndTime	= @ldt_systemtime,
		KBStockTime	= @ldt_systemtime,
		LastEmp		= 'Y',
		LastDate		= @ldt_systemtime
	 WHERE	KBNo		= @ps_kbno
	   AND	KBStatusCode	= 'A'
	   AND	KBActiveGubun	= 'A'
	   AND	PrdFlag		= 'N'

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error

	-- ���� �̷�
	UPDATE	TKBHIS
	SET	KBStatusCode	= @ls_kbstatuscode,
		PrdFlag		= 'E',
		PrdDate		= @ls_applydate_close,
		PrdAreaCode	= @ps_areacode,
		PrdDivisionCode	= @ps_divisioncode,
		PrdWorkCenter	= @ps_workcenter,
		PrdLineCode	= @ps_linecode,
		TimeApplyFrom	= @ls_applyfrom,
		TimeCode	= @ls_timecode,
		PrdQty		= @li_rackqty,
		LotNo		= @ls_lotno,
		StockDate	= @ls_applydate_close,
		StockQty		= @li_rackqty,
		KBEndTime	= @ldt_systemtime,
		KBStockTime	= @ldt_systemtime,
		LastEmp		= 'Y',
		LastDate		= @ldt_systemtime
	 WHERE	KBNo		= @ps_kbno
	   AND	LastLoopFlag	= 'Y'
	   AND	KBStatusCode	= 'A'
	   AND	KBActiveGubun	= 'A'
	   AND	PrdFlag		= 'N'

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error

	-- ���� ��� üũ
	SELECT	@li_row_count	= COUNT(ItemCode)
	  FROM	TINV
	 WHERE	Areacode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	ItemCode	= @ls_present_itemcode

	IF @li_row_count > 0
	BEGIN
		-- ������� �߰�
		UPDATE	TINV
		SET	InvQty		= InvQty + @li_rackqty,
			LastEmp		= 'Y',
			LastDate		= @ldt_systemtime
		 WHERE	Areacode	= @ps_areacode
		   AND	DivisionCode	= @ps_divisioncode
		   AND	ItemCode	= @ls_present_itemcode

		-- ERROR üũ
		Select	@pi_err_code	= @pi_err_code + @@Error
	END
	ELSE
	BEGIN
		-- ��� ����
		INSERT INTO TINV
		VALUES
				(@ps_areacode,
				 @ps_divisioncode,
				 @ls_present_itemcode,
				 @li_rackqty,
				 0,
				 0,
				 0,
				 0,
				 NULL,
				 'Y',
				 @ldt_systemtime)
		-- ERROR üũ
		Select	@pi_err_code	= @pi_err_code + @@Error
	END

	-- TSTOCK_INTERFACE ���ڵ� ī����
	SELECT	@li_row_count	= MAX(SeqNo)
	  FROM	TSTOCK_INTERFACE
	 WHERE	KBNo		= @ps_kbno
	   AND	KBReleaseDate	= @ls_kbreleasedate
	   AND	KBReleaseSeq	= @ls_krbeleaseseq
	   AND	MISFlag		= 'A'

	-- NULL üũ
	IF @li_row_count IS NULL
	BEGIN
		SELECT @li_row_count = 1
	END
	ELSE
	BEGIN
		SELECT @li_row_count = @li_row_count + 1
	END

	-- TSTOCK_INTERFACE�� SeqNo�� �����Ͽ� �ű� ���ڵ� ����
	INSERT INTO TSTOCK_INTERFACE
	VALUES
			(@ps_kbno,
			 @ls_kbreleasedate,
			 @ls_krbeleaseseq,
			 @li_row_count,
			 'A',
			 'Y',
			 @ls_applydate_close,
			 @ps_areacode,
			 @ps_divisioncode,
			 @ps_workcenter,
			 @ps_linecode,
			 @ls_present_itemcode,
			 @li_rackqty,
			 @ps_com_code,
			 @ldt_systemtime)
	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
END
ELSE

-- ���� �Ϸ�
BEGIN
	-- ���� STATUSCODE ����
	SELECT @ls_kbstatuscode = 'C'

	-- ���� ���� ��Ȳ
	UPDATE	TKB
	SET	KBStatusCode	= @ls_kbstatuscode,
		PrdFlag		= 'E',
		PrdDate		= @ls_applydate_close,
		PrdAreaCode	= @ps_areacode,
		PrdDivisionCode	= @ps_divisioncode,
		PrdWorkCenter	= @ps_workcenter,
		PrdLineCode	= @ps_linecode,
		TimeApplyFrom	= @ls_applyfrom,
		TimeCode	= @ls_timecode,
		PrdQty		= @li_rackqty,
		LotNo		= @ls_lotno,
		KBEndTime	= @ldt_systemtime,
		LastEmp		= 'Y',
		LastDate		= @ldt_systemtime
	 WHERE	KBNo		= @ps_kbno
	   AND	KBStatusCode	= 'A'
	   AND	KBActiveGubun	= 'A'
	   AND	PrdFlag		= 'N'

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error

	-- ���� �̷�
	UPDATE	TKBHIS
	SET	KBStatusCode	= @ls_kbstatuscode,
		PrdFlag		= 'E',
		PrdDate		= @ls_applydate_close,
		PrdAreaCode	= @ps_areacode,
		PrdDivisionCode	= @ps_divisioncode,
		PrdWorkCenter	= @ps_workcenter,
		PrdLineCode	= @ps_linecode,
		TimeApplyFrom	= @ls_applyfrom,
		TimeCode	= @ls_timecode,
		PrdQty		= @li_rackqty,
		LotNo		= @ls_lotno,
		KBEndTime	= @ldt_systemtime,
		LastEmp		= 'Y',
		LastDate		= @ldt_systemtime
	 WHERE	KBNo		= @ps_kbno
	   AND	LastLoopFlag	= 'Y'
	   AND	KBStatusCode	= 'A'
	   AND	KBActiveGubun	= 'A'
	   AND	PrdFlag		= 'N'

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
END
	
/*########################################################################################

	�������� ���

########################################################################################*/
	
-- �ʱ�ȭ
SELECT @ldt_tprdkb_lastdate = NULL

-- ���� ���ڵ� üũ
SELECT	@li_row_count		= count(KBNo)
  FROM	TPRDKB
 WHERE	PrdDate			= @ls_applydate_close
   AND	AreaCode		= @ps_areacode
   AND	DivisionCode		= @ps_divisioncode
   AND	WorkCenter		= @ps_workcenter
   AND	LineCode 		= @ps_linecode

IF @li_row_count < 1
BEGIN
	-- ��������� ���ʷ�...
	SELECT	@li_prdorder	= 1,
		@li_prdkborder	= 1
END
ELSE
BEGIN
	-- ���������� �Էµ� ���������� �ð��� �о�´�.
	SELECT	@ldt_tprdkb_lastdate	= MAX(LastDate)
	  FROM	TPRDKB
	 WHERE	PrdDate			= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode 		= @ps_linecode

	-- ������ �Ϸ��� ǰ���� ������ �����´�.
	SELECT	@ls_before_itemcode	= ItemCode,
		@li_prdorder		= PrdOrder,
		@li_prdkborder		= PrdKBOrder
	  FROM	TPRDKB
	 WHERE	PrdDate			= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode 		= @ps_linecode
	   AND	LastDate 		= @ldt_tprdkb_lastdate

	-- ���������� ǰ���� ������ ǰ�� ��
	IF @ls_present_itemcode	= @ls_before_itemcode
	BEGIN
		-- �Ϸ� ����(����) 
		SELECT	@li_prdkborder	= @li_prdkborder + 1
	END
	ELSE
	BEGIN
		-- �Ϸ� ����
		SELECT	@li_prdorder	= @li_prdorder + 1,
			@li_prdkborder	= 1
	END
END

-- ������� ���
INSERT INTO TPRDKB
VALUES
		(@ls_applydate_close,
		 @ps_areacode,
		 @ps_divisioncode,
		 @ps_workcenter,
		 @ps_linecode,
		 @li_prdorder,
		 @li_prdkborder,
		 @ls_present_itemcode,
		 @ps_kbno,
		 @ls_kbreleasedate,
		 @ls_krbeleaseseq,
		 'Y',
		 @ldt_systemtime )
-- ERROR üũ
Select	@pi_err_code	= @pi_err_code + @@Error
	
/*########################################################################################

	���� �ؼ���

########################################################################################*/

Set @li_row_count = 0
SELECT	@li_row_count	= COUNT(ItemCode)
FROM	TPRDRATEKB
WHERE	PrdDate		= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode
   AND	ItemCode	= @ls_present_itemcode

-- ���� ���� ���� üũ
Set @li_kb_count = 0
IF @li_row_count < 1
Begin
	-- ���øż�
	SELECT	@li_kb_count		= COUNT(ItemCode)
	  FROM	TPLANRELEASE
	 WHERE	PlanDate		= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode		= @ps_linecode
	   AND	ItemCode		= @ls_present_itemcode
	   AND	ReleaseGubun		IN ( 'Y', 'T','U')

	-- �ű� ����
	INSERT INTO TPRDRATEKB
	VALUES
			(@ls_applydate_close,
			 @ps_areacode,
			 @ps_divisioncode,
			 @ps_workcenter,
			 @ps_linecode,
			 @ls_present_itemcode,
			 @li_kb_count,
			 1,
			 'Y',
			 @ldt_systemtime)
	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
End
ELSE
Begin
	-- �����߰�
	UPDATE	TPRDRATEKB
	   SET	PrdCount	= PrdCount + 1,
		LastEmp		= 'Y',
		LastDate		= @ldt_systemtime
	 WHERE	PrdDate		= @ls_applydate_close
	   AND	AreaCode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	WorkCenter	= @ps_workcenter
	   AND	LineCode	= @ps_linecode
	   AND	ItemCode	= @ls_present_itemcode

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
End

/*########################################################################################

	Ȯ�� ���� �ؼ���

########################################################################################*/

Set @li_row_count = 0
SELECT	@li_row_count	= COUNT(ItemCode)
FROM	TPRDRATEKB_T
WHERE	PrdDate		= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode
   AND	ItemCode	= @ls_present_itemcode

-- ���� ���� ���� üũ
Set @li_kb_count = 0
IF @li_row_count	< 1
Begin
	-- ���øż�
	SELECT	@li_kb_count		= COUNT(ItemCode)
	  FROM	TPLANRELEASE_T
	 WHERE	PlanDate		= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode		= @ps_linecode
	   AND	ItemCode		= @ls_present_itemcode
	   AND	ReleaseGubun		IN ( 'Y', 'T','U')

	-- �ű� ����
	INSERT INTO TPRDRATEKB_T
	VALUES
			(@ls_applydate_close,
			 @ps_areacode,
			 @ps_divisioncode,
			 @ps_workcenter,
			 @ps_linecode,
			 @ls_present_itemcode,
			 @li_kb_count,
			 1,
			 'Y',
			 @ldt_systemtime)
	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
End
ELSE
Begin
	-- �����߰�
	UPDATE	TPRDRATEKB_T
	   SET	PrdCount	= PrdCount + 1,
		LastEmp		= 'Y',
		LastDate		= @ldt_systemtime
	 WHERE	PrdDate		= @ls_applydate_close
	   AND	AreaCode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	WorkCenter	= @ps_workcenter
	   AND	LineCode	= @ps_linecode
	   AND	ItemCode	= @ls_present_itemcode

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
End

/*########################################################################################

	����ȭ ���� �ؼ���

########################################################################################*/
	
-- �������� TABLE ����
Create Table #Tmp_Order
(
	Order_no		int,
	Order_ItemCode		Char(12),
	CycleOrder		int
)	

-- �������� TABLE ����
Create Table #Tmp_Results
(
	Result_no		int,
	Result_ItemCode	Char(12),
	PrdOrder		int
)	

-- �������ü���
Set @li_row_count = 0
SELECT	@li_row_count	= COUNT(ItemCode) 
  FROM	TPLANRELEASE
 WHERE	PlanDate	= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode
   AND	ReleaseGubun	IN('T','U','Y')

-- �������� TABLE
Select	@li_loop_count		= 0,
	@ls_order_itemcode	= '', 
	@li_cycleorder		= 0
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count = @li_loop_count + 1
       	Set RowCount @li_loop_count 

	SELECT	@li_loop_count		= @li_loop_count ,
		@ls_order_itemcode	= ItemCode,
		@li_cycleorder		= CycleOrder
	   FROM TPLANRELEASE
	 WHERE	PlanDate		= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode		= @ps_linecode
	   AND	ReleaseGubun		IN('T','U','Y')
	 ORDER BY	CycleOrder, ReleaseOrder ASC

	Insert #Tmp_Order Values(@li_loop_count, @ls_order_itemcode, @li_cycleorder)

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
END

-- ���� ����
SELECT	@li_row_count	= COUNT(ItemCode) 
  FROM	TPRDKB
 WHERE	PrdDate		= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode

-- ������� TABLE
Select	@li_loop_count		= 0,
	@ls_result_itemcode	= '',
	@li_prdorder		= 0
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count = @li_loop_count + 1
       	Set RowCount @li_loop_count 

	SELECT	@li_loop_count		= @li_loop_count,
		@ls_result_itemcode	= ItemCode,
		@li_prdorder		= PrdOrder
	   FROM	TPRDKB
	 WHERE	PrdDate			= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode		= @ps_linecode

	Insert #Tmp_Results Values(@li_loop_count, @ls_result_itemcode, @li_prdorder)

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
END

-- ���ڵ� ī���� �ʱ�ȭ
Set RowCount 0

SELECT	@li_row_count	= COUNT(ItemCode) 
  FROM	TPLANRELEASE
 WHERE	PlanDate	= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode
   AND	ReleaseGubun	IN('T','U','Y')

-- HIT COUNT
Select	@li_loop_count = 0, @li_hitcount = 0
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count = @li_loop_count + 1

	-- ���ü���
	SELECT	@ls_order_itemcode	= Order_ItemCode,
		@li_cycleorder		= CycleOrder
	  FROM	#Tmp_Order
	WHERE	Order_no		= @li_loop_count

	-- �������
	SELECT	@ls_result_itemcode	= Result_ItemCode,
		@li_prdorder		= PrdOrder
	  FROM	#Tmp_Results
	WHERE	Result_no		= @li_loop_count

	-- ���ü����� ������� ��
	IF	@ls_present_itemcode	= @ls_order_itemcode	AND
		@ls_present_itemcode	= @ls_result_itemcode
	BEGIN
		SELECT	@li_hitcount	= @li_hitcount + 1
	END
END

SELECT	@li_row_count	= COUNT(ItemCode)
  FROM	TPRDRATECYCLE
WHERE	PrdDate		= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode
   AND	ItemCode	= @ls_present_itemcode

-- ���� ���� ���� üũ
IF @li_row_count > 0
Begin
	-- ���� �߰�
	UPDATE	TPRDRATECYCLE
	   SET	HitCount		= @li_hitcount,
		LastEmp		= 'Y',
		LastDate		= @ldt_systemtime
	 WHERE	PrdDate		= @ls_applydate_close
	   AND	AreaCode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	WorkCenter	= @ps_workcenter
	   AND	LineCode	= @ps_linecode
	   AND	ItemCode	= @ls_present_itemcode

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
End
ELSE
Begin
	-- �ű� ����
	INSERT INTO TPRDRATECYCLE
	VALUES
			(@ls_applydate_close,
			 @ps_areacode,
			 @ps_divisioncode,
			 @ps_workcenter,
			 @ps_linecode,
			 @ls_present_itemcode,
			 @li_kb_count,
			 @li_hitcount,
			 'Y',
			 @ldt_systemtime)
	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
End

-- TMP TABLE �ʱ�ȭ
TRUNCATE TABLE #Tmp_Order
TRUNCATE TABLE #Tmp_Results

/*########################################################################################

	Ȯ�� ����ȭ ���� �ؼ���

########################################################################################*/

-- �������ü���
SELECT	@li_row_count	= COUNT(ItemCode) 
  FROM	TPLANRELEASE_T
 WHERE	PlanDate	= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode
   AND	ReleaseGubun	IN('T','U','Y')

Select	@li_loop_count = 0

-- �������� TABLE
Select	@li_loop_count		= 0,
	@ls_order_itemcode	= '', 
	@li_cycleorder		= 0
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count = @li_loop_count + 1
       	Set RowCount @li_loop_count

	SELECT	@li_loop_count		= @li_loop_count,
		@ls_order_itemcode	= ItemCode,
		@li_cycleorder		= CycleOrder
	   FROM TPLANRELEASE_T
	 WHERE	PlanDate		= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode		= @ps_linecode
	   AND	ReleaseGubun		IN('T','U','Y')
	 ORDER BY	CycleOrder, ReleaseOrder ASC

	Insert #Tmp_Order Values(@li_loop_count, @ls_order_itemcode, @li_cycleorder)

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
END

-- ���� ����
SELECT	@li_row_count	= COUNT(ItemCode) 
  FROM	TPRDKB
 WHERE	PrdDate		= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode

-- ������� TABLE
Select	@li_loop_count		= 0,
	@ls_result_itemcode	= '',
	@li_prdorder		= 0
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count = @li_loop_count + 1
       	Set RowCount @li_loop_count 

	SELECT	@li_loop_count		= @li_loop_count,
		@ls_result_itemcode	= ItemCode,
		@li_prdorder		= PrdOrder
	   FROM	TPRDKB
	 WHERE	PrdDate			= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode		= @ps_linecode

	Insert #Tmp_Results Values(@li_loop_count, @ls_result_itemcode, @li_prdorder)

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
END

SELECT	@li_row_count	= COUNT(ItemCode) 
  FROM	TPLANRELEASE_T
 WHERE	PlanDate	= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode
   AND	ReleaseGubun	IN('T','U','Y')

-- HIT COUNT
Select	@li_loop_count = 0, @li_hitcount = 0
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count = @li_loop_count + 1

	-- ���ü���
	SELECT	@ls_order_itemcode	= Order_ItemCode,
		@li_cycleorder		= CycleOrder
	  FROM	#Tmp_Order
	WHERE	Order_no		= @li_loop_count

	-- �������
	SELECT	@ls_result_itemcode	= Result_ItemCode,
		@li_prdorder		= PrdOrder
	  FROM	#Tmp_Results
	WHERE	Result_no		= @li_loop_count

	-- ���ü����� ������� ��
	IF	@ls_present_itemcode	= @ls_order_itemcode	AND
		@ls_present_itemcode	= @ls_result_itemcode
	BEGIN
		SELECT	@li_hitcount	= @li_hitcount + 1
	END
END

-- ���ڵ� ī���� �ʱ�ȭ
Set RowCount 0

SELECT	@li_row_count	= COUNT(ItemCode)
  FROM	TPRDRATECYCLE_T
WHERE	PrdDate		= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode
   AND	ItemCode	= @ls_present_itemcode

-- ���� ���� ���� üũ
IF @li_row_count > 0
Begin
	-- ���� �߰�
	UPDATE	TPRDRATECYCLE_T
	   SET	HitCount		= @li_hitcount,
		LastEmp		= 'Y',
		LastDate		= @ldt_systemtime
	 WHERE	PrdDate		= @ls_applydate_close
	   AND	AreaCode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	WorkCenter	= @ps_workcenter
	   AND	LineCode	= @ps_linecode
	   AND	ItemCode	= @ls_present_itemcode

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
End
ELSE
Begin
	-- �ű� ����
	INSERT INTO TPRDRATECYCLE_T
	VALUES
			(@ls_applydate_close,
			 @ps_areacode,
			 @ps_divisioncode,
			 @ps_workcenter,
			 @ps_linecode,
			 @ls_present_itemcode,
			 @li_kb_count,
			 @li_hitcount,
			 'Y',
			 @ldt_systemtime)
	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
End

-- TMP TABLE ����
DROP TABLE #Tmp_Order
DROP TABLE #Tmp_Results

/*########################################################################################

	Lot No �̷�

########################################################################################*/
	
SELECT	@li_row_count	= COUNT(ItemCode)
  FROM	TLOTNO
 WHERE	TraceDate	= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	LotNo		= @ls_lotno
   AND	ItemCode	= @ls_present_itemcode
   AND	CustCode	= 'XXXXXX'
   AND	ShipGubun	= 'X'

-- �ű�, ���� ����Ÿ üũ
IF @li_row_count > 0
BEGIN
	-- ��� �߰����� üũ
	IF @ls_inspectgubun	= 'N'	AND
	    @ls_stockgubun	= 'N'
	BEGIN
		-- ���� �Ϸ� �� ��� â�� �԰�
		UPDATE	TLOTNO
		      SET	PrdQty		= PrdQty	+ @li_rackqty,
			StockQty		= StockQty	+ @li_rackqty,
			LastEmp		= 'Y',
			LastDate		= @ldt_systemtime
		 WHERE	TraceDate	= @ls_applydate_close
		   AND	AreaCode	= @ps_areacode
		   AND	DivisionCode	= @ps_divisioncode
		   AND	LotNo		= @ls_lotno
		   AND	ItemCode	= @ls_present_itemcode
		   AND	CustCode	= 'XXXXXX'
		   AND	ShipGubun	= 'X'

		-- ERROR üũ
		Select	@pi_err_code	= @pi_err_code + @@Error
	END
	ELSE
	BEGIN
		-- ���길 �Ϸ�
		UPDATE	TLOTNO
		      SET	PrdQty		= PrdQty	+ @li_rackqty,
			LastEmp		= 'Y',
			LastDate		= @ldt_systemtime
		 WHERE	TraceDate	= @ls_applydate_close
		   AND	AreaCode	= @ps_areacode
		   AND	DivisionCode	= @ps_divisioncode
		   AND	LotNo		= @ls_lotno
		   AND	ItemCode	= @ls_present_itemcode
		   AND	CustCode	= 'XXXXXX'
		   AND	ShipGubun	= 'X'

		-- ERROR üũ
		Select	@pi_err_code	= @pi_err_code + @@Error
	END
END
ELSE
BEGIN
	-- ��� �߰����� üũ
	IF @ls_inspectgubun	= 'N'	AND
	    @ls_stockgubun	= 'N'
	BEGIN
		-- ���� �Ϸ� �� ��� â�� �԰�
		INSERT INTO TLOTNO
		VALUES
				(@ls_applydate_close,
				 @ps_areacode,
				 @ps_divisioncode,
				 @ls_lotno,
				 @ls_present_itemcode,
				'XXXXXX',
				'X',
				'X',
				 @li_rackqty,
				 @li_rackqty,
				 0,
				 'Y',
				 @ldt_systemtime)
		-- ERROR üũ
		Select	@pi_err_code	= @pi_err_code + @@Error
	END
	ELSE
	BEGIN
		-- ���길 �Ϸ�
		INSERT INTO TLOTNO
		VALUES
				(@ls_applydate_close,
				 @ps_areacode,
				 @ps_divisioncode,
				 @ls_lotno,
				 @ls_present_itemcode,
				'XXXXXX',
				'X',
				'X',
				 @li_rackqty,
				 0,
				 0,
				 'Y',
				 @ldt_systemtime)
		-- ERROR üũ
		Select	@pi_err_code	= @pi_err_code + @@Error
	END
END

/*########################################################################################

	���� �̷�

########################################################################################*/

SELECT	@li_row_count	= COUNT(ItemCode)
  FROM	TPRD
 WHERE	PrdDate		= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode
   AND	ItemCode	= @ls_present_itemcode

IF @li_row_count > 0
BEGIN
	-- �����̷��� ���귮 ����
	UPDATE	TPRD
	      SET	PrdQty		= PrdQty + @li_rackqty,
		LastEmp		= 'Y',
		LastDate		= @ldt_systemtime
	 WHERE	PrdDate		= @ls_applydate_close
	   AND	AreaCode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	WorkCenter	= @ps_workcenter
	   AND	LineCode	= @ps_linecode
	   AND	ItemCode	= @ls_present_itemcode

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
END
ELSE
BEGIN
	-- �����̷��� ���ڵ� ����
	INSERT INTO TPRD
	VALUES
			(@ls_applydate_close,
			 @ps_areacode,
			 @ps_divisioncode,
			 @ps_workcenter,
			 @ps_linecode,
			 @ls_present_itemcode,
			 0,				-- ��ȹ����
			 @li_rackqty,
			 'Y',
			 @ldt_systemtime)
	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
END

/*########################################################################################

	ǰ�� CONTAINMENT �˻��� DATA�Է�

########################################################################################*/

IF @ls_inspectgubun = 'Y'
BEGIN
	-- ǰ���� ������ ��ǰ��, �𵨱��� �����´�
	SELECT	@ls_productgroup	= ProductGroup,   
		@ls_modelgroup		= ModelGroup  
	  FROM	TMSTMODEL
	 WHERE	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	ItemCode		= @ls_present_itemcode

	-- ���� üũ
	Set	@li_row_count		= 0
	SELECT	@li_row_count		= COUNT(KBNO)
	  FROM	TQCONTAINQCENTRY
	 WHERE	AREACODE		= @ps_areacode
	   AND	DIVISIONCODE		= @ps_divisioncode
	   AND	PRDENDDATE		= @ls_applydate_close
	   AND	KBNO			= @ps_kbno

	IF @li_row_count > 0
	BEGIN
		UPDATE	TQCONTAINQCENTRY
		SET	PRDENDTIME		= @ls_now_time + ':00',
			ITEMCODE		= @ls_present_itemcode,
			PRODUCTGROUP		= @ls_productgroup,
			MODELGROUP		= @ls_modelgroup,
			RACKQTY		= @li_rackqty,
			LastEmp			= 'Y',
			LastDate			= @ldt_systemtime
		 WHERE	AREACODE		= @ps_areacode
		   AND	DIVISIONCODE		= @ps_divisioncode
		   AND	PRDENDDATE		= @ls_applydate_close
		   AND	KBNO			= @ps_kbno
	END
	ELSE
	BEGIN

		INSERT INTO TQCONTAINQCENTRY
			VALUES
				(@ps_areacode,
				 @ps_divisioncode,
				 @ls_applydate_close,
				 @ps_kbno,
				 @ls_now_time + ':00',
				 @ls_present_itemcode,
				 @ls_productgroup,
				 @ls_modelgroup,
				 @li_rackqty,
				 0,
				 '1',
				 '',
				 '',
				 'Y',
				 @ldt_systemtime	)
	END

	-- ERROR üũ
	Select	@pi_err_code	= @pi_err_code + @@Error
END

-- ERROR ����
IF @pi_err_code = 0
BEGIN
	COMMIT		TRAN
END
ELSE
BEGIN
	ROLLBACK	TRAN
END

RETURN	@pi_err_code


------------------------------------------------------------------------------
End				-- Procedure End

GO
