/* ************************** TSETCARDHIST table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TSETCARDHIST]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TSETCARDHIST]
GO

CREATE TABLE [dbo].[TSETCARDHIST] (
  [Logid]			      [int]	      IDENTITY(1,1),
  [OrderNo]         [char]      (8)     NOT NULL,
  [EventDate]       [char]      (10)    NULL,
  [EventMemo]       [varchar]   (250)   NULL,
  [Tabal]           [varchar]   (50)    NULL,
  [ConfirmFlag]     [char]      (1)     NULL,
  [ConfirmEmpno]    [char]      (6)     NULL,
  [ManHour]         [int]               NULL,
  [EtcMemo]         [varchar]   (250)   NULL,
  [LastEmp]         [char]      (6)     NULL,
  [LastDate]        [datetime]  default getdate()   NULL
  CONSTRAINT [PK_TSETCARDHIST] PRIMARY KEY  CLUSTERED
  (
    [Logid]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
