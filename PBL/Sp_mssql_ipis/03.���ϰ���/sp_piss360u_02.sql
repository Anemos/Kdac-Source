/*
	File Name	: sp_piss360u_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss010i_01
	Description	: ��ǰǥ���
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss360u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss360u_02]
GO
/*
exec sp_piss360u_02 @ps_areacode         = 'D',          -- ��������        
                    @ps_divisioncode	 = 'A',          -- �����ڵ�  
                    @ps_itemcode         = '511513'      -- ǰ���ڵ�
*/

Create Procedure sp_piss360u_02                    @ps_areacode         char(01),
                    @ps_divisioncode	 char(01),
                    @ps_itemcode         char(12)

As
Begin
   select kbno = a.kbno,
          itemcode = a.itemcode,
          itemname = b.itemname,
          currentqty = a.currentqty,
          cancelqty = 0
     from tkb a,tmstitem b
    where a.areacode = @ps_areacode
      and a.divisioncode = @ps_divisioncode
      and a.itemcode = @ps_itemcode
      and kbstatuscode = 'D'
      and currentqty > 0 
      and substring(kbno,3,1) = 'Z'
end


GO
