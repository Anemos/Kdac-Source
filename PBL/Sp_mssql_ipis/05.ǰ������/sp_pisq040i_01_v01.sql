/************************************************************************************************/
/*	File Name	: sp_pisq040i_01.SQL                                                            */
/*	SYSTEM		: ǰ������(��ǰǰ��)                                                            */
/*	Description	: �˻���ؼ� ��ȸ �� ���                                                       */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCSTANDARD                                                                  */
/*	              TMSTITEM                                                                      */
/*	              TMSTSUPPLIER                                                                  */
/*	              TMSTEMP                                                                       */
/*  Parameter   : @ps_areacode          char(01)    => ��������                                 */
/*                @ps_divisioncode      char(01)    => �����ڵ�                                 */
/*                @ps_consertdate_f     char(10)    => �������� FROM                            */
/*                @ps_consertdate_t     char(10)    => �������� TO                              */
/*                @ps_suppliercode      char(05)	=> ��ü�ڵ�                                 */
/*                @ps_itemcode          varchar(12) => ǰ��                                     */
/*                @ps_chkflag 			char(01)	=> �ݼ�:1, ����:2, ��ü:%                   */
/*	Notes		: ���ε� �˻���ؼ� �ڷḦ ��ȸ�Ѵ�.                                            */
/*	Made Date	: 2002. 09. 04                                                                  */
/*	Author		: �������-������                                                               */
/*	�߰�����  : �������� �ʵ� �߰�                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq040i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq040i_01
GO
/*
Exec sp_pisq040i_01
		@ps_areacode        = '1'            ,
		@ps_divisioncode    = '1'            ,
        @ps_consertdate_f   = '2000.01.01'   ,
        @ps_consertdate_t   = '2999.12.31'   ,
        @ps_suppliercode    = '%'            ,
        @ps_itemcode        = '%'			 ,
		@ps_chkflag 		= '%'
*/


