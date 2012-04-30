USE [IPIS]
GO
/****** Object:  StoredProcedure [dbo].[sp_pism122i_01]    Script Date: 01/19/2012 15:49:46 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*************************/
/*     일별 생산실적( 경영지표보고 )     */
/*************************/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_pism122i_01]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_pism122i_01]
go

/*
Execute sp_pism122i_01
	@ps_area	= 'D',
	@ps_div		= 'A',
	@ps_stMonth	= '2012.01'
*/

CREATE    PROCEDURE [dbo].[sp_pism122i_01]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_stMonth	Char(7)		-- 기준년월
AS
BEGIN

Declare	@SQLString 	NVARCHAR(1500), 
	@cvtValue	Char(2),
	@Day		int,
	@DailyStatus	Char(1) ,
	@lastyear	Char(4) ,
	@workday varchar(10)

Set @lastYear 	= 	Cast ( Cast( substring(@ps_stMonth, 1, 4) as Numeric(4) ) - 1 as Char(4) )
Set @workday = @ps_stMonth + '%'

-- 해당일자에 생산실적이 없는 경우 해당일이 나타나지 않으므로 Temp Table 생성 

CREATE TABLE #Temp_realprod 
(
	AreaCode		Char(1)		not null,
	DivisionCode		Char(1)		not null,
	WorkCenter		Varchar(6)	not null,
	wcitemgroup		varchar(30)	null,
	ItemCode		VarChar(12)	not null,
	sublinecode		Varchar(7)	null,
	sublineno		char(1)		null,
	stmh			numeric(15,5)	null,
	day_01			int		null,
	day_02			int		null,
	day_03			int		null,
	day_04			int		null,
	day_05			int		null,
	day_06			int		null,
	day_07			int		null,
	day_08			int		null,
	day_09			int		null,
	day_10			int		null,
	day_11			int		null,
	day_12			int		null,
	day_13			int		null,
	day_14			int		null,
	day_15			int		null,
	day_16			int		null,
	day_17			int		null,
	day_18			int		null,
	day_19			int		null,
	day_20			int		null,
	day_21			int		null,
	day_22			int		null,
	day_23			int		null,
	day_24			int		null,
	day_25			int		null,
	day_26			int		null,
	day_27			int		null,
	day_28			int		null,
	day_29			int		null,
	day_30			int		null,
	day_31			int		null,
	actin_01			numeric(10,1)	null,
	actin_02			numeric(10,1)	null,
	actin_03			numeric(10,1)	null,
	actin_04			numeric(10,1)	null,
	actin_05			numeric(10,1)	null,
	actin_06			numeric(10,1)	null,
	actin_07			numeric(10,1)	null,
	actin_08			numeric(10,1)	null,
	actin_09			numeric(10,1)	null,
	actin_10			numeric(10,1)	null,
	actin_11			numeric(10,1)	null,
	actin_12			numeric(10,1)	null,
	actin_13			numeric(10,1)	null,
	actin_14			numeric(10,1)	null,
	actin_15			numeric(10,1)	null,
	actin_16			numeric(10,1)	null,
	actin_17			numeric(10,1)	null,
	actin_18			numeric(10,1)	null,
	actin_19			numeric(10,1)	null,
	actin_20			numeric(10,1)	null,
	actin_21			numeric(10,1)	null,
	actin_22			numeric(10,1)	null,
	actin_23			numeric(10,1)	null,
	actin_24			numeric(10,1)	null,
	actin_25			numeric(10,1)	null,
	actin_26			numeric(10,1)	null,
	actin_27			numeric(10,1)	null,
	actin_28			numeric(10,1)	null,
	actin_29			numeric(10,1)	null,
	actin_30			numeric(10,1)	null,
	actin_31			numeric(10,1)	null,
	actmh_01			numeric(15,5)	null,
	actmh_02			numeric(15,5)	null,
	actmh_03			numeric(15,5)	null,
	actmh_04			numeric(15,5)	null,
	actmh_05			numeric(15,5)	null,
	actmh_06			numeric(15,5)	null,
	actmh_07			numeric(15,5)	null,
	actmh_08			numeric(15,5)	null,
	actmh_09			numeric(15,5)	null,
	actmh_10			numeric(15,5)	null,
	actmh_11			numeric(15,5)	null,
	actmh_12			numeric(15,5)	null,
	actmh_13			numeric(15,5)	null,
	actmh_14			numeric(15,5)	null,
	actmh_15			numeric(15,5)	null,
	actmh_16			numeric(15,5)	null,
	actmh_17			numeric(15,5)	null,
	actmh_18			numeric(15,5)	null,
	actmh_19			numeric(15,5)	null,
	actmh_20			numeric(15,5)	null,
	actmh_21			numeric(15,5)	null,
	actmh_22			numeric(15,5)	null,
	actmh_23			numeric(15,5)	null,
	actmh_24			numeric(15,5)	null,
	actmh_25			numeric(15,5)	null,
	actmh_26			numeric(15,5)	null,
	actmh_27			numeric(15,5)	null,
	actmh_28			numeric(15,5)	null,
	actmh_29			numeric(15,5)	null,
	actmh_30			numeric(15,5)	null,
	actmh_31			numeric(15,5)	null,
	lpi_01			numeric(15,4)	null,
	lpi_02			numeric(15,4)	null,
	lpi_03			numeric(15,4)	null,
	lpi_04			numeric(15,4)	null,
	lpi_05			numeric(15,4)	null,
	lpi_06			numeric(15,4)	null,
	lpi_07			numeric(15,4)	null,
	lpi_08			numeric(15,4)	null,
	lpi_09			numeric(15,4)	null,
	lpi_10			numeric(15,4)	null,
	lpi_11			numeric(15,4)	null,
	lpi_12			numeric(15,4)	null,
	lpi_13			numeric(15,4)	null,
	lpi_14			numeric(15,4)	null,
	lpi_15			numeric(15,4)	null,
	lpi_16			numeric(15,4)	null,
	lpi_17			numeric(15,4)	null,
	lpi_18			numeric(15,4)	null,
	lpi_19			numeric(15,4)	null,
	lpi_20			numeric(15,4)	null,
	lpi_21			numeric(15,4)	null,
	lpi_22			numeric(15,4)	null,
	lpi_23			numeric(15,4)	null,
	lpi_24			numeric(15,4)	null,
	lpi_25			numeric(15,4)	null,
	lpi_26			numeric(15,4)	null,
	lpi_27			numeric(15,4)	null,
	lpi_28			numeric(15,4)	null,
	lpi_29			numeric(15,4)	null,
	lpi_30			numeric(15,4)	null,
	lpi_31			numeric(15,4)	null
)

