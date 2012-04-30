if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_PART_HIST]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_PART_HIST]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE SP_PART_HIST
@area_code varchar(30),
@factory_code varchar(30)

AS
BEGIN


  SELECT '불출' as hist_div,
part_out.area_code as area_code,   
         part_out.factory_code as factory_code,   
         part_out.part_code as part_code,   
         part_out.part_tag as part_tag,   
         part_out.wo_code as wo_code,   
         part_out.dept_code as dept_code,   
         part_out.part_used as part_used,   
         part_out.equip_code as equip_code,   
         part_out.out_date as out_date,   
         part_out.invy_state as invy_state,   
         part_out.out_qty as out_qty,   
         part_out.out_serial as out_serial,   
         part_out.input_div as input_div,   
         part_out.up_div as up_div,   
         part_master.part_name as part_name
    FROM part_out,   
         part_master  
   WHERE ( part_out.part_code = part_master.part_code ) and  
         ( part_out.area_code = @area_code ) AND  
         ( part_out.factory_code = @factory_code )    

union

  SELECT '반납' as hist_div,
part_return.area_code as area_code,   
         part_return.factory_code as factory_code,   
         part_return.part_code as part_code,   
         part_return.part_tag as part_tag,   
         part_return.wo_code as wo_code,   
         part_return.dept_code as dept_code,   
         part_return.part_used as part_used,   
         part_return.equip_code as equip_code,   
         part_return.return_date as out_date,   
         part_return.invy_state as invy_state,   
         part_return.return_qty as out_qty,   
         part_return.return_serial as out_serial,   
         part_return.input_div as input_div,   
         part_return.up_div as up_div,   
         part_master.part_name  as part_name
    FROM part_return,   
         part_master  
   WHERE ( part_return.part_code = part_master.part_code ) and  
         ( part_return.area_code = @area_code ) AND  
         ( part_return.factory_code = @factory_code )  
order by hist_div desc

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

