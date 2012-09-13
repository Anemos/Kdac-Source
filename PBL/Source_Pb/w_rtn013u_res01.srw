$PBExportHeader$w_rtn013u_res01.srw
$PBExportComments$공정별 부대작업 등록[결재]
forward
global type w_rtn013u_res01 from window
end type
type st_message from statictext within w_rtn013u_res01
end type
type cb_4 from commandbutton within w_rtn013u_res01
end type
type cb_3 from commandbutton within w_rtn013u_res01
end type
type dw_2 from datawindow within w_rtn013u_res01
end type
type st_3 from statictext within w_rtn013u_res01
end type
type st_2 from statictext within w_rtn013u_res01
end type
type st_1 from statictext within w_rtn013u_res01
end type
type cb_2 from commandbutton within w_rtn013u_res01
end type
type cb_1 from commandbutton within w_rtn013u_res01
end type
type dw_1 from datawindow within w_rtn013u_res01
end type
type sle_4 from singlelineedit within w_rtn013u_res01
end type
type sle_3 from singlelineedit within w_rtn013u_res01
end type
type sle_2 from singlelineedit within w_rtn013u_res01
end type
end forward

global type w_rtn013u_res01 from window
integer x = 901
integer y = 500
integer width = 2679
integer height = 1800
boolean titlebar = true
string title = "유형별 부대작업"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
st_message st_message
cb_4 cb_4
cb_3 cb_3
dw_2 dw_2
st_3 st_3
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
sle_4 sle_4
sle_3 sle_3
sle_2 sle_2
end type
global w_rtn013u_res01 w_rtn013u_res01

type variables
datawindowchild i_dwc_1,i_dwc_2,i_dwc_3
int i_n_rowcount
string i_s_plant,i_s_dvsn,i_s_itno,i_s_line1,i_s_line2,i_s_opno,i_s_selected
end variables

forward prototypes
public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1)
public subroutine wf_rtn006_update (string a_nvmo, string a_mcno, string a_term)
public subroutine wf_rgbclear (string a_para)
end prototypes

public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1);
end subroutine

public subroutine wf_rtn006_update (string a_nvmo, string a_mcno, string a_term);string l_s_rfedfm,l_s_rfedfm1,l_s_rfedfm2,l_s_rfremk,l_s_rfedto
dec    l_n_rfmctm,l_n_rflbtm
int    l_n_sqlcount

l_s_rfedto = f_relativedate(dw_2.object.rdedfm[1],-1)

select rdedfm,rdremk,rdmctm,rdlbtm into :l_s_rfedfm,:l_s_rfremk,:l_n_rfmctm,:l_n_rflbtm from pbrtn.rtn004
	  where rdplant = :i_s_plant and rddvsn = :i_s_dvsn and rditno = :i_s_itno and rdline1 = :i_s_line1 and rdline2 = :i_s_line2 and 
		    rdopno  = :i_s_opno  and rdnvmo = :a_nvmo and rdmcno = :a_mcno and rdterm = :a_term 
using sqlca;

select count(*) into:l_n_sqlcount from pbrtn.rtn006
	where rfcmcd = :g_s_company and rfplant = :i_s_plant and rfdvsn = :i_s_dvsn and rfitno = :i_s_itno and rfline1 = :i_s_line1 and rfline2 = :i_s_line2 and 
		  rfopno = :i_s_opno and rfnvmo = :a_nvmo and rfmcno = :a_mcno and rfterm = :a_term 
			and rfedfm = :l_s_rfedfm
using sqlca;

if l_n_sqlcount > 0 then	
	update pbrtn.rtn006 
		 set rfmctm = :l_n_rfmctm,rflbtm = :l_n_rflbtm,rfremk = :l_s_rfremk,rfedto = :l_s_rfedto,
		 	 rfflag = 'C',rfupdt = :g_s_date
	where rfcmcd  = :g_s_company  and rfplant = :i_s_plant and rfdvsn = :i_s_dvsn and rfitno = :i_s_itno and rfline1 = :i_s_line1 and
		   rfline2 = :i_s_line2   and rfopno = :i_s_opno  and rfnvmo = :a_nvmo   and rfmcno  = :a_mcno    and
		   rfterm  = :a_term and rfedfm = :l_s_rfedfm
	using sqlca;
