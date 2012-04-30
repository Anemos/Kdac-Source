/* 주의 **********/
/* compile하는 serer의 공장은 linkedserver를 사용안함 */
/*
	File Name	: sp_piss_update_tinv.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss_update_tinv
	Description	: 이체확정시 해당 공장으로 데이타 전송
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
	@ps_areacode		= 'K',	         -- 의뢰지역
	@ps_divisioncode	= 'P',	         -- 의뢰공장
	@ps_moveareacode	= 'D',	         -- 불출지역
	@ps_movedivisioncode	= 'M',	         -- 불출공장
        @ps_shipplandate        = '2002.11.25',  -- 출하계획일자
        @ps_srno                = '00026384P00', -- sr번호
        @pl_truckorder          = 1,             -- 차량순번
        @ps_itemcode    	='09119-12004',  -- 품번
        @pl_shipqty             = 10,            -- 확인수량
	@ps_LastEmp             = 'ADMIN'        -- 사원번호
*/

Create Procedure sp_piss_update_tinv
	@ps_areacode		char(1),	-- 의뢰지역
	@ps_divisioncode	char(1),	-- 의뢰공장
	@ps_moveareacode	char(1),	-- 불출지역
	@ps_movedivisioncode	char(1),	-- 불출공장
        @ps_shipplandate        char(10),       -- 출하계획일자
        @ps_srno                varchar(12),    -- sr번호
        @pl_truckorder          smallint,       -- 차량순번
        @ps_itemcode    	varchar(12),    -- 품번
        @pl_shipqty             int,       -- 확인수량
	@ps_LastEmp             char(6)         -- 사원번호
        
As

Declare	@ll_tshipinv_count      smallint,
        @ll_tinv_count          smallint,
        @ll_error               smallint

Begin
   set xact_abort on
   set @ll_tshipinv_count    = 0
   set @ll_tinv_count        = 0
   set @ll_error = 9
   if @ps_moveareacode = 'D' and (@ps_movedivisioncode = 'M' or @ps_movedivisioncode = 'S') --대구 조향,제동
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
         if @ll_tinv_count > 0   -- 재고있으면 update
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
     
   if @ps_moveareacode = 'D' and (@ps_movedivisioncode = 'A') --대구 전장
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
         if @ll_tinv_count > 0   -- 재고있으면 update
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
   if @ps_moveareacode = 'D' and (@ps_movedivisioncode = 'H' or @ps_moveareacode = 'V') --대구 압축,공조
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
         if @ll_tinv_count > 0   -- 재고있으면 update
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
     
   if @ps_moveareacode = 'K' or @ps_moveareacode = 'Y' --군산,여주
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
         if @ll_tinv_count > 0   -- 재고있으면 update
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
     
   if @ps_moveareacode = 'J'  --진천
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
         if @ll_tinv_count > 0   -- 재고있으면 update
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
