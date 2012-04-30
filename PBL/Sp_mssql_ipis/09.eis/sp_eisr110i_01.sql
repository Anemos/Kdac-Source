SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_eisr110i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_eisr110i_01]
GO

------------------------------------------------------------------
--      월별 외주간판준수율(전사)
------------------------------------------------------------------
CREATE PROCEDURE sp_eisr110i_01
	@ps_year		Char(4),	-- 년도
	@ps_area		Char(1)		-- 지역
AS

BEGIN

Set NoCount On

Declare	@ldt_applytime		DateTime
Select  @ldt_applytime = GetDate()

SELECT 	AreaCode, DivisionCode,
	MonthKBQty1	= Sum( isNull(MonthKBQty1, 0) ),
	DateKBQty1	= Sum( isNull(DateKBQty1, 0) ),
	TimeKBQty1	= Sum( isNull(TimeKBQty1, 0) ),
	MonthKBQty2	= Sum( isNull(MonthKBQty2, 0) ),
	DateKBQty2	= Sum( isNull(DateKBQty2, 0) ),
	TimeKBQty2	= Sum( isNull(TimeKBQty2, 0) ),
	MonthKBQty3	= Sum( isNull(MonthKBQty3, 0) ),
	DateKBQty3	= Sum( isNull(DateKBQty3, 0) ),
	TimeKBQty3	= Sum( isNull(TimeKBQty3, 0) ),
	MonthKBQty4	= Sum( isNull(MonthKBQty4, 0) ),
	DateKBQty4	= Sum( isNull(DateKBQty4, 0) ),
	TimeKBQty4	= Sum( isNull(TimeKBQty4, 0) ),
	MonthKBQty5	= Sum( isNull(MonthKBQty5, 0) ),
	DateKBQty5	= Sum( isNull(DateKBQty5, 0) ),
	TimeKBQty5	= Sum( isNull(TimeKBQty5, 0) ),
	MonthKBQty6	= Sum( isNull(MonthKBQty6, 0) ),
	DateKBQty6	= Sum( isNull(DateKBQty6, 0) ),
	TimeKBQty6	= Sum( isNull(TimeKBQty6, 0) ),
	MonthKBQty7	= Sum( isNull(MonthKBQty7, 0) ),
	DateKBQty7	= Sum( isNull(DateKBQty7, 0) ),
	TimeKBQty7	= Sum( isNull(TimeKBQty7, 0) ),
	MonthKBQty8	= Sum( isNull(MonthKBQty8, 0) ),
	DateKBQty8	= Sum( isNull(DateKBQty8, 0) ),
	TimeKBQty8	= Sum( isNull(TimeKBQty8, 0) ),
	MonthKBQty9	= Sum( isNull(MonthKBQty9, 0) ),
	DateKBQty9	= Sum( isNull(DateKBQty9, 0) ),
	TimeKBQty9	= Sum( isNull(TimeKBQty9, 0) ),
	MonthKBQty10	= Sum( isNull(MonthKBQty10, 0) ),
	DateKBQty10	= Sum( isNull(DateKBQty10, 0) ),
	TimeKBQty10	= Sum( isNull(TimeKBQty10, 0) ),
	MonthKBQty11	= Sum( isNull(MonthKBQty11, 0) ),
	DateKBQty11	= Sum( isNull(DateKBQty11, 0) ),
	TimeKBQty11	= Sum( isNull(TimeKBQty11, 0) ),
	MonthKBQty12	= Sum( isNull(MonthKBQty12, 0) ),
	DateKBQty12	= Sum( isNull(DateKBQty12, 0) ),
	TimeKBQty12	= Sum( isNull(TimeKBQty12, 0) )
INTO	#PARTKBCOUNT_tmp
FROM (	-- M-1 TPARTKBHIS 에서 1~12월 정규간판매수계산
	Select	AreaCode, DivisionCode,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.01' Then Count(*) Else 0 End As MonthKBQty1,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.02' Then Count(*) Else 0 End As MonthKBQty2,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.03' Then Count(*) Else 0 End As MonthKBQty3,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.04' Then Count(*) Else 0 End As MonthKBQty4,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.05' Then Count(*) Else 0 End As MonthKBQty5,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.06' Then Count(*) Else 0 End As MonthKBQty6,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.07' Then Count(*) Else 0 End As MonthKBQty7,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.08' Then Count(*) Else 0 End As MonthKBQty8,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.09' Then Count(*) Else 0 End As MonthKBQty9,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.10' Then Count(*) Else 0 End As MonthKBQty10,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.11' Then Count(*) Else 0 End As MonthKBQty11,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.12' Then Count(*) Else 0 End As MonthKBQty12,
		0 As DateKBQty1,
		0 As DateKBQty2,
		0 As DateKBQty3,
		0 As DateKBQty4,
		0 As DateKBQty5,
		0 As DateKBQty6,
		0 As DateKBQty7,
		0 As DateKBQty8,
		0 As DateKBQty9,
		0 As DateKBQty10,
		0 As DateKBQty11,
		0 As DateKBQty12,
		0 As TimeKBQty1,
		0 As TimeKBQty2,
		0 As TimeKBQty3,
		0 As TimeKBQty4,
		0 As TimeKBQty5,
		0 As TimeKBQty6,
		0 As TimeKBQty7,
		0 As TimeKBQty8,
		0 As TimeKBQty9,
		0 As TimeKBQty10,
		0 As TimeKBQty11,
		0 As TimeKBQty12
	  From	TPARTKBHIS
	 Where	--AreaCode 		Like @ps_area		And
		PartKBGubun		= 'N'			And
		PartKBStatus		= 'C'			And
		SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 4) =  @ps_year 
	Group By AreaCode, DivisionCode,SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7)
	
	Union All
	
	-- M-2 TPARTKBSTATUS 에서 1~12월 정규간판매수계산( 납입예정일이 지난 발주 및 가입고간판 )
	Select	AreaCode, DivisionCode,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.01' Then Count(*) Else 0 End As MonthKBQty1,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.02' Then Count(*) Else 0 End As MonthKBQty2,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.03' Then Count(*) Else 0 End As MonthKBQty3,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.04' Then Count(*) Else 0 End As MonthKBQty4,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.05' Then Count(*) Else 0 End As MonthKBQty5,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.06' Then Count(*) Else 0 End As MonthKBQty6,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.07' Then Count(*) Else 0 End As MonthKBQty7,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.08' Then Count(*) Else 0 End As MonthKBQty8,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.09' Then Count(*) Else 0 End As MonthKBQty9,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.10' Then Count(*) Else 0 End As MonthKBQty10,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.11' Then Count(*) Else 0 End As MonthKBQty11,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.12' Then Count(*) Else 0 End As MonthKBQty12,
		0 As DateKBQty1,
		0 As DateKBQty2,
		0 As DateKBQty3,
		0 As DateKBQty4,
		0 As DateKBQty5,
		0 As DateKBQty6,
		0 As DateKBQty7,
		0 As DateKBQty8,
		0 As DateKBQty9,
		0 As DateKBQty10,
		0 As DateKBQty11,
		0 As DateKBQty12,
		0 As TimeKBQty1,
		0 As TimeKBQty2,
		0 As TimeKBQty3,
		0 As TimeKBQty4,
		0 As TimeKBQty5,
		0 As TimeKBQty6,
		0 As TimeKBQty7,
		0 As TimeKBQty8,
		0 As TimeKBQty9,
		0 As TimeKBQty10,
		0 As TimeKBQty11,
		0 As TimeKBQty12
	  From	TPARTKBSTATUS
	 Where	--AreaCode 		Like @ps_area	And
		PartKBGubun		= 'N'		And
		PartKBStatus		= 'B'		And
		SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 4) =  @ps_year 
