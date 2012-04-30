/*
	File Name	: sp_piss130u_03.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss130i_03
	Description	: �����reading(Ʈ������)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss130u_03]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss130u_03]
GO


/*
Exec sp_piss130u_03 @ps_shipplandate = '2002.10.31',
                    @ps_areacode     = 'D',
                    @ps_divisioncode = '%'
*/

Create Procedure sp_piss130u_03
	@ps_shipplandate	char(10),	-- ��ȹ����
	@ps_areacode            char(01),       -- ��������
        @ps_divisioncode        char(01)        -- �����ڵ� 
As
Begin
 SELECT divisioncode = A.divisioncode,
        Itemcode     = A.ItemCode,   
        loadqty	     = sum(A.truckloadqty),
        readingqty   = 0
    FROM TLOADPLAN A
   WHERE ( A.Areacode     = @ps_areacode) and
         ( A.ShipPlanDate = @ps_shipplandate ) AND  
         ( A.DivisionCode like @ps_divisioncode ) AND  
         ( A.TruckOrder = 1 )    
GROUP BY A.divisioncode,A.ItemCode   ;


End		-- Procedure End



GO
