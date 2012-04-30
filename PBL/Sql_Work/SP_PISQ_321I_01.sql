SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


-- =============================================
-- ALTER  procedure basic template
-- =============================================

ALTER     PROCEDURE sp_pisq321i_01 
        @ps_gubun              char(01)       ,   -- 정산, 발생 구분
        @ps_areacode         char(01)       ,   -- 지역구분 %
        @ps_divisioncode     char(01)      ,   -- 공장코드 %
        @ps_productcd        char(02)      ,   -- 제품군 %
        @ps_fromdate           char(07)      ,   -- 시작일
        @ps_todate               char(07)      ,   -- 완료일
        @ps_itemgubun         char(04)      ,   -- 자재구분 %
        @ps_customcd         char(08)          -- 고객사코드 %
AS
BEGIN

if @ps_gubun = '1'   -- 정산
 begin
 SELECT MANAGENO, MANAGESEQ, KDACCUSTOMER, CUSTOMERCODE, DOCUMENTNO,
              EXPORTGUBUN, OAGUBUN, ACCOUNTDATE, RAISEDATE, CLAIMNO, SEQNO, 
              REASONITEMCODE, REASONITEMNAME, RAISEITEMCODE, ITEMNAME, PRODUCTGROUP,
              AREACODE,DIVISIONCODE, REPAYCODE, LEDGERNO, LEDGERDETAILNO, NATIONCODE,
              DEALERCODE, CARITEM, CARCODE, CARPRODUCTDATE, CAROUTDATE, CARREPAIRDATE,
              CARDISTANCE, STATUSCODE, REASONCODE, MARKUPRATE, UNITPRICE, PAYQTY, 
              PAYPARTAMOUNT, PAYWAGEAMOUNT, PAYMARKUP, PAYMANGEAMOUNT, PAYSIDEAMOUNT, 
              PAYAMOUNT, REPAYRATE, REPAYQTY, REPAYPARTAMOUNT, REPAYWAGEAMOUNT,
              REPAYMARTUP, REPAYMANAGEAMOUNT, REPAYSIDEAMOUNT, REPAYAMOUNT,
              ANALYZECONTENT, BADCODE, CUSTOMCODE, OUTSIDECUSTOMCODE, APPLYRATE,
              DIFFERENTQTY, DIFFERENTAMOUNT, CONFIRMQTY, CONFIRMAMOUNT, SHIPAMOUNT,
              ACCOUNTAMOUNT, RECLAIMQTY, RECLAIMAMOUNT,MEMO
 FROM TQMANAGEMASTER
 WHERE areacode like @ps_areacode and divisioncode like @ps_divisioncode and
              productgroup like @ps_productcd and exportgubun like @ps_itemgubun and
              customercode like @ps_customcd and
              accountdate >= @ps_fromdate and accountdate <= @ps_todate
 end
if @ps_gubun = '2'   -- 발생
  begin
 SELECT MANAGENO, MANAGESEQ, KDACCUSTOMER, CUSTOMERCODE, DOCUMENTNO,
              EXPORTGUBUN, OAGUBUN, ACCOUNTDATE, RAISEDATE, CLAIMNO, SEQNO, 
              REASONITEMCODE, REASONITEMNAME, RAISEITEMCODE, ITEMNAME, PRODUCTGROUP,
              AREACODE,DIVISIONCODE, REPAYCODE, LEDGERNO, LEDGERDETAILNO, NATIONCODE,
              DEALERCODE, CARITEM, CARCODE, CARPRODUCTDATE, CAROUTDATE, CARREPAIRDATE,
              CARDISTANCE, STATUSCODE, REASONCODE, MARKUPRATE, UNITPRICE, PAYQTY, 
              PAYPARTAMOUNT, PAYWAGEAMOUNT, PAYMARKUP, PAYMANGEAMOUNT, PAYSIDEAMOUNT, 
              PAYAMOUNT, REPAYRATE, REPAYQTY, REPAYPARTAMOUNT, REPAYWAGEAMOUNT,
              REPAYMARTUP, REPAYMANAGEAMOUNT, REPAYSIDEAMOUNT, REPAYAMOUNT,
              ANALYZECONTENT, BADCODE, CUSTOMCODE, OUTSIDECUSTOMCODE, APPLYRATE,
              DIFFERENTQTY, DIFFERENTAMOUNT, CONFIRMQTY, CONFIRMAMOUNT, SHIPAMOUNT,
              ACCOUNTAMOUNT, RECLAIMQTY, RECLAIMAMOUNT,MEMO
 FROM TQMANAGEMASTER
 WHERE areacode like @ps_areacode and divisioncode like @ps_divisioncode and
              productgroup like @ps_productcd and exportgubun like @ps_itemgubun and
              customercode like @ps_customcd and
              raisedate >= @ps_fromdate and raisedate <= @ps_todate
 end
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

