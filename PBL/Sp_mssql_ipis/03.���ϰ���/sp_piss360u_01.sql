/*
	File Name	: sp_piss360u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss360u_01
	Description	: 현품표취소
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Initial		: 2002. 09. 17
	Author		: 대우정보
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss360u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss360u_01]
GO
/*
exec sp_piss360u_01 @ps_areacode         = 'D',           -- 지역구분        
                    @ps_divisioncode	 = 'A',           -- 공장코드  
                    @ps_productgroup     = '%',
                    @ps_modelgroup       = '%',
                    @ps_itemcode        = '%'
*/

Create Procedure sp_piss360u_01                    @ps_areacode         char(01),
                    @ps_divisioncode	 char(01),
                    @ps_productgroup     varchar(03),
                    @ps_modelgroup       varchar(04),
                    @ps_itemcode         varchar(12)

As
Begin
   select itemcode = a.itemcode,
          itemname = a.itemname
     from tmstitem a, tmstmodel b
    where b.areacode = @ps_areacode
      and b.divisioncode = @ps_divisioncode
      and b.itemcode = a.itemcode
      and b.productgroup like @ps_productgroup
      and b.modelgroup like @ps_modelgroup
      and b.itemcode like @ps_itemcode
end


GO
