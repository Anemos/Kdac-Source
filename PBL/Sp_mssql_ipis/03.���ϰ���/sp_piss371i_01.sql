/*
	File Name	: sp_piss371i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss371i_01
	Description	: �԰���Ȳ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss371i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss371i_01]
GO
/*
exec sp_piss371i_01 @ps_areacode         = 'D',               -- ��������        
                    @ps_divisioncode	 = '%',               -- �����ڵ�  
                    @ps_fromdate         = '2001.01.01',      -- from�԰�����
                    @ps_todate           = '2003.01.01'      -- to�԰�����
*/

Create Procedure sp_piss371i_01                 @ps_areacode         char(01),
                 @ps_divisioncode     char(01),
                 @ps_fromdate         char(10),
                 @ps_todate           char(10)

As
Begin
SELECT   divisioncode   = a.DivisionCode,   
         workcenter     = a.WorkCenter + a.linecode,   
         linefullname   = d.linefullname,
         itemcode       = a.itemcode,
         itemspec       = c.itemspec,
         rackcode       = b.rackcode,
         stockloacation = b.stocklocation,
         kbcount        = 1,
         kbno           = a.KBNo,   
         stockqty       = a.stockqty
    FROM TKBHIS a,tmstkb b,tmstitem c,tmstline d
   where a.areacode     = @ps_areacode
     and a.divisioncode like @ps_divisioncode
     and a.stockdate    >= @ps_fromdate
     and a.stockdate    <= @ps_todate  
     and a.areacode     *= b.areacode
     and a.divisioncode *= b.divisioncode
     and a.itemcode     *= b.itemcode
     and a.itemcode     =  c.itemcode
     and a.areacode     *= d.areacode
     and a.divisioncode *= d.divisioncode
     and a.workcenter   *= d.workcenter
     and a.linecode     *= d.linecode
end


GO
