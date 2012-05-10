$PBExportHeader$w_comm311u.srw
$PBExportComments$AutoDown 프로그램(up)
forward
global type w_comm311u from w_origin_sheet01
end type
type st_top from statictext within w_comm311u
end type
type ddlb_1 from dropdownlistbox within w_comm311u
end type
type sle_1 from singlelineedit within w_comm311u
end type
type ddlb_2 from dropdownlistbox within w_comm311u
end type
type dw_1 from datawindow within w_comm311u
end type
type cb_1 from commandbutton within w_comm311u
end type
type lb_1 from listbox within w_comm311u
end type
type cb_3 from commandbutton within w_comm311u
end type
type dw_4 from datawindow within w_comm311u
end type
type mle_detail from multilineedit within w_comm311u
end type
type st_1 from statictext within w_comm311u
end type
type ddlb_gubun from dropdownlistbox within w_comm311u
end type
type sle_docno from singlelineedit within w_comm311u
end type
type dw_wait from datawindow within w_comm311u
end type
type gb_1 from groupbox within w_comm311u
end type
end forward

global type w_comm311u from w_origin_sheet01
integer height = 2764
st_top st_top
ddlb_1 ddlb_1
sle_1 sle_1
ddlb_2 ddlb_2
dw_1 dw_1
cb_1 cb_1
lb_1 lb_1
cb_3 cb_3
dw_4 dw_4
mle_detail mle_detail
st_1 st_1
ddlb_gubun ddlb_gubun
sle_docno sle_docno
dw_wait dw_wait
gb_1 gb_1
end type
global w_comm311u w_comm311u

type variables
string 		is_path, is_system_nm = 'kdac',is_getfocus = '0'
integer	is_file_id
string 		userid, tname, itname
end variables

forward prototypes
public subroutine wf_server_update (string a_name, decimal a_ver, unsignedlong a_size, blob a_binary, string a_delete, string a_upgrade_detail, blob a_old_binary)
end prototypes

public subroutine wf_server_update (string a_name, decimal a_ver, unsignedlong a_size, blob a_binary, string a_delete, string a_upgrade_detail, blob a_old_binary);Integer 	ln_rcnt,i,ln_count
String  	ls_area
Blob		lb_binaryold

sqlxx		=	CREATE transaction

ln_count = 	dw_4.retrieve()