Insert Into #Temp_realprod ( AreaCode, DivisionCode, WorkCenter, Wcitemgroup,Itemcode,sublinecode,sublineno,stmh ) 
SELECT 	distinct a.AreaCode,a.DivisionCode,a.WorkCenter,rtrim(a.wcitemgroup),a.itemcode,rtrim(a.sublinecode),a.sublineno,
	isnull(CASE SUBSTRING(a.WorkDay,6,2) 
		WHEN '01' THEN STMH01
		WHEN '02' THEN STMH02
		WHEN '03' THEN STMH03
		WHEN '04' THEN STMH04
		WHEN '05' THEN STMH05
		WHEN '06' THEN STMH06
		WHEN '07' THEN STMH07
		WHEN '08' THEN STMH08
		WHEN '09' THEN STMH09
		WHEN '10' THEN STMH10
		WHEN '11' THEN STMH11
		WHEN '12' THEN STMH12 END , 0) 
FROM 	TMHREALPROD A,tmhstandard B 
WHERE	( a.AreaCode 	= @ps_area ) AND  
	( a.DivisionCode 	= @ps_div ) AND  
	( substring(a.WorkDay, 1, 7) = @ps_stMonth ) AND
	( A.WorkCenter 	*= b.WorkCenter ) And 
 	( A.ItemCode 	*= b.ItemCode ) And 
	( A.subLineCode 	*= b.subLineCode ) And 
	( A.subLineNo 	*= b.subLineNo ) And 
	( A.AreaCode 	*= b.AreaCode ) And 
	( A.DivisionCode 	*= b.DivisionCode ) And 	
	( b.styear	=  @lastyear	) 
--Group By a.AreaCode, a.DivisionCode, a.WorkCenter, a.wcitemgroup,a.itemcode,a.sublinecode,a.sublineno

	
Set @Day = 1 
WHILE @Day <= 31
BEGIN
	Execute sp_pism000_cvtValue @pi_value = @Day, @ps_cvtValue = @cvtValue	Output 
	If @@Error <> 0 Goto Exit_pr 

	Begin 
	Set @SQLString = "Update #Temp_realprod " + 
		              "Set day_" + @cvtValue + " = ( Select sum(IsNull(A.daypQty,0) + IsNull(A.nightpQty,0)) " + 
			  				    "From TMHREALPROD A, TMHDAILYSTATUS B " + 
							   "Where ( A.AreaCode = B.AreaCode ) And " + 
								 "( A.DivisionCode = B.DivisionCode ) And " + 
								 "( A.WorkCenter = B.WorkCenter ) And " + 
								 "( A.WorkDay = B.WorkDay ) And " + 
								 "( A.AreaCode = '" + @ps_area + "' ) And " + 
								 "( A.DivisionCode = '" + @ps_div + "' ) And " + 
								 "( A.WorkCenter = #Temp_realprod.WorkCenter ) And " + 
								 "( A.wcitemgroup = #Temp_realprod.wcitemgroup ) And " + 
								 "( A.itemcode = #Temp_realprod.itemcode ) And " +
								 "( A.sublinecode = #Temp_realprod.sublinecode ) And " +
								 "( A.sublineno = #Temp_realprod.sublineno ) And " +
								 "( A.WorkDay = '" + @ps_stMonth + "." + @cvtValue + "' ) And " + 
									 "( IsNull(B.DailyStatus,'0') = '1' ) ), "  + 
				"actin_" + @cvtValue + " 	= ( Select sum(IsNull(A.actinmh,0)) " + 
			  				    "From TMHREALPROD A, TMHDAILYSTATUS B " + 
							   "Where ( A.AreaCode = B.AreaCode ) And " + 
								 "( A.DivisionCode = B.DivisionCode ) And " + 
								 "( A.WorkCenter = B.WorkCenter ) And " + 
								 "( A.WorkDay = B.WorkDay ) And " + 
								 "( A.AreaCode = '" + @ps_area + "' ) And " + 
								 "( A.DivisionCode = '" + @ps_div + "' ) And " + 
								 "( A.WorkCenter = #Temp_realprod.WorkCenter ) And " + 
								 "( A.wcitemgroup = #Temp_realprod.wcitemgroup ) And " + 
								 "( A.itemcode = #Temp_realprod.itemcode ) And " +
								 "( A.sublinecode = #Temp_realprod.sublinecode ) And " +
								 "( A.sublineno = #Temp_realprod.sublineno ) And " +
								 "( A.WorkDay = '" + @ps_stMonth + "." + @cvtValue + "' ) And " + 
									 "( IsNull(B.DailyStatus,'0') = '1' ) ) " 

 		EXEC sp_executesql @SQLString
 		If @@Error <> 0 Goto Exit_pr
		End

	Set @Day = @Day + 1 
