/*
	File Name	: sp_piss200i_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss200i_02
	Description	: ��ü�����Ȳ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss200i_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss200i_02]
GO

/*
Exec sp_piss200i_02
        @ps_areacode     = 'J',
	@ps_divisioncode = 'H',
	@ps_itemcode = '620324J'
*/

Create Procedure sp_piss200i_02
        @ps_areacode     char(01),      -- ��������
	@ps_divisioncode Char(01),	-- ���屸��
	@ps_itemcode     varchar(12)	-- ǰ��

As
Begin
Select shipplandate = a.shipplandate,
       truckorder   = a.truckorder,
       truckno      = a.truckno,
       fromareacode = a.fromareacode,
       fromdivisioncode = a.fromdivisioncode,
       movereuireno = a.moverequireno,
       truckloadqty = a.truckloadqty
from  Tshipinv a
where a.areacode = @ps_areacode
  and a.divisioncode = @ps_divisioncode
  and a.itemcode     = @ps_itemcode
  and a.moveconfirmdate is null
  and a.moveconfirmflag = 'Y'
  and a.sendflag = 'Y'
End

GO
