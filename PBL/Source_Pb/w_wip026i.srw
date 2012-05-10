$PBExportHeader$w_wip026i.srw
$PBExportComments$재공수불총괄표(공제전)
forward
global type w_wip026i from w_origin_sheet04
end type
type dw_2 from datawindow within w_wip026i
end type
type dw_4 from datawindow within w_wip026i
end type
type pb_1 from picturebutton within w_wip026i
end type
type dw_report from datawindow within w_wip026i
end type
type dw_exch_rpt from datawindow within w_wip026i
end type
type gb_1 from groupbox within w_wip026i
end type
end forward

global type w_wip026i from w_origin_sheet04
dw_2 dw_2
dw_4 dw_4
pb_1 pb_1
dw_report dw_report
dw_exch_rpt dw_exch_rpt
gb_1 gb_1
end type
global w_wip026i w_wip026i

type variables
datastore ds_stock, ds_linevendor, ds_dvsn    //수불총괄표
datastore ds_exch_stock,ds_exch_linevendor,ds_exch_dvsn
string i_s_ioindex, i_s_gubun
string i_s_fromdt, i_s_todt 
end variables

forward prototypes
public function integer wf_set_dvsn_onhand_amount (datastore arg_ds)
public function integer wf_set_linevendor_onhand_amount (datastore arg_ds)
public function integer wf_set_stock_onhand_amount (datastore arg_ds)
public function integer wf_exch_add_stock (datastore arg_ds)
public function integer wf_exch_linevendor_onhand (datastore arg_ds)
public function integer wf_exch_stock_onhand (datastore arg_ds)
public function integer wf_exch_dvsn (string arg_plant, string arg_dvsn)
public function integer wf_add_stock_amount (datastore arg_ds)
public function integer wf_exch_dvsn_onhand (datastore arg_ds)
public function integer wf_set_common_amount_divide (datastore arg_ds)
public function integer wf_exch_total ()
public function integer wf_exch_plant (string arg_plant)
public function integer wf_find_datachk (string arg_plant, string arg_dvsn)
public function integer wf_inout_dvsn (string arg_plant, string arg_dvsn)
public function integer wf_inout_plant (string arg_plant)
public function integer wf_inout_total ()
end prototypes

public function integer wf_set_dvsn_onhand_amount (datastore arg_ds);string l_s_pdcd
integer l_n_rowcnt, i, l_n_findrow, l_n_startrow
dec{0} l_n_dsohat, l_n_dwohat
long   ll_rowcnt02

ll_rowcnt02 = arg_ds.rowcount()
l_n_rowcnt = ds_dvsn.RowCount()
l_n_startrow = 1
for i = 1 to l_n_rowcnt
    l_s_pdcd    = ds_dvsn.getitemstring(i,"prodcd")   
	 l_n_dsohat  = ds_dvsn.getitemdecimal(i,"bgat")
	 l_n_findrow = arg_ds.find("prodcd = '" + l_s_pdcd +"'",l_n_startrow,ll_rowcnt02)
	 if l_n_findrow > 0 then
		 l_n_dwohat = arg_ds.getitemdecimal(l_n_findrow,"ohat")	
		 arg_ds.setitem(l_n_findrow,"ohat", l_n_dwohat + l_n_dsohat)
	end if
	//l_n_startrow = l_n_findrow
next
return 0
end function

public function integer wf_set_linevendor_onhand_amount (datastore arg_ds);string l_s_pdcd
integer l_n_rowcnt, i, l_n_findrow, l_n_startrow
dec{0} l_n_dsohat, l_n_dwohat
long  ll_rowcnt02

ll_rowcnt02 = arg_ds.rowcount()
l_n_rowcnt = ds_linevendor.RowCount()
l_n_startrow = 1
for i = 1 to l_n_rowcnt
    l_s_pdcd    = ds_linevendor.getitemstring(i,"prodcd")   
	 l_n_dsohat  = ds_linevendor.getitemdecimal(i,"bgat")
	 l_n_findrow = arg_ds.find("prodcd = '" + l_s_pdcd +"'",l_n_startrow,ll_rowcnt02)
	 if l_n_findrow > 0 then
		 l_n_dwohat = arg_ds.getitemdecimal(l_n_findrow,"ohat")	
		 arg_ds.object.ohat[l_n_findrow] = l_n_dwohat + l_n_dsohat
	end if
	//l_n_startrow = l_n_findrow
next
return 0
end function

public function integer wf_set_stock_onhand_amount (datastore arg_ds);string l_s_pdcd
integer l_n_rowcnt, i, l_n_findrow, l_n_startrow
dec{0} l_n_dsohat, l_n_dwohat
long   ll_rowcnt02

ll_rowcnt02 = arg_ds.rowcount()
l_n_rowcnt = ds_stock.RowCount()
l_n_startrow = 1
for i = 1 to l_n_rowcnt
    l_s_pdcd    = ds_stock.getitemstring(i,"prodcd")   
	 l_n_dsohat  = ds_stock.getitemdecimal(i,"bgat")
	 l_n_findrow = arg_ds.find("prodcd = '" + l_s_pdcd +"'",l_n_startrow,ll_rowcnt02)
	 if l_n_findrow > 0 then
		 l_n_dwohat = arg_ds.getitemdecimal(l_n_findrow,"ohat")	
		 arg_ds.setitem(l_n_findrow,"ohat", l_n_dwohat + l_n_dsohat)
	end if
	//l_n_startrow = l_n_findrow
next
return 0
end function

public function integer wf_exch_add_stock (datastore arg_ds);string l_s_pdcd
integer l_n_rowcnt, i, l_n_findrow, l_n_startrow
dec{0} l_n_dsbgat, l_n_dsinat, l_n_dsusat3, l_n_dsusat4, l_n_dsusat5, l_n_dsusat6, l_n_dsusat7, l_n_dsusat8, l_n_dsusat9
dec{0} l_n_dwbgat, l_n_dwinat, l_n_dwusat3, l_n_dwusat4, l_n_dwusat6, l_n_dwusatex, l_n_dwusatex1, l_n_dwusatrtn, l_n_dwusat7
dec{0} l_n_dwusat8, l_n_dwusat9, l_n_dsohat, l_n_dwohat
long   ll_rowcnt02

l_n_rowcnt = ds_exch_stock.RowCount()
ll_rowcnt02 = arg_ds.rowcount()
l_n_startrow = 1
for i = 1 to l_n_rowcnt
    l_s_pdcd    = ds_exch_stock.getitemstring(i,"prodcd")   
	 l_n_dsbgat  = ds_exch_stock.getitemdecimal(i,"bgat")
//	 l_n_dsinat  = ds_exch_stock.getitemdecimal(i,"inat")
	 l_n_dsusat3 = ds_exch_stock.getitemdecimal(i,"usat3")
    l_n_dsusat4 = ds_exch_stock.getitemdecimal(i,"usat4")
	 l_n_dsusat5 = ds_exch_stock.getitemdecimal(i,"usat5")
	 l_n_dsusat6 = ds_exch_stock.getitemdecimal(i,"usat6")
	 l_n_dsusat7 = ds_exch_stock.getitemdecimal(i,"usat7")
	 l_n_dsusat8 = ds_exch_stock.getitemdecimal(i,"usat8")
	 l_n_dsohat = ds_exch_stock.getitemdecimal(i,"ohat")
//	 l_n_dsusat9 = ds_exch_stock.getitemdecimal(i,"usat9")
	 l_n_findrow = arg_ds.find("prodcd = '" + l_s_pdcd +"'",l_n_startrow,ll_rowcnt02)
		 if l_n_findrow > 0 then
		 l_n_dwbgat    = arg_ds.getitemdecimal(l_n_findrow,"bgat")
       l_n_dwinat    = arg_ds.getitemdecimal(l_n_findrow,"inat")
		 l_n_dwusat3   = arg_ds.getitemdecimal(l_n_findrow,"usat3")
		 l_n_dwusat4   = arg_ds.getitemdecimal(l_n_findrow,"usat4")
		 l_n_dwusat6   = arg_ds.getitemdecimal(l_n_findrow,"usat6")
		 l_n_dwusatex  = arg_ds.getitemdecimal(l_n_findrow,"usatex")
		 l_n_dwusatex1 = arg_ds.getitemdecimal(l_n_findrow,"usatex1")
		 l_n_dwusatrtn = arg_ds.getitemdecimal(l_n_findrow,"usatrtn")
		 l_n_dwusat7   = arg_ds.getitemdecimal(l_n_findrow,"usat7")
		 l_n_dwusat8   = arg_ds.getitemdecimal(l_n_findrow,"usat8")
		 l_n_dwohat   = arg_ds.getitemdecimal(l_n_findrow,"ohat")
