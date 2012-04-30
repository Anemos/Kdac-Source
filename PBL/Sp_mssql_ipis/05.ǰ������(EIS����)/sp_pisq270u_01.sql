/************************************************************************************************/
/*	File Name	: sp_pisq270u_01.SQL                                                            */
/*	SYSTEM		: 품질관리(공정품질)                                                            */
/*	Description	: Containment 유검사품 등록                                                     */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQCONTAINQCITEM                                                               */
/*	              TMSTMODEL                                                                     */
/*	              TMSTITEM                                                                      */
/*  Parameter   : @ps_areacode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_ProductGroup      char(02)    => 제품군                                   */
/*                @ps_ModelGroup        char(03)    => 모델군                                   */
/*	Notes		: 유검사품으로 선택할 품번을 화면에 표시한다                                    */
/*	Made Date	: 2002. 09. 26                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq270u_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq270u_01
GO
/*
Exec sp_pisq270u_01
		@ps_areacode        = 'D'   ,
		@ps_divisioncode    = 'A'   ,
        @ps_ProductGroup    = '%'   ,
        @ps_ModelGroup      = '%'
*/


/****** Object:  Stored Procedure dbo.sp_pisq270u_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq270u_01
        @ps_areacode          char(01)      ,   -- 지역구분
        @ps_divisioncode      char(01)      ,   -- 공장코드
        @ps_ProductGroup      varchar(02)   ,   -- 제품군
        @ps_ModelGroup        varchar(03)       -- 모델군

AS

BEGIN
    
	SELECT A.AREACODE       AS_AREACODE     ,   
		   A.DIVISIONCODE   AS_DIVISIONCODE ,   
		   A.PRODUCTGROUP   AS_PRODUCTGROUP ,
		   A.MODELGROUP     AS_MODELGROUP   ,
		   A.ITEMCODE       AS_ITEMCODE     ,
	       B.ITEMNAME       AS_ITEMNAME     ,
	       ' '              DEL_CHK                   
	  FROM TMSTMODEL A,
	       TMSTITEM  B
	 WHERE A.ITEMCODE       =    B.ITEMCODE
	   AND A.AREACODE       =    @ps_AreaCode
	   AND A.DIVISIONCODE   =    @ps_DivisionCode
	   AND A.PRODUCTGROUP   LIKE @ps_ProductGroup
	   AND A.MODELGROUP     LIKE @ps_ModelGroup
	   AND A.AREACODE + A.DIVISIONCODE + A.ITEMCODE NOT IN
	       ( SELECT C.AREACODE + C.DIVISIONCODE + C.ITEMCODE FROM TQCONTAINQCITEM C )
END 

go
