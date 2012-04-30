/************************************************************************************************/
/*	File Name	: sp_eisq020i_02.SQL                                                            */
/*	SYSTEM		: 경영자용 통합정보	                                                            */
/*	Description	: 일간 수입검사 불량율(전사-LOT)	                                            */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCRESULT                                                                    */
/*	              TMSTDIVISION                                                                  */
/*  Parameter   : @ps_QCDate	        char(10)    => 말일조호일자                             */
/*	Notes		: 전사 일간 수입검사 불량율을 조회한다.						                    */
/*	Made Date	: 2002. 11. 29                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_eisq020i_02') and sysstat & 0xf = 4)
	drop procedure dbo.sp_eisq020i_02
GO
/*
Exec sp_eisq020i_02
        @ps_QCDate	= '2002.11.31'
*/


/****** Object:  Stored Procedure dbo.sp_eisq020i_02    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_eisq020i_02
        @ps_QCDate            char(10)
AS

BEGIN

	SELECT	AS_AREACODE,
			AS_DIVISIONCODE,
			A.AREANAME		AS AS_AREANAME,
			B.DIVISIONNAME	AS AS_DIVISIONNAME,
			I_01,
            I_02,
            I_03,
            I_04,
            I_05,
            I_06,
            I_07,
            I_08,
            I_09,
            I_10,
            I_11,
            I_12,
            I_13,
            I_14,
            I_15,
            I_16,
            I_17,
            I_18,
            I_19,
            I_20,
            I_21,
            I_22,
            I_23,
            I_24,
            I_25,
            I_26,
            I_27,
            I_28,
            I_29,
            I_30,
            I_31,
            I_32,
            B_01,
            B_02,
            B_03,
            B_04,
            B_05,
            B_06,
            B_07,
            B_08,
            B_09,
            B_10,
            B_11,
            B_12,
            B_13,
            B_14,
            B_15,
            B_16,
            B_17,
            B_18,
            B_19,
            B_20,
            B_21,
            B_22,
            B_23,
            B_24,
            B_25,
            B_26,
            B_27,
            B_28,
            B_29,
            B_30,
            B_31,
            B_32
	  FROM	(
			SELECT	AS_AREACODE,
					AS_DIVISIONCODE,
					SUM(ISNULL(D_S01, 0)) AS I_01,
		            SUM(ISNULL(D_S02, 0)) AS I_02,
		            SUM(ISNULL(D_S03, 0)) AS I_03,
		            SUM(ISNULL(D_S04, 0)) AS I_04,
		            SUM(ISNULL(D_S05, 0)) AS I_05,
		            SUM(ISNULL(D_S06, 0)) AS I_06,
		            SUM(ISNULL(D_S07, 0)) AS I_07,
		            SUM(ISNULL(D_S08, 0)) AS I_08,
		            SUM(ISNULL(D_S09, 0)) AS I_09,
		            SUM(ISNULL(D_S10, 0)) AS I_10,
		            SUM(ISNULL(D_S11, 0)) AS I_11,
		            SUM(ISNULL(D_S12, 0)) AS I_12,
		            SUM(ISNULL(D_S13, 0)) AS I_13,
		            SUM(ISNULL(D_S14, 0)) AS I_14,
		            SUM(ISNULL(D_S15, 0)) AS I_15,
		            SUM(ISNULL(D_S16, 0)) AS I_16,
		            SUM(ISNULL(D_S17, 0)) AS I_17,
		            SUM(ISNULL(D_S18, 0)) AS I_18,
		            SUM(ISNULL(D_S19, 0)) AS I_19,
		            SUM(ISNULL(D_S20, 0)) AS I_20,
		            SUM(ISNULL(D_S21, 0)) AS I_21,
		            SUM(ISNULL(D_S22, 0)) AS I_22,
		            SUM(ISNULL(D_S23, 0)) AS I_23,
		            SUM(ISNULL(D_S24, 0)) AS I_24,
		            SUM(ISNULL(D_S25, 0)) AS I_25,
		            SUM(ISNULL(D_S26, 0)) AS I_26,
		            SUM(ISNULL(D_S27, 0)) AS I_27,
		            SUM(ISNULL(D_S28, 0)) AS I_28,
		            SUM(ISNULL(D_S29, 0)) AS I_29,
		            SUM(ISNULL(D_S30, 0)) AS I_30,
		            SUM(ISNULL(D_S31, 0)) AS I_31,
		            SUM(ISNULL(D_S32, 0)) AS I_32,
		            SUM(ISNULL(D_B01, 0)) AS B_01,
		            SUM(ISNULL(D_B02, 0)) AS B_02,
		            SUM(ISNULL(D_B03, 0)) AS B_03,
		            SUM(ISNULL(D_B04, 0)) AS B_04,
		            SUM(ISNULL(D_B05, 0)) AS B_05,
		            SUM(ISNULL(D_B06, 0)) AS B_06,
		            SUM(ISNULL(D_B07, 0)) AS B_07,
		            SUM(ISNULL(D_B08, 0)) AS B_08,
		            SUM(ISNULL(D_B09, 0)) AS B_09,
		            SUM(ISNULL(D_B10, 0)) AS B_10,
		            SUM(ISNULL(D_B11, 0)) AS B_11,
		            SUM(ISNULL(D_B12, 0)) AS B_12,
		            SUM(ISNULL(D_B13, 0)) AS B_13,
		            SUM(ISNULL(D_B14, 0)) AS B_14,
		            SUM(ISNULL(D_B15, 0)) AS B_15,
		            SUM(ISNULL(D_B16, 0)) AS B_16,
		            SUM(ISNULL(D_B17, 0)) AS B_17,
		            SUM(ISNULL(D_B18, 0)) AS B_18,
		            SUM(ISNULL(D_B19, 0)) AS B_19,
		            SUM(ISNULL(D_B20, 0)) AS B_20,
		            SUM(ISNULL(D_B21, 0)) AS B_21,
		            SUM(ISNULL(D_B22, 0)) AS B_22,
		            SUM(ISNULL(D_B23, 0)) AS B_23,
		            SUM(ISNULL(D_B24, 0)) AS B_24,
		            SUM(ISNULL(D_B25, 0)) AS B_25,
		            SUM(ISNULL(D_B26, 0)) AS B_26,
		            SUM(ISNULL(D_B27, 0)) AS B_27,
		            SUM(ISNULL(D_B28, 0)) AS B_28,
		            SUM(ISNULL(D_B29, 0)) AS B_29,
		            SUM(ISNULL(D_B30, 0)) AS B_30,
		            SUM(ISNULL(D_B31, 0)) AS B_31,
		            SUM(ISNULL(D_B32, 0))    B_32
			  FROM	(
					SELECT	A.AREACODE 		AS AS_AREACODE,
							A.DIVISIONCODE	AS AS_DIVISIONCODE,
							-- 업체LOT수량
							--
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '01'  = A.QCDATE THEN COUNT(*) END AS D_S01,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '02'  = A.QCDATE THEN COUNT(*) END AS D_S02,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '03'  = A.QCDATE THEN COUNT(*) END AS D_S03,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '04'  = A.QCDATE THEN COUNT(*) END AS D_S04,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '05'  = A.QCDATE THEN COUNT(*) END AS D_S05,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '06'  = A.QCDATE THEN COUNT(*) END AS D_S06,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '07'  = A.QCDATE THEN COUNT(*) END AS D_S07,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '08'  = A.QCDATE THEN COUNT(*) END AS D_S08,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '09'  = A.QCDATE THEN COUNT(*) END AS D_S09,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '10'  = A.QCDATE THEN COUNT(*) END AS D_S10,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '11'  = A.QCDATE THEN COUNT(*) END AS D_S11,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '12'  = A.QCDATE THEN COUNT(*) END AS D_S12,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '13'  = A.QCDATE THEN COUNT(*) END AS D_S13,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '14'  = A.QCDATE THEN COUNT(*) END AS D_S14,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '15'  = A.QCDATE THEN COUNT(*) END AS D_S15,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '16'  = A.QCDATE THEN COUNT(*) END AS D_S16,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '17'  = A.QCDATE THEN COUNT(*) END AS D_S17,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '18'  = A.QCDATE THEN COUNT(*) END AS D_S18,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '19'  = A.QCDATE THEN COUNT(*) END AS D_S19,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '20'  = A.QCDATE THEN COUNT(*) END AS D_S20,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '21'  = A.QCDATE THEN COUNT(*) END AS D_S21,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '22'  = A.QCDATE THEN COUNT(*) END AS D_S22,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '23'  = A.QCDATE THEN COUNT(*) END AS D_S23,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '24'  = A.QCDATE THEN COUNT(*) END AS D_S24,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '25'  = A.QCDATE THEN COUNT(*) END AS D_S25,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '26'  = A.QCDATE THEN COUNT(*) END AS D_S26,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '27'  = A.QCDATE THEN COUNT(*) END AS D_S27,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '28'  = A.QCDATE THEN COUNT(*) END AS D_S28,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '29'  = A.QCDATE THEN COUNT(*) END AS D_S29,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '30'  = A.QCDATE THEN COUNT(*) END AS D_S30,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '31'  = A.QCDATE THEN COUNT(*) END AS D_S31,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '01' <= A.QCDATE 
							 							 AND  A.QCDATE <= @ps_QCDate THEN COUNT(*) END AS D_S32,
							-- 불량LOT수량                                                                                                                                                 
							--
					 	    0 AS D_B01,
					 	    0 AS D_B02,
					 	    0 AS D_B03,
					 	    0 AS D_B04,
					 	    0 AS D_B05,
					 	    0 AS D_B06,
					 	    0 AS D_B07,
					 	    0 AS D_B08,
					 	    0 AS D_B09,
					 	    0 AS D_B10,
					 	    0 AS D_B11,
					 	    0 AS D_B12,
					 	    0 AS D_B13,
					 	    0 AS D_B14,
					 	    0 AS D_B15,
					 	    0 AS D_B16,
					 	    0 AS D_B17,
					 	    0 AS D_B18,
					 	    0 AS D_B19,
					 	    0 AS D_B20,
					 	    0 AS D_B21,
					 	    0 AS D_B22,
					 	    0 AS D_B23,
					 	    0 AS D_B24,
					 	    0 AS D_B25,
					 	    0 AS D_B26,
					 	    0 AS D_B27,
					 	    0 AS D_B28,
					 	    0 AS D_B29,
					 	    0 AS D_B30,
					 	    0 AS D_B31,
							0 AS D_B32
					  FROM	TQQCRESULT  A                                                                                                                                                      
					 WHERE	A.QCDATE	>=   SUBSTRING(@ps_QCDate, 1, 8) + '01'
					   AND	A.QCDATE	<=   @ps_QCDate
					 GROUP	BY A.AREACODE, A.DIVISIONCODE, A.QCDATE
		
			         UNION	ALL
		
					SELECT	A.AREACODE 		AS AS_AREACODE,
							A.DIVISIONCODE	AS AS_DIVISIONCODE,
							-- 업체납품수량
							--
					 	    0 AS D_S01,
					 	    0 AS D_S02,
					 	    0 AS D_S03,
					 	    0 AS D_S04,
					 	    0 AS D_S05,
					 	    0 AS D_S06,
					 	    0 AS D_S07,
					 	    0 AS D_S08,
					 	    0 AS D_S09,
					 	    0 AS D_S10,
					 	    0 AS D_S11,
					 	    0 AS D_S12,
					 	    0 AS D_S13,
					 	    0 AS D_S14,
					 	    0 AS D_S15,
					 	    0 AS D_S16,
					 	    0 AS D_S17,
					 	    0 AS D_S18,
					 	    0 AS D_S19,
					 	    0 AS D_S20,
					 	    0 AS D_S21,
					 	    0 AS D_S22,
					 	    0 AS D_S23,
					 	    0 AS D_S24,
					 	    0 AS D_S25,
					 	    0 AS D_S26,
					 	    0 AS D_S27,
					 	    0 AS D_S28,
					 	    0 AS D_S29,
					 	    0 AS D_S30,
					 	    0 AS D_S31,
							0 AS D_S32,
							-- 불량수량                                                                                                                                                 
							--
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '01'  = A.QCDATE THEN COUNT(*) END AS D_B01,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '02'  = A.QCDATE THEN COUNT(*) END AS D_B02,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '03'  = A.QCDATE THEN COUNT(*) END AS D_B03,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '04'  = A.QCDATE THEN COUNT(*) END AS D_B04,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '05'  = A.QCDATE THEN COUNT(*) END AS D_B05,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '06'  = A.QCDATE THEN COUNT(*) END AS D_B06,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '07'  = A.QCDATE THEN COUNT(*) END AS D_B07,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '08'  = A.QCDATE THEN COUNT(*) END AS D_B08,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '09'  = A.QCDATE THEN COUNT(*) END AS D_B09,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '10'  = A.QCDATE THEN COUNT(*) END AS D_B10,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '11'  = A.QCDATE THEN COUNT(*) END AS D_B11,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '12'  = A.QCDATE THEN COUNT(*) END AS D_B12,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '13'  = A.QCDATE THEN COUNT(*) END AS D_B13,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '14'  = A.QCDATE THEN COUNT(*) END AS D_B14,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '15'  = A.QCDATE THEN COUNT(*) END AS D_B15,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '16'  = A.QCDATE THEN COUNT(*) END AS D_B16,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '17'  = A.QCDATE THEN COUNT(*) END AS D_B17,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '18'  = A.QCDATE THEN COUNT(*) END AS D_B18,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '19'  = A.QCDATE THEN COUNT(*) END AS D_B19,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '20'  = A.QCDATE THEN COUNT(*) END AS D_B20,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '21'  = A.QCDATE THEN COUNT(*) END AS D_B21,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '22'  = A.QCDATE THEN COUNT(*) END AS D_B22,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '23'  = A.QCDATE THEN COUNT(*) END AS D_B23,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '24'  = A.QCDATE THEN COUNT(*) END AS D_B24,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '25'  = A.QCDATE THEN COUNT(*) END AS D_B25,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '26'  = A.QCDATE THEN COUNT(*) END AS D_B26,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '27'  = A.QCDATE THEN COUNT(*) END AS D_B27,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '28'  = A.QCDATE THEN COUNT(*) END AS D_B28,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '29'  = A.QCDATE THEN COUNT(*) END AS D_B29,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '30'  = A.QCDATE THEN COUNT(*) END AS D_B30,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '31'  = A.QCDATE THEN COUNT(*) END AS D_B31,
					 	    CASE WHEN SUBSTRING(@ps_QCDate, 1, 8) + '01' <= A.QCDATE                                            
														 AND  A.QCDATE <= @ps_QCDate THEN COUNT(*) END AS D_B32
					  FROM	TQQCRESULT  A                                                                                                                                                      
					 WHERE	A.QCDATE	>=   SUBSTRING(@ps_QCDate, 1, 8) + '01'
					   AND	A.QCDATE	<=   @ps_QCDate
			           AND	A.JUDGEFLAG  IN   ('2', '3')
					 GROUP	BY A.AREACODE, A.DIVISIONCODE, A.QCDATE
					) TMP
				 GROUP	BY AS_AREACODE, AS_DIVISIONCODE
			) TEMP, TMSTAREA A, TMSTDIVISION B
	 WHERE	AS_AREACODE		= A.AREACODE
	   AND	AS_AREACODE		= B.AREACODE
	   AND	AS_DIVISIONCODE	= B.DIVISIONCODE
	 ORDER  BY AS_AREACODE, B.SORTORDER

END 

go