--		((PartKBStatus		= 'B'		And
--		SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 4) =  @ps_year ) Or
--		 (PartKBStatus		= 'A'		And
--		SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 4) =  @ps_year And
--		Case OrderChangeFlag When 'Y' Then ChangeForecastTime Else PartForecastTime End < @ldt_applytime ))
	Group By AreaCode, DivisionCode, SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7)
	
	Union All
	-- D-1 TPARTKBHIS 에서 1~12월 일자준수간판(정규간판)매수계산
	Select	AreaCode, DivisionCode,
		0 As MonthKBQty1,
		0 As MonthKBQty2,
		0 As MonthKBQty3,
		0 As MonthKBQty4,
		0 As MonthKBQty5,
		0 As MonthKBQty6,
		0 As MonthKBQty7,
		0 As MonthKBQty8,
		0 As MonthKBQty9,
		0 As MonthKBQty10,
		0 As MonthKBQty11,
		0 As MonthKBQty12,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.01' Then Count(*) Else 0 End As DateKBQty1,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.02' Then Count(*) Else 0 End As DateKBQty2,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.03' Then Count(*) Else 0 End As DateKBQty3,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.04' Then Count(*) Else 0 End As DateKBQty4,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.05' Then Count(*) Else 0 End As DateKBQty5,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.06' Then Count(*) Else 0 End As DateKBQty6,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.07' Then Count(*) Else 0 End As DateKBQty7,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.08' Then Count(*) Else 0 End As DateKBQty8,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.09' Then Count(*) Else 0 End As DateKBQty9,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.10' Then Count(*) Else 0 End As DateKBQty10,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.11' Then Count(*) Else 0 End As DateKBQty11,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.12' Then Count(*) Else 0 End As DateKBQty12,
		0 As TimeKBQty1,
		0 As TimeKBQty2,
		0 As TimeKBQty3,
		0 As TimeKBQty4,
		0 As TimeKBQty5,
		0 As TimeKBQty6,
		0 As TimeKBQty7,
		0 As TimeKBQty8,
		0 As TimeKBQty9,
		0 As TimeKBQty10,
		0 As TimeKBQty11,
		0 As TimeKBQty12
	  From	TPARTKBHIS
	 Where	--AreaCode 		Like @ps_area	And
		PartKBGubun		= 'N'		And
		PartKBStatus		= 'C'		And
		PartObeyDateFlag	= 1		And
		SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 4) =  @ps_year 
	Group By AreaCode, DivisionCode,SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7)
	
	Union All
	-- D-2  TPARTKBSTATUS 에서 1~12월 일자준수간판(정규간판)매수계산
	Select	AreaCode, DivisionCode,
		0 As MonthKBQty1,
		0 As MonthKBQty2,
		0 As MonthKBQty3,
		0 As MonthKBQty4,
		0 As MonthKBQty5,
		0 As MonthKBQty6,
		0 As MonthKBQty7,
		0 As MonthKBQty8,
		0 As MonthKBQty9,
		0 As MonthKBQty10,
		0 As MonthKBQty11,
		0 As MonthKBQty12,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.01' Then Count(*) Else 0 End As DateKBQty1,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.02' Then Count(*) Else 0 End As DateKBQty2,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.03' Then Count(*) Else 0 End As DateKBQty3,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.04' Then Count(*) Else 0 End As DateKBQty4,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.05' Then Count(*) Else 0 End As DateKBQty5,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.06' Then Count(*) Else 0 End As DateKBQty6,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.07' Then Count(*) Else 0 End As DateKBQty7,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.08' Then Count(*) Else 0 End As DateKBQty8,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.09' Then Count(*) Else 0 End As DateKBQty9,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.10' Then Count(*) Else 0 End As DateKBQty10,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.11' Then Count(*) Else 0 End As DateKBQty11,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.12' Then Count(*) Else 0 End As DateKBQty12,
		0 As TimeKBQty1,
		0 As TimeKBQty2,
		0 As TimeKBQty3,
		0 As TimeKBQty4,
		0 As TimeKBQty5,
		0 As TimeKBQty6,
		0 As TimeKBQty7,
		0 As TimeKBQty8,
		0 As TimeKBQty9,
		0 As TimeKBQty10,
		0 As TimeKBQty11,
		0 As TimeKBQty12
	  From	TPARTKBSTATUS
	 Where	--AreaCode 		Like @ps_area	And
		PartKBGubun		= 'N'		And
		PartKBStatus		= 'B'		And
		PartObeyDateFlag	= 1		And
		SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 4) =  @ps_year 
	Group By AreaCode, DivisionCode,SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7)
	
	Union All
	-- T-1  TPARTKBHIS 에서 1~12월 시간준수간판(정규간판)매수계산
	Select	AreaCode, DivisionCode,
		0 As MonthKBQty1,
		0 As MonthKBQty2,
		0 As MonthKBQty3,
		0 As MonthKBQty4,
		0 As MonthKBQty5,
		0 As MonthKBQty6,
		0 As MonthKBQty7,
		0 As MonthKBQty8,
		0 As MonthKBQty9,
		0 As MonthKBQty10,
		0 As MonthKBQty11,
		0 As MonthKBQty12,
		0 As DateKBQty1,
		0 As DateKBQty2,
		0 As DateKBQty3,
		0 As DateKBQty4,
		0 As DateKBQty5,
		0 As DateKBQty6,
		0 As DateKBQty7,
		0 As DateKBQty8,
		0 As DateKBQty9,
		0 As DateKBQty10,
		0 As DateKBQty11,
		0 As DateKBQty12,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.01' Then Count(*) Else 0 End As TimeKBQty1,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.02' Then Count(*) Else 0 End As TimeKBQty2,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.03' Then Count(*) Else 0 End As TimeKBQty3,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.04' Then Count(*) Else 0 End As TimeKBQty4,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.05' Then Count(*) Else 0 End As TimeKBQty5,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.06' Then Count(*) Else 0 End As TimeKBQty6,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.07' Then Count(*) Else 0 End As TimeKBQty7,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.08' Then Count(*) Else 0 End As TimeKBQty8,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.09' Then Count(*) Else 0 End As TimeKBQty9,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.10' Then Count(*) Else 0 End As TimeKBQty10,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.11' Then Count(*) Else 0 End As TimeKBQty11,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.12' Then Count(*) Else 0 End As TimeKBQty12
	  From	TPARTKBHIS
	 Where	--AreaCode 		Like @ps_area	And
		PartKBGubun		= 'N'		And
		PartKBStatus		= 'C'		And
		PartObeyTimeFlag	= 1		And
		SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 4) =  @ps_year 
	Group By AreaCode, DivisionCode,SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7)
	
	Union All
	-- T-2  TPARTKBHIS 에서 1~12월 시간준수간판(정규간판)매수계산
	Select	AreaCode, DivisionCode,
		0 As MonthKBQty1,
		0 As MonthKBQty2,
		0 As MonthKBQty3,
		0 As MonthKBQty4,
		0 As MonthKBQty5,
		0 As MonthKBQty6,
		0 As MonthKBQty7,
		0 As MonthKBQty8,
		0 As MonthKBQty9,
		0 As MonthKBQty10,
		0 As MonthKBQty11,
		0 As MonthKBQty12,
		0 As DateKBQty1,
		0 As DateKBQty2,
		0 As DateKBQty3,
		0 As DateKBQty4,
		0 As DateKBQty5,
		0 As DateKBQty6,
		0 As DateKBQty7,
		0 As DateKBQty8,
		0 As DateKBQty9,
		0 As DateKBQty10,
		0 As DateKBQty11,
		0 As DateKBQty12,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.01' Then Count(*) Else 0 End As TimeKBQty1,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.02' Then Count(*) Else 0 End As TimeKBQty2,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.03' Then Count(*) Else 0 End As TimeKBQty3,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.04' Then Count(*) Else 0 End As TimeKBQty4,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.05' Then Count(*) Else 0 End As TimeKBQty5,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.06' Then Count(*) Else 0 End As TimeKBQty6,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.07' Then Count(*) Else 0 End As TimeKBQty7,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.08' Then Count(*) Else 0 End As TimeKBQty8,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.09' Then Count(*) Else 0 End As TimeKBQty9,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.10' Then Count(*) Else 0 End As TimeKBQty10,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.11' Then Count(*) Else 0 End As TimeKBQty11,
		Case When SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7) =  @ps_year + '.12' Then Count(*) Else 0 End As TimeKBQty12
	  From	TPARTKBSTATUS
	 Where	--AreaCode 		Like @ps_area	And
		PartKBGubun		= 'N'		And
		PartKBStatus		= 'B'		And
		PartObeyTimeFlag	= 1		And
		SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 4) =  @ps_year 
	Group By AreaCode, DivisionCode,SubString( (Case OrderChangeFlag When 'Y' Then ChangeForecastDate Else PartForecastDate End), 1, 7)
	)	A
