/*
  file name : sp_set_ftpfile.sql
  system    : cmms system
  procedure name  : sp_set_ftpfile
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_set_ftpfile]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_set_ftpfile]
go

/*
execute sp_set_ftpfile
*/

create PROCEDURE [dbo].[sp_set_ftpfile]
  @AREA_CODE CHAR(1),
  @FACTORY_CODE CHAR(1),
  @EQUIP_CODE VARCHAR(9),
  @FILE_NAME VARCHAR(100),
  @FILE_DESC VARCHAR(255),
  @FILE_SIZE INT,
  @LASTEMP CHAR(6),
  @File_ID CHAR(10) output

AS
  DECLARE   @LASTDATE DATETIME,
      @Header CHAR(6),
      @Index CHAR(4)

BEGIN
  Select @Header = Substring(convert(VARCHAR(30), getdate(), 112), 1, 6)
  if exists (Select 1 From cmms.dbo.equip_ftpfile Where substring(file_id, 1,6) = @Header)
    begin
      Select @Index = str(Max(substring(file_id, 7, 4))+1, 4, 0) From cmms.dbo.equip_ftpfile
      Where substring(file_id, 1,6) = @Header
    end
  else
    Set @Index = '0001'


  if @index  = '****'
    begin
      Set @File_Id = 'XXXXXXXXXX'
    end
  else
    begin
      Set @File_Id = @Header + Replace(@Index, ' ', 0)
      Set @LASTDATE = getdate()

      Insert Into cmms.dbo.equip_ftpfile Values(@File_Id, @AREA_CODE, @FACTORY_CODE, @EQUIP_CODE,
                    @FILE_NAME, @FILE_DESC, @FILE_SIZE, @LASTEMP, @LASTDATE)
    end

Select @File_Id

END