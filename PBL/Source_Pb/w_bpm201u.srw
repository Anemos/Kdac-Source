$PBExportHeader$w_bpm201u.srw
$PBExportComments$사업계획품목관리
forward
global type w_bpm201u from w_origin_sheet01
end type
type tab_1 from tab within w_bpm201u
end type
type tabpage_1 from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type pb_5 from picturebutton within tabpage_1
end type
type cb_6 from commandbutton within tabpage_1
end type
type cb_5 from commandbutton within tabpage_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type dw_10 from datawindow within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type dw_11 from datawindow within tabpage_1
end type
type dw_12 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_1 cb_1
pb_5 pb_5
cb_6 cb_6
cb_5 cb_5
cb_3 cb_3
st_1 st_1
dw_10 dw_10
cb_2 cb_2
dw_11 dw_11
dw_12 dw_12
end type
type tabpage_2 from userobject within tab_1
end type
type pb_6 from picturebutton within tabpage_2
end type
type dw_22 from datawindow within tabpage_2
end type
type dw_21 from datawindow within tabpage_2
end type
type dw_20 from datawindow within tabpage_2
end type
type pb_2 from picturebutton within tabpage_2
end type
type tabpage_2 from userobject within tab_1
pb_6 pb_6
dw_22 dw_22
dw_21 dw_21
dw_20 dw_20
pb_2 pb_2
end type
type tabpage_3 from userobject within tab_1
end type
type pb_1 from picturebutton within tabpage_3
end type
type pb_4 from picturebutton within tabpage_3
end type
type dw_3 from datawindow within tabpage_3
end type
type dw_2 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
pb_1 pb_1
pb_4 pb_4
dw_3 dw_3
dw_2 dw_2
end type
type tab_1 from tab within w_bpm201u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_bpm201u from w_origin_sheet01
integer height = 2736
string title = "기 본 정 보 유 지 관 리"
event ue_open_after ( )
tab_1 tab_1
end type
global w_bpm201u w_bpm201u

type variables
string is_xplant, is_div, is_orgsql,is_orgsql1
String is_action, is_col_nm
long   il_LastClickedRow
int    i_n_tab_index
Boolean ib_Insert = False

datawindow  idw_10, idw_11, idw_12, idw_20, idw_21, idw_22, idw_30, idw_31
// DataWindow 선언...
datawindowchild idwc_1
// Window 선언...
Window	iw_Sheet


end variables

forward prototypes
public subroutine wf_inv002_update (string as_gubun, string as_itno)
public function integer wf_master_check (string as_itno, string as_type, ref string arg_msgcd)
public subroutine wf_inv602_insert (string as_plant, string as_div, string as_itno, decimal ad_cost)
public function integer wf_pur103_chk (string as_itno)
public function string wf_inv101_xunit (string as_itno, string as_xunit)
end prototypes

event ue_open_after();String ls_div 
iw_Sheet = w_frame.GetActiveSheet( )

//f_AutDiv_Set( idw_20 )
//f_Autmlan_set( idw_22 )
////comm121의 지역/공장 가져오기
f_pur_getxplantdiv(is_xplant,is_div)

idw_20.object.xplant[1] = is_xplant
idw_20.object.div[1] = is_div


//ls_div = idw_20.GetItemString(1,'div')
ls_div = trim(idw_20.object.div[1])

idw_20.GetChild('pdcd', idwc_1)
idwc_1.SetTransObject(Sqlca)
idwc_1.Retrieve(ls_Div)


string ls_xyear
select coalesce(max(xyear || revno),'')
into :ls_xyear
from pbbpm.bpm519;

idw_10.object.xyear[1] = mid(ls_xyear,1,4)
idw_20.object.xyear[1] = mid(ls_xyear,1,4)
idw_30.object.xyear[1] = mid(ls_xyear,1,4)

idw_10.object.revno[1] = mid(ls_xyear,5,2)
idw_20.object.revno[1] = mid(ls_xyear,5,2)
end event

public subroutine wf_inv002_update (string as_gubun, string as_itno);
UPDATE "PBINV"."INV002"  
   SET "RROGB" = :as_gubun, 
	    "UPDTID" = :g_s_empno,  "UPDTDT" = :g_s_datetime, "IPADDR" = :g_s_ipaddr, "MACADDR" = :g_s_macaddr   
WHERE ( "PBINV"."INV002"."COMLTD" = '01')  AND ( "PBINV"."INV002"."ITNO"   = :as_itno)  using sqlca ;
if sqlca.sqlcode <> 0 then
	rollback using sqlca;
else
	commit using sqlca;
end if

end subroutine

public function integer wf_master_check (string as_itno, string as_type, ref string arg_msgcd);/*************************************************************************************/
/*      -.INV002에 존재하지 않는 품목만 입력가능                                     */
/*      -.INV001에 존재하지 않는 품목만 입력가능                                     */
/*************************************************************************************/
String  ls_iitno, ls_fitno, ls_sitno
Integer li_cnt, li_cnt1

ls_iitno = mid(as_itno,1,1)
ls_fitno = mid(as_itno,2,1)
ls_sitno = mid(as_itno,3,1)
//물성분류체계 확인
if as_type = ' ' then 
	SELECT  count(*) into :li_cnt1
		FROM "PBINV"."INV001" A
	WHERE A."COMLTD" = '01' AND A."INL" = :ls_iitno AND A."FST" = :ls_fitno 
									AND A."SND" = :ls_sitno AND A."THD" = ' ' ;
	IF li_cnt1 >= 1 THEN          
		RETURN -1
	END IF	
end if

RETURN 0

end function

public subroutine wf_inv602_insert (string as_plant, string as_div, string as_itno, decimal ad_cost);Dec{2} ld_cost

//품목재고 db read(지역/공장/품번)
SELECT "PBINV"."INV602"."XCOST"  INTO :ld_cost
  FROM "PBINV"."INV602" 
WHERE ( "PBINV"."INV602"."COMLTD" = '01')     AND ( "PBINV"."INV602"."XPLANT" = :as_plant) AND
		( "PBINV"."INV602"."DIV"    = :as_div)  AND ( "PBINV"."INV602"."ITNO"   = :as_itno)  using sqlca ;

if sqlca.sqlcode = 0 then
	UPDATE "PBINV"."INV602"  
	SET "XCOST"  = :ad_cost,    "UPDTID" = :g_s_empno,   "UPDTDT" = :g_s_datetime, 
		 "IPADDR" = :g_s_ipaddr, "MACADDR" = :g_s_macaddr   
	WHERE ( "PBINV"."INV602"."COMLTD" = '01')    AND ( "PBINV"."INV602"."XPLANT" = :as_plant) AND
			( "PBINV"."INV602"."DIV"    = :as_div) AND ( "PBINV"."INV602"."ITNO"   = :as_itno)  using sqlca ;
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
	else
		commit using sqlca;
	end if
else
	INSERT INTO "PBINV"."INV602"  
		  ( "COMLTD", "XPLANT",   "DIV",        "ITNO",      "XCOST",       "COSTDIV", 
			 "EXTD",   "INPTID",   "INPTDT",     "UPDTID",    "UPDTDT",      "IPADDR",   "MACADDR" )  
	VALUES ( '01',     :as_plant,  :as_div,      :as_itno,    :ad_cost,      ' ',
			 ' ',      :g_s_empno, :g_s_datetime, :g_s_empno, :g_s_datetime, :g_s_ipaddr, :g_s_macaddr ) Using sqlca;
	if sqlca.sqlcode <> 0 then
	   rollback using sqlca;
	else
	   commit using sqlca;
	end if
end if

end subroutine

public function integer wf_pur103_chk (string as_itno);Int li_cnt

SELECT COUNT(ITNO)
  INTO :li_cnt
  FROM PBPUR.PUR103 
 WHERE COMLTD = '01' AND ITNO = :as_itno Using sqlca;
 
IF li_cnt <= 0 THEN                      
	RETURN -1
else
	Return 1
END IF
end function

public function string wf_inv101_xunit (string as_itno, string as_xunit);//String ls_xunit
//
//SELECT "PBINV"."INV101"."XUNIT"
// INTO  :ls_xunit
// FROM "PBINV"."INV101" 
//WHERE "PBINV"."INV101"."COMLTD" = '01'  AND "PBINV"."INV101"."ITNO"   = :as_itno AND
//      "PBINV"."INV101"."XUNIT"  <> :as_xunit  using sqlca ;

//if sqlca.sqlcode <> 0 then
//	ls_cls  = ' '
//	ls_srce = ' '
//	ls_unit = ' '
//end if

return ''




end function

on w_bpm201u.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_bpm201u.destroy
call super::destroy
destroy(this.tab_1)
end on

event ue_retrieve;string ls_xyear, ls_revno, ls_itno, ls_itnm, ls_spec, ls_gubun, ls_xplant, ls_div, ls_pdcd, ls_cls, ls_srce, ls_itno2
int    ll_row, ll_rcnt

uo_status.st_message.text	=	"조회중입니다."
setpointer(HourGlass!)


choose case i_n_tab_index
	case 1
			  
		if idw_10.accepttext() = -1 then
			messagebox('확인','조회조건중 데이타 오류난 자료있습니다.')
			uo_status.st_message.text	=	'조회조건중 데이타 오류난 자료있습니다.'
			return
		end if
		
		ls_xyear = trim(idw_10.object.xyear[1])
		ls_revno = trim(idw_10.object.revno[1])
		ls_gubun = trim(idw_10.object.gubun[1])
		ls_itno = trim(idw_10.object.itno[1])  ////품명,규격,품번
		if trim(ls_xyear) = '' or isnumber(ls_xyear) = false then
			messagebox('확인','사업계획년도를 확인하세요.')
			uo_status.st_message.text	=	'사업계획년도를 확인하세요.'
			return
		end if
		if trim(ls_revno) = '' then
			messagebox('확인','사업계획년도/버전을 확인하세요.')
			uo_status.st_message.text	=	'사업계획년도/버전을 확인하세요.'
			return
		end if
		if ls_gubun = '1' then //품명
         ls_itnm = ls_itno		
			ls_spec = ''
			ls_itno = ''
	   elseif ls_gubun = '2' then //규격
			ls_itnm = ''
			ls_spec = ls_itno
			ls_itno = ''
	   else //품번
			ls_itnm = ''
			ls_spec = ''
	   end if
		
		uo_status.st_message.text	= '조회중입니다...'   
		idw_11.reset() 
		if idw_11.retrieve(ls_xyear,ls_revno, ls_itnm,ls_spec,ls_itno) > 0 then
			uo_status.st_message.text	=	f_message("I010")		// 조회되었습니다.
			wf_icon_onoff(true,true,true,true,false,false,true) //I,A,U,D,P
		else
			uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
			wf_icon_onoff(true,false,false,false,false,false,true) //I,A,U,D,P
		end if
