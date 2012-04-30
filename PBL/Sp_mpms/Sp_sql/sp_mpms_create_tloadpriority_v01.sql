/*
  File Name : sp_mpms_create_tloadpriority.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_create_tloadpriority
  Description : 우선순위정보를 생성함
  Use DataBase  : MPMS
  Use Program :
  Use Table : tworkcalendar, tworkcenter, tloadpriority
  Parameter : 
  Initial   : 2010.06.07
  Author    : Kiss Kim
*/


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_create_tloadpriority]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_create_tloadpriority]
GO

/*
Execute sp_mpms_create_tloadpriority 'A'
*/

Create Procedure sp_mpms_create_tloadpriority
  @ps_versionno char(1)

As
Begin

DELETE FROM TLOADPRIORITY
WHERE VersionNo = @ps_versionno

Create table #tmp_priority (
  [SerialNo]    [int]	      IDENTITY(1,1),
  [OrderNo]     [char]    (8)     NOT NULL,
  [PartNo]      [char]    (6)     NOT NULL,
  [PreOperNo]   [char]    (3)     NULL,
  [OperNo]      [char]    (3)     NOT NULL,
  [PostOperno]  [char]    (3)     NULL,
  [WcCode]      [char]    (3)     NULL,
  [StdTimeSum]  [numeric] (10,0)  NULL,
  [AllotTime]   [numeric] (5,0)   NULL,
  [InWorkDate]  [char]    (10)    NULL,    -- 작업시작일
  [OutWorkDate] [char]    (10)    NULL,    -- 작업완료일
  [LoadFlag]    [char]    (1)     NULL,    -- 배정 완료 'Y'
  [OutFlag]     [char]    (1)     NULL )

INSERT INTO #tmp_priority
( OrderNo,PartNo,PreOperNo,OperNo,PostOperno,WcCode,StdTimeSum,AllotTime,
  InWorkDate,OutWorkDate,LoadFlag,OutFlag)
SELECT c.OrderNo, c.PartNo, 
( SELECT TOP 1 OperNo FROM TROUTING 
	WHERE OrderNO = c.Orderno AND PartNo = c.PartNo AND 
		OperNo < c.OperNo AND WorkStatus <> 'C' AND WcCode <> 'THT'
	ORDER BY OperNo desc ),
c.OperNo, 
( SELECT TOP 1 OperNo FROM TROUTING 
	WHERE OrderNO = c.Orderno AND PartNo = c.PartNo AND 
		OperNo > c.OperNo AND WorkStatus <> 'C' AND WcCode <> 'THT'
	ORDER BY OperNo asc ),
c.WcCode,
isnull(c.StdTime * (isnull(b.Qty1,0) + isnull(b.Qty2,0)),0),
0,
'',
'',
'N',
c.OutFlag
  FROM TORDER a INNER JOIN TPARTLIST b
    ON a.OrderNo = b.OrderNo
    INNER JOIN TROUTING c
    ON b.OrderNo = c.OrderNo AND b.PartNo = c.PartNo
  WHERE a.ingstatus <> 'C' AND c.WorkStatus <> 'C' AND c.WcCode <> 'THT'
  ORDER BY a.PriorityNo, a.OrderNo, b.PriorityNo, c.OperNo

INSERT INTO TLOADPRIORITY
( VersionNo, SerialNo, OrderNo,PartNo,PreOperNo,OperNo,PostOperno,WcCode,StdTimeSum,AllotTime,
  InWorkDate,OutWorkDate,LoadFlag,OutFlag)
SELECT @ps_versionno,SerialNo,OrderNo,PartNo,PreOperNo,OperNo,PostOperno,WcCode,StdTimeSum,AllotTime,
  InWorkDate,OutWorkDate,LoadFlag,OutFlag
FROM #tmp_priority

drop table #tmp_priority
return

End   -- Procedure End

Go