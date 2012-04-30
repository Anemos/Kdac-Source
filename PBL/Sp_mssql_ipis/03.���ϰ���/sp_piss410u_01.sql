/*
	File Name	: sp_piss410u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss410i_01
	Description	: ����SR���
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss410u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss410u_01]
GO


/*
exec sp_piss410u_01 @ps_areacode     = 'D',          -- ��������
                    @ps_divisioncode = 'S',          -- �����ڵ�
                    @ps_custcode     = 'L10500'        -- �ŷ�ó

*/
CREATE PROCEDURE sp_piss410u_01
	@ps_areacode     char(01),        -- ��������
        @ps_divisioncode char(01),        -- �����ڵ�
	@ps_custcode	 Char(06)         -- �ŷ�ó
AS

BEGIN

select distinct checksrno     = b.checksrno,
       shipgubun     = b.shipgubun,
       applyfrom     = b.applyfrom,
       shipgubunname = d.shipgubunname,
       srcancelgubun = b.srcancelgubun
 from tsrorder b,tmstitem c,tmstshipgubun d
where b.srareacode     = @ps_areacode
  and b.srdivisioncode = @ps_divisioncode
  and b.custcode       = @ps_custcode
  and b.checksrno not in (select distinct a.checksrno
                       from tsrorder a, tloadplan b
                      where a.srareacode      = @ps_areacode
	                and a.srdivisioncode  = @ps_divisioncode
                        and a.custcode        = @ps_custcode
	                and a.srno            *= b.srno
	                and a.srareacode      *= b.areacode
	                and a.srdivisioncode  *= b.divisioncode
		        and a.shiporderqty    <> a.shipremainqty
--			and a.srcancelgubun   = 'N'
--                      and a.shipendgubun    = 'N'
                        and b.truckno is null)
  and b.itemcode     *= c.itemcode
  and b.shiporderqty = b.shipremainqty
  and b.srcancelgubun  = 'N'
  and b.shipendgubun   = 'N'
  and (b.kitgubun = 'N' or (b.kitgubun = 'Y' and pcgubun = 'P'))
  and (b.shiporderqty = b.shipremainqty)
  and b.shipgubun = d.shipgubun
order by b.checksrno

end 


GO
