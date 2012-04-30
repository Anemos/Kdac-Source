/************************************************************************************************/
/*	File Name	: sp_eisq010i_01.SQL                                                            */
/*	SYSTEM		: 경영자용 통합정보	                                                            */
/*	Description	: 월간 수입검사 불량율(전사-수량)	                                            */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCRESULT                                                                    */
/*	              TMSTDIVISION                                                                  */
/*  Parameter   : @ps_QCDateFmb         char(10)    => 전년조회일자FROM                         */
/*                @ps_QCDateTob         char(10)    => 전년조회일자TO                           */
/*  			  @ps_QCDateFm          char(10)    => 조회일자FROM                             */
/*                @ps_QCDateTo          char(10)    => 조회일자TO                               */
/*	Notes		: 전사 월간 수입검사 불량율을 조회한다.						                    */
/*	Made Date	: 2002. 11. 27                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_eisq010i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_eisq010i_01
GO
/*
Exec sp_eisq010i_01
        @ps_QCDateFmb       = '2001.12.01',
        @ps_QCDateTob       = '2001.12.31',
        @ps_QCDateFm        = '2002.12.01',
        @ps_QCDateTo        = '2002.12.31'
*/


/****** Object:  Stored Procedure dbo.sp_eisq010i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_eisq010i_01
        @ps_QCDateFmb         char(10)      ,   -- 전년조회일자FROM
        @ps_QCDateTob         char(10)		,   -- 전년조회일자TO
        @ps_QCDateFm          char(10)      ,   -- 조회일자FROM
        @ps_QCDateTo          char(10)          -- 조회일자TO
AS

BEGIN

	SELECT	AS_AREACODE,
			AS_DIVISIONCODE,
			A.AREANAME		AS AS_AREANAME,
			B.DIVISIONNAME	AS AS_DIVISIONNAME,
			SUM(ISNULL(M_IBYEAR, 0)) AS I_00,
			SUM(ISNULL(M_I11, 0))	 AS I_01,
			SUM(ISNULL(M_I10, 0))	 AS I_02,
			SUM(ISNULL(M_I09, 0))	 AS I_03,
			SUM(ISNULL(M_I08, 0))	 AS I_04,
			SUM(ISNULL(M_I07, 0))	 AS I_05,
			SUM(ISNULL(M_I06, 0))	 AS I_06,
			SUM(ISNULL(M_I05, 0))	 AS I_07,
			SUM(ISNULL(M_I04, 0))	 AS I_08,
			SUM(ISNULL(M_I03, 0))	 AS I_09,
			SUM(ISNULL(M_I02, 0))	 AS I_10,
			SUM(ISNULL(M_I01, 0))	 AS I_11,
			SUM(ISNULL(M_I00, 0))	 AS I_12,
			SUM(ISNULL(M_IYEAR, 0))	 AS I_13,
			SUM(ISNULL(M_BBYEAR, 0)) AS B_00,
			SUM(ISNULL(M_B11, 0))	 AS B_01,
			SUM(ISNULL(M_B10, 0))	 AS B_02,
			SUM(ISNULL(M_B09, 0))	 AS B_03,
			SUM(ISNULL(M_B08, 0))	 AS B_04,
			SUM(ISNULL(M_B07, 0))	 AS B_05,
			SUM(ISNULL(M_B06, 0))	 AS B_06,
			SUM(ISNULL(M_B05, 0))	 AS B_07,
			SUM(ISNULL(M_B04, 0))	 AS B_08,
			SUM(ISNULL(M_B03, 0))	 AS B_09,
			SUM(ISNULL(M_B02, 0))	 AS B_10,
			SUM(ISNULL(M_B01, 0))	 AS B_11,
			SUM(ISNULL(M_B00, 0))	 AS B_12,
			SUM(ISNULL(M_BYEAR, 0))	 AS B_13
	  FROM	(
			SELECT	A.AREACODE 		AS AS_AREACODE,
					A.DIVISIONCODE	AS AS_DIVISIONCODE,
					-- 업체납품수량
					--
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFmb),102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTob),102) THEN SUM(ISNULL(A.SUPPLIERDELIVERYQTY, 0)) END AS M_IBYEAR,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.SUPPLIERDELIVERYQTY, 0)) END AS M_I11,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.SUPPLIERDELIVERYQTY, 0)) END AS M_I10,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.SUPPLIERDELIVERYQTY, 0)) END AS M_I09,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.SUPPLIERDELIVERYQTY, 0)) END AS M_I08,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.SUPPLIERDELIVERYQTY, 0)) END AS M_I07,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.SUPPLIERDELIVERYQTY, 0)) END AS M_I06,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.SUPPLIERDELIVERYQTY, 0)) END AS M_I05,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.SUPPLIERDELIVERYQTY, 0)) END AS M_I04,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.SUPPLIERDELIVERYQTY, 0)) END AS M_I03,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.SUPPLIERDELIVERYQTY, 0)) END AS M_I02,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.SUPPLIERDELIVERYQTY, 0)) END AS M_I01,
					CASE WHEN                                       @ps_QCDateFm        <= A.QCDATE AND A.QCDATE <=                                       @ps_QCDateTo        THEN SUM(ISNULL(A.SUPPLIERDELIVERYQTY, 0)) END AS M_I00,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.SUPPLIERDELIVERYQTY, 0)) END AS M_IYEAR,
					-- 불량수량                                                                                                                                                        
					--
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFmb),102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTob),102) THEN SUM(ISNULL(A.BADQTY, 0)) END AS M_BBYEAR,	
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.BADQTY, 0)) END AS M_B11,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.BADQTY, 0)) END AS M_B10,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.BADQTY, 0)) END AS M_B09,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.BADQTY, 0)) END AS M_B08,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.BADQTY, 0)) END AS M_B07,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.BADQTY, 0)) END AS M_B06,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.BADQTY, 0)) END AS M_B05,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.BADQTY, 0)) END AS M_B04,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.BADQTY, 0)) END AS M_B03,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.BADQTY, 0)) END AS M_B02,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.BADQTY, 0)) END AS M_B01,
					CASE WHEN                                       @ps_QCDateFm        <= A.QCDATE AND A.QCDATE <=                                       @ps_QCDateTo        THEN SUM(ISNULL(A.BADQTY, 0)) END AS M_B00,
					CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN SUM(ISNULL(A.BADQTY, 0)) END AS M_BYEAR
			  FROM	TQQCRESULT  A                                                                                                                                                      
			 WHERE	A.QCDATE	>=   CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFmb), 102)
			   AND	A.QCDATE	<=   @ps_QCDateTo
			 GROUP	BY A.AREACODE, A.DIVISIONCODE, A.QCDATE
			) TMP, TMSTAREA A, TMSTDIVISION B
	 WHERE	AS_AREACODE		= A.AREACODE
	   AND	AS_AREACODE		= B.AREACODE
	   AND	AS_DIVISIONCODE	= B.DIVISIONCODE
	 GROUP  BY AS_AREACODE, AS_DIVISIONCODE, A.AREANAME, B.DIVISIONNAME, B.SORTORDER
	 ORDER  BY AS_AREACODE, B.SORTORDER

END 

go