//*************************************************************************품목상세정보관리			
	case 2	
			  
		if idw_20.accepttext() = -1 then
			messagebox('확인','조회조건중 데이타 오류난 자료있습니다.')
			uo_status.st_message.text	=	'조회조건중 데이타 오류난 자료있습니다.'
			return
		end if
		
		ls_xyear = trim(idw_20.object.xyear[1])
		ls_revno = trim(idw_20.object.revno[1])
		ls_xplant = trim(idw_20.object.xplant[1])
		ls_div = trim(idw_20.object.div[1])
		ls_pdcd = trim(idw_20.object.pdcd[1])
		ls_cls = trim(idw_20.object.cls[1])
		ls_srce = trim(idw_20.object.srce[1])
		ls_itno = trim(idw_20.object.itno[1])  ////품명,규격,품번
		if trim(ls_xyear) = '' or isnumber(ls_xyear) = false then
			messagebox('확인','사업계획년도를 확인하세요.')
			uo_status.st_message.text	=	'사업계획년도를 확인하세요.'
			return
		end if
		if trim(ls_revno) = ''  then
			messagebox('확인','사업계획년도/버전을 확인하세요.')
			uo_status.st_message.text	=	'사업계획년도/버전을 확인하세요.'
			return
		end if
		if trim(ls_xplant) = '' then
			messagebox('확인','지역을 선택하세요!')
			uo_status.st_message.text	=	'지역을 선택하세요!'
			return
		end if		
		if trim(ls_div) = '' then
			messagebox('확인','공장을 선택하세요!')
			uo_status.st_message.text	=	'공장을 선택하세요!'
			return
		end if		
		uo_status.st_message.text	= '조회중입니다...'   
		idw_21.reset() 
		idw_22.reset() 
		if idw_21.retrieve(ls_xyear,ls_revno, ls_xplant,ls_div,ls_pdcd,ls_cls,ls_srce,ls_itno) > 0 then
			uo_status.st_message.text	=	f_message("I010")		// 조회되었습니다.
			wf_icon_onoff(true,true,true,true,false,false,true) //I,A,U,D,P
		else
			uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
			wf_icon_onoff(true,true,false,false,false,false,true) //I,A,U,D,P
		end if	
//****************************************BPM521 로그에는 버전관리안함	
case 3	
			  
		if idw_30.accepttext() = -1 then
			messagebox('확인','조회조건중 데이타 오류난 자료있습니다.')
			uo_status.st_message.text	=	'조회조건중 데이타 오류난 자료있습니다.'
			return
		end if
		
		ls_xyear = trim(idw_30.object.xyear[1])
			ls_gubun = trim(idw_30.object.gubun[1])
		if trim(ls_xyear) = '' or isnumber(ls_xyear) = false then
			messagebox('확인','사업계획년도를 확인하세요.')
			uo_status.st_message.text	=	'사업계획년도를 확인하세요.'
			return
		end if
		uo_status.st_message.text	= '조회중입니다...'   
		idw_31.reset() 
	   if idw_31.retrieve(ls_xyear,'w_bpm201u', ls_gubun) > 0 then
			uo_status.st_message.text	=	f_message("I010")		// 조회되었습니다.
			wf_icon_onoff(true,false,false,false,false,false,true) //I,A,U,D,P
		else
			uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
			wf_icon_onoff(true,false,false,false,false,false,true) //I,A,U,D,P
		end if		
end choose

setpointer(arrow!)
end event

event ue_save;string ls_xplant, ls_div, ls_itno, ls_itnm, ls_spec, ls_rev, ls_xunit, ls_type, ls_chgcd,ls_comcd
string ls_xyear,ls_revno, ls_msg,ls_jobcode
string ls_column,ls_rtndate,ls_errcd, ls_cdiv
integer li_rtncnt, li_rtn, Net
//INTERFACE
Int li_index, rtn, ll_insert
long ll_rcnt
dec  ld_convqty
//String ls_message, ls_areadivision[]
//str_ipis_server lstr_ipis[]

Choose case i_n_tab_index
		
		case 1
			IF idw_10.accepttext() = -1 THEN
				messagebox('확인','입력항목중 에러난곳 수정후 저장하세요!',Exclamation!)
				uo_status.st_message.text	= '입력항목중 에러난곳 수정후 저장하세요!'
				Return
			END IF
			ls_xyear = trim(idw_10.object.xyear[1])
			ls_revno = trim(idw_10.object.revno[1])
			IF f_bpmstcd_chk('150',ls_xyear,ls_revno, ls_msg) = -1  THEN   //tab별 진행상태확인
				messagebox('확인',ls_msg)
				uo_status.st_message.text	= ls_msg
				Return
			END IF
									
			IF idw_12.accepttext() = -1 THEN
				messagebox('확인','입력항목중 에러난곳 수정후 저장하세요!',Exclamation!)
				uo_status.st_message.text	= '입력항목중 에러난곳 수정후 저장하세요!'
				Return
			END IF
			uo_status.st_message.text	= '자료 확인중...'
			IF idw_12.ModifiedCount() < 1 THEN
			   messagebox('확인','변경된 내역이 없습니다!')
				uo_status.st_message.text = '변경된 내역이 없습니다!'
				RETURN
			END IF
			//입력시 입력항목 확인
			ls_type = idw_12.getitemstring(1,"xtype")
			IF idw_12.GetItemStatus(1,0,Primary!) = NewModified! OR +&
				idw_12.GetItemStatus(1,0,Primary!) = DataModified! THEN
				ls_itno = idw_12.GetItemString(1,"itno")
				li_rtn = wf_master_check(ls_itno,ls_type,ls_errcd)  //입력여부, 물성분류체계유무확인
				if li_rtn = -1 then
				   uo_status.st_message.text = f_message(ls_errcd)
				   return
			   end if
			END IF
			
			if idw_12.getitemstatus(1,0,Primary!) = Newmodified! then
				ls_jobcode = 'C'
			else
				ls_jobcode = 'S'
			end if
			ls_msg = '품번:' + ls_itno + ' 품목기본정보 수정'
         if idw_12.getitemstatus(1,'itnm',Primary!) = Datamodified! then
				ls_itnm = trim(idw_12.getitemstring(1,"itnm",Primary!,true))
				ls_msg = ls_msg + ' 품명수정:' + ls_itnm
			end if
			if idw_12.getitemstatus(1,'xunit',Primary!) = Datamodified! then
				ls_xunit = trim(idw_12.getitemstring(1,"xunit",Primary!,true))
				ls_msg = ls_msg + ' BOM단위수정:' + ls_xunit
			end if
			f_null_chk(idw_12)                                    
			if f_mandantory_chk(idw_12) = -1 then return    
          
			//idw_12.setitem(1,'gubun','2')
			f_inptid(idw_12)       // 등록자,등록일,수정자,수정일,ip,mac address
         li_rtncnt = idw_12.update(true,false)
			if li_rtncnt = 1 then
				
				f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm201u',g_s_empno,ls_jobcode,ls_msg)
				This.TriggerEvent('ue_retrieve')
				uo_status.st_message.text = f_message("U010")    //저장이 되었습니다.
			else 
				uo_status.st_message.text = f_message("U020")   
				rollback using sqlca;
			end if
//**************************************************************************사업계획 품목상세정보				
		case 2
			IF idw_20.accepttext() = -1 THEN
				messagebox('확인','입력항목중 에러난곳 수정후 저장하세요!',Exclamation!)
				uo_status.st_message.text	= '입력항목중 에러난곳 수정후 저장하세요!'
				Return
			END IF
			ls_xyear = trim(idw_20.object.xyear[1])
			ls_revno = trim(idw_20.object.revno[1])
			IF f_bpmstcd_chk('150',ls_xyear,ls_revno, ls_msg) = -1  THEN   //tab별 진행상태확인
				messagebox('확인',ls_msg)
				uo_status.st_message.text	= ls_msg
				Return
			END IF
			
			IF idw_22.accepttext() = -1 THEN
				messagebox('확인','입력항목중 에러난곳 수정후 저장하세요!',Exclamation!)
				uo_status.st_message.text	= '입력항목중 에러난곳 수정후 저장하세요!'
				Return
			END IF

			IF idw_22.ModifiedCount() < 1 THEN;
			   messagebox('확인','변경된 내역이 없습니다!')
				uo_status.st_message.text = "변경된 Data가 없습니다."
				return
			END IF
			ls_xyear = trim(idw_22.object.xyear[1])
			ls_revno = trim(idw_22.object.revno[1])
			ls_xplant = trim(idw_22.object.xplant[1])
			ls_div = trim(idw_22.object.div[1])
			ls_itno = trim(idw_22.object.itno[1])
			ls_comcd = trim(idw_22.object.comcd[1])  //고객사 유무상여부
			
			
			select count(*) into :ll_rcnt
			from  pbbpm.bpm502
			where xyear = :ls_xyear
			and   revno = :ls_revno
			and   itno = :ls_itno;
			IF ll_rcnt = 0 THEN
			   messagebox('확인','사업계획 품목기본정보 없습니다! 먼저입력하세요.')
				uo_status.st_message.text = '사업계획 품목기본정보 없습니다! 먼저입력하세요.'
				return
			END IF
			
			// 구입선 check
			String ls_cls, ls_srce
			ls_cls  = trim(idw_22.getitemstring(1,"cls"))
			ls_srce = trim(idw_22.getitemstring(1,"srce"))
			if ls_cls <> '30' then
				if f_spacechk(ls_srce) = -1 then
					Messagebox("확인!","구입선은 필수입력입니다.",Exclamation!)
					return
				end if
			end if
					
			// 자재담당자 check
			String ls_mlan
			ls_mlan = trim(idw_22.getitemstring(1,"mlan"))
			if ls_cls <> '30' then
				if ls_cls = '10' then
					if ls_srce <> '03' then
						if f_spacechk(ls_mlan) = -1 then
							Messagebox("확인!","자재담당은 필수입력입니다.",Exclamation!)
							return
						end if
					end if
				else
					if f_spacechk(ls_mlan) = -1 then
						Messagebox("확인!","자재담당은 필수입력입니다.",Exclamation!)
						return
					end if
				end if
			end if
			
//			// 자동불출처리대상(계정:40,50만 허용) & 불출간판품목은 제외 
//			String ls_autcd, ls_kbcd
//			ls_autcd = trim(idw_22.getitemstring(1,"autcd"))
//			if (ls_cls <> '40') and (ls_cls <> '50') then
//				if ls_autcd = 'Y' then
//					Messagebox("확인!","허용되지 않는 계정입니다.",Exclamation!)
//					return
//				end if
//			else
//				if ls_autcd = 'Y' then
//					ls_kbcd = trim(idw_22.getitemstring(1,"kbcd"))
//					if ls_kbcd = 'A' then
//						Messagebox("확인!","불출간판품목입니다.",Exclamation!)
//						return
//					end if
//				end if
//			end if
			
