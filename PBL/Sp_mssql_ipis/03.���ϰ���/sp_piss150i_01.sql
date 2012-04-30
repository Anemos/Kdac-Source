drop procedure sp_piss150i_01
go
/*
exec sp_piss150i_01 @ps_areacode      = 'D',         -- ��������
                    @ps_divisioncode  = 'S',         -- �����ڵ�
	            @ps_shipdate      = '2002.11.07', -- ������
                    @ps_truckno       = '1234'           -- ������ȣ

*/
CREATE PROCEDURE sp_piss150i_01
	@ps_areacode       char(01),  -- ��������
        @ps_divisioncode   char(01),  -- �����ڵ�
	@ps_shipdate	   char(10),  -- ������
        @ps_truckno        varchar(15),  -- ������ȣ ,
        @pl_fromtruckorder int,
        @pl_totruckorder   int

AS

BEGIN

 SELECT distinct divisioncode = A.DivisionCode,
        ShipSheetNo  = A.ShipSheetNo,   
        TruckNo	     = A.TruckNo,   
        custcode     = C.custcode,
        CustName     = C.CustName,   
        ShipDate     = A.ShipDate,   
        printcount   = A.printcount,
        RePrint    = 1,
        truckorder   = a.truckorder
    FROM tshipsheet   A,
	 tmstcustomer C
   Where A.CustCode	*= C.CustCode
     and A.AreaCode     = @ps_areacode
     and A.DivisionCode LIKE @ps_divisioncode
     and A.ShipDate     = @ps_shipdate
     and a.truckno like @ps_truckno     
     and a.truckorder   >= @pl_fromtruckorder
     and a.truckorder   <= @pl_totruckorder
 order by a.divisioncode,a.truckorder
end

GO
