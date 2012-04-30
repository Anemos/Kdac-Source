CREATE TABLE "BPM514" ( 
 "ZCMCD" CHAR(2) NOT NULL  DEFAULT '', 
 "ZDATE" CHAR(4) NOT NULL  DEFAULT '', 
 "ZBREV" CHAR(2) NOT NULL  DEFAULT '', 
 "ZGUBUN" CHAR(1) NOT NULL  DEFAULT '', 
 "ZPLANT" CHAR(1) NOT NULL  DEFAULT '', 
 "ZDIV" CHAR(1) NOT NULL  DEFAULT '', 
 "ZMDCD" VARCHAR(4) NOT NULL  DEFAULT '', 
 "ZMDNO" VARCHAR(12) NOT NULL  DEFAULT '', 
 "ZSERIAL" NUMERIC(4,0) NOT NULL  DEFAULT 0, 
 "ZLEVEL" VARCHAR(10) NOT NULL  DEFAULT '', 
 "ZITNO" VARCHAR(12) NOT NULL  DEFAULT '', 
 "ZREV" CHAR(1) NOT NULL  DEFAULT '', 
 "ZDESC" VARCHAR(50) NOT NULL  DEFAULT '', 
 "ZSPEC" VARCHAR(50) NOT NULL  DEFAULT '', 
 "ZUNITQTY" NUMERIC(11,3) NOT NULL  DEFAULT 0, 
 "ZUNIT1" CHAR(2) NOT NULL  DEFAULT '', 
 "ZCONFACT" NUMERIC(13,5) NOT NULL  DEFAULT 0, 
 "ZUNIT2" CHAR(2) NOT NULL  DEFAULT '', 
 "ZSRCE" CHAR(2) NOT NULL  DEFAULT '', 
 "ZTYPE" CHAR(1) NOT NULL  DEFAULT '', 
 "ZCURD" CHAR(3) NOT NULL  DEFAULT '', 
 "ZCURE" CHAR(3) NOT NULL  DEFAULT '', 
 "ZFOB1" CHAR(1) NOT NULL  DEFAULT '', 
 "ZFOB2" CHAR(1) NOT NULL  DEFAULT '', 
 "ZCHK" CHAR(2) NOT NULL  DEFAULT '', 
 "ZCURDCST" NUMERIC(11,6) NOT NULL  DEFAULT 0, 
 "ZCURECST" NUMERIC(11,6) NOT NULL  DEFAULT 0, 
 "ZWONDCST" NUMERIC(11,6) NOT NULL  DEFAULT 0, 
 "ZWONECST" NUMERIC(11,6) NOT NULL  DEFAULT 0, 
 "ZWONEAMT" NUMERIC(13,6) NOT NULL  DEFAULT 0, 
 "ZWONDAMT" NUMERIC(13,6) NOT NULL  DEFAULT 0, 
 "ZWKCT" CHAR(4) NOT NULL  DEFAULT '', 
 "ZGRAD" CHAR(1) NOT NULL  DEFAULT '', 
 "ZALTNO" VARCHAR(12) NOT NULL  DEFAULT '', 
 "ZFMDT" CHAR(8) NOT NULL  DEFAULT '', 
 "ZTODT" CHAR(8) NOT NULL  DEFAULT '', 
 "ZCALC" CHAR(1) NOT NULL  DEFAULT '', 
PRIMARY KEY ( "ZCMCD",  "ZDATE",  "ZGUBUN",  "ZPLANT",  "ZDIV",  "ZMDCD",  "ZMDNO",  "ZSERIAL" )); 

