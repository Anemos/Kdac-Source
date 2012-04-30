/************************************************************************************************/
/*	File Name	: sp_eisq030i_01.SQL                                                            */
/*	SYSTEM		: 경영자용 통합정보	                                                            */
/*	Description	: 월간 공정중 소재 불량율(전사)		                                            */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQPROCESSTOBED																*/
/*	              TMSTAREA		                                                                */
/*	              TMSTDIVISION                                                                  */
/*  Parameter   : @ps_QCDateB	        char(4)    => 조회전년 			                        */
/*  			  @ps_QCDate	        char(4)    => 조회년 			                        */
/*	Notes		: 월간 공정중 소재 불량율을 조회한다.						                    */
/*	Made Date	: 2002. 12. 18                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_eisq030i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_eisq030i_01
GO
/*
Exec sp_eisq030i_01
        @ps_QCDateB      = '2001',
        @ps_QCDate       = '2002'
*/


/****** Object:  Stored Procedure dbo.sp_eisq030i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_eisq030i_01
        @ps_QCDateB        char(4),
        @ps_QCDate         char(4)
AS

BEGIN
	SELECT AS_AREACODE,
           AS_DIVISIONCODE,
		   A.AREANAME				AS AS_AREANAME,
		   B.DIVISIONNAME			AS AS_DIVISIONNAME,
		   SUM(ISNULL(I_000, 0)) AS I_00,
		   SUM(ISNULL(I_001, 0))   AS I_01,
		   SUM(ISNULL(I_002, 0))   AS I_02,
		   SUM(ISNULL(I_003, 0))   AS I_03,
		   SUM(ISNULL(I_004, 0))   AS I_04,
		   SUM(ISNULL(I_005, 0))   AS I_05,
		   SUM(ISNULL(I_006, 0))   AS I_06,
		   SUM(ISNULL(I_007, 0))   AS I_07,
	 	   SUM(ISNULL(I_008, 0))   AS I_08,
		   SUM(ISNULL(I_009, 0))   AS I_09,
		   SUM(ISNULL(I_010, 0))   AS I_10,
		   SUM(ISNULL(I_011, 0))   AS I_11,
		   SUM(ISNULL(I_012, 0))   AS I_12,
		   SUM(ISNULL(I_013, 0))   AS I_13,
		   SUM(ISNULL(B_000, 0))   AS B_00,
		   SUM(ISNULL(B_001, 0))   AS B_01,
		   SUM(ISNULL(B_002, 0))   AS B_02,
		   SUM(ISNULL(B_003, 0))   AS B_03,
		   SUM(ISNULL(B_004, 0))   AS B_04,
		   SUM(ISNULL(B_005, 0))   AS B_05,
		   SUM(ISNULL(B_006, 0))   AS B_06,
		   SUM(ISNULL(B_007, 0))   AS B_07,
		   SUM(ISNULL(B_008, 0))   AS B_08,
		   SUM(ISNULL(B_009, 0))   AS B_09,
		   SUM(ISNULL(B_010, 0))   AS B_10,
		   SUM(ISNULL(B_011, 0))   AS B_11,
		   SUM(ISNULL(B_012, 0))   AS B_12,
		   SUM(ISNULL(B_013, 0))   AS B_13
	  FROM (SELECT	A.AREACODE					AS AS_AREACODE,
					A.DIVISIONCODE				AS AS_DIVISIONCODE,
					A.MAKEDATE					AS AS_MAKEDATE,
					CASE WHEN @ps_QCDateB	    =  SUBSTRING(A.MAKEDATE,1,4) THEN SUM(A.INQTY)  ELSE 0 END AS I_000,
					CASE WHEN @ps_QCDate + '.01'=  A.MAKEDATE                THEN SUM(A.INQTY)  ELSE 0 END AS I_001,
					CASE WHEN @ps_QCDate + '.02'=  A.MAKEDATE                THEN SUM(A.INQTY)  ELSE 0 END AS I_002,
					CASE WHEN @ps_QCDate + '.03'=  A.MAKEDATE                THEN SUM(A.INQTY)  ELSE 0 END AS I_003,
					CASE WHEN @ps_QCDate + '.04'=  A.MAKEDATE                THEN SUM(A.INQTY)  ELSE 0 END AS I_004,
					CASE WHEN @ps_QCDate + '.05'=  A.MAKEDATE                THEN SUM(A.INQTY)  ELSE 0 END AS I_005,
					CASE WHEN @ps_QCDate + '.06'=  A.MAKEDATE                THEN SUM(A.INQTY)  ELSE 0 END AS I_006,
					CASE WHEN @ps_QCDate + '.07'=  A.MAKEDATE                THEN SUM(A.INQTY)  ELSE 0 END AS I_007,
					CASE WHEN @ps_QCDate + '.08'=  A.MAKEDATE                THEN SUM(A.INQTY)  ELSE 0 END AS I_008,
					CASE WHEN @ps_QCDate + '.09'=  A.MAKEDATE                THEN SUM(A.INQTY)  ELSE 0 END AS I_009,
					CASE WHEN @ps_QCDate + '.10'=  A.MAKEDATE                THEN SUM(A.INQTY)  ELSE 0 END AS I_010,
					CASE WHEN @ps_QCDate + '.11'=  A.MAKEDATE                THEN SUM(A.INQTY)  ELSE 0 END AS I_011,
					CASE WHEN @ps_QCDate + '.12'=  A.MAKEDATE                THEN SUM(A.INQTY)  ELSE 0 END AS I_012,
					CASE WHEN @ps_QCDate        =  SUBSTRING(A.MAKEDATE,1,4) THEN SUM(A.INQTY)  ELSE 0 END AS I_013,
					CASE WHEN @ps_QCDateB	    =  SUBSTRING(A.MAKEDATE,1,4) THEN SUM(A.BADQTY) ELSE 0 END AS B_000,
					CASE WHEN @ps_QCDate + '.01'=  A.MAKEDATE                THEN SUM(A.BADQTY) ELSE 0 END AS B_001,
					CASE WHEN @ps_QCDate + '.02'=  A.MAKEDATE                THEN SUM(A.BADQTY) ELSE 0 END AS B_002,
					CASE WHEN @ps_QCDate + '.03'=  A.MAKEDATE                THEN SUM(A.BADQTY) ELSE 0 END AS B_003,
					CASE WHEN @ps_QCDate + '.04'=  A.MAKEDATE                THEN SUM(A.BADQTY) ELSE 0 END AS B_004,
					CASE WHEN @ps_QCDate + '.05'=  A.MAKEDATE                THEN SUM(A.BADQTY) ELSE 0 END AS B_005,
					CASE WHEN @ps_QCDate + '.06'=  A.MAKEDATE                THEN SUM(A.BADQTY) ELSE 0 END AS B_006,
					CASE WHEN @ps_QCDate + '.07'=  A.MAKEDATE                THEN SUM(A.BADQTY) ELSE 0 END AS B_007,
					CASE WHEN @ps_QCDate + '.08'=  A.MAKEDATE                THEN SUM(A.BADQTY) ELSE 0 END AS B_008,
					CASE WHEN @ps_QCDate + '.09'=  A.MAKEDATE                THEN SUM(A.BADQTY) ELSE 0 END AS B_009,
					CASE WHEN @ps_QCDate + '.10'=  A.MAKEDATE                THEN SUM(A.BADQTY) ELSE 0 END AS B_010,
					CASE WHEN @ps_QCDate + '.11'=  A.MAKEDATE                THEN SUM(A.BADQTY) ELSE 0 END AS B_011,
					CASE WHEN @ps_QCDate + '.12'=  A.MAKEDATE                THEN SUM(A.BADQTY) ELSE 0 END AS B_012,
					CASE WHEN @ps_QCDate        =  SUBSTRING(A.MAKEDATE,1,4) THEN SUM(A.BADQTY) ELSE 0 END AS B_013
			  FROM	TQPROCESSTOBED	A
			 WHERE	A.MAKEDATE	   >= @ps_QCDateB + '.01'
			   AND	A.MAKEDATE	   <= @ps_QCDate  + '.12'
			 GROUP  BY A.AREACODE, A.DIVISIONCODE,  A.MAKEDATE
		   ) TMP, TMSTAREA A, TMSTDIVISION B
	 WHERE RTRIM(AS_AREACODE)		= A.AREACODE
	   AND RTRIM(AS_AREACODE)		= B.AREACODE
	   AND RTRIM(AS_DIVISIONCODE)	= B.DIVISIONCODE
	 GROUP BY AS_AREACODE, AS_DIVISIONCODE, A.AREANAME, B.DIVISIONNAME, B.SORTORDER
	 ORDER BY AS_AREACODE, B.SORTORDER

END 

go