else
	if l_s_rfedfm <= l_s_rfedto then
		insert into pbrtn.rtn006
		(rfcmcd,rfplant,rfdvsn,rfitno,rfline1,rfline2,rfopno,rfnvmo,rfmcno,rfterm,rfedfm,rfmctm,rflbtm,rfremk,rfepno,
		 rfflag,rfedto,rfipad,rfupdt,rfsydt )
		values
		(:g_s_company,:i_s_plant,:i_s_dvsn, :i_s_itno, :i_s_line1,:i_s_line2,:i_s_opno,:a_nvmo,:a_mcno,:a_term,:l_s_rfedfm,
		 :l_n_rfmctm,:l_n_rflbtm, :l_s_rfremk,: g_s_empno,'A',:l_s_rfedto,:g_s_ipaddr,:g_s_date,:g_s_date )
		using sqlca;
		
		l_s_rfedfm = f_relativedate(l_s_rfedfm,-1)
		
		select rfedfm into:l_s_rfedfm2 from pbrtn.rtn006
			where rfcmcd = :g_s_company and rfplant = :i_s_plant and rfdvsn = :i_s_dvsn and rfitno = :i_s_itno and rfline1 = :i_s_line1 and rfline2 = :i_s_line2 and 
				  rfopno = :i_s_opno and rfnvmo = :a_nvmo and rfmcno = :a_mcno and rfterm = :a_term and 
				  rfedfm < :l_s_rfedfm and rfedto > :l_s_rfedfm 
		using sqlca;
		
		if f_spacechk(l_s_rfedfm2) <> -1 then
			update pbrtn.rtn006 
				set rfedto = :l_s_rfedfm,rfupdt = :g_s_date
			where rfcmcd  = :g_s_company and rfplant = :i_s_plant and rfdvsn = :i_s_dvsn and rfitno = :i_s_itno and rfline1 = :i_s_line1 and
				  rfline2 = :i_s_line2   and rfopno = :i_s_opno and rfnvmo = :a_nvmo   and rfmcno  = :a_mcno    and
				  rfterm  = :a_term and rfedfm = :l_s_rfedfm2
			using sqlca;
		end if
	else
		select rfedfm into:l_s_rfedfm2 from pbrtn.rtn006
			where rfcmcd = :g_s_company and rfplant = :i_s_plant and rfdvsn = :i_s_dvsn and rfitno = :i_s_itno and rfline1 = :i_s_line1 and rfline2 = :i_s_line2 and 
				  rfopno = :i_s_opno and rfnvmo = :a_nvmo and rfmcno = :a_mcno and rfterm = :a_term and 
				  rfedfm < :l_s_rfedto and rfedto > :l_s_rfedto 
		using sqlca;
		
		if f_spacechk(l_s_rfedfm2) <> -1 then
			update pbrtn.rtn006 
				set rfedto = :l_s_rfedto,rfupdt = :g_s_date
			where rfcmcd  = :g_s_company and rfplant = :i_s_plant and rfdvsn = :i_s_dvsn and rfitno = :i_s_itno and rfline1 = :i_s_line1 and
				  rfline2 = :i_s_line2   and rfopno = :i_s_opno and rfnvmo = :a_nvmo   and rfmcno  = :a_mcno    and
				  rfterm  = :a_term and rfedfm = :l_s_rfedfm2
			using sqlca;
		end if
	end if
end if
end subroutine

public subroutine wf_rgbclear (string a_para);
dw_2.getchild("rdnvmo",i_dwc_1)
i_dwc_1.settransobject(sqlca)
i_dwc_1.retrieve('RTN010')

dw_2.getchild("rdmcno",i_dwc_1)
i_dwc_1.settransobject(sqlca)
i_dwc_1.retrieve('RTN020')

dw_2.getchild('rdterm',i_dwc_1)
i_dwc_1.settransobject(sqlca) 
i_dwc_1.retrieve('RTN030')

//if trim(dw_2.object.rdmcno[1]) = '0' then
//	dw_2.getchild('rdterm',i_dwc_2)
//	i_dwc_2.settransobject(sqlca)
//	i_dwc_2.retrieve('RTN030')
//else
//	dw_2.getchild('rdterm',i_dwc_3)
//	i_dwc_3.settransobject(sqlca)
//	i_dwc_3.retrieve('RTN040')
//end if


