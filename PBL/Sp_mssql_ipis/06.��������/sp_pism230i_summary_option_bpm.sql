SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism230i_summary_option_bpm]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism230i_summary_option_bpm]
GO


/*****************************************/ 
/*    ���庰 ��� ǥ�� �� ������MH ȣȯǰ Summary    */ 
/* exec sp_pism230i_summary_option_bpm 'D','A','2012.11.29','2013','0A'  */
/*****************************************/ 

CREATE PROCEDURE sp_pism230i_summary_option_bpm
  @ps_AreaCode Char(1),
  @ps_DivisionCode Char(1),
	@ps_ToDate	Char(10),
	@ps_xyear	Char(4),
	@ps_revno Char(2)

AS
BEGIN

declare @ls_bomdate char(8),
  @ld_value decimal(15,6),
  @ls_opitn varchar(15),
  @ls_ofitn varchar(15),
  @li_chkcnt      int

set @ls_bomdate = convert(char(8), cast(@ps_ToDate as datetime), 112)


-- �������������� ����MH �հ� ���ϱ�
-- ó������ : 1. ȣȯ��/��ǰ�� ó�� sp_pism230i_summary_option_bpm @ps_AreaCode, @ps_DivisionCode, @ps_toDate
--              1.1 ȣȯ��ǰ���� �������� ���ʴ�� Ȯ������ ����
--              1.2 ȣȯ��ǰ�� ����Ʈ�߿� ȣȯ��ǰ���� ���� ����ǰ���� ��꿡 ����
--            2. ��ȣȯ ó��

-- ǥ��MH ó��
set @ls_opitn = ''
set @li_chkcnt = 0
set @ld_value = 0

while @li_chkcnt = 0
  BEGIN
  
  select distinct @ls_opitn = zitno, @ld_value = zstdin
  from tmhbasebombpm
  where zcmcd = '01' and zplant = @ps_AreaCode and
    zdiv = @ps_DivisionCode and xyear = @ps_xyear and revno = @ps_revno and
    zitno > @ls_opitn and zgrad = '1' and zcomcd <> '2'
  order by zitno desc

  if @@rowcount = 0
    break
  
  if @ld_value > 0
    BEGIN
    update tmhbasebombpm
    set zstdin_s = @ld_value
    where zcmcd = '01' and zplant = @ps_AreaCode and
      zdiv = @ps_DivisionCode and  xyear = @ps_xyear and revno = @ps_revno and
      zitno = @ls_opitn
    
    set @ld_value = 0
    continue
    END
  
  set @ls_ofitn = ''
  while @li_chkcnt = 0
    BEGIN
    
    select distinct @ls_ofitn = zitno, @ld_value = zstdin
    from tmhbasebombpm
    where zcmcd = '01' and zplant = @ps_AreaCode and
      zdiv = @ps_DivisionCode and  xyear = @ps_xyear and revno = @ps_revno and
      zaltno = @ls_opitn and zitno > @ls_ofitn
    order by zitno
    
    if @@rowcount = 0
      break
    
    if @ld_value > 0
      BEGIN
      update tmhbasebombpm
      set zstdin_s = @ld_value, zcheck = 'Y'
      where zcmcd = '01' and zplant = @ps_AreaCode and
        zdiv = @ps_DivisionCode and  xyear = @ps_xyear and revno = @ps_revno and
        zitno = @ls_ofitn
      
      set @ld_value = 0
      break
      END
    END
    
    set @ld_value = 0
  END

--�系����MHó��
set @ls_opitn = ''
set @li_chkcnt = 0
set @ld_value = 0

while @li_chkcnt = 0
  BEGIN
  
  select distinct @ls_opitn = zitno, @ld_value = zstdout
  from tmhbasebombpm
  where zcmcd = '01' and zplant = @ps_AreaCode and
    zdiv = @ps_DivisionCode and  xyear = @ps_xyear and revno = @ps_revno and
    zitno > @ls_opitn and zgrad = '1' and zcomcd <> '2'
  order by zitno desc

  if @@rowcount = 0
    break
  
  if @ld_value > 0
    BEGIN
    update tmhbasebombpm
    set zstdout_s = @ld_value
    where zcmcd = '01' and zplant = @ps_AreaCode and
      zdiv = @ps_DivisionCode and  xyear = @ps_xyear and revno = @ps_revno and
      zitno = @ls_opitn
    
    set @ld_value = 0
    continue
    END
  
  set @ls_ofitn = ''
  while @li_chkcnt = 0
    BEGIN
    
    select distinct @ls_ofitn = zitno, @ld_value = zstdout
    from tmhbasebombpm
    where zcmcd = '01' and zplant = @ps_AreaCode and
      zdiv = @ps_DivisionCode and  xyear = @ps_xyear and revno = @ps_revno and
      zaltno = @ls_opitn and zitno > @ls_ofitn
    order by zitno
    
    if @@rowcount = 0
      break
    
    if @ld_value > 0
      BEGIN
      update tmhbasebombpm
      set zstdout_s = @ld_value, zcheck = 'Y'
      where zcmcd = '01' and zplant = @ps_AreaCode and
        zdiv = @ps_DivisionCode and  xyear = @ps_xyear and revno = @ps_revno and
        zitno = @ls_ofitn
      
      set @ld_value = 0
      break
      END
    END
    
    set @ld_value = 0
  END

  
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

