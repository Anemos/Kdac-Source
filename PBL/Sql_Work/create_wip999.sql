DROP TABLE "WIP999";

CREATE TABLE "WIP999" ("YYDT" CHAR(4) NOT NULL, "PLANT" CHAR(1) NOT NULL, "DVSN" CHAR(1) NOT NULL, 
"PDCD" CHAR(4) NOT NULL, 
"PDNM" CHAR(60) NOT NULL, "ORCT" CHAR(5) NOT NULL, "ITNO" CHAR(15) NOT NULL, "IOCD" CHAR(1) NOT NULL,
"DESC" CHAR(50) NOT NULL, "SPEC" CHAR(50) NOT NULL,"ITCL" CHAR(2) NOT NULL, "SRCE" CHAR(2) NOT NULL, 
"UNIT" CHAR(2) NOT NULL, "AVRG1" DECIMAL(15,5) NOT NULL, "BGQT" DECIMAL(13,2) NOT NULL, 
"BGAT1" DECIMAL(15,0) NOT NULL, "INQT" DECIMAL(13,2) NOT NULL, "INAT" DECIMAL(15,0) NOT NULL, 
"USQT1" DECIMAL(13,2) NOT NULL, "USAT1" DECIMAL(15,0) NOT NULL, 
"USQT2" DECIMAL(13,2) NOT NULL, "USAT2" DECIMAL(15,0) NOT NULL, 
"USQT3" DECIMAL(13,2) NOT NULL, "USAT3" DECIMAL(15,0) NOT NULL, 
"USQT4" DECIMAL(13,2) NOT NULL, "USAT4" DECIMAL(15,0) NOT NULL,
"USQT5" DECIMAL(13,2) NOT NULL, "USAT5" DECIMAL(15,0) NOT NULL, 
"USQT6" DECIMAL(13,2) NOT NULL, "USAT6" DECIMAL(15,0) NOT NULL, 
"OHQT" DECIMAL(13,2) NOT NULL, "OHAT" DECIMAL(15,0) NOT NULL) ;
CREATE INDEX "WIP999" ON "WIP999" ("YYDT","PLANT", "DVSN", "ORCT", "ITNO") ;
