/*
  File Name : sp_pisi_d_tmhlabtac.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_pisi_d_tmhlabtac
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
      Where id = object_id(N'[dbo].[sp_pisi_d_tmhlabtac]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisi_d_tmhlabtac]
GO

/*
Execute sp_pisi_d_tmhlabtac
*/

Create Procedure sp_pisi_d_tmhlabtac

As
Begin

set xact_abort off

-- 대구전장
     -- 수정

    update [ipisele_svr\ipis].ipis.dbo.tmhlabtac
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
  from  [ipisele_svr\ipis].ipis.dbo.tmhlabtac a,
        tmislabtac_log b,
        [ipisele_svr\ipis].ipis.dbo.tmstemp c
  where a.dgempno = b.empno and
    a.dgday   = b.dgyy+'.'+b.dgmm+'.'+b.dgdd and
    a.dgempno = c.empno

  if @@error  <>  0
     Begin
     Return
     End

    -- 추가
   insert into [ipisele_svr\ipis].ipis.dbo.tmhlabtac
    (dgempno, dgday,    dgdiv,    dgdepte,
    dgempgb,  dgdaygb,  dgtimer,  dgcd1r,
    dgcd2r,   dgcd3r,   dgdngbr,  dgotr,
    dgntr,    dgjor,    dgsangr,  dgjuhur,
    dghumur,  dgspcr,   dgjir,    dgoor,
    dgpor,    dgjtr,    dggunbor, dgmur,
    dgclass,  dgjikchek, dgindt,    dgintime, dginusr,
    dgupdt,   dguptime, dgupusr,  excflag)
  Select  a.empno,  a.dgyy+'.'+a.dgmm+'.'+a.dgdd, a.dgdiv,    a.dgdepte,
    a.dgempgb,  a.dgdaygb,  a.dgtimer,  a.dgcd1r,
    a.dgcd2r,   a.dgcd3r,   a.dgdngbr,  a.dgotr,
    a.dgntr,    a.dgjor,    a.dgsangr,  a.dgjuhur,
    a.dghumur,  a.dgspcr,   a.dgjir,    a.dgoor,
    a.dgpor,    a.dgjtr,    a.dggunbor, a.dgmur,
    a.dgclass,  c.empjikchek, a.dgindt,   a.dgintime, a.dginusr,
    a.dgupdt,   a.dguptime, a.dgupusr,  null
  from tmislabtac_log a,
      [ipisele_svr\ipis].ipis.dbo.tmstdept b,
      [ipisele_svr\ipis].ipis.dbo.tmstemp c
  where a.dgdepte = b.deptcode and
    b.areacode in ('X','D') and
    b.divisioncode in ('X','A') and
    a.empno+a.dgyy+'.'+a.dgmm+'.'+a.dgdd+a.dgdiv+a.dgdepte not in
    (select dgempno+dgday+dgdiv+dgdepte from [ipisele_svr\ipis].ipis.dbo.tmhlabtac) and
    a.empno = c.empno

   if @@error <>  0
     Begin
     Return
     End

-- 대구기계
     -- 수정
    update [ipismac_svr\ipis].ipis.dbo.tmhlabtac
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
  from  [ipismac_svr\ipis].ipis.dbo.tmhlabtac a,
      tmislabtac_log b,
      [ipismac_svr\ipis].ipis.dbo.tmstemp c
  where a.dgempno = b.empno and
    a.dgday   = b.dgyy+'.'+b.dgmm+'.'+b.dgdd and
    a.dgempno = c.empno

  if @@error  <>  0
     Begin
     Return
     End

    -- 추가
   insert into [ipismac_svr\ipis].ipis.dbo.tmhlabtac
    (dgempno, dgday,    dgdiv,    dgdepte,
    dgempgb,  dgdaygb,  dgtimer,  dgcd1r,
    dgcd2r,   dgcd3r,   dgdngbr,  dgotr,
    dgntr,    dgjor,    dgsangr,  dgjuhur,
    dghumur,  dgspcr,   dgjir,    dgoor,
    dgpor,    dgjtr,    dggunbor, dgmur,
    dgclass,  dgjikchek, dgindt,    dgintime, dginusr,
    dgupdt,   dguptime, dgupusr,  excflag)
  Select  a.empno,  a.dgyy+'.'+a.dgmm+'.'+a.dgdd, a.dgdiv,    a.dgdepte,
    a.dgempgb,  a.dgdaygb,  a.dgtimer,  a.dgcd1r,
    a.dgcd2r,   a.dgcd3r,   a.dgdngbr,  a.dgotr,
    a.dgntr,    a.dgjor,    a.dgsangr,  a.dgjuhur,
    a.dghumur,  a.dgspcr,   a.dgjir,    a.dgoor,
    a.dgpor,    a.dgjtr,    a.dggunbor, a.dgmur,
    a.dgclass,  c.empjikchek, a.dgindt,   a.dgintime, a.dginusr,
    a.dgupdt,   a.dguptime, a.dgupusr,  null
  from tmislabtac_log a,
    [ipismac_svr\ipis].ipis.dbo.tmstdept b,
    [ipismac_svr\ipis].ipis.dbo.tmstemp c
  where a.dgdepte = b.deptcode and
    b.areacode in ('X','D') and
    b.divisioncode in ('X','M','S') and
    a.empno+a.dgyy+'.'+a.dgmm+'.'+a.dgdd+a.dgdiv+a.dgdepte not in
    (select dgempno+dgday+dgdiv+dgdepte from [ipismac_svr\ipis].ipis.dbo.tmhlabtac) and
    a.empno = c.empno

  if @@error  <>  0
     Begin
     Return
     End

