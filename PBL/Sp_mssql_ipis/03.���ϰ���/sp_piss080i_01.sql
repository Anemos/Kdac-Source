/*
	File Name	: sp_piss080i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss010i_01
	Description	: 미납보기
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss080i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss080i_01]
GO
/*
exec sp_piss080i_01 @ps_areacode     = '1',
                    @ps_divisioncode = '1',
	            @ps_applydate    = '2002.01.01',
                    @ps_itemcode     = '1'

*/
CREATE PROCEDURE sp_piss080i_01
        @ps_areacode            char(01),
        @ps_divisioncode        char(01),
	@ps_applydate 		Char(10),
	@ps_itemcode 		Varchar(12)
AS

BEGIN

  SELECT ShipDate	= A.applyfrom,   
         SRNo		= A.checkSRNo,
         ShipGubunName	= C.ShipGubunName,   
         CustName	= B.CustName,   
         ShipEditNo	= A.ShipEditNo,   
         ShipRemainQty	= A.ShipRemainQty,
         inputdate      = d.inputdate
    FROM TSRORDER A,   
         TMSTCUSTOMER B,   
         TMSTSHIPGUBUN C,
         tsrheader d  
   WHERE (A.CustCode 	    = B.CustCode)
     and (A.ShipGubun 	    = C.ShipGubun)
     and (A.SRAreaCode      = @ps_areacode)
     and (A.ItemCode        = @ps_itemcode)
     and (A.ShipEndGubun    = 'N') 
     and (a.shipremainqty > 0)
--     and (A.SRCancelGubun   = 'N') 
     and (A.SRDivisionCode  = @ps_divisioncode) 
     and (A.ApplyFrom       <= @ps_applydate)
     and a.stcd = 'Y'
     and a.checksrno *= d.checksrno
order by a.checksrno,d.inputdate,a.applyfrom
END


GO