if a_para = 'P' then
	dw_2.object.rdnvmo.background.color   = rgb(192,192,192)
	dw_2.object.rdmcno.background.color   = rgb(192,192,192)
	dw_2.object.rdterm.background.color   = rgb(192,192,192)
	dw_2.object.rdedfm.background.color   = rgb(192,192,192)
	dw_2.object.rdmctm.background.color   = rgb(192,192,192)
	dw_2.object.rdlbtm.background.color   = rgb(192,192,192)
	dw_2.object.rdremk.background.color   = rgb(192,192,192)
	
	dw_2.object.rdnvmo.protect = true
	dw_2.object.rdmcno.protect = true
	dw_2.object.rdterm.protect = true
	dw_2.object.rdedfm.protect = true
	dw_2.object.rdmctm.protect = true
	dw_2.object.rdlbtm.protect = true
	dw_2.object.rdremk.protect = true
	
elseif a_para = 'A' then
	dw_2.object.rdnvmo[1] = '01'
	dw_2.object.rdmcno[1] = '0'
	dw_2.object.rdterm[1] = '0'
	dw_2.object.rdnvmo.background.color   = rgb(255,250,239)
	dw_2.object.rdmcno.background.color   = rgb(255,250,239)
	dw_2.object.rdterm.background.color   = rgb(255,250,239)
	dw_2.object.rdedfm.background.color   = rgb(255,250,239)
	dw_2.object.rdmctm.background.color   = rgb(255,250,239)
	dw_2.object.rdlbtm.background.color   = rgb(255,250,239)
	dw_2.object.rdremk.background.color   = rgb(255,255,255)
	
	dw_2.object.rdnvmo.protect = false
	dw_2.object.rdmcno.protect = false
	dw_2.object.rdterm.protect = false
	dw_2.object.rdedfm.protect = false
	dw_2.object.rdmctm.protect = false
	dw_2.object.rdlbtm.protect = false
	dw_2.object.rdremk.protect = false
elseif a_para = 'C' then
	dw_2.object.rdnvmo.background.color   = rgb(192,192,192)
	dw_2.object.rdmcno.background.color   = rgb(192,192,192)
	dw_2.object.rdterm.background.color   = rgb(192,192,192)
	dw_2.object.rdedfm.background.color   = rgb(255,250,239)
	dw_2.object.rdmctm.background.color   = rgb(255,250,239)
	dw_2.object.rdlbtm.background.color   = rgb(255,250,239)
	dw_2.object.rdremk.background.color   = rgb(255,255,255)
	
	dw_2.object.rdnvmo.protect = true
	dw_2.object.rdmcno.protect = true
	dw_2.object.rdterm.protect = true
	dw_2.object.rdedfm.protect = false
	dw_2.object.rdmctm.protect = false
	dw_2.object.rdlbtm.protect = false
	dw_2.object.rdremk.protect = false
end if
	

end subroutine

on w_rtn013u_res01.create
this.st_message=create st_message
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_2=create dw_2
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.sle_4=create sle_4
this.sle_3=create sle_3
this.sle_2=create sle_2
this.Control[]={this.st_message,&
this.cb_4,&
this.cb_3,&
this.dw_2,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.sle_4,&
this.sle_3,&
this.sle_2}
end on

on w_rtn013u_res01.destroy
destroy(this.st_message)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_2)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.sle_4)
destroy(this.sle_3)
destroy(this.sle_2)
end on

event open;str_parms lstr_parm

lstr_parm = message.PowerObjectParm	

i_s_plant = lstr_parm.string_arg[1]
i_s_dvsn  = lstr_parm.string_arg[2]
i_s_itno  = lstr_parm.string_arg[3]
i_s_line1 = lstr_parm.string_arg[4]
i_s_line2 = lstr_parm.string_arg[5]
i_s_opno  = lstr_parm.string_arg[6]

sle_2.text = i_s_itno
sle_3.text = trim(i_s_line1) + '-' + i_s_line2
sle_4.text = i_s_opno
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
i_n_rowcount = dw_1.retrieve(g_s_company,i_s_plant,i_s_dvsn,i_s_itno,i_s_line1,i_s_line2,i_s_opno)
wf_rgbclear('P')
//dw_2.insertrow(0)
//dw_2.setfocus()
//
//i_s_selected = 'A'
//w_rtn013u_res01.dw_1.sharedataoff()



end event

event close;this.hide() 
end event

type st_message from statictext within w_rtn013u_res01
integer x = 14
integer y = 1580
integer width = 1467
integer height = 136
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_rtn013u_res01
integer x = 1783
integer y = 1596
integer width = 251
integer height = 104
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭제"
end type

