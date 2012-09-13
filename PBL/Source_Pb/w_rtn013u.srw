$PBExportHeader$w_rtn013u.srw
$PBExportComments$품변별 Routing 정보 등록(결재]
forward
global type w_rtn013u from w_origin_sheet01
end type
type tv_1 from treeview within w_rtn013u
end type
type dw_1 from datawindow within w_rtn013u
end type
type sle_input from singlelineedit within w_rtn013u
end type
type dw_detail from datawindow within w_rtn013u
end type
type pb_find_item from picturebutton within w_rtn013u
end type
type rb_1 from radiobutton within w_rtn013u
end type
type rb_2 from radiobutton within w_rtn013u
end type
type uo_1 from uo_plandiv_pdcd_rtn within w_rtn013u
end type
type cb_copy from commandbutton within w_rtn013u
end type
type cb_delete from commandbutton within w_rtn013u
end type
type cb_rtn013_template from commandbutton within w_rtn013u
end type
type cb_rtn014_template from commandbutton within w_rtn013u
end type
type dw_down from datawindow within w_rtn013u
end type
type cb_allcopy from commandbutton within w_rtn013u
end type
type cb_deptchange from commandbutton within w_rtn013u
end type
type gb_framemove from groupbox within w_rtn013u
end type
type gb_1 from groupbox within w_rtn013u
end type
type gb_2 from groupbox within w_rtn013u
end type
end forward

global type w_rtn013u from w_origin_sheet01
integer width = 4677
string title = "Routing 정보 등록"
tv_1 tv_1
dw_1 dw_1
sle_input sle_input
dw_detail dw_detail
pb_find_item pb_find_item
rb_1 rb_1
rb_2 rb_2
uo_1 uo_1
cb_copy cb_copy
cb_delete cb_delete
cb_rtn013_template cb_rtn013_template
cb_rtn014_template cb_rtn014_template
dw_down dw_down
cb_allcopy cb_allcopy
cb_deptchange cb_deptchange
gb_framemove gb_framemove
gb_1 gb_1
gb_2 gb_2
end type
global w_rtn013u w_rtn013u

type variables
datastore ids_data1,ids_data2,ids_data3,ids_data4,ids_data5,ids_data6
string i_s_selected,i_s_chkbox,i_s_rcitno,i_s_rcline,i_s_protect
integer l_s_populate, l_s_populate_no, i_i_lastrow
end variables

forward prototypes
public subroutine wf_visible_check (string ag_visible)
public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw)
public subroutine wf_dw3_delete ()
public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1)
public subroutine wf_rgbclear (string a_para)
public function string wf_gradeupdate (string a_plant, string a_div, string a_itno, string a_line)
public function integer wf_rtn004_6_update (string a_cmcd, string a_plant, string a_dvsn, string a_itno, string a_line1, string a_line2, string a_opno)
public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this)
public subroutine wf_rtn005_update (string a_cmcd, string a_plant, string a_dvsn, string a_itno, string a_line, string a_opno, string a_date)
public subroutine wf_rtn006_update (string a_plant, string a_dvsn, string a_itno, string a_line1, string a_line2, string a_opno, string a_nvmo, string a_mcno, string a_term, decimal a_rrnno, string a_rdedfm)
public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent)
public subroutine wf_set_items (integer ag_level, integer ag_row, readonly treeviewitem ag_tvinew)
protected function string wf_chk_error1 (decimal l_n_rbopsq, string l_s_rbopno, string l_s_rbedfm, string l_s_rbopnm, string l_s_rbline3, decimal l_d_rbbmtm, decimal l_d_rbbltm, decimal l_d_rbbstm, decimal l_n_rblbcnt, string l_s_rbplant, string l_s_rbdvsn, string l_s_rbline, string l_s_rbitno)
end prototypes

public subroutine wf_visible_check (string ag_visible);
end subroutine

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

public subroutine wf_dw3_delete ();
end subroutine

public subroutine wf_rgbset (string ag_s_column, integer ag_n_number, integer ag_n_color, datawindow ag_dw_1);string l_s_command
long 	 l_l_color = 16777215						//	white

//--	Argument	=> ag_s_column = column 명, 
//---             ag_n_number = column 순서,
//--  				ag_n_color  = column 색상( 1 = Cream[255,250,239], 2 = White[255,255,255] )  
ag_dw_1.setredraw(False)
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
ag_dw_1.setredraw(True)
end subroutine

public subroutine wf_rgbclear (string a_para);
if a_para = 'I' then
	dw_detail.object.rcitno.background.color  = rgb(192,192,192)
	dw_detail.object.rcline1.background.color = rgb(192,192,192)
	dw_detail.object.rcline2.background.color = rgb(192,192,192)
   dw_detail.object.rcopsq.background.color  = rgb(192,192,192)
	dw_detail.object.rcopno.background.color  = rgb(192,192,192)
//	dw_detail.object.rcedfm.background.color  = rgb(192,192,192)
	dw_detail.object.rcopnm.background.color  = rgb(192,192,192)
	dw_detail.object.rcline3.background.color = rgb(192,192,192)
	dw_detail.object.rcbmtm.background.color  = rgb(192,192,192)
	dw_detail.object.rcbltm.background.color  = rgb(192,192,192)
	dw_detail.object.rcbstm.background.color  = rgb(192,192,192)
	dw_detail.object.rclbcnt.background.color = rgb(192,192,192)
	
	dw_detail.object.rcitno.protect           = true
	dw_detail.object.rcline1.protect          = true
	dw_detail.object.rcline2.protect          = true
   dw_detail.object.rcopsq.protect           = true
	dw_detail.object.rcopno.protect           = true
//	dw_detail.object.rcedfm.protect           = true
	dw_detail.object.rcopnm.protect           = true
	dw_detail.object.rcline3.protect          = true
	dw_detail.object.rcbmtm.protect           = true
	dw_detail.object.rcbltm.protect           = true
	dw_detail.object.rcbstm.protect           = true
	dw_detail.object.rclbcnt.protect          = true
	dw_detail.object.find_button.visible      = false
	dw_detail.object.jangbi_button.visible    = true
	dw_detail.object.budae_button.visible     = true
	dw_detail.object.b_jubu.visible           = false
elseif a_para = 'A' then
	if f_spacechk(dw_detail.object.rcitno[1]) = -1 then
		i_s_protect = ' '
		dw_detail.object.rcitno.background.color  = rgb(255,255,239)
		dw_detail.object.rcitno.protect           = false
	else
		i_s_protect = '1'
		dw_detail.object.rcitno.background.color  = rgb(192,192,192)
		dw_detail.object.rcitno.protect           = true
	end if
	
	if f_spacechk(dw_detail.object.rcline1[1]) = -1 then
		i_s_protect += ' '
		dw_detail.object.rcline1.background.color  = rgb(255,255,239)
		dw_detail.object.rcline1.protect           = false
	else
		i_s_protect += '1'
		dw_detail.object.rcline1.background.color  = rgb(192,192,192)
		dw_detail.object.rcline1.protect           = true
	end if
	
	if f_spacechk(dw_detail.object.rcline2[1]) = -1 then
		i_s_protect += ' '
		dw_detail.object.rcline2.background.color  = rgb(255,255,239)
		dw_detail.object.rcline2.protect           = false
	else
		i_s_protect += '1'
		dw_detail.object.rcline2.background.color  = rgb(192,192,192)
		dw_detail.object.rcline2.protect           = true
	end if
	
	dw_detail.object.rcopsq.background.color  = rgb(255,255,239)
	dw_detail.object.rcopno.background.color  = rgb(255,255,239)
//	dw_detail.object.rcedfm.background.color  = rgb(255,255,239)
	dw_detail.object.rcopnm.background.color  = rgb(255,255,239)
	dw_detail.object.rcline3.background.color = rgb(255,255,239)
	dw_detail.object.rcbmtm.background.color  = rgb(255,255,239)
	dw_detail.object.rcbltm.background.color  = rgb(255,255,239)
	dw_detail.object.rcbstm.background.color  = rgb(255,255,239)
	dw_detail.object.rclbcnt.background.color = rgb(255,255,255)
	
   dw_detail.object.rcopsq.protect           = false
	dw_detail.object.rcopno.protect           = false
//	dw_detail.object.rcedfm.protect           = false
	dw_detail.object.rcopnm.protect           = false
	dw_detail.object.rcline3.protect          = false
	dw_detail.object.rcbmtm.protect           = false
	dw_detail.object.rcbltm.protect           = false
	dw_detail.object.rcbstm.protect           = false
	dw_detail.object.rclbcnt.protect          = false
	dw_detail.object.find_button.visible      = true
	dw_detail.object.jangbi_button.visible    = true
	dw_detail.object.budae_button.visible     = true
	dw_detail.object.b_jubu.visible           = true
else
	dw_detail.object.rcitno.background.color  = rgb(192,192,192)
	dw_detail.object.rcline1.background.color = rgb(192,192,192)
	dw_detail.object.rcline2.background.color = rgb(192,192,192)
	dw_detail.object.rcopsq.background.color  = rgb(255,255,239)
	dw_detail.object.rcopno.background.color  = rgb(192,192,192)
//	dw_detail.object.rcopno.background.color  = rgb(255,255,239)
//	dw_detail.object.rcedfm.background.color  = rgb(255,255,239)
	dw_detail.object.rcopnm.background.color  = rgb(255,255,239)
	dw_detail.object.rcline3.background.color = rgb(255,255,239)
	dw_detail.object.rcbmtm.background.color  = rgb(255,255,239)
	dw_detail.object.rcbltm.background.color  = rgb(255,255,239)
	dw_detail.object.rcbstm.background.color  = rgb(255,255,239)
	dw_detail.object.rclbcnt.background.color = rgb(255,255,255)
	i_s_protect = '111'
	dw_detail.object.rcitno.protect           = true
	dw_detail.object.rcline1.protect          = true
	dw_detail.object.rcline2.protect          = true
   dw_detail.object.rcopsq.protect           = false
	dw_detail.object.rcopno.protect           = true
//	dw_detail.object.rcopno.protect           = false
//	dw_detail.object.rcedfm.protect           = false
	dw_detail.object.rcopnm.protect           = false
	dw_detail.object.rcline3.protect          = false
	dw_detail.object.rcbmtm.protect           = false
	dw_detail.object.rcbltm.protect           = false
	dw_detail.object.rcbstm.protect           = false
	dw_detail.object.rclbcnt.protect          = false
	dw_detail.object.find_button.visible      = true
	dw_detail.object.jangbi_button.visible    = true
	dw_detail.object.budae_button.visible     = true
	dw_detail.object.b_jubu.visible           = true
end if
end subroutine

public function string wf_gradeupdate (string a_plant, string a_div, string a_itno, string a_line);string l_s_rcgrde
long   l_n_sql_count1

select rcgrde into :l_s_rcgrde from pbrtn.rtn013
	where rccmcd = :g_s_company and rcplant = :a_plant and rcdvsn = :a_div and rcitno = :a_itno and trim(rcline1) || rcline2 = :a_line
using sqlca;

if f_spacechk(l_s_rcgrde) = -1 then
	select count(*) into :l_n_sql_count1 from pbrtn.rtn013
		where rccmcd = :g_s_company and rcplant = :a_plant and rcdvsn = :a_div and rcitno = :a_itno and rcgrde = 'A'
	using sqlca;
	if l_n_sql_count1 < 1 then
		l_s_rcgrde = 'A'
	else
		l_s_rcgrde = 'B'
	end if
end if
return l_s_rcgrde
end function

