USE [IPIS]
GO
/****** Object:  StoredProcedure [dbo].[sp_pism010u_dailydelete]    Script Date: 05/04/2012 10:06:13 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



/*************************/
/*     �۾��Ϻ� ����     */
/*************************/

ALTER PROCEDURE [dbo].[sp_pism010u_dailydelete]
	@ps_area	Char(1),		-- ����
	@ps_div		Char(1),		-- ����
	@ps_wc		Varchar(5),		-- ��
	@ps_wday	Char(10),		-- �۾����� 
	@ri_error	int Output

AS
BEGIN
	
   DELETE FROM TMHDAILYDETAIL 
	 WHERE ( AreaCode = @ps_area ) AND  
	       ( DivisionCode = @ps_div ) AND  
	       ( WorkCenter = @ps_wc ) And 
	       ( WorkDay = @ps_wday ) 
	If @@Error <> 0 Goto Exit_pr 
	
   DELETE FROM TMHDAILYSUB
	 WHERE ( AreaCode = @ps_area ) AND  
	       ( DivisionCode = @ps_div ) AND  
	       ( WorkCenter = @ps_wc ) And 
	       ( WorkDay = @ps_wday )  
	If @@Error <> 0 Goto Exit_pr 
	
   DELETE FROM TMHSUPPORT
	 WHERE ( AreaCode = @ps_area ) AND  
	       ( DivisionCode = @ps_div ) AND  
	       ( WorkCenter = @ps_wc ) And 
	       ( WorkDay = @ps_wday )  
	If @@Error <> 0 Goto Exit_pr 
	
   DELETE FROM TMHREALPROD     
	 WHERE ( AreaCode = @ps_area ) AND  
	       ( DivisionCode = @ps_div ) AND  
	       ( WorkCenter = @ps_wc ) And 
	       ( WorkDay = @ps_wday )  
	If @@Error <> 0 Goto Exit_pr 

   DELETE FROM TMHDAILY 
	 WHERE ( AreaCode = @ps_area ) AND  
	       ( DivisionCode = @ps_div ) AND  
	       ( WorkCenter = @ps_wc ) And 
	       ( WorkDay = @ps_wday ) 
	If @@Error <> 0 Goto Exit_pr 

   DELETE FROM TMHDAILYSTATUS 
	 WHERE ( AreaCode = @ps_area ) AND  
	       ( DivisionCode = @ps_div ) AND  
	       ( WorkCenter = @ps_wc ) And 
	       ( WorkDay = @ps_wday )  
	If @@Error <> 0 Goto Exit_pr 

Exit_pr:

Select	@ri_error	= @@Error
return @ri_error

END