event clicked;string l_s_nvmo,l_s_mcno,l_s_term,l_s_rdedfm,l_s_rdremk, ls_message, ls_chtime, ls_rcnvcd
int    l_n_row, l_n_chkcount
dec    l_d_rdmctm,l_d_rdlbtm
long   ll_logid

l_n_row     = dw_1.getselectedrow(0)
if l_n_row < 1 then
	st_message.text = "삭제할 부대정보를 선택해 주십시요"
	return 0
end if

ll_logid		= dw_1.getitemnumber(l_n_row,"rdlogid")

l_s_nvmo    = dw_1.object.rdnvmo[l_n_row]
l_s_mcno    = dw_1.object.rdmcno[l_n_row]
l_s_term    = dw_1.object.rdterm[l_n_row]
l_s_rdedfm  = dw_1.object.rdedfm[l_n_row]
l_d_rdmctm  = dw_1.object.rdmctm[l_n_row]
l_d_rdlbtm  = dw_1.object.rdlbtm[l_n_row]
l_s_rdremk  = dw_1.object.rdremk[l_n_row]
dw_1.object.upd_chk[l_n_row] = 'D'
dw_1.setredraw(true)
dw_2.reset()

ls_chtime = f_get_systemdate(sqlca)
SQLCA.AUTOCOMMIT = FALSE

//부대정보 이력관리 프로세스
//SELECT COUNT(*) INTO :l_n_chkcount FROM PBRTN.RTN016
//WHERE RFCMCD = :g_s_company AND RFPLANT = :i_s_plant AND RFDVSN = :i_s_dvsn AND
//		RFITNO = :i_s_itno AND RFLINE1 = :i_s_line1 AND RFLINE2 = :i_s_line2 AND
//		RFOPNO = :i_s_opno AND RFNVMO = :l_s_nvmo AND RFMCNO = :l_s_mcno AND 
//		RFTERM = :l_s_term AND RFEDFM = :l_s_rdedfm
//using sqlca;
//
//if l_n_chkcount > 0 then
//	UPDATE PBRTN.RTN016
//	SET RFREMK = :l_s_rdremk,   
//		RFFLAG = 'D', 
//		RFEDTO=  :g_s_date,
//		RFEPNO = :g_s_empno,      
//		RFIPAD = :g_s_ipaddr,   
//		RFUPDT = :g_s_date,   
//		RFSYDT = :g_s_date
//	WHERE RFCMCD = :g_s_company AND RFPLANT = :i_s_plant AND RFDVSN = :i_s_dvsn AND
//			RFITNO = :i_s_itno AND RFLINE1 = :i_s_line1 AND RFLINE2 = :i_s_line2 AND
//			RFOPNO = :i_s_opno AND RFNVMO = :l_s_nvmo AND RFMCNO = :l_s_mcno AND 
//			RFTERM = :l_s_term AND RFEDFM = :l_s_rdedfm
//	using sqlca;
//	
//	if sqlca.sqlnrows < 1 then
//		ls_message = "부대작업 이력생성시에 오류가 발생하였습니다."
//		goto Rollback_
//	end if
//end if
//
update pbrtn.rtn014
set rdflag = 'D', rdepno = :g_s_empno, rdipad = :g_s_ipaddr, rdupdt = :g_s_date
where rdlogid = :ll_logid
using sqlca;
if sqlca.sqlcode <> 0 then
	st_message.text = "부대작업 삭제시에 오류가 발생하였습니다."
	goto Rollback_
end if

select sum(rdmctm), sum(rdlbtm), count(*) into :l_d_rdmctm, :l_d_rdlbtm, :l_n_chkcount
from pbrtn.rtn014
WHERE rdcmcd = :g_s_company AND rdplant = :i_s_plant AND rddvsn = :i_s_dvsn AND
		rditno = :i_s_itno AND rdline1 = :i_s_line1 AND rdline2 = :i_s_line2 AND
		rdopno = :i_s_opno and rdflag <> 'D'
using sqlca;

if l_n_chkcount = 0 then
	ls_rcnvcd = 'N'
	l_d_rdmctm = 0
	l_d_rdlbtm = 0
else
	ls_rcnvcd = 'Y'
end if

update pbrtn.rtn013
set rcnvcd = :ls_rcnvcd, rcnvmc = :l_d_rdmctm, rcnvlb  = :l_d_rdlbtm,
	 rcepno = :g_s_empno , rcipad = :g_s_ipaddr, rcupdt = :g_s_date, rcflag = 'R',
	 rcchtime = :ls_chtime, rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
	 rcplemp = '', rcplchk = 'N', rcpltime = '',
	 rcdlemp = '', rcdlchk = 'N', rcdltime = ''
