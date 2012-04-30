/*
	File Name	: sp_piss461i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss461i_01
	Description	: 출하요청서재출력
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss461i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss461i_01]
GO
/*
exec sp_piss461i_01 @ps_areacode         = 'D',          -- 지역구분        
                    @ps_divisioncode	 = 'H',          -- 공장코드  
                    @ps_applyfrom        = '2002.01.01', -- 납품요구일
                    @ps_applyfrom1       = '2002.12.31', -- 납품요구일
                    @ps_shipoemgubun     = '%',
                    @ps_date_std         = '2'           -- 일자기분 (1:납품일자,2:입력일)           
*/

Create Procedure sp_piss461i_01                    @ps_areacode         char(01),
                    @ps_divisioncode	 char(01),
                    @ps_applyfrom        char(10),
                    @ps_applyfrom1       char(10),
                    @ps_shipoemgubun     char(01),
                    @ps_date_std         char(01)

As
Begin
  if @ps_date_std = '1'
     begin
     SELECT divisioncode = a.divisioncode,
            SRNO      = a.checksrno,
            custcode  = a.custcode,
            custname  = b.custname,
            applyfrom = a.applyfrom,
            shiporderqty = sum(a.shiporderqty),
            shipgubun    = a.shipgubun,
            shipgubunname = c.shipgubunname,
            stcd      = 'N'
       FROM Tsrorder a,   
            Tmstcustomer b,   
            Tmstshipgubun c 
     WHERE (A.AreaCode = @ps_areacode)
       and (a.divisioncode like @ps_divisioncode)
       and (a.custcode *= b.custcode)
       and (a.shipgubun = c.shipgubun)
       and (c.shipoemgubun like @ps_shipoemgubun)
       and (a.stcd = 'Y')
--     and a.srcancelgubun  = 'N'
--     and a.shipendgubun   = 'N'
       and (a.kitgubun      = 'N' or (a.kitgubun = 'Y' and a.pcgubun = 'P'))
--     and (a.shiporderqty  = a.shipremainqty)
       and (a.applyfrom    >= @ps_applyfrom)
       and (a.applyfrom    <= @ps_applyfrom1)
     group by a.divisioncode,a.checksrno,a.custcode,b.custname,a.shipgubun,c.shipgubunname,a.stcd,a.applyfrom
     order by a.custcode,a.applyfrom,a.checksrno
     end 
else
     begin
     SELECT divisioncode = a.divisioncode,
            SRNO      = a.checksrno,
            custcode  = a.custcode,
            custname  = b.custname,
            applyfrom = a.applyfrom,
            shiporderqty = sum(a.shiporderqty),
            shipgubun    = a.shipgubun,
            shipgubunname = c.shipgubunname,
            stcd      = 'N'
       FROM Tsrorder a,   
            Tmstcustomer b,   
            Tmstshipgubun c ,
            tsrheader d
     WHERE (A.AreaCode = @ps_areacode)
       and (a.divisioncode like @ps_divisioncode)
       and (a.custcode *= b.custcode)
       and (a.shipgubun = c.shipgubun)
       and (c.shipoemgubun like @ps_shipoemgubun)
       and (a.stcd = 'Y')
--     and a.srcancelgubun  = 'N'
--     and a.shipendgubun   = 'N'
       and (a.kitgubun      = 'N' or (a.kitgubun = 'Y' and a.pcgubun = 'P'))
--     and (a.shiporderqty  = a.shipremainqty)
       and a.checksrno      = d.checksrno
       and (d.inputdate    >= @ps_applyfrom)
       and (d.inputdate    <= @ps_applyfrom1)
     group by a.divisioncode,a.checksrno,a.custcode,b.custname,a.shipgubun,c.shipgubunname,a.stcd,a.applyfrom
     order by a.custcode,a.applyfrom,a.checksrno
     end 

end

GO
