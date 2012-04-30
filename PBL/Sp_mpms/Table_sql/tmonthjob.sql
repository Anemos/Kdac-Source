/* ************************** TMONTHJOB table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMONTHJOB]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMONTHJOB]
GO

CREATE TABLE [dbo].[TMONTHJOB] (
  [YearMm]      [char]      (6)     NOT NULL,
	[LaborCost]		[numeric]		(8,0)		NULL,
	[ResultFlag]	[char] 		  (1) 		NULL,
	[LastEmp]			[char] 		  (6)			NULL,
	[LastDate]		[datetime] 	default getdate() 
	CONSTRAINT [PK_TMONTHJOB] PRIMARY KEY  CLUSTERED 
	(
		[YearMm]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
