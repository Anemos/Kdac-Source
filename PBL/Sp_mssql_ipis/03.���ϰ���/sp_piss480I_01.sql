/*
	File Name	: sp_piss480i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss480u_01
	Description	: ����SRȮ��(���������Ͽ�û��)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss480i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss480i_01]
GO


/*
exec sp_piss480i_01 @ps_areacode     = 'D',          -- ��������
                    @ps_divisioncode = 'A',          -- �����ڵ�
                    @ps_custgubun    = '%',          -- �ŷ�ó����
                    @ps_custcode     = '%',          -- �ŷ�ó�ڵ�
                    @ps_shipoemgubun = '%',          --���ϱ���
                    @ps_applyfrom   = '2002.12.10',  -- ������
                    @ps_productgroup = '%'           -- ��ǰ��
*/
CREATE PROCEDURE sp_piss480i_01
	@ps_areacode     char(01),        -- ��������
        @ps_divisioncode char(01),        -- �����ڵ�
        @ps_custgubun    char(01),        -- �ŷ�ó����
        @ps_custcode     varchar(06),     -- �ŷ�ó�ڵ�
        @ps_shipoemgubun char(01),        -- ���ϱ���
        @ps_applyfrom    char(10),        -- ������
        @ps_productgroup varchar(04)      -- ��ǰ��
AS
declare
       @ls_applyfrom1    char(10),
       @ls_applyfrom2    char(10),
       @ls_applyfrom3    char(10),
       @ls_applyfrom4    char(10),
       @ls_applyfrom5    char(10),
       @ls_applyfrom6    char(10),
       @ls_applyfrom7    char(10)
BEGIN

select top 1 @ls_applyfrom1 = convert(char(10),dateadd(day,1,convert(datetime,@ps_applyfrom)),102) from sysusers
select top 1 @ls_applyfrom2 = convert(char(10),dateadd(day,2,convert(datetime,@ps_applyfrom)),102) from sysusers
select top 1 @ls_applyfrom3 = convert(char(10),dateadd(day,3,convert(datetime,@ps_applyfrom)),102) from sysusers
select top 1 @ls_applyfrom4 = convert(char(10),dateadd(day,4,convert(datetime,@ps_applyfrom)),102) from sysusers
select top 1 @ls_applyfrom5 = convert(char(10),dateadd(day,5,convert(datetime,@ps_applyfrom)),102) from sysusers
select top 1 @ls_applyfrom6 = convert(char(10),dateadd(day,6,convert(datetime,@ps_applyfrom)),102) from sysusers
select top 1 @ls_applyfrom7 = convert(char(10),dateadd(day,7,convert(datetime,@ps_applyfrom)),102) from sysusers


select productgroup     = a.productgroup,
       productgroupname = a.productgroupname,
       itemcode         = b.itemcode,
       itemname         = case isnull(f.itemname,'') when '' then b.itemcode else f.itemname end,
       customeritemno   = b.customeritemno,
       qty1             = sum(case b.applyfrom when @ls_applyfrom1 then b.shipremainqty else 0 end),
       qty2             = sum(case b.applyfrom when @ls_applyfrom2 then b.shipremainqty else 0 end),
       qty3             = sum(case b.applyfrom when @ls_applyfrom3 then b.shipremainqty else 0 end),
       qty4             = sum(case b.applyfrom when @ls_applyfrom4 then b.shipremainqty else 0 end),
       qty5             = sum(case b.applyfrom when @ls_applyfrom5 then b.shipremainqty else 0 end),
       qty6             = sum(case b.applyfrom when @ls_applyfrom6 then b.shipremainqty else 0 end),
       qty7             = sum(case b.applyfrom when @ls_applyfrom7 then b.shipremainqty else 0 end),
       invqty           = e.invqty,
       qty8             = sum(case when b.applyfrom > @ls_applyfrom7 then b.shipremainqty else 0 end)
  from tsrorder b,tmstshipgubun c,tmstproductgroup a,tmstcustomer d,TINV E,tmstitem f,tmstmodel g
 where b.srareacode     = @ps_areacode
   and b.srdivisioncode = @ps_divisioncode
   and b.applyfrom      >= @ls_applyfrom1
--   and b.applyfrom      <= @ls_applyfrom7
--   and b.srcancelgubun  = 'N'
   and b.shipremainqty > 0
   and b.shipendgubun   = 'N'
   and b.custcode       like @ps_custcode
   and b.custcode       = d.custcode
   and d.custgubun      like @ps_custgubun
   and b.shipgubun      = c.shipgubun
   and c.shipoemgubun   like @ps_shipoemgubun
   and a.productgroup   like @ps_productgroup
   and (b.kitgubun      = 'N' or (b.kitgubun = 'Y' and b.pcgubun = 'C'))
   and b.areacode       = g.areacode
   and b.divisioncode   = g.divisioncode
   and b.itemcode       = g.itemcode
   and g.productgroup   = a.productgroup
   and b.areacode       = a.areacode
   and b.divisioncode   = a.divisioncode
   and b.itemcode       *= f.itemcode
   and b.shipremainqty  > 0 
   and b.stcd           = 'Y'
   and b.areacode       *= e.areAcode
   and b.divisioncode   *= e.divisioncode
   and b.itemcode       *= e.itemcode
group by a.productgroup,a.productgroupname,b.itemcode,f.itemname,b.customeritemno,e.invqty
 order by a.productgroup,b.itemcode

end 


GO