public function integer wf_rtn004_6_update (string a_cmcd, string a_plant, string a_dvsn, string a_itno, string a_line1, string a_line2, string a_opno);string l_s_rdnvmo,l_s_rdmcno,l_s_rdterm,l_s_rdremk,l_s_rdedfm
dec    l_s_rdmctm,l_s_rdlbtm

declare rtn004_cur cursor for 
  select rdnvmo,rdmcno,rdterm,rdmctm,rdlbtm,rdremk,rdedfm from pbrtn.rtn014
  		where rdcmcd  = :a_cmcd  and rdplant = :a_plant and rddvsn = :a_dvsn and rditno = :a_itno and rdline1 = :a_line1 and
	          rdline2 = :a_line2 and rdopno = :a_opno
  using SQLCA ;

open rtn004_cur ;

do while true
    fetch rtn004_cur into :l_s_rdnvmo,:l_s_rdmcno,:l_s_rdterm,:l_s_rdmctm,:l_s_rdlbtm,:l_s_rdremk,:l_s_rdedfm ;
    if sqlca.sqlcode <> 0 then
		exit
	 end if 
	 if l_s_rdedfm > g_s_date then
		 update pbrtn.rtn016 
			 set rfedto = :g_s_date , rfupdt = :g_s_date , rfflag = 'D' 
		 where  rfcmcd = :g_s_company and rfplant = :a_plant and rfdvsn = :a_dvsn and rfitno = :a_itno and rfline1 = :a_line1 and rfopno = :a_opno and
				  rfline2 = :a_line2 and rfnvmo = :l_s_rdnvmo  and rfmcno = :l_s_rdmcno and rfterm = :l_s_rdterm and
				  rfedto >= :g_s_date 
		 using  sqlca;
	 end if
	 insert into pbrtn.rtn016
	 	(rfcmcd,rfplant,rfdvsn,rfitno,rfline1,rfline2,rfopno,rfnvmo,rfmcno,rfterm,rfedfm,rfmctm,rflbtm,rfremk,rfepno,
		 rfflag,rfedto,rfipad,rfupdt,rfsydt)
	 values
	 	(:a_cmcd,:a_plant,:a_dvsn,:a_itno,:a_line1,:a_line2,:a_opno,:l_s_rdnvmo,:l_s_rdmcno,:l_s_rdterm,:l_s_rdedfm,:l_s_rdmctm,
		 :l_s_rdlbtm,:l_s_rdremk,:g_s_empno,'D',:g_s_date,:g_s_ipaddr,:g_s_date,:g_s_date)
	 using sqlca;
loop

return 0


end function

public function integer wf_add_items (long ag_parent, integer ag_level, integer ag_rows, treeview ag_this);Integer			l_n_Cnt
TreeViewItem	l_tvi_New

For l_n_Cnt = 1 To ag_Rows
	// TreeView의 Item에 각각의 값을 Setting시킨다.
	
	wf_set_items(ag_Level, l_n_Cnt, l_tvi_New)
	
	// TreeView에 Item을 추가시킨다.
	If ag_this.InsertItemLast(ag_Parent, l_tvi_New) < 1 Then
		Return -1
	End If
Next

Return ag_Rows

end function

public subroutine wf_rtn005_update (string a_cmcd, string a_plant, string a_dvsn, string a_itno, string a_line, string a_opno, string a_date);string l_s_rcline1, l_s_rcline2,l_s_rcedfm,l_s_rcopnm,l_s_rcline3,l_s_rcgrde,l_s_rcmcyn,l_s_rcnvcd,l_s_rcflag,l_s_reedto
int    l_n_rcopsq,l_n_rclbcnt,l_n_sqlcount
dec    l_n_rcbmtm,l_n_rcbltm,l_n_rcbstm,l_n_rcnvmc,l_n_rcnvlb

l_s_rcline1 = mid(a_line,1,len(a_line) - 1)
l_s_rcline2 = mid(a_line,len(a_line),1)
a_date      = f_relativedate(a_date,-1)

//select rcedfm,rcopnm,rcline3,rcgrde,rcmcyn,rcnvcd,rcflag,rcopsq,rclbcnt,rcbmtm,rcbltm,rcbstm,rcnvmc,rcnvlb 
//	into :l_s_rcedfm, :l_s_rcopnm , :l_s_rcline3, :l_s_rcgrde, :l_s_rcmcyn, :l_s_rcnvcd ,:l_s_rcflag,:l_n_rcopsq,
//	     :l_n_rclbcnt, :l_n_rcbltm, :l_n_rcbltm,  :l_n_rcbstm, :l_n_rcnvmc, :l_n_rcnvlb from pbrtn.rtn013
//where rccmcd  = :a_cmcd and rcplant = :a_plant and rcdvsn = :a_dvsn and rcitno = :a_itno and 
//      trim(rcline1) || rcline2 = :a_line and rcopno = :a_opno   
//using sqlca;
//
//select count(*) into:l_n_sqlcount from pbrtn.rtn015
//	where recmcd = :a_cmcd and replant = :a_plant and redvsn = :a_dvsn and reitno = :a_itno and trim(reline1) || reline2 = :a_line and
//	      reopno = :a_opno and reedfm  = :l_s_rcedfm using sqlca;
//		
//if l_n_sqlcount > 0 then
//	update pbrtn.rtn015
//	set  reopnm  = :l_s_rcopnm  , reopsq = :l_n_rcopsq , reline3 = :l_s_rcline3 , remcyn = :l_s_rcmcyn , rebmtm = :l_n_rcbmtm,
//		 rebltm  = :l_n_rcbltm  , rebstm = :l_n_rcbstm , renvcd  = :l_s_rcnvcd  , renvmc = :l_n_rcnvmc , renvlb = :l_n_rcnvlb,
//		 relbcnt = :l_n_rclbcnt , reedto = :a_date     , reflag  = 'C'  , reepno = :g_s_empno  , reipad = :g_s_ipaddr,
//		 reupdt  = :g_s_date
//	where recmcd = :a_cmcd and replant = :a_plant and redvsn = :a_dvsn and reitno = :a_itno and trim(reline1) || reline2 = :a_line and
//	      reopno = :a_opno and reedfm = :l_s_rcedfm 
//	using sqlca;
//else
//	insert into "PBRTN"."RTN005"
//		( recmcd,replant,redvsn,reitno,reline1,reline2,reopno,reedfm,reopnm,reopsq,reline3,regrde,remcyn,rebmtm,rebltm,rebstm,
//	  	  renvcd,renvmc,renvlb,relbcnt,reedto,reflag,reepno,reipad,reupdt,resydt)
//	values
//		( :a_cmcd,:a_plant,:a_dvsn,:a_itno,:l_s_rcline1,:l_s_rcline2,:a_opno,:l_s_rcedfm,:l_s_rcopnm,:l_n_rcopsq,
//		  :l_s_rcline3,:l_s_rcgrde,:l_s_rcmcyn,:l_n_rcbmtm,:l_n_rcbltm,:l_n_rcbstm,:l_s_rcnvcd,:l_n_rcnvmc,:l_n_rcnvlb,
//		  :l_n_rclbcnt,:a_date,'A',:g_s_empno,:g_s_ipaddr,:g_s_date,:g_s_date)
//	using sqlca;
//	
//	l_s_rcedfm = f_relativedate(l_s_rcedfm,-1)
//	
//	select reedfm into:l_s_reedto from pbrtn.rtn005
//	where recmcd = :a_cmcd and replant = :a_plant and redvsn = :a_dvsn and reitno = :a_itno and trim(reline1) || reline2 = :a_line and
//	      reopno = :a_opno and reedfm < :l_s_rcedfm and reedto > :l_s_rcedfm using sqlca;	
//	if f_spacechk(l_s_reedto) <> -1 then
//		update pbrtn.rtn005
//			set reedto = :l_s_rcedfm
//		where recmcd = :a_cmcd and replant = :a_plant and redvsn = :a_dvsn and reitno = :a_itno and trim(reline1) || reline2 = :a_line and
//	     	  reopno = :a_opno and reedfm = :l_s_reedto 
//		using sqlca;
//	end if
//end if
//
//
end subroutine

public subroutine wf_rtn006_update (string a_plant, string a_dvsn, string a_itno, string a_line1, string a_line2, string a_opno, string a_nvmo, string a_mcno, string a_term, decimal a_rrnno, string a_rdedfm);string l_s_rfedfm,l_s_rfedfm1,l_s_rfedfm2,l_s_rfremk,l_s_rfedto
dec    l_n_rfmctm,l_n_rflbtm,l_n_rrnno
int    l_n_sqlcount

l_s_rfedto = f_relativedate(a_rdedfm,-1)

select rdedfm,rdremk,rdmctm,rdlbtm into :l_s_rfedfm,:l_s_rfremk,:l_n_rfmctm,:l_n_rflbtm from pbrtn.rtn014
	  where rrn(pbrtn.rtn014) = :a_rrnno 
using sqlca;

select count(*) into:l_n_sqlcount from pbrtn.rtn016
	where rfcmcd = :g_s_company and rfplant = :a_plant and rfdvsn = :a_dvsn and rfitno = :a_itno and rfline1 = :a_line1 and rfline2 = :a_line2 and 
		  rfopno = :a_opno and rfnvmo = :a_nvmo and rfmcno = :a_mcno and rfterm = :a_term 
 		  and rfedfm = :l_s_rfedfm
using sqlca;

if l_n_sqlcount > 0 then	
	update pbrtn.rtn016 
		 set rfmctm = :l_n_rfmctm,rflbtm = :l_n_rflbtm,rfremk = :l_s_rfremk,rfedto = :l_s_rfedto,
		 	 rfflag = 'C',rfupdt = :g_s_date
	where rfcmcd  = :g_s_company and rfplant = :a_plant and rfdvsn = :a_dvsn and rfitno = :a_itno and rfline1 = :a_line1 and
		  rfline2 = :a_line2   and rfopno = :a_opno and rfnvmo = :a_nvmo   and rfmcno  = :a_mcno    and
		  rfterm  = :a_term and rfedfm = :l_s_rfedfm
	using sqlca;
else
	insert into pbrtn.rtn016
	(rfcmcd,rfplant,rfdvsn,rfitno,rfline1,rfline2,rfopno,rfnvmo,rfmcno,rfterm,rfedfm,rfmctm,rflbtm,rfremk,rfepno,
	 rfflag,rfedto,rfipad,rfupdt,rfsydt )
	values
	(:g_s_company,:a_plant,:a_dvsn, :a_itno, :a_line1,:a_line2,:a_opno,:a_nvmo,:a_mcno,:a_term,:l_s_rfedfm,
	 :l_n_rfmctm,:l_n_rflbtm, :l_s_rfremk,: g_s_empno,'A',:l_s_rfedto,:g_s_ipaddr,:g_s_date,:g_s_date )
	using sqlca;
	
	l_s_rfedfm = f_relativedate(l_s_rfedfm,-1)
	
	select rfedfm into:l_s_rfedfm2 from pbrtn.rtn016
		where rfcmcd = :g_s_company and rfplant = :a_plant and rfdvsn = :a_dvsn and rfitno = :a_itno and rfline1 = :a_line1 and rfline2 = :a_line2 and 
			  rfopno = :a_opno and rfnvmo = :a_nvmo and rfmcno = :a_mcno and rfterm = :a_term and 
			  rfedfm < :l_s_rfedfm and rfedto > :l_s_rfedfm 
	using sqlca;
	
	if f_spacechk(l_s_rfedfm2) <> -1 then
		update pbrtn.rtn016 
			set rfedto = :l_s_rfedfm,rfupdt = :g_s_date
		where rfcmcd  = :g_s_company and rfplant = :a_plant and rfdvsn = :a_dvsn and rfitno = :a_itno and rfline1 = :a_line1 and
			  rfline2 = :a_line2   and rfopno = :a_opno and rfnvmo = :a_nvmo   and rfmcno  = :a_mcno    and
			  rfterm  = :a_term and rfedfm = :l_s_rfedfm2
		using sqlca;
	end if
