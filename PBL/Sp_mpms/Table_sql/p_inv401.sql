/* ************************** P_INV401 table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[P_INV401]')
              and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[P_INV401]
GO

CREATE TABLE [dbo].[P_INV401] (
  [SLIPTYPE]  [char]    (2)    NOT NULL ,
	[SRNO]      [char]    (8)    NOT NULL ,
	[SRNO1]     [char]    (2)    NOT NULL ,
	[SRNO2]     [char]    (2)    NOT NULL ,
	[RQNO]      [char]    (11)   NULL ,
	[XPLANT]    [char]    (1)    NULL ,
	[DIV]       [char]    (1)    NULL ,
	[ITNO]      [char]    (12)   NULL ,
	[ITNM]      [char]    (50)   NULL ,
	[SPEC]      [char]    (50)   NULL ,
	[CLS]       [char]    (2)    NULL ,
	[SRCE]      [char]    (2)    NULL ,
	[VSRNO]     [char]    (5)    NULL ,
	[VNDNM]     [char]    (30)   NULL ,
	[TDTE4]     [char]    (8)    NULL ,
	[TQTY4]     [numeric] (11, 1) NULL ,
	[XCOST]     [numeric] (13, 2) NULL ,
	[TRAMT]     [numeric] (13, 0) NULL ,
	[EXTD]      [char]    (20)  NULL )
GO

setuser
GO
