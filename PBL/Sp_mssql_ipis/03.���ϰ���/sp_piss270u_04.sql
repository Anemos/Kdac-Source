/*
	File Name	: sp_piss270u_04.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss270u_04_01
	Description	: �����ǥ���
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss270u_04]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss270u_04]
GO


/*
exec sp_piss270u_04 @ps_areacode     = 'D',                  -- ��������
                    @ps_divisioncode = 'S',                  -- �����ڵ�
	            @ps_shipdate     = '2002.11.08',         -- ������
	            @ps_shipsheetno  = '11111'               -- ��ǥ��ȣ
*/
CREATE PROCEDURE sp_piss270u_04
	@ps_areacode     char(01),        -- ��������
        @ps_divisioncode char(01),        -- �����ڵ�
	@ps_shipdate	 Char(10),        -- ������
	@ps_shipsheetno  Char(10)         -- ��ǥ��ȣ
AS

BEGIN

SELECT shipdate      = A.ShipDate,   
       areacode      = A.AreaCode,   
       divisioncode  = A.DivisionCode,   
       truckorder    = A.TruckOrder,   
       shipsheetno   = A.ShipSheetNo,   
       kbno          = A.KBNo,   
       kbreleasedate = A.KBReleaseDate,   
       kbreleaseseq  = A.KBReleaseSeq,   
       shipqty       = sum(A.ShipQty),
       custcode      = b.custcode,
       itemcode      = b.itemcode,
       shipgubun     = b.shipgubun
  FROM TSHIPKBHIS  a , tsrorder b
 where a.areacode     = @ps_areacode     
   and a.divisioncode = @ps_divisioncode 
   and a.shipdate     = @ps_shipdate	 
   and a.shipsheetno  = @ps_shipsheetno  
   and a.areacode     = b.areacode
   and a.divisioncode = b.divisioncode
   and a.srno         = b.srno
  group by A.ShipDate,   
           A.AreaCode,   
           A.DivisionCode,   
           A.TruckOrder,   
           A.ShipSheetNo,   
           A.KBNo,   
           A.KBReleaseDate,   
           A.KBReleaseSeq,   
           b.custcode,
           b.itemcode,
           b.shipgubun
end 

GO
