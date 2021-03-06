SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_03_2p]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_03_2p]
GO




/*********************************************/
/*      작업일보 생산수량내역 출력 (을지)    */
/*********************************************/

CREATE PROCEDURE sp_pism010u_03_2p
	@ps_area		Char(1),		-- 지역
	@ps_div			Char(1),		-- 공장
	@ps_wc			Varchar(5),		-- 조
	@ps_wday		Char(10)		-- 작업일자 

AS
BEGIN

 Declare @retCnt 	int,
	 @spcLine	int 

SELECT Top 26 A.DivisionCode,   
   	 A.AreaCode,   
	 A.WorkCenter,   
	 A.WorkDay,   
	 A.Seq, 
 	 A.ItemCode,   
	 A.subLineCode,   
 	 A.subLineNo 
     Into #Temp_daily_1p 
     FROM TMHREALPROD A 
   WHERE ( A.AreaCode = @ps_area ) AND  
         ( A.DivisionCode = @ps_div ) AND  
         ( A.WorkCenter = @ps_wc ) AND  
         ( A.WorkDay = @ps_wday ) And 
	 ( IsNull(A.ActInMH,0) > 0 ) 
Order By A.Seq,
	 A.wcItemGroup, 
	 A.ItemCode,   
	 A.subLineCode,  
	 A.subLineNo 

 Create Table #Temp_daily_2p 
  ( AreaCode 		Char(1)		null,
    DivisionCode 	Char(1)		null,
    WorkCenter		VarChar(5)	null, 
    WorkDay		Char(10)	null,
    wcItemGroup		VarChar(30)	null, 
    ItemCode		Varchar(12)	null, 
    subLineCode 	VarChar(7)	null,
    subLineNo 		Char(1)		null, 
    Seq			Numeric(3)	null,
    ItemName		VarChar(100)	null,
    ItemSpec		Varchar(100) 	null, 
    daypQty 		int		null,
    nightpQty 		int		null, 
    UnuseMH 		Numeric(4,1)	null,
    ActMH 		Numeric(4,1)	null,
    ActInMH 		Numeric(4,1)	null,
    BasicTime 		Numeric(9,4)	null,
    BasicMH 		Numeric(4,1)	null ) 

  Insert Into #Temp_daily_2p 
  SELECT A.AreaCode,   
	 A.DivisionCode,   
   	 A.WorkCenter,   
	 A.WorkDay,   
  	 A.wcItemGroup, 
 	 A.ItemCode,   
	 A.subLineCode,   
 	 A.subLineNo,   
	 A.Seq, 
	 B.ItemName,   
  	 B.ItemSpec, 
	 A.daypQty,   
	 A.nightpQty,   
	 A.UnuseMH,   
	 A.ActMH,   
	 A.ActInMH,   
	 A.BasicTime,   
	 A.BasicMH 
     FROM TMHREALPROD A,    
          TMSTITEM B 
   WHERE ( A.ItemCode = B.ItemCode ) and  
         ( ( A.AreaCode = @ps_area ) AND  
           ( A.DivisionCode = @ps_div ) AND  
           ( A.WorkCenter = @ps_wc ) AND  
           ( A.WorkDay = @ps_wday ) And 
	   ( IsNull(A.ActInMH,0) > 0 ) And 
Not EXISTS ( SELECT Seq From #Temp_daily_1p 
	      Where ( AreaCode = A.AreaCode ) And 
		    ( DivisionCode = A.DivisionCode ) And 
		    ( WorkCenter = A.WorkCenter ) And 
		    ( Workday = A.WorkDay ) And 
		    ( ItemCode = A.ItemCode ) And 
		    ( subLineCode = A.subLineCode ) And 
		    ( subLineNo = A.subLineNo ) ) ) 

Set @retCnt = @@RowCount 
If @retCnt > 0 
	Begin 
		If @retCnt <= 33 
			Set @spcLine = 33 - @retCnt 
		Else
			Begin 
				Set @spcLine = 33 - ( @retCnt % 33 ) 
			End 

	End 

While @spcLine > 0 
Begin 
   Insert Into #Temp_daily_2p ( Seq ) Values ( 999 ) 
   Set @spcLine = @spcLine - 1 
End

 Select * From #Temp_daily_2p 

Drop Table #Temp_daily_1p 
Drop Table #Temp_daily_2p
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

