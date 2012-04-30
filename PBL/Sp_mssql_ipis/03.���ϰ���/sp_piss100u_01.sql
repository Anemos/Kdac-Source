/*
	File Name	: sp_piss100u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_piss100u_01
	Description	: ��������
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: �������
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss100u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss100u_01]
GO
/*
Exec sp_piss100u_01 @ps_srno          ='291192P00',
                    @ps_applydate     ='2002.11.07',
                    @ps_areacode      = 'D',
                    @ps_divisioncode  = 'S',
                    @ps_empno         = 'DS0',
	            @pi_rackqty       = 96,
                    @ps_srgubun       ='S'
*/
CREATE PROCEDURE sp_piss100u_01
	         @ps_srno               char(11),       -- SR��ȣ
                 @ps_applydate	        Char(10),       -- ������
                 @ps_areacode           char(01),       -- ��������
                 @ps_divisioncode       char(01),       -- �����ڵ�
	         @ps_empno	        Char(06),       -- ����������
                 @pi_rackqty            integer,        -- �����
                 @ps_srgubun            char(01)        -- ����OEM����
AS

BEGIN

  SELECT SRNo	        = A.SRNo,   
         TruckOrder	= IsNUll(B.TruckOrder, 0),
         CustCode	= A.CustCode,   
         ApplyDate	= @ps_applydate,
	 ShipEditNo	= A.ShipEditNo,   
         SRGubun	= @ps_srgubun,   
         TruckNo	= B.TruckNo,   
         ItemCode	= A.ItemCode,   
	 TruckLoadQty	= IsNull(B.TruckLoadQty, 0) / @pi_rackqty,
         TruckDansuQty   = IsNull(B.TruckLoadQty, 0)% @pi_rackqty,
         lastemp	= @ps_empno,
         LastDate	= GetDate(),
         ShipRemainQty	= A.ShipRemainQty,
	 RackQty	= @pi_rackqty,
         Divisioncode   = A.divisioncode
    FROM tsrorder A,
	 tloadplan B   
   WHERE A.SRNo 	*= B.SRNo
     and a.areacode     *= b.areacode
     and a.divisioncode *= b.divisioncode
     and A.srAreaCode     = @ps_areacode
     and A.srDivisioncode = @ps_divisioncode
     and A.ShipRemainQty 	> 0 
     and B.Truckno      is Null
     and A.SRNo         = @ps_srno
     and B.ShipPlanDate = @ps_applydate

end



GO
