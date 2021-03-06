if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_WO_CLOSE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_WO_CLOSE]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE SP_WO_CLOSE
@LS_WO_CODE VARCHAR(30)
AS
BEGIN
BEGIN TRAN
INSERT INTO WO_HIST 
	SELECT *
	from WO
	where WO_CODE=@LS_WO_CODE
DELETE WO where WO_CODE=@LS_WO_CODE
COMMIT TRAN
select @@ROWCOUNT
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

