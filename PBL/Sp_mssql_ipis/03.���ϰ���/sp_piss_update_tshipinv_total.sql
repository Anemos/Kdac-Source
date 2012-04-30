/*
	File Name	: sp_piss_update_tshipinv_total.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss_update_tshipinv_total
	Description	: 이체출하시 해당 공장으로 데이타 전송
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 17
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss_update_tshipinv_total]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss_update_tshipinv_total]
GO

/*
Execute sp_piss_update_tshipinv_total
*/

Create Procedure sp_piss_update_tshipinv_total

As

Declare	@ls_shipplandate        char(10),
        @ls_areacode            char(01),
        @ls_divisioncode        char(01),
        @ls_srno                varchar(11),
        @ll_truckorder          int,
        @ls_fromareacode     	Char(01),
        @ls_fromdivisioncode    char(01),
        @ls_truckno             varchar(15),
        @ls_shipdate            char(10),
        @ls_shipgubun           char(01),
        @ls_itemcode            varchar(20),
        @ls_custcode            varchar(06),
        @ll_shipeditno          smallint,
        @ls_applyfrom           char(10),
        @ls_moverequireno       varchar(20),
        @ll_shiporderqty        int,
        @ll_truckloadqty        int,
        @ll_truckdansuqty       int,
        @ls_truckmodifyflag     char(01),
        @ll_error               int,
        @ll_count               int

Begin
   set xact_abort on

DECLARE tshipinv_cur CURSORFOR select ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,
           FromAreaCode,FromDivisionCode,TruckNo,ShipDate,ShipGubun,
           ItemCode,CustCode,ShipEditNo,ApplyFrom,moverequireno,shiporderqty,
	   TruckLoadQty,TruckDansuQty,TruckModifyFlag
     from tshipinv
    where moveconfirmflag = 'Y'
      and sendflag        = 'Y'
      AND lastemp         = 'X'
open tshipinv_cur
FETCH next FROM tshipinv_cur into @ls_ShipPlanDate,@ls_AreaCode,@ls_DivisionCode,@ls_SRNo,@ll_TruckOrder,
           @ls_FromAreaCode,@ls_FromDivisionCode,@ls_TruckNo,@ls_ShipDate,@ls_ShipGubun,
           @ls_ItemCode,@ls_CustCode,@ll_ShipEditNo,@ls_ApplyFrom,@ls_moverequireno,@ll_shiporderqty,
	   @ll_TruckLoadQty,@ll_TruckDansuQty,@ls_TruckModifyFlag

WHILE @@FETCH_STATUS = 0

