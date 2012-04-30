if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMCMASTER]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMCMASTER]
GO

CREATE TABLE [dbo].[TMCMASTER] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[MisFlag]		[char] (1)	NOT NULL , 	 -- ���� (A, R, D)
	[AreaCode]		[char] (1)	NOT NULL ,	 -- ����
	[DivisionCode]		[char] (1)	NOT NULL ,	 -- ����
	[MCCode]		[char] (9)	NOT NULL ,	 -- ����ڵ�
	[MCName]		[char] (30)	NOT NULL ,	 -- ����
	[AssetCode]		[char] (10)	NOT NULL ,	 -- �ڻ��ڵ�
	[Status]		[char] (1)	NOT NULL ,	 -- ����
	[MCSpec]		[char] (20)	NOT NULL ,	 -- �԰�
	[MCUsage]		[char] (40)	NOT NULL ,	 -- �뵵
	[CCCode]		[char] (5)	NOT NULL ,	 -- C/C �ڵ�
	[Line]			[char] (5)	NOT NULL ,	 -- ����
	[MCShortName]		[char] (20)	NOT NULL ,	 -- ��Ī
	[SetupDate]		[char] (8)	NOT NULL ,	 -- ��ġ����	
	[ProcessNo]		[char] (5)	NOT NULL ,	 -- ������ȣ
	[AdminDept]		[char] (5)	NOT NULL ,	 -- ��μ�
	[UseDept]		[char] (5)	NOT NULL ,	 -- ���μ�
	[Buyer]			[char] (5)	NOT NULL ,	 -- ����ó
	[DomesticAgent]		[char] (5)	NOT NULL ,	 -- ���� Agent
	[UploadFlag]		[char] (1)	NOT NULL ,	 -- Upload����(Y:upload�Ϸ�, N:upload�̿Ϸ�)
	[LastEmp]		[LastEmp]	NULL ,
	[LastDate]		[LastDate]	NULL ,
	CONSTRAINT [PK_TMCMASTER] PRIMARY KEY  CLUSTERED 
	(
		[LogID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

setuser
GO

EXEC sp_bindefault N'[dbo].[DF_CURRENT_TIME]', N'[TMCMASTER].[LastDate]'
GO

setuser
GO


