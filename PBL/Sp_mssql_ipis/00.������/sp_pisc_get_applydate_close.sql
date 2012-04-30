/*
	File Name	: sp_pisc_get_applydate_close.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisc_get_applydate_close
	Description	: 기준일 구하기 - 월마감 일자를 고려한 기준일 구하기
			  주의 : Host 가 매달 말일 20:00 에 마감처리를 하므로
				IPIS 도 매달 말일에는 기준일 계산이 틀려진다...ㅅㅂ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 17
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_get_applydate_close]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_get_applydate_close]
GO

/*
declare	@ls_applydate	char(10),
	@ldt_datetime	datetime

--select	@ldt_datetime = Convert(datetime, '2002.09.30 19:00:00')
select	@ldt_datetime = Convert(datetime, '2002.09.26 11:00:00')

Execute sp_pisc_get_applydate_close
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@pdt_sourcedate		= @ldt_datetime,
	@rs_applydate		= @ls_applydate		output

select @ls_applydate
*/

Create Procedure sp_pisc_get_applydate_close
	@ps_areacode		char(1),			-- 지역
	@ps_divisioncode	char(1),			-- 공장
	@pdt_sourcedate		datetime,		-- 기준일을 구하려는 일시
	@rs_applydate		char(10)		output	-- 기준일

As
Begin

Declare	@ls_sourceday	char(10),	-- 기준일을 구하려는 일자('YYYY.MM.DD')
	@ls_sourcetime	char(8),		-- 기준일을 구하려는 일자의 시간('HH:MM:SS')
	@ls_lastday	char(10),	-- 기준일을 구하려는 일자가 속한 달의 마지막 일자('YYYY.MM.DD')
	@ls_nextday	char(10)		-- 기준일을 구하려는 일자가 속한 달의 다음달의 첫째 일자('YYYY.MM.DD')


Select	@ls_sourceday	= Convert(char(10), @pdt_sourcedate, 102),
	@ls_sourcetime	= Convert(char(8), @pdt_sourcedate, 108)
Select	@ls_lastday	= Convert(char(10), DateAdd(DD, -1, DateAdd(MM, 1, Convert(DateTime, Left(@ls_sourceday, 7) + '.01'))), 102)
Select	@ls_nextday	= Convert(char(10), DateAdd(MM, 1, Convert(DateTime, Left(@ls_sourceday, 7) + '.01')), 102)

-- 월 마지막 날은 마감시간이 '20:00' 이다. 매우 중요함...
-- 따라서, 월의 마지막 일자하구 월 첫째 일자의 기준일 계산은 지랄같다...
If @ls_sourceday = @ls_lastday
Begin
	If @ls_sourcetime > '19:59:59'
	Begin
		Select	@rs_applydate	= @ls_nextday
		Return
	End
	Else
	Begin
		Select	@rs_applydate = Convert(Char(10),
						DateAdd(Second,
							DateDiff(Second,
								Convert(DateTime, '08:00:00'),
								Convert(DateTime, '00:00:00')
							)
						,@pdt_sourcedate )
					 ,102)
		Return
	End
End
Else
Begin
	If Right(@ls_sourceday, 2) = '01'
	Begin
		Select	@rs_applydate = @ls_sourceday
		Return
	End
End

-- 지금부터는 말일 및 첫일 이 아닌 일자의 기준일 구하기.
--If @ps_areacode = '%' Or @ps_divisioncode = '%'
If @ps_divisioncode = '%'
Begin
	-- 공장이 없으므로 08:00:00 으로 처리
	Select	@rs_applydate = Convert(Char(10),
					DateAdd(Second,
						DateDiff(Second,
							Convert(DateTime, '08:00:00'),
							Convert(DateTime, '00:00:00')
						)
					,@pdt_sourcedate )
				 ,102)
End
Else
Begin
	-- 여기는 기준 일자를 계산함.
	Select	@rs_applydate = Convert(Char(10),
					DateAdd(Second,
						DateDiff(Second,
							Convert(DateTime, A.FlagGubun),
							Convert(DateTime, '00:00:00')
						)
					,@pdt_sourcedate )
				 ,102)
	  From	tmstflag		A
	 Where	AreaCode	= @ps_areacode		And
		DivisionCode	= @ps_divisioncode	And
		FlagCode	= 'CHANGE_DATE'

	If @@RowCount = 0 Or @rs_applydate Is Null
	Begin
		-- 데이터가 없으므로 08:00:00 으로 처리
		Select	@rs_applydate = Convert(Char(10),
						DateAdd(Second,
							DateDiff(Second,
								Convert(DateTime, '08:00:00'),
								Convert(DateTime, '00:00:00')
							)
						,@pdt_sourcedate )
					 ,102)
	End
End

Return

End		-- Procedure End
Go
