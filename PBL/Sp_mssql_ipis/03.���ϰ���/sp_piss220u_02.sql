/*
	File Name	: sp_piss220u_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss220u_02
	Description	: BACKSHIP
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss220u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss220u_02]
GO


/*
exec sp_piss220u_02 @ps_gubun        = 'A',          -- 구분 (A:전체, B:의뢰완료,C:의뢰미완료)
                    @ps_areacode     = 'D',          -- 지역구분
                    @ps_divisioncode = 'A',          -- 공장코드
                    @ps_scustcd      = 'L16000',       -- 거래처코드
	            @ps_citno        = '%',          -- 거래처품번
                    @ps_fromrpdt     = '1',          -- from의뢰일자
                    @ps_torpdt       = 'z'           -- to의뢰일자
*/
CREATE PROCEDURE sp_piss220u_02
                    @ps_gubun        char(01),       -- 구분
	            @ps_areacode     char(01),       -- 지역구분
                    @ps_divisioncode char(01),       -- 공장코드
                    @ps_scustcd      char(06),        -- 거래처코드
	            @ps_citno        varchar(20),    -- 거래처품번
                    @ps_fromrpdt     char(10),       -- from의뢰일자
                    @ps_torpdt       char(10)        -- to의뢰일자
AS

BEGIN
if @ps_gubun =  'A'
   begin
         Select	 divisioncode   = A.div,
	         citno	        = A.citno,
		 itemcode       = A.itno,
		 itemname	= b.itemname,
		 csrno   	= a.csrno,
	      	 invoice	= a.invoice,
		 rpdt    	= a.rpdt,
		 cnlcd	        = a.cnlcd,
		 suse   	= a.suse,
		 cur    	= a.cur,
		 luprc    	= a.luprc,
	         rcqty          = a.rcqty,
	         normalqty      = a.normalqty,
	         repairqty      = a.repairqty,
	         defectqty      = a.defectqty,
                 stype          = a.stype
	   From	tshipback A,
		tmstitem B
	  where a.xplant = @ps_areacode
	    and a.div like @ps_divisioncode
	    and a.scustcd like @ps_scustcd
	    and a.rpdt >= @ps_fromrpdt
	    and a.rpdt <= @ps_torpdt
	    and a.citno like @ps_citno
	    and a.itno = b.itemcode
end
if @ps_gubun = 'B' 
   begin
         Select	 divisioncode   = A.div,
	         citno	        = A.citno,
		 itno           = A.itno,
		 itemname	= b.itemname,
		 csrno   	= a.csrno,
	      	 invoice	= a.invoice,
		 rpdt    	= a.rpdt,
		 cnlcd	        = a.cnlcd,
		 suse   	= a.suse,
		 cur    	= a.cur,
		 luprc    	= a.luprc,
	         rcqty          = a.rcqty,
	         normalqty      = a.normalqty,
	         repairqty      = a.repairqty,
	         defectqty      = a.defectqty,
                 stype          = a.stype
	   From	tshipback A,
		tmstitem B
	  where a.xplant = @ps_areacode
	    and a.div like @ps_divisioncode
	    and a.scustcd like @ps_scustcd
	    and a.rpdt >= @ps_fromrpdt
	    and a.rpdt <= @ps_torpdt
	    and a.citno like @ps_citno
	    and a.itno = b.itemcode
            and cancelconfirmdate is not null
end
if @ps_gubun = 'C' 
   begin
         Select	 divisioncode   = A.div,
	         citno	        = A.citno,
		 itno           = A.itno,
		 itemname	= b.itemname,
		 csrno   	= a.csrno,
	      	 invoice	= a.invoice,
		 rpdt    	= a.rpdt,
		 cnlcd	        = a.cnlcd,
		 suse   	= a.suse,
		 cur    	= a.cur,
		 luprc    	= a.luprc,
	         rcqty          = a.rcqty,
	         normalqty      = a.normalqty,
	         repairqty      = a.repairqty,
	         defectqty      = a.defectqty,
                 stype          = a.stype
	   From	tshipback A,
		tmstitem B
	  where a.xplant = @ps_areacode
	    and a.div like @ps_divisioncode
	    and a.scustcd like @ps_scustcd
	    and a.rpdt >= @ps_fromrpdt
	    and a.rpdt <= @ps_torpdt
	    and a.citno like @ps_citno
	    and a.itno = b.itemcode
            and cancelconfirmdate is null
  end
end 


GO