for	i	=	1	to	ln_count
		// remote autodown 관련
		if 	trim(dw_4.object.servergubun[i]) = "A" then
			continue
		end if
	
		ls_area 					= 	trim(dw_4.object.serverid[i])
		sqlxx.ServerName 		= 	trim(dw_4.object.servername[i])
		sqlxx.DBMS       		= 	trim(dw_4.object.serverdbms[i])
		sqlxx.Database   		= 	trim(dw_4.object.serverdatabase[i])
		sqlxx.LogId      			= 	trim(dw_4.object.serverlogid[i])
		sqlxx.LogPass    		= 	trim(dw_4.object.serverpassword[i])
		if 	trim(dw_4.object.serverautocommit[i]) = "T" then
			sqlxx.autocommit	= 	true
		else
			sqlxx.autocommit	= 	false
		end if
		
		sqlxx.DBParm     =	trim(dw_4.object.serverdbparm[i])
	
		connect using 	sqlxx;
	
		if 	sqlxx.sqlcode <> 0 then
			messagebox('경고',  ls_area + ' AUTODOWN 서버가 연결되지 않습니다. update 불가.')
			continue
		end if
		if 	a_delete = 'Y' then
			delete from comm702
				where system_nm = :is_system_nm and file_nm = :a_name
			using sqlxx ;
			if 	is_system_nm = 'blank' then
				delete from comm702
					where system_nm = 'kdac' and file_nm = :a_name
				using sqlxx ;
			end if
			if sqlxx.sqlcode = 0 then
				commit using sqlxx;
				uo_status.st_message.text = a_name + " 삭제완료( " + ls_area + " )"
			else
				rollback using sqlxx;
			end if
		else
			select	count(*) into :ln_rcnt	from   comm702
			where 	system_nm = :is_system_nm and
						file_nm   = :a_name using sqlxx;
			if 	isnull(ln_rcnt) then
				ln_rcnt = 0
			end if
			if 	ln_rcnt < 1 then
				if 	is_system_nm = 'blank' then
					insert into comm702
					  ( system_nm,      file_nm,       file_ver, file_size,
						 inpt_id,        inpt_dt,       updt_id,  updt_dt,	confirm_flag,	confirm_date,upgrade_detail )  
					values
					  ( 'kdac', :a_name,  :a_ver, :a_size,
						 :g_s_empno,     :g_s_datetime,:g_s_empno ,:g_s_datetime	,'N'	,'',:a_upgrade_detail)  using sqlxx;
					UPDATEBLOB comm702 
						SET binary_value = :a_binary 
					WHERE system_nm     = 'kdac'
							file_nm       = :a_name   using sqlxx;	 
							
					UPDATEBLOB comm702 
						SET binary_old = :a_binary
					WHERE system_nm     = 'kdac'
							file_nm       = :a_name   using sqlxx;	 						
				end if
				
				insert into comm702
				  ( system_nm,      file_nm,       file_ver, file_size,
					 inpt_id,        inpt_dt,       updt_id,  updt_dt,	confirm_flag,	confirm_date,upgrade_detail ) 
				values
				  ( :is_system_nm, :a_name,  :a_ver, :a_size,
					 :g_s_empno,     :g_s_datetime,:g_s_empno ,:g_s_datetime	,'N'	,'',:a_upgrade_detail)  using sqlxx;
					 
			else
				update 	comm702
				set  		file_ver  		= :a_ver	,		file_size			=	:a_size,
					  		updt_id   		= :g_s_empno,	updt_dt			= 	:g_s_datetime,
					  		confirm_flag	=	'N'	,		confirm_Date	=	'',	upgrade_detail	=	:a_upgrade_detail
				where 	system_nm 	= 	:is_system_nm and
							file_nm   	= 	:a_name   
				Using sqlxx;
			end if
			if 	sqlxx.sqlcode = 0 then
				commit using sqlxx ;
			else
				rollback using sqlxx ;
			end if
			
			UPDATEBLOB comm702 
				SET 	binary_old 		= 	:a_old_binary 
			WHERE 	system_nm     	=	:is_system_nm and
						file_nm       		= 	:a_name   using sqlxx;
			UPDATEBLOB comm702 
				SET 	binary_value 	= 	:a_binary
			WHERE 	system_nm     	=	:is_system_nm and
						file_nm       		= 	:a_name   using sqlxx;					
			if 	sqlxx.sqlcode = 0 then
				commit using sqlxx;
				uo_status.st_message.text = a_name + " 저장 완료 ( " + ls_area + " )"
			else
				rollback using sqlxx;
			end if
		end if
		disconnect using 	sqlxx;
next
destroy 	sqlxx 

end subroutine

on w_comm311u.create
int iCurrent
call super::create
this.st_top=create st_top
this.ddlb_1=create ddlb_1
this.sle_1=create sle_1
this.ddlb_2=create ddlb_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.lb_1=create lb_1
this.cb_3=create cb_3
this.dw_4=create dw_4
this.mle_detail=create mle_detail
this.st_1=create st_1
this.ddlb_gubun=create ddlb_gubun
this.sle_docno=create sle_docno
this.dw_wait=create dw_wait
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_top
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.ddlb_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.lb_1
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.dw_4
this.Control[iCurrent+10]=this.mle_detail
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.ddlb_gubun
this.Control[iCurrent+13]=this.sle_docno
this.Control[iCurrent+14]=this.dw_wait
this.Control[iCurrent+15]=this.gb_1
end on

