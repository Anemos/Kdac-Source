/*
	File Name	: sp_piss240i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss240u_01
	Description	: �����μ�Ȯ��
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss240u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss240u_01]
GO
/*
exec sp_piss240u_01  @ps_shipdate     = '2002.09.24', -- ��������
                     @ps_areacode     = 'D',          -- ��������
                     @ps_divisioncode = 'A',          -- �����ڵ�
                     @ps_truckno      = '1234'        -- ������ȣ

*/
CREATE PROCEDURE sp_piss240u_01
        @ps_shipdate     char(10),        -- ��������
	@ps_areacode     char(01),        -- ��������
        @ps_divisioncode char(01),        -- �����ڵ�
        @ps_truckno	 varChar(12)         -- ������ȣ
AS

BEGIN

Select	 distinct shipsheetno	= A.ShipSheetNo,
	 custcode       = A.custcode,
	 custname	= C.custname,
         printcount     = case when a.printcount > 0 then 1
                          else 0 end,
         confirmflag    = a.confirmflag,
         divisioncode   = a.divisioncode,
         truckorder     = a.truckorder,
         shipdate       = a.shipdate   
   From	tshipsheet A,
	tsrorder B,
	tmstcustomer C
  Where	A.SRNo 	       = B.SRNo
    and B.CustCode     = C.CustCode
    and A.areacode     = @ps_areacode
    and A.divisioncode like @ps_divisioncode
    and a.confirmflag  = 'N'
    and a.truckno      = @ps_truckno
--    and a.shipdate     = @ps_shipdate

end 

GO
