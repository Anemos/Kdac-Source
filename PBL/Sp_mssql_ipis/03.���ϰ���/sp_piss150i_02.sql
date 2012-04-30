drop procedure sp_piss150i_02
go
/*
exec sp_piss150i_02 @ps_areacode     = 'D',          -- 지역구분
                    @ps_divisioncode = 'A',          -- 공장코드
                    @ps_shipsheetno	 = 'AM290002',          -- 발행번호
	            @ps_shipdate	 = '2002.10.09'  -- 출하일
*/
CREATE PROCEDURE sp_piss150i_02
	@ps_areacode     char(01),        -- 지역구분
        @ps_divisioncode char(01),        -- 공장코드
        @ps_shipsheetno	 Char(08),        -- 발행번호
	@ps_shipdate	 Char(10)         -- 출하일
AS

BEGIN

/*
Select distinct itemcode = itemcode,
       rackqty  = rackqty
  into #tmp_rackqty
  from tmstkb
 where areacode     = @ps_areacode
   and divisioncode = @ps_divisioncode
*/
Select	distinct SRNo   = A.SRNo,
        TruckNo		= A.TruckNo,
	TruckOrder	= A.Truckorder,
	CustCode	= A.CustCode,
	CustName	= D.CustName,
	CustNo	        = D.CustNO,
	CustHeadName	= D.CustHeadName,
	CustAddress     = D.CustAddress1 + ' ' + D.CustAddress2,
	ItemCode	= B.ItemCode,
        CustmorItemNo   = B.CustomerItemNo,
	ItemName	= C.ItemName,
	ShipOrderQty	= B.ShipOrderQty,
        ShipQty         = sum(E.shipqty),
	ShipUsage	= B.ShipUsage,
        CheckSRNo       = B.CheckSRNo
  From	tshipsheet   A,
	tsrorder     B,
	tmstitem     C,
	tmstcustomer D,
        tshipkbhis   E
 Where	A.SRNo	        = B.SrNO
   And	B.itemCode	= C.ItemCode
   And	A.CustCode	*= D.CustCode
   And	B.SRCancelGubun	= 'N'
   and	A.ShipSheetno 	= @ps_shipsheetno
   and	A.ShipDate 	= @ps_shipdate
   and  A.AreaCode      = @ps_areacode
   and  A.DivisionCode  = @ps_divisioncode
   and  A.AreaCode      = B.srAreaCode
   and  A.DivisionCode  = B.srdivisionCode
   and  A.ShipDate      = E.ShipDate
   and  A.AreaCode      = E.AreaCode
   and  A.DivisionCode  = E.DivisionCode
   and  A.SRNo          = E.SRNo
   and  A.shipsheetno   = E.shipsheetno
group by A.SRNo,
        A.TruckNo,
	A.Truckorder,
	A.CustCode,
	D.CustName,
	D.CustNO,
	D.CustHeadName,
	D.CustAddress1,D.CustAddress2,
	B.ItemCode,
        B.CustomerItemNo,
	C.ItemName,
	B.ShipOrderQty,
	B.ShipUsage,
        B.CheckSRNo
end

--drop table #tmp_rackqty


GO
