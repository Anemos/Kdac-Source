SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism120i_01_rev1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism120i_01_rev1]
GO








/*************************/
/*     일별 생산실적     */
/* exec sp_pism120i_01_rev1 'D','A','%','2012.03' */
/*************************/

CREATE PROCEDURE [dbo].[sp_pism120i_01_rev1]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		VarChar(5),		-- 조
	@ps_stMonth	Char(7)			-- 기준년월
AS
BEGIN

Declare	@SQLString 	NVARCHAR(1000), 
	@cvtValue	Char(2),
	@Day		int,
	@DailyStatus	Char(1) 

	-- 해당일자에 생산실적이 없는 경우 해당일이 나타나지 않으므로 Temp Table 생성 

	CREATE TABLE #Temp_realprod 
	(
		AreaCode		Char(1)		not null,
		DivisionCode		Char(1)		not null,
		WorkCenter		Varchar(6)	not null,
		ItemCode		VarChar(12)	not null,
		sublinecode		VarChar(7)	not null,
		sublineno		VarChar(1)	not null,
		wcitemgroup		varchar(30)	null,
		seq			int		null,
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
		day_31			int		null 
	)

     Insert Into #Temp_realprod ( AreaCode, DivisionCode, WorkCenter, ItemCode,Sublinecode,Sublineno,Wcitemgroup ) 
	  SELECT AreaCode, 
		 DivisionCode, 
		 WorkCenter, 
		 ItemCode,
                             Sublinecode,
                             Sublineno ,
		 rtrim(wcitemgroup)
	    FROM TMHREALPROD 
	   WHERE ( AreaCode = @ps_area ) AND  
	         ( DivisionCode = @ps_div ) AND  
	         ( WorkCenter like @ps_wc ) AND  
	         ( substring(WorkDay, 1, 7) = @ps_stMonth ) 
	Group By AreaCode, 
		 DivisionCode, WorkCenter, ItemCode ,Sublinecode, Sublineno,wcitemgroup

	
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
								 	 "( A.ItemCode = #Temp_realprod.ItemCode ) And " + 
                                  							 "( A.SublineCode = #Temp_realprod.SublineCode ) And " + 
                                  							 "( A.SublineNo = #Temp_realprod.SublineNo ) And " + 
									 "( A.wcitemgroup = #Temp_realprod.wcitemgroup ) And " + 
									 "( A.WorkDay = '" + @ps_stMonth + "." + @cvtValue + "' ) And " + 
 									 "( IsNull(B.DailyStatus,'0') = '1' ) ) " 
		EXEC sp_executesql @SQLString
		If @@Error <> 0 Goto Exit_pr
		End

		Set @Day = @Day + 1 
	END

  Select A.WorkCenter, 
	 E.WorkCenterName,
	 B.ProductGroup,
	 D.ProductGroupName,
	 A.ItemCode, 
	 C.ItemName, 
               A.Sublinecode,
               A.Sublineno,
	 isnull(A.wcitemgroup,''),
	 isnull(A.seq,0),
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
	 IsNull(A.day_31,0) 
    From #Temp_realprod A, 
         TMSTMODEL B,   
         TMSTITEM C,   
         TMSTPRODUCTGROUP D,   
         TMSTWORKCENTER E 
   WHERE ( A.AreaCode = B.AreaCode ) and  
         ( A.DivisionCode = B.DivisionCode ) and  
         ( A.ItemCode = C.ItemCode ) and  
         ( A.ItemCode = B.ItemCode ) and  
         ( B.ProductGroup = D.ProductGroup ) and  
         ( A.AreaCode = D.AreaCode ) and  
         ( A.DivisionCode = D.DivisionCode ) and  
         ( A.AreaCode = E.AreaCode ) and  
         ( A.DivisionCode = E.DivisionCode ) and  
         ( A.WorkCenter = E.WorkCenter ) 

Exit_pr:
DROP TABLE #Temp_realprod 

END