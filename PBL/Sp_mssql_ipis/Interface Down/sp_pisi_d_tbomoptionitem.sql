/*
  File Name : sp_pisi_d_tbomoptionitem.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_pisi_d_tbomoptionitem
  Description : Download BOM option - 매일
        tbomoptionitem
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : IPIS2000
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2004.10.14
  Author    : Gary Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisi_d_tbomoptionitem]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisi_d_tbomoptionitem]
GO

/*
Execute sp_pisi_d_tbomoptionitem
*/

Create Procedure sp_pisi_d_tbomoptionitem

As
Begin


If Exists (select * From bom003)

  Begin
    -- 대구 전장
    exec [ipisele_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tbomoptionitem'

    insert into [ipisele_svr\ipis].ipis.dbo.tbomoptionitem
    (Oplant, Odvsn, Opitn, Ofitn, Ochdt, Oedtm, Oedte, Orate, Ochcd, Ofocd, Oemno, LastDate)
    select oplant, odvsn, opitn, ofitn,
      substring(ochdt, 1, 4)+'.'+substring(ochdt, 5, 2)+'.'+substring(ochdt, 7,2),
      case
        when oedtm = '' then '1900.01.01'
        else substring(oedtm, 1, 4)+'.'+substring(oedtm, 5, 2)+'.'+substring(oedtm, 7,2)
        end,
      case
        when oedte = '' then '9999.12.31'
        else substring(oedte, 1, 4)+'.'+substring(oedte, 5, 2)+'.'+substring(oedte, 7,2)
        end,
      orate, ochcd, ofocd, oemno, getdate()
    from bom003
    where oplant = 'D' and odvsn in ('A')

    -- 대구 기계
    exec [ipismac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tbomoptionitem'

    insert into [ipismac_svr\ipis].ipis.dbo.tbomoptionitem
    (Oplant, Odvsn, Opitn, Ofitn, Ochdt, Oedtm, Oedte, Orate, Ochcd, Ofocd, Oemno, LastDate)
    select oplant, odvsn, opitn, ofitn,
      substring(ochdt, 1, 4)+'.'+substring(ochdt, 5, 2)+'.'+substring(ochdt, 7,2),
      case
        when oedtm = '' then '1900.01.01'
        else substring(oedtm, 1, 4)+'.'+substring(oedtm, 5, 2)+'.'+substring(oedtm, 7,2)
        end,
      case
        when oedte = '' then '9999.12.31'
        else substring(oedte, 1, 4)+'.'+substring(oedte, 5, 2)+'.'+substring(oedte, 7,2)
        end,
      orate, ochcd, ofocd, oemno, getdate()
    from bom003
    where oplant = 'D' and odvsn in ('M','S')

    -- 대구 공조
    exec [ipishvac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tbomoptionitem'

    insert into [ipishvac_svr\ipis].ipis.dbo.tbomoptionitem
    (Oplant, Odvsn, Opitn, Ofitn, Ochdt, Oedtm, Oedte, Orate, Ochcd, Ofocd, Oemno, LastDate)
    select oplant, odvsn, opitn, ofitn,
      substring(ochdt, 1, 4)+'.'+substring(ochdt, 5, 2)+'.'+substring(ochdt, 7,2),
      case
        when oedtm = '' then '1900.01.01'
        else substring(oedtm, 1, 4)+'.'+substring(oedtm, 5, 2)+'.'+substring(oedtm, 7,2)
        end,
      case
        when oedte = '' then '9999.12.31'
        else substring(oedte, 1, 4)+'.'+substring(oedte, 5, 2)+'.'+substring(oedte, 7,2)
        end,
      orate, ochcd, ofocd, oemno, getdate()
    from bom003
    where (oplant = 'D' and odvsn in ('M','S')) or oplant = 'K'

    -- 진천
    exec [ipisjin_svr].ipis.dbo.sp_pisi_truncate_table 'tbomoptionitem'

    insert into [ipisjin_svr].ipis.dbo.tbomoptionitem
    (Oplant, Odvsn, Opitn, Ofitn, Ochdt, Oedtm, Oedte, Orate, Ochcd, Ofocd, Oemno, LastDate)
    select oplant, odvsn, opitn, ofitn,
      substring(ochdt, 1, 4)+'.'+substring(ochdt, 5, 2)+'.'+substring(ochdt, 7,2),
      case
        when oedtm = '' then '1900.01.01'
        else substring(oedtm, 1, 4)+'.'+substring(oedtm, 5, 2)+'.'+substring(oedtm, 7,2)
        end,
      case
        when oedte = '' then '9999.12.31'
        else substring(oedte, 1, 4)+'.'+substring(oedte, 5, 2)+'.'+substring(oedte, 7,2)
        end,
      orate, ochcd, ofocd, oemno, getdate()
    from bom003
    where oplant = 'J'

    Truncate Table  bom003

    End
End   -- Procedure End
Go
