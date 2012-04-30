/*
  File Name : sp_mpm220u_05.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm220u_05
  Description : 외주가공 데이타 생성
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno  char(8),
              @ps_partno char(6),
              @ps_empno   char(6),
              @pi_err_code INT OUTPUT
  Use Table : trouting, toutprocess, toutprocessdetail
  Initial   : 2006.06
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm220u_05]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm220u_05]
GO

/*
declare @pi_rtn int
select @pi_rtn = 0
Execute sp_mpm220u_05
  @ps_orderno = '20060176',
  @ps_partno= '001000',
  @ps_empno = '000030',
  @pi_err_code = @pi_rtn output

select @pi_rtn
*/

Create Procedure sp_mpm220u_05
  @ps_orderno       char(8),
  @ps_partno        char(6),
  @ps_empno         char(6),
  @pi_err_code      INT OUTPUT

As
Begin       -- Procedure Start

Begin TRAN

Declare @ls_outflag     char(1),
  @ls_outstatus   char(1),
  @ls_operno      char(3),
  @ls_postoperno  char(3),
  @ls_chkoperno   char(3),
  @ls_fromoperno  varchar(50),
  @ls_tooperno    varchar(50),
  @ls_outserial   char(2),
  @li_maxserial   int,
  @li_cnt         int,
  @li_totcnt      int,
  @li_unitprice   numeric(11,2),
  @li_outcostratio  numeric(10,0),
  @li_stdtime     numeric(10,0),
  @li_matcost     numeric(10,0),
  @li_mchcost     numeric(10,0),
  @li_outcost     numeric(10,0),
  @li_price       numeric(11,1),
  @li_weight      numeric(11,3),
  @li_weight2     numeric(11,3),
  @li_applyqty    numeric(5,0),
  @ls_wccode      char(3),
  @ls_outmaterialflag char(1)

/*########################################################################################

  ERROR FLAG 초기화

########################################################################################*/

SELECT  @pi_err_code = 0

/*########################################################################################

  품번에 대한 외주가공 정보 초기화

########################################################################################*/

SELECT TOP 1 @ls_outstatus = OutStatus
FROM TOUTPROCESS aa INNER JOIN TOUTPROCESSDETAIL bb
  ON aa.Orderno = bb.Orderno AND aa.PartNo = bb.PartNo AND
    aa.OutSerial = bb.OutSerial
WHERE bb.OrderNo = @ps_orderno AND bb.PartNo = @ps_partno

If @@rowcount <> 0
  BEGIN
    DELETE TOUTPROCESSDETAIL
    FROM TOUTPROCESS aa INNER JOIN TOUTPROCESSDETAIL bb
      ON aa.OrderNo = bb.OrderNo AND aa.PartNo = bb.PartNo AND
        aa.OutSerial = bb.OutSerial
    WHERE aa.OrderNo = @ps_orderno AND aa.PartNo = @ps_partno AND
      aa.OutStatus = 'A'

    Select @pi_err_code = @pi_err_code + @@ERROR

    DELETE FROM TOUTPROCESS
    WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND
      OutStatus = 'A'

    Select @pi_err_code = @pi_err_code + @@ERROR
  END

/*########################################################################################

  수정된 PartNo에 대한 외주가공데이타 있는지 체크한다.
  외주가공단가 = (제조원가 + 재료비) * 1.155
  제조원가 = 임율 * 투입시간
  재료비 = weight( tpartlist ) * unitprice ( tmaterialprice )
  재료비는 첫번째공순의 제조원가계산에만 포함되어야 한다.

########################################################################################*/

select operno = aa.operno,
  postoperno = ( select top 1 operno from trouting
    where orderno = @ps_orderno and partno = @ps_partno and operno > aa.operno
    order by operno ),
  outcostratio = cc.outcostratio,
  stdtime = aa.StdTime,
  unitprice = case aa.wccode when 'THT' then isnull(dd.heatprice,0) else isnull(dd.unitprice,0) end,
  weight = bb.weight,
  weight2 = bb.weight2,
  outmaterialflag = bb.outmaterialflag,
  wccode = aa.wccode,
  applyqty = isnull(bb.qty1,0) + isnull(bb.qty2,0),
  IDENTITY(int, 1,1) as id_num
into #tmp_routing
from trouting aa inner join tpartlist bb
  on aa.orderno = bb.orderno and aa.partno = bb.partno
  inner join tworkcenter cc
  on aa.wccode = cc.wccode
  left outer join tmaterialprice dd
  on bb.material = dd.material
where aa.orderno = @ps_orderno and aa.partno = @ps_partno and aa.outflag = 'P' and
  not exists ( select bb.operno from toutprocessdetail bb
      where aa.orderno = bb.orderno and aa.partno = bb.partno and aa.operno = bb.operno )
