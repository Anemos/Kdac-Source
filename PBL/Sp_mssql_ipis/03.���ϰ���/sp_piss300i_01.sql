/*
	File Name	: sp_piss300i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss300i_01
	Description	: 월일별출하현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss300i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss300i_01]
GO

/*
Exec sp_piss300i_01
        @ps_yy           = '2002',
        @ps_areacode     = 'D',
	@ps_divisioncode = '%',
        @ps_custgubun    = '%',
        @ps_custcode     = '%',
        @ps_productgroup = '%',
        @ps_modelgroup   = '%',
        @ps_itemcode     = '%'
*/
Create Procedure sp_piss300i_01
        @ps_yy           char(04),    -- 출하년
        @ps_areacode     char(01),    -- 지역구분
	@ps_divisioncode Char(01),    -- 공장구분
        @ps_custgubun    char(01),    -- 거래처구분
        @ps_custcode     varchar(06), -- 거래처코드
        @ps_productgroup varchar(02), -- 제품군
        @ps_modelgroup   varchar(03), -- 모델그룹
        @ps_itemcode     varchar(12)  -- 품번
        
As
Begin
select itemcode  = a.itemcode,
       itemname  = d.itemname,
       qty       = sum(z.qty),
       qty01     = sum(z.qty01),
       qty01     = sum(z.qty02),
       qty01     = sum(z.qty03),
       qty01     = sum(z.qty04),
       qty01     = sum(z.qty05),
       qty01     = sum(z.qty06),
       qty01     = sum(z.qty07),
       qty01     = sum(z.qty08),
       qty01     = sum(z.qty09),
       qty01     = sum(z.qty10),
       qty01     = sum(z.qty11),
       qty01     = sum(z.qty12)
  from (SELECT itemcode     = a.ItemCode,
             areacode     = a.areacode,
             divisioncode = a.divisioncode,
             qty   = sum(isnull(a.shipqty,0)),
             qty01 = sum(case substring(a.tracedate,6,2)
                    when '01'  then a.shipqty  else 0  end),
             qty02 = sum(case substring(a.tracedate,6,2)
                    when '02'  then a.shipqty  else 0  end),
             qty03 = sum(case substring(a.tracedate,6,2)
                    when '03'  then a.shipqty  else 0  end),
             qty04 = sum(case substring(a.tracedate,6,2)
                    when '04'  then a.shipqty  else 0  end),
             qty05 = sum(case substring(a.tracedate,6,2)
                    when '05'  then a.shipqty  else 0  end),
             qty06 = sum(case substring(a.tracedate,6,2)
                    when '06'  then a.shipqty  else 0  end),
             qty07 = sum(case substring(a.tracedate,6,2)
                    when '07'  then a.shipqty  else 0  end),
             qty08 = sum(case substring(a.tracedate,6,2)
                    when '08'  then a.shipqty  else 0  end),
             qty09 = sum(case substring(a.tracedate,6,2)
                    when '09'  then a.shipqty  else 0  end),
             qty10 = sum(case substring(a.tracedate,6,2)
                    when '10'  then a.shipqty  else 0  end),
             qty11 = sum(case substring(a.tracedate,6,2)
                    when '11'  then a.shipqty  else 0  end),
             qty12 = sum(case substring(a.tracedate,6,2)
                    when '12'  then a.shipqty  else 0  end)
        FROM tlotno a,tmstcustomer c
       WHERE a.tracedate like @ps_yy +'%'
         and a.areacode = @ps_areacode
         and a.divisioncode like @ps_divisioncode
         and a.custcode  = c.custcode
         and a.custcode like  @ps_custcode
         and c.custgubun like @ps_custgubun
       group by a.ItemCode,a.areacode,a.divisioncode) z,
     tmstmodel a,tmstitem d
 where a.areacode     = z.areacode
   and a.divisioncode = z.divisioncode
   and a.itemcode     = z.itemcode
   and a.productgroup like @ps_productgroup
   and a.modelgroup   like @ps_modelgroup
   and a.itemcode = d.itemcode
 group by a.itemcode,d.itemname

End

GO
