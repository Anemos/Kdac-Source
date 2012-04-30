USE [ORMS]
GO

/****** Object:  StoredProcedure [dbo].[SP_JOB_EXCEL_CREATE]    Script Date: 01/17/2011 10:12:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[SP_JOB_EXCEL_CREATE]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[SP_JOB_EXCEL_CREATE]
GO

/*
--------------------------------------------------------------------
TITLE 		: 일자별 가동율 자료를 Excel 파일로 생성
DATE		: 2010.06.01
CREATOR	: FIT
INPUT		: 
OUTUPT	              : ORMS_20090101_075959.xls (일시)
DESCRIPTION	: 
  	
  EXEC SP_JOB_EXCEL_CREATE  
	'C:\data\', 
	'ORMS', 
	'DATA'

  * 매월 1일  07:59에 생성
--------------------------------------------------------------------
*/

CREATE               Procedure [dbo].[SP_JOB_EXCEL_CREATE]
    @ExcelFilePath  	varchar(255),   	-- Excel 파일이 생성될 경로
    @ServerName 		varchar(128),  	-- Excel 파일명의 prefix 
    @WKS_Name   		varchar(128)    	-- Name of the XLS Worksheet (table)
AS


SET NOCOUNT ON

BEGIN
		
    DECLARE @Conn 	int 		-- ADO Connection object to create XLS
        	   , @hr 		int 		-- OLE return value
        	   , @src 	varchar(255) 	-- OLE Error Source
        	   , @desc 	varchar(255) 	-- OLE Error Description
        	   , @Path 	varchar(255) 	-- Drive or UNC path for XLS
        	   , @Connect 	varchar(255) 	-- OLE DB Connection string for Jet 4 Excel ISAM
        	   , @WKS_Created 	bit 	-- Whether the XLS Worksheet exists
        	   , @DDL 	varchar(8000) 	-- Jet4 DDL for the XLS WKS table creation
        	   , @SQL 	varchar(8000) 	-- INSERT INTO XLS T-SQL
        	   , @Recs 	int 		-- Number of records added to XLS
        	   , @Log 	bit 		-- Whether to log process detail
        	   , @FileName 	varchar(255)    	-- Excel FileName

    DECLARE @DDLFieldName	varchar(8000)	-- Excel 파일에 생성될 필드명
    DECLARE @FieldName		varchar(8000)	-- Excel 파일에 생성될 필드명
    DECLARE @SelectSQL   		varchar(8000)	-- 엑셀에 저장될 쿼리문


    -- EXCEL생성시 DATA 일자  
    -- 
    DECLARE @ymd_from		char(8)		
    DECLARE @ymd_to		char(8)		

    SELECT   @ymd_to 	= convert(char(6), dateadd(m,-1,getdate()), 112) + '31'
    SELECT   @ymd_from 	= left(@ymd_to,6) + '01' 

    SET @DDLFieldName = ' ' + 
	'PROD_YMD 	text, 	PROD_SHIFT		text,  	' +
	'WORK_QTY	text, 	WORK_RATE		text  ' 

    SET @FieldName = ' ' + 
	'PROD_YMD	, 	PROD_SHIFT	, ' +
	'WORK_QTY	, 	WORK_RATE	 ' 



    SET @SelectSQL = 'SELECT 			' +
	'PROD_YMD, 		PROD_SHIFT,  	' +
	'convert(varchar,WORK_QTY),		' +
	'convert(varchar,WORK_RATE)  		' +
      	'FROM   TH_DATA_DAY  ' +          
     	'WHERE   PROD_YMD >  ''' + @ymd_from + ''''    +
     	'     AND   PROD_YMD <= ''' + @ymd_to + ''''   

   
    SET @FileName = @ServerName + '_' + LEFT(@ymd_to,6) + '_' + REPLACE(CONVERT(VARCHAR(8), GETDATE(), 114),':','')

    SELECT @Recs = 0, @Log = 1 
    
    SET @Path = @ExcelFilePath + @FileName + '.xls'
    SET @Connect = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+@Path+';Extended Properties=Excel 8.0'


    SET @DDL = 'CREATE TABLE ' + @WKS_Name + '  ('+@DDLFieldName+')'
    SET @SQL = 'INSERT INTO '+ @ServerName+'...'+ @WKS_Name+' ('+@FieldName+') '
    SET @SQL = @SQL + @SelectSQL

 
    EXEC @hr = sp_OACreate 'ADODB.Connection', @Conn OUT

    IF @hr <> 0 
    BEGIN
	-- Return OLE error
	EXEC sp_OAGetErrorInfo @Conn, @src OUT, @desc OUT 
	SELECT Error=convert(varbinary(4),@hr), Source=@src, Description=@desc, 'SKIP-01'
	RETURN
    END
   

    EXEC @hr = sp_OASetProperty @Conn, 'ConnectionString', @Connect

    IF @hr <> 0
    BEGIN
	 -- Return OLE error
	EXEC sp_OAGetErrorInfo @Conn, @src OUT, @desc OUT 
	SELECT Error=convert(varbinary(4),@hr), Source=@src, Description=@desc, 'SKIP-02'
	RETURN
    END


    EXEC @hr = sp_OAMethod @Conn, 'Open'

    IF @hr <> 0
    BEGIN
	-- Return OLE error
	EXEC sp_OAGetErrorInfo @Conn, @src OUT, @desc OUT 
	SELECT ErrNum=@hr, Error=convert(varbinary(4),@hr), Source=@src, Description=@desc, 'SKIP-03'
	RETURN
    END


    EXEC @hr = sp_OAMethod @Conn, 'Execute', NULL, @DDL, NULL, 129 -- adCmdText + adExecuteNoRecords

    IF ((@hr = 0x80040E14) OR (@hr = 0x80042732))
    BEGIN
	-- Trap these OLE Errors
	IF @hr = 0x80040E14
	BEGIN
		PRINT char(9)+''''+@WKS_Name+''' Worksheet exists for append'
		SET @WKS_Created = 0
	END
	
	SET @hr = 0 -- ignore these errors
    END

    IF @hr <> 0
    BEGIN
	-- Return OLE error
	EXEC sp_OAGetErrorInfo @Conn, @src OUT, @desc OUT 
	SELECT Error=convert(varbinary(4),@hr), Source=@src, Description=@desc, 'SKIP-04'
	RETURN
    END

    EXEC @hr = sp_OADestroy @Conn
    IF @hr <> 0
    BEGIN
	-- Return OLE error
	EXEC sp_OAGetErrorInfo @Conn, @src OUT, @desc OUT 
	SELECT Error=convert(varbinary(4),@hr), Source=@src, Description=@desc, 'SKIP-05'
	RETURN
    END

    IF NOT EXISTS(SELECT srvname from master.dbo.sysservers where srvname = @ServerName)
    BEGIN
	EXEC sp_addlinkedserver @server = @ServerName
	        , @srvproduct = 'Microsoft Excel Workbook'
	        , @provider = 'Microsoft.Jet.OLEDB.4.0'
	        , @datasrc = @Path
	        , @provstr = 'Excel 8.0' 
	
	EXEC sp_addlinkedsrvlogin @ServerName, 'false' 
    END

    EXEC (@SQL)


    PRINT CONVERT(varchar,@@ROWCOUNT)+' Rows Affected...'   

    IF EXISTS(SELECT srvname from master.dbo.sysservers where srvname = @ServerName)
    BEGIN
	EXEC sp_dropserver @ServerName, 'droplogins'
    END
 

  SET NOCOUNT OFF
 

END









GO

