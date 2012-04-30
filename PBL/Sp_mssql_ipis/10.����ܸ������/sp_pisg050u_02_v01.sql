/*##############################################################################*/
/*## File Name		: sp_pisg050u_02.SQL						##*/
/*## SYSTEM		: KDAC 대구공장 IPIS2000						##*/
/*## Procedure Name	: sp_pisg050u_02							##*/
/*## Description	: 현장관리의 조립순서							##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg050u_02							##*/
/*## Parameter		: @ps_plandate, @ps_areacode, @ps_divisioncode,			##*/
/*## Parameter		: @ps_workcenter, @ps_linecode					##*/
/*## Use Table		: TKB, TMSTKB, TPLANRELEASE					##*/
/*## Initial		: 2002. 09. 12							##*/
/*## Last Change	: 2003. 01. 13							##*/
/*## Author		: 최선배								##*/
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
	@ps_areacode		char(1),			-- 지역코드
	@ps_divisioncode	char(1),			-- 공장코드
	@ps_workcenter		char(5),			-- 조
	@ps_linecode		char(1),			-- 라인코드
	@ps_kbno		varchar(11),		-- 간판번호
	@ps_com_code		varchar(15),		-- 단말기 코드
	@pi_err_code		INT	OUTPUT		-- ERROR 코드
As
Begin				-- Procedure Start
------------------------------------------------------------------------------

Begin	TRAN

Declare	@ldt_systemtime		DateTime,	-- 현재 DATETIME
	@ls_applydate		char(10),	-- 마감을 적용안한 날자
	@ls_lastdate		char(10),	-- 각달의 마지막 날자
	@ls_applymonth		char(08),	-- 현재 년,월
	@ls_applydate_close	char(10),	-- 마감을 적용한 날자
	@ls_now_time		char(5),		-- 현재 시간
	@ls_shift			char(1),		-- 주/야 구분
	@ls_lotno		varchar(6),	-- LOTNO
	@ls_present_itemcode	varchar(12),	-- 현재 간판의 품번
	@li_rackqty		int,		-- 수용수
	@ls_inspectgubun	char(1),		-- 입고 구분
	@ls_stockgubun		char(1),		-- 창고 등록 구분
	@ls_kbreleasedate	char(10),	-- 조립지시 일자
	@ls_krbeleaseseq	int,		-- 조립지시 Sequenc
	@li_present_cycleorder	int,		-- 현재 간판의 조립지시 순서
	@li_present_releaseorder	int,		-- 현재 간판의 조립지시 순서(간판)
	@li_min_cycleorder	int,		-- 미완료분중 최소 조립지시 순서
	@li_min_releaseorder	int,		-- 미완료분중 최소 조립지시 순서(간판)
	@ls_applyfrom		char(10),	-- 마스타적용 시작일
	@ls_timecode		char(10),	-- 시간 코드
	@li_row_count		int,		-- DATA COUNT
	@ldt_tprdkb_lastdate	datetime,	-- 마지막 실적등록 시간
	@li_prdorder		int,		-- 생산 순서
	@li_prdkborder		int,		-- 생산 순서(간판)
	@ls_before_itemcode	varchar(12),	-- 이전 조립 완료한 품번
	@li_kb_count		int,		-- 간판수
	@li_loop_count		int,		-- LOOT COUNT
	@ls_order_itemcode	varchar(12),	-- 지시한 품번
	@ls_result_itemcode	varchar(12),	-- 완료한 품번
	@li_cycleorder		int,		-- 지시순서
	@li_hitcount		int,		-- 매칭수
	@ls_productgroup	char(2),		-- 제품군
	@ls_modelgroup		char(3),		-- 모델군
	@ls_kbstatuscode	char(1)		-- 간판 상태

/*########################################################################################

	ERROR FLAG 초기화

########################################################################################*/

SELECT	@pi_err_code = 0

/*########################################################################################

	시스템 시간

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

	기본정보

########################################################################################*/

-- 조립지시일자, 조립지시 SEQ
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

-- 입고구분, 창고구분
SELECT	@ls_kbstatuscode	= KBStatusCode,
	@ls_inspectgubun	= InspectGubun,
	@ls_stockgubun		= StockGubun
  FROM	TKB
 WHERE	KBNo			= @ps_kbno

