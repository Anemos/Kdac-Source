/************************************************************************************************/
/*	File Name	: sp_eisq125i_01.SQL                                                            */
/*	SYSTEM		: 경영자용 통합정보	                                                            */
/*	Description	: 월간 제품별 Warranty 현황(공장별-금액)                                        */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQMANAGEMASTER																*/
/*  			  TMSTPRODUCTGROUP																*/
/*  			  TLOTNO																		*/
/*  			  VMSTKB_MODEL																	*/
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_DateFmb           char(10)    => 전년조회일자FROM                         */
/*                @ps_DateTob           char(10)    => 전년조회일자TO                           */
/*                @ps_DateFm            char(10)    => 조회일자FROM                             */
/*                @ps_DateTo            char(10)    => 조회일자TO                               */
/*                @ps_exportgubun		char(1)     => 내수(D), 수출(E), 전체(%)                */
/*	Notes		: 월간 제품별 Warranty 현황을 표시한다    		                                */
/*	Made Date	: 2002. 12. 12                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_eisq125i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_eisq125i_01
GO
/*
Exec sp_eisq125i_01
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'V' ,
		@ps_DateFmb         = '2001.12.01' ,
		@ps_DateTob         = '2001.12.31' ,
		@ps_DateFm          = '2002.12.01' ,
		@ps_DateTo          = '2002.12.31' ,
		@ps_exportgubun		= '%'

*/


/****** Object:  Stored Procedure dbo.sp_eisq125i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_eisq125i_01
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
		@ps_DateFmb           char(10)      ,   -- 전년조회일자FROM
		@ps_DateTob           char(10)      ,   -- 전년조회일자TO
		@ps_DateFm            char(10)      ,   -- 조회일자FROM
		@ps_DateTo            char(10)      ,   -- 조회일자TO
		@ps_exportgubun		  varchar(1)		-- 내수(D), 수출(E), 전체(%)
AS

BEGIN
			
	SELECT	A.AREACODE			AS AS_AREA, 
			D.AREANAME			AS AS_AREANAME, 
			A.DIVISIONCODE		AS AS_DIVISION,
			E.DIVISIONNAME		AS AS_DIVISIONNAME,
			A.PRODUCTGROUP		AS AS_PRODUCT		,
			B.PRODUCTGROUPNAME	AS AS_PRODUCTNAME	,
			-- 전년
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_DateFmb), 102) <= A.ACCOUNTDATE AND A.ACCOUNTDATE  <= CONVERT(CHAR(07), DATEADD(month, -00, @ps_DateFmb), 102) THEN A.CONFIRMAMOUNT ELSE 0 END), 0) AS I_00,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMAMOUNT ELSE 0 END), 0) AS I_01,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -10, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMAMOUNT ELSE 0 END), 0) AS I_02,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -09, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMAMOUNT ELSE 0 END), 0) AS I_03,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -08, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMAMOUNT ELSE 0 END), 0) AS I_04,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -07, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMAMOUNT ELSE 0 END), 0) AS I_05,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -06, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMAMOUNT ELSE 0 END), 0) AS I_06,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -05, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMAMOUNT ELSE 0 END), 0) AS I_07,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -04, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMAMOUNT ELSE 0 END), 0) AS I_08,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -03, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMAMOUNT ELSE 0 END), 0) AS I_09,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -02, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMAMOUNT ELSE 0 END), 0) AS I_10,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -01, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMAMOUNT ELSE 0 END), 0) AS I_11,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -00, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMAMOUNT ELSE 0 END), 0) AS I_12,
			-- 누계
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_DateFm), 102) <= A.ACCOUNTDATE AND A.ACCOUNTDATE <= CONVERT(CHAR(07), DATEADD(month, -00, @ps_DateFm), 102) THEN A.CONFIRMAMOUNT ELSE 0 END), 0) AS I_13,
			-- 목표
         	isnull(MAX(C.AMOUNTYEARGOAL), 0)	AS I_14
	  FROM	TQMANAGEMASTER			A,
			TMSTPRODUCTGROUP		B,
			TQWARRANTYGOALREJECT	C,
			TMSTAREA				D,
			TMSTDIVISION			E			
	 WHERE	A.AREACODE		 =  B.AREACODE		
	   AND  A.DIVISIONCODE	 =  B.DIVISIONCODE
	   AND  A.PRODUCTGROUP	 =  B.PRODUCTGROUP
	   AND  A.AREACODE		*=  C.AREACODE
	   AND  A.DIVISIONCODE	*=  C.DIVISIONCODE
	   AND  C.STANDARDYEAR 	 =  SUBSTRING(@ps_DateFm, 1, 4)
	   AND  A.PRODUCTGROUP  *=  C.PRODUCTGROUP
	   AND  A.AREACODE		 =  D.AREACODE		
	   AND  A.AREACODE		 =  E.AREACODE		
	   AND  A.DIVISIONCODE	 =  E.DIVISIONCODE
	   AND  A.AREACODE		 =  @ps_AreaCode
	   AND  A.DIVISIONCODE	 =  @ps_DivisionCode
	   AND  A.ACCOUNTDATE	>=  CONVERT(CHAR(07), DATEADD(month, -11, @ps_DateFmb), 102)
	   AND  A.ACCOUNTDATE	<=  SUBSTRING(@ps_DateFm, 1, 7)
	   AND  A.EXPORTGUBUN LIKE  @ps_exportgubun
	 GROUP  BY A.AREACODE, D.AREANAME, A.DIVISIONCODE, E.DIVISIONNAME, A.PRODUCTGROUP, B.PRODUCTGROUPNAME
	 ORDER  BY A.AREACODE, A.DIVISIONCODE, A.PRODUCTGROUP, B.PRODUCTGROUPNAME
   
END 

go
