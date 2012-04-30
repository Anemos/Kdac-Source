/*
	File Name	: sp_piss462i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss462i_01
	Description	: ǰ����SR��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss462i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss462i_01]
GO
/*
exec sp_piss462i_01 @ps_areacode         = 'D',          -- ��������        
                    @ps_divisioncode	 = 'H',          -- �����ڵ�  
                    @ps_applyfrom        = '2003.01.01', -- ��ǰ�䱸��
                    @ps_applyfrom1       = '2003.12.31', -- ��ǰ�䱸��
                    @ps_shipoemgubun     = '%',          -- ���ϱ���
                    @ps_itemcode         = '%',     -- ǰ���ڵ�
                    @ps_customeritemno   = '%',           -- �ŷ�óǰ��
                    @ps_productgroup     = '%'

*/

Create Procedure sp_piss462i_01                    @ps_areacode         char(01),
                    @ps_divisioncode	 char(01),
                    @ps_applyfrom        char(10),
                    @ps_applyfrom1       char(10),
                    @ps_shipoemgubun     char(01),
                    @ps_itemcode         varchar(20),
                    @ps_customeritemno   varchar(20),
                    @ps_productgroup     varchar(5)

As
Begin
  SELECT divisioncode  = a.divisioncode,
         checkSRNO     = a.checksrno,
         srno          = a.srno,
         custcode      = a.custcode,
         custname      = b.custname,
         applyfrom     = a.applyfrom,
         shiporderqty  = a.shiporderqty,
         shipqty       = a.shiporderqty - a.shipremainqty - a.cancelqty,
         shipremainqty = a.shipremainqty,
         shipgubun     = a.shipgubun,
         shipgubunname = c.shipgubunname,
         inputdate     = d.inputdate + ' ' + d.inputtime,
         itemcode      = a.itemcode,
         itemname      = e.itemname,
         customeritemno = a.customeritemno
    FROM Tsrorder a,   
         Tmstcustomer b,   
         Tmstshipgubun c,
         tsrheader d,
         tmstitem e,
         tmstmodel f
   WHERE (A.AreaCode      = @ps_areacode)
     and (a.divisioncode  like @ps_divisioncode)
     and (a.custcode      *= b.custcode)
     and (a.shipgubun     = c.shipgubun)
     and (c.shipoemgubun  like @ps_shipoemgubun)
     and a.itemcode       like @ps_itemcode
     and a.customeritemno like @ps_customeritemno
     and a.checksrno      *= d.checksrno
     and a.itemcode       *= e.itemcode
     and (a.stcd = 'Y')
--     and a.srcancelgubun  = 'N'
--     and a.shipendgubun   = 'N'
--     and (a.kitgubun      = 'N' or (a.kitgubun = 'Y' and a.pcgubun = 'P'))
     and (a.applyfrom    >= @ps_applyfrom)
     and (a.applyfrom    <= @ps_applyfrom1)
     and (a.areacode     = f.areacode)
     and (a.divisioncode = f.divisioncode)
     and (a.itemcode     = f.itemcode)
     and f.productgroup  like @ps_productgroup

end

GO