end if
end subroutine

public subroutine wf_itempopulate (long ag_handle, treeview ag_tvcurrent);Integer			l_n_Level, l_n_rows
string			l_s_plant,l_s_div,l_s_pdcd,l_s_rcitno
TreeViewItem	l_tvi_Current,l_tvi_parent
Treeview			l_tv_current
long l_s_handle1

SetPointer(HourGlass!)

// Determine the level
ag_tvcurrent.GetItem(ag_handle, l_tvi_Current)
l_n_Level = l_tvi_Current.Level

string l_s_parm
l_s_parm    = uo_1.uf_Return()
l_s_plant   = mid(l_s_parm,1,1)
l_s_div     = mid(l_s_parm,2,1)
l_s_pdcd    = mid(l_s_parm,3,2)
l_s_pdcd = l_s_pdcd + '%'

if l_n_level = 1 and i_s_chkbox = '1' then
	l_n_rows = ids_data2.retrieve(l_s_plant,l_s_div,trim(l_tvi_current.data),l_s_pdcd)
elseif l_n_level = 1 and i_s_chkbox = '2' then
	l_n_rows = ids_data3.retrieve(l_s_plant,l_s_div,trim(l_tvi_current.data),l_s_pdcd)
elseif l_n_level = 2 and i_s_chkbox = '2' then
	l_n_rows = ids_data5.retrieve(l_s_plant,l_s_div,trim(l_tvi_current.data),l_s_pdcd)
elseif l_n_level = 2 and i_s_chkbox = '1' then
	l_s_handle1 = ag_tvcurrent.finditem(parenttreeitem!, ag_handle)
	ag_tvcurrent.GetItem(l_s_handle1, l_tvi_parent)
	l_s_rcitno = trim(l_tvi_parent.data)
	l_n_rows = ids_data6.retrieve(l_s_plant,l_s_div,l_s_rcitno,trim(l_tvi_current.data),l_s_pdcd)
end if

wf_add_items(ag_handle,l_n_level,l_n_rows,ag_tvcurrent)
end subroutine

public subroutine wf_set_items (integer ag_level, integer ag_row, readonly treeviewitem ag_tvinew);string  l_s_plant,l_s_div,l_s_pdcd,l_s_rcline,l_s_rcitno
integer l_n_sqlcount

string l_s_parm
l_s_parm    = uo_1.uf_Return()
l_s_plant   = mid(l_s_parm,1,1)
l_s_div     = mid(l_s_parm,2,1)
l_s_pdcd    = mid(l_s_parm,3,2)

if ag_level = 1 then
	if i_s_chkbox = '1' then
		ag_tvinew.data  = trim(ids_data2.object.rcline1[ag_row])
		ag_tvinew.label = string(ids_data2.object.rcline1[ag_row],"@@@@@@@") 
		ag_tvinew.pictureindex = 3
		ag_tvinew.selectedpictureindex = 4
		l_s_rcline = ag_tvinew.data
		l_s_rcitno = trim(ids_data2.object.rcitno[ag_row]) 
		select count(*) into: l_n_sqlcount from pbrtn.rtn013
	       where rccmcd = :g_s_company and rcplant = :l_s_plant and rcdvsn = :l_s_div and rcline1 = :l_s_rcline and rcitno = :l_s_rcitno using sqlca;
	elseif i_s_chkbox = '2' then
		ag_tvinew.data  = trim(ids_data3.object.rbline1[ag_row]) +    ids_data3.object.rbline2[ag_row]
		ag_tvinew.label = string(ids_data3.object.rbline1[ag_row],"@@@@@@@") + '-' + ids_data3.object.rbline2[ag_row]
		ag_tvinew.pictureindex = 3
		ag_tvinew.selectedpictureindex = 4
		l_s_rcline = trim(ag_tvinew.data)
		select count(*) into: l_n_sqlcount from pbrtn.rtn013 
	       where rccmcd = :g_s_company and rcplant = :l_s_plant and rcdvsn = :l_s_div and trim(rcline1) || rcline2 = :l_s_rcline 
		using sqlca;
	end if
	if l_n_sqlcount > 0 then 
		ag_tvinew.children = true
	else
		ag_tvinew.children = false
	end if
end if
if ag_level = 2 and i_s_chkbox = '2' then
		ag_tvinew.data  = ids_data5.object.rcitno[ag_row]
		ag_tvinew.label = ids_data5.object.rcitno[ag_row]
		ag_tvinew.pictureindex = 3
		ag_tvinew.selectedpictureindex = 4
		ag_tvinew.children = false
elseif ag_level = 2 and i_s_chkbox = '1' then
		ag_tvinew.data  = trim(ids_data6.object.rcline1[ag_row]) + ids_data6.object.rcline2[ag_row]
		ag_tvinew.label = string(ids_data6.object.rcline1[ag_row],"@@@@@@@")  + '-' + ids_data6.object.rcline2[ag_row]
		ag_tvinew.pictureindex = 3
		ag_tvinew.selectedpictureindex = 4
		ag_tvinew.children = false
end if



end subroutine

protected function string wf_chk_error1 (decimal l_n_rbopsq, string l_s_rbopno, string l_s_rbedfm, string l_s_rbopnm, string l_s_rbline3, decimal l_d_rbbmtm, decimal l_d_rbbltm, decimal l_d_rbbstm, decimal l_n_rblbcnt, string l_s_rbplant, string l_s_rbdvsn, string l_s_rbline, string l_s_rbitno);string l_s_error, l_s_wkrbedfm ,l_s_string,l_s_rcedfm
integer l_n_sqlcount

l_s_error = space(13)

if i_s_selected = 'A' then
	//신규입력일때  품번체크
	select count(*) into:l_n_sqlcount from pbinv.inv101
			where xplant = :l_s_rbplant and div = :l_s_rbdvsn and itno = :l_s_rbitno using sqlca;
	if l_n_sqlcount = 0 then
		l_s_error = '1'
	else
		//BOM등록품번여부
		select count(*) into:l_n_sqlcount from pbpdm.bom001
			where plant = :l_s_rbplant and pdvsn = :l_s_rbdvsn and ppitn = :l_s_rbitno and 
					( (PEDTE = ' ' ) OR  
							( PEDTE <> ' ' AND PEDTE >= :l_s_rbedfm )) using sqlca;
		if l_n_sqlcount = 0 then		
			l_s_error = '1'
		else
			if mid(i_s_protect,1,1) = "1" then
				l_s_error = '2'
			else
				l_s_error = ' ' 
			end if
		end if
	end if
	// 대체라인 등록여부	
	select count(*) into:l_n_sqlcount from pbrtn.rtn012
			 where rbcmcd = :g_s_company and rbplant = :l_s_rbplant and rbdvsn = :l_s_rbdvsn and trim(rbline1) || rbline2 = :l_s_rbline
			 using sqlca;
	if l_n_sqlcount = 0 then
		if mid(i_s_protect,2,1) = '1' then
			l_s_error += '2'
		else
			l_s_error += '1'
		end if
		if mid(i_s_protect,3,1) = '1' then
			l_s_error += '2'
		else
			l_s_error += '1'
		end if
	else
		if mid(i_s_protect,2,1) = '1' then
			l_s_error += '2'
		else
			l_s_error += ' '
		end if
		if mid(i_s_protect,3,1) = '1' then
			l_s_error += '2'
		else
			l_s_error += ' '
		end if
	end if
else
	if mid(i_s_protect,2,1) = '1' then
		l_s_error = ' 2'
	else
		l_s_error = '  '
	end if
	if mid(i_s_protect,3,1) = '1' then
		l_s_error += '2'
	else
		l_s_error += ' '
	end if
end if
// 공정순서가 NULL이거나 0이면 에러
if isnull(l_n_rbopsq ) = true or l_n_rbopsq = 0 then
	l_s_error += '1'
else
 	l_s_error += ' '
end if 
// 공정번호가 빈문자열이거나 NULL이면 에러
if f_spacechk(l_s_rbopno) = -1 then
	l_s_error = l_s_error + '1'
elseif i_s_selected = 'A' then
		// 신규입력일때 품번공정정보에 등록되어 있는경우에 에러
		select count(*) into:l_n_sqlcount from pbrtn.rtn013
			where rccmcd = :g_s_company and rcplant = :l_s_rbplant and rcdvsn = :l_s_rbdvsn and rcline1 || rcline2 = :l_s_rbline and
			      rcitno = :l_s_rbitno  and rcopno  = :l_s_rbopno 
		using sqlca;
		if l_n_sqlcount > 0 then
			l_s_error = l_s_error + '1'
		else
			l_s_error = l_s_error + ' '
		end if
else
	l_s_error = l_s_error + ' '
end if

// 적용일자가 빈문자이거나 NULL이면 에러
if f_spacechk(l_s_rbedfm) = -1 then
	l_s_rbedfm = f_relativedate(g_s_date,1)
end if

l_s_wkrbedfm = f_dateedit(l_s_rbedfm)
l_s_rcedfm   = ''

// 공정명이 빈문자이거나 NULL이면 에러
if f_spacechk(l_s_rbopnm) = -1 then
	l_s_error = l_s_error + '1'
else
	l_s_error = l_s_error + ' '
end if

// 조코드가 4자리가 아니거나 등록된 코드가 아니면 에러
if len(l_s_rbline3) = 4 then
	l_s_string = f_get_deptnm(l_s_rbline3,'5')
elseif len(l_s_rbline3) = 5 then
//	l_s_string = f_get_purvndnm(l_s_rbline3)
end if

if f_spacechk(l_s_string) = -1 then
   l_s_error = l_s_error + '1'
else
	l_s_error = l_s_error + ' '
end if

// 기계작업시간이 NULL이면 0
if isnull(l_d_rbbmtm ) = true then
 l_d_rbbmtm = 0 
end if	

// 수작업시간이 NULL이면 0
if isnull(l_d_rbbltm ) = true then
 l_d_rbbltm = 0 
end if

// 기계작업시간과 수작업시간 둘다 0이면 오류
//if l_d_rbbmtm = 0 and l_d_rbbltm = 0 then
//	l_s_error = l_s_error + '1 '
//else
	// 0보다 적으면 오류
 	if l_d_rbbmtm < 0 then
	 	l_s_error = l_s_error + '1'
	else
		 l_s_error = l_s_error + ' '
 	end if
 	if l_d_rbbltm < 0 then
	   l_s_error = l_s_error + '1'
	else
	   l_s_error = l_s_error + ' '
 	end if
//end if

// 기본작업시간이 NULL이거나 0이면 오류
//if isnull(l_d_rbbstm ) = true or l_d_rbbstm = 0 then
//	l_s_error = l_s_error + '1'
//else
//	l_s_error = l_s_error + ' '
//end if

// 인원이 음수이면 오류
if isnull(l_n_rblbcnt) = false and l_n_rblbcnt <> 0 then
 	if l_n_rblbcnt < 0 then
		 l_s_error = l_s_error + '1'
	else
		 l_s_error = l_s_error + ' '
 	end if
else
	l_s_error = l_s_error + ' '
end if

return l_s_error

end function

