/* ���� ******************/
/* �ش� ������ linkserver�� ��� ���� */
/*
	File Name	: sp_piss_update_tshipinv.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss_tpdate_tshiphvac_ipismac_svr
	Description	: ��ü���Ͻ� �ش� �������� ����Ÿ ����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 17
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss_update_tshipinv]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss_update_tshipinv]
GO

/*
Execute sp_piss_update_tshipinv
        @ps_shipplandate        = '2002.11.01', -- ���ϰ�ȹ��
	@ps_areacode		= 'D',   	-- ��������
	@ps_divisioncode	= 'M',   	-- �������
        @ps_srno                = '00026384P00',-- S/R��ȣ
        @pl_truckorder          = 3,            -- ��������
        @ps_TruckNo		= '1234',       -- ������ȣ
	@ps_ShipDate		= '2002.11.01', -- ������
        @pl_TruckLoadQty	= 16000,        -- ��ü����
	@ps_LastEmp             = 'DM00'       -- �����ȣ
*/

Create Procedure sp_piss_update_tshipinv
        @ps_shipplandate        char(10),
	@ps_areacode		char(1),	-- ��������
	@ps_divisioncode	char(1),	-- �������
        @ps_srno                varchar(11),    -- S/R��ȣ
        @pl_truckorder          smallint,       -- ��������
        @ps_TruckNo		varchar(15),    -- ������ȣ
	@ps_ShipDate		char(10),       -- ������
        @pl_TruckLoadQty	decimal(7),     -- ��ü����
	@ps_LastEmp             char(6)        -- �����ȣ

As

Declare	@ls_moveareacode     	Char(01),
        @ls_movedivisioncode    char(01),
        @ll_shipeditno          smallint,
        @ls_itemcode            char(12),
        @ls_custcode            char(06),
        @ll_count               int,
        @ll_shiporderqty        int,
        @ls_sendflag            char(1),
        @ls_moverequireno       varchar(10),
        @ll_error               int

Begin
   set xact_abort on
