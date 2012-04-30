/*##############################################################################*/
/*## File Name		: sp_pisg070u_02.SQL						##*/
/*## SYSTEM		: KDAC 대구공장 IPIS2000						##*/
/*## Procedure Name	: sp_pisg070u_02							##*/
/*## Description	: 현장관리의 조립순서							##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg070u_02							##*/
/*## Parameter		: @ps_plandate, @ps_areacode, @ps_divisioncode,			##*/
/*## Parameter		: @ps_workcenter, @ps_linecode					##*/
/*## Use Table		: TKB, TMSTKB, TPLANRELEASE					##*/
/*## Initial		: 2002. 09. 12							##*/
/*## Last Change	: 2002. 12. 05							##*/
/*## Author		: 최선배								##*/
/*##############################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg070u_02'))
	Drop Procedure sp_pisg070u_02
Go

/*
EXEC	sp_pisg070u_02
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A',
	@ps_kbno		= 'DA010003011',
	@ps_com_code		= 'ABS001',
	@pi_err_code		= 0
*/

Create Procedure sp_pisg070u_02
	@ps_areacode		char(1),		-- 지역코드
	@ps_divisioncode	char(1),		-- 공장코드
	@ps_workcenter		char(5),		-- 조
	@ps_linecode		char(1),		-- 라인코드
	@ps_kbno		varchar(11),	-- 간판번호
	@ps_com_code		varchar(15),	-- 단말기 코드
	@pi_err_code		int	output	-- ERROR CODE
As
Begin

------------------------------------------------------------------------------

Begin	TRAN

Declare	@ldt_kb_endtime		DateTime,	-- 실적등록 완료한 DATETIME
	@ls_applydate		char(10),	-- 마감을 적용안한 날자
	@ls_applydate_close	char(10),	-- 마감을 적용한 날자
	@ls_now_time		char(5),		-- 현재 시간
	@ls_present_itemcode	varchar(12),	-- 현재 간판의 품번
	@li_rackqty		int,		-- 수용수
	@ls_inspectgubun	char(1),		-- 입고 구분
	@ls_stockgubun		char(1),		-- 창고 등록 구분
	@ls_kbreleasedate	char(10),	-- 조립지시 일자
	@ls_krbeleaseseq	int,		-- 조립지시 Sequenc
	@ls_lotno		varchar(6),	-- LOTNO
	@li_present_prdorder	int,		-- 생산순서
	@li_present_prdkborder	int,		-- 생산순서(간판)
	@li_row_count		int,		-- 레코드 카운터
	@li_loop_count		int,		-- LOOP COUNT
	@li_present_cycleorder	int,		-- 현재 지시 순서
	@li_present_releaseorder	int,		-- 현재 지시 순서(간판)
	@li_max_cycleorder	int,		-- 최대 지시 순서
	@li_max_releaseorder	int,		-- 최대 지시 순서(간판)
	@li_before_tmp_cycle	int,		-- 이전 지시 순서
	@li_before_tmp_release	int,		-- 이전 지시 순서(간판)
	@li_now_tmp_cycle	int,		-- 비교 대상 지시 순서
	@li_now_tmp_release	int,		-- 비교 대상 지시 순서(간판)
	@li_location		int,
	@ldt_systemtime		DateTime	-- 현재 시간

/*########################################################################################

	간판 완료 시간 및 정보

########################################################################################*/

SELECT	@ls_inspectgubun	= InspectGubun,
	@ls_stockgubun		= StockGubun,
	@ls_lotno		= LotNo,
	@ldt_kb_endtime		= KBEndTime
  FROM	TKB
 WHERE	KBNo			= @ps_kbno
   AND	AreaCode		= @ps_areacode
   AND	DivisionCode		= @ps_divisioncode
   AND	WorkCenter		= @ps_workcenter
   AND	LineCode		= @ps_linecode

/*########################################################################################

	시스템 시간

########################################################################################*/

SELECT	@ldt_systemtime = GETDATE()

EXEC	sp_pisc_get_applydate_close
	@ps_areacode,
	@ps_divisioncode,
	@ldt_kb_endtime,
	@ls_applydate_close	output

