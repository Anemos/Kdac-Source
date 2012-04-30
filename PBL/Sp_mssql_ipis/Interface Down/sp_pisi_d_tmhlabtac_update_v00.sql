/*
  File Name : sp_pisi_d_tmhlabtac_update.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_pisi_d_tmhlabtac_update
  Description : Download 근태 데이타 - 매일
        tmhlabtac
        여주전자 서버추가 : 2004.04.19
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : IPIS2000
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2002. 11. 12
  Author    : Gary Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisi_d_tmhlabtac_update]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisi_d_tmhlabtac_update]
GO

/*
Execute sp_pisi_d_tmhlabtac_update
*/

Create Procedure sp_pisi_d_tmhlabtac_update

As
Begin

set xact_abort off


-- 부평물류
     -- 수정
    update [ipisbup_svr\ipis].ipis.dbo.tmhlabtac
  set dgdiv    = b.dgdiv,   dgdepte  = b.dgdepte,
    dgempgb  = b.dgempgb,   dgdaygb  = b.dgdaygb,
    dgtimer  = b.dgtimer,   dgcd1r   = b.dgcd1r,
    dgcd2r   = b.dgcd2r,    dgcd3r   = b.dgcd3r,
    dgdngbr  = b.dgdngbr,   dgotr  = b.dgotr,
    dgntr    = b.dgntr,   dgjor  = b.dgjor,
    dgsangr  = b.dgsangr,   dgjuhur  = b.dgjuhur,
    dghumur  = b.dghumur,   dgspcr   = b.dgspcr,
    dgjir    = b.dgjir,   dgoor  = b.dgoor,
    dgpor    = b.dgpor,   dgjtr  = b.dgjtr,
    dggunbor = b.dggunbor,    dgmur  = b.dgmur,
    dgclass  = b.dgclass,   dgjikchek = c.empjikchek,
    dgindt   = b.dgindt,
    dgintime = b.dgintime,    dginusr  = b.dginusr,
    dgupdt   = b.dgupdt,    dguptime = b.dguptime,
    dgupusr  = b.dgupusr 
  from  [ipisbup_svr\ipis].ipis.dbo.tmhlabtac a,
      [ipis_daegu].interface.dbo.tmislabtac_log b,
      [ipisbup_svr\ipis].ipis.dbo.tmstemp c
  where a.dgempno = b.empno and
    a.dgday   = b.dgyy+'.'+b.dgmm+'.'+b.dgdd and
    a.dgempno = c.empno

  if @@error  <>  0
     Begin
     Return
     End

    -- 추가
   insert into [ipisbup_svr\ipis].ipis.dbo.tmhlabtac
    (dgempno, dgday,    dgdiv,    dgdepte,
    dgempgb,  dgdaygb,  dgtimer,  dgcd1r,
    dgcd2r,   dgcd3r,   dgdngbr,  dgotr,
    dgntr,    dgjor,    dgsangr,  dgjuhur,
    dghumur,  dgspcr,   dgjir,    dgoor,
    dgpor,    dgjtr,    dggunbor, dgmur,
    dgclass,  dgjikchek, dgindt,   dgintime, dginusr,
    dgupdt,   dguptime, dgupusr,  excflag  )
  Select  a.empno,  a.dgyy+'.'+a.dgmm+'.'+a.dgdd, a.dgdiv,    a.dgdepte,
    a.dgempgb,  a.dgdaygb,  a.dgtimer,  a.dgcd1r,
    a.dgcd2r,   a.dgcd3r,   a.dgdngbr,  a.dgotr,
    a.dgntr,    a.dgjor,    a.dgsangr,  a.dgjuhur,
    a.dghumur,  a.dgspcr,   a.dgjir,    a.dgoor,
    a.dgpor,    a.dgjtr,    a.dggunbor, a.dgmur,
    a.dgclass,  c.empjikchek, a.dgindt,   a.dgintime, a.dginusr,
    a.dgupdt,   a.dguptime, a.dgupusr,  null
  from [ipis_daegu].interface.dbo.tmislabtac_log a,
    [ipisbup_svr\ipis].ipis.dbo.tmstdept b,
    [ipisbup_svr\ipis].ipis.dbo.tmstemp c
  where a.dgdepte = b.deptcode and
    b.areacode in ('X','B') and
    b.divisioncode in ('X','A','M','S','H','V','Y') and
    a.empno+a.dgyy+'.'+a.dgmm+'.'+a.dgdd+a.dgdiv+a.dgdepte not in
    (select dgempno+dgday+dgdiv+dgdepte from [ipisbup_svr\ipis].ipis.dbo.tmhlabtac) and
    a.empno = c.empno

  if @@error  <>  0
     Begin
     Return
     End