Group By 	A.AreaCode, A.DivisionCode	

--// 지역별 소계를 계산한다.
  SELECT 	AreaCode	= AreaCode,   
		MonthKBQty1	= Sum(MonthKBQty1),
		DateKBQty1	= Sum(DateKBQty1),
		TimeKBQty1	= Sum(TimeKBQty1),
		MonthKBQty2	= Sum(MonthKBQty2),
		DateKBQty2	= Sum(DateKBQty2),
		TimeKBQty2	= Sum(TimeKBQty2),
		MonthKBQty3	= Sum(MonthKBQty3),
		DateKBQty3	= Sum(DateKBQty3),
		TimeKBQty3	= Sum(TimeKBQty3),
		MonthKBQty4	= Sum(MonthKBQty4),
		DateKBQty4	= Sum(DateKBQty4),
		TimeKBQty4	= Sum(TimeKBQty4),
		MonthKBQty5	= Sum(MonthKBQty5),
		DateKBQty5	= Sum(DateKBQty5),
		TimeKBQty5	= Sum(TimeKBQty5),
		MonthKBQty6	= Sum(MonthKBQty6),
		DateKBQty6	= Sum(DateKBQty6),
		TimeKBQty6	= Sum(TimeKBQty6),
		MonthKBQty7	= Sum(MonthKBQty7),
		DateKBQty7	= Sum(DateKBQty7),
		TimeKBQty7	= Sum(TimeKBQty7),
		MonthKBQty8	= Sum(MonthKBQty8),
		DateKBQty8	= Sum(DateKBQty8),
		TimeKBQty8	= Sum(TimeKBQty8),
		MonthKBQty9	= Sum(MonthKBQty9),
		DateKBQty9	= Sum(DateKBQty9),
		TimeKBQty9	= Sum(TimeKBQty9),
		MonthKBQty10	= Sum(MonthKBQty10),
		DateKBQty10	= Sum(DateKBQty10),
		TimeKBQty10	= Sum(TimeKBQty10),
		MonthKBQty11	= Sum(MonthKBQty11),
		DateKBQty11	= Sum(DateKBQty11),
		TimeKBQty11	= Sum(TimeKBQty11),
		MonthKBQty12	= Sum(MonthKBQty12),
		DateKBQty12	= Sum(DateKBQty12),
		TimeKBQty12	= Sum(TimeKBQty12)
    INTO	#PARTKBCOUNTSUM_tmp
    FROM	#PARTKBCOUNT_tmp
   Where	MonthKBQty1 + MonthKBQty2 + MonthKBQty3 + MonthKBQty4 + MonthKBQty5 + MonthKBQty6 + MonthKBQty7 + MonthKBQty8 + MonthKBQty9 + MonthKBQty10 + MonthKBQty11 + MonthKBQty12 > 0
