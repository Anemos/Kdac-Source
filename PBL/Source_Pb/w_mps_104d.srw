$PBExportHeader$w_mps_104d.srw
$PBExportComments$생산계획 Upload
forward
global type w_mps_104d from w_origin_sheet06
end type
type st_a1 from statictext within w_mps_104d
end type
type st_a2 from statictext within w_mps_104d
end type
type st_3 from statictext within w_mps_104d
end type
type st_daesang from statictext within w_mps_104d
end type
type st_55 from statictext within w_mps_104d
end type
type st_saeng from statictext within w_mps_104d
end type
type uo_1 from uo_progress_bar within w_mps_104d
end type
type dw_1 from datawindow within w_mps_104d
end type
type uo_2 from uo_plandiv_pdcd_rtn within w_mps_104d
end type
type st_2 from statictext within w_mps_104d
end type
type uo_3 from uo_ccyymm_mps within w_mps_104d
end type
type dw_2 from datawindow within w_mps_104d
end type
type gb_1 from groupbox within w_mps_104d
end type
type gb_2 from groupbox within w_mps_104d
end type
type gb_3 from groupbox within w_mps_104d
end type
end forward

global type w_mps_104d from w_origin_sheet06
st_a1 st_a1
st_a2 st_a2
st_3 st_3
st_daesang st_daesang
st_55 st_55
st_saeng st_saeng
uo_1 uo_1
dw_1 dw_1
uo_2 uo_2
st_2 st_2
uo_3 uo_3
dw_2 dw_2
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_mps_104d w_mps_104d

type variables
dec i_n_complete
string is_xplant,is_div,is_pdcd,is_date
end variables

forward prototypes
public subroutine wf_return ()
public function integer wf_delete_old_data (string fs_year, string fs_month, string fs_xplant, string fs_div, string fs_pdcd)
public subroutine wf_qty_move (integer fn_row)
end prototypes

public subroutine wf_return ();string ls_parm

ls_parm     = uo_2.uf_return()
is_xplant  = mid(ls_parm,1,1)
is_div    = mid(ls_parm,2,1)
is_pdcd    = mid(ls_parm,3,4)
is_date    = uo_3.uf_yyyymm()
end subroutine

public function integer wf_delete_old_data (string fs_year, string fs_month, string fs_xplant, string fs_div, string fs_pdcd);
delete from pbmps.mps004
where dcmcd	=	:g_s_company	and	dyear	=	:fs_year	and	dmonth	=	:fs_month	and
		dplant		=	:fs_xplant			and	ddvsn	=	:fs_div		and	ditno		in 	
		(	select	itno	from pbinv.inv101	
				where comltd	=	:g_s_company	and	xplant	=	:fs_xplant		and	div		=	:fs_div		and		
						pdcd		like	:fs_pdcd	
		)
using sqlca ;

if sqlca.sqlcode	<> 0	then
	return 1
else
	return 0
end if
end function

public subroutine wf_qty_move (integer fn_row);int  i
string ls_year,ls_month,ls_itno
dec{4} ld_mrat
dec{0} ld_bqtyd[12],ld_bqtye[12],ld_dplnq[12],ld_ddplnq[12],ld_deplnq[12],ld_fdplnq[8]

ls_year			=	mid(is_date,1,4)
ls_month			=	mid(is_date,5,2)
ls_itno			=	trim(dw_1.object.itno[fn_row])

ld_dplnq[1]		=	dw_1.object.dplnq01[fn_row]
ld_dplnq[2]		=	dw_1.object.dplnq02[fn_row]
ld_dplnq[3]		=	dw_1.object.dplnq03[fn_row]
ld_dplnq[4]		=	dw_1.object.dplnq04[fn_row]
ld_dplnq[5]		=	dw_1.object.dplnq05[fn_row]
ld_dplnq[6]		=	dw_1.object.dplnq06[fn_row]

