select * from tmstmodel where areacode ='D' and divisioncode ='A'
/*
	File Name	: sp_piss310i_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss310i_02
	Description	: ��ǰǥ�����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss310i_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss310i_02]
GO
/*
exec sp_piss310i_02 @ps_areacode      = 'D',         -- ��������
                    @ps_divisioncode  = 'A',         -- �����ڵ�
	            @ps_kbno          = 'DAZ02100009'    -- ���ǹ�ȣ

*/
CREATE PROCEDURE sp_piss310i_02
	@ps_areacode       char(01),  -- ��������
        @ps_divisioncode   char(01),  -- �����ڵ�
        @ps_kbno           char(11)   -- ���ݹ�ȣ
AS

BEGIN

 SELECT areacode     = a.areacode,
        areaname     = c.areaname,
        divisioncode = a.divisioncode,
        divisionname = d.divisionname,
        kbno         = A.kbno,
        itemcode     = a.itemcode,
        itemname     = case isnull(e.itemname,'') when '' then (select itemname from tmstitem where itemcode = a.itemcode) 
                                                  else e.itemname end ,
        modelid      = b.modelid,
        rackqty      = a.rackqty,
        kbstatuscode = case a.invgubunflag when 'N' then '��ǰ'
                                           when 'R' then '�����'
                                           when 'D' then '��ǰ'
                                           else ''
                       end ,
        RePrint      = 0
    FROM tkb   A,
	 vmstmodel B,
         tmstarea c,
         tmstdivision d,
         tmstitem e
   Where A.tempgubun = 'T'
     and A.AreaCode     = @ps_areacode
     and A.DivisionCode = @ps_divisioncode
     and A.kbno = @ps_kbno
     and a.areacode  *= b.areacode
     and a.divisioncode *= b.divisioncode
     and a.itemcode  *= b.itemcode
     and a.areacode = c.areacode
     and a.areacode = d.areacode
     and a.divisioncode = d.divisioncode
     and a.itemcode *= e.itemcode

end




GO
