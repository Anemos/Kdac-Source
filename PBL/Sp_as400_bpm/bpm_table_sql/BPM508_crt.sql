CREATE TABLE "BPM508" ( 
 "COMLTD" CHAR(2) NOT NULL  DEFAULT '', 
 "XYEAR" CHAR(4) NOT NULL  DEFAULT '', 
 "BREV" CHAR(2) NOT NULL  DEFAULT '', 
 "BGUBUN" CHAR(1) NOT NULL  DEFAULT '', 
 "BPLANT" CHAR(1) NOT NULL  DEFAULT '', 
 "BDIV" CHAR(1) NOT NULL  DEFAULT '', 
 "BMDCD" CHAR(4) NOT NULL  DEFAULT '', 
 "BMDNO" CHAR(12) NOT NULL  DEFAULT '', 
 "BSERNO" NUMERIC(4,0) NOT NULL  DEFAULT 0, 
 "BPRNO" CHAR(12) NOT NULL  DEFAULT '', 
 "BCHNO" CHAR(12) NOT NULL  DEFAULT '', 
 "BLEV" NUMERIC(2,0) NOT NULL  DEFAULT 0, 
 "BLOLE" NUMERIC(2,0) NOT NULL  DEFAULT 0, 
 "BUM" CHAR(2) NOT NULL  DEFAULT '', 
 "BWOCT" CHAR(4) NOT NULL  DEFAULT '', 
 "BPRQT" NUMERIC(9,3) NOT NULL  DEFAULT 0, 
 "BPRQT1" NUMERIC(9,3) NOT NULL  DEFAULT 0, 
 "BFMDT" CHAR(8) NOT NULL  DEFAULT '', 
 "BTODT" CHAR(8) NOT NULL  DEFAULT '', 
 "BALCD" CHAR(1) NOT NULL  DEFAULT '', 
 "BYOU" CHAR(1) NOT NULL  DEFAULT '', 
 "BGRAD" CHAR(1) NOT NULL  DEFAULT '', 
 "BALTNO" VARCHAR(12) NOT NULL  DEFAULT '', 
 "BCALC" CHAR(1) NOT NULL  DEFAULT '', 
 "EXTD" CHAR(10) NOT NULL  DEFAULT '', 
 "INPTID" CHAR(6) NOT NULL  DEFAULT '', 
 "INPTDT" CHAR(19) NOT NULL  DEFAULT '', 
 "UPDTID" CHAR(6) NOT NULL  DEFAULT '', 
 "UPDTDT" CHAR(19) NOT NULL  DEFAULT '', 
 "IPADDR" CHAR(30) NOT NULL  DEFAULT '', 
 "MACADDR" CHAR(30) NOT NULL  DEFAULT '', 
PRIMARY KEY ( "COMLTD",  "XYEAR",  "BREV",  "BGUBUN",  "BPLANT",  "BDIV",  "BMDCD",  "BMDNO",  "BSERNO" )); 

