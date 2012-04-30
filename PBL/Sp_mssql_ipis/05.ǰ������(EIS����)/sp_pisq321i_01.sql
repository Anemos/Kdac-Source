/*
	File Name	: sp_pisq321i_01.SQL
	SYSTEM		: ǰ������(��ǰ��)
	Description	: Warranty ���� ���ε� �ڷ���ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase: EIS
	Use Table	: TQMANAGEMASTER
  Parameter   : @ps_gubun              varchar(1)       ,   -- ����, �߻� ����
        @ps_areacode         varchar(1)       ,   -- �������� %
        @ps_divisioncode     varchar(1)      ,   -- �����ڵ� %
        @ps_productcd        varchar(2)      ,   -- ��ǰ�� %
        @ps_fromdate           varchar(7)      ,   -- ������
        @ps_todate               varchar(7)      ,   -- �Ϸ���
        @ps_itemgubun         varchar(4)      ,   -- ���籸�� %
        @ps_customcd         varchar(8)          -- �����ڵ� %
	Notes		: Warranty ���� ���ε� �ڷ���ȸ
	Made Date	: 2002. 10. 01
	Modify Date : 
	Author		: �������-������
*/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq321i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq321i_01
GO
/*
Exec sp_pisq321i_01
		@ps_gubun              varchar(1)       ,   -- ����, �߻� ����
    @ps_areacode         varchar(1)       ,   -- �������� %
    @ps_divisioncode     varchar(1)      ,   -- �����ڵ� %
    @ps_productcd        varchar(2)      ,   -- ��ǰ�� %
    @ps_fromdate           varchar(7)      ,   -- ������
    @ps_todate               varchar(7)      ,   -- �Ϸ���
    @ps_itemgubun         varchar(4)      ,   -- ���籸�� %
    @ps_customcd         varchar(8)          -- �����ڵ� %

*/


/****** Object:  Stored Procedure dbo.sp_pisq321i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq321i_01
        @ps_gubun              varchar(1)       ,   -- ����, �߻� ����
        @ps_areacode         varchar(1)       ,   -- �������� %
        @ps_divisioncode     varchar(1)      ,   -- �����ڵ� %
        @ps_productcd        varchar(2)      ,   -- ��ǰ�� %
        @ps_fromdate           varchar(7)      ,   -- ������
        @ps_todate               varchar(7)      ,   -- �Ϸ���
        @ps_itemgubun         varchar(4)      ,   -- ���籸�� %
        @ps_customcd         varchar(8)          -- �����ڵ� %
AS
BEGIN

if @ps_gubun = 'A'  
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
              kdaccustomer like @ps_customcd and
              accountdate >= @ps_fromdate and accountdate <= @ps_todate
if @ps_gubun = 'R' 
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
              kdaccustomer like @ps_customcd and
              raisedate >= @ps_fromdate and raisedate <= @ps_todate

return
END

go
