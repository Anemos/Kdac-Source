/*
	File Name	: sp_piss150i_06.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss150i_06
	Description	: 출고전표
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss150i_06]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss150i_06]
GO

/*
exec sp_piss150i_06 @ps_areacode     = 'D',          -- 지역구분
                    @ps_divisioncode = 'V',          -- 공장코드
                    @ps_shipsheetno	 = 'DVP211002', -- 발행번호
	            @ps_shipdate	 = '2002.11.27'  -- 출하일
*/
CREATE PROCEDURE sp_piss150i_06
	@ps_areacode     char(01),        -- 지역구분
        @ps_divisioncode char(01),        -- 공장코드
        @ps_shipsheetno	 Char(10),        -- 발행번호
	@ps_shipdate	 Char(10)         -- 출하일
AS

declare
  @ls_custcode       varchar(06),
  @ls_divisionname   varchar(30),
  @ls_addr           varchar(100),
  @ls_headname       varchar(10),
  @ls_divisionno     varchar(10),
  @ls_divisionname_1 varchar(30),
  @ls_addr_1         varchar(100),
  @ls_headname_1     varchar(10),
  @ls_divisionno_1   varchar(10)
BEGIN

--공급자
Select @ls_divisionname = divisionname,
       @ls_addr         = '',
       @ls_headname     = '',
       @ls_divisionno   = ''
  from tmstdivision
 where areacode     = @ps_areacode
   and divisioncode = @ps_divisioncode

--받는자
select top 1 @ls_custcode = custcode
  from tshipsheet
 where shipsheetno  = @ps_shipsheetno
   and areacode     = @ps_areacode
   and divisioncode = @ps_divisioncode
   and shipdate     = @ps_shipdate

--이체시
if substring(@ps_shipsheetno,3,1) = 'M' 
   begin
      Select @ls_divisionname_1 = divisionname,
             @ls_addr_1         = '',
             @ls_headname_1     = '',
             @ls_divisionno_1   = ''
        from tmstdivision
       where areacode     = substring(@ls_custcode,1,1)
         and divisioncode = substring(@ls_custcode,2,1)
   end
--이체가 아니면
if substring(@ps_shipsheetno,3,1) <> 'M'
   begin
      Select @ls_divisionname_1 = custname,
             @ls_addr_1         = CustAddress1 + ' ' + CustAddress2,
             @ls_headname_1     = CustHeadName,
             @ls_divisionno_1   = CustNO
        from tmstcustomer
       where custcode     = @ls_custcode
   end
Select	distinct SRNo   = A.SRNo,
        TruckNo		= A.TruckNo,
	TruckOrder	= A.Truckorder,
	CustCode	= A.CustCode,
	CustName	= @ls_divisionname_1,
	CustNo	        = @ls_divisionno_1,
	CustHeadName	= @ls_headname_1,
	CustAddress     = @ls_addr_1,
	ItemCode	= B.ItemCode,
        CustomerItemNo  = B.CustomerItemNo,
	ItemName	= C.ItemName,
	ShipOrderQty	= B.ShipOrderQty,
--        ShipQty         = sum(E.truckloadqty),
        ShipQty         = a.shipqty,
	ShipUsage	= B.ShipUsage,
        CheckSRNo       = checksrno,
        prtSRNo         = case substring(@ps_shipsheetno,3,1) when 'M' then B.moverequireno else B.CheckSRNo end,
        divisionno      = @ls_divisionno,
        headname        = @ls_headname,
        divisionname    = @ls_divisionname,
        addr            = @ls_addr
  From	tshipsheet   A,
	tsrorder     B,
	tmstitem     C
--        ,tloadplan    E
 Where	A.ShipSheetno 	= @ps_shipsheetno
   and	A.ShipDate 	= @ps_shipdate
   and  A.AreaCode      = @ps_areacode
   and  A.DivisionCode  = @ps_divisioncode
   and A.SRNo	        = B.SrNO
   And	B.itemCode	= C.ItemCode
--   And	B.SRCancelGubun	= 'N'
--   and  A.AreaCode      = B.AreaCode
--   and  A.DivisionCode  = B.divisionCode
/*  and  A.ShipDate      *= E.ShipplanDate
--   and  A.AreaCode      *= E.AreaCode
--   and  A.DivisionCode  *= E.DivisionCode
--   and  A.SRNo          *= E.SRNo

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
*/
end

--drop table #tmp_rackqty


GO
