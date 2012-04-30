CREATE TABLE "WIP007" ("WGCMCD" CHAR(2) NOT NULL, "WGPLANT" CHAR(1) NOT NULL, "WGDVSN" CHAR(1) NOT NULL, "WGITNO" CHAR(15) NOT NULL, "WGPHQT" DECIMAL(11,1) NOT NULL, "WGIPADDR" CHAR(30) NOT NULL, "WGMACADDR" CHAR(30) NOT NULL, "WGINPTDT" CHAR(8) NOT NULL, "WGUPDTDT" CHAR(8) NOT NULL , PRIMARY KEY ("WGCMCD", "WGPLANT", "WGDVSN", "WGITNO")) ;
CREATE UNIQUE INDEX "WIP007" ON "WIP007" ("WGCMCD", "WGPLANT", "WGDVSN", "WGITNO") ;
insert into "PBCOMMON".pbcattbl (pbt_tnam, pbt_ownr, pbd_fhgt, pbd_fwgt, pbd_fitl, pbd_funl, pbd_fchr, pbd_fptc, pbd_ffce, pbh_fhgt, pbh_fwgt, pbh_fitl, pbh_funl, pbh_fchr, pbh_fptc, pbh_ffce, pbl_fhgt, pbl_fwgt, pbl_fitl, pbl_funl, pbl_fchr, pbl_fptc, pbl_ffce, pbt_cmnt) values ('WIP007', 'PBWIP', -10, 400, 'N', 'N', 0, 34, '굴림체          ', -10, 400, 'N', 'N', 0, 34, '굴림체          ', -10, 400 , 'N', 'N', 0, 34, '굴림체          ', '자가품 실사 DB') ;
insert into "PBCOMMON".pbcatcol (pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ('WIP007', 'PBWIP', 'WGCMCD', '회사', 23 , '회사', 25, 25 , 0 , 0 , 0 , 'N', '회사' ) ;
insert into "PBCOMMON".pbcatcol (pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ('WIP007', 'PBWIP', 'WGPLANT', '지역', 23 , '지역', 25, 25 , 0 , 0 , 0 , 'N', '지역' ) ;
insert into "PBCOMMON".pbcatcol (pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ('WIP007', 'PBWIP', 'WGDVSN', '공장', 23 , '공장', 25, 25 , 0 , 0 , 0 , 'N', '공장' ) ;
insert into "PBCOMMON".pbcatcol (pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ('WIP007', 'PBWIP', 'WGITNO', '품번', 23 , '품번', 25, 25 , 0 , 0 , 0 , 'N', '품번' ) ;
insert into "PBCOMMON".pbcatcol (pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ('WIP007', 'PBWIP', 'WGPHQT', '실사수량', 23 , '실사수량', 25, 25 , 0 , 0 , 0 , 'N', '실사수량' ) ;
insert into "PBCOMMON".pbcatcol (pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ('WIP007', 'PBWIP', 'WGIPADDR', 'IP ADDRESS', 23 , 'IP ADDRESS', 25, 25 , 0 , 0 , 0 , 'N', 'IPADDRESS' ) ;
insert into "PBCOMMON".pbcatcol (pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ('WIP007', 'PBWIP', 'WGMACADDR', '장비번호', 23 , '장비번호', 25, 25 , 0 , 0 , 0 , 'N', '장비번호' ) ;
insert into "PBCOMMON".pbcatcol (pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ('WIP007', 'PBWIP', 'WGINPTDT', '입력일', 23 , '입력일', 25, 25 , 0 , 0 , 0 , 'N', '입력일' ) ;
insert into "PBCOMMON".pbcatcol (pbc_tnam, pbc_ownr, pbc_cnam, pbc_labl, pbc_lpos, pbc_hdr, pbc_hpos, pbc_jtfy, pbc_case, pbc_hght, pbc_wdth, pbc_bmap, pbc_cmnt ) values ('WIP007', 'PBWIP', 'WGUPDTDT', '수정일', 23 , '수정일', 25, 25 , 0 , 0 , 0 , 'N', '수정일' ) ;
