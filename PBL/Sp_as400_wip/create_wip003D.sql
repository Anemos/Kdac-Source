--  Generate SQL
--  Version:                    V5R3M0 040528
--  Generated on:               08/08/14 12:07:26
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

DROP TABLE PBWIP.WIP003D;

CREATE TABLE PBWIP.WIP003D (
  WCCMCD CHAR(2) CCSID 833 NOT NULL ,
  WCPLANT CHAR(1) CCSID 833 NOT NULL ,
  WCDVSN CHAR(1) CCSID 833 NOT NULL ,
  WCITNO CHAR(15) CCSID 933 NOT NULL ,
  WCYYMMDD CHAR(8) CCSID 933 NOT NULL ,
  WCITCL CHAR(2) CCSID 833 NOT NULL ,
  WCSRCE CHAR(2) CCSID 833 NOT NULL ,
  WCPDCD CHAR(2) CCSID 833 NOT NULL ,
  WCAVRG1 DECIMAL(15, 5) NOT NULL ,
  WCAVRG2 DECIMAL(15, 5) NOT NULL ,
  WCBGQT DECIMAL(15, 4) NOT NULL ,
  WCBGAT1 DECIMAL(15, 0) NOT NULL ,
  WCBGAT2 DECIMAL(15, 0) NOT NULL ,
  WCINQT DECIMAL(15, 4) NOT NULL ,
  WCINAT1 DECIMAL(15, 0) NOT NULL ,
  WCINAT2 DECIMAL(15, 0) NOT NULL ,
  WCUSQT1 DECIMAL(15, 4) NOT NULL ,
  WCUSAT1 DECIMAL(15, 0) NOT NULL ,
  WCUSQT2 DECIMAL(15, 4) NOT NULL ,
  WCUSAT2 DECIMAL(15, 0) NOT NULL ,
  WCUSQT3 DECIMAL(15, 4) NOT NULL ,
  WCUSAT3 DECIMAL(15, 0) NOT NULL ,
  WCUSQT4 DECIMAL(15, 4) NOT NULL ,
  WCUSAT4 DECIMAL(15, 0) NOT NULL ,
  WCUSQT5 DECIMAL(15, 4) NOT NULL ,
  WCUSAT5 DECIMAL(15, 0) NOT NULL ,
  WCUSQT6 DECIMAL(15, 4) NOT NULL ,
  WCUSAT6 DECIMAL(15, 0) NOT NULL ,
  WCUSAT7 DECIMAL(15, 0) NOT NULL ,
  WCUSQT8 DECIMAL(15, 4) NOT NULL ,
  WCUSAT8 DECIMAL(15, 0) NOT NULL ,
  WCUSAT9 DECIMAL(15, 0) NOT NULL ,
  WCOHQT DECIMAL(15, 4) NOT NULL ,
  WCOHAT1 DECIMAL(15, 0) NOT NULL ,
  WCOHAT2 DECIMAL(15, 0) NOT NULL ,
  WCIPADDR CHAR(30) CCSID 933 NOT NULL ,
  WCMACADDR CHAR(30) CCSID 933 NOT NULL ,
  WCINPTDT CHAR(8) CCSID 933 NOT NULL ,
  WCUPDTDT CHAR(8) CCSID 933 NOT NULL ,
  PRIMARY KEY( WCCMCD , WCPLANT , WCDVSN , WCITNO , WCYYMMDD ) ) ;