on w_comm311u.destroy
call super::destroy
destroy(this.st_top)
destroy(this.ddlb_1)
destroy(this.sle_1)
destroy(this.ddlb_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.lb_1)
destroy(this.cb_3)
destroy(this.dw_4)
destroy(this.mle_detail)
destroy(this.st_1)
destroy(this.ddlb_gubun)
destroy(this.sle_docno)
destroy(this.dw_wait)
destroy(this.gb_1)
end on

event open;call super::open;ddlb_1.text	= 	"PBD(Using)"
ddlb_2.text 	= 	"*.pbd"

is_path 		= 	"c:\kdac\pbl\epbl\"
sle_1.text 	=	is_path

dw_1.settransobject(sqlca)
// PC의 내용 display
ddlb_2.triggerevent("selectionchanged")
timer(0)
timer(30)
end event

event ue_retrieve;String 	commnt, owner, val
String 	trac

if 	f_spacechk(is_system_nm) = -1 then
	uo_status.st_message.text = "단위업무명을 입력 하세요"
	beep(1)
	return
end if

dw_1.reset()
dw_1.retrieve(is_system_nm) 

i_b_delete 	=	true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
				  	i_b_dprint,   i_b_dchar)


end event

event ue_insert;Integer	ln_idx, ln_row
Decimal 	ln_file_version
Ulong   	ln_file_size
String  	ls_file_nm, ls_system_nm

uo_status.st_message.text =	''

if 	lb_1.SelectedIndex() = -1 then
	messagebox("확인","파일선택란에서 입력파일을 선택하세요")
	uo_status.st_message.text = "파일선택란에서 입력파일을 선택하세요"
	return
end if

if 	f_spacechk(is_system_nm) = -1 then
	messagebox("확인","단위업무명을 입력 하세요")
	uo_status.st_message.text = "단위업무명을 입력 하세요"
	return
end if

if 	f_spacechk(mle_detail.text) = -1 then
	messagebox("확인","변경사유를 반드시 입력하세요.")
	uo_status.st_message.text = "변경사유를 반드시 입력하세요."
	return
end if
if	ddlb_gubun.text	=	'서비스 요청서'		or	ddlb_gubun.text	=	'업무 연락'	or	&
	ddlb_gubun.text	=	'기능 추가 & 개선'	or ddlb_gubun.text	=	'서비스 장애'	 then
	if	f_spacechk(sle_docno.text) = -1 or is_getfocus	=	'0' then
		messagebox("확인","GWP 또는 DSOM 문서번호를 반드시 입력하세요")
		uo_status.st_message.text = "GWP 또는 DSOM 문서번호를 반드시 입력하세요"
		return
	end if
elseif	trim(ddlb_gubun.text)	=	'프로젝트'		then
		if	f_spacechk(sle_docno.text) = -1 or is_getfocus	=	'0' then
			messagebox("확인","DPMS 프로젝트 코드를 반드시 입력하세요")
			uo_status.st_message.text = "DPMS 프로젝트 코드를 반드시 입력하세요"
			return
		end if
end if
SetPointer(HourGlass!)
do while		True
	ln_idx	=	lb_1.SelectedIndex()
	if 	ln_idx > 0 then
		ls_file_nm = lower(lb_1.text(ln_idx))
		ln_file_size = FileLength(is_path + ls_file_nm )
		ln_row = dw_1.find( "file_nm = '" + ls_file_nm + "'" , 1, dw_1.rowcount())
		dw_1.setredraw(false)
		if ln_row > 0 then
			dw_1.object.cp_status[ln_row] = "mod"
			if is_system_nm <> 'blank' then
				ln_file_version = dw_1.object.file_ver[ln_row] + 0.01
			else
				ln_file_version = 1.00
			end if
		else
			ln_row = dw_1.insertrow(0)
			dw_1.object.cp_status[ln_row] = "new"
			dw_1.object.system_nm[ln_row] = is_system_nm
			if ls_file_nm = 'kdacdw.exe' or ls_file_nm = 'kdacdw.bat' or ls_file_nm = 'kdacdw.pif' or ls_file_nm = 'kdacdw.ini' then 
				ln_file_version = 2.00
			else
				ln_file_version = 1.00
			end if
		end if
		dw_1.object.file_ver[ln_row] 			=	ln_file_version
		dw_1.object.file_nm[ln_row] 			= 	ls_file_nm
		dw_1.object.file_size[ln_row]			= 	ln_file_size
		dw_1.object.upgrade_detail[ln_row]	= 	'[' + trim(ddlb_gubun.text) + ']-[' + trim(sle_docno.text) + ']-' +  trim(mle_detail.text)
		dw_1.setredraw(true)
		lb_1.DeleteItem(ln_idx)
	else
		exit
	end if
