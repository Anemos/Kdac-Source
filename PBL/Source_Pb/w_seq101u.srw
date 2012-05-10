$PBExportHeader$w_seq101u.srw
$PBExportComments$코드마스터 등록
forward
global type w_seq101u from w_origin_sheet09
end type
type dw_codegubun from datawindow within w_seq101u
end type
type dw_codeid from datawindow within w_seq101u
end type
type gb_1 from groupbox within w_seq101u
end type
type gb_2 from groupbox within w_seq101u
end type
end forward

global type w_seq101u from w_origin_sheet09
integer height = 2720
string title = "코드마스터등록"
dw_codegubun dw_codegubun
dw_codeid dw_codeid
gb_1 gb_1
gb_2 gb_2
end type
global w_seq101u w_seq101u

type variables
string is_selected  
end variables

forward prototypes
public subroutine wf_protect (string ag_s_column, integer ag_n_number, datawindow ag_dw_1)
end prototypes

public subroutine wf_protect (string ag_s_column, integer ag_n_number, datawindow ag_dw_1);//if upper(gubun) = 'INSERT' then
//	dw_codeid.object.codeid.background.color 		= 15780518  // Blue
//	dw_codeid.object.codeid.protect		 			= false
//else
//	dw_codeid.object.codeid.background.color 		= 2415968448  // Light Gray
//	dw_codeid.object.codeid.protect		 			= true
//end if
//
//
string l_s_command
//--	Argument	=> ag_s_column = column 명, 
//---             ag_n_number = column 순서,
ag_dw_1.setredraw(False)
l_s_command	=	ag_s_column + ".Protect = '1" &            
					+	"~tIf(mid(pt_chk," + string(ag_n_number) + ", 1) = " + "~~'1~~'," &
					+  " 1, 0 )'"
					
ag_dw_1.Modify(l_s_command)
ag_dw_1.setredraw(True)
 
end subroutine

on w_seq101u.create
int iCurrent
call super::create
this.dw_codegubun=create dw_codegubun
this.dw_codeid=create dw_codeid
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_codegubun
this.Control[iCurrent+2]=this.dw_codeid
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.gb_2
end on

on w_seq101u.destroy
call super::destroy
destroy(this.dw_codegubun)
destroy(this.dw_codeid)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;long ln_position
string ls_ipaddr,ls_database,ls_logpass,ls_computer
disconnect using sqlpis ;
ln_position = lastpos(g_s_ipaddr,'.')
ls_ipaddr   = mid(g_s_ipaddr,1,ln_position - 1)
ls_ipaddr   = ProfileString(gs_inifile,"IPADDR",ls_ipaddr," ")

if ls_ipaddr <> 'KUN' and ls_ipaddr <> 'BUP' then
	close(this)
end if
RegistryGet("HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\VxD\VNETSUP", "ComputerName", ls_computer)
ls_database    	= trim(ProfileString(gs_inifile,ls_ipaddr,"DataBase",			" "))
ls_logpass     	= trim(ProfileString(gs_inifile,ls_ipaddr,"LogPass",		" "))
gs_servername	 	= ProfileString(gs_inifile,ls_ipaddr,"ServerName",	" ")
SQLPIS.ServerName = gs_servername
SQLPIS.DBMS       = ProfileString(gs_inifile,ls_ipaddr,"DBMS",			" ")
SQLPIS.Database   = ls_database
SQLPIS.LogID      = ProfileString(gs_inifile,ls_ipaddr,"LogId",			" ")
SQLPIS.LogPass    = ls_logpass
SQLPIS.DbParm     = "appname='IPIS for KDAC', host='" + ls_computer + "'"
SQLPIS.AutoCommit = True
gs_appname	    	= ProfileString(gs_inifile,"PARAMETER","AppName",            " ")
connect using sqlpis ;
dw_codegubun.settransobject(sqlpis)
dw_codeid.settransobject(sqlpis)
wf_icon_onoff(true,true,true,true,false,false,false,false,false)
dw_codegubun.retrieve()
end event
event ue_insert;call super::ue_insert;int ln_row
string ls_codegubun
is_selected = 'A'
ln_row = dw_codegubun.getselectedrow(0)
if ln_row < 1 then
	messagebox("확인","코드분류를 선택하신 후 입력이 가능합니다")
	return
