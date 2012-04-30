/*
	File Name	: sp_piss400u_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss400u_02
	Description	: ��������Ȯ��
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss400u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss400u_02]
GO
/*
exec sp_piss400u_02 @ps_areacode     = 'K',          -- ��������
                    @ps_divisioncode = 'S',          -- �����ڵ�
                    @ps_truckno      = 'zzzz',       -- ������ȣ
	            @ps_shipdate     = '2002.12.05'  -- ������
*/
CREATE PROCEDURE sp_piss400u_02
	@ps_areacode     char(01),        -- ��������
        @ps_divisioncode char(01),        -- �����ڵ�
        @ps_truckno	 varchar(15)      -- ������ȣ

AS

BEGIN

Select	 divisioncode   = A.divisioncode,
         ShipSheetNo	= A.ShipSheetNo,
	 SRNO	        = A.SRNo,
	 ShipQty	= sum(A.ShipQty),
	 CustCode	= B.CustCode,
      	 CustName	= C.custname,
	 Cancelflag	= 0,
	 itemCode	= B.itemcode,
	 ItemName	= D.ItemName,
	 SRGubun	= b.shipgubun,
	 Truckorder	= A.Truckorder,
         shipdate       = A.Shipdate,
         requiredate    = B.applyfrom
   From	tshipkbhis A,
	tsrorder B,
	tmstcustomer C,
	tmstitem D,
        tshipsheet E
  Where	A.SRNo 	       = B.SRNo
    and a.srno         = e.srno
    and B.CustCode     *= C.CustCode
    and	B.itemcode     = D.itemcode
    and A.areacode     = @ps_areacode
    and A.divisioncode = @ps_divisioncode
    and E.truckno      = @ps_truckno
    and a.areacode     = e.areacode
    and a.divisioncode = e.divisioncode
    and a.shipsheetno  = e.shipsheetno
    and a.truckorder   = e.truckorder
    and e.confirmflag  = 'Y'
    and e.saleconfirmflag  = 'N'
    and b.shipgubun    <> 'M'
 group by A.divisioncode,
         A.ShipSheetNo,
	 A.SRNo,
	 B.CustCode,
      	 C.custname,
	 B.itemcode,
	 D.ItemName,
	 b.shipgubun,
	 A.Truckorder,
         A.Shipdate,
         B.applyfrom
end 


GO
