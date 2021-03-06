SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr141p_03]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr141p_03]
GO

------------------------------------------------------------------
--  간판가입고이력(기간별) 1/2
------------------------------------------------------------------
CREATE  PROCEDURE sp_pisr141p_03
  @ps_areacode    Char(1),    -- 지역 코드
  @ps_divcode     Char(1),    -- 공장 코드
  @ps_suppcode    VarChar(5),     -- 업체전산화번호
  @ps_itemcode    VarChar(12),    -- 품번
  @ps_product     VarChar(2),     -- 제품군
  @ps_fromdate    Char(10),     -- 조회시작일자
  @ps_todate    Char(10)    -- 조회종료일자
AS
BEGIN
Set NoCount On

/*
Declare @ls_applytime   Char(16)    -- 입고기준시간
Select  @ls_applytime = @ps_applydate + ' 20:00'  -- 일간마감고려
*/

Create  Table #TPARTKBKEY_TMP
( AreaCode  Char(1),
  DivisionCode  Char(1),
  SupplierCode  Char(5),
  ItemCode  VarChar(12)
)


  SELECT F.AreaCode,
         F.DivisionCode,
         F.SupplierCode,
         F.ItemCode,
         Count(F.PartKBNo)  As KBCount,
         Sum(F.RackQty)   As ItemQty
    Into #TPARTKBSTATUS_TMP
    FROM TPARTKBSTATUS    F
   WHERE F.AreaCode     = @ps_areacode    AND
         F.DivisionCode   = @ps_divcode     AND
         F.SupplierCode   like @ps_suppcode AND
         F.ItemCode   like @ps_itemcode AND
         F.PartKBStatus   = 'B'     And
         F.PartReceiptDate  >= @ps_fromdate   And
         F.PartReceiptDate  <= @ps_todate
Group By F.AreaCode,
         F.DivisionCode,
         F.SupplierCode,
         F.ItemCode

  SELECT F.AreaCode,
         F.DivisionCode,
         F.SupplierCode,
         F.ItemCode,
         Count(F.PartKBNo)  As KBCount,
         Sum(F.RackQty)   As ItemQty
    Into #TPARTKBHIS_TMP
    FROM TPARTKBHIS   F
   WHERE F.AreaCode     = @ps_areacode    AND
         F.DivisionCode   = @ps_divcode     AND
         F.SupplierCode   like @ps_suppcode AND
         F.ItemCode   like @ps_itemcode AND
         F.PartKBStatus   = 'C'     And
         F.PartReceiptDate  >= @ps_fromdate   And
         F.PartReceiptDate  <= @ps_todate
Group By F.AreaCode,
         F.DivisionCode,
         F.SupplierCode,
         F.ItemCode

Insert Into #TPARTKBKEY_TMP
  SELECT Distinct
   A.AreaCode,
         A.DivisionCode,
         A.SupplierCode,
         A.ItemCode
    FROM #TPARTKBSTATUS_TMP  A
Union
  SELECT Distinct
   A.AreaCode,
         A.DivisionCode,
         A.SupplierCode,
         A.ItemCode
    FROM #TPARTKBHIS_TMP  A

  SELECT H.AreaCode,
         A.AreaName,
         H.DivisionCode,
         B.DivisionName,
         H.SupplierCode,
         C.SupplierNo,
         C.SupplierKorName,
         H.ItemCode,
         D.ItemName,
   E.PartModelID,
   ( Select Top 1 I.ProductGroup From TMSTMODEL I Where I.AreaCode = H.AreaCode And I.DivisionCode = H.DivisionCode And I.ItemCode = H.ItemCode ) As ProductGroup,
         isNull(F.KBCount, 0) + isNull(G.KBCount,0) As KBCount,
         isNull(F.ItemQty, 0) + isNull(G.ItemQty,0) As ItemQty,
   @ps_fromdate   As ApplyFrom,
   @ps_todate   As ApplyTo,
   E.MailBoxNo
    FROM TMSTAREA   A,
         TMSTDIVISION   B,
         TMSTSUPPLIER   C,
         TMSTITEM   D,
         TMSTPARTKB   E,
         #TPARTKBSTATUS_TMP F,
         #TPARTKBHIS_TMP  G,
   #TPARTKBKEY_TMP    H
   WHERE H.AreaCode     *= F.AreaCode     AND
         H.DivisionCode   *= F.DivisionCode AND
         H.SupplierCode   *= F.SupplierCode AND
         H.ItemCode   *= F.ItemCode   AND

   H.AreaCode     *= G.AreaCode     AND
         H.DivisionCode   *= G.DivisionCode AND
         H.SupplierCode   *= G.SupplierCode AND
         H.ItemCode   *= G.ItemCode   AND

   H.AreaCode     = A.AreaCode    and

         H.AreaCode     = B.AreaCode    and
         H.DivisionCode   = B.DivisionCode  and

         H.SupplierCode   = C.SupplierCode  and

         H.ItemCode     = D.ItemCode    and

         H.AreaCode     = E.AreaCode    and
         H.DivisionCode   = E.DivisionCode  and
         H.SupplierCode   = E.SupplierCode  and
         H.ItemCode     = E.ItemCode    and

   ( Select Top 1 I.ProductGroup From TMSTMODEL I Where I.AreaCode = H.AreaCode And I.DivisionCode = H.DivisionCode And I.ItemCode = H.ItemCode ) like @ps_product

Drop Table #TPARTKBSTATUS_TMP
Drop Table #TPARTKBHIS_TMP
Drop Table #TPARTKBKEY_TMP

Set NoCount Off

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

