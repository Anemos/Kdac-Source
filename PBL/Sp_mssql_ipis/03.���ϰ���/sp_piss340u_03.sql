/*
	File Name	: sp_piss340u_03.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss340u_03
	Description	: 출하관리(군산)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss340u_03]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss340u_03]
GO
/*
exec sp_piss340u_01 @ps_areacode         = 'D',           -- 지역구분        
                    @ps_divisioncode	 = 'M',           -- 공장코드  
                    @ps_custcode         = 'L10500',      -- 거래처코드
                    @ps_shipgubun        = 'O',           -- 출하구분
                    @ps_FROMshipeditno       = 0,              -- 편수
                    @ps_TOshipeditno       = 99              -- 편수
*/

Create Procedure sp_piss340u_03                    @ps_areacode         char(01),
                    @ps_divisioncode	 char(01),
                    @ps_custcode         char(06),
                    @ps_shipgubun        char(01),
                    @ps_fromshipeditno   int,
                    @ps_toshipeditno     int

As
Begin
   select divisioncode = a.divisioncode,
          productgroup = a.productgroup,
          itemcode     = a.itemcode,
          customeritemno = a.customeritemno,
          itemname     = isnull(b.itemname,a.itemcode),
          srno         = a.srno,
          checksrno    = a.checksrno,
          shipeditno   = a.shipeditno,
          shipremainqty = a.shipremainqty,
          shipqty      = 0,
          todayinv     = isnull(c.invqty,0),
          shipsheetno  = '',
          applyfrom    = a.applyfrom,
          shipusage    = a.shipusage,
          custcode     = a.custcode,
          shipgubun    = a.shipgubun,
          psrno        = a.psrno,
          kitgubun     = a.kitgubun,
          pcgubun      = a.pcgubun
     from tsrorder a, tmstitem b,tinv c,tmstshipgubun d
    where a.areacode     =  @ps_areacode
      and a.divisioncode =  @ps_divisioncode
      and a.custcode     =  @ps_custcode
      and d.shipoemgubun =  @ps_shipgubun
      and a.shipeditno   >=  @ps_fromshipeditno
      and a.shipeditno   <=  @ps_toshipeditno
      and a.shipgubun    =  d.shipgubun
      and a.itemcode     *= b.itemcode
      and a.areacode     *= c.areacode
      and a.divisioncode *= c.divisioncode
      and a.itemcode     *= c.itemcode
      and a.shipremainqty > 0 
--      and a.srcancelgubun = 'N'
      AND A.shipendgubun  = 'N'
      and (a.kitgubun     = 'N' or (a.kitgubun = 'Y' and a.pcgubun = 'P'))
      and a.stcd = 'Y'
  order by a.divisioncode,
           a.productgroup,
           a.psrno,
           a.itemcode,a.pcgubun desc
end

GO
