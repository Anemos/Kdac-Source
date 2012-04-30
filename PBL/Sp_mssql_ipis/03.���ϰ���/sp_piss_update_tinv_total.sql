/*
	File Name	: sp_piss_update_tinv_total.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss_update_tinv_total
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
	    Where id = object_id(N'[dbo].[sp_piss_update_tinv_total]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss_update_tinv_total]
GO

/*
Execute sp_piss_update_tinv_total
*/
Create Procedure sp_piss_update_tinv_total
   
As

Declare	@ls_shipplandate        char(10),
        @ls_areacode            char(01),
        @ls_divisioncode        char(01),
        @ls_srno                varchar(11),
        @ll_truckorder          int,
        @ls_fromareacode        char(01),
        @ls_fromdivisioncode    char(01),
        @ll_truckloadqty        int,
        @ls_itemcode            varchar(20),
        @ll_error               smallint,
        @ll_tinv_count          int,
        @ll_tshipinv_count      int 
Begin
   set xact_abort on
DECLARE tshipinv_cur CURSORFOR select ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,itemcode,
           FromAreaCode,FromDivisionCode,TruckLoadQty
     from tshipinv
    where moveconfirmflag = 'N'
      and sendflag = 'N'
      and lastemp  = 'X'
      and moveconfirmdate is not null
open tshipinv_cur
FETCH next FROM tshipinv_cur into @ls_ShipPlanDate,@ls_AreaCode,@ls_DivisionCode,@ls_SRNo,@ll_TruckOrder,@ls_itemcode,
           @ls_FromAreaCode,@ls_FromDivisionCode,@ll_TruckLoadQty

WHILE @@FETCH_STATUS = 0

