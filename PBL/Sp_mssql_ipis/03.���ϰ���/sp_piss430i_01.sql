/*
	File Name	: sp_piss430i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss430i_01
	Description	: 자SR보기
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss430i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss430i_01]
GO


/*
Exec sp_piss430i_01 @ps_srno          ='12345P0',
                    @ps_applydate     ='2002.10.28',
                    @ps_areacode      = 'D',
                    @ps_divisioncode  = 'S'
*/

CREATE PROCEDURE sp_piss430i_01
	         @ps_srno               VARchar(11),       -- SR번호
                 @ps_applydate	        Char(10),       -- 기준일
                 @ps_areacode           char(01),       -- 지역구분
                 @ps_divisioncode       char(01)       -- 공장코드

AS

BEGIN

 SELECT  srno           = A.SRNo,   
         shipyard       = D.ShipYard,   
         srserial       = A.SRSerial,   
         srsplitcount   = A.SRSplitCount,   
         applyfrom      = A.ApplyFrom,   
         custcode       = A.CustCode,   
         shipeditno     = A.ShipEditNo,   
         productgroup   = A.ProductGroup,   
         modelgroup     = A.ModelGroup,   
         modelid         = B.Modelid,
         customeritemno = A.CustomerItemNo,   
         shiporderqty   = A.ShipOrderQty,   
         shipremainqty  = A.ShipRemainQty,   
         shipusage      = A.ShipUsage,   
         shipendgubun   = A.ShipEndGubun,   
         srcancelgubun  = A.SrCancelGubun,   
         shipdate       = A.ShipDate,   
         lastemp        = A.LastEmp,   
         lastdate       = A.LastDate,   
         shipgubun      = A.ShipGubun,   
         divisioncode   = A.SRDivisionCode,   
         itemname       = B.ItemName,   
         custname       = C.CustName,
         itemcode       = A.itemcode
    FROM tsrorder A,   
         vmstmodel B,   
         tmstcustomer C,
         tsrheader D
   WHERE (A.SRAreaCode     = B.AreaCode) 
     and (A.SrDivisionCode = B.Divisioncode)
     and (A.ItemCode       = B.ItemCode )
     and (A.CustCode       = C.CustCode )
--     and (A.SRCancelGubun  = 'N' )
     and (A.PsrNo          = @ps_srno)
     and (A.SRAreaCode     *= D.SRAreaCode)
     and (A.SRDivisionCode *= D.SRDivisionCode)
     and (A.ShipGubun      *= D.ShipGubun)
     and (A.SRYear         *= D.SRYear)
     and (A.SrMonth        *= D.SRMonth)
     and (A.Srserial       *= D.srserial)
     and (A.SRSplitcount   *= D.SrSplitCount)
     and (A.SRAreaCode     = @ps_areacode)
     and (A.SrDivisioncode = @ps_divisioncode)
     and (a.pcgubun        = 'C')

end


GO