//		 l_n_dwusat9   = arg_ds.getitemdecimal(l_n_findrow,"usat9")
		 arg_ds.setitem(l_n_findrow,"bgat", l_n_dwbgat + l_n_dsbgat)
		 arg_ds.setitem(l_n_findrow,"inat", l_n_dwinat + l_n_dsinat)
		 arg_ds.setitem(l_n_findrow,"usat3", l_n_dwusat3 + l_n_dsusat3)
		 arg_ds.setitem(l_n_findrow,"usat4", l_n_dwusat4 + l_n_dsusat4)
		 arg_ds.setitem(l_n_findrow,"usat6", l_n_dwusat6 + l_n_dsusat5)
		 arg_ds.setitem(l_n_findrow,"usatex", l_n_dwusatex + l_n_dsusat6)
		 arg_ds.setitem(l_n_findrow,"usatex1", l_n_dwusatex1 )
		 arg_ds.setitem(l_n_findrow,"usatrtn", l_n_dwusatrtn + l_n_dsusat8  )
		 arg_ds.setitem(l_n_findrow,"usat7", l_n_dwusat7 )
		 arg_ds.setitem(l_n_findrow,"ohat", l_n_dwohat + l_n_dsohat )
		 //arg_ds.setitem(l_n_findrow,"usat8", l_n_dwusat8 + l_n_dsusat8)
//		 arg_ds.setitem(l_n_findrow,"usat9", l_n_dwusat9 + l_n_dsusat9)
	end if
	//l_n_startrow = l_n_findrow
next
return 0
end function

public function integer wf_exch_linevendor_onhand (datastore arg_ds);string l_s_pdcd
integer l_n_rowcnt, i, l_n_findrow, l_n_startrow
dec{0} l_n_dsohat, l_n_dwohat
long  ll_rowcnt02

ll_rowcnt02 = arg_ds.rowcount()
l_n_startrow = 1
for i = 1 to ll_rowcnt02
    l_s_pdcd    = arg_ds.getitemstring(i,"prodcd")    
	 arg_ds.setitem(i,"prod_nm", trim(f_get_coflname( g_s_company,'DAC160', arg_ds.object.prodcd[i])))
	 if i_s_ioindex = '4' then
		arg_ds.setitem(i,"plant_nm",trim(f_get_coflname(g_s_company,'SLE220', arg_ds.object.wip003_wcplant[i])))
		arg_ds.setitem(i,"dvsn_nm",trim(f_get_coflname(g_s_company,'DAC030', arg_ds.object.wip003_wcdvsn[i])))
	 else
		arg_ds.setitem(i,"plant_nm",trim(f_get_coflname(g_s_company,'SLE220', arg_ds.object.wip002_wbplant[i])))
		arg_ds.setitem(i,"dvsn_nm",trim(f_get_coflname(g_s_company,'DAC030', arg_ds.object.wip002_wbdvsn[i])))
	 end if   
//	 l_n_dsohat  = ds_exch_linevendor.getitemdecimal(i,"bgat")
//	 l_n_findrow = arg_ds.find("prodcd = '" + l_s_pdcd +"'",l_n_startrow,ll_rowcnt02)
//	 if l_n_findrow > 0 then
//		 l_n_dwohat = arg_ds.getitemdecimal(l_n_findrow,"ohat")	
//		 arg_ds.object.ohat[l_n_findrow] = l_n_dwohat + l_n_dsohat
//	end if
	//l_n_startrow = l_n_findrow
next
return 0
end function

public function integer wf_exch_stock_onhand (datastore arg_ds);string l_s_pdcd, ls_plant, ls_dvsn, ls_predate
integer l_n_rowcnt, i, l_n_findrow, l_n_startrow
dec{0} l_n_dsohat, l_n_dwohat
dec{3} lc_acost
dec{1} lc_bgqt, lc_ohqt
long   ll_rowcnt02

ll_rowcnt02 = arg_ds.rowcount()
ls_predate = uf_wip_addmonth(i_s_fromdt,-1)
l_n_startrow = 1
for i = 1 to ll_rowcnt02
    l_s_pdcd    = arg_ds.getitemstring(i,"prodcd")    
	 arg_ds.setitem(i,"prod_nm", trim(f_get_coflname( g_s_company,'DAC160', arg_ds.object.prodcd[i])))
	 if i_s_ioindex = '4' then
		arg_ds.setitem(i,"plant_nm",trim(f_get_coflname(g_s_company,'SLE220', arg_ds.object.wip003_wcplant[i])))
		arg_ds.setitem(i,"dvsn_nm",trim(f_get_coflname(g_s_company,'DAC030', arg_ds.object.wip003_wcdvsn[i])))
	 else
		arg_ds.setitem(i,"plant_nm",trim(f_get_coflname(g_s_company,'SLE220', arg_ds.object.wip002_wbplant[i])))
		arg_ds.setitem(i,"dvsn_nm",trim(f_get_coflname(g_s_company,'DAC030', arg_ds.object.wip002_wbdvsn[i])))
	 end if 
//	 ls_plant = arg_ds.getitemstring(i,"wip003_wcplant")
//	 ls_dvsn = arg_ds.getitemstring(i,"wip003_wcdvsn")
//	 //전월 이체단가
//	 
//	 l_n_dsohat  = ds_exch_stock.getitemdecimal(i,"bgat")
//	 l_n_findrow = arg_ds.find("prodcd = '" + l_s_pdcd +"'",l_n_startrow,ll_rowcnt02)
//	 if l_n_findrow > 0 then
//		 l_n_dwohat = arg_ds.getitemdecimal(l_n_findrow,"ohat")	
//		 arg_ds.setitem(l_n_findrow,"ohat", l_n_dwohat + l_n_dsohat)
//	end if
	//l_n_startrow = l_n_findrow
next
return 0
end function

public function integer wf_exch_dvsn (string arg_plant, string arg_dvsn);long ll_rowcnt, ll_rtn
string ls_predate, ls_preyyyy, ls_premm
datastore lds_01