-- 군산물류
    -- 수정
    update [ipiskun_svr\ipis].ipis.dbo.tmhlabtac
  set dgdiv    = b.dgdiv,   dgdepte  = b.dgdepte,
    dgempgb  = b.dgempgb,   dgdaygb  = b.dgdaygb,
    dgtimer  = b.dgtimer,   dgcd1r   = b.dgcd1r,
    dgcd2r   = b.dgcd2r,    dgcd3r   = b.dgcd3r,
    dgdngbr  = b.dgdngbr,   dgotr  = b.dgotr,
    dgntr    = b.dgntr,   dgjor  = b.dgjor,
    dgsangr  = b.dgsangr,   dgjuhur  = b.dgjuhur,
    dghumur  = b.dghumur,   dgspcr   = b.dgspcr,
    dgjir    = b.dgjir,   dgoor  = b.dgoor,
    dgpor    = b.dgpor,   dgjtr  = b.dgjtr,
    dggunbor = b.dggunbor,    dgmur  = b.dgmur,
    dgclass  = b.dgclass,   dgjikchek = c.empjikchek,
    dgindt   = b.dgindt,
    dgintime = b.dgintime,    dginusr  = b.dginusr,
    dgupdt   = b.dgupdt,    dguptime = b.dguptime,
    dgupusr  = b.dgupusr 
  from  [ipiskun_svr\ipis].ipis.dbo.tmhlabtac a,
      [ipis_daegu].interface.dbo.tmislabtac_log b,
      [ipiskun_svr\ipis].ipis.dbo.tmstemp c
  where a.dgempno = b.empno and
    a.dgday   = b.dgyy+'.'+b.dgmm+'.'+b.dgdd and
    a.dgempno = c.empno

  if @@error  <>  0
     Begin
     Return
     End

    -- 추가
   insert into [ipiskun_svr\ipis].ipis.dbo.tmhlabtac
    (dgempno, dgday,    dgdiv,    dgdepte,
    dgempgb,  dgdaygb,  dgtimer,  dgcd1r,
    dgcd2r,   dgcd3r,   dgdngbr,  dgotr,
    dgntr,    dgjor,    dgsangr,  dgjuhur,
    dghumur,  dgspcr,   dgjir,    dgoor,
    dgpor,    dgjtr,    dggunbor, dgmur,
    dgclass,  dgjikchek, dgindt,   dgintime, dginusr,
    dgupdt,   dguptime, dgupusr,  excflag  )
  Select  a.empno,  a.dgyy+'.'+a.dgmm+'.'+a.dgdd, a.dgdiv,    a.dgdepte,
    a.dgempgb,  a.dgdaygb,  a.dgtimer,  a.dgcd1r,
    a.dgcd2r,   a.dgcd3r,   a.dgdngbr,  a.dgotr,
    a.dgntr,    a.dgjor,    a.dgsangr,  a.dgjuhur,
    a.dghumur,  a.dgspcr,   a.dgjir,    a.dgoor,
    a.dgpor,    a.dgjtr,    a.dggunbor, a.dgmur,
    a.dgclass,  c.empjikchek, a.dgindt,   a.dgintime, a.dginusr,
    a.dgupdt,   a.dguptime, a.dgupusr,  null 
  from [ipis_daegu].interface.dbo.tmislabtac_log a,
    [ipiskun_svr\ipis].ipis.dbo.tmstdept b,
    [ipiskun_svr\ipis].ipis.dbo.tmstemp c
  where a.dgdepte = b.deptcode and
    b.areacode in ('X','K') and
    b.divisioncode in ('X','M','S','H') and
    a.empno+a.dgyy+'.'+a.dgmm+'.'+a.dgdd+a.dgdiv+a.dgdepte not in
    (select dgempno+dgday+dgdiv+dgdepte from [ipiskun_svr\ipis].ipis.dbo.tmhlabtac) and
    a.empno = c.empno

  if @@error  <>  0
     Begin
     Return
     End

