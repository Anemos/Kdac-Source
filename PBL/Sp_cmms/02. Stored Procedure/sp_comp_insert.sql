/*
  file name : sp_comp_insert.sql
  system    : cmms system
  procedure name  : sp_comp_insert
  description : EIS DB�� �۾���� Summary �۾�
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_comp_insert]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_comp_insert]
go

/*
execute sp_comp_insert
*/

create procedure [dbo].[sp_comp_insert]
as

BEGIN -- BEGIN PROCEDURE

  DELETE FROM COMP_MASTER
  WHERE COMP_DIV_CODE1='���־�ü'

  INSERT INTO COMP_MASTER (COMP_CODE, COMP_NAME, COMP_DIV_CODE1, COMP_ADDRESS, COMP_BOSS, COMP_ZIPCODE, COMP_PHONE, COMP_FAX)
  SELECT SUPPLIERCODE, SUPPLIERKORNAME, '���־�ü', SUPPLIERADDRESS, SUPPLIERHEADNAME, SUPPLIERPOSTNO, SUPPLIERTELNO, SUPPLIERFAXNO
  FROM IPIS.DBO.TMSTSUPPLIER
  WHERE ISNULL(XSTOP,'') <> 'X'

END -- END PROCEDURE