EXEC	sp_pisc_get_applydate
	@ps_areacode,
	@ps_divisioncode,
	@ldt_kb_endtime,
	@ls_applydate		output

SELECT @ls_now_time = CONVERT(char(5), @ldt_kb_endtime, 108)

/*########################################################################################

	기본정보

########################################################################################*/

-- 조립지시일자, 조립지시 SEQ
SELECT	@ls_present_itemcode	= ItemCode,
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

Select	@pi_err_code	= 0

/*########################################################################################

	실적 삭제

########################################################################################*/

-- 삭제할 간판의 생산순서
SELECT	@li_present_prdorder	= PrdOrder,
	@li_present_prdkborder	= PrdKBOrder
  FROM	TPRDKB
 WHERE	PrdDate			= @ls_applydate_close
   AND	AreaCode		= @ps_areacode
   AND	DivisionCode		= @ps_divisioncode
   AND	WorkCenter		= @ps_workcenter
   AND	LineCode 		= @ps_linecode
   AND	ItemCode		= @ls_present_itemcode
   AND	KBNo			= @ps_kbno

-- 레코드 카운터
SELECT	@li_row_count		= COUNT(PrdKBOrder)
  FROM	TPRDKB
 WHERE	PrdDate			= @ls_applydate_close
   AND	AreaCode		= @ps_areacode
   AND	DivisionCode		= @ps_divisioncode
   AND	WorkCenter		= @ps_workcenter
   AND	LineCode 		= @ps_linecode
   AND	ItemCode		= @ls_present_itemcode
   AND	PrdOrder		= @li_present_prdorder

-- 해당 레코드 삭제
DELETE	
  FROM	TPRDKB
WHERE	PrdDate			= @ls_applydate_close
   AND	AreaCode		= @ps_areacode
   AND	DivisionCode		= @ps_divisioncode
   AND	WorkCenter		= @ps_workcenter
   AND	LineCode 		= @ps_linecode
   AND	PrdOrder 		= @li_present_prdorder
   AND	PrdKBOrder 		= @li_present_prdkborder

-- ERROR 체크
Select	@pi_err_code	= @pi_err_code + @@Error

Select	@li_loop_count = @li_present_prdkborder
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count	= @li_loop_count + 1

	UPDATE	TPRDKB
	   SET	PrdKBOrder	= @li_loop_count - 1
	 WHERE	PrdDate		= @ls_applydate_close
	   AND	AreaCode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	WorkCenter	= @ps_workcenter
	   AND	LineCode 	= @ps_linecode
	   AND	PrdOrder	= @li_present_prdorder
	   AND	PrdKBOrder 	= @li_loop_count

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END

/*########################################################################################

	조립지시 순서 변경 및 간판 상태 변경

########################################################################################*/

Create Table #Tmp_Order_Change
(
	Order_no		int,
	CycleOrder		int,
	ReleaseOrder		INT
)	

-- 현재 조립지시순서
SELECT	@li_present_cycleorder	= CycleOrder,
	@li_present_releaseorder	= ReleaseOrder
  FROM	TPLANRELEASE
 WHERE	PlanDate		= @ls_applydate_close
   AND	AreaCode		= @ps_areacode
   AND	DivisionCode		= @ps_divisioncode
   AND	WorkCenter		= @ps_workcenter
   AND	LineCode 		= @ps_linecode
   AND	ItemCode		= @ls_present_itemcode
   AND	KBNo			= @ps_kbno

-- 완료 중 최대 조립지시 순서
SELECT	@li_max_cycleorder	= MAX(CycleOrder)
  FROM	TPLANRELEASE
 WHERE	PlanDate		= @ls_applydate_close
   AND	AreaCode		= @ps_areacode
   AND	DivisionCode		= @ps_divisioncode
   AND	WorkCenter		= @ps_workcenter
   AND	LineCode 		= @ps_linecode
   AND	ItemCode		= @ls_present_itemcode
   AND	PrdFlag			= 'E'

