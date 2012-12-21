$PBExportHeader$w_dac005i.srw
$PBExportComments$환율 조회
forward
global type w_dac005i from w_origin_sheet01
end type
type tab_1 from tab within w_dac005i
end type
type tabpage_1 from userobject within tab_1
end type
type pb_1 from picturebutton within tabpage_1
end type
type em_1 from editmask within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
pb_1 pb_1
em_1 em_1
st_1 st_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type pb_2 from picturebutton within tabpage_2
end type
type dw_3 from datawindow within tabpage_2
end type
type dw_2 from datawindow within tabpage_2
end type
type st_4 from statictext within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type em_3 from editmask within tabpage_2
end type
type em_2 from editmask within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type tabpage_2 from userobject within tab_1
pb_2 pb_2
dw_3 dw_3
dw_2 dw_2
st_4 st_4
st_3 st_3
em_3 em_3
em_2 em_2
st_2 st_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_4 from datawindow within tabpage_3
end type
type em_4 from editmask within tabpage_3
end type
type st_5 from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_4 dw_4
em_4 em_4
st_5 st_5
end type
type tab_1 from tab within w_dac005i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_dac005i from w_origin_sheet01
tab_1 tab_1
end type
global w_dac005i w_dac005i

type variables
DataWindowChild dw_child1
integer i_n_tab_index
string  i_s_exut
end variables

on w_dac005i.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_dac005i.destroy
call super::destroy
destroy(this.tab_1)
end on

event open;call super::open;string l_s_frdt, l_s_todt

tab_1.tabpage_1.dw_1.settransobject(sqlca)
tab_1.tabpage_2.dw_3.settransobject(sqlca)
tab_1.tabpage_3.dw_4.settransobject(sqlca)

//if f_weekday(string(today(), "yyyy-mm-dd")) = 1 then
//	tab_1.tabpage_1.em_1.text = string(RelativeDate(today(), -2), "yyyymmdd")
//	tab_1.tabpage_2.em_3.text = string(RelativeDate(today(), -2), "yyyymmdd")
//	tab_1.tabpage_3.em_4.text = string(RelativeDate(today(), -2), "yyyymmdd")
//else
	tab_1.tabpage_1.em_1.text = string(RelativeDate(today(), 0), "yyyymmdd")
	tab_1.tabpage_2.em_3.text = string(RelativeDate(today(), 0), "yyyymmdd")
	tab_1.tabpage_3.em_4.text = string(RelativeDate(today(), 0), "yyyymmdd")
//end if
tab_1.tabpage_2.em_2.text = string(RelativeDate(today(), -10), "yyyymmdd")

tab_1.tabpage_2.em_2.getdata(l_s_frdt)
tab_1.tabpage_2.em_3.getdata(l_s_todt)

tab_1.tabpage_2.dw_2.GetChild('exut', dw_child1)
dw_child1.settransobject(sqlca)
dw_child1.retrieve(g_s_company, l_s_frdt, l_s_todt)
tab_1.tabpage_2.dw_2.insertrow(0)
//tab_1.tabpage_2.cb_1.enabled = false
i_b_retrieve =	True
i_b_insert   =	False
i_b_delete	 =	False
i_b_save 	 =	false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
		  
setpointer(arrow!)
end event

event ue_retrieve;call super::ue_retrieve;string l_s_date1, l_s_date2
int    l_n_row
dec    l_n_usds, l_n_jpys, l_n_eurs, l_n_dkks, l_n_gbps, l_n_auds, &
		 l_n_usdb, l_n_jpyb, l_n_eurb, l_n_dkkb, l_n_gbpb, l_n_audb

setpointer(hourglass!)

uo_status.st_message.text	=	''

