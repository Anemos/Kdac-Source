/*
  File Name : sp_down_ipis_mis_sle101.SQL
  SYSTEM    : Interface System
  Procedure Name  : sp_down_ipis_mis_sle101
  Description : 거래처별품목현황, 대구전장인터페이스 JOB Schedule
  Use DataBase  : IPIS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2007.05
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_down_ipis_mis_sle101]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_down_ipis_mis_sle101]
GO

/*
Execute sp_down_ipis_mis_sle101
*/

Create Procedure sp_down_ipis_mis_sle101

As
Begin

SET XACT_ABORT OFF

Declare @i      Int,
  @li_loop_count    Int,
  @ls_chgcd   char(1),
  @ls_area    char(1),
  @ls_division    char(1),
  @ls_custcd    char(6),
  @ls_citno   varchar(20),
  @ls_citnm   varchar(30),
  @ls_itno    varchar(12),
  @ls_chgdate   varchar(30)

Select  *
into  #tmp_pdsle101
from  tmissle101
Order By  chgdate


Select @i = 0, @li_loop_count = @@RowCount, @ls_chgdate = ''


While @i < @li_loop_count
Begin

  Select  Top 1
    @i    = @i + 1,
    @ls_chgdate = chgdate,
    @ls_chgcd = chgcd,
    @ls_area  = xplant,
    @ls_division  = div,
    @ls_custcd  = custcd,
    @ls_citno = citno,
    @ls_citnm = citnm,
    @ls_itno  = itno
  From  #tmp_pdsle101
  Where chgdate > @ls_chgdate

  if exists (select * From tmissle101
     Where  Chgdate < @ls_Chgdate and
        custcd  = @ls_custcd  and
        citno   = @ls_citno)
       Begin
     Continue
     End

  If @ls_chgcd = 'C' or @ls_chgcd = 'U'   -- 추가 또는 수정
  Begin

    If @ls_area = 'D' and @ls_division = 'A'
      Begin
      if Not Exists (select * From [ipisele_svr\ipis].ipis.dbo.tmstcustitem
           Where  custcode  = @ls_custcd  and
              custitemcode  = @ls_citno)
        Begin
        Insert Into [ipisele_svr\ipis].ipis.dbo.tmstcustitem
            (CustCode,  CustItemCode, CustItemName,
            AreaCode, DivisionCode, ItemCode,
            LastEmp)
          Values (@ls_custcd, @ls_citno,  @ls_citnm,
            @ls_area, @ls_division, @ls_itno,
            'SYSTEM')

        if @@error <> 0
          Begin
          Continue
          End

        delete  from tmissle101
        where   chgdate   = @ls_Chgdate and
          custcd+citno  in
          (Select Custcode+CustitemCode
            From  [ipisele_svr\ipis].ipis.dbo.tmstcustitem
            Where Custcode  = @ls_custcd  and
              CustitemCode  = @ls_citno)

          if @@error <> 0
            Begin
            Continue
            End

        End
      Else
        Begin
        Update  [ipisele_svr\ipis].ipis.dbo.tmstcustitem
        Set Areacode  = @ls_area,
          DivisionCode  = @ls_division,
          CustItemName  = @ls_citnm,
          ItemCode  = @ls_itno,
          LastDate  = Getdate()
        Where Custcode  = @ls_custcd  and
          custitemcode  = @ls_citno

        if @@error <> 0
          Begin
          Continue
          End

        If Exists (Select * From
              [ipisele_svr\ipis].ipis.dbo.tmstcustitem
            Where Custcode  = @ls_custcd  and
              CustitemCode  = @ls_citno and
              Areacode  = @ls_area  and
              DivisionCode  = @ls_division  and
              CustItemName  = @ls_citnm and
              ItemCode  = @ls_itno)
            begin
            delete  from tmissle101
              where   chgdate   = @ls_Chgdate

            if @@error <> 0
              Begin
              Continue
              End

            end

        End
      End

    If @ls_area = 'D' and (@ls_division = 'M' or @ls_division = 'S')
      Begin
      if Not Exists (select * From  [ipismac_svr\ipis].ipis.dbo.tmstcustitem
           Where  custcode  = @ls_custcd  and
              CustItemCode  = @ls_citno)
        Begin
        Insert Into [ipismac_svr\ipis].ipis.dbo.tmstcustitem
            (CustCode,  CustItemCode, CustItemName,
            AreaCode, DivisionCode, ItemCode,
            LastEmp)
          Values (@ls_custcd, @ls_citno,  @ls_citnm,
            @ls_area, @ls_division, @ls_itno,
            'SYSTEM')

        if @@error <> 0
          Begin
          Continue
          End

        delete  from tmissle101
        where   chgdate   = @ls_Chgdate and
          custcd+citno  in
          (Select Custcode+CustitemCode
            From  [ipismac_svr\ipis].ipis.dbo.tmstcustitem
            Where Custcode  = @ls_custcd  and
              CustitemCode  = @ls_citno)

        if @@error <> 0
          Begin
          Continue
          End

        End
      Else
        Begin
        Update  [ipismac_svr\ipis].ipis.dbo.tmstcustitem
        Set Areacode  = @ls_area,
          DivisionCode  = @ls_division,
          CustItemName  = @ls_citnm,
          ItemCode  = @ls_itno,
          LastDate  = Getdate()
        Where Custcode  = @ls_custcd  and
          custitemcode  = @ls_citno

        if @@error <> 0
          Begin
          Continue
          End

        If Exists (Select * From
              [ipismac_svr\ipis].ipis.dbo.tmstcustitem
            Where Custcode  = @ls_custcd  and
              CustitemCode  = @ls_citno and
              Areacode  = @ls_area  and
              DivisionCode  = @ls_division  and
              CustItemName  = @ls_citnm and
              ItemCode  = @ls_itno)
            begin
            delete  from tmissle101
              where   chgdate   = @ls_Chgdate

            if @@error <> 0
              Begin
              Continue
              End

            end


        End
      End

    If (@ls_area = 'D' and (@ls_division = 'H' or @ls_division = 'V'))
      Begin
      if Not Exists (select * From  [ipishvac_svr\ipis].ipis.dbo.tmstcustitem
           Where  custcode  = @ls_custcd  and
              custitemcode  = @ls_citno)
        Begin
        Insert Into [ipishvac_svr\ipis].ipis.dbo.tmstcustitem
            (CustCode,  CustItemCode, CustItemName,
            AreaCode, DivisionCode, ItemCode,
            LastEmp)
          Values (@ls_custcd, @ls_citno,  @ls_citnm,
            @ls_area, @ls_division, @ls_itno,
            'SYSTEM')

        if @@error <> 0
          Begin
          Continue
          End

        delete  from tmissle101
        where   chgdate   = @ls_Chgdate and
          custcd+citno  in
          (Select Custcode+CustitemCode
            From  [ipishvac_svr\ipis].ipis.dbo.tmstcustitem
            Where Custcode  = @ls_custcd  and
              CustitemCode  = @ls_citno)

        if @@error <> 0
          Begin
          Continue
          End

        End
      Else
        Begin
        Update  [ipishvac_svr\ipis].ipis.dbo.tmstcustitem
        Set Areacode  = @ls_area,
          DivisionCode  = @ls_division,
          CustItemName  = @ls_citnm,
          ItemCode  = @ls_itno,
          LastDate  = Getdate()
        Where Custcode  = @ls_custcd  and
          custitemcode  = @ls_citno

        if @@error <> 0
          Begin
          Continue
          End

        If Exists (Select * From
              [ipishvac_svr\ipis].ipis.dbo.tmstcustitem
            Where Custcode  = @ls_custcd  and
              CustitemCode  = @ls_citno and
              Areacode  = @ls_area  and
              DivisionCode  = @ls_division  and
              CustItemName  = @ls_citnm and
              ItemCode  = @ls_itno)
            begin
            delete  from tmissle101
              where   chgdate   = @ls_Chgdate

            if @@error <> 0
              Begin
              Continue
              End

            end
        End
      End

    -- 부평물류
      if Not Exists (select * From  [ipisbup_svr\ipis].ipis.dbo.tmstcustitem
           Where  custcode  = @ls_custcd  and
              custitemcode  = @ls_citno)
        Begin
        Insert Into [ipisbup_svr\ipis].ipis.dbo.tmstcustitem
            (CustCode,  CustItemCode, CustItemName,
            AreaCode, DivisionCode, ItemCode,
            LastEmp)
          Values (@ls_custcd, @ls_citno,  @ls_citnm,
            @ls_area, @ls_division, @ls_itno,
            'SYSTEM')

        if @@error <> 0
          Begin
          Continue
          End

        delete  from tmissle101
        where   chgdate   = @ls_Chgdate and
          custcd+citno  in
          (Select Custcode+CustitemCode
            From  [ipisbup_svr\ipis].ipis.dbo.tmstcustitem
            Where Custcode  = @ls_custcd  and
              CustitemCode  = @ls_citno)

        if @@error <> 0
          Begin
          Continue
          End

        End
      Else
        Begin
        Update  [ipisbup_svr\ipis].ipis.dbo.tmstcustitem
        Set Areacode  = @ls_area,
          DivisionCode  = @ls_division,
          CustItemName  = @ls_citnm,
          ItemCode  = @ls_itno,
          LastDate  = Getdate()
        Where Custcode  = @ls_custcd  and
          custitemcode  = @ls_citno

        if @@error <> 0
          Begin
          Continue
          End

        If Exists (Select * From
              [ipisbup_svr\ipis].ipis.dbo.tmstcustitem
            Where Custcode  = @ls_custcd  and
              CustitemCode  = @ls_citno and
              Areacode  = @ls_area  and
              DivisionCode  = @ls_division  and
              CustItemName  = @ls_citnm and
              ItemCode  = @ls_itno)
            begin
            delete  from tmissle101
              where   chgdate   = @ls_Chgdate

            if @@error <> 0
              Begin
              Continue
              End

            end
        End

    -- 군산물류
      if Not Exists (select * From  [ipiskun_svr\ipis].ipis.dbo.tmstcustitem
           Where  custcode  = @ls_custcd  and
              custitemcode  = @ls_citno)
        Begin
        Insert Into [ipiskun_svr\ipis].ipis.dbo.tmstcustitem
            (CustCode,  CustItemCode, CustItemName,
            AreaCode, DivisionCode, ItemCode,
            LastEmp)
          Values (@ls_custcd, @ls_citno,  @ls_citnm,
            @ls_area, @ls_division, @ls_itno,
            'SYSTEM')

        if @@error <> 0
          Begin
          Continue
          End

        delete  from tmissle101
        where   chgdate   = @ls_Chgdate and
          custcd+citno  in
          (Select Custcode+CustitemCode
            From  [ipiskun_svr\ipis].ipis.dbo.tmstcustitem
            Where Custcode  = @ls_custcd  and
              CustitemCode  = @ls_citno)

        if @@error <> 0
          Begin
          Continue
          End

        End
      Else
        Begin
        Update  [ipiskun_svr\ipis].ipis.dbo.tmstcustitem
        Set Areacode  = @ls_area,
          DivisionCode  = @ls_division,
          CustItemName  = @ls_citnm,
          ItemCode  = @ls_itno,
          LastDate  = Getdate()
        Where Custcode  = @ls_custcd  and
          custitemcode  = @ls_citno

        if @@error <> 0
          Begin
          Continue
          End

        If Exists (Select * From
              [ipiskun_svr\ipis].ipis.dbo.tmstcustitem
            Where Custcode  = @ls_custcd  and
              CustitemCode  = @ls_citno and
              Areacode  = @ls_area  and
              DivisionCode  = @ls_division  and
              CustItemName  = @ls_citnm and
              ItemCode  = @ls_itno)
            begin
            delete  from tmissle101
              where   chgdate   = @ls_Chgdate

            if @@error <> 0
              Begin
              Continue
              End

            end
        End

    -- 여주전자
    If @ls_area = 'Y'
      Begin
      if Not Exists (select * From  [ipisyeo_svr\ipis].ipis.dbo.tmstcustitem
           Where  custcode  = @ls_custcd  and
              custitemcode  = @ls_citno)
        Begin
        Insert Into [ipisyeo_svr\ipis].ipis.dbo.tmstcustitem
            (CustCode,  CustItemCode, CustItemName,
            AreaCode, DivisionCode, ItemCode,
            LastEmp)
          Values (@ls_custcd, @ls_citno,  @ls_citnm,
            @ls_area, @ls_division, @ls_itno,
            'SYSTEM')

        if @@error <> 0
          Begin
          Continue
          End

        delete  from tmissle101
        where   chgdate   = @ls_Chgdate and
          custcd+citno  in
          (Select Custcode+CustitemCode
            From  [ipisyeo_svr\ipis].ipis.dbo.tmstcustitem
            Where Custcode  = @ls_custcd  and
              CustitemCode  = @ls_citno)

        if @@error <> 0
          Begin
          Continue
          End

        End
      Else
        Begin
        Update  [ipisyeo_svr\ipis].ipis.dbo.tmstcustitem
        Set Areacode  = @ls_area,
          DivisionCode  = @ls_division,
          CustItemName  = @ls_citnm,
          ItemCode  = @ls_itno,
          LastDate  = Getdate()
        Where Custcode  = @ls_custcd  and
          custitemcode  = @ls_citno

        if @@error <> 0
          Begin
          Continue
          End

        If Exists (Select * From
              [ipisyeo_svr\ipis].ipis.dbo.tmstcustitem
            Where Custcode  = @ls_custcd  and
              CustitemCode  = @ls_citno and
              Areacode  = @ls_area  and
              DivisionCode  = @ls_division  and
              CustItemName  = @ls_citnm and
              ItemCode  = @ls_itno)
            begin
            delete  from tmissle101
              where   chgdate   = @ls_Chgdate

            if @@error <> 0
              Begin
              Continue
              End

            end
        End
      End

    If @ls_area = 'J'
      Begin
      if Not Exists (select * From  [ipisjin_svr].ipis.dbo.tmstcustitem
           Where  custcode  = @ls_custcd  and
              custitemcode  = @ls_citno)
        Begin
        Insert Into [ipisjin_svr].ipis.dbo.tmstcustitem
            (CustCode,  CustItemCode, CustItemName,
            AreaCode, DivisionCode, ItemCode,
            LastEmp)
          Values (@ls_custcd, @ls_citno,  @ls_citnm,
            @ls_area, @ls_division, @ls_itno,
            'SYSTEM')

        if @@error <> 0
          Begin
          Continue
          End

        delete  from tmissle101
        where   chgdate   = @ls_Chgdate and
          custcd+citno  in
          (Select Custcode+CustitemCode
            From  [ipisjin_svr].ipis.dbo.tmstcustitem
            Where Custcode  = @ls_custcd  and
              CustitemCode  = @ls_citno)

        if @@error <> 0
          Begin
          Continue
          End

        End
      Else
        Begin
        Update  [ipisjin_svr].ipis.dbo.tmstcustitem
        Set Areacode  = @ls_area,
          DivisionCode  = @ls_division,
          CustItemName  = @ls_citnm,
          ItemCode  = @ls_itno,
          LastDate  = Getdate()
        Where Custcode  = @ls_custcd  and
          custitemcode  = @ls_citno

        if @@error <> 0
          Begin
          Continue
          End

        If Exists (Select * From
              [ipisjin_svr].ipis.dbo.tmstcustitem
            Where Custcode  = @ls_custcd  and
              CustitemCode  = @ls_citno and
              Areacode  = @ls_area  and
              DivisionCode  = @ls_division  and
              CustItemName  = @ls_citnm and
              ItemCode  = @ls_itno)
            begin
            delete  from tmissle101
              where   chgdate   = @ls_Chgdate

            if @@error <> 0
              Begin
              Continue
              End

            end
        End
      End


  End -- If @ls_chgcd = 'C'or 'U' End

  If @ls_chgcd = 'D'  -- 삭제
  Begin

    If @ls_area = 'D' and @ls_Division = 'A'
      Begin
      Delete  from [ipisele_svr\ipis].ipis.dbo.tmstcustitem
        Where custcode  = @ls_custcd  and
          custitemcode  = @ls_citno

      if @@error <> 0
        Begin
        Continue
        End

      If Not Exists (Select * From
            [ipisele_svr\ipis].ipis.dbo.tmstcustitem
          Where Custcode  = @ls_custcd  and
            CustitemCode  = @ls_citno)
        begin
        delete  from tmissle101
          where   chgdate   = @ls_Chgdate

        if @@error <> 0
          Begin
          Continue
          End

        end
      End

    If @ls_area = 'D' and (@ls_division = 'M' or @ls_division = 'S')
      Begin
      Delete  from [ipismac_svr\ipis].ipis.dbo.tmstcustitem
      Where custcode  = @ls_custcd  and
        custitemcode  = @ls_citno

      if @@error <> 0
        Begin
        Continue
        End

      If Not Exists (Select * From
            [ipismac_svr\ipis].ipis.dbo.tmstcustitem
          Where Custcode  = @ls_custcd  and
            CustitemCode  = @ls_citno)
        begin
        delete  from tmissle101
          where   chgdate   = @ls_Chgdate

        if @@error <> 0
          Begin
          Continue
          End

        end
      End

    If (@ls_area = 'D' and  (@ls_division = 'H' or @ls_division = 'V'))
      Begin
      Delete  from [ipishvac_svr\ipis].ipis.dbo.tmstcustitem
      Where custcode  = @ls_custcd  and
        custitemcode  = @ls_citno

      if @@error <> 0
        Begin
        Continue
        End

      If Not Exists (Select * From
            [ipishvac_svr\ipis].ipis.dbo.tmstcustitem
          Where Custcode  = @ls_custcd  and
            CustitemCode  = @ls_citno)
        begin
        delete  from tmissle101
          where   chgdate   = @ls_Chgdate

        if @@error <> 0
          Begin
          Continue
          End

        end
      End

    If @ls_area = 'B'
      Begin
      Delete  from [ipisbup_svr\ipis].ipis.dbo.tmstcustitem
      Where custcode  = @ls_custcd  and
        custitemcode  = @ls_citno

      if @@error <> 0
        Begin
        Continue
        End

      If Not Exists (Select * From
            [ipisbup_svr\ipis].ipis.dbo.tmstcustitem
          Where Custcode  = @ls_custcd  and
            CustitemCode  = @ls_citno)
        begin
        delete  from tmissle101
          where   chgdate   = @ls_Chgdate

        if @@error <> 0
          Begin
          Continue
          End

        end
      End

    If @ls_area = 'K'
      Begin
      Delete  from [ipiskun_svr\ipis].ipis.dbo.tmstcustitem
      Where custcode  = @ls_custcd  and
        custitemcode  = @ls_citno

      if @@error <> 0
        Begin
        Continue
        End

      If Not Exists (Select * From
            [ipiskun_svr\ipis].ipis.dbo.tmstcustitem
          Where Custcode  = @ls_custcd  and
            CustitemCode  = @ls_citno)
        begin
        delete  from tmissle101
          where   chgdate   = @ls_Chgdate

        if @@error <> 0
          Begin
          Continue
          End

        end
      End

    If @ls_area = 'Y'
      Begin
      Delete  from [ipisyeo_svr\ipis].ipis.dbo.tmstcustitem
      Where custcode  = @ls_custcd  and
        custitemcode  = @ls_citno

      if @@error <> 0
        Begin
        Continue
        End

      If Not Exists (Select * From
            [ipisyeo_svr\ipis].ipis.dbo.tmstcustitem
          Where Custcode  = @ls_custcd  and
            CustitemCode  = @ls_citno)
        begin
        delete  from tmissle101
          where   chgdate   = @ls_Chgdate

        if @@error <> 0
          Begin
          Continue
          End

        end
      End

    If @ls_area = 'J'
      Begin
      Delete  from [ipisjin_svr].ipis.dbo.tmstcustitem
      Where custcode  = @ls_custcd and
        custitemcode  = @ls_citno

      if @@error <> 0
        Begin
        Continue
        End

        If Not Exists (Select * From
            [ipisjin_svr].ipis.dbo.tmstcustitem
          Where Custcode  = @ls_custcd  and
            CustitemCode  = @ls_citno)
        begin
        delete  from tmissle101
          where   chgdate   = @ls_Chgdate

        if @@error <> 0
          Begin
          Continue
          End

        end
      End

  End -- If @ls_chgcd = 'D' End

End     -- While Loop End

if (select count(*) from tmissle101) = 0
  begin
    truncate table tmissle101
  end

Drop table #tmp_pdsle101

End   -- Procedure End
Go