i_s_todt = uf_wip_addmonth(i_s_fromdt,1)
ls_predate = uf_wip_addmonth(i_s_fromdt,-1)
ls_preyyyy = mid(ls_predate,1,4)
ls_premm = mid(ls_predate,5,2)
choose case i_s_ioindex
	case '1'
		ds_exch_stock.reset()
		ds_exch_dvsn.reset()
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_exchange_dvsn'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_exchange_dvsn'
		dw_2.settransobject(sqlca)
		dw_exch_rpt.dataobject = 'd_wip026i_exchange_dvsnrpt'
		dw_exch_rpt.settransobject(sqlca)
		
		lds_01.retrieve(g_s_company, arg_plant, arg_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
				
		ds_exch_stock.retrieve(g_s_company, arg_plant, arg_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), &
												ls_preyyyy, ls_premm)
		wf_exch_add_stock(lds_01)
		wf_exch_dvsn_onhand(lds_01)
		//wf_exch_stock_onhand(lds_01)

		ll_rowcnt = lds_01.rowcount()
		if ll_rowcnt < 1 then
			uo_status.st_message.text = f_message("I020")
		else
			ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
			uo_status.st_message.text = f_message("I010")
		end if
   case '2'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_exchange_line_vendor'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_exchange_line_vendor'
		dw_2.settransobject(sqlca)
		dw_exch_rpt.dataobject = 'd_wip026i_exchange_line_vendorrpt'
		dw_exch_rpt.settransobject(sqlca)
		
		lds_01.retrieve(g_s_company, arg_plant, arg_dvsn, '1', mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
	
		wf_exch_linevendor_onhand(lds_01)

		ll_rowcnt = lds_01.rowcount()
		if ll_rowcnt < 1 then
			uo_status.st_message.text = f_message("I020")
		else
			ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
			uo_status.st_message.text = f_message("I010")
		end if
	case '3'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_exchange_line_vendor'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_exchange_line_vendor'
		dw_2.settransobject(sqlca)
      dw_exch_rpt.dataobject = 'd_wip026i_exchange_line_vendorrpt'
		dw_exch_rpt.settransobject(sqlca)
		
		lds_01.retrieve(g_s_company, arg_plant, arg_dvsn, '2', mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)

		wf_exch_linevendor_onhand(lds_01)

		ll_rowcnt = lds_01.rowcount()
		if ll_rowcnt < 1 then
			uo_status.st_message.text = f_message("I020")
		else
			ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
			uo_status.st_message.text = f_message("I010")
		end if
  case '4'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_exchange_stock'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_exchange_stock'
		dw_2.settransobject(sqlca)
		dw_exch_rpt.dataobject = 'd_wip026i_exchange_stockrpt'
		dw_exch_rpt.settransobject(sqlca)
		
		lds_01.retrieve(g_s_company, arg_plant, arg_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
	
		wf_exch_stock_onhand(lds_01)

		ll_rowcnt = lds_01.rowcount()
		if ll_rowcnt < 1 then
			uo_status.st_message.text = f_message("I020")
		else
			ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
			uo_status.st_message.text = f_message("I010")
		end if
end choose
if dw_2.rowcount() > 0 then
	return 0
else
	return -1
end if

end function

public function integer wf_add_stock_amount (datastore arg_ds);string l_s_pdcd
integer l_n_rowcnt, i, l_n_findrow, l_n_startrow
dec{0} l_n_dsbgat, l_n_dsinat, l_n_dsusat3, l_n_dsusat4, l_n_dsusat5, l_n_dsusat6, l_n_dsusat7, l_n_dsusat8, l_n_dsusat9
dec{0} l_n_dwbgat, l_n_dwinat, l_n_dwusat3, l_n_dwusat4, l_n_dwusat6, l_n_dwusatex, l_n_dwusatex1, l_n_dwusatrtn, l_n_dwusat7
dec{0} l_n_dwusat8, l_n_dwusat9
long   ll_rowcnt02

l_n_rowcnt = ds_stock.RowCount()
ll_rowcnt02 = arg_ds.rowcount()
l_n_startrow = 1
for i = 1 to l_n_rowcnt
    l_s_pdcd    = ds_stock.getitemstring(i,"prodcd")   
	 l_n_dsbgat  = ds_stock.getitemdecimal(i,"bgat")
//	 l_n_dsinat  = ds_stock.getitemdecimal(i,"inat")
	 l_n_dsusat3 = ds_stock.getitemdecimal(i,"usat3")
    l_n_dsusat4 = ds_stock.getitemdecimal(i,"usat4")
	 l_n_dsusat5 = ds_stock.getitemdecimal(i,"usat5")
	 l_n_dsusat6 = ds_stock.getitemdecimal(i,"usat6")
	 l_n_dsusat7 = ds_stock.getitemdecimal(i,"usat7")
	 l_n_dsusat8 = ds_stock.getitemdecimal(i,"usat8")
	 l_n_dsusat9 = ds_stock.getitemdecimal(i,"usat9")
	 l_n_findrow = arg_ds.find("prodcd = '" + l_s_pdcd +"'",l_n_startrow,ll_rowcnt02)
		 if l_n_findrow > 0 then
		 l_n_dwbgat    = arg_ds.getitemdecimal(l_n_findrow,"bgat")
       l_n_dwinat    = arg_ds.getitemdecimal(l_n_findrow,"inat")
		 l_n_dwusat3   = arg_ds.getitemdecimal(l_n_findrow,"usat3")
		 l_n_dwusat4   = arg_ds.getitemdecimal(l_n_findrow,"usat4")
		 l_n_dwusat6   = arg_ds.getitemdecimal(l_n_findrow,"usat6")
		 l_n_dwusatex  = arg_ds.getitemdecimal(l_n_findrow,"usatex")
		 l_n_dwusatex1 = arg_ds.getitemdecimal(l_n_findrow,"usatex1")
		 l_n_dwusatrtn = arg_ds.getitemdecimal(l_n_findrow,"usatrtn")
		 l_n_dwusat7   = arg_ds.getitemdecimal(l_n_findrow,"usat7")
		 l_n_dwusat8   = arg_ds.getitemdecimal(l_n_findrow,"usat8")
		 l_n_dwusat9   = arg_ds.getitemdecimal(l_n_findrow,"usat9")
		 arg_ds.setitem(l_n_findrow,"bgat", l_n_dwbgat + l_n_dsbgat)
		 arg_ds.setitem(l_n_findrow,"inat", l_n_dwinat + l_n_dsinat)
		 arg_ds.setitem(l_n_findrow,"usat3", l_n_dwusat3 + l_n_dsusat3)
		 arg_ds.setitem(l_n_findrow,"usat4", l_n_dwusat4 + l_n_dsusat4)
		 arg_ds.setitem(l_n_findrow,"usat6", l_n_dwusat6 + l_n_dsusat5)
		 arg_ds.setitem(l_n_findrow,"usatex", l_n_dwusatex + l_n_dsusat6)
		 arg_ds.setitem(l_n_findrow,"usatex1", l_n_dwusatex1 )
		 arg_ds.setitem(l_n_findrow,"usatrtn", l_n_dwusatrtn + l_n_dsusat8  )
		 arg_ds.setitem(l_n_findrow,"usat7", l_n_dwusat7 )
		 //arg_ds.setitem(l_n_findrow,"usat8", l_n_dwusat8 + l_n_dsusat8)
		 arg_ds.setitem(l_n_findrow,"usat9", l_n_dwusat9 + l_n_dsusat9)
	end if
	//l_n_startrow = l_n_findrow
next
return 0
end function

public function integer wf_exch_dvsn_onhand (datastore arg_ds);string l_s_pdcd
integer l_n_rowcnt, i, l_n_findrow, l_n_startrow
dec{0} l_n_dsohat, l_n_dwohat
long   ll_rowcnt02

ll_rowcnt02 = arg_ds.rowcount()
l_n_startrow = 1
for i = 1 to ll_rowcnt02
    l_s_pdcd    = arg_ds.getitemstring(i,"prodcd")    
	 arg_ds.setitem(i,"prod_nm", trim(f_get_coflname( g_s_company,'DAC160', arg_ds.object.prodcd[i])))
	 if i_s_ioindex = '4' then
		arg_ds.setitem(i,"plant_nm",trim(f_get_coflname(g_s_company,'SLE220', arg_ds.object.wip003_wcplant[i])))
		arg_ds.setitem(i,"dvsn_nm",trim(f_get_coflname(g_s_company,'DAC030', arg_ds.object.wip003_wcdvsn[i])))
	 else
		arg_ds.setitem(i,"plant_nm",trim(f_get_coflname(g_s_company,'SLE220', arg_ds.object.wip002_wbplant[i])))
		arg_ds.setitem(i,"dvsn_nm",trim(f_get_coflname(g_s_company,'DAC030', arg_ds.object.wip002_wbdvsn[i])))
	 end if
//	 l_n_dsohat  = ds_exch_dvsn.getitemdecimal(i,"bgat")
//	 l_n_findrow = arg_ds.find("prodcd = '" + l_s_pdcd +"'",l_n_startrow,ll_rowcnt02)
//	 if l_n_findrow > 0 then
//		 l_n_dwohat = arg_ds.getitemdecimal(l_n_findrow,"ohat")	
//		 arg_ds.setitem(l_n_findrow,"ohat", l_n_dwohat + l_n_dsohat)
//	end if
	//l_n_startrow = l_n_findrow
next
return 0
end function

public function integer wf_set_common_amount_divide (datastore arg_ds);string l_s_pdcd
integer l_n_rowcnt, l_n_endrow, i
dec{0} l_n_bgat, l_n_inat, l_n_usat1, l_n_usat2, l_n_usat3, l_n_usat4, l_n_usat5, l_n_usat6, l_n_usat7, l_n_usat8, l_n_usat9, l_n_usatex, l_n_usatex1, l_n_usatrtn, l_n_usata
dec{0} l_n_combgat, l_n_cominat, l_n_comusat1, l_n_comusat2, l_n_comusat3, l_n_comusat4, l_n_comusat5, l_n_comusat6, l_n_comusat7, l_n_comusat8, l_n_comusat9, l_n_comusatex, l_n_comusatex1, l_n_comusatrtn, l_n_comusata
dec{0} l_n_rembgat, l_n_reminat, l_n_remusat1, l_n_remusat2, l_n_remusat3, l_n_remusat4, l_n_remusat5, l_n_remusat6, l_n_remusat7, l_n_remusat8, l_n_remusat9, l_n_remusatex, l_n_remusatex1, l_n_remusatrtn, l_n_remusata
dec{0} l_n_addbgat, l_n_addinat, l_n_addusat1, l_n_addusat2, l_n_addusat3, l_n_addusat4, l_n_addusat5, l_n_addusat6, l_n_addusat7, l_n_addusat8, l_n_addusat9, l_n_addusatex, l_n_addusatex1, l_n_addusatrtn, l_n_addusata

dec{0} l_n_totamt, l_n_rateamt, l_n_usat

l_n_rowcnt = arg_ds.RowCount()
//**********************************
//* 90 인 공용제품을 다른 제품군에 배분하는 작업. 배분율은 전체사용금액 대한 개별 제품군의 사용금액별로 정함
//**********************************
for i = 1 to l_n_rowcnt
	 l_s_pdcd    = arg_ds.getitemstring(i,"prodcd")
	 if mid(l_s_pdcd,1,2) = '90' then
		 l_n_combgat    = arg_ds.getitemdecimal(i,"bgat")
	    l_n_cominat    = arg_ds.getitemdecimal(i,"inat")
		 l_n_comusat1   = arg_ds.getitemdecimal(i,"usat1")
		 l_n_comusat2   = arg_ds.getitemdecimal(i,"usat2")
		 l_n_comusat3   = arg_ds.getitemdecimal(i,"usat3")
		 l_n_comusat4   = arg_ds.getitemdecimal(i,"usat4")
		 l_n_comusat5   = arg_ds.getitemdecimal(i,"usat5")
		 l_n_comusat6   = arg_ds.getitemdecimal(i,"usat6")
		 l_n_comusat7   = arg_ds.getitemdecimal(i,"usat7")
		 l_n_comusat8   = arg_ds.getitemdecimal(i,"usat8")
		 l_n_comusat9   = arg_ds.getitemdecimal(i,"usat9")
		 l_n_comusatex  = arg_ds.getitemdecimal(i,"usatex")
		 l_n_comusatex1 = arg_ds.getitemdecimal(i,"usatex1")
		 l_n_comusatrtn = arg_ds.getitemdecimal(i,"usatrtn")
		 l_n_comusata = arg_ds.getitemdecimal(i,"usata")
	
		 l_n_rembgat    = arg_ds.getitemdecimal(i,"bgat")
		 l_n_reminat    = arg_ds.getitemdecimal(i,"inat")
		 l_n_remusat1   = arg_ds.getitemdecimal(i,"usat1")
		 l_n_remusat2   = arg_ds.getitemdecimal(i,"usat2")
		 l_n_remusat3   = arg_ds.getitemdecimal(i,"usat3")
		 l_n_remusat4   = arg_ds.getitemdecimal(i,"usat4")
		 l_n_remusat5   = arg_ds.getitemdecimal(i,"usat5")
		 l_n_remusat6   = arg_ds.getitemdecimal(i,"usat6")
		 l_n_remusat7   = arg_ds.getitemdecimal(i,"usat7")
		 l_n_remusat8   = arg_ds.getitemdecimal(i,"usat8")
		 l_n_remusat9   = arg_ds.getitemdecimal(i,"usat9")
		 l_n_remusatex  = arg_ds.getitemdecimal(i,"usatex")
		 l_n_remusatex1 = arg_ds.getitemdecimal(i,"usatex1")
		 l_n_remusatrtn = arg_ds.getitemdecimal(i,"usatrtn")
		 l_n_remusata = arg_ds.getitemdecimal(i,"usata")
	 else
		 
		 l_n_usat1 = arg_ds.getitemdecimal(i,"usat1") 
		 l_n_usat2 = arg_ds.getitemdecimal(i,"usat2") 
		 if i_s_ioindex = '1' then
		    l_n_totamt = l_n_totamt + l_n_usat1
		 else
			 l_n_totamt = l_n_totamt + l_n_usat1 + l_n_usat2
		 end if
		 l_n_endrow = i
	 end if
next

if l_n_totamt = 0 then
	l_n_totamt = 1
end if

	for i = 1 to l_n_rowcnt
   	 l_s_pdcd    = arg_ds.getitemstring(i,"prodcd")   
		 arg_ds.setitem(i,"prod_nm", trim(f_get_coflname( g_s_company,'DAC160', arg_ds.object.prodcd[i])))
		 if i_s_ioindex = '4' then
			arg_ds.setitem(i,"plant_nm",trim(f_get_coflname(g_s_company,'SLE220', arg_ds.object.wip003_wcplant[i])))
   	 	arg_ds.setitem(i,"dvsn_nm",trim(f_get_coflname(g_s_company,'DAC030', arg_ds.object.wip003_wcdvsn[i])))
		 else
		 	arg_ds.setitem(i,"plant_nm",trim(f_get_coflname(g_s_company,'SLE220', arg_ds.object.wip002_wbplant[i])))
   	 	arg_ds.setitem(i,"dvsn_nm",trim(f_get_coflname(g_s_company,'DAC030', arg_ds.object.wip002_wbdvsn[i])))
		 end if
		 if mid(l_s_pdcd,1,2) = '90' then
			 continue
		 end if	 
		 l_n_bgat    = arg_ds.getitemdecimal(i,"bgat")
		 l_n_inat    = arg_ds.getitemdecimal(i,"inat")
		 l_n_usat1   = arg_ds.getitemdecimal(i,"usat1")
		 l_n_usat2   = arg_ds.getitemdecimal(i,"usat2")
		 l_n_usat3   = arg_ds.getitemdecimal(i,"usat3")
		 l_n_usat4   = arg_ds.getitemdecimal(i,"usat4")
		 l_n_usat5   = arg_ds.getitemdecimal(i,"usat5")
		 l_n_usat6   = arg_ds.getitemdecimal(i,"usat6")
		 l_n_usat7   = arg_ds.getitemdecimal(i,"usat7")
		 l_n_usat8   = arg_ds.getitemdecimal(i,"usat8")
		 l_n_usat9   = arg_ds.getitemdecimal(i,"usat9")
		 l_n_usatex  = arg_ds.getitemdecimal(i,"usatex")
		 l_n_usatex1 = arg_ds.getitemdecimal(i,"usatex1")
		 l_n_usatrtn = arg_ds.getitemdecimal(i,"usatrtn")
		 l_n_usata = arg_ds.getitemdecimal(i,"usata")
		 if i = l_n_endrow then
			 l_n_addbgat    = l_n_rembgat
			 l_n_addinat    = l_n_reminat
			 l_n_addusat1   = l_n_remusat1
			 l_n_addusat2   = l_n_remusat2
			 l_n_addusat3   = l_n_remusat3
			 l_n_addusat4   = l_n_remusat4
			 l_n_addusat5   = l_n_remusat5
			 l_n_addusat6   = l_n_remusat6
			 l_n_addusat7   = l_n_remusat7
			 l_n_addusat8   = l_n_remusat8
			 l_n_addusat9   = l_n_remusat9
			 l_n_addusatex  = l_n_remusatex
			 l_n_addusatex1 = l_n_remusatex1
			 l_n_addusatrtn = l_n_remusatrtn
			 l_n_addusata = l_n_remusata
		 else 
		    if i_s_ioindex = '1' then
				 l_n_usat = l_n_usat1
			 else
				 l_n_usat = l_n_usat1 + l_n_usat2
			 end if	 
			 l_n_addbgat    = round((l_n_usat / l_n_totamt) * l_n_combgat,0)
			 l_n_addinat    = round((l_n_usat / l_n_totamt) * l_n_cominat,0)
			 l_n_addusat1   = round((l_n_usat / l_n_totamt) * l_n_comusat1,0)
			 l_n_addusat2   = round((l_n_usat / l_n_totamt) * l_n_comusat2,0)
			 l_n_addusat3   = round((l_n_usat / l_n_totamt) * l_n_comusat3,0)
			 l_n_addusat4   = round((l_n_usat / l_n_totamt) * l_n_comusat4,0)
			 l_n_addusat5   = round((l_n_usat / l_n_totamt) * l_n_comusat5,0)
			 l_n_addusat6   = round((l_n_usat / l_n_totamt) * l_n_comusat6,0)
			 l_n_addusat7   = round((l_n_usat / l_n_totamt) * l_n_comusat7,0)
			 l_n_addusat8   = round((l_n_usat / l_n_totamt) * l_n_comusat8,0)
			 l_n_addusat9   = round((l_n_usat / l_n_totamt) * l_n_comusat9,0)
			 l_n_addusatex  = round((l_n_usat / l_n_totamt) * l_n_comusatex,0)
			 l_n_addusatex1 = round((l_n_usat / l_n_totamt) * l_n_comusatex1,0)
			 l_n_addusatrtn = round((l_n_usat / l_n_totamt) * l_n_comusatrtn,0)
			 l_n_addusata = round((l_n_usat / l_n_totamt) * l_n_comusata,0)
		 end if	 
		 arg_ds.setitem(i,"comm_bgat", l_n_bgat + l_n_addbgat)
		 arg_ds.setitem(i,"comm_inat", l_n_inat + l_n_addinat)
		 arg_ds.setitem(i,"comm_usat1", l_n_usat1 + l_n_addusat1)
		 arg_ds.setitem(i,"comm_usat2", l_n_usat2 + l_n_addusat2)
		 arg_ds.setitem(i,"comm_usat3", l_n_usat3 + l_n_addusat3)
		 arg_ds.setitem(i,"comm_usat4", l_n_usat4 + l_n_addusat4)
		 arg_ds.setitem(i,"comm_usat5", l_n_usat5 + l_n_addusat5)
		 arg_ds.setitem(i,"comm_usat6", l_n_usat6 + l_n_addusat6)
		 arg_ds.setitem(i,"comm_usat7", l_n_usat7 + l_n_addusat7)
		 arg_ds.setitem(i,"comm_usat8", l_n_usat8 + l_n_addusat8)
		 arg_ds.setitem(i,"comm_usat9", l_n_usat9 + l_n_addusat9)
		 arg_ds.setitem(i,"comm_usatex", l_n_usatex + l_n_addusatex)
		 arg_ds.setitem(i,"comm_usatex1", l_n_usatex1 + l_n_addusatex1)
		 arg_ds.setitem(i,"comm_usatrtn", l_n_usatrtn + l_n_addusatrtn)
		 arg_ds.setitem(i,"comm_usata", l_n_usata + l_n_addusata)
	
	    l_n_rembgat    = l_n_rembgat - l_n_addbgat
		 l_n_reminat    = l_n_reminat - l_n_addinat
		 l_n_remusat1   = l_n_remusat1 - l_n_addusat1
		 l_n_remusat2   = l_n_remusat2 - l_n_addusat2
		 l_n_remusat3   = l_n_remusat3 - l_n_addusat3
		 l_n_remusat4   = l_n_remusat4 - l_n_addusat4
		 l_n_remusat5   = l_n_remusat5 - l_n_addusat5
		 l_n_remusat6   = l_n_remusat6 - l_n_addusat6
		 l_n_remusat7   = l_n_remusat7 - l_n_addusat7
       l_n_remusat8   = l_n_remusat8 - l_n_addusat8
		 l_n_remusat9   = l_n_remusat9 - l_n_addusat9
		 l_n_remusatex  = l_n_remusatex - l_n_addusatex
		 l_n_remusatex1 = l_n_remusatex1 - l_n_addusatex1
		 l_n_remusatrtn = l_n_remusatrtn - l_n_addusatrtn
		 l_n_remusata = l_n_remusata - l_n_addusata
		 //l_n_rowcnt = arg_ds.rowcount()
   next
return 0
end function

public function integer wf_exch_total ();string ls_gubun , ls_iocd, ls_plant, ls_dvsn, l_s_refdate, l_s_kijun, mod_string, l_s_ionm
long  ll_rowcnt, ll_cnt, ll_cntx, ll_currow, ll_rtn
string ls_predate, ls_preyyyy, ls_premm
datastore lds_01

i_s_todt = uf_wip_addmonth(i_s_fromdt,1)
ls_predate = uf_wip_addmonth(i_s_fromdt,-1)
ls_preyyyy = mid(ls_predate,1,4)
ls_premm = mid(ls_predate,5,2)

setpointer(hourglass!)

choose case i_s_ioindex
	case '1'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_exchange_dvsn'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_exchange_dvsn'
		dw_2.settransobject(sqlca)
		dw_exch_rpt.dataobject = 'd_wip026i_exchange_dvsnrpt'
		dw_exch_rpt.settransobject(sqlca)
	case '2'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_exchange_line_vendor'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_exchange_line_vendor'
		dw_2.settransobject(sqlca)
		dw_exch_rpt.dataobject = 'd_wip026i_exchange_line_vendorrpt'
		dw_exch_rpt.settransobject(sqlca)
	case '3'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_exchange_line_vendor'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_exchange_line_vendor'
		dw_2.settransobject(sqlca)
      dw_exch_rpt.dataobject = 'd_wip026i_exchange_line_vendorrpt'
		dw_exch_rpt.settransobject(sqlca)
	case '4'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_exchange_stock'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_exchange_stock'
		dw_2.settransobject(sqlca)
		dw_exch_rpt.dataobject = 'd_wip026i_exchange_stockrpt'
		dw_exch_rpt.settransobject(sqlca)
end choose

for ll_cnt = 1 to 16
	choose case ll_cnt
		case 1
			ls_plant = 'D'
			ls_dvsn = 'A'
		case 2
			ls_plant = 'D'
			ls_dvsn = 'H'
		case 3
			ls_plant = 'D'
			ls_dvsn = 'M'
		case 4
			ls_plant = 'D'
			ls_dvsn = 'S'
		case 5
			ls_plant = 'D'
			ls_dvsn = 'V'
		case 6
			ls_plant = 'J'
			ls_dvsn = 'S'
		case 7
			ls_plant = 'J'
			ls_dvsn = 'H'
		case 8
			ls_plant = 'J'
			ls_dvsn = 'M'
		case 9
			ls_plant = 'K'
			ls_dvsn = 'S'
		case 10
			ls_plant = 'K'
			ls_dvsn = 'H'
		case 11
			ls_plant = 'B'
			ls_dvsn = 'A'
		case 12
			ls_plant = 'B'
			ls_dvsn = 'M'
		case 13
			ls_plant = 'B'
			ls_dvsn = 'S'
		case 14
			ls_plant = 'B'
			ls_dvsn = 'H'
		case 15
			ls_plant = 'B'
			ls_dvsn = 'V'
		case 16
			ls_plant = 'B'
			ls_dvsn = 'Y'
	end choose
	choose case i_s_ioindex
		case '1'
			lds_01.reset()
			lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
		
			ds_exch_stock.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), &
													ls_preyyyy, ls_premm)
			wf_exch_add_stock(lds_01)
			wf_exch_dvsn_onhand(lds_01)
			//wf_exch_stock_onhand(lds_01)
	
			ll_rowcnt = lds_01.rowcount()
			if ll_rowcnt < 1 then
				continue
			else
				ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
			end if
		case '2'
			lds_01.reset()
			lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '1', mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)

			wf_exch_linevendor_onhand(lds_01)
	
			ll_rowcnt = lds_01.rowcount()
			if ll_rowcnt < 1 then
				continue
			else
				ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
			end if
		case '3'
			lds_01.reset()
			lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '2', mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)

			wf_exch_linevendor_onhand(lds_01)
	
			ll_rowcnt = lds_01.rowcount()
			if ll_rowcnt < 1 then
				continue
			else
				ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
			end if
		case '4'
			lds_01.reset()
			lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)

			wf_exch_stock_onhand(lds_01)
	
			ll_rowcnt = lds_01.rowcount()
			if ll_rowcnt < 1 then
				continue
			else
				ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
			end if
	end choose