on w_rtn013u.create
int iCurrent
call super::create
this.tv_1=create tv_1
this.dw_1=create dw_1
this.sle_input=create sle_input
this.dw_detail=create dw_detail
this.pb_find_item=create pb_find_item
this.rb_1=create rb_1
this.rb_2=create rb_2
this.uo_1=create uo_1
this.cb_copy=create cb_copy
this.cb_delete=create cb_delete
this.cb_rtn013_template=create cb_rtn013_template
this.cb_rtn014_template=create cb_rtn014_template
this.dw_down=create dw_down
this.cb_allcopy=create cb_allcopy
this.cb_deptchange=create cb_deptchange
this.gb_framemove=create gb_framemove
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.sle_input
this.Control[iCurrent+4]=this.dw_detail
this.Control[iCurrent+5]=this.pb_find_item
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.rb_2
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.cb_copy
this.Control[iCurrent+10]=this.cb_delete
this.Control[iCurrent+11]=this.cb_rtn013_template
this.Control[iCurrent+12]=this.cb_rtn014_template
this.Control[iCurrent+13]=this.dw_down
this.Control[iCurrent+14]=this.cb_allcopy
this.Control[iCurrent+15]=this.cb_deptchange
this.Control[iCurrent+16]=this.gb_framemove
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.gb_2
end on

on w_rtn013u.destroy
call super::destroy
destroy(this.tv_1)
destroy(this.dw_1)
destroy(this.sle_input)
destroy(this.dw_detail)
destroy(this.pb_find_item)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.uo_1)
destroy(this.cb_copy)
destroy(this.cb_delete)
destroy(this.cb_rtn013_template)
destroy(this.cb_rtn014_template)
destroy(this.dw_down)
destroy(this.cb_allcopy)
destroy(this.cb_deptchange)
destroy(this.gb_framemove)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;//f_window_resize(this)

l_s_populate_no = 0
setpointer(HourGlass!)
pb_find_item.visible = false
pb_find_item.enabled = false	
cb_copy.enabled      = false
cb_delete.enabled      = false
cb_allcopy.enabled      = false
//uo_1.dw_1.object.st_2.visible    = false
//uo_1.dw_1.object.div.visible     = false
//uo_1.dw_1.object.st_2.visible    = false
//uo_1.dw_1.object.pdcd.visible    = false

ids_data1 = create Datastore
// 대체 품번 DB(RTN002)와 품목 Balance DB(INVDAA)DB 존재하는 전체 품번 DISPLAY
ids_data1.dataobject = "d_rtn01_dw_routing_item_treeview"
ids_data1.settransobject(sqlca)
ids_data2 = create Datastore
// 특정 품번의 대체 Line1 Display
ids_data2.dataobject = "d_rtn01_dw_daechae_line_treeview"
ids_data2.settransobject(sqlca)
ids_data3 = create Datastore
// 대체 Line1 하위에 존재하는 Line2 Display
ids_data3.dataobject = "d_rtn01_dw_daechae_line1_treeview"
ids_data3.settransobject(sqlca)
ids_data4 = create Datastore
// 공장별 전체 대체 Line1 Display
ids_data4.dataobject = "d_rtn01_dw_line_treeview"
ids_data4.settransobject(sqlca)
ids_data5 = create Datastore
// 특정 대체 Line1 + Line2 의 하위 품번 Display Treeview
ids_data5.dataobject = "d_rtn01_dw_item_treeview"
ids_data5.settransobject(sqlca)
ids_data6 = create Datastore
// 특정 품번의 대체 Line1 + 2 Display
ids_data6.dataobject = "d_rtn01_dw_daechae_line2_treeview"
ids_data6.settransobject(sqlca)

dw_1.settransobject(sqlca)
dw_detail.settransobject(sqlca)

i_b_retrieve = true
i_b_insert = false
i_b_save = false
i_b_delete = false
i_b_dretrieve = false
i_b_dprint = false
i_b_dchar = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	              i_b_dprint,   i_b_dchar)


end event

event close;destroy ids_data1
destroy ids_data2
destroy ids_data3 
destroy ids_data4
destroy ids_data5
destroy ids_data6 
close(w_rtn013u_res03)
close(w_rtn013u_res01)


end event

event ue_retrieve;string       l_s_plant,l_s_div,l_s_pdcd,l_s_sleinput,ls_chkpdcd
integer      k, l_n_rows, l_n_root, l_n_sub_rows, net , l_n_count
treeviewitem l_tvi_root
long         l_n_tvi

cb_copy.enabled = false
cb_delete.enabled = false

if i_s_level = "5" then
	dw_1.accepttext()
	if dw_1.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if

dw_1.reset()

l_s_populate_no = 0

do until tv_1.FindItem(roottreeitem!, 0) = -1 
    l_n_tvi = tv_1.FindItem(roottreeitem!, 0)
    tv_1.DeleteItem(l_n_tvi)
loop
i_s_selected = ""
uo_status.st_message.text = ""
setpointer(HourGlass!)

string l_s_parm
l_s_parm    = uo_1.uf_Return()
l_s_plant   = mid(l_s_parm,1,1)
l_s_div     = mid(l_s_parm,2,1)
l_s_pdcd    = trim(mid(l_s_parm,3,2))

if f_spacechk(l_s_plant) = -1 or f_spacechk(l_s_div) = -1 or f_spacechk(l_s_pdcd) = -1 then
	uo_status.st_message.text = "지역,공장은 필수 입력사항입니다."
	return 0
end if

ids_data1.reset()
ids_data2.reset()
ids_data3.reset()
ids_data4.reset()
ids_data5.reset()
ids_data6.reset()

l_s_sleinput = trim(sle_input.text)
if f_spacechk(l_s_sleinput) <> -1 and rb_2.checked = true then
	select substring(pdcd,1,2) into :ls_chkpdcd
	from pbinv.inv101
	where comltd = '01' and xplant = :l_s_plant and
			div = :l_s_div and itno = :l_s_sleinput
	using sqlca;
	
	if l_s_pdcd <> ls_chkpdcd then
		select prname into :ls_chkpdcd
		from pbcommon.dac007 where prprcd = :ls_chkpdcd
		using sqlca;
		
		uo_status.st_message.text = "제품군에 해당하는 품번이 아닙니다. => " + ls_chkpdcd
		return 0
	end if
end if
l_s_pdcd = l_s_pdcd + '%'

if rb_2.checked = true then
	i_s_chkbox = '1'
	if f_spacechk(l_s_sleinput) = -1 then
		l_n_rows = ids_data1.retrieve(l_s_plant,l_s_div,l_s_pdcd)
		if l_n_rows = 0 then
			uo_status.st_message.text = f_message("I020")
			return 0
		end if
		for k = 1 to l_n_rows
			l_tvi_root.label = ids_data1.object.rtn011_raitno[k]
			l_tvi_root.data  = trim(ids_data1.object.rtn011_raitno[k])
			l_tvi_root.pictureindex = 3	
			l_tvi_root.selectedpictureindex = 4
			if ids_data2.retrieve(l_s_plant,l_s_div,l_tvi_root.data,l_s_pdcd) > 0 then
				l_tvi_root.children = true
			else
				l_tvi_root.children = false
			end if
			l_n_root = tv_1.insertitemlast(0,l_tvi_root)
			l_s_populate = 0
			tv_1.expanditem(l_n_root)
		next
	else
		l_s_sleinput = f_rtn01_conv_itno(l_s_plant,l_s_div,l_s_sleinput)
		if trim(sle_input.text) <> trim(l_s_sleinput) then
			messagebox("확인", trim(sle_input.text) + "  품번은 유사 품번입니다. 대표품번 " + trim(l_s_sleinput) + &
			                   "의 Routing 정보가 조회 됩니다 " )
									 
			select substring(pdcd,1,2) into :ls_chkpdcd
			from pbinv.inv101
			where comltd = '01' and xplant = :l_s_plant and
					div = :l_s_div and itno = :l_s_sleinput
			using sqlca;
			
			l_s_pdcd = ls_chkpdcd + '%'
		end if
		if ids_data2.retrieve(l_s_plant,l_s_div,l_s_sleinput,l_s_pdcd) < 1 then
			uo_status.st_message.text = f_message("I020")
			return 0
		end if
		l_tvi_root.label = l_s_sleinput
		l_tvi_root.data  = l_s_sleinput
		l_tvi_root.pictureindex = 3	
		l_tvi_root.selectedpictureindex = 4
		if ids_data2.retrieve(l_s_plant,l_s_div,l_s_sleinput,l_s_pdcd) > 0 then
			l_tvi_root.children = true
		else
			l_tvi_root.children = false
		end if
		l_n_root = tv_1.insertitemlast(0,l_tvi_root)
		l_s_populate = 0
		tv_1.expanditem(l_n_root)
	end if
else
	i_s_chkbox = '2'
//	st_input.text = ''
	if f_spacechk(l_s_sleinput) = -1 then
		l_n_rows = ids_data4.retrieve(l_s_plant,l_s_div)
		if l_n_rows = 0 then
			uo_status.st_message.text = f_message("I020")
			return 
		end if
		for k = 1 to l_n_rows
			l_tvi_root.label = ids_data4.object.rbline1[k]
			l_tvi_root.data  = ids_data4.object.rbline1[k]
			l_tvi_root.pictureindex = 3	
			l_tvi_root.selectedpictureindex = 4
			l_s_sleinput = l_tvi_root.data
			select count(*) into :l_n_count from pbrtn.rtn013
				where rccmcd = '01' and rcplant = :l_s_plant and rcdvsn = :l_s_div and rcline1 = :l_s_sleinput
			using sqlca;
			if l_n_count < 1 then 
				l_tvi_root.children = false
				l_tvi_root.pictureindex = 2
			else
				l_tvi_root.children = true
			end if

			l_n_root = tv_1.insertitemlast(0,l_tvi_root)
			l_s_populate = 0
			tv_1.expanditem(l_n_root)
		next
	else
		select count(*) into :l_n_count from pbrtn.rtn012
			where rbcmcd = '01' and rbplant = :l_s_plant and rbdvsn = :l_s_div and rbline1 = :l_s_sleinput 
		using sqlca;
		if l_n_count < 1 then 
			uo_status.st_message.text = f_message("I020")
			return
		end if
		l_tvi_root.label = l_s_sleinput
		l_tvi_root.data  = l_s_sleinput
		l_tvi_root.pictureindex = 3	
		l_tvi_root.selectedpictureindex = 4
		
		select count(*) into :l_n_count from pbrtn.rtn013
			where rccmcd = '01' and rcplant = :l_s_plant and rcdvsn = :l_s_div and rcline1 = :l_s_sleinput 
		using sqlca;
		if l_n_count < 1 then 
			l_tvi_root.children = false
			l_tvi_root.pictureindex = 2
		else
			l_tvi_root.children = true
		end if
		l_n_root = tv_1.insertitemlast(0,l_tvi_root)
		l_s_populate = 0
		tv_1.expanditem(l_n_root)
	end if
end if
uo_status.st_message.text = f_message("I010")
i_s_selected = "I"
dw_detail.object.b_jubu.visible = false
// dw_detail.object.b_jubu.enabled = false
i_b_retrieve = true
i_b_insert = true
i_b_save = false
i_b_delete = true
i_b_dretrieve = false
i_b_dprint = false
i_b_dchar = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	              i_b_dprint,   i_b_dchar)
return 0
end event

event ue_insert;string l_s_plant,l_s_div,l_s_pdcd,l_s_itno,l_s_rbline2, l_s_itno1, l_s_itno2,l_s_sleline1,l_s_sleline2,l_s_sleitno
treeviewitem l_tvi_item	, l_tvi_item1 , l_tvi_item2
integer l_n_rows, i, k, net
long l_s_rowcount, l_s_handle, l_s_handle1, l_s_handle2

cb_copy.enabled = false

if i_s_level = "5" then
	dw_detail.accepttext()
	if dw_detail.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if
uo_status.st_message.text = ""

dw_detail.reset()

