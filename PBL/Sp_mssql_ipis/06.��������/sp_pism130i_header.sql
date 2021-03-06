SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism130i_header]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism130i_header]
GO







/********************************/ 
/*     공수투입 현황 - Header   */ 
/********************************/ 

CREATE PROCEDURE [dbo].[sp_pism130i_header]
	@ps_retGubun 	Char(1) 
AS
BEGIN

 Create Table #Temp_dispName 
	( Seq1		int,
	  Seq2		int		null,
	  dispLevel	Char(1),
	  dispName	VarChar(100) 	null ) 

If @ps_retGubun = '1' 
	Insert Into #Temp_dispName 
	  SELECT 1 Seq1,  
		 0 Seq2, 
		'1' dispLevel, 
		'   정시공수 (B)' dispName 
	 Union 
	  SELECT 2, 0, '1', '   정시외공수 (C)'  		Union 
	  SELECT 3, 0, '0', '총보유공수 (A=B+C)' 		Union 
	-- 상세조회일 경우 ( 평가제외 무급공수 'K' ) 
	  SELECT 5, 0, '1', '   무급공수 (E)'    		Union 
	-- 평가제외 유급공수 'S' 
	  SELECT 7, 0, '1', '   유급공수 (F)'  			Union 
	  SELECT 8, 0, '0', '평가제외공수 (D=E+F)' 		Union 
	  SELECT 9, 0, '0', '총투입공수 (G=A-D)' 		Union 
	-- 유급근태사고공수 'B'
	  SELECT 11, 0, '1', '   유급근태사고공수 (H)' 		Union 
	-- 일보사고공수 'G'
	  SELECT 13, 0, '1', '   일보사고공수 (I)' 		Union 
	-- 부가작업공수 'F'
	  SELECT 15, 0, '1', '   부가작업공수 (J)' 		Union 
	-- 유휴공수 'U'
	  SELECT 17, 0, '1', '   유휴공수 (K)' 			Union 
	  SELECT 18, 0, '0', '비가동공수 계 (L=H+I+J+K)' 	Union 
	  SELECT 19, 0, '0', '실투입공수 {M=G-(H+I+J)}' 	Union 
	  SELECT 20, 0, '0', '실동공수 (N=G-L)' 		Union 
	-- 능률저하 'Z' 
	  SELECT 23, 0, '0', '표준생산공수 (O)' 		Union 
	  SELECT 24, 0, '0', '실동율 (P=N/G)' 			Union 
	  SELECT 25, 0, '0', '작업효율 (Q=O/N)' 		Union 
	  SELECT 26, 0, '0', '종합효율 (R=P*Q)' 		Union 
	  SELECT 27, 0, '0', 'LPI' 
  Else	-- 상세조회 
	Insert Into #Temp_dispName 
	  SELECT 1 Seq1,  
		 0 Seq2, 
		'1' dispLevel, 
		'   정시공수 (B)' dispName 			Union 
	  SELECT 2, 0, '1', '   정시외공수 (C)' 		Union 
	  SELECT 3, 0, '0', '총보유공수 (A=B+C)' 		Union 
	-- 상세조회일 경우 ( 평가제외 무급공수 'K' ) 
	Select 4, B.printSq, '2', space(6) + B.mhName From TMHCODE B 
	 Where ( B.mhGubun = 'K' ) And ( IsNull(B.useFlag,'0') = '1' ) 	Union 
	  SELECT 5, 0, '1', '   무급공수 (E)' 				Union 
	-- 평가제외 유급공수 'S' 
	Select 6, B.printSq, '2', space(6) + B.mhName From TMHCODE B 
	 Where ( B.mhGubun = 'S' ) And ( IsNull(B.useFlag,'0') = '1' ) 
	Union 
	  SELECT 7, 0, '1', '   유급공수 (F)' 				Union 
	  SELECT 8, 0, '0', '평가제외공수 (D=E+F)' 			Union 
	  SELECT 9, 0, '0', '총투입공수 (G=A-D)' 			Union 
	-- 유급근태사고공수 'B'
	Select 10, B.printSq, '2', space(6) + B.mhName From TMHCODE B 
	 Where ( B.mhGubun = 'B' ) And ( IsNull(B.useFlag,'0') = '1' ) 	Union 
	  SELECT 11, 0, '1', '   유급근태사고공수 (H)' 			Union 
	-- 일보사고공수 'G'
	Select 12, B.printSq, '2', space(6) + B.mhName From TMHCODE B 
	 Where ( B.mhGubun = 'G' ) And ( IsNull(B.useFlag,'0') = '1' ) 	Union 
	  SELECT 13, 0, '1', '   일보사고공수 (I)' 			Union 
	-- 부가작업공수 'F'
	Select 14, B.printSq, '2', space(6) + B.mhName From TMHCODE B 
	 Where ( B.mhGubun = 'F' ) And ( IsNull(B.useFlag,'0') = '1' ) 	Union 
	  SELECT 15, 0, '1', '   부가작업공수 (J)' 			Union 
	-- 유휴공수 'U'
	Select 16, B.printSq, '2', space(6) + B.mhName From TMHCODE B 
	 Where ( B.mhGubun = 'U' ) And ( IsNull(B.useFlag,'0') = '1' )  Union 
	  SELECT 17, 0, '1', '   유휴공수 (K)' 			        Union 
	  SELECT 18, 0, '0', '비가동공수 계 (L=H+I+J+K)' 	        Union 
	  SELECT 19, 0, '0', '실투입공수 {M=G-(H+I+J)}' 		Union 
	  SELECT 20, 0, '0', '실동공수 (N=G-L)' 			Union 
	-- 능률저하 'Z' 
	Select 21, B.printSq, '2', space(6) + B.mhName From TMHCODE B 
	 Where ( B.mhGubun = 'Z' ) And ( IsNull(B.useFlag,'0') = '1' ) 	Union 
	  SELECT 22, 0, '1', '   능률저하공수' 				Union 
	  SELECT 23, 0, '0', '표준생산공수 (O)' 			Union 
	  SELECT 24, 0, '0', '실동율 (P=N/G)' 				Union 
	  SELECT 25, 0, '0', '작업효율 (Q=O/N)' 			Union 
	  SELECT 26, 0, '0', '종합효율 (R=P*Q)' 			Union 
	  SELECT 27, 0, '0', 'LPI' 

 Select * From #Temp_dispName Order By Seq1, Seq2 

 Drop Table #Temp_dispName 
END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

