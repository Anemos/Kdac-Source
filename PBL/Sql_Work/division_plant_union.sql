select 'Z' ,'전체 ', '전체 '
From	tmstarea		A
Where	A.AreaCode	= 'D'

union all

Select	AreaCode	= A.AreaCode,
	AreaName	= A.AreaName,
	DisplayName	= A.AreaName + '(' + A.AreaCode + ')'
From	tmstarea		A
Where	A.AreaCode	Like '%'
Group By A.AreaCode, A.AreaName, A.SortOrder


select 'Z' ,'전체 ', 'Z','전체 ','TOTAL',' ',' '
From	tmstarea		A
Where	A.AreaCode	= 'D'

union all

Select	AreaCode	= A.AreaCode,
	AreaName	= B.AreaName,
	DivisionCode	= A.DivisionCode,
	DivisionName	= A.DivisionName,
	DivisionNameEng	= A.DivisionNameEng,
	ServerName	= A.ServerName,
	DisplayName	= A.DivisionName + '(' + A.AreaCode + A.DivisionCode + ')'
From	tmstdivision	A,
	tmstarea		B
Where	A.AreaCode	Like 'J%'		And
	A.DivisionGubun	Like '%'	And
	A.DivisionCode	Like '%'	And
	A.AreaCode	= B.AreaCode
Group By A.AreaCode, B.AreaName, A.DivisionCode, A.DivisionName, A.DivisionNameEng, B.SortOrder, A.SortOrder, A.ServerName


