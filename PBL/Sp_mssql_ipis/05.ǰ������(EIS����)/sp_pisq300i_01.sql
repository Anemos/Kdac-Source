/************************************************************************************************/
/*	File Name	: sp_pisq300i_01.SQL                                                            */
/*	SYSTEM		: ǰ������(����ǰ��)                                                            */
/*	Description	: Containment �ҷ���Ȳ(ǰ����-�ҷ�����)                                         */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQCONTAINQCENTRY                                                              */
/*	              TQCONTAINQCENTRYDETAIL	                                                    */
/*	              TQCONTAINBADREASON		                                                    */ 
/*		          TQCONTAINBADTYPE			                                                    */
/*  Parameter   : @ps_areacode          char(01)    => ��������                                 */
/*                @ps_divisioncode      char(01)    => �����ڵ�                                 */
/*                @ps_ProductGroup      char(02)    => ��ǰ��                                   */
/*                @ps_ModelGroup        char(03)    => �𵨱�                                   */
/*                @ps_datefm            char(10)    => ����FROM                                 */
/*                @ps_dateto            char(10)    => ����TO                                   */
/*                @ps_itemcode          varchar(12) => ǰ��                                     */
/*	Notes		: Containment ǰ����-�ҷ������� ȭ�鿡 ǥ���Ѵ�                                 */
/*	Made Date	: 2002. 09. 30                                                                  */
/*	Author		: �������-������                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq300i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq300i_01
GO
/*
Exec sp_pisq300i_01
		@ps_areacode        = 'D'   ,
		@ps_divisioncode    = 'A'   ,
        @ps_ProductGroup    = '%'   ,
        @ps_ModelGroup      = '%'   ,
        @ps_datefm          = '2000.01.01' ,
        @ps_dateto          = '2002.12.31' ,
        @ps_itemcode        = '511514'
*/


/****** Object:  Stored Procedure dbo.sp_pisq300i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq300i_01
        @ps_areacode          char(01)      ,   -- ��������
        @ps_divisioncode      char(01)      ,   -- �����ڵ�
        @ps_ProductGroup      varchar(02)   ,   -- ��ǰ��
        @ps_ModelGroup        varchar(03)   ,   -- �𵨱�
        @ps_datefm            char(10)      ,   -- ����FROM
        @ps_dateto            char(10)      ,   -- ����TO
        @ps_itemcode          varchar(12)       -- ǰ��

AS

BEGIN
	SELECT C.CONTAINBADREASONCODE	AS AS_REASONCODE,   
		   C.CONTAINBADREASONNAME	AS AS_REASONNAME,   
		   D.CONTAINBADTYPECODE		AS AS_TYPECODE	,   
		   D.CONTAINBADTYPENAME		AS AS_TYPENAME	,
		   SUM(B.BADQTY)			AS AS_BADQTY   
	  FROM TQCONTAINQCENTRY			A,	
		   TQCONTAINQCENTRYDETAIL	B,
		   TQCONTAINBADREASON		C,   
		   TQCONTAINBADTYPE			D  
	 WHERE A.AREACODE			=	 B.AREACODE
	   AND A.DIVISIONCODE		=	 B.DIVISIONCODE
	   AND A.PRDENDDATE			=	 B.PRDENDDATE
	   AND A.KBNO				=	 B.KBNO
	   AND B.AREACODE			=	 C.AREACODE
	   AND B.DIVISIONCODE		=	 C.DIVISIONCODE
	   AND B.BADREASONCODE		=	 C.CONTAINBADREASONCODE   
	   AND B.AREACODE			=	 D.AREACODE
	   AND B.DIVISIONCODE		=	 D.DIVISIONCODE
	   AND B.BADREASONCODE		=	 D.CONTAINBADREASONCODE   
	   AND B.BADTYPECODE		=	 D.CONTAINBADTYPECODE   
	   AND A.AREACODE			=	 @ps_areacode
	   AND A.DIVISIONCODE		=	 @ps_divisioncode
	   AND A.PRODUCTGROUP		LIKE @ps_ProductGroup
	   AND A.MODELGROUP			LIKE @ps_ModelGroup
	   AND A.QCDATE				>=   @ps_datefm
	   AND A.QCDATE				<=   @ps_dateto
	   AND A.ITEMCODE			=	 @ps_itemcode
	   AND A.QCFLAG				=	 '0'
	 GROUP BY C.CONTAINBADREASONCODE,   
			  C.CONTAINBADREASONNAME,   
			  D.CONTAINBADTYPECODE	,   
			  D.CONTAINBADTYPENAME
	 ORDER BY SUM(B.BADQTY) DESC
	 
END 

go
