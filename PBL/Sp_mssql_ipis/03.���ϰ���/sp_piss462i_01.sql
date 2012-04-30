/*
	File Name	: sp_piss462i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss462i_01
	Description	: 품번별SR조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss462i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss462i_01]
GO
/*
exec sp_piss462i_01 @ps_areacode         = 'D',          -- 지역구분        
                    @ps_divisioncode	 = 'H',          -- 공장코드  
                    @ps_applyfrom        = '2003.01.01', -- 납품요구일
                    @ps_applyfrom1       = '2003.12.31', -- 납품요구일
                    @ps_shipoemgubun     = '%',          -- 출하구분
                    @ps_itemcode         = '%',     -- 품번코드
                    @ps_customeritemno   = '%',           -- 거래처품번
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
