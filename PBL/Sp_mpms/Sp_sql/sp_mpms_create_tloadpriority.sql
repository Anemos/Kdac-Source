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
Execute sp_mpms_create_tloadpriority 
*/

Create Procedure sp_mpms_create_tloadpriority

As
Begin

TRUNCATE TABLE TLOADPRIORITY

INSERT INTO TLOADPRIORITY
( OrderNo,PartNo,PreOperNo,OperNo,PostOperno,WcCode,StdTimeSum,AllotTime,
  InWorkDate,OutWorkDate,LoadFlag,OutFlag,LastEmp,LastDate )
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
c.OutFlag,
null,
getdate()
  FROM TORDER a INNER JOIN TPARTLIST b
    ON a.OrderNo = b.OrderNo
    INNER JOIN TROUTING c
    ON b.OrderNo = c.OrderNo AND b.PartNo = c.PartNo
  WHERE a.ingstatus <> 'C' AND c.WorkStatus <> 'C' AND c.WcCode <> 'THT'
  ORDER BY a.PriorityNo, a.OrderNo, b.PriorityNo, c.OperNo

return

End   -- Procedure End

Go