-- 여주전자
     -- 수정
    update [ipisyeo_svr\ipis].ipis.dbo.tmhlabtac
  set dgdiv    = b.dgdiv,   dgdepte  = b.dgdepte,
    dgempgb  = b.dgempgb,   dgdaygb  = b.dgdaygb,
    dgtimer  = b.dgtimer,   dgcd1r   = b.dgcd1r,
    dgcd2r   = b.dgcd2r,    dgcd3r   = b.dgcd3r,
    dgdngbr  = b.dgdngbr,   dgotr  = b.dgotr,
    dgntr    = b.dgntr,   dgjor  = b.dgjor,
    dgsangr  = b.dgsangr,   dgjuhur  = b.dgjuhur,
    dghumur  = b.dghumur,   dgspcr   = b.dgspcr,
    dgjir    = b.dgjir,   dgoor  = b.dgoor,
    dgpor    = b.dgpor,   dgjtr  = b.dgjtr,
    dggunbor = b.dggunbor,    dgmur  = b.dgmur,
    dgclass  = b.dgclass,   dgjikchek = c.empjikchek,
    dgindt   = b.dgindt,
    dgintime = b.dgintime,    dginusr  = b.dginusr,
    dgupdt   = b.dgupdt,    dguptime = b.dguptime,
    dgupusr  = b.dgupusr 
  from  [ipisyeo_svr\ipis].ipis.dbo.tmhlabtac a,
      [ipis_daegu].interface.dbo.tmislabtac_log b,
      [ipisyeo_svr\ipis].ipis.dbo.tmstemp c
  where a.dgempno = b.empno and
    a.dgday   = b.dgyy+'.'+b.dgmm+'.'+b.dgdd and
    a.dgempno = c.empno

  if @@error  <>  0
     Begin
     Return
     End

    -- 추가
   insert into [ipisyeo_svr\ipis].ipis.dbo.tmhlabtac
    (dgempno, dgday,    dgdiv,    dgdepte,
    dgempgb,  dgdaygb,  dgtimer,  dgcd1r,
    dgcd2r,   dgcd3r,   dgdngbr,  dgotr,
    dgntr,    dgjor,    dgsangr,  dgjuhur,
    dghumur,  dgspcr,   dgjir,    dgoor,
    dgpor,    dgjtr,    dggunbor, dgmur,
    dgclass,  dgjikchek, dgindt,   dgintime, dginusr,
    dgupdt,   dguptime, dgupusr,  excflag  )
  Select  a.empno,  a.dgyy+'.'+a.dgmm+'.'+a.dgdd, a.dgdiv,    a.dgdepte,
    a.dgempgb,  a.dgdaygb,  a.dgtimer,  a.dgcd1r,
    a.dgcd2r,   a.dgcd3r,   a.dgdngbr,  a.dgotr,
    a.dgntr,    a.dgjor,    a.dgsangr,  a.dgjuhur,
    a.dghumur,  a.dgspcr,   a.dgjir,    a.dgoor,
    a.dgpor,    a.dgjtr,    a.dggunbor, a.dgmur,
    a.dgclass,  c.empjikchek, a.dgindt,   a.dgintime, a.dginusr,
    a.dgupdt,   a.dguptime, a.dgupusr,  null 
  from [ipis_daegu].interface.dbo.tmislabtac_log a,
    [ipisyeo_svr\ipis].ipis.dbo.tmstdept b,
    [ipisyeo_svr\ipis].ipis.dbo.tmstemp c
  where a.dgdepte = b.deptcode and
    b.areacode in ('X','D','Y') and
    b.divisioncode in ('X','Y') and
    a.empno+a.dgyy+'.'+a.dgmm+'.'+a.dgdd+a.dgdiv+a.dgdepte not in
    (select dgempno+dgday+dgdiv+dgdepte from [ipisyeo_svr\ipis].ipis.dbo.tmhlabtac) and
    a.empno = c.empno

  if @@error  <>  0
     Begin
     Return
     End

