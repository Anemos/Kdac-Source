/*
	File Name	: sp_piss380i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss120u_01
	Description	: 당일출하재고과부족현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss380i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss380i_01]
GO

/*
exec sp_piss380i_01 @ps_areacode     = 'D',          -- 지역구분
                    @ps_divisioncode = 'S',          -- 공장코드
	            @ps_shipdate     = '2002.10.31'  -- 출하일
*/
CREATE PROCEDURE sp_piss380i_01
	@ps_areacode     char(01),        -- 지역구분
        @ps_divisioncode char(01),        -- 공장코드
	@ps_shipdate	 Char(10)         -- 출하일
AS

BEGIN

SELECT DIVISONCODE = A.DIVISIONCODE,
       PRODUCTGROUP = C.PRODUCTGROUP,
       MODELGROUP = C.MODELGROUP,
       ITEMCODE = A.ITEMCODE,
       ITEMNAME = e.ITEMNAME,
       MODELID  = C.MODELID,
       TODAYINV = ISNULL(D.INVQty,0) + ISNULL(d.repairqty,0) ,
       TRUCKLOADQTY = SUM(ISNULL(A.TRUCKLOADQTY,0)),
       ORDERQTY  = ISNULL(B.ORDERQTY,0)
  FROM TLOADPLAN A,
       (SELECT DIVISIONCODE,ITEMCODE,ORDERQTY = SUM(RELEASEKBQTY)
          FROM TPLANRELEASE 
         WHERE AREACODE = @ps_areacode
           AND DIVISIONCODE LIKE @ps_divisioncode
           AND PLANDATE = @ps_shipdate
           AND PRDFLAG = 'N'
          GROUP BY DIVISIONCODE,ITEMCODE) B,
       VMSTMODEL C, TINV D,tmstitem e
 WHERE A.AREACODE     = @ps_areacode
   AND A.DIVISIONCODE LIKE @ps_divisioncode
   AND A.SHIPPLANDATE <= @ps_shipdate
   AND A.TRUCKNO IS NULL
   AND A.DIVISIONCODE *= B.DIVISIONCODE
   AND A.ITEMCODE     *= B.ITEMCODE
   AND A.AREACODE     *= C.AREACODE
   AND A.DIVISIONCODE *= C.DIVISIONCODE
   AND A.ITEMCODE     *= C.ITEMCODE
   AND A.AREACODE     *= D.AREACODE
   AND A.DIVISIONCODE *= D.DIVISIONCODE
   AND A.ITEMCODE     *= D.ITEMCODE
   and a.itemcode     =  e.itemcode
GROUP BY A.DIVISIONCODE,
         C.PRODUCTGROUP,
         C.MODELGROUP,
         A.ITEMCODE,
         e.ITEMNAME,
         C.MODELID,
         D.INVqty,
         d.repairqty,
         B.ORDERQTY

End

GO
