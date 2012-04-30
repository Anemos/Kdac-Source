/*
	File Name	: sp_piss060i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss050i_03
	Description	: 출하요청현황(이체외)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss060i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss060i_01]
GO

/*
Exec dbo.sp_piss060i_01	@ps_applydate	     = '2002.11.23',
		        @ps_areacode        = 'D',
		        @ps_divisioncode    = 'S',
		        @ps_custcode	     = 'L10500',
		        @ps_shipoemgubun    = '%'
*/

CREATE PROCEDURE dbo.sp_piss060i_01
	         @ps_applydate	        Char(10),       -- 기준일
                 @ps_areacode           char(1),        --  지역구분
                 @ps_divisioncode       char(1),        -- 공장코드
	         @ps_custcode	        Char(6),        -- 거래처
                 @ps_shipoemgubun       char(1)         -- 출하OEM구분

AS

BEGIN

-- 거래처별  편수별 시간을 알아 내고 이를  시간대 별로 정렬한다.

Create Table #Tmp_ShipOrder
(
	ShipNo		Int,
	ShipEditNo	Char(2),
	ShipStartTime	DateTime
)

Declare	@li_rowcount	Int,
	@li_i		Int,
	@ls_custcode	Char(6),
	@ls_shipeditno	Char(2),
	@ldt_shipstarttime	datetime


Select	ShipEditNo	= ShipEditNo,
	ShipStartTime	= ShipStartTime
  Into	#Tmp_Ship
  From	tmsteditno
 Where	ApplyFrom	= (	Select	Max(ApplyFrom)
				  From	tmsteditno
				 Where	ApplyFrom 	<= @ps_applydate
				   and	CustCode	= @ps_custcode
                                   and areacode = @ps_areacode
                                   and divisioncode = @ps_divisioncode	)
   and	CustCode	= @ps_custcode
   and areacode = @ps_areacode
   and divisioncode = @ps_divisioncode
Order By 1,2

Select @li_rowcount = @@RowCount, @li_i = 0

While @li_i < @li_rowcount
Begin
       	Set RowCount 1
	Select	@li_i		= @li_i + 1,
		@ls_shipeditno	= ShipEditNo,
		@ldt_shipstarttime	= ShipStartTime
	  From	#Tmp_Ship

	Insert #Tmp_ShipOrder Values( @li_i,@ls_shipeditno, @ldt_shipstarttime)
	Delete #Tmp_Ship
       	Set RowCount 0
End
Drop Table #Tmp_Ship

-- select * from #tmp_ShipOrder
-- 품번,거래처품번,SR의 총미납 수량을 가져온다.
/*
Select	areacode        = a.srareacode,
        divisioncode    = A.srdivisioncode,
        ItemCode	= A.ItemCode,
        CustomerItemNo  = A.CustomerItemNo, 
        SRMinapSum      = Sum(case a.applyfrom when @ps_applydate then 0 else A.ShipRemainQty end)
  Into 	#Tmp_SRMinap
  From 	tsrorder A,
        tmstshipgubun B
 Where 	A.ApplyFrom      <= @ps_applydate
   and	A.ShipEndGubun   = 'N'
   and  A.srcancelgubun  = 'N'
   and  A.ShipRemainqty  > 0 
   and  A.ShipGubun      = B.ShipGubun
   and  B.ShipOemGubun   like @ps_shipoemgubun
   and  B.ShipOemGubun   <> 'X'
   and  a.stcd           ='Y'
   and  A.SRAreaCode     = @ps_areacode
   and  A.SRDivisionCode like @ps_divisioncode
   and  A.CustCode       = @ps_custcode
   and  a.pcgubun        = 'P'
Group by a.srareacode,A.srdivisioncode,A.itemcode,A.CustomerItemNo
--select * from #Tmp_SRMinap
*/
-- 편수별 출하계획현황을 Form 에 맞추어 쿼리한다.