-- 완료 중 최대 조립지시 순서(간판)
SELECT	@li_max_releaseorder	= MAX(ReleaseOrder)
  FROM	TPLANRELEASE
 WHERE	PlanDate		= @ls_applydate_close
   AND	AreaCode		= @ps_areacode
   AND	DivisionCode		= @ps_divisioncode
   AND	WorkCenter		= @ps_workcenter
   AND	LineCode 		= @ps_linecode
   AND	CycleOrder 		= @li_max_cycleorder
   AND	ItemCode		= @ls_present_itemcode
   AND	PrdFlag			= 'E'

-- 레코드 COUNT
SELECT	@li_row_count		= COUNT(ReleaseOrder)
  FROM	TPLANRELEASE
 WHERE	PlanDate		= @ls_applydate_close
   AND	AreaCode		= @ps_areacode
   AND	DivisionCode		= @ps_divisioncode
   AND	WorkCenter		= @ps_workcenter
   AND	LineCode 		= @ps_linecode
   AND	ItemCode		= @ls_present_itemcode
   AND	PrdFlag			= 'E'

-- 초기화
Select	@li_loop_count = 0

-- TMP TABLE에 INSERT
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count = @li_loop_count + 1
       	Set RowCount @li_loop_count

	SELECT	@li_now_tmp_cycle	= CycleOrder,
		@li_now_tmp_release	= ReleaseOrder
	  FROM	TPLANRELEASE
	 WHERE	PlanDate		= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode 		= @ps_linecode
	   AND	ItemCode		= @ls_present_itemcode
	   AND	PrdFlag			= 'E'
	 ORDER BY	CycleOrder, ReleaseOrder ASC

	Insert #Tmp_Order_Change Values(@li_loop_count, @li_now_tmp_cycle, @li_now_tmp_release)

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END

-- 레코드 카운터 초기화
Set RowCount 0

-- 현재 간판을 임시로 9999로 변경
UPDATE	TPLANRELEASE
   SET	CycleOrder	= 9999,
	ReleaseOrder	= 9999
 WHERE	PlanDate	= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode 	= @ps_linecode
   AND	CycleOrder	= @li_present_cycleorder
   AND	ReleaseOrder 	= @li_present_releaseorder

-- ERROR 체크
Select	@pi_err_code	= @pi_err_code + @@Error

-- 위치 찾기
Select	@li_loop_count = 0
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count = @li_loop_count + 1

	SELECT	@li_now_tmp_cycle	= CycleOrder,
		@li_now_tmp_release	= ReleaseOrder
	  FROM	#Tmp_Order_Change
	WHERE	Order_no		= @li_loop_count
	 ORDER BY	CycleOrder, ReleaseOrder ASC

	IF @li_present_cycleorder		= @li_now_tmp_cycle	AND
	    @li_present_releaseorder	= @li_now_tmp_release
	BEGIN
		SELECT	@li_location	= @li_loop_count
	END
END

-- 찾은 위치 다음 레코드부터 지시 순서 일괄 처리
Select	@li_loop_count	= @li_location
While 	@li_loop_count	< @li_row_count
BEGIN
	SELECT	@li_before_tmp_cycle	= CycleOrder,
		@li_before_tmp_release	= ReleaseOrder
	  FROM	#Tmp_Order_Change
	 WHERE	Order_no		= @li_loop_count
	 ORDER BY	CycleOrder, ReleaseOrder ASC

	SET @li_loop_count = @li_loop_count + 1

	SELECT	@li_now_tmp_cycle	= CycleOrder,
		@li_now_tmp_release	= ReleaseOrder
	  FROM	#Tmp_Order_Change
	 WHERE	Order_no		= @li_loop_count
	 ORDER BY	CycleOrder, ReleaseOrder ASC

	-- 지시순서 일관변경
	UPDATE	TPLANRELEASE
	   SET	CycleOrder	= @li_before_tmp_cycle,
		ReleaseOrder	= @li_before_tmp_release
	 WHERE	PlanDate	= @ls_applydate_close
	   AND	AreaCode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	WorkCenter	= @ps_workcenter
	   AND	LineCode 	= @ps_linecode
	   AND	CycleOrder	= @li_now_tmp_cycle
	   AND	ReleaseOrder 	= @li_now_tmp_release

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END

