/* ************************** TOUTORDER table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TOUTORDER]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TOUTORDER]
GO

CREATE TABLE [dbo].[TOUTORDER] (
	[SerialNo]		[char]		  (10)		NOT NULL,
	[OrderNo]			[char] 		  (8) 		NULL,
	[PurItno]		  [varchar]   (12) 		NULL,
	[Xunit]		    [char]      (2) 		NULL,         -- 'ST' : 세트품, 'EA' : 단가
	[PurSrno]     [varchar]   (11)    NULL,
	[OutStatus]   [char]      (1)     NULL,
	[OutCost]     [numeric]   (13,2)  NULL,
	[OrderEmp]    [char]      (6)     NULL,
	[OrderDate]   [char]      (10)    NULL,
	[IncomeEmp]   [char]      (6)     NULL,
	[IncomeDate]  [char]      (10)    NULL,
	[LastEmp]			[char] 		  (6)			NULL,
	[LastDate]		[datetime] 	default getdate() 
	CONSTRAINT [PK_TOUTORDER] PRIMARY KEY  CLUSTERED 
	(
		[SerialNo]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
