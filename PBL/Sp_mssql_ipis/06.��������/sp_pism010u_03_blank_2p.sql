SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_03_blank_2p]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_03_blank_2p]
GO





/*********************************************/
/*      작업일보 생산수량내역 출력 (을지)    */
/*********************************************/

CREATE PROCEDURE sp_pism010u_03_blank_2p
	@ps_area		Char(1),		-- 지역
	@ps_div			Char(1),		-- 공장
	@ps_wc			Varchar(5)		-- 조

AS
BEGIN


	SELECT Top 26 Seq, 
		      wcItemGroup, 
		      ItemCode,   
		      subLineCode,  
		      subLineNo 
 	  Into #Temp_daily_1p 
	  From TMHWCITEM  
	 Where ( AreaCode = @ps_area ) AND  
	       ( DivisionCode = @ps_div ) AND  
	       ( WorkCenter = @ps_wc ) And 
	       ( IsNull(UseFlag,'') <> '0' ) 
      Order By Seq asc,
	       ItemCode asc,   
	       subLineCode asc,  
	       subLineNo asc 

	SELECT A.DivisionCode,   
	       A.AreaCode,   
	       A.WorkCenter,  
	       A.wcItemGroup, 
	       A.ItemCode,   
	       A.subLineCode,  
	       A.subLineNo,   
	       A.seq, 
	       A.useFlag, 
	       B.ItemName,   
	       B.ItemSpec 
	  From TMHWCITEM A,    
	       TMSTITEM B
	 Where 	( A.ItemCode *= B.ItemCode ) and  
		       ( 	( A.AreaCode = @ps_area ) AND  
		         	( A.DivisionCode = @ps_div ) AND  
		         	( A.WorkCenter = @ps_wc ) And 
				( IsNull(A.UseFlag,'') <> '0' ) And 
      				Not EXISTS ( SELECT * From #Temp_daily_1p 
		    		Where ( Seq = A.Seq ) ) ) 

Drop Table #Temp_daily_1p 
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

