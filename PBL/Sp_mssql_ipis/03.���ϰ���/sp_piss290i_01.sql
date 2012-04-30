/*
	File Name	: sp_piss290i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss290i_01
	Description	: 출하취소현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss290i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss290i_01]
GO

/*
Exec sp_piss290i_01 @ps_shipdate       = '2002.10.08',
                    @ps_shipdate1      = '2002.12.31',
		    @ps_areacode       = 'D',
		    @ps_divisioncode   = 'S'
*/

CREATE PROCEDURE sp_piss290i_01
	      @ps_shipdate	      char(10),       --from출하일
	      @ps_shipdate1	      char(10),       --to출하일
              @ps_areacode            char(1),        --지역
              @ps_divisioncode        char(1)         --공장

AS

BEGIN

  SELECT shipDate	= Z.shipDate,   
         divisioncode	= Z.divisioncode,   
         ItemCode	= B.ItemCode,   
         ItemName	= B.ItemName,   
         srno           = z.srno,
         ModelId	= B.ModelID,   
         shetsshetno    = Z.shipsheetno,
         shipQty	= Z.shipQty,
         lastemp        = Z.lastemp,
         empname        = Z.empname,
         lastdate       = Z.lastdate
  from 
  (SELECT shipDate	= A.shipDate,   
         areacode       = a.areacode,
         divisioncode	= A.divisioncode,   
         ItemCode	= C.ItemCode,
         srno           = c.srno,   
         shipsheetno   =  a.shipsheetno,
         shipQty	= A.shipQty,
         lastemp        = A.lastemp,
         empname        = D.empname,
         lastdate       = A.lastdate
    FROM TSHIPCANCEL A,   
         tsrorder  C,
         tmstemp D
   WHERE (A.shipdate >= @ps_shipdate)
     and (A.shipdate <= @ps_shipdate1)
     and (A.AreaCode 	 = @ps_areacode) 
     and (A.DivisionCode like @ps_divisioncode)
     and (A.srno         = C.srno)
     and (a.areacode     = C.areacode)
     and (a.divisioncode = c.divisioncode)
     and (a.lastemp      *= d.empno)) Z, vmstmodel b
where b.areacode     = z.areacode
  and b.divisioncode = z.divisioncode
  and b.itemcode     = z.itemcode

END 

GO