BEGIN
  IF @ls_fromareacode = 'D' and (@ls_fromdivisioncode = 'M' or @ls_fromdivisioncode = 'S') --대구 조향,제동
     begin 
        select @ll_count = count(*)
          from [ipismac_svr\ipis].ipis.dbo.TSHIPINV
         where ShipPlanDate     = @ls_shipplandate
           and AreaCode         = @ls_fromareacode
           and divisioncode     = @ls_fromdivisioncode
           and srno             = @ls_srno
           and truckorder       = @ll_truckorder
           and fromareacode     = @ls_areacode
           and fromdivisioncode = @ls_divisioncode
        if @ll_count = 0   -- 없으면 insert
           begin
              insert into [ipismac_svr\ipis].ipis.dbo.TSHIPINV
          	         (ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,
	                  FromAreaCode,FromDivisionCode,TruckNo,ShipDate,ShipGubun,
	                  ItemCode,CustCode,ShipEditNo,ApplyFrom,moverequireno,shiporderqty,
	                  TruckLoadQty,TruckDansuQty,TruckModifyFlag,MoveConfirmFlag,MoveConfirmDate,MoveConfirmTime,
                          SendFlag,LastEmp,LastDate)
                  values (@ls_shipplandate,@ls_fromareacode,@ls_fromdivisioncode,@ls_srno,@ll_truckorder,
                          @ls_areacode,@ls_divisioncode,@ls_truckno,@ls_shipdate,'M',
                          @ls_itemcode,@ls_custcode,@ll_shipeditno,@ls_shipdate,@ls_moverequireno,@ll_shiporderqty,
                          @ll_truckloadqty,0,'N','N',null,null,
                          'N','Y',getdate())
               set @ll_error = @@error
           end
        else               -- 있으면 update
           begin
              update [ipismac_svr\ipis].ipis.dbo.TSHIPINV
                 set truckloadqty = @ll_truckloadqty,
                     sendflag        = 'N',
                     moveconfirmflag = 'N',
                     lastemp      = 'Y',
                     lastdate     = getdate()
               where ShipPlanDate     = @ls_shipplandate
                 and AreaCode         = @ls_fromareacode
                 and divisioncode     = @ls_fromdivisioncode
                 and srno             = @ls_srno
                 and truckorder       = @ll_truckorder
                 and fromareacode     = @ls_areacode
                 and fromdivisioncode = @ls_divisioncode
               set @ll_error = @@error
           end
      End
  IF @ls_fromareacode = 'D' and (@ls_fromdivisioncode = 'A' ) --대구 전장
     begin 
        select @ll_count = count(*)
          from [IPISele_SVR\ipis].ipis.DBO.TSHIPINV
         where ShipPlanDate     = @ls_shipplandate
           and AreaCode         = @ls_fromareacode
           and divisioncode     = @ls_fromdivisioncode
           and srno             = @ls_srno
           and truckorder       = @ll_truckorder
           and fromareacode     = @ls_areacode
           and fromdivisioncode = @ls_divisioncode
        if @ll_count = 0   -- 없으면 insert
           begin
              insert into [IPISele_SVR\ipis].ipis.DBO.TSHIPINV
          	         (ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,
	                  FromAreaCode,FromDivisionCode,TruckNo,ShipDate,ShipGubun,
	                  ItemCode,CustCode,ShipEditNo,ApplyFrom,moverequireno,shiporderqty,
	                  TruckLoadQty,TruckDansuQty,TruckModifyFlag,MoveConfirmFlag,MoveConfirmDate,MoveConfirmTime,
                          SendFlag,LastEmp,LastDate)
                  values (@ls_shipplandate,@ls_fromareacode,@ls_fromdivisioncode,@ls_srno,@ll_truckorder,
                          @ls_areacode,@ls_divisioncode,@ls_truckno,@ls_shipdate,'M',
                          @ls_itemcode,@ls_custcode,@ll_shipeditno,@ls_shipdate,@ls_moverequireno,@ll_shiporderqty,
                          @ll_truckloadqty,0,'N','N',null,null,
                          'N','Y',getdate())
               set @ll_error = @@error
           end
        else               -- 있으면 update
           begin
              update [IPISele_SVR\ipis].ipis.DBO.TSHIPINV
                 set truckloadqty = @ll_truckloadqty,
                     sendflag        = 'N',
                     moveconfirmflag = 'N',
                     lastemp      = 'Y',
                     lastdate     = getdate()
               where ShipPlanDate     = @ls_shipplandate
                 and AreaCode         = @ls_fromareacode
                 and divisioncode     = @ls_fromdivisioncode
                 and srno             = @ls_srno
                 and truckorder       = @ll_truckorder
                 and fromareacode     = @ls_areacode
                 and fromdivisioncode = @ls_divisioncode
               set @ll_error = @@error
           end

      End
  IF @ls_fromareacode = 'D' and (@ls_fromdivisioncode = 'H' or @ls_fromdivisioncode = 'V' ) --대구 압축공조
     begin 
        select @ll_count = count(*)
          from [ipishvac_svr\ipis].ipis.dbo.TSHIPINV
         where ShipPlanDate     = @ls_shipplandate
           and AreaCode         = @ls_fromareacode
           and divisioncode     = @ls_fromdivisioncode
           and srno             = @ls_srno
           and truckorder       = @ll_truckorder
           and fromareacode     = @ls_areacode
           and fromdivisioncode = @ls_divisioncode
        if @ll_count = 0   -- 없으면 insert
           begin
              insert into [ipishvac_svr\ipis].ipis.dbo.TSHIPINV
          	         (ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,
	                  FromAreaCode,FromDivisionCode,TruckNo,ShipDate,ShipGubun,
	                  ItemCode,CustCode,ShipEditNo,ApplyFrom,moverequireno,shiporderqty,
	                  TruckLoadQty,TruckDansuQty,TruckModifyFlag,MoveConfirmFlag,MoveConfirmDate,MoveConfirmTime,
                          SendFlag,LastEmp,LastDate)
                  values (@ls_shipplandate,@ls_fromareacode,@ls_fromdivisioncode,@ls_srno,@ll_truckorder,
                          @ls_areacode,@ls_divisioncode,@ls_truckno,@ls_shipdate,'M',
                          @ls_itemcode,@ls_custcode,@ll_shipeditno,@ls_shipdate,@ls_moverequireno,@ll_shiporderqty,
                          @ll_truckloadqty,0,'N','N',null,null,
                          'N','Y',getdate())
               set @ll_error = @@error
           end
        else               -- 있으면 update
           begin
              update [ipishvac_svr\ipis].ipis.dbo.TSHIPINV
                 set truckloadqty = @ll_truckloadqty,
                     sendflag        = 'N',
                     moveconfirmflag = 'N',
                     lastemp      = 'Y',
                     lastdate     = getdate()
               where ShipPlanDate     = @ls_shipplandate
                 and AreaCode         = @ls_fromareacode
                 and divisioncode     = @ls_fromdivisioncode
                 and srno             = @ls_srno
                 and truckorder       = @ll_truckorder
                 and fromareacode     = @ls_areacode
                 and fromdivisioncode = @ls_divisioncode
               set @ll_error = @@error
           end
      End
  IF @ls_fromareacode = 'K' or @ls_fromareacode = 'Y'  --군산,여주

     begin 
        select @ll_count = count(*)
          from [ipishvac_svr\ipis].ipis.dbo.TSHIPINV
         where ShipPlanDate     = @ls_shipplandate
           and AreaCode         = @ls_fromareacode
           and divisioncode     = @ls_fromdivisioncode
           and srno             = @ls_srno
           and truckorder       = @ll_truckorder
           and fromareacode     = @ls_areacode
           and fromdivisioncode = @ls_divisioncode
        if @ll_count = 0   -- 없으면 insert
           begin
              insert into [ipishvac_svr\ipis].ipis.dbo.TSHIPINV
          	         (ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,
	                  FromAreaCode,FromDivisionCode,TruckNo,ShipDate,ShipGubun,
	                  ItemCode,CustCode,ShipEditNo,ApplyFrom,moverequireno,shiporderqty,
	                  TruckLoadQty,TruckDansuQty,TruckModifyFlag,MoveConfirmFlag,MoveConfirmDate,MoveConfirmTime,
                          SendFlag,LastEmp,LastDate)
                  values (@ls_shipplandate,@ls_fromareacode,@ls_fromdivisioncode,@ls_srno,@ll_truckorder,
                          @ls_areacode,@ls_divisioncode,@ls_truckno,@ls_shipdate,'M',
                          @ls_itemcode,@ls_custcode,@ll_shipeditno,@ls_shipdate,@ls_moverequireno,@ll_shiporderqty,
                          @ll_truckloadqty,0,'N','N',null,null,
                          'N','Y',getdate())
               set @ll_error = @@error
           end
        else               -- 있으면 update
           begin
              update [ipishvac_svr\ipis].ipis.dbo.TSHIPINV
                 set truckloadqty = @ll_truckloadqty,
                     sendflag        = 'N',
                     moveconfirmflag = 'N',
                     lastemp      = 'Y',
                     lastdate     = getdate()
               where ShipPlanDate     = @ls_shipplandate
                 and AreaCode         = @ls_fromareacode
                 and divisioncode     = @ls_fromdivisioncode
                 and srno             = @ls_srno
                 and truckorder       = @ll_truckorder
                 and fromareacode     = @ls_areacode
                 and fromdivisioncode = @ls_divisioncode
               set @ll_error = @@error
           end
      End
  IF @ls_fromareacode = 'J'  --진천
     begin 
        select @ll_count = count(*)
          from [IPISjin_SVR].ipis.DBO.TSHIPINV
         where ShipPlanDate     = @ls_shipplandate
           and AreaCode         = @ls_fromareacode
           and divisioncode     = @ls_fromdivisioncode
           and srno             = @ls_srno
           and truckorder       = @ll_truckorder
           and fromareacode     = @ls_areacode
           and fromdivisioncode = @ls_divisioncode
        if @ll_count = 0   -- 없으면 insert
           begin
              insert into [IPISjin_SVR].ipis.DBO.TSHIPINV
          	         (ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,
	                  FromAreaCode,FromDivisionCode,TruckNo,ShipDate,ShipGubun,
	                  ItemCode,CustCode,ShipEditNo,ApplyFrom,moverequireno,shiporderqty,
	                  TruckLoadQty,TruckDansuQty,TruckModifyFlag,MoveConfirmFlag,MoveConfirmDate,MoveConfirmTime,
                          SendFlag,LastEmp,LastDate)
                  values (@ls_shipplandate,@ls_fromareacode,@ls_fromdivisioncode,@ls_srno,@ll_truckorder,
                          @ls_areacode,@ls_divisioncode,@ls_truckno,@ls_shipdate,'M',
                          @ls_itemcode,@ls_custcode,@ll_shipeditno,@ls_shipdate,@ls_moverequireno,@ll_shiporderqty,
                          @ll_truckloadqty,0,'N','N',null,null,
                          'N','Y',getdate())
               set @ll_error = @@error
           end
        else               -- 있으면 update
           begin
              update [IPISjin_SVR].ipis.DBO.TSHIPINV
                 set truckloadqty = @ll_truckloadqty,
                     sendflag        = 'N',
                     moveconfirmflag = 'N',
                     lastemp      = 'Y',
                     lastdate     = getdate()
               where ShipPlanDate     = @ls_shipplandate
                 and AreaCode         = @ls_fromareacode
                 and divisioncode     = @ls_fromdivisioncode
                 and srno             = @ls_srno
                 and truckorder       = @ll_truckorder
                 and fromareacode     = @ls_areacode
                 and fromdivisioncode = @ls_divisioncode
               set @ll_error = @@error
           end
      End
      if @ll_error = 0 --정상으로 처리되면 
         begin
         update tshipinv
            set lastemp = 'Y'
         where ShipPlanDate     = @ls_shipplandate
           and AreaCode         = @ls_areacode
           and divisioncode     = @ls_divisioncode
           and srno             = @ls_srno
           and truckorder       = @ll_truckorder
           and fromareacode     = @ls_fromareacode
           and fromdivisioncode = @ls_fromdivisioncode
         end
    FETCH next FROM tshipinv_cur into @ls_ShipPlanDate,@ls_AreaCode,@ls_DivisionCode,@ls_SRNo,@ll_TruckOrder,
               @ls_FromAreaCode,@ls_FromDivisionCode,@ls_TruckNo,@ls_ShipDate,@ls_ShipGubun,
               @ls_ItemCode,@ls_CustCode,@ll_ShipEditNo,@ls_ApplyFrom,@ls_moverequireno,@ll_shiporderqty,
	       @ll_TruckLoadQty,@ll_TruckDansuQty,@ls_TruckModifyFlag
END


CLOSE tshipinv_cur

DEALLOCATE tshipinv_cur

end 
Go
