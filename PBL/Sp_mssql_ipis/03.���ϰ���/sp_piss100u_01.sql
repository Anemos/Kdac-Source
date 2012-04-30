/*
	File Name	: sp_piss100u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss100u_01
	Description	: 수량분할
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss100u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss100u_01]
GO
/*
Exec sp_piss100u_01 @ps_srno          ='291192P00',
                    @ps_applydate     ='2002.11.07',
                    @ps_areacode      = 'D',
                    @ps_divisioncode  = 'S',
                    @ps_empno         = 'DS0',
	            @pi_rackqty       = 96,
                    @ps_srgubun       ='S'
*/
CREATE PROCEDURE sp_piss100u_01
	         @ps_srno               char(11),       -- SR번호
                 @ps_applydate	        Char(10),       -- 기준일
                 @ps_areacode           char(01),       -- 지역구분
                 @ps_divisioncode       char(01),       -- 공장코드
	         @ps_empno	        Char(06),       -- 최종수정자
                 @pi_rackqty            integer,        -- 수용수
                 @ps_srgubun            char(01)        -- 출하OEM구분
AS

BEGIN

  SELECT SRNo	        = A.SRNo,   
         TruckOrder	= IsNUll(B.TruckOrder, 0),
         CustCode	= A.CustCode,   
         ApplyDate	= @ps_applydate,
	 ShipEditNo	= A.ShipEditNo,   
         SRGubun	= @ps_srgubun,   
         TruckNo	= B.TruckNo,   
         ItemCode	= A.ItemCode,   
	 TruckLoadQty	= IsNull(B.TruckLoadQty, 0) / @pi_rackqty,
         TruckDansuQty   = IsNull(B.TruckLoadQty, 0)% @pi_rackqty,
         lastemp	= @ps_empno,
         LastDate	= GetDate(),
         ShipRemainQty	= A.ShipRemainQty,
	 RackQty	= @pi_rackqty,
         Divisioncode   = A.divisioncode
    FROM tsrorder A,
	 tloadplan B   
   WHERE A.SRNo 	*= B.SRNo
     and a.areacode     *= b.areacode
     and a.divisioncode *= b.divisioncode
     and A.srAreaCode     = @ps_areacode
     and A.srDivisioncode = @ps_divisioncode
     and A.ShipRemainQty 	> 0 
     and B.Truckno      is Null
     and A.SRNo         = @ps_srno
     and B.ShipPlanDate = @ps_applydate

end



GO
