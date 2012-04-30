/************************************************************************************************/
/*	File Name	: sp_pisq090i_02.SQL                                                            */
/*	SYSTEM		: ǰ������(��ǰǰ��)                                                            */
/*	Description	: �˻� �����Ȳ(���ǿ�)                                                       */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCRESULT                                                                    */
/*	              TMSTSUPPLIER                                                                  */
/*	              TMSTITEM                                                                      */
/*	              TMSTEMP                                                                       */
/*  Parameter   : @ps_AreaCode          char(01)    => ��������                                 */
/*                @ps_DivisionCode      char(01)    => �����ڵ�                                 */
/*                @ps_DeliveryDate      char(10)    => ��ǰ����                                 */
/*                @ps_SupplierCode      char(05)	=> ��ü�ڵ�                                 */
/*                @ps_ItemCode          varchar(12) => ǰ��                                     */
/*	Notes		: �˻�����Ȳ�� ������ �˻缺���������� ��ȸ�Ѵ�.                              */
/*	Made Date	: 2002. 09. 12                                                                  */
/*	Author		: �������-������                                                               */
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
        @ps_AreaCode          char(01)      ,   -- ��������
        @ps_DivisionCode      char(01)      ,   -- �����ڵ�
        @ps_DeliveryDate      varchar(10)   ,   -- ��ǰ����
        @ps_SupplierCode      varchar(05)   ,	-- ��ü�ڵ�
        @ps_ItemCode          varchar(12)       -- ǰ��

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