next

if dw_2.rowcount() > 0 then
	return 0
else
	return -1
end if
end function

public function integer wf_exch_plant (string arg_plant);string ls_gubun , ls_iocd, ls_plant, ls_dvsn, l_s_refdate, l_s_kijun, mod_string, l_s_ionm
long  ll_rowcnt, ll_cnt, ll_cntx, ll_currow, ll_rtn
string ls_predate, ls_preyyyy, ls_premm
datastore lds_01

i_s_todt = uf_wip_addmonth(i_s_fromdt,1)
ls_predate = uf_wip_addmonth(i_s_fromdt,-1)
ls_preyyyy = mid(ls_predate,1,4)
ls_premm = mid(ls_predate,5,2)

setpointer(hourglass!)

choose case i_s_ioindex
	case '1'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_exchange_dvsn'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_exchange_dvsn'
		dw_2.settransobject(sqlca)
		dw_exch_rpt.dataobject = 'd_wip026i_exchange_dvsnrpt'
		dw_exch_rpt.settransobject(sqlca)
	case '2'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_exchange_line_vendor'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_exchange_line_vendor'
		dw_2.settransobject(sqlca)
		dw_exch_rpt.dataobject = 'd_wip026i_exchange_line_vendorrpt'
		dw_exch_rpt.settransobject(sqlca)
	case '3'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_exchange_line_vendor'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_exchange_line_vendor'
		dw_2.settransobject(sqlca)
      dw_exch_rpt.dataobject = 'd_wip026i_exchange_line_vendorrpt'
		dw_exch_rpt.settransobject(sqlca)
	case '4'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_exchange_stock'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_exchange_stock'
		dw_2.settransobject(sqlca)
		dw_exch_rpt.dataobject = 'd_wip026i_exchange_stockrpt'
		dw_exch_rpt.settransobject(sqlca)