/*########################################################################################
	
	조립지시 순서 변경및 간판상태 변경
	
########################################################################################*/
	
-- 최소 지시순서
SELECT	@li_min_cycleorder	= MIN(CycleOrder)
  FROM	TPLANRELEASE
 WHERE	PlanDate		= @ls_applydate_close
   AND	AreaCode		= @ps_areacode
   AND	DivisionCode		= @ps_divisioncode
   AND	WorkCenter		= @ps_workcenter
   AND	LineCode 		= @ps_linecode
   AND	ItemCode 		= @ls_present_itemcode
   AND	PrdFlag	 		= 'N' 

-- 최소 지시순서간판
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
	-- 간판정보 조립완료로 변경
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END
ELSE
BEGIN
	-- 최소 지시순서를 9999로 임시 변경
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error

	-- 현 지시순서를 최소 지시순서로 변경
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
	
	-- 최소 지시순서를 현 지시순서로 변경
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END
	
/*########################################################################################

	시간대별 생산계획(월마감을 적용한 시점)

########################################################################################*/
	
-- 마스타 적용일 및 TimeCode
SELECT	@ls_applyfrom			= ApplyFrom,
	@ls_timecode			= TimeCode
  FROM	TMSTTIME
 WHERE	AreaCode			=   @ps_areacode
   AND	DivisionCode			=   @ps_divisioncode
   AND	ApplyFrom			<= @ls_applydate
   AND	ApplyTo				>= @ls_applydate
   AND	CONVERT(Char(5),TimeStart,108)	<= @ls_now_time
   AND	CONVERT(Char(5),TimeEnd,108)	>= @ls_now_time

-- COUNT 체크
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
	-- 시간대별 생산계획의 생산량 증가
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END
ELSE
BEGIN
	-- 시간대별 생산계획의 레코드 생성
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
	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END
	
/*########################################################################################

	생산완료, 창고입고 체크

########################################################################################*/
	
IF @ls_inspectgubun	= 'N'	AND
    @ls_stockgubun	= 'N'

-- 창고 입고
BEGIN
	-- 간판 StatusCode 셋팅
	SELECT @ls_kbstatuscode = 'D'

	-- 개별 간판 현황
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error

	-- 간판 이력
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error

	-- 기존 재고 체크
	SELECT	@li_row_count	= COUNT(ItemCode)
	  FROM	TINV
	 WHERE	Areacode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	ItemCode	= @ls_present_itemcode

	IF @li_row_count > 0
	BEGIN
		-- 기존재고에 추가
		UPDATE	TINV
		SET	InvQty		= InvQty + @li_rackqty,
			LastEmp		= 'Y',
			LastDate		= @ldt_systemtime
		 WHERE	Areacode	= @ps_areacode
		   AND	DivisionCode	= @ps_divisioncode
		   AND	ItemCode	= @ls_present_itemcode

		-- ERROR 체크
		Select	@pi_err_code	= @pi_err_code + @@Error
	END
	ELSE
	BEGIN
		-- 재고 생성
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
		-- ERROR 체크
		Select	@pi_err_code	= @pi_err_code + @@Error
	END

	-- TSTOCK_INTERFACE 레코드 카운터
	SELECT	@li_row_count	= MAX(SeqNo)
	  FROM	TSTOCK_INTERFACE
	 WHERE	KBNo		= @ps_kbno
	   AND	KBReleaseDate	= @ls_kbreleasedate
	   AND	KBReleaseSeq	= @ls_krbeleaseseq
	   AND	MISFlag		= 'A'

	-- NULL 체크
	IF @li_row_count IS NULL
	BEGIN
		SELECT @li_row_count = 1
	END
	ELSE
	BEGIN
		SELECT @li_row_count = @li_row_count + 1
	END

	-- TSTOCK_INTERFACE의 SeqNo를 증가하여 신규 레코드 생성
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
	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END
ELSE

-- 생산 완료
BEGIN
	-- 간판 STATUSCODE 셋팅
	SELECT @ls_kbstatuscode = 'C'

	-- 개별 간판 현황
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error

	-- 간판 이력
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END
	
/*########################################################################################

	조립실적 등록

########################################################################################*/
	
-- 초기화
SELECT @ldt_tprdkb_lastdate = NULL

