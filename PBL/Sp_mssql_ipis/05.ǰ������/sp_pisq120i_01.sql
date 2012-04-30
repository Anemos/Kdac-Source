/************************************************************************************************/
/*	File Name	: sp_pisq120i_01.SQL                                                            */
/*	SYSTEM		: ǰ������(��ǰǰ��)                                                            */
/*	Description	: ������Ȳ �� ��ǰǥ���                                                        */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCRESULT                                                                    */
/*	              TMSTSUPPLIER                                                                  */
/*	              TMSTITEM                                                                      */
/*  Parameter   : @ps_AreaCode          char(01)    => ��������                                 */
/*                @ps_DivisionCode      char(01)    => �����ڵ�                                 */
/*                @ps_DeliveryDate      char(10)    => ��ǰ����                                 */
/*                @ps_SupplierCode      char(05)	=> ��ü�ڵ�                                 */
/*                @ps_ItemCode          varchar(12) => ǰ��                                     */
/*                @ps_PrintFlag         char(01)    => ��¿���                                 */
/*	Notes		: �˻���ؼ� �����Ƿ� �ڷḦ ��ȸ�Ѵ�.                                          */
/*	Made Date	: 2002. 09. 09                                                                  */
/*	Author		: �������-������                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq120i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq120i_01
GO
/*
Exec sp_pisq120i_01
		@ps_AreaCode        = '1'    ,
		@ps_DivisionCode    = '1'    ,
        @ps_DeliveryDate    = '%'    ,
        @ps_SupplierCode    = '%'    ,
        @ps_ItemCode        = '%'    ,
        @ps_PrintFlag       = '%'
*/


/****** Object:  Stored Procedure dbo.sp_pisq120i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq120i_01
        @ps_AreaCode          char(01)      ,   -- ��������
        @ps_DivisionCode      char(01)      ,   -- �����ڵ�
        @ps_DeliveryDate      varchar(10)   ,   -- ��ǰ����
        @ps_SupplierCode      varchar(05)   ,	-- ��ü�ڵ�
        @ps_ItemCode          varchar(12)   ,   -- ǰ��
        @ps_PrintFlag         char(01)          -- ��¿���
AS

BEGIN

  SELECT A.DELIVERYDATE         ,   
         A.DELIVERYTIME         ,
         A.SUPPLIERCODE         ,   
         B.SUPPLIERKORNAME      ,   
         A.DELIVERYNO           ,   
         A.ITEMCODE             ,   
         C.ITEMNAME             ,   
         A.KBCOUNT              ,
         A.SUPPLIERDELIVERYQTY  ,   
         A.BADQTY               ,   
         A.GOODQTY              ,   
         A.PRINTFLAG            ,   
         A.JUDGEFLAG            ,   
         A.INSPECTORCODE        ,   
         A.CONFIRMFLAG          ,   
         A.AREACODE             ,   
         A.DIVISIONCODE         ,   
         A.MAKEDATE             ,   
         A.CHARGENAME           ,   
         A.STANDARDREVNO        ,   
         A.SUPPLIERLOTQTY       ,   
         A.QCMETHOD             ,   
         A.REMARK               ,   
         A.BADREASON            ,   
         A.BADMEMO              ,   
         A.CONFIRMCODE          ,   
         A.QCDATE               ,   
         A.QCKBFLAG             ,   
         A.SLNO                 ,
         'N'    as_reprint
    FROM TQQCRESULT    A,
         TMSTSUPPLIER  B,
         TMSTITEM      C
   WHERE A.SUPPLIERCODE  *=     B.SUPPLIERCODE 
     AND A.ITEMCODE      *=     C.ITEMCODE
     AND A.AREACODE      =      @ps_AreaCode
     AND A.DIVISIONCODE  =      @ps_DivisionCode
     AND A.SUPPLIERCODE  LIKE   @ps_SupplierCode
     AND A.ITEMCODE      LIKE   @ps_ItemCode
     AND A.DELIVERYDATE  LIKE   @ps_DeliveryDate
     AND A.PRINTFLAG     LIKE   @ps_PrintFlag
     AND A.JUDGEFLAG     =      '3' 
     AND A.QCKBFLAG      =      '1' 

END 

go
