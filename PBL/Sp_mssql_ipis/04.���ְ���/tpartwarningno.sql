/* ************************** TPARTWARNINGNO table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TPARTWARNINGNO]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TPARTWARNINGNO]
GO

CREATE TABLE [dbo].[TPARTWARNINGNO] (
	[AreaCode]			  [char]		  (1)     NOT NULL,
	[DivisionCode]		[char]		  (1)		  NOT NULL,
	[ItemCode]			  [varchar]  	(12) 	  NOT NULL,
	[LastEmp]			    [varchar]		(6)		  NULL,
	[LastDate]			  [datetime]	        NULL,
	
	CONSTRAINT [PK_TPARTWARNINGNO] PRIMARY KEY  CLUSTERED 
	(
		[AreaCode], [DivisionCode], [ItemCode]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
