/************************************************************************************************/
/*	File Name	: sp_pisq020i_01.SQL                                                            */
/*	SYSTEM		: ǰ������(��ǰǰ��)                                                            */
/*	Description	: �˻���ؼ� ������Ȳ                                                           */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCSTANDARD                                                                  */
/*	              TMSTITEM                                                                      */
/*	              TMSTSUPPLIER                                                                   */
/*	              TMSTEMP                                                                       */
/*  Parameter   : @ps_areacode          char(01)    => ��������                                 */
/*                @ps_divisioncode      char(01)    => �����ڵ�                                 */
/*                @ps_enactmentdate     char(10)    => ��������                                 */
/*                @ps_suppliercode      char(05)	=> ��ü�ڵ�                                 */
/*                @ps_itemcode          varchar(12) => ǰ��                                     */
/*	Notes		: �˻���ؼ� �����Ƿ� �ڷḦ ��ȸ�Ѵ�.                                          */
/*	Made Date	: 2002. 09. 02                                                                  */
/*	Author		: �������-������                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq020i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq020i_01
GO
/*
Exec sp_pisq020i_01
		@ps_areacode        = '1'       ,
		@ps_divisioncode    = '1'       ,
        @ps_enactmentdate   = '%'    ,
        @ps_suppliercode    = '%'    ,
        @ps_itemcode        = '%'
*/


/****** Object:  Stored Procedure dbo.sp_pisq020i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq020i_01
        @ps_areacode          char(01)      ,   -- ��������
        @ps_divisioncode      char(01)      ,   -- �����ڵ�
        @ps_enactmentdate     varchar(10)   ,   -- ��������
        @ps_suppliercode      varchar(05)   ,	-- ��ü�ڵ�
        @ps_itemcode          varchar(12)       -- ǰ��

AS

BEGIN

  SELECT TQQCSTANDARD.AREACODE,   
         TQQCSTANDARD.DIVISIONCODE,   
         TQQCSTANDARD.SUPPLIERCODE,   
         TMSTSUPPLIER.SUPPLIERKORNAME,   
         TQQCSTANDARD.ITEMCODE,   
         TMSTITEM.ITEMNAME,   
         TQQCSTANDARD.STANDARDREVNO,   
         TQQCSTANDARD.CHARGENAME,   
         TQQCSTANDARD.ENACTMENTDATE,   
         TQQCSTANDARD.ITEMRANK,   
         TQQCSTANDARD.QUALITY,   
         TQQCSTANDARD.HEATTREATMENT,   
         TQQCSTANDARD.SURFACETREATMENT,   
         TQQCSTANDARD.QCCONCEPTIONREFERENCE,   
         TQQCSTANDARD.BADTREATMENT,   
         TQQCSTANDARD.CONSERTDEPENDENCEFLAG,   
         TQQCSTANDARD.CHARGECODE,   
         TMSTEMPA.EMPNAME CHARGE_EMPNAME,
         TQQCSTANDARD.CHARGECONSERTFLAG,   
         TQQCSTANDARD.SANCTIONCODE,   
         TMSTEMPB.EMPNAME SANCTION_EMPNAME,
         TQQCSTANDARD.SANCTIONCONSERTFLAG,   
         TQQCSTANDARD.CONSERTDATE,   
         TQQCSTANDARD.RETURNREASON,   
         TQQCSTANDARD.MODIFYCONTENT
    FROM TQQCSTANDARD       ,
         TMSTITEM           ,
         TMSTSUPPLIER       ,
         TMSTEMP TMSTEMPA   ,
         TMSTEMP TMSTEMPB
   WHERE TQQCSTANDARD.ITEMCODE      *= TMSTITEM.ITEMCODE
     AND TQQCSTANDARD.SUPPLIERCODE  *= TMSTSUPPLIER.SUPPLIERCODE
     AND TQQCSTANDARD.CHARGECODE    *= TMSTEMPA.EMPNO
     AND TQQCSTANDARD.SANCTIONCODE  *= TMSTEMPB.EMPNO
     AND TQQCSTANDARD.AREACODE      = @ps_areacode
     AND TQQCSTANDARD.DIVISIONCODE  = @ps_divisioncode
     AND TQQCSTANDARD.SUPPLIERCODE  LIKE @ps_suppliercode
     AND TQQCSTANDARD.ITEMCODE      LIKE @ps_itemcode
     AND TQQCSTANDARD.ENACTMENTDATE LIKE @ps_enactmentdate
     AND TQQCSTANDARD.CONSERTDEPENDENCEFLAG = 'Y'
     AND TQQCSTANDARD.CHARGECONSERTFLAG <> 'N'
     AND TQQCSTANDARD.SANCTIONCONSERTFLAG  = 'X'
END 

go
