/*
	File Name	: sp_pisp241u_04_u.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp241u_04_u
	Description	: 간판 발행 - 발행된 내역 저장
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 10
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp241u_04_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp241u_04_u]
GO

/*
Execute sp_pisp241u_04_u
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= '%',
	@ps_itemcode		= '%',
	@ps_kbactivegubun	= '%'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp241u_04_u
	@ps_kbno_1		varchar(11),
	@ps_kbno_2		varchar(11),
	@ps_kbno_3		varchar(11),
	@ps_empcode		varchar(6)

As
Begin

Declare	@ldt_nowtime		datetime,	-- 지준일을 구하기 위한 현재 일시
	@ls_error		char(2),
	@ls_errortext		varchar(100)

Select	@ldt_nowtime	= GetDate()

-- tkb 변경
Update	tkb
Set	KBPrintTime	= @ldt_nowtime,
	PrintCount	= PrintCount + 1,
	LastEmp		= 'Y',--@ps_empcode,
	LastDate		= @ldt_nowtime
From	tkb	A
Where	A.KBNo		In (@ps_kbno_1, @ps_kbno_2, @ps_kbno_3)

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '간판의 인쇄 정보를 변경하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판의 인쇄 정보를 변경하는 중에 오류가 발생하였습니다.'
	GoTo Proc_Exit
End

-- tkbhis 변경
Update	tkbhis
Set	KBPrintTime	= @ldt_nowtime,
	PrintCount	= PrintCount + 1,
	LastEmp		= 'Y',--@ps_empcode,
	LastDate		= @ldt_nowtime
From	tkbhis	A
Where	A.KBNo		In (@ps_kbno_1, @ps_kbno_2, @ps_kbno_3)	And
	A.LastLoopFlag	= 'Y'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '간판의 인쇄 정보를 변경하였습니다.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '간판 이력의 인쇄 정보를 변경하는 중에 오류가 발생하였습니다.'
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
