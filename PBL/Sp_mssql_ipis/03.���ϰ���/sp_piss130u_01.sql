/*
	File Name	: sp_piss130u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss130i_01
	Description	: �����reading(Ʈ������)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss130u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss130u_01]
GO

/*
Exec sp_piss130u_01 @ps_shipplandate = '2002.10.09',
                    @ps_areacode     = 'D',
                    @ps_divisioncode = '%'
*/

Create Procedure sp_piss130u_01
	@ps_shipplandate		char(10),	-- ��ȹ����
	@ps_areacode            char(01),       -- ��������
        @ps_divisioncode        char(01)        -- �����ڵ� 
As
Begin
  SELECT DISTINCT ShipPlanDate = A.ShipPlanDate,   
         TruckOrder = A.TruckOrder  
    FROM TLOADPLAN  A
   WHERE (A.ShipPlanDate = @ps_shipplandate )
     and (A.DivisionCode like @ps_divisioncode )   
     and (A.AreaCode     = @ps_areacode)
     and (a.truckno is null)
Return

End		-- Procedure End


GO