order by aa.operno

select @li_totcnt = @@rowcount
select @li_cnt = 0
select @ls_operno = '000'
select @ls_chkoperno = 'XXX'

while @li_cnt <= (@li_totcnt - 1)
  BEGIN
    select top 1 @ls_operno = operno,
      @ls_postoperno = postoperno,
      @li_outcostratio = isnull(outcostratio,0),
      @li_stdtime = isnull(stdtime,0),
      @li_unitprice = isnull(unitprice,0),
      @li_weight = isnull(weight,0),
      @li_weight2 = isnull(weight2,0),
      @ls_outmaterialflag = outmaterialflag,
      @ls_wccode = wccode,
      @li_applyqty = applyqty
    from #tmp_routing
    where id_num > @li_cnt
    order by id_num

    if @ls_chkoperno <> @ls_operno
      BEGIN
        SELECT @li_maxserial = cast( isnull(Max(OutSerial),'0') as integer ) + 1
        FROM TOUTPROCESS
        WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno

        select @ls_fromoperno = '#' + @ls_operno
        select @ls_outserial = cast( @li_maxserial as varchar(2) )
        if len(@ls_outserial) = 1
          select @ls_outserial = '0' + @ls_outserial

        INSERT INTO TOUTPROCESS(OrderNo, PartNo, OutSerial, OutStatus,
          InputEmp, InputDate, LastEmp)
        VALUES (@ps_orderno, @ps_partno, @ls_outserial, 'A',
          @ps_empno, convert(varchar(10),getdate(),112),'SYSTEM')

        Select @pi_err_code = @pi_err_code + @@ERROR

        -- calculate material cost
        if @ls_outmaterialflag = 'N' or @li_cnt <> 0
          select @li_matcost = 0
        else
          select @li_matcost = @li_applyqty * @li_weight2 * @li_unitprice
        
        -- calculate manufacture cost
        if @ls_wccode = 'THT'
            select @li_mchcost = ( @li_applyqty * @li_weight * @li_unitprice )
        else
            select @li_mchcost = @li_matcost + ( @li_outcostratio * cast( ( @li_applyqty * @li_stdtime / 60 ) as numeric(15,10) ) )
        
        select @li_outcost = @li_mchcost * 1.155

        INSERT INTO TOUTPROCESSDETAIL(OrderNo, PartNo, OutSerial, OperNo,
          ApplyQty, StdTime, OutCostRatio, MatCost, MchCost,
          OutCost, LastEmp)
        VALUES (@ps_orderno, @ps_partno, @ls_outserial, @ls_operno,
          @li_applyqty, @li_stdtime, @li_outcostratio, @li_matcost, @li_mchcost,
          @li_outcost, @ps_empno)

        Select @pi_err_code = @pi_err_code + @@ERROR

        UPDATE TOUTPROCESS
          SET PartSpec = @ls_fromoperno
          WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND OutSerial = @ls_outserial

        Select @pi_err_code = @pi_err_code + @@ERROR
      END
    else
      BEGIN
        select @ls_tooperno = @ls_fromoperno + '~' + '#' + @ls_operno

        UPDATE TOUTPROCESS
        SET PartSpec = @ls_tooperno
        WHERE OrderNo = @ps_orderno AND PartNo = @ps_partno AND OutSerial = @ls_outserial

        Select @pi_err_code = @pi_err_code + @@ERROR

        -- calculate material cost
        select @li_matcost = 0
        
        -- calculate manufacture cost
        if @ls_wccode = 'THT'
            select @li_mchcost = ( @li_applyqty * @li_weight * @li_unitprice )
        else
            select @li_mchcost = @li_outcostratio * cast( ( @li_applyqty * @li_stdtime / 60 ) as numeric(15,10) )
        select @li_outcost = @li_mchcost * 1.155

        INSERT INTO TOUTPROCESSDETAIL(OrderNo, PartNo, OutSerial, OperNo,
          ApplyQty, StdTime, OutCostRatio, MatCost, MchCost,
          OutCost, LastEmp)
        VALUES (@ps_orderno, @ps_partno, @ls_outserial, @ls_operno,
          @li_applyqty, @li_stdtime, @li_outcostratio, @li_matcost, @li_mchcost,
          @li_outcost, @ps_empno)

        Select @pi_err_code = @pi_err_code + @@ERROR
      END
    select @ls_chkoperno = @ls_postoperno
    select @li_cnt = @li_cnt + 1
  END

DROP TABLE #tmp_routing
-- ERROR 결정
IF @pi_err_code = 0
BEGIN
  COMMIT    TRAN
END
ELSE
BEGIN
  ROLLBACK  TRAN
END

RETURN  @pi_err_code

End   -- Procedure End
Go