BEGIN
   set @ll_error = 0
   if @ls_fromareacode = 'D' and (@ls_fromdivisioncode = 'M' or @ls_fromdivisioncode = 'S') --대구 조향,제동
      begin
         select @ll_tinv_count = count(*) 
           from [IPISMAC_SVR\ipis].ipis.DBO.TINV
          where AreaCode     = @ls_fromareacode
            and divisioncode = @ls_fromdivisioncode
            and itemcode     = @ls_itemcode
         if @ll_tinv_count > 0   -- 재고있으면 update
            begin
               update [IPISMAC_SVR\ipis].ipis.DBO.TINV
                  set moveinvqty = moveinvqty - @ll_truckloadqty,
                      lastdate   = getdate(),
                      lastemp    = 'Y'
                where AreaCode     = @ls_fromareacode
                  and divisioncode = @ls_fromdivisioncode
                  and itemcode     = @ls_itemcode
               set @ll_error = @ll_error + @@error
             end
         select @ll_tshipinv_count = count(*)
           from [IPISmac_SVR\ipis].ipis.DBO.TSHIPINV
          where ShipPlanDate     = @ls_shipplandate
            and AreaCode         = @ls_fromareacode
            and divisioncode     = @ls_fromdivisioncode
            and srno             = @ls_srno
            and truckorder       = @ll_truckorder
            and fromareacode     = @ls_areacode
            and fromdivisioncode = @ls_divisioncode
      
         if @ll_tshipinv_count > 0  --tshipinv update   
            begin
               update [IPISMAC_SVR\ipis].ipis.DBO.TSHIPINV
                  set moveconfirmdate = convert(char(10),getdate(),102),
                      moveconfirmtime = getdate(),
                      lastdate        = getdate(),
                      lastemp         = 'Y'
                where ShipPlanDate     = @ls_shipplandate
                  and AreaCode         = @ls_fromareacode
                  and divisioncode     = @ls_fromdivisioncode
                  and srno             = @ls_srno
                  and truckorder       = @ll_truckorder
                  and fromareacode     = @ls_areacode
                  and fromdivisioncode = @ls_divisioncode
               set  @ll_error = @ll_error +  @@error
            end

      end
     
   if @ls_fromareacode = 'D' and (@ls_fromdivisioncode = 'A') --대구 전장
      begin
         select @ll_tinv_count = count(*) 
           from [IPISELE_SVR\ipis].ipis.DBO.TINV
          where AreaCode     = @ls_fromareacode
            and divisioncode = @ls_fromdivisioncode
            and itemcode     = @ls_itemcode
         if @ll_tinv_count > 0   -- 재고있으면 update
            begin
               update [IPISELE_SVR\ipis].ipis.DBO.TINV
                  set moveinvqty = moveinvqty - @ll_truckloadqty,
                      lastdate     = getdate(),
                      lastemp      = 'Y'
                where AreaCode     = @ls_areacode
                  and divisioncode = @ls_divisioncode
                  and itemcode     = @ls_itemcode
               set @ll_error = @ll_error + @@error
             end

         select @ll_tshipinv_count = count(*)
           from [IPISELE_SVR\ipis].ipis.DBO.TSHIPINV
          where ShipPlanDate     = @ls_shipplandate
            and AreaCode         = @ls_fromareacode
            and divisioncode     = @ls_fromdivisioncode
            and srno             = @ls_srno
            and truckorder       = @ll_truckorder
            and fromareacode     = @ls_areacode
            and fromdivisioncode = @ls_divisioncode
      
         if @ll_tshipinv_count > 0  --tshipinv update   
            begin
               update [IPISELE_SVR\ipis].ipis.DBO.TSHIPINV
                  set moveconfirmdate = convert(char(10),getdate(),102),
                      moveconfirmtime = getdate(),
                      lastdate        = getdate(),
                      lastemp         = 'Y'
                where ShipPlanDate     = @ls_shipplandate
                  and AreaCode         = @ls_fromareacode
                  and divisioncode     = @ls_fromdivisioncode
                  and srno             = @ls_srno
                  and truckorder       = @ll_truckorder
                  and fromareacode     = @ls_areacode
                  and fromdivisioncode = @ls_divisioncode
               set @ll_error = @ll_error + @@error
            end

      end
   if @ls_fromareacode = 'D' and (@ls_fromdivisioncode = 'H' or @ls_fromareacode = 'V') --대구 압축,공조
      begin
         select @ll_tinv_count = count(*) 
           from [IPIShvac_SVR\ipis].ipis.DBO.TINV
          where AreaCode     = @ls_fromareacode
            and divisioncode = @ls_fromdivisioncode
            and itemcode     = @ls_itemcode
         if @ll_tinv_count > 0   -- 재고있으면 update
            begin
               update [IPIShvac_SVR\ipis].ipis.DBO.TINV
                  set moveinvqty = moveinvqty - @ll_truckloadqty,
                      lastdate   = getdate(),
                      lastemp    = 'Y'
                where AreaCode     = @ls_fromareacode
                  and divisioncode = @ls_fromdivisioncode
                  and itemcode     = @ls_itemcode
               set @ll_error = @ll_error + @@error
             end

         select @ll_tshipinv_count = count(*)
           from [IPIShvac_SVR\ipis].ipis.DBO.TSHIPINV
          where ShipPlanDate     = @ls_shipplandate
            and AreaCode         = @ls_fromareacode
            and divisioncode     = @ls_fromdivisioncode
            and srno             = @ls_srno
            and truckorder       = @ll_truckorder
            and fromareacode     = @ls_areacode
            and fromdivisioncode = @ls_divisioncode
      
         if @ll_tshipinv_count > 0  --tshipinv update   
            begin
               update [IPIShvac_SVR\ipis].ipis.DBO.TSHIPINV
                  set moveconfirmdate = convert(char(10),getdate(),102),
                      moveconfirmtime = getdate(),
                      lastdate        = getdate(),
                      lastemp         = 'Y'
                where ShipPlanDate     = @ls_shipplandate
                  and AreaCode         = @ls_fromareacode
                  and divisioncode     = @ls_fromdivisioncode
                  and srno             = @ls_srno
                  and truckorder       = @ll_truckorder
                  and fromareacode     = @ls_areacode
                  and fromdivisioncode = @ls_divisioncode
               set @ll_error = @ll_error + @@error
            end
      end
     
   if @ls_fromareacode = 'K' or @ls_fromareacode = 'Y' --군산,여주
      begin
         select @ll_tinv_count = count(*) 
           from [IPIShvac_SVR\ipis].ipis.DBO.TINV
          where AreaCode     = @ls_fromareacode
            and divisioncode = @ls_fromdivisioncode
            and itemcode     = @ls_itemcode
         if @ll_tinv_count > 0   -- 재고있으면 update
            begin
               update [IPIShvac_SVR\ipis].ipis.DBO.TINV
                  set moveinvqty = moveinvqty - @ll_truckloadqty,
                      lastdate   = getdate(),
                      lastemp    = 'Y'
                where AreaCode     = @ls_fromareacode
                  and divisioncode = @ls_fromdivisioncode
                  and itemcode     = @ls_itemcode
               set @ll_error = @ll_error + @@error
             end

         select @ll_tshipinv_count = count(*)
           from [IPIShvac_SVR\ipis].ipis.DBO.TSHIPINV
          where ShipPlanDate     = @ls_shipplandate
            and AreaCode         = @ls_fromareacode
            and divisioncode     = @ls_fromdivisioncode
            and srno             = @ls_srno
            and truckorder       = @ll_truckorder
            and fromareacode     = @ls_areacode
            and fromdivisioncode = @ls_divisioncode
      
         if @ll_tshipinv_count > 0  --tshipinv update   
            begin
               update [IPIShvac_SVR\ipis].ipis.DBO.TSHIPINV
                  set moveconfirmdate = convert(char(10),getdate(),102),
                      moveconfirmtime = getdate(),
                      lastdate        = getdate(),
                      lastemp         = 'Y'
                where ShipPlanDate     = @ls_shipplandate
                  and AreaCode         = @ls_fromareacode
                  and divisioncode     = @ls_fromdivisioncode
                  and srno             = @ls_srno
                  and truckorder       = @ll_truckorder
                  and fromareacode     = @ls_areacode
                  and fromdivisioncode = @ls_divisioncode
               set @ll_error = @ll_error + @@error
            end
      end
     
   if @ls_fromareacode = 'J'  --진천
      begin
         select @ll_tinv_count = count(*) 
           from [IPISjin_SVR].ipis.DBO.TINV
          where AreaCode     = @ls_fromareacode
            and divisioncode = @ls_fromdivisioncode
            and itemcode     = @ls_itemcode
         if @ll_tinv_count > 0   -- 재고있으면 update
            begin
               update [IPISjin_SVR].ipis.DBO.TINV
                  set moveinvqty = moveinvqty - @ll_truckloadqty,
                      lastdate     = getdate(),
                      lastemp      = 'Y'       
                where AreaCode     = @ls_fromareacode
                  and divisioncode = @ls_fromdivisioncode
                  and itemcode     = @ls_itemcode
               set @ll_error = @ll_error + @@error
             end
         select @ll_tshipinv_count = count(*)
           from [IPISjin_SVR].ipis.DBO.TSHIPINV
          where ShipPlanDate     = @ls_shipplandate
            and AreaCode         = @ls_fromareacode
            and divisioncode     = @ls_fromdivisioncode
            and srno             = @ls_srno
            and truckorder       = @ll_truckorder
            and fromareacode     = @ls_areacode
            and fromdivisioncode = @ls_divisioncode
      
         if @ll_tshipinv_count > 0  --tshipinv update   
            begin
               update [IPISjin_SVR].ipis.DBO.TSHIPINV
                  set moveconfirmdate = convert(char(10),getdate(),102),
                      moveconfirmtime = getdate(),
                      lastdate        = getdate(),
                      lastemp        = 'Y'
                where ShipPlanDate     = @ls_shipplandate
                  and AreaCode         = @ls_fromareacode
                  and divisioncode     = @ls_fromdivisioncode
                  and srno             = @ls_srno
                  and truckorder       = @ll_truckorder
                  and fromareacode     = @ls_areacode
                  and fromdivisioncode = @ls_divisioncode
               set @ll_error = @ll_error + @@error
            end
      end
     if @ll_error = 0 
     begin
      update tshipinv
         set moveconfirmflag = 'Y',
             sendflag        = 'Y',
             lastemp         = 'Y'
       where ShipPlanDate     = @ls_shipplandate
         and AreaCode         = @ls_areacode
         and divisioncode     = @ls_divisioncode
         and srno             = @ls_srno
         and truckorder       = @ll_truckorder
         and fromareacode     = @ls_fromareacode
         and fromdivisioncode = @ls_fromdivisioncode
     end
      FETCH next FROM tshipinv_cur into @ls_ShipPlanDate,@ls_AreaCode,@ls_DivisionCode,@ls_SRNo,@ll_TruckOrder,@ls_itemcode,
                      @ls_FromAreaCode,@ls_FromDivisionCode,@ll_TruckLoadQty

END


CLOSE tshipinv_cur

DEALLOCATE tshipinv_cur

End
Go
