SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_10]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_10]
GO








/*******************************************/
/*     조별 작업일보 평가제외 사원등록     */
/*******************************************/

CREATE PROCEDURE sp_pism010u_10
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_stDay	Char(10) 

AS
BEGIN

  SELECT @ps_area AreaCode, 
	 @ps_div  DivisionCode, 
	 A.DGDEPTE WorkCenter, 
	 A.DGEmpNo EmpNo, 
	 A.DGCLASS EmpClass 
    Into #Temp_excEmp 
    FROM TMHLABTAC A, 
	 TMSTWORKCENTER B
   WHERE ( B.AreaCode = @ps_area ) And
 	 ( B.DivisionCode = @ps_div ) And 
	 ( B.WorkCenter = A.DGDEPTE ) And 
	 ( B.WorkCenterGubun1 = 'K' ) And 	-- 델파이조 
	 ( IsNull(B.WorkCenterGubun2,'') <> '' ) And 	-- 간접조제외 
	 ( A.DGDEPTE like '%' ) And   
         ( A.DGDAY = (  SELECT max(TMHLABTAC.DGDAY)  
                          FROM TMHLABTAC  
                         WHERE ( TMHLABTAC.DGDEPTE = A.DGDEPTE ) AND  
                               ( TMHLABTAC.DGDAY <= @ps_stDay ) ) ) And 
           ( A.DGJIKCHEK IN ( 'A','B','C'))

 Insert Into TMHDAILYEXCEMP ( AreaCode, DivisionCode, WorkCenter, excEmpNo ) 
      SELECT A.AreaCode, 
             A.DivisionCode, 
             A.WorkCenter, 
	     A.EmpNo 
        FROM #Temp_excEmp A 
       WHERE 
  Not Exists ( Select excEmpNo From TMHDAILYEXCEMP 
		Where ( AreaCode = A.AreaCode ) And 
		      ( DivisionCode = A.DivisionCode ) And 
		      ( WorkCenter = A.WorkCenter ) And 
		      ( excEmpNo = A.EmpNo ) ) 

  SELECT A.AreaCode,   
         A.DivisionCode,   
         A.WorkCenter,   
         B.WorkCenterName,   
	 A.excEmpNo,   
         C.EmpName, 
       ( Select CodeName From TMSTCODE Where CodeGroup = 'OJIKCHEK' And CodeID = C.EmpJikchek ) ClassName, 
         A.excFlag,   
         A.LastEmp,
	 A.LastDate 
    FROM TMHDAILYEXCEMP A,   
         TMSTWORKCENTER B, 
	 TMSTEMP C   
   WHERE ( A.AreaCode = B.AreaCode) and  
         ( A.DivisionCode = B.DivisionCode) and  
         ( A.WorkCenter = B.WorkCenter) and  
	 ( A.excEmpNo *= C.EmpNo ) And 
         ( ( B.AreaCode = @ps_area ) AND 
           ( B.DivisionCode = @ps_div ) And 
	   ( B.WorkCenterGubun1 = 'K' ) And -- 델파이 조 
	   ( IsNull(B.WorkCenterGubun2,'') <> '' ) )   -- 간접조 제외 
 
 Drop Table #Temp_excEmp

END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