-- 기존 레코드 체크
SELECT	@li_row_count		= count(KBNo)
  FROM	TPRDKB
 WHERE	PrdDate			= @ls_applydate_close
   AND	AreaCode		= @ps_areacode
   AND	DivisionCode		= @ps_divisioncode
   AND	WorkCenter		= @ps_workcenter
   AND	LineCode 		= @ps_linecode

IF @li_row_count < 1
BEGIN
	-- 생산순서를 최초로...
	SELECT	@li_prdorder	= 1,
		@li_prdkborder	= 1
END
ELSE
BEGIN
	-- 마지막으로 입력된 조립실적의 시간을 읽어온다.
	SELECT	@ldt_tprdkb_lastdate	= MAX(LastDate)
	  FROM	TPRDKB
	 WHERE	PrdDate			= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode 		= @ps_linecode

	-- 마지막 완료한 품번과 순서를 가져온다.
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

	-- 이전실적의 품번과 현재의 품번 비교
	IF @ls_present_itemcode	= @ls_before_itemcode
	BEGIN
		-- 완료 순서(간판) 
		SELECT	@li_prdkborder	= @li_prdkborder + 1
	END
	ELSE
	BEGIN
		-- 완료 순서
		SELECT	@li_prdorder	= @li_prdorder + 1,
			@li_prdkborder	= 1
	END
END

-- 생산실적 등록
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
-- ERROR 체크
Select	@pi_err_code	= @pi_err_code + @@Error
	
/*########################################################################################

	간판 준수율

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

-- 기존 존재 유무 체크
Set @li_kb_count = 0
IF @li_row_count < 1
Begin
	-- 지시매수
	SELECT	@li_kb_count		= COUNT(ItemCode)
	  FROM	TPLANRELEASE
	 WHERE	PlanDate		= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode		= @ps_linecode
	   AND	ItemCode		= @ls_present_itemcode
	   AND	ReleaseGubun		IN ( 'Y', 'T','U')

	-- 신규 생성
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
	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
End
ELSE
Begin
	-- 기존추가
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
End

/*########################################################################################

	확정 간판 준수율

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

-- 기존 존재 유무 체크
Set @li_kb_count = 0
IF @li_row_count	< 1
Begin
	-- 지시매수
	SELECT	@li_kb_count		= COUNT(ItemCode)
	  FROM	TPLANRELEASE_T
	 WHERE	PlanDate		= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode		= @ps_linecode
	   AND	ItemCode		= @ls_present_itemcode
	   AND	ReleaseGubun		IN ( 'Y', 'T','U')

	-- 신규 생성
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
	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
End
ELSE
Begin
	-- 기존추가
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
End

/*########################################################################################

	평준화 순서 준수율

########################################################################################*/
	
-- 조립지시 TABLE 생성
Create Table #Tmp_Order
(
	Order_no		int,
	Order_ItemCode		Char(12),
	CycleOrder		int
)	

-- 조립실적 TABLE 생성
Create Table #Tmp_Results
(
	Result_no		int,
	Result_ItemCode	Char(12),
	PrdOrder		int
)	

-- 조립지시순서
Set @li_row_count = 0
SELECT	@li_row_count	= COUNT(ItemCode) 
  FROM	TPLANRELEASE
 WHERE	PlanDate	= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode
   AND	ReleaseGubun	IN('T','U','Y')

-- 조립지시 TABLE
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END

-- 생산 순서
SELECT	@li_row_count	= COUNT(ItemCode) 
  FROM	TPRDKB
 WHERE	PrdDate		= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode

-- 생산순서 TABLE
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END

-- 레코드 카운터 초기화
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

	-- 지시순서
	SELECT	@ls_order_itemcode	= Order_ItemCode,
		@li_cycleorder		= CycleOrder
	  FROM	#Tmp_Order
	WHERE	Order_no		= @li_loop_count

	-- 생산순서
	SELECT	@ls_result_itemcode	= Result_ItemCode,
		@li_prdorder		= PrdOrder
	  FROM	#Tmp_Results
	WHERE	Result_no		= @li_loop_count

	-- 지시순서와 생산순서 비교
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

-- 기존 존재 유무 체크
IF @li_row_count > 0
Begin
	-- 기존 추가
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
End
ELSE
Begin
	-- 신규 생성
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
	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
