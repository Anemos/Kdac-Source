/* ************************** TSUBMATCOST table ************************** */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TSUBMATCOST]') 
							and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TSUBMATCOST]
GO

CREATE TABLE [dbo].[TSUBMATCOST] (
  [YearMm]      [char]      (6)     NOT NULL,
	[OrderDept]		[varchar]	  (5)		  NOT NULL,
	[DeptPortion] [numeric]   (3,0)   NULL,
	[SubMatCost]  [numeric]   (8,0)   NULL,
	[LastEmp]			[char] 		  (6)			NULL,
	[LastDate]		[datetime] 	default getdate() 
	CONSTRAINT [PK_TSUBMATCOST] PRIMARY KEY  CLUSTERED 
	(
		[YearMm],[OrderDept]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO
