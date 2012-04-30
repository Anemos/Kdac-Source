/*
	File Name	: sp_piss461i_03.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss461i_03
	Description	: 영업SR취소확정
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss461i_03]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss461i_03]
GO
/*
exec sp_piss461i_03 @ps_areacode         = 'D',          -- 지역구분        
                    @ps_divisioncode	 = 'H',          -- 공장코드  
                    @ps_applyfrom        = '2002.01.01', -- 납품요구일
                    @ps_applyfrom1       = '2002.12.31', -- 납품요구일
                    @ps_shipoemgubun     = '%',
                    @ps_date_std         = '1'           -- 일자기분 (1:납품일자,2:입력일)           
*/
CREATE PROCEDURE sp_piss461i_03
                    @ps_areacode         char(01),
                    @ps_divisioncode	 char(01),
                    @ps_applyfrom        char(10),
                    @ps_applyfrom1       char(10),
                    @ps_shipoemgubun     char(01),
                    @ps_date_std         char(01)
AS

BEGIN
  if @ps_date_std = '1'
     begin
        SELECT divisioncode  = a.divisioncode,
               SRNO          = a.checksrno,
               custcode      = c.custcode,
               custname      = e.custname,
               applyfrom     = c.applyfrom,
               shiporderqty  = sum(c.shipremainqty),
               shipgubun     = c.shipgubun,
               shipgubunname = d.shipgubunname,
               stcd      = 'N'
          from tsrcancel a,tmstitem b,tsrorder c,tmstshipgubun d,tmstcustomer e
         where a.areacode     = @ps_areacode
           and a.divisioncode = @ps_divisioncode
           and a.itemcode     *= b.itemcode
           and a.areacode     = c.areacode
           and a.divisioncode = c.divisioncode
           and a.srno         = substring(c.srno,1,len(c.srno) - 3)
           and a.confirmflag  = 'Y'           and c.shipgubun    = d.shipgubun
           and c.applyfrom    >= @ps_applyfrom
           and c.applyfrom   <= @ps_applyfrom1
           and d.shipoemgubun like @ps_shipoemgubun
           and c.custcode    *= e.custcode
          group by a.divisioncode,a.checksrno,c.custcode,e.custname,c.applyfrom,c.shipgubun,d.shipgubunname
     end  
  else
     begin
        SELECT divisioncode  = a.divisioncode,
               SRNO          = a.checksrno,
               custcode      = c.custcode,
               custname      = e.custname,
               applyfrom     = c.applyfrom,
               shiporderqty  = sum(c.shipremainqty),
               shipgubun     = c.shipgubun,
               shipgubunname = d.shipgubunname,
               stcd      = 'N'
          from tsrcancel a,tmstitem b,tsrorder c,tmstshipgubun d,tmstcustomer e
         where a.areacode     = @ps_areacode
           and a.divisioncode = @ps_divisioncode
           and a.itemcode     *= b.itemcode
           and a.areacode     = c.areacode
           and a.divisioncode = c.divisioncode
           and a.srno         = substring(c.srno,1,len(c.srno) - 3)
           and a.confirmflag  = 'Y'           and c.shipgubun    = d.shipgubun
           and a.canceldate  >= @ps_applyfrom
           and a.canceldate  <= @ps_applyfrom1
           and d.shipoemgubun like @ps_shipoemgubun
           and c.custcode    *= e.custcode
          group by a.divisioncode,a.checksrno,c.custcode,e.custname,c.applyfrom,c.shipgubun,d.shipgubunname
     end  

end 

GO
