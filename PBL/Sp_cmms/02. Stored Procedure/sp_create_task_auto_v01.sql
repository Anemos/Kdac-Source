/*
  file name : sp_create_task_auto.sql
  system    : cmms system
  procedure name  : sp_create_task_auto
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_create_task_auto]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_create_task_auto]
go

/*
execute sp_create_task_auto
*/

create procedure [dbo].[sp_create_task_auto]
AS
Begin -- Begin PROCEDURE

Declare   @NextWoNo     AS VarChar(30)
Declare   @EquipCode    AS VarChar(30)
Declare   @Div      AS VarChar(30)
Declare   @Area       AS VarChar(30)
Declare   @Factory    AS VarChar(30)
Declare   @EstDate    AS Char(10)
Declare   @li_Serial    AS Int
Declare   @li_TotCnt    AS Int

  Create  Table #Task_Gen  (
        Serial      Int identity(1,1) Not Null,
        Equip_Code    VarChar(9)    Null,
        Class_Div   VarChar(30)   Null,
        Area_Code     Char(1)       Null,
        Factory_Code  Char(1)     Null,
        Class_Est_Date  Char(10)    Null )

  Insert Into #Task_Gen (Equip_Code, Class_Div, Area_Code, Factory_Code, Class_Est_Date)
  Select Distinct A.Equip_Code, A.Class_Div, B.Area_Code, B.Factory_Code,
    Case When Convert(VarChar(10), A.Class_Est_Date, 120) < Convert(VarChar(10), GetDate(), 120) Then
        Convert(VarChar(10), GetDate(), 120)
      Else Convert(VarChar(10), A.Class_Est_Date, 120) End as Class_Est_Date
  From Equip_Class A inner join Equip_Master B
    on A.area_code = B.area_code and A.factory_code = B.factory_code and A.equip_code = B.equip_code
  Where Convert(VarChar(10), A.Class_Est_Date, 120) <= Convert(VarChar(10), DateAdd(dd, 10, GetDate()), 120)
      And B.Equip_Div_Code Not IN ('8', '9', 'X') And A.Class_Div <> '04'
  Order by Class_Est_Date

  Select @li_Serial = 0, @li_TotCnt = @@RowCount
  If (@li_TotCnt  = 0 ) Return

  Begin TRAN

  While @li_Serial < @li_TotCnt
  Begin
    Select Top 1
        @li_Serial = A.Serial,
        @EquipCode  = A.Equip_Code,
        @Div = A.Class_Div,
        @Area = A.Area_Code,
        @Factory = A.Factory_Code,
        @EstDate = A.Class_Est_Date
      From #Task_Gen A
    Where A.Serial > @li_Serial
     Order by A.Serial

    EXEC SP_GET_NEXTTaskNO @Area, @Factory, 'PM', @NextWoNo   output-- ���� �۾����� ��ȣ�� �����´�.
    Insert Into Task_Class  (
          Task_Code, Class_Div, Class_Spot, Class_Item, Class_Basis, Class_Process,
          Class_Est_Time_Hour, Class_Est_Time_Min, Part_Code, Class_est_Qty)
    Select @NextWoNo, Class_Div, Class_Spot, Class_Item, Class_Basis, Class_Process,
        Class_Est_Time_Hour, Class_Est_Time_Min, Part_Code,Class_Qty
      From Equip_Class
    Where area_code = @Area and factory_code = @Factory
        and Equip_Code = @EquipCode And Class_Div = @Div
        And Class_Div <> '04'
        And ( Case When Convert(VarChar(10), Class_Est_Date, 120) < Convert(VarChar(10), GetDate(), 120) Then
          Convert(VarChar(10), GetDate(), 120)
          Else Convert(VarChar(10), Class_Est_Date, 120) End ) = @EstDate

    Insert Into Task_Part (Task_Code, Part_Code, est_Qty)
    Select @NextWoNo, Part_Code, sum(Class_Qty)
      From Equip_Class
    Where area_code = @Area and factory_code = @Factory
        and Equip_Code = @EquipCode And Class_Div = @Div And Part_Code <> ''
        And Class_Div <> '04'
        And ( Case When Convert(VarChar(10), Class_Est_Date, 120) < Convert(VarChar(10), GetDate(), 120) Then
          Convert(VarChar(10), GetDate(), 120)
          Else Convert(VarChar(10), Class_Est_Date, 120) End ) = @EstDate
    Group by Part_Code

    Insert Into Task (Task_Code, Area_Code, Factory_Code, Equip_Code, exam_date, status_Code)
    values(@NextWoNo, @Area, @Factory, @EquipCode, Cast(@EstDate as Datetime), '��ȹ')

    UPDATE Equip_Class
    SET Class_Est_Date =  case When Cycle_Code = '��' then DateAdd(YEAR, (1 * Class_Cycle), Cast(@EstDate as Datetime))
      When Cycle_Code = '�ݱ�' then DateAdd(MONTH, (6 * Class_Cycle), Cast(@EstDate as Datetime))
      When Cycle_Code = '�б�' then DateAdd(MONTH, (3 * Class_Cycle), Cast(@EstDate as Datetime))
      When Cycle_Code = '��' then DateAdd(MONTH, (1 * Class_Cycle), Cast(@EstDate as Datetime))
      When Cycle_Code = '��' then DateAdd(WEEK, (1 * Class_Cycle), Cast(@EstDate as Datetime))
      When Cycle_Code = '��' then DateAdd(DAY, (1* Class_Cycle), Cast(@EstDate as Datetime))
      Else Class_Est_Date End
    Where area_code = @Area and factory_code = @Factory
        and Equip_Code = @EquipCode And Class_Div = @Div
        And Class_Div <> '04'
        And ( Case When Convert(VarChar(10), Class_Est_Date, 120) < Convert(VarChar(10), GetDate(), 120) Then
          Convert(VarChar(10), GetDate(), 120)
          Else Convert(VarChar(10), Class_Est_Date, 120) End ) = @EstDate
  End

  COMMIT TRAN

  DROP TABLE #Task_Gen

End -- End PROCEDURE