Group By	AreaCode

--// 전체   합계를 계산한다.
  SELECT 	MonthKBQty1	= Sum(MonthKBQty1),
		DateKBQty1	= Sum(DateKBQty1),
		TimeKBQty1	= Sum(TimeKBQty1),
		MonthKBQty2	= Sum(MonthKBQty2),
		DateKBQty2	= Sum(DateKBQty2),
		TimeKBQty2	= Sum(TimeKBQty2),
		MonthKBQty3	= Sum(MonthKBQty3),
		DateKBQty3	= Sum(DateKBQty3),
		TimeKBQty3	= Sum(TimeKBQty3),
		MonthKBQty4	= Sum(MonthKBQty4),
		DateKBQty4	= Sum(DateKBQty4),
		TimeKBQty4	= Sum(TimeKBQty4),
		MonthKBQty5	= Sum(MonthKBQty5),
		DateKBQty5	= Sum(DateKBQty5),
		TimeKBQty5	= Sum(TimeKBQty5),
		MonthKBQty6	= Sum(MonthKBQty6),
		DateKBQty6	= Sum(DateKBQty6),
		TimeKBQty6	= Sum(TimeKBQty6),
		MonthKBQty7	= Sum(MonthKBQty7),
		DateKBQty7	= Sum(DateKBQty7),
		TimeKBQty7	= Sum(TimeKBQty7),
		MonthKBQty8	= Sum(MonthKBQty8),
		DateKBQty8	= Sum(DateKBQty8),
		TimeKBQty8	= Sum(TimeKBQty8),
		MonthKBQty9	= Sum(MonthKBQty9),
		DateKBQty9	= Sum(DateKBQty9),
		TimeKBQty9	= Sum(TimeKBQty9),
		MonthKBQty10	= Sum(MonthKBQty10),
		DateKBQty10	= Sum(DateKBQty10),
		TimeKBQty10	= Sum(TimeKBQty10),
		MonthKBQty11	= Sum(MonthKBQty11),
		DateKBQty11	= Sum(DateKBQty11),
		TimeKBQty11	= Sum(TimeKBQty11),
		MonthKBQty12	= Sum(MonthKBQty12),
		DateKBQty12	= Sum(DateKBQty12),
		TimeKBQty12	= Sum(TimeKBQty12)
    INTO	#PARTKBCOUNTTOT_tmp
    FROM	#PARTKBCOUNTSUM_tmp


