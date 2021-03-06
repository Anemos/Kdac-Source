SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism050u_04]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism050u_04]
GO


/*****************************/
/*     조별 목표공수 조회    */
/*****************************/

CREATE PROCEDURE sp_pism050u_04
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		Varchar(5),		-- 조
	@ps_stYear	Char(4),		-- 기준년 
	@ps_LastEmp	Varchar(6)		-- 최종수정자 
AS
BEGIN

Declare @lastYear	Char(4)

Set @lastYear = Cast ( Cast( @ps_stYear as Numeric(4) ) - 1 as Char(4) )

	begin		
		Execute sp_pism050u_03 
			@ps_area		= @ps_area,
			@ps_div			= @ps_div,
			@ps_wc			= @ps_wc,
			@ps_stYear		= @ps_stYear,
			@ps_LastEmp		= @ps_LastEmp 
		If @@Error <> 0 Goto Exit_pr 
  end
  
SELECT 	A.AreaCode,   
       	A.DivisionCode,   
	A.WorkCenter,   
	F.WorkCenterName,   
	C.ProductGroup,   
	E.ProductGroupName,   
	A.ItemCode,   
	D.ItemName,   
	A.subLineCode, 
	A.subLineNo, 
	A.tarMonth,   
	A.tarMH,   
	A.modifyFlag,   
	A.LastEmp,
	A.LastDate 
    FROM	TMHMONTHTARGET A,   
	TMSTMODEL C,   
         	TMSTITEM D,   
         	TMSTPRODUCTGROUP E,   
         	TMSTWORKCENTER F,
	TMHSTANDARD G 
   WHERE ( A.AreaCode = C.AreaCode ) And 
	 ( A.DivisionCode = C.DivisionCode ) And 
	 ( A.ItemCode = C.ItemCode ) And 
	 ( A.AreaCode = E.AreaCode ) And 
	 ( A.DivisionCode = E.DivisionCode ) And 
	 ( A.AreaCode = F.AreaCode ) And 
	 ( A.DivisionCode = F.DivisionCode ) And 
	 ( A.WorkCenter = F.WorkCenter ) And 
	 ( C.ItemCode = D.ItemCode ) And 
         ( C.ProductGroup = E.ProductGroup ) And 
         ( A.AreaCode = G.AreaCode ) and  
         ( A.DivisionCode = G.DivisionCode ) and  
         ( A.WorkCenter = G.WorkCenter ) and  
	 ( A.ItemCode = G.ItemCode ) and  
	 ( A.subLineCode = G.subLineCode ) And 
	 ( A.subLineNo = G.subLineNo ) And 
  	 ( ( A.AreaCode = @ps_area ) AND  
           ( A.DivisionCode = @ps_div ) AND  
           ( A.WorkCenter like @ps_wc ) AND  
           ( substring(A.tarMonth, 1, 4) = @ps_stYear ) And 
	   ( G.stYear = @lastYear ) ) 
 Order By A.AreaCode,   
       	 A.DivisionCode,   
         A.WorkCenter,   
         C.ProductGroup, 
	 A.ItemCode, 
	 A.subLineCode, 
	 A.subLineNo, 
	 A.tarMonth 

Exit_pr:

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