string l_s_parm
l_s_parm    = uo_1.uf_Return()
l_s_plant   = mid(l_s_parm,1,1)
l_s_div     = mid(l_s_parm,2,1)
l_s_pdcd    = mid(l_s_parm,3,2)

l_n_rows = dw_1.getselectedrow(0)

if l_n_rows < 1 then
	l_s_handle = tv_1.finditem(currenttreeitem!,0)
	tv_1.getitem(l_s_handle, l_tvi_item)
	l_s_itno = l_tvi_item.label
	if l_tvi_item.level > 1 then
		l_s_handle1 = tv_1.finditem(parenttreeitem!,l_s_handle)
		tv_1.getitem(l_s_handle1, l_tvi_item1)
		l_s_itno1 = l_tvi_item1.label
		if l_tvi_item.level > 2 then
			l_s_handle2 = tv_1.finditem(parenttreeitem!,l_s_handle1)
			tv_1.getitem(l_s_handle2, l_tvi_item2)
			l_s_itno2 = trim(l_tvi_item2.label)
			if i_s_chkbox = '1' then
				l_s_sleline1 = mid(l_s_itno,1,7)
				l_s_sleline2 = mid(l_s_itno,9,1)
				l_s_sleitno  = l_s_itno2
			elseif i_s_chkbox = '2' then
				l_s_sleline1 = mid(l_s_itno1,1,7)
				l_s_sleline2 = mid(l_s_itno1,9,1)
				l_s_sleitno  = l_s_itno
			end if
		else
			if i_s_chkbox = '1' then
				l_s_sleline1 = mid(l_s_itno,1,7)
				l_s_sleitno  = l_s_itno1
			elseif i_s_chkbox = '2' then
				l_s_sleline1 = mid(l_s_itno,1,7)
				l_s_sleline2 = mid(l_s_itno,9,1)
			end if
		end if
	else
		if i_s_chkbox = '1' then
			l_s_sleitno = l_s_itno
		elseif i_s_chkbox = '2' then
			l_s_sleline1 = mid(l_s_itno,1,7)
			l_s_sleline2 = mid(l_s_itno,9,1)
		end if
	end if
else
	l_s_sleitno  = dw_1.object.rcitno[l_n_rows]
	l_s_sleline1 = string(dw_1.object.rcline1[l_n_rows],'@@@@@@@')
	l_s_sleline2 = dw_1.object.rcline2[l_n_rows]
end if

dw_detail.insertrow(0) 
dw_detail.object.rcplant[1] = l_s_plant
dw_detail.object.rcdvsn[1]  = l_s_div
dw_detail.object.rcitno[1]  = l_s_sleitno
dw_detail.object.rcline1[1] = l_s_sleline1
dw_detail.object.rcline2[1] = l_s_sleline2
dw_detail.object.rcedfm[1]  = ''
wf_rgbclear('A')
dw_detail.setfocus()
dw_detail.setcolumn('rcopno')

i_s_selected = "A"
uo_status.st_message.text = f_message("A070")
i_b_retrieve  = true
i_b_insert    = false
i_b_save      = true
i_b_delete    = false
i_b_dretrieve = false
i_b_dprint    = false
i_b_dchar     = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	           i_b_dprint,   i_b_dchar)
return 0
end event

event ue_save;string l_s_rcplant, l_s_rcdvsn, l_s_rcitno, l_s_rcline, l_s_rcopno, l_s_rcedfm, l_s_rcopnm, l_s_rcline3, &
       l_s_rcmcyn , l_s_rcnvcd, l_s_rcepno, l_s_rcupdt, l_s_rcsydt, l_s_pdcd,l_s_error, l_s_column, &
	   l_s_itno, l_s_itno1, l_s_flag, l_s_raline,l_s_rcgrde,l_s_array[],l_s_parm,l_s_rcline1,l_s_rcline2
dec    l_d_rcbmtm, l_d_rcbltm, l_d_rcbstm, l_d_rcnvmc, l_d_rcnvlb, l_n_rcopsq, l_n_rclbcnt,l_n_sum_rdmctm,l_n_sum_rdlbtm
int    l_n_rowcount, i, l_n_sqlcount, l_n_modifycount, net, net1
string ls_message, ls_chtime
window l_s_wsheet

setpointer(hourglass!)

cb_copy.enabled = false
dw_detail.accepttext()

string l_s_parm1

l_s_parm1     = uo_1.uf_Return()
l_s_rcplant   = mid(l_s_parm1,1,1)
l_s_rcdvsn    = mid(l_s_parm1,2,1)
l_s_pdcd      = mid(l_s_parm1,3,2)

l_s_rcitno  = dw_detail.getitemstring(1,"rcitno")
l_s_rcline  = trim(dw_detail.getitemstring(1,"rcline1")) + dw_detail.getitemstring(1,"rcline2")
l_s_rcline1 = trim(dw_detail.getitemstring(1,"rcline1"))
l_s_rcline2 = dw_detail.getitemstring(1,"rcline2")
l_s_rcopno  = upper(dw_detail.getitemstring(1,"rcopno"))
l_s_rcedfm  = dw_detail.getitemstring(1,"rcedfm")
l_s_rcopnm  = upper(dw_detail.getitemstring(1,"rcopnm"))
l_n_rcopsq  = dw_detail.getitemnumber(1,"rcopsq")
l_s_rcline3 = upper(trim((dw_detail.getitemstring(1,"rcline3"))))
l_s_rcmcyn  = dw_detail.getitemstring(1,"rcmcyn")
l_d_rcbmtm  = dw_detail.getitemnumber(1,"rcbmtm")
l_d_rcbltm  = dw_detail.getitemnumber(1,"rcbltm")
l_d_rcbstm  = dw_detail.getitemnumber(1,"rcbstm")
l_s_rcnvcd  = dw_detail.getitemstring(1,"rcnvcd")
l_n_rclbcnt = dw_detail.getitemnumber(1,"rclbcnt")
l_s_rcepno  = g_s_empno
l_s_rcupdt  = g_s_date
l_s_rcsydt  = dw_detail.getitemstring(1,"rcsydt")

l_s_error   = wf_chk_error1(l_n_rcopsq,l_s_rcopno,l_s_rcedfm,l_s_rcopnm,l_s_rcline3,l_d_rcbmtm, &
 						    l_d_rcbltm,l_d_rcbstm,l_n_rclbcnt,l_s_rcplant,l_s_rcdvsn, l_s_rcline,l_s_rcitno)

dw_detail.object.cp_chk[1] = l_s_error
wf_rgbset("rcitno" ,1,1,dw_detail)
wf_rgbset("rcline1" ,2,1,dw_detail)
wf_rgbset("rcline2" ,3,1,dw_detail)
wf_rgbset("rcopsq" ,4,1,dw_detail)
wf_rgbset("rcopno" ,5,1,dw_detail)
wf_rgbset("rcedfm" ,6,1,dw_detail)
wf_rgbset("rcopnm" ,7,1,dw_detail)
wf_rgbset("rcline3",8,1,dw_detail)
wf_rgbset("rcbmtm" ,9,1,dw_detail)
wf_rgbset("rcbltm" ,10,1,dw_detail)
wf_rgbset("rcbstm", 11,1,dw_detail)
wf_rgbset("rclbcnt",12,2,dw_detail)
dw_1.setredraw(false)

l_s_column = ''
l_s_error = ''
l_s_error = dw_detail.getitemstring(1,"cp_chk")

if f_spacechk(l_s_error) = 0 then
	if mid(l_s_error,1,1) = "1" then
		if f_spacechk(l_s_column) = -1 then
			l_s_column = "rcitno"
		end if
	elseif mid(l_s_error,2,1) = "1" then
		   if f_spacechk(l_s_column) = -1 then
			   l_s_column = "rcline1"
		   end if	
	elseif mid(l_s_error,3,1) = "1" then
		   if f_spacechk(l_s_column) = -1 then
			   l_s_column = "rcline2"
		   end if		
	elseif mid(l_s_error,4,1) = "1" then
		   if f_spacechk(l_s_column) = -1 then
			   l_s_column = "rcopsq"
		   end if
	elseif mid(l_s_error,5,1) = "1" then
			if f_spacechk(l_s_column) = -1 then
				l_s_column = "rcopno"
			end if
	elseif mid(l_s_error,6,1) = "1" then
			if f_spacechk(l_s_column) = -1 then
				l_s_column = "rcedfm"
			end if
	elseif mid(l_s_error,7,1) = "1" then
			if f_spacechk(l_s_column) = -1 then
				l_s_column = "rcopnm"
			end if
	elseif mid(l_s_error,8,1) = "1" then
			if f_spacechk(l_s_column) = -1 then
				l_s_column = "rcline3"
			end if
	elseif mid(l_s_error,9,1) = "1" then
			if f_spacechk(l_s_column) = -1 then
				l_s_column = "rcbmtm"
			end if
	elseif mid(l_s_error,10,1) = "1" then
			if f_spacechk(l_s_column) = -1 then
				l_s_column = "rcbltm"
			end if
	elseif mid(l_s_error,11,1) = "1" then
			if f_spacechk(l_s_column) = -1 then
				l_s_column = "rcbstm"
			end if
	elseif mid(l_s_error,12,1) = "1" then
			if f_spacechk(l_s_column) = -1 then
				l_s_column = "rclbcnt"
			end if
	end if
end if

dw_1.setredraw(true)

if len(l_s_column) > 0 then
	dw_detail.setfocus()
	dw_detail.setcolumn(l_s_column)
	uo_status.st_message.text = f_message("E010")
	i_n_erreturn = -1
	return 
end if

//wf_share_update()

//// 장비 유뮤 update
select count(*) into :l_n_sqlcount from pbrtn.rtn017
where rgcmcd = '01' and rgplant = :l_s_rcplant and rgdvsn = :l_s_rcdvsn and rgitno = :l_s_rcitno and 
		rgline1 = :l_s_rcline1 and rgline2 = :l_s_rcline2 and rgopno = :l_s_rcopno using sqlca;
if l_n_sqlcount > 0 then
	l_s_rcmcyn = 'Y'
else
	l_s_rcmcyn = 'N'
end if

if isnull(l_d_rcbmtm)  = true then l_d_rcbmtm  = 0 
if isnull(l_d_rcbltm)  = true then l_d_rcbltm  = 0 
if isnull(l_d_rcbstm)  = true then l_d_rcbstm  = 0 
if isnull(l_d_rcnvmc)  = true then l_d_rcnvmc  = 0 
if isnull(l_d_rcnvlb)  = true then l_d_rcnvlb  = 0 
if isnull(l_n_rcopsq)  = true then l_n_rcopsq  = 0 
if isnull(l_n_rclbcnt) = true then l_n_rclbcnt = 0 

//// 부대작업 유뮤 update
select sum(rdmctm), sum(rdlbtm) into : l_n_sum_rdmctm, : l_n_sum_rdlbtm from pbrtn.rtn014
		 where rdcmcd = :g_s_company and rddvsn = :l_s_rcdvsn and rdplant = :l_s_rcplant and rditno = :l_s_rcitno 
		   and rdline1 = :l_s_rcline1 and rdline2 = :l_s_rcline2 and
			    rdopno = :l_s_rcopno and rdflag <> 'D' 
using sqlca;

dw_detail.object.rcnvmc[1] = l_n_sum_rdmctm
dw_detail.object.rcnvlb[1] = l_n_sum_rdlbtm
l_d_rcnvmc  = dw_detail.getitemnumber(1,"rcnvmc")
l_d_rcnvlb  = dw_detail.getitemnumber(1,"rcnvlb")
if isnull(l_d_rcnvmc) then
	l_d_rcnvmc = 0
end if
if isnull(l_d_rcnvlb) then
	l_d_rcnvlb = 0
end if

