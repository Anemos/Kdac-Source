/*
	File Name	: sp_piss230i_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss230i_02
	Description	: 월일별출하현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss230i_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss230i_02]
GO
/*
Exec sp_piss230i_02
        @ps_yymm         = '2002.09',
        @ps_areacode     = 'D',
	@ps_divisioncode = 'A',
        @ps_custgubun    = '%',
        @ps_custcode     = '%',
        @ps_productgroup = '%',
        @ps_modelgroup   = '%',
        @ps_itemcode     = '%'
*/
Create Procedure sp_piss230i_02
        @ps_yymm         char(07),        -- 출하년월
        @ps_areacode     char(01),    -- 지역구분
	@ps_divisioncode Char(01),    -- 공장구분
        @ps_custgubun    char(01),    -- 거래처구분
        @ps_custcode     varchar(06), -- 거래처코드
        @ps_productgroup varchar(02), -- 제품군
        @ps_modelgroup   varchar(03), -- 모델그룹
        @ps_itemcode     varchar(12)  -- 품번
        
As
Begin


select shipday = a.shipday,
       qty = sum(a.qty)
from
(select shipday = '01',
       qty = 0
union all
select shipday = '02',
       qty = 0
union all
select shipday = '03',
       qty = 0
union all
select shipday = '04',
       qty = 0
union all
select shipday = '05',
       qty = 0
union all
select shipday = '06',
       qty = 0
union all
select shipday = '07',
       qty = 0
union all
select shipday = '08',
       qty = 0
union all
select shipday = '09',
       qty = 0
union all
select shipday = '10',
       qty = 0
union all
select shipday = '11',
       qty = 0
union all
select shipday = '12',
       qty = 0
union all
select shipday = '13',
       qty = 0
union all
select shipday = '14',
       qty = 0
union all
select shipday = '15',
       qty = 0
union all
select shipday = '16',
       qty = 0
union all
select shipday = '17',
       qty = 0
union all
select shipday = '18',
       qty = 0
union all
select shipday = '19',
       qty = 0
union all
select shipday = '20',
       qty = 0
union all
select shipday = '21',
       qty = 0
union all
select shipday = '22',
       qty = 0
union all
select shipday = '23',
       qty = 0
union all
select shipday = '24',
       qty = 0
union all
select shipday = '25',
       qty = 0
union all
select shipday = '26',
       qty = 0
union all
select shipday = '27',
       qty = 0
union all
select shipday = '28',
       qty = 0
union all
select shipday = '29',
       qty = 0
union all
select shipday = '30',
       qty = 0
union all
select shipday = '31',
       qty = 0
union all
 SELECT shipday = substring(a.traceDate,9,2),
        qty = sum(isnull(a.shipqty,0))
   FROM tlotno a,
        tmstmodel b,
        tmstcustomer c
  WHERE a.tracedate    like @ps_yymm +'%'
    and a.areacode     = @ps_areacode
    and a.divisioncode like @ps_divisioncode
    and a.areacode     = b.areacode
    and a.divisioncode = b.divisioncode
    and a.custcode     = c.custcode
    and a.custcode     like @ps_custcode
    and c.custgubun    like @ps_custgubun
    and b.productgroup like @ps_productgroup
    and b.modelgroup   like @ps_modelgroup
    and a.itemcode     like @ps_itemcode
    and a.itemcode     = b.itemcode
group by substring(a.traceDate,9,2)) a
group by a.shipday
End

GO
