/* ���� **********/
/* compile�ϴ� serer�� ������ linkedserver�� ������ */
/*
	File Name	: sp_piss_update_tinv.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss_update_tinv
	Description	: ��üȮ���� �ش� �������� ����Ÿ ����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 17
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss_update_tinv]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss_update_tinv]
GO

/*
Execute sp_piss_update_tinv
	@ps_areacode		= 'K',	         -- �Ƿ�����
	@ps_divisioncode	= 'P',	         -- �Ƿڰ���
	@ps_moveareacode	= 'D',	         -- ��������
	@ps_movedivisioncode	= 'M',	         -- �������
        @ps_shipplandate        = '2002.11.25',  -- ���ϰ�ȹ����
        @ps_srno                = '00026384P00', -- sr��ȣ
        @pl_truckorder          = 1,             -- ��������
        @ps_itemcode    	='09119-12004',  -- ǰ��
        @pl_shipqty             = 10,            -- Ȯ�μ���
	@ps_LastEmp             = 'ADMIN'        -- �����ȣ
*/

Create Procedure sp_piss_update_tinv
	@ps_areacode		char(1),	-- �Ƿ�����
	@ps_divisioncode	char(1),	-- �Ƿڰ���
	@ps_moveareacode	char(1),	-- ��������
	@ps_movedivisioncode	char(1),	-- �������
        @ps_shipplandate        char(10),       -- ���ϰ�ȹ����
        @ps_srno                varchar(12),    -- sr��ȣ
        @pl_truckorder          smallint,       -- ��������
        @ps_itemcode    	varchar(12),    -- ǰ��
        @pl_shipqty             int,       -- Ȯ�μ���
	@ps_LastEmp             char(6)         -- �����ȣ
        
As

Declare	@ll_tshipinv_count      smallint,
        @ll_tinv_count          smallint,
        @ll_error               smallint

Begin
   set xact_abort on
   set @ll_tshipinv_count    = 0
   set @ll_tinv_count        = 0
   set @ll_error = 9
   if @ps_moveareacode = 'D' and (@ps_movedivisioncode = 'M' or @ps_movedivisioncode = 'S') --�뱸 ����,����
      begin
         select @ll_tinv_count = count(*) 
           from [IPISMAC_SVR\ipis].ipis.DBO.TINV
          where AreaCode     = @ps_moveareacode
            and divisioncode = @ps_movedivisioncode
            and itemcode     = @ps_itemcode
/*         select @ll_tshipinv_count = count(*)
           from [IPISmac_SVR\ipis].ipis.DBO.TSHIPINV
          where ShipPlanDate     = @ps_shipplandate
            and AreaCode         = @ps_moveareacode
            and divisioncode     = @ps_movedivisioncode
            and srno             = @ps_srno
            and truckorder       = @pl_truckorder
            and fromareacode     = @ps_areacode
            and fromdivisioncode = @ps_divisioncode
      
         if @ll_tshipinv_count > 0  --tshipinv update   
            begin
               update [IPISMAC_SVR\ipis].ipis.DBO.TSHIPINV
                  set moveconfirmflag = 'Y',
                      SENDFLAG        = 'Y',
                      moveconfirmdate = convert(char(10),getdate(),102),
                      moveconfirmtime = getdate(),
                      lastdate        = getdate(),
                      lastemp         = 'Y'
                where ShipPlanDate     = @ps_shipplandate
                  and AreaCode         = @ps_moveareacode
                  and divisioncode     = @ps_movedivisioncode
                  and srno             = @ps_srno
                  and truckorder       = @pl_truckorder
                  and fromareacode     = @ps_areacode
                  and fromdivisioncode = @ps_divisioncode
               set @ll_error = @@error
            end
*/
         if @ll_tinv_count > 0   -- ��������� update
            begin
               update [IPISMAC_SVR\ipis].ipis.DBO.TINV
                  set moveinvqty = moveinvqty - @pl_shipqty,
                      lastdate   = getdate(),
                      lastemp    = 'Y'
                where AreaCode   = @ps_areacode
                  and divisioncode = @ps_movedivisioncode
                  and itemcode     = @ps_itemcode
               set @ll_error = @@error
             end
      end
     
   if @ps_moveareacode = 'D' and (@ps_movedivisioncode = 'A') --�뱸 ����
      begin
         select @ll_tinv_count = count(*) 
           from [IPISELE_SVR\ipis].ipis.DBO.TINV
          where AreaCode     = @ps_moveareacode
            and divisioncode = @ps_movedivisioncode
            and itemcode     = @ps_itemcode
