/*
	File Name	: sp_piss270u_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss270u_02
	Description	: �����ǥ���
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss270u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss270u_02]
GO

/*
exec sp_piss270u_02 @ps_areacode     = 'D',          -- ��������
                    @ps_divisioncode = 'A',          -- �����ڵ�
                    @ps_truckno      = '1234',       -- ������ȣ
	            @ps_shipdate     = '2002.10.15'  -- ������
*/
CREATE PROCEDURE sp_piss270u_02
	@ps_areacode     char(01),        -- ��������
        @ps_divisioncode char(01),        -- �����ڵ�
        @ps_truckno	 VARchar(12),        -- ������ȣ
	@ps_shipdate	 Char(10)         -- ������
AS

BEGIN

Select	distinct divisioncode   = A.divisioncode,
        ShipSheetNo    = A.ShipSheetNo,
	CustCode       = A.CustCode,
      	CustName       = B.custname,
        truckorder     = a.truckorder,
        cancelflag     = 0
   From	tshipsheet A,
        tmstcustomer B
  Where	A.CustCode     *= B.CustCode
    and	A.shipdate     = @ps_shipdate
    and A.areacode     = @ps_areacode
    and A.divisioncode = @ps_divisioncode
    and A.truckno      = @ps_truckno
    and A.confirmflag  = 'N'
    and A.confirmdate  is not null
end 


GO
