/* ************************** TOUTPROCESS table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TOUTPROCESS]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TOUTPROCESS]
GO

CREATE TABLE [dbo].[TOUTPROCESS] (
	[OrderNo]			[char]		  (8)			NOT NULL,
	[PartNo]			[char] 		  (6) 		NOT NULL,
	[OutSerial]		[char] 		  (2) 		NOT NULL,
	[PartSpec]    [varchar]   (50)    NULL,
	[OutStatus]   [char]      (1)     NULL,
	[InputEmp]    [char]      (6)     NULL,
	[InputDate]   [char]      (10)    NULL,
	[ConfirmEmp]  [char]      (6)     NULL,
	[ConfirmDate] [char]      (10)    NULL,
	[OrderEmp]    [char]      (6)     NULL,
	[OrderDate]   [char]      (10)    NULL,
	[IncomeEmp]   [char]      (6)     NULL,
	[IncomeDate]  [char]      (10)    NULL,
	[Memo]	      [varchar]   (255) 	NULL,
	[LastEmp]			[char] 		  (6)			NULL,
	[LastDate]		[datetime] 	default getdate() 
	CONSTRAINT [PK_TOUTPROCESS] PRIMARY KEY  CLUSTERED 
	(
		[OrderNo], [PartNo], [OutSerial]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
