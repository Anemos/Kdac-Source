/************************************************************************************************/
/*	File Name	: sp_pisq080i_01.SQL                                                            */
/*	SYSTEM		: 품질관리(부품품질)                                                            */
/*	Description	: 검사 대기현황(간판용)                                                         */
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
/*	Notes		: 검사기준서 승인의뢰 자료를 조회한다.                                          */
/*	Made Date	: 2002. 09. 05                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq080i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq080i_01
GO
/*
Exec sp_pisq080i_01
		@ps_AreaCode        = '1'       ,
		@ps_DivisionCode    = '1'       ,
        @ps_DeliveryDate    = '%'    ,
        @ps_SupplierCode    = '%'    ,
        @ps_ItemCode        = '%'
*/


/****** Object:  Stored Procedure dbo.sp_pisq080i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq080i_01
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
         'N'		AS AS_FLAG
    FROM TQQCRESULT    A,
         TMSTSUPPLIER  B,
         TMSTITEM      C,
         TMSTEMP       D
   WHERE A.SUPPLIERCODE  *=     B.SUPPLIERCODE 
     AND A.ITEMCODE      *=     C.ITEMCODE
     AND A.INSPECTORCODE *=     D.EMPNO
     AND A.AREACODE      =      @ps_AreaCode
     AND A.DIVISIONCODE  =      @ps_DivisionCode
     AND A.SUPPLIERCODE  LIKE   @ps_SupplierCode
     AND A.ITEMCODE      LIKE   @ps_ItemCode
     AND A.DELIVERYDATE  LIKE   @ps_DeliveryDate
     AND A.CONFIRMFLAG   =      'N'
     AND A.QCKBFLAG      =      '1'
     AND A.DELIVERYDATE  IS NOT NULL 
     AND RTRIM(A.DELIVERYDATE) <> ''

END 

go
