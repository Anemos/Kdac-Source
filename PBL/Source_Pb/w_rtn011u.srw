$PBExportHeader$w_rtn011u.srw
$PBExportComments$유사품번 등록[결재]
forward
global type w_rtn011u from w_origin_sheet01
end type
type dw_1 from datawindow within w_rtn011u
end type
type st_2 from statictext within w_rtn011u
end type
type sle_itno from singlelineedit within w_rtn011u
end type
type pb_find_item from picturebutton within w_rtn011u
end type
type dw_2 from datawindow within w_rtn011u
end type
type uo_1 from uo_plandiv_pdcd_rtn within w_rtn011u
end type
type gb_2 from groupbox within w_rtn011u
end type
end forward

global type w_rtn011u from w_origin_sheet01
string tag = "유사품번등록"
string title = "유사품번등록"
boolean clientedge = true
dw_1 dw_1
st_2 st_2
sle_itno sle_itno
pb_find_item pb_find_item
dw_2 dw_2
uo_1 uo_1
gb_2 gb_2
end type
global w_rtn011u w_rtn011u

type variables
datastore i_ds_data
string i_s_selected
datawindowchild child_div
long     i_i_LastRow,oldw,oldh
end variables

forward prototypes
public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw)
public subroutine wf_protect (string ag_s_column, integer ag_n_number, datawindow ag_dw_1)
public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1)
public subroutine wf_set_dw1 (string i_s_protect)
end prototypes

public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw);integer	l_i_Idx, l_i_last_row

l_i_last_row = i_i_LastRow

dw.setredraw(false)
dw.selectrow(0,false)

If l_i_last_row = 0 then
	dw.setredraw(true)
	Return 1
end if

if l_i_last_row > al_aclickedrow then
	For l_i_Idx = l_i_last_row to al_aclickedrow STEP -1
		dw.selectrow(l_i_Idx,TRUE)	
	end for	
else
	For l_i_Idx = l_i_last_row to al_aclickedrow 
		dw.selectrow(l_i_Idx,TRUE)	
	next	
end if

dw.setredraw(true)
Return 1

end function

public subroutine wf_protect (string ag_s_column, integer ag_n_number, datawindow ag_dw_1);string l_s_command
long 	 l_l_color = 16777215						//	white

//--	Argument	=> ag_s_column = column 명, 
//---             ag_n_number = column 순서,
ag_dw_1.setredraw(False)
l_s_command	=	ag_s_column + ".Protect = '1" &            
					+	"~tIf(mid(pt_chk," + string(ag_n_number) + ", 1) = " + "~~'1~~'," &
					+  " 1, 0 )'"
					
ag_dw_1.Modify(l_s_command)
ag_dw_1.setredraw(True)
l_s_command = ' '
l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_color) &            
					+	"~tIf(mid(pt_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," & 
					+ 	" rgb(192,192,192), rgb(255,250,239))'"			

ag_dw_1.Modify(l_s_command)
ag_dw_1.setredraw(True)

end subroutine

public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1);string l_s_command
long 	 l_l_color = 16777215						//	white

//--	Argument	=> ag_s_column = column 명, 
//---             ag_n_number = column 순서,
//--  				ag_n_color  = column 색상( 1 = Cream[255,250,239], 2 = White[255,255,255] )  
// ag_dw_1.setredraw(False)
if ag_n_color 	= 	1	then
	l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_color) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~' ," & 
					+ 	" rgb(255,255,0), " + "~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'2~~' ," &
					+  " rgb(192,192,192),rgb(255,250,239)))'"
else
	l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_color) &            
					+	"~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~' ," & 
					+ 	" rgb(255,255,0), " + "~tIf(mid(cp_chk," + string(ag_n_number) + ", 1) =" + "~~'2~~' ," &
					+  " rgb(192,192,192),rgb(255,255,255)))'"
end if
ag_dw_1.Modify(l_s_command)
// ag_dw_1.setredraw(True)
end subroutine

public subroutine wf_set_dw1 (string i_s_protect);if i_s_protect = 'P' then
   dw_1.object.rtn011_raitno1.background.color = rgb(192,192,192)
//	dw_1.object.rtn011_raedfm.background.color = rgb(255,255,239)
//	dw_1.object.rtn011_raedfm.protect = false
	dw_1.object.rtn011_raitno1.protect = true
	dw_1.setfocus()
