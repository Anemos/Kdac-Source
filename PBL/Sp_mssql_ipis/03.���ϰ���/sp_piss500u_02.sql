/*
	File Name	: sp_piss500u_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss500u_02
	Description	: ��üȮ���ù������ڷ���ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss500u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss500u_02]
GO


/*
exec sp_piss500u_02 
     @ps_areacode = 'D',
     @ps_divisioncode = 'A'

*/
CREATE PROCEDURE sp_piss500u_02
            @ps_areacode     char(1),
            @ps_divisioncode char(1)
AS

BEGIN

select shipplandate = a.shipplandate,
       areacode     = a.areacode,
       divisioncode = a.divisioncode,
       fromareacode = a.fromareacode,
       fromdivisioncode = a.fromdivisioncode,
       srno             = a.srno,
       truckorder       = a.truckorder,
       truckno          = a.truckno,
       shipdate         = a.shipdate,
       truckloadqty     = a.truckloadqty,
       lastemp          = a.lastemp,
       itemcode         = a.itemcode
  from tshipinv a
 where a.areacode      = @ps_areacode
   and a.divisioncode  like @ps_divisioncode
   and sendflag        = 'N'
   and moveconfirmflag = 'Y'
   AND lastemp          = 'Y'
order by a.shipplandate

end 

GO
