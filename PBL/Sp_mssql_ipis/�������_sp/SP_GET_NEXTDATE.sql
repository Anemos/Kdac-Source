SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

ALTER  PROCEDURE SP_GET_NEXTDATE
@scycle	varchar(30),
@picycle	int,
@pdDATE	datetime,
@pdNEXTDUEDATE  datetime output
as
begin -- procedure begin
select  @pdNEXTDUEDATE = @pdDATE
--IF @pdNEXTDUEDATE >= DATEADD(DAY, -1, GETDATE())  -- �������̰ų� ������ �����̸� RETURN
--   BEGIN
--      RETURN
--   END
IF @scycle = '��'
   BEGIN
--     WHILE @pdNEXTDUEDATE < GETDATE()
         BEGIN
            SELECT @pdNEXTDUEDATE = DATEADD(YEAR, 1*@picycle, @pdNEXTDUEDATE)
         END
   END
ELSE IF @scycle = '�ݱ�'
   BEGIN
--    WHILE @pdNEXTDUEDATE < GETDATE()
        BEGIN
            SELECT @pdNEXTDUEDATE = DATEADD(MONTH, 6*@picycle, @pdNEXTDUEDATE)
         END
   END
ELSE IF @scycle = '�б�'
   BEGIN
--    WHILE @pdNEXTDUEDATE < GETDATE()
         BEGIN
            SELECT @pdNEXTDUEDATE = DATEADD(MONTH, 3*@picycle, @pdNEXTDUEDATE)
         END
   END
ELSE IF @scycle = '��'
   BEGIN
--    WHILE @pdNEXTDUEDATE < GETDATE()
         BEGIN
            SELECT @pdNEXTDUEDATE = DATEADD(MONTH, 1*@picycle, @pdNEXTDUEDATE)
         END
   END
ELSE IF @scycle = '��'
   BEGIN
-- WHILE @pdNEXTDUEDATE < GETDATE()
         BEGIN
        SELECT @pdNEXTDUEDATE = DATEADD(WEEK, 1*@picycle, @pdNEXTDUEDATE)
         END
   END
ELSE IF @scycle = '��'
   BEGIN
 --WHILE @pdNEXTDUEDATE < GETDATE()
         BEGIN
            SELECT @pdNEXTDUEDATE = DATEADD(DAY, 1*@picycle, @pdNEXTDUEDATE)
         END
   END
select @pdNEXTDUEDATE
RETURN
end -- procedure end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