/*         select @ll_tshipinv_count = count(*)
           from [IPISELE_SVR\ipis].ipis.DBO.TSHIPINV
          where ShipPlanDate     = @ps_shipplandate
            and AreaCode         = @ps_moveareacode
            and divisioncode     = @ps_movedivisioncode
            and srno             = @ps_srno
            and truckorder       = @pl_truckorder
            and fromareacode     = @ps_areacode
            and fromdivisioncode = @ps_divisioncode
      
         if @ll_tshipinv_count > 0  --tshipinv update   
            begin
               update [IPISELE_SVR\ipis].ipis.DBO.TSHIPINV
                  set moveconfirmflag = 'Y',
                      SENDFLAG        = 'Y',
                      moveconfirmdate = convert(char(10),getdate(),102),
                      moveconfirmtime = getdate(),
                      lastdate        = getdate(),
                      lastemp         = 'Y'
                where ShipPlanDate     = @ps_shipplandate
                  and AreaCode         = @ps_moveareacode
                  and divisioncode     = @ps_movedivisioncode
                  and srno             = @ps_srno
                  and truckorder       = @pl_truckorder
                  and fromareacode     = @ps_areacode
                  and fromdivisioncode = @ps_divisioncode
               set @ll_error = @@error
            end
*/
         if @ll_tinv_count > 0   -- ��������� update
            begin
               update [IPISELE_SVR\ipis].ipis.DBO.TINV
                  set moveinvqty = moveinvqty - @pl_shipqty,
                      lastdate     = getdate(),
                      lastemp      = 'Y'
                where AreaCode     = @ps_areacode
                  and divisioncode = @ps_divisioncode
                  and itemcode     = @ps_itemcode
               set @ll_error = @@error
             end
      end
   if @ps_moveareacode = 'D' and (@ps_movedivisioncode = 'H' or @ps_moveareacode = 'V') --�뱸 ����,����
      begin
         select @ll_tinv_count = count(*) 
           from [IPIShvac_SVR\ipis].ipis.DBO.TINV
          where AreaCode     = @ps_moveareacode
            and divisioncode = @ps_movedivisioncode
            and itemcode     = @ps_itemcode
/*         select @ll_tshipinv_count = count(*)
           from [IPIShvac_SVR\ipis].ipis.DBO.TSHIPINV
          where ShipPlanDate     = @ps_shipplandate
            and AreaCode         = @ps_moveareacode
            and divisioncode     = @ps_movedivisioncode
            and srno             = @ps_srno
            and truckorder       = @pl_truckorder
            and fromareacode     = @ps_areacode
            and fromdivisioncode = @ps_divisioncode
      
         if @ll_tshipinv_count > 0  --tshipinv update   
            begin
               update [IPIShvac_SVR\ipis].ipis.DBO.TSHIPINV
                  set moveconfirmflag = 'Y',
                      SENDFLAG        = 'Y',
                      moveconfirmdate = convert(char(10),getdate(),102),
                      moveconfirmtime = getdate(),
                      lastdate        = getdate(),
                      lastemp         = 'Y'
                where ShipPlanDate     = @ps_shipplandate
                  and AreaCode         = @ps_moveareacode
                  and divisioncode     = @ps_movedivisioncode
                  and srno             = @ps_srno
                  and truckorder       = @pl_truckorder
                  and fromareacode     = @ps_areacode
                  and fromdivisioncode = @ps_divisioncode
               set @ll_error = @@error
            end
*/
         if @ll_tinv_count > 0   -- ��������� update
            begin
               update [IPIShvac_SVR\ipis].ipis.DBO.TINV
                  set moveinvqty = moveinvqty - @pl_shipqty,
                      lastdate   = getdate(),
                      lastemp    = 'Y'
                where AreaCode     = @ps_moveareacode
                  and divisioncode = @ps_movedivisioncode
                  and itemcode     = @ps_itemcode
               set @ll_error = @@error
             end
      end
     
   if @ps_moveareacode = 'K' or @ps_moveareacode = 'Y' --����,����
      begin
         select @ll_tinv_count = count(*) 
           from [IPIShvac_SVR\ipis].ipis.DBO.TINV
          where AreaCode     = @ps_moveareacode
            and divisioncode = @ps_movedivisioncode
            and itemcode     = @ps_itemcode
