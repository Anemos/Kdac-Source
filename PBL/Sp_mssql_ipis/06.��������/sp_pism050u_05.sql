SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism050u_05]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism050u_05]
GO








/*********************************/
/*     공장단위 목표지수 등록    */
/*********************************/

CREATE PROCEDURE sp_pism050u_05
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_stYear	Char(4),		-- 기준년 
	@ps_LastEmp 	VarChar(6)		-- 최종수정자
AS
BEGIN

Declare @Month		int,
	@cvtMonth	Char(2)
	
Set @Month = 1 

Begin Tran 

	WHILE @Month <= 13  
	BEGIN
		Execute sp_pism000_cvtValue @pi_Value = @Month, @ps_cvtValue = @cvtMonth Output 

		INSERT INTO TMHDIVVALUETARGET ( AreaCode, DivisionCode, tarMonth, LastEmp ) 
			Select AreaCode, DivisionCode, @ps_stYear + '.' + @cvtMonth, 'Y' 
			  From TMSTDIVISION A
			 Where ( AreaCode = @ps_area ) And 
			       ( DivisionCode = @ps_div ) And 
             	    Not Exists ( Select DivisionCode FROM TMHDIVVALUETARGET 
			          WHERE ( AreaCode = @ps_area ) AND 
					( DivisionCode = @ps_div ) AND 
					( tarMonth = @ps_stYear + '.' + @cvtMonth ) ) 
		If @@Error <> 0 
		Begin
			RollBack Tran
			Return 
		End

	Set @Month = @Month + 1 
	End	

	Commit Tran

  SELECT A.AreaCode,   
         A.DivisionCode,   
         A.tarMonth,   
         A.tarLPI_bunmo,   
         A.tarLPI_bunja,   
         A.tarLPI,   
         A.LastEmp,   
         A.LastDate, 
	 B.totInMH, 
	 B.ActMH, 
	 B.basicMH 
    FROM TMHDIVVALUETARGET A, 
	( SELECT tarMonth, 
		 sum( IsNull(totInMH,0) ) totInMH, 
		 sum( IsNull(ActMH,0) ) ActMH, 
		 sum( IsNull(basicMH,0) ) basicMH 
	    FROM TMHVALUETARGET 
	   Where ( AreaCode = @ps_area ) And 	
		 ( DivisionCode = @ps_div ) And 
		 ( substring(tarMonth, 1, 4) = @ps_stYear ) 
	Group By tarMonth ) B 
   WHERE ( A.tarMonth = B.tarMonth ) And 
	 ( A.AreaCode = @ps_area ) AND  
         ( A.DivisionCode = @ps_div ) And 
	 ( substring(A.tarMonth, 1, 4) = @ps_stYear ) 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

