/*
  File Name : sp_mpms_workstatus_chk.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_workstatus_chk
  Description : 작업실적에서 작업완료를 선택시에 가능여부 Return
   - 불량이 있는 경우에 재작업실적 존재여부 'ERR01'
  Use DataBase  : MPMS
  Use Program :
  Use Table : tpartlist
  Parameter : @ps_orderno char(8)
              @ps_partno  char(6)
              @ps_operno char(3)
              @ps_rtn     varchar(5)
  Initial   : 2004.03.31
  Author    : Kiss Kim
*/


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_workstatus_chk]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_workstatus_chk]
GO

/*

declare @ls_rtn varchar(5)
select @ls_rtn = 'OK'
Execute sp_mpms_workstatus_chk 
  @ps_orderno = '20040110',
  @ps_partno  = '000007',
  @ps_operno = '110',
  @ps_rtn    = @ls_rtn output

select @ls_rtn
*/

Create Procedure sp_mpms_workstatus_chk
  @ps_orderno char(8),
  @ps_partno  char(6),
  @ps_operno  char(3),
  @ps_rtn     varchar(5) output

As
Begin

Declare @ls_stype char(2),
  @ls_srno char(10),
  @ls_reoperno char(3),
  @li_cnt integer,
  @ls_workstatus char(1)

select @ps_rtn = 'OK'

select Stype = aa.Stype,
  Srno = aa.Srno,
  ReOperNo = bb.ReOperNo,
  WorkStatus = bb.WorkStatus
into #bad_tmp
from tworkjob aa inner join tbaddetail bb
  on aa.Stype = bb.Stype and aa.Srno = bb.Srno
where aa.orderno = @ps_orderno and aa.partno = @ps_partno and
  aa.operno = @ps_operno and aa.resultflag = 'E'

if @@rowcount < 1
  Select @ps_rtn = 'ERR00'
else
  Begin
    while @@error = 0
      Begin
        select Top 1 @ls_stype = stype, @ls_srno = srno, 
          @ls_reoperno = reoperno, @ls_workstatus = workstatus
        from #bad_tmp
        order by stype, srno
        
        if @@rowcount = 0
          Break
        
        select @li_cnt = count(*)
        from tworkjob
        where badstype = @ls_stype and badsrno = @ls_srno and 
          operno = @ls_reoperno
        
        if @li_cnt < 1 or @ls_workstatus <> 'C'
          Begin
          Select @ps_rtn = 'ERR01'
          Break
          End
          
        delete from #bad_tmp
        where stype = @ls_stype and srno = @ls_srno and
          reoperno = @ls_reoperno
        
      End
  End

Return 

End   -- Procedure End

Go
