SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
Exec sp_pisq090i_03
		@ps_AreaCode        = 'D'    ,
		@ps_DivisionCode    = 'A'    ,
        @ps_DeliveryDate    = '%'    ,
        @ps_SupplierCode    = '%'    ,
        @ps_ItemCode        = '%'
*/


/****** Object:  Stored Procedure dbo.sp_pisq090i_03    Script Date: 03-06-12  ******/
ALTER             PROCEDURE sp_pisq090i_03
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_DeliveryDate      varchar(10)   ,   -- 납품일자
        @ps_SupplierCode      varchar(05)   ,	-- 업체코드
        @ps_ItemCode          varchar(12)      -- 품번

AS

BEGIN

  SELECT  A.DELIVERYDATE	,
         	A.SUPPLIERCODE         ,
         	D.SUPPLIERKORNAME      ,
	    		A.SLNO                 ,
         	A.ITEMCODE             ,
         	E.ITEMNAME             ,
         	A.SUPPLIERDELIVERYQTY  ,
         	A.BADQTY               ,
         	A.GOODQTY              ,
         	A.JUDGEFLAG     		,
					isnull(B.INSPECTORCODE,' ') ,
          ' ' AS EMPNAME ,
          isnull(B.CONFIRMFLAG, ' ') ,
					A.AREACODE,
					A.DIVISIONCODE,
          isnull(B.MAKEDATE, ' '),
					isnull(B.CHARGENAME, ' '),
					isnull(B.STANDARDREVNO, 'XX'),
					isnull(B.QCMETHOD, ' '),
					isnull(B.REMARK, ' '),
					isnull(B.BADREASON, ' '),
					isnull(B.BADMEMO, ' '),
					isnull(B.CONFIRMCODE, ' '),
					isnull(B.PRINTFLAG, ' '),
					isnull(B.QCDATE, ' '),
					isnull(B.QCKBFLAG, ' '),
					isnull(B.SLNO, ' ')	,
					A.QCGUBUN AS 	QCFLAG ,
					F.AREANAME             ,
          G.DIVISIONNAME         ,      
          D.SUPPLIERKORNAME    
    FROM TQBUSINESSTEMP A,
				 TQQCRESULT	B,
         TMSTSUPPLIER   D,
         TMSTITEM       E,
         TMSTAREA       F,   
         TMSTDIVISION   G
   	WHERE A.AREACODE		*= B.AREACODE
			AND A.DIVISIONCODE 	*= B.DIVISIONCODE
			AND A.SUPPLIERCODE	*= B.SUPPLIERCODE
			AND A.SLNO				*= B.DELIVERYNO
			AND A.ITEMCODE		*= B.ITEMCODE
			AND A.AREACODE      =       F.AREACODE
      AND A.DIVISIONCODE  =       G.DIVISIONCODE
			AND A.SUPPLIERCODE  =       D.SUPPLIERCODE
     	AND A.ITEMCODE      =       E.ITEMCODE
     	AND A.AREACODE      =      @ps_AreaCode
     	AND A.DIVISIONCODE  =      @ps_DivisionCode
     	AND A.SUPPLIERCODE  LIKE   @ps_SupplierCode
     	AND A.ITEMCODE      LIKE   @ps_ItemCode
     	AND A.DELIVERYDATE  LIKE   @ps_DeliveryDate
     	AND A.JUDGEFLAG     =      '9'
     	AND A.QCGUBUN <> 'Q'

UNION ALL

	SELECT substring(A.DELIVERYDATE,1,4) +
	   		 substring(A.DELIVERYDATE,6,2) +  substring(A.DELIVERYDATE,9,2)    ,
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
         A.QCMETHOD             ,
         A.REMARK               ,
         A.BADREASON            ,
         A.BADMEMO              ,
         A.CONFIRMCODE          ,
         A.PRINTFLAG            ,
         A.QCDATE               ,
         A.QCKBFLAG             ,
         A.SLNO					,
         'N'		AS AS_FLAG ,
         F.AREANAME             ,
         G.DIVISIONNAME         ,      
         B.SUPPLIERKORNAME    
    FROM TQQCRESULT     A,
         TMSTSUPPLIER   B,
         TMSTITEM       C,
         TMSTEMP        D,
         TMSTAREA       F,   
         TMSTDIVISION   G
   WHERE A.SUPPLIERCODE  =     B.SUPPLIERCODE
     AND A.ITEMCODE      =     C.ITEMCODE
     AND A.INSPECTORCODE *=     D.EMPNO
     AND A.AREACODE      =      F.AREACODE
     AND A.DIVISIONCODE  =      G.DIVISIONCODE
     AND A.AREACODE      =      @ps_AreaCode
     AND A.DIVISIONCODE  =      @ps_DivisionCode
     AND A.SUPPLIERCODE  LIKE   @ps_SupplierCode
     AND A.ITEMCODE      LIKE   @ps_ItemCode
     AND A.DELIVERYDATE  LIKE   @ps_DeliveryDate
     AND A.CONFIRMFLAG   =      'N'
     AND A.QCKBFLAG      =      '2'
		 AND A.JUDGEFLAG     <>    '9'
     AND A.DELIVERYDATE  IS NOT NULL
     AND RTRIM(A.DELIVERYDATE) <> ''

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