if l_d_rcnvmc + l_d_rcnvlb = 0 then
	 l_s_rcnvcd = 'N'
else
	 l_s_rcnvcd = 'Y'
end if

if f_spacechk(l_s_rcsydt) = -1 then
	 l_s_rcsydt = g_s_date 
end if

ls_chtime = f_get_systemdate(sqlca)

SQLCA.AUTOCOMMIT = FALSE

select count(*) into :l_n_sqlcount from pbrtn.rtn013
where rccmcd = '01' and rcplant = :l_s_rcplant and rcdvsn = :l_s_rcdvsn and 
	rcitno = :l_s_rcitno and trim(rcline1) || rcline2 = :l_s_rcline and rcopno = :l_s_rcopno 
using sqlca;

if l_n_sqlcount > 0 then
	l_s_flag = 'R'
	
	if dw_detail.getitemstring(1,"rcinchk") = 'Y' and dw_detail.getitemstring(1,"rcdlchk") = 'N' then
		ls_message = "결재진행중이므로 수정할수 없습니다."
		goto Rollback_
	end if
	
	update pbrtn.rtn013
	set rcopnm  = :l_s_rcopnm , rcopsq = :l_n_rcopsq , rcline3 = :l_s_rcline3 ,
		 rcmcyn = :l_s_rcmcyn , rcbmtm = :l_d_rcbmtm , rcbltm  = :l_d_rcbltm  , rcbstm = :l_d_rcbstm,
		 rcnvcd = :l_s_rcnvcd , rcnvmc = :l_d_rcnvmc , rcnvlb  = :l_d_rcnvlb  , rclbcnt = :l_n_rclbcnt,
		 rcepno = :l_s_rcepno , rcipad = :g_s_ipaddr, rcupdt = :g_s_date, rcflag = :l_s_flag,
		 rcchtime = :ls_chtime, rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
		 rcplemp = '', rcplchk = 'N', rcpltime = '',
		 rcdlemp = '', rcdlchk = 'N', rcdltime = ''
	where rccmcd = '01' and rcplant = :l_s_rcplant and rcdvsn = :l_s_rcdvsn and 
			rcitno = :l_s_rcitno and rcline1 = :l_s_rcline1 and  rcline2 = :l_s_rcline2 and 
			rcopno = :l_s_rcopno 
	using sqlca;
			
	if sqlca.sqlnrows < 1 then
		ls_message = "공정별 세부내역정보 수정할때 오류가 발생했습니다."
		goto Rollback_
	end if
else
	//유사품번 등록여부 체크
	ls_message = f_rtn02_conv_itno(l_s_rcplant,l_s_rcdvsn,l_s_rcitno,g_s_date)
	if ls_message <> l_s_rcitno then
		ls_message = "유사품번으로 등록되어 있는 품목입니다."
		goto Rollback_
	end if
	
	l_s_flag = 'A'
	l_s_rcgrde = wf_gradeupdate(l_s_rcplant,l_s_rcdvsn,l_s_rcitno,l_s_rcline)
	
	insert into pbrtn.rtn013
		( rccmcd,rcplant,rcdvsn,rcitno,rcline1,rcline2,rcopno,rcchtime,rcedfm,
		rcopnm,rcopsq,rcline3,rcgrde,rcmcyn,rcbmtm,rcbltm,rcbstm,
		rcnvcd,rcnvmc,rcnvlb,rclbcnt,rcflag,rcepno,rcipad,rcupdt,rcsydt,
		rcinemp, rcinchk, rcintime, rcplemp, rcplchk, rcpltime,
		rcdlemp, rcdlchk, rcdltime )
	values
		( '01',:l_s_rcplant,:l_s_rcdvsn,:l_s_rcitno,:l_s_rcline1,:l_s_rcline2,:l_s_rcopno,:ls_chtime,'',
		:l_s_rcopnm,:l_n_rcopsq,:l_s_rcline3,:l_s_rcgrde,:l_s_rcmcyn,:l_d_rcbmtm,:l_d_rcbltm,:l_d_rcbstm,
		:l_s_rcnvcd,:l_d_rcnvmc,:l_d_rcnvlb,:l_n_rclbcnt,:l_s_flag,:l_s_rcepno,:g_s_ipaddr,:g_s_date,:g_s_date,
		:g_s_empno, 'N', '', '', 'N','',
		'', 'N','')
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		ls_message = "공정별 세부내역정보 입력할때 오류가 발생했습니다."
		goto Rollback_
	end if
end if

COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE

l_n_rowcount = dw_1.retrieve(l_s_rcplant,l_s_rcdvsn,l_s_rcline,l_s_rcitno)

if i_s_selected = 'A' then
	net1 = messagebox("확인","새로운 공정을 계속 입력하시겠습니까 ?", question!, OKCancel!,2)
	if net1 = 1 then
		dw_1.selectrow(0,false)
		dw_1.selectrow(l_n_rowcount,true)
		l_s_wsheet = w_frame.GetActiveSheet()
		l_s_wsheet.TriggerEvent("ue_insert")
		return 0
	end if
end if

wf_rgbclear('I')
dw_detail.object.b_jubu.visible = false
// dw_detail.object.b_jubu.enabled = false
i_s_selected = ''

i_b_retrieve = true
i_b_insert = true
i_b_save = false
i_b_delete = true
i_b_dretrieve = false
i_b_dprint = false
i_b_dchar = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	              i_b_dprint,   i_b_dchar)
						 
return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
i_n_erreturn = -1
uo_status.st_message.text = ls_message

return -1

end event

event ue_delete;string  l_s_rcplant,l_s_rcdvsn, l_s_rcitno, l_s_rcline, l_s_rcopno, l_s_rcedfm, text_value , l_s_rcline1,l_s_rcline2,l_s_rcnvcd
string  l_s_rcopnm,l_s_rcline3,l_s_rcgrde,l_s_rcmcyn,l_s_rcedto,l_s_rcflag,l_s_rcepno,l_s_rcipad,l_s_rcupdt,l_s_rcsydt
long    l_s_handle, l_n_yesno, l_s_newhandle, l_s_nexthandle
integer l_n_row, net, l_s_rcopsq,l_s_rclbcnt,l_n_sqlcount
dec     l_s_rcbmtm,l_s_rcbltm,l_s_rcbstm,l_s_rcnvmc,l_s_rcnvlb
string ls_message, ls_chtime
treeviewitem l_tvi_item

setpointer(hourglass!)
cb_copy.enabled = false

if i_s_level = "5" then
	dw_1.accepttext()
	if dw_1.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if

i_s_selected = "D"
uo_status.st_message.text = ""

l_n_row = dw_1.getselectedrow(0)
if l_n_row < 1 then
	uo_status.st_message.text = f_message("D040")
	return 0
end if

l_s_rcplant = trim(dw_1.object.rcplant[l_n_row])
l_s_rcdvsn  = trim(dw_1.object.rcdvsn[l_n_row])
l_s_rcitno  = trim(dw_1.object.rcitno[l_n_row])
l_s_rcline  = trim(dw_1.object.rcline1[l_n_row]) + dw_1.object.rcline2[l_n_row]
l_s_rcline1 = trim(dw_1.object.rcline1[l_n_row])
l_s_rcline2 = dw_1.object.rcline2[l_n_row]
l_s_rcopno  = trim(dw_1.object.rcopno[l_n_row])
l_s_rcedfm  = dw_1.object.rcedfm[l_n_row]
l_s_rcopnm  = dw_1.object.rcopnm[l_n_row]
l_s_rcopsq  = dw_1.object.rcopsq[l_n_row]
l_s_rcline3 = dw_1.object.rcline3[l_n_row]
l_s_rcgrde  = dw_1.object.rcgrde[l_n_row]
l_s_rcmcyn  = dw_1.object.rcmcyn[l_n_row]
l_s_rcbmtm  = dw_1.object.rcbmtm[l_n_row]
l_s_rcbltm  = dw_1.object.rcbltm[l_n_row]
l_s_rcbstm  = dw_1.object.rcbstm[l_n_row]
l_s_rcnvcd  = dw_1.object.rcnvcd[l_n_row]
l_s_rcnvmc  = dw_1.object.rcnvmc[l_n_row]
l_s_rcnvlb  = dw_1.object.rcnvlb[l_n_row]
l_s_rclbcnt = dw_1.object.rclbcnt[l_n_row]
l_s_rcflag  = dw_1.object.rcflag[l_n_row]
l_s_rcepno  = g_s_empno
l_s_rcipad  = g_s_ipaddr
l_s_rcupdt  = g_s_date
l_s_rcsydt  = g_s_date

if dw_1.object.rcinchk[l_n_row] = 'Y' and dw_1.object.rcdlchk[l_n_row] = 'N' then
	uo_status.st_message.text = "결재진행중이므로 삭제할 수 없습니다."
	return 0
end if

l_n_yesno = messagebox("삭제확인", "선택된 라인의 공정순서를 삭제하시겠습니까 ?",Question!,OkCancel!,2)
if l_n_yesno <> 1 then
	uo_status.st_message.text = f_message("D040")
	return 0
end if

dw_1.deleterow(l_n_row)
ls_chtime = f_get_systemdate(sqlca)

SQLCA.AUTOCOMMIT = FALSE

update pbrtn.rtn013
set rcchtime = :ls_chtime, rcflag = 'D',
	 rcepno = :l_s_rcepno , rcipad = :l_s_rcipad, rcupdt = :l_s_rcupdt,
	 rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
	 rcplemp = '', rcplchk = 'N', rcpltime = '',
	 rcdlemp = '', rcdlchk = 'N', rcdltime = ''
where rccmcd = :g_s_company and rcplant = :l_s_rcplant and rcdvsn = :l_s_rcdvsn and 
	rcline1 = :l_s_rcline1 and rcline2 = :l_s_rcline2 and rcopno = :l_s_rcopno  and 
	rcitno  = :l_s_rcitno
using sqlca;

if sqlca.sqlnrows < 1 then
	ls_message = "공정 상세정보를 삭제하는 중에 에러가 발생하였습니다."
	goto Rollback_
end if

COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE

dw_1.reset()
dw_1.retrieve(l_s_rcplant,l_s_rcdvsn,l_s_rcline,l_s_rcitno)

i_s_selected = ''
i_b_retrieve = true
i_b_insert = true
i_b_save = false
i_b_delete = true
i_b_dretrieve = false
i_b_dprint = false
i_b_dchar = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	          i_b_dprint,   i_b_dchar)
					
return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
uo_status.st_message.text = ls_message

return -1
						 
end event

event closequery;call super::closequery;int net

if i_s_level = "5" then
	dw_1.accepttext()
	if dw_1.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if
end event

