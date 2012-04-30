/*
	File Name	: sp_piss160u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss160i_01
	Description	: ��������
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss160u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss160u_01]
GO

/*
exec sp_piss160u_01 @ps_areacode     = 'D',          -- ��������
                    @ps_divisioncode = 'S',          -- �����ڵ�
                    @ps_shipsheetno  = 'DSA2110002',   -- �����ȣ
	            @ps_shipdate     = '2002.11.08'  -- ������
*/
CREATE PROCEDURE sp_piss160u_01
	@ps_areacode     char(01),        -- ��������
        @ps_divisioncode char(01),        -- �����ڵ�
        @ps_shipsheetno	 Char(10),        -- ��ǥ��ȣ
	@ps_shipdate	 Char(10)         -- ������
AS

BEGIN

Select	 ShipSheetNo	= A.ShipSheetNo,
         kbno           = A.KBNO,
	 SRNO	        = B.SRNo,
	 ShipQty	= A.ShipQty,
	 CustCode	= B.CustCode,
      	 CustName	= C.custname,
	 Cancelflag	= 0,
	 itemCode	= B.itemcode,
	 ItemName	= D.ItemName,
	 SRGubun	= b.shipgubun,
	 Truckorder	= A.Truckorder,
         shipdate       = A.Shipdate,
         requiredate    = B.shipdate,
         checksrno      = b.checksrno
   From	tshipkbhis A,
	tsrorder B,
	tmstcustomer C,
	tmstitem D
  Where	A.SRNo 	       = B.SRNo
    and B.CustCode     *= C.CustCode
    and	B.itemcode     = D.itemcode
    and	A.shipsheetno  = @ps_shipsheetno
    and	A.shipdate     = @ps_shipdate
    and A.areacode     = @ps_areacode
    and A.divisioncode = @ps_divisioncode

end 


GO
