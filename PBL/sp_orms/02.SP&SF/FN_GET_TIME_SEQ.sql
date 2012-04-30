USE [ORMS]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_GET_TIME_SEQ]    Script Date: 01/17/2011 10:14:38 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[FN_GET_TIME_SEQ]')
        And OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
  Drop FUNCTION [dbo].[FN_GET_TIME_SEQ]
GO


/*
--------------------------------------------------------------------
TITLE 		: 시간대별 정열순서를 조회 
DATE		: 2010.06.01
CREATOR	: FIT
DESCRIPTION	: 
	SELECT dbo.FN_GET_TIME_SEQ('101')
--------------------------------------------------------------------
*/
CREATE  	  FUNCTION  [dbo].[FN_GET_TIME_SEQ] 
(
  @parm_HH 	AS VARCHAR(3)		-- 시각   
)

RETURNS INT AS  

BEGIN 

  DECLARE @li_SEQ	AS INT

  SELECT @li_SEQ = RecordID
     FROM TH_WORK_TIME
   WHERE HH 	= @parm_HH


  RETURN @li_SEQ

END





GO