--// Data Select
  SELECT 	A.AreaCode,	--1
		A.DivisionCode,	--2
		C.SortOrder,	--3
		B.AreaName,	
		C.DivisionName,	
		A.MonthKBQty1,
		A.DateKBQty1,
		Case A.MonthKBQty1 When 0 Then 0.0 Else Round( A.DateKBQty1*1.0 / A.MonthKBQty1 * 100.0 , 2) End As Drate1,
		A.TimeKBQty1,
		Case A.MonthKBQty1 When 0 Then 0.0 Else Round( A.TimeKBQty1*1.0 / A.MonthKBQty1 * 100.0 , 2) End As Trate1,
		A.MonthKBQty2,
		A.DateKBQty2,
		Case A.MonthKBQty2 When 0 Then 0.0 Else Round( A.DateKBQty2*1.0 / A.MonthKBQty2 * 100.0 , 2) End As Drate2,
		A.TimeKBQty2,
		Case A.MonthKBQty2 When 0 Then 0.0 Else Round( A.TimeKBQty2*1.0 / A.MonthKBQty2 * 100.0 , 2) End As Trate2,
		A.MonthKBQty3,
		A.DateKBQty3,
		Case A.MonthKBQty3 When 0 Then 0.0 Else Round( A.DateKBQty3*1.0 / A.MonthKBQty3 * 100.0 , 2) End As Drate3,
		A.TimeKBQty3,
		Case A.MonthKBQty3 When 0 Then 0.0 Else Round( A.TimeKBQty3*1.0 / A.MonthKBQty3 * 100.0 , 2) End As Trate3,
		A.MonthKBQty4,
		A.DateKBQty4,
		Case A.MonthKBQty4 When 0 Then 0.0 Else Round( A.DateKBQty4*1.0 / A.MonthKBQty4 * 100.0 , 2) End As Drate4,
		A.TimeKBQty4,
		Case A.MonthKBQty4 When 0 Then 0.0 Else Round( A.TimeKBQty4*1.0 / A.MonthKBQty4 * 100.0 , 2) End As Trate4,
		A.MonthKBQty5,
		A.DateKBQty5,
		Case A.MonthKBQty5 When 0 Then 0.0 Else Round( A.DateKBQty5*1.0 / A.MonthKBQty5 * 100.0 , 2) End As Drate5,
		A.TimeKBQty5,
		Case A.MonthKBQty5 When 0 Then 0.0 Else Round( A.TimeKBQty5*1.0 / A.MonthKBQty5 * 100.0 , 2) End As Trate5,
		A.MonthKBQty6,
		A.DateKBQty6,
		Case A.MonthKBQty6 When 0 Then 0.0 Else Round( A.DateKBQty6*1.0 / A.MonthKBQty6 * 100.0 , 2) End As Drate6,
		A.TimeKBQty6,
		Case A.MonthKBQty6 When 0 Then 0.0 Else Round( A.TimeKBQty6*1.0 / A.MonthKBQty6 * 100.0 , 2) End As Trate6,
		A.MonthKBQty7,
		A.DateKBQty7,
		Case A.MonthKBQty7 When 0 Then 0.0 Else Round( A.DateKBQty7*1.0 / A.MonthKBQty7 * 100.0 , 2) End As Drate7,
		A.TimeKBQty7,
		Case A.MonthKBQty7 When 0 Then 0.0 Else Round( A.TimeKBQty7*1.0 / A.MonthKBQty7 * 100.0 , 2) End As Trate7,
		A.MonthKBQty8,
		A.DateKBQty8,
		Case A.MonthKBQty8 When 0 Then 0.0 Else Round( A.DateKBQty8*1.0 / A.MonthKBQty8 * 100.0 , 2) End As Drate8,
		A.TimeKBQty8,
		Case A.MonthKBQty8 When 0 Then 0.0 Else Round( A.TimeKBQty8*1.0 / A.MonthKBQty8 * 100.0 , 2) End As Trate8,
		A.MonthKBQty9,
		A.DateKBQty9,
		Case A.MonthKBQty9 When 0 Then 0.0 Else Round( A.DateKBQty9*1.0 / A.MonthKBQty9 * 100.0 , 2) End As Drate9,
		A.TimeKBQty9,
		Case A.MonthKBQty9 When 0 Then 0.0 Else Round( A.TimeKBQty9*1.0 / A.MonthKBQty9 * 100.0 , 2) End As Trate9,
		A.MonthKBQty10,
		A.DateKBQty10,
		Case A.MonthKBQty10 When 0 Then 0.0 Else Round( A.DateKBQty10*1.0 / A.MonthKBQty10 * 100.0 , 2) End As Drate10,
		A.TimeKBQty10,
		Case A.MonthKBQty10 When 0 Then 0.0 Else Round( A.TimeKBQty10*1.0 / A.MonthKBQty10 * 100.0 , 2) End As Trate10,
		A.MonthKBQty11,
		A.DateKBQty11,
		Case A.MonthKBQty11 When 0 Then 0.0 Else Round( A.DateKBQty11*1.0 / A.MonthKBQty11 * 100.0 , 2) End As Drate11,
		A.TimeKBQty11,
		Case A.MonthKBQty11 When 0 Then 0.0 Else Round( A.TimeKBQty11*1.0 / A.MonthKBQty11 * 100.0 , 2) End As Trate11,
		A.MonthKBQty12,
		A.DateKBQty12,
		Case A.MonthKBQty12 When 0 Then 0.0 Else Round( A.DateKBQty12*1.0 / A.MonthKBQty12 * 100.0 , 2) End As Drate12,
		A.TimeKBQty12,
		Case A.MonthKBQty12 When 0 Then 0.0 Else Round( A.TimeKBQty12*1.0 / A.MonthKBQty12 * 100.0 , 2) End As Trate12,
		A.MonthKBQty1 + A.MonthKBQty2 + A.MonthKBQty3 + A.MonthKBQty4 + A.MonthKBQty5 + A.MonthKBQty6 + A.MonthKBQty7 + A.MonthKBQty8 + A.MonthKBQty9 + A.MonthKBQty10 + A.MonthKBQty11 + A.MonthKBQty12 As MonthKBQty13,
		A.DateKBQty1 + A.DateKBQty2 + A.DateKBQty3 + A.DateKBQty4 + A.DateKBQty5 + A.DateKBQty6 + A.DateKBQty7 + A.DateKBQty8 + A.DateKBQty9 + A.DateKBQty10 + A.DateKBQty11 + A.DateKBQty12 As DateKBQty13,
		Round( (A.DateKBQty1 + A.DateKBQty2 + A.DateKBQty3 + A.DateKBQty4 + A.DateKBQty5 + A.DateKBQty6 + A.DateKBQty7 + A.DateKBQty8 + A.DateKBQty9 + A.DateKBQty10 + A.DateKBQty11 + A.DateKBQty12 )*1.0 / (A.MonthKBQty1 + A.MonthKBQty2 + A.MonthKBQty3 + A.MonthKBQty4 + A.MonthKBQty5 + A.MonthKBQty6 + A.MonthKBQty7 + A.MonthKBQty8 + A.MonthKBQty9 + A.MonthKBQty10 + A.MonthKBQty11 + A.MonthKBQty12) * 100.0, 2 ) As Drate13,
		A.TimeKBQty1 + A.TimeKBQty2 + A.TimeKBQty3 + A.TimeKBQty4 + A.TimeKBQty5 + A.TimeKBQty6 + A.TimeKBQty7 + A.TimeKBQty8 + A.TimeKBQty9 + A.TimeKBQty10 + A.TimeKBQty11 + A.TimeKBQty12 As TimeKBQty13,
		Round( (A.TimeKBQty1 + A.TimeKBQty2 + A.TimeKBQty3 + A.TimeKBQty4 + A.TimeKBQty5 + A.TimeKBQty6 + A.TimeKBQty7 + A.TimeKBQty8 + A.TimeKBQty9 + A.TimeKBQty10 + A.TimeKBQty11 + A.TimeKBQty12 )*1.0 / (A.MonthKBQty1 + A.MonthKBQty2 + A.MonthKBQty3 + A.MonthKBQty4 + A.MonthKBQty5 + A.MonthKBQty6 + A.MonthKBQty7 + A.MonthKBQty8 + A.MonthKBQty9 + A.MonthKBQty10 + A.MonthKBQty11 + A.MonthKBQty12) * 100.0, 2 ) As Trate13
    FROM	#PARTKBCOUNT_tmp	A,
		TMSTAREA		B,
		TMSTDIVISION		C
   Where	--(A.MonthKBQty1 + A.MonthKBQty2 + A.MonthKBQty3 + A.MonthKBQty4 + A.MonthKBQty5 + A.MonthKBQty6 + A.MonthKBQty7 + A.MonthKBQty8 + A.MonthKBQty9 + A.MonthKBQty10 + A.MonthKBQty11 + A.MonthKBQty12) > 0  And
		A.AreaCode 	= B.AreaCode 		And
		A.AreaCode 	= C.AreaCode 		And
		A.DivisionCode 	= C.DivisionCode
		
