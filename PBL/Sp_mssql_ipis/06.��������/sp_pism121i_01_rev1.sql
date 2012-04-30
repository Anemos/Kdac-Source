USE [IPIS]
GO
/****** Object:  StoredProcedure [dbo].[sp_pism121i_01_rev1]    Script Date: 01/19/2012 14:34:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/*************************/
/*     일별 생산실적     */
/*************************/

/*
Execute sp_pism121i_01_rev1
	@ps_area	= 'D',
	@ps_div		= 'H',
	@ps_wc		= '522H',
	@ps_stMonth	= '2008.03'
Execute sp_pism121i_01_rev1_test
	@ps_area	= 'D',
	@ps_div		= 'H',
	@ps_wc		= '522H',
	@ps_stMonth	= '2008.03'

select * from tmhstandard
where styear = '2007' and workcenter = '522H'
*/

ALTER     PROCEDURE [dbo].[sp_pism121i_01_rev1]
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
	actin_31			numeric(4,1)	null 
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

Select   	A.WorkCenter,E.WorkCenterName,isnull(A.wcitemgroup,''),A.Itemcode,B.Itemname,A.sublinecode,A.sublineno,A.stmh,
	IsNull(A.day_01,0),
	IsNull(A.day_02,0),
	IsNull(A.day_03,0),
	IsNull(A.day_04,0),
	IsNull(A.day_05,0),
	IsNull(A.day_06,0),
	IsNull(A.day_07,0),
	IsNull(A.day_08,0),
	IsNull(A.day_09,0),
	IsNull(A.day_10,0),
	IsNull(A.day_11,0),
	IsNull(A.day_12,0),
	IsNull(A.day_13,0),
	IsNull(A.day_14,0),
	IsNull(A.day_15,0),
	IsNull(A.day_16,0),
	IsNull(A.day_17,0),
	IsNull(A.day_18,0),
	IsNull(A.day_19,0),
	IsNull(A.day_20,0),
	IsNull(A.day_21,0),
	IsNull(A.day_22,0),
	IsNull(A.day_23,0),
	IsNull(A.day_24,0),
	IsNull(A.day_25,0),
	IsNull(A.day_26,0),
	IsNull(A.day_27,0),
	IsNull(A.day_28,0),
	IsNull(A.day_29,0),
	IsNull(A.day_30,0),
	IsNull(A.day_31,0),
	IsNull(A.actin_01,0),
	IsNull(A.actin_02,0),
	IsNull(A.actin_03,0),
	IsNull(A.actin_04,0),
	IsNull(A.actin_05,0),
	IsNull(A.actin_06,0),
	IsNull(A.actin_07,0),
	IsNull(A.actin_08,0),
	IsNull(A.actin_09,0),
	IsNull(A.actin_10,0),
	IsNull(A.actin_11,0),
	IsNull(A.actin_12,0),
	IsNull(A.actin_13,0),
	IsNull(A.actin_14,0),
	IsNull(A.actin_15,0),
	IsNull(A.actin_16,0),
	IsNull(A.actin_17,0),
	IsNull(A.actin_18,0),
	IsNull(A.actin_19,0),
	IsNull(A.actin_20,0),
	IsNull(A.actin_21,0),
	IsNull(A.actin_22,0),
	IsNull(A.actin_23,0),
	IsNull(A.actin_24,0),
	IsNull(A.actin_25,0),
	IsNull(A.actin_26,0),
	IsNull(A.actin_27,0),
	IsNull(A.actin_28,0),
	IsNull(A.actin_29,0),
	IsNull(A.actin_30,0),
	IsNull(A.actin_31,0)  
From #Temp_realprod A, TMSTITEM B,TMSTWORKCENTER E 
WHERE 
	( A.AreaCode = E.AreaCode ) and  
 	( A.DivisionCode = E.DivisionCode ) and  
 	( A.WorkCenter = E.WorkCenter ) and
 	( A.Itemcode = B.Itemcode )  	 
Exit_pr:

DROP TABLE #Temp_realprod 

END