elseif i_s_protect = 'I' then
	dw_1.object.rtn011_raitno1.background.color = rgb(192,192,192)
//	dw_1.object.rtn011_raedfm.background.color = rgb(192,192,192)
//	dw_1.object.rtn011_raedfm.protect = true
	dw_1.object.rtn011_raitno1.protect = true
end if


end subroutine

on w_rtn011u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_2=create st_2
this.sle_itno=create sle_itno
this.pb_find_item=create pb_find_item
this.dw_2=create dw_2
this.uo_1=create uo_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.sle_itno
this.Control[iCurrent+4]=this.pb_find_item
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.gb_2
end on

on w_rtn011u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.sle_itno)
destroy(this.pb_find_item)
destroy(this.dw_2)
destroy(this.uo_1)
destroy(this.gb_2)
end on

event ue_retrieve;Long	l_n_Rows,l_n_root,l_n_tvi
integer i
string l_s_parm,l_s_plant,l_s_div,l_s_pdcd,l_s_itemname,l_s_rhitno
s_inv101_info st_data

SetPointer(HourGlass!)

uo_status.st_message.text = ""

dw_1.reset()
dw_2.reset()

wf_set_dw1('P')
//----------- 공장 선택 ----------

l_s_parm  = uo_1.uf_Return()
l_s_plant = mid(l_s_parm,1,1)
l_s_div   = mid(l_s_parm,2,1)
l_s_pdcd  = trim(mid(l_s_parm,3,2))
i_s_Selected = ''
l_s_rhitno = trim(sle_itno.text)

if f_spacechk(l_s_rhitno) = -1 then
	l_n_rows =dw_2.retrieve(l_s_plant,l_s_div,l_s_pdcd + '%',l_s_rhitno + '%')
	if l_n_rows < 1 then
		uo_status.st_message.text = f_message("I020")
		return
	end if
else
   l_n_rows =dw_2.retrieve(l_s_plant,l_s_div,l_s_pdcd + '%',l_s_rhitno + '%')
	if l_n_rows < 1 then
		uo_status.st_message.text = f_message("I020")
		return
	end if 

	if dw_1.retrieve(l_s_plant,l_s_div,l_s_rhitno ) < 1 then
	   uo_status.st_message.text = f_message("I020")
		return
	end if
	i_s_selected = 'C'
end if 
uo_status.st_message.text = f_message("I010")
i_b_retrieve = true
i_b_insert = true
i_b_save = true
i_b_delete = true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	              i_b_dprint,   i_b_dchar)

end event

event open;call super::open;//f_window_resize(this)


dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
i_s_selected = ''

wf_set_dw1('P')

//i_s_sqlselect = dw_1.getsqlselect()

i_b_dretrieve = false
i_b_dprint = false
i_b_dchar = false

i_b_retrieve = true
i_b_insert = true
i_b_save = false
i_b_delete = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	              i_b_dprint,   i_b_dchar)
					

end event

event close;call super::close;destroy i_ds_data  
end event

event ue_save;call super::ue_save;string l_s_plant,l_s_rhdvsn,l_s_pdcd,l_s_rhitno,l_s_rhitno1,l_s_rhedfm,l_s_chk,l_s_errcd,l_s_column,l_s_riedfm,l_s_array[]
string ls_message, ls_chtime, ls_pcls
integer i,l_s_count,l_s_rowcount,l_n_sqlcount,l_n_check
s_inv101_info st_data

uo_status.st_message.text = ""

SetPointer(HourGlass!)
l_s_rowcount = dw_1.rowcount()

for i = 1 to l_s_rowcount
	l_s_array[i] = dw_1.object.rtn011_raitno1[i]
next

dw_1.accepttext()

string l_s_parm

l_s_parm    = uo_1.uf_Return()
l_s_plant   = mid(l_s_parm,1,1)
l_s_rhdvsn  = mid(l_s_parm,2,1)
l_s_pdcd    = mid(l_s_parm,3,2)