ld_dplnq[7]		=	dw_1.object.dplnq07[fn_row]
ld_dplnq[8]		=	dw_1.object.dplnq08[fn_row]
ld_dplnq[9]		=	dw_1.object.dplnq09[fn_row]
ld_dplnq[10]		=	dw_1.object.dplnq10[fn_row]
ld_dplnq[11]		=	dw_1.object.dplnq11[fn_row]
ld_dplnq[12]		=	dw_1.object.dplnq12[fn_row]
	 
		 
select bqtyd01,bqtye01,bqtyd02,bqtye02,bqtyd03,bqtye03,bqtyd04,bqtye04,bqtyd05,bqtye05,bqtyd06,bqtye06,
	bqtyd07,bqtye07,bqtyd08,bqtye08,bqtyd09,bqtye09,bqtyd10,bqtye10,bqtyd11,bqtye11,bqtyd12,bqtye12
   into :ld_bqtyd[1],:ld_bqtye[1],:ld_bqtyd[2],:ld_bqtye[2],:ld_bqtyd[3],:ld_bqtye[3], 
	     :ld_bqtyd[4],:ld_bqtye[4],:ld_bqtyd[5],:ld_bqtye[5],:ld_bqtyd[6],:ld_bqtye[6],
		  :ld_bqtyd[7],:ld_bqtye[7],:ld_bqtyd[8],:ld_bqtye[8],:ld_bqtyd[9],:ld_bqtye[9], 
	     :ld_bqtyd[10],:ld_bqtye[10],:ld_bqtyd[11],:ld_bqtye[11],:ld_bqtyd[12],:ld_bqtye[12]
from pbmps.mps002 
	where 	bcmcd 	= :g_s_company 	and byear 	= :ls_year 	and bmonth 	= :ls_month and
	      		bplant 	= :is_xplant	   		and bdvsn	= :is_div   		and bitno 		= :ls_itno 
using sqlca ;
if sqlca.sqlcode = 0 then
	for i = 1 to 12 
		if ( ld_bqtyd[i] + ld_bqtye[i] ) = 0 then
			ld_mrat = 1
		else
			ld_mrat = ld_bqtyd[i] / ( ld_bqtyd[i] + ld_bqtye[i] )
		end if
		ld_ddplnq[i] = ld_mrat * ld_dplnq[i]
		ld_deplnq[i] = ld_dplnq[i] - ld_ddplnq[i]
	next
else
	for i = 1 to 12 
		ld_ddplnq[i] = ld_dplnq[i]
		ld_deplnq[i] = ld_dplnq[i] - ld_ddplnq[i]
	next
end if

ld_fdplnq[1] = ld_ddplnq[1] / 2   // M월 상반기 내수계획
ld_fdplnq[2] = ld_ddplnq[1] - ld_fdplnq[1] // M+1 월 상반기 내수계획
ld_fdplnq[3] = ld_ddplnq[2] / 2   // M월 하반기 내수계획
ld_fdplnq[4] = ld_ddplnq[2] - ld_fdplnq[3] // M+1 월 하반기 내수계획
ld_fdplnq[5] = ld_deplnq[1] / 2   // M월 상반기 수출계획
ld_fdplnq[6] = ld_deplnq[1] - ld_fdplnq[5] // M+1 월 상반기 수출계획
ld_fdplnq[7] = ld_deplnq[2] / 2   // M월 하반기 수출계획
ld_fdplnq[8] = ld_deplnq[2] - ld_fdplnq[7] // M+1 월 하반기 수출계획

