/*
  File Name : sp_mcmaster_no_down.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_mcmaster_no_down
  Description : Download 고정자산번호
        equip_master - 일간단위 갱신
        여주전자 서버추가 : 2004.04.19
        시험제작실 고정자산번호 다운로드 : 2008.09.05
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : IPIS2000
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2002. 11. 12
  Author    : Gary Kim
  Remark    :
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mcmaster_no_down]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mcmaster_no_down]
GO

/*
Execute sp_mcmaster_no_down
*/

Create  Procedure sp_mcmaster_no_down

As
Begin


if Exists (select * from fia030)
  Begin

    -- 대구 전장

    Update  [ipisele_svr\ipis].cmms.dbo.equip_master
    Set Asset_code  = ''
    Where Area_Code+Factory_code+Equip_code in
      (Select Case Fidiv
        When  'DC'  Then  'D'
        When  'DE'  Then  'D'
        When  'DW'  Then  'D'
        When  'DY'  Then  'D'
        When  'DM'  Then  'D'
        When  'DS'  Then  'D'
        When  'DH'  Then  'D'
        When  'DV'  Then  'D'
        When  'JM'  Then  'J'
        When  'JS'  Then  'J'
        When  'JH'  Then  'J'
        When  'KM'  Then  'K'
        When  'KS'  Then  'K'
        When  'KH'  Then  'K'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End +
        Case Fidiv
        When  'DC'  Then  'A'
        When  'DE'  Then  'A'
        When  'DW'  Then  'A'
        When  'DY'  Then  'A'
        When  'DM'  Then  'M'
        When  'DS'  Then  'S'
        When  'DH'  Then  'H'
        When  'DV'  Then  'V'
        When  'JM'  Then  'M'
        When  'JS'  Then  'S'
        When  'JH'  Then  'H'
        When  'KS'  Then  'S'
        When  'KH'  Then  'H'
        When  'KM'  Then  'M'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End +
        Fimchno
      From  Fia030)

    Update  [ipisele_svr\ipis].cmms.dbo.equip_master
    Set Asset_code  = b.ficode
    From  [ipisele_svr\ipis].cmms.dbo.equip_master  a,
      (Select Area_Code = Case Fidiv
        When  'DC'  Then  'D'
        When  'DE'  Then  'D'
        When  'DW'  Then  'D'
        When  'DY'  Then  'D'
        When  'DM'  Then  'D'
        When  'DS'  Then  'D'
        When  'DH'  Then  'D'
        When  'DV'  Then  'D'
        When  'JM'  Then  'J'
        When  'JS'  Then  'J'
        When  'JH'  Then  'J'
        When  'KM'  Then  'K'
        When  'KS'  Then  'K'
        When  'KH'  Then  'K'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End,
        Factory_code  = Case Fidiv
        When  'DC'  Then  'A'
        When  'DE'  Then  'A'
        When  'DW'  Then  'A'
        When  'DY'  Then  'A'
        When  'DM'  Then  'M'
        When  'DS'  Then  'S'
        When  'DH'  Then  'H'
        When  'DV'  Then  'V'
        When  'JM'  Then  'M'
        When  'JS'  Then  'S'
        When  'JH'  Then  'H'
        When  'KS'  Then  'S'
        When  'KH'  Then  'H'
        When  'KM'  Then  'M'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End,
        Fimchno,
        Ficode
      From  Fia030) b
    Where a.Area_Code = b.Area_Code and
      a.Factory_code  = b.Factory_code  and
      a.Equip_code  = b.Fimchno

    -- 대구 시험제작실
    Update [ipisele_svr\ipis].cmms.dbo.equip_master
    Set asset_code = bb.ficode
    From [ipisele_svr\ipis].cmms.dbo.equip_master aa inner join
      ( select fimchno, max(ficode) as ficode from fia030
        group by fimchno ) bb on aa.equip_code = bb.fimchno
    Where aa.area_code = 'D' and aa.factory_code = 'R'

    -- 대구 기계

    Update  [ipismac_svr\ipis].cmms.dbo.equip_master
    Set Asset_code  = ''
    Where Area_Code+Factory_code+Equip_code in
      (Select Case Fidiv
        When  'DC'  Then  'D'
        When  'DE'  Then  'D'
        When  'DW'  Then  'D'
        When  'DY'  Then  'D'
        When  'DM'  Then  'D'
        When  'DS'  Then  'D'
        When  'DH'  Then  'D'
        When  'DV'  Then  'D'
        When  'JM'  Then  'J'
        When  'JS'  Then  'J'
        When  'JH'  Then  'J'
        When  'KM'  Then  'K'
        When  'KS'  Then  'K'
        When  'KH'  Then  'K'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End +
        Case Fidiv
        When  'DC'  Then  'A'
        When  'DE'  Then  'A'
        When  'DW'  Then  'A'
        When  'DY'  Then  'A'
        When  'DM'  Then  'M'
        When  'DS'  Then  'S'
        When  'DH'  Then  'H'
        When  'DV'  Then  'V'
        When  'JM'  Then  'M'
        When  'JS'  Then  'S'
        When  'JH'  Then  'H'
        When  'KS'  Then  'S'
        When  'KH'  Then  'H'
        When  'KM'  Then  'M'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End +
        Fimchno
      From  Fia030)

    Update  [ipismac_svr\ipis].cmms.dbo.equip_master
    Set Asset_code  = b.ficode
    From  [ipismac_svr\ipis].cmms.dbo.equip_master  a,
      (Select Area_Code = Case Fidiv
        When  'DC'  Then  'D'
        When  'DE'  Then  'D'
        When  'DW'  Then  'D'
        When  'DY'  Then  'D'
        When  'DM'  Then  'D'
        When  'DS'  Then  'D'
        When  'DH'  Then  'D'
        When  'DV'  Then  'D'
        When  'JM'  Then  'J'
        When  'JS'  Then  'J'
        When  'JH'  Then  'J'
        When  'KM'  Then  'K'
        When  'KS'  Then  'K'
        When  'KH'  Then  'K'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End,
        Factory_code  = Case Fidiv
        When  'DC'  Then  'A'
        When  'DE'  Then  'A'
        When  'DW'  Then  'A'
        When  'DY'  Then  'A'
        When  'DM'  Then  'M'
        When  'DS'  Then  'S'
        When  'DH'  Then  'H'
        When  'DV'  Then  'V'
        When  'JM'  Then  'M'
        When  'JS'  Then  'S'
        When  'JH'  Then  'H'
        When  'KS'  Then  'S'
        When  'KH'  Then  'H'
        When  'KM'  Then  'M'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End,
        Fimchno,
        Ficode
      From  Fia030) b
    Where a.Area_Code = b.Area_Code and
      a.Factory_code  = b.Factory_code  and
      a.Equip_code  = b.Fimchno


    -- 대구 공조


    Update  [ipishvac_svr\ipis].cmms.dbo.equip_master
    Set Asset_code  = ''
    Where Area_Code+Factory_code+Equip_code in
      (Select Case Fidiv
        When  'DC'  Then  'D'
        When  'DE'  Then  'D'
        When  'DW'  Then  'D'
        When  'DY'  Then  'D'
        When  'DM'  Then  'D'
        When  'DS'  Then  'D'
        When  'DH'  Then  'D'
        When  'DV'  Then  'D'
        When  'JM'  Then  'J'
        When  'JS'  Then  'J'
        When  'JH'  Then  'J'
        When  'KM'  Then  'K'
        When  'KS'  Then  'K'
        When  'KH'  Then  'K'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End +
        Case Fidiv
        When  'DC'  Then  'A'
        When  'DE'  Then  'A'
        When  'DW'  Then  'A'
        When  'DY'  Then  'A'
        When  'DM'  Then  'M'
        When  'DS'  Then  'S'
        When  'DH'  Then  'H'
        When  'DV'  Then  'V'
        When  'JM'  Then  'M'
        When  'JS'  Then  'S'
        When  'JH'  Then  'H'
        When  'KS'  Then  'S'
        When  'KH'  Then  'H'
        When  'KM'  Then  'M'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End +
        Fimchno
      From  Fia030)

    Update  [ipishvac_svr\ipis].cmms.dbo.equip_master
    Set Asset_code  = b.ficode
    From  [ipishvac_svr\ipis].cmms.dbo.equip_master a,
      (Select Area_Code = Case Fidiv
      When  'DC'  Then  'D'
        When  'DE'  Then  'D'
        When  'DW'  Then  'D'
        When  'DY'  Then  'D'
        When  'DM'  Then  'D'
        When  'DS'  Then  'D'
        When  'DH'  Then  'D'
        When  'DV'  Then  'D'
        When  'JM'  Then  'J'
        When  'JS'  Then  'J'
        When  'JH'  Then  'J'
        When  'KM'  Then  'K'
        When  'KS'  Then  'K'
        When  'KH'  Then  'K'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
      End,
      Factory_code  = Case Fidiv
      When  'DC'  Then  'A'
        When  'DE'  Then  'A'
        When  'DW'  Then  'A'
        When  'DY'  Then  'A'
        When  'DM'  Then  'M'
        When  'DS'  Then  'S'
        When  'DH'  Then  'H'
        When  'DV'  Then  'V'
        When  'JM'  Then  'M'
        When  'JS'  Then  'S'
        When  'JH'  Then  'H'
        When  'KS'  Then  'S'
        When  'KH'  Then  'H'
        When  'KM'  Then  'M'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
      End,
      Fimchno,
      Ficode
      From  Fia030) b
    Where a.Area_Code = b.Area_Code and
      a.Factory_code  = b.Factory_code  and
      a.Equip_code  = b.Fimchno

    -- 여주전자


    Update  [ipisyeo_svr\ipis].cmms.dbo.equip_master
    Set Asset_code  = ''
    Where Area_Code+Factory_code+Equip_code in
      (Select Case Fidiv
        When  'DC'  Then  'D'
        When  'DE'  Then  'D'
        When  'DW'  Then  'D'
        When  'DY'  Then  'D'
        When  'DM'  Then  'D'
        When  'DS'  Then  'D'
        When  'DH'  Then  'D'
        When  'DV'  Then  'D'
        When  'JM'  Then  'J'
        When  'JS'  Then  'J'
        When  'JH'  Then  'J'
        When  'KM'  Then  'K'
        When  'KS'  Then  'K'
        When  'KH'  Then  'K'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End +
        Case Fidiv
        When  'DC'  Then  'A'
        When  'DE'  Then  'A'
        When  'DW'  Then  'A'
        When  'DY'  Then  'A'
        When  'DM'  Then  'M'
        When  'DS'  Then  'S'
        When  'DH'  Then  'H'
        When  'DV'  Then  'V'
        When  'JM'  Then  'M'
        When  'JS'  Then  'S'
        When  'JH'  Then  'H'
        When  'KS'  Then  'S'
        When  'KH'  Then  'H'
        When  'KM'  Then  'M'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End +
        Fimchno
      From  Fia030)

    Update  [ipisyeo_svr\ipis].cmms.dbo.equip_master
    Set Asset_code  = b.ficode
    From  [ipisyeo_svr\ipis].cmms.dbo.equip_master  a,
      (Select Area_Code = Case Fidiv
        When  'DC'  Then  'D'
        When  'DE'  Then  'D'
        When  'DW'  Then  'D'
        When  'DY'  Then  'D'
        When  'DM'  Then  'D'
        When  'DS'  Then  'D'
        When  'DH'  Then  'D'
        When  'DV'  Then  'D'
        When  'JM'  Then  'J'
        When  'JS'  Then  'J'
        When  'JH'  Then  'J'
        When  'KM'  Then  'K'
        When  'KS'  Then  'K'
        When  'KH'  Then  'K'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End,
        Factory_code  = Case Fidiv
        When  'DC'  Then  'A'
        When  'DE'  Then  'A'
        When  'DW'  Then  'A'
        When  'DY'  Then  'A'
        When  'DM'  Then  'M'
        When  'DS'  Then  'S'
        When  'DH'  Then  'H'
        When  'DV'  Then  'V'
        When  'JM'  Then  'M'
        When  'JS'  Then  'S'
        When  'JH'  Then  'H'
        When  'KS'  Then  'S'
        When  'KH'  Then  'H'
        When  'KM'  Then  'M'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End,
        Fimchno,
        Ficode
      From  Fia030) b
    Where a.Area_Code = b.Area_Code and
      a.Factory_code  = b.Factory_code  and
      a.Equip_code  = b.Fimchno

    -- 진천

    Update  [ipisjin_svr].cmms.dbo.equip_master
    Set Asset_code  = ''
    Where Area_Code+Factory_code+Equip_code in
      (Select Case Fidiv
        When  'DC'  Then  'D'
        When  'DE'  Then  'D'
        When  'DW'  Then  'D'
        When  'DY'  Then  'D'
        When  'DM'  Then  'D'
        When  'DS'  Then  'D'
        When  'DH'  Then  'D'
        When  'DV'  Then  'D'
        When  'JM'  Then  'J'
        When  'JS'  Then  'J'
        When  'JH'  Then  'J'
        When  'KM'  Then  'K'
        When  'KS'  Then  'K'
        When  'KH'  Then  'K'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End +
        Case Fidiv
        When  'DC'  Then  'A'
        When  'DE'  Then  'A'
        When  'DW'  Then  'A'
        When  'DY'  Then  'A'
        When  'DM'  Then  'M'
        When  'DS'  Then  'S'
        When  'DH'  Then  'H'
        When  'DV'  Then  'V'
        When  'JM'  Then  'M'
        When  'JS'  Then  'S'
        When  'JH'  Then  'H'
        When  'KS'  Then  'S'
        When  'KH'  Then  'H'
        When  'KM'  Then  'M'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End +
        Fimchno
      From  Fia030)

    Update  [ipisjin_svr].cmms.dbo.equip_master
    Set Asset_code  = b.ficode
    From  [ipisjin_svr].cmms.dbo.equip_master a,
      (Select Area_Code = Case Fidiv
        When  'DC'  Then  'D'
        When  'DE'  Then  'D'
        When  'DW'  Then  'D'
        When  'DY'  Then  'D'
        When  'DM'  Then  'D'
        When  'DS'  Then  'D'
        When  'DH'  Then  'D'
        When  'DV'  Then  'D'
        When  'JM'  Then  'J'
        When  'JS'  Then  'J'
        When  'JH'  Then  'J'
        When  'KM'  Then  'K'
        When  'KS'  Then  'K'
        When  'KH'  Then  'K'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End,
        Factory_code  = Case Fidiv
        When  'DC'  Then  'A'
        When  'DE'  Then  'A'
        When  'DW'  Then  'A'
        When  'DY'  Then  'A'
        When  'DM'  Then  'M'
        When  'DS'  Then  'S'
        When  'DH'  Then  'H'
        When  'DV'  Then  'V'
        When  'JM'  Then  'M'
        When  'JS'  Then  'S'
        When  'JH'  Then  'H'
        When  'KS'  Then  'S'
        When  'KH'  Then  'H'
        When  'KM'  Then  'M'
        When  'YD'  Then  'Y'
        When  'YX'  Then  'Y'
        When  'YH'  Then  'Y'
        Else  'X'
        End,
        Fimchno,
        Ficode
      From  Fia030) b
    Where a.Area_Code = b.Area_Code and
      a.Factory_code  = b.Factory_code  and
      a.Equip_code  = b.Fimchno

    Truncate table fia030
  end

End   -- Procedure End

GO
