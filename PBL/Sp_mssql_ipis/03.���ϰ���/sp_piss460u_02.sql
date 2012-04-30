/*
	File Name	: sp_piss460u_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss460u_02
	Description	: ����SRȮ��
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss460u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss460u_02]
GO


/*
exec sp_piss460u_02 @ps_areacode     = 'D',          -- ��������
                    @ps_divisioncode = 'S',          -- �����ڵ�
                    @ps_custcode     = 'L10500',        -- �ŷ�ó
                    @ps_checksrno    = ''

*/
CREATE PROCEDURE sp_piss460u_02
	@ps_areacode     char(01),        -- ��������
        @ps_divisioncode char(01),        -- �����ڵ�
	@ps_custcode	 Char(06),        -- �ŷ�ó
        @ps_checksrno    varchar(11)      -- SR��ȣ
AS

BEGIN

select checksrno     = b.checksrno,
       srno          = b.srno,
       itemcode      = b.itemcode,
       itemname      = isnull(c.itemname,b.itemcode),
       shiporderqty  = b.shiporderqty,
       srcancelgubun = b.srcancelgubun,
       pcgubun       = b.pcgubun,
       kitgubun      = b.kitgubun
  from tsrorder b,tmstitem c
 where b.srareacode     = @ps_areacode
   and b.srdivisioncode = @ps_divisioncode
   and b.custcode       = @ps_custcode
   and b.itemcode       *= c.itemcode
--   and b.srcancelgubun  = 'N'
--   and b.shipendgubun   = 'N'
   and (b.kitgubun      = 'N' or (b.kitgubun = 'Y' and pcgubun = 'P'))
--   and (b.shiporderqty  = b.shipremainqty)
   and (b.checksrno     = @ps_checksrno)
 order by b.checksrno

end 


GO