-- 임시변경한 현 간판의 조립지시 순서변경
UPDATE	TPLANRELEASE
   SET	CycleOrder	= @li_max_cycleorder,
	ReleaseOrder	= @li_max_releaseorder,
	PrdFlag		= 'N',
	LastEmp		= 'Y',
	LastDate		= @ldt_systemtime
 WHERE	PlanDate	= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode 	= @ps_linecode
   AND	CycleOrder	= 9999
   AND	ReleaseOrder 	= 9999

-- ERROR 체크
Select	@pi_err_code	= @pi_err_code + @@Error

DROP TABLE #Tmp_Order_Change

/*########################################################################################

	시간대별 생산계획 감산

########################################################################################*/

Declare	@ls_applyfrom		char(10),	-- 마스타 적용 시작일
	@ls_timecode		char(05)		-- 시간 코드
--	@ls_lastdate		char(10),	-- 각달의 마지막 날자
--	@ls_applymonth		char(08)		-- 현재 년,월

-- 마감일 정보
--Select	@ls_applymonth	= SUBSTRING(@ls_applydate,1,8)
--Select	@ls_lastdate	= 
--	Convert(Char(8), DateAdd(DD, -1, DateAdd(MM, 1, Convert(DateTime, @ls_applymonth + '01'))), 112)

--IF @ls_lastdate = @ls_applydate	AND
--	@ls_now_time >= '20:00'
--BEGIN
	-- 일자와 시간을 다음날 아침 8:00로 한다.
--	SELECT @ls_applydate	= CONVERT(CHAR(10), DATEADD(day, 1, @ldt_systemtime), 102)
--	SELECT @ls_now_time	= '08:00'
--END

-- 마스타 적용 시작일
SELECT	@ls_applyfrom			= ApplyFrom,
	@ls_timecode			= TimeCode
  FROM	TMSTTIME
 WHERE	AreaCode			=   @ps_areacode
   AND	DivisionCode			=   @ps_divisioncode
   AND	ApplyFrom			<= @ls_applydate
   AND	ApplyTo				>= @ls_applydate
   AND	CONVERT(Char(5),TimeStart,108)	<= @ls_now_time
   AND	CONVERT(Char(5),TimeEnd,108)	>= @ls_now_time

-- TPRDTIME TABLE의 생산량 감소
UPDATE	TPRDTIME
   SET	PrdQty		= PrdQty - @li_rackqty,
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

/*########################################################################################

	간판 현황

########################################################################################*/

UPDATE	TKB
   SET	KBStatusCode		= 'A',
	PrdFlag			= 'N',
	InspectFlag		= NULL,
	PrdDate			= NULL,
	PrdAreaCode		= NULL,
	PrdDivisionCode		= NULL,
	PrdWorkCenter		= NULL,
	PrdLineCode		= NULL,
	TimeApplyFrom		= NULL,
	TimeCode		= NULL,
	PrdQty			= 0,
	LotNo			= NULL,
	StockDate		= NULL,
	StockQty			= 0,
	KBStartTime		= NULL,
	KBEndTime		= NULL,
	KBStockTime		= NULL,
	LastEmp			= 'Y',
	LastDate			= @ldt_systemtime
WHERE	KBNo			= @ps_kbno
   AND	KBActiveGubun		= 'A'
   AND	PrdFlag			= 'E'

-- ERROR 체크
Select	@pi_err_code	= @pi_err_code + @@Error

/*########################################################################################

	간판 이력

########################################################################################*/

UPDATE	TKBHIS
   SET	KBStatusCode		= 'A',
	PrdFlag			= 'N',
	InspectFlag		= NULL,
	PrdDate			= NULL,
	PrdAreaCode		= NULL,
	PrdDivisionCode		= NULL,
	PrdWorkCenter		= NULL,
	PrdLineCode		= NULL,
	TimeApplyFrom		= NULL,
	TimeCode		= NULL,
	PrdQty			= 0,
	LotNo			= NULL,
	StockDate		= NULL,
	StockQty			= 0,
	KBStartTime		= NULL,
	KBEndTime		= NULL,
	KBStockTime		= NULL,
	LastEmp			= 'Y',
	LastDate			= @ldt_systemtime
