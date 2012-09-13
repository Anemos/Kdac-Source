$PBExportHeader$uo_accslipchange.sru
$PBExportComments$전표 db 필수입력사항 수정
forward
global type uo_accslipchange from userobject
end type
type cb_1 from commandbutton within uo_accslipchange
end type
type dw_1 from datawindow within uo_accslipchange
end type
end forward

global type uo_accslipchange from userobject
integer width = 4608
integer height = 932
long backcolor = 12632256
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
event wf_timer pbm_timer
cb_1 cb_1
dw_1 dw_1
end type
global uo_accslipchange uo_accslipchange

type variables
string i_s_1, i_s_2, i_s_3, i_s_4, i_s_5, i_s_6, i_s_7, i_s_8, i_s_9, i_s_10, &
       i_s_11, i_s_12, i_s_13, i_s_14, i_s_15, i_s_16, i_s_17, i_s_18, &
		 i_s_19, i_s_20

end variables

forward prototypes
public subroutine wf_rgbclear ()
public function string wf_vat_amt_accode_chk (string a_s_accode, string a_s_drcr, decimal a_n_origamt, decimal a_n_slamt)
end prototypes

public subroutine wf_rgbclear ();dw_1.object.slpageno.background.color   = rgb(255,255,255)
dw_1.object.slserno.background.color    = rgb(255,255,255)
dw_1.object.slaccode.background.color   = rgb(255,255,255)
dw_1.object.sldiv.background.color      = rgb(255,255,255)
dw_1.object.slempno.background.color    = rgb(255,255,255)
dw_1.object.sldrcr.background.color     = rgb(255,255,255)
dw_1.object.slamt.background.color      = rgb(255,255,255)
dw_1.object.slopaccode.background.color = rgb(255,255,255)
dw_1.object.slsummary.background.color  = rgb(255,255,255)
dw_1.object.sldept.background.color     = rgb(255,255,255)
dw_1.object.slcucodegb.background.color = rgb(255,255,255)
dw_1.object.slcucode.background.color   = rgb(255,255,255)
dw_1.object.sluser.background.color     = rgb(255,255,255)
dw_1.object.slbefdt.background.color    = rgb(255,255,255)
dw_1.object.slbefamt.background.color   = rgb(255,255,255)
dw_1.object.slfromdt.background.color   = rgb(255,255,255)
dw_1.object.sltodt.background.color     = rgb(255,255,255)
dw_1.object.sldtcnt.background.color    = rgb(255,255,255)
dw_1.object.slorigamt.background.color  = rgb(255,255,255)
dw_1.object.slrate.background.color     = rgb(255,255,255)
dw_1.object.slbankcode.background.color = rgb(255,255,255)
dw_1.object.slpdcd.background.color     = rgb(255,255,255)
dw_1.object.slutcode.background.color   = rgb(255,255,255)
dw_1.object.slqty.background.color      = rgb(255,255,255)
dw_1.object.slutprice.background.color  = rgb(255,255,255)
dw_1.object.slfornut.background.color   = rgb(255,255,255)
dw_1.object.slfornamt.background.color  = rgb(255,255,255)
dw_1.object.slexrate.background.color   = rgb(255,255,255)
dw_1.object.slmanage1.background.color  = rgb(255,255,255)
dw_1.object.slmanage2.background.color  = rgb(255,255,255)
end subroutine

public function string wf_vat_amt_accode_chk (string a_s_accode, string a_s_drcr, decimal a_n_origamt, decimal a_n_slamt);//if a_s_accode = 'A3030108' and a_s_drcr = '1' then
//	if a_n_origamt < -299999 or  a_n_origamt > 299999 then
//		return 'e'
//	else
//		return ''
//	end if
//end if
//
//if a_s_accode = 'A3030109' and a_s_drcr = '1' then
//	if a_n_origamt >= -299999  and   a_n_origamt <= 299999 then
//		return 'e'
//	else
//		return ''
//	end if
//end if

if ( a_s_accode = 'D1052606' or a_s_accode = 'D1052607' or &
     a_s_accode = 'S1032606' or a_s_accode = 'D1032607' or &
	  a_s_accode = 'M1032606' or a_s_accode = 'M1032607' ) and a_s_drcr = '1' then
	if a_n_slamt > -100000 AND  a_n_slamt < 100000 then
		return 'e'
	else
		return ''
	end if
