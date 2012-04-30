/*
	File Name	: sp_piss130u_04.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss130i_04
	Description	: �����reading(������ȹtotal����)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss130u_04]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss130u_04]
GO


/*
Exec sp_piss130u_04 @ps_shipplandate = '2002.10.09',
                    @ps_areacode     = 'D',
                    @ps_divisioncode = '%',
                    @pi_truckorder   = 1
*/

Create Procedure sp_piss130u_04
	@ps_shipplandate	char(10),	-- ��ȹ����
	@ps_areacode            char(01),       -- ��������
        @ps_divisioncode        char(01),       -- �����ڵ� 
        @pi_truckorder          int             -- ��������
As
Begin
 SELECT divisioncode = A.divisioncode,
        Itemcode     = A.ItemCode,   
        loadqty	     = sum(A.truckloadqty),
        readingqty   = 0
    FROM TLOADPLAN A,   
         tsrorder c
   WHERE ( A.Areacode     = @ps_areacode)
     and ( A.ShipPlanDate = @ps_shipplandate )
     and ( A.DivisionCode like @ps_divisioncode )
     and ( A.TruckOrder = @pi_truckorder )
     and ( a.areacode = c.areacode) 
     and ( a.divisioncode = c.divisioncode ) 
     and ( a.srno = c.srno)
     and ( c.kitgubun = 'N' or (c.kitgubun = 'Y' and c.pcgubun = 'C'))
     and ( c.stcd = 'Y')
     and (c.shipremainqty > 0)
     and ( c.shipendgubun <> 'Z')
GROUP BY A.divisioncode,A.ItemCode   

End		-- Procedure End


GO
