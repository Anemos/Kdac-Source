IF EXISTS (select id FROM dbo.sysobjects WHERE id = object_id('LookUps'))
	DROP TABLE LookUps
go
CREATE TABLE dbo.LookUps (
	ID		int identity(1,1) NOT NULL
			CONSTRAINT pkLookUps PRIMARY KEY clustered,
	LUID		int NOT null,
	Type		varchar(30) NOT null,	
	code		varchar(30) NOT null,
	description	varchar(255) NOT NULL )
go
CREATE UNIQUE NONCLUSTERED INDEX uniLookUpsLUIDType on LookUps(LUID, Type)
go
	
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqStat',1,'Granted','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqStat',2,'Converting','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqStat',3,'Waiting','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',0,'','No access IS granted to the resource. Serves AS a placeholder.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',1,'Sch-S','(Schema stability). Ensures that a schema element, such AS a TABLE or index, IS NOT dropped WHILE ANY session holds a schema stability lock on the schema element.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',2,'Sch-M','(Schema modification). Must be held BY ANY session that wants to change the schema OF the specified resource. Ensures that no other sessions are referencing the indicated object.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',3,'S','(Shared). The holding session IS granted shared access to the resource.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',4,'U','(Update). Indicates an update lock acquired on resources that may eventually be updated. It IS used to prevent a common form OF deadlock that occurs WHEN multiple sessions lock resources for potential update at a later time.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',5,'X','(Exclusive). The holding session IS granted exclusive access to the resource.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',6,'IS','(Intent Shared). Indicates the intention to place S locks on SOME subordinate resource in the lock hierarchy.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',7,'IU','(Intent Update). Indicates the intention to place U locks on SOME subordinate resource in the lock hierarchy.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',8,'IX','(Intent Exclusive). Indicates the intention to place X locks on SOME subordinate resource in the lock hierarchy.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',9,'SIU','(Shared Intent Update). Indicates shared access to a resource WITH the intent OF acquiring update locks on subordinate resources in the lock hierarchy.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',10,'SIX','(Shared Intent Exclusive). Indicates shared access to a resource WITH the intent OF acquiring exclusive locks on subordinate resources in the lock hierarchy.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',11,'UIX','(Update Intent Exclusive). Indicates an update lock hold on a resource WITH the intent OF acquiring exclusive locks on subordinate resources in the lock hierarchy.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',12,'BU','Used BY BULK operations.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',13,'RangeS_S','(Shared Key-Range AND Shared Resource lock). Indicates SERIALIZABLE range scan.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',14,'RangeS_U','(Shared Key-Range AND UPDATE Resource lock). Indicates SERIALIZABLE update scan.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',15,'RangeI_N','(Insert Key-Range AND NULL Resource lock). Used to test ranges before inserting a new key into an index.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',16,'RangeI_S','Key-Range Conversion lock, created BY an overlap OF RangeI_N AND S locks.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',17,'RangeI_U','Key-Range Conversion lock, created BY an overlap OF RangeI_N AND U locks.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',18,'RangeI_X','Key-Range Conversion lock, created BY an overlap OF RangeI_N AND X locks.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',19,'RangeX_S','Key-Range Conversion lock, created BY an overlap OF RangeI_N AND RangeS_S. locks.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',20,'RangeX_U','Key-Range Conversion lock, created BY an overlap OF RangeI_N AND RangeS_U locks.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqMode',21,'RangeX_X','(Exclusive Key-Range AND Exclusive Resource lock). This is a conversion lock used WHEN updating a key in a range.')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('RscType',1,'','Resource (not used)')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('RscType',2, 'Database','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('RscType',3, 'File','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('RscType',4, 'Index','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('RscType',5, 'Table','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('RscType',6, 'Page','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('RscType',7, 'Key','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('RscType',8, 'Extent','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('RscType',9, 'Row ID','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('RscType',10, 'Application','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqOwn',1,'Transaction','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqOwn',2,'Cursor','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqOwn',3,'Session','')
	INSERT INTO dbo.LookUps(Type, LUID, Code, Description) VALUES ('ReqOwn',4,'ExSession','')
go
/*------------------------------------------------------------------------
xSpy IS a handier version OF sp_who. It's easier TO type and more 
information in a better sorted fashion: ALL blocking data IS in the first two
fields AND all, IF any, blocking/blocker SPIDs appear at the beginning
result set.
----------------------------------------
--------------------------------*/ 
IF EXISTS (select id FROM sysobjects WHERE id = object_id('dbo.xSpy') )
	DROP PROCEDURE dbo.xSpy 
go
CREATE PROCEDURE dbo.xSpy
as
SET nocount ON
	SELECT 	isnull((select 'X'
			FROM 	master.dbo.sysprocesses a,
				master.dbo.sysprocesses b
			WHERE 	b.blocked <> 0 		AND
				b.blocked = a.spid	AND	
				a.blocked = 0		AND
				sp.SPID = a.SPID),'') Blocker,
		sp.blocked,
		convert(varchar(6),sp.spid) + 
		CASE 
			WHEN sp.spid = @@SPID THEN '(me)'
			ELSE ''
		END	SPID,
		substring(sd.name,1,20)	DB,
		substring(sp.nt_domain,1,20) DOMAIN,
		substring(sp.nt_username,1,20) NTUSER,
		substring(sp.loginame,1,20) SQLUSER,
		sp.cpu,
		sp.physical_io,
		sp.memusage,
		sp.status,
		sp.open_tran,
		substring(sp.hostname,1,20) HOSTNAME,
		substring(sp.program_name,1,30) program_name,
		sp.cmd,
		sp.net_library
	FROM 	master.dbo.sysprocesses sp,
		master.dbo.sysdatabases sd
	WHERE	sp.dbid = sd.dbid AND
		sp.ecid = 0
	ORDER BY 1 desc, sp.blocked desc, sp.Status, sp.CPU DESC
go
/*------------------------------------------------------------------------
Basically, xSpyBlock IS a friendlier version OF sp_lock that returns ONLY
information about currently blocking SPIDs
xSpyBlock returns similar data TO sp_lock, but it provides the offending
objects human readable name AS opposed TO just it's dbid AND object id.
Requires that the TABLE LookUps IS IN the same DATABASE as this procedure.
xSpyBlock IS a maintenance SP, AND is intended TO be run BY the 
USER DBO only.
----------------------------------------
--------------------------------*/
go
IF EXISTS (select id FROM sysobjects WHERE id = object_id('dbo.xSpyBlock') )
	DROP PROCEDURE dbo.xSpyBlock
go
CREATE PROCEDURE dbo.xSpyBlock
as
SET nocount ON
	DECLARE @DBName	varchar(30),
		@sMsg	varchar(255) 
 
	/*
	ReqStat		Status OF the lock request
	RscType		Resource type
	ReqOwn		Type OF object associated WITH the lock
	ReqMode		Lock request mode
	ReqModeDesc	Verbose description OF Lock request mode
	*/
 	CREATE TABLE #Blocker (
		ID		int identity(1,1) NOT null,
		SOID		int NOT null, 
		SPID		int NOT null, 
		Object		varchar(30) NOT NULL
				DEFAULT '',
		RscText		varchar(32) NOT null,
		DBName		varchar(30) NOT null,	
		ReqStat		varchar(30) NOT null,	 
		RscType		varchar(30) NOT null,	 
		ReqOwn		varchar(30) NOT null,	 
		ReqMode		varchar(30) NOT null,	 
		ReqModeDesc	varchar(255) NOT NULL )
	IF EXISTS (select b.spid FROM master.dbo.sysprocesses b WHERE b.blocked <> 0)
		BEGIN
	
		INSERT INTO #Blocker(RscText, SOID, SPID, DBName, ReqStat, RscType, ReqOwn, ReqMode, ReqModeDesc)
		SELECT 	sl.rsc_text, sl.rsc_objid, a.spid, sd.name, ReqStat.Code, RscType.Code,ReqOwn.Code, ReqMode.Code, ReqMode.Description
		FROM 	master.dbo.sysprocesses a,
			master.dbo.sysprocesses b,
			master.dbo.syslockinfo sl,
			master.dbo.sysdatabases sd,
			dbo.LookUps ReqStat,
			dbo.LookUps ReqMode,
			dbo.LookUps RscType,
			dbo.LookUps ReqOwn
		WHERE 	b.blocked <> 0 			AND
			b.blocked = a.spid		AND	
			sl.req_spid = a.spid		AND
			sl.rsc_dbid = sd.dbid		AND
			a.blocked = 0			AND
			a.ecid = 0			AND
			b.ecid = 0			AND
			sl.req_status = ReqStat.LUID	AND
			sl.req_mode = ReqMode.LUID	AND
			sl.rsc_type = RscType.LUID	AND
			sl.req_ownertype = ReqOwn.LUID	AND
			ReqStat.Type = 'ReqStat'	AND
			ReqMode.Type = 'ReqMode'	AND
			RscType.Type = 'RscType'	AND
			ReqOwn.Type = 'ReqOwn'	
		ORDER BY a.spid, rsc_text
		DECLARE tbla CURSOR FOR 
			SELECT DISTINCT 
				DBName
			FROM 	#Blocker
			WHERE	SOID > 0
		OPEN tbla
 
		FETCH next FROM tbla INTO @DBName
		WHILE @@FETCH_STATUS = 0
			BEGIN
			SELECT @sMsg = 'update b SET b.object = name FROM ' + @DBName + '..sysobjects so, #Blocker b WHERE so.id = b.SOID AND b.DBName = ''' + @DBName + ''''
			EXEC (@sMsg)
			FETCH next FROM tbla INTO @DBName
			END
	 	CLOSE tbla
		DEALLOCATE tbla
		END 
 
	SELECT 	SPID 'Blocker SPID',
		left(
		CASE SOID
			WHEN 0 THEN '-'
			ELSE DBName + '..' + Object
		end,30) Object,
		RscType,
		RscText,
		ReqMode,
		ReqModeDesc,
		ReqStat,
		ReqOwn
	FROM 	#Blocker ORDER BY RscText
go
/*------------------------------------------------------------------------
xSpySQL IS a handy way OF running DBCC INPUTBUFFER on ALL offending
blockers without HAVING TO lookup their SPID.
xSpySQL IS a maintenance SP, AND is intended TO be run BY the 
USER DBO only.
----------------------------------------
--------------------------------*/ 
IF EXISTS (select id FROM sysobjects WHERE id = object_id('dbo.xSpySQL') )
	DROP PROCEDURE dbo.xSpySQL 
go
CREATE PROCEDURE dbo.xSpySQL
as
SET nocount ON
	DECLARE @ID	int,
		@SPID	int,
		@sMsg	varchar(255) 
	CREATE TABLE #dbcc (
		ID		int identity(1,1) NOT null,
		SPID		int NOT NULL
				DEFAULT 0,
		Parameters	int null,
		EventType	varchar(255) null,
		EventInfo	varchar(1000) NULL )
	DECLARE tbla CURSOR FOR 
		SELECT a.spid
		FROM 	master.dbo.sysprocesses a,
			master.dbo.sysprocesses b
		WHERE 	b.blocked <> 0 		AND
		b.blocked = a.spid	AND
		a.blocked = 0	
	OPEN tbla
 
	FETCH next FROM tbla INTO @SPID
	WHILE @@FETCH_STATUS = 0
		BEGIN
 
		SELECT @sMsg = 'dbcc inputbuffer(' + convert(varchar,@SPID) + ')'
		INSERT INTO #dbcc (EventType, Parameters, EventInfo )
		EXEC (@sMsg)
		SELECT @ID = @@Identity
		UPDATE	x
		SET	SPID = @SPID
		FROM 	#dbcc x
		WHERE	x.ID = @ID	
	
		FETCH next FROM tbla INTO @SPID
		END
 	CLOSE tbla
	DEALLOCATE tbla
	SELECT SPID, EventInfo FROM #dbcc
go
/*------------------------------------------------------------------------
How TO run them:
----------------------------------------
--------------------------------*/ 
EXEC xSpy
EXEC xSpyBlock
EXEC xSpySQL
