/*
	File Name	: sp_piss210i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss210i_01
	Description	: 납기준수율현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss210i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss210i_01]
GO
/*
Exec sp_piss210i_01
        @ps_fromdate     = '2002.01.01',
        @ps_todate       = '2002.12.01',
        @ps_areacode     = 'D',
	@ps_divisioncode = 'S'
*/

Create Procedure sp_piss210i_01
        @ps_fromdate     char(10),      -- 납기요구일
        @ps_todate       char(10),      -- 납기요구일
        @ps_areacode     char(01),      -- 지역구분
	@ps_divisioncode Char(01)	-- 공장구분
As
Begin

select shipdate  = a.shipdate,
       shipgubun = a.shipgubun,
       shipgubunname = b.shipgubunname,
       custcode  = a.custcode,
       custname  = c.custname,
       shiporderqty = sum(a.shiporderqty),
       shipqty      = sum(a.shipqty)
 from (Select shipdate      = a.applyfrom,
              shipgubun     = a.shipgubun,
              custcode      = a.custcode,
              shiporderqty   = sum(isnull(a.shiporderqty,0)),
              shipqty = 0
         from Tsrorder a
        where a.areacode = @ps_areacode
          and a.divisioncode like @ps_divisioncode
          and a.applyfrom  >= @ps_fromdate
          and a.applyfrom  <= @ps_todate
          and (a.kitgubun = 'N' or (a.kitgubun ='Y' and a.pcgubun = 'P'))
        group by a.applyfrom,a.shipgubun,a.custcode
       union all
       Select shipdate      = a.applyfrom,
              shipgubun     = a.shipgubun,
              custcode      = a.custcode,
              shiporderqty  = 0,
              shipqty       = sum(isnull(b.shipqty,0))
         from Tsrorder a,tshipsheet b
        where a.areacode = @ps_areacode
          and a.divisioncode like @ps_divisioncode
          and a.applyfrom >= @ps_fromdate
          and a.applyfrom <= @ps_todate
          and a.applyfrom = b.shipdate
          and a.areacode  = b.areacode
          and a.divisioncode = b.divisioncode
          and a.srno = b.srno
          and b.truckno is not null
          and (a.kitgubun = 'N' or (a.kitgubun ='Y' and a.pcgubun = 'P'))
        group by a.applyfrom,a.shipgubun,a.custcode) a,
       tmstshipgubun b, tmstcustomer c
 where a.shipgubun = b.shipgubun
   and a.custcode = c.custcode
 group by a.shipdate,a.shipgubun,b.shipgubunname,a.custcode,c.custname

End

GO
