/*
	File Name	: sp_piss440u_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss440u_02
	Description	: ��ǰ�԰�,��� ����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss440u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss440u_02]
GO
/*
exec sp_piss440u_02 @ps_areacode         = 'D',           -- ��������        
                    @ps_divisioncode	 = 'S',           -- �����ڵ�  
                    @ps_proofno          = '11111'        -- ��������ȣ
*/

Create Procedure sp_piss440u_02                    @ps_areacode         char(01),
                    @ps_divisioncode	 char(01),
                    @ps_proofno          varchar(12)

As
Begin
  SELECT areacode     = A.AreaCode,   
         divisioncode = A.DivisionCode,   
         inputdate    = A.InputDate,   
         inputflag    = A.InputFlag,   
         proofno      = A.ProofNo,   
         deptcode     = A.DeptCode,  
         deptname     = B.deptname, 
         itemcode     = A.ItemCode,
         itemname     = c.itemname, 
         inputqty     = A.InputQty
    FROM TSTOCKETC A,tmstdept b,tmstitem c
   where a.areacode = @ps_areacode
     and a.divisioncode like @ps_divisioncode
     and a.proofno   = @ps_proofno
     and a.deptcode  = b.deptcode
     and a.itemcode  = c.itemcode
end

GO
