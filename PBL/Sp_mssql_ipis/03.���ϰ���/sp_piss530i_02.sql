drop procedure sp_piss530i_02
go
/*
exec sp_piss530i_02 @ps_srno          = 'J'         -- SR��ȣ

*/
CREATE PROCEDURE sp_piss530i_02
	@ps_srno           varchar(11)   -- �����ȣ

AS

BEGIN

 SELECT shipsheetno    = A.shipsheetno,
        shipdate       = a.shipdate,
        shipqty        = a.shipqty,
        sheetprintdate = a.sheetprintdate,
        confirmdate    = a.confirmdate,
        saleconfirmdate = a.saleconfirmdate,
        truckno         = a.truckno
   FROM tshipsheet A
  Where A.srno = @ps_srno
 order by a.shipdate,a.shipsheetno
end

GO
