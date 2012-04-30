/*
	File Name	: sp_piss090u_04.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss090u_04
	Description	: 출하계획(이체)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss090u_04]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss090u_04]
GO


/*
exec sp_piss090u_04 @ps_areacode        = 'J',
                    @ps_divisioncode    = 'H',
                    @ps_applydate	= '2003.01.14'
*/

Create Procedure sp_piss090u_04
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

-- 기존에 상차계획 되었던 수량을 Select
Select	SRNo	        = A.SRno,
        checksrno       = b.checksrno,
	Truckorder	= A.TruckOrder,
	TruckLoadQty	= Sum(A.TruckLoadQty),
	TruckDansuQty	= Sum(A.TruckDansuQty)
  Into	#Tmp_TruckPlan
  from	tloadplan A,
        tsrorder B
 Where	A.shipplandate  = @ps_applydate
   and  A.SRNo          = B.SRNo
   and  B.ShipRemainQty > 0
--   and  B.SRCancelGubun = 'N'
--   and  B.ShipEndGubun  = 'N'
--   and  B.ApplyFrom     <= @ps_applydate
   and	A.TruckNo is Null
   and  B.ShipGubun     = 'M'
   and  b.stcd          = 'Y'
   and  a.areacode     = @ps_areacode
   and  a.divisioncode like @ps_divisioncode
   and  a.areacode     = b.SRareacode
   and  a.divisioncode = b.SRdivisioncode
   AND  b.shipremainqty > 0
Group By A.SRNo,A.CustCode,A.TruckOrder,b.checksrno

Select	distinct DivisionCode    = A.Divisioncode,
        SRNo	        = A.SRNo,
	TruckOrder	= IsNull(F.TruckOrder, 0),
	custName	= a.moveareacode,
	CustCode	= A.movedivisioncode,
        ShipOrderQty    = A.ShipOrderQty,
	ApplyDate	= @ps_applydate,
	RequireDate	= A.ApplyFrom,
	Applyfrom	= A.ApplyFrom,
	ShipYard	= D.ShipYard,
	ShipEditNo	= A.ShipEditNO,
        SRGubun         = 'M',
	ItemCode	= A.ItemCode,
        ItemName         = case ISNULL(G.ItemName,'')
                                when '' then (select custitemname 
                                                      from tmstcustitem 
                                                     where custcode = A.CUSTCODE and custitemcode = a.CustomerItemNo )
                                else G.itemname end,
	ModelID		= C.ModelID,
	ShipRemainQty	= A.ShipRemainQty,
	TruckLoadQty	= IsNull(F.TruckLoadQty, 0) / ISNULL(C.RackQty,9999999),
        TruckDansuQty   = IsNull(F.TruckLoadQty, 0)% ISNULL(C.RackQty,9999999),
	RackQty		= ISNULL(C.RackQty,9999999),
	ShipGubunName	= E.ShipGubunName,
	ShipEndGubun	= A.ShipEndGubun,
        TruckNo         = Space(15),
        shipgubun       = A.shipgubun,
        checksrno       = A.checksrno,
        kitgubun        = a.kitgubun,
        shipoemgubun    = E.shipoemgubun,
        orderno         = a.orderno
  FROM	tsrorder A,   
	#Tmp_ItemName C,
        tsrheader D,   
	tmstshipgubun E,
	#Tmp_TruckPlan F,
        tmstitem G
 WHERE	
--A.ShipEndGubun	 = 'N'
--   AND A.SRCancelGubun  = 'N'
    ((A.SHIPendGUBUN = 'Y' and ISNULL(A.SHIPDATE,'') = @ps_applydate)  or (A.SHIPendGUBUN = 'N'))
   and  A.srAreaCode     *= C.AreaCode
   and  A.srDivisioncode *= C.DivisionCode
   and  A.ItemCode       *= C.ItemCode
   and  A.ItemCode       *= G.ItemCode
   and	A.ShipGubun      = E.ShipGubun
   and	A.SRNo	         *= F.SRNo
--   and	A.ApplyFrom      <= @ps_applydate
   and  A.checksrno      *= D.checksrno
   and  A.srAreaCode     = @ps_areacode
   and  A.srDivisioncode like @ps_divisioncode
   and  A.ShipGubun      = 'M'
   and  a.stcd           = 'Y'
   and  a.shipremainqty > 0
order by A.movedivisioncode,a.applyfrom,a.itemcode
Drop Table #Tmp_TruckPlan
Drop Table #Tmp_ItemName

End

GO
