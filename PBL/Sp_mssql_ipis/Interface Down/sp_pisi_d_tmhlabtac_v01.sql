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

    update [ipis_daegu].ipis.dbo.tmhlabtac
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
    dgupusr  = b.dgupusr,	dgserno	= b.dgserno
  from  [ipis_daegu].ipis.dbo.tmhlabtac a,
        tmislabtac_log b,
        [ipis_daegu].ipis.dbo.tmstemp c
  where a.dgempno = b.empno and
    a.dgday   = b.dgyy+'.'+b.dgmm+'.'+b.dgdd and
    a.dgempno = c.empno

  if @@error  <>  0
     Begin
     Return
     End

   -- 대구 전장 추가
   insert into [ipis_daegu].ipis.dbo.tmhlabtac
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
  from tmislabtac_log a inner join[ipis_daegu].ipis.dbo.tmstdept b
	on a.dgdepte = b.deptcode
    inner join [ipis_daegu].ipis.dbo.tmstemp c
	on a.empno = c.empno
  where b.areacode in ('X','D') and
    b.divisioncode in ('X','A','M','S','H','V') and
    not exists ( select * from [ipis_daegu].ipis.dbo.tmhlabtac d
		where a.EMPNO = d.DGEMPNO and (a.DGYY + a.DGMM + a.DGDD) = CONVERT(char(8),cast(d.DGDAY as DATETIME),112))

   if @@error <>  0
     Begin
     Return
     End
     
   Execute [ipisjin_Svr].ipis.dbo.sp_pisi_d_tmhlabtac_update

  --history삭제

  Delete From tmislabtac_log

End   -- Procedure End
Go
