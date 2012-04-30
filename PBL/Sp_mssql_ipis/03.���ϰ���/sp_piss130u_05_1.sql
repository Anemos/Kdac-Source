/*
	File Name	: sp_piss130u_05_1.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss130i_05_1
	Description	: 출고간판reading(출고전표모품번포함)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss130u_05_1]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss130u_05_1]
GO


/*
exec sp_piss130u_05_1 @ps_areacode = 'D',       -- 지역코드
                    @ps_divisioncode = 'S',  -- 공장코드
	            @pi_truckorder = 1,      -- 차량순번
	            @ps_truckno	= '1234',    -- 차량번호
	            @ps_month = '2002.11',   -- 출고전표발행년월
	            @ps_shipdate = '2002.11.13'

*/
CREATE PROCEDURE sp_piss130u_05_1
        @ps_areacode            char(01),       -- 지역코드
        @ps_divisioncode        char(01),       -- 공장코드
	@pi_truckorder          int,            -- 차량순번
	@ps_truckno		varChar(11),	-- 차량번호
	@ps_month		Char(07),	-- 출고전표 발행 월
	@ps_shipdate		Char(10)        -- 출하일
        

AS

BEGIN

Declare	@ls_moveserial	    Char(04),
	@ls_serial	    Char(04),
	@ls_shipsheetno	    Char(08),
	@ls_srno	    Varchar(11),
	@li_TruckOrder	    Int,
	@ls_TruckNo	    Char(11),
        @ls_shipgubun       char(01),
	@ls_CustCode	    Char(06),
	@ls_ApplyDate	    Char(10),
	@li_ShipQty	    Int,
	@li_rowcount	    Int,
	@li_shipsheet_count int,
	@i		    Int,
	@j		    Int,
	@li_loop	    Int,
	@li_srno_loop	    Int,
	@ls_sheetserial	    Char(4),
	@ls_sheet	    Char(4),
        @ls_divisioncode    char(01),
        @li_seq             int,
        @ls_year            char(01),
        @ls_month           char(02),
        @ls_compare_custcode char(06),
        @ls_compare_shipgubun char(01),
        @ls_compare_divisioncode char(01),
        @li_count           int ,
        @ls_itemcode        char(12)


-- 기존에 발행된 출고전표 시리얼 값의 최대 값들을 구해온다.
Select	DivisionCode    = Divisioncode,
        shipgubun       = substring(shipsheetno,3,1),
	SheetSerial	= IsNull(max(Substring(ShipSheetNo, 7, 4)), '0000')
  Into	#tmp_tempshipsheet
  From 	tshipsheet
 Where 	substring(ShipDate, 1, 7) = @ps_month
   and  AreaCode = @ps_areacode
   and  Divisioncode like @ps_divisioncode
Group by DivisionCode,substring(shipsheetno,3,1)

Select	DivisionCode    = Divisioncode,
        shipgubun       = shipgubun,
	SheetSerial	= max(SheetSerial)
  Into	#Tmp_sheetSerial
  From 	#tmp_tempshipsheet
Group by DivisionCode,shipgubun
--select * from #Tmp_sheetSerial
Drop table #tmp_tempshipsheet

Create Table #Tmp_ShipSheetno
(
        ShipSheetNo	Char(10),
	SRNo 	        Varchar(10),
	TruckOrder	Int,
	CustCode	Char(06),
	ShipDate	Char(10),	ShipQty		Int,
        shipgubun       char(01)
)
-- 상차계획 table에 있는 Rack수량과 단수품 수량을  실제 제품의상차수량으로 
-- 바꾸어서 가져온다.
Select	SRNo	        = A.SRNo,
	CustCode	= A.CustCode,
	TruckOrder	= A.Truckorder,
	TruckNo		= A.TruckNo,
	ApplyFrom	= A.ApplyFrom,
	ShipEditNo	= A.ShipEditNo,
	ItemCode	= A.ItemCode,	
	ShipQty		= A.TruckLoadQty,
        DivisionCode    = A.DivisionCode,
        shipgubun       = b.shipgubun
  Into	#Tmp_shipqty_sr
  From	tloadplan A,tsrorder b
 where	A.ShipPlanDate  = @ps_shipdate
   and	A.TruckOrder 	= @pi_truckorder
   and  A.AreaCode      = @ps_areacode
   and  a.areacode = b.srareacode
   and  a.divisioncode = b.srdivisioncode
   and  a.srno = b.srno
   and  A.Divisioncode  like @ps_divisioncode
   and	A.TruckNo is Null
   and  (b.kitgubun = 'N' or (b.kitgubun = 'Y' and b.pcgubun = 'C'))
   and  b.stcd       = 'Y'
   and  a.shipremainqty > 0
   and  b.shipendgubun <> 'Z'
order by a.divisioncode,a.custcode,a.shipgubun
--SELECT * FROM #tmp_shipqty_sr

-- S/R
select @ls_year  = SUBSTRING(@PS_SHIPDATE,4,1)
select @ls_month = SUBSTRING(@PS_SHIPDATE,6,2) 

SELECT	ShipSheet	= @ps_areacode + A.DivisionCode + A.ShipGubun + @ls_year + @ls_month,
	SRNo            = A.SRNo,
	TruckOrder	= B.Truckorder,
	CustCode	= A.CustCode,
	ShipQty		= B.ShipQty,
        DivisionCode    = A.DivisionCode,
        shipgubun       = a.shipgubun
  Into	#Tmp_TmpShipSheet
  FROM	tsrorder A,   
	#Tmp_shipqty_sr B 
 WHERE 	A.SRNo 	= B.SRNo
   and	A.ShipEditNo	= B.ShipEditNo
   and	A.ItemCode	= B.ItemCode
