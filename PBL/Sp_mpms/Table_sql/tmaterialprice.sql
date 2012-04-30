/* ************************** TMATERIALPRICE table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMATERIALPRICE]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMATERIALPRICE]
GO

CREATE TABLE [dbo].[TMATERIALPRICE] (
  [Material]      [varchar]   (20)    NOT NULL,
  [UnitPrice]     [numeric]   (11,2)  NULL,
  [HeatPrice]     [numeric]   (11,2)  NULL,
  [Gravity]       [numeric]   (11,2)  NULL,
  [ApplyDate]     [varchar]   (10)    NULL,
  [LastEmp]       [char]      (6)     NULL,
  [LastDate]      [datetime]  default getdate()
  CONSTRAINT [PK_TMATERIALPRICE] PRIMARY KEY  CLUSTERED
  (
    [Material]
  )  ON [PRIMARY]
) ON [PRIMARY]
GO

setuser
GO
