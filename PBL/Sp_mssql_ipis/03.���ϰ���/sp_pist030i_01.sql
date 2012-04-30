/*
	File Name	: sp_pist030i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pist030i_01
	Description	: LOT�и���Ȳ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pist030i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pist030i_01]
GO

/*
Exec sp_pist030i_01 @ps_fromdate = '2000.01.01',      --������
	            @ps_enddate	 = '2002.12.31',      --������
                    @ps_areacode = 'J',               --����
                    @ps_divisioncode = 'S',           --����
                    @ps_workcenter = '%',             --��
                    @ps_linecode ='%'                 --�����ڵ�

*/

CREATE PROCEDURE sp_pist030i_01
	      @ps_fromdate	      char(10),       --������
	      @ps_enddate	      char(10),       --������
              @ps_areacode            char(01),       --����
              @ps_divisioncode        char(01),       --����
              @ps_workcenter          varchar(05),    --��
              @ps_linecode            char(01)        --�����ڵ�
AS

BEGIN

  SELECT tracedate      = A.TraceDate,
         divisioncode   = C.divisioncode,
	 workcode       = C.workcenter,
         workcentername = C.WorkCenterName,
         linecode       = D.linecode,
         LineName       = F.lineshortname,
         itemcode       = D.itemcode,
         itemname       = E.itemname,
         modelid        = B.ModelID,
         kbno           = A.KBNo,
         rackqty        = A.RackQty,
	 lotno          = A.LotNo,
	 divideqty      = A.DivideQty
    FROM tlotnodivide A,   
         tmstkb B,   
         tmstworkcenter C,
         tkbhis D,
         tmstitem E,
         tmstLine F
   WHERE (D.areacode      = @ps_areacode)
     and (D.divisioncode  like @ps_divisioncode)
     and (D.workcenter    like @ps_workcenter)
     and (D.LineCode      like @ps_linecode)
     and (A.TraceDate     >= @ps_fromdate)
     and (A.Tracedate     <= @ps_enddate)
     and (D.Areacode      = C.areacode)
     and (D.Divisioncode  = C.divisioncode)
     and (D.workcenter    = C.workcenter)
     and (A.KBNo          = D.KBNo)
     and (A.KBReleaseDate = D.KBReleaseDate)
     and (A.KBReleaseSeq  = D.KBReleaseSeq)
     and (D.itemcode      = E.itemcode)
     and (D.Areacode      = F.areacode)
     and (D.Divisioncode  = F.divisioncode)
     and (D.workcenter    = F.workcenter)
     and (D.Linecode      = F.linecode)
END 


GO