where rccmcd = :g_s_company and rcplant = :i_s_plant and rcdvsn = :i_s_dvsn and 
		rcitno = :i_s_itno and rcline1 = :i_s_line1 and rcline2 = :i_s_line2 and 
		rcopno = :i_s_opno 
using sqlca;

if sqlca.sqlnrows < 1 then
	st_message.text = "부대작업에 해당하는 공정정보가 없습니다. " + sqlca.sqlerrtext
	goto Rollback_
end if

i_s_selected = ''
COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
st_message.text = "삭제완료! 결재절차를 수행하시기 바랍니다."
dw_1.retrieve(g_s_company,i_s_plant,i_s_dvsn,i_s_itno,i_s_line1,i_s_line2,i_s_opno)
return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE

return -1

end event

type cb_3 from commandbutton within w_rtn013u_res01
integer x = 1499
integer y = 1596
integer width = 251
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입력"
end type

event clicked;wf_rgbclear('A')
dw_2.reset()
dw_2.insertrow(0)
dw_2.setfocus()
i_s_selected = 'A'

st_message.text = "부대작업을 입력하십시요"
end event

type dw_2 from datawindow within w_rtn013u_res01
integer x = 14
integer y = 1116
integer width = 2624
integer height = 452
integer taborder = 30
string dataobject = "d_rtn01_dw_budaejakup_ff"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;integer i , l_n_rowcount
string l_s_coitname

if dwo.name = 'rdmcno' then
	if trim(this.object.rdmcno[1]) = '0' then
		this.getchild('rdterm',i_dwc_2)
		i_dwc_2.settransobject(sqlca)
		i_dwc_2.retrieve('RTN040')
	else
		this.getchild('rdterm',i_dwc_3)
		i_dwc_3.settransobject(sqlca)
		i_dwc_3.retrieve('RTN030')
	end if
end if

end event

type st_3 from statictext within w_rtn013u_res01
integer x = 1851
integer y = 40
integer width = 297
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "공정번호"
boolean focusrectangle = false
end type

type st_2 from statictext within w_rtn013u_res01
integer x = 1001
integer y = 40
integer width = 306
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "대체Line"
boolean focusrectangle = false
end type

type st_1 from statictext within w_rtn013u_res01
integer x = 27
integer y = 40
integer width = 238
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "품  번"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_rtn013u_res01
integer x = 2350
integer y = 1596
integer width = 251
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종료"
end type

event clicked;close(w_rtn013u_res01)
end event

type cb_1 from commandbutton within w_rtn013u_res01
integer x = 2066
integer y = 1596
integer width = 251
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;integer l_n_rows,l_n_sqlcount,i,net1,l_n_chkcount
dec     l_d_rdmctm, l_d_rdlbtm,l_d_rdmctm1,l_d_rdlbtm1
string l_s_parm,l_s_errchk,l_n_column,l_s_rdnvmo,l_s_rdmcno,&
       l_s_rdedfm,l_s_rdterm,l_s_rdremk,l_s_error
string ls_chtime, ls_message, ls_nextdate, ls_rcnvcd
long	ll_logid

if i_s_selected = 'I' or i_s_selected = ' ' then
	return 0
end if
setpointer(hourglass!)
         
dw_2.accepttext()

l_s_errchk = ''
dw_2.SetRedraw(false)
dw_2.object.rdnvmo.background.color = rgb(255,250,239)
dw_2.object.rdmcno.background.color = rgb(255,250,239)
dw_2.object.rdterm.background.color = rgb(255,250,239)
dw_2.object.rdedfm.background.color = rgb(255,250,239)
dw_2.object.rdmctm.background.color = rgb(255,250,239)
dw_2.object.rdlbtm.background.color = rgb(255,250,239)
dw_2.object.rdremk.background.color = rgb(255,255,255)

//적용일자 체크
ll_logid		= dw_2.getitemnumber(1,"rdlogid")
l_s_rdedfm = dw_2.object.rdedfm[1]
l_s_rdremk = dw_2.object.rdremk[1]
l_d_rdmctm = dw_2.object.rdmctm[1]
l_d_rdlbtm = dw_2.object.rdlbtm[1]
l_s_rdnvmo = dw_2.object.rdnvmo[1]
l_s_rdmcno = dw_2.object.rdmcno[1]
l_s_rdterm = dw_2.object.rdterm[1]

