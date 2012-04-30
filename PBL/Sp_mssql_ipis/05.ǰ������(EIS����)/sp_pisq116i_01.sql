/************************************************************************************************/
/*	File Name	: sp_pisq116i_01.SQL                                                            */
/*	SYSTEM		: ǰ������(��ǰǰ��)                                                            */
/*	Description	: �˻缺���� ���γ��� ��Ȳ                                                      */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCRESULTDETAIL                                                              */
/*  Parameter   : @ps_AreaCode          char(01)    => ��������                                 */
/*                @ps_DivisionCode      char(01)    => �����ڵ�                                 */
/*                @ps_SupplierCode      char(05)	=> ��ü�ڵ�                                 */
/*                @ps_DeliveryNo	    varchar(12) => ��ǰ��ȣ                                 */
/*                @ps_ItemCode          varchar(12) => ǰ��                                     */
/*	Notes		: �˻� ������ ���γ��� �ڷḦ ��ȸ�Ѵ�.  		                                */
/*	Made Date	: 2002. 09. 17                                                                  */
/*	Author		: �������-������                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq116i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq116i_01
GO
/*
Exec sp_pisq116i_01
		@ps_AreaCode        = '1'    ,
		@ps_DivisionCode    = '1'    ,
        @ps_SupplierCode    = '%'    ,
        @ps_DeliveryNo      = '%'    ,
        @ps_ItemCode        = '%'    
*/


/****** Object:  Stored Procedure dbo.sp_pisq116i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq116i_01
        @ps_AreaCode          char(01)      ,   -- ��������
        @ps_DivisionCode      char(01)      ,   -- �����ڵ�
        @ps_SupplierCode      char(05)   	,	-- ��ü�ڵ�
		@ps_DeliveryNo	      varchar(12)	,	-- ��ǰ��ȣ
        @ps_ItemCode          varchar(12)       -- ǰ��

AS

BEGIN

  SELECT A.AREACODE,   
         A.DIVISIONCODE,   
         A.SUPPLIERCODE,   
         A.DELIVERYNO,   
         A.ITEMCODE,   
         A.SUPPLIERLOTNO,   
         A.ORDERNO,   
         A.LOTQTY  ,
         B.QCITEM,   
         B.DECISIONRANK,   
         B.ITEMSPECQUALITY,   
         A.SUPPLIERMEASUREMENTX1,   
         A.SUPPLIERMEASUREMENTX2,   
         A.SUPPLIERMEASUREMENTX3,   
         A.SUPPLIERMEASUREMENTX4,   
         A.SUPPLIERMEASUREMENTX5,   
         A.SUPPLIERMEASUREMENTX6,   
         A.SUPPLIERMEASUREMENTX7,   
         A.SUPPLIERMEASUREMENTX8,   
         A.SUPPLIERMEASUREMENTX9,   
         A.SUPPLIERMEASUREMENTX10,   
         A.SUPPLIERMEASUREMENTX,   
         A.SUPPLIERMEASUREMENTR,   
         A.SUPPLIERMEASUREMENTS,   
         A.SUPPLIERFLAGRESULT,   
         A.QCMEASUREMENTX1,   
         A.QCMEASUREMENTX2,   
         A.QCMEASUREMENTX3,   
         A.QCMEASUREMENTX4,   
         A.QCMEASUREMENTX5,   
         A.QCMEASUREMENTX6,   
         A.QCMEASUREMENTX7,   
         A.QCMEASUREMENTX8,   
         A.QCMEASUREMENTX9,   
         A.QCMEASUREMENTX10,   
         A.QCMEASUREMENTX,   
         A.QCMEASUREMENTR,   
         A.QCMEASUREMENTS,   
         A.QCFLAGRESULT
    FROM TQQCRESULTDETAIL	A,
		 TQQCSTANDARDDETAIL	B
   WHERE A.AREACODE		= B.AREACODE
     AND A.DIVISIONCODE	= B.DIVISIONCODE
     AND A.SUPPLIERCODE	= B.SUPPLIERCODE
     AND A.ITEMCODE		= B.ITEMCODE
     AND A.ORDERNO		= B.ORDERNO
     AND A.AREACODE		= @PS_AREACODE    
     AND A.DIVISIONCODE = @PS_DIVISIONCODE
     AND A.SUPPLIERCODE = @PS_SUPPLIERCODE
     AND A.DELIVERYNO	= @PS_DELIVERYNO	
     AND A.ITEMCODE		= @PS_ITEMCODE    

END 

go
