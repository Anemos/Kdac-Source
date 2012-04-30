/*
  File Name : sp_get_moldcode.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_get_moldcode
  Description : return code( format 0000 ) from tmoldcode
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_get_moldcode]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_get_moldcode]
GO

/*
exec sp_get_moldcode 'SER'
*/

Create Procedure sp_get_moldcode
  @ps_codeid char(3)

As
Begin

declare @ls_nextno varchar(10), @ls_reftext varchar(10)
declare @ls_rtn    varchar(10)
declare @li_cnt int, @li_totalcnt int, @li_rowcnt int,
        @li_idno  int, @li_refno int

Begin Tran
select @li_idno = isnull(idno,0), @li_refno = refno, @ls_reftext = reftext
from  tmoldcode
where codeid = @ps_codeid

if @ps_codeid = 'ORD'
  Begin
    if cast(datepart(year,getdate()) as char(4)) =  @ls_reftext
      Begin
        update tmoldcode
          set idno = @li_idno + 1
          where codeid = @ps_codeid
        select @li_rowcnt = @@rowcount
      End
    else
      Begin
        select @li_idno = 0
        select @ls_reftext = cast(datepart(year,getdate()) as char(4))
        update tmoldcode
          set idno = 1, reftext = cast(datepart(year,getdate()) as char(4))
          where codeid = @ps_codeid
        select @li_rowcnt = @@rowcount
      End
    End
if @ps_codeid in ('CID','SER','MAT')
  Begin
    update tmoldcode
      set idno = @li_idno + 1
      where codeid = @ps_codeid
    select @li_rowcnt = @@rowcount
  End

if @ps_codeid = 'PUR'
  Begin
    if cast(datepart(year,getdate()) as char(4)) =  @ls_reftext
      Begin
        update tmoldcode
          set idno = @li_idno + 1
          where codeid = @ps_codeid
        select @li_rowcnt = @@rowcount
      End
    else
      Begin
        select @li_idno = 0
        select @ls_reftext = cast(datepart(year,getdate()) as char(4))
        update tmoldcode
          set idno = 1, reftext = cast(datepart(year,getdate()) as char(4))
          where codeid = @ps_codeid
        select @li_rowcnt = @@rowcount
      End
    End

if @li_rowcnt <> 1
  Begin
    Rollback Tran
    return
  End

Commit Tran
select @ls_nextno = cast(@li_idno as varchar(10))
select @li_totalcnt = @li_refno - len(@ls_nextno)
select @li_cnt = 0
while @li_cnt < @li_totalcnt
  Begin
    select @li_cnt = @li_cnt + 1
    select @ls_nextno = '0' + @ls_nextno
  End

if @ps_codeid = 'ORD'
  Begin
    select @ls_rtn = convert(char(4),@ls_reftext) + convert(char(4),@ls_nextno)
  End
if @ps_codeid = 'PUR'
  Begin
    select @ls_rtn = convert(char(4),@ls_reftext) + convert(char(6),@ls_nextno)
  End
if @ps_codeid in ('CID','SER','MAT')
  Begin
    select @ls_rtn = @ls_nextno
  End

select @ls_rtn

End   -- Procedure End
Go