choose case i_n_tab_index
	case 1
		tab_1.tabpage_1.em_1.getdata(l_s_date1)
		if f_dateedit(l_s_date1) = '        ' then
			uo_status.st_message.text	=	'기준일자를 입력(수정)후 작업하시오.'
			return
		end if
		l_n_row = tab_1.tabpage_1.dw_1.retrieve(g_s_company, l_s_date1)
		if l_n_row > 0 then
			uo_status.st_message.text	=	f_message("I010")		// 조회되었습니다.
		else
			uo_status.st_message.text	=	f_message("I020")		// 조회할 자료가 없습니다.
		end if
	
	case 2
		tab_1.tabpage_2.em_2.getdata(l_s_date1)
		tab_1.tabpage_2.em_3.getdata(l_s_date2)
		if f_dateedit(l_s_date1) = '        ' then
			uo_status.st_message.text	=	'기준기간(from)을 입력(수정)후 작업하시오.'
			return
		end if
		if f_dateedit(l_s_date2) = '        ' then
			uo_status.st_message.text	=	'기준기간(to)을 수정후 작업하시오.'
			return
		end if
		if l_s_date1 > l_s_date2 then
			uo_status.st_message.text	=	'기준기간을 수정후 작업하시오.'
			return
		end if
		if f_spacechk(i_s_exut) = -1 then
			uo_status.st_message.text	=	'통화단위를 선택후 작업하시오.'
			return
		end if
		
		l_n_row = tab_1.tabpage_2.dw_3.retrieve(g_s_company, l_s_date1, l_s_date2, i_s_exut)
		if l_n_row > 0 then
			uo_status.st_message.text	=	'조회되었습니다.'