if dw_2.object.rdmctm[1] = 0 and dw_2.object.rdlbtm[1] = 0 then
   l_s_errchk = l_s_errchk + '1'
	dw_2.object.rdmctm.color = rgb(255,255,0)
else
	if dw_2.object.rdmctm[1] < 0 then
		l_s_errchk = l_s_errchk + '1'
		dw_2.object.rdmctm.background.color = rgb(255,255,0)
	else
		l_s_errchk = l_s_errchk + ' '
	end if
end if
if dw_2.object.rdlbtm[1] < 0 then
	l_s_errchk = l_s_errchk + '1'
	dw_2.object.rdbltm.background.color = rgb(255,255,0)
else
	l_s_errchk = l_s_errchk + ' '
end if
l_n_column	=	''
if f_spacechk(l_s_errchk) =	0 then
//	if mid(l_s_errchk,1,3) = "111" then
//		if f_spacechk(l_n_column)	= 	-1  then
//			l_n_column  =	"rdnvmo"
//		end if
	if mid(l_s_errchk,1,1) = "1" then
		if f_spacechk(l_n_column)	= 	-1  then
			l_n_column  =	"rdedfm"
		end if
	elseif mid(l_s_errchk,2,1) = "1" then
		if f_spacechk(l_n_column)	= 	-1  then
			l_n_column  =	"rdmctm"
		end if
	elseif mid(l_s_errchk,3,1)	= 	"1" then
		if f_spacechk(l_n_column) 	= 	-1	 then
			l_n_column  =	"rdlbtm"
		end if
	end if
end if

dw_2.SetRedraw(True)

if len(l_n_column)  > 0 then									// Editing Error
	dw_2.setrow(1)
	dw_2.setcolumn(l_n_column)
	dw_2.setfocus()
	st_message.text = "필수입력 항목을 수정 후 처리바랍니다."
	return 0
end if

ls_chtime = f_get_systemdate(sqlca)
ls_nextdate = f_relativedate(g_s_date,1)
SQLCA.AUTOCOMMIT = FALSE

SELECT COUNT(*) INTO :l_n_chkcount FROM PBRTN.RTN014
WHERE RDLOGID = :ll_logid
using sqlca;
	
if l_n_chkcount > 0 then
//부대정보
	UPDATE PBRTN.RTN014  
	SET RDFLAG = 'D',   
		RDEPNO = :g_s_empno,     
		RDIPAD = :g_s_ipaddr,   
		RDUPDT = :g_s_date 
	WHERE RDLOGID = :ll_logid
	using sqlca;
	if sqlca.sqlnrows < 1 then
		ls_message = "부대정보 수정시에 오류가 발생했습니다."
		goto Rollback_
	end if
	
	l_s_rdedfm = ''
	INSERT INTO PBRTN.RTN014  
	( RDCMCD, RDPLANT, RDDVSN, RDITNO, RDLINE1, RDLINE2, RDOPNO, RDNVMO, RDMCNO,   
	  RDTERM, RDMCTM,  RDLBTM, RDREMK, RDFLAG, RDEPNO, RDEDFM,   
	  RDIPAD, RDUPDT, RDSYDT )  
	VALUES (:g_s_company,:i_s_plant,:i_s_dvsn,:i_s_itno,:i_s_line1,:i_s_line2,:i_s_opno,:l_s_rdnvmo,:l_s_rdmcno,
	  :l_s_rdterm, :l_d_rdmctm, :l_d_rdlbtm, :l_s_rdremk, 'A', :g_s_empno, :l_s_rdedfm,
	  :g_s_ipaddr, :g_s_date, :g_s_date )
	using sqlca;
	if sqlca.sqlcode <> 0 then
		ls_message = "부대정보 생성시에 오류가 발생했습니다."
		goto Rollback_
	end if
else
	l_s_rdedfm = ''
	INSERT INTO PBRTN.RTN014  
	( RDCMCD, RDPLANT, RDDVSN, RDITNO, RDLINE1, RDLINE2, RDOPNO, RDNVMO, RDMCNO,   
	  RDTERM, RDMCTM,  RDLBTM, RDREMK, RDFLAG, RDEPNO, RDEDFM,   
	  RDIPAD, RDUPDT, RDSYDT )  
	VALUES (:g_s_company,:i_s_plant,:i_s_dvsn,:i_s_itno,:i_s_line1,:i_s_line2,:i_s_opno,:l_s_rdnvmo,:l_s_rdmcno,
	  :l_s_rdterm, :l_d_rdmctm, :l_d_rdlbtm, :l_s_rdremk, 'A', :g_s_empno, :l_s_rdedfm,
	  :g_s_ipaddr, :g_s_date, :g_s_date )
	using sqlca;
	if sqlca.sqlcode <> 0 then
		ls_message = "부대정보 생성시에 오류가 발생했습니다."
		goto Rollback_
	end if
