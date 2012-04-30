/*
	File Name	: sp_piss250i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss250i_01
	Description	: �����μ�Ȯ����Ȳ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss250i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss250i_01]
GO
/*
exec sp_piss250i_01  @ps_shipdate     = '2002.11.18', -- ��������
                     @ps_areacode     = 'D'          -- ��������

*/
CREATE PROCEDURE sp_piss250i_01
        @ps_shipdate     char(10),        -- ��������
        @ps_shipdate1    char(10),        -- ��������
	@ps_areacode     char(01),        -- ����
        @ps_divisioncode char(01)         -- ����
AS

BEGIN

Select	 distinct truckno        = A.truckno,
         shipsheetno	= A.ShipSheetNo,
	 custcode       = A.custcode,
	 custname	= C.custname,
         confirmflag    = a.confirmflag,
         divisioncode   = a.divisioncode,
         divisionname   = d.divisionname,
         confirmdate    = a.confirmdate,
         lastemp        = a.lastemp 
   From	tshipsheet_tong A,
	tmstcustomer C,
        tmstdivision D
  Where	A.CustCode     *= C.CustCode
    and A.areacode     = @ps_areacode
    and A.divisioncode like @ps_divisioncode
    and a.shipdate     >= @ps_shipdate
    and a.shipdate     <= @ps_shipdate1
    and a.divisioncode = D.divisioncode
    and a.areacode     = D.areacode
end 


GO
