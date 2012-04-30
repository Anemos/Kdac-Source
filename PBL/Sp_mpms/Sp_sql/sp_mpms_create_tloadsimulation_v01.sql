/*
  File Name : sp_mpms_create_tloadsimulation.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_create_tloadsimulation
  Description : 납기정보생성
  Use DataBase  : MPMS
  Use Program :
  Use Table : tloadpriority, tloadavailtime, tloadsimulation
  Parameter :
  Initial   : 2010.06.07
  Author    : Kiss Kim
*/


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_create_tloadsimulation]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_create_tloadsimulation]
GO

/*
Execute sp_mpms_create_tloadsimulation
select * from tloadpriority

update tloadpriority
set allottime = 0, outworkdate = '', loadflag = 'N'

select * from tloadavailtime
select * from tloadsimulation
*/

Create Procedure sp_mpms_create_tloadsimulation

As
Begin

declare @ls_refdate varchar(10), @ls_orderno char(8), @ls_partno char(6)
declare @ls_chk_orderno char(8), @ls_chk_partno char(6)
declare @ls_operno char(3), @ls_postoperno char(3), @ls_wccode char(3)
declare @li_remaintime int, @ls_outflag char(1)
declare @li_check int, @li_index int, @li_count int, @li_serialno int
declare @li_stdtime int, @li_allottime int, @li_resulttime int

Execute sp_mpms_create_tloadpriority 
delete from tloadavailtime
delete from tloadsimulation

select @ls_refdate = convert(varchar(10), dateadd(day,1,getdate()), 102)
select @li_check = count(*) from tloadpriority where loadflag = 'N'