Select	areacode       = a.srareacode,
        divisioncode   = A.srdivisioncode,
        ItemCode       = A.ItemCode,
        CustomerItemNo = A.CustomerItemNo,
        SRMinapSum     = Sum(case a.applyfrom when @ps_applydate then 0 else A.ShipRemainQty end),
	Qty1     = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 1)  Then A.ShipRemainQty Else 0 End else 0 end),
	Qty2     = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 2)  Then A.ShipRemainQty Else 0 End else 0 end),
	Qty3     = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 3)  Then A.ShipRemainQty Else 0 End else 0 end),
        Qty4     = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 4)  Then A.ShipRemainQty Else 0 End else 0 end),
	Qty5     = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 5)  Then A.ShipRemainQty Else 0 End else 0 end),
	Qty6     = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 6)  Then A.ShipRemainQty Else 0 End else 0 end),
	Qty7     = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 7)  Then A.ShipRemainQty Else 0 End else 0 end),
	Qty8     = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 8)  Then A.ShipRemainQty Else 0 End else 0 end),
	Qty9     = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 9)  Then A.ShipRemainQty Else 0 End else 0 end),
	Qty10    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 10) Then A.ShipRemainQty Else 0 End else 0 end),
	Qty11    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 11) Then A.ShipRemainQty Else 0 End else 0 end),
        Qty12    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 12) Then A.ShipRemainQty Else 0 End else 0 end),
	Qty13    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 13) Then A.ShipRemainQty Else 0 End else 0 end),
	Qty14    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 14) Then A.ShipRemainQty Else 0 End else 0 end),
	Qty15    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 15) Then A.ShipRemainQty Else 0 End else 0 end),
	Qty16    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 16) Then A.ShipRemainQty Else 0 End else 0 end),
	Qty17    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 17) Then A.ShipRemainQty Else 0 End else 0 end),
        Qty18    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 18) Then A.ShipRemainQty Else 0 End else 0 end),
	Qty19    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 19) Then A.ShipRemainQty Else 0 End else 0 end),
	Qty20    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 20) Then A.ShipRemainQty Else 0 End else 0 end),
	Qty21    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 21) Then A.ShipRemainQty Else 0 End else 0 end),
        Qty22    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 22) Then A.ShipRemainQty Else 0 End else 0 end),
	Qty23    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 23) Then A.ShipRemainQty Else 0 End else 0 end),
	Qty24    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 24) Then A.ShipRemainQty Else 0 End else 0 end),
	Qty25    = sum(case applyfrom when @ps_applydate then Case When (B.ShipNo = 25) Then A.ShipRemainQty Else 0 End else 0 end)
  Into	#Tmp_SROrder
  From	tsrorder A,
	#Tmp_ShipOrder B,
        tmstshipgubun C
Where	A.CustCode	 = @ps_custcode
    and	A.ShipEditNo	 = B.ShipEditNo
    and	A.ShipGubun	 = C.ShipGubun
    and C.ShipOemGubun   like @ps_shipoemgubun
    and C.ShipOemGubun   <> 'X'
    and A.ShipRemainQty  > 0
    and	A.ApplyFrom 	 <= @ps_applydate 
--    and	A.SRCancelGubun	 = 'N'
    and A.shipendgubun   = 'N'
    and a.stcd           = 'Y'
    and A.SRAreaCode     = @ps_areacode
    and A.SRDivisionCode like @ps_divisioncode
    and pcgubun          = 'P'
