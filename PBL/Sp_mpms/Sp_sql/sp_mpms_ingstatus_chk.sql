/*
  File Name : sp_mpms_ingstatus_chk.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_ingstatus_chk
  Description : 진행중인 Order에 대해서 공정이 작업완료된 경우에 해당 Order를 제작완료시킴
  Use DataBase  : MPMS
  Use Program :
  Use Table : torder
  Parameter : @ps_yyyymm char(7)
  Initial   : 2004.03.31
  Author    : Kiss Kim
*/


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_ingstatus_chk]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_ingstatus_chk]
GO

/*
Execute sp_mpms_ingstatus_chk '2004.09', '000030'
*/

Create Procedure sp_mpms_ingstatus_chk
  @ps_yyyymm char(7),
  @ps_empno char(6)
  
As
Begin

Declare @ls_orderno char(8), @ls_checkdt char(8)
Declare @li_cnt integer, @ls_errchk varchar(10)
Declare @ld_enddate datetime

select @ld_enddate = dateadd(dd,-1,dateadd(mm,1,convert(datetime, @ps_yyyymm + '.01')))
select @ls_checkdt = convert(char(8), @ld_enddate, 112)
select @ls_errchk  = 'OK'

select  OrderNo
into #ing_tmp
from  torder
where ingstatus <> 'C' and ingstatus = '4'

select @ls_orderno = '00000000'
if @@rowcount <> 0
  Begin
    While @@error = 0
      Begin
        select top 1 @ls_orderno = orderno
        from #ing_tmp
        where orderno > @ls_orderno
        order by orderno
        
        if @@rowcount = 0
          Break
        
        select @li_cnt = count(*)
        from trouting
        where orderno = @ls_orderno
        
        if @li_cnt = 0
          Continue
          
        select @li_cnt = count(*)
        from trouting
        where orderno = @ls_orderno and workstatus <> 'C'
        
        if @@error <> 0
          Begin 
            Select @ls_errchk = 'ERROR_01'
            Break
          End
        if @li_cnt > 0
          Continue
        
        select @li_cnt = count(*)
        from tworkjob
        where orderno = @ls_orderno and workdate > @ls_checkdt
        
        if @@error <> 0
          Begin 
            Select @ls_errchk = 'ERROR_02'
            Break
          End
        if @li_cnt > 0
          Continue
        
        update torder
        set ingstatus = 'C', enddate = @ld_enddate, lastemp = @ps_empno, lastdate = getdate()
        where orderno = @ls_orderno
        
        if @@error <> 0
          Begin 
            Select @ls_errchk = 'ERROR_03'
            Break
          End
      End
  End

drop table #ing_tmp

select @ls_errchk
return

End   -- Procedure End

Go