dw_2.object.dplnq01[fn_row]  		= ld_dplnq[1]
dw_2.object.dplnq02[fn_row]  		= ld_dplnq[2]
dw_2.object.dplnq03[fn_row]  		= ld_dplnq[3]
dw_2.object.dplnq04[fn_row]  		= ld_dplnq[4]
dw_2.object.dplnq05[fn_row]  		= ld_dplnq[5]
dw_2.object.dplnq06[fn_row]  		= ld_dplnq[6]
dw_2.object.dplnq07[fn_row]  		= ld_dplnq[7]
dw_2.object.dplnq08[fn_row]  		= ld_dplnq[8]
dw_2.object.dplnq09[fn_row]  		= ld_dplnq[9]
dw_2.object.dplnq10[fn_row]  		= ld_dplnq[10]
dw_2.object.dplnq11[fn_row]  		= ld_dplnq[11]
dw_2.object.dplnq12[fn_row]  		= ld_dplnq[12]

dw_2.object.ddplnq01[fn_row] 		= ld_ddplnq[1]
dw_2.object.ddplnq02[fn_row] 		= ld_ddplnq[2]
dw_2.object.ddplnq03[fn_row] 		= ld_ddplnq[3]
dw_2.object.ddplnq04[fn_row] 		= ld_ddplnq[4]
dw_2.object.ddplnq05[fn_row] 		= ld_ddplnq[5]
dw_2.object.ddplnq06[fn_row] 		= ld_ddplnq[6]
dw_2.object.ddplnq07[fn_row] 		= ld_ddplnq[7]
dw_2.object.ddplnq08[fn_row] 		= ld_ddplnq[8]
dw_2.object.ddplnq09[fn_row] 		= ld_ddplnq[9]
dw_2.object.ddplnq10[fn_row] 		= ld_ddplnq[10]
dw_2.object.ddplnq11[fn_row] 		= ld_ddplnq[11]
dw_2.object.ddplnq12[fn_row] 		= ld_ddplnq[12]

dw_2.object.deplnq01[fn_row] 		= ld_deplnq[1]
dw_2.object.deplnq02[fn_row] 		= ld_deplnq[2]
dw_2.object.deplnq03[fn_row] 		= ld_deplnq[3]
dw_2.object.deplnq04[fn_row] 		= ld_deplnq[4]
dw_2.object.deplnq05[fn_row] 		= ld_deplnq[5]
dw_2.object.deplnq06[fn_row] 		= ld_deplnq[6]
dw_2.object.deplnq07[fn_row] 		= ld_deplnq[7]
dw_2.object.deplnq08[fn_row] 		= ld_deplnq[8]
dw_2.object.deplnq09[fn_row] 		= ld_deplnq[9]
dw_2.object.deplnq10[fn_row] 		= ld_deplnq[10]
dw_2.object.deplnq11[fn_row] 		= ld_deplnq[11]
dw_2.object.deplnq12[fn_row] 		= ld_deplnq[12]

dw_2.object.dfdplnq1[fn_row] 		= ld_fdplnq[1]
dw_2.object.dfdplnq2[fn_row] 		= ld_fdplnq[2]
dw_2.object.dsdplnq1[fn_row] 		= ld_fdplnq[3]
dw_2.object.dsdplnq2[fn_row] 		= ld_fdplnq[4]
dw_2.object.dfeplnq1[fn_row] 		= ld_fdplnq[5]
dw_2.object.dfeplnq2[fn_row] 		= ld_fdplnq[6]
dw_2.object.dseplnq1[fn_row] 		= ld_fdplnq[7]
dw_2.object.dseplnq2[fn_row] 		= ld_fdplnq[8]



	

end subroutine

on w_mps_104d.create
int iCurrent
call super::create
this.st_a1=create st_a1
this.st_a2=create st_a2
this.st_3=create st_3
this.st_daesang=create st_daesang
this.st_55=create st_55
this.st_saeng=create st_saeng
this.uo_1=create uo_1
this.dw_1=create dw_1
this.uo_2=create uo_2
this.st_2=create st_2
this.uo_3=create uo_3
this.dw_2=create dw_2
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_a1
this.Control[iCurrent+2]=this.st_a2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_daesang
this.Control[iCurrent+5]=this.st_55
this.Control[iCurrent+6]=this.st_saeng
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.uo_2
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.uo_3
this.Control[iCurrent+12]=this.dw_2
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.gb_3
end on

