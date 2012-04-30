/*
	File Name	: sp_piss070i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss420i_01
	Description	: �Ϻ�����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss070i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss070i_01]
GO


/*
Exec sp_piss070i_01 @ps_areacode       = 'D',
		    @ps_divisioncode   = 'A',
                    @ps_itemcode       = '511513'
*/

CREATE PROCEDURE sp_piss070i_01
              @ps_areacode            char(01),         --����
              @ps_divisioncode        char(01),         --����
              @ps_itemcode            char(12)          --ǰ��

AS

BEGIN

  SELECT ShipDate	= A.applyfrom,   
         SRNo		= A.checksrNo,
         ShipGubunName	= C.ShipGubunName,   
         CustName	= B.CustName,   
         ShipEditNo	= A.ShipEditNo,   
         ShipRemainQty	= A.ShipRemainQty,
         SrdivisionCode = A.DivisionCode,
         inputdate      = d.inputdate
    FROM TSRORDER A,   
         TMSTCUSTOMER B,   
         TMSTSHIPGUBUN C,
         tsrheader d
   WHERE (A.CustCode 	   *= B.CustCode) 
     and (A.ShipGubun 	   = C.ShipGubun)
     and (A.ItemCode 	   = @ps_itemcode) 
     and (A.SRAreaCode     = @ps_areacode)
     and (A.SRDivisionCode like @ps_divisioncode)
     and (a.checksrno      *= d.checksrno)
order by a.checksrno,d.inputdate,a.applyfrom
END 

GO
