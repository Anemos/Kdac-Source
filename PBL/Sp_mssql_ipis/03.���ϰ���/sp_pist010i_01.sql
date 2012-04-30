/*
	File Name	: sp_pist010i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pist010i_01
	Description	: ��ǰ�̷���ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pist010i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pist010i_01]
GO
/*
Exec sp_pist010i_01 @ps_areacode = 'D',               --����
                    @ps_divisioncode = '%',           --����
                    @ps_workcenter = '%',             --��
                    @ps_linecode ='%',                 --�����ڵ�
                    @ps_fromdate = '2000.01.01',      --������
	            @ps_todate	 = '2002.12.01'      --������
*/

CREATE PROCEDURE sp_pist010i_01
              @ps_areacode            char(01),       --����
              @ps_divisioncode        char(01),       --����
              @ps_workcenter          varchar(05),    --��
              @ps_linecode            char(01),       --�����ڵ�
              @ps_fromdate            char(10),
              @ps_todate              char(10)        
AS

BEGIN
  SELECT divisioncode = a.divisioncode,
         lotno = A.LotNo,
         itemcode = a.itemcode,
         itemname = case isnull(b.itemname,'') when '' then (select itemcode from tmstitem where itemcode = a.itemcode)
                                               else b.itemname
                    end,
	 modelid = b.ModelID,
	 sortorder = B.SortOrder,
         kbno = A.KBNo,
         rackqty = A.rackQty,
	 StatusCode	= A.kbStatusCode,
	 KBStatuscode = Case When A.kbStatusCode = 'D' Then 'â�����'
			     When A.kbStatusCode = 'E' Then '����'
			     When A.kbStatusCode = 'F' Then 'ȸ��'
			     Else Space(8)
			End
    FROM tkbhis A,   
         vmstmodel B
   WHERE (a.areacode = @ps_areacode)
     and (a.divisioncode like @ps_divisioncode)
     and (a.workcenter like @ps_workcenter)
     and (a.linecode   like @ps_linecode)
     and (a.areacode = b.areacode )
     and (a.divisioncode *= b.divisioncode)
     and (a.itemcode     *= b.itemcode)
     and (a.areacode     *= b.areacode)
     and (a.kbreleasedate >= @ps_fromdate)
     and (a.kbreleasedate <= @ps_todate)
     and (A.kbStockTime is Not Null)
     and (a.lotno is not null)
   
END 


GO