on w_mps_104d.destroy
call super::destroy
destroy(this.st_a1)
destroy(this.st_a2)
destroy(this.st_3)
destroy(this.st_daesang)
destroy(this.st_55)
destroy(this.st_saeng)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.uo_2)
destroy(this.st_2)
destroy(this.uo_3)
destroy(this.dw_2)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;dw_1.settransobject(sqlca)
end event

event ue_bretrieve;call super::ue_bretrieve;int  ln_count,i,ln_row
string ls_pathname,ls_filename,ls_checkdate[],ls_mod,ls_date,ls_stscd

setpointer(HourGlass!)

uo_1.uf_set_position (0)
st_daesang.text = ''
st_saeng.text = ''

i_b_bcreate = false
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
wf_return()
if trim(is_xplant) = '' or trim(is_div) = '' then
	messagebox("확인","지역과 공장을 반드시 입력바랍니다")
	return 0
end if

select coalesce(max(zstscd),'') into :ls_stscd from pbmps.mps007
where 	zcmcd = '01' and zpgmid = 'MPSU06' and 
			zplant = :is_xplant and zdvsn = :is_div and zyear = :is_date
using sqlca ;			

if ls_stscd = '' then
	messagebox("확인","해당월의 판매계획집계가 완료되지 않았습니다.")
	return
end if

dw_1.reset()

if f_pdm_getfromexcel(dw_1) = 0 then
	if dw_1.object.checkdouble[1]	=	1	then // 중복 체크
		messagebox("확인","같은 품번이 두번이상 입력되었습니다. 엑셀파일을 확인하세요")
		return 0
	else
		messagebox("확인","엑셀파일 조회 완료.")
	end if
else
	messagebox("확인","엑셀파일 조회 실패")
     return 0
end if

for i = 0 to 11
	ls_date =  f_relative_month(is_date + '01' , i)
	ls_checkdate[i+1] = mid(ls_date,1,4) + '년 ' + mid(ls_date,5,2) + '월'
next
ls_mod	=  "t_1.Text = '" + ls_checkdate[1]   +  "'" + &
				"t_2.Text = '" + ls_checkdate[2]   +  "'" + &
				"t_3.Text = '" + ls_checkdate[3]   +  "'" + &
				"t_4.Text = '" + ls_checkdate[4]   +  "'" + &
				"t_5.Text = '" + ls_checkdate[5]   +  "'" + &
				"t_6.Text = '" + ls_checkdate[6]   +  "'" + &
				"t_7.Text = '" + ls_checkdate[7]   +  "'" + &
				"t_8.Text = '" + ls_checkdate[8]   +  "'" + &
				"t_9.Text = '" + ls_checkdate[9]   +  "'" + &
				"t_10.Text = '" + ls_checkdate[10]   +  "'" + &
				"t_11.Text = '" + ls_checkdate[11]   +  "'" + &
				"t_12.Text = '" + ls_checkdate[12]   +  "'"
dw_1.Modify(ls_mod)

ln_count = dw_1.rowcount()

if ln_count  > 0 	then
	ln_row		=	dw_1.find("isnull(itno) or trim(itno) = '' ",1,ln_count)
	if  ln_row	> 0 then
		messagebox("확인","품번은 반드시 입력바랍니다.")
		dw_1.scrolltorow(ln_row)
		dw_1.selectrow(ln_row,true)
		return 0
	end if
	if trim(is_pdcd) <> '' then
		ln_row		=	dw_1.find(" trim(pdcd) <> '' and mid(pdcd,1,2)  <> '" + is_pdcd + "'",1,ln_count)
		if  ln_row	> 0 then
			messagebox("확인","선택하신 제품군과 다른 제품군이 Excel 파일에 있습니다.확인하시고 작업바랍니다")
			dw_1.scrolltorow(ln_row)
			dw_1.selectrow(ln_row,true)
			return 0
		end if
	end if
	i_b_bcreate	  = True
	wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