insert into "PBCOMMON".pbcattbl(pbt_tnam, pbt_ownr, pbd_fhgt, pbd_fwgt, pbd_fitl, pbd_funl, pbd_fchr, pbd_fptc, pbd_ffce, pbh_fhgt, pbh_fwgt, pbh_fitl, pbh_funl, pbh_fchr, pbh_fptc, pbh_ffce, pbl_fhgt, pbl_fwgt, pbl_fitl, pbl_funl, pbl_fchr, pbl_fptc, pbl_ffce, pbt_cmnt)values ( 'BPM514', 'PBBPM', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400, 'N', 'N', 0, 0, '                  ', 0, 400 , 'N', 'N', 0, 0, '                  ', '사업계획BOM내역조회') ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCMCD', '회사', 23 , '회사', 25, 23 , 0 , 0 , 0 , 'N', '회사' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZDATE', '사업계획년도', 23 , '사업계획년도', 25, 23 , 0 , 0 , 0 , 'N', '사업계획년도' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZBREV', '버전', 23 , '버전', 25, 23 , 0 , 0 , 0 , 'N', '버전' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZGUBUN', '배부구분', 23 , '배부구분', 25, 23 , 0 , 0 , 0 , 'N', '배부구분' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZPLANT', '지역', 23 , '지역', 25, 23 , 0 , 0 , 0 , 'N', '지역' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZDIV', '공장', 23 , '공장', 25, 23 , 0 , 0 , 0 , 'N', '공장' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZMDCD', '모델군', 23 , '모델군', 25, 23 , 0 , 0 , 0 , 'N', '모델군' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZMDNO', '제품모델', 23 , '제품모델', 25, 23 , 0 , 0 , 0 , 'N', '제품모델' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZSERIAL', '순번', 23 , '순번', 25, 24 , 0 , 0 , 0 , 'N', '순번' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZLEVEL', '레벨', 23 , '레벨', 25, 23 , 0 , 0 , 0 , 'N', '레벨' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZITNO', '자품번', 23 , '자품번', 25, 23 , 0 , 0 , 0 , 'N', '자품번' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZREV', 'REV', 23 , 'REV', 25, 23 , 0 , 0 , 0 , 'N', 'REV' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZDESC', '품명', 23 , '품명', 25, 23 , 0 , 0 , 0 , 'N', '품명' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZSPEC', '규격', 23 , '규격', 25, 23 , 0 , 0 , 0 , 'N', '규격' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZUNITQTY', '원단위', 23 , '원단위', 25, 24 , 0 , 0 , 0 , 'N', '원단위' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZUNIT1', 'BOM원단위', 23 , 'BOM원단위', 25, 23 , 0 , 0 , 0 , 'N', 'BOM원단위' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCONFACT', '변환계수', 23 , '변환계수', 25, 24 , 0 , 0 , 0 , 'N', '변환계수' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZUNIT2', '구매원단위', 23 , '구매원단위', 25, 23 , 0 , 0 , 0 , 'N', '구매원단위' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZSRCE', '구입선', 23 , '구입선', 25, 23 , 0 , 0 , 0 , 'N', '구입선' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZTYPE', '타입', 23 , '타입', 25, 23 , 0 , 0 , 0 , 'N', '타입' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCURD', '내자통화', 23 , '내자통화', 25, 23 , 0 , 0 , 0 , 'N', '내자통화' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCURE', '외자통화', 23 , '외자통화', 25, 23 , 0 , 0 , 0 , 'N', '외자통화' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZFOB1', 'FOB1', 23 , 'FOB1', 25, 23 , 0 , 0 , 0 , 'N', 'FOB1' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZFOB2', 'FOB2', 23 , 'FOB2', 25, 23 , 0 , 0 , 0 , 'N', 'FOB2' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCHK', '검증', 23 , '검증', 25, 23 , 0 , 0 , 0 , 'N', '검증' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCURDCST', '내자단가', 23 , '내자단가', 25, 24 , 0 , 0 , 0 , 'N', '내자단가' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCURECST', '외자단가', 23 , '외자단가', 25, 24 , 0 , 0 , 0 , 'N', '외자단가' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZWONDCST', '내자단가(원환)', 23 , '내자단가(원환)', 25, 24 , 0 , 0 , 0 , 'N', '내자단가(원환)' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZWONECST', '외자단가(원화)', 23 , '외자단가(원화)', 25, 24 , 0 , 0 , 0 , 'N', '외자단가(원화)' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZWONEAMT', '외자금액', 23 , '외자금액', 25, 24 , 0 , 0 , 0 , 'N', '외자금액' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZWONDAMT', '내자금액', 23 , '내자금액', 25, 24 , 0 , 0 , 0 , 'N', '내자금액' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZWKCT', '사업장', 23 , '사업장', 25, 23 , 0 , 0 , 0 , 'N', '사업장' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZGRAD', '등급', 23 , '등급', 25, 23 , 0 , 0 , 0 , 'N', '등급' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZALTNO', '이체', 23 , '이체', 25, 23 , 0 , 0 , 0 , 'N', '이체' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZFMDT', '시작일자', 23 , '시작일자', 25, 23 , 0 , 0 , 0 , 'N', '시작일자' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZTODT', '완료일자', 23 , '완료일자', 25, 23 , 0 , 0 , 0 , 'N', '완료일자' ) ; 
insert into "PBCOMMON".pbcatcol(pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ( 'BPM514', 'PBBPM', 'ZCALC', '재료비대상', 23 , '재료비대상', 25, 23 , 0 , 0 , 0 , 'N', '재료비대상' ) ; 

