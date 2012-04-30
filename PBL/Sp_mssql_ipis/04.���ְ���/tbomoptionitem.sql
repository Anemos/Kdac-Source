/* ************************** TBOMOPTIONITEM table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TBOMOPTIONITEM]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TBOMOPTIONITEM]
GO

CREATE TABLE [dbo].[TBOMOPTIONITEM] (
	[Oplant]		[char]		(1)     NOT NULL,
	[Odvsn]			[char]		(1)		  NOT NULL,
	[Opitn]			[varchar] (12) 	  NOT NULL,
	[Ofitn]			[varchar]	(12)	  NOT NULL,
	[Ochdt]			[char]		(10)		  NOT NULL,
	[Oedtm]			[char]    (10)	    NULL,
	[Oedte]			[char]		(10)		  NULL,
	[Orate]     [numeric] (5,2)   NULL,
	[Ochcd]     [char]    (1)     NULL,
	[Ofocd]     [char]    (2)     NULL,
	[Oemno]     [char]    (6)     NULL,
	[LastDate]  [datetime]	  NULL,
	
	CONSTRAINT [PK_TBOMOPTIONITEM] PRIMARY KEY  CLUSTERED 
	(
		[Oplant], [Odvsn], [Opitn], [Ofitn], [Ochdt]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