end if
ls_codegubun = dw_codegubun.object.codeid[ln_row]
if trim(ls_codegubun) = '' then
	ls_codegubun = 'SEQCODE'
end if
ln_row = dw_codeid.insertrow(0)
dw_codeid.object.codegubun[ln_row] = ls_codegubun
dw_codeid.object.pt_chk[ln_row] = ' '
wf_protect("codeid",1,dw_codeid)
dw_codeid.setfocus()
dw_codeid.setrow(ln_row)
dw_codeid.setcolumn("codeid")



end event

event ue_retrieve;call super::ue_retrieve;is_selected = 'R'
//wf_protect("")
dw_codegubun.retrieve()

end event

event ue_save;call super::ue_save;long ln_rowcount,i,ln_count,ln_savecount
dwItemStatus ls_status
datetime ld_nowtime
string ls_codeid,ls_codename,ls_codegubun
 
ld_nowtime = f_pisc_get_date_nowtime()
ln_rowcount = dw_codeid.rowcount()
if ln_rowcount < 1 then
	messagebox("확인","저장할 정보가 없습니다")
	return 1
end if
dw_codeid.accepttext()
for i = 1 to ln_rowcount
	ls_codeid		= trim(dw_codeid.object.codeid[i])
	ls_codename		= trim(dw_codeid.object.codename[i])	
	if f_spacechk(ls_codeid) = -1 and f_spacechk(ls_codename) = -1 then
		dw_codeid.deleterow(i)
		i = i - 1
		ln_rowcount = ln_rowcount - 1
		continue
	end if
next
if f_mandatory_chk(dw_codeid) = -1 then
	return 1
end if
sqlpis.autocommit = false
for i = 1 to ln_rowcount
	ls_status =  dw_codeid.GetItemStatus(i, 0,Primary!)
	if ls_status = datamodified! or ls_status = newmodified! then
		ls_codeid		= trim(dw_codeid.object.codeid[i])
		ls_codename		= trim(dw_codeid.object.codename[i])	
 		ls_codegubun 	= trim(dw_codeid.object.codegubun[i])
 		if ls_status = newmodified! then
			select count(*) into :ln_count from tseqmstcode
				where codegubun = :ls_codegubun and codeid = :ls_codeid
			using sqlpis ;
			if ln_count > 0 then
				messagebox("확인",ls_codeid + " 은 이미 등록된 코드입니다")
				dw_codeid.deleterow(i)
				sqlpis.autocommit = true
				return 1
			end if
		end if
		dw_codeid.setitem(i,"lastemp",'ADMIN')	
		dw_codeid.setitem(i,"lastdate",ld_nowtime)	
		ln_savecount 	= 1
	else
		continue
	end if
next
if ln_savecount = 1 then
	if dw_codeid.update() <> 1 then
		messagebox("확인2","시스템개발팀에 문의바랍니다")
		rollback using sqlpis;
	else
		commit using sqlpis;
		messagebox("확인","저장성공")
	end if
end if
sqlpis.autocommit = true
this.triggerevent("ue_retrieve")





end event

event ue_delete;call super::ue_delete;long ln_row,ln_count=0,ln_yesno
string ls_codegubun,ls_codeid

is_Selected = 'D'
ln_row = dw_codeid.getselectedrow(0)

if ln_row < 1 then
	messagebox("확인","삭제하고자 하는 코드 ID 를 선택한 후 작업바랍니다")
	return
end if
ls_codegubun 	= 	trim(dw_codeid.object.codegubun[ln_row])
ls_codeid		=	trim(dw_codeid.object.codeid[ln_row])
if ls_codegubun = "SEQLINE" then
	select count(*) into :ln_count from tseqmstitem
		where linecode = :ls_codeid 
	using sqlpis ;
//elseif ls_codegubun = "SEQRACK" then
//	select count(*) into :ln_count from tseqmstitem
//		where rackgroup = :ls_codeid 
//	using sqlpis ;
elseif ls_codegubun = "SEQCAR" then
	select count(*) into :ln_count from tseqmstitem
		where cartype = :ls_codeid 
	using sqlpis ;		