-- 대구공조
     -- 수정
    update [ipishvac_svr\ipis].ipis.dbo.tmhlabtac
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
  from  [ipishvac_svr\ipis].ipis.dbo.tmhlabtac a,
      tmislabtac_log b,
      [ipishvac_svr\ipis].ipis.dbo.tmstemp c
  where a.dgempno = b.empno and
    a.dgday   = b.dgyy+'.'+b.dgmm+'.'+b.dgdd and
    a.dgempno = c.empno

  if @@error  <>  0
     Begin
     Return
     End

    -- 추가
   insert into [ipishvac_svr\ipis].ipis.dbo.tmhlabtac
    (dgempno, dgday,    dgdiv,    dgdepte,
    dgempgb,  dgdaygb,  dgtimer,  dgcd1r,
    dgcd2r,   dgcd3r,   dgdngbr,  dgotr,
    dgntr,    dgjor,    dgsangr,  dgjuhur,
    dghumur,  dgspcr,   dgjir,    dgoor,
    dgpor,    dgjtr,    dggunbor, dgmur,
    dgclass,  dgjikchek, dgindt,   dgintime, dginusr,
    dgupdt,   dguptime, dgupusr,  excflag)
  Select  a.empno,  a.dgyy+'.'+a.dgmm+'.'+a.dgdd, a.dgdiv,    a.dgdepte,
    a.dgempgb,  a.dgdaygb,  a.dgtimer,  a.dgcd1r,
    a.dgcd2r,   a.dgcd3r,   a.dgdngbr,  a.dgotr,
    a.dgntr,    a.dgjor,    a.dgsangr,  a.dgjuhur,
    a.dghumur,  a.dgspcr,   a.dgjir,    a.dgoor,
    a.dgpor,    a.dgjtr,    a.dggunbor, a.dgmur,
    a.dgclass,  c.empjikchek, a.dgindt,   a.dgintime, a.dginusr,
    a.dgupdt,   a.dguptime, a.dgupusr,  null
  from tmislabtac_log a,
    [ipishvac_svr\ipis].ipis.dbo.tmstdept b,
    [ipishvac_svr\ipis].ipis.dbo.tmstemp c
  where a.dgdepte = b.deptcode and
    b.areacode in ('X','D') and
    b.divisioncode in ('X','H','V','K') and
    a.empno+a.dgyy+'.'+a.dgmm+'.'+a.dgdd+a.dgdiv+a.dgdepte not in
    (select dgempno+dgday+dgdiv+dgdepte from [ipishvac_svr\ipis].ipis.dbo.tmhlabtac) and
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
      tmislabtac_log b,
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
    dgupdt,   dguptime, dgupusr,  excflag)
  Select  a.empno,  a.dgyy+'.'+a.dgmm+'.'+a.dgdd, a.dgdiv,    a.dgdepte,
    a.dgempgb,  a.dgdaygb,  a.dgtimer,  a.dgcd1r,
    a.dgcd2r,   a.dgcd3r,   a.dgdngbr,  a.dgotr,
    a.dgntr,    a.dgjor,    a.dgsangr,  a.dgjuhur,
    a.dghumur,  a.dgspcr,   a.dgjir,    a.dgoor,
    a.dgpor,    a.dgjtr,    a.dggunbor, a.dgmur,
    a.dgclass,  c.empjikchek, a.dgindt,   a.dgintime, a.dginusr,
    a.dgupdt,   a.dguptime, a.dgupusr,  null
  from tmislabtac_log a,
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
    dgupusr  = b.dgupusr
  from  [ipisjin_svr].ipis.dbo.tmhlabtac a,
      tmislabtac_log b,
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
    dgupdt,   dguptime, dgupusr,  excflag)
  Select  a.empno,  a.dgyy+'.'+a.dgmm+'.'+a.dgdd, a.dgdiv,    a.dgdepte,
    a.dgempgb,  a.dgdaygb,  a.dgtimer,  a.dgcd1r,
    a.dgcd2r,   a.dgcd3r,   a.dgdngbr,  a.dgotr,
    a.dgntr,    a.dgjor,    a.dgsangr,  a.dgjuhur,
    a.dghumur,  a.dgspcr,   a.dgjir,    a.dgoor,
    a.dgpor,    a.dgjtr,    a.dggunbor, a.dgmur,
    a.dgclass,  c.empjikchek, a.dgindt,   a.dgintime, a.dginusr,
    a.dgupdt,   a.dguptime, a.dgupusr,  null
  from tmislabtac_log a,
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

  --history삭제

  Delete From tmislabtac_log

End   -- Procedure End
Go
