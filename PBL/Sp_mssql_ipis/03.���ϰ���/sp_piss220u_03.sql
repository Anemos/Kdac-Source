/*
	File Name	: sp_piss220u_03.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss220u_03
	Description	: BACKSHIP
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss220u_03]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss220u_03]
GO


/*
exec sp_piss220u_03 @ps_areacode     = 'D',
                    @ps_divisioncode = 'S',
                    @ps_srno         = '2X0111'          -- 전산번호
*/
CREATE PROCEDURE sp_piss220u_03
                    @ps_areacode     char(01),
                    @ps_divisioncode char(01),
                    @ps_srno         char(11)       -- 전산번호

AS

BEGIN
  Select	 csrno    = a.csrno,
                 csrno1   = a.csrno1,
                 csrno2   = a.csrno2,
                 billno   = A.billno,
                 srno     = a.srno,
                 itemcode = a.itno,
	         cancelconfirmdate = a.cancelconfirmdate,
                 normalqty = a.normalqty,
                 repairqty = a.repairqty,
                 defectqty = a.defectqty,
                 rcqty     = a.rcqty
	   From	tshipback A
	  where a.xplant  = @ps_areacode
	    and a.div     = @ps_divisioncode
	    and a.csrno   = @ps_srno

end 

GO