//			//2005.05.16 외자구매요구사항
//			If (idw_22.object.cls[1] = '10')   And &
//			   (idw_22.object.srce[1] = '01')  And &
//				(idw_22.Object.xunit[1] = 'EA') And &
//				(idw_22.Object.convqty1[1] = 0 ) then
//				Net = MessageBox("확인!", "[외자관리요구사항]순중량(Net Weight)을 입력바랍니다. 입력하시겠습니까?", Exclamation!,YesNo!, 1)
//				
//				IF Net = 1 THEN
//					return
//				End if
//		   End if
			
			// 원가사업장 getting
			string ls_pdcd
			ls_pdcd = trim(idw_22.getitemstring(1,'pdcd'))
			ls_cdiv = f_get_accdiv(idw_20.getitemstring(1,'xplant'),idw_20.getitemstring(1,'div'),ls_pdcd)
			                           
			
			//필수입력 항목 check
			if f_mandantory_chk(idw_22) = -1 then return    
			
			idw_22.setitem(1,'xplant',idw_20.getitemstring(1,'xplant'))
         idw_22.setitem(1,'div',idw_20.getitemstring(1,'div'))
			idw_22.setitem(1,'costdiv',ls_cdiv)
			f_inptid(idw_22)     // 등록자,등록일,수정자,수정일,ip,mac address      
         	
			////고객상 유무상-무조건 양산품목
			ls_comcd = idw_22.getitemstring(1,"comcd")
			if ls_comcd = 'Y' Or ls_comcd = 'O' then
			   idw_22.setitem(1,'mass','M')
			end if
					
//		   // 이체단가 등록
//			Dec{2} ld_iwcost
//			ls_itno   = idw_22.getitemstring(1,"itno")
//			ld_iwcost = idw_22.getitemnumber(1,"iwcost")
//			if ld_iwcost > 0 then
//				wf_inv602_insert(idw_20.getitemstring(1,'xplant'),idw_20.getitemstring(1,'div'),ls_itno,ld_iwcost)
//			end if			
			
//			// 외자MRP, 비간판 WARNING 비대상,대상  WCCD.
//			if Trim(idw_22.getitemstring(1,"wccd")) = '' then 
//				idw_22.setitem(1,'wccd','N')
//			End if
			
			// 변환계수 check
			If (( idw_22.Object.xunit[1] <> f_Get_Unit_s( ls_itno )) and &
			   ( idw_22.Object.convqty[1] = 1 )) OR &
				(( idw_22.Object.xunit[1] = f_Get_Unit_s( ls_itno )) and &
			   ( idw_22.Object.convqty[1] <> 1 )) then	
				messagebox('확인','재고단위/BOM단위 대비 변환계수가 불일치 합니다.')
				uo_status.st_message.text = '재고단위/BOM단위 대비 변환계수가 불일치 합니다.'
				return
				//Net = MessageBox("확인!", "재고단위/BOM단위 대비 변환계수가 불일치 합니다. 변환계수를 수정하시겠습니까?", Exclamation!,YesNo!, 1)
				
//				IF Net = 1 THEN
//					return
//				End if
			End if
			
//			//품목 master RROGB(내외자구분) Update			
//			String ls_gubun
//			if ls_srce = '01' then
//				ls_gubun = 'I'
//			else			
//				ls_gubun = 'D'
//			end if
//			
//			wf_inv002_update(ls_gubun,ls_itno)
			
//			// 저장품 등록시 구매담당자 INV002의 구매담당자 자동등록
//			string ls_plan
////			if ls_cls = '20' or ls_cls = '24' then  // 구매담당자(ls_itno) 여주는 내자일 경우만 
//			if idw_20.getitemstring(1,'xplant') = 'Y' And ls_srce <> '01' then
//				//ls_plan = f_Get_Xplan_yeo(ls_itno)				
//			else
//				ls_plan = f_get_plan(ls_itno)				
//			End if
//			idw_22.setitem(1,'xplan',ls_plan)
////			end if
			if idw_22.getitemstatus(1,0,Primary!) = Newmodified! then
				ls_jobcode = 'C'
			else
				ls_jobcode = 'S'
			end if
			ls_msg = '지역/공장:' + ls_xplant + ls_div + ' 품번:' + ls_itno + ' 품목상세정보 수정'
         if idw_22.getitemstatus(1,'cls',Primary!) = Datamodified! then
				ls_cls = trim(idw_22.getitemstring(1,'cls',Primary!,true))
				ls_msg = ls_msg + ' 계정수정:' + ls_cls
			end if
			if idw_22.getitemstatus(1,'srce',Primary!) = Datamodified! then
				ls_srce = trim(idw_22.getitemstring(1,'srce',Primary!,true))
				ls_msg = ls_msg + ' 구입선수정:' + ls_srce
			end if
			if idw_22.getitemstatus(1,'xunit',Primary!) = Datamodified! then
				ls_xunit = trim(idw_22.getitemstring(1,'xunit',Primary!,true))
				ls_msg = ls_msg + ' 재고단위수정:' + ls_xunit
			end if
			if idw_22.getitemstatus(1,'convqty',Primary!) = Datamodified! then
				ld_convqty = idw_22.GetItemNumber(1,'convqty',Primary!,true)
				ls_msg = ls_msg + ' 변환계수수정: ' + string(ld_convqty)
			end if
			
			f_null_chk(idw_22)   //data value => null이면 zero or spaces setting
			f_inptid(idw_22)     // 등록자,등록일,수정자,수정일,ip,mac address      
         

//			// inv101(품목재고) update
			li_rtncnt = idw_22.update(true,false)
			if li_rtncnt = 1 then
				////고객사유무상 여부 단가정보 업데이트
				update pbbpm.bpm509
				    set ycmcd = :ls_comcd
				where yccyy = :ls_xyear
				and   revno = :ls_revno
				and   yitno = :ls_itno;
				f_bpm_job_start(ls_xyear,ls_revno,'w_bpm201u',g_s_empno,ls_jobcode,ls_msg)
				idw_22.retrieve(ls_xyear,ls_revno,idw_20.getitemstring(1,"xplant"),idw_20.getitemstring(1,"div"),idw_22.object.itno[1])
				uo_status.st_message.text = f_message("U010")    //저장이 되었습니다.
			else 
				uo_status.st_message.text = f_message("U020")   //inv101 insert error
			end if	
end choose

COMMIT USING SQLCA;       
return
SetPointer(Arrow!)


end event

event ue_insert;call super::ue_insert;int    l_n_row, net
string ls_xyear, ls_revno, ls_xplant,ls_div,ls_msg

choose case i_n_tab_index
		 case 1
			IF idw_10.accepttext() = -1 THEN
				messagebox('확인','입력항목중 에러난곳 수정후 저장하세요!',Exclamation!)
				uo_status.st_message.text	= '입력항목중 에러난곳 수정후 저장하세요!'
				Return
			END IF
			ls_xyear = trim(idw_10.object.xyear[1])
			ls_revno = trim(idw_10.object.revno[1])
			IF f_bpmstcd_chk('150',ls_xyear,ls_revno, ls_msg) = -1  THEN   //tab별 진행상태확인
				messagebox('확인',ls_msg)
				uo_status.st_message.text	= ls_msg
				Return
			END IF
			
			
			idw_12.reset()
			idw_12.insertrow(0)
			idw_12.object.xyear[1] = ls_xyear
			idw_12.object.revno[1] = ls_revno
			
			idw_12.SetItemStatus(1, 0, Primary!, NotModified!)
			  
			
			f_Color_Protect( idw_12 )
			
  		   idw_12.setcolumn('itno')
			idw_12.setfocus( ) 
			wf_icon_onoff(true,true,true,true,false,false,false)
			uo_status.st_message.text = f_message('A070')  // 해당정보를 입력하십시오
		 
		case 2
			IF idw_20.accepttext() = -1 THEN
				messagebox('확인','입력항목중 에러난곳 수정후 저장하세요!',Exclamation!)
				uo_status.st_message.text	= '입력항목중 에러난곳 수정후 저장하세요!'
				Return
			END IF
			ls_xyear = trim(idw_20.object.xyear[1])
			ls_revno = trim(idw_20.object.revno[1])
			IF f_bpmstcd_chk('150',ls_xyear,ls_revno,ls_msg) = -1  THEN   //tab별 진행상태확인
				messagebox('확인',ls_msg)
				uo_status.st_message.text	= ls_msg
				Return
			END IF
			
			idw_20.setitemstatus(1,0,primary!,datamodified!)
 			if f_mandantory_chk(idw_20) = -1  then              // 필수입력 항목 Editing
				return
			end if
         ls_xyear = trim(idw_20.object.xyear[1])
			ls_revno = trim(idw_20.object.revno[1])
			ls_xplant = trim(idw_20.object.xplant[1])
			ls_div = trim(idw_20.object.div[1])						

			idw_22.insertrow(0)
			idw_22.object.xyear[1] = ls_xyear
			idw_22.object.revno[1] = ls_revno
			////// 제품 선택 
			idw_22.getchild("pdcd",idwc_1)      
			idwc_1.SetTransObject(sqlca)	
			idwc_1.retrieve(ls_xplant,ls_div)
			idw_22.setfocus() 
  		   idw_22.setcolumn("itno")
			wf_icon_onoff(true,true,true,true,false,false,false)
			uo_status.st_message.text = f_message('A070')  // 해당정보를 입력하십시오

end choose

end event

event ue_delete;long ll_cntsum,ll_currow, ll_cnt, ll_rcnt
integer li_rtn 
string ls_itno, ls_div, ls_plant, ls_frdt, ls_cls, ls_srce, ls_msg
string ls_xyear, ls_revno

setpointer(hourglass!)

choose case i_n_tab_index
		case 1
			iF idw_10.accepttext() = -1  THEN
				MessageBox('확인','조회조건자료에 오류발생! 확인하세요!')
				uo_status.st_message.text = '조회조건자료에 오류발생! 확인하세요!'
				Return
			END IF

         ls_xyear = trim(idw_10.object.xyear[1])
			ls_revno = trim(idw_10.object.revno[1])
			IF f_bpmstcd_chk('150',ls_xyear,ls_revno, ls_msg) = -1  THEN  //상태확인
			   MessageBox('확인',ls_msg)
				uo_status.st_message.text = ls_msg
				Return
			END IF
			
			
			ll_currow = idw_11.getrow()
			ls_itno = idw_11.object.itno[ll_currow]
			
			select count(*) into :ll_cnt
			from pbbpm.bpm503
			where xyear = :ls_xyear
			and   revno = :ls_revno
			and   itno = :ls_itno;
			IF ll_cnt > 0  THEN
				MessageBox('확인','품목상세정보가 있습니다. 먼저 삭제후 작업하세요!')
				uo_status.st_message.text = '품목상세정보가 있습니다. 먼저 삭제후 작업하세요!'
				Return
			END IF