end if

//부대정보 이력관리 프로세스
//SELECT COUNT(*) INTO :l_n_chkcount FROM PBRTN.RTN016
//WHERE RFCMCD = :g_s_company AND RFPLANT = :i_s_plant AND RFDVSN = :i_s_dvsn AND
//		RFITNO = :i_s_itno AND RFLINE1 = :i_s_line1 AND RFLINE2 = :i_s_line2 AND
//		RFOPNO = :i_s_opno AND RFNVMO = :l_s_rdnvmo AND RFMCNO = :l_s_rdmcno AND 
//		RFTERM = :l_s_rdterm AND RFEDFM = :l_s_rdedfm
//using sqlca;
//			
//if l_n_chkcount < 1 then 
//	INSERT INTO PBRTN.RTN016  
//	( RFCMCD, RFPLANT, RFDVSN, RFITNO, RFLINE1, RFLINE2, RFOPNO, RFNVMO, RFMCNO, 
//	  RFTERM, RFMCTM, RFLBTM, RFREMK, RFFLAG, RFEPNO, RFEDFM,  
//	  RFEDTO, RFIPAD, RFUPDT, RFSYDT )
//	SELECT RDCMCD, RDPLANT, RDDVSN, RDITNO, RDLINE1, RDLINE2, RDOPNO, RDNVMO, RDMCNO,   
//	  RDTERM, RDMCTM,  RDLBTM, RDREMK, 'A', :g_s_empno, :l_s_rdedfm,   
//	  '9999.12.31', :g_s_ipaddr, :g_s_date, :g_s_date
//	FROM PBRTN.RTN014
//	WHERE RDCMCD = :g_s_company AND RDPLANT = :i_s_plant AND RDDVSN = :i_s_dvsn AND
//			RDITNO = :i_s_itno AND RDLINE1 = :i_s_line1 AND RDLINE2 = :i_s_line2 AND
//			RDOPNO = :i_s_opno AND RDNVMO = :l_s_rdnvmo AND RDMCNO = :l_s_rdmcno AND 
//			RDTERM = :l_s_rdterm
//	using sqlca;
//	if sqlca.sqlcode <> 0 then
//		ls_message = "부대작업 이력생성시에 오류발생 1."
//		goto Rollback_
//	end if
//else
//	UPDATE PBRTN.RTN016
//	SET RFFLAG = 'R', 
//		RFEDTO=  :g_s_date,
//		RFEPNO = :g_s_empno,      
//		RFIPAD = :g_s_ipaddr,   
//		RFUPDT = :g_s_date,   
//		RFSYDT = :g_s_date
//	WHERE RFCMCD = :g_s_company AND RFPLANT = :i_s_plant AND RFDVSN = :i_s_dvsn AND
//			RFITNO = :i_s_itno AND RFLINE1 = :i_s_line1 AND RFLINE2 = :i_s_line2 AND
//			RFOPNO = :i_s_opno AND RFNVMO = :l_s_rdnvmo AND RFMCNO = :l_s_rdmcno AND 
//			RFTERM = :l_s_rdterm AND RFEDFM = :l_s_rdedfm
//	using sqlca;
//	
//	if sqlca.sqlnrows < 1 then
//		ls_message = "부대작업 이력생성시에 오류발생 3."
//		goto Rollback_
//	end if
//	
//	INSERT INTO PBRTN.RTN016  
//	( RFCMCD, RFPLANT, RFDVSN, RFITNO, RFLINE1, RFLINE2, RFOPNO, RFNVMO, RFMCNO, 
//	  RFTERM, RFMCTM, RFLBTM, RFREMK, RFFLAG, RFEPNO, RFEDFM,  
//	  RFEDTO, RFIPAD, RFUPDT, RFSYDT )
//	SELECT RDCMCD, RDPLANT, RDDVSN, RDITNO, RDLINE1, RDLINE2, RDOPNO, RDNVMO, RDMCNO,   
//	  RDTERM, RDMCTM,  RDLBTM, RDREMK, 'A', :g_s_empno, :ls_nextdate,   
//	  '9999.12.31', :g_s_ipaddr, :g_s_date, :g_s_date
//	FROM PBRTN.RTN014
//	WHERE RDCMCD = :g_s_company AND RDPLANT = :i_s_plant AND RDDVSN = :i_s_dvsn AND
//			RDITNO = :i_s_itno AND RDLINE1 = :i_s_line1 AND RDLINE2 = :i_s_line2 AND
//			RDOPNO = :i_s_opno AND RDNVMO = :l_s_rdnvmo AND RDMCNO = :l_s_rdmcno AND 
//			RDTERM = :l_s_rdterm
//	using sqlca;
//	
//	if sqlca.sqlcode <> 0 then
//		ls_message = "부대작업 이력생성시에 오류발생 4."
//		goto Rollback_
//	end if
//end if

