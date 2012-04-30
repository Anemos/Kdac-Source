/*
	File Name	: sp_piss180i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss180i_01
	Description	: 미납현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss180i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss180i_01]
GO

/*
exec sp_piss180i_01
        @ps_areacode    = 'D',
        @ps_divisioncode = 'S',
	@ps_applydate	 = '2002.10.31',
	@ps_custcode	 = 'L10500',
	@ps_productgroup = '%',
        @ps_modelgroup   = '%',
        @ps_shipoemgubun = '%'

*/
CREATE PROCEDURE sp_piss180i_01
        @ps_areacode            char(01),
        @ps_divisioncode        char(01),
	@ps_applydate		Char(10),
	@ps_custcode		Char(06),
        @ps_productgroup        varchar(02),
	@ps_modelgroup		varChar(03),
	@ps_shipoemgubun	varChar(01)
AS
BEGIN

--customer별  편수와 시간을 알아 낸다.

Create Table #Tmp_ShipOrder
(
	ShipNo		Int,
	CustCode	Char(6),
	ShipEditNo	Char(2),
	shipstarttime	DateTime
)

Declare	@li_rowcount	Int,
	@li_i		Int,
	@ls_custcode	Char(6),
	@ls_shipeditno	Char(2),
	@ldt_shipstarttime	datetime


Select	CustCode       	= CustCode,
	ShipEditNo	= ShipEditNo,
	shipstartTime	= shipstartTime
  Into	#Tmp_Ship
  From	tmsteditno
 Where	Applyfrom	= (	Select	Max(Applyfrom)
				  From	tmsteditno
				 Where	Applyfrom 	<= @ps_applydate
				   and	CustCode	= @ps_custcode
                                   and  areacode        = @ps_areacode
                                   and divisioncode     = @ps_divisioncode	)
   and	CustCode	= @ps_custcode
   and  areacode        = @ps_areacode
   and  divisioncode    = @ps_divisioncode
Order By 2,3

Select @li_rowcount = @@RowCount, @li_i = 0

While @li_i < @li_rowcount
Begin
       	Set RowCount 1
	Select	@li_i		= @li_i + 1,
		@ls_custcode	= CustCode,
		@ls_shipeditno	= Shipeditno,
		@ldt_shipstarttime	= shipstartTime
	  From	#Tmp_Ship

	Insert #Tmp_ShipOrder Values(@li_i, @ls_custcode, @ls_shipeditno, @ldt_shipstarttime)
	Delete #Tmp_Ship
       	Set RowCount 0
End
Drop Table #Tmp_Ship

Select	A.Srno,
        a.divisioncode,
	A.CustCode,
	A.Shipeditno,
	A.shipRemainQty,
	B.ShipNo,
	A.ShipEndGubun,
	Case When ((B.ShipNo = 1) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty1,
	Case When ((B.ShipNo = 2) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty2,
	Case When ((B.ShipNo = 3) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty3,
	Case When ((B.ShipNo = 4) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty4,
	Case When ((B.ShipNo = 5) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty5,
	Case When ((B.ShipNo = 6) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty6,
	Case When ((B.ShipNo = 7) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty7,
	Case When ((B.ShipNo = 8) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty8,
	Case When ((B.ShipNo = 9) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty9,
	Case When ((B.ShipNo = 10) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty10,
	Case When ((B.ShipNo = 11) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty11,
	Case When ((B.ShipNo = 12) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty12,
	Case When ((B.ShipNo = 13) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty13,
	Case When ((B.ShipNo = 14) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty14,
	Case When ((B.ShipNo = 15) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty15,
	Case When ((B.ShipNo = 16) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty16,
	Case When ((B.ShipNo = 17) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty17,
	Case When ((B.ShipNo = 18) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty18,
	Case When ((B.ShipNo = 19) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty19,
	Case When ((B.ShipNo = 20) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty20,
	Case When ((B.ShipNo = 21) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty21,
	Case When ((B.ShipNo = 22) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty22,
	Case When ((B.ShipNo = 23) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty23,
	Case When ((B.ShipNo = 24) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty24,
	Case When ((B.ShipNo = 25) and (A.Shipeditno = B.Shipeditno)) Then A.ShipRemainQty Else 0 End Qty25
  Into	#Tmp_Order
  From	tsrorder A,
	#Tmp_shipOrder B,
	tmstcustomer C,
        tmstshipgubun D
 Where	A.CustCode	= B.CustCode
   and	A.Shipeditno	= B.Shipeditno
   and	A.CustCode	= C.CustCode
   and	A.APPLYFROM	<= @ps_applydate
   and	C.Custcode	= @ps_custcode
   and	A.shipRemainqty	> 0 
   and	A.ShipEndGubun	= 'N'
--   and	A.SrCancelgubun	= 'N'
   and  a.areacode = @ps_areacode
   and  a.divisioncode like @ps_divisioncode
   and  a.shipgubun  = d.shipgubun
   and  d.shipoemgubun like @ps_shipoemgubun
   and  (a.kitgubun = 'N' or (a.kitgubun = 'Y' and a.pcgubun = 'P'))
   and  a.stcd       = 'Y'
Select	G.ProductgroupName,
	A.ItemCode,
	A.Customeritemno,
        G.SortOrder,
        G.ModelID,
	qty1 = Sum(E.Qty1),
	qty2 = Sum(E.Qty2),
	qty3 = Sum(E.Qty3),
	qty4 = Sum(E.Qty4),
	qty5 = Sum(E.Qty5),
	qty6 = Sum(E.Qty6),
	qty7 = Sum(E.Qty7),
	qty8 = Sum(E.Qty8),
	qty9 = Sum(E.Qty9),
	qty10 = Sum(E.Qty10),
	qty11 = Sum(E.Qty11),
	qty12 = Sum(E.Qty12),
	qty13 = Sum(E.Qty13),
	qty14 = Sum(E.Qty14),
	qty15 = Sum(E.Qty15),
	qty16 = Sum(E.Qty16),
	qty17 = Sum(E.Qty17),
	qty18 = Sum(E.Qty18),
	qty19 = Sum(E.Qty19),
	qty20 = Sum(E.Qty20),
	qty21 = Sum(E.Qty21),
	qty22 = Sum(E.Qty22),
	qty23 = Sum(E.Qty23),
	qty24 = Sum(E.Qty24),
	qty25 = Sum(E.Qty25)
From	tsrorder A,
	#Tmp_shipOrder D,
	#Tmp_Order E,
        vmstmodel G
where 	A.Srno  	= E.srno 
   and	A.shipeditno 	= D.shipeditno 
   and 	A.itemcode 	*= G.itemcode
   and  a.areacode = @ps_areacode
   and  a.divisioncode like @ps_divisioncode
   and  a.srareacode *= g.areacode
   and  a.srdivisioncode *= g.divisioncode
   and  (a.kitgubun = 'N' or (a.kitgubun = 'Y' and a.pcgubun = 'P'))
   and  a.stcd ='Y'
Group by G.ProductgroupName,
	A.ItemCode,
	A.Customeritemno,
        G.SortOrder,
        G.modelid

Drop Table #Tmp_Order
Drop Table #Tmp_shipOrder
END



GO
