/* ************************** TITEMSTORE table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TITEMSTORE]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TITEMSTORE]
GO

CREATE TABLE [dbo].[TITEMSTORE] (
  [SlipType]    [char]    (2)     NOT NULL,
  [Srno]        [char]    (8)     NOT NULL,
  [Srno1]       [char]    (2)     NOT NULL,
  [Srno2]       [char]    (2)     NOT NULL,
  [RQNO]        [char]    (11)    NULL,
  [Xplant]      [char]    (1)     NULL,
  [Div]         [char]    (1)     NULL,
  [Itno]        [varchar] (12)    NULL,
  [Itnm]        [varchar] (50)    NULL,
  [Spec]        [varchar] (50)    NULL,
  [Cls]         [char]    (2)     NULL,
  [Srce]        [char]    (2)     NULL,
  [MatCls]      [char]    (1)     NULL,
  [OrderNo]     [char]    (8)     NULL,
  [PartNo]      [char]    (6)     NULL,
  [Vsrno]       [char]    (5)     NULL,
  [Vndnm]       [varchar] (30)    NULL,
  [Tqty4]       [numeric] (11,1)  NULL,
  [Tdte4]       [char]    (8)     NULL,
  [Xcost]       [numeric] (13,2)  NULL,
  [Tramt]       [numeric] (13,0)  NULL,
  [LastEmp]     [char]    (6)     NULL,
  [LastDate]    [datetime] default getdate()
  CONSTRAINT [PK_TITEMSTORE] PRIMARY KEY  CLUSTERED
  (
    [SlipType], [Srno], [Srno1], [Srno2], [RQNO]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