for i = 1 to l_s_rowcount
	l_s_errcd = '2'
	if dw_1.getitemstatus(i,'rtn011_raitno1',primary!) <> NewModified! and dw_1.getitemstatus(i,'rtn011_raitno1',primary!) <> DataModified! then
		dw_1.object.cp_chk[i] = '2 '
		continue
	end if
	
	l_s_rhedfm  = trim(dw_1.object.rtn011_raedfm[i])
	
	l_s_rhitno1 = dw_1.object.rtn011_raitno1[i]
	l_s_rhitno   = dw_1.object.rtn011_raitno[i] 
	st_data = f_get_inv101_rtn(l_s_plant,l_s_rhdvsn,l_s_rhitno1)
	if st_data.errcode <> 0 then
		uo_status.st_message.text = '품목 상세정보 미등록 품번입니다'
		l_s_errcd = '1'
	elseif ( st_data.cls = '30' or st_data.srce = '03' or st_Data.cls = '50') then
		select count(*) into : l_s_count from pbpdm.bom001
			where pcmcd = :g_s_company and plant = :l_s_plant and pdvsn = :l_s_rhdvsn and ppitn = :l_s_rhitno1 and
					pedtm <= :l_s_rhedfm using sqlca;
		if l_s_count < 1 or isnull(l_s_count) then 
			uo_status.st_message.text = 'BOM 미등록 품번입니다'
			l_s_errcd = '1'
		else
			select count(*) into : l_s_count from pbrtn.rtn013
				where rccmcd = '01' and rcplant = :l_s_plant and rcdvsn = :l_s_rhdvsn and rcitno = :l_s_rhitno1 
			using sqlca;
			if l_s_count > 0 then 
				uo_status.st_message.text = 'Routing 세부정보가 이미 등록된 품번입니다'
				l_s_errcd = '1'
			else
				select count(*) into : l_s_count from pbrtn.rtn011
					where racmcd = '01' and raplant = :l_s_plant and radvsn = :l_s_rhdvsn and raitno1 = :l_s_rhitno1 
				using sqlca;
				if l_s_count > 0 then 
					uo_status.st_message.text = '이미 유사품번으로 등록된 품번입니다'
					l_s_errcd = '1'
				end if
			end if
		end if
		
		select cls into :ls_pcls
		from pbinv.inv101
		where comltd = '01' and xplant = :l_s_plant and div = :l_s_rhdvsn and
			itno = :l_s_rhitno
		using sqlca;
		
		if (st_Data.cls = '50' and ls_pcls <> '50') or (st_Data.cls <> '50' and ls_pcls = '50') then
			uo_status.st_message.text = '사내공정외주품은 대표, 유사품번이 같아야 합니다.'
			l_s_errcd = '1'
		end if
	else
		uo_status.st_message.text = '계정과 구입선을 확인하세요'
		l_s_errcd = '1'
	end if
	
	dw_1.object.cp_chk[i] = l_s_errcd
	l_n_check += 1
next

if l_n_check < 1 then
    uo_status.st_message.text = f_message("E020")	
	return 0
end if

wf_rgbset("rtn011_raitno1",1,1,dw_1)
//wf_rgbset("rtn011_raedfm",2,1,dw_1)

l_s_errcd = ''
l_s_column = ''

for i = 1 to l_s_rowcount
	if dw_1.getitemstatus(i,'rtn011_raitno1',primary!) = NewModified! or dw_1.getitemstatus(i,'rtn011_raedfm',primary!) = DataModified! then
	   l_s_errcd = dw_1.getitemstring(i,"cp_chk")
	   if f_spacechk(l_s_errcd) <> -1 then
			if mid(l_s_errcd,1,1) = "1" then
				if f_spacechk(l_s_column) = -1 then
					l_s_column = "rtn011_raitno1"
					exit
				end if
		    end if
		    if mid(l_s_errcd,2,1) = "1" then
				if f_spacechk(l_s_column) = -1 then
					l_s_column = "rtn011_raedfm"
					exit
				end if
		    end if
	   end if
	end if
next

dw_1.setredraw(true)

if len(l_s_column) > 0 then
	dw_1.setrow(i)
	dw_1.setcolumn(l_s_column)
	dw_1.setfocus()
	return 0
end if

SQLCA.AUTOCOMMIT = FALSE

