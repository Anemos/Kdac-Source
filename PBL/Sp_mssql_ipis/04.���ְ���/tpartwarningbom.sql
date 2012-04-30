/* ************************** TPARTWARNINGBOM table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TPARTWARNINGBOM]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TPARTWARNINGBOM]
GO

CREATE TABLE [dbo].[TPARTWARNINGBOM] (
	[AreaCode]			  [char]		  (1)     NOT NULL,
	[DivisionCode]		[char]		  (1)		  NOT NULL,
	[ModelItemNo]			[varchar]  	(12) 	  NOT NULL,
	[ParentItemNo]		[varchar]	  (12)	  NOT NULL,
	[ChildItemNo]			[varchar]		(12)		NOT NULL,
	[QuantityPerUnit]	[numeric]   (8,3)	  NULL,
	[LowLevel]        [smallint]          NULL,
	[SerialLevel]			[varchar]		(500)		NULL,
	[LastDate]			  [datetime]	        NULL
) ON [PRIMARY]
GO

setuser
GO