END

--기준mh, LPI 계산
Update #Temp_realprod
Set actmh_01 = (stmh * IsNull(day_01,0)), lpi_01 = CASE WHEN IsNull(actin_01,0) = 0 THEN 0 ELSE (stmh * IsNull(day_01,0)) * 100 / actin_01 END,
  actmh_02 = (stmh * IsNull(day_02,0)), lpi_02 = CASE WHEN IsNull(actin_02,0) = 0 THEN 0 ELSE (stmh * IsNull(day_02,0)) * 100 / actin_02 END,
  actmh_03 = (stmh * IsNull(day_03,0)), lpi_03 = CASE WHEN IsNull(actin_03,0) = 0 THEN 0 ELSE (stmh * IsNull(day_03,0)) * 100 / actin_03 END,
  actmh_04 = (stmh * IsNull(day_04,0)), lpi_04 = CASE WHEN IsNull(actin_04,0) = 0 THEN 0 ELSE (stmh * IsNull(day_04,0)) * 100 / actin_04 END,
  actmh_05 = (stmh * IsNull(day_05,0)), lpi_05 = CASE WHEN IsNull(actin_05,0) = 0 THEN 0 ELSE (stmh * IsNull(day_05,0)) * 100 / actin_05 END,
  actmh_06 = (stmh * IsNull(day_06,0)), lpi_06 = CASE WHEN IsNull(actin_06,0) = 0 THEN 0 ELSE (stmh * IsNull(day_06,0)) * 100 / actin_06 END,
  actmh_07 = (stmh * IsNull(day_07,0)), lpi_07 = CASE WHEN IsNull(actin_07,0) = 0 THEN 0 ELSE (stmh * IsNull(day_07,0)) * 100 / actin_07 END,
  actmh_08 = (stmh * IsNull(day_08,0)), lpi_08 = CASE WHEN IsNull(actin_08,0) = 0 THEN 0 ELSE (stmh * IsNull(day_08,0)) * 100 / actin_08 END,
  actmh_09 = (stmh * IsNull(day_09,0)), lpi_09 = CASE WHEN IsNull(actin_09,0) = 0 THEN 0 ELSE (stmh * IsNull(day_09,0)) * 100 / actin_09 END,
  actmh_10 = (stmh * IsNull(day_10,0)), lpi_10 = CASE WHEN IsNull(actin_10,0) = 0 THEN 0 ELSE (stmh * IsNull(day_10,0)) * 100 / actin_10 END,
  actmh_11 = (stmh * IsNull(day_11,0)), lpi_11 = CASE WHEN IsNull(actin_11,0) = 0 THEN 0 ELSE (stmh * IsNull(day_11,0)) * 100 / actin_11 END,
  actmh_12 = (stmh * IsNull(day_12,0)), lpi_12 = CASE WHEN IsNull(actin_12,0) = 0 THEN 0 ELSE (stmh * IsNull(day_12,0)) * 100 / actin_12 END,
  actmh_13 = (stmh * IsNull(day_13,0)), lpi_13 = CASE WHEN IsNull(actin_13,0) = 0 THEN 0 ELSE (stmh * IsNull(day_13,0)) * 100 / actin_13 END,
  actmh_14 = (stmh * IsNull(day_14,0)), lpi_14 = CASE WHEN IsNull(actin_14,0) = 0 THEN 0 ELSE (stmh * IsNull(day_14,0)) * 100 / actin_14 END,
  actmh_15 = (stmh * IsNull(day_15,0)), lpi_15 = CASE WHEN IsNull(actin_15,0) = 0 THEN 0 ELSE (stmh * IsNull(day_15,0)) * 100 / actin_15 END,
  actmh_16 = (stmh * IsNull(day_16,0)), lpi_16 = CASE WHEN IsNull(actin_16,0) = 0 THEN 0 ELSE (stmh * IsNull(day_16,0)) * 100 / actin_16 END,
  actmh_17 = (stmh * IsNull(day_17,0)), lpi_17 = CASE WHEN IsNull(actin_17,0) = 0 THEN 0 ELSE (stmh * IsNull(day_17,0)) * 100 / actin_17 END,
  actmh_18 = (stmh * IsNull(day_18,0)), lpi_18 = CASE WHEN IsNull(actin_18,0) = 0 THEN 0 ELSE (stmh * IsNull(day_18,0)) * 100 / actin_18 END,
  actmh_19 = (stmh * IsNull(day_19,0)), lpi_19 = CASE WHEN IsNull(actin_19,0) = 0 THEN 0 ELSE (stmh * IsNull(day_19,0)) * 100 / actin_19 END,
  actmh_20 = (stmh * IsNull(day_20,0)), lpi_20 = CASE WHEN IsNull(actin_20,0) = 0 THEN 0 ELSE (stmh * IsNull(day_20,0)) * 100 / actin_20 END,
  actmh_21 = (stmh * IsNull(day_21,0)), lpi_21 = CASE WHEN IsNull(actin_21,0) = 0 THEN 0 ELSE (stmh * IsNull(day_21,0)) * 100 / actin_21 END,
  actmh_22 = (stmh * IsNull(day_22,0)), lpi_22 = CASE WHEN IsNull(actin_22,0) = 0 THEN 0 ELSE (stmh * IsNull(day_22,0)) * 100 / actin_22 END,
  actmh_23 = (stmh * IsNull(day_23,0)), lpi_23 = CASE WHEN IsNull(actin_23,0) = 0 THEN 0 ELSE (stmh * IsNull(day_23,0)) * 100 / actin_23 END,
  actmh_24 = (stmh * IsNull(day_24,0)), lpi_24 = CASE WHEN IsNull(actin_24,0) = 0 THEN 0 ELSE (stmh * IsNull(day_24,0)) * 100 / actin_24 END,
  actmh_25 = (stmh * IsNull(day_25,0)), lpi_25 = CASE WHEN IsNull(actin_25,0) = 0 THEN 0 ELSE (stmh * IsNull(day_25,0)) * 100 / actin_25 END,
  actmh_26 = (stmh * IsNull(day_26,0)), lpi_26 = CASE WHEN IsNull(actin_26,0) = 0 THEN 0 ELSE (stmh * IsNull(day_26,0)) * 100 / actin_26 END,
  actmh_27 = (stmh * IsNull(day_27,0)), lpi_27 = CASE WHEN IsNull(actin_27,0) = 0 THEN 0 ELSE (stmh * IsNull(day_27,0)) * 100 / actin_27 END,
  actmh_28 = (stmh * IsNull(day_28,0)), lpi_28 = CASE WHEN IsNull(actin_28,0) = 0 THEN 0 ELSE (stmh * IsNull(day_28,0)) * 100 / actin_28 END,
  actmh_29 = (stmh * IsNull(day_29,0)), lpi_29 = CASE WHEN IsNull(actin_29,0) = 0 THEN 0 ELSE (stmh * IsNull(day_29,0)) * 100 / actin_29 END,
  actmh_30 = (stmh * IsNull(day_30,0)), lpi_30 = CASE WHEN IsNull(actin_30,0) = 0 THEN 0 ELSE (stmh * IsNull(day_30,0)) * 100 / actin_30 END,
  actmh_31 = (stmh * IsNull(day_31,0)), lpi_31 = CASE WHEN IsNull(actin_31,0) = 0 THEN 0 ELSE (stmh * IsNull(day_31,0)) * 100 / actin_31 END

