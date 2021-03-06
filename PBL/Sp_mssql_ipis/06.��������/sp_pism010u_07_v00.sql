SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_07]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_07]
GO







/******************************/
/*     일일근태내역 Disp      */
/******************************/

CREATE PROCEDURE sp_pism010u_07
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장
	@ps_wc		Varchar(5),		-- 조
	@ps_wday	Char(10) 		-- 작업일자

AS
BEGIN

        SELECT A.DGDAY,
	       A.DGEMPNO,   
	       TMSTEMP.EmpName,   
	       A.DGEMPGB,   
	       A.DGDAYGB,   
	       A.DGTIMER,   
	       IsNull(A.DGCD1R,'') DGCD1R,
	       IsNull(A.DGCD2R,'') DGCD2R,  
	       IsNull(A.DGCD3R,'') DGCD3R,    
	       A.DGDNGBR,   
	       A.DGOTR,   
	       A.DGNTR,   
	       A.DGJOR,   
	       A.DGSANGR,   
	       A.DGJUHUR,   
	       A.DGHUMUR,   
	       A.DGSPCR,   
	       A.DGJIR,   
	       A.DGOOR,   
	       A.DGPOR,   
	       A.DGJTR,   
	       A.DGGUNBOR,   
	       A.DGMUR,   
	       A.DGCLASS,   
	       TMSTCODE.CodeName ClassName, 
	       A.DGINDT,   
	       A.DGINTIME,   
	       A.DGINUSR,   
	       A.DGUPDT,   
	       A.DGUPTIME,   
	       A.DGUPUSR,   
   	       A.excFlag inChk 
          FROM TMHLABTAC A, TMSTEMP, TMSTCODE 
         WHERE ( A.DGEMPNO = TMSTEMP.EmpNo ) and  
	       ( A.DGCLASS = TMSTCODE.CodeID ) And 
	       ( TMSTCODE.CodeGroup = 'OEMPCLASS' ) And 
               ( ( A.DGDAY = @ps_wday ) and 
                 ( A.DGDEPTE = @ps_wc ) ) 

END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