end choose

choose case arg_plant
	case 'D'
		for ll_cnt = 1 to 5
			choose case ll_cnt
				case 1
					ls_plant = 'D'
					ls_dvsn = 'A'
				case 2
					ls_plant = 'D'
					ls_dvsn = 'H'
				case 3
					ls_plant = 'D'
					ls_dvsn = 'M'
				case 4
					ls_plant = 'D'
					ls_dvsn = 'S'
				case 5
					ls_plant = 'D'
					ls_dvsn = 'V'
			end choose
			choose case i_s_ioindex
				case '1'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
				
					ds_exch_stock.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), &
															ls_preyyyy, ls_premm)
					wf_exch_add_stock(lds_01)
					wf_exch_dvsn_onhand(lds_01)
					//wf_exch_stock_onhand(lds_01)
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '2'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '1', mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
	
					wf_exch_linevendor_onhand(lds_01)
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '3'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '2', mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)

					wf_exch_linevendor_onhand(lds_01)
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '4'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
	
					wf_exch_stock_onhand(lds_01)
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
			end choose
		next
	case 'J'
		for ll_cnt = 1 to 3
			choose case ll_cnt
				case 1
					ls_plant = 'J'
					ls_dvsn = 'M'
				case 2
					ls_plant = 'J'
					ls_dvsn = 'S'
				case 3
					ls_plant = 'J'
					ls_dvsn = 'H'
			end choose
			choose case i_s_ioindex
				case '1'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
				
					ds_exch_stock.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), &
															ls_preyyyy, ls_premm)
					wf_exch_add_stock(lds_01)
					wf_exch_dvsn_onhand(lds_01)
					//wf_exch_stock_onhand()
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '2'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '1', mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
	
					wf_exch_linevendor_onhand(lds_01)
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '3'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '2', mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)

					wf_exch_linevendor_onhand(lds_01)
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '4'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
	
					wf_exch_stock_onhand(lds_01)
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
			end choose
		next
	case 'K'
		for ll_cnt = 1 to 2
			choose case ll_cnt
				case 1
					ls_plant = 'K'
					ls_dvsn = 'S'
				case 2
					ls_plant = 'K'
					ls_dvsn = 'H'
			end choose
			choose case i_s_ioindex
				case '1'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
				
					ds_exch_stock.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), &
															ls_preyyyy, ls_premm)
					wf_exch_add_stock(lds_01)
					wf_exch_dvsn_onhand(lds_01)
					//wf_exch_stock_onhand()
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '2'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '1', mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
	
					wf_exch_linevendor_onhand(lds_01)
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '3'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '2', mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)

					wf_exch_linevendor_onhand(lds_01)
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '4'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
	
					wf_exch_stock_onhand(lds_01)
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
			end choose
		next
	case 'B'
		for ll_cnt = 1 to 6
			choose case ll_cnt
				case 1
					ls_plant = 'B'
					ls_dvsn = 'A'
				case 2
					ls_plant = 'B'
					ls_dvsn = 'M'
				case 3
					ls_plant = 'B'
					ls_dvsn = 'S'
				case 4
					ls_plant = 'B'
					ls_dvsn = 'H'
				case 5
					ls_plant = 'B'
					ls_dvsn = 'V'
				case 6
					ls_plant = 'B'
					ls_dvsn = 'Y'
			end choose
			choose case i_s_ioindex
				case '1'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
				
					ds_exch_stock.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), &
															ls_preyyyy, ls_premm)
					wf_exch_add_stock(lds_01)
					wf_exch_dvsn_onhand(lds_01)
					//wf_exch_stock_onhand()
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '2'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '1', mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
	
					wf_exch_linevendor_onhand(lds_01)
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '3'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '2', mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)

					wf_exch_linevendor_onhand(lds_01)
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '4'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, mid(i_s_fromdt,1,4), mid(i_s_fromdt,5,2), ls_preyyyy, ls_premm)
	
					wf_exch_stock_onhand(lds_01)
			
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
			end choose
		next
