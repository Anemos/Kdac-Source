/*
  File Name : sp_mpms_create_data.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_create_data
  Description : 부서, 인원 정보 생성
  Use DataBase  : MPMS
  Use Program :
  Use Table : tmstdept, tmstemp
  Parameter : 
  Initial   : 2004.03.31
  Author    : Kiss Kim
*/


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_create_data]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_create_data]
GO

/*
Execute sp_mpms_create_data
*/

Create Procedure sp_mpms_create_data

As
Begin

truncate table tmstdept
insert into tmstdept
select * from [ipisele_svr\ipis].ipis.dbo.tmstdept

truncate table tmstemp
insert into tmstemp
select * from [ipisele_svr\ipis].ipis.dbo.tmstemp

End   -- Procedure End

Go