end if

if ( a_s_accode = 'D1052602' or a_s_accode = 'D1052604' or &
     a_s_accode = 'S1032602' or a_s_accode = 'D1032604' or &
	  a_s_accode = 'M1032602' or a_s_accode = 'M1032604' ) and a_s_drcr = '1' then
	if a_n_slamt < -99999 or a_n_slamt > 99999 then
		return 'e'
	else
		return ''
	end if
else 
	   return  '' 
end if
end function

on uo_accslipchange.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on uo_accslipchange.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within uo_accslipchange
integer x = 4114
integer y = 12
integer width = 480
integer height = 76
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "수정내용 저장"
end type

event clicked;int    l_n_dw2row, l_n_dw3row, l_n_rcnt, l_n_rowcnt, l_n_findrow
string l_s_column, l_s_accode, l_s_opaccode, l_s_cucode, l_s_fromdt, l_s_todt, l_s_sql, &
       l_s_div, l_s_empno, l_s_dept, l_s_out, l_s_acdate
dec    l_n_slipno, l_n_cdno, l_n_pageno, l_n_serno, l_n_framt, l_n_toamt
long   l_n_pos

dw_1.accepttext()

wf_rgbclear()

l_s_acdate = dw_1.object.slacdate[1]
l_n_slipno = dw_1.object.slslipno[1]
l_n_cdno   = dw_1.object.slcdno[1]
l_n_pageno = dw_1.object.slpageno[1]
l_n_serno  = dw_1.object.slserno[1]

l_s_accode = dw_1.object.slaccode[1]
select count(*)  into :l_n_rcnt
from   "PBACC"."ACC010"
where  "PBACC"."ACC010"."COMLTD" = :g_s_company and
       "PBACC"."ACC010"."ACCODE1"||"PBACC"."ACC010"."ACCODE2"||"PBACC"."ACC010"."ACCODE3"||"PBACC"."ACC010"."ACCODE4"||"PBACC"."ACC010"."ACCODE5" = :l_s_accode using sqlca;
if isnull(l_n_rcnt) then
	l_n_rcnt = 0
end if
if l_n_rcnt < 1 then
	dw_1.object.slaccode.Background.Color = rgb(255,255,0)
	if len(l_s_column) < 1 then
		l_s_column = "slaccode"
	end if
end if

l_s_div = dw_1.object.sldiv[1]
select count(*)  into :l_n_rcnt
from   "PBCOMMON"."DAC002"
where  "PBCOMMON"."DAC002"."COMLTD"  = :g_s_company and
       "PBCOMMON"."DAC002"."COGUBUN" = 'ACC001'     and
		 "PBCOMMON"."DAC002"."COCODE"  = :l_s_div     using sqlca;
if isnull(l_n_rcnt) then
	l_n_rcnt = 0
end if
if l_n_rcnt < 1 then
   dw_1.object.sldiv.Background.Color = rgb(255,255,0)
   if len(l_s_column) < 1 then	
		l_s_column	=	"sldiv"		
	end if
else
	if g_s_wkcd = '1' then
		if ( l_s_accode > 'H1080100' and l_s_accode < 'H1080199' and &
	  		dw_1.object.sldiv[1] <> 'DA' ) or dw_1.object.sldiv[1] = 'DU' then
			dw_1.object.sldiv.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then	
				l_s_column	=	"sldiv"		
			end if
		end if
	else
		if dw_1.object.sldiv[1] <> 'DU' then
			dw_1.object.sldiv.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then	
				l_s_column	=	"sldiv"		
			end if
		end if
	end if
end if

l_s_empno = dw_1.object.slempno[1]
select "PBCOMMON"."DAC003"."PEDEPT", "PBCOMMON"."DAC003"."PEOUT" 
into   :l_s_dept, :l_s_out
from   "PBCOMMON"."DAC003"
where  "PBCOMMON"."DAC003"."PEEMPNO" = :l_s_empno using sqlca ;
if sqlca.sqlcode <> 0 then
	l_s_dept = ' '
end if

