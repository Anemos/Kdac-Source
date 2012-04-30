/*
	File Name	: sp_piso_generate_inv.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piso_generate_inv
	Description	: 월초 재고 계산
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 11
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piso_generate_inv]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piso_generate_inv]
GO


/*

Execute sp_piso_generate_inv '08:00', 'D', 'A'

select * from tplanrelease where releasegubun in ('T', 'Y') and prdflag = 'N'
select * from tinvhis
*/

Create Procedure sp_piso_generate_inv
	@ps_generate_time	varchar(5),	-- 주간 08:00, 야간 20:00 계산
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1)
	
As
Begin

Declare	@ldt_nowtime		datetime,	-- 지준일을 구하기 위한 현재 일시
	@ls_applydate		char(10),
	@ls_lastdate		char(10),
	@ls_applymonth		char(7),
	@ls_error		varchar(2),
	@ls_errortext		varchar(100)

-- 일단 기준일을 구하자
Select	@ldt_nowtime	= GetDate()

Exec	sp_pisc_get_applydate_close
	@ps_areacode		= @ps_areacode,
	@ps_divisioncode	= @ps_divisioncode,
	@pdt_sourcedate		= @ldt_nowtime,
	@rs_applydate		= @ls_applydate	output

--Select	@ls_lastdate = Convert(Char(10), DateAdd(DD, -1, DateAdd(MM, 1, Convert(DateTime, Left('2002.11.11', 7) + '.01'))), 102)
Select	@ls_lastdate = Convert(Char(10), DateAdd(DD, -1, DateAdd(MM, 1, Convert(DateTime, Left(@ls_applydate, 7) + '.01'))), 102)

If @ps_generate_time = '08:00'
Begin
	-- 매달 2일날의 경우 기준일이 1일로 날라오므로..조건을 하나 더 추가
	If @ls_applydate = Left(@ls_applydate, 7) + '.01' And Right(Convert(char(10), @ldt_nowtime, 102), 2) = '01'
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '매월 첫날은 08:00 에 계산 불가'
	
		Select	@ls_error,
			@ls_errortext
		Return
	End
End
Else
Begin
	If @ls_applydate <> @ls_lastdate
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '매월 말일이 아닌 일자는 20:00 에 계산 불가'
	
		Select	@ls_error,
			@ls_errortext
		Return
	End
End

--select	@ls_applydate	= '2002.12.25'
Select	@ls_applymonth	= Left(Convert(Char(10), DateAdd(MM, 1, Convert(DateTime, @ls_applydate)), 102), 7)

-- 일단 월초 재고를 삭제하자
Delete	tinvhis
Where	ApplyMonth	= @ls_applymonth
And	AreaCode	like @ps_areacode
And	DivisionCode	like @ps_divisioncode

-- 월초 재고를 추가하자
Insert	tinvhis
Select	ApplyMonth	= @ls_applymonth,
	AreaCode	= A.AreaCode,
	DivisionCode	= A.DivisionCode,
	ItemCode	= A.ItemCode,
	InvQty		= A.InvQty,
	RepairQty	= A.RepairQty,
	DefectQty	= A.DefectQty,
	MoveInvQty	= A.MoveInvQty,
	ShipInvQty	= A.ShipInvQty,
	InvCompute	= A.InvCompute,
	CloseFlag	= 'Y',
	CloseDate	= @ldt_nowtime,
	LastEmp		= 'Y',
	LastDate		= @ldt_nowtime
From	tinv	A
Where	A.AreaCode	like @ps_areacode
And	A.DivisionCode	like @ps_divisioncode

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '월초 재고를 계산하였습니다..'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '월초 재고를 계산하는 중에 오류가 발생하였습니다.'
End

Select	@ls_error,
	@ls_errortext

Return

End		-- Procedure End
Go