End

-- TMP TABLE 초기화
TRUNCATE TABLE #Tmp_Order
TRUNCATE TABLE #Tmp_Results

/*########################################################################################

	확정 평준화 순서 준수율

########################################################################################*/

-- 조립지시순서
SELECT	@li_row_count	= COUNT(ItemCode) 
  FROM	TPLANRELEASE_T
 WHERE	PlanDate	= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode
   AND	ReleaseGubun	IN('T','U','Y')

Select	@li_loop_count = 0

-- 조립지시 TABLE
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END

-- 생산 순서
SELECT	@li_row_count	= COUNT(ItemCode) 
  FROM	TPRDKB
 WHERE	PrdDate		= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode

-- 생산순서 TABLE
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

	-- ERROR 체크
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

	-- 지시순서
	SELECT	@ls_order_itemcode	= Order_ItemCode,
		@li_cycleorder		= CycleOrder
	  FROM	#Tmp_Order
	WHERE	Order_no		= @li_loop_count

	-- 생산순서
	SELECT	@ls_result_itemcode	= Result_ItemCode,
		@li_prdorder		= PrdOrder
	  FROM	#Tmp_Results
	WHERE	Result_no		= @li_loop_count

	-- 지시순서와 생산순서 비교
	IF	@ls_present_itemcode	= @ls_order_itemcode	AND
		@ls_present_itemcode	= @ls_result_itemcode
	BEGIN
		SELECT	@li_hitcount	= @li_hitcount + 1
	END
END

-- 레코드 카운터 초기화
Set RowCount 0

SELECT	@li_row_count	= COUNT(ItemCode)
  FROM	TPRDRATECYCLE_T
WHERE	PrdDate		= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode
   AND	ItemCode	= @ls_present_itemcode

-- 기존 존재 유무 체크
IF @li_row_count > 0
Begin
	-- 기존 추가
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
End
ELSE
Begin
	-- 신규 생성
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
	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
End

-- TMP TABLE 삭제
DROP TABLE #Tmp_Order
DROP TABLE #Tmp_Results

/*########################################################################################

	Lot No 이력

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

-- 신규, 기존 데이타 체크
IF @li_row_count > 0
BEGIN
	-- 재고에 추가여부 체크
	IF @ls_inspectgubun	= 'N'	AND
	    @ls_stockgubun	= 'N'
	BEGIN
		-- 생산 완료 후 즉시 창고 입고
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

		-- ERROR 체크
		Select	@pi_err_code	= @pi_err_code + @@Error
	END
	ELSE
	BEGIN
		-- 생산만 완료
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

		-- ERROR 체크
		Select	@pi_err_code	= @pi_err_code + @@Error
	END
END
ELSE
BEGIN
	-- 재고에 추가여부 체크
	IF @ls_inspectgubun	= 'N'	AND
	    @ls_stockgubun	= 'N'
	BEGIN
		-- 생산 완료 후 즉시 창고 입고
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
		-- ERROR 체크
		Select	@pi_err_code	= @pi_err_code + @@Error
	END
	ELSE
	BEGIN
		-- 생산만 완료
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
		-- ERROR 체크
		Select	@pi_err_code	= @pi_err_code + @@Error
	END
END

/*########################################################################################

	생산 이력

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
	-- 생산이력의 생산량 증가
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END
ELSE
BEGIN
	-- 생산이력의 레코드 생성
	INSERT INTO TPRD
	VALUES
			(@ls_applydate_close,
			 @ps_areacode,
			 @ps_divisioncode,
			 @ps_workcenter,
			 @ps_linecode,
			 @ls_present_itemcode,
			 0,				-- 게획수량
			 @li_rackqty,
			 'Y',
			 @ldt_systemtime)
	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END

/*########################################################################################

	품질 CONTAINMENT 검사등록 DATA입력

########################################################################################*/

IF @ls_inspectgubun = 'Y'
BEGIN
	-- 품번을 가지고 제품군, 모델군을 가져온다
	SELECT	@ls_productgroup	= ProductGroup,   
		@ls_modelgroup		= ModelGroup  
	  FROM	TMSTMODEL
	 WHERE	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	ItemCode		= @ls_present_itemcode

	-- 기존 체크
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

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END

-- ERROR 결정
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