group by a.srareacode,A.srdivisioncode,A.ItemCode,A.CustomerItemNo
--select * from #Tmp_SROrder
-- 편수별 출하계획현황을 Form 에 맞추어 쿼리한다.
--select * from #Tmp_SROrder
Select	areacode         = b.areacode,
        divisioncode     = B.divisioncode,
        productgroup     = A.productgroup,
        ProductGroupName = A.ProductGroupName,
	ItemCode         = B.ItemCode,
        ItemName         = case ISNULL(A.ItemName,'')
                                when '' then (select custitemname 
                                                      from tmstcustitem 
                                                     where custcode = @ps_custcode and custitemcode = B.CustomerItemNo )
                                else a.itemname end,
        CustomerItemno	 = B.CustomerItemNo,      
	ModelID		 = A.ModelID,
	srminapsum       = IsNull(srminapsum,0),
	Qty1             = IsNull(Qty1,0),
	Qty2             = IsNull(Qty2,0),
	Qty3             = IsNull(Qty3,0),
        Qty4             = IsNull(Qty4,0),
	Qty5             = IsNull(Qty5,0),
	Qty6             = IsNull(Qty6,0),
	Qty7             = IsNull(Qty7,0),
	Qty8             = IsNull(Qty8,0),
	Qty9             = IsNull(Qty9,0),
	Qty10            = IsNull(Qty10,0),
	Qty11            = IsNull(Qty11,0),
        Qty12            = IsNull(Qty12,0),
	Qty13            = IsNull(Qty13,0),
	Qty14            = IsNull(Qty14,0),
	Qty15            = IsNull(Qty15,0),
	Qty16            = IsNull(Qty16,0),
	Qty17            = IsNull(Qty17,0),
        Qty18            = IsNull(Qty18,0),
	Qty19            = IsNull(Qty19,0),
	Qty20            = IsNull(Qty20,0),
	Qty21            = IsNull(Qty21,0),
        Qty22            = IsNull(Qty22,0),
	Qty23            = IsNull(Qty23,0),
	Qty24            = IsNull(Qty24,0),
	Qty25            = IsNull(Qty25,0)
  Into	#Tmp_SrOrder1
  From	#Tmp_SROrder B,vmstmodel A
 Where	A.Itemcode	= B.ItemCode
   and  A.areacode      = B.areacode
   and  A.divisioncode  = B.Divisioncode

Drop Table #Tmp_SROrder

Select	ProductGroup     = A.ProductGroup,
        ProductGroupName = A.ProductGroupName,
	ItemCode         = A.ItemCode,
	ItemName         = A.ItemName,
	customeritemno	 = A.CustomerItemNo,
        ModelID          = A.ModelID,
	MinapQty	 = a.SRMinapSum,
	Qty1             = Sum(Qty1),
	Qty2             = Sum(Qty2),
	Qty3             = Sum(Qty3),
        Qty4             = Sum(Qty4),
	Qty5             = Sum(Qty5),
	Qty6             = Sum(Qty6),
	Qty7             = Sum(Qty7),
	Qty8             = Sum(Qty8),
	Qty9             = Sum(Qty9),
	Qty10            = Sum(Qty10),
	Qty11            = Sum(Qty11),
        Qty12            = Sum(Qty12),
	Qty13            = Sum(Qty13),
	Qty14            = Sum(Qty14),
	Qty15            = Sum(Qty15),
	Qty16            = Sum(Qty16),
	Qty17            = Sum(Qty17),
        Qty18            = Sum(Qty18),
	Qty19            = Sum(Qty19),
	Qty20            = Sum(Qty20),
	Qty21            = Sum(Qty21),
        Qty22            = Sum(Qty22),
	Qty23            = Sum(Qty23),
	Qty24            = Sum(Qty24),
	Qty25            = Sum(Qty25)
  From  #Tmp_SROrder1 A
/*,
--	#Tmp_SRMinap B
 Where	A.divisioncode    *= B.divisioncode
   and  A.ItemCode        *= B.ItemCode
   and  A.CustomerItemNo  *= B.CustomerItemNo
*/
Group by A.ProductGroup,ProductGroupName, A.ItemCode, A.ItemName, A.CustomerItemNo, A.ModelID,a.srminapsum
--,
--         B.SRMinapSum

--Drop Table #Tmp_SRMinap
Drop Table #Tmp_SRorder1

end

GO