//			if f_inv101_item_chk(ls_itno) = -1 then
//				messagebox("확인!","품번" + ls_itno + " 는(은) 상세정보 등록품목, 삭제할 수 없습니다.")
//				return
//			end if
			
			li_rtn = messagebox("알림", ls_itno + " 를" + f_message("D050"),question!,yesno!,1)   //정말삭제하시겠습니까?
			if li_rtn = 2 then
				uo_status.st_message.text = f_message("D030")   //삭제가 취소되었습니다.
				return 0
			end if
						
			// deleted row
			idw_11.DeleteRow(ll_currow)
         idw_12.DeleteRow(1)
			
			// delete Update
			li_rtn = idw_12.update(true,false)
			if li_rtn = 1 then 
				f_bpm_job_start(ls_xyear,ls_revno,'w_bpm201u',g_s_empno,'D','품번:' + ls_itno + ' 기본정보 삭제')
				idw_12.ResetUpdate()
				commit using sqlca;
				uo_status.st_message.text = f_message("D010")   //삭제되었습니다.
			else
				rollback using sqlca;
				uo_status.st_message.text = f_message("D020") //삭제실패 정보시스템으로 연락바랍니다.
			end if
	case 2
		iF idw_12.accepttext() = -1  THEN
				MessageBox('확인','조회조건자료에 오류발생! 확인하세요!')
				uo_status.st_message.text = '조회조건자료에 오류발생! 확인하세요!'
				Return
			END IF

         ls_xyear = trim(idw_20.object.xyear[1])
			ls_revno = trim(idw_20.object.revno[1])
			IF f_bpmstcd_chk('150',ls_xyear,ls_revno,ls_msg) = -1  THEN  //상태확인
			   MessageBox('확인',ls_msg)
				uo_status.st_message.text = ls_msg
				Return
			END IF
			uo_status.st_message.text = '삭제할 자료 확인중...'
			IF idw_21.rowcount() = 0  THEN
				MessageBox('확인','조회후 자료를 선택하세요!')
				uo_status.st_message.text = '조회후 자료를 선택하세요!'
				Return
			END IF
			IF idw_22.rowcount() = 0  or idw_22.getitemstatus(1,0,Primary!) = Newmodified! THEN
				MessageBox('확인','삭제할 자료를 선택하세요!')
				uo_status.st_message.text = '삭제할 자료를 선택하세요!'
				Return
			END IF
			
			ll_currow = idw_21.getrow()
			ls_plant  = trim(idw_22.object.xplant[1])
			ls_div    = trim(idw_22.object.div[1])
			ls_itno   = trim(idw_22.object.itno[1])
			ls_cls    = trim(idw_22.object.cls[1])
			ls_srce   = trim(idw_22.object.srce[1])
			//사업계획BOM 확인
			select count(*) into :ll_rcnt
			from pbbpm.bpm504
			where pcmcd = '01'
			and   xyear = :ls_xyear
			and   revno = :ls_revno
			and   plant = :ls_plant
			and   pdvsn = :ls_div
			and   (ppitn = :ls_itno  or pcitn = :ls_itno);
			if ll_rcnt > 0   then
				messagebox('확인','지역/공장:' + ls_plant + ls_div + ' 품번' + ls_itno + ' 는(은) 사업계획BOM에 등록된 품목입니다. 삭제할수 없습니다.')
				uo_status.st_message.text = '지역/공장:' + ls_plant + ls_div + ' 품번' + ls_itno + ' 는(은) 사업계획BOM에 등록된 품목입니다. 삭제할수 없습니다.'
				return
			end if
			
			
			li_rtn = messagebox("알림", ls_itno + " 를" + f_message("D050"),question!,yesno!,1)   //정말삭제하시겠습니까?
			if li_rtn = 2 then
				uo_status.st_message.text = f_message("D030")   //삭제가 취소되었습니다.
				return 0
			end if
												
			idw_21.DeleteRow(ll_currow)
         idw_22.DeleteRow(1)
			
			// delete Update
			li_rtn = idw_22.update(true,false)
			if li_rtn = 1 then 
				f_bpm_job_start(ls_xyear,ls_revno,'w_bpm201u',g_s_empno,'D','지역/공장:' + ls_plant + ls_div + ' 품번:' + ls_itno + ' 품목상세정보 삭제')
				idw_22.ResetUpdate()
            uo_status.st_message.text = f_message("D010")   //삭제되었습니다.
			else
				uo_status.st_message.text = f_message("D020")   //삭제실패 정보시스템으로 연락바랍니다.
			end if
						
End choose

SetPointer(Arrow!)



end event

event open;call super::open;This.Event Post ue_open_after()

end event

event ue_dprint;call super::ue_dprint;f_screen_print(This)
end event

