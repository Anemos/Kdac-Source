/************************************************************************************************/
/*	File Name	: sp_pisq370i_01.SQL                                                            */
/*	SYSTEM		: 품질관리(고객품질)                                                            */
/*	Description	: 발생월별 불량유형 현황                                                        */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQWARRANTYSHEET                                                       		*/
/*  			  TQWARRANTYSMALL                                                       		*/
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_ItemCode          varchar(12) => 품번                                     */
/*                @ps_Date            	char(10)    => 기준월                                   */
/*	Notes		: 발생월별 불량유형 현황을 화면에 표시한다                                      */
/*	Made Date	: 2002. 10. 02                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq370i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq370i_01
GO
/*
Exec sp_pisq370i_01
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
		@ps_ItemCode        = '1' ,
		@ps_Date            = '2002.12.01' 

*/


/****** Object:  Stored Procedure dbo.sp_pisq370i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq370i_01
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
		@ps_ItemCode          varchar(12)   ,   -- 품번
        @ps_Date              char(10)          -- 기준월
AS

BEGIN

	 SELECT A.ANALYZECODE		AS AS_ANALYZECODE,
		    B.SMALLGROUPNAME	AS AS_SMALLGROUPNAME,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -35, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_35,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -34, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_34,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -33, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_33,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -32, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_32,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -31, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_31,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -30, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_30,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -29, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_29,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -28, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_28,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -27, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_27,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -26, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_26,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -25, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_25,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -24, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_24,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -23, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_23,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -22, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_22,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -21, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_21,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -20, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_20,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -19, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_19,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -18, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_18,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -17, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_17,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -16, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_16,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -15, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_15,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -14, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_14,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -13, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_13,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -12, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_12,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_11,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -10, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_10,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -09, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_09,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -08, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_08,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -07, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_07,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -06, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_06,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -05, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_05,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -04, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_04,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -03, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_03,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -02, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_02,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -01, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_01,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -00, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_00,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -35, @ps_Date), 102) <= A.RAISEDATE AND A.RAISEDATE <= CONVERT(CHAR(07), DATEADD(month, -00, @ps_Date), 102) THEN 1 ELSE 0 END) AS M_TOT
	   FROM TQWARRANTYSHEET A,
			TQWARRANTYSMALL B
 	  WHERE A.AREACODE		=  B.AREACODE
		AND A.DIVISIONCODE	=  B.DIVISIONCODE
	    AND	A.PRODUCTGROUP  =  B.PRODUCTGROUP
		AND A.ANALYZECODE	=  B.LARGEGROUPCODE + B.MIDDLEGROUPCODE + B.SMALLGROUPCODE
		AND A.AREACODE		=  @ps_areacode
		AND A.DIVISIONCODE	=  @ps_divisioncode
		AND A.ITEMCODE		=  @ps_ItemCode
		AND A.RAISEDATE		>= CONVERT(CHAR(07), DATEADD(month, -35, @ps_Date), 102)
		AND A.RAISEDATE		<= SUBSTRING(@ps_Date, 1, 7)
 	  GROUP BY A.ANALYZECODE, B.SMALLGROUPNAME

	 UNION ALL

	 SELECT '합계' 	AS AS_ANALYZECODE,
		    '합계'	AS AS_SMALLGROUPNAME,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -35, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_35,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -34, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_34,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -33, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_33,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -32, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_32,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -31, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_31,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -30, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_30,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -29, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_29,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -28, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_28,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -27, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_27,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -26, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_26,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -25, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_25,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -24, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_24,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -23, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_23,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -22, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_22,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -21, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_21,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -20, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_20,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -19, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_19,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -18, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_18,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -17, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_17,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -16, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_16,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -15, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_15,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -14, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_14,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -13, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_13,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -12, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_12,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_11,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -10, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_10,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -09, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_09,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -08, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_08,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -07, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_07,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -06, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_06,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -05, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_05,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -04, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_04,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -03, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_03,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -02, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_02,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -01, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_01,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -00, @ps_Date), 102) = A.RAISEDATE THEN 1 ELSE 0 END) AS M_00,
			SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -35, @ps_Date), 102) <= A.RAISEDATE AND A.RAISEDATE <= CONVERT(CHAR(07), DATEADD(month, -00, @ps_Date), 102) THEN 1 ELSE 0 END) AS M_TOT
	   FROM TQWARRANTYSHEET A
	  WHERE A.AREACODE		=  @ps_areacode
		AND A.DIVISIONCODE	=  @ps_divisioncode
		AND A.ITEMCODE		=  @ps_ItemCode
		AND A.RAISEDATE		>= CONVERT(CHAR(07), DATEADD(month, -35, @ps_Date), 102)
		AND A.RAISEDATE		<= SUBSTRING(@ps_Date, 1, 7)
   
END 

go