if f_spacechk(dw_1.object.sldrcr[1]) = -1 then
   dw_1.object.sldrcr.Background.Color = rgb(255,255,0)
   if len(l_s_column) < 1 then	
		l_s_column	=	"sldrcr"		
	end if
end if

l_s_opaccode = dw_1.object.slopaccode[1]
select count(*)  into :l_n_rcnt
from   "PBACC"."ACC010"
where  "PBACC"."ACC010"."COMLTD" = :g_s_company and
       "PBACC"."ACC010"."ACCODE1"||"PBACC"."ACC010"."ACCODE2"||"PBACC"."ACC010"."ACCODE3"||"PBACC"."ACC010"."ACCODE4"||"PBACC"."ACC010"."ACCODE5" = :l_s_opaccode using sqlca;
if isnull(l_n_rcnt) then
	l_n_rcnt = 0
end if
if l_n_rcnt < 1 then
	dw_1.object.slopaccode.Background.Color = rgb(255,255,0)
	if len(l_s_column) < 1 then
		l_s_column = "slopaccode"
	end if
end if
if l_s_accode = l_s_opaccode then
	dw_1.object.slopaccode.Background.Color = rgb(255,255,0)
	dw_1.object.slaccode.Background.Color = rgb(255,255,0)
	if len(l_s_column) < 1 then
		l_s_column = "slaccode"
	end if
end if

if f_spacechk(dw_1.object.slsummary[1]) = -1 then
   dw_1.object.slsummary.Background.Color = rgb(255,255,0)
   if len(l_s_column) < 1 then	
		l_s_column	=	"slsummary"		
	end if	
end if

	if wf_vat_amt_accode_chk(l_s_accode, dw_1.object.sldrcr[1], dw_1.object.slorigamt[1], dw_1.object.slamt[1]) = 'e' then
		dw_1.object.slaccode.Background.Color = rgb(255,255,0)
		if len(l_s_column) < 1 then
			l_s_column = "slaccode"
		end if
	end if
// 부서
	if i_s_1 = 'X' then
		if f_get_accdr01(l_s_accode, dw_1.object.sldept[1], l_s_acdate) = 'e' then
			dw_1.object.sldept.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "sldept"
			end if
		end if
	end if
// 거래처
	if ( l_s_accode >= 'S1010000' and l_s_accode <= 'S1019999' ) and &
	   dw_1.object.sldrcr[1] = '2' then
		if dw_1.object.slcucodegb[1] = 'S' then
			l_s_cucode = dw_1.object.slcucode[1]
			select count(*)  into :l_n_rcnt
			from   "PBPUR"."PUR101"
			where  "PBPUR"."PUR101"."COMLTD" = :g_s_company and
					 "PBPUR"."PUR101"."VSRNO"  = :l_s_cucode  using sqlca;
			if isnull(l_n_rcnt) then
				l_n_rcnt = 0
			end if
			if l_n_rcnt = 0 then
				dw_1.object.slcucode.Background.Color = rgb(255,255,0)
				if len(l_s_column) < 1 then
					l_s_column = "slcucode"
				end if
			end if
		else
			dw_1.object.slaccode.Background.Color = rgb(255,255,0)
			dw_1.object.slcucodegb.Background.Color = rgb(255,255,0)
			dw_1.object.slcucode.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "slcucodegb"
			end if
		end if
	else
		if i_s_2 = 'X' or ( f_get_acckyungbi_accode(l_s_accode) = 'y' and l_n_cdno < 50 ) then
			if f_get_acccomm_kyungbi(l_s_accode) = 'y' then
					if l_s_accode = 'M1032606' or l_s_accode = 'S1032606' or l_s_accode = 'D1052606' or &
						l_s_accode = 'M1032607' or l_s_accode = 'S1032607' or l_s_accode = 'D1052607' then
						if f_get_accdr022(dw_1.object.slcucode[1]) = 'e' then
							dw_1.object.slcucode.Background.Color = rgb(255,255,0)
							if len(l_s_column) < 1 then
								l_s_column = "slcucode"
							end if
						end if
					else
						dw_1.object.slcucodegb[1] = 'D'
						dw_1.object.slcucode[1]   = dw_1.object.sldept[1]
					end if
			elseif f_get_acckyungbi_accode(l_s_accode) = 'y' then
					if f_get_accdr021(dw_1.object.slcucode[1]) = 'e' then
						dw_1.object.slcucode.Background.Color = rgb(255,255,0)
						if len(l_s_column) < 1 then
							l_s_column = "slcucode"
						end if
					end if
			elseif dw_1.object.slcucodegb[1] = 'P' then
				if f_get_accdr023(dw_1.object.slcucode[1]) = 'e' then
					dw_1.object.slcucode.Background.Color = rgb(255,255,0)
					if len(l_s_column) < 1 then
						l_s_column = "slcucode"
					end if
				end if
			elseif dw_1.object.slcucodegb[1] = 'B' then
				if f_get_accdr024(dw_1.object.slcucode[1]) = 'e' then
					dw_1.object.slcucode.Background.Color = rgb(255,255,0)
					if len(l_s_column) < 1 then
						l_s_column = "slcucode"
					end if
				end if
			elseif dw_1.object.slcucodegb[1] = 'D' then
				if f_get_accdr021(dw_1.object.slcucode[1]) = 'e' then
					dw_1.object.slcucode.Background.Color = rgb(255,255,0)
					if len(l_s_column) < 1 then
						l_s_column = "slcucode"
					end if
				end if
			else
					if f_get_accdr022(dw_1.object.slcucode[1]) = 'e' then
						dw_1.object.slcucode.Background.Color = rgb(255,255,0)
						if len(l_s_column) < 1 then
							l_s_column = "slcucode"
						end if
					end if
			end if
		end if
	end if