WHERE	KBNo			= @ps_kbno
   AND	LastLoopFlag		= 'Y'
   AND	KBActiveGubun		= 'A'
   AND	PrdFlag			= 'E'

-- ERROR 체크
Select	@pi_err_code	= @pi_err_code + @@Error

/*########################################################################################

	재고 현황

########################################################################################*/

-- 입고 구분 체크
IF @ls_inspectgubun	= 'N'	AND
    @ls_stockgubun	= 'N'
BEGIN
	UPDATE	TINV
	   SET	InvQty		= InvQty - @li_rackqty,
		LastEmp		= 'Y',
		LastDate		= @ldt_systemtime
	WHERE	Areacode	= @ps_areacode
	   AND	DivisionCode	= @ps_divisioncode
	   AND	ItemCode	= @ls_present_itemcode

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error

	-- TSTOCK_INTERFACE 레코드 카운터
	SELECT	@li_row_count	= MAX(SeqNo)
	  FROM	TSTOCK_INTERFACE
	 WHERE	KBNo		= @ps_kbno
	   AND	KBReleaseDate	= @ls_kbreleasedate
	   AND	KBReleaseSeq	= @ls_krbeleaseseq
	   AND	MISFlag		= 'D'

	-- NULL 체크
	IF @li_row_count IS NULL or @li_row_count = 0
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
			 'D',
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

/*########################################################################################

	간판 준수율

########################################################################################*/

UPDATE	TPRDRATEKB
   SET	PrdCount	= PrdCount - 1,
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

/*########################################################################################

	확정 간판 준수율

########################################################################################*/

UPDATE	TPRDRATEKB_T
   SET	PrdCount	= PrdCount - 1,
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

/*########################################################################################

	평준화 순서 준수율

########################################################################################*/

Declare	@ls_order_itemcode	varchar(12),	-- 지시 품번
	@ls_result_itemcode	varchar(12),	-- 생산 품번
	@li_hitcount		int		-- 매칭 수량

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
	Result_ItemCode		Char(12),
	PrdOrder		int
)	

-- 조립지시순서
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
	@li_present_cycleorder	= 0
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count = @li_loop_count + 1
       	Set RowCount @li_loop_count 

	SELECT	@li_loop_count		= @li_loop_count,
		@ls_order_itemcode	= ItemCode,
		@li_present_cycleorder	= CycleOrder
	   FROM TPLANRELEASE
	 WHERE	PlanDate		= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode		= @ps_linecode
	   AND	ReleaseGubun		IN('T','U','Y')
	 ORDER BY	CycleOrder, ReleaseOrder ASC

	Insert #Tmp_Order Values(@li_loop_count, @ls_order_itemcode, @li_present_cycleorder)

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
	@li_present_prdorder	= 0
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count = @li_loop_count + 1
       	Set RowCount @li_loop_count 

	SELECT	@li_loop_count		= @li_loop_count,
		@ls_result_itemcode	= ItemCode,
		@li_present_prdorder	= PrdOrder
	   FROM	TPRDKB
	 WHERE	PrdDate			= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode		= @ps_linecode

	Insert #Tmp_Results Values(@li_loop_count, @ls_result_itemcode, @li_present_prdorder)

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END

-- 레코드 카운터 초기화
Set RowCount 0

-- HIT COUNT
Select	@li_loop_count = 0, @li_hitcount = 0
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count = @li_loop_count + 1

	-- 지시순서
	SELECT	@ls_order_itemcode	= Order_ItemCode,
		@li_present_cycleorder	= CycleOrder
	  FROM	#Tmp_Order
	WHERE	Order_no		= @li_loop_count

	-- 생산순서
	SELECT	@ls_result_itemcode	= Result_ItemCode,
		@li_present_prdorder	= PrdOrder
	  FROM	#Tmp_Results
	WHERE	Result_no		= @li_loop_count

	-- 지시순서와 생산순서 비교
	IF	@ls_present_itemcode	= @ls_order_itemcode	AND
		@ls_present_itemcode	= @ls_result_itemcode
	BEGIN
		SELECT	@li_hitcount	= @li_hitcount + 1
	END
