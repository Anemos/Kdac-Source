/*
	File Name	: sp_pisp260i_02_u.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp260i_02_u
	Description	: 간판 정보 - 간판 초기화 저장 프로시저
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 10
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp260i_02_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp260i_02_u]
GO

/*
Execute sp_pisp260i_02_u
	@ps_kbno	= 'D',
	@ps_empcode	= '%'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp260i_02_u
	@ps_kbno		varchar(11),
	@ps_empcode		varchar(6)

As
Begin

Declare	@ldt_nowtime		datetime,	-- 지준일을 구하기 위한 현재 일시
	@ls_error		char(2),
	@ls_errortext		varchar(100)

Select	@ldt_nowtime	= GetDate()

-- tkb 를 변경하자.
Update	tkb
Set	KBStatusCode		= 'F',
--	CurrentQty		= RackQty,
--	ReleaseGubun		= Null,
--	ReleaseCancel		= Null,
--	PrdFlag			= Null,
--	InspectGubun		= Null,
--	InspectFlag		= Null,
--	StockGubun		= Null,
--	StockCancel		= Null,
--	PlanDate		= Null,
--	PrdDate			= Null,
--	PrdAreaCode		= Null,
--	PrdDivisionCode		= Null,
--	PrdWorkCenter		= Null,
--	PrdLineCode		= Null,
--	TimeApplyFrom		= Null,
--	TimeCode		= Null,
--	PrdQty			= 0,
--	LotNo			= Null,
--	StockDate		= Null,
--	StockQty			= 0,
--	ShipDate		= Null,
--	ShipQty			= 0,
--	KBReleaseTime		= Null,
--	KBStartTime		= Null,
--	KBEndTime		= Null,
--	KBInspectTime		= Null,
--	KBStockTime		= Null,
--	KBShipTime		= Null,
	KBBackTime		= Null,
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime
Where	KBNo		= @ps_kbno

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '간판정보 초기화를 저장하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판정보 초기화를 저장하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- tkbhis 을 변경하자
Update	tkbhis
Set	KBStatusCode		= 'F',
--	CurrentQty		= RackQty,
--	ReleaseGubun		= Null,
--	ReleaseCancel		= Null,
--	PrdFlag			= Null,
--	InspectGubun		= Null,
--	InspectFlag		= Null,
--	StockGubun		= Null,
--	StockCancel		= Null,
--	PlanDate		= Null,
--	PrdDate			= Null,
--	PrdAreaCode		= Null,
--	PrdDivisionCode		= Null,
--	PrdWorkCenter		= Null,
--	PrdLineCode		= Null,
--	TimeApplyFrom		= Null,
--	TimeCode		= Null,
--	PrdQty			= 0,
--	LotNo			= Null,
--	StockDate		= Null,
--	StockQty			= 0,
--	ShipDate		= Null,
--	ShipQty			= 0,
--	KBReleaseTime		= Null,
--	KBStartTime		= Null,
--	KBEndTime		= Null,
--	KBInspectTime		= Null,
--	KBStockTime		= Null,
--	KBShipTime		= Null,
	KBBackTime		= Null,
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime
Where	KBNo		= @ps_kbno		And
	LastLoopFlag	= 'Y'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '간판정보 초기화를 저장하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판이력정보 초기화를 저장하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End


Proc_Exit:

/*
If @ls_error = '00'
Begin
	Commit Tran
End
Else
Begin
	RollBack Tran
End
*/

Select	Error		= @ls_error,
	ErrorText	= @ls_errortext

Return

End		-- Procedure End
Go
