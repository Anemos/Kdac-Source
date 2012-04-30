/************************************************************************************************/
/*	File Name	: sp_pisq041u_01.SQL                                                            */
/*	SYSTEM		: 품질관리(부품품질)                                                            */
/*	Description	: 검사기준서 이동                                                       */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCSTANDARD                                                                  */
/*	              TMSTITEM                                                                      */
/*	              TMSTSUPPLIER                                                                  */
/*	              TMSTEMP                                                                       */
/*  Parameter   : @ps_areacode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_suppliercode      char(05)	=> 업체코드                                 */
/*	Notes		: 기존업체의 검사기준서를 조회한다.                                            */
/*	Made Date	: 2004.11.26                                                                 */
/*	Author		: Kiss Kim                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq041u_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq041u_01
GO
/*
Exec sp_pisq041u_01
		@ps_areacode        = 'D'            ,
		@ps_divisioncode    = 'A'            ,
    @ps_suppliercode    = 'D0524'           
*/


/****** Object:  Stored Procedure dbo.sp_pisq041u_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq041u_01
        @ps_areacode          char(01)      ,   -- 지역구분
        @ps_divisioncode      char(01)      ,   -- 공장코드
        @ps_suppliercode      varchar(05)     	-- 업체코드

AS

BEGIN

  SELECT A.AREACODE			AS AS_AREACODE,   
         A.DIVISIONCODE		AS AS_DIVISIONCODE,
         A.SUPPLIERCODE		AS AS_SUPPLIERCODE, 
         C.SUPPLIERKORNAME	AS AS_SUPPLIERKORNAME,  
         A.ITEMCODE			AS AS_ITEMCODE,
         B.ITEMNAME			AS AS_ITEMNAME,
         A.STANDARDREVNO	AS AS_STANDARDREVNO,
         A.STANDARDREVNO  AS AS_CHKREVNO,
         A.SUPPLIERCODE   AS AS_CHKSUPPLIERCODE,
         'S'              AS DEL_CHK
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
     AND A.SUPPLIERCODE  = @ps_suppliercode

END 

go
