/************************************************************************************************/
/*	File Name	: sp_pisq120i_02.SQL                                                            */
/*	SYSTEM		: ǰ������(��ǰǰ��)                                                            */
/*	Description	: ������Ȳ �� ��ǰǥ���(��ǰǥ���)                                            */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCRESULT                                                                    */
/*	              TMSTSUPPLIER                                                                  */
/*	              TMSTITEM                                                                      */
/*	              TPARTKBSTATUS                                                                 */
/*	              TMSTAREA                                                                      */
/*	              TMSTDIVISION                                                                  */
/*  Parameter   : @ps_AreaCode          char(01)    => ��������                                 */
/*                @ps_DivisionCode      char(01)    => �����ڵ�                                 */
/*                @ps_SupplierCode      char(05)	=> ��ü�ڵ�                                 */
/*                @ps_DeliveryNO        varchar(12) => ��ǰ��ȣ                                 */
/*                @ps_ItemCode          varchar(12) => ǰ��                                     */
/*	Notes		: ������Ȳ �� ��ǰǥ�� ����Ѵ�.                                                */
/*	Made Date	: 2002. 09. 09                                                                  */
/*	Author		: �������-������                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq120i_02') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq120i_02
GO
/*
Exec sp_pisq120i_02
		@ps_AreaCode        = 'D'               ,
		@ps_DivisionCode    = 'H'               ,
        @ps_SupplierCode    = 'D0002'           ,
        @ps_DeliveryNo      = '200000000002'    ,
        @ps_ItemCode        = '002C24103'       
*/


/****** Object:  Stored Procedure dbo.sp_pisq120i_02    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq120i_02
        @ps_AreaCode          char(01)      ,   -- ��������
        @ps_DivisionCode      char(01)      ,   -- �����ڵ�
        @ps_SupplierCode      char(05)	    ,   -- ��ü�ڵ�
        @ps_DeliveryNO        varchar(12)   ,   -- ��ǰ��ȣ
        @ps_ItemCode          varchar(12)       -- ǰ��
AS

BEGIN

  SELECT A.AREACODE             ,   
         E.AREANAME             ,   
         A.DIVISIONCODE         ,   
         F.DIVISIONNAME         ,   
         A.SUPPLIERCODE         ,   
         B.SUPPLIERKORNAME      ,   
         A.DELIVERYNO           ,   
         A.ITEMCODE             ,   
         C.ITEMNAME             ,   
         A.SUPPLIERDELIVERYQTY  ,   
         A.BADQTY               ,   
         A.GOODQTY              ,   
         A.KBCOUNT              ,
         D.PARTKBNO				,
         D.RACKQTY
    FROM TQQCRESULT    A,
         TMSTSUPPLIER  B,
         TMSTITEM      C,
         TPARTKBSTATUS D,
         TMSTAREA      E,
         TMSTDIVISION  F
   WHERE A.SUPPLIERCODE  *= B.SUPPLIERCODE 
     AND A.ITEMCODE      *= C.ITEMCODE
     AND A.AREACODE      =  D.AREACODE
     AND A.DIVISIONCODE  =  D.DIVISIONCODE
     AND A.SUPPLIERCODE  =  D.SUPPLIERCODE
     AND A.DELIVERYNO    =  D.DELIVERYNO
     AND A.ITEMCODE      =  D.ITEMCODE
     AND A.AREACODE      =  E.AREACODE
     AND A.AREACODE      =  F.AREACODE
     AND A.DIVISIONCODE  =  F.DIVISIONCODE
     AND A.AREACODE      =  @ps_AreaCode
     AND A.DIVISIONCODE  =  @ps_DivisionCode
     AND A.SUPPLIERCODE  =  @ps_SupplierCode
     AND A.DELIVERYNO    = 	@ps_DeliveryNo
     AND A.ITEMCODE      =  @ps_ItemCode

END 

go