Select ' ' as areacode, ' ' as divisioncode, 'Total' as workcenter, 'Total' as workcentername,
  '1' as sts_01,
  '1' as sts_02,
  '1' as sts_03,
  '1' as sts_04,
  '1' as sts_05,
  '1' as sts_06,
  '1' as sts_07,
  '1' as sts_08,
  '1' as sts_09,
  '1' as sts_10,
  '1' as sts_11,
  '1' as sts_12,
  '1' as sts_13,
  '1' as sts_14,
  '1' as sts_15,
  '1' as sts_16,
  '1' as sts_17,
  '1' as sts_18,
  '1' as sts_19,
  '1' as sts_20,
  '1' as sts_21,
  '1' as sts_22,
  '1' as sts_23,
  '1' as sts_24,
  '1' as sts_25,
  '1' as sts_26,
  '1' as sts_27,
  '1' as sts_28,
  '1' as sts_29,
  '1' as sts_30,
  '1' as sts_31,
  Sum(IsNull(A.actin_01,0)) as actin_01,
	Sum(IsNull(A.actin_02,0)) as actin_02,
	Sum(IsNull(A.actin_03,0)) as actin_03,
	Sum(IsNull(A.actin_04,0)) as actin_04,
	Sum(IsNull(A.actin_05,0)) as actin_05,
	Sum(IsNull(A.actin_06,0)) as actin_06,
	Sum(IsNull(A.actin_07,0)) as actin_07,
	Sum(IsNull(A.actin_08,0)) as actin_08,
	Sum(IsNull(A.actin_09,0)) as actin_09,
	Sum(IsNull(A.actin_10,0)) as actin_10,
	Sum(IsNull(A.actin_11,0)) as actin_11,
	Sum(IsNull(A.actin_12,0)) as actin_12,
	Sum(IsNull(A.actin_13,0)) as actin_13,
	Sum(IsNull(A.actin_14,0)) as actin_14,
	Sum(IsNull(A.actin_15,0)) as actin_15,
	Sum(IsNull(A.actin_16,0)) as actin_16,
	Sum(IsNull(A.actin_17,0)) as actin_17,
	Sum(IsNull(A.actin_18,0)) as actin_18,
	Sum(IsNull(A.actin_19,0)) as actin_19,
	Sum(IsNull(A.actin_20,0)) as actin_20,
	Sum(IsNull(A.actin_21,0)) as actin_21,
	Sum(IsNull(A.actin_22,0)) as actin_22,
	Sum(IsNull(A.actin_23,0)) as actin_23,
	Sum(IsNull(A.actin_24,0)) as actin_24,
	Sum(IsNull(A.actin_25,0)) as actin_25,
	Sum(IsNull(A.actin_26,0)) as actin_26,
	Sum(IsNull(A.actin_27,0)) as actin_27,
	Sum(IsNull(A.actin_28,0)) as actin_28,
	Sum(IsNull(A.actin_29,0)) as actin_29,
	Sum(IsNull(A.actin_30,0)) as actin_30,
	Sum(IsNull(A.actin_31,0)) as actin_31,
	Sum(IsNull(A.actmh_01,0)) as actmh_01,
	Sum(IsNull(A.actmh_02,0)) as actmh_02,
	Sum(IsNull(A.actmh_03,0)) as actmh_03,
	Sum(IsNull(A.actmh_04,0)) as actmh_04,
	Sum(IsNull(A.actmh_05,0)) as actmh_05,
	Sum(IsNull(A.actmh_06,0)) as actmh_06,
	Sum(IsNull(A.actmh_07,0)) as actmh_07,
	Sum(IsNull(A.actmh_08,0)) as actmh_08,
	Sum(IsNull(A.actmh_09,0)) as actmh_09,
	Sum(IsNull(A.actmh_10,0)) as actmh_10,
	Sum(IsNull(A.actmh_11,0)) as actmh_11,
	Sum(IsNull(A.actmh_12,0)) as actmh_12,
	Sum(IsNull(A.actmh_13,0)) as actmh_13,
	Sum(IsNull(A.actmh_14,0)) as actmh_14,
	Sum(IsNull(A.actmh_15,0)) as actmh_15,
	Sum(IsNull(A.actmh_16,0)) as actmh_16,
	Sum(IsNull(A.actmh_17,0)) as actmh_17,
	Sum(IsNull(A.actmh_18,0)) as actmh_18,
	Sum(IsNull(A.actmh_19,0)) as actmh_19,
	Sum(IsNull(A.actmh_20,0)) as actmh_20,
	Sum(IsNull(A.actmh_21,0)) as actmh_21,
	Sum(IsNull(A.actmh_22,0)) as actmh_22,
	Sum(IsNull(A.actmh_23,0)) as actmh_23,
	Sum(IsNull(A.actmh_24,0)) as actmh_24,
	Sum(IsNull(A.actmh_25,0)) as actmh_25,
	Sum(IsNull(A.actmh_26,0)) as actmh_26,
	Sum(IsNull(A.actmh_27,0)) as actmh_27,
	Sum(IsNull(A.actmh_28,0)) as actmh_28,
	Sum(IsNull(A.actmh_29,0)) as actmh_29,
	Sum(IsNull(A.actmh_30,0)) as actmh_30,
	Sum(IsNull(A.actmh_31,0)) as actmh_31,
	CASE WHEN Sum(IsNull(A.actin_01,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_01,0)) * 100 / Sum(IsNull(A.actin_01,0)) END as lpi_01,
	CASE WHEN Sum(IsNull(A.actin_02,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_02,0)) * 100 / Sum(IsNull(A.actin_02,0)) END as lpi_02,
	CASE WHEN Sum(IsNull(A.actin_03,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_03,0)) * 100 / Sum(IsNull(A.actin_03,0)) END as lpi_03,
	CASE WHEN Sum(IsNull(A.actin_04,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_04,0)) * 100 / Sum(IsNull(A.actin_04,0)) END as lpi_04,
	CASE WHEN Sum(IsNull(A.actin_05,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_05,0)) * 100 / Sum(IsNull(A.actin_05,0)) END as lpi_05,
	CASE WHEN Sum(IsNull(A.actin_06,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_06,0)) * 100 / Sum(IsNull(A.actin_06,0)) END as lpi_06,
	CASE WHEN Sum(IsNull(A.actin_07,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_07,0)) * 100 / Sum(IsNull(A.actin_07,0)) END as lpi_07,
	CASE WHEN Sum(IsNull(A.actin_08,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_08,0)) * 100 / Sum(IsNull(A.actin_08,0)) END as lpi_08,
	CASE WHEN Sum(IsNull(A.actin_09,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_09,0)) * 100 / Sum(IsNull(A.actin_09,0)) END as lpi_09,
	CASE WHEN Sum(IsNull(A.actin_10,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_10,0)) * 100 / Sum(IsNull(A.actin_10,0)) END as lpi_10,
	CASE WHEN Sum(IsNull(A.actin_11,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_11,0)) * 100 / Sum(IsNull(A.actin_11,0)) END as lpi_11,
	CASE WHEN Sum(IsNull(A.actin_12,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_12,0)) * 100 / Sum(IsNull(A.actin_12,0)) END as lpi_12,
	CASE WHEN Sum(IsNull(A.actin_13,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_13,0)) * 100 / Sum(IsNull(A.actin_13,0)) END as lpi_13,
	CASE WHEN Sum(IsNull(A.actin_14,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_14,0)) * 100 / Sum(IsNull(A.actin_14,0)) END as lpi_14,
	CASE WHEN Sum(IsNull(A.actin_15,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_15,0)) * 100 / Sum(IsNull(A.actin_15,0)) END as lpi_15,
	CASE WHEN Sum(IsNull(A.actin_16,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_16,0)) * 100 / Sum(IsNull(A.actin_16,0)) END as lpi_16,
	CASE WHEN Sum(IsNull(A.actin_17,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_17,0)) * 100 / Sum(IsNull(A.actin_17,0)) END as lpi_17,
	CASE WHEN Sum(IsNull(A.actin_18,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_18,0)) * 100 / Sum(IsNull(A.actin_18,0)) END as lpi_18,
	CASE WHEN Sum(IsNull(A.actin_19,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_19,0)) * 100 / Sum(IsNull(A.actin_19,0)) END as lpi_19,
	CASE WHEN Sum(IsNull(A.actin_20,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_20,0)) * 100 / Sum(IsNull(A.actin_20,0)) END as lpi_20,
	CASE WHEN Sum(IsNull(A.actin_21,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_21,0)) * 100 / Sum(IsNull(A.actin_21,0)) END as lpi_21,
	CASE WHEN Sum(IsNull(A.actin_22,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_22,0)) * 100 / Sum(IsNull(A.actin_22,0)) END as lpi_22,
	CASE WHEN Sum(IsNull(A.actin_23,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_23,0)) * 100 / Sum(IsNull(A.actin_23,0)) END as lpi_23,
	CASE WHEN Sum(IsNull(A.actin_24,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_24,0)) * 100 / Sum(IsNull(A.actin_24,0)) END as lpi_24,
	CASE WHEN Sum(IsNull(A.actin_25,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_25,0)) * 100 / Sum(IsNull(A.actin_25,0)) END as lpi_25,
	CASE WHEN Sum(IsNull(A.actin_26,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_26,0)) * 100 / Sum(IsNull(A.actin_26,0)) END as lpi_26,
	CASE WHEN Sum(IsNull(A.actin_27,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_27,0)) * 100 / Sum(IsNull(A.actin_27,0)) END as lpi_27,
	CASE WHEN Sum(IsNull(A.actin_28,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_28,0)) * 100 / Sum(IsNull(A.actin_28,0)) END as lpi_28,
	CASE WHEN Sum(IsNull(A.actin_29,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_29,0)) * 100 / Sum(IsNull(A.actin_29,0)) END as lpi_29,
	CASE WHEN Sum(IsNull(A.actin_30,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_30,0)) * 100 / Sum(IsNull(A.actin_30,0)) END as lpi_30,
	CASE WHEN Sum(IsNull(A.actin_31,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_31,0)) * 100 / Sum(IsNull(A.actin_31,0)) END as lpi_31
