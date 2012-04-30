/*
  File Name : VROUTBASICTIME.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  View Name  : VROUTBASICTIME
  Description : 종합효율 - 라우팅 표준시간 합을 조회하는 뷰
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : ipis
  Use Program :
  Parameter :
  Use Table :
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[VROUTBASICTIME]')
        And OBJECTPROPERTY(id, N'IsView') = 1)
  Drop View [dbo].[VROUTBASICTIME]
GO

/* select * from VROUTBASICTIME */

CREATE  View VROUTBASICTIME

As

SELECT TMSTROUTING.AreaCode,
     TMSTROUTING.DivisionCode,
     TMSTROUTING.WorkCenter,
     Min(TMSTROUTING.ApplyDate),
     TMSTROUTING.ItemCode,
     TMSTROUTING.SubLineCode,
     TMSTROUTING.SubLineNo,
     Cast ( Sum ( IsNull(TMSTROUTING.BaseManualWorkTime,0) + IsNull(TMSTROUTING.SideManualWorkTime,0) ) as Numeric(9,4) )
  FROM TMSTROUTING
Group By TMSTROUTING.AreaCode, TMSTROUTING.DivisionCode, TMSTROUTING.WorkCenter,
      TMSTROUTING.ItemCode, TMSTROUTING.SubLineCode, TMSTROUTING.SubLineNo

go
