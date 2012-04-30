/*
	File Name	: sp_piss390i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss390i_01
	Description	: �������������Ȳ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss390i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss390i_01]
GO
/*
Exec sp_piss390i_01
        @ps_areacode     = 'D',
	@ps_divisioncode = 'M',
	@ps_productgroup = '%',
	@ps_modelgroup   = '%'
*/

Create Procedure sp_piss390i_01
        @ps_areacode     char(01),      -- ��������
	@ps_divisioncode Char(01),	-- ���屸��
	@ps_productgroup varchar(03),	-- ��ǰ�� 
	@ps_modelgroup   varchar(05)	-- �𵨱� 
As
Begin

SELECT divisioncode = A.divisioncode,
       itemcode = a.itemcode,
       itemname = b.itemname,
       modelid = b.modelid,
       SrotOrder = b.SortOrder,
       sheetinv = a.sheetinv,
       moveinv = a.moveinv,
       todayinv = a.todayinv
from vmstmodel b,
(Select areacode = b.areacode,
        divisioncode        = b.divisioncode,
        ItemCode            = B.ItemCode,
        sheetinv            = sum(isnull(B.invqty,0) + isnull(B.repairqty,0) + isnull(B.shipinvqty,0)),
	moveinv             = sum(isnull(B.shipinvqty,0)),
	todayinv            = sum(isnull(B.invqty,0) + isnull(B.repairqty,0))
from  Tinv b
where B.areacode = @ps_areacode
  and B.divisioncode like @ps_divisioncode
  and b.shipinvqty > 0
group by b.areacode,b.divisioncode,B.itemcode) A
where a.areacode = b.areacode
  and a.divisioncode = b.divisioncode
  and a.itemcode = b.itemcode
  and a.areacode = @ps_areacode
  and a.divisioncode = @ps_divisioncode
  and b.productgroup like @ps_productgroup
  and b.modelgroup   like @ps_modelgroup

End

GO
