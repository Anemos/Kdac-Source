/*
	File Name	: sp_piss230i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss210i_01
	Description	: 월일별출하현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss230i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss230i_01]
GO

/*
Exec sp_piss230i_01
        @ps_yymm         = '2003.01',
        @ps_areacode     = 'Y',
	@ps_divisioncode = 'Y',
        @ps_custgubun    = '%',
        @ps_custcode     = '%',
        @ps_productgroup = '%',
        @ps_modelgroup   = '%',
        @ps_itemcode     = '878201Z'
*/
Create Procedure sp_piss230i_01
        @ps_yymm     char(07),        -- 출하년월
        @ps_areacode     char(01),    -- 지역구분
	@ps_divisioncode Char(01),    -- 공장구분
        @ps_custgubun    char(01),    -- 거래처구분
        @ps_custcode     varchar(06), -- 거래처코드
        @ps_productgroup varchar(02), -- 제품군
        @ps_modelgroup   varchar(03), -- 모델그룹
        @ps_itemcode     varchar(12)  -- 품번
        
As
Begin

select itemcode = a.itemcode,
       itemname = d.itemname,
       qty = z.qty,
       qty01 = z.qty01,
       qty02 = z.qty02,
       qty03 = z.qty03,
       qty04 = z.qty04,
       qty05 = z.qty05,
       qty06 = z.qty06,
       qty07 = z.qty07,
       qty08 = z.qty08,
       qty09 = z.qty09,
       qty10 = z.qty10,
       qty11 = z.qty11,
       qty12 = z.qty12,
       qty13 = z.qty13,
       qty14 = z.qty14,
       qty15 = z.qty15,
       qty16 = z.qty16,
       qty17 = z.qty17,
       qty18 = z.qty18,
       qty19 = z.qty19,
       qty20 = z.qty20,
       qty21 = z.qty21,
       qty22 = z.qty22,
       qty23 = z.qty23,
       qty24 = z.qty24,
       qty25 = z.qty25,
       qty26 = z.qty26,
       qty27 = z.qty27,
       qty28 = z.qty28,
       qty29 = z.qty29,
       qty30 = z.qty30,
       qty31 = z.qty31
  from tmstmodel a,tmstitem d,
 (SELECT a.ItemCode,
        a.divisioncode,
        qty   = sum(isnull(a.shipqty,0)),
        qty01 = sum(case substring(a.tracedate,9,2)
                    when '01'  then a.shipqty  else 0  end),
        qty02 = sum(case substring(a.tracedate,9,2)
                    when '02'  then a.shipqty  else 0  end),
        qty03 = sum(case substring(a.tracedate,9,2)
                    when '03'  then a.shipqty  else 0  end),
        qty04 = sum(case substring(a.tracedate,9,2)
                    when '04'  then a.shipqty  else 0  end),
        qty05 = sum(case substring(a.tracedate,9,2)
                    when '05'  then a.shipqty  else 0  end),
        qty06 = sum(case substring(a.tracedate,9,2)
                    when '06'  then a.shipqty  else 0  end),
        qty07 = sum(case substring(a.tracedate,9,2)
                    when '07'  then a.shipqty  else 0  end),
        qty08 = sum(case substring(a.tracedate,9,2)
                    when '08'  then a.shipqty  else 0  end),
        qty09 = sum(case substring(a.tracedate,9,2)
                    when '09'  then a.shipqty  else 0  end),
        qty10 = sum(case substring(a.tracedate,9,2)
                    when '10'  then a.shipqty  else 0  end),
        qty11 = sum(case substring(a.tracedate,9,2)
                    when '11'  then a.shipqty  else 0  end),
        qty12 = sum(case substring(a.tracedate,9,2)
                    when '12'  then a.shipqty  else 0  end),
        qty13 = sum(case substring(a.tracedate,9,2)
                    when '13'  then a.shipqty  else 0  end),
        qty14 = sum(case substring(a.tracedate,9,2)
                    when '14'  then a.shipqty  else 0  end),
        qty15 = sum(case substring(a.tracedate,9,2)
                    when '15'  then a.shipqty  else 0  end),
        qty16 = sum(case substring(a.tracedate,9,2)
                    when '16'  then a.shipqty  else 0  end),
        qty17 = sum(case substring(a.tracedate,9,2)
                    when '17'  then a.shipqty  else 0  end),
        qty18 = sum(case substring(a.tracedate,9,2)
                    when '18'  then a.shipqty  else 0  end),
        qty19 = sum(case substring(a.tracedate,9,2)
                    when '19'  then a.shipqty  else 0  end),
        qty20 = sum(case substring(a.tracedate,9,2)
                    when '20'  then a.shipqty  else 0  end),
        qty21 = sum(case substring(a.tracedate,9,2)
                    when '21'  then a.shipqty  else 0  end),
        qty22 = sum(case substring(a.tracedate,9,2)
                    when '22'  then a.shipqty  else 0  end),
        qty23 = sum(case substring(a.tracedate,9,2)
                    when '23'  then a.shipqty  else 0  end),
        qty24 = sum(case substring(a.tracedate,9,2)
                    when '24'  then a.shipqty  else 0  end),
        qty25 = sum(case substring(a.tracedate,9,2)
                    when '25'  then a.shipqty  else 0  end),
        qty26 = sum(case substring(a.tracedate,9,2)
                    when '26'  then a.shipqty  else 0  end),
        qty27 = sum(case substring(a.tracedate,9,2)
                    when '27'  then a.shipqty  else 0  end),
        qty28 = sum(case substring(a.tracedate,9,2)
                    when '28'  then a.shipqty  else 0  end),
        qty29 = sum(case substring(a.tracedate,9,2)
                    when '29'  then a.shipqty  else 0  end),
        qty30 = sum(case substring(a.tracedate,9,2)
                    when '30'  then a.shipqty  else 0  end),
        qty31 = sum(case substring(a.tracedate,9,2)
                    when '31'  then a.shipqty  else 0  end)
   FROM tlotno a,
        tmstcustomer c
  WHERE a.tracedate    like @ps_yymm +'%'
    and a.areacode     =    @ps_areacode
    and a.divisioncode like @ps_divisioncode
    and a.custcode     =    c.custcode
    and a.custcode     like @ps_custcode
    and c.custgubun    like @ps_custgubun
    and a.itemcode     like @ps_itemcode
group by a.ItemCode,a.divisioncode ) z
where a.areacode = @ps_areacode
  and a.divisioncode = z.divisioncode
  and a.itemcode = z.itemcode
  and a.itemcode = d.itemcode
  and a.productgroup like @ps_productgroup
  and a.modelgroup  like @ps_modelgroup
End

GO