while @li_check > 0
  Begin
    select @li_index = 0
    
    exec sp_mpms_create_tloadavailtime @ls_refdate
    -- 외주공정 처리
    select @li_serialno = 0
    select @ls_chk_orderno = ''
    select @ls_chk_partno = ''
    
    select @li_index = DATEPART(WEEKDAY,cast(@ls_refdate as datetime))
    while ( @li_index <> 1 and @li_index <> 7 )
      Begin
        SELECT TOP 1 @li_serialno = SerialNo,
          @ls_orderno = OrderNo,
          @ls_partno = PartNo,
          @ls_operno = OperNo,
          @ls_wccode = WcCode,
          @li_stdtime = StdTimeSum,
          @li_allottime = AllotTime
        FROM TLOADPRIORITY A
        WHERE A.OutFlag = 'P' AND A.SerialNo > @li_serialno AND
          A.LOADFLAG = 'N' AND
          ( A.PREOPERNO IS NULL OR
          EXISTS ( SELECT * FROM TLOADPRIORITY B
            WHERE A.ORDERNO = B.ORDERNO AND A.PARTNO = B.PARTNO AND
              A.PREOPERNO = B.OPERNO AND B.LOADFLAG = 'Y' ))
        ORDER BY A.SERIALNO
        
        if @@rowcount = 0
          break
        
        if @ls_orderno <> @ls_chk_orderno or @ls_chk_partno <> @ls_partno
          Begin
            select @li_resulttime = 480
          End
        
        select @ls_chk_orderno = @ls_orderno
        select @ls_chk_partno = @ls_partno
        
        if (@li_resulttime - (@li_stdtime - @li_allottime)) > 0
          Begin
            select @li_resulttime = @li_resulttime - (@li_stdtime - @li_allottime)
            
            UPDATE TLOADPRIORITY
            SET LoadFlag = 'Y',
                AllotTime = AllotTime + (StdTimeSum - AllotTime),
                InWorkDate = case when allottime = 0 then @ls_refdate else InWorkDate end,
                OutWorkDate = @ls_refdate
            WHERE SerialNo = @li_serialno
            
            INSERT INTO TLOADSIMULATION
            ( PlanDate,SerialNo,OrderNo,PartNo,OperNo,
              WcCode,RemainTime,AllotTime,LoadFlag,LastEmp,LastDate )
            VALUES(@ls_refdate,@li_serialno,@ls_orderno,@ls_partno,@ls_operno,
              @ls_wccode,@li_resulttime,(@li_stdtime - @li_allottime),'Y','A',getdate())
          End
        else
          Begin
            
            UPDATE TLOADPRIORITY
            SET AllotTime = AllotTime + @li_resulttime,
              InWorkDate = case when allottime = 0 then @ls_refdate else InWorkDate end,
              OutWorkDate = @ls_refdate
            WHERE SerialNo = @li_serialno
            
            INSERT INTO TLOADSIMULATION
            ( PlanDate,SerialNo,OrderNo,PartNo,OperNo,
              WcCode,RemainTime,AllotTime,LoadFlag,LastEmp,LastDate )
            VALUES(@ls_refdate,@li_serialno,@ls_orderno,@ls_partno,@ls_operno,
              @ls_wccode,@li_resulttime,@li_resulttime,'N','B',getdate())
            
            select @li_resulttime = 0
          End
      End
    -- 사내가공 처리 ORDER 우선순위로 처리
    select @li_serialno = 0
    select @li_index = 0
    while @li_index = 0
      Begin
      
        SELECT TOP 1 @li_serialno = A.SerialNo,
          @ls_orderno = A.OrderNo,
          @ls_partno = A.PartNo,
          @ls_operno = A.OperNo,
          @ls_wccode = A.WcCode,
          @ls_postoperno = A.PostOperNo,
          @li_stdtime = isnull(A.StdTimeSum,0),
          @li_allottime = isnull(A.AllotTime,0),
          @ls_outflag = A.OutFlag
        FROM TLOADPRIORITY A
        WHERE A.OutFlag <> 'P' AND A.LOADFLAG = 'N' AND 
           A.OUTWORKDATE <> @ls_refdate AND A.SERIALNO > @li_serialno AND
          ( A.PREOPERNO IS NULL OR
          EXISTS ( SELECT * FROM TLOADPRIORITY B
            WHERE A.ORDERNO = B.ORDERNO AND A.PARTNO = B.PARTNO AND
              A.PREOPERNO = B.OPERNO AND B.LOADFLAG = 'Y' AND
              ((B.OUTFLAG <> 'P') OR (B.OUTFLAG = 'P' AND B.OUTWORKDATE <> @ls_refdate))
              ))
        ORDER BY A.SERIALNO
        
        if @@rowcount = 0
          break
        else
          Begin
            select top 1 @li_remaintime = isnull(remaintime,0)
            from tloadavailtime
            where plandate = @ls_refdate and remaintime <> 0
            
            if @@rowcount = 0
              break
          End
        
        select @li_remaintime = isnull(remaintime,0)
        from tloadavailtime
        where plandate = @ls_refdate and wccode = @ls_wccode and 
          remaintime <> 0

        if @@rowcount = 0
          continue

        -- 납기배정작업
        if (@li_remaintime < (@li_stdtime - @li_allottime))
          Begin
            select @li_resulttime = @li_remaintime

            UPDATE TLOADPRIORITY
            SET AllotTime = AllotTime + @li_resulttime,
                InWorkDate = case when allottime = 0 then @ls_refdate else InWorkDate end,
                OutWorkDate = @ls_refdate
            WHERE SerialNo = @li_serialno
            
            UPDATE TLOADAVAILTIME
            SET ApplyTime = ApplyTime + @li_resulttime,
              RemainTime = 0
            WHERE PlanDate = @ls_refdate AND WcCode = @ls_wccode
            
            INSERT INTO TLOADSIMULATION
            ( PlanDate,SerialNo,OrderNo,PartNo,OperNo,
              WcCode,RemainTime,AllotTime,LoadFlag,LastEmp,LastDate )
            VALUES(@ls_refdate,@li_serialno,@ls_orderno,@ls_partno,@ls_operno,
              @ls_wccode,@li_remaintime,@li_resulttime,'N','C',getdate())
          End
        else
          Begin
            select @li_resulttime = (@li_stdtime - @li_allottime)

            UPDATE TLOADPRIORITY
            SET AllotTime = AllotTime + @li_resulttime,
              LoadFlag = 'Y',
              InWorkDate = case when allottime = 0 then @ls_refdate else InWorkDate end,
              OutWorkDate = @ls_refdate
            WHERE SerialNo = @li_serialno
            
            UPDATE TLOADAVAILTIME
            SET ApplyTime = ApplyTime + @li_resulttime,
              RemainTime = RemainTime - @li_resulttime
            WHERE PlanDate = @ls_refdate AND WcCode = @ls_wccode
            
            INSERT INTO TLOADSIMULATION
            ( PlanDate,SerialNo,OrderNo,PartNo,OperNo,
              WcCode,RemainTime,AllotTime,LoadFlag,LastEmp,LastDate )
            VALUES(@ls_refdate,@li_serialno,@ls_orderno,@ls_partno,@ls_operno,
              @ls_wccode,@li_remaintime,(@li_stdtime - @li_allottime),'Y','D',getdate())
          End
          
      End

    select @li_check = count(*) from tloadpriority where loadflag = 'N'
    if @li_check > 0
      select @ls_refdate = convert(varchar(10),dateadd(day,1,cast(@ls_refdate as datetime)),102)
      
  End

return

End   -- Procedure End

Go