loop

i_b_save 	= 	true
i_b_delete 	= 	false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
				  	i_b_dprint,   i_b_dchar)
end event

event ue_save;call super::ue_save;Integer  	ln_filehdl, ln_row, ln_rowcount, ln_block, ln_cnt, ln_rcnt
Ulong    	ln_byte
Blob     	lb_part, lb_binary
String   	ls_file_nm, ls_system_nm,ls_chk_file,ls_upgrade_detail,ls_chk_pbd
Ulong    	ln_file_size, ln_mfilesiz
Dec      	ln_ver
Boolean  	lb_error
Long		ln_return

dw_1.accepttext()
ln_rowcount = dw_1.rowcount()
f_sysdate()
for 	ln_row = 1 to ln_rowcount
		if 	dw_1.object.cp_status[ln_row] = "new" or dw_1.object.cp_status[ln_row] = "mod" then
			ls_system_nm	= 	lower(dw_1.object.system_nm[ln_row])
			ls_file_nm   		= 	lower(dw_1.object.file_nm[ln_row])
			ls_chk_file   		= 	mid(ls_file_nm,1,4)
			ls_chk_pbd		= 	right(trim(ls_file_nm),4)
			if 	ls_chk_file <> 'kdac' and ls_chk_file <> 'comm' and ls_system_nm = 'kdac' and ls_chk_pbd = '.pbd' then
				select count(*) into :ln_rcnt from pbcommon.comm702
					where file_nm = :ls_file_nm and system_nm = 'blank' 
				using sqlca ;
				if 	ln_rcnt = 0 then
					uo_status.st_message.text = string(ln_row) + "." + is_path + ls_file_nm &
														 + " 의 Blank PBD 파일이 존재하지 않습니다."
					return
				end if	
			end if
			
			if 	FileExists(is_path + ls_file_nm) = false then
				uo_status.st_message.text = string(ln_row) + "." + is_path + ls_file_nm &
								+ "에 파일이 존재하지 않습니다."
				beep(1)
				return
			end if
			 
			ln_file_size		=	dw_1.object.file_size[ln_row]
			ln_mfilesiz 		= 	FileLength(is_path + ls_file_nm)
			if 	ln_file_size <> ln_mfilesiz then
				uo_status.st_message.text = string(ln_row) + "." + is_path + ls_file_nm &
								+ "에 위치한 파일 크기가 기존의 것과 틀립니다."
				beep(1)
				return
			end if
			
			if 	trim(is_system_nm) <> trim(ls_system_nm) then
				uo_status.st_message.text = string(ln_row) + "." + is_path + ls_file_nm &
								+ "에 위치한 사용구분이 조회된 사용구분과 틀립니다."
				beep(1)
				return
			end if
			dw_1.object.confirm_flag[ln_row]   	= 	'N'
			dw_1.object.confirm_date[ln_row]   	= 	''
			dw_1.object.updt_id[ln_row]   			= 	g_s_empno
			dw_1.object.updt_dt[ln_row]   			= 	g_s_datetime
			if 	dw_1.object.cp_status[ln_row] 	= 	"new" then
				dw_1.object.inpt_id[ln_row]  		= 	g_s_empno
				dw_1.object.inpt_dt[ln_row]  		= 	g_s_datetime	
			end if
		end if
next

if 	dw_1.modifiedcount() = 0 and dw_1.deletedcount() = 0 then
   	uo_status.st_message.text = "변경사항 없음"
	beep(1)
	return