ls_chtime = f_get_systemdate(sqlca)
for i = 1 to l_s_rowcount
	if dw_1.getitemstatus(i,'rtn011_raitno1',primary!) = NewModified! or dw_1.getitemstatus(i,'rtn011_raitno1',primary!) = DataModified! then
		l_s_rhitno   = dw_1.object.rtn011_raitno[i] 
		l_s_rhitno1  = dw_1.object.rtn011_raitno1[i] 
		l_s_rhedfm   = dw_1.object.rtn011_raedfm[i]

		select count(*) into :l_n_sqlcount from pbrtn.rtn011
			where racmcd = '01' and raplant = :l_s_plant and radvsn = :l_s_rhdvsn and raitno = :l_s_rhitno and raitno1 = :l_s_rhitno1 
		using sqlca;
		
		if l_n_sqlcount > 0 then
			if dw_1.object.rtn011_rainchk[i] = 'Y' and dw_1.object.rtn011_radlchk[i] = 'N' then
				ls_message = "결재 진행중이므로 수정할수 없습니다."
				goto Rollback_
			end if
			
			update pbrtn.rtn011
			set raepno = :g_s_empno, raipad = :g_s_ipaddr, 
				rasydt = :g_s_date, raflag = 'R',
				rainemp = :g_s_empno, rainchk = 'N', raintime = '',
				raplemp = '', raplchk = 'N', rapltime = '', 
				radlemp = '', radlchk = 'N', radltime = ''
			where racmcd = :g_s_company and raplant = :l_s_plant and 
				radvsn = :l_s_rhdvsn and raitno = :l_s_rhitno and 
				raitno1 = :l_s_rhitno1
			using sqlca;
			
			if sqlca.sqlnrows < 1 then
				ls_message = "유사품번 수정시에 에러가 발생하였습니다."
				goto Rollback_
			end if
			
		else
			INSERT INTO "PBRTN"."RTN011"( "RACMCD","RAPLANT","RADVSN","RAITNO", "RAITNO1",   
         "RACHTIME", "RAEDFM", "RAEPNO", "RAIPAD", "RASYDT", 
			"RAINEMP", "RAINCHK", "RAINTIME",   
         "RAPLEMP", "RAPLCHK", "RAPLTIME",   
         "RADLEMP", "RADLCHK", "RADLTIME", "RAFLAG" )  
			VALUES ( '01', :l_s_plant, :l_s_rhdvsn, :l_s_rhitno, :l_s_rhitno1,
			:ls_chtime, '', :g_s_empno, :g_s_ipaddr, :g_s_date,
			:g_s_empno, 'N', '',
			'', 'N', '',
			'', 'N', '', 'A' )
			using sqlca;
			
			if sqlca.sqlcode <> 0 then
				ls_message = "유사품번 입력시에 에러가 발생하였습니다."
				goto Rollback_
			end if
		end if
	end if
next

COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE

dw_1.retrieve(l_s_plant,l_s_rhdvsn,l_s_rhitno) 
uo_status.st_message.text = f_message("U010")

wf_set_dw1('I')

i_s_selected = ''

i_b_retrieve	= true
i_b_insert 		= true
i_b_save 		= false
i_b_delete 		= true
wf_icon_onoff( i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	              i_b_dprint,   i_b_dchar )

return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
uo_status.st_message.text = ls_message

return -1
end event

event ue_delete;call super::ue_delete;integer l_n_row,l_n_yesno,l_n_sqlcount
string ls_message, ls_raplant, ls_radvsn, ls_raitno, ls_raitno1, ls_chtime

uo_status.st_message.text = ""
i_s_Selected = ' '
SetPointer(HourGlass!)
 
l_n_row = dw_1.getselectedrow(0)
if l_n_row <> 0 then
	l_n_yesno = messagebox("삭제확인", "선택된 품번(들)을 삭제하시겠습니까 ?",Question!,OkCancel!,2)
	if l_n_yesno <> 1 then
		uo_status.st_message.text = f_message("D030")
		return 
	end if
else
	uo_status.st_message.text = f_message("D100")
	return 
end if