end choose
if dw_2.rowcount() > 0 then
	return 0
else
	return -1
end if
end function

public function integer wf_find_datachk (string arg_plant, string arg_dvsn);string ls_iocd, ls_plant, ls_dvsn, ls_vndr, ls_cttp, ls_rtnvalue
string ls_fromdt, ls_todt, ls_errcolumn, ls_chkcd, ls_chkdt

dw_4.accepttext()
ls_errcolumn = ""
ls_plant = dw_4.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_4.getitemstring(1,"wip001_wadvsn")
ls_iocd = dw_4.getitemstring(1,"wip001_waiocd")
//ls_fromdt = dw_4.getitemstring(1,"wip001_wainptdt")
ls_todt = dw_4.getitemstring(1,"wip001_waupdtdt")

//if f_dateedit(ls_fromdt) = space(8) then
//	dw_4.modify("wip001_wainptdt.background.color = 65535")
//	if f_spacechk(ls_errcolumn) = -1 then
//		ls_errcolumn = "wip001_wainptdt"
//	end if
//else
//	dw_4.modify("wip001_wainptdt.background.color = 15780518")
//end if

if f_dateedit(ls_todt + '01') = space(8) then
	dw_4.modify("wip001_waupdtdt.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "wip001_waupdtdt"
	end if
else
	dw_4.modify("wip001_waupdtdt.background.color = 15780518")
end if

//if ls_fromdt > ls_todt then
//	dw_4.modify("wip001_wainptdt.background.color = 65535")
//	dw_4.modify("wip001_waupdtdt.background.color = 65535")
//	if f_spacechk(ls_errcolumn) = -1 then
//		ls_errcolumn = "wip001_wainptdt"
//	end if
//else
//	dw_4.modify("wip001_wainptdt.background.color = 15780518")
//	dw_4.modify("wip001_waupdtdt.background.color = 15780518")
//end if

if f_spacechk(arg_plant) = -1 then
	arg_plant = 'B'
	if f_spacechk(arg_dvsn) = -1 then
		arg_dvsn = 'Y'
	end if
else
	if f_spacechk(arg_dvsn) = -1 then
		choose case arg_plant
			case 'D'
				arg_dvsn = 'V'
			case 'J'
				arg_dvsn = 'S'
			case 'K'
				arg_dvsn = 'S'
			case 'B'
				arg_dvsn = 'Y'
		end choose
	end if
end if

ls_cttp = 'WIP' + arg_dvsn + '080'
select wzeddt, wzstscd into :ls_chkdt, :ls_chkcd from pbwip.wip090
	where wzcmcd = :g_s_company and wzplant = :arg_plant and wzcttp = :ls_cttp
	using sqlca;
	
//상태코드 체크
if ls_chkcd <> 'C' and ls_todt = ls_chkdt then
	uo_status.st_message.text = "단가계산이 완료되지 않았습니다."
	return -1
end if
if ls_todt > ls_chkdt then
	dw_4.modify("wip001_waupdtdt.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "wip001_waupdtdt"
	end if
else
	dw_4.modify("wip001_waupdtdt.background.color = 15780518")
end if

if f_spacechk(ls_errcolumn) <> -1 then
	uo_status.st_message.text = "에러사항을 수정후 조회바랍니다."
	dw_4.setcolumn(ls_errcolumn)
	dw_4.setfocus()
	return -1
else
	return 0
end if
end function

public function integer wf_inout_dvsn (string arg_plant, string arg_dvsn);long ll_rowcnt, ll_rtn
datastore lds_01

choose case i_s_ioindex
	case '1'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_dvsn'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_dvsn'
		dw_2.settransobject(sqlca)
		dw_report.dataobject = 'd_wip026i_dvsnrpt'
		dw_report.settransobject(sqlca)
		
		lds_01.retrieve(g_s_company, arg_plant, arg_dvsn, i_s_fromdt, i_s_fromdt)
	   	
		ds_stock.retrieve(g_s_company, arg_plant, arg_dvsn, i_s_fromdt, i_s_fromdt)
   	wf_add_stock_amount(lds_01)
   
		ds_dvsn.retrieve(g_s_company, arg_plant, arg_dvsn, i_s_todt, i_s_fromdt)
      wf_set_dvsn_onhand_amount(lds_01)
   	ds_stock.retrieve(g_s_company, arg_plant, arg_dvsn, i_s_todt, i_s_fromdt)
      wf_set_stock_onhand_amount(lds_01)
      
      wf_set_common_amount_divide(lds_01)
		ll_rowcnt = lds_01.rowcount()
		if ll_rowcnt < 1 then
			//uo_status.st_message.text = f_message("I020")
		else
			ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
		end if
   case '2'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_line_vendor'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_line_vendor'
		dw_2.settransobject(sqlca)
		dw_report.dataobject = 'd_wip026i_line_vendorrpt'
		dw_report.settransobject(sqlca)
		lds_01.retrieve(g_s_company, arg_plant, arg_dvsn, '1', i_s_fromdt, i_s_fromdt)

		ds_linevendor.retrieve(g_s_company, arg_plant, arg_dvsn, '1', i_s_todt, i_s_fromdt)
      wf_set_linevendor_onhand_amount(lds_01)

      wf_set_common_amount_divide(lds_01)
		ll_rowcnt = lds_01.rowcount()
		if ll_rowcnt < 1 then
			//uo_status.st_message.text = f_message("I020")
		else
			ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
		end if
	case '3'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_line_vendor'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_line_vendor'
		dw_2.settransobject(sqlca)
      dw_report.dataobject = 'd_wip026i_line_vendorrpt'
		dw_report.settransobject(sqlca)
	   lds_01.retrieve(g_s_company, arg_plant, arg_dvsn, '2', i_s_fromdt, i_s_fromdt)

		ds_linevendor.retrieve(g_s_company, arg_plant, arg_dvsn, '2', i_s_todt, i_s_fromdt)
      wf_set_linevendor_onhand_amount(lds_01)

      wf_set_common_amount_divide(lds_01)
		ll_rowcnt = lds_01.rowcount()
		if ll_rowcnt < 1 then
			//uo_status.st_message.text = f_message("I020")
		else
			ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
		end if
  case '4'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_stock'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_stock'
		dw_2.settransobject(sqlca)
		dw_report.dataobject = 'd_wip026i_stockrpt'
		dw_report.settransobject(sqlca)
		lds_01.retrieve(g_s_company, arg_plant, arg_dvsn, i_s_fromdt, i_s_fromdt)

		ds_stock.retrieve(g_s_company, arg_plant, arg_dvsn, i_s_todt, i_s_fromdt)
      wf_set_stock_onhand_amount(lds_01)

      wf_set_common_amount_divide(lds_01)
		ll_rowcnt = lds_01.rowcount()
		if ll_rowcnt < 1 then
			//uo_status.st_message.text = f_message("I020")
		else
			ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
		end if
end choose

if dw_2.rowcount() > 0 then
	return 0
else
	return -1
end if
end function

public function integer wf_inout_plant (string arg_plant);string ls_gubun , ls_iocd, ls_plant, ls_dvsn, l_s_refdate, l_s_kijun, mod_string, l_s_ionm
long  ll_rowcnt, ll_cnt, ll_cntx, ll_currow, ll_rtn

datastore lds_01
setpointer(hourglass!)

choose case i_s_ioindex
	case '1'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_dvsn'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_dvsn'
		dw_2.settransobject(sqlca)
		dw_report.dataobject = 'd_wip026i_dvsnrpt'
		dw_report.settransobject(sqlca)
	case '2'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_line_vendor'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_line_vendor'
		dw_2.settransobject(sqlca)
		dw_report.dataobject = 'd_wip026i_line_vendorrpt'
		dw_report.settransobject(sqlca)
	case '3'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_line_vendor'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_line_vendor'
		dw_2.settransobject(sqlca)
      dw_report.dataobject = 'd_wip026i_line_vendorrpt'
		dw_report.settransobject(sqlca)
	case '4'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_stock'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_stock'
		dw_2.settransobject(sqlca)
		dw_report.dataobject = 'd_wip026i_stockrpt'
		dw_report.settransobject(sqlca)
end choose

choose case arg_plant
	case 'D'
		for ll_cnt = 1 to 5
			choose case ll_cnt
				case 1
					ls_plant = 'D'
					ls_dvsn = 'A'
				case 2
					ls_plant = 'D'
					ls_dvsn = 'H'
				case 3
					ls_plant = 'D'
					ls_dvsn = 'M'
				case 4
					ls_plant = 'D'
					ls_dvsn = 'S'
				case 5
					ls_plant = 'D'
					ls_dvsn = 'V'
			end choose
			choose case i_s_ioindex
				case '1'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)
						
					ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)
					wf_add_stock_amount(lds_01)
				
					ds_dvsn.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
					wf_set_dvsn_onhand_amount(lds_01)
					ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
					wf_set_stock_onhand_amount(lds_01)
					
					wf_set_common_amount_divide(lds_01)
					
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '2'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '1', i_s_fromdt, i_s_fromdt)
	
					ds_linevendor.retrieve(g_s_company, ls_plant, ls_dvsn, '1', i_s_todt, i_s_fromdt)
					wf_set_linevendor_onhand_amount(lds_01)
			
					wf_set_common_amount_divide(lds_01)
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '3'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '2', i_s_fromdt, i_s_fromdt)
					ds_linevendor.retrieve(g_s_company, ls_plant, ls_dvsn, '2', i_s_todt, i_s_fromdt)
					wf_set_linevendor_onhand_amount(lds_01)
			
					wf_set_common_amount_divide(lds_01)
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '4'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)
	
					ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
					wf_set_stock_onhand_amount(lds_01)
			
					wf_set_common_amount_divide(lds_01)
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
			end choose
		next
	case 'J'
		for ll_cnt = 1 to 3
			choose case ll_cnt
				case 1
					ls_plant = 'J'
					ls_dvsn = 'M'
				case 2
					ls_plant = 'J'
					ls_dvsn = 'S'
				case 3
					ls_plant = 'J'
					ls_dvsn = 'H'
			end choose
			choose case i_s_ioindex
				case '1'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)
						
					ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)
					wf_add_stock_amount(lds_01)
				
					ds_dvsn.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
					wf_set_dvsn_onhand_amount(lds_01)
					ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
					wf_set_stock_onhand_amount(lds_01)
					
					wf_set_common_amount_divide(lds_01)
					
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '2'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '1', i_s_fromdt, i_s_fromdt)
	
					ds_linevendor.retrieve(g_s_company, ls_plant, ls_dvsn, '1', i_s_todt, i_s_fromdt)
					wf_set_linevendor_onhand_amount(lds_01)
			
					wf_set_common_amount_divide(lds_01)
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '3'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '2', i_s_fromdt, i_s_fromdt)
					ds_linevendor.retrieve(g_s_company, ls_plant, ls_dvsn, '2', i_s_todt, i_s_fromdt)
					wf_set_linevendor_onhand_amount(lds_01)
			
					wf_set_common_amount_divide(lds_01)
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '4'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)
	
					ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
					wf_set_stock_onhand_amount(lds_01)
			
					wf_set_common_amount_divide(lds_01)
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
			end choose
		next
	case 'K'
		for ll_cnt = 1 to 2
			choose case ll_cnt
				case 1
					ls_plant = 'K'
					ls_dvsn = 'S'
				case 2
					ls_plant = 'K'
					ls_dvsn = 'H'
			end choose
			choose case i_s_ioindex
				case '1'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)
						
					ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)
					wf_add_stock_amount(lds_01)
				
					ds_dvsn.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
					wf_set_dvsn_onhand_amount(lds_01)
					ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
					wf_set_stock_onhand_amount(lds_01)
					
					wf_set_common_amount_divide(lds_01)
					
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '2'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '1', i_s_fromdt, i_s_fromdt)
	
					ds_linevendor.retrieve(g_s_company, ls_plant, ls_dvsn, '1', i_s_todt, i_s_fromdt)
					wf_set_linevendor_onhand_amount(lds_01)
			
					wf_set_common_amount_divide(lds_01)
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '3'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '2', i_s_fromdt, i_s_fromdt)
					ds_linevendor.retrieve(g_s_company, ls_plant, ls_dvsn, '2', i_s_todt, i_s_fromdt)
					wf_set_linevendor_onhand_amount(lds_01)
			
					wf_set_common_amount_divide(lds_01)
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '4'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)
	
					ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
					wf_set_stock_onhand_amount(lds_01)
			
					wf_set_common_amount_divide(lds_01)
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
			end choose
		next
	case 'B'
		for ll_cnt = 1 to 6
			choose case ll_cnt
				case 1
					ls_plant = 'B'
					ls_dvsn = 'A'
				case 2
					ls_plant = 'B'
					ls_dvsn = 'M'
				case 3
					ls_plant = 'B'
					ls_dvsn = 'S'
				case 4
					ls_plant = 'B'
					ls_dvsn = 'H'
				case 5
					ls_plant = 'B'
					ls_dvsn = 'V'
				case 6
					ls_plant = 'B'
					ls_dvsn = 'Y'
			end choose
			choose case i_s_ioindex
				case '1'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)
						
					ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)
					wf_add_stock_amount(lds_01)
				
					ds_dvsn.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
					wf_set_dvsn_onhand_amount(lds_01)
					ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
					wf_set_stock_onhand_amount(lds_01)
					
					wf_set_common_amount_divide(lds_01)
					
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '2'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '1', i_s_fromdt, i_s_fromdt)
	
					ds_linevendor.retrieve(g_s_company, ls_plant, ls_dvsn, '1', i_s_todt, i_s_fromdt)
					wf_set_linevendor_onhand_amount(lds_01)
			
					wf_set_common_amount_divide(lds_01)
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '3'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '2', i_s_fromdt, i_s_fromdt)
					ds_linevendor.retrieve(g_s_company, ls_plant, ls_dvsn, '2', i_s_todt, i_s_fromdt)
					wf_set_linevendor_onhand_amount(lds_01)
			
					wf_set_common_amount_divide(lds_01)
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
				case '4'
					lds_01.reset()
					lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)
	
					ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
					wf_set_stock_onhand_amount(lds_01)
			
					wf_set_common_amount_divide(lds_01)
					ll_rowcnt = lds_01.rowcount()
					if ll_rowcnt < 1 then
						continue
					else
						ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
					end if
			end choose
		next
