/*
	File Name	: sp_piss110i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss090u_03
	Description	: sr보기
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss110i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss110i_01]
GO

/*
Exec sp_piss110i_01 @ps_srno          ='AK2Z00404',
                    @ps_applydate     ='2002.12.09',
                    @ps_areacode      = 'D',
                    @ps_divisioncode  = 'A'
*/

CREATE PROCEDURE sp_piss110i_01
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
         itemname       = case isnull(B.ItemName,'')
                                when '' then (select custitemname 
                                                from tmstcustitem 
                                               where A.CustomerItemNo = custitemcode and a.custcode = custcode)
                                else b.itemname
                          end,   
         custname       = C.CustName,
         itemcode       = A.itemcode,
         orderno        = a.orderno
    FROM tsrorder A,   
         vmstmodel B,   
         tmstcustomer C,
         tsrheader D
   WHERE (A.SRAreaCode     *= B.AreaCode) 
     and (A.SrDivisionCode *= B.Divisioncode)
     and (A.ItemCode       *= B.ItemCode )
     and (A.CustCode       *= C.CustCode )
--     and (A.SRCancelGubun  = 'N' )
     and (A.kitgubun = 'N' or (a.kitgubun = 'Y' and a.pcgubun = 'C'))
     and (A.checksrNo      = @ps_srno)
     and (a.checksrno      *= d.checksrno)
     and (A.SRAreaCode     = @ps_areacode)
     and (A.SrDivisioncode = @ps_divisioncode)
     and (a.shipremainqty > 0)
end


GO
