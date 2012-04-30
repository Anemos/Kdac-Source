/* ************************** EQUIP_FTPFILE table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[EQUIP_FTPFILE]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[EQUIP_FTPFILE]
GO

CREATE TABLE [dbo].[EQUIP_FTPFILE] (
  [File_id]      [char]      (10)     NOT NULL,
	[Area_code]			[char]		  (1)			NOT NULL,
	[Factory_code]			[char] 		  (1) 		NOT NULL,
	[Equip_code]     [varchar]   (9)   NOT NULL,
	[File_name]    [varchar]   (50)  NULL,
	[File_desc]     [varchar]   (255)  NULL,
	[File_size]     [numeric]   (10,0)  NULL,
	[LastEmp]			[char] 		  (6)			NULL,
	[LastDate]		[datetime] 	default getdate() 
	CONSTRAINT [PK_EQUIP_FTPFILE] PRIMARY KEY  CLUSTERED 
	(
		[File_id]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
