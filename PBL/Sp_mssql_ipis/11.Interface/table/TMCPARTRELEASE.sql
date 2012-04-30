if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMCPARTRELEASE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMCPARTRELEASE]
GO

CREATE TABLE [dbo].[TMCPARTRELEASE] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[AreaCode]		[char] (1)	NOT NULL ,	 -- ����
	[DivisionCode]		[char] (1)	NOT NULL ,	 -- ����
	[ReleaseDate]		[char] (8)	NOT NULL ,	 -- ��������
	[SerialNo]		[char] (8)	NOT NULL ,	 -- ���ں� Serial No
	[ItemCode]		[varchar] (12)	NOT NULL ,	 -- ǰ��
	[SlipNo]		[varchar] (14)	NOT NULL ,	 -- ������ǥ��ȣ
	[OrderNo]		[varchar] (16)	NOT NULL ,	 -- �۾����ù�ȣ
	[DeptCode]		[varchar] (10)	NULL ,		 -- ���μ�	
	[Usage]			[varchar] (2)	NULL ,		 -- ����뵵
	[MCNo]			[varchar] (9)	NULL ,		 -- ����ȣ
	[StockStatus]		[char] (1)	NOT NULL ,	 -- ������(U:��밡, R:����ǰ, S:��ǰ, X:�ο�)
	[ReleaseQty]		[decimal] (7,1)	NOT NULL ,	 -- ���ⷮ
	[DataStatus]		[char] (1)	NOT NULL ,	 -- ����(A:�Է�, R:����, D:����)
	[UploadFlag]		[char] (1)	NOT NULL ,	 -- Upload����(Y:upload�Ϸ�, N:upload�̿Ϸ�)
	[LastEmp]		[LastEmp]	NULL ,
	[LastDate]		[LastDate]	NULL ,
	CONSTRAINT [PK_TMCPARTRELEASE] PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TMCPARTRELEASE].[LastDate]'
GO

setuser
GO