//			tab_1.tabpage_2.cb_1.enabled = true
		else
			uo_status.st_message.text	=	'조회할 자료가 없습니다.'
		end if
	
	case 3
		tab_1.tabpage_3.em_4.getdata(l_s_date1)
		if f_dateedit(l_s_date1) = '        ' then
			uo_status.st_message.text	=	'기준일자를 입력(수정)후 작업하시오.'
			return
		end if
		
		select count(*)  into :l_n_row
		from   "PBCOMMON"."DAC005"
		where  "PBCOMMON"."DAC005"."COMLTD" = :g_s_company and
		       "PBCOMMON"."DAC005"."EXDATE" = :l_s_date1   using sqlca ;
		if isnull(l_n_row) then
			l_n_row = 0
		end if
		
		if l_n_row < 1 then
			uo_status.st_message.text	=	f_message("I020")
		else
			select "PBCOMMON"."DAC005"."EXRATES", "PBCOMMON"."DAC005"."EXRATEB"
			into   :l_n_usds, :l_n_usdb
			from   "PBCOMMON"."DAC005"
			where  "PBCOMMON"."DAC005"."COMLTD" = :g_s_company and
					 "PBCOMMON"."DAC005"."EXDATE" = :l_s_date1   and
					 "PBCOMMON"."DAC005"."EXUT"   = 'USD'        using sqlca ;
			if sqlca.sqlcode <> 0 then
				l_n_usds = 0
				l_n_usdb = 0
			end if
			
			select "PBCOMMON"."DAC005"."EXRATES", "PBCOMMON"."DAC005"."EXRATEB"
			into   :l_n_jpys, :l_n_jpyb
			from   "PBCOMMON"."DAC005"
			where  "PBCOMMON"."DAC005"."COMLTD" = :g_s_company and
					 "PBCOMMON"."DAC005"."EXDATE" = :l_s_date1   and
					 "PBCOMMON"."DAC005"."EXUT"   = 'JPY'        using sqlca ;
			if sqlca.sqlcode <> 0 then
				l_n_jpys = 0
				l_n_jpyb = 0
			end if
			
			select "PBCOMMON"."DAC005"."EXRATES", "PBCOMMON"."DAC005"."EXRATEB"
			into   :l_n_eurs, :l_n_eurb
			from   "PBCOMMON"."DAC005"
			where  "PBCOMMON"."DAC005"."COMLTD" = :g_s_company and
					 "PBCOMMON"."DAC005"."EXDATE" = :l_s_date1   and
					 "PBCOMMON"."DAC005"."EXUT"   = 'EUR'        using sqlca ;
			if sqlca.sqlcode <> 0 then
				l_n_eurs = 0
				l_n_eurb = 0
			end if
			
			select "PBCOMMON"."DAC005"."EXRATES", "PBCOMMON"."DAC005"."EXRATEB"
			into   :l_n_dkks, :l_n_dkkb
			from   "PBCOMMON"."DAC005"
			where  "PBCOMMON"."DAC005"."COMLTD" = :g_s_company and
					 "PBCOMMON"."DAC005"."EXDATE" = :l_s_date1   and
					 "PBCOMMON"."DAC005"."EXUT"   = 'DKK'        using sqlca ;
			if sqlca.sqlcode <> 0 then
				l_n_dkks = 0
				l_n_dkkb = 0
			end if
			
			select "PBCOMMON"."DAC005"."EXRATES", "PBCOMMON"."DAC005"."EXRATEB"
			into   :l_n_gbps, :l_n_gbpb
			from   "PBCOMMON"."DAC005"
			where  "PBCOMMON"."DAC005"."COMLTD" = :g_s_company and
					 "PBCOMMON"."DAC005"."EXDATE" = :l_s_date1   and
					 "PBCOMMON"."DAC005"."EXUT"   = 'GBP'        using sqlca ;
			if sqlca.sqlcode <> 0 then
				l_n_gbps = 0
				l_n_gbpb = 0
			end if
			
			select "PBCOMMON"."DAC005"."EXRATES", "PBCOMMON"."DAC005"."EXRATEB"
			into   :l_n_auds, :l_n_audb
			from   "PBCOMMON"."DAC005"
			where  "PBCOMMON"."DAC005"."COMLTD" = :g_s_company and
					 "PBCOMMON"."DAC005"."EXDATE" = :l_s_date1   and
					 "PBCOMMON"."DAC005"."EXUT"   = 'AUD'        using sqlca ;
			if sqlca.sqlcode <> 0 then
				l_n_auds = 0
				l_n_audb = 0
			end if
			
			l_n_row = 0
			
			l_n_row ++
			tab_1.tabpage_3.dw_4.object.gubu[l_n_row] = '매도율(TTS)'
			tab_1.tabpage_3.dw_4.object.exut[l_n_row] = 'USD'
			tab_1.tabpage_3.dw_4.object.usd[l_n_row]  = 1
			tab_1.tabpage_3.dw_4.object.jpy[l_n_row]  = l_n_jpys / l_n_usds
			tab_1.tabpage_3.dw_4.object.eur[l_n_row]  = l_n_eurs / l_n_usds
			tab_1.tabpage_3.dw_4.object.dkk[l_n_row]  = l_n_dkks / l_n_usds
			tab_1.tabpage_3.dw_4.object.gbp[l_n_row]  = l_n_gbps / l_n_usds
			tab_1.tabpage_3.dw_4.object.aud[l_n_row]  = l_n_auds / l_n_usds
			tab_1.tabpage_3.dw_4.object.won[l_n_row]  = 1        / l_n_usds
			
			l_n_row ++
			tab_1.tabpage_3.dw_4.object.gubu[l_n_row] = '매도율(TTS)'
			tab_1.tabpage_3.dw_4.object.exut[l_n_row] = 'JPY'
			tab_1.tabpage_3.dw_4.object.usd[l_n_row]  = l_n_usds / l_n_jpys
			tab_1.tabpage_3.dw_4.object.jpy[l_n_row]  = 1
			tab_1.tabpage_3.dw_4.object.eur[l_n_row]  = l_n_eurs / l_n_jpys
			tab_1.tabpage_3.dw_4.object.dkk[l_n_row]  = l_n_dkks / l_n_jpys
			tab_1.tabpage_3.dw_4.object.gbp[l_n_row]  = l_n_gbps / l_n_jpys
			tab_1.tabpage_3.dw_4.object.aud[l_n_row]  = l_n_auds / l_n_jpys
			tab_1.tabpage_3.dw_4.object.won[l_n_row]  = 1        / l_n_jpys
			
			l_n_row ++
			tab_1.tabpage_3.dw_4.object.gubu[l_n_row] = '매도율(TTS)'
			tab_1.tabpage_3.dw_4.object.exut[l_n_row] = 'EUR'
			tab_1.tabpage_3.dw_4.object.usd[l_n_row]  = l_n_usds / l_n_eurs
			tab_1.tabpage_3.dw_4.object.jpy[l_n_row]  = l_n_jpys / l_n_eurs
			tab_1.tabpage_3.dw_4.object.eur[l_n_row]  = 1
			tab_1.tabpage_3.dw_4.object.dkk[l_n_row]  = l_n_dkks / l_n_eurs
			tab_1.tabpage_3.dw_4.object.gbp[l_n_row]  = l_n_gbps / l_n_eurs
			tab_1.tabpage_3.dw_4.object.aud[l_n_row]  = l_n_auds / l_n_eurs
			tab_1.tabpage_3.dw_4.object.won[l_n_row]  = 1        / l_n_eurs
			
			l_n_row ++
			tab_1.tabpage_3.dw_4.object.gubu[l_n_row] = '매도율(TTS)'
			tab_1.tabpage_3.dw_4.object.exut[l_n_row] = 'DKK'
			tab_1.tabpage_3.dw_4.object.usd[l_n_row]  = l_n_usds / l_n_dkks
			tab_1.tabpage_3.dw_4.object.jpy[l_n_row]  = l_n_jpys / l_n_dkks
			tab_1.tabpage_3.dw_4.object.eur[l_n_row]  = l_n_eurs / l_n_dkks
			tab_1.tabpage_3.dw_4.object.dkk[l_n_row]  = 1
			tab_1.tabpage_3.dw_4.object.gbp[l_n_row]  = l_n_gbps / l_n_dkks
			tab_1.tabpage_3.dw_4.object.aud[l_n_row]  = l_n_auds / l_n_dkks
			tab_1.tabpage_3.dw_4.object.won[l_n_row]  = 1        / l_n_dkks
			
			l_n_row ++
			tab_1.tabpage_3.dw_4.object.gubu[l_n_row] = '매도율(TTS)'
			tab_1.tabpage_3.dw_4.object.exut[l_n_row] = 'GBP'
			tab_1.tabpage_3.dw_4.object.usd[l_n_row]  = l_n_usds / l_n_gbps
			tab_1.tabpage_3.dw_4.object.jpy[l_n_row]  = l_n_jpys / l_n_gbps
			tab_1.tabpage_3.dw_4.object.eur[l_n_row]  = l_n_eurs / l_n_gbps
			tab_1.tabpage_3.dw_4.object.dkk[l_n_row]  = l_n_dkks / l_n_gbps
			tab_1.tabpage_3.dw_4.object.gbp[l_n_row]  = 1
			tab_1.tabpage_3.dw_4.object.aud[l_n_row]  = l_n_auds / l_n_gbps
			tab_1.tabpage_3.dw_4.object.won[l_n_row]  = 1        / l_n_gbps
			
			l_n_row ++
			tab_1.tabpage_3.dw_4.object.gubu[l_n_row] = '매도율(TTS)'
			tab_1.tabpage_3.dw_4.object.exut[l_n_row] = 'AUD'
			tab_1.tabpage_3.dw_4.object.usd[l_n_row]  = l_n_usds / l_n_auds
			tab_1.tabpage_3.dw_4.object.jpy[l_n_row]  = l_n_jpys / l_n_auds
			tab_1.tabpage_3.dw_4.object.eur[l_n_row]  = l_n_eurs / l_n_auds
			tab_1.tabpage_3.dw_4.object.dkk[l_n_row]  = l_n_dkks / l_n_auds
			tab_1.tabpage_3.dw_4.object.gbp[l_n_row]  = l_n_gbps / l_n_auds
			tab_1.tabpage_3.dw_4.object.aud[l_n_row]  = 1
			tab_1.tabpage_3.dw_4.object.won[l_n_row]  = 1        / l_n_auds
			
			l_n_row ++
			tab_1.tabpage_3.dw_4.object.gubu[l_n_row] = '매도율(TTS)'
			tab_1.tabpage_3.dw_4.object.exut[l_n_row] = 'WON'
			tab_1.tabpage_3.dw_4.object.usd[l_n_row]  = l_n_usds
			tab_1.tabpage_3.dw_4.object.jpy[l_n_row]  = l_n_jpys
			tab_1.tabpage_3.dw_4.object.eur[l_n_row]  = l_n_eurs
			tab_1.tabpage_3.dw_4.object.dkk[l_n_row]  = l_n_dkks
			tab_1.tabpage_3.dw_4.object.gbp[l_n_row]  = l_n_gbps
			tab_1.tabpage_3.dw_4.object.aud[l_n_row]  = l_n_auds
			tab_1.tabpage_3.dw_4.object.won[l_n_row]  = 1
			
			l_n_row ++
			tab_1.tabpage_3.dw_4.object.gubu[l_n_row] = '매입율(TTB)'
			tab_1.tabpage_3.dw_4.object.exut[l_n_row] = 'USD'
			tab_1.tabpage_3.dw_4.object.usd[l_n_row]  = 1
			tab_1.tabpage_3.dw_4.object.jpy[l_n_row]  = l_n_jpyb / l_n_usdb
			tab_1.tabpage_3.dw_4.object.eur[l_n_row]  = l_n_eurb / l_n_usdb
			tab_1.tabpage_3.dw_4.object.dkk[l_n_row]  = l_n_dkkb / l_n_usdb
			tab_1.tabpage_3.dw_4.object.gbp[l_n_row]  = l_n_gbpb / l_n_usdb
			tab_1.tabpage_3.dw_4.object.aud[l_n_row]  = l_n_audb / l_n_usdb
			tab_1.tabpage_3.dw_4.object.won[l_n_row]  = 1        / l_n_usdb
			
			l_n_row ++
			tab_1.tabpage_3.dw_4.object.gubu[l_n_row] = '매입율(TTB)'
			tab_1.tabpage_3.dw_4.object.exut[l_n_row] = 'JPY'
			tab_1.tabpage_3.dw_4.object.usd[l_n_row]  = l_n_usdb / l_n_jpyb
			tab_1.tabpage_3.dw_4.object.jpy[l_n_row]  = 1
			tab_1.tabpage_3.dw_4.object.eur[l_n_row]  = l_n_eurb / l_n_jpyb
			tab_1.tabpage_3.dw_4.object.dkk[l_n_row]  = l_n_dkkb / l_n_jpyb
			tab_1.tabpage_3.dw_4.object.gbp[l_n_row]  = l_n_gbpb / l_n_jpyb
			tab_1.tabpage_3.dw_4.object.aud[l_n_row]  = l_n_audb / l_n_jpyb
			tab_1.tabpage_3.dw_4.object.won[l_n_row]  = 1        / l_n_jpyb
			
			l_n_row ++
			tab_1.tabpage_3.dw_4.object.gubu[l_n_row] = '매입율(TTB)'
			tab_1.tabpage_3.dw_4.object.exut[l_n_row] = 'EUR'
			tab_1.tabpage_3.dw_4.object.usd[l_n_row]  = l_n_usdb / l_n_eurb
			tab_1.tabpage_3.dw_4.object.jpy[l_n_row]  = l_n_jpyb / l_n_eurb
			tab_1.tabpage_3.dw_4.object.eur[l_n_row]  = 1
			tab_1.tabpage_3.dw_4.object.dkk[l_n_row]  = l_n_dkkb / l_n_eurb
			tab_1.tabpage_3.dw_4.object.gbp[l_n_row]  = l_n_gbpb / l_n_eurb
			tab_1.tabpage_3.dw_4.object.aud[l_n_row]  = l_n_audb / l_n_eurb
			tab_1.tabpage_3.dw_4.object.won[l_n_row]  = 1        / l_n_eurb
			
			l_n_row ++
			tab_1.tabpage_3.dw_4.object.gubu[l_n_row] = '매입율(TTB)'
			tab_1.tabpage_3.dw_4.object.exut[l_n_row] = 'DKK'
			tab_1.tabpage_3.dw_4.object.usd[l_n_row]  = l_n_usdb / l_n_dkkb
			tab_1.tabpage_3.dw_4.object.jpy[l_n_row]  = l_n_jpyb / l_n_dkkb
			tab_1.tabpage_3.dw_4.object.eur[l_n_row]  = l_n_eurb / l_n_dkkb
			tab_1.tabpage_3.dw_4.object.dkk[l_n_row]  = 1
			tab_1.tabpage_3.dw_4.object.gbp[l_n_row]  = l_n_gbpb / l_n_dkkb
			tab_1.tabpage_3.dw_4.object.aud[l_n_row]  = l_n_audb / l_n_dkkb
			tab_1.tabpage_3.dw_4.object.won[l_n_row]  = 1        / l_n_dkkb
			
			l_n_row ++
			tab_1.tabpage_3.dw_4.object.gubu[l_n_row] = '매입율(TTB)'
			tab_1.tabpage_3.dw_4.object.exut[l_n_row] = 'GBP'
			tab_1.tabpage_3.dw_4.object.usd[l_n_row]  = l_n_usdb / l_n_gbpb
			tab_1.tabpage_3.dw_4.object.jpy[l_n_row]  = l_n_jpyb / l_n_gbpb
			tab_1.tabpage_3.dw_4.object.eur[l_n_row]  = l_n_eurb / l_n_gbpb
			tab_1.tabpage_3.dw_4.object.dkk[l_n_row]  = l_n_dkkb / l_n_gbpb
			tab_1.tabpage_3.dw_4.object.gbp[l_n_row]  = 1
			tab_1.tabpage_3.dw_4.object.aud[l_n_row]  = l_n_audb / l_n_gbpb
			tab_1.tabpage_3.dw_4.object.won[l_n_row]  = 1        / l_n_gbpb
			
			l_n_row ++
			tab_1.tabpage_3.dw_4.object.gubu[l_n_row] = '매입율(TTB)'
			tab_1.tabpage_3.dw_4.object.exut[l_n_row] = 'AUD'
			tab_1.tabpage_3.dw_4.object.usd[l_n_row]  = l_n_usdb / l_n_audb
			tab_1.tabpage_3.dw_4.object.jpy[l_n_row]  = l_n_jpyb / l_n_audb
			tab_1.tabpage_3.dw_4.object.eur[l_n_row]  = l_n_eurb / l_n_audb
			tab_1.tabpage_3.dw_4.object.dkk[l_n_row]  = l_n_dkkb / l_n_audb
			tab_1.tabpage_3.dw_4.object.gbp[l_n_row]  = l_n_gbpb / l_n_audb
			tab_1.tabpage_3.dw_4.object.aud[l_n_row]  = 1
			tab_1.tabpage_3.dw_4.object.won[l_n_row]  = 1        / l_n_audb
			
			l_n_row ++
			tab_1.tabpage_3.dw_4.object.gubu[l_n_row] = '매입율(TTB)'
			tab_1.tabpage_3.dw_4.object.exut[l_n_row] = 'WON'
			tab_1.tabpage_3.dw_4.object.usd[l_n_row]  = l_n_usdb
			tab_1.tabpage_3.dw_4.object.jpy[l_n_row]  = l_n_jpyb
			tab_1.tabpage_3.dw_4.object.eur[l_n_row]  = l_n_eurb
			tab_1.tabpage_3.dw_4.object.dkk[l_n_row]  = l_n_dkkb
			tab_1.tabpage_3.dw_4.object.gbp[l_n_row]  = l_n_gbpb
			tab_1.tabpage_3.dw_4.object.aud[l_n_row]  = l_n_audb
			tab_1.tabpage_3.dw_4.object.won[l_n_row]  = 1
			
			uo_status.st_message.text	=	f_message("I010")		// 조회되었습니다.
		end if

