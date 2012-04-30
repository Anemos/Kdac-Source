/* ************************** TPARTCALENDARWORK table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TPARTCALENDARWORK]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TPARTCALENDARWORK]
GO

CREATE TABLE [dbo].[TPARTCALENDARWORK] (
	[AreaCode] [char] (1) NOT NULL ,
	[DivisionCode] [char] (1) NOT NULL ,
	[ProductGroup] [char] (2) NOT NULL ,
	[ApplyMonth] [char] (7) NOT NULL ,
	[ApplyDate] [char] (10) NOT NULL ,
	[DayNo] [smallint] NOT NULL ,
	[WorkGubun] [char] (1) NOT NULL CONSTRAINT [DF_TPARTCALENDARWORK_WorkGubun] DEFAULT ('W'),
	[Remark] [varchar] (50) NULL ,
	[LastEmp] [LastEmp] NULL ,
	[LastDate] [LastDate] NULL ,
	CONSTRAINT [PK_TPARTCALENDARWORK] PRIMARY KEY  CLUSTERED 
	(
		[AreaCode],
		[DivisionCode],
		[ProductGroup],
		[ApplyDate]
	)  ON [PRIMARY] ,
	CONSTRAINT [CHK_TPARTCALENDARWORK_WorkGubun] CHECK ([WorkGubun] = 'W' or [WorkGubun] = 'H') 
) ON [PRIMARY]
GO

setuser
GO
