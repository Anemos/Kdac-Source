SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism050u_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism050u_01]
GO








/*****************************/
/*     조별 목표지수 등록    */
/*****************************/

CREATE PROCEDURE sp_pism050u_01
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		Varchar(5),		-- 조
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

		INSERT INTO TMHVALUETARGET ( AreaCode, DivisionCode, WorkCenter, tarMonth, LastEmp ) 
			Select AreaCode, DivisionCode, WorkCenter, @ps_stYear + '.' + @cvtMonth, 'Y' 
			  From TMSTWORKCENTER A
			 Where ( AreaCode = @ps_area ) And 
			       ( DivisionCode = @ps_div ) And 
			       ( WorkCenter like @ps_wc ) And 
			       ( WorkCenterGubun1 = 'K' ) And 
			       ( IsNull(WorkCenterGubun2,'') <> '' ) And 
             	    Not Exists ( Select WorkCenter FROM TMHVALUETARGET  
			          WHERE ( AreaCode = @ps_area ) AND 
					( DivisionCode = @ps_div ) AND 
					( WorkCenter = A.WorkCenter ) And 
					( tarMonth = @ps_stYear + '.' + @cvtMonth ) ) 
		If @@Error <> 0 
		Begin
			RollBack Tran
			Return 
		End

/*
		UPDATE TMHVALUETARGET  
		   SET divtarLPI = ( Select Top 1 divtarLPI From TMHVALUETARGET 
				      Where ( AreaCode = A.AreaCode ) And 
					    ( DivisionCode = A.DivisionCode ) And 
					    ( tarMonth = A.tarMonth ) ) 
		 From TMHVALUETARGET A 
		WHERE ( A.AreaCode = @ps_area ) AND  
		      ( A.DivisionCode = @ps_div ) And 
		      ( A.tarMonth = @ps_stYear + '.' + @cvtMonth ) 
*/
	Set @Month = @Month + 1 
	End	

Commit Tran

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

