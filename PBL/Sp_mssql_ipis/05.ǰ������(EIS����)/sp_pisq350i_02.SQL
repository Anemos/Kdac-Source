/************************************************************************************************/
/*	File Name	: sp_pisq350i_02.SQL                                                            */
/*	SYSTEM		: 품질관리(고객품질)                                                            */
/*	Description	: Weibull Chart 조회                                                            */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQWARRANTYSHEET                                                               */
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_Date            	char(10)    => 기준월 + '.01'                           */
/*                @ps_DateTo          	char(10)    => 기준월 + 월의최종일                      */
/*                @ps_ItemCode          varchar(12) => 품번                                     */
/*                @ps_Analyzecode      	char(06)    => 분석결과코드(제품군포함)                 */
/*                @ps_dptvgubun         char(01)    => DPTV/IPTV구분                            */
/*                @ps_dptvgubun이 '1'이면 DPTV '%'면 'IPTV'이다                                 */
/*	Notes		: Weibull Chart를 화면에 표시한다                                               */
/*	Made Date	: 2002. 10. 02                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq350i_02') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq350i_02
GO
/*
Exec sp_pisq350i_02
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
		@ps_Date            = '2002.12.01' ,
		@ps_DateTo          = '2002.12.31',
		@ps_ItemCode        = '1000001' ,
		@ps_Analyzecode     = '%',
		@ps_dptvgubun       = '%'

*/


/****** Object:  Stored Procedure dbo.sp_pisq350i_02    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq350i_02
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
		@ps_Date              char(10)      ,   -- 기준월 + '.01'
		@ps_DateTo            char(10)      ,   -- 기준월 + 월의최종일
		@ps_ItemCode          varchar(12)   ,   -- 품번
		@ps_Analyzecode       varchar(06)   ,   -- 분석결과코드
		@ps_dptvgubun         char(01)          -- DPTV/IPTV구분
AS

BEGIN

	 SELECT DATEDIFF(month, A.OUTDATE, A.REPAIRDATE) + 1 AS AS_TITLE,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -35, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -35, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_35,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -34, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -34, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_34,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -33, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -33, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_33,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -32, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -32, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_32,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -31, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -31, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_31,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -30, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -30, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_30,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -29, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -29, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_29,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -28, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -28, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_28,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -27, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -27, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_27,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -26, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -26, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_26,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -25, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -25, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_25,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -24, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -24, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_24,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -23, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -23, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_23,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -22, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -22, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_22,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -21, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -21, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_21,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -20, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -20, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_20,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -19, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -19, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_19,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -18, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -18, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_18,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -17, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -17, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_17,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -16, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -16, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_16,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -15, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -15, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_15,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -14, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -14, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_14,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -13, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -13, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_13,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -12, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -12, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_12,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_11,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -10, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_10,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -09, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_09,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -08, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_08,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -07, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_07,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -06, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_06,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -05, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_05,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -04, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_04,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -03, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_03,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -02, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_02,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -01, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_01,
			SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -00, @ps_Date), 102) <= A.LOTNO AND A.LOTNO <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateTo), 102) THEN 1 ELSE 0 END) AS M_00
	   FROM TQWARRANTYSHEET A
	  WHERE A.AREACODE		=  	 @ps_areacode
		AND A.DIVISIONCODE	=  	 @ps_divisioncode
		AND A.ITEMCODE		=	 @ps_ItemCode
		AND A.PRODUCTGROUP + A.ANALYZECODE   LIKE @ps_Analyzecode
		AND A.LOTNO			>=   CONVERT(CHAR(10), DATEADD(month, -35, @ps_Date), 102)
		AND A.LOTNO			<=   @ps_DateTo
		AND A.CUSTOMCODE	LIKE @ps_dptvgubun
	  GROUP BY DATEDIFF(month, A.OUTDATE, A.REPAIRDATE) + 1
	  HAVING DATEDIFF(month, A.OUTDATE, A.REPAIRDATE) + 1 < 37

END 
go