/****** Object:  Stored Procedure dbo.sp_pisq040i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq040i_01
        @ps_areacode          char(01)      ,   -- ��������
        @ps_divisioncode      char(01)      ,   -- �����ڵ�
        @ps_consertdate_f     char(10)      ,   -- �������� FROM
        @ps_consertdate_t     char(10)      ,   -- �������� TO
        @ps_suppliercode      varchar(05)   ,	-- ��ü�ڵ�
        @ps_itemcode          varchar(12)   ,   -- ǰ��
        @ps_chkflag 		  char(01)			-- �ݼ�:1, ����:2, ��ü:%

AS

BEGIN

  SELECT A.AREACODE			AS AS_AREACODE,   
         A.DIVISIONCODE		AS AS_DIVISIONCODE,
         A.SUPPLIERCODE		AS AS_SUPPLIERCODE, 
         C.SUPPLIERKORNAME	AS AS_SUPPLIERKORNAME,  
         A.ITEMCODE			AS AS_ITEMCODE,
         B.ITEMNAME			AS AS_ITEMNAME,
         A.STANDARDREVNO	AS AS_STANDARDREVNO,	
         A.CHARGENAME		AS AS_CHARGENAME,
         A.ENACTMENTDATE	AS AS_ENACTMENTDATE,
         A.ITEMRANK			AS AS_ITEMRANK,
         A.QUALITY			AS AS_QUALITY,
         A.HEATTREATMENT	AS AS_HEATTREATMENT,
         A.SURFACETREATMENT	AS AS_SURFACETREATMENT,
         A.QCCONCEPTIONREFERENCE	AS AS_QCCONCEPTIONREFERENCE, 
         A.BADTREATMENT				AS AS_BADTREATMENT,
         A.CONSERTDEPENDENCEFLAG	AS AS_CONSERTDEPENDENCEFLAG,
         A.CHARGECODE				AS AS_CHARGECODE,	
         D.EMPNAME 					AS AS_CHARGE_EMPNAME,
         A.CHARGECONSERTFLAG		AS AS_CHARGECONSERTFLAG,
         A.SANCTIONCODE				AS AS_SANCTIONCODE,
         E.EMPNAME 					AS AS_SANCTION_EMPNAME,
         A.SANCTIONCONSERTFLAG		AS AS_SANCTIONCONSERTFLAG,
         ' '			  			AS AS_CONSERTDATE,   
         A.CONSERTDATE 				AS AS_RETURNDATE,   
         A.RETURNREASON				AS AS_RETURNREASON,
         A.MODIFYCONTENT			AS AS_MODIFYCONTENT,
         A.APPLYDATE          AS AS_APPLYDATE
    FROM TQQCSTANDARD       A,
         TMSTITEM           B,
         TMSTSUPPLIER       C,
         TMSTEMP            D,
         TMSTEMP            E
   WHERE A.ITEMCODE      *= B.ITEMCODE
     AND A.SUPPLIERCODE  *= C.SUPPLIERCODE
     AND A.CHARGECODE    *= D.EMPNO
     AND A.SANCTIONCODE  *= E.EMPNO
     AND A.AREACODE      = @ps_areacode
     AND A.DIVISIONCODE  = @ps_divisioncode
     AND A.SUPPLIERCODE  LIKE @ps_suppliercode
     AND A.ITEMCODE      LIKE @ps_itemcode
     AND A.CONSERTDATE   >= @ps_consertdate_f
     AND A.CONSERTDATE   <= @ps_consertdate_t
     AND A.CHARGECONSERTFLAG	= 'N'
     AND '1' LIKE @ps_chkflag 

  UNION ALL

  SELECT A.AREACODE			AS AS_AREACODE,   
         A.DIVISIONCODE		AS AS_DIVISIONCODE,
         A.SUPPLIERCODE		AS AS_SUPPLIERCODE, 
         C.SUPPLIERKORNAME	AS AS_SUPPLIERKORNAME,  
         A.ITEMCODE			AS AS_ITEMCODE,
         B.ITEMNAME			AS AS_ITEMNAME,
         A.STANDARDREVNO	AS AS_STANDARDREVNO,	
         A.CHARGENAME		AS AS_CHARGENAME,
         A.ENACTMENTDATE	AS AS_ENACTMENTDATE,
         A.ITEMRANK			AS AS_ITEMRANK,
         A.QUALITY			AS AS_QUALITY,
         A.HEATTREATMENT	AS AS_HEATTREATMENT,
         A.SURFACETREATMENT	AS AS_SURFACETREATMENT,
         A.QCCONCEPTIONREFERENCE	AS AS_QCCONCEPTIONREFERENCE, 
         A.BADTREATMENT				AS AS_BADTREATMENT,
         A.CONSERTDEPENDENCEFLAG	AS AS_CONSERTDEPENDENCEFLAG,
         A.CHARGECODE				AS AS_CHARGECODE,	
         D.EMPNAME 					AS AS_CHARGE_EMPNAME,
         A.CHARGECONSERTFLAG		AS AS_CHARGECONSERTFLAG,
         A.SANCTIONCODE				AS AS_SANCTIONCODE,
         E.EMPNAME 					AS AS_SANCTION_EMPNAME,
         A.SANCTIONCONSERTFLAG		AS AS_SANCTIONCONSERTFLAG,
         ' '			  			AS AS_CONSERTDATE,   
         A.CONSERTDATE 				AS AS_RETURNDATE,   
         A.RETURNREASON				AS AS_RETURNREASON,
         A.MODIFYCONTENT			AS AS_MODIFYCONTENT,
         A.APPLYDATE          AS AS_APPLYDATE
    FROM TQQCSTANDARD       A,
         TMSTITEM           B,
         TMSTSUPPLIER       C,
         TMSTEMP            D,
         TMSTEMP            E
   WHERE A.ITEMCODE      *= B.ITEMCODE
     AND A.SUPPLIERCODE  *= C.SUPPLIERCODE
     AND A.CHARGECODE    *= D.EMPNO
     AND A.SANCTIONCODE  *= E.EMPNO
     AND A.AREACODE      = @ps_areacode
     AND A.DIVISIONCODE  = @ps_divisioncode
     AND A.SUPPLIERCODE  LIKE @ps_suppliercode
     AND A.ITEMCODE      LIKE @ps_itemcode
     AND A.CONSERTDATE   >= @ps_consertdate_f
     AND A.CONSERTDATE   <= @ps_consertdate_t
     AND A.SANCTIONCONSERTFLAG	= 'N'
     AND '1' LIKE @ps_chkflag 

  UNION ALL

  SELECT A.AREACODE			AS AS_AREACODE,   
         A.DIVISIONCODE		AS AS_DIVISIONCODE,
         A.SUPPLIERCODE		AS AS_SUPPLIERCODE, 
         C.SUPPLIERKORNAME	AS AS_SUPPLIERKORNAME,  
         A.ITEMCODE			AS AS_ITEMCODE,
         B.ITEMNAME			AS AS_ITEMNAME,
         A.STANDARDREVNO	AS AS_STANDARDREVNO,	
         A.CHARGENAME		AS AS_CHARGENAME,
         A.ENACTMENTDATE	AS AS_ENACTMENTDATE,
         A.ITEMRANK			AS AS_ITEMRANK,
         A.QUALITY			AS AS_QUALITY,
         A.HEATTREATMENT	AS AS_HEATTREATMENT,
         A.SURFACETREATMENT	AS AS_SURFACETREATMENT,
         A.QCCONCEPTIONREFERENCE	AS AS_QCCONCEPTIONREFERENCE, 
         A.BADTREATMENT				AS AS_BADTREATMENT,
         A.CONSERTDEPENDENCEFLAG	AS AS_CONSERTDEPENDENCEFLAG,
         A.CHARGECODE				AS AS_CHARGECODE,	
         D.EMPNAME 					AS AS_CHARGE_EMPNAME,
         A.CHARGECONSERTFLAG		AS AS_CHARGECONSERTFLAG,
         A.SANCTIONCODE				AS AS_SANCTIONCODE,
         E.EMPNAME 					AS AS_SANCTION_EMPNAME,
         A.SANCTIONCONSERTFLAG		AS AS_SANCTIONCONSERTFLAG,
         A.CONSERTDATE 				AS AS_CONSERTDATE,   
         ' '						AS AS_RETURNDATE,   
         A.RETURNREASON				AS AS_RETURNREASON,
         A.MODIFYCONTENT			AS AS_MODIFYCONTENT,
         A.APPLYDATE          AS AS_APPLYDATE
    FROM TQQCSTANDARD       A,
         TMSTITEM           B,
         TMSTSUPPLIER       C,
         TMSTEMP            D,
         TMSTEMP            E
   WHERE A.ITEMCODE      *= B.ITEMCODE
     AND A.SUPPLIERCODE  *= C.SUPPLIERCODE
     AND A.CHARGECODE    *= D.EMPNO
     AND A.SANCTIONCODE  *= E.EMPNO
     AND A.AREACODE      = @ps_areacode
     AND A.DIVISIONCODE  = @ps_divisioncode
     AND A.SUPPLIERCODE  LIKE @ps_suppliercode
     AND A.ITEMCODE      LIKE @ps_itemcode
     AND A.CONSERTDATE   >= @ps_consertdate_f
     AND A.CONSERTDATE   <= @ps_consertdate_t
     AND A.CHARGECONSERTFLAG	= 'Y'
     AND A.SANCTIONCONSERTFLAG	= 'Y'
     AND '2' LIKE @ps_chkflag 

END 

go
