/*
	File Name	: sp_piss170i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss170i_01
	Description	: 출하현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17 
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss170i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss170i_01]
GO

/*
exec sp_piss170i_01
        @ps_areacode    = 'D',
        @ps_divisioncode = 'A',
        @ps_fromdate	= '2002.12.23',
	@ps_enddate	= '2002.12.23',
	@ps_productgroup = '%',
        @ps_modelgroup   = '%',
	@ps_itemcode	 = '%',
        @ps_shipoemgubun = '%'

*/

Create Procedure sp_piss170i_01
        @ps_areacode     char(01),
        @ps_divisioncode Char(1), 
        @ps_fromdate     Char(10),
        @ps_enddate      Char(10),
        @ps_productgroup varchar(02),
        @ps_modelgroup   varchar(03),
	@ps_itemcode     Varchar(12),
        @ps_shipoemgubun char(01)        

As
Begin
select areacode,divisioncode,itemcode,sortorder,productgroup,modelgroup,modelid
  into #tmp_vmstmodel
  from vmstmodel
 where areacode = @ps_areacode
   and divisioncode like @ps_divisioncode

        
select shipdate   = b.shipdate,
       truckorder = b.truckorder,
       truckno    = b.truckno,
       itemcode   = c.itemcode,
       itemname   = e.itemname,
       modelid    = d.modelid,
       shipqty    = SUM(b.shipqty),
       sortorder  = d.sortorder,
       custcode   = b.custcode,
       custname   = f.custname,
       shipusage  = c.shipusage,
       shipgubun  = c.shipgubun,
       shipgubunname = g.shipgubunname
  from tshipsheet b,tsrorder c,#tmp_vmstmodel d,tmstitem e,tmstcustomer f,tmstshipgubun g
 where b.areacode     = @ps_areacode
   and b.divisioncode like @ps_divisioncode
   and b.shipdate     >= @ps_fromdate
   and b.shipdate     <= @ps_enddate
   and c.itemcode     like @ps_itemcode
   and b.srno         = c.srno
   and b.areacode     = c.areacode
   and b.divisioncode = c.divisioncode
   and b.areacode     *= d.areacode
   and b.divisioncode *= d.divisioncode
   and c.itemcode     *= d.itemcode
   and isnull(d.productgroup,'%') like @ps_productgroup
   and isnull(d.modelgroup,'%')   like @ps_modelgroup
   AND b.truckno      is not null
   and (c.kitgubun = 'N' or (c.kitgubun = 'Y' and c.pcgubun = 'C'))
   and c.itemcode   = e.itemcode
   and c.custcode   = f.custcode
   and c.shipgubun  = g.shipgubun
   and g.shipoemgubun like @ps_shipoemgubun
group by b.shipdate,
       b.truckorder,
       b.truckno,
       c.itemcode,
       e.itemname,
       d.modelid,
       d.sortorder,
       b.custcode,
       f.custname,
       c.shipusage,c.shipgubun,g.shipgubunname
drop table #tmp_vmstmodel
End


GO
