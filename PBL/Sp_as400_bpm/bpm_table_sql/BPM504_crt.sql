CREATE TABLE "BPM504" ( 
 "PCMCD" CHAR(2) NOT NULL  DEFAULT '', 
 "XYEAR" CHAR(4) NOT NULL  DEFAULT '', 
 "REVNO" CHAR(2) NOT NULL  DEFAULT '', 
 "PLANT" CHAR(1) NOT NULL  DEFAULT '', 
 "PDVSN" CHAR(1) NOT NULL  DEFAULT '', 
 "PPITN" VARCHAR(15) NOT NULL  DEFAULT '', 
 "PROUT" CHAR(4) NOT NULL  DEFAULT '', 
 "PCITN" VARCHAR(15) NOT NULL  DEFAULT '', 
 "PCHDT" CHAR(8) NOT NULL  DEFAULT '', 
 "PQTYM" NUMERIC(8,3) NOT NULL  DEFAULT 0, 
 "PQTYE" NUMERIC(8,3) NOT NULL  DEFAULT 0, 
 "PWKCT" CHAR(4) NOT NULL  DEFAULT '', 
 "PEDTM" CHAR(8) NOT NULL  DEFAULT '', 
 "PEDTE" CHAR(8) NOT NULL  DEFAULT '', 
 "POPCD" CHAR(1) NOT NULL  DEFAULT '', 
 "PEXPLANT" CHAR(1) NOT NULL  DEFAULT '', 
 "PEXDV" CHAR(1) NOT NULL  DEFAULT '', 
 "PCHCD" CHAR(1) NOT NULL  DEFAULT '', 
 "POSCD" CHAR(1) NOT NULL  DEFAULT '', 
 "PEBST" CHAR(1) NOT NULL  DEFAULT '', 
 "PMACADDR" VARCHAR(30) NOT NULL  DEFAULT '', 
 "PIPADDR" VARCHAR(30) NOT NULL  DEFAULT '', 
 "PINDT" CHAR(8) NOT NULL  DEFAULT '', 
 "PEMNO" CHAR(6) NOT NULL  DEFAULT '', 
 "PREMK" CHAR(20) NOT NULL  DEFAULT '', 
PRIMARY KEY ( "PCMCD",  "XYEAR",  "REVNO",  "PLANT",  "PDVSN",  "PPITN",  "PROUT",  "PCITN",  "PCHDT" )); 

insert into "PBCOMMON".pbcattbl(pbt_tnam, pbt_ownr, pbd_fhgt, pbd_fwgt, pbd_fitl, pbd_funl, pbd_fchr, pbd_fptc, pbd_ffce, pbh_fhgt, pbh_fwgt, pbh_fitl, pbh_funl, pbh_fchr, pbh_fptc, pbh_ffce, pbl_fhgt, pbl_fwgt, pbl_fitl, pbl_funl, pbl_fchr, pbl_fptc, pbl_ffce, pbt_cmnt)values ( 'BPM504', 'PBBPM', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400 , 'N', 'N', 0, 0, '                  ', '사업계획BOM등록') ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PCMCD', '회사', 23 , '회사', 25, 23 , 0 , 0 , 0 , 'N', '회사' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'XYEAR', '사업계획년도', 23 , '사업계획년도', 25, 23 , 0 , 0 , 0 , 'N', '사업계획년도' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'REVNO', '버전', 23 , '버전', 25, 23 , 0 , 0 , 0 , 'N', '버전' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PLANT', '지역', 23 , '지역', 25, 23 , 0 , 0 , 0 , 'N', '지역' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PDVSN', '공장', 23 , '공장', 25, 23 , 0 , 0 , 0 , 'N', '공장' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PPITN', '상위품번', 23 , '상위품번', 25, 23 , 0 , 0 , 0 , 'N', '상위품번' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PROUT', '라우팅', 23 , '라우팅', 25, 23 , 0 , 0 , 0 , 'N', '라우팅' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PCITN', '하위품번', 23 , '하위품번', 25, 23 , 0 , 0 , 0 , 'N', '하위품번' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PCHDT', '수정일자', 23 , '수정일자', 25, 23 , 0 , 0 , 0 , 'N', '수정일자' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PQTYM', '원단위(생산)', 23 , '원단위(생산)', 25, 24 , 0 , 0 , 0 , 'N', '원단위(생산)' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PQTYE', '원단위(연구)', 23 , '원단위(연구)', 25, 24 , 0 , 0 , 0 , 'N', '원단위(연구)' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PWKCT', '작업장', 23 , '작업장', 25, 23 , 0 , 0 , 0 , 'N', '작업장' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PEDTM', '적용일자', 23 , '적용일자', 25, 23 , 0 , 0 , 0 , 'N', '적용일자' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PEDTE', '완료일자', 23 , '완료일자', 25, 23 , 0 , 0 , 0 , 'N', '완료일자' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'POPCD', '호환구분', 23 , '호환구분', 25, 23 , 0 , 0 , 0 , 'N', '호환구분' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PEXPLANT', '이체지역', 23 , '이체지역', 25, 23 , 0 , 0 , 0 , 'N', '이체지역' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PEXDV', '이체공장', 23 , '이체공장', 25, 23 , 0 , 0 , 0 , 'N', '이체공장' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PCHCD', '변경구분', 23 , '변경구분', 25, 23 , 0 , 0 , 0 , 'N', '변경구분' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'POSCD', '사급구분', 23 , '사급구분', 25, 23 , 0 , 0 , 0 , 'N', '사급구분' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PEBST', '연구코드', 23 , '연구코드', 25, 23 , 0 , 0 , 0 , 'N', '연구코드' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PMACADDR', 'MAC ADDRESS', 23 , 'MAC ADDRESS', 25, 23 , 0 , 0 , 0 , 'N', 'MAC ADDRESS' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PIPADDR', 'IP ADDRESS', 23 , 'IP ADDRESS', 25, 23 , 0 , 0 , 0 , 'N', 'IP ADDRESS' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PINDT', '수정일자', 23 , '수정일자', 25, 23 , 0 , 0 , 0 , 'N', '수정일자' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PEMNO', '수정자', 23 , '수정자', 25, 23 , 0 , 0 , 0 , 'N', '수정자' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM504', 'PBBPM', 'PREMK', '비고', 23 , '비고', 25, 23 , 0 , 0 , 0 , 'N', '비고' ) ; 