--   and	A.SRCancelGubun	= 'N'
   and	A.ShipRemainQty	> 0
   and  A.AreaCode = @ps_areacode
   and  A.DivisionCode = B.DivisionCode
   and (a.kitgubun = 'N' or ( a.kitgubun = 'Y' and a.pcgubun = 'C'))
   and (a.shipendgubun <> 'Z')
--select * from #Tmp_TmpShipSheet
Drop Table #Tmp_shipQty_sr

SELECT	DivisionCode    = A.DivisionCode,
        ShipSheet	= A.ShipSheet,
	SRNo		= A.SRNo,
	SheetSerial	= IsNull(B.SheetSerial,'0000'),
	TruckOrder	= A.Truckorder,
	CustCode	= A.CustCode,
	ShipQty		= A.ShipQty,
        shipgubun       = a.shipgubun
  Into	#Tmp_ShipSheet_sr
  FROM	#Tmp_TmpShipSheet A,   
	#Tmp_sheetSerial B
 WHERE 	a.shipgubun *= b.shipgubun
    and A.DivisionCode  *= B.DivisionCode
order by A.divisioncode,A.custcode,a.shipgubun
--select * from #Tmp_ShipSheet_sr
Create Table #Tmp_SRNo
(
	SRNo	Char(11)
)

Select	DivisionCode    = A.DivisionCode,
        ShipSheet	= A.ShipSheet,
	SheetSerial	= A.SheetSerial,
        shipgubun       = a.shipgubun
  Into	#Tmp_SheetNo
  From	#Tmp_ShipSheet_sr A
--Group By A.DivisionCode,A.ShipSheet, A.SheetSerial
order by A.DivisionCode,a.shipgubun,A.ShipSheet

select @li_count = count(*)
  from #Tmp_ShipSheet_sr

select @i = 1,@ls_compare_custcode = ' ',@ls_compare_divisioncode = ' ',@ls_serial = '',@ls_compare_shipgubun = ''
while @i <= @li_count
begin
  set rowcount @i
  select @li_seq = @li_seq + 1
  Select @ls_custcode     = custcode,
         @ls_divisioncode = divisioncode,
         @ls_shipgubun    = shipgubun,
         @ls_srno         = srno
    From #Tmp_ShipSheet_sr
--  print 'divisioncode :'+ @ls_divisioncode + ':' + @ls_srno
  if @ls_divisioncode <> @ls_compare_divisioncode   --공장이 바뀌면
     begin
       select @ls_compare_Divisioncode = @ls_divisioncode
       select @ls_compare_custcode = @ls_custcode
       select @ls_compare_shipgubun = @ls_shipgubun
       select @li_seq = 1
       select @ls_serial = isnull(sheetserial,'0000')
         from #tmp_sheetserial
        where divisioncode = @ls_divisioncode
       if @ls_serial = null or @ls_serial = ''
          begin
            select @ls_serial = '0000'
          end
      update #Tmp_ShipSheet_sr
          Set SheetSerial = substring('0000' + Convert(VarChar(4), Convert(int,@ls_serial) + 1),len('0000' + Convert(VarChar(4), Convert(int,@ls_serial) + 1)) - 3, 4)
         where divisioncode = @ls_divisioncode
           and srno = @ls_srno
     end
  else if @ls_custcode <> @ls_compare_custcode or @li_seq > 10 or @ls_shipgubun <> @ls_compare_shipgubun   --거래처가 바뀌거나 건수가 10보다 크거나 출하구분이 바뀌면
       begin
         select @ls_compare_custcode  = @ls_custcode
         select @ls_compare_shipgubun = @ls_shipgubun
         select @li_seq = 1
         select @ls_serial = max(sheetserial)
           from #Tmp_ShipSheet_sr
          where divisioncode = @ls_divisioncode
            and shipgubun    = @ls_shipgubun
         if @ls_serial = null or @ls_serial = ''
         begin
            select @ls_serial = '0000'
         end 
         update #Tmp_ShipSheet_sr
            Set SheetSerial = substring('0000' + Convert(VarChar(4), Convert(int,@ls_serial) + 1),len('0000' + Convert(VarChar(4), Convert(int,@ls_serial) + 1)) - 3, 4)
          where divisioncode = @ls_divisioncode
            and srno = @ls_srno
       end
  else 
  begin
    update #Tmp_ShipSheet_sr
       Set SheetSerial = substring('0000' + Convert(VarChar(4), Convert(int,@ls_serial) + 1),len('0000' + Convert(VarChar(4), Convert(int,@ls_serial) + 1)) - 3, 4)
     where divisioncode = @ls_divisioncode
       and srno = @ls_srno
  end
  select @i = @i + 1
end

Drop Table #Tmp_SheetNo
Drop Table #Tmp_SRNo

select	ShipSheetNo	= ShipSheet + SheetSerial,
        SRNo            = SRNo,
	TruckOrder	= @pi_truckorder,
	TruckNo		= @ps_truckno,
	CustCode        = CustCode,
	ShipQty         = ShipQty,
        DivisionCode    = DivisionCode
 from	#Tmp_ShipSheet_sr
ORDER BY ShipSheet + SheetSerial
Drop Table #Tmp_ShipSheet_sr
End 

GO
