/*
	File Name	: sp_pisc_get_shift.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisc_get_shift
	Description	: 주/야 구분 구하기.
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 17
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_get_shift]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_get_shift]
GO

/*
declare	@ls_shift		char(1),
	@ldt_datetime	datetime

--select	@ldt_datetime = Convert(datetime, '2002.09.30 19:00:00')
select	@ldt_datetime = Convert(datetime, '2002.10.31 19:59:59')

Execute sp_pisc_get_shift
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'B',
	@pdt_sourcedate		= @ldt_datetime,
	@rs_shift		= @ls_shift		output

select @ls_shift
*/

Create Procedure sp_pisc_get_shift
	@ps_areacode		char(1),			-- 지역
	@ps_divisioncode	char(1),			-- 공장
	@pdt_sourcedate		datetime,		-- 기준일을 구하려는 일시
	@rs_shift		char(1)		output	-- 기준일

As
Begin

Declare	@ls_sourcetime	char(8)		-- 기준일을 구하려는 일자의 시간('HH:MM:SS')

Select	@ls_sourcetime	= Convert(char(8), @pdt_sourcedate, 108)

--If @ps_areacode = '%' Or @ps_divisioncode = '%'
If @ps_divisioncode = '%'
Begin
	-- 공장이 없으므로 주간을 08:00 ~ 20:00 로 처리
	Select @rs_shift = Case When @ls_sourcetime > '07:59:59' And @ls_sourcetime < '20:00:00' Then 'A' Else 'B' End
End
Else
Begin
	-- 여기는 주/야 구분을 계산함.
	Select	@rs_shift = Case When @ls_sourcetime > '07:59:59' And @ls_sourcetime < A.FlagGubun Then 'A' Else 'B' End
	  From	tmstflag		A
	 Where	AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		FlagCode	= 'CHANGE_SHIFT'

	If @@RowCount = 0 Or @rs_shift Is Null
	Begin
		-- 데이터가 없으므로 주간을 08:00 ~ 20:00 로 처리
		Select @rs_shift = Case When @ls_sourcetime > '07:59:59' And @ls_sourcetime < '20:00:00' Then 'A' Else 'B' End
	End
End

Return

End		-- Procedure End
Go
