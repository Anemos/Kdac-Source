/*
	File Name	: sp_piss220u_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss220u_02
	Description	: BACKSHIP
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss220u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss220u_02]
GO


/*
exec sp_piss220u_02 @ps_gubun        = 'A',          -- ���� (A:��ü, B:�ǷڿϷ�,C:�Ƿڹ̿Ϸ�)
                    @ps_areacode     = 'D',          -- ��������
                    @ps_divisioncode = 'A',          -- �����ڵ�
                    @ps_scustcd      = 'L16000',       -- �ŷ�ó�ڵ�
	            @ps_citno        = '%',          -- �ŷ�óǰ��
                    @ps_fromrpdt     = '1',          -- from�Ƿ�����
                    @ps_torpdt       = 'z'           -- to�Ƿ�����
*/
CREATE PROCEDURE sp_piss220u_02
                    @ps_gubun        char(01),       -- ����
	            @ps_areacode     char(01),       -- ��������
                    @ps_divisioncode char(01),       -- �����ڵ�
                    @ps_scustcd      char(06),        -- �ŷ�ó�ڵ�
	            @ps_citno        varchar(20),    -- �ŷ�óǰ��
                    @ps_fromrpdt     char(10),       -- from�Ƿ�����
                    @ps_torpdt       char(10)        -- to�Ƿ�����
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