insert into "PBCOMMON".pbcattbl(pbt_tnam, pbt_ownr, pbd_fhgt, pbd_fwgt, pbd_fitl, pbd_funl, pbd_fchr, pbd_fptc, pbd_ffce, pbh_fhgt, pbh_fwgt, pbh_fitl, pbh_funl, pbh_fchr, pbh_fptc, pbh_ffce, pbl_fhgt, pbl_fwgt, pbl_fitl, pbl_funl, pbl_fchr, pbl_fptc, pbl_ffce, pbt_cmnt)values ( 'BPM508', 'PBBPM', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400 , 'N', 'N', 0, 0, '                  ', '사업계획BOM원단위정보') ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'COMLTD', '회사', 23 , '회사', 25, 23 , 0 , 0 , 0 , 'N', '회사' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'XYEAR', '사업계획년도', 23 , '사업계획년도', 25, 23 , 0 , 0 , 0 , 'N', '사업계획년도' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BREV', '버전', 23 , '버전', 25, 23 , 0 , 0 , 0 , 'N', '버전' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BGUBUN', '배부구분', 23 , '배부구분', 25, 23 , 0 , 0 , 0 , 'N', '배부구분' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BPLANT', '지역', 23 , '지역', 25, 23 , 0 , 0 , 0 , 'N', '지역' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BDIV', '공장', 23 , '공장', 25, 23 , 0 , 0 , 0 , 'N', '공장' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BMDCD', '제품군', 23 , '제품군', 25, 23 , 0 , 0 , 0 , 'N', '제품군' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BMDNO', '제품모델', 23 , '제품모델', 25, 23 , 0 , 0 , 0 , 'N', '제품모델' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BSERNO', '순번', 23 , '순번', 25, 24 , 0 , 0 , 0 , 'N', '순번' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BPRNO', '모품번', 23 , '모품번', 25, 23 , 0 , 0 , 0 , 'N', '모품번' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BCHNO', '자품번', 23 , '자품번', 25, 23 , 0 , 0 , 0 , 'N', '자품번' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BLEV', '레벨', 23 , '레벨', 25, 24 , 0 , 0 , 0 , 'N', '레벨' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BLOLE', '최하레벨', 23 , '최하레벨', 25, 24 , 0 , 0 , 0 , 'N', '최하레벨' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BUM', 'BOM단위', 23 , 'BOM단위', 25, 23 , 0 , 0 , 0 , 'N', 'BOM단위' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BWOCT', '조코드', 23 , '조코드', 25, 23 , 0 , 0 , 0 , 'N', '조코드' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BPRQT', '모델원단위', 23 , '모델원단위', 25, 24 , 0 , 0 , 0 , 'N', '모델원단위' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BPRQT1', '개별원단위', 23 , '개별원단위', 25, 24 , 0 , 0 , 0 , 'N', '개별원단위' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BFMDT', '적용일자', 23 , '적용일자', 25, 23 , 0 , 0 , 0 , 'N', '적용일자' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BTODT', '완료일자', 23 , '완료일자', 25, 23 , 0 , 0 , 0 , 'N', '완료일자' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BALCD', '이체여부', 23 , '이체여부', 25, 23 , 0 , 0 , 0 , 'N', '이체여부' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BYOU', '유무상구분', 23 , '유무상구분', 25, 23 , 0 , 0 , 0 , 'N', '유무상구분' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BGRAD', '호환등급', 23 , '호환등급', 25, 23 , 0 , 0 , 0 , 'N', '호환등급' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BALTNO', '호환주품번', 23 , '호환주품번', 25, 23 , 0 , 0 , 0 , 'N', '호환주품번' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'BCALC', '재료비포함', 23 , '재료비포함', 25, 23 , 0 , 0 , 0 , 'N', '재료비포함' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'EXTD', '비고', 23 , '비고', 25, 23 , 0 , 0 , 0 , 'N', '비고' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'INPTID', '입력자 사번', 23 , '입력자 사번', 25, 23 , 0 , 0 , 0 , 'N', '입력자 사번' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'INPTDT', '입력일', 23 , '입력일', 25, 23 , 0 , 0 , 0 , 'N', '입력일' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'UPDTID', '변경자 사번', 23 , '변경자 사번', 25, 23 , 0 , 0 , 0 , 'N', '변경자 사번' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'UPDTDT', '변경일', 23 , '변경일', 25, 23 , 0 , 0 , 0 , 'N', '변경일' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'IPADDR', 'IP ADDRESS', 23 , 'IP ADDRESS', 25, 23 , 0 , 0 , 0 , 'N', 'IP ADDRESS' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM508', 'PBBPM', 'MACADDR', 'MAC ADDRESS', 23 , 'MAC ADDRESS', 25, 23 , 0 , 0 , 0 , 'N', 'MAC ADDRESS' ) ; 