end choose
if dw_2.rowcount() > 0 then
	return 0
else
	return -1
end if

end function

public function integer wf_inout_total ();string ls_gubun , ls_iocd, ls_plant, ls_dvsn, l_s_refdate, l_s_kijun, mod_string, l_s_ionm
long  ll_rowcnt, ll_cnt, ll_cntx, ll_currow, ll_rtn

datastore lds_01
setpointer(hourglass!)

choose case i_s_ioindex
	case '1'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_dvsn'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_dvsn'
		dw_2.settransobject(sqlca)
		dw_report.dataobject = 'd_wip026i_dvsnrpt'
		dw_report.settransobject(sqlca)
	case '2'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_line_vendor'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_line_vendor'
		dw_2.settransobject(sqlca)
		dw_report.dataobject = 'd_wip026i_line_vendorrpt'
		dw_report.settransobject(sqlca)
	case '3'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_line_vendor'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_line_vendor'
		dw_2.settransobject(sqlca)
      dw_report.dataobject = 'd_wip026i_line_vendorrpt'
		dw_report.settransobject(sqlca)
	case '4'
		lds_01 = create datastore
		lds_01.dataobject = 'd_wip026i_stock'
		lds_01.settransobject(sqlca)
		dw_2.dataobject = 'd_wip026i_stock'
		dw_2.settransobject(sqlca)
		dw_report.dataobject = 'd_wip026i_stockrpt'
		dw_report.settransobject(sqlca)
end choose

for ll_cnt = 1 to 16
	choose case ll_cnt
		case 1
			ls_plant = 'D'
			ls_dvsn = 'A'
		case 2
			ls_plant = 'D'
			ls_dvsn = 'H'
		case 3
			ls_plant = 'D'
			ls_dvsn = 'M'
		case 4
			ls_plant = 'D'
			ls_dvsn = 'S'
		case 5
			ls_plant = 'D'
			ls_dvsn = 'V'
		case 6
			ls_plant = 'J'
			ls_dvsn = 'S'
		case 7
			ls_plant = 'J'
			ls_dvsn = 'H'
		case 8
			ls_plant = 'J'
			ls_dvsn = 'M'
		case 9
			ls_plant = 'K'
			ls_dvsn = 'S'
		case 10
			ls_plant = 'K'
			ls_dvsn = 'H'
		case 11
			ls_plant = 'B'
			ls_dvsn = 'A'
		case 12
			ls_plant = 'B'
			ls_dvsn = 'M'
		case 13
			ls_plant = 'B'
			ls_dvsn = 'S'
		case 14
			ls_plant = 'B'
			ls_dvsn = 'H'
		case 15
			ls_plant = 'B'
			ls_dvsn = 'V'
		case 16
			ls_plant = 'B'
			ls_dvsn = 'Y'
	end choose
	choose case i_s_ioindex
		case '1'
			lds_01.reset()
			lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)
				
			ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)
			wf_add_stock_amount(lds_01)
		
			ds_dvsn.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
			wf_set_dvsn_onhand_amount(lds_01)
			ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
			wf_set_stock_onhand_amount(lds_01)
			
			wf_set_common_amount_divide(lds_01)
			
			ll_rowcnt = lds_01.rowcount()
			if ll_rowcnt < 1 then
				continue
			else
				ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
			end if
		case '2'
			lds_01.reset()
			lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '1', i_s_fromdt, i_s_fromdt)

			ds_linevendor.retrieve(g_s_company, ls_plant, ls_dvsn, '1', i_s_todt, i_s_fromdt)
			wf_set_linevendor_onhand_amount(lds_01)
	
			wf_set_common_amount_divide(lds_01)
			ll_rowcnt = lds_01.rowcount()
			if ll_rowcnt < 1 then
				continue
			else
				ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
			end if
		case '3'
			lds_01.reset()
			lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, '2', i_s_fromdt, i_s_fromdt)
			ds_linevendor.retrieve(g_s_company, ls_plant, ls_dvsn, '2', i_s_todt, i_s_fromdt)
			wf_set_linevendor_onhand_amount(lds_01)
	
			wf_set_common_amount_divide(lds_01)
			ll_rowcnt = lds_01.rowcount()
			if ll_rowcnt < 1 then
				continue
			else
				ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
			end if
		case '4'
			lds_01.reset()
			lds_01.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_fromdt, i_s_fromdt)

			ds_stock.retrieve(g_s_company, ls_plant, ls_dvsn, i_s_todt, i_s_fromdt)
			wf_set_stock_onhand_amount(lds_01)
	
			wf_set_common_amount_divide(lds_01)
			ll_rowcnt = lds_01.rowcount()
			if ll_rowcnt < 1 then
				continue
			else
				ll_rtn = lds_01.RowsCopy (1, ll_rowcnt, primary!, dw_2, dw_2.RowCount() + 1, primary!)
			end if
	end choose
