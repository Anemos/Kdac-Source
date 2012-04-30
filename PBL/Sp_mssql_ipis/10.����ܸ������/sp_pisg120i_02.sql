/*##############################################################################*/
/*## File Name		: sp_pisg120i_02.SQL						##*/
/*## SYSTEM		: KDAC 대구공장 IPIS2000						##*/
/*## Procedure Name	: sp_pisg120i_02							##*/
/*## Description		: 현장관리의 조립순서						##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg120i_02							##*/
/*## Parameter		: @ps_kbno, @ps_com_code, @pi_err_code				##*/
/*## Use Table		: TKB, TKBHIS							##*/
/*## Initial		: 2002. 11. 05							##*/
/*## Last Change	: 2002. 12. 12							##*/
/*## Author		: 최선배								##*/
/*##############################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg120i_02'))
	Drop Procedure sp_pisg120i_02
Go

/*
EXEC	sp_pisg120i_02
	@ps_kbno		= 'DH010020002',
	@ps_com_code		= 'DHA08',
	@pi_err_code		= 0
*/

Create Procedure sp_pisg120i_02
	@ps_kbno		varchar(11),		-- 간판번호
	@ps_com_code		varchar(15),		-- 단말기 코드
	@pi_err_code		INT	OUTPUT		-- ERROR 코드
As
Begin
------------------------------------------------------------------------------

Begin	TRAN

Declare	@ldt_systemtime		DateTime,	-- 현재 DATETIME
	@ls_areacode		char(1),		-- AREACODE
	@ls_divisioncode		char(1),		-- DIVISIONCODE
	@ls_stockgubun		char(1)		-- 창고 등록 구분

/*########################################################################################

	ERROR FLAG 초기화

########################################################################################*/

SELECT	@pi_err_code = 0

/*########################################################################################

	시스템 시간

########################################################################################*/

SELECT	@ldt_systemtime		= GETDATE()

/*########################################################################################

	기본정보

########################################################################################*/

SELECT	@ls_areacode	= AreaCode,
	@ls_divisioncode	= DivisionCode,
	@ls_stockgubun	= StockGubun
  FROM	TKB
 WHERE	KBNo			= @ps_kbno

/*########################################################################################

	회수 간판 처리

########################################################################################*/

-- 간판정보 조립완료로 변경
/*
UPDATE	TPLANRELEASE
SET	KBNo		= 'A',
	KBReleaseDate	= 'A',
	KBReleaseSeq	= 0,
	ReleaseGubun	= 'C',
	PrdFlag		= 'C',
	ReleaseKBCount	= 0,
	ReleaseKBQty	= 0,
	LastEmp		= @ps_com_code,
	LastDate		= @ldt_systemtime
 WHERE	AreaCode	= @ls_areacode
   AND	DivisionCode	= @ls_divisioncode
   AND	KBNo		= @ps_kbno

-- ERROR 체크
Select	@pi_err_code	= @pi_err_code + @@Error
*/

-- 개별 간판 현황
UPDATE	TKB
SET	KBStatusCode	= 'F',
	KBBackTime	= @ldt_systemtime,
	LastEmp		= 'Y',
	LastDate		= @ldt_systemtime
 WHERE	KBNo		= @ps_kbno

-- ERROR 체크
Select	@pi_err_code	= @pi_err_code + @@Error

-- 간판 이력
UPDATE	TKBHIS
SET	KBStatusCode	= 'F',
	KBBackTime	= @ldt_systemtime,
	LastEmp		= 'Y',
	LastDate		= @ldt_systemtime
 WHERE	KBNo		= @ps_kbno
   AND	LastLoopFlag	= 'Y'

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

End			-- Procedure End
Go