// 사용자사번
	if i_s_3 = 'X' then
		if f_get_accdr023(dw_1.object.sluser[1]) = 'e' then
			dw_1.object.sluser.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "sluser"
			end if
		end if
	end if
	if i_s_4 = 'X' then
		if f_get_accdr041(g_s_company, dw_1.object.slmanage1[1], dw_1.object.slaccode[1]) = 'e' or &
		   f_get_accdr042(dw_1.object.slmanage1[1], dw_1.object.slaccode[1]) = 'e' or &
			f_get_accdr043(dw_1.object.slmanage1[1], dw_1.object.slaccode[1], dw_1.object.sldrcr[1], dw_1.object.sldept[1], dw_1.object.slopaccode[1]) = 'e' then
			dw_1.object.slmanage1.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "slmanage1"
			end if
		end if
	end if
	if i_s_5 = 'X' then
		if f_get_accdr051(dw_1.object.slmanage2[1], dw_1.object.slaccode[1], dw_1.object.slacdate[1], dw_1.object.sldiv[1], dw_1.object.sldrcr[1], dw_1.object.sldept[1]) = 'e' then
			dw_1.object.slmanage2.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "slmanage2"
			end if
		end if
	end if
	if i_s_6 = 'X' then
		if f_dateedit(dw_1.object.slbefdt[1]) = '        ' or &
		   mid(dw_1.object.slbefdt[1],1,6) > mid(dw_1.object.slacdate[1],1,6) then
			dw_1.object.slbefdt.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "slbefdt"
			end if
		end if
	end if
	if i_s_7 = 'X' then
		if dw_1.object.slbefamt[1] = 0 then
			dw_1.object.slbefamt.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "slbefamt"
			end if
		end if
	end if
	if i_s_8 = 'X' then
		if ( ( l_s_accode >= 'H1010000' and l_s_accode <= 'H1019999' ) or &
		     ( l_s_accode >= 'H1050000' and l_s_accode <= 'H1059999' ) )  then
		   if	mid(dw_1.object.slmanage1[1],2,21) = 'CB' then
			 if f_dateedit(dw_1.object.slfromdt[1]) = '        ' then
				dw_1.object.slfromdt.Background.Color = rgb(255,255,0)
				if len(l_s_column) < 1 then
					l_s_column = "slfromdt"
				end if
			end if
		   end if 
		else
			if f_dateedit(dw_1.object.slfromdt[1]) = '        ' then
				dw_1.object.slfromdt.Background.Color = rgb(255,255,0)
				if len(l_s_column) < 1 then
					l_s_column = "slfromdt"
				end if
			end if
		end if
	end if
	if i_s_9 = 'X' then
		if f_dateedit(dw_1.object.sltodt[1]) = '        ' then
			dw_1.object.sltodt.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "sltodt"
			end if
		end if
	end if
	if i_s_10 = 'X' then
		if dw_1.object.sldtcnt[1] < 1 then
			dw_1.object.sldtcnt.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "sldtcnt"
			end if
		end if
	end if
	if i_s_11 = 'X' then
		if f_get_accdr11(l_s_accode, dw_1.object.sldrcr[1], dw_1.object.slbefamt[1], dw_1.object.slamt[1], dw_1.object.slorigamt[1],' ') = 'e' then
			dw_1.object.slorigamt.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "slorigamt"
			end if
		end if
	end if
	if i_s_12 = 'X' then
		if dw_1.object.slrate[1] = 0 then
			dw_1.object.slrate.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "slrate"
			end if
		end if
	end if
	if i_s_13 = 'X' then
		if dw_1.object.slqty[1] = 0 then
			dw_1.object.slqty.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "slqty"
			end if
		end if
	end if
	if i_s_14 = 'X' then
		if f_get_accdr14(dw_1.object.slutcode[1]) = 'e' then
			dw_1.object.slutcode.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "slutcode"
			end if
		end if
	end if
	if i_s_15 = 'X' then
		if dw_1.object.slutprice[1] = 0 then
			dw_1.object.slutprice.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "slutprice"
			end if
		end if
	end if
	if i_s_16 = 'X' then
		if dw_1.object.slfornamt[1] = 0 then
			if f_spacechk(dw_1.object.slfornut[1]) <> -1 then
				dw_1.object.slfornamt.Background.Color = rgb(255,255,0)
				if len(l_s_column) < 1 then
					l_s_column = "slfornamt"
				end if
			end if
		end if
	end if
	if i_s_17 = 'X' then
		if f_spacechk(dw_1.object.slfornut[1]) <> -1 then
			if f_get_accdr17(dw_1.object.slfornut[1]) = 'e' then
				dw_1.object.slfornut.Background.Color = rgb(255,255,0)
				if len(l_s_column) < 1 then
					l_s_column = "slfornut"
				end if
			end if
		end if
	end if
	if i_s_18 = 'X' then
		if dw_1.object.slexrate[1] = 0 then
			if f_spacechk(dw_1.object.slfornut[1]) <> -1 then
				dw_1.object.slexrate.Background.Color = rgb(255,255,0)
				if len(l_s_column) < 1 then
					l_s_column = "slexrate"
				end if
			end if
		end if
	end if
	if i_s_19 = 'X' then
		if f_get_accdr024(dw_1.object.slbankcode[1]) = 'e' then
			dw_1.object.slbankcode.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "slbankcode"
			end if
		end if
	end if
	if i_s_20 = 'X' then
		if f_get_accdr057(l_s_accode, dw_1.object.slpdcd[1], dw_1.object.sldept[1]) = 'e' then
			dw_1.object.slpdcd.Background.Color = rgb(255,255,0)
			if len(l_s_column) < 1 then
				l_s_column = "slpdcd"
			end if
		end if
	end if

if len(l_s_column) > 0 then									// Editing Error
	dw_1.setcolumn(l_s_column)
	dw_1.setfocus()
	messagebox('ERROR Message', '노랑색 항목을 수정 후 수정내용저장 버튼을 클릭 바랍니다.')
	return
end if

if dw_1.ModifiedCount() = 0 then
	dw_1.setfocus()
	messagebox('Message', '변경내용이 없습니다.')
   return
end if

f_sysdate()       

dw_1.object.updtid[1]  = g_s_empno
dw_1.object.updtdt[1]  = g_s_datetime
dw_1.object.ipaddr[1]  = g_s_ipaddr
dw_1.object.macaddr[1] = g_s_macaddr

if dw_1.update() = 1 then
   commit using sqlca;
	messagebox('Message', '저장되었습니다.')
else
	rollback using SQLCA;
	messagebox('ERROR Message', '[저장실패] 정보시스템팀으로 연락바랍니다.')
end if 

setpointer(Arrow!)
end event

type dw_1 from datawindow within uo_accslipchange
integer x = 9
integer y = 96
integer width = 4590
integer height = 828
integer taborder = 10
string title = "none"
string dataobject = "d_acc205u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

