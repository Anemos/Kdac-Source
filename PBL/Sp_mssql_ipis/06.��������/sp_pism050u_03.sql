SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism050u_03]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism050u_03]
GO







/*****************************/
/*     조별 목표공수 등록    */
/*****************************/

CREATE PROCEDURE sp_pism050u_03
	@ps_area		Char(1),		-- 지역
	@ps_div			Char(1),		-- 공장	
	@ps_wc			Varchar(5),		-- 조
	@ps_stYear		Char(4),		-- 기준년 
	@ps_LastEmp 		VarChar(6)		-- 최종수정자
AS
BEGIN

Declare @Month		int,
	@cvtMonth	Char(2),
	@lastYear	Char(4) 
	
Set @Month = 1 
Set @lastYear = Cast ( Cast( @ps_stYear as Numeric(4) ) - 1 as Char(4) )

Begin Tran 

	WHILE @Month <= 12 
	BEGIN
		Execute sp_pism000_cvtValue @pi_Value = @Month, @ps_cvtValue = @cvtMonth Output 

		  INSERT INTO TMHMONTHTARGET  
		         ( AreaCode, DivisionCode, WorkCenter, ItemCode, subLineCode, subLineNo, tarMonth, LastEmp )  
		  SELECT AreaCode, DivisionCode, WorkCenter, ItemCode, subLineCode, subLineNo, @ps_stYear + '.' + @cvtMonth, 'Y' 
		     FROM TMHSTANDARD A 
		     Where ( AreaCode = @ps_area ) And 
			   ( DivisionCode = @ps_div ) And 
			   ( WorkCenter like @ps_wc ) And 
			   ( stYear = @lastYear ) And 
		Not Exists ( Select ItemCode, subLineCode, subLineNo From TMHMONTHTARGET 
			      Where ( AreaCode = A.AreaCode ) And 
				    ( DivisionCode = A.DivisionCode ) And 
		                    ( WorkCenter = A.WorkCenter ) And 
				    ( ItemCode = A.ItemCode ) And 
				    ( subLineCode = A.subLineCode ) And 
				    ( subLineNo = A.subLineNo ) And 
		                    ( tarMonth = @ps_stYear + '.' + @cvtMonth ) ) 
		If @@Error <> 0 
		Begin
			RollBack Tran
			Return 
		End

	Set @Month = @Month + 1 
	End	

	Update TMHMONTHTARGET 
	   Set tarMH = IsNull(D.calctarMH,0), 
	       LastEmp = 'Y' 
	  From ( SELECT A.WorkCenter,   
			A.ItemCode,   
			A.subLineCode, 
			A.subLineNo, 
			A.tarMonth,   
			Case IsNull(C.tarLPI,0) When 0 Then 0 Else 
			     Round( IsNull(B.stMH,0) / IsNull(C.tarLPI,0) * 100, 5 ) End calctarMH 
		   FROM TMHMONTHTARGET A,   
			TMHSTANDARD B,   
			TMHVALUETARGET C 
		  WHERE ( A.AreaCode = B.AreaCode ) and  
			( A.DivisionCode = B.DivisionCode ) and  
			( A.WorkCenter = B.WorkCenter ) and  
			( A.ItemCode = B.ItemCode ) and  
			( A.subLineCode = B.subLineCode ) And 
			( A.subLineNo = B.subLineNo ) And 
			( A.AreaCode = C.AreaCode ) and  
			( A.DivisionCode = C.DivisionCode ) and  
			( A.WorkCenter = C.WorkCenter ) and  
			( A.tarMonth = C.tarMonth ) and  
			( ( A.AreaCode = @ps_area ) AND  
			( A.DivisionCode = @ps_div ) AND  
			( B.stYear = @lastYear ) ) ) D 
	Where ( TMHMONTHTARGET.WorkCenter = D.WorkCenter ) And 
	      ( TMHMONTHTARGET.ItemCode = D.ItemCode ) And 
	      ( TMHMONTHTARGET.subLineCode = D.subLineCode ) And 
	      ( TMHMONTHTARGET.subLineNo = D.subLineNo ) And 
	      ( TMHMONTHTARGET.tarMonth = D.tarMonth ) And 
	      ( ( TMHMONTHTARGET.AreaCode = @ps_area ) And 
		( TMHMONTHTARGET.DivisionCode = @ps_div ) And 
		( TMHMONTHTARGET.WorkCenter like @ps_wc ) And 
		( IsNull(TMHMONTHTARGET.tarMH,0) = 0 ) ) 
Commit Tran 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

