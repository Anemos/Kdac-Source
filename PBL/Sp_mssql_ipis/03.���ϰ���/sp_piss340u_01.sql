/*
	File Name	: sp_piss340u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss340u_01
	Description	: ���ϰ���(����)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss340u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss340u_01]
GO
/*
exec sp_piss340u_01 @ps_areacode         = 'Y',           -- ��������        
                    @ps_divisioncode	 = 'Y',           -- �����ڵ�  
                    @ps_custcode         = 'L10500',      -- �ŷ�ó�ڵ�
                    @ps_shipgubun        = 'K',           -- ���ϱ���
                    @ps_shipeditno       = 1              -- ���
*/

Create Procedure sp_piss340u_01                    @ps_areacode         char(01),
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
           a.itemcode
end

GO
