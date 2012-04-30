if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMCMASTER]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMCMASTER]
GO

CREATE TABLE [dbo].[TMCMASTER] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[MisFlag]		[char] (1)	NOT NULL , 	 -- 구분 (A, R, D)
	[AreaCode]		[char] (1)	NOT NULL ,	 -- 지역
	[DivisionCode]		[char] (1)	NOT NULL ,	 -- 공장
	[MCCode]		[char] (9)	NOT NULL ,	 -- 장비코드
	[MCName]		[char] (30)	NOT NULL ,	 -- 장비명
	[AssetCode]		[char] (10)	NOT NULL ,	 -- 자산코드
	[Status]		[char] (1)	NOT NULL ,	 -- 구분
	[MCSpec]		[char] (20)	NOT NULL ,	 -- 규격
	[MCUsage]		[char] (40)	NOT NULL ,	 -- 용도
	[CCCode]		[char] (5)	NOT NULL ,	 -- C/C 코드
	[Line]			[char] (5)	NOT NULL ,	 -- 라인
	[MCShortName]		[char] (20)	NOT NULL ,	 -- 약칭
	[SetupDate]		[char] (8)	NOT NULL ,	 -- 설치일자	
	[ProcessNo]		[char] (5)	NOT NULL ,	 -- 공정번호
	[AdminDept]		[char] (5)	NOT NULL ,	 -- 운영부서
	[UseDept]		[char] (5)	NOT NULL ,	 -- 사용부서
	[Buyer]			[char] (5)	NOT NULL ,	 -- 구입처
	[DomesticAgent]		[char] (5)	NOT NULL ,	 -- 국내 Agent
	[UploadFlag]		[char] (1)	NOT NULL ,	 -- Upload구분(Y:upload완료, N:upload미완료)
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