/*         select @ll_tshipinv_count = count(*)
           from [IPIShvac_SVR\ipis].ipis.DBO.TSHIPINV
          where ShipPlanDate     = @ps_shipplandate
            and AreaCode         = @ps_moveareacode
            and divisioncode     = @ps_movedivisioncode
            and srno             = @ps_srno
            and truckorder       = @pl_truckorder
            and fromareacode     = @ps_areacode
            and fromdivisioncode = @ps_divisioncode
      
         if @ll_tshipinv_count > 0  --tshipinv update   
            begin
               update [IPIShvac_SVR\ipis].ipis.DBO.TSHIPINV
                  set moveconfirmflag = 'Y',
                      SENDFLAG        = 'Y',
                      moveconfirmdate = convert(char(10),getdate(),102),
                      moveconfirmtime = getdate(),
                      lastdate        = getdate(),
                      lastemp         = 'Y'
                where ShipPlanDate     = @ps_shipplandate
                  and AreaCode         = @ps_moveareacode
                  and divisioncode     = @ps_movedivisioncode
                  and srno             = @ps_srno
                  and truckorder       = @pl_truckorder
                  and fromareacode     = @ps_areacode
                  and fromdivisioncode = @ps_divisioncode
               set @ll_error = @@error
            end
*/
         if @ll_tinv_count > 0   -- ��������� update
            begin
               update [IPIShvac_SVR\ipis].ipis.DBO.TINV
                  set moveinvqty = moveinvqty - @pl_shipqty,
                      lastdate   = getdate(),
                      lastemp    = 'Y'
                where AreaCode     = @ps_moveareacode
                  and divisioncode = @ps_movedivisioncode
                  and itemcode     = @ps_itemcode
               set @ll_error = @@error
             end
      end
     
   if @ps_moveareacode = 'J'  --��õ
      begin
         select @ll_tinv_count = count(*) 
           from [IPISjin_SVR].ipis.DBO.TINV
          where AreaCode     = @ps_moveareacode
            and divisioncode = @ps_movedivisioncode
            and itemcode     = @ps_itemcode
/*         select @ll_tshipinv_count = count(*)
           from [IPISjin_SVR].ipis.DBO.TSHIPINV
          where ShipPlanDate     = @ps_shipplandate
            and AreaCode         = @ps_moveareacode
            and divisioncode     = @ps_movedivisioncode
            and srno             = @ps_srno
            and truckorder       = @pl_truckorder
            and fromareacode     = @ps_areacode
            and fromdivisioncode = @ps_divisioncode
      
         if @ll_tshipinv_count > 0  --tshipinv update   
            begin
               update [IPISjin_SVR].ipis.DBO.TSHIPINV
                  set moveconfirmflag = 'Y',
                      SENDFLAG        = 'Y',
                      moveconfirmdate = convert(char(10),getdate(),102),
                      moveconfirmtime = getdate(),
                      lastdate        = getdate(),
                      lastemp        = 'Y'
                where ShipPlanDate     = @ps_shipplandate
                  and AreaCode         = @ps_moveareacode
                  and divisioncode     = @ps_movedivisioncode
                  and srno             = @ps_srno
                  and truckorder       = @pl_truckorder
                  and fromareacode     = @ps_areacode
                  and fromdivisioncode = @ps_divisioncode
               set @ll_error = @@error
            end
*/
         if @ll_tinv_count > 0   -- ��������� update
            begin
               update [IPISjin_SVR].ipis.DBO.TINV
                  set moveinvqty = moveinvqty - @pl_shipqty,
                      lastdate     = getdate(),
                      lastemp      = 'Y'       
                where AreaCode     = @ps_moveareacode
                  and divisioncode = @ps_movedivisioncode
                  and itemcode     = @ps_itemcode
               set @ll_error = @@error
             end
      end

select error = @@error

End
Go
