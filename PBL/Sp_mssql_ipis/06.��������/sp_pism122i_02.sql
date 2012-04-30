USE [IPIS]
GO
/****** Object:  StoredProcedure [dbo].[sp_pism122i_02]    Script Date: 01/19/2012 14:34:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/*************************/
/*     일별 생산실적( 경영지표보고용 )    */
/*************************/

/*
Execute sp_pism122i_02
	@ps_area	= 'D',
	@ps_div		= 'A',
	@ps_wc    = '%'
	@ps_stMonth	= '2012.01'

select * from tmhstandard
where styear = '2007' and workcenter = '522H'
*/

CREATE     PROCEDURE [dbo].[sp_pism122i_02]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		VarChar(5),	-- 조
	@ps_stMonth	Char(7)		-- 기준년월
AS
BEGIN

Declare	@SQLString 	NVARCHAR(1500), 
	@cvtValue	Char(2),
	@Day		int,
	@DailyStatus	Char(1) ,
	@lastyear	Char(4) 

Set 	@lastYear 	= 	Cast ( Cast( substring(@ps_stMonth, 1, 4) as Numeric(4) ) - 1 as Char(4) )

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
	stmh			numeric(7,5)	null,
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
	actin_01			numeric(4,1)	null,
	actin_02			numeric(4,1)	null,
	actin_03			numeric(4,1)	null,
	actin_04			numeric(4,1)	null,
	actin_05			numeric(4,1)	null,
	actin_06			numeric(4,1)	null,
	actin_07			numeric(4,1)	null,
	actin_08			numeric(4,1)	null,
	actin_09			numeric(4,1)	null,
	actin_10			numeric(4,1)	null,
	actin_11			numeric(4,1)	null,
	actin_12			numeric(4,1)	null,
	actin_13			numeric(4,1)	null,
	actin_14			numeric(4,1)	null,
	actin_15			numeric(4,1)	null,
	actin_16			numeric(4,1)	null,
	actin_17			numeric(4,1)	null,
	actin_18			numeric(4,1)	null,
	actin_19			numeric(4,1)	null,
	actin_20			numeric(4,1)	null,
	actin_21			numeric(4,1)	null,
	actin_22			numeric(4,1)	null,
	actin_23			numeric(4,1)	null,
	actin_24			numeric(4,1)	null,
	actin_25			numeric(4,1)	null,
	actin_26			numeric(4,1)	null,
	actin_27			numeric(4,1)	null,
	actin_28			numeric(4,1)	null,
	actin_29			numeric(4,1)	null,
	actin_30			numeric(4,1)	null,
	actin_31			numeric(4,1)	null,
	actmh_01			numeric(7,5)	null,
	actmh_02			numeric(7,5)	null,
	actmh_03			numeric(7,5)	null,
	actmh_04			numeric(7,5)	null,
	actmh_05			numeric(7,5)	null,
	actmh_06			numeric(7,5)	null,
	actmh_07			numeric(7,5)	null,
	actmh_08			numeric(7,5)	null,
	actmh_09			numeric(7,5)	null,
	actmh_10			numeric(7,5)	null,
	actmh_11			numeric(7,5)	null,
	actmh_12			numeric(7,5)	null,
	actmh_13			numeric(7,5)	null,
	actmh_14			numeric(7,5)	null,
	actmh_15			numeric(7,5)	null,
	actmh_16			numeric(7,5)	null,
	actmh_17			numeric(7,5)	null,
	actmh_18			numeric(7,5)	null,
	actmh_19			numeric(7,5)	null,
	actmh_20			numeric(7,5)	null,
	actmh_21			numeric(7,5)	null,
	actmh_22			numeric(7,5)	null,
	actmh_23			numeric(7,5)	null,
	actmh_24			numeric(7,5)	null,
	actmh_25			numeric(7,5)	null,
	actmh_26			numeric(7,5)	null,
	actmh_27			numeric(7,5)	null,
	actmh_28			numeric(7,5)	null,
	actmh_29			numeric(7,5)	null,
	actmh_30			numeric(7,5)	null,
	actmh_31			numeric(7,5)	null,
	lpi_01			numeric(7,4)	null,
	lpi_02			numeric(7,4)	null,
	lpi_03			numeric(7,4)	null,
	lpi_04			numeric(7,4)	null,
	lpi_05			numeric(7,4)	null,
	lpi_06			numeric(7,4)	null,
	lpi_07			numeric(7,4)	null,
	lpi_08			numeric(7,4)	null,
	lpi_09			numeric(7,4)	null,
	lpi_10			numeric(7,4)	null,
	lpi_11			numeric(7,4)	null,
	lpi_12			numeric(7,4)	null,
	lpi_13			numeric(7,4)	null,
	lpi_14			numeric(7,4)	null,
	lpi_15			numeric(7,4)	null,
	lpi_16			numeric(7,4)	null,
	lpi_17			numeric(7,4)	null,
	lpi_18			numeric(7,4)	null,
	lpi_19			numeric(7,4)	null,
	lpi_20			numeric(7,4)	null,
	lpi_21			numeric(7,4)	null,
	lpi_22			numeric(7,4)	null,
	lpi_23			numeric(7,4)	null,
	lpi_24			numeric(7,4)	null,
	lpi_25			numeric(7,4)	null,
	lpi_26			numeric(7,4)	null,
	lpi_27			numeric(7,4)	null,
	lpi_28			numeric(7,4)	null,
	lpi_29			numeric(7,4)	null,
	lpi_30			numeric(7,4)	null,
	lpi_31			numeric(7,4)	null
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
	( a.WorkCenter 	like @ps_wc ) AND
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

