/*
	File Name	: sp_piss510u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss400u_01
	Description	: ��������Ȯ����Ȳ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss510i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss510i_01]
GO
/*
exec sp_piss510i_01 @ps_areacode         = 'D',          -- ��������
                    @ps_divisioncode     = '%',          -- �����ڵ�
	            @ps_shipdate         = '2002.10.30', -- from������
	            @ps_shipdate1        = '2002.12.30', -- to������
                    @ps_saleconfirmflag  = '%'           -- Ȯ�α���
*/
CREATE PROCEDURE sp_piss510i_01
	@ps_areacode        char(01),        -- ��������
        @ps_divisioncode    char(01),        -- �����ڵ�
	@ps_shipdate	    Char(10),        -- ������
	@ps_shipdate1       Char(10),        -- ������
        @ps_saleconfirmflag char(01)         -- Ȯ�α���
AS

BEGIN

Select	distinct divisioncode = A.divisioncode,
        shipdate              = a.shipdate,
        sheetprintdate        = convert(char(10),a.sheetprintdate,102),
        confirmdate           = convert(char(10),a.confirmdate,102),
        truckno               = a.truckno,
        saleconfirmflag       = case a.saleconfirmflag when 'Y' then 'Ȯ�οϷ�'
                                     else '��Ȯ��' end,
        saleconfirmdate       = convert(char(10),a.saleconfirmdate,102),                
        ShipSheetNo    = A.ShipSheetNo
   From	tshipsheet A
  Where	A.shipdate        >= @ps_shipdate
    and A.shipdate        <= @ps_shipdate1
    and A.areacode        = @ps_areacode
    and A.divisioncode    like @ps_divisioncode
    and A.saleconfirmflag like @ps_saleconfirmflag
    and a.confirmflag    = 'Y'
end 


GO