end if

f_pism_working_msg(This.title,"AutoDown 프로그램 정보를 저장중입니다. 잠시만 기다려 주십시오.") 
lb_error = false

if 	dw_1.update() = 1 then
	if 	dw_1.rowcount() > 0 then 
		for	ln_row = 1 to ln_rowcount
				if 	dw_1.object.cp_status[ln_row] = "new" or dw_1.object.cp_status[ln_row] = "mod" then
					ls_file_nm   			= 	lower(dw_1.object.file_nm[ln_row])
					ln_file_size 			= 	dw_1.object.file_size[ln_row]
					ln_ver      	 		= 	dw_1.object.file_ver[ln_row]
					ls_upgrade_detail	=	dw_1.object.upgrade_detail[ln_row]
					ln_filehdl				=	FileOpen( is_path + ls_file_nm, StreamMode!, Read!, LockRead!)
					if 	ln_file_size > 32765 then
						if 	mod(ln_file_size, 32765) = 0 then
							ln_block = ln_file_size / 32765
						else
							ln_block = ( ln_file_size / 32765 ) + 1
						end if
					else
						ln_block = 	1
					end if
					
					ln_byte   	=	fileread(ln_filehdl, lb_part)
					lb_binary 	= 	lb_part
					
					if 	ln_block	>	1	then
						for		ln_cnt		=	2	to	ln_block
								ln_byte   += 	fileread(ln_filehdl, lb_part)
								lb_binary	+= 	lb_part
						next
					end if
					fileclose(ln_filehdl) 
					if 	ln_byte = ln_file_size then
						if 	dw_1.object.cp_status[ln_row] = "new" and is_system_nm = 'blank' then
							insert into pbcommon.comm702
							  ( system_nm, file_nm, file_ver,	file_size,	 	inpt_id,
								 inpt_dt,	updt_id,	updt_dt,		confirm_flag,	confirm_date,	upgrade_detail )  
							values
							  ( 'kdac', 	:ls_file_nm,  :ln_ver, 	:ln_file_size,
								 :g_s_empno,   :g_s_datetime,	:g_s_empno ,	:g_s_datetime,	'N',	'',	:ls_upgrade_detail)  using sqlca;
							UPDATEBLOB pbcommon.comm702
								SET binary_value = :lb_binary 
							WHERE system_nm     = 'kdac'
									file_nm       = :ls_file_nm   using sqlca;	 
							UPDATEBLOB pbcommon.comm702
								SET binary_old = :lb_binary
							WHERE system_nm     = 'kdac'
									file_nm       = :ls_file_nm   using sqlca;	 								
						end if
						
	//					blob		lb_binaryold
	//					SELECTBLOB binary_value		INTO 	:lb_binaryold
	//					FROM 		pbcommon.comm702
	//				  	WHERE 	system_nm   	= :ls_system_nm
	//					AND		file_nm	  	= :ls_file_nm
	//					USING 	sqlca;
	
						Integer  	ln_filehdl_old,ln_block_old
						Ulong    	ln_byte_old
						Blob		lb_old_part,lb_binaryold
						
						ln_return			=	Filelength("c:\kdac\" + ls_file_nm )
						ln_filehdl_old 	= 	FileOpen("c:\kdac\" + ls_file_nm, StreamMode!, Read!, LockRead!)
						if 	ln_return > 32765 then
							if 	mod(ln_return, 32765) = 0 then
								ln_block_old = ln_return / 32765
							else
								ln_block_old = ( ln_return / 32765 ) + 1
							end if
						else
							ln_block_old = 1
						end if
						
						ln_byte_old	=	fileread(ln_filehdl_old, lb_binaryold)
						if	ln_byte_old	=	-1	then
							setnull(lb_old_part)
						else
							lb_old_part 	= 	lb_binaryold
						end if
						
						if ln_block_old > 1 then
							for ln_cnt = 2 to ln_block_old
								ln_byte_old	+= 	fileread(ln_filehdl_old, lb_binaryold)
								lb_old_part 	+=	lb_binaryold
							next
						end if
						fileclose(ln_filehdl_old) 
					
						UPDATEBLOB 	pbcommon.comm702
							SET 	binary_old 	= :lb_old_part
						WHERE 	system_nm   = :is_system_nm
						and 		file_nm      	= :ls_file_nm
						using sqlca;
						UPDATEBLOB 	pbcommon.comm702
							SET 	binary_value = :lb_binary
						WHERE 	system_nm   = :is_system_nm
						and 		file_nm      	= :ls_file_nm
						using sqlca;
						if 	sqlca.sqlcode = 0 then
							commit using sqlca;
							uo_status.st_message.text = ls_file_nm + " 저장 완료 ( AS/400 )."
							wf_server_update(ls_file_nm,ln_ver,ln_file_size,lb_binary,' ',ls_upgrade_detail,lb_old_part)
						else
							messagebox("확인",sqlca.sqlerrtext + string(sqlca.sqlcode))
							rollback using sqlca;	
							uo_status.st_message.text = string(ln_row) + "." + ls_file_nm + " 저장 실패..." &
											+ "실행 중단"
							lb_error = true
							exit
						end if
					else
						uo_status.st_message.text = string(ln_row) + "." + ls_file_nm + "읽기 실패..." &
										+ "검색한 (" + string(ln_file_size) + ")Byte와 " &
										+ "읽은 (" + string(ln_byte) + ")Byte가 " &
										+ "서로 다릅니다."
						lb_error = true
						exit
					end if
				end if
		next
	end if
   	commit using sqlca;
else
	uo_status.st_message.text	=  f_message("E025")	// [저장 실패] 정보시스템팀으로 연락바랍니다. 
	rollback using sqlca;
	lb_error = true
end if

If	IsValid(w_pism_working) Then Close(w_pism_working)

if 	lb_error = false then
	dw_1.reset()
	lb_1.reset()
	lb_1.DirList(is_path + ddlb_2.text, 0)
	timer(1)
	uo_status.st_message.text = "저장완료"
else
	beep(1)
end if
dw_wait.retrieve('N',g_s_empno)
postevent("ue_retrieve")

end event

event ue_delete;call super::ue_delete;//if 	g_s_empno = 'ADMIN'	then
//	messagebox("확인","ADMIN 은 삭제권한이 없습니다")
//	return
//end if
//

Integer 	ln_row, ln_rowcount, ln_cnt
String 	ls_name
Blob		ls_blob 

ls_blob 	=	Blob('A')
 
Setpointer(hourglass!)
ln_rowcount 	=	dw_1.rowcount()
if 	ln_rowcount	>	0	then
	for 	ln_row = 1 to ln_rowcount
		 	if 	dw_1.isselected( ln_row ) = true then	ln_cnt ++
	next
	if 	ln_cnt > 0 then
		if 	MessageBox("확 인", "청색으로 선택(" + string(ln_cnt) + " 건)된 자료를 삭제 하시겠습니까?", &
										Exclamation!, YesNo! , 2) = 1 then
			for 	ln_row = ln_rowcount to 1 step -1
				 	if 	dw_1.isselected( ln_row ) = true then
						ls_name = trim(dw_1.object.file_nm[ln_row])
						delete from comm702
							where system_nm = :is_system_nm and file_nm = :ls_name
						using sqlca ;
						wf_server_update(ls_name,0,0,ls_blob,'Y','',ls_blob)
						dw_1.deleterow(ln_row)
					 end if
			next
			this.triggerevent("ue_retrieve")
			uo_status.st_message.text = "삭제완료 ( AS/400 )"
		end if
	else
		uo_status.st_message.text = "삭제할 자료가 없습니다."
		beep(1)
	end if
else
	uo_status.st_message.text = "삭제할 자료가 없습니다."
	beep(1)
end if

end event

event timer;call super::timer;SetPointer(HourGlass!)
f_sysdate()
uo_status.st_date.text    = 	String(g_s_date, "@@@@-@@-@@")
uo_status.st_time.text 	=	mid(g_s_time,1,5)
dw_wait.retrieve('N',g_s_empno)
SetPointer(Arrow!)

end event

event activate;call super::activate;f_sysdate()
uo_status.st_date.text    = 	String(g_s_date, "@@@@-@@-@@")
uo_status.st_time.text 	=	mid(g_s_time,1,5)
dw_wait.retrieve('N',g_s_empno)
end event

type uo_status from w_origin_sheet01`uo_status within w_comm311u
end type

type st_top from statictext within w_comm311u
integer x = 55
integer y = 48
integer width = 453
integer height = 112
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "파일 구분 :"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_comm311u
integer x = 517
integer y = 52
integer width = 1394
integer height = 452
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 128
long backcolor = 15780518
boolean sorted = false
boolean vscrollbar = true
string item[] = {"PBD(Using)","PBD(Blank)","그림 파일","현장단말기","금형단말기"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String 	commnt, owner, val
String	trac

if 	index 		= 	1 	then
	val = 'kdac'
elseif index 	= 	2 	then
	val = 'blank'
elseif index	=	3 	then
	val = 'ebmp'
elseif index	=	4	then
	val = 'ipis'	
elseif index	=	5	then
	val = 'mpms'	
end if

is_system_nm	=	val

ddlb_2.triggerevent("selectionchanged")



end event

type sle_1 from singlelineedit within w_comm311u
integer x = 3680
integer y = 112
integer width = 896
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 15780518
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;is_path = sle_1.text
lb_1.reset()
lb_1.DirList(is_path + ddlb_2.text, 0)
parent.triggerevent("ue_retrieve")

end event

type ddlb_2 from dropdownlistbox within w_comm311u
integer x = 3685
integer y = 212
integer width = 891
integer height = 1052
integer taborder = 40
integer textsize = -13
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 15780518
string text = "*.pbd"
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"*.PBD","*.EXE","*.*"}
end type

event selectionchanged;lb_1.reset()
lb_1.DirList(is_path + ddlb_2.text, 0)
parent.triggerevent("ue_retrieve")



end event

event modified;lb_1.reset()
lb_1.DirList(is_path + ddlb_2.text, 0)
parent.triggerevent("ue_retrieve")
end event

type dw_1 from datawindow within w_comm311u
integer x = 14
integer y = 212
integer width = 3653
integer height = 1580
integer taborder = 20
string dataobject = "d_comm311u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row > 0 then
	this.selectrow(0	, false)
	this.selectrow(row, true)
end if

end event

event getfocus;call super::getfocus;
end event

event losefocus;call super::losefocus;
end event

event itemchanged;i_b_save = true
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
				  i_b_dprint,   i_b_dchar)
end event

event dragdrop;parent.triggerevent("ue_insert")
end event

type cb_1 from commandbutton within w_comm311u
integer x = 3680
integer y = 20
integer width = 896
integer height = 92
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "폴더 선택"
end type

event clicked;long value
string docname, named, ls_path,ls_temp
int ret

value = GetFileOpenName("Select File",  &
		  docname, named, "All File", "All Files (*.*),*.*")
value = pos(docname, named)
ls_path = left(docname, value - 1)
if f_spacechk(ls_path) = -1 then
	return
end if
if ls_path <> is_path  then
	is_path = ls_path
	ddlb_2.triggerevent("selectionchanged")
end if
//parent.triggerevent("ue_retrieve")
sle_1.text = is_path 

end event

type lb_1 from listbox within w_comm311u
event getfocus pbm_lbnsetfocus
integer x = 3680
integer y = 332
integer width = 896
integer height = 1460
integer taborder = 50
string dragicon = "WinLogo!"
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 12632256
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
boolean extendedselect = true
end type

event rbuttondown;drag(begin!)
end event

type cb_3 from commandbutton within w_comm311u
boolean visible = false
integer x = 2121
integer y = 148
integer width = 270
integer height = 128
integer taborder = 70
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "군산"
end type

event clicked;//blob l_b_binary
//string l_s_empno
//
//declare test_cur cursor for 
//  select emp_no from pbcommon.comm121	
//using SQLCA ;
//
//open test_cur ;
//  do while true
//    fetch test_cur into :l_s_empno ;
//    if sqlca.sqlcode <> 0 then
//		exit
//	 end if 
//	 selectBLOB emp_pwd  into :l_b_binary
//			from  pbcommon.comm121  
//			WHERE emp_no       = :l_s_empno   using sqlca;
//		
//	 UPDATEBLOB comm121
//		SET emp_pwd = :l_b_binary
//	 WHERE emp_no    = :l_s_empno   using sqlzz;
//	 if sqlzz.sqlcode = 0 then
//		uo_status.st_message.text = " 저장 완료."
//		commit using sqlzz;
//	 else  
//		rollback using sqlzz;
//		return
//	 end if
//  loop
//close test_cur ;
//
//
end event

type dw_4 from datawindow within w_comm311u
boolean visible = false
integer x = 2130
integer y = 420
integer width = 686
integer height = 400
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_comm001_retrieve"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlpis)
end event

type mle_detail from multilineedit within w_comm311u
integer x = 3698
integer y = 2148
integer width = 873
integer height = 288
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 15780518
textcase textcase = upper!
integer limit = 50
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_comm311u
integer x = 3694
integer y = 1828
integer width = 448
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 128
long backcolor = 12632256
string text = "변경사유 등록"
boolean focusrectangle = false
end type

type ddlb_gubun from dropdownlistbox within w_comm311u
integer x = 3698
integer y = 1912
integer width = 873
integer height = 580
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 15780518
boolean autohscroll = true
boolean sorted = false
boolean hscrollbar = true
string item[] = {"서비스 요청서","기능 추가 & 개선","서비스 장애","업무 연락","프로젝트"}
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text	=	'서비스 요청서'
end event

event selectionchanged;if	index	=	1	or	index	=	2	then
	sle_docno.text			=	'서비스요청서 번호를 입력하세요'
	sle_docno.textcolor	=	rgb(255,0,0)
	sle_docno.backcolor	=	15780518
	sle_docno.enabled		=	true
	is_getfocus				=	'0'
elseif	index	=	3 then
	sle_docno.text			=	'서비스장애 번호를 입력하세요'
	sle_docno.textcolor	=	rgb(255,0,0)
	sle_docno.backcolor	=	15780518
	sle_docno.enabled		=	true
	is_getfocus				=	'0'	
elseif	index	=	4	then
	sle_docno.text			=	'업무연락 번호를 입력하세요'
	sle_docno.textcolor	=	rgb(255,0,0)
	sle_docno.backcolor	=	15780518
	sle_docno.enabled		=	true
	is_getfocus				=	'0'	
elseif	index	=	5	then
	sle_docno.text			=	'프로젝트 코드를 입력하세요'
	sle_docno.textcolor	=	rgb(255,0,0)
	sle_docno.backcolor	=	15780518
	sle_docno.enabled		=	true
	is_getfocus				=	'0'		
else	
	sle_docno.text			=	''
	sle_docno.textcolor	=	rgb(0,0,0)
	sle_docno.enabled		=	false
end if
end event

type sle_docno from singlelineedit within w_comm311u
integer x = 3698
integer y = 2036
integer width = 873
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 255
long backcolor = 15780518
string text = "서비스요청서 번호를 입력하세요"
borderstyle borderstyle = stylelowered!
end type

event getfocus;sle_docno.text		=	''
sle_docno.textcolor	=	rgb(255,0,0)
is_getfocus	=	'1'
end event

type dw_wait from datawindow within w_comm311u
integer x = 14
integer y = 1800
integer width = 3648
integer height = 680
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string title = "승인대기 프로그램 List - 자동 조회 (30초마다)"
string dataobject = "d_comm311i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)	;
end event

type gb_1 from groupbox within w_comm311u
integer x = 9
integer width = 1938
integer height = 176
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
end type

