/*
	File Name	: sp_piss090u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss090u_01
	Description	: 출하계획(정상)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss090u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss090u_01]
GO
/*
exec sp_piss090u_01 @ps_areacode        = 'D',
                    @ps_divisioncode    = 'S',
                    @ps_applydate	= '2002.12.24'
*/

Create Procedure sp_piss090u_01
        @ps_areacode            char(01),       -- 지역구분
        @ps_divisioncode        char(01),       -- 공장코드
	@ps_applydate		char(10)	-- 출하일자

As
Begin
Select	Distinct AreaCode        = A.AreaCode,
        DivisionCode    = A.DivisionCode,
	ItemCode	= A.ItemCode,
        ItemName        = a.ItemName,
        modelid         = A.ModelId,
	RackQty		= isnull(b.RackQty,9999999)
  Into	#Tmp_ItemName
  From	vmstmodel a,tmstkb b
 Where	a.AreaCode      = @ps_areacode
   and  a.DivisionCode  like @ps_divisioncode
   and  a.areacode      *= b.areacode
   and  a.divisioncode  *= b.divisioncode
   and  a.ItemCode      *= b.ItemCode
--   And	A.ChangeFlag   <> 'D'
--select * from #Tmp_itemname
--drop table #Tmp_itemname
-- 기존에 상차계획 되었던 수량을 Select
Select	SRNo	        = A.SRno,
        checksrno       = b.checksrno,
	CustCode	= A.CustCode,
	Truckorder	= A.TruckOrder,
	TruckLoadQty	= Sum(A.TruckLoadQty),
	TruckDansuQty	= Sum(A.TruckDansuQty)
  Into	#Tmp_TruckPlan
  from	tloadplan A,
        tsrorder B
 Where	A.SRNo          = B.SRNo
   and  B.ShipRemainQty > 0
--   and  B.SRCancelGubun = 'N'
   and  B.ShipEndGubun  = 'N'
   and  A.shipplandate  = @ps_applydate
   and  B.ApplyFrom     = @ps_applydate
   and	A.TruckNo is    Null
   AND  b.SHIPGUBUN     <> 'M'
   and  b.stcd          = 'Y'
   and  (b.kitgubun     = 'N' or (b.pcgubun = 'P' and kitgubun = 'Y'))
   and  a.areacode      = @ps_areacode
   and  a.divisioncode  like @ps_divisioncode
   and  b.areacode      = a.areacode
   and  b.divisioncode  = a.divisioncode
Group By A.SRNo,A.CustCode,A.TruckOrder,b.checksrno
--select * from #tmp_truckplan
--drop table #tmp_truckplan
Select	DivisionCode    = A.Divisioncode,
        SRNo	        = A.SRNo,
        applyfrom       = a.applyfrom,
	TruckOrder	= IsNull(F.TruckOrder, 0),
	CustName	= B.CustName,
	CustCode	= A.CustCode,
        ShipOrderQty    = A.ShipOrderQty,
	ApplyDate	= @ps_applydate,
	RequireDate	= A.ApplyFrom,
	ShipYard	= D.ShipYard,
        ShipEditNO	= A.ShipEditNo,
        SRGubun         = 'S',
	ItemCode	= A.ItemCode,
        ItemName        = case ISNULL(g.ItemName,'')
                                when '' then (select custitemname 
                                                from tmstcustitem 
                                               where custcode = A.CUSTCODE and custitemcode = a.CustomerItemNo)
                                else g.itemname end,
	ModelID		= C.ModelID,
	ShipRemainQty	= A.ShipRemainQty,
	TruckLoadQty	= IsNull(F.TruckLoadQty, 0) / isnull(C.RackQty,9999999),
        TruckDansuQty   = IsNull(F.TruckLoadQty, 0) % isnull(C.RackQty,9999999),
	RackQty		= isnull(C.RackQty,9999999),
	ShipGubunName	= E.ShipGubunName,
	ShipEndGubun	= A.ShipEndGubun,
        TruckNo         = Space(4),
        ShipGubun       = A.Shipgubun,
        checksrno       = A.checksrno,
        kitgubun        = a.kitgubun,
        shipoemgubun    = h.shipoemgubun,
        orderno         = a.orderno
  FROM	tsrorder A,   
	tmstcustomer B,   
	#Tmp_ItemName C,
        tsrheader D,   
	tmstshipgubun E,
	#Tmp_TruckPlan F,
        tmstitem G,
        tmstshipgubun h
 WHERE	A.ShipEndGubun	 = 'N'
--   and	A.SRCancelGubun  = 'N'
   and  A.srareaCode     *= C.AreaCode
   and  A.srdivisioncode *= C.DivisionCode
   and  A.ItemCode 	 *= C.ItemCode
   and  A.ItemCode 	 *= G.ItemCode
   and  A.CustCode 	 *= B.CustCode
   and	A.ShipGubun	 = E.ShipGubun
   and	A.SRNo	         *= F.SRNo
   and	A.CustCode	 *= F.CustCode
   and	A.ApplyFrom	 = @ps_applydate
   and  a.shipremainqty  > 0 
   and  (a.kitgubun      = 'N' or (a.kitgubun = 'Y' and a.pcgubun = 'P'))
   and  A.checksrno      *= D.checksrno
   and  A.SRAreaCode     = @ps_areacode
   and  A.SRDivisioncode like @ps_divisioncode
   AND  a.SHIPGUBUN      <> 'M'
   and  a.stcd           = 'Y'
   and  a.shipgubun      = h.shipgubun
order by custcode,itemcode,applyfrom
Drop Table #Tmp_TruckPlan
Drop Table #Tmp_ItemName
--	ItemName	= ISNULL(C.ItemName,A.ITEMCODE),
End

GO