-- 진천
     -- 수정
    update [ipisjin_svr].ipis.dbo.tmhlabtac
  set dgdiv    = b.dgdiv,   dgdepte  = b.dgdepte,
    dgempgb  = b.dgempgb,   dgdaygb  = b.dgdaygb,
    dgtimer  = b.dgtimer,   dgcd1r   = b.dgcd1r,
    dgcd2r   = b.dgcd2r,    dgcd3r   = b.dgcd3r,
    dgdngbr  = b.dgdngbr,   dgotr  = b.dgotr,
    dgntr    = b.dgntr,   dgjor  = b.dgjor,
    dgsangr  = b.dgsangr,   dgjuhur  = b.dgjuhur,
    dghumur  = b.dghumur,   dgspcr   = b.dgspcr,
    dgjir    = b.dgjir,   dgoor  = b.dgoor,
    dgpor    = b.dgpor,   dgjtr  = b.dgjtr,
    dggunbor = b.dggunbor,    dgmur  = b.dgmur,
    dgclass  = b.dgclass,   dgjikchek = c.empjikchek, dgindt   = b.dgindt,
    dgintime = b.dgintime,    dginusr  = b.dginusr,
    dgupdt   = b.dgupdt,    dguptime = b.dguptime,
    dgupusr  = b.dgupusr,	dgserno	= b.dgserno
  from  [ipisjin_svr].ipis.dbo.tmhlabtac a,
      [ipis_daegu].interface.dbo.tmislabtac_log b,
      [ipisjin_svr].ipis.dbo.tmstemp c
  where a.dgempno = b.empno and
    a.dgday   = b.dgyy+'.'+b.dgmm+'.'+b.dgdd and
    a.dgempno = c.empno

  if @@error  <>  0
     Begin
     Return
     End

    -- 추가
   insert into [ipisjin_svr].ipis.dbo.tmhlabtac
    (dgempno, dgday,    dgdiv,    dgdepte,
    dgempgb,  dgdaygb,  dgtimer,  dgcd1r,
    dgcd2r,   dgcd3r,   dgdngbr,  dgotr,
    dgntr,    dgjor,    dgsangr,  dgjuhur,
    dghumur,  dgspcr,   dgjir,    dgoor,
    dgpor,    dgjtr,    dggunbor, dgmur,
    dgclass,  dgjikchek, dgindt,    dgintime, dginusr,
    dgupdt,   dguptime, dgupusr,  excflag, dgserno)
  Select  a.empno,  a.dgyy+'.'+a.dgmm+'.'+a.dgdd, a.dgdiv,    a.dgdepte,
    a.dgempgb,  a.dgdaygb,  a.dgtimer,  a.dgcd1r,
    a.dgcd2r,   a.dgcd3r,   a.dgdngbr,  a.dgotr,
    a.dgntr,    a.dgjor,    a.dgsangr,  a.dgjuhur,
    a.dghumur,  a.dgspcr,   a.dgjir,    a.dgoor,
    a.dgpor,    a.dgjtr,    a.dggunbor, a.dgmur,
    a.dgclass,  c.empjikchek, a.dgindt,   a.dgintime, a.dginusr,
    a.dgupdt,   a.dguptime, a.dgupusr,  null, a.dgserno
  from [ipis_daegu].interface.dbo.tmislabtac_log a,
      [ipisjin_svr].ipis.dbo.tmstdept b,
      [ipisjin_svr].ipis.dbo.tmstemp c
  where a.dgdepte = b.deptcode and
    b.areacode in ('X','J') and
    a.empno+a.dgyy+'.'+a.dgmm+'.'+a.dgdd+a.dgdiv+a.dgdepte not in
    (select dgempno+dgday+dgdiv+dgdepte from [ipisjin_svr].ipis.dbo.tmhlabtac)  and
    a.empno = c.empno

  if @@error  <>  0
     Begin
     Return
     End


End   -- Procedure End
Go