Union
  SELECT 	A.AreaCode,			--1
		'Z'	As DivisionCode,	--2
		100 As SortOrder,		--3	
		B.AreaName,	
		'소계'	As DivisionName,	
		A.MonthKBQty1,
		A.DateKBQty1,
		Case A.MonthKBQty1 When 0 Then 0.0 Else Round( A.DateKBQty1*1.0 / A.MonthKBQty1 * 100.0 , 2) End As Drate1,
		A.TimeKBQty1,
		Case A.MonthKBQty1 When 0 Then 0.0 Else Round( A.TimeKBQty1*1.0 / A.MonthKBQty1 * 100.0 , 2) End As Trate1,
		A.MonthKBQty2,
		A.DateKBQty2,
		Case A.MonthKBQty2 When 0 Then 0.0 Else Round( A.DateKBQty2*1.0 / A.MonthKBQty2 * 100.0 , 2) End As Drate2,
		A.TimeKBQty2,
		Case A.MonthKBQty2 When 0 Then 0.0 Else Round( A.TimeKBQty2*1.0 / A.MonthKBQty2 * 100.0 , 2) End As Trate2,
		A.MonthKBQty3,
		A.DateKBQty3,
		Case A.MonthKBQty3 When 0 Then 0.0 Else Round( A.DateKBQty3*1.0 / A.MonthKBQty3 * 100.0 , 2) End As Drate3,
		A.TimeKBQty3,
		Case A.MonthKBQty3 When 0 Then 0.0 Else Round( A.TimeKBQty3*1.0 / A.MonthKBQty3 * 100.0 , 2) End As Trate3,
		A.MonthKBQty4,
		A.DateKBQty4,
		Case A.MonthKBQty4 When 0 Then 0.0 Else Round( A.DateKBQty4*1.0 / A.MonthKBQty4 * 100.0 , 2) End As Drate4,
		A.TimeKBQty4,
		Case A.MonthKBQty4 When 0 Then 0.0 Else Round( A.TimeKBQty4*1.0 / A.MonthKBQty4 * 100.0 , 2) End As Trate4,
		A.MonthKBQty5,
		A.DateKBQty5,
		Case A.MonthKBQty5 When 0 Then 0.0 Else Round( A.DateKBQty5*1.0 / A.MonthKBQty5 * 100.0 , 2) End As Drate5,
		A.TimeKBQty5,
		Case A.MonthKBQty5 When 0 Then 0.0 Else Round( A.TimeKBQty5*1.0 / A.MonthKBQty5 * 100.0 , 2) End As Trate5,
		A.MonthKBQty6,
		A.DateKBQty6,
		Case A.MonthKBQty6 When 0 Then 0.0 Else Round( A.DateKBQty6*1.0 / A.MonthKBQty6 * 100.0 , 2) End As Drate6,
		A.TimeKBQty6,
		Case A.MonthKBQty6 When 0 Then 0.0 Else Round( A.TimeKBQty6*1.0 / A.MonthKBQty6 * 100.0 , 2) End As Trate6,
		A.MonthKBQty7,
		A.DateKBQty7,
		Case A.MonthKBQty7 When 0 Then 0.0 Else Round( A.DateKBQty7*1.0 / A.MonthKBQty7 * 100.0 , 2) End As Drate7,
		A.TimeKBQty7,
		Case A.MonthKBQty7 When 0 Then 0.0 Else Round( A.TimeKBQty7*1.0 / A.MonthKBQty7 * 100.0 , 2) End As Trate7,
		A.MonthKBQty8,
		A.DateKBQty8,
		Case A.MonthKBQty8 When 0 Then 0.0 Else Round( A.DateKBQty8*1.0 / A.MonthKBQty8 * 100.0 , 2) End As Drate8,
		A.TimeKBQty8,
		Case A.MonthKBQty8 When 0 Then 0.0 Else Round( A.TimeKBQty8*1.0 / A.MonthKBQty8 * 100.0 , 2) End As Trate8,
		A.MonthKBQty9,
		A.DateKBQty9,
		Case A.MonthKBQty9 When 0 Then 0.0 Else Round( A.DateKBQty9*1.0 / A.MonthKBQty9 * 100.0 , 2) End As Drate9,
		A.TimeKBQty9,
		Case A.MonthKBQty9 When 0 Then 0.0 Else Round( A.TimeKBQty9*1.0 / A.MonthKBQty9 * 100.0 , 2) End As Trate9,
		A.MonthKBQty10,
		A.DateKBQty10,
		Case A.MonthKBQty10 When 0 Then 0.0 Else Round( A.DateKBQty10*1.0 / A.MonthKBQty10 * 100.0 , 2) End As Drate10,
		A.TimeKBQty10,
		Case A.MonthKBQty10 When 0 Then 0.0 Else Round( A.TimeKBQty10*1.0 / A.MonthKBQty10 * 100.0 , 2) End As Trate10,
		A.MonthKBQty11,
		A.DateKBQty11,
		Case A.MonthKBQty11 When 0 Then 0.0 Else Round( A.DateKBQty11*1.0 / A.MonthKBQty11 * 100.0 , 2) End As Drate11,
		A.TimeKBQty11,
		Case A.MonthKBQty11 When 0 Then 0.0 Else Round( A.TimeKBQty11*1.0 / A.MonthKBQty11 * 100.0 , 2) End As Trate11,
		A.MonthKBQty12,
		A.DateKBQty12,
		Case A.MonthKBQty12 When 0 Then 0.0 Else Round( A.DateKBQty12*1.0 / A.MonthKBQty12 * 100.0 , 2) End As Drate12,
		A.TimeKBQty12,
		Case A.MonthKBQty12 When 0 Then 0.0 Else Round( A.TimeKBQty12*1.0 / A.MonthKBQty12 * 100.0 , 2) End As Trate12,
		A.MonthKBQty1 + A.MonthKBQty2 + A.MonthKBQty3 + A.MonthKBQty4 + A.MonthKBQty5 + A.MonthKBQty6 + A.MonthKBQty7 + A.MonthKBQty8 + A.MonthKBQty9 + A.MonthKBQty10 + A.MonthKBQty11 + A.MonthKBQty12 As MonthKBQty13,
		A.DateKBQty1 + A.DateKBQty2 + A.DateKBQty3 + A.DateKBQty4 + A.DateKBQty5 + A.DateKBQty6 + A.DateKBQty7 + A.DateKBQty8 + A.DateKBQty9 + A.DateKBQty10 + A.DateKBQty11 + A.DateKBQty12 As DateKBQty13,
		Round( (A.DateKBQty1 + A.DateKBQty2 + A.DateKBQty3 + A.DateKBQty4 + A.DateKBQty5 + A.DateKBQty6 + A.DateKBQty7 + A.DateKBQty8 + A.DateKBQty9 + A.DateKBQty10 + A.DateKBQty11 + A.DateKBQty12 )*1.0 / (A.MonthKBQty1 + A.MonthKBQty2 + A.MonthKBQty3 + A.MonthKBQty4 + A.MonthKBQty5 + A.MonthKBQty6 + A.MonthKBQty7 + A.MonthKBQty8 + A.MonthKBQty9 + A.MonthKBQty10 + A.MonthKBQty11 + A.MonthKBQty12) * 100.0, 2 ) As Drate13,
		A.TimeKBQty1 + A.TimeKBQty2 + A.TimeKBQty3 + A.TimeKBQty4 + A.TimeKBQty5 + A.TimeKBQty6 + A.TimeKBQty7 + A.TimeKBQty8 + A.TimeKBQty9 + A.TimeKBQty10 + A.TimeKBQty11 + A.TimeKBQty12 As TimeKBQty13,
		Round( (A.TimeKBQty1 + A.TimeKBQty2 + A.TimeKBQty3 + A.TimeKBQty4 + A.TimeKBQty5 + A.TimeKBQty6 + A.TimeKBQty7 + A.TimeKBQty8 + A.TimeKBQty9 + A.TimeKBQty10 + A.TimeKBQty11 + A.TimeKBQty12 )*1.0 / (A.MonthKBQty1 + A.MonthKBQty2 + A.MonthKBQty3 + A.MonthKBQty4 + A.MonthKBQty5 + A.MonthKBQty6 + A.MonthKBQty7 + A.MonthKBQty8 + A.MonthKBQty9 + A.MonthKBQty10 + A.MonthKBQty11 + A.MonthKBQty12) * 100.0, 2 ) As Trate13
    FROM	#PARTKBCOUNTSUM_tmp	A,
		TMSTAREA		B
   WHERE	--(A.MonthKBQty1 + A.MonthKBQty2 + A.MonthKBQty3 + A.MonthKBQty4 + A.MonthKBQty5 + A.MonthKBQty6 + A.MonthKBQty7 + A.MonthKBQty8 + A.MonthKBQty9 + A.MonthKBQty10 + A.MonthKBQty11 + A.MonthKBQty12) > 0  And
		A.AreaCode = B.AreaCode		