--   set distributed on
   set @ls_moveareacode        = ''
   set @ls_movedivisioncode    = ''
   set @ll_shipeditno          = 0
   set @ll_shiporderqty        = 0
   set @ls_itemcode            = ''
   set @ls_custcode            = ''
   set @ll_count               = 0
   set @ls_sendflag            = 'N'
   set @ls_moverequireno       = ''
   SET @ll_error               = 9
   select @ls_moveareacode     = moveareacode,
          @ls_movedivisioncode = movedivisioncode,
          @ll_shipeditno       = shipeditno,
          @ls_itemcode         = itemcode,
          @ls_custcode         = custcode,
          @ls_moverequireno    = moverequireno,
          @ll_shiporderqty     = shiporderqty
     from tsrorder
    where srareacode     = @ps_areacode
      and srdivisioncode = @ps_divisioncode
      and srno           = @ps_srno

  IF @ls_moveareacode = 'D' and (@ls_movedivisioncode = 'M' or @ls_movedivisioncode = 'S') --�뱸 ����,����
     begin 
        select @ll_count = count(*)
          from [ipismac_svr\ipis].ipis.dbo.TSHIPINV
         where ShipPlanDate     = @ps_shipplandate
           and AreaCode         = @ls_moveareacode
           and divisioncode     = @ls_movedivisioncode
           and srno             = @ps_srno
           and truckorder       = @pl_truckorder
           and fromareacode     = @ps_areacode
           and fromdivisioncode = @ps_divisioncode
        if @ll_count = 0   -- ������ insert
           begin
              insert into [ipismac_svr\ipis].ipis.dbo.TSHIPINV
          	         (ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,
	                  FromAreaCode,FromDivisionCode,TruckNo,ShipDate,ShipGubun,
	                  ItemCode,CustCode,ShipEditNo,ApplyFrom,moverequireno,shiporderqty,
	                  TruckLoadQty,TruckDansuQty,TruckModifyFlag,MoveConfirmFlag,MoveConfirmDate,MoveConfirmTime,
                          SendFlag,LastEmp,LastDate)
                  values (@ps_shipplandate,@ls_moveareacode,@ls_movedivisioncode,@ps_srno,@pl_truckorder,
                          @ps_areacode,@ps_divisioncode,@ps_truckno,@ps_shipdate,'M',
                          @ls_itemcode,@ls_custcode,@ll_shipeditno,@ps_shipdate,@ls_moverequireno,@ll_shiporderqty,
                          @pl_truckloadqty,0,'N','N',null,null,
                          'N','Y',getdate())
               set @ll_error = @@error
           end
        else               -- ������ update
           begin
              update [ipismac_svr\ipis].ipis.dbo.TSHIPINV
                 set truckloadqty = @pl_truckloadqty,
                     sendflag        = 'N',
                     moveconfirmflag = 'N',
                     lastemp      = 'Y',
                     lastdate     = getdate()
               where ShipPlanDate     = @ps_shipplandate
                 and AreaCode         = @ls_moveareacode
                 and divisioncode     = @ls_movedivisioncode
                 and srno             = @ps_srno
                 and truckorder       = @pl_truckorder
                 and fromareacode     = @ps_areacode
                 and fromdivisioncode = @ps_divisioncode
               set @ll_error = @@error
           end
      End
  IF @ls_moveareacode = 'D' and (@ls_movedivisioncode = 'A' ) --�뱸 ����
     begin 
        select @ll_count = count(*)
          from [IPISele_SVR\ipis].ipis.DBO.TSHIPINV
         where ShipPlanDate     = @ps_shipplandate
           and AreaCode         = @ls_moveareacode
           and divisioncode     = @ls_movedivisioncode
           and srno             = @ps_srno
           and truckorder       = @pl_truckorder
           and fromareacode     = @ps_areacode
           and fromdivisioncode = @ps_divisioncode
        if @ll_count = 0   -- ������ insert
           begin
              insert into [IPISele_SVR\ipis].ipis.DBO.TSHIPINV
          	         (ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,
	                  FromAreaCode,FromDivisionCode,TruckNo,ShipDate,ShipGubun,
	                  ItemCode,CustCode,ShipEditNo,ApplyFrom,moverequireno,shiporderqty,
	                  TruckLoadQty,TruckDansuQty,TruckModifyFlag,MoveConfirmFlag,MoveConfirmDate,MoveConfirmTime,
                          SendFlag,LastEmp,LastDate)
                  values (@ps_shipplandate,@ls_moveareacode,@ls_movedivisioncode,@ps_srno,@pl_truckorder,
                          @ps_areacode,@ps_divisioncode,@ps_truckno,@ps_shipdate,'M',
                          @ls_itemcode,@ls_custcode,@ll_shipeditno,@ps_shipdate,@ls_moverequireno,@ll_shiporderqty,
                          @pl_truckloadqty,0,'N','N',null,null,
                          'N','Y',getdate())
               set @ll_error = @@error
           end
        else               -- ������ update
           begin
              update [IPISele_SVR\ipis].ipis.DBO.TSHIPINV
                 set truckloadqty = @pl_truckloadqty,
                     sendflag        = 'N',
                     moveconfirmflag = 'N',
                     lastemp      = 'Y',
                     lastdate     = getdate()
               where ShipPlanDate     = @ps_shipplandate
                 and AreaCode         = @ls_moveareacode
                 and divisioncode     = @ls_movedivisioncode
                 and srno             = @ps_srno
                 and truckorder       = @pl_truckorder
                 and fromareacode     = @ps_areacode
                 and fromdivisioncode = @ps_divisioncode
               set @ll_error = @@error
           end

      End
  IF @ls_moveareacode = 'D' and (@ls_movedivisioncode = 'H' or @ls_movedivisioncode = 'V' ) --�뱸 �������
     begin 
        select @ll_count = count(*)
          from [ipishvac_svr\ipis].ipis.dbo.TSHIPINV
         where ShipPlanDate     = @ps_shipplandate
           and AreaCode         = @ls_moveareacode
           and divisioncode     = @ls_movedivisioncode
           and srno             = @ps_srno
           and truckorder       = @pl_truckorder
           and fromareacode     = @ps_areacode
           and fromdivisioncode = @ps_divisioncode
        if @ll_count = 0   -- ������ insert
           begin
              insert into [ipishvac_svr\ipis].ipis.dbo.TSHIPINV
          	         (ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,
	                  FromAreaCode,FromDivisionCode,TruckNo,ShipDate,ShipGubun,
	                  ItemCode,CustCode,ShipEditNo,ApplyFrom,moverequireno,shiporderqty,
	                  TruckLoadQty,TruckDansuQty,TruckModifyFlag,MoveConfirmFlag,MoveConfirmDate,MoveConfirmTime,
                          SendFlag,LastEmp,LastDate)
                  values (@ps_shipplandate,@ls_moveareacode,@ls_movedivisioncode,@ps_srno,@pl_truckorder,
                          @ps_areacode,@ps_divisioncode,@ps_truckno,@ps_shipdate,'M',
                          @ls_itemcode,@ls_custcode,@ll_shipeditno,@ps_shipdate,@ls_moverequireno,@ll_shiporderqty,
                          @pl_truckloadqty,0,'N','N',null,null,
                          'N','Y',getdate())
               set @ll_error = @@error
           end
        else               -- ������ update
           begin
              update [ipishvac_svr\ipis].ipis.dbo.TSHIPINV
                 set truckloadqty = @pl_truckloadqty,
                     sendflag        = 'N',
                     moveconfirmflag = 'N',
                     lastemp      = 'Y',
                     lastdate     = getdate()
               where ShipPlanDate     = @ps_shipplandate
                 and AreaCode         = @ls_moveareacode
                 and divisioncode     = @ls_movedivisioncode
                 and srno             = @ps_srno
                 and truckorder       = @pl_truckorder
                 and fromareacode     = @ps_areacode
                 and fromdivisioncode = @ps_divisioncode
               set @ll_error = @@error
           end
      End
  IF @ls_moveareacode = 'K' or @ls_moveareacode = 'Y'  --����,����

     begin 
        select @ll_count = count(*)
          from [ipishvac_svr\ipis].ipis.dbo.TSHIPINV
         where ShipPlanDate     = @ps_shipplandate
           and AreaCode         = @ls_moveareacode
           and divisioncode     = @ls_movedivisioncode
           and srno             = @ps_srno
           and truckorder       = @pl_truckorder
           and fromareacode     = @ps_areacode
           and fromdivisioncode = @ps_divisioncode
        if @ll_count = 0   -- ������ insert
           begin
              insert into [ipishvac_svr\ipis].ipis.dbo.TSHIPINV
          	         (ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,
	                  FromAreaCode,FromDivisionCode,TruckNo,ShipDate,ShipGubun,
	                  ItemCode,CustCode,ShipEditNo,ApplyFrom,moverequireno,shiporderqty,
	                  TruckLoadQty,TruckDansuQty,TruckModifyFlag,MoveConfirmFlag,MoveConfirmDate,MoveConfirmTime,
                          SendFlag,LastEmp,LastDate)
                  values (@ps_shipplandate,@ls_moveareacode,@ls_movedivisioncode,@ps_srno,@pl_truckorder,
                          @ps_areacode,@ps_divisioncode,@ps_truckno,@ps_shipdate,'M',
                          @ls_itemcode,@ls_custcode,@ll_shipeditno,@ps_shipdate,@ls_moverequireno,@ll_shiporderqty,
                          @pl_truckloadqty,0,'N','N',null,null,
                          'N','Y',getdate())
               set @ll_error = @@error
           end
        else               -- ������ update
           begin
              update [ipishvac_svr\ipis].ipis.dbo.TSHIPINV
                 set truckloadqty = @pl_truckloadqty,
                     sendflag        = 'N',
                     moveconfirmflag = 'N',
                     lastemp      = 'Y',
                     lastdate     = getdate()
               where ShipPlanDate     = @ps_shipplandate
                 and AreaCode         = @ls_moveareacode
                 and divisioncode     = @ls_movedivisioncode
                 and srno             = @ps_srno
                 and truckorder       = @pl_truckorder
                 and fromareacode     = @ps_areacode
                 and fromdivisioncode = @ps_divisioncode
               set @ll_error = @@error
           end
      End
  IF @ls_moveareacode = 'J'  --��õ
     begin 
        select @ll_count = count(*)
          from [IPISjin_SVR].ipis.DBO.TSHIPINV
         where ShipPlanDate     = @ps_shipplandate
           and AreaCode         = @ls_moveareacode
           and divisioncode     = @ls_movedivisioncode
           and srno             = @ps_srno
           and truckorder       = @pl_truckorder
           and fromareacode     = @ps_areacode
           and fromdivisioncode = @ps_divisioncode
        if @ll_count = 0   -- ������ insert
           begin
              insert into [IPISjin_SVR].ipis.DBO.TSHIPINV
          	         (ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,
	                  FromAreaCode,FromDivisionCode,TruckNo,ShipDate,ShipGubun,
	                  ItemCode,CustCode,ShipEditNo,ApplyFrom,moverequireno,shiporderqty,
	                  TruckLoadQty,TruckDansuQty,TruckModifyFlag,MoveConfirmFlag,MoveConfirmDate,MoveConfirmTime,
                          SendFlag,LastEmp,LastDate)
                  values (@ps_shipplandate,@ls_moveareacode,@ls_movedivisioncode,@ps_srno,@pl_truckorder,
                          @ps_areacode,@ps_divisioncode,@ps_truckno,@ps_shipdate,'M',
                          @ls_itemcode,@ls_custcode,@ll_shipeditno,@ps_shipdate,@ls_moverequireno,@ll_shiporderqty,
                          @pl_truckloadqty,0,'N','N',null,null,
                          'N','Y',getdate())
               set @ll_error = @@error
           end
        else               -- ������ update
           begin
              update [IPISjin_SVR].ipis.DBO.TSHIPINV
                 set truckloadqty = @pl_truckloadqty,
                     sendflag        = 'N',
                     moveconfirmflag = 'N',
                     lastemp      = 'Y',
                     lastdate     = getdate()
               where ShipPlanDate     = @ps_shipplandate
                 and AreaCode         = @ls_moveareacode
                 and divisioncode     = @ls_movedivisioncode
                 and srno             = @ps_srno
                 and truckorder       = @pl_truckorder
                 and fromareacode     = @ps_areacode
                 and fromdivisioncode = @ps_divisioncode
               set @ll_error = @@error
           end
      End
/*
   if @@error <> 0 
      commit tran
   else
      rollback tran
*/
--   select error = @@error
   select error = @ll_error
--    select  @@error
--     select @pl_error = 8

End
Go
