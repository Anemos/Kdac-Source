/*
	File Name	: sp_piss460u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss460u_01
	Description	: 생관SR확정
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss460u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss460u_01]
GO
/*
exec sp_piss460u_01 @ps_areacode         = 'D',           -- 지역구분        
                    @ps_divisioncode	 = 'H'           -- 공장코드  
*/

Create Procedure sp_piss460u_01                    @ps_areacode         char(01),
                    @ps_divisioncode	 char(01)

As
Begin
  SELECT divisioncode = a.divisioncode,
         SRNO      = a.checksrno,
         custcode  = a.custcode,
         custname  = b.custname,
         applyfrom = d.shipdate,
         shiporderqty = sum(a.shiporderqty),
         shipgubun    = a.shipgubun,
         shipgubunname = c.shipgubunname,
         stcd      = A.stcd
    FROM Tsrorder a,   
         Tmstcustomer b,   
         Tmstshipgubun c,
         tsrheader d 
   WHERE (A.AreaCode = @ps_areacode)
     and (a.divisioncode like @ps_divisioncode)
     and (a.custcode *= b.custcode)
     and (a.shipgubun = c.shipgubun)
     and (a.stcd = 'N')
     and a.srcancelgubun  = 'N'
     and a.shipendgubun   = 'N'
     and (a.kitgubun      = 'N' or (a.kitgubun = 'Y' and a.pcgubun = 'P'))
     and (a.shiporderqty  = a.shipremainqty)
     and (a.checksrno *= d.checksrno)
group by a.divisioncode,a.checksrno,a.custcode,b.custname,a.shipgubun,c.shipgubunname,a.stcd,d.shipdate
end

GO