select sum(rdmctm), sum(rdlbtm), count(*) into :l_d_rdmctm, :l_d_rdlbtm, :l_n_chkcount
from pbrtn.rtn014
WHERE rdcmcd = :g_s_company AND rdplant = :i_s_plant AND rddvsn = :i_s_dvsn AND
		rditno = :i_s_itno AND rdline1 = :i_s_line1 AND rdline2 = :i_s_line2 AND
		rdopno = :i_s_opno and rdflag <> 'D'
using sqlca;

if l_n_chkcount = 0 then
	ls_rcnvcd = 'N'
	l_d_rdmctm = 0
	l_d_rdlbtm = 0
else
	ls_rcnvcd = 'Y'
end if

update pbrtn.rtn013
set rcnvcd = :ls_rcnvcd, rcnvmc = :l_d_rdmctm, rcnvlb  = :l_d_rdlbtm,
	 rcepno = :g_s_empno , rcipad = :g_s_ipaddr, rcupdt = :g_s_date, rcflag = 'R',
	 rcchtime = :ls_chtime, rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
	 rcplemp = '', rcplchk = 'N', rcpltime = '',
	 rcdlemp = '', rcdlchk = 'N', rcdltime = ''
where rccmcd = :g_s_company and rcplant = :i_s_plant and rcdvsn = :i_s_dvsn and 
		rcitno = :i_s_itno and rcline1 = :i_s_line1 and rcline2 = :i_s_line2 and 
		rcopno = :i_s_opno 
using sqlca;

if sqlca.sqlnrows < 1 then
	ls_message = "부대작업에 해당하는 공정정보가 없습니다."
	goto Rollback_
end if

COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE

st_message.text = "처리완료! 결재절차를 수행하시기 바랍니다."
dw_1.retrieve(g_s_company,i_s_plant,i_s_dvsn,i_s_itno,i_s_line1,i_s_line2,i_s_opno)
wf_rgbclear('P')
dw_2.reset()
i_s_selected = ' '

return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
st_message.text = ls_message

return -1



end event

type dw_1 from datawindow within w_rtn013u_res01
event ue_keydown pbm_dwnkey
integer x = 14
integer y = 144
integer width = 2624
integer height = 952
integer taborder = 10
string dataobject = "d_rtn01_dw_budaejakup"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string l_s_nvmo,l_s_mcno,l_s_term
long ll_logid

if row < 1 then
	return 0
end if

this.selectrow(0,false)
this.selectrow(row,true)

i_s_selected = 'I'
wf_rgbclear('P')

ll_logid = dw_1.getitemnumber(row,"rdlogid")

dw_2.retrieve(ll_logid)

dw_2.setredraw(true)
st_message.text = "조회되었습니다."





end event

event doubleclicked;string l_s_nvmo,l_s_mcno,l_s_term
long ll_logid

if row < 1 then
	return 0
end if

this.selectrow(0,false)
this.selectrow(row,true)

i_s_selected = 'C'
wf_rgbclear('C')

ll_logid = dw_1.getitemnumber(row,"rdlogid")

dw_2.retrieve(ll_logid)

dw_2.setredraw(true)
st_message.text = "조회되었습니다."

end event

type sle_4 from singlelineedit within w_rtn013u_res01
integer x = 2153
integer y = 24
integer width = 233
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_3 from singlelineedit within w_rtn013u_res01
integer x = 1335
integer y = 24
integer width = 430
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_2 from singlelineedit within w_rtn013u_res01
integer x = 270
integer y = 24
integer width = 590
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

