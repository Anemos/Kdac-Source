SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_03_1p]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_03_1p]
GO




/*********************************************/
/*      작업일보 생산수량내역 출력 (갑지)    */
/*********************************************/

CREATE PROCEDURE sp_pism010u_03_1p
	@ps_area		Char(1),		-- 지역
	@ps_div			Char(1),		-- 공장
	@ps_wc			Varchar(5),		-- 조
	@ps_wday		Char(10)		-- 작업일자 

AS
BEGIN

 Declare @retCnt 	int,
	 @spcLine	int 

 Create Table #Temp_daily_1p 
  ( AreaCode 		Char(1)		null,
    DivisionCode 	Char(1)		null,
    WorkCenter		VarChar(5)	null, 
    WorkDay		Char(10)	null,
    wcItemGroup		VarChar(30)	null, 
    Seq			Numeric(3)	null,
    ItemCode		Varchar(12)	null, 
    subLineCode 	VarChar(7)	null,
    subLineNo 		Char(1)		null, 
    daypQty 		int		null,
    nightpQty 		int		null, 
    UnuseMH 		Numeric(4,1)	null,
    ActMH 		Numeric(4,1)	null,
    ActInMH 		Numeric(4,1)	null,
    BasicTime 		Numeric(9,4)	null,
    BasicMH 		Numeric(4,1)	null,
    ItemName		VarChar(100)	null,
    ItemSpec		Varchar(100) 	null  ) 

Insert Into #Temp_daily_1p 
SELECT Top 26 A.AreaCode, 
	 A.DivisionCode,   
	 A.WorkCenter,   
	 A.WorkDay,   
  	 A.wcItemGroup, 
	 A.Seq, 
 	 A.ItemCode,   
	 A.subLineCode,   
 	 A.subLineNo,   
	 A.daypQty,   
	 A.nightpQty,   
	 A.UnuseMH,   
	 A.ActMH,   
	 A.ActInMH,   
	 A.BasicTime,   
	 A.BasicMH, 
	 B.ItemName,   
  	 B.ItemSpec 
     FROM TMHREALPROD A,    
          TMSTITEM B 
   WHERE ( A.ItemCode = B.ItemCode ) and  
         ( ( A.AreaCode = @ps_area ) AND  
           ( A.DivisionCode = @ps_div ) AND  
           ( A.WorkCenter = @ps_wc ) AND  
           ( A.WorkDay = @ps_wday ) And 
	   ( IsNull(A.ActInMH,0) > 0 ) ) 
Order By A.Seq, 
  	 A.wcItemGroup, 
 	 A.ItemCode,   
	 A.subLineCode,   
 	 A.subLineNo 

Set @retCnt = @@RowCount 
If @retCnt <= 26 Set @spcLine = 26 - @retCnt  

While @spcLine > 0 
Begin 
   Insert Into #Temp_daily_1p ( Seq ) Values ( 999 ) 
   Set @spcLine = @spcLine - 1 
End

 Select * From #Temp_daily_1p 

Drop Table #Temp_daily_1p 
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