type uo_status from w_origin_sheet01`uo_status within w_bpm201u
integer y = 2492
integer width = 4617
integer height = 88
integer taborder = 20
end type

type tab_1 from tab within w_bpm201u
integer x = 5
integer y = 36
integer width = 4599
integer height = 2448
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;i_n_tab_index = newindex

Choose Case newindex
			
	case 1
		if idw_11.rowcount() > 0 then
         wf_icon_onoff(true,true,true,true,false,false,true)    //I,A,U,D,P
		else
			wf_icon_onoff(true,true,false,false,false,false,true) //I,A,U,D,P
		end if
	case 2	
		if idw_21.rowcount() > 0 then
         wf_icon_onoff(true,true,true,true,false,false,true)    //I,A,U,D,P
		else
			wf_icon_onoff(true,true,false,false,false,false,true) //I,A,U,D,P
		end if
	case 3	
		if idw_31.rowcount() > 0 then
         wf_icon_onoff(true,false,false,false,false,false,true)    //I,A,U,D,P
		else
			wf_icon_onoff(true,false,false,false,false,false,true) //I,A,U,D,P
		end if	
				
End Choose


end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4562
integer height = 2332
long backcolor = 12632256
string text = "품목기본정보 등록"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_1 cb_1
pb_5 pb_5
cb_6 cb_6
cb_5 cb_5
cb_3 cb_3
st_1 st_1
dw_10 dw_10
cb_2 cb_2
dw_11 dw_11
dw_12 dw_12
end type

on tabpage_1.create
this.cb_1=create cb_1
this.pb_5=create pb_5
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_3=create cb_3
this.st_1=create st_1
this.dw_10=create dw_10
this.cb_2=create cb_2
this.dw_11=create dw_11
this.dw_12=create dw_12
this.Control[]={this.cb_1,&
this.pb_5,&
this.cb_6,&
this.cb_5,&
this.cb_3,&
this.st_1,&
this.dw_10,&
this.cb_2,&
this.dw_11,&
this.dw_12}
end on

on tabpage_1.destroy
destroy(this.cb_1)
destroy(this.pb_5)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.dw_10)
destroy(this.cb_2)
destroy(this.dw_11)
destroy(this.dw_12)
end on

type cb_1 from commandbutton within tabpage_1
boolean visible = false
integer x = 3909
integer y = 148
integer width = 338
integer height = 100
integer taborder = 110
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "관리자용"
end type

event clicked;SetPointer(hourglass!)

String   ls_xyear, ls_revno, ls_msg
Long     ll_row, ll_rcnt, ll_rcnt1
Integer  li_rtn, li_ok

////부서코드확인
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('확인','생성작업에 대한 권한이 없습니다!')
	uo_status.st_message.text = '생성작업에 대한 권한이 없습니다!'
	Return
END IF

IF idw_10.accepttext() = -1  THEN
	MessageBox('확인','조회조건자료에 오류발생! 확인하세요!')
	uo_status.st_message.text = '조회조건자료에 오류발생! 확인하세요!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])
IF ls_xyear = ''  THEN
	MessageBox('확인','사업계획년도를 확인하세요!')
	uo_status.st_message.text = '사업계획년도를 확인하세요!'
	Return
END IF
IF ls_revno = ''  THEN
	MessageBox('확인','사업계획년도/버전을 확인하세요!')
	uo_status.st_message.text = '사업계획년도/버전을 확인하세요!'
	Return
END IF

IF f_bpmstcd_chk('150',ls_xyear,ls_revno,ls_msg) = -1  THEN  //상태확인
	MessageBox('확인',ls_msg)
	uo_status.st_message.text = ls_msg
	//Return
END IF


select count(*)
   into :ll_rcnt
from pbbpm.bpm502
where xyear = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('확인','사업계획품목 기본정보 자료없음')
	uo_status.st_message.text = '사업계획품목 기본정보 자료없음'
	Return
end if

li_ok = MessageBox('확인','생성작업을 시작합니다! 확인키를 누르세요!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '생성작업이 취소되었습니다.'
	Return
END IF					 


uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목기본정보(BPM502) 삭제중...'
sqlca.autocommit = false

//if ll_rcnt > 0 then
	delete from pbbpm.bpm502
	where xyear = :ls_xyear
	and   revno = :ls_revno;
	if sqlca.sqlcode <> 0 then
		MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목기본정보(BPM502) 기존자료 삭제중 오류발생! 급히 연락바랍니다.')
		uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목기본정보(BPM502) 기존자료 삭제중 오류발생! 급히 연락바랍니다.'
		messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
		rollback using sqlca;
		sqlca.autocommit = true
		Return
	end if
	
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목상세정보(BPM503) 삭제중...'
	delete from pbbpm.bpm503
	where xyear = :ls_xyear
	and   revno = :ls_revno;
	if sqlca.sqlcode <> 0 then
		MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목상세정보(BPM503) 기존자료 삭제중 오류발생! 급히 연락바랍니다.')
		uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목상세정보(BPM503) 기존자료 삭제중 오류발생! 급히 연락바랍니다.'
		messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
		rollback using sqlca;
		sqlca.autocommit = true
		Return
	end if
//end if
commit using sqlca;
sqlca.autocommit = true
SetPointer(arrow!)
uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목정보(BPM502,503) 삭제완료.'
return

end event

type pb_5 from picturebutton within tabpage_1
integer x = 4320
integer y = 60
integer width = 155
integer height = 132
integer taborder = 50
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;
If idw_11.RowCount( ) = 0 Then
	MessageBox('확인!', '엑셀로 저장할 정보가 없습니다. 조회후 작업하세요.')
	uo_status.st_message.text = '엑셀로 저장할 정보가 없습니다. 조회후 작업하세요.'
	Return
End If
f_Save_To_Excel( idw_11)
setpointer(arrow!)
return



		
	

end event

type cb_6 from commandbutton within tabpage_1
integer x = 3634
integer y = 44
integer width = 361
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "확정취소"
end type

event clicked;SetPointer(hourglass!)

String   ls_xyear, ls_revno, ls_msg, ls_stcd
Long     ll_row, ll_rcnt
Integer  li_rtn, li_ok

////부서코드확인
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('확인','생성작업에 대한 권한이 없습니다!')
	uo_status.st_message.text = '생성작업에 대한 권한이 없습니다!'
	Return
END IF
IF idw_10.accepttext() = -1  THEN
	MessageBox('확인','조회조건자료에 오류발생! 확인하세요!')
	uo_status.st_message.text = '조회조건자료에 오류발생! 확인하세요!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])

IF f_bpmstcd_chk1('150',ls_xyear,ls_revno, ls_msg) = -1  THEN  //상태확인
	MessageBox('확인',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

////품목단가 확정확인
select coalesce(max(taskstatus),'')
into :ls_stcd
from pbbpm.bpm519
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '200';
IF ls_stcd = 'C'  THEN
	MessageBox('확인','사업계획 품목단가정보가 확정되었습니다. 품목단가정보 확정취소후 작업하세요!')
	uo_status.st_message.text = '사업계획 품목단가정보가 확정되었습니다. 품목단가정보 확정취소후 작업하세요!'
	Return	 
END IF

li_ok = MessageBox('확인','확정취소합니다! 확인키를 누르세요!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '작업이 취소되었습니다.'
	Return
END IF					 


update pbbpm.bpm519
   set taskstatus = 'G'
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '150';

if sqlca.sqlcode <> 0 then
	MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목정보상태(BPM519) 자료 확정중 오류발생! 급히 연락바랍니다.')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목정보상태(BPM519) 자료 확정중 오류발생! 급히 연락바랍니다.'
	messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if

f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm201u',g_s_empno,'X','품목기본,상세정보 자료확정 취소')

uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목정보 확정취소 완료. '
SetPointer(arrow!)
return

end event

type cb_5 from commandbutton within tabpage_1
integer x = 2875
integer y = 44
integer width = 361
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "자료추가"
end type

event clicked;SetPointer(hourglass!)

String   ls_xyear, ls_revno, ls_msg
Long     ll_row, ll_rcnt, ll_rcnt1
Integer  li_rtn, li_ok

////부서코드확인
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('확인','생성작업에 대한 권한이 없습니다!')
	uo_status.st_message.text = '생성작업에 대한 권한이 없습니다!'
	Return
END IF

IF idw_10.accepttext() = -1  THEN
	MessageBox('확인','조회조건자료에 오류발생! 확인하세요!')
	uo_status.st_message.text = '조회조건자료에 오류발생! 확인하세요!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])
IF ls_xyear = ''  THEN
	MessageBox('확인','사업계획년도를 확인하세요!')
	uo_status.st_message.text = '사업계획년도를 확인하세요!'
	Return
END IF
IF ls_revno = ''  THEN
	MessageBox('확인','사업계획년도/버전을 확인하세요!')
	uo_status.st_message.text = '사업계획년도/버전을 확인하세요!'
	Return
END IF

if f_bpmstcd_chk('150',ls_xyear,ls_revno, ls_msg) = -1 then
	MessageBox('확인',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

select count(*)
   into :ll_rcnt
from pbbpm.bpm502
where xyear = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('작업불가','기존 자료가 없습니다. 생성작업을 사용하세요!')
	uo_status.st_message.text = '기존 자료가 없습니다. 생성작업을 사용하세요!'
	Return
end if
select count(*)
   into :ll_rcnt
from pbbpm.bpm503
where xyear = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt = 0  THEN
	MessageBox('확인','상세 정보가 없습니다. 연락바랍니다!')
	uo_status.st_message.text = '상세 정보가 없습니다. 연락바랍니다!'
	Return
end if


li_ok = MessageBox('확인','작업을 시작합니다! 확인키를 누르세요!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '작업이 취소되었습니다.'
	Return
END IF					 


uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목기본정보 추가 생성중...'
sqlca.autocommit = false 

SELECT  count(*) into :ll_rcnt
FROM PBinv.inv002 
where comltd = '01'
//and   gubun in ('0','2') 
and   itno not in (select itno from pbbpm.bpm502
                   where xyear = :ls_xyear
						 and   revno = :ls_revno)
and   itno in (select itno from pbinv.inv101 
               where comltd = '01'
					and   cls in ('10','20','24','50','30')) ;

SELECT  count(*) into :ll_rcnt1
FROM PBinv.inv101 
where comltd = '01'
and   cls in ('10','20','24','50','30')
and   xplant || div || trim(itno) not in (select xplant || div || trim(itno) from pbbpm.bpm503
                                          where  xyear = :ls_xyear
														and    revno = :ls_revno) ; 

IF ll_rcnt = 0  and ll_rcnt1 = 0 THEN
	MessageBox('확인','추가할 내역이 없습니다. 확인바랍니다!')
	uo_status.st_message.text = '추가할 내역이 없습니다. 확인바랍니다!'
	Return
end if														
														
insert into pbbpm.bpm502
        (XYEAR,    revno,      ITNO,        ITNM,       SPEC,           XUNIT,   
         XTYPE,     EXTD,      INPTID,     INPTDT,         UPDTID,   
         UPDTDT,    IPADDR,    MACADDR,    CRTDT,           gubun)  
SELECT  :ls_xyear,  :ls_revno,  ITNO,     ITNM,        SPEC,          XUNIT,   
         XTYPE,     EXTD,      INPTID,      INPTDT,        UPDTID,   
         UPDTDT,    IPADDR,    MACADDR,   :g_s_date,       gubun  
FROM PBinv.inv002 
where comltd = '01'
and   gubun in ('0','2')  
and   itno not in (select itno from pbbpm.bpm502
                   where xyear = :ls_xyear
						 and   revno = :ls_revno);
if sqlca.sqlcode <> 0 and sqlca.sqlnrows <= 0 then
	MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목기본정보(BPM502) 자료 생성중 오류발생! 급히 연락바랍니다.')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목기본정보(BPM502) 자료 생성중 오류발생! 급히 연락바랍니다.'
	messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if
uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목상세정보 추가 생성중...'

insert into pbbpm.bpm503
        (XYEAR,     revno,        XPLANT,        DIV,         ITNO,   
         CLS,        SRCE,        PDCD,        XUNIT,   
         COSTDIV,    XPLAN,       MLAN,        CONVQTY,   
         COMCD,       EXTD,       INPTID,       INPTDT,   
         UPDTID,     UPDTDT,      IPADDR,       MACADDR,   
         CRTDT  )
  
SELECT   :ls_XYEAR,  :ls_revno,   XPLANT,    DIV,         ITNO,   
         CLS,        SRCE,        PDCD,        XUNIT,   
         COSTDIV,    XPLAN,       MLAN,        CONVQTY,   
         COMCD,       EXTD,       INPTID,       INPTDT,   
         UPDTID,     UPDTDT,      IPADDR,       MACADDR,   
         :g_s_date  
FROM PBinv.inv101 
where comltd = '01'
and   cls in ('10','20','24','50','30')
and   xplant || div || trim(itno) not in (select xplant || div || trim(itno) from pbbpm.bpm503
                                          where  xyear = :ls_xyear
														and    revno = :ls_revno)                                         
;
if sqlca.sqlcode <> 0 and sqlca.sqlnrows <= 0 then
	MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목상세정보(BPM503) 자료 생성중 오류발생! 급히 연락바랍니다.')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목상세정보(BPM503) 자료 생성중 오류발생! 급히 연락바랍니다.'
	messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if


f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm201u',g_s_empno,'E','품목기본,상세정보 추가작업완료')

sqlca.autocommit = true


uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목기본정보:' + &
         string(ll_rcnt) + '개, 상세정보:' + string(ll_rcnt1) + '개 추가 생성완료.' 
SetPointer(arrow!)
return

end event

type cb_3 from commandbutton within tabpage_1
integer x = 3255
integer y = 44
integer width = 361
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "자료확정"
end type

event clicked;SetPointer(hourglass!)

String   ls_xyear, ls_revno, ls_msg, ls_stcd
Long     ll_row, ll_rcnt
Integer  li_rtn, li_ok

////부서코드확인
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('확인','생성작업에 대한 권한이 없습니다!')
	uo_status.st_message.text = '생성작업에 대한 권한이 없습니다!'
	Return
END IF
IF idw_10.accepttext() = -1  THEN
	MessageBox('확인','조회조건자료에 오류발생! 확인하세요!')
	uo_status.st_message.text = '조회조건자료에 오류발생! 확인하세요!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])

IF f_bpmstcd_chk('150',ls_xyear,ls_revno, ls_msg) = -1  THEN  //상태확인
	MessageBox('확인',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF

////환율 확정확인
select coalesce(max(taskstatus),'')
into :ls_stcd
from pbbpm.bpm519
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '100';
IF ls_stcd <> 'C'  THEN
	MessageBox('확인','사업계획 환율정보가 확정전입니다. 먼저 확정하세요!')
	uo_status.st_message.text = '사업계획 환율정보가 확정전입니다. 먼저 확정하세요!'
	Return	 
END IF
////부대비율 확정확인
select coalesce(max(taskstatus),'')
into :ls_stcd
from pbbpm.bpm519
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '110';
IF ls_stcd <> 'C'  THEN
	MessageBox('확인','사업계획 부대비율정보가 확정전입니다. 먼저 확정하세요!')
	uo_status.st_message.text = '사업계획 부대비율정보가 확정전입니다. 먼저 확정하세요!'
	Return	 
END IF

select count(*)
   into :ll_rcnt
from pbbpm.bpm502
where xyear = :ls_xyear
and   revno = :ls_revno;

IF ll_rcnt = 0  THEN
	MessageBox('확인','확정할 자료가 없습니다! 확인하세요!')
	uo_status.st_message.text = '확정할 자료가 없습니다! 확인하세요!'
	Return	 
END IF

li_ok = MessageBox('확인','확정합니다! 확인키를 누르세요!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '작업이 취소되었습니다.'
   Return
END IF					 

update pbbpm.bpm519
   set taskstatus = 'C'
where comltd = '01'
and   xyear = :ls_xyear
and   revno = :ls_revno
and   seqno = '150';

if sqlca.sqlcode <> 0 then
	MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목정보상태(BPM519) 자료 확정중 오류발생! 급히 연락바랍니다.')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목정보상태(BPM519) 자료 확정중 오류발생! 급히 연락바랍니다.'
	messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	Return
end if

f_bpm_job_start(ls_xyear,ls_revno,'w_bpm201u',g_s_empno,'T','품목기본,상세정보 자료확정')

uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목기본,상세정보 확정완료. '
SetPointer(arrow!)
return




end event

type st_1 from statictext within tabpage_1
integer x = 41
integer y = 164
integer width = 3328
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "(기초자료생성-자재관리 품목기본정보의 직접재전체품목, 자재관리 품목상세정보-계정10,20,24,50,30)"
boolean focusrectangle = false
end type

type dw_10 from datawindow within tabpage_1
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 36
integer width = 2473
integer height = 116
integer taborder = 20
string title = "none"
string dataobject = "d_bpm201u_10"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;If key = KeyEnter! Then
	iw_sheet.TriggerEvent('ue_retrieve')
End If
end event

event constructor;idw_10 = this
this.settransobject(sqlca)

//This.GetChild('div', idwc_1)
//idwc_1.SetTransObject(SQLCA)
//idwc_1.Retrieve('D')
This.InsertRow(0)
f_pur040_nullchk03(this)

//this.object.frdt[1] = f_pur040_relativedate(g_s_date,-10)   //mid(g_s_date,1,4) + '0101'



end event

event itemerror;return 1
end event

event getfocus;f_pur040_toggle(handle(this),'ENG')
end event

type cb_2 from commandbutton within tabpage_1
integer x = 2505
integer y = 44
integer width = 361
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "자료생성"
end type

event clicked;SetPointer(hourglass!)

String   ls_xyear, ls_revno, ls_msg
Long     ll_row, ll_rcnt, ll_rcnt1
Integer  li_rtn, li_ok

////부서코드확인
IF g_s_deptcd <> '1200' and g_s_deptcd <> '2300'  THEN
	MessageBox('확인','생성작업에 대한 권한이 없습니다!')
	uo_status.st_message.text = '생성작업에 대한 권한이 없습니다!'
	Return
END IF

IF idw_10.accepttext() = -1  THEN
	MessageBox('확인','조회조건자료에 오류발생! 확인하세요!')
	uo_status.st_message.text = '조회조건자료에 오류발생! 확인하세요!'
	Return
END IF

ls_xyear = trim(idw_10.object.xyear[1])
ls_revno = trim(idw_10.object.revno[1])
IF ls_xyear = ''  THEN
	MessageBox('확인','사업계획년도를 확인하세요!')
	uo_status.st_message.text = '사업계획년도를 확인하세요!'
	Return
END IF
IF ls_revno = ''  THEN
	MessageBox('확인','사업계획년도/버전을 확인하세요!')
	uo_status.st_message.text = '사업계획년도/버전을 확인하세요!'
	Return
END IF


IF f_bpmstcd_chk('150',ls_xyear,ls_revno, ls_msg) = -1  THEN  //상태확인
	MessageBox('확인',ls_msg)
	uo_status.st_message.text = ls_msg
	Return
END IF


select count(*)
   into :ll_rcnt
from pbbpm.bpm502
where xyear = :ls_xyear
and   revno = :ls_revno;
IF ll_rcnt > 0  THEN
	MessageBox('작업불가','기존 자료가 있습니다. 추가기능을 사용하세요!')
	uo_status.st_message.text = '기존 자료가 있습니다. 추가기능을 사용하세요!'
	Return
end if

li_ok = MessageBox('확인','생성작업을 시작합니다! 확인키를 누르세요!', &
					 Exclamation!, OKCancel!, 2)
IF li_ok <> 1 THEN
	uo_status.st_message.text = '생성작업이 취소되었습니다.'
	Return
END IF					 


uo_status.st_message.text = ls_xyear + '년 사업계획 품목기본정보 생성중...'
sqlca.autocommit = false

//if ll_rcnt > 0 then
//	delete from pbbpm.bpm502
//	where xyear = :ls_xyear;
//	if sqlca.sqlcode <> 0 then
//		MessageBox('확인',ls_xyear + '년 사업계획 품목기본정보(BPM502) 기존자료 삭제중 오류발생! 급히 연락바랍니다.')
//		uo_status.st_message.text = ls_xyear + '년 사업계획 품목기본정보(BPM502) 기존자료 삭제중 오류발생! 급히 연락바랍니다.'
//		messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
//		rollback using sqlca;
//		sqlca.autocommit = true
//		Return
//	end if
//end if

insert into pbbpm.bpm502
        (XYEAR,    revno,      ITNO,       ITNM,    SPEC,       XUNIT,   
         XTYPE,     EXTD,      INPTID,     INPTDT,        UPDTID,   
         UPDTDT,    IPADDR,    MACADDR,    CRTDT, gubun)  
SELECT  :ls_xyear,  :ls_revno,  ITNO,       ITNM,    SPEC,       XUNIT,   
         XTYPE,     EXTD,      INPTID,     INPTDT,        UPDTID,   
         UPDTDT,    IPADDR,    MACADDR,   :g_s_date, gubun  
FROM PBinv.inv002 
where comltd = '01'
//and   gubun in ('0','2')
and   itno in (select itno from pbinv.inv101 
               where comltd = '01'
					and   cls in ('10','20','24','50','30'))
;  
if sqlca.sqlcode <> 0 then
	MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목기본정보(BPM502) 자료 생성중 오류발생! 급히 연락바랍니다.')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목기본정보(BPM502) 자료 생성중 오류발생! 급히 연락바랍니다.'
	messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if

uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목상세정보 생성중...'

insert into pbbpm.bpm503
        (XYEAR,     revno,       XPLANT,        DIV,         ITNO,   
         CLS,        SRCE,        PDCD,        XUNIT,   
         COSTDIV,    XPLAN,       MLAN,        CONVQTY,   
         COMCD,       EXTD,       INPTID,       INPTDT,   
         UPDTID,     UPDTDT,      IPADDR,       MACADDR,   
         CRTDT  )
  
SELECT   :ls_XYEAR,  :ls_revno,   XPLANT,    DIV,         ITNO,   
         CLS,        SRCE,        PDCD,        XUNIT,   
         COSTDIV,    XPLAN,       MLAN,        CONVQTY,   
         COMCD,       EXTD,       INPTID,       INPTDT,   
         UPDTID,     UPDTDT,      IPADDR,       MACADDR,   
         :g_s_date  
FROM PBinv.inv101 
where comltd = '01'
and   cls in ('10','20','24','50','30');
if sqlca.sqlcode <> 0 then
	MessageBox('확인',ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목상세정보(BPM503) 자료 생성중 오류발생! 급히 연락바랍니다.')
	uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목상세정보(BPM503) 자료 생성중 오류발생! 급히 연락바랍니다.'
	messagebox('시스템 담당확인','sqlerrtext:' + string(sqlca.sqlcode) + ':' + string(sqlca.sqlerrtext))
	rollback using sqlca;
	sqlca.autocommit = true
	Return
end if

sqlca.autocommit = true

f_bpm_job_start(ls_xyear,ls_revno, 'w_bpm201u',g_s_empno,'A','품목기본,상세정보 자료생성 작업완료')

sqlca.autocommit = true

select count(*)
   into :ll_rcnt1
from pbbpm.bpm503
where xyear = :ls_xyear
and   revno = :ls_revno;

select count(*)
   into :ll_rcnt
from pbbpm.bpm502
where xyear = :ls_xyear
and   revno = :ls_revno;

uo_status.st_message.text = ls_xyear + '년 REV:' + ls_revno + '번 사업계획 품목기본정보:' + &
         string(ll_rcnt) + '개, 상세정보:' + string(ll_rcnt1) + '개 생성완료.' 
SetPointer(arrow!)
return

end event

type dw_11 from datawindow within tabpage_1
integer y = 256
integer width = 4526
integer height = 1804
integer taborder = 90
string title = "none"
string dataobject = "d_bpm201u_11"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;// column별 sorting
THIS.SetRedraw(False)
IF row < 1 THEN
   IF f_getobjectpoint_head(THIS,is_col_nm) = 1 THEN
   	f_dw_sort(THIS,is_col_nm)
   END IF
END IF
THIS.SetRedraw(True) 

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
end if	

long ll_rcnt
string ls_xyear, ls_revno, ls_itno
ls_xyear = trim(this.object.xyear[row])
ls_revno = trim(this.object.revno[row])
ls_itno = trim(this.object.itno[row])
idw_12.reset()
idw_12.retrieve(ls_xyear, ls_revno, ls_itno)



end event

event constructor;idw_11 = this
this.settransobject(sqlca)

//// BOM 단위 선택
//This.getchild("xunit",i_dwc_unit) 
//i_dwc_unit.SetTransObject(sqlca)	
//i_dwc_unit.retrieve('DAC070')
//
//// ITEM TYPE 선택
//This.getchild("xtype",i_dwc_type) 
//i_dwc_type.SetTransObject(sqlca)	
//i_dwc_type.retrieve('INV220')

end event

type dw_12 from datawindow within tabpage_1
integer y = 2072
integer width = 4530
integer height = 260
integer taborder = 50
string title = "none"
string dataobject = "d_bpm201u_12"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;//항목 입력/수정시 Data Check 
String   ls_colnm, ls_itno, ls_null, ls_srdata
Int      li_cnt
string  ls_xyear, ls_revno
CHOOSE CASE dwo.Name
   CASE 'itno'         
		if isnull(data) then 
			data = ''
		end if
		
      ls_xyear = trim(idw_12.object.xyear[1])
		ls_revno = trim(idw_12.object.revno[1])
		SELECT count(*)
		INTO :li_cnt
		FROM PBbpm.bpm502 A
		WHERE xyear = :ls_xyear
		and   revno = :ls_revno
		and  ITNO   = :data;
		IF  li_cnt > 0  THEN 
			 Messagebox("확인", "입력한 품번은 기 등록된 품번입니다! ", Exclamation!)
			 uo_status.st_message.text = "입력한 품번은 기 등록된 품번입니다! "
			 RETURN 1
		end if
		This.SetColumn( 'itnm' )
		
	CASE 'itnm'
		
		IF Pos(data, '"', 1) <> 0 then
			//ldw_dw1.setitem(1, "itnm", '')
			Messagebox("확인", "품명에 ~"은 입력이 불가능합니다! ", Exclamation!)
			Return 1
		End if
		
		IF Pos(data, '~'', 1) <> 0 then
			//ldw_dw1.setitem(1, "itnm", '')
			MessageBox("확인!", "품명에 ~'은 입력이 불가능합니다!", Exclamation!)
			Return 1
		End if
	
END CHOOSE

end event

event constructor;idw_12 = this
this.settransobject(sqlca)


// BOM 단위 선택
This.getchild("xunit",idwc_1) 
idwc_1.SetTransObject(sqlca)	
idwc_1.retrieve('DAC070')

// ITEM TYPE 선택
This.getchild("xtype",idwc_1) 
idwc_1.SetTransObject(sqlca)	
idwc_1.retrieve('INV220')



end event

event itemerror;This.SetFocus( )

Return 1
end event

event itemfocuschanged;string ls_data
Choose Case dwo.Name 
		CASE "itnm"
		   ls_data = this.Object.itnm[row]
		IF Pos(ls_data, '"', 1) <> 0 then
			Messagebox("확인", "품명에 ~"를 입력은 불가능합니다! ", Exclamation!)
			Return 1
		End if
End Choose
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4562
integer height = 2332
long backcolor = 12632256
string text = "품목상세정보등록"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
pb_6 pb_6
dw_22 dw_22
dw_21 dw_21
dw_20 dw_20
pb_2 pb_2
end type

on tabpage_2.create
this.pb_6=create pb_6
this.dw_22=create dw_22
this.dw_21=create dw_21
this.dw_20=create dw_20
this.pb_2=create pb_2
this.Control[]={this.pb_6,&
this.dw_22,&
this.dw_21,&
this.dw_20,&
this.pb_2}
end on

on tabpage_2.destroy
destroy(this.pb_6)
destroy(this.dw_22)
destroy(this.dw_21)
destroy(this.dw_20)
destroy(this.pb_2)
end on

type pb_6 from picturebutton within tabpage_2
integer x = 4119
integer y = 32
integer width = 155
integer height = 132
integer taborder = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;
If idw_21.RowCount( ) = 0 Then
	MessageBox('확인!', '엑셀로 저장할 정보가 없습니다. 조회후 작업하세요.')
	uo_status.st_message.text = '엑셀로 저장할 정보가 없습니다. 조회후 작업하세요.'
	Return
End If
f_Save_To_Excel( idw_21)
setpointer(arrow!)
return



		
	

end event

type dw_22 from datawindow within tabpage_2
integer y = 1980
integer width = 4553
integer height = 340
integer taborder = 60
string title = "none"
string dataobject = "d_bpm201u_22"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;idw_22 = this
This.SetTransObject(Sqlca)

//// 계정 선택
//This.getchild("cls",idwc_1)  
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('INV021')
//	
//// 구입선 선택
//This.getchild("srce",idwc_1) 
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('10')

////// 제품 선택 
This.getchild("pdcd",idwc_1)      
idwc_1.SetTransObject(sqlca)	
idwc_1.retrieve('','')

// 자재담당
This.getchild("mlan",idwc_1) 
idwc_1.SetTransObject(sqlca)	
idwc_1.retrieve('INV070')
	
//// 구매담당
//This.getchild("xplan",idwc_1) 
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('INV050')

//// 재고단위
//This.getchild("xunit",idwc_1) 
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('DAC070')
	
//// abc 코드
//This.getchild("abccd",idwc_1) 
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('INV225')
//
//// 불출주기
//This.getchild("iscd",idwc_1) 
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('INV100')
end event

event itemchanged;DataWindowChild  cdw_1
String ls_xyear,ls_revno, ls_data, ls_colnm, ls_null, ls_xplant, ls_div, ls_comcd, ls_itno,ls_xunit
Int li_rtn, li_cnt
long ll_rcnt

idw_20.accepttext()
ls_xyear = idw_20.GetItemString(1,'xyear')
ls_revno = idw_20.GetItemString(1,'revno')
ls_xplant = idw_20.GetItemString(1,'xplant')
ls_div   = idw_20.GetItemString(1,'div')


Choose Case	dwo.Name
	Case 'itno'
		if isnull(data) then
			data = ''
		end if
		select count(*), coalesce(max(xunit),'') 
		   into :ll_rcnt, :ls_xunit
		from  pbbpm.bpm502
		where xyear = :ls_xyear
		and   revno = :ls_revno
		and   itno = :data;
		If ll_rcnt = 0 Then   // 미등록(ItemMaster Table) 품목
			MessageBox("확인!", "품목 기본정보등록이 되지 않은 품번입니다.", Exclamation!)
			uo_status.st_message.text = "품목 기본정보등록이 되지 않은 품번입니다."
			Return 1
		End If
		select count(*) into :ll_rcnt
		from  pbbpm.bpm503
		where xyear = :ls_xyear
		and   revno = :ls_revno
		and   xplant = :ls_xplant
		and   div = :ls_div
		and   itno = :data;
		If ll_rcnt > 0 Then   // 미등록(ItemMaster Table) 품목
			MessageBox("확인!", "품목 상세정보에 이미 등록된 품번입니다.")
			uo_status.st_message.text = "품목 상세정보에 이미 등록된 품번입니다."
			Return 1
		End If
		
//		ls_comcd = f_get_comcd(data)
//		
//		If ls_comcd = 'Y' Then
//			li_rtn = messagebox("알림", "고객사유상사급품으로 이미 입력된 품번입니다!~n~r" &
//			                    +"입력시 자동으로 고객사유상사급품으로 등록하시겠습니까?",question!,yesno!,1)  
//			if li_rtn = 2 then
//				uo_status.st_message.text = "다른 품번을 재입력 바랍니다."
//				Return 1
//			else
//				this.object.mass[1]  ='M'
//				this.Object.xplan[1] ='7D'
//				this.Object.comcd[1] ='Y'
//				
//			end if
//		ELSEIF ls_comcd = 'O' Then
//			li_rtn = messagebox("알림", "고객사무상사급품으로 이미 입력된 품번입니다!~n~r" &
//			                    +"입력시 자동으로 고객사무상사급품으로 등록하시겠습니까?",question!,yesno!,1)  
//			if li_rtn = 2 then
//				uo_status.st_message.text = "다른 품번을 재입력 바랍니다."
//				Return 1
//			else
//				this.object.mass[1]  ='M'
//				this.Object.xplan[1] ='7D'
//				this.Object.comcd[1] ='O'
//				
//			end if
//		Else
//			this.object.mass[1]  ='N'
//			this.Object.xplan[1] =''
//			this.Object.comcd[1] ='N'
//		End if
		
		//this.Object.srce[1] = f_Get_Srce_Mst( data )   // 구입선.
		this.Object.xunit[1] = ls_xunit    // 단위.	
		
		This.SetColumn('cls')
		
	Case 'cls'                  // 계정에 따른 Editing Change 
		
		This.object.srce[1] = ' '
		
//		this.GetChild("srce",cdw_1)
//	   cdw_1.SetTransObject(Sqlca)
//	   cdw_1.Retrieve( data )
		
		If data = '40' then
			MessageBox("확인!","허용되지 않는 계정입니다.")     
			return 1
		End if
		
		//직접재로 등록된 품번은 저장품으로 등록 불가!
		//간접재 품목체계에 맞아야 한다.
//		IF data = '20' Or data = '24' then
//			
//			ls_itno = this.object.itno[1]
			
//			select count(itno) into :li_cnt
//			from pbinv.inv002
//			where comltd ='01' and itno = :ls_itno and gubun ='2';
//			
//			if li_cnt > 0 then 
//				MessageBox("확인!","직접재로 등록된 품번입니다.")     
//				return 1
//			End if
//		End if
		
//		If data = '30' or data = '35' Then
//			this.Object.pdcd.dddw.Name = "dddw_pdcdnm_104"
//			This.Modify("pdcd.dddw.AllowEdit = no")
//			This.Modify("pdcd.dddw.VScrollBar = yes")
//			This.Modify("pdcd.dddw.Percentwidth= 130")
//			This.Modify("pdcd.dddw.displaycolumn= 'compute_0001'")
//			This.Modify("pdcd.dddw.datacolumn= 'compute_0002'")
//			This.GetChild("pdcd",cdw_1)
//			cdw_1.SetTransObject(Sqlca)
//       	cdw_1.Retrieve(ls_xplant, ls_div)
//		else
//			This.Modify("pdcd.dddw.Name='dddw_pdcdnm_103'")
//			This.Modify("pdcd.dddw.AllowEdit = no")
//			This.Modify("pdcd.dddw.VScrollBar = yes")
//			This.Modify("pdcd.dddw.Percentwidth= 130")
//			This.Modify("pdcd.dddw.displaycolumn= 'compute_0001'")
//			This.Modify("pdcd.dddw.datacolumn= 'compute_0002'")
//			This.GetChild("pdcd",cdw_1)
//			cdw_1.SetTransObject(Sqlca)
//      	cdw_1.Retrieve(ls_xplant, ls_div)
//		end if
//		This.SetColumn('srce')
		
	Case 'srce'
		ls_itno = this.object.itno[1]
		if data = '01' then
			select count(itno) into :li_cnt
			from pbbpm.bpm503
			where xyear = :ls_xyear 
			and   revno = :ls_revno
			and itno = :ls_itno and srce <> '01';
			
			if li_cnt > 0 then 
				MessageBox("확인!","타공장에 내자로 등록된 품번입니다.")  
				this.object.srce[1] = ''
				return 1
			End if
		else
			select count(itno) into :li_cnt
			from pbbpm.bpm503
			where xyear = :ls_xyear
			and   revno = :ls_revno
			and itno = :ls_itno 
			and srce = '01';
			
			if li_cnt > 0 then 
				MessageBox("확인!","타공장에 외자로 등록된 품번입니다.")  
				this.object.srce[1] = ''				
				return 1
			End if
		end if
		if data = '01' then
			this.object.xplan.dddw.name = 'dddw_pur030_xplan1'
		else
			this.object.xplan.dddw.name = 'dddw_pur030_xplan5'
		end if
		This.GetChild("xplan",cdw_1)
		cdw_1.SetTransObject(Sqlca)
		cdw_1.Retrieve()
		This.SetColumn('pdcd')
	 CASE 'pdcd'  // 제품코드 Check
		
			String ls_Search_Syntax
			Int	 li_Chk
			Long   ll_Len
			
			if isnull(data) then
				data = ''
			end if
						
			ls_Search_Syntax = " cocode = '" + data + "'"
			This.GetChild( 'pdcd', cdw_1 )
			
			li_Chk = cdw_1.Find( ls_Search_Syntax, 1, cdw_1.RowCount( ) )
			
			If li_Chk = 0 Then  
				MessageBox("확인!", "제품(을)를 올바르게 입력하십시요.", Exclamation!)
				Return 
			End If	
			
			ls_Search_Syntax = ''
			li_Chk = 0
			
			If This.object.cls[1] = '30' Then
				
				ll_len = Len(Trim(Data))
				If ll_len < 3 Then 
					MessageBox("확인!", "완제품은 제품군이 3자리이상 입력해야 합니다.", Exclamation!)
					Return 1
				End If
				
			End If
			
	Case 'xunit'			
//			If (This.object.cls[1] = '10') And (This.object.srce[1] = '01') and (data = 'EA') then
//				MessageBox("확인!", "[외자관리요구사항] 순중량(Net Weight)을 입력하십시오.", Exclamation!)
//			End if
			
			iF ib_insert = False then //수정시..
							//내자는 구매단가 결정!, 외자는 발주존재시 단위변경 안되게.. '06,08,31 심,호
					if This.object.srce[1] = '01' then
						ls_itno = trim(This.object.itno[1])
						select count(*) into :ll_rcnt
						from pbpur.pur302
						where comltd = '01'
						and  itno = :ls_itno; 
						if ll_rcnt > 0 then
//					 if f_pur301_exist(This.object.itno[1]) = 1  then
						messagebox("확인!","외자구매요구 진행건으로 자재단위 변경불가!", Exclamation!)
						return 1
					end if
				elseif This.object.srce[1] = '02' or This.object.srce[1] = '04' then			
				// 품목 단가 존재건
				if wf_pur103_chk(This.object.itno[1]) = 1  then
						messagebox("확인!","품목단가가 존재함으로 자재단위 변경불가!", Exclamation!)
						return 1
					end if
				End if
			End if
				
END CHOOSE	




end event

event itemerror;//f_multi_Select( This, Row, 0 )
//This.SetItemStatus( Row, 0, Primary!, DataModified! )
This.SetFocus( )
Return 1
end event

event getfocus;f_toggle( handle(This), 'ENG' ) // 키보드 영문으로 설정...
end event

event retrieveend;This.Modify("itno.Tabsequence = 0")
This.Object.itno.Background.Color = 536870912        //Non-Edit, 회색
//This.Modify("cls.Tabsequence = 0")
//This.Object.cls.Background.Color = 536870912        //Non-Edit, 회색
//This.Modify("srce.Tabsequence = 0")
//This.Object.srce.Background.Color = 536870912        //Non-Edit, 회색
//This.Modify("pdcd.Tabsequence = 0")
//This.Object.pdcd.Background.Color = 536870912        //Non-Edit, 회색
end event

type dw_21 from datawindow within tabpage_2
integer x = 5
integer y = 256
integer width = 4553
integer height = 1712
integer taborder = 100
string title = "none"
string dataobject = "d_bpm201u_21"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;THIS.SetRedraw(False)
IF row < 1 THEN
   IF f_getobjectpoint_head(THIS,is_col_nm) = 1 THEN
   	f_dw_sort(THIS,is_col_nm)
   END IF
END IF
THIS.SetRedraw(True)

if row > 0 then
	idw_21.selectrow(0,false)
	idw_21.selectrow(row,true)
else
   return	
end if	

string ls_xyear, ls_revno
ls_xyear= trim(idw_21.object.xyear[row])
ls_revno= trim(idw_21.object.revno[row])
idw_22.reset()
if idw_22.retrieve(ls_xyear,ls_revno,idw_20.getitemstring(1,"xplant"),idw_20.getitemstring(1,"div"),idw_21.object.itno[row]) > 0 then
   if idw_21.object.srce[row] = '01' then
		idw_22.object.xplan.dddw.name = 'dddw_pur030_xplan1'
	else
		idw_22.object.xplan.dddw.name = 'dddw_pur030_xplan5'
	end if
	idw_22.GetChild("xplan",idwc_1)
	idwc_1.SetTransObject(Sqlca)
	idwc_1.Retrieve()
	ib_insert = False

	//Dec{2} ld_wcost
	//ld_wcost = f_get_iwcost(idw_20.getitemstring(1,"xplant") , idw_20.getitemstring(1,"div") , idw_21.object.itno[row] )
	//idw_22.setitem(1,"iwcost",ld_wcost)
	//
	wf_icon_onoff(true,true,true,true,true,false,false)
	uo_status.st_message.text	=	f_message("I010")		// 조회되었습니다.
end if
setpointer(arrow!)
return
end event

event constructor;idw_21 = this
This.SetTransObject(Sqlca)
//is_orgsql1 = This.getsqlselect()


//// 계정 선택
//This.getchild("cls",i_dwc_cls)  
//i_dwc_cls.SetTransObject(sqlca)	
//i_dwc_cls.retrieve('INV020')
//	
//// 구입선 선택
//This.getchild("srce",i_dwc_srce) 
//i_dwc_srce.SetTransObject(sqlca)	
//i_dwc_srce.retrieve('DAC040')
//
//// 자재담당	
//This.getchild("mlan",i_dwc_mlan) 
//i_dwc_mlan.SetTransObject(sqlca)	
//i_dwc_mlan.retrieve('INV070')
	
// 구매담당
//This.getchild("xplan",i_dwc_plan) 
//i_dwc_plan.SetTransObject(sqlca)	
//i_dwc_plan.retrieve('INV050')	

end event

type dw_20 from datawindow within tabpage_2
event ue_key_down pbm_dwnkey
integer y = 12
integer width = 3566
integer height = 248
integer taborder = 10
string title = "none"
string dataobject = "d_bpm201u_20"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key_down;If key = KeyEnter! Then
	iw_Sheet.TriggerEvent('ue_retrieve')
End If
end event

event itemchanged;String ls_data, ls_colnm, ls_null

This.AcceptText()
ls_colnm = This.GetColumnName()
IF ls_colnm = 'xplant' Then
   idw_20.SetItem(1,'div', ' ' ) //SetNull(ls_null))
   ls_data = idw_20.GetItemString(1,'xplant')
   idw_20.GetChild("div",idwc_1)
   idwc_1.SetTransObject(Sqlca)
   idwc_1.Retrieve(ls_data)
END IF

IF ls_colnm = 'div' Then
	idw_20.SetItem(1,'pdcd', ' ')
   idw_20.GetChild('pdcd', idwc_1)
   idwc_1.SetTransObject(Sqlca)
   idwc_1.Retrieve(data) 
END IF

IF ls_colnm = 'cls' Then
   idw_20.SetItem(1,'srce', ' ' ) //SetNull(ls_null))
   ls_data = idw_20.GetItemString(1,'cls')
   idw_20.GetChild("srce",idwc_1)
   idwc_1.SetTransObject(Sqlca)
   idwc_1.Retrieve(ls_data)
END IF
end event

event constructor;this.SetTransObject(Sqlca)
idw_20 = this
// 지역
//This.getchild("xplant",idwc_1)       
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('SLE220')
	
//// 공장
//This.getchild("div",idwc_1)  
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('D')

//// 제품 선택
This.getchild("pdcd",idwc_1)       
idwc_1.SetTransObject(sqlca)	
idwc_1.retrieve('')
//	
// 계정 선택
//This.getchild("cls",idwc_1)  
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('INV021')
	
//// 구입선 선택
//This.getchild("srce",idwc_1) 
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('10')


This.insertrow(0)
f_pur040_nullchk03(this)

end event

type pb_2 from picturebutton within tabpage_2
boolean visible = false
integer x = 4297
integer y = 16
integer width = 238
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string picturename = "C:\KDAC\bmp\search.gif"
string disabledname = "C:\KDAC\bmp\not_search.gif"
alignment htextalign = left!
end type

event clicked;
String ls_plant, ls_div, ls_itno

ls_plant = idw_20.getitemstring(1,"xplant")
ls_div	= idw_20.getitemstring(1,"div")
ls_itno  = Trim( idw_20.Object.itno[1] )

String ls_parm

If f_spacechk(ls_itno) = -1 Then
	ls_parm = ls_plant + ls_div
Else
	ls_parm = ls_plant + ls_div + ls_itno
End If

//OpenWithParm(w_itno_search_invres, ls_parm)
idw_20.Object.itno[1] = Message.StringParm
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4562
integer height = 2332
long backcolor = 12632256
string text = "작업이력조회"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
pb_1 pb_1
pb_4 pb_4
dw_3 dw_3
dw_2 dw_2
end type

on tabpage_3.create
this.pb_1=create pb_1
this.pb_4=create pb_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.Control[]={this.pb_1,&
this.pb_4,&
this.dw_3,&
this.dw_2}
end on

on tabpage_3.destroy
destroy(this.pb_1)
destroy(this.pb_4)
destroy(this.dw_3)
destroy(this.dw_2)
end on

type pb_1 from picturebutton within tabpage_3
integer x = 4000
integer y = 12
integer width = 155
integer height = 132
integer taborder = 70
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;
If idw_31.RowCount( ) = 0 Then
	MessageBox('확인!', '엑셀로 저장할 정보가 없습니다. 조회후 작업하세요.')
	uo_status.st_message.text = '엑셀로 저장할 정보가 없습니다. 조회후 작업하세요.'
	Return
End If
f_Save_To_Excel( idw_31)
setpointer(arrow!)
return



		
	

end event

type pb_4 from picturebutton within tabpage_3
boolean visible = false
integer x = 4297
integer y = 16
integer width = 238
integer height = 108
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string picturename = "C:\KDAC\bmp\search.gif"
string disabledname = "C:\KDAC\bmp\not_search.gif"
alignment htextalign = left!
end type

event clicked;
String ls_plant, ls_div, ls_itno

ls_plant = idw_20.getitemstring(1,"xplant")
ls_div	= idw_20.getitemstring(1,"div")
ls_itno  = Trim( idw_20.Object.itno[1] )

String ls_parm

If f_spacechk(ls_itno) = -1 Then
	ls_parm = ls_plant + ls_div
Else
	ls_parm = ls_plant + ls_div + ls_itno
End If

//OpenWithParm(w_itno_search_invres, ls_parm)
idw_20.Object.itno[1] = Message.StringParm
end event

type dw_3 from datawindow within tabpage_3
event ue_key_down pbm_dwnkey
integer x = 18
integer y = 16
integer width = 1705
integer height = 104
integer taborder = 10
string title = "none"
string dataobject = "d_bpm201u_30"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key_down;If key = KeyEnter! Then
	iw_Sheet.TriggerEvent('ue_retrieve')
End If
end event

event constructor;this.SetTransObject(Sqlca)
idw_30 = this
// 지역
//This.getchild("xplant",idwc_1)       
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('SLE220')
	
//// 공장
//This.getchild("div",idwc_1)  
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('D')

//// 제품 선택
//This.getchild("pdcd",idwc_1)       
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('')
//	
// 계정 선택
//This.getchild("cls",idwc_1)  
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('INV021')
	
//// 구입선 선택
//This.getchild("srce",idwc_1) 
//idwc_1.SetTransObject(sqlca)	
//idwc_1.retrieve('10')


This.insertrow(0)
f_pur040_nullchk03(this)

end event

event itemchanged;if isnull(data) then
	data = ''
end if
//String ls_data, ls_colnm, ls_null
//
//This.AcceptText()
//ls_colnm = This.GetColumnName()
//IF ls_colnm = 'xplant' Then
//   idw_20.SetItem(1,'div', ' ' ) //SetNull(ls_null))
//   ls_data = idw_20.GetItemString(1,'xplant')
//   idw_20.GetChild("div",idwc_1)
//   idwc_1.SetTransObject(Sqlca)
//   idwc_1.Retrieve(ls_data)
//END IF
//
//IF ls_colnm = 'div' Then
//	idw_20.SetItem(1,'pdcd', ' ')
//   idw_20.GetChild('pdcd', idwc_1)
//   idwc_1.SetTransObject(Sqlca)
//   idwc_1.Retrieve(data) 
//END IF
//
//IF ls_colnm = 'cls' Then
//   idw_20.SetItem(1,'srce', ' ' ) //SetNull(ls_null))
//   ls_data = idw_20.GetItemString(1,'cls')
//   idw_20.GetChild("srce",idwc_1)
//   idwc_1.SetTransObject(Sqlca)
//   idwc_1.Retrieve(ls_data)
//END IF
end event

event itemerror;return 1 
end event

type dw_2 from datawindow within tabpage_3
integer x = 5
integer y = 144
integer width = 4553
integer height = 2180
integer taborder = 100
string title = "none"
string dataobject = "d_bpm201u_31"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;THIS.SetRedraw(False)
IF row < 1 THEN
   IF f_getobjectpoint_head(THIS,is_col_nm) = 1 THEN
   	f_dw_sort(THIS,is_col_nm)
   END IF
END IF
THIS.SetRedraw(True)

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
else
   return	
end if	


end event

event constructor;idw_31 = this
This.SetTransObject(Sqlca)
is_orgsql1 = This.getsqlselect()


//// 계정 선택
//This.getchild("cls",i_dwc_cls)  
//i_dwc_cls.SetTransObject(sqlca)	
//i_dwc_cls.retrieve('INV020')
//	
//// 구입선 선택
//This.getchild("srce",i_dwc_srce) 
//i_dwc_srce.SetTransObject(sqlca)	
//i_dwc_srce.retrieve('DAC040')
//
//// 자재담당	
//This.getchild("mlan",i_dwc_mlan) 
//i_dwc_mlan.SetTransObject(sqlca)	
//i_dwc_mlan.retrieve('INV070')
	
// 구매담당
//This.getchild("xplan",i_dwc_plan) 
//i_dwc_plan.SetTransObject(sqlca)	
//i_dwc_plan.retrieve('INV050')	

end event

