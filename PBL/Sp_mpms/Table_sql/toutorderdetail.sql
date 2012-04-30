/* ************************** TOUTORDERDETAIL table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TOUTORDERDETAIL]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TOUTORDERDETAIL]
GO

CREATE TABLE [dbo].[TOUTORDERDETAIL] (
	[SerialNo]		[char]		  (10)		NOT NULL,
	[OrderNo]			[char] 		  (8) 		NOT NULL,
	[PartNo]		  [char]      (6) 		NOT NULL,
	[OutSerial]   [char]      (2)     NOT NULL,
	[OutCost]     [numeric]   (13,2)  NULL,
	[LastEmp]			[char] 		  (6)			NULL,
	[LastDate]		[datetime] 	default getdate() 
	CONSTRAINT [PK_TOUTORDERDETAIL] PRIMARY KEY  CLUSTERED 
	(
		[SerialNo],[OrderNo],[PartNo],[OutSerial]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