Select   	A.WorkCenter,E.WorkCenterName,isnull(A.wcitemgroup,''),A.Itemcode,B.Itemname,A.sublinecode,A.sublineno,A.stmh,
	IsNull(A.day_01,0) as day_01,
	IsNull(A.day_02,0) as day_02,
	IsNull(A.day_03,0) as day_03,
	IsNull(A.day_04,0) as day_04,
	IsNull(A.day_05,0) as day_05,
	IsNull(A.day_06,0) as day_06,
	IsNull(A.day_07,0) as day_07,
	IsNull(A.day_08,0) as day_08,
	IsNull(A.day_09,0) as day_09,
	IsNull(A.day_10,0) as day_10,
	IsNull(A.day_11,0) as day_11,
	IsNull(A.day_12,0) as day_12,
	IsNull(A.day_13,0) as day_13,
	IsNull(A.day_14,0) as day_14,
	IsNull(A.day_15,0) as day_15,
	IsNull(A.day_16,0) as day_16,
	IsNull(A.day_17,0) as day_17,
	IsNull(A.day_18,0) as day_18,
	IsNull(A.day_19,0) as day_19,
	IsNull(A.day_20,0) as day_20,
	IsNull(A.day_21,0) as day_21,
	IsNull(A.day_22,0) as day_22,
	IsNull(A.day_23,0) as day_23,
	IsNull(A.day_24,0) as day_24,
	IsNull(A.day_25,0) as day_25,
	IsNull(A.day_26,0) as day_26,
	IsNull(A.day_27,0) as day_27,
	IsNull(A.day_28,0) as day_28,
	IsNull(A.day_29,0) as day_29,
	IsNull(A.day_30,0) as day_30,
	IsNull(A.day_31,0) as day_31,
	IsNull(A.actin_01,0) as actin_01,
	IsNull(A.actin_02,0) as actin_02,
	IsNull(A.actin_03,0) as actin_03,
	IsNull(A.actin_04,0) as actin_04,
	IsNull(A.actin_05,0) as actin_05,
	IsNull(A.actin_06,0) as actin_06,
	IsNull(A.actin_07,0) as actin_07,
	IsNull(A.actin_08,0) as actin_08,
	IsNull(A.actin_09,0) as actin_09,
	IsNull(A.actin_10,0) as actin_10,
	IsNull(A.actin_11,0) as actin_11,
	IsNull(A.actin_12,0) as actin_12,
	IsNull(A.actin_13,0) as actin_13,
	IsNull(A.actin_14,0) as actin_14,
	IsNull(A.actin_15,0) as actin_15,
	IsNull(A.actin_16,0) as actin_16,
	IsNull(A.actin_17,0) as actin_17,
	IsNull(A.actin_18,0) as actin_18,
	IsNull(A.actin_19,0) as actin_19,
	IsNull(A.actin_20,0) as actin_20,
	IsNull(A.actin_21,0) as actin_21,
	IsNull(A.actin_22,0) as actin_22,
	IsNull(A.actin_23,0) as actin_23,
	IsNull(A.actin_24,0) as actin_24,
	IsNull(A.actin_25,0) as actin_25,
	IsNull(A.actin_26,0) as actin_26,
	IsNull(A.actin_27,0) as actin_27,
	IsNull(A.actin_28,0) as actin_28,
	IsNull(A.actin_29,0) as actin_29,
	IsNull(A.actin_30,0) as actin_30,
	IsNull(A.actin_31,0) as actin_31,
	IsNull(A.actmh_01,0) as actmh_01,
	IsNull(A.actmh_02,0) as actmh_02,
	IsNull(A.actmh_03,0) as actmh_03,
	IsNull(A.actmh_04,0) as actmh_04,
	IsNull(A.actmh_05,0) as actmh_05,
	IsNull(A.actmh_06,0) as actmh_06,
	IsNull(A.actmh_07,0) as actmh_07,
	IsNull(A.actmh_08,0) as actmh_08,
	IsNull(A.actmh_09,0) as actmh_09,
	IsNull(A.actmh_10,0) as actmh_10,
	IsNull(A.actmh_11,0) as actmh_11,
	IsNull(A.actmh_12,0) as actmh_12,
	IsNull(A.actmh_13,0) as actmh_13,
	IsNull(A.actmh_14,0) as actmh_14,
	IsNull(A.actmh_15,0) as actmh_15,
	IsNull(A.actmh_16,0) as actmh_16,
	IsNull(A.actmh_17,0) as actmh_17,
	IsNull(A.actmh_18,0) as actmh_18,
	IsNull(A.actmh_19,0) as actmh_19,
	IsNull(A.actmh_20,0) as actmh_20,
	IsNull(A.actmh_21,0) as actmh_21,
	IsNull(A.actmh_22,0) as actmh_22,
	IsNull(A.actmh_23,0) as actmh_23,
	IsNull(A.actmh_24,0) as actmh_24,
	IsNull(A.actmh_25,0) as actmh_25,
	IsNull(A.actmh_26,0) as actmh_26,
	IsNull(A.actmh_27,0) as actmh_27,
	IsNull(A.actmh_28,0) as actmh_28,
	IsNull(A.actmh_29,0) as actmh_29,
	IsNull(A.actmh_30,0) as actmh_30,
	IsNull(A.actmh_31,0) as actmh_31,
	IsNull(A.lpi_01,0) as lpi_01,
	IsNull(A.lpi_02,0) as lpi_02,
	IsNull(A.lpi_03,0) as lpi_03,
	IsNull(A.lpi_04,0) as lpi_04,
	IsNull(A.lpi_05,0) as lpi_05,
	IsNull(A.lpi_06,0) as lpi_06,
	IsNull(A.lpi_07,0) as lpi_07,
	IsNull(A.lpi_08,0) as lpi_08,
	IsNull(A.lpi_09,0) as lpi_09,
	IsNull(A.lpi_10,0) as lpi_10,
	IsNull(A.lpi_11,0) as lpi_11,
	IsNull(A.lpi_12,0) as lpi_12,
	IsNull(A.lpi_13,0) as lpi_13,
	IsNull(A.lpi_14,0) as lpi_14,
	IsNull(A.lpi_15,0) as lpi_15,
	IsNull(A.lpi_16,0) as lpi_16,
	IsNull(A.lpi_17,0) as lpi_17,
	IsNull(A.lpi_18,0) as lpi_18,
	IsNull(A.lpi_19,0) as lpi_19,
	IsNull(A.lpi_20,0) as lpi_20,
	IsNull(A.lpi_21,0) as lpi_21,
	IsNull(A.lpi_22,0) as lpi_22,
	IsNull(A.lpi_23,0) as lpi_23,
	IsNull(A.lpi_24,0) as lpi_24,
	IsNull(A.lpi_25,0) as lpi_25,
	IsNull(A.lpi_26,0) as lpi_26,
	IsNull(A.lpi_27,0) as lpi_27,
	IsNull(A.lpi_28,0) as lpi_28,
	IsNull(A.lpi_29,0) as lpi_29,
	IsNull(A.lpi_30,0) as lpi_30,
	IsNull(A.lpi_31,0) as lpi_31
From #Temp_realprod A, TMSTITEM B,TMSTWORKCENTER E 
WHERE 
	( A.AreaCode = E.AreaCode ) and  
 	( A.DivisionCode = E.DivisionCode ) and  
 	( A.WorkCenter = E.WorkCenter ) and
 	( A.Itemcode = B.Itemcode )  	 
Exit_pr:

DROP TABLE #Temp_realprod 

END


