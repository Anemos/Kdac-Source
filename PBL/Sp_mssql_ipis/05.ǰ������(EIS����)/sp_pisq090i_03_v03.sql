/*
  File Name : sp_pisq090i_03.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_pisq090i_03
  Description : 비간판 검사대기현황리스트
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : IPIS2000
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2007.07.04
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisq090i_03]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisq090i_03]
GO

/*
Exec sp_pisq090i_03
    @ps_AreaCode        = 'D'    ,
    @ps_DivisionCode    = 'A'    ,
    @ps_DeliveryDate    = '%'    ,
    @ps_SupplierCode    = '%'    ,
    @ps_ItemCode        = '%'
*/

CREATE  PROCEDURE sp_pisq090i_03
  @ps_AreaCode          char(01)      ,   -- 지역구분
  @ps_DivisionCode      char(01)      ,   -- 공장코드
  @ps_DeliveryDate      varchar(10)   ,   -- 납품일자
  @ps_SupplierCode      varchar(05)   , -- 업체코드
  @ps_ItemCode          varchar(12)      -- 품번

AS

BEGIN

  SELECT  TMP_01.DELIVERYDATE,
          TMP_01.SUPPLIERCODE,
          D.SUPPLIERKORNAME,
          TMP_01.SLNO,
          TMP_01.ITEMCODE,
          E.ITEMNAME,
          TMP_01.SUPPLIERDELIVERYQTY,
          TMP_01.BADQTY,
          TMP_01.GOODQTY,
          TMP_01.JUDGEFLAG,
          TMP_01.INSPECTORCODE,
          TMP_01.EMPNAME,
          TMP_01.CONFIRMFLAG,
          TMP_01.AREACODE,
          TMP_01.DIVISIONCODE,
          TMP_01.MAKEDATE,
          TMP_01.CHARGENAME,
          TMP_01.STANDARDREVNO,
          TMP_01.QCMETHOD,
          TMP_01.REMARK,
          TMP_01.BADREASON,
          TMP_01.BADMEMO,
          TMP_01.CONFIRMCODE,
          TMP_01.PRINTFLAG,
          TMP_01.QCDATE,
          TMP_01.QCKBFLAG,
          TMP_01.SLNO_1,
          TMP_01.QCGUBUN,
          F.AREANAME             ,
          G.DIVISIONNAME         ,
          D.SUPPLIERKORNAME,
          CHECKREVNO = CASE ISNULL(TMP_01.ITEMREVNO,ISNULL(E.ITEMREVNO,'')) WHEN ISNULL(E.ITEMREVNO,'') THEN 'N' ELSE 'Y' END
    FROM ( SELECT DELIVERYDATE = A.DELIVERYDATE,
        SUPPLIERCODE = A.SUPPLIERCODE,
        SLNO = A.SLNO,
        ITEMCODE = A.ITEMCODE  ,
        SUPPLIERDELIVERYQTY = A.SUPPLIERDELIVERYQTY  ,
        BADQTY = A.BADQTY               ,
        GOODQTY = CASE A.QCGUBUN WHEN 'Q' THEN A.SUPPLIERDELIVERYQTY
                  ELSE A.GOODQTY  END   ,
        JUDGEFLAG = CASE A.QCGUBUN WHEN 'Q' THEN '1'
                  ELSE A.JUDGEFLAG  END ,
        INSPECTORCODE = isnull(B.INSPECTORCODE ,' ') ,
        EMPNAME = CASE A.QCGUBUN WHEN 'Q' THEN 'kdac'
                  ELSE ' ' END,
        CONFIRMFLAG = isnull(B.CONFIRMFLAG, ' ') ,
        AREACODE = A.AREACODE,
        DIVISIONCODE = A.DIVISIONCODE,
        MAKEDATE = isnull(B.MAKEDATE, ' '),
        CHARGENAME = isnull(B.CHARGENAME, ' '),
        STANDARDREVNO = isnull(B.STANDARDREVNO, 'XX'),
        QCMETHOD = isnull(B.QCMETHOD, ' '),
        REMARK = isnull(B.REMARK, ' '),
        BADREASON = isnull(B.BADREASON, ' '),
        BADMEMO = isnull(B.BADMEMO, ' '),
        CONFIRMCODE = isnull(B.CONFIRMCODE, ' '),
        PRINTFLAG = isnull(B.PRINTFLAG, ' '),
        QCDATE = isnull(B.QCDATE, ' '),
        QCKBFLAG = isnull(B.QCKBFLAG, ' '),
        SLNO_1 = isnull(B.SLNO, ' ') ,
        QCGUBUN = A.QCGUBUN,
        ITEMREVNO = CASE WHEN B.DELIVERYNO IS NULL THEN B.ITEMREVNO ELSE ISNULL(B.ITEMREVNO,'') END
      FROM TQBUSINESSTEMP A LEFT OUTER JOIN TQQCRESULT  B
        ON A.AREACODE   = B.AREACODE
          AND A.DIVISIONCODE  = B.DIVISIONCODE
          AND A.SUPPLIERCODE = B.SUPPLIERCODE
          AND A.SLNO       = B.DELIVERYNO
          AND A.ITEMCODE   = B.ITEMCODE
      WHERE A.JUDGEFLAG     =      '9' AND A.DELIVERYDATE >= '20030902' ) TMP_01,
         TMSTSUPPLIER   D,
         TMSTITEM       E,
         TMSTAREA       F,
         TMSTDIVISION   G
    WHERE TMP_01.AREACODE      =       F.AREACODE
      AND TMP_01.AREACODE = G.AREACODE
      AND TMP_01.DIVISIONCODE  =       G.DIVISIONCODE
      AND TMP_01.SUPPLIERCODE  =       D.SUPPLIERCODE
      AND TMP_01.ITEMCODE      =       E.ITEMCODE
      AND TMP_01.AREACODE      =      @ps_AreaCode
      AND TMP_01.DIVISIONCODE  =      @ps_DivisionCode
      AND TMP_01.SUPPLIERCODE  LIKE   @ps_SupplierCode
      AND TMP_01.ITEMCODE      LIKE   @ps_ItemCode
      AND TMP_01.DELIVERYDATE  LIKE   @ps_DeliveryDate

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
         isnull(D.EMPNAME, A.INSPECTORCODE)  ,
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
         A.SLNO         ,
         'N'    AS AS_FLAG ,
         F.AREANAME             ,
         G.DIVISIONNAME         ,
         B.SUPPLIERKORNAME,
         CHECKREVNO = CASE ISNULL(A.ITEMREVNO,'') WHEN ISNULL(C.ITEMREVNO,'') THEN 'N' ELSE 'Y' END
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
  AND A.AREACODE = G.AREACODE
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
  AND A.DELIVERYDATE >= '2003.09.02'
     AND RTRIM(A.DELIVERYDATE) <> ''

END
