SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism040u_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism040u_01]
GO








/*********************************/
/*     기준년 기준공수 등록      */
/*********************************/

CREATE PROCEDURE sp_pism040u_01
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_stYear	Char(4),		-- 기준년 
	@ps_wc		Varchar(5),		-- 조
	@ps_lastEmp	Varchar(6)		-- 사번

AS 
BEGIN 

Begin Tran 
	Begin

	  INSERT INTO tmhstandard 
	       ( AreaCode, DivisionCode, stYear, WorkCenter, ItemCode, subLineCode, subLineNo, LastEmp )  
	  SELECT A.AreaCode,   
	         A.DivisionCode,   
		 @ps_stYear, 
	         A.WorkCenter,   
	         A.ItemCode, 
		 A.subLineCode, 
		 A.subLineNo, 
	         'Y' 
	    FROM TMHMONTHPRODLINE_S A 
	   WHERE ( A.AreaCode = @ps_area ) AND  
	         ( A.DivisionCode = @ps_div ) AND  
	         ( A.WorkCenter like @ps_wc ) AND  
		 ( substring(A.sMonth, 1, 4) = @ps_stYear ) And 
	         ( A.pQty > 0 ) And 
      Not Exists ( SELECT AreaCode, DivisionCode, WorkCenter, ItemCode, subLineCode, subLineNo 
	             FROM tmhstandard 
		    WHERE ( AreaCode = A.AreaCode ) and ( DivisionCode = A.DivisionCode ) and ( WorkCenter = A.WorkCenter ) And 
			  ( ItemCode = A.ItemCode ) And ( subLineCode = A.subLineCode ) And ( subLineNo = A.subLineNo ) And 
			  ( stYear = @ps_stYear ) ) 
	GROUP BY A.AreaCode, A.DivisionCode, A.WorkCenter, A.ItemCode, A.subLineCode, A.subLineNo 
	
	If @@Error <> 0 Goto Exit_pr  	
	End

	Begin
	  INSERT INTO tmhstandard 
	       ( AreaCode, DivisionCode, stYear, WorkCenter, ItemCode, subLineCode, subLineNo, modifyFlag, LastEmp )  
	  SELECT A.AreaCode,   
	         A.DivisionCode,   
		 @ps_stYear, 
	         A.WorkCenter,   
	         A.ItemCode,
		 A.subLineCode, 
		 A.subLineNo, 
		 '0', 
		 'Y' 
	    FROM TMHWCITEM A
	   WHERE ( A.AreaCode = @ps_area ) AND  
	         ( A.DivisionCode = @ps_div ) AND  
	         ( A.WorkCenter like @ps_wc ) AND 
	        ( IsNull(A.useFlag,'0') <> '3' ) and
	        ( isnull(A.wcitemgroup,'') <> '' ) and
      Not Exists ( SELECT AreaCode, DivisionCode, WorkCenter, ItemCode, subLineCode, subLineNo 
		     FROM tmhstandard 
		    WHERE ( AreaCode = A.AreaCode ) and ( DivisionCode = A.DivisionCode ) and ( WorkCenter = A.WorkCenter ) And 
			  ( ItemCode = A.ItemCode ) And ( subLineCode = A.subLineCode ) And ( subLineNo = A.subLineNo ) And 
			  ( stYear = @ps_stYear ) ) 
	GROUP BY A.AreaCode,  A.DivisionCode, A.WorkCenter, A.ItemCode, A.subLineCode, A.subLineNo 

	End 

Commit Tran

Exit_pr: 

If @@Error <> 0 RollBack Tran 

Return 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

