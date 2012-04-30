/************************************************************************************************/
/*	File Name	: sp_pisq070u_01.SQL                                                            */
/*	SYSTEM		: 품질관리(부품품질)                                                            */
/*	Description	: 수입검사 무검사품 등록                                                        */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCITEM                                                                      */
/*	              TMSTMODEL                                                                     */
/*	              TMSTORDERRATE                                                                 */
/*	              TMSTITEM                                                                      */
/*	              TMSTSUPPLIER                                                                  */
/*  Parameter   : @ps_areacode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_ProductGroup      char(02)    => 제품군                                   */
/*                @ps_ModelGroup        char(03)    => 모델군                                   */
/*	Notes		: 유검사품으로 선택할 품번을 화면에 표시한다                                    */
/*	Made Date	: 2002. 09. 04                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq070u_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq070u_01
GO
/*
Exec sp_pisq070u_01
		@ps_areacode        = 'D'   ,
		@ps_divisioncode    = 'H'   ,
        @ps_ProductGroup    = '%'   ,
        @ps_ModelGroup      = '%'
*/


/****** Object:  Stored Procedure dbo.sp_pisq070u_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq070u_01
        @ps_areacode          char(01)      ,   -- 지역구분
        @ps_divisioncode      char(01)      ,   -- 공장코드
        @ps_ProductGroup      varchar(02)   ,   -- 제품군
        @ps_ModelGroup        varchar(03)       -- 모델군

AS

BEGIN
    SELECT AS_AREACODE       ,   
           AS_DIVISIONCODE   ,   
           B.ITEMCODE       ,   
           C.ITEMNAME       ,   
           B.SUPPLIERCODE   ,
           D.SUPPLIERKORNAME,   
		   AS_PRODUCTGROUP  ,
           AS_MODELGROUP    ,
           ' '   DEL_CHK                   
      FROM TMSTPARTCOST B, 
           (SELECT A.AREACODE       AS_AREACODE     ,   
                   A.DIVISIONCODE   AS_DIVISIONCODE ,   
                   A.ITEMCODE       AS_ITEMCODE     ,
				   A.PRODUCTGROUP   AS_PRODUCTGROUP ,
               	   A.MODELGROUP     AS_MODELGROUP
              FROM TMSTMODEL  A
             WHERE A.AREACODE       = @ps_AreaCode
               AND A.DIVISIONCODE   = @ps_DivisionCode
               AND A.PRODUCTGROUP   LIKE @ps_ProductGroup
               AND A.MODELGROUP     LIKE @ps_ModelGroup
               AND A.ITEMCLASS	IN ('10', '20', '35', '40', '50') ) AS TEMP,
         TMSTITEM           C,
         TMSTSUPPLIER       D
     WHERE B.ITEMCODE      = AS_ITEMCODE
       AND B.ITEMCODE      *= C.ITEMCODE
       AND B.SUPPLIERCODE  *= D.SUPPLIERCODE
       AND AS_AREACODE + AS_DIVISIONCODE + B.ITEMCODE + B.SUPPLIERCODE  NOT IN
             ( SELECT E.AREACODE + E.DIVISIONCODE + E.ITEMCODE + E.SUPPLIERCODE FROM TQQCITEM E )
END 

go
