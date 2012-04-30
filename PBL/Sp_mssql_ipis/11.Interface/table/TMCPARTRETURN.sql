if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMCPARTRETURN]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMCPARTRETURN]
GO

CREATE TABLE [dbo].[TMCPARTRETURN] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[AreaCode]		[char] (1)	NOT NULL ,	 -- ����
	[DivisionCode]		[char] (1)	NOT NULL ,	 -- ����
	[ReturnDate]		[char] (8)	NOT NULL ,	 -- �ݳ�����
	[SerialNo]		[char] (8)	NOT NULL ,	 -- ���ں� Serial No
	[ItemCode]		[varchar] (12)	NOT NULL ,	 -- ǰ��
	[SlipNo]		[varchar] (14)	NOT NULL ,	 -- �ݳ���ǥ��ȣ
	[OrderNo]		[varchar] (16)	NOT NULL ,	 -- �۾����ù�ȣ
	[DeptCode]		[varchar] (10)	NULL ,		 -- �ݳ��μ�	
	[Usage]			[varchar] (2)	NULL ,		 -- �ݳ��뵵
	[MCNo]			[varchar] (9)	NULL ,		 -- ����ȣ
	[StockStatus]		[char] (1)	NOT NULL ,	 -- ������(U:��밡, R:����ǰ, S:��ǰ, X:�ο�)
	[ReturnQty]		[decimal] (7,1)	NOT NULL ,	 -- �ݳ���
	[DataStatus]		[char] (1)	NOT NULL ,	 -- ����(A:�Է�, R:����, D:����)
	[UploadFlag]		[char] (1)	NOT NULL ,	 -- Upload����(Y:upload�Ϸ�, N:upload�̿Ϸ�)
	[LastEmp]		[LastEmp]	NULL ,
	[LastDate]		[LastDate]	NULL ,
	CONSTRAINT [PK_TMCPARTRETURN] PRIMARY KEY  CLUSTERED 
	(
		[AreaCode],
		[DivisionCode],
		[ReturnDate],
		[SerialNo]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TMCPARTRETURN].[LastDate]'
GO

setuser
GO