end if
if ln_count > 0 then
	messagebox("확인","서열품목마스터 정보에서 " + ls_codeid + " 를 현재 사용중입니다")
   return
end if
ln_count = 0
if ls_codegubun = "SEQITEM" then
	select count(*) into :ln_count from tseqmstprod
		where seqgubun = :ls_codeid 
	using sqlpis ;
end if
if ln_count > 0 then
	messagebox("확인","제품군 마스터 정보에서 " + ls_codeid + " 를 현재 사용중입니다")
   return
end if
ln_count = 0
if ls_codegubun = "SEQCODE" then
	select count(*) into :ln_count from tseqmstcode
		where codegubun = :ls_codeid 
	using sqlpis ;
end if
if ln_count > 0 then
	messagebox("확인","코드 마스터 정보에서 " + ls_codeid + " 를 현재 사용중입니다")
   return
end if
ln_count = 0
if ls_codegubun = "SEQSHIFT" then
	select count(*) into :ln_count from tseqdayplan
		where shiftcode = :ls_codeid 
	using sqlpis ;
end if
if ln_count > 0 then
	messagebox("확인","일일생산계획 정보에서 " + ls_codeid + " 를 현재 사용중입니다")
   return
end if
ln_count = 0
if ls_codegubun = "SEQWORK" then
	select count(*) into :ln_count from tseqworkcalendar
		where workgubun = :ls_codeid 
	using sqlpis ;
end if
if ln_count > 0 then
	messagebox("확인","Work Calendar 정보에서 " + ls_codeid + " 를 현재 사용중입니다")
   return
end if

ln_yesno = messagebox("삭제확인", "선택된 코드를 삭제하시겠습니까 ?",Question!,OkCancel!,2)
if ln_yesno <> 1 then
	uo_status.st_message.text = f_message("D030")
	return 0
end if

delete from tseqmstcode
where codegubun = :ls_codegubun and codeid = :ls_codeid
using sqlpis ;
if sqlpis.sqlnrows < 1 then
	uo_status.st_message.text = "삭제 실패.시스템 개발팀으로 연락바랍니다"
	return
else
	uo_status.st_message.text = "삭제 성공"
end if
dw_codeid.reset()
this.triggerevent("ue_retrieve")





end event

event activate;call super::activate;dw_codegubun.settransobject(sqlpis)
dw_codeid.settransobject(sqlpis)
end event

type uo_status from w_origin_sheet09`uo_status within w_seq101u
end type

type dw_codegubun from datawindow within w_seq101u
integer x = 69
integer y = 140
integer width = 1838
integer height = 2308
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_tseqmstcode_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlpis)
end event

event clicked;setpointer(hourglass!)
uo_status.st_message.text = ''

string 	ls_codegubun
int 		li_rowcnt

this.selectrow(0, false)
li_rowcnt = this.rowcount()
dw_codeid.reset()

if row > 0 and row <= li_rowcnt then
	this.selectrow(row,true)
else
	return 0
end if

ls_codegubun = this.object.codeid[row]
if trim(ls_codegubun) = '' then
	ls_codegubun = "SEQCODE" 
end if
dw_codeid.object.codeid.protect = true
// dw_codeid.object.codeid.background.color = rgb(192,192,192)
if dw_codeid.retrieve(ls_codegubun + '%') < 1 then
	uo_status.st_message.text = '조회할 정보가 없습니다'
else
	uo_status.st_message.text = '조회 완료'
	dw_codeid.setfocus()
	dw_codeid.setrow(1)
	dw_codeid.setcolumn("codename")
end if

end event

type dw_codeid from datawindow within w_seq101u
integer x = 2002
integer y = 140
integer width = 2482
integer height = 2308
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_tseqmstcode_02"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlpis)
end event

event clicked;if row <= 0 then
	return
end if
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

end event

event losefocus;if is_selected <> "A" then
	return
end if

if keydown(keytab!) = false then
	return
end if
this.insertrow(0)
end event

type gb_1 from groupbox within w_seq101u
integer x = 37
integer y = 44
integer width = 1906
integer height = 2436
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "코드분류"
end type

type gb_2 from groupbox within w_seq101u
integer x = 1970
integer y = 44
integer width = 2551
integer height = 2432
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "코드내용"
end type

