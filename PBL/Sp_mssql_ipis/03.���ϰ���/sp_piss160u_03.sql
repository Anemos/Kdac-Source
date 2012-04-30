/*
	File Name	: sp_piss160u_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss160i_02
	Description	: ��������
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss160u_03]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss160u_03]
GO

/*
exec sp_piss160u_03 @ps_areacode     = 'D',          -- ��������
                    @ps_divisioncode = 'S',          -- �����ڵ�
                    @ps_shipsheetno  = 'DSA2110002',   -- �����ȣ
	            @ps_shipdate     = '2002.11.08'  -- ������
*/
CREATE PROCEDURE sp_piss160u_03
	@ps_areacode     char(01),        -- ��������
        @ps_divisioncode char(01),        -- �����ڵ�
        @ps_shipsheetno	 Char(10),        -- ��ǥ��ȣ
	@ps_shipdate	 Char(10)         -- ������
AS

BEGIN

Select	 ShipSheetNo	= A.ShipSheetNo,
	 SRNO	        = A.SRNo,
	 ShipQty	= sum(A.ShipQty),
	 remainQty	= sum(A.ShipQty)
   From	tshipsheet A
  Where	A.shipsheetno  = @ps_shipsheetno
    and	A.shipdate     = @ps_shipdate
    and A.areacode     = @ps_areacode
    and A.divisioncode = @ps_divisioncode
group by a.shipsheetno,a.srno
end 


GO
