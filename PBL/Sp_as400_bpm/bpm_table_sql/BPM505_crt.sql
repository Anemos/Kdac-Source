CREATE TABLE "BPM505" ( 
 "OCMCD" CHAR(2) NOT NULL  DEFAULT '', 
 "XYEAR" CHAR(4) NOT NULL  DEFAULT '', 
 "REVNO" CHAR(2) NOT NULL  DEFAULT '', 
 "OPLANT" CHAR(1) NOT NULL  DEFAULT '', 
 "ODVSN" CHAR(1) NOT NULL  DEFAULT '', 
 "OPITN" VARCHAR(15) NOT NULL  DEFAULT '', 
 "OFITN" VARCHAR(15) NOT NULL  DEFAULT '', 
 "OCHDT" CHAR(8) NOT NULL  DEFAULT '', 
 "OEDTM" CHAR(8) NOT NULL  DEFAULT '', 
 "OEDTE" CHAR(8) NOT NULL  DEFAULT '', 
 "ORATE" NUMERIC(5,2) NOT NULL  DEFAULT 0, 
 "OCHCD" CHAR(1) NOT NULL  DEFAULT '', 
 "OFOCD" CHAR(2) NOT NULL  DEFAULT '', 
 "OMACADDR" VARCHAR(30) NOT NULL  DEFAULT '', 
 "OIPADDR" VARCHAR(30) NOT NULL  DEFAULT '', 
 "OEMNO" CHAR(6) NOT NULL  DEFAULT '', 
PRIMARY KEY ( "OCMCD",  "XYEAR",  "REVNO",  "OPLANT",  "ODVSN",  "OPITN",  "OFITN",  "OCHDT" )); 

insert into "PBCOMMON".pbcattbl(pbt_tnam, pbt_ownr, pbd_fhgt, pbd_fwgt, pbd_fitl, pbd_funl, pbd_fchr, pbd_fptc, pbd_ffce, pbh_fhgt, pbh_fwgt, pbh_fitl, pbh_funl, pbh_fchr, pbh_fptc, pbh_ffce, pbl_fhgt, pbl_fwgt, pbl_fitl, pbl_funl, pbl_fchr, pbl_fptc, pbl_ffce, pbt_cmnt)values ( 'BPM505', 'PBBPM', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400 , 'N', 'N', 0, 0, '                  ', '사업계획BOM호환등록') ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OCMCD', '회사', 23 , '회사', 25, 23 , 0 , 0 , 0 , 'N', '회사' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'XYEAR', '사업계획년도', 23 , '사업계획년도', 25, 23 , 0 , 0 , 0 , 'N', '사업계획년도' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'REVNO', '버전', 23 , '버전', 25, 23 , 0 , 0 , 0 , 'N', '버전' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OPLANT', '지역', 23 , '지역', 25, 23 , 0 , 0 , 0 , 'N', '지역' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'ODVSN', '공장', 23 , '공장', 25, 23 , 0 , 0 , 0 , 'N', '공장' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OPITN', '주품번', 23 , '주품번', 25, 23 , 0 , 0 , 0 , 'N', '주품번' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OFITN', '부품번', 23 , '부품번', 25, 23 , 0 , 0 , 0 , 'N', '부품번' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OCHDT', '수정일자', 23 , '수정일자', 25, 23 , 0 , 0 , 0 , 'N', '수정일자' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OEDTM', '적용일자', 23 , '적용일자', 25, 23 , 0 , 0 , 0 , 'N', '적용일자' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OEDTE', '완료일자', 23 , '완료일자', 25, 23 , 0 , 0 , 0 , 'N', '완료일자' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'ORATE', '호환율', 23 , '호환율', 25, 24 , 0 , 0 , 0 , 'N', '호환율' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OCHCD', '변경구분', 23 , '변경구분', 25, 23 , 0 , 0 , 0 , 'N', '변경구분' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OFOCD', '옵션', 23 , '옵션', 25, 23 , 0 , 0 , 0 , 'N', '옵션' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OMACADDR', 'MAC ADDRESS', 23 , 'MAC ADDRESS', 25, 23 , 0 , 0 , 0 , 'N', 'MAC ADDRESS' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OIPADDR', 'IP ADDRESS', 23 , 'IP ADDRESS', 25, 23 , 0 , 0 , 0 , 'N', 'IP ADDRESS' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM505', 'PBBPM', 'OEMNO', '수정자', 23 , '수정자', 25, 23 , 0 , 0 , 0 , 'N', '수정자' ) ; 