end if

st_daesang.text = string(ln_count,"###,### ")


end event

event ue_bcreate;call super::ue_bcreate;integer    	Net,i,ln_count
string		ls_itno,ls_type,ls_srce,ls_cls
dec{2}	ld_davcst
dec{0}   ld_ohqt

Net = messagebox("확 인", "자료생성 작업을 수행 하겠습니까?",Question!, OkCancel!, 1)
if Net <> 1 then
	return
end if

setpointer(HourGlass!)

uo_1.uf_set_position (0)
st_saeng.text = ''

uo_status.st_message.text = "자료 처리중(오류 확인중)..."

ln_count = dw_1.rowcount()

dw_2.reset()

for i = 1 to ln_count
	yield()
   dw_1.scrolltorow(i)
	dw_1.selectrow(0,false)
	dw_1.selectrow(i,true)
	ls_itno			=	trim(dw_1.object.itno[i])
	ld_ohqt        =  dw_1.object.ohqt[i]
	select cls,srce,saud into :ls_cls,:ls_srce,:ld_davcst from pbinv.inv101
		where comltd = :g_s_company and xplant = :is_xplant and div = :is_div and itno = :ls_itno 
	using sqlca ;
	if sqlca.sqlcode <> 0 then
		messagebox("확인","품목상세정보에 등록되지 않은 품번입니다")
		return 0
	end if
	
	if dw_1.object.davcst[i] = 0 then
		select avgprc into :ld_davcst from pbsle.sle213
			where comltd = :g_s_company and cym = :is_date and xplant = :is_xplant and div = :is_div and
			      itno = :ls_itno
		using sqlca ;
	else
		ld_davcst		=	dw_1.object.davcst[i]
	end if
	
	if ls_srce	=	"03"	then
		ls_type	=	'A'	
	elseif ls_cls	=	"30"	and	trim(ls_srce)	=	''	then
		ls_type	=	' '
	else
		ls_type	=	'B'
	end if
	
	dw_2.object.dyear[i]		=	mid(is_date,1,4)
	dw_2.object.dmonth[i]	=	mid(is_date,5,2)	
	dw_2.object.dplant[i]	=	is_xplant
	dw_2.object.ddvsn[i]		=	is_div
	dw_2.object.dtype[i]		=	ls_type
	dw_2.object.ditno[i]		=	ls_itno
	dw_2.object.davcst[i]	=	ld_davcst
	dw_2.object.dmacaddr[i]	=	g_s_macaddr
	dw_2.object.dipaddr[i]	=	g_s_ipaddr
	dw_2.object.dempno[i]	=	g_s_empno
	dw_2.object.dupdt[i]		=	g_s_date
	dw_2.object.dcrdt[i]		=	g_s_date
	wf_qty_move(i)
	
	update pbmps.mps001
		set aohqt	=	:ld_ohqt
	where acmcd = '01' and advsn = :is_div and aplant = :is_xplant and aitno = :ls_itno
	using sqlca ;
	
	if sqlca.sqlnrows < 1 then
		insert into pbmps.mps001
		( acmcd,aplant,advsn,aitno,atype,
		  asfsd,asfsq,altsz,abmbq,apdqa,
		  apdqr,aslqa,aslqr,aohqt,alnmn,alnal,achyn,
		  amacaddr,aipaddr,alsdt,aupdt,acrdt )
		values(:g_s_company,:is_xplant,:is_div,:ls_itno,:ls_type,
		 0,0,0,0,0,
		 0,0,0,0,' ',' ',' ', 
		 :g_s_macaddr,:g_s_ipaddr,:is_date,:g_s_date,:g_s_date )
		 using sqlca;
	end if
	
	dw_2.object.dexpst[i]		=	ld_ohqt
	i_n_complete	= i * 100 / ln_count
	if mod(i,5) 	= 0 then
		uo_1.uf_set_position (i_n_complete)
	end if
