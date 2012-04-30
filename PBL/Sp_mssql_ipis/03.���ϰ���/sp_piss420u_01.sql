/*
	File Name	: sp_piss420i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss420i_01
	Description	: 영업SR취소확정
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss420u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss420u_01]
GO


/*
exec sp_piss420u_01 @ps_areacode     = 'D',          -- 지역구분
                    @ps_divisioncode = 'M',           -- 공장코드
                    @ps_cancelgubun  = '2'

*/
CREATE PROCEDURE sp_piss420u_01
	@ps_areacode     char(01),        -- 지역구분
        @ps_divisioncode char(01),        -- 공장코드
        @ps_cancelgubun  char(01)
AS

BEGIN

select divisioncode  = a.divisioncode,
       checksrno     = a.checksrno,
       srno          = a.srno,
       itemcode      = a.itemcode,
       itemname      = isnull(b.itemname,a.itemcode),
       shiporderqty  = c.shiporderqty,
       srcancelgubun = a.confirmflag,
       canceldate    = a.canceldate,
       cancelgubun   = a.cancelgubun,
       cuscode       = c.custcode,
       applyfrom     = c.applyfrom,
       CANCELQTY     = A.CANCELQTY
 from tsrcancel a,tmstitem b,tsrorder c
where a.areacode     = @ps_areacode
  and a.divisioncode = @ps_divisioncode
  and a.itemcode     *= b.itemcode
  and a.areacode     = c.areacode
  and a.divisioncode = c.divisioncode
  and a.srno         = substring(c.srno,1,len(c.srno) - 3)
  and a.confirmflag  = 'N'
  and a.cancelgubun  = @ps_cancelgubun 

end 

GO
