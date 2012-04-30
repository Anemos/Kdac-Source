if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_GET_time]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_GET_time]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE SP_GET_time
@dt_from	datetime,
@dt_to	datetime
AS
BEGIN
select datediff(minute,@dt_from,@dt_to)
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

