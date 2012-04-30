if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TMCPARTRETURN]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TMCPARTRETURN]
GO

CREATE TABLE [dbo].[TMCPARTRETURN] (
	[LogID] 		[int] IDENTITY(1,1)	NOT NULL ,
	[AreaCode]		[char] (1)	NOT NULL ,	 -- 지역
	[DivisionCode]		[char] (1)	NOT NULL ,	 -- 공장
	[ReturnDate]		[char] (8)	NOT NULL ,	 -- 반납일자
	[SerialNo]		[char] (8)	NOT NULL ,	 -- 일자별 Serial No
	[ItemCode]		[varchar] (12)	NOT NULL ,	 -- 품번
	[SlipNo]		[varchar] (14)	NOT NULL ,	 -- 반납전표번호
	[OrderNo]		[varchar] (16)	NOT NULL ,	 -- 작업지시번호
	[DeptCode]		[varchar] (10)	NULL ,		 -- 반납부서	
	[Usage]			[varchar] (2)	NULL ,		 -- 반납용도
	[MCNo]			[varchar] (9)	NULL ,		 -- 장비번호
	[StockStatus]		[char] (1)	NOT NULL ,	 -- 재고상태(U:사용가, R:수리품, S:폐품, X:부외)
	[ReturnQty]		[decimal] (7,1)	NOT NULL ,	 -- 반납량
	[DataStatus]		[char] (1)	NOT NULL ,	 -- 구분(A:입력, R:수정, D:삭제)
	[UploadFlag]		[char] (1)	NOT NULL ,	 -- Upload구분(Y:upload완료, N:upload미완료)
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