Union
  SELECT 	'Z'	As AreaCode,	--1
		'Z'	As DivisionCode,--2
		101	As SortOrder,	--3
		'전사'	As AreaName,	
		'    '	As DivisionName,	
		A.MonthKBQty1,
		A.DateKBQty1,
		Case A.MonthKBQty1 When 0 Then 0.0 Else Round( A.DateKBQty1*1.0 / A.MonthKBQty1 * 100.0 , 2) End As Drate1,
		A.TimeKBQty1,
		Case A.MonthKBQty1 When 0 Then 0.0 Else Round( A.TimeKBQty1*1.0 / A.MonthKBQty1 * 100.0 , 2) End As Trate1,
		A.MonthKBQty2,
		A.DateKBQty2,
		Case A.MonthKBQty2 When 0 Then 0.0 Else Round( A.DateKBQty2*1.0 / A.MonthKBQty2 * 100.0 , 2) End As Drate2,
		A.TimeKBQty2,
		Case A.MonthKBQty2 When 0 Then 0.0 Else Round( A.TimeKBQty2*1.0 / A.MonthKBQty2 * 100.0 , 2) End As Trate2,
		A.MonthKBQty3,
		A.DateKBQty3,
		Case A.MonthKBQty3 When 0 Then 0.0 Else Round( A.DateKBQty3*1.0 / A.MonthKBQty3 * 100.0 , 2) End As Drate3,
		A.TimeKBQty3,
		Case A.MonthKBQty3 When 0 Then 0.0 Else Round( A.TimeKBQty3*1.0 / A.MonthKBQty3 * 100.0 , 2) End As Trate3,
		A.MonthKBQty4,
		A.DateKBQty4,
		Case A.MonthKBQty4 When 0 Then 0.0 Else Round( A.DateKBQty4*1.0 / A.MonthKBQty4 * 100.0 , 2) End As Drate4,
		A.TimeKBQty4,
		Case A.MonthKBQty4 When 0 Then 0.0 Else Round( A.TimeKBQty4*1.0 / A.MonthKBQty4 * 100.0 , 2) End As Trate4,
		A.MonthKBQty5,
		A.DateKBQty5,
		Case A.MonthKBQty5 When 0 Then 0.0 Else Round( A.DateKBQty5*1.0 / A.MonthKBQty5 * 100.0 , 2) End As Drate5,
		A.TimeKBQty5,
		Case A.MonthKBQty5 When 0 Then 0.0 Else Round( A.TimeKBQty5*1.0 / A.MonthKBQty5 * 100.0 , 2) End As Trate5,
		A.MonthKBQty6,
		A.DateKBQty6,
		Case A.MonthKBQty6 When 0 Then 0.0 Else Round( A.DateKBQty6*1.0 / A.MonthKBQty6 * 100.0 , 2) End As Drate6,
		A.TimeKBQty6,
		Case A.MonthKBQty6 When 0 Then 0.0 Else Round( A.TimeKBQty6*1.0 / A.MonthKBQty6 * 100.0 , 2) End As Trate6,
		A.MonthKBQty7,
		A.DateKBQty7,
		Case A.MonthKBQty7 When 0 Then 0.0 Else Round( A.DateKBQty7*1.0 / A.MonthKBQty7 * 100.0 , 2) End As Drate7,
		A.TimeKBQty7,
		Case A.MonthKBQty7 When 0 Then 0.0 Else Round( A.TimeKBQty7*1.0 / A.MonthKBQty7 * 100.0 , 2) End As Trate7,
		A.MonthKBQty8,
		A.DateKBQty8,
		Case A.MonthKBQty8 When 0 Then 0.0 Else Round( A.DateKBQty8*1.0 / A.MonthKBQty8 * 100.0 , 2) End As Drate8,
		A.TimeKBQty8,
		Case A.MonthKBQty8 When 0 Then 0.0 Else Round( A.TimeKBQty8*1.0 / A.MonthKBQty8 * 100.0 , 2) End As Trate8,
		A.MonthKBQty9,
		A.DateKBQty9,
		Case A.MonthKBQty9 When 0 Then 0.0 Else Round( A.DateKBQty9*1.0 / A.MonthKBQty9 * 100.0 , 2) End As Drate9,
		A.TimeKBQty9,
		Case A.MonthKBQty9 When 0 Then 0.0 Else Round( A.TimeKBQty9*1.0 / A.MonthKBQty9 * 100.0 , 2) End As Trate9,
		A.MonthKBQty10,
		A.DateKBQty10,
		Case A.MonthKBQty10 When 0 Then 0.0 Else Round( A.DateKBQty10*1.0 / A.MonthKBQty10 * 100.0 , 2) End As Drate10,
		A.TimeKBQty10,
		Case A.MonthKBQty10 When 0 Then 0.0 Else Round( A.TimeKBQty10*1.0 / A.MonthKBQty10 * 100.0 , 2) End As Trate10,
		A.MonthKBQty11,
		A.DateKBQty11,
		Case A.MonthKBQty11 When 0 Then 0.0 Else Round( A.DateKBQty11*1.0 / A.MonthKBQty11 * 100.0 , 2) End As Drate11,
		A.TimeKBQty11,
		Case A.MonthKBQty11 When 0 Then 0.0 Else Round( A.TimeKBQty11*1.0 / A.MonthKBQty11 * 100.0 , 2) End As Trate11,
		A.MonthKBQty12,
		A.DateKBQty12,
		Case A.MonthKBQty12 When 0 Then 0.0 Else Round( A.DateKBQty12*1.0 / A.MonthKBQty12 * 100.0 , 2) End As Drate12,
		A.TimeKBQty12,
		Case A.MonthKBQty12 When 0 Then 0.0 Else Round( A.TimeKBQty12*1.0 / A.MonthKBQty12 * 100.0 , 2) End As Trate12,
		A.MonthKBQty1 + A.MonthKBQty2 + A.MonthKBQty3 + A.MonthKBQty4 + A.MonthKBQty5 + A.MonthKBQty6 + A.MonthKBQty7 + A.MonthKBQty8 + A.MonthKBQty9 + A.MonthKBQty10 + A.MonthKBQty11 + A.MonthKBQty12 As MonthKBQty13,
		A.DateKBQty1 + A.DateKBQty2 + A.DateKBQty3 + A.DateKBQty4 + A.DateKBQty5 + A.DateKBQty6 + A.DateKBQty7 + A.DateKBQty8 + A.DateKBQty9 + A.DateKBQty10 + A.DateKBQty11 + A.DateKBQty12 As DateKBQty13,
		Round( (A.DateKBQty1 + A.DateKBQty2 + A.DateKBQty3 + A.DateKBQty4 + A.DateKBQty5 + A.DateKBQty6 + A.DateKBQty7 + A.DateKBQty8 + A.DateKBQty9 + A.DateKBQty10 + A.DateKBQty11 + A.DateKBQty12 )*1.0 / (A.MonthKBQty1 + A.MonthKBQty2 + A.MonthKBQty3 + A.MonthKBQty4 + A.MonthKBQty5 + A.MonthKBQty6 + A.MonthKBQty7 + A.MonthKBQty8 + A.MonthKBQty9 + A.MonthKBQty10 + A.MonthKBQty11 + A.MonthKBQty12) * 100.0, 2 ) As Drate13,
		A.TimeKBQty1 + A.TimeKBQty2 + A.TimeKBQty3 + A.TimeKBQty4 + A.TimeKBQty5 + A.TimeKBQty6 + A.TimeKBQty7 + A.TimeKBQty8 + A.TimeKBQty9 + A.TimeKBQty10 + A.TimeKBQty11 + A.TimeKBQty12 As TimeKBQty13,
		Round( (A.TimeKBQty1 + A.TimeKBQty2 + A.TimeKBQty3 + A.TimeKBQty4 + A.TimeKBQty5 + A.TimeKBQty6 + A.TimeKBQty7 + A.TimeKBQty8 + A.TimeKBQty9 + A.TimeKBQty10 + A.TimeKBQty11 + A.TimeKBQty12 )*1.0 / (A.MonthKBQty1 + A.MonthKBQty2 + A.MonthKBQty3 + A.MonthKBQty4 + A.MonthKBQty5 + A.MonthKBQty6 + A.MonthKBQty7 + A.MonthKBQty8 + A.MonthKBQty9 + A.MonthKBQty10 + A.MonthKBQty11 + A.MonthKBQty12) * 100.0, 2 ) As Trate13
    FROM	#PARTKBCOUNTTOT_tmp A
--   WHERE	(A.MonthKBQty1 + A.MonthKBQty2 + A.MonthKBQty3 + A.MonthKBQty4 + A.MonthKBQty5 + A.MonthKBQty6 + A.MonthKBQty7 + A.MonthKBQty8 + A.MonthKBQty9 + A.MonthKBQty10 + A.MonthKBQty11 + A.MonthKBQty12) > 0
Order By	1, 3

Drop Table	#PARTKBCOUNT_tmp
Drop Table	#PARTKBCOUNTSUM_tmp
Drop Table	#PARTKBCOUNTTOT_tmp

Set NoCount Off

End	-- End PROCEDURE
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