From #Temp_realprod A, TMSTITEM B,TMSTWORKCENTER E 
WHERE 
	( A.AreaCode = E.AreaCode ) and  
 	( A.DivisionCode = E.DivisionCode ) and  
 	( A.WorkCenter = E.WorkCenter ) and
 	( A.Itemcode = B.Itemcode )

Union All 

Select A.AreaCode as areacode, A.DivisionCode as divisioncode, A.WorkCenter as workcenter, E.WorkCenterName as workcentername,
  IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.01' AS CHAR(10)) ),'X') as sts_01,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.02' AS CHAR(10)) ),'X') as sts_02,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.03' AS CHAR(10)) ),'X') as sts_03,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.04' AS CHAR(10)) ),'X') as sts_04,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.05' AS CHAR(10)) ),'X') as sts_05,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.06' AS CHAR(10)) ),'X') as sts_06,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.07' AS CHAR(10)) ),'X') as sts_07,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.08' AS CHAR(10)) ),'X') as sts_08,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.09' AS CHAR(10)) ),'X') as sts_09,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.10' AS CHAR(10)) ),'X') as sts_10,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.11' AS CHAR(10)) ),'X') as sts_11,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.12' AS CHAR(10)) ),'X') as sts_12,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.13' AS CHAR(10)) ),'X') as sts_13,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.14' AS CHAR(10)) ),'X') as sts_14,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.15' AS CHAR(10)) ),'X') as sts_15,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.16' AS CHAR(10)) ),'X') as sts_16,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.17' AS CHAR(10)) ),'X') as sts_17,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.18' AS CHAR(10)) ),'X') as sts_18,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.19' AS CHAR(10)) ),'X') as sts_19,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.20' AS CHAR(10)) ),'X') as sts_20,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.21' AS CHAR(10)) ),'X') as sts_21,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.22' AS CHAR(10)) ),'X') as sts_22,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.23' AS CHAR(10)) ),'X') as sts_23,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.24' AS CHAR(10)) ),'X') as sts_24,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.25' AS CHAR(10)) ),'X') as sts_25,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.26' AS CHAR(10)) ),'X') as sts_26,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.27' AS CHAR(10)) ),'X') as sts_27,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.28' AS CHAR(10)) ),'X') as sts_28,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.29' AS CHAR(10)) ),'X') as sts_29,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.30' AS CHAR(10)) ),'X') as sts_30,
	IsNull(( SELECT F.DailyStatus FROM TMHDAILYSTATUS F WHERE F.AreaCode = A.AreaCode and F.DivisionCode = A.DivisionCode and
	F.WorkCenter = A.WorkCenter and F.WorkDay = CAST(@ps_stMonth + '.31' AS CHAR(10)) ),'X') as sts_31,
	Sum(IsNull(A.actin_01,0)) as actin_01,
	Sum(IsNull(A.actin_02,0)) as actin_02,
	Sum(IsNull(A.actin_03,0)) as actin_03,
	Sum(IsNull(A.actin_04,0)) as actin_04,
	Sum(IsNull(A.actin_05,0)) as actin_05,
	Sum(IsNull(A.actin_06,0)) as actin_06,
	Sum(IsNull(A.actin_07,0)) as actin_07,
	Sum(IsNull(A.actin_08,0)) as actin_08,
	Sum(IsNull(A.actin_09,0)) as actin_09,
	Sum(IsNull(A.actin_10,0)) as actin_10,
	Sum(IsNull(A.actin_11,0)) as actin_11,
	Sum(IsNull(A.actin_12,0)) as actin_12,
	Sum(IsNull(A.actin_13,0)) as actin_13,
	Sum(IsNull(A.actin_14,0)) as actin_14,
	Sum(IsNull(A.actin_15,0)) as actin_15,
	Sum(IsNull(A.actin_16,0)) as actin_16,
	Sum(IsNull(A.actin_17,0)) as actin_17,
	Sum(IsNull(A.actin_18,0)) as actin_18,
	Sum(IsNull(A.actin_19,0)) as actin_19,
	Sum(IsNull(A.actin_20,0)) as actin_20,
	Sum(IsNull(A.actin_21,0)) as actin_21,
	Sum(IsNull(A.actin_22,0)) as actin_22,
	Sum(IsNull(A.actin_23,0)) as actin_23,
	Sum(IsNull(A.actin_24,0)) as actin_24,
	Sum(IsNull(A.actin_25,0)) as actin_25,
	Sum(IsNull(A.actin_26,0)) as actin_26,
	Sum(IsNull(A.actin_27,0)) as actin_27,
	Sum(IsNull(A.actin_28,0)) as actin_28,
	Sum(IsNull(A.actin_29,0)) as actin_29,
	Sum(IsNull(A.actin_30,0)) as actin_30,
	Sum(IsNull(A.actin_31,0)) as actin_31,
	Sum(IsNull(A.actmh_01,0)) as actmh_01,
	Sum(IsNull(A.actmh_02,0)) as actmh_02,
	Sum(IsNull(A.actmh_03,0)) as actmh_03,
	Sum(IsNull(A.actmh_04,0)) as actmh_04,
	Sum(IsNull(A.actmh_05,0)) as actmh_05,
	Sum(IsNull(A.actmh_06,0)) as actmh_06,
	Sum(IsNull(A.actmh_07,0)) as actmh_07,
	Sum(IsNull(A.actmh_08,0)) as actmh_08,
	Sum(IsNull(A.actmh_09,0)) as actmh_09,
	Sum(IsNull(A.actmh_10,0)) as actmh_10,
	Sum(IsNull(A.actmh_11,0)) as actmh_11,
	Sum(IsNull(A.actmh_12,0)) as actmh_12,
	Sum(IsNull(A.actmh_13,0)) as actmh_13,
	Sum(IsNull(A.actmh_14,0)) as actmh_14,
	Sum(IsNull(A.actmh_15,0)) as actmh_15,
	Sum(IsNull(A.actmh_16,0)) as actmh_16,
	Sum(IsNull(A.actmh_17,0)) as actmh_17,
	Sum(IsNull(A.actmh_18,0)) as actmh_18,
	Sum(IsNull(A.actmh_19,0)) as actmh_19,
	Sum(IsNull(A.actmh_20,0)) as actmh_20,
	Sum(IsNull(A.actmh_21,0)) as actmh_21,
	Sum(IsNull(A.actmh_22,0)) as actmh_22,
	Sum(IsNull(A.actmh_23,0)) as actmh_23,
	Sum(IsNull(A.actmh_24,0)) as actmh_24,
	Sum(IsNull(A.actmh_25,0)) as actmh_25,
	Sum(IsNull(A.actmh_26,0)) as actmh_26,
	Sum(IsNull(A.actmh_27,0)) as actmh_27,
	Sum(IsNull(A.actmh_28,0)) as actmh_28,
	Sum(IsNull(A.actmh_29,0)) as actmh_29,
	Sum(IsNull(A.actmh_30,0)) as actmh_30,
	Sum(IsNull(A.actmh_31,0)) as actmh_31,
	CASE WHEN Sum(IsNull(A.actin_01,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_01,0)) * 100 / Sum(IsNull(A.actin_01,0)) END as lpi_01,
	CASE WHEN Sum(IsNull(A.actin_02,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_02,0)) * 100 / Sum(IsNull(A.actin_02,0)) END as lpi_02,
	CASE WHEN Sum(IsNull(A.actin_03,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_03,0)) * 100 / Sum(IsNull(A.actin_03,0)) END as lpi_03,
	CASE WHEN Sum(IsNull(A.actin_04,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_04,0)) * 100 / Sum(IsNull(A.actin_04,0)) END as lpi_04,
	CASE WHEN Sum(IsNull(A.actin_05,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_05,0)) * 100 / Sum(IsNull(A.actin_05,0)) END as lpi_05,
	CASE WHEN Sum(IsNull(A.actin_06,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_06,0)) * 100 / Sum(IsNull(A.actin_06,0)) END as lpi_06,
	CASE WHEN Sum(IsNull(A.actin_07,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_07,0)) * 100 / Sum(IsNull(A.actin_07,0)) END as lpi_07,
	CASE WHEN Sum(IsNull(A.actin_08,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_08,0)) * 100 / Sum(IsNull(A.actin_08,0)) END as lpi_08,
	CASE WHEN Sum(IsNull(A.actin_09,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_09,0)) * 100 / Sum(IsNull(A.actin_09,0)) END as lpi_09,
	CASE WHEN Sum(IsNull(A.actin_10,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_10,0)) * 100 / Sum(IsNull(A.actin_10,0)) END as lpi_10,
	CASE WHEN Sum(IsNull(A.actin_11,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_11,0)) * 100 / Sum(IsNull(A.actin_11,0)) END as lpi_11,
	CASE WHEN Sum(IsNull(A.actin_12,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_12,0)) * 100 / Sum(IsNull(A.actin_12,0)) END as lpi_12,
	CASE WHEN Sum(IsNull(A.actin_13,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_13,0)) * 100 / Sum(IsNull(A.actin_13,0)) END as lpi_13,
	CASE WHEN Sum(IsNull(A.actin_14,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_14,0)) * 100 / Sum(IsNull(A.actin_14,0)) END as lpi_14,
	CASE WHEN Sum(IsNull(A.actin_15,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_15,0)) * 100 / Sum(IsNull(A.actin_15,0)) END as lpi_15,
	CASE WHEN Sum(IsNull(A.actin_16,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_16,0)) * 100 / Sum(IsNull(A.actin_16,0)) END as lpi_16,
	CASE WHEN Sum(IsNull(A.actin_17,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_17,0)) * 100 / Sum(IsNull(A.actin_17,0)) END as lpi_17,
	CASE WHEN Sum(IsNull(A.actin_18,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_18,0)) * 100 / Sum(IsNull(A.actin_18,0)) END as lpi_18,
	CASE WHEN Sum(IsNull(A.actin_19,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_19,0)) * 100 / Sum(IsNull(A.actin_19,0)) END as lpi_19,
	CASE WHEN Sum(IsNull(A.actin_20,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_20,0)) * 100 / Sum(IsNull(A.actin_20,0)) END as lpi_20,
	CASE WHEN Sum(IsNull(A.actin_21,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_21,0)) * 100 / Sum(IsNull(A.actin_21,0)) END as lpi_21,
	CASE WHEN Sum(IsNull(A.actin_22,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_22,0)) * 100 / Sum(IsNull(A.actin_22,0)) END as lpi_22,
	CASE WHEN Sum(IsNull(A.actin_23,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_23,0)) * 100 / Sum(IsNull(A.actin_23,0)) END as lpi_23,
	CASE WHEN Sum(IsNull(A.actin_24,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_24,0)) * 100 / Sum(IsNull(A.actin_24,0)) END as lpi_24,
	CASE WHEN Sum(IsNull(A.actin_25,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_25,0)) * 100 / Sum(IsNull(A.actin_25,0)) END as lpi_25,
	CASE WHEN Sum(IsNull(A.actin_26,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_26,0)) * 100 / Sum(IsNull(A.actin_26,0)) END as lpi_26,
	CASE WHEN Sum(IsNull(A.actin_27,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_27,0)) * 100 / Sum(IsNull(A.actin_27,0)) END as lpi_27,
	CASE WHEN Sum(IsNull(A.actin_28,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_28,0)) * 100 / Sum(IsNull(A.actin_28,0)) END as lpi_28,
	CASE WHEN Sum(IsNull(A.actin_29,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_29,0)) * 100 / Sum(IsNull(A.actin_29,0)) END as lpi_29,
	CASE WHEN Sum(IsNull(A.actin_30,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_30,0)) * 100 / Sum(IsNull(A.actin_30,0)) END as lpi_30,
	CASE WHEN Sum(IsNull(A.actin_31,0)) = 0 THEN 0 ELSE Sum(IsNull(A.actmh_31,0)) * 100 / Sum(IsNull(A.actin_31,0)) END as lpi_31
From #Temp_realprod A, TMSTITEM B, TMSTWORKCENTER E 
WHERE 
	( A.AreaCode = E.AreaCode ) and  
 	( A.DivisionCode = E.DivisionCode ) and  
 	( A.WorkCenter = E.WorkCenter ) and
 	( A.Itemcode = B.Itemcode )
Group by A.AreaCode, A.DivisionCode, A.WorkCenter, E.WorkCenterName
Exit_pr:

DROP TABLE #Temp_realprod 

END