next

uo_status.st_message.text = "오류 없음. 저장중..."

if	wf_delete_old_data(mid(is_date,1,4),mid(is_date,5,2),is_xplant,is_div,trim(is_pdcd) + '%')	<>	0	then // 이전 Data 삭제
	messagebox("확인","생산계획 정보 Upload 실패하였습니다. 시스템개발팀으로 문의바랍니다")
	return	0
end if

if dw_2.update() <> 1 then
	messagebox("확인","생산계획 정보 Upload 실패하였습니다. 시스템개발팀으로 문의바랍니다")
	return
end if

f_mps007_update(is_xplant,is_div,mid(is_date,1,4)+mid(is_date,5,2),'N')

st_saeng.text = string(ln_count,"###,### ")
messagebox("확인","생산계획 정보 Upload 완료, 생산계획 Download 화면에서 확정작업을 해주시기 바랍니다.")

end event

type uo_status from w_origin_sheet06`uo_status within w_mps_104d
integer y = 2436
integer width = 4603
integer height = 92
end type

type st_a1 from statictext within w_mps_104d
integer x = 1298
integer y = 1548
integer width = 2103
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "１.~'대상조회~'를 눌러 대상건수를 확인 하십시오."
boolean focusrectangle = false
end type

type st_a2 from statictext within w_mps_104d
integer x = 1294
integer y = 1656
integer width = 2103
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "２. 대상건수에 이상이 없으면 ~'자료생성~'을 누르십시오."
boolean focusrectangle = false
end type

type st_3 from statictext within w_mps_104d
integer x = 1403
integer y = 1844
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "대상건수"
boolean focusrectangle = false
end type

type st_daesang from statictext within w_mps_104d
integer x = 1728
integer y = 1836
integer width = 389
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_55 from statictext within w_mps_104d
integer x = 2455
integer y = 1844
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "생성건수"
boolean focusrectangle = false
end type

type st_saeng from statictext within w_mps_104d
integer x = 2784
integer y = 1836
integer width = 389
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type uo_1 from uo_progress_bar within w_mps_104d
event destroy ( )
integer x = 1609
integer y = 2120
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type dw_1 from datawindow within w_mps_104d
integer x = 41
integer y = 216
integer width = 4562
integer height = 1272
integer taborder = 10
boolean bringtotop = true
string title = "dw_1"
string dataobject = "d_mps_upload_old"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;MESSAGEBOX("DatawindowError",STRING(ROW))
return 1

end event

event itemerror;MESSAGEBOX("확인",STRING(ROW) + "   " + STRING(DWO.NAME))
end event

event clicked;if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
end if
end event

type uo_2 from uo_plandiv_pdcd_rtn within w_mps_104d
event aaa pbm_dwnsetfocus
integer x = 91
integer y = 48
integer width = 2455
integer taborder = 30
boolean bringtotop = true
end type

on uo_2.destroy
call uo_plandiv_pdcd_rtn::destroy
end on

type st_2 from statictext within w_mps_104d
integer x = 2587
integer y = 80
integer width = 288
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년월"
boolean focusrectangle = false
end type

type uo_3 from uo_ccyymm_mps within w_mps_104d
event destroy ( )
integer x = 2898
integer y = 64
integer taborder = 50
boolean bringtotop = true
end type

on uo_3.destroy
call uo_ccyymm_mps::destroy
end on

type dw_2 from datawindow within w_mps_104d
boolean visible = false
integer x = 2144
integer y = 228
integer width = 686
integer height = 400
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_insert_mps004"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type gb_1 from groupbox within w_mps_104d
integer x = 1321
integer y = 1748
integer width = 2011
integer height = 236
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_mps_104d
integer x = 1321
integer y = 2024
integer width = 2011
integer height = 256
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "[처리상태]"
end type

type gb_3 from groupbox within w_mps_104d
integer x = 41
integer y = 4
integer width = 4562
integer height = 192
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

