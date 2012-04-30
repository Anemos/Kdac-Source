/************************************************************************************************/
/*	File Name	: sp_pisq090i_02.SQL                                                            */
/*	SYSTEM		: 품질관리(부품품질)                                                            */
/*	Description	: 검사 대기현황(비간판용)                                                       */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCRESULT                                                                    */
/*	              TMSTSUPPLIER                                                                  */
/*	              TMSTITEM                                                                      */
/*	              TMSTEMP                                                                       */
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_DivisionCode      char(01)    => 공장코드                                 */
/*                @ps_DeliveryDate      char(10)    => 납품일자                                 */
/*                @ps_SupplierCode      char(05)	=> 업체코드                                 */
/*                @ps_ItemCode          varchar(12) => 품번                                     */
/*	Notes		: 검사대기현황의 오른쪽 검사성적서정보를 조회한다.                              */
/*	Made Date	: 2002. 09. 12                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq090i_02') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq090i_02
GO
/*
Exec sp_pisq090i_02
		@ps_AreaCode        = 'D'    ,
		@ps_DivisionCode    = 'H'    ,
        @ps_DeliveryDate    = '%'    ,
        @ps_SupplierCode    = '%'    ,
        @ps_ItemCode        = '%'
*/


/****** Object:  Stored Procedure dbo.sp_pisq090i_02    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq090i_02
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_DeliveryDate      varchar(10)   ,   -- 납품일자
        @ps_SupplierCode      varchar(05)   ,	-- 업체코드
        @ps_ItemCode          varchar(12)       -- 품번

AS

BEGIN

  SELECT A.DELIVERYDATE         ,   
         A.DELIVERYTIME         ,
         A.SUPPLIERCODE         ,   
         B.SUPPLIERKORNAME      ,   
         A.DELIVERYNO           ,   
         A.ITEMCODE             ,   
         C.ITEMNAME             ,   
         A.SUPPLIERDELIVERYQTY  ,   
         A.BADQTY               ,   
         A.GOODQTY              ,   
         A.JUDGEFLAG            ,   
         A.INSPECTORCODE        ,   
         D.EMPNAME              ,
         A.CONFIRMFLAG          ,   
         A.AREACODE             ,   
         A.DIVISIONCODE         ,   
         A.MAKEDATE             ,   
         A.CHARGENAME           ,   
         A.STANDARDREVNO        ,   
         A.KBCOUNT              ,   
         A.QCMETHOD             ,   
         A.REMARK               ,   
         A.BADREASON            ,   
         A.BADMEMO              ,   
         A.CONFIRMCODE          ,   
         A.PRINTFLAG            ,   
         A.QCDATE               ,   
         A.QCKBFLAG             ,   
         A.SLNO					,
		 F.QCGUBUN		 
    FROM TQQCRESULT    A,
         TMSTSUPPLIER  B,
         TMSTITEM      C,
         TMSTEMP       D,
		 TQQCITEM      F
   WHERE A.SUPPLIERCODE  =      B.SUPPLIERCODE 
     AND A.ITEMCODE      =      C.ITEMCODE
     AND A.INSPECTORCODE *=     D.EMPNO
     AND A.AREACODE      *=     F.AREACODE
     AND A.DIVISIONCODE  *=     F.DIVISIONCODE
     AND A.SUPPLIERCODE  *=     F.SUPPLIERCODE 
     AND A.ITEMCODE      *=     F.ITEMCODE
     AND A.AREACODE      =      @ps_AreaCode
     AND A.DIVISIONCODE  =      @ps_DivisionCode
     AND A.SUPPLIERCODE  LIKE   @ps_SupplierCode
     AND A.ITEMCODE      LIKE   @ps_ItemCode
     AND A.MAKEDATE		 LIKE   @ps_DeliveryDate
     AND A.QCKBFLAG      =      '2'
     AND A.JUDGEFLAG     =      '9'

--     AND A.AREACODE + A.DIVISIONCODE + A.SUPPLIERCODE + A.DELIVERYNO + A.ITEMCODE IN
--		 ( SELECT DISTINCT E.AREACODE + E.DIVISIONCODE + E.SUPPLIERCODE + E.DELIVERYNO + E.ITEMCODE 
--			 FROM TQQCRESULTDETAIL E
--		    WHERE E.AREACODE      =      @ps_AreaCode
--			  AND E.DIVISIONCODE  =      @ps_DivisionCode
--			  AND E.SUPPLIERCODE  LIKE   @ps_SupplierCode
--			  AND E.ITEMCODE      LIKE   @ps_ItemCode )

END 

go
