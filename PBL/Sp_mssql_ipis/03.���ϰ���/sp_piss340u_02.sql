/*
	File Name	: sp_piss340u_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss340u_02
	Description	: ���ϰ���(����ó��,��ü)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss340u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss340u_02]
GO
/*
exec sp_piss340u_02 @ps_areacode         = 'Y',           -- ��������        
                    @ps_divisioncode	 = 'Y',           -- �����ڵ�  
                    @ps_custcode         = 'L10500',      -- �ŷ�ó�ڵ�
                    @ps_shipgubun        = 'X',           -- ���ϱ���
                    @ps_shipeditno       = 0,              -- ���
                    @ps_toshipeditno     = 0              -- ���
*/

Create Procedure sp_piss340u_02                    @ps_areacode         char(01),
                    @ps_divisioncode	 char(01),
                    @ps_custcode         char(06),
                    @ps_shipgubun        char(01),
                    @ps_shipeditno       int,
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
          custcode     = a.moveareacode+a.movedivisioncode,
          shipgubun    = a.shipgubun,
          psrno        = a.psrno,
          kitgubun     = a.kitgubun,
          pcgubun      = a.pcgubun
     from tsrorder a, tmstitem b,tinv c,tmstshipgubun d
    where a.areacode     =  @ps_areacode
      and a.divisioncode =  @ps_divisioncode
      and d.shipoemgubun     =  @ps_shipgubun
      and a.shipeditno       >=  @ps_shipeditno
      and a.shipeditno       <=  @ps_toshipeditno
      and a.shipgubun        =  d.shipgubun
      and a.itemcode         *= b.itemcode
      and a.moveareacode     *= c.areacode
      and a.movedivisioncode *= c.divisioncode
      and a.itemcode         *= c.itemcode
      and a.shipremainqty > 0 
--      and a.srcancelgubun = 'N'
      and a.shipendgubun  = 'N'
      and (a.kitgubun     = 'N' or (a.kitgubun = 'Y' and a.pcgubun = 'P'))
      and stcd = 'Y'
end

GO
