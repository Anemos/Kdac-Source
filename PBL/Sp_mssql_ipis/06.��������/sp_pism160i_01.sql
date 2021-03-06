SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism160i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism160i_01]
GO








/**************************************/ 
/*     시간단위 지원공수 발생내역     */ 
/**************************************/ 

CREATE PROCEDURE sp_pism160i_01
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		VarChar(5),		-- 조
	@ps_stFromDate	Char(10),		-- 기준일 From
	@ps_stToDate	Char(10)		-- 기준일 To 
AS
BEGIN

 Declare @WorkCenter	VarChar(5),
	 @WorkDay 	Char(10),
	 @supWorkCenter VarChar(5), 
	 @supGubun	Char(1), 
	 @supMH   	Numeric(5,1), 
	 @rowNo 	Int 

 Create Table #Temp_supWC 
        ( WorkCenter		VarChar(5)	Not Null, 
	  WorkCenterName	VarChar(30)	Null,
	  WorkDay		Char(10)	Not Null ) 

   Insert Into #Temp_supWC 
	Select A.WorkCenter,
	       B.WorkCenterName,
	       A.WorkDay 
	  From TMHSUPPORT A,   
	       TMSTWORKCENTER B, 
	       TMHDAILYSTATUS C 
	 Where ( A.AreaCode = B.AreaCode ) And 
	       ( A.DivisionCode = B.DivisionCode ) And 
	       ( A.WorkCenter = B.Workcenter ) And 
	       ( A.AreaCode = C.AreaCode ) And 
	       ( A.DivisionCode = C.DivisionCode ) And 
	       ( A.WorkCenter = C.WorkCenter ) And 
	       ( A.WorkDay = C.WorkDay ) And 
	       ( ( A.AreaCode = @ps_area ) And 	
		 ( A.DivisionCode = @ps_div ) And 
		 ( A.WorkCenter like @ps_wc ) And 
		 ( A.WorkDay Between @ps_stFromDate and @ps_stToDate ) And 
		 ( B.WorkCenterGubun1 = 'K' ) And 
		 ( IsNull(B.WorkCenterGubun2,'') <> '' ) And 
		 ( C.DailyStatus = '1' ) ) 
	Union 
	Select A.supWorkCenter,
	       B.WorkCenterName,
	       A.WorkDay 
	  From TMHSUPPORT A,   
	       TMSTWORKCENTER B, 
	       TMHDAILYSTATUS C 
	 Where ( A.AreaCode = B.AreaCode ) And 
	       ( A.DivisionCode = B.DivisionCode ) And 
	       ( A.supWorkCenter = B.Workcenter ) And 
	       ( A.AreaCode = C.AreaCode ) And 
	       ( A.DivisionCode = C.DivisionCode ) And 
	       ( A.WorkCenter = C.WorkCenter ) And 
	       ( A.WorkDay = C.WorkDay ) And 
	       ( ( A.AreaCode = @ps_area ) And 
		 ( A.DivisionCode = @ps_div ) And 
		 ( A.supWorkCenter like @ps_wc ) And 
	  	 ( A.WorkDay Between @ps_stFromDate and @ps_stToDate ) And 
		 ( B.WorkCenterGubun1 = 'K' ) And 
		 ( IsNull(B.WorkCenterGubun2,'') <> '' ) And 
		 ( C.DailyStatus = '1' ) )

 Create Table #Temp_supWC_m 
        ( WorkCenter		VarChar(5)	Not Null, 
	  WorkDay		Char(10)	Not Null,
	  rowNo			int		Not NULL,
	  m_WorkCenter		VarChar(5)	Not NULL,
	  m_supGubun		Char(1)		Not NULL,
	  m_supMH		Numeric(5,1)	NULL ) 

 Create Table #Temp_supWC_p 
        ( WorkCenter		VarChar(5)	Not Null, 
	  WorkDay		Char(10)	Not Null,
	  rowNo			int		Not NULL,
	  p_WorkCenter		VarChar(5)	Not NULL,
	  p_supGubun		Char(1)		Not NULL,
	  p_supMH		Numeric(5,1)	NULL ) 


	DECLARE supWCList CURSOR FOR  
         Select WorkCenter, 
		WorkDay 
	   From #Temp_supWC 
	OPEN supWCList
	FETCH NEXT FROM supWCList INTO @WorkCenter, @WorkDay 
	WHILE @@FETCH_STATUS = 0 
	Begin
		Set @rowNo = 0 

		DECLARE supMHList_m CURSOR FOR  
		  Select A.supWorkCenter,
			 A.supGubun, 
			 sum( IsNull(A.supMH,0) + IsNull(A.etcsupMH,0) ) m_supMH 
		    From TMHSUPPORT A 
		   Where ( A.WorkCenter = @WorkCenter ) And 
			 ( A.WorkDay = @WorkDay ) 
		Group By A.supWorkCenter,
			 A.WorkDay, 
			 A.supGubun
		OPEN supMHList_m 
		FETCH NEXT FROM supMHList_m INTO @supWorkCenter, @supGubun, @supMH  
		WHILE @@FETCH_STATUS = 0
		Begin
			Set @rowNo = @rowNo + 1 
			Insert Into #Temp_supWC_m ( WorkCenter, WorkDay, rowNo, m_WorkCenter, m_supGubun, m_supMH ) 
			  Values ( @WorkCenter, @WorkDay, @rowNo, @supWorkCenter, @supGubun, @supMH ) 

			FETCH NEXT FROM supMHList_m INTO @supWorkCenter, @supGubun, @supMH   
		End 
		CLOSE supMHList_m 
		DEALLOCATE supMHList_m  
	
		Set @rowNo = 0 

		DECLARE supMHList_p CURSOR FOR  
		 Select A.WorkCenter,
			A.supGubun, 
		 	sum( IsNull(A.supMH,0) + IsNull(A.etcsupMH,0) ) p_supMH 
		   From TMHSUPPORT A 
		  Where ( A.supWorkCenter = @WorkCenter ) And 
		 	( A.WorkDay = @WorkDay ) 
	       Group By A.WorkCenter,
			A.WorkDay, 
		 	A.supGubun 
		OPEN supMHList_p
		FETCH NEXT FROM supMHList_p INTO @supWorkCenter, @supGubun, @supMH  
		WHILE @@FETCH_STATUS = 0
		Begin
			Set @rowNo = @rowNo + 1 
			Insert Into #Temp_supWC_p ( WorkCenter, WorkDay, rowNo, p_WorkCenter, p_supGubun, p_supMH ) 
			  Values ( @WorkCenter, @WorkDay, @rowNo, @supWorkCenter, @supGubun, @supMH ) 

			FETCH NEXT FROM supMHList_p INTO @supWorkCenter, @supGubun, @supMH  
		End 
		CLOSE supMHList_p 
		DEALLOCATE supMHList_p   
	
		FETCH NEXT FROM supWCList INTO @WorkCenter, @WorkDay 

	End 
	CLOSE supWCList 
	DEALLOCATE supWCList    

       Select A.WorkCenter, 
	      A.WorkCenterName,
	      A.Workday, 
	      B.rowNo, 
	      B.m_WorkCenter,
	      B.m_supGubun, 
	      B.m_supMH, 
	      C.p_WorkCenter,
	      C.p_supGubun, 
	      C.p_supMH 
 	 Into #Temp_disp 
	 From #Temp_supWC A,
	      #Temp_supWC_m B,
	      #Temp_supWC_p C 
	Where ( A.WorkCenter = B.WorkCenter ) And 
	      ( A.WorkDay = B.WorkDay ) And 
	      ( A.WorkCenter = C.WorkCenter ) And 
	      ( A.WorkDay = C.WorkDay ) And 
	      ( B.rowNo = C.rowNo ) 

       Select WorkCenter, 
	      WorkCenterName,
	      Workday, 
	      m_WorkCenter,
	      ( Case substring(m_WorkCenter,3,2) When '00' Then ( Select deptName From TMSTDEPT 
								   Where ( AreaCode = @ps_area ) And 
									 ( DivisionCode = @ps_div ) And 
									 ( DeptCode = m_WorkCenter ) ) 
		Else ( Select WorkCenterName From TMSTWORKCENTER 
			Where ( AreaCode = @ps_area ) And ( DivisionCode like ( Case @ps_area When 'J' Then '%' Else @ps_div End ) ) And ( WorkCenter = m_WorkCenter ) ) End ) m_WorkCenterName, 
	      m_supGubun, 
	      m_supMH, 
	      p_WorkCenter,
	      ( Case substring(p_WorkCenter,3,2) When '00' Then ( Select deptName From TMSTDEPT 
								   Where ( AreaCode = @ps_area ) And 
									 ( DivisionCode = @ps_div ) And 
									 ( DeptCode = p_WorkCenter ) ) 
		Else ( Select WorkCenterName From TMSTWORKCENTER 
			Where ( AreaCode = @ps_area ) And ( DivisionCode like ( Case @ps_area When 'J' Then '%' Else @ps_div End ) ) And ( WorkCenter = p_WorkCenter ) ) End ) p_WorkCenterName, 
	      p_supGubun, 
	      p_supMH 
	 From #Temp_disp 
	Union 
       Select A.WorkCenter, 
	      A.WorkCenterName,
	      A.Workday, 
	      B.m_WorkCenter,
	      ( Case substring(m_WorkCenter,3,2) When '00' Then ( Select deptName From TMSTDEPT 
								   Where ( AreaCode = @ps_area ) And 
									 ( DivisionCode = @ps_div ) And 
									 ( DeptCode = m_WorkCenter ) ) 
		Else ( Select WorkCenterName From TMSTWORKCENTER 
			Where ( AreaCode = @ps_area ) And ( DivisionCode like ( Case @ps_area When 'J' Then '%' Else @ps_div End ) ) And ( WorkCenter = m_WorkCenter ) ) End ) m_WorkCenterName, 
	      B.m_supGubun, 
	      B.m_supMH, 
	      NULL,
	      NULL, 
	      NULL, 
	      NULL   
	 From #Temp_supWC A,
	      #Temp_supWC_m B 
	Where ( A.WorkCenter = B.WorkCenter ) And 
	      ( A.WorkDay = B.WorkDay ) And 
	      ( Not Exists ( Select rowNo From #Temp_disp 
			      Where ( WorkCenter = B.WorkCenter ) and 
				    ( WorkDay = B.WorkDay ) And 
				    ( rowNo = B.rowNo ) ) ) 
	Union 
       Select A.WorkCenter, 
	      A.WorkCenterName,
	      A.Workday, 
	      NULL,
	      NULL,
	      NULL, 
	      NULL, 
	      C.p_WorkCenter,
	      ( Case substring(p_WorkCenter,3,2) When '00' Then ( Select deptName From TMSTDEPT 
								   Where ( AreaCode = @ps_area ) And 
									 ( DivisionCode = @ps_div ) And 
									 ( DeptCode = p_WorkCenter ) ) 
		Else ( Select WorkCenterName From TMSTWORKCENTER 
			Where ( AreaCode = @ps_area ) And ( DivisionCode like ( Case @ps_area When 'J' Then '%' Else @ps_div End ) ) And ( WorkCenter = p_WorkCenter ) ) End ) p_WorkCenterName, 
	      C.p_supGubun, 
	      C.p_supMH 
	 From #Temp_supWC A,
	      #Temp_supWC_p C
	Where ( A.WorkCenter = C.WorkCenter ) And 
	      ( A.WorkDay = C.WorkDay ) And 
	      ( Not Exists ( Select rowNo From #Temp_disp 
			      Where ( WorkCenter = C.WorkCenter ) and 
				    ( WorkDay = C.WorkDay ) And 
				    ( rowNo = C.rowNo ) ) ) 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

