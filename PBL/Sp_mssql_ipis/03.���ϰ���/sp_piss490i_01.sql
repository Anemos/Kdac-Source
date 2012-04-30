/*
	File Name	: sp_piss490i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss490u_01
	Description	: 월간출하요청서
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss490i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss490i_01]
GO


/*
exec sp_piss490i_01 @ps_areacode     = 'D',          -- 지역구분
                    @ps_divisioncode = 'A',          -- 공장코드
                    @ps_applyfrom   = '2002.10'  -- 기준일


*/
CREATE PROCEDURE sp_piss490i_01
	@ps_areacode     char(01),        -- 지역구분
        @ps_divisioncode char(01),        -- 공장코드
        @ps_applyfrom    char(07)         -- 기준일
AS
BEGIN


select inputdate = b.inputdate,
       qty1      = sum(case substring(a.applyfrom,9,2) when '01' then a.shiporderqty else 0 end),
       qty2      = sum(case substring(a.applyfrom,9,2) when '02' then a.shiporderqty else 0 end),
       qty3      = sum(case substring(a.applyfrom,9,2) when '03' then a.shiporderqty else 0 end),
       qty4      = sum(case substring(a.applyfrom,9,2) when '04' then a.shiporderqty else 0 end),
       qty5      = sum(case substring(a.applyfrom,9,2) when '05' then a.shiporderqty else 0 end),
       qty6      = sum(case substring(a.applyfrom,9,2) when '06' then a.shiporderqty else 0 end),
       qty7      = sum(case substring(a.applyfrom,9,2) when '07' then a.shiporderqty else 0 end),
       qty8      = sum(case substring(a.applyfrom,9,2) when '08' then a.shiporderqty else 0 end),
       qty9      = sum(case substring(a.applyfrom,9,2) when '09' then a.shiporderqty else 0 end),
       qty10     = sum(case substring(a.applyfrom,9,2) when '10' then a.shiporderqty else 0 end),
       qty11     = sum(case substring(a.applyfrom,9,2) when '11' then a.shiporderqty else 0 end),
       qty12     = sum(case substring(a.applyfrom,9,2) when '12' then a.shiporderqty else 0 end),
       qty13     = sum(case substring(a.applyfrom,9,2) when '13' then a.shiporderqty else 0 end),
       qty14     = sum(case substring(a.applyfrom,9,2) when '14' then a.shiporderqty else 0 end),
       qty15     = sum(case substring(a.applyfrom,9,2) when '15' then a.shiporderqty else 0 end),
       qty16     = sum(case substring(a.applyfrom,9,2) when '16' then a.shiporderqty else 0 end),
       qty17     = sum(case substring(a.applyfrom,9,2) when '17' then a.shiporderqty else 0 end),
       qty18     = sum(case substring(a.applyfrom,9,2) when '18' then a.shiporderqty else 0 end),
       qty19     = sum(case substring(a.applyfrom,9,2) when '19' then a.shiporderqty else 0 end),
       qty20     = sum(case substring(a.applyfrom,9,2) when '20' then a.shiporderqty else 0 end),
       qty21     = sum(case substring(a.applyfrom,9,2) when '21' then a.shiporderqty else 0 end),
       qty22     = sum(case substring(a.applyfrom,9,2) when '22' then a.shiporderqty else 0 end),
       qty23     = sum(case substring(a.applyfrom,9,2) when '23' then a.shiporderqty else 0 end),
       qty24     = sum(case substring(a.applyfrom,9,2) when '24' then a.shiporderqty else 0 end),
       qty25     = sum(case substring(a.applyfrom,9,2) when '25' then a.shiporderqty else 0 end),
       qty26     = sum(case substring(a.applyfrom,9,2) when '26' then a.shiporderqty else 0 end),
       qty27     = sum(case substring(a.applyfrom,9,2) when '27' then a.shiporderqty else 0 end),
       qty28     = sum(case substring(a.applyfrom,9,2) when '28' then a.shiporderqty else 0 end),
       qty29     = sum(case substring(a.applyfrom,9,2) when '29' then a.shiporderqty else 0 end),
       qty30     = sum(case substring(a.applyfrom,9,2) when '30' then a.shiporderqty else 0 end),
       qty31     = sum(case substring(a.applyfrom,9,2) when '31' then a.shiporderqty else 0 end)
  from tsrorder a,tsrheader b
 where a.srareacode     = @ps_areacode
   and a.srdivisioncode = @ps_divisioncode
   and a.applyfrom      like @ps_applyfrom+'%'
   and a.checksrno      = b.checksrno
   and a.shipremainqty > 0
--   and a.srcancelgubun  = 'N'
   and a.shipendgubun   = 'N'
   and (a.kitgubun      = 'N' or (a.kitgubun = 'Y' and a.pcgubun = 'P'))
   and a.stcd = 'Y'
group by b.inputdate
 order by b.inputdate

end 


GO
