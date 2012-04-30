/*
  file name : sp_get_nextdate.sql
  system    : cmms system
  procedure name  : sp_get_nextdate
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_get_nextdate]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_get_nextdate]
go

/*
execute sp_get_nextdate
*/

create procedure [dbo].[sp_get_nextdate]
@scycle varchar(30),
@picycle  int,
@pdDATE datetime,
@pdNEXTDUEDATE  datetime output
as
begin -- procedure begin
select  @pdNEXTDUEDATE = @pdDATE
--IF @pdNEXTDUEDATE >= DATEADD(DAY, -1, GETDATE())  -- 현재일이거나 현재일 이후이면 RETURN
--   BEGIN
--      RETURN
--   END
IF @scycle = '년'
   BEGIN
--     WHILE @pdNEXTDUEDATE < GETDATE()
         BEGIN
            SELECT @pdNEXTDUEDATE = DATEADD(YEAR, 1*@picycle, @pdNEXTDUEDATE)
         END
   END
ELSE IF @scycle = '반기'
   BEGIN
--    WHILE @pdNEXTDUEDATE < GETDATE()
        BEGIN
            SELECT @pdNEXTDUEDATE = DATEADD(MONTH, 6*@picycle, @pdNEXTDUEDATE)
         END
   END
ELSE IF @scycle = '분기'
   BEGIN
--    WHILE @pdNEXTDUEDATE < GETDATE()
         BEGIN
            SELECT @pdNEXTDUEDATE = DATEADD(MONTH, 3*@picycle, @pdNEXTDUEDATE)
         END
   END
ELSE IF @scycle = '월'
   BEGIN
--    WHILE @pdNEXTDUEDATE < GETDATE()
         BEGIN
            SELECT @pdNEXTDUEDATE = DATEADD(MONTH, 1*@picycle, @pdNEXTDUEDATE)
         END
   END
ELSE IF @scycle = '주'
   BEGIN
-- WHILE @pdNEXTDUEDATE < GETDATE()
         BEGIN
        SELECT @pdNEXTDUEDATE = DATEADD(WEEK, 1*@picycle, @pdNEXTDUEDATE)
         END
   END
ELSE IF @scycle = '일'
   BEGIN
 --WHILE @pdNEXTDUEDATE < GETDATE()
         BEGIN
            SELECT @pdNEXTDUEDATE = DATEADD(DAY, 1*@picycle, @pdNEXTDUEDATE)
         END
   END
select @pdNEXTDUEDATE
RETURN
end -- procedure end