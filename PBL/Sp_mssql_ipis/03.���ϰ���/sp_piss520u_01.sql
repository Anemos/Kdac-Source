drop procedure sp_piss520u_01
go
/*
exec sp_piss520u_01 @ps_areacode      = 'D',         -- ��������
                    @ps_divisioncode  = 'S',         -- �����ڵ�
	            @ps_shipdate      = '2002.11.07',-- ������
                    @ps_truckorder    = 1,           -- ��������
                    @ps_truckno       = '1234'       -- ��������

*/
CREATE PROCEDURE sp_piss520u_01
	@ps_areacode       char(01),     -- ��������
        @ps_divisioncode   char(01),     -- �����ڵ�
	@ps_shipdate	   char(10),     -- ������
        @pl_truckorder     int,          -- �������� 
        @ps_truckno        varchar(15)  -- ������ȣ ,

AS

BEGIN

 SELECT distinct divisioncode = A.DivisionCode,
        ShipSheetNo  = A.ShipSheetNo,   
        TruckNo	     = A.TruckNo,   
        custcode     = C.custcode,
        CustName     = C.CustName,   
        ShipDate     = A.ShipDate,   
        truckorder   = a.truckorder
   FROM tshipsheet   A,
	tmstcustomer C
  Where A.CustCode	*= C.CustCode
    and A.AreaCode     = @ps_areacode
    and A.DivisionCode LIKE @ps_divisioncode
    and A.ShipDate     = @ps_shipdate
    and a.truckno      = @ps_truckno     
    and a.truckorder   = @pl_truckorder
 order by a.divisioncode,a.shipsheetno
end

GO
