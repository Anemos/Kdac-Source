/*
  File Name : sp_mpm134i_03.SQL
  SYSTEM    : 금형공정관리시스템
  View Name  : sp_mpm134i_03
  Description : WorkCenter별 장비내역
  Supply    : 
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2005.04
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm134i_03]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm134i_03]
GO

/*
Execute sp_mpm134i_03 
*/

Create Procedure sp_mpm134i_03

As
Begin

declare @ls_wccode char(3), @ls_mchno varchar(10), @ls_result varchar(255)
declare @li_count int, @li_totcount int

create table #tmp_mchno
( serialno int,
  TBS varchar(255) null,
  TLA varchar(255) null,
  TDM varchar(255) null,
  TPM varchar(255) null,
  TBM varchar(255) null,
  TMM varchar(255) null,
  TJB varchar(255) null,
  TUG varchar(255) null,
  TSG varchar(255) null,
  TJG varchar(255) null,
  TVG varchar(255) null,
  TWC varchar(255) null,
  TED varchar(255) null,
  TLP varchar(255) null,
  TAM varchar(255) null )

select top 1 @ls_wccode = wccode, 
  @li_totcount = count(*)
from tmachine
group by wccode
order by count(*) desc

select @li_count = 0
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    
    insert into #tmp_mchno
    values(@li_count,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
  End

-- TBS
select @li_totcount = count(*)
from tmachine
where wccode = 'TBS'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TBS' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TBS = @ls_result
    where serialno = @li_count
    
  End

-- TLA
select @li_totcount = count(*)
from tmachine
where wccode = 'TLA'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TLA' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TLA = @ls_result
    where serialno = @li_count
    
  End

-- TDM
select @li_totcount = count(*)
from tmachine
where wccode = 'TDM'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TDM' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TDM = @ls_result
    where serialno = @li_count
    
  End

-- TPM
select @li_totcount = count(*)
from tmachine
where wccode = 'TPM'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TPM' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TPM = @ls_result
    where serialno = @li_count
    
  End

-- TBM
select @li_totcount = count(*)
from tmachine
where wccode = 'TBM'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TBM' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TBM = @ls_result
    where serialno = @li_count
    
  End

-- TMM
select @li_totcount = count(*)
from tmachine
where wccode = 'TMM'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TMM' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TMM = @ls_result
    where serialno = @li_count
    
  End

-- TJB
select @li_totcount = count(*)
from tmachine
where wccode = 'TJB'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TJB' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TJB = @ls_result
    where serialno = @li_count
    
  End

-- TUG
select @li_totcount = count(*)
from tmachine
where wccode = 'TUG'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TUG' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TUG = @ls_result
    where serialno = @li_count
    
  End

-- TSG
select @li_totcount = count(*)
from tmachine
where wccode = 'TSG'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TSG' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TSG = @ls_result
    where serialno = @li_count
    
  End

-- TJG
select @li_totcount = count(*)
from tmachine
where wccode = 'TJG'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TJG' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TJG = @ls_result
    where serialno = @li_count
    
  End

-- TVG
select @li_totcount = count(*)
from tmachine
where wccode = 'TVG'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TVG' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TVG = @ls_result
    where serialno = @li_count
    
  End

-- TWC
select @li_totcount = count(*)
from tmachine
where wccode = 'TWC'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TWC' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TWC = @ls_result
    where serialno = @li_count
    
  End

-- TED
select @li_totcount = count(*)
from tmachine
where wccode = 'TED'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TED' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TED = @ls_result
    where serialno = @li_count
    
  End

-- TLP
select @li_totcount = count(*)
from tmachine
where wccode = 'TLP'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TLP' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TLP = @ls_result
    where serialno = @li_count
    
  End

-- TAM
select @li_totcount = count(*)
from tmachine
where wccode = 'TAM'

select @li_count = 0, @ls_mchno = '000'
while ( @li_count < @li_totcount )
  Begin
    select @li_count = @li_count + 1
    select TOP 1 @ls_result = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3) + ' ' + aa.mchname,
      @ls_mchno = aa.mchno
    from tmachine aa
    where aa.wccode = 'TAM' and aa.mchno > @ls_mchno
    order by aa.mchno
    
    update #tmp_mchno
    set TAM = @ls_result
    where serialno = @li_count
    
  End


-- result
select * from #tmp_mchno

drop table #tmp_mchno
End   -- Procedure End
Go