SQLCA.AUTOCOMMIT = FALSE
ls_chtime = f_get_systemdate(sqlca)
do until l_n_row = 0
	ls_raplant = dw_1.object.rtn011_raplant[l_n_row]
	ls_radvsn  = dw_1.object.rtn011_radvsn[l_n_row]
	ls_raitno  = dw_1.object.rtn011_raitno[l_n_row]
	ls_raitno1 = dw_1.object.rtn011_raitno1[l_n_row]
	
	if dw_1.object.rtn011_radlchk[l_n_row] = 'N' and dw_1.object.rtn011_rainchk[l_n_row] = 'Y' then
		ls_message = "결재 진행중이므로 삭제할 수 없습니다."
		goto Rollback_
	end if
	
	select count(*) into :l_n_sqlcount
	from pbrtn.rtn018
	where rhcmcd = :g_s_company and rhplant = :ls_raplant and 
		rhdvsn = :ls_radvsn and rhitno = :ls_raitno and 
		rhitno1 = :ls_raitno1
	using sqlca;
	
	if l_n_sqlcount < 1 then
		delete from pbrtn.rtn011
		where racmcd = :g_s_company and raplant = :ls_raplant and 
			radvsn = :ls_radvsn and raitno = :ls_raitno and 
			raitno1 = :ls_raitno1
		using sqlca;
	else	
		update pbrtn.rtn011
		set rachtime = :ls_chtime, raepno = :g_s_empno, raipad = :g_s_ipaddr, 
			rasydt = :g_s_date, raflag = 'D',
			rainemp = :g_s_empno, rainchk = 'N', raintime = '',
			raplemp = '', raplchk = 'N', rapltime = '', 
			radlemp = '', radlchk = 'N', radltime = ''
		where racmcd = :g_s_company and raplant = :ls_raplant and 
			radvsn = :ls_radvsn and raitno = :ls_raitno and 
			raitno1 = :ls_raitno1
		using sqlca;
		if sqlca.sqlnrows < 1 then
			ls_message = "유사품번 삭제시에 오류가 발생했습니다."
			goto Rollback_
		end if
	end if
	l_n_row = dw_1.getselectedrow(l_n_row)
loop

COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
dw_1.retrieve(ls_raplant,ls_radvsn,ls_raitno) 
uo_status.st_message.text = "정상적으로 삭제처리되었으며, 결재절차를 수행하시기 바랍니다."

i_b_retrieve = true
i_b_insert = true
i_b_save = false
i_b_delete = true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	              i_b_dprint,   i_b_dchar)
return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
uo_status.st_message.text = ls_message

return -1
end event

event ue_insert;call super::ue_insert;Long	l_n_Rows,l_n_root,l_s_count
integer i
string  l_s_parm,l_s_plant,l_s_div,l_s_itno,l_s_chk,l_s_pdcd
s_inv101_info st_data

SetPointer(HourGlass!)

uo_status.st_message.text = ""
i_s_Selected = 'A'

l_s_parm  = uo_1.uf_Return()
l_s_plant = mid(l_s_parm,1,1)
l_s_div   = mid(l_s_parm,2,1)
l_s_pdcd  = mid(l_s_parm,3,2)

l_s_itno = trim(sle_itno.text)

st_data = f_get_inv101_rtn(l_s_plant,l_s_div,l_s_itno)
if st_data.errcode <> 0 then
	uo_status.st_message.text = '품목 상세 정보 미등록품입니다'
	return 0
end if

if ( st_data.cls = '30' or st_data.srce = '03' or st_data.srce = '04' ) then
	select count(*) into : l_s_count from pbrtn.rtn013
		where rccmcd = '01' and rcplant = :l_s_plant and rcdvsn = :l_s_div and rcitno = :l_s_itno 
	using sqlca;
	if l_s_count = 0 or isnull(l_s_count) then 
		uo_status.st_message.text = 'Routing 공정정보가 등록되지 않은 대표품번입니다'
		return -1
	end if
   l_n_rows = dw_1.retrieve(l_s_plant,l_s_div,l_s_itno) 	
	dw_1.insertrow(0)
	for i = 1 to l_n_rows
		dw_1.object.pt_chk[i] = '1 '
	next
	dw_1.object.pt_chk[l_n_rows + 1] = '  '
	wf_protect("rtn011_raitno1",1,dw_1)
//	wf_protect("rtn011_raedfm",2,dw_1)
	dw_1.object.rtn011_raitno[l_n_rows + 1] = l_s_itno
	dw_1.object.rtn011_raedfm[l_n_rows + 1] = f_relativedate(g_s_date,1)
	dw_1.setfocus()
	dw_1.setrow(l_n_rows + 1)
	dw_1.setcolumn("rtn011_raitno1")
else
	uo_status.st_message.text = '공정정보등록을 위한 품번에 대한 계정과 구입선을 확인하세요'
	return 0
