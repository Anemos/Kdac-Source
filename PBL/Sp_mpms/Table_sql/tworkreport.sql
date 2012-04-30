/* ************************** TWORKREPORT table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TWORKREPORT]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TWORKREPORT]
GO

CREATE TABLE [dbo].[TWORKREPORT] (
  [WorkDate]          [char]    (10)    NOT NULL,
  [WorkGubun]         [char]    (1)     NOT NULL,
  [OverTime2]         [numeric] (5,1)   NULL,
  [OverTime3]         [numeric] (5,1)   NULL,
  [EarlyTime]         [numeric] (5,1)   NULL,
  [SpecialTime]       [numeric] (5,1)   NULL,
  [DayMan]            [numeric] (5,1)   NULL,
  [DayInputTime]      [numeric] (5,1)   NULL,
  [NightMan]          [numeric] (5,1)   NULL,
  [NightInputTime]    [numeric] (5,1)   NULL,
  [EventMan]          [numeric] (5,1)   NULL,
  [EventInputTime]    [numeric] (5,1)   NULL,
  [EventMemo]         [text]            NULL,
  [SpecialMemo]       [text]            NULL,
  [ConfirmFlag]       [char]    (1)     NULL,
  [ConfirmEmp]        [char]    (6)     NULL,
  [SanctionFlag]      [char]    (1)     NULL,
  [SanctionEmp]       [char]    (6)     NULL,
  [EmpNo1]            [char]    (6)     NULL,
  [JobTime1]          [varchar] (30)    NULL,
  [EmpNo2]            [char]    (6)     NULL,
  [JobTime2]          [varchar] (30)    NULL,
  [EmpNo3]            [char]    (6)     NULL,
  [JobTime3]          [varchar] (30)    NULL,
  [EmpNo4]            [char]    (6)     NULL,
  [JobTime4]          [varchar] (30)    NULL,
  [EmpNo5]            [char]    (6)     NULL,
  [JobTime5]          [varchar] (30)    NULL,
  [EmpNo6]            [char]    (6)     NULL,
  [JobTime6]          [varchar] (30)    NULL,
  [EmpNo7]            [char]    (6)     NULL,
  [JobTime7]          [varchar] (30)    NULL,
  [EmpNo8]            [char]    (6)     NULL,
  [JobTime8]          [varchar] (30)    NULL,
  [EmpNo9]            [char]    (6)     NULL,
  [JobTime9]          [varchar] (30)    NULL,
  [EmpNo10]           [char]    (6)     NULL,
  [JobTime10]         [varchar] (30)    NULL,
  [EmpNo11]           [char]    (6)     NULL,
  [JobTime11]         [varchar] (30)    NULL,
  [EmpNo12]           [char]    (6)     NULL,
  [JobTime12]         [varchar] (30)    NULL,
  [LastEmp]           [char]    (6)     NULL,
  [LastDate]          [datetime]  default getdate()   NULL
  CONSTRAINT [PK_TWORKREPORT] PRIMARY KEY  CLUSTERED
  (
    [WorkDate],[WorkGubun]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
