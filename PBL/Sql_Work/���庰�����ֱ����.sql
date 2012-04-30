SELECT	areacode = A.AreaCode,   
	         	divisioncode = A.DivisionCode,   
	         	suppliercode = A.SupplierCode, 
				supplierno = B.SupplierNo,   
	         	supplierkorname = B.SupplierKorName,    
	         	suppliercycle = cast(A.SupplyTerm as varchar(10)) + '-' + 
							cast(A.SupplyEditNo as varchar(10)) + '-' + 
							cast(A.SupplyCycle as varchar(10)), 
	        	C.PartEditNo,   
	        	C.PartEditTime
    FROM 	TMSTPARTCYCLE	A inner join  TMSTSUPPLIER		B  
				on  A.SupplierCode 		= B.SupplierCode
				inner join tmstpartedit c
				on a.areacode = c.areacode and a.divisioncode = c.divisioncode and
					a.suppliercode = c.suppliercode
   WHERE  A.AreaCode 		= 'D'  AND  
         		  A.DivisionCode 	= 'A'  AND    
         		  A.ApplyTo 		= '9999.12.31' and
				   b.xstop <> 'X' and
				  c.ApplyFrom 	<= A.ApplyFrom  	AND  
	         		c.ApplyTo 	>= A.ApplyFrom 

select supplicode
select areacode, divisioncode,suppliercode
FROM [ipisele_svr\ipis].ipis.dbo.TMSTPARTCYCLE	A
	 inner join  [ipisele_svr\ipis].ipis.dbo.TMSTSUPPLIER		B  
				on  A.SupplierCode 		= B.SupplierCode
where  A.ApplyTo 		= '9999.12.31' and
		b.xstop <> 'X'
union all
select areacode, divisioncode,suppliercode
FROM [ipismac_svr\ipis].ipis.dbo.TMSTPARTCYCLE	A
	 inner join  [ipismac_svr\ipis].ipis.dbo.TMSTSUPPLIER		B  
				on  A.SupplierCode 		= B.SupplierCode
where  A.ApplyTo 		= '9999.12.31' and
		b.xstop <> 'X'
union all
select areacode, divisioncode,suppliercode
FROM [ipishvac_svr\ipis].ipis.dbo.TMSTPARTCYCLE	A
	 inner join  [ipishvac_svr\ipis].ipis.dbo.TMSTSUPPLIER		B  
				on  A.SupplierCode 		= B.SupplierCode
where  A.ApplyTo 		= '9999.12.31' and
		b.xstop <> 'X'
union all
select areacode, divisioncode,suppliercode
FROM [ipisjin_svr].ipis.dbo.TMSTPARTCYCLE	A
	 inner join  [ipisjin_svr].ipis.dbo.TMSTSUPPLIER		B  
				on  A.SupplierCode 		= B.SupplierCode
where  A.ApplyTo 		= '9999.12.31' and
		b.xstop <> 'X'