type uo_status from w_origin_sheet01`uo_status within w_rtn013u
integer x = 0
integer y = 2472
end type

type tv_1 from treeview within w_rtn013u
integer x = 5
integer y = 284
integer width = 754
integer height = 2148
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
boolean hideselection = false
boolean tooltips = false
grsorttype sorttype = ascending!
string picturename[] = {"","Close!","Custom039!","Custom050!","","",""}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event itempopulate;Integer			l_n_Level
TreeViewItem	l_tvi_Current
long           l_n_rows

// Determine the level
tv_1.GetItem(handle, l_tvi_Current)
l_n_Level = l_tvi_Current.Level
if l_s_populate_no = 1 then
	l_s_populate_no = 0 
   return
end if
if l_n_level > 2 then 
	return
end if
if l_s_populate <> 0 then		
   wf_itempopulate(handle, tv_1)
end if
l_s_populate = 1

 
end event

event selectionchanged;string l_s_plant,l_s_div,l_s_pdcd,l_s_itno, l_s_itno1, l_s_itno2
treeviewitem l_tvi_item	, l_tvi_item1 , l_tvi_item2
integer l_n_rows, i, k, net
long l_s_handle , l_s_handle1

i_s_rcitno = ''
i_s_rcline = ''

if i_s_level = "5" then
	dw_1.accepttext()
	if dw_1.modifiedcount() > 0 then
		net=messagebox("확인",f_message("U080"),question!,yesnocancel!,2)
		if net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif net=3 then
			return 1
		end if
	end if
end if

uo_status.st_message.text = ""

dw_1.reset()
dw_detail.reset()

string l_s_parm
l_s_parm    = uo_1.uf_Return()
l_s_plant   = mid(l_s_parm,1,1)
l_s_div     = mid(l_s_parm,2,1)
l_s_pdcd    = mid(l_s_parm,3,2)

tv_1.getitem(newhandle, l_tvi_item)

l_s_itno = trim(l_tvi_item.data)

i_s_selected = ' '
i_b_retrieve = true
i_b_insert = true
i_b_save = false
i_b_delete = true
i_b_dretrieve = false
i_b_dprint = false
i_b_dchar = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	              i_b_dprint,   i_b_dchar)


if l_tvi_item.level <> 3 then 
	return
end if

l_s_handle = tv_1.finditem(parenttreeitem!,newhandle)
tv_1.getitem(l_s_handle, l_tvi_item1)
l_s_itno1 = l_tvi_item1.data

l_s_handle1 = tv_1.finditem(parenttreeitem!,l_s_handle)
tv_1.getitem(l_s_handle1, l_tvi_item2)
l_s_itno2 = l_tvi_item2.data

if rb_2.checked = true then
	i_s_rcline    = l_s_itno
	i_s_rcitno    = l_s_itno2
else
	i_s_rcline    = l_s_itno1
	i_s_rcitno    = l_s_itno
end if

if dw_1.retrieve(l_s_plant,l_s_div,i_s_rcline, i_s_rcitno) < 1 then
	cb_copy.enabled = false
	cb_delete.enabled = false
	cb_allcopy.enabled = false
else
	cb_copy.enabled = true
	cb_delete.enabled = true
	cb_allcopy.enabled = true
end if

end event

event clicked;Integer			l_n_Level
TreeViewItem	l_tvi_Current
long           l_n_rows

// Determine the level
tv_1.GetItem(handle, l_tvi_Current)
l_n_Level = l_tvi_Current.Level

if l_n_level < 3 then 
	cb_copy.enabled = false
end if
end event

type dw_1 from datawindow within w_rtn013u
event keydown pbm_dwnkey
event ue_keydown pbm_dwnkey
integer x = 782
integer y = 284
integer width = 3794
integer height = 1552
boolean bringtotop = true
string title = "dw_1"
string dataobject = "d_rtn01_dw_detail_routing"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string l_s_rcplant,l_s_rcdvsn,l_s_rcitno,l_s_rcline1,l_s_rcline2,l_s_rcopno

this.selectrow(0,false)
if row < 1 then return ;
this.selectrow(row,true)

l_s_rcplant = this.object.rcplant[row]
l_s_rcdvsn  = this.object.rcdvsn[row]
l_s_rcitno  = this.object.rcitno[row]
l_s_rcline1  = this.object.rcline1[row]
l_s_rcline2  = this.object.rcline2[row]
l_s_rcopno  = this.object.rcopno[row]

dw_detail.retrieve(g_s_company,l_s_rcplant,l_s_rcdvsn,l_s_rcitno,l_s_rcline1,l_s_rcline2,l_s_rcopno)
wf_rgbclear('I')

i_b_retrieve = true
i_b_insert = true
i_b_save = false
i_b_delete = true
i_b_dretrieve = false
i_b_dprint = false
i_b_dchar = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	              i_b_dprint,   i_b_dchar)

if dwo.name = "find_history" then
	str_parms lstr_parm
	
	lstr_parm.string_arg[1] = g_s_company
	lstr_parm.string_arg[2] = this.getitemstring(row,"rcplant")
	lstr_parm.string_arg[3] = this.getitemstring(row,"rcdvsn")
	lstr_parm.string_arg[4] = this.getitemstring(row,"rcitno")
	lstr_parm.string_arg[5] = this.getitemstring(row,"rcline1")
	lstr_parm.string_arg[6] = this.getitemstring(row,"rcline2")
	lstr_parm.string_arg[7] = this.getitemstring(row,"rcopno")
	lstr_parm.integer_arg[1] = this.getitemnumber(row,"rcopsq")
	
	openwithparm(w_rtn01_rtninfo_history, lstr_parm)
end if

return 0


end event

event doubleclicked;string l_s_rcplant,l_s_rcdvsn,l_s_rcitno,l_s_rcline1,l_s_rcline2,l_s_rcopno
integer l_n_rows

uo_status.st_message.text = ''
l_s_rcplant = this.object.rcplant[row]
l_s_rcdvsn  = this.object.rcdvsn[row]
l_s_rcitno  = this.object.rcitno[row]
l_s_rcline1  = this.object.rcline1[row]
l_s_rcline2 = this.object.rcline2[row]
l_s_rcopno  = this.object.rcopno[row]

l_n_rows = dw_detail.retrieve(g_s_company,l_s_rcplant,l_s_rcdvsn,l_s_rcitno,l_s_rcline1,l_s_rcline2,l_s_rcopno)
wf_rgbclear('C')
dw_detail.setfocus()
dw_detail.setcolumn('rcopsq')
dw_detail.object.rcedfm[1] = f_relativedate(g_s_date,1)
// dw_detail.setcolumn('rcopno')
uo_status.st_message.text = "해당정보를 수정하세요   " + string(l_n_rows) 
i_b_retrieve = true
i_b_insert = false
i_b_save = true
i_b_delete = true
i_b_dretrieve = false
i_b_dprint = false
i_b_dchar = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	              i_b_dprint,   i_b_dchar)

end event

type sle_input from singlelineedit within w_rtn013u
event ue_keydown pbm_keydown
integer x = 2985
integer y = 48
integer width = 416
integer height = 80
integer taborder = 20
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
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if key = keyenter! then
	parent.triggerevent("ue_retrieve")
end if
end event

type dw_detail from datawindow within w_rtn013u
event ue_keydown pbm_dwnkey
integer x = 782
integer y = 1852
integer width = 3794
integer height = 588
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_rtn01_dw_rtn013_ffinput"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;window l_s_wsheet

if key = keyenter! and i_s_selected = 'A' then
  	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_save")
end if


end event

event buttonclicked;string l_s_parm
int    i
long ll_selrow
str_parms lstr_parm

l_s_parm = '  '
dw_detail.accepttext()

if dwo.name = 'find_button' then
	openwithparm(w_find_001 , l_s_parm)
	l_s_parm = message.stringparm
	if f_spacechk(l_s_parm) <> -1 then
		dw_detail.object.rcline3[1]  = mid(l_s_parm,1,5)
	end if
end if

if dwo.name = 'jangbi_button' then
	if f_spacechk(dw_detail.object.rcline3[1]) = -1 then
		messagebox("확인", "조코드를 입력한 후 등록이 가능합니다")
	   return
	else
//		l_s_parm = dw_detail.object.rcplant[1] + dw_detail.object.rcdvsn[1] + string(dw_detail.object.rcitno[1],'@@@@@@@@@@@@') + &
//				   string(dw_detail.object.rcline1[1],'@@@@@@@') + dw_detail.object.rcline2[1] + string(dw_detail.object.rcopno[1],'@@@@@@@') + &
//				   string(dw_detail.object.rcline3[1],'@@@@@')

		lstr_parm.string_arg[1] = dw_detail.object.rcplant[1]
		lstr_parm.string_arg[2] = dw_detail.object.rcdvsn[1]
		lstr_parm.string_arg[3] = dw_detail.object.rcitno[1]
		lstr_parm.string_arg[4] = dw_detail.object.rcline1[1]
		lstr_parm.string_arg[5] = dw_detail.object.rcline2[1]
		lstr_parm.string_arg[6] = dw_detail.object.rcopno[1]
		lstr_parm.string_arg[7] = dw_detail.object.rcline3[1]
		close(w_rtn013u_res03)
		openwithparm(w_rtn013u_res03, lstr_parm)
//		w_rtn013u_res03.dw_2.sharedata(dw_share2) 
		dw_detail.reset()
		ll_selrow = dw_1.getselectedrow(0)
		if ll_selrow > 0 then		
			dw_detail.retrieve(g_s_company,dw_1.getitemstring(ll_selrow,"rcplant"),dw_1.getitemstring(ll_selrow,"rcdvsn"), &
				dw_1.getitemstring(ll_selrow,"rcitno"),dw_1.getitemstring(ll_selrow,"rcline1"), &
				dw_1.getitemstring(ll_selrow,"rcline2"),dw_1.getitemstring(ll_selrow,"rcopno"))
			wf_rgbclear('I')
		end if
	end if
end if

if dwo.name = 'budae_button' then
	if f_spacechk(dw_detail.object.rcitno[1]) = -1 or f_spacechk(dw_detail.object.rcline1[1]) = -1 or &
	   f_spacechk(dw_detail.object.rcopno[1]) = -1 then
		messagebox("확인", "공장,품번,대체라인,공정번호를 확인 후 등록하세요")
	   return
	else
//		l_s_parm = dw_detail.object.rcplant[1] + dw_detail.object.rcdvsn[1] + string(dw_detail.object.rcitno[1],'@@@@@@@@@@@@') + &
//				   string(dw_detail.object.rcline1[1],'@@@@@@@') + dw_detail.object.rcline2[1] + string(dw_detail.object.rcopno[1],'@@@@@@@') 
		lstr_parm.string_arg[1] = dw_detail.object.rcplant[1]
		lstr_parm.string_arg[2] = dw_detail.object.rcdvsn[1]
		lstr_parm.string_arg[3] = dw_detail.object.rcitno[1]
		lstr_parm.string_arg[4] = dw_detail.object.rcline1[1]
		lstr_parm.string_arg[5] = dw_detail.object.rcline2[1]
		lstr_parm.string_arg[6] = dw_detail.object.rcopno[1]
		close(w_rtn013u_res01)
		openwithparm(w_rtn013u_res01, lstr_parm)
//		w_rtn013u_res01.dw_1.sharedata(dw_share1) 
		dw_detail.reset()
		ll_selrow = dw_1.getselectedrow(0)
		if ll_selrow > 0 then		
			dw_detail.retrieve(g_s_company,dw_1.getitemstring(ll_selrow,"rcplant"),dw_1.getitemstring(ll_selrow,"rcdvsn"), &
				dw_1.getitemstring(ll_selrow,"rcitno"),dw_1.getitemstring(ll_selrow,"rcline1"), &
				dw_1.getitemstring(ll_selrow,"rcline2"),dw_1.getitemstring(ll_selrow,"rcopno"))
			wf_rgbclear('I')
		end if
	end if
end if

if dwo.name = 'b_jubu' then
	if f_spacechk(dw_detail.object.rcitno[1]) = -1 or f_spacechk(dw_detail.object.rcdvsn[1]) = -1 then
		messagebox("확인", "공장,품번을 확인하세요 ")
	   return
	else
		l_s_parm = dw_detail.object.rcplant[1] + dw_detail.object.rcdvsn[1] + string(dw_detail.object.rcitno[1],'@@@@@@@@@@@@') 
		openwithparm(w_rtn013u_res02, l_s_parm)
	end if
end if
end event

event itemchanged;// 입력,수정 데이타 체크루틴
end event

type pb_find_item from picturebutton within w_rtn013u
integer x = 3419
integer y = 36
integer width = 238
integer height = 108
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

l_s_parm    = uo_1.uf_Return()
l_s_plant   = mid(l_s_parm,1,1)
l_s_div     = mid(l_s_parm,2,1)
l_s_pdcd    = mid(l_s_parm,3,2)

if f_spacechk(l_s_pdcd) = -1 then
	uo_status.st_message.text = "제품군을 선택해 주십시요"
	return 0
end if

l_s_parm = g_s_date + l_s_plant + l_s_div + l_s_pdcd
openwithparm(w_rtn_find_item,l_s_parm)
l_s_parm = message.stringparm
sle_input.text = l_s_parm

end event

type rb_1 from radiobutton within w_rtn013u
integer x = 37
integer y = 60
integer width = 352
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "대체Line"
boolean checked = true
end type

event clicked;call super::clicked;window l_s_wsheet
rb_2.checked = false
pb_find_item.visible = false
pb_find_item.enabled = false
//uo_1.dw_1.object.st_2.visible    = false
//uo_1.dw_1.object.div.visible     = false
//uo_1.dw_1.object.st_2.visible    = false
//uo_1.dw_1.object.div.visible     = false
end event

type rb_2 from radiobutton within w_rtn013u
integer x = 37
integer y = 156
integer width = 251
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "품 번"
end type

event clicked;call super::clicked;window l_s_wsheet
rb_1.checked = false
pb_find_item.visible = true
pb_find_item.enabled = true
//uo_1.dw_1.object.st_2.visible    = true
//uo_1.dw_1.object.div.visible     = true
//uo_1.dw_1.object.st_2.visible    = true
//uo_1.dw_1.object.div.visible     = true

end event

type uo_1 from uo_plandiv_pdcd_rtn within w_rtn013u
integer x = 494
integer y = 28
integer width = 2482
integer height = 104
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd_rtn::destroy
end on

type cb_copy from commandbutton within w_rtn013u
integer x = 2930
integer y = 168
integer width = 462
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "대체라인복사"
end type

event clicked;string l_s_parm
str_parms lstr_parm

uo_status.st_message.text = ' '

lstr_parm.string_arg[1] = g_s_company
lstr_parm.string_arg[2] = dw_1.object.rcplant[1]
lstr_parm.string_arg[3] = dw_1.object.rcdvsn[1]
lstr_parm.string_arg[4] = dw_1.object.rcitno[1]
lstr_parm.string_arg[5] = dw_1.object.rcline1[1]
lstr_parm.string_arg[6] = dw_1.object.rcline2[1]

openwithparm(w_rtn013u_res04, lstr_parm)

l_s_parm = message.stringparm

if mid(l_s_parm,1,1) = 'Y' then
	messagebox("확인",'Copy 완료')
	sle_input.text = mid(l_s_parm,2,12)
	rb_1.checked = false
	rb_2.checked = true
	pb_find_item.visible = true
	pb_find_item.enabled = true
	parent.triggerevent("ue_retrieve")
else
	messagebox("확인",'Copy 취소')
end if

return 0

end event

type cb_delete from commandbutton within w_rtn013u
integer x = 2290
integer y = 168
integer width = 581
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "대체라인일괄삭제"
end type

event clicked;string ls_chtime,l_s_plant,l_s_dvsn,l_s_pitno,l_s_line1,l_s_line2, ls_message
integer li_rtn
uo_status.st_message.text = ' '
l_s_plant = dw_1.object.rcplant[1]
l_s_dvsn  = dw_1.object.rcdvsn[1]
l_s_pitno = dw_1.object.rcitno[1]
l_s_line1 = dw_1.object.rcline1[1]
l_s_line2 = dw_1.object.rcline2[1]

select count(*) into :li_rtn
from pbrtn.rtn013
where rccmcd = :g_s_company and rcplant = :l_s_plant and 
	rcdvsn = :l_s_dvsn and rcitno = :l_s_pitno and
	rcline1 = :l_s_line1 and rcline2 = :l_s_line2 and
	rcinchk = 'Y' and rcdlchk = 'N'
using sqlca;
if li_rtn > 0 then
	uo_status.st_message.text = "결재가 진행중이므로 삭제할수 없습니다."
	return 0
end if

li_rtn = MessageBox("확인", "대체라인 :" + l_s_line1 + "-" + l_s_line2 + ", 품번 :" + l_s_pitno &
	+ " 정보를 일괄 삭제하시겠습니까?", Exclamation!, OKCancel!, 2)
if li_rtn  = 2 then
	return 0
end if

ls_chtime = f_get_systemdate(sqlca)
SQLCA.AUTOCOMMIT = FALSE

update pbrtn.rtn013
set rcchtime = :ls_chtime, rcflag = 'D',
	 rcepno = :g_s_empno , rcipad = :g_s_ipaddr, rcupdt = :g_s_date,
	 rcinemp = :g_s_empno, rcinchk = 'N', rcintime = '',
	 rcplemp = '', rcplchk = 'N', rcpltime = '',
	 rcdlemp = '', rcdlchk = 'N', rcdltime = ''
where rccmcd = :g_s_company and rcplant = :l_s_plant and 
	rcdvsn = :l_s_dvsn and rcitno = :l_s_pitno and
	rcline1 = :l_s_line1 and rcline2 = :l_s_line2
using sqlca;

if sqlca.sqlnrows < 1 then
	ls_message = "삭제중에 오류가 발생하였습니다."
	goto Rollback_
end if
COMMIT USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE

rb_1.checked = false
rb_2.checked = true
pb_find_item.visible = true
pb_find_item.enabled = true
parent.triggerevent("ue_retrieve")

return 0

Rollback_:
ROLLBACK USING SQLCA;
SQLCA.AUTOCOMMIT = TRUE
uo_status.st_message.text = ls_message

return -1
end event

type cb_rtn013_template from commandbutton within w_rtn013u
integer x = 503
integer y = 168
integer width = 795
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "기본정보 업로드용 템플릿"
end type

event clicked;string ls_plant, ls_dvsn, ls_itno, ls_line1, ls_line2
long ll_rowcnt

ll_rowcnt = dw_1.rowcount()
if ll_rowcnt < 1 then
	uo_status.st_message.text = "조회된 공정정보가 없습니다."
	return -1
end if

dw_down.dataobject = "d_rtn013u_rtn013_template"
dw_down.settransobject(sqlca)

ls_plant = dw_1.getitemstring(1,"rcplant")
ls_dvsn = dw_1.getitemstring(1,"rcdvsn")
ls_itno = dw_1.getitemstring(1,"rcitno")
ls_line1 = dw_1.getitemstring(1,"rcline1")
ls_line2 = dw_1.getitemstring(1,"rcline2")
ll_rowcnt = dw_down.retrieve(g_s_company, ls_plant, ls_dvsn, ls_itno, ls_line1, ls_line2 )
if ll_rowcnt > 0 then
	f_save_to_excel_number(dw_down)
else
	uo_status.st_message.text = "다운로드할 자료가 없습니다."
end if

return 0
end event

type cb_rtn014_template from commandbutton within w_rtn013u
integer x = 1362
integer y = 168
integer width = 795
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "부대작업 업로드용 템플릿"
end type

event clicked;string ls_plant, ls_dvsn, ls_itno, ls_line1, ls_line2
long ll_rowcnt

ll_rowcnt = dw_1.rowcount()
if ll_rowcnt < 1 then
	uo_status.st_message.text = "조회된 공정정보가 없습니다."
	return -1
end if

dw_down.dataobject = "d_rtn013u_rtn014_template"
dw_down.settransobject(sqlca)

ls_plant = dw_1.getitemstring(1,"rcplant")
ls_dvsn = dw_1.getitemstring(1,"rcdvsn")
ls_itno = dw_1.getitemstring(1,"rcitno")
ls_line1 = dw_1.getitemstring(1,"rcline1")
ls_line2 = dw_1.getitemstring(1,"rcline2")
ll_rowcnt = dw_down.retrieve(g_s_company, ls_plant, ls_dvsn, ls_itno, ls_line1, ls_line2 )
if ll_rowcnt > 0 then
	f_save_to_excel_number(dw_down)
else
	uo_status.st_message.text = "다운로드할 자료가 없습니다."
end if

return 0
end event

type dw_down from datawindow within w_rtn013u
boolean visible = false
integer x = 3209
integer y = 172
integer width = 686
integer height = 352
integer taborder = 60
boolean bringtotop = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_allcopy from commandbutton within w_rtn013u
integer x = 3451
integer y = 168
integer width = 462
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "품번전체복사"
end type

event clicked;string l_s_parm
str_parms lstr_parm

uo_status.st_message.text = ' '

lstr_parm.string_arg[1] = g_s_company
lstr_parm.string_arg[2] = dw_1.object.rcplant[1]
lstr_parm.string_arg[3] = dw_1.object.rcdvsn[1]
lstr_parm.string_arg[4] = dw_1.object.rcitno[1]
lstr_parm.string_arg[5] = dw_1.object.rcline1[1]
lstr_parm.string_arg[6] = dw_1.object.rcline2[1]

openwithparm(w_rtn013u_res05, lstr_parm)

l_s_parm = message.stringparm

if mid(l_s_parm,1,1) = 'Y' then
	messagebox("확인",'품번 전체 Copy 완료')
	sle_input.text = mid(l_s_parm,2,12)
	rb_1.checked = false
	rb_2.checked = true
	pb_find_item.visible = true
	pb_find_item.enabled = true
	parent.triggerevent("ue_retrieve")
else
	messagebox("확인",'품번 전체 Copy 취소')
end if

return 0

end event

type cb_deptchange from commandbutton within w_rtn013u
integer x = 3973
integer y = 168
integer width = 480
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조코드일괄변경"
end type

event clicked;string l_s_parm, l_s_plant, l_s_div
str_parms lstr_parm

l_s_parm    = uo_1.uf_Return()
l_s_plant   = mid(l_s_parm,1,1)
l_s_div     = mid(l_s_parm,2,1)

if f_spacechk(l_s_plant) = -1 or f_spacechk(l_s_div) = -1 then
	uo_status.st_message.text = "지역,공장을 선택해 주십시요."
	return 0
end if

lstr_parm.string_arg[1] = g_s_company
lstr_parm.string_arg[2] = l_s_plant
lstr_parm.string_arg[3] = l_s_div

openwithparm(w_rtn013u_res06, lstr_parm)
end event

type gb_framemove from groupbox within w_rtn013u
event ue_gbmousedown pbm_lbuttondown
event ue_gbmousemove pbm_mousemove
event ue_gbmouseup pbm_lbuttonup
boolean visible = false
integer x = 5
integer y = 124
integer width = 731
integer height = 1692
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
end type

event ue_gbmousedown;setpointer(sizeWE!)
end event

event ue_gbmousemove;integer li_border, li_curwidth
li_border = this.x + this.width
//if (li_border - 20) <= xpos and (li_border + 20) >= xpos then
setpointer(sizeWE!)
//end if
if flags = 1 then
	li_curwidth = this.width + (xpos - this.width)
	this.resize( li_curwidth,this.height)
end if
end event

event ue_gbmouseup;integer li_tvwidth,li_lvwidth
li_tvwidth = xpos - (tv_1.x + tv_1.width) 
tv_1.resize((tv_1.width + li_tvwidth - 20),tv_1.height)
li_lvwidth = 3607 - (xpos + 9)
dw_1.x = xpos + 9
dw_1.width = li_lvwidth

end event

event constructor;this.x = 5
this.y = 125
this.width = 730
this.height = 1690
end event

type gb_1 from groupbox within w_rtn013u
integer x = 9
integer y = 4
integer width = 421
integer height = 268
integer textsize = -4
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_rtn013u
integer x = 443
integer y = 4
integer width = 4133
integer height = 268
integer textsize = -4
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

