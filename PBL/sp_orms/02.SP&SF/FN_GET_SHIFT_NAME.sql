USE [ORMS]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_GET_SHIFT_NAME]    Script Date: 01/17/2011 10:14:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[FN_GET_SHIFT_NAME]')
        And OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
  Drop FUNCTION [dbo].[FN_GET_SHIFT_NAME]
GO

/*
--------------------------------------------------------------------
TITLE 		: SHIFT코드로 SHIFT명 조회
DATE		: 2010.06.01
CREATOR	: FIT
DESCRIPTION	: 
	SELECT dbo.FN_GET_SHIFT_NAME('1')
--------------------------------------------------------------------
*/
CREATE    	FUNCTION  [dbo].[FN_GET_SHIFT_NAME]
(
  @parm_SHIFT	AS VARCHAR(1)		-- SHIFT   
)

RETURNS VARCHAR(10) AS  

BEGIN 

  DECLARE @ls_SHIFT_NAME	AS VARCHAR(10)

  IF (@parm_SHIFT = '1')
	SET @ls_SHIFT_NAME = '주간'
  ELSE
	SET @ls_SHIFT_NAME = '야간'

  RETURN @ls_SHIFT_NAME

END



GO