END

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

-- 조립지시 TABLE
Select	@li_loop_count		= 0,
	@ls_order_itemcode	= '',
	@li_present_cycleorder	= 0
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count = @li_loop_count + 1
       	Set RowCount @li_loop_count

	SELECT	@ls_order_itemcode	= ItemCode,
		@li_present_cycleorder	= CycleOrder
	   FROM TPLANRELEASE_T
	 WHERE	PlanDate		= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode		= @ps_linecode
	   AND	ReleaseGubun		IN('T','U','Y')
	 ORDER BY	CycleOrder, ReleaseOrder ASC

	Insert #Tmp_Order Values(@li_loop_count, @ls_order_itemcode, @li_present_cycleorder)

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
	@li_present_prdorder	= 0
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count = @li_loop_count + 1
       	Set RowCount @li_loop_count 

	SELECT	@ls_result_itemcode	= ItemCode,
		@li_present_prdorder	= PrdOrder
	   FROM	TPRDKB
	 WHERE	PrdDate			= @ls_applydate_close
	   AND	AreaCode		= @ps_areacode
	   AND	DivisionCode		= @ps_divisioncode
	   AND	WorkCenter		= @ps_workcenter
	   AND	LineCode		= @ps_linecode

	Insert #Tmp_Results Values(@li_loop_count, @ls_result_itemcode, @li_present_prdorder)

	-- ERROR 체크
	Select	@pi_err_code	= @pi_err_code + @@Error
END

-- HIT COUNT
Select	@li_loop_count = 0, @li_hitcount = 0
While 	@li_loop_count < @li_row_count
BEGIN
	SET @li_loop_count = @li_loop_count + 1

	-- 지시순서
	SELECT	@ls_order_itemcode	= Order_ItemCode,
		@li_present_cycleorder	= CycleOrder
	  FROM	#Tmp_Order
	WHERE	Order_no		= @li_loop_count

	-- 생산순서
	SELECT	@ls_result_itemcode	= Result_ItemCode,
		@li_present_prdorder	= PrdOrder
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

-- TMP TABLE 삭제
DROP TABLE #Tmp_Order
DROP TABLE #Tmp_Results

/*########################################################################################

	LOT NO 이력

########################################################################################*/

-- 재고에 추가여부 체크
IF @ls_inspectgubun	= 'N' AND
    @ls_stockgubun	= 'N'
BEGIN
	-- 생산 완료 후 즉시 창고 입고
	UPDATE	TLOTNO
	   SET	PrdQty		= PrdQty    - @li_rackqty,
		StockQty		= StockQty - @li_rackqty,
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
	   SET	PrdQty		= PrdQty    - @li_rackqty,
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

/*########################################################################################

	생산수량 관리

########################################################################################*/

-- TPRD TABLE의 생산량 감소
UPDATE	TPRD
   SET	PrdQty		= PrdQty - @li_rackqty,
	LastEmp		= @ps_com_code,
	LastDate		= @ldt_systemtime
WHERE	PrdDate		= @ls_applydate_close
   AND	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	WorkCenter	= @ps_workcenter
   AND	LineCode	= @ps_linecode
   AND	ItemCode	= @ls_present_itemcode

-- ERROR 체크
Select	@pi_err_code	= @pi_err_code + @@Error

/*########################################################################################

	분할 Lot 정보 삭제

########################################################################################*/

DELETE
  FROM	TLOTNODIVIDE
WHERE	TraceDate	= @ls_applydate_close
 AND	KBNo		= @ps_kbno
 AND	KBReleaseDate	= @ls_kbreleasedate

-- ERROR 체크
Select	@pi_err_code	= @pi_err_code + @@Error

/*########################################################################################

	품질 CONTAINMENT 검사등록 DATA 삭제

########################################################################################*/

DELETE
  FROM	TQCONTAINQCENTRY
WHERE	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	prdenddate	= @ls_applydate_close
   AND	kbno		= @ps_kbno

-- ERROR 체크
Select	@pi_err_code	= @pi_err_code + @@Error

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
End			-- Procedure End
GO