next
if dw_2.rowcount() > 0 then
	return 0
else
	return -1
end if

end function

on w_wip026i.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_4=create dw_4
this.pb_1=create pb_1
this.dw_report=create dw_report
this.dw_exch_rpt=create dw_exch_rpt
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.dw_report
this.Control[iCurrent+5]=this.dw_exch_rpt
this.Control[iCurrent+6]=this.gb_1
end on

on w_wip026i.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_4)
destroy(this.pb_1)
destroy(this.dw_report)
destroy(this.dw_exch_rpt)
destroy(this.gb_1)
end on

event open;call super::open;datawindowchild dwc_01, dwc_02
dw_4.settransobject(sqlca)

dw_4.getchild("wip001_waplant",dwc_01)
dwc_01.settransobject(sqlca)
dwc_01.retrieve('SLE220')
dw_4.getchild("wip001_wadvsn",dwc_02)
dwc_02.settransobject(sqlca)
dwc_02.retrieve('D')

dw_4.insertrow(0)
dw_4.setitem(1,"wip001_waiocd",'1')
dw_4.setitem(1,"gubun",'1')

dw_2.settransobject(sqlca)
// 창고재공 데이타스토어 
ds_stock = create datastore                               
ds_stock.dataobject = "d_wip026i_stock"
ds_stock.settransobject(sqlca)
// 라인및 업체 재공 데이타스토어
ds_linevendor = create datastore               
ds_linevendor.dataobject = "d_wip026i_line_vendor"
ds_linevendor.settransobject(sqlca)
// 공장 재공 데이타스토어
ds_dvsn = create datastore                
ds_dvsn.dataobject = "d_wip026i_dvsn"
ds_dvsn.settransobject(sqlca)

//데이타스토어 셋팅
ds_exch_stock = create datastore                               
ds_exch_stock.dataobject = "d_wip026i_exchange_stock"
ds_exch_stock.settransobject(sqlca)
ds_exch_linevendor = create datastore               
ds_exch_linevendor.dataobject = "d_wip026i_exchange_line_vendor"
ds_exch_linevendor.settransobject(sqlca)
ds_exch_dvsn = create datastore                
ds_exch_dvsn.dataobject = "d_wip026i_exchange_dvsn"
ds_exch_dvsn.settransobject(sqlca)

// 조회, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, false, false, false, false, false, false, false, false)
end event

event ue_retrieve;datawindowchild child_plant, child_dvsn
integer l_n_rowcnt
string ls_plant,ls_dvsn,ls_iocd

dw_4.accepttext()
if f_wip_mandantory_chk( dw_4 ) = -1 then return 0   //필수입력사항

ls_plant  = dw_4.getitemstring(1,"wip001_waplant")
ls_dvsn   = dw_4.getitemstring(1,"wip001_wadvsn")

if wf_find_datachk(ls_plant, ls_dvsn) = -1 then return 0

i_s_ioindex   = dw_4.getitemstring(1,"wip001_waiocd")
i_s_gubun = dw_4.getitemstring(1,"gubun")
i_s_fromdt = dw_4.getitemstring(1,"wip001_waupdtdt")
i_s_todt = uf_wip_addmonth(i_s_fromdt,1)

choose case i_s_gubun
	case '1'
		if f_spacechk(ls_plant) = -1 then
			//전공장 수불총괄표
			if wf_inout_total() = -1 then
				uo_status.st_message.text = f_message("I040")
				return 0
			else
				uo_status.st_message.text = f_message("I010")
			end if
		else
			if f_spacechk(ls_dvsn) = -1 then
				//지역별 수불총괄표
				if wf_inout_plant(ls_plant) = -1 then
					uo_status.st_message.text = f_message("I040")
					return 0
				else
					uo_status.st_message.text = f_message("I010")
				end if
			else
				//공장별 수불총괄표
				if wf_inout_dvsn(ls_plant, ls_dvsn) = -1 then
					uo_status.st_message.text = f_message("I040")
					return 0
				else
					uo_status.st_message.text = f_message("I010")
				end if
			end if
		end if
	case '2'
		if f_spacechk(ls_plant) = -1 then
			//전공장 이체총괄표
			if wf_exch_total() = -1 then
				uo_status.st_message.text = f_message("I040")
				return 0
			else
				uo_status.st_message.text = f_message("I010")
			end if
		else
			if f_spacechk(ls_dvsn) = -1 then
				//지역별 이체총괄표
				if wf_exch_plant(ls_plant) = -1 then
					uo_status.st_message.text = f_message("I040")
					return 0
				else
					uo_status.st_message.text = f_message("I010")
				end if
			else
				//공장별 이체총괄표
				if wf_exch_dvsn(ls_plant, ls_dvsn) = -1 then
					uo_status.st_message.text = f_message("I040")
					return 0
				else
					uo_status.st_message.text = f_message("I010")
				end if
			end if
		end if
end choose

i_b_print = true
wf_icon_onoff(i_b_retrieve, i_b_print,      i_b_first,   i_b_prev,   i_b_next,  & 
 				  i_b_last,     i_b_dretrieve,  i_b_dprint,  i_b_dchar)

return 0
end event

event ue_print;integer l_n_rowcnt, i
string mod_string,l_s_plant,l_s_dvsn, l_s_ionm
string l_s_refdate, l_s_kijun

window 	l_to_open
str_easy l_str_prt

								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."
//this.TriggerEvent("ue_retrieve")
if dw_2.rowcount() < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

if i_s_gubun = '1' then
	dw_2.sharedata(dw_report)
else
	dw_2.sharedata(dw_exch_rpt)
end if

if i_s_ioindex = '1' then
	l_s_ionm = ' ( 공장 )'
elseif i_s_ioindex = '2' then
	l_s_ionm = ' ( 라인 )'
elseif i_s_ioindex = '3' then
	l_s_ionm = ' ( 업체 )'
else
	l_s_ionm = ' ( 창고 )'
end if

l_s_refdate = f_relativedate(i_s_todt + '01', -1)

l_s_kijun = mid(i_s_fromdt,1,4) + '.' + mid(i_s_fromdt,5,2) + '.' + '01' + ' - ' + mid(l_s_refdate,1,4) + '.' + mid(l_s_refdate,5,2) + '.' + mid(l_s_refdate,7,2)

mod_string =  "t_kijun.text = '( " + l_s_kijun + " )'" + "t_head.text = '" + l_s_ionm + "'"
	

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
if i_s_gubun = '1' then
	l_str_prt.datawindow   = dw_report
else
	l_str_prt.datawindow   = dw_exch_rpt
end if
l_str_prt.dwsyntax = mod_string
//l_str_prt.title = "완성품별 사용실적"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0

end event

type uo_status from w_origin_sheet04`uo_status within w_wip026i
end type

type dw_2 from datawindow within w_wip026i
integer x = 14
integer y = 252
integer width = 4585
integer height = 2216
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip026i_dvsn"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_4 from datawindow within w_wip026i
event ue_dwkeydown pbm_dwnkey
integer x = 50
integer y = 60
integer width = 4375
integer height = 144
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip026i_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwkeydown;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_save")
end if
end event

event itemchanged;string ls_colname, ls_plant, ls_dvsn, ls_null
datawindowchild cdw_1

uo_status.st_message.text = ""
This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   This.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = This.GetItemString(1,'wip001_waplant')
   This.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF

if ls_colname = 'wip001_waiocd' then
	if data = '2' then
		This.modify("vndr.visible = true")
		This.modify("vsrno_t.visible = true")
		This.modify("vndnm.visible = true")
		This.modify("b_search.visible = true")
	else
		This.modify("vndr.visible = false")
		This.modify("vsrno_t.visible = false")
		This.modify("vndnm.visible = false")
		This.modify("b_search.visible = false")
	end if
end if

end event

type pb_1 from picturebutton within w_wip026i
integer x = 4251
integer y = 64
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
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_2)
end event

type dw_report from datawindow within w_wip026i
boolean visible = false
integer x = 3698
integer y = 232
integer width = 169
integer height = 88
integer taborder = 90
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_exch_rpt from datawindow within w_wip026i
boolean visible = false
integer x = 4315
integer y = 228
integer width = 151
integer height = 104
integer taborder = 100
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_wip026i
integer x = 23
integer width = 4576
integer height = 216
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

