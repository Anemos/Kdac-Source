/************************************************************************************************/
/*	File Name	: sp_pisq090i_01.SQL                                                            */
/*	SYSTEM		: 품질관리(부품품질)                                                            */
/*	Description	: 검사 대기현황(비간판용)                                                       */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCRESULT                                                                    */
/*	              TMSTAREA                                                                      */
/*	              TMSTDIVISION                                                                  */
/*	              TMSTSUPPLIER                                                                  */
/*	              TMSTITEM                                                                      */
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_DivisionCode      char(01)    => 공장코드                                 */
/*                @ps_DeliveryDate      char(10)    => 납품일자                                 */
/*                @ps_SupplierCode      char(05)	=> 업체코드                                 */
/*                @ps_ItemCode          varchar(12) => 품번                                     */
/*	Notes		: 검사대기현황의 왼쪽 거래명세표 정보를 조회한다.                               */
/*	Made Date	: 2002. 09. 12                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq090i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq090i_01
GO
/*
Exec sp_pisq090i_01
		@ps_AreaCode        = 'D'    ,
		@ps_DivisionCode    = 'H'    ,
        @ps_DeliveryDate    = '%'    ,
        @ps_SupplierCode    = '%'    ,
        @ps_ItemCode        = '%'
*/


/****** Object:  Stored Procedure dbo.sp_pisq090i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq090i_01
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_DeliveryDate      varchar(10)   ,   -- 납품일자
        @ps_SupplierCode      varchar(05)   ,	-- 업체코드
        @ps_ItemCode          varchar(12)       -- 품번

AS

BEGIN

  SELECT A.AREACODE             ,
         B.AREANAME             ,
         A.DIVISIONCODE         ,
         C.DIVISIONNAME         ,   
         A.SLNO                 ,   
         A.DELIVERYDATE         ,   
         A.SUPPLIERCODE         ,   
         D.SUPPLIERKORNAME      ,   
         A.ITEMCODE             ,   
         E.ITEMNAME             ,   
         A.SUPPLIERDELIVERYQTY  ,   
         A.BADQTY               ,   
         A.GOODQTY              ,   
         A.JUDGEFLAG     		,       
		 A.QCGUBUN		 
    FROM TQBUSINESSTEMP A,
         TMSTAREA       B,   
         TMSTDIVISION   C,
         TMSTSUPPLIER   D,
         TMSTITEM       E
   WHERE A.AREACODE      =       B.AREACODE
     AND A.AREACODE      =       C.AREACODE
     AND A.DIVISIONCODE  =       C.DIVISIONCODE
     AND A.SUPPLIERCODE  =       D.SUPPLIERCODE 
     AND A.ITEMCODE      =       E.ITEMCODE
     AND A.AREACODE      =      @ps_AreaCode
     AND A.DIVISIONCODE  =      @ps_DivisionCode
     AND A.SUPPLIERCODE  LIKE   @ps_SupplierCode
     AND A.ITEMCODE      LIKE   @ps_ItemCode
     AND A.DELIVERYDATE  LIKE   @ps_DeliveryDate
     AND A.JUDGEFLAG     =      '9'

END 

go