end choose

i_b_retrieve =	True
i_b_save		 =	False
i_b_delete	 =	False
i_b_dprint	 =	false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
              i_b_dprint,   i_b_dchar)
		  
setpointer(arrow!)
end event

event close;call super::close;g_n_tabno     = 0
end event

type uo_status from w_origin_sheet01`uo_status within w_dac005i
end type

type tab_1 from tab within w_dac005i
event create ( )
event destroy ( )
integer x = 14
integer y = 24
integer width = 4590
integer height = 2464
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

event selectionchanged;
i_n_tab_index = newindex
g_n_tabno     = newindex

if i_n_tab_index = 1 then
	tab_1.tabpage_1.em_1.setfocus()
elseif i_n_tab_index = 2 then
	tab_1.tabpage_2.em_2.setfocus()
elseif i_n_tab_index = 3 then
	tab_1.tabpage_3.em_4.setfocus()
end if
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4553
integer height = 2348
long backcolor = 12632256
string text = "일자별 환율조회"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
pb_1 pb_1
em_1 em_1
st_1 st_1
dw_1 dw_1
end type

on tabpage_1.create
this.pb_1=create pb_1
this.em_1=create em_1
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.pb_1,&
this.em_1,&
this.st_1,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.pb_1)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.dw_1)
end on

type pb_1 from picturebutton within tabpage_1
integer x = 4398
integer y = 12
integer width = 160
integer height = 104
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel_number(tab_1.tabpage_1.dw_1)
end event

type em_1 from editmask within tabpage_1
integer x = 347
integer y = 20
integer width = 366
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_1 from statictext within tabpage_1
integer x = 18
integer y = 36
integer width = 311
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준 일자"
boolean focusrectangle = false
end type

type dw_1 from datawindow within tabpage_1
integer y = 128
integer width = 4553
integer height = 2220
integer taborder = 20
string title = "none"
string dataobject = "d_dac005i_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4553
integer height = 2348
long backcolor = 12632256
string text = "통화별 환율조회"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
pb_2 pb_2
dw_3 dw_3
dw_2 dw_2
st_4 st_4
st_3 st_3
em_3 em_3
em_2 em_2
st_2 st_2
end type

on tabpage_2.create
this.pb_2=create pb_2
this.dw_3=create dw_3
this.dw_2=create dw_2
this.st_4=create st_4
this.st_3=create st_3
this.em_3=create em_3
this.em_2=create em_2
this.st_2=create st_2
this.Control[]={this.pb_2,&
this.dw_3,&
this.dw_2,&
this.st_4,&
this.st_3,&
this.em_3,&
this.em_2,&
this.st_2}
end on

on tabpage_2.destroy
destroy(this.pb_2)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.em_3)
destroy(this.em_2)
destroy(this.st_2)
end on

type pb_2 from picturebutton within tabpage_2
integer x = 4402
integer y = 12
integer width = 155
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel_number(tab_1.tabpage_2.dw_3)
end event

type dw_3 from datawindow within tabpage_2
integer y = 132
integer width = 4553
integer height = 2216
integer taborder = 40
string title = "none"
string dataobject = "d_dac005i_02"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within tabpage_2
integer x = 1627
integer y = 24
integer width = 274
integer height = 80
integer taborder = 30
string title = "none"
string dataobject = "dddw_exutcode_ext"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;i_s_exut = dw_child1.getitemstring(dw_child1.getrow(), "exut")
end event

type st_4 from statictext within tabpage_2
integer x = 1303
integer y = 36
integer width = 315
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "통화 단위"
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_2
integer x = 727
integer y = 36
integer width = 46
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type em_3 from editmask within tabpage_2
integer x = 782
integer y = 20
integer width = 370
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
boolean autoskip = true
end type

event modified;string l_s_frdt, l_s_todt

tab_1.tabpage_2.em_2.getdata(l_s_frdt)
tab_1.tabpage_2.em_3.getdata(l_s_todt)

tab_1.tabpage_2.dw_2.GetChild('exut', dw_child1)
dw_child1.settransobject(sqlca)
dw_child1.retrieve(g_s_company, l_s_frdt, l_s_todt)
tab_1.tabpage_2.dw_2.insertrow(0)
end event

type em_2 from editmask within tabpage_2
integer x = 338
integer y = 20
integer width = 370
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
boolean autoskip = true
end type

event modified;string l_s_frdt, l_s_todt

tab_1.tabpage_2.em_2.getdata(l_s_frdt)
tab_1.tabpage_2.em_3.getdata(l_s_todt)

tab_1.tabpage_2.dw_2.GetChild('exut', dw_child1)
dw_child1.settransobject(sqlca)
dw_child1.retrieve(g_s_company, l_s_frdt, l_s_todt)
tab_1.tabpage_2.dw_2.insertrow(0)
end event

type st_2 from statictext within tabpage_2
integer x = 14
integer y = 36
integer width = 315
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준 기간"
boolean focusrectangle = false
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4553
integer height = 2348
long backcolor = 12632256
string text = "일자별 주요통화 대비"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_4 dw_4
em_4 em_4
st_5 st_5
end type

on tabpage_3.create
this.dw_4=create dw_4
this.em_4=create em_4
this.st_5=create st_5
this.Control[]={this.dw_4,&
this.em_4,&
this.st_5}
end on

on tabpage_3.destroy
destroy(this.dw_4)
destroy(this.em_4)
destroy(this.st_5)
end on

type dw_4 from datawindow within tabpage_3
integer y = 120
integer width = 4553
integer height = 2228
integer taborder = 50
string title = "none"
string dataobject = "d_dac005i_03"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_4 from editmask within tabpage_3
integer x = 329
integer y = 16
integer width = 366
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_5 from statictext within tabpage_3
integer x = 18
integer y = 32
integer width = 311
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준 일자"
boolean focusrectangle = false
end type