end if

uo_status.st_message.text = f_message("A070")   
i_b_retrieve = true
i_b_insert = false
i_b_save = true
i_b_delete = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	              i_b_dprint,   i_b_dchar)

end event

type uo_status from w_origin_sheet01`uo_status within w_rtn011u
end type

type dw_1 from datawindow within w_rtn011u
event keydown pbm_dwnkey
event ue_mousemove pbm_mousemove
integer x = 2542
integer y = 204
integer width = 2057
integer height = 2280
integer taborder = 30
string dragicon = "DataPipeline!"
boolean bringtotop = true
string title = "none"
string dataobject = "d_rtn01_dw_daechae_item_input"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event keydown;window l_s_wsheet

if keydown(KeyEscape!) = true and i_s_selected = 'A' then
	this.deleterow(0)
end if

if key = keyenter! then
  	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_save")
end if
end event

event clicked;this.SelectRow(0, FALSE)
if row <= 0 then
	return
end if

dw_1.setfocus()

If Keydown(KeyShift!) then
	wf_Shift_Highlight(row, this)
ElseIf Keydown(KeyControl!) then
	i_i_LastRow = row
	if this.IsSelected(row) Then

	else
		this.SelectRow(row,TRUE)
	end if	
Else
	i_i_LastRow = row
	this.SelectRow(row, TRUE)
End If


end event

event losefocus;integer l_n_rows, l_n_rows1
string modstring

if i_s_selected <> "A" then
	return
end if

if keydown(keytab!) = false then
	return
end if

l_n_rows = this.rowcount()	
this.insertrow(0)
this.setfocus()
this.setrow(l_n_rows + 1)
this.setcolumn("rtn011_raitno1")
this.object.rtn011_raitno[l_n_rows+1]  = this.object.rtn011_raitno[l_n_rows]
this.object.rtn011_racmcd[l_n_rows+1]  = this.object.rtn011_racmcd[l_n_rows]
this.object.rtn011_raplant[l_n_rows+1] = this.object.rtn011_raplant[l_n_rows]
this.object.rtn011_radvsn[l_n_rows+1]  = this.object.rtn011_radvsn[l_n_rows]
this.object.rtn011_raedfm[l_n_rows+1]  = ''
this.object.pt_chk[l_n_rows + 1] = '1  '
wf_protect("rtn011_raitno",1,dw_1)
wf_protect("rtn011_raitno1",2,dw_1)
end event

event rbuttondown;drag(begin!)
end event

event itemchanged;string ls_plant, ls_dvsn, ls_pitno, ls_cls, ls_cls_child

if dwo.name = 'rtn011_raitno1' then
	ls_plant = this.getitemstring(row,"rtn011_raplant")
	ls_dvsn = this.getitemstring(row,"rtn011_radvsn")
	ls_pitno = this.getitemstring(row,"rtn011_raitno")
	
	select cls into :ls_cls
	from pbinv.inv101
	where comltd = '01' and xplant = :ls_plant and
		div = :ls_dvsn and itno = :ls_pitno
	using sqlca;
	
	select cls into :ls_cls_child
	from pbinv.inv101
	where comltd = '01' and xplant = :ls_plant and
		div = :ls_dvsn and itno = :data
	using sqlca;
	
	if ls_cls = '50' and ls_cls_child <> '50' then
		uo_status.st_message.text = "대표품번이 외주가공품이므로 유사품번도 외주가공품이어야 합니다."
		return 2
	end if
end if

return 0
end event

type st_2 from statictext within w_rtn011u
integer x = 2688
integer y = 80
integer width = 274
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "대표품번"
boolean focusrectangle = false
end type

type sle_itno from singlelineedit within w_rtn011u
event ue_slekeydown pbm_keydown
integer x = 2990
integer y = 68
integer width = 453
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
textcase textcase = upper!
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

event ue_slekeydown;if key = keyenter! then
	parent.triggerevent("ue_retrieve")
end if
end event

type pb_find_item from picturebutton within w_rtn011u
integer x = 3493
integer y = 56
integer width = 238
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string l_s_plant,l_s_div,l_s_pdcd,l_s_parm
uo_status.st_message.text = ""

l_s_parm  = uo_1.uf_Return()
l_s_plant = mid(l_s_parm,1,1)
l_s_div   = mid(l_s_parm,2,1)
l_s_pdcd  = mid(l_s_parm,3,2)

if f_spacechk(l_s_pdcd) = -1 then
	uo_status.st_message.text = "제품군을 선택해 주십시요"
	return 0
end if
l_s_parm = g_s_date + l_s_plant + l_s_div + l_s_pdcd
openwithparm(w_rtn_find_item,l_s_parm)
l_s_parm = message.stringparm
sle_itno.text = l_s_parm

end event

type dw_2 from datawindow within w_rtn011u
integer x = 73
integer y = 204
integer width = 2450
integer height = 2280
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_rtn01_dw_routing_item_treeview_rev3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string l_s_dvsn,l_s_plant,l_s_itno
long    li_rowcnt

setpointer(hourglass!)
uo_status.st_message.text = ''
this.selectrow(0, false)
li_rowcnt = this.rowcount()
dw_1.reset()

if row > 0 and row <= li_rowcnt then
	this.selectrow(row,true)
else
	return 0
end if
l_s_plant = dw_2.object.rtn013_rcplant[row]
l_s_dvsn  = dw_2.object.rtn013_rcdvsn[row]
l_s_itno  = trim(dw_2.object.rtn013_rcitno[row]) 
sle_itno.text = l_s_itno 
wf_set_dw1('P')
if dw_1.retrieve(l_s_plant,l_s_dvsn,l_s_itno ) < 1 then
	uo_status.st_message.text = f_message("I020")
	return
end if
i_s_selected = 'C'
end event

event dragdrop;integer l_n_row, l_n_count
l_n_row = dw_1.getselectedrow(0)
if l_n_row < 1 then
	messagebox("확인","유사품번을 선택 후 작업 가능합니다.")
	return 0
end if
if dw_1.getitemstring(l_n_row,"rtn011_radlchk") = 'N' then
	messagebox("확인","해당건은 결재가 진행중이므로 수정할수 없습니다.")
	return 0
end if
if messagebox("확인","결재없이 현재기준으로 변경됩니다. 대표품번 " + string(dw_1.object.rtn011_raitno[l_n_row]) + " 을 유사품번 " + &
              string(dw_1.object.rtn011_raitno1[l_n_row]) + "으로 바꾸시겠습니까 ?",question!,yesno!,2)  = 2 then
	return 0
end if

string l_s_plant, l_s_div, l_s_itno, l_s_itno1, l_s_edfm, l_s_rhedfm, ls_message, ls_chtime

l_s_plant = dw_1.object.rtn011_raplant[l_n_row]
l_s_div   = dw_1.object.rtn011_radvsn[l_n_row] 
l_s_itno  = dw_1.object.rtn011_raitno[l_n_row]
l_s_itno1 = dw_1.object.rtn011_raitno1[l_n_row]
l_s_rhedfm = dw_1.object.rtn011_raedfm[l_n_row]

//************************************
//* 1. 현재기준으로 대표품번을 해당 유사품번으로 변경
//*    RTN013, RTN014, RTN015, RTN016, RTN017
//* 2. 대표품번을 현재기준의 유사품번으로 변경
//*    RTN011, RTN018
//************************************

SQLCA.AUTOCOMMIT = FALSE
ls_chtime = f_get_systemdate(sqlca)

// 1. 현재기준으로 대표품번을 해당 유사품번으로 변경

update pbrtn.rtn013
set rcitno = :l_s_itno1
where rccmcd = :g_s_company and rcplant = :l_s_plant and rcdvsn = :l_s_div and rcitno = :l_s_itno
using sqlca;
if sqlca.sqlnrows < 1 then
	ls_message = "RTN013 공정정보 수정시에 에러가 발생했습니다. 정보시스템으로 연락바랍니다."
	goto Rollback_
end if

select count(*) into :l_n_count
from pbrtn.rtn014 
where  rdcmcd  = :g_s_company  and rdplant = :l_s_plant and rddvsn = :l_s_div and rditno = :l_s_itno
using sqlca ;

if l_n_count > 0 then
	update pbrtn.rtn014 
	set rditno = :l_s_itno1
	where  rdcmcd  = :g_s_company  and rdplant = :l_s_plant and rddvsn = :l_s_div and rditno = :l_s_itno
	using sqlca ;
	
	if sqlca.sqlnrows < 1 then
		ls_message = "RTN014 부대작업 수정시에 에러가 발생했습니다. 정보시스템으로 연락바랍니다."
		goto Rollback_
	end if
end if

select count(*) into :l_n_count
from pbrtn.rtn017 
where  rgcmcd  = :g_s_company  and rgplant = :l_s_plant and rgdvsn = :l_s_div and rgitno = :l_s_itno
using sqlca ;
if l_n_count = 0 then 
	update pbrtn.rtn017 
	set rgitno = :l_s_itno1
	where  rgcmcd  = :g_s_company  and rgplant = :l_s_plant and rgdvsn = :l_s_div and rgitno = :l_s_itno
	using sqlca ;
	if sqlca.sqlcode <> 0 then
		ls_message = "RTN017 유사품번의 공정정보 생성 입력 에러. 정보시스템으로 연락바랍니다."
		goto Rollback_
	end if
end if

update pbrtn.rtn015
set reitno = :l_s_itno1
where recmcd = :g_s_company and replant = :l_s_plant and redvsn = :l_s_div and reitno = :l_s_itno and
	reedto = '99991231'
using sqlca;
if sqlca.sqlnrows < 1 then
	ls_message = "RTN015 공정정보 수정시에 에러가 발생했습니다. 정보시스템으로 연락바랍니다."
	goto Rollback_
end if

// 2. 대표품번을 현재기준의 유사품번으로 변경
update pbrtn.rtn011
set raitno = :l_s_itno1 , raitno1 = :l_s_itno
where racmcd = :g_s_company and raplant = :l_s_plant and 
	radvsn = :l_s_div and raitno = :l_s_itno and 
	raitno1 = :l_s_itno1
using sqlca;

if sqlca.sqlnrows < 1 then
	ls_message = "RTN011 유사품번을 대체품번으로 변경시에 오류가 발생했습니다."
	goto Rollback_
end if

select count(*) into :l_n_count
from pbrtn.rtn011
where racmcd = :g_s_company and raplant = :l_s_plant and 
	radvsn = :l_s_div and raitno = :l_s_itno 
using sqlca;

if l_n_count > 0 then
	update pbrtn.rtn011
	set raitno = :l_s_itno1
	where racmcd = :g_s_company and raplant = :l_s_plant and 
		radvsn = :l_s_div and raitno = :l_s_itno 
	using sqlca;
	
	if sqlca.sqlnrows < 1 then
		ls_message = "RTN011 유사품번을 대체품번으로 일괄변경시에 오류가 발행했습니다."
		goto Rollback_
	end if
end if

update pbrtn.rtn018
set rhitno = :l_s_itno1 , rhitno1 = :l_s_itno
where rhcmcd = :g_s_company and rhplant = :l_s_plant and 
	rhdvsn = :l_s_div and rhitno = :l_s_itno and 
	rhitno1 = :l_s_itno1 and rhedto = '99991231'
using sqlca;

if sqlca.sqlnrows < 1 then
	ls_message = "RTN018 유사품번을 대체품번으로 변경시에 오류가 발생했습니다."
	goto Rollback_
end if

select count(*) into :l_n_count
from pbrtn.rtn018
where rhcmcd = :g_s_company and rhplant = :l_s_plant and 
	rhdvsn = :l_s_div and rhitno = :l_s_itno and rhedto = '99991231'
using sqlca;

if l_n_count > 0 then
	update pbrtn.rtn018
	set rhitno = :l_s_itno1
	where rhcmcd = :g_s_company and rhplant = :l_s_plant and 
		rhdvsn = :l_s_div and rhitno = :l_s_itno and rhedto = '99991231'
	using sqlca;
	
	if sqlca.sqlnrows < 1 then
		ls_message = "RTN011 유사품번을 대체품번으로 일괄변경시에 오류가 발행했습니다."
		goto Rollback_
	end if
end if

COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
uo_status.st_message.text = "정상적으로 처리되었습니다."

return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
uo_status.st_message.text = ls_message

return -1



		
end event

type uo_1 from uo_plandiv_pdcd_rtn within w_rtn011u
integer x = 142
integer y = 48
integer width = 2459
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd_rtn::destroy
end on

type gb_2 from groupbox within w_rtn011u
integer x = 64
integer width = 4530
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

