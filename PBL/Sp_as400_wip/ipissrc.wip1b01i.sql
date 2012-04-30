       IDENTIFICATION      DIVISION.
       PROGRAM-ID.         WP1B07.
      *****************************************************
      *       WIP SOYO       CALC    PROGRAM              *
      *****************************************************
       AUTHOR.             CHO TAE SEOB.
       ENVIRONMENT         DIVISION.
       CONFIGURATION       SECTION.
       SOURCE-COMPUTER.    IBM-S38.
       OBJECT-COMPUTER.    IBM-S38.
       INPUT-OUTPUT        SECTION.
       FILE-CONTROL.
           SELECT INV002-FILE   ASSIGN TO DATABASE-INV002
                  ORGANIZATION          IS INDEXED
                  ACCESS MODE           IS RANDOM
                  RECORD KEY            IS EXTERNALLY-DESCRIBED-KEY
                  FILE STATUS           IS INV002-STSCD.
           SELECT WIP001-FILE    ASSIGN TO DATABASE-WIP001
                  ORGANIZATION          IS INDEXED
                  ACCESS MODE           IS RANDOM
                  RECORD KEY            IS EXTERNALLY-DESCRIBED-KEY
                  FILE STATUS           IS WIP001-STSCD.
           SELECT WIP041-FILE    ASSIGN TO DATABASE-WIP041
                  ORGANIZATION          IS INDEXED
                  ACCESS MODE           IS RANDOM
                  RECORD KEY            IS EXTERNALLY-DESCRIBED-KEY
                  FILE STATUS           IS WIP041-STSCD.
           SELECT INV101-FILE    ASSIGN TO DATABASE-INV101
                  ORGANIZATION          IS INDEXED
                  ACCESS MODE           IS RANDOM
                  RECORD KEY            IS EXTERNALLY-DESCRIBED-KEY
                  FILE STATUS           IS INV101-STSCD.
           SELECT BOM003-FILE    ASSIGN TO DATABASE-BOM003
                  ORGANIZATION          IS INDEXED
                  ACCESS MODE           IS DYNAMIC
                  RECORD KEY            IS EXTERNALLY-DESCRIBED-KEY
                  FILE STATUS           IS BOM003-STSCD.
           SELECT BOM003LA-FILE  ASSIGN TO DATABASE-BOM003LA
                  ORGANIZATION          IS INDEXED
                  ACCESS MODE           IS DYNAMIC
                  RECORD KEY            IS EXTERNALLY-DESCRIBED-KEY
                  FILE STATUS           IS BOM003LA-STSCD.
           SELECT INV401-FILE    ASSIGN TO DATABASE-INV401
                  ORGANIZATION          IS INDEXED
                  ACCESS MODE           IS RANDOM
                  RECORD KEY            IS EXTERNALLY-DESCRIBED-KEY
                  FILE STATUS           IS INV401-STSCD.
           SELECT WIP004-FILE    ASSIGN TO DATABASE-WIP004
                  ORGANIZATION          IS INDEXED
                  ACCESS MODE           IS RANDOM
                  RECORD KEY            IS EXTERNALLY-DESCRIBED-KEY
                  FILE STATUS           IS WIP004-STSCD.
           SELECT WIP090-FILE    ASSIGN TO DATABASE-WIP090
                  ORGANIZATION          IS INDEXED
                  ACCESS MODE           IS RANDOM
                  RECORD KEY            IS EXTERNALLY-DESCRIBED-KEY
                  FILE STATUS           IS WIP004-STSCD.
           SELECT BOM001L03-FILE ASSIGN TO DATABASE-BOM001L03
                  ORGANIZATION          IS INDEXED
                  ACCESS MODE           IS DYNAMIC
                  RECORD KEY            IS EXTERNALLY-DESCRIBED-KEY
                  FILE STATUS           IS BOM001L03-STSCD.
           SELECT BOM001L03-FILE1 ASSIGN TO DATABASE-BOM001L03
                  ORGANIZATION          IS INDEXED
                  ACCESS MODE           IS DYNAMIC
                  RECORD KEY            IS EXTERNALLY-DESCRIBED-KEY
                  FILE STATUS           IS BOM001L03-STSCD1.
      ******************************************************
       DATA    DIVISION.
       FILE    SECTION.
       FD  INV002-FILE LABEL RECORDS ARE STANDARD.
       01  INV002-REC.
           COPY DDS-ALL-FORMATS OF PBINV-INV002.
       FD  WIP001-FILE LABEL RECORDS ARE STANDARD.
       01  WIP001-REC.
           COPY DDS-ALL-FORMATS OF PBWIP-WIP001.
       FD  WIP041-FILE LABEL RECORDS ARE STANDARD.
       01  WIP041-REC.
           COPY DDS-ALL-FORMATS OF PBWIP-WIP041.
       FD  WIP090-FILE LABEL RECORDS ARE STANDARD.
       01  WIP090-REC.
           COPY DDS-ALL-FORMATS OF PBWIP-WIP090.
       FD  INV101-FILE LABEL RECORDS ARE STANDARD.
       01  INV101-REC.
           COPY DDS-ALL-FORMATS OF PBINV-INV101.
       FD  WIP004-FILE LABEL RECORDS ARE STANDARD.
       01  WIP004-REC.
           COPY DDS-ALL-FORMATS OF PBWIP-WIP004.
       FD  INV401-FILE LABEL RECORDS ARE STANDARD.
       01  INV401-REC.
           COPY DDS-ALL-FORMATS OF PBINV-INV401.
       FD  BOM003-FILE LABEL RECORD ARE STANDARD.
       01  BOM003-REC.
           COPY DDS-ALL-FORMATS OF PBPDM-BOM003.
       FD  BOM003LA-FILE LABEL RECORD ARE STANDARD.
       01  BOM003LA-REC.
           COPY DDS-ALL-FORMATS OF PBPDM-BOM003LA.
       FD  BOM001L03-FILE LABEL RECORDS ARE STANDARD.
       01  BOM001L03-REC.
           COPY DDS-ALL-FORMATS OF PBPDM-BOM001L03.
       FD  BOM001L03-FILE1 LABEL RECORDS ARE STANDARD.
       01  BOM001L03-REC1.
           COPY DDS-ALL-FORMATS OF PBPDM-BOM001L03.
      ******************************************************
       WORKING-STORAGE     SECTION.
       77  I-IDX           PIC 9(3)        VALUE ZEROS.
       77  J-IDX           PIC 9(3)        VALUE ZEROS.
       77  K-IDX           PIC 9(3)        VALUE ZEROS.
       77  WERCD           PIC X(1)        VALUE SPACE.
       77  WK-ITNO         PIC X(15)       VALUE SPACE.
       77  WK-CHILD        PIC X(1)        VALUE SPACE.
       77  WK-ERRITNO      PIC X(15)       VALUE SPACE.
       77  WK-PQTYM        PIC S9(11)V9(4) VALUE ZEROS.
       77  WK-PQTYM1       PIC  9(11)V9(4) VALUE ZEROS.
       77  WK-PRQT         PIC S9(14)V9(4) VALUE ZEROS.
       77  WK-PRQT1        PIC S9(14)V9(4) VALUE ZEROS.
       77  SYS-DATE        PIC X(8)        VALUE ZEROS.
       77  WK-GRAD         PIC X(1)        VALUE SPACE.
       77  ERR-SW1         PIC X(1)  VALUE SPACE.
       77  WK-PDCD         PIC X(2)  VALUE SPACE.
       77  WC-SRNO         PIC 9(10)  VALUE ZEROS.
       01  WK-PTNO.
           03 WK-PTNO1 PIC X(1) OCCURS 15.
       01  SYSTEM-TIME.
           03 SYS-TIME     PIC 9(6)        VALUE ZEROS.
           03 FILLER       PIC X(2)        VALUE SPACE.
       01  WK-DATE.
           03 WK-YYMM      PIC X(6)   VALUE SPACE.
           03 WK-DD        PIC X(2)   VALUE SPACE.
       01  WK-SRNO.
           03 WK-SRNO1     PIC X(2)   VALUE SPACE.
           03 WK-SRNO2     PIC X(8)   VALUE SPACE.
       01  STSTUS-CODE.
           03 INV002-STSCD    PIC X(2).
           03 WIP001-STSCD    PIC X(2).
           03 WIP041-STSCD    PIC X(2).
           03 INV101-STSCD    PIC X(2).
           03 BOM003-STSCD    PIC X(2).
           03 BOM003LA-STSCD  PIC X(2).
           03 BOM001L03-STSCD    PIC X(2).
           03 BOM001L03-STSCD1   PIC X(2).
           03 INV401-STSCD     PIC X(2).
           03 WIP004-STSCD    PIC X(2).
       01  DATE-AREA.
           03 AC-FDATE.
              05 AC-FCC PIC 9(2).
              05 AC-FYY PIC 9(2).
              05 AC-FMM PIC 9(2).
              05 AC-FDD PIC 9(2).
           03 AC-TDATE.
              05 AC-TCC PIC 9(2).
              05 AC-TYY PIC 9(2).
              05 AC-TMM PIC 9(2).
              05 AC-TDD PIC 9(2).
       01  SAVE-AREA.
           03 SA-QTYA   PIC S9(11)V9(4) OCCURS 100 TIMES.
           03 SA-TWPITN  PIC X(15)      OCCURS 100 TIMES.
           03 SA-TWCITN  PIC X(15)      OCCURS 100 TIMES.
           03 SA-TWROUT  PIC X(4)       OCCURS 100 TIMES.
           03 SA-TWCHDT  PIC X(8)       OCCURS 100 TIMES.
       01  PA-PARA.
           03 PA-DIV  PIC X(1).
           03 PA-TRM  PIC X(6).
           03 PA-DB   PIC X(3).
       LINKAGE SECTION.
       01  PARA-AREA.
           03 AC-TOTSRNO.
              05 AC-SLIPTYPE PIC X(2).
              05 AC-SRNO     PIC X(8).
              05 AC-SRNO1    PIC X(2).
              05 AC-SRNO2    PIC X(2).
       PROCEDURE  DIVISION USING PARA-AREA.
       OPEN-RTN.
           IF AC-SLIPTYPE =
              "RS" OR "RM" OR "SM" OR "IS" OR "IE"
              NEXT SENTENCE
           ELSE
              GO TO END-JOB-RTN.
           OPEN INPUT INV002-FILE BOM001L03-FILE BOM001L03-FILE1
                      INV401-FILE BOM003LA-FILE BOM003-FILE INV101-FILE
                I-O   WIP001-FILE WIP004-FILE WIP090-FILE
                      WIP041-FILE.
           MOVE ZEROS TO I-IDX, J-IDX, K-IDX.
           ACCEPT SYSTEM-TIME FROM TIME.
           MOVE   SPACE       TO   SYS-DATE.
           CALL   "DATEACPT" USING SYS-DATE.
           CANCEL "DATEACPT".
           MOVE "01"        TO COMLTD   OF INV401-REC.
           MOVE AC-SLIPTYPE TO SLIPTYPE OF INV401-REC.
           MOVE AC-SRNO     TO SRNO     OF INV401-REC.
           MOVE AC-SRNO1    TO SRNO1    OF INV401-REC.
           MOVE AC-SRNO2    TO SRNO2    OF INV401-REC.
           READ INV401-FILE INVALID KEY
                GO TO END-JOB-RTN.
           IF DIV OF INV401-REC = "Y"
              GO TO END-JOB-RTN.
           IF SLIPTYPE OF INV401-REC = "IS" OR "RS"
              IF TQTY2 OF INV401-REC = ZEROS AND
                 TQTY3 OF INV401-REC = ZEROS AND
                 TQTY4 OF INV401-REC = ZEROS
                 GO TO END-JOB-RTN.
           IF SLIPTYPE OF INV401-REC = "RS"
              IF XUSE OF INV401-REC = "04"
                 IF RTNGUB OF INV401-REC = "02"
                    GO TO END-JOB-RTN
                 ELSE
                    NEXT SENTENCE
              ELSE
                 IF XUSE OF INV401-REC = "01" OR "03" OR "  "
                    IF RTNGUB OF INV401-REC = "02"
                       NEXT SENTENCE
                    ELSE
                       GO TO END-JOB-RTN
                 ELSE
                    GO TO END-JOB-RTN.
           MOVE TQTY4 OF INV401-REC TO WK-PQTYM.
           IF SLIPTYPE OF INV401-REC = "RS"
              IF XUSE OF INV401-REC = "04"
                 COMPUTE WK-PQTYM = (TQTY2 OF INV401-REC +
                                    TQTY3 OF INV401-REC +
                                    TQTY4 OF INV401-REC) * -1
              ELSE
                 COMPUTE WK-PQTYM = (TQTY2 OF INV401-REC +
                                    TQTY3 OF INV401-REC +
                                    TQTY4 OF INV401-REC)
           ELSE
              IF SLIPTYPE OF INV401-REC = "SM"
                 MULTIPLY TQTY4 OF INV401-REC BY -1 GIVING WK-PQTYM.
           MOVE WK-PQTYM TO WK-PQTYM1.
           MOVE COMLTD OF INV401-REC  TO COMLTD OF INV002-REC,
                                         COMLTD OF INV101-REC.
           MOVE XPLANT OF INV401-REC  TO XPLANT OF INV101-REC.
           MOVE DIV    OF INV401-REC  TO DIV    OF INV101-REC.
           MOVE ITNO   OF INV401-REC  TO ITNO   OF INV002-REC,
                                         ITNO   OF INV101-REC.
           READ INV002-FILE INVALID KEY
                MOVE "1"                  TO WERCD
                MOVE ITNO   OF INV002-REC TO WK-ERRITNO
                PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                GO TO END-JOB-RTN.
           READ INV101-FILE INVALID KEY
                MOVE "2" TO WERCD
                MOVE ITNO   OF INV101-REC TO WK-ERRITNO
                PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                GO TO END-JOB-RTN.
           MOVE PDCD OF INV101-REC TO WK-PDCD.
           IF CONVQTY OF INV101-REC = ZEROS
              NEXT SENTENCE
           ELSE
            MULTIPLY CONVQTY OF INV101-REC BY WK-PQTYM GIVING WK-PQTYM.
           IF SRCE OF INV101-REC = "03" OR "  "
              NEXT SENTENCE
           ELSE
              GO TO END-JOB-RTN.
           IF CLS OF INV101-REC = "10" OR "30" OR "40" OR "50"
              NEXT SENTENCE
           ELSE
              GO TO END-JOB-RTN.
           IF SLIPTYPE OF INV401-REC = "RS" OR "IS"
              IF SRCE OF INV101-REC = "03"
                 NEXT SENTENCE
              ELSE
                 GO TO END-JOB-RTN.
           MOVE SPACE TO ERR-SW1.
           MOVE ITNO OF INV101-REC TO WK-PTNO.
           PERFORM ITEM-CHECK-RTN THRU ITEM-CHECK-EXIT
                   VARYING I-IDX FROM 1 BY 1 UNTIL I-IDX > 14.
           IF ERR-SW1 = SPACE
              NEXT SENTENCE
           ELSE
              GO TO END-JOB-RTN.
           MOVE TDTE4 OF INV401-REC TO WK-DATE.
           MOVE ZEROS TO J-IDX.
           MOVE "N" TO WK-CHILD.
           MOVE COMLTD OF INV101-REC TO PCMCD OF BOM001L03-REC.
           MOVE XPLANT OF INV101-REC TO PLANT OF BOM001L03-REC.
           MOVE DIV    OF INV101-REC TO PDVSN OF BOM001L03-REC.
           MOVE ITNO   OF INV101-REC TO PCITN OF BOM001L03-REC.
           PERFORM CHILD-FOUND-RTN THRU CHILD-FOUND-EXIT.
           IF WK-CHILD = "N"
              MOVE "3" TO WERCD
              MOVE ITNO   OF INV101-REC TO WK-ERRITNO
              PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
              GO TO END-JOB-RTN.
           MOVE COMLTD OF INV101-REC TO PCMCD OF BOM001L03-REC.
           MOVE XPLANT OF INV101-REC TO PLANT OF BOM001L03-REC.
           MOVE DIV    OF INV101-REC TO PDVSN OF BOM001L03-REC.
           MOVE ITNO   OF INV101-REC TO PPITN OF BOM001L03-REC WK-ITNO.
           MOVE SPACE                TO PCITN OF BOM001L03-REC
                                        PROUT OF BOM001L03-REC
                                        PCHDT OF BOM001L03-REC.
           START BOM001L03-FILE KEY IS NOT < EXTERNALLY-DESCRIBED-KEY
                 INVALID KEY
                 MOVE "4" TO WERCD
                 MOVE ITNO   OF INV101-REC TO WK-ERRITNO
                 PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                 GO TO END-JOB-RTN.
           READ BOM001L03-FILE NEXT RECORD AT END
                MOVE "5" TO WERCD
                MOVE ITNO   OF INV101-REC TO WK-ERRITNO
                PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                GO TO END-JOB-RTN.
           IF COMLTD OF INV101-REC = PCMCD OF BOM001L03-REC AND
              XPLANT OF INV101-REC = PLANT OF BOM001L03-REC AND
              DIV    OF INV401-REC = PDVSN OF BOM001L03-REC AND
              WK-ITNO              = PPITN OF BOM001L03-REC
              NEXT SENTENCE
           ELSE
              MOVE "6" TO WERCD
              MOVE ITNO   OF INV101-REC TO WK-ERRITNO
              PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
              GO TO END-JOB-RTN.
       EXPRO-RTN.
           IF PEDTM OF BOM001L03-REC > WK-DATE AND
              PEDTM OF BOM001L03-REC NOT = SPACE
              GO TO NEXT-COMPONENT-RTN.
           IF PEDTE OF BOM001L03-REC < WK-DATE AND
              PEDTE OF BOM001L03-REC NOT = SPACE
              GO TO NEXT-COMPONENT-RTN.
           MOVE COMLTD OF INV401-REC    TO COMLTD OF INV002-REC,
                                           COMLTD OF INV101-REC.
           MOVE XPLANT OF INV401-REC    TO XPLANT OF INV101-REC.
           MOVE DIV    OF INV401-REC    TO DIV    OF INV101-REC.
           MOVE PCITN  OF BOM001L03-REC TO ITNO   OF INV002-REC,
                                           ITNO   OF INV101-REC.
           READ INV002-FILE INVALID KEY
                MOVE "7" TO WERCD
                MOVE ITNO   OF INV002-REC TO WK-ERRITNO
                PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                GO TO END-JOB-RTN.
           READ INV101-FILE INVALID KEY
                MOVE ITNO   OF INV101-REC TO WK-ERRITNO
                PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                GO TO END-JOB-RTN.
           MOVE SPACE TO WK-GRAD.
           PERFORM GRAD2-PART-RTN THRU GRAD2-PART-EXIT
           IF WK-GRAD = SPACE
              PERFORM GRAD1-PART-RTN THRU GRAD1-PART-EXIT.
           IF WK-GRAD = SPACE
              MOVE SPACE TO OFITN OF BOM003-REC.
           IF J-IDX = ZEROS
              MULTIPLY WK-PQTYM     BY PQTYM OF BOM001L03-REC
                                               GIVING WK-PRQT
           ELSE
              MULTIPLY SA-QTYA(J-IDX) BY PQTYM OF BOM001L03-REC GIVING
                                         WK-PRQT.
           MOVE ZEROS TO WK-PRQT1.
           IF WK-GRAD = SPACE OR "1"
              IF SRCE OF INV101-REC = "03" OR "  "
                 MOVE "N" TO WK-CHILD
                 PERFORM CHILD-FOUND-RTN THRU CHILD-FOUND-EXIT
                 IF WK-CHILD = "Y"
                    GO TO CHILD-START-MOVE-RTN
                 ELSE
                    PERFORM UPDATE-RTN THRU UPDATE-EXIT
                    IF WERCD = SPACE
                       NEXT SENTENCE
                    ELSE
                       GO TO END-JOB-RTN
              ELSE
                 PERFORM UPDATE-RTN THRU UPDATE-EXIT
                 IF WERCD = SPACE
                    NEXT SENTENCE
                 ELSE
                    GO TO END-JOB-RTN.
       ALT-RTN.
           IF WK-PRQT1 = ZEROS
              GO TO NEXT-COMPONENT-RTN.
           IF OFITN OF BOM003-REC = SPACE
              MOVE "8" TO WERCD
              MOVE PCITN OF BOM001L03-REC TO WK-ERRITNO
              PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
              GO TO END-JOB-RTN.
           MOVE WK-PRQT1 TO WK-PRQT.
           MOVE ZEROS    TO WK-PRQT1.
           MOVE COMLTD OF INV401-REC TO COMLTD OF INV002-REC
                                        COMLTD OF INV101-REC.
           MOVE XPLANT OF INV401-REC TO XPLANT OF INV101-REC.
           MOVE DIV    OF INV401-REC TO DIV    OF INV101-REC.
           MOVE OFITN  OF BOM003-REC TO ITNO   OF INV002-REC
                                        ITNO   OF INV101-REC.
           READ INV002-FILE INVALID KEY
                MOVE "9" TO WERCD
                MOVE PCITN OF BOM001L03-REC TO WK-ERRITNO
                PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                GO TO END-JOB-RTN.
           READ INV101-FILE INVALID KEY
                MOVE "A" TO WERCD
                MOVE PCITN OF BOM001L03-REC TO WK-ERRITNO
                PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                GO TO END-JOB-RTN.
           MOVE "N" TO WK-CHILD.
           MOVE COMLTD OF INV101-REC TO PCMCD OF BOM001L03-REC1.
           MOVE XPLANT OF INV101-REC TO PLANT OF BOM001L03-REC1.
           MOVE DIV    OF INV101-REC TO PDVSN OF BOM001L03-REC1.
           MOVE ITNO   OF INV101-REC TO PPITN OF BOM001L03-REC1.
           MOVE SPACE                TO PCITN OF BOM001L03-REC1
                                        PROUT OF BOM001L03-REC1
                                        PCHDT OF BOM001L03-REC1.
           START BOM001L03-FILE1 KEY IS NOT < EXTERNALLY-DESCRIBED-KEY
                 INVALID KEY GO TO ALT-CHILD-EXIT.
       ALT-CHILD-RTN.
           READ BOM001L03-FILE1 NEXT RECORD AT END
                GO TO ALT-CHILD-EXIT.
           IF COMLTD OF INV101-REC = PCMCD OF BOM001L03-REC1 AND
              XPLANT OF INV101-REC = PLANT OF BOM001L03-REC1 AND
              DIV    OF INV101-REC = PDVSN OF BOM001L03-REC1 AND
              ITNO   OF INV101-REC = PPITN OF BOM001L03-REC1
              NEXT SENTENCE
           ELSE
              GO TO ALT-CHILD-EXIT.
           IF (PEDTM OF BOM001L03-REC1 > WK-DATE) AND
              (PEDTM OF BOM001L03-REC1 NOT = SPACE)
              GO TO ALT-CHILD-RTN.
           IF (PEDTE OF BOM001L03-REC1 < WK-DATE) AND
              (PEDTE OF BOM001L03-REC1 NOT = SPACE)
              GO TO ALT-CHILD-RTN.
           MOVE "Y" TO WK-CHILD.
       ALT-CHILD-EXIT.
           IF WK-CHILD = "N" OR
              (SRCE OF INV101-REC = "04" OR "02" OR "05" OR "06")
              PERFORM GRAD1-READ-RTN THRU GRAD1-PART-EXIT
              PERFORM UPDATE-RTN THRU UPDATE-EXIT
              IF WERCD = SPACE
                 GO TO ALT-RTN
              ELSE
                 GO TO END-JOB-RTN.
       CHILD-START-MOVE-RTN.
           ADD  1                     TO J-IDX.
           MOVE WK-PRQT                 TO SA-QTYA(J-IDX).
           MOVE COMLTD OF INV101-REC    TO PCMCD OF BOM001L03-REC.
           MOVE XPLANT OF INV101-REC    TO PLANT OF BOM001L03-REC.
           MOVE DIV    OF INV101-REC    TO PDVSN OF BOM001L03-REC.
           MOVE PPITN  OF BOM001L03-REC TO SA-TWPITN(J-IDX).
           MOVE PCITN  OF BOM001L03-REC TO SA-TWCITN(J-IDX).
           MOVE PROUT  OF BOM001L03-REC TO SA-TWROUT(J-IDX).
           MOVE PCHDT  OF BOM001L03-REC TO SA-TWCHDT(J-IDX).
           MOVE ITNO   OF INV101-REC    TO PPITN OF BOM001L03-REC
                                           WK-ITNO.
           MOVE SPACE                   TO PCITN OF BOM001L03-REC
                                           PROUT OF BOM001L03-REC
                                           PCHDT OF BOM001L03-REC.
       CHILD-START-RTN.
           START BOM001L03-FILE KEY IS > EXTERNALLY-DESCRIBED-KEY
                 INVALID KEY
                 GO TO SAVE-CHK-RTN.
       NEXT-COMPONENT-RTN.
           READ BOM001L03-FILE NEXT RECORD AT END GO TO SAVE-CHK-RTN.
           IF COMLTD OF INV401-REC = PCMCD OF BOM001L03-REC AND
              XPLANT OF INV401-REC = PLANT OF BOM001L03-REC AND
              DIV    OF INV401-REC = PDVSN OF BOM001L03-REC AND
              WK-ITNO              = PPITN OF BOM001L03-REC
              GO TO EXPRO-RTN.
       SAVE-CHK-RTN.
           IF J-IDX = ZEROS
              GO TO END-JOB-RTN.
           MOVE COMLTD OF INV401-REC TO PCMCD OF BOM001L03-REC.
           MOVE XPLANT OF INV401-REC TO PLANT OF BOM001L03-REC.
           MOVE DIV    OF INV401-REC TO PDVSN OF BOM001L03-REC.
           MOVE SA-TWPITN(J-IDX) TO PPITN OF BOM001L03-REC WK-ITNO.
           MOVE SA-TWCITN(J-IDX) TO PCITN OF BOM001L03-REC.
           MOVE SA-TWROUT(J-IDX) TO PROUT OF BOM001L03-REC.
           MOVE SA-TWCHDT(J-IDX) TO PCHDT OF BOM001L03-REC.
           SUBTRACT 1 FROM J-IDX GIVING J-IDX.
           GO TO CHILD-START-RTN.
       GRAD2-PART-RTN.
           MOVE PCMCD OF BOM001L03-REC TO OCMCD  OF BOM003LA-REC.
           MOVE PLANT OF BOM001L03-REC TO OPLANT OF BOM003LA-REC.
           MOVE PDVSN OF BOM001L03-REC TO ODVSN  OF BOM003LA-REC.
           MOVE PCITN OF BOM001L03-REC TO OFITN  OF BOM003LA-REC.
           MOVE SPACE                  TO OPITN  OF BOM003LA-REC
                                          OCHDT  OF BOM003LA-REC.
           START BOM003LA-FILE KEY IS NOT < EXTERNALLY-DESCRIBED-KEY
                 INVALID KEY GO TO GRAD2-PART-EXIT.
       GRAD2-READ-RTN.
           READ BOM003LA-FILE NEXT RECORD AT END
                GO TO GRAD2-PART-EXIT.
           IF PCMCD OF BOM001L03-REC = OCMCD  OF BOM003LA-REC AND
              PLANT OF BOM001L03-REC = OPLANT OF BOM003LA-REC AND
              PDVSN OF BOM001L03-REC = ODVSN  OF BOM003LA-REC AND
              PCITN OF BOM001L03-REC = OFITN  OF BOM003LA-REC
              NEXT SENTENCE
           ELSE
              GO TO GRAD2-PART-EXIT.
           IF OEDTM OF BOM003LA-REC > WK-DATE AND
              OEDTM OF BOM003LA-REC NOT = SPACE
              GO TO GRAD2-READ-RTN.
           IF OEDTE OF BOM003LA-REC < WK-DATE AND
              OEDTE OF BOM003LA-REC NOT = SPACE
              GO TO GRAD2-READ-RTN.
           MOVE "2" TO WK-GRAD.
       GRAD2-PART-EXIT.
           EXIT.
       GRAD1-PART-RTN.
           MOVE PCMCD OF BOM001L03-REC TO OCMCD  OF BOM003-REC.
           MOVE PLANT OF BOM001L03-REC TO OPLANT OF BOM003-REC.
           MOVE PDVSN OF BOM001L03-REC TO ODVSN  OF BOM003-REC.
           MOVE PCITN OF BOM001L03-REC TO OPITN  OF BOM003-REC.
           MOVE SPACE                  TO OFITN  OF BOM003-REC
                                          OCHDT  OF BOM003-REC.
           START BOM003-FILE KEY IS NOT < EXTERNALLY-DESCRIBED-KEY
                 INVALID KEY MOVE SPACE TO OFITN OF BOM003-REC
                             GO TO GRAD1-PART-EXIT.
       GRAD1-READ-RTN.
           READ BOM003-FILE NEXT RECORD AT END
                MOVE SPACE TO OFITN OF BOM003-REC
                GO TO GRAD1-PART-EXIT.
           IF PCMCD OF BOM001L03-REC = OCMCD  OF BOM003-REC AND
              PLANT OF BOM001L03-REC = OPLANT OF BOM003-REC AND
              PDVSN OF BOM001L03-REC = ODVSN  OF BOM003-REC AND
              PCITN OF BOM001L03-REC = OPITN  OF BOM003-REC
              NEXT SENTENCE
           ELSE
              MOVE SPACE TO OFITN OF BOM003-REC
              GO TO GRAD1-PART-EXIT.
           IF OEDTM OF BOM003-REC > WK-DATE AND
              OEDTM OF BOM003-REC NOT = SPACE
              GO TO GRAD1-READ-RTN.
           IF OEDTE OF BOM003-REC < WK-DATE AND
              OEDTE OF BOM003-REC NOT = SPACE
              GO TO GRAD1-READ-RTN.
           MOVE "1" TO WK-GRAD.
       GRAD1-PART-EXIT.
           EXIT.
       CHILD-FOUND-RTN.
           MOVE PCMCD OF BOM001L03-REC TO PCMCD OF BOM001L03-REC1.
           MOVE PLANT OF BOM001L03-REC TO PLANT OF BOM001L03-REC1.
           MOVE PDVSN OF BOM001L03-REC TO PDVSN OF BOM001L03-REC1.
           MOVE PCITN OF BOM001L03-REC TO PPITN OF BOM001L03-REC1.
           MOVE SPACE                  TO PCITN OF BOM001L03-REC1
                                          PROUT OF BOM001L03-REC1
                                          PCHDT OF BOM001L03-REC1.
           START BOM001L03-FILE1 KEY IS NOT < EXTERNALLY-DESCRIBED-KEY
                 INVALID KEY GO TO CHILD-FOUND-EXIT.
       CHILD-FOUND-RTN1.
           READ BOM001L03-FILE1 NEXT RECORD AT END
                GO TO CHILD-FOUND-EXIT.
           IF PCMCD OF BOM001L03-REC = PCMCD OF BOM001L03-REC1 AND
              PLANT OF BOM001L03-REC = PLANT OF BOM001L03-REC1 AND
              PDVSN OF BOM001L03-REC = PDVSN OF BOM001L03-REC1 AND
              PCITN OF BOM001L03-REC = PPITN OF BOM001L03-REC1
              NEXT SENTENCE
           ELSE
              GO TO CHILD-FOUND-EXIT.
           IF (PEDTM OF BOM001L03-REC1 > WK-DATE) AND
              (PEDTM OF BOM001L03-REC1 NOT = SPACE)
              GO TO CHILD-FOUND-RTN1.
           IF (PEDTE OF BOM001L03-REC1 < WK-DATE) AND
              (PEDTE OF BOM001L03-REC1 NOT = SPACE)
              GO TO CHILD-FOUND-RTN1.
           MOVE "Y" TO WK-CHILD.
       CHILD-FOUND-EXIT.
           EXIT.
       UPDATE-RTN.
           ACCEPT  SYSTEM-TIME FROM TIME.
           IF WK-PRQT = ZEROS
              GO TO UPDATE-EXIT.
           IF PWKCT OF BOM001L03-REC = "8888"
              GO TO UPDATE-EXIT.
           MOVE COMLTD OF INV101-REC TO WACMCD  OF WIP001-REC.
           MOVE XPLANT OF INV101-REC TO WAPLANT OF WIP001-REC.
           MOVE DIV    OF INV101-REC TO WADVSN  OF WIP001-REC.
           MOVE "9999"               TO WAORCT  OF WIP001-REC.
           MOVE ITNO   OF INV101-REC TO WAITNO  OF WIP001-REC.
           READ WIP001-FILE INVALID KEY
                MOVE "1"   TO WAIOCD  OF WIP001-REC
                MOVE ZEROS TO WAAVRG1 OF WIP001-REC
                              WAAVRG2 OF WIP001-REC
                              WABGQT  OF WIP001-REC
                              WABGAT1 OF WIP001-REC
                              WABGAT2 OF WIP001-REC
                              WAINQT  OF WIP001-REC
                              WAINAT1 OF WIP001-REC
                              WAINAT2 OF WIP001-REC
                              WAINAT3 OF WIP001-REC
                              WAINAT4 OF WIP001-REC
                              WAUSQT1 OF WIP001-REC
                              WAUSAT1 OF WIP001-REC
                              WAUSQT2 OF WIP001-REC
                              WAUSAT2 OF WIP001-REC
                              WAUSQT3 OF WIP001-REC
                              WAUSAT3 OF WIP001-REC
                              WAUSQT4 OF WIP001-REC
                              WAUSAT4 OF WIP001-REC
                              WAUSQT5 OF WIP001-REC
                              WAUSAT5 OF WIP001-REC
                              WAUSQT6 OF WIP001-REC
                              WAUSAT6 OF WIP001-REC
                              WAUSQT7 OF WIP001-REC
                              WAUSAT7 OF WIP001-REC
                              WAUSQT8 OF WIP001-REC
                              WAUSAT8 OF WIP001-REC
                              WAUSAT9 OF WIP001-REC
                              WAOHQT  OF WIP001-REC
                              WAOHAT1 OF WIP001-REC
                              WAOHAT2 OF WIP001-REC
                              WASCRP  OF WIP001-REC
                              WARETN  OF WIP001-REC
                MOVE SPACE TO WAPLAN OF WIP001-REC
                              WAIPADDR  OF WIP001-REC
                              WAMACADDR OF WIP001-REC
                MOVE SYS-DATE TO WAINPTDT OF WIP001-REC
                                 WAUPDTDT OF WIP001-REC.
           IF WK-GRAD = "1"
              IF OFITN OF BOM003-REC NOT = SPACE
                 IF WAOHQT < WK-PRQT
                    IF WAOHQT > ZEROS
                       SUBTRACT WAOHQT FROM WK-PRQT GIVING WK-PRQT1
                       MOVE     WAOHQT TO   WK-PRQT
                    ELSE
                       MOVE WK-PRQT TO WK-PRQT1
                       GO TO UPDATE-EXIT.
           IF SLIPTYPE OF INV401-REC = "RM" OR "SM"
              MOVE SPACE       TO   WDPRDPT OF WIP004-REC
              MOVE "01"        TO   WDUSGE  OF WIP004-REC
              ADD      WK-PRQT TO   WAUSQT1
              SUBTRACT WK-PRQT FROM WAOHQT.
           IF SLIPTYPE OF INV401-REC = "IS" OR "RS"
              IF XUSE OF INV401-REC = "04"
                 MOVE "02"                TO   WDUSGE  OF WIP004-REC
                 MOVE VSRNO OF INV401-REC TO   WDPRDPT OF WIP004-REC
                 ADD      WK-PRQT         TO   WAUSQT2
                 SUBTRACT WK-PRQT         FROM WAOHQT
              ELSE
                 IF XUSE OF INV401-REC = "07"
                    MOVE VSRNO OF INV401-REC TO   WDPRDPT OF WIP004-REC
                    MOVE "03"                TO   WDUSGE  OF WIP004-REC
                    ADD      WK-PRQT         TO   WAUSQT3
                    SUBTRACT WK-PRQT         FROM WAOHQT
                 ELSE
                    MOVE SPACE       TO   WDPRDPT OF WIP004-REC
                    MOVE "07"        TO   WDUSGE  OF WIP004-REC
                    ADD      WK-PRQT TO   WAUSQT7
                    SUBTRACT WK-PRQT FROM WAOHQT.
           MOVE   PDCD OF INV101-REC TO WDPDCD.
           MOVE   SYS-DATE TO WAUPDTDT OF WIP001-REC.
           IF WIP001-STSCD = "00"
              REWRITE WIP001-REC INVALID KEY
                      MOVE "D" TO WERCD
                      MOVE WAITNO TO WK-ERRITNO
                      PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                      GO TO UPDATE-EXIT.
           IF WIP001-STSCD NOT = "00"
              WRITE WIP001-REC INVALID KEY
                      MOVE "E" TO WERCD
                      MOVE WAITNO TO WK-ERRITNO
                      PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                      GO TO UPDATE-EXIT.
           MOVE COMLTD   OF INV401-REC TO WDCMCD  OF WIP004-REC.
           MOVE "WC"                   TO WDSLTY  OF WIP004-REC.
           MOVE XPLANT   OF INV401-REC TO WDPLANT OF WIP004-REC.
           MOVE DIV      OF INV401-REC TO WDDVSN  OF WIP004-REC.
           MOVE "1"                    TO WDIOCD  OF WIP004-REC.
           MOVE ITNO     OF INV101-REC TO WDITNO  OF WIP004-REC.
           MOVE RVNO     OF INV002-REC TO WDRVNO  OF WIP004-REC.
           MOVE ITNM     OF INV002-REC TO WDDESC  OF WIP004-REC.
           MOVE SPEC     OF INV002-REC TO WDSPEC  OF WIP004-REC.
           MOVE XUNIT    OF INV101-REC TO WDUNIT  OF WIP004-REC.
           MOVE CLS      OF INV101-REC TO WDITCL  OF WIP004-REC.
           MOVE SRCE     OF INV101-REC TO WDSRCE  OF WIP004-REC.
           MOVE PDCD     OF INV101-REC TO WDPDCD  OF WIP004-REC.
           MOVE SLNO     OF INV401-REC TO WDSLNO  OF WIP004-REC.
           MOVE SLIPTYPE OF INV401-REC TO WDPRSRTY  OF WIP004-REC.
           MOVE SRNO     OF INV401-REC TO WDPRSRNO  OF WIP004-REC.
           MOVE SRNO1    OF INV401-REC TO WDPRSRNO1 OF WIP004-REC.
           MOVE SRNO2    OF INV401-REC TO WDPRSRNO2 OF WIP004-REC.
           MOVE ITNO     OF INV401-REC TO WDPRNO    OF WIP004-REC.
           MOVE "9999"                 TO WDCHDPT   OF WIP004-REC.
           MOVE  TDTE4  OF INV401-REC  TO WDDATE    OF WIP004-REC.
           MOVE  WK-PQTYM1             TO WDPRQT    OF WIP004-REC.
       TRANS-WRITE-RTN.
           IF SLIPTYPE OF INV401-REC = "SM" OR
              (SLIPTYPE OF INV401-REC = "RS" AND
               XUSE OF INV401-REC = "04")
              IF WK-PRQT < -99999999999
                 MOVE -99999999999 TO WDCHQT OF WIP004-REC
              ELSE
                 MOVE WK-PRQT TO WDCHQT OF WIP004-REC
           ELSE
              IF WK-PRQT > 99999999999
                 MOVE 99999999999 TO WDCHQT OF WIP004-REC
              ELSE
                 MOVE WK-PRQT TO WDCHQT OF WIP004-REC.
           SUBTRACT WDCHQT OF WIP004-REC FROM WK-PRQT.
           MOVE COMLTD OF INV401-REC TO WZCMCD.
           MOVE " "                  TO WZPLANT.
           MOVE "SERIAL"             TO WZCTTP.
           READ WIP090-FILE INVALID KEY
                MOVE WAITNO TO WK-ERRITNO
                MOVE "F" TO WERCD
                PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                GO TO UPDATE-EXIT.
           ADD 1 TO WZSERNO.
           REWRITE WIP090-REC INVALID
                   MOVE WAITNO TO WK-ERRITNO
                   MOVE "G" TO WERCD
                   PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                   GO TO UPDATE-EXIT.
           MOVE WZSERNO     TO   WC-SRNO.
           MOVE WC-SRNO     TO   WDSRNO   OF WIP004-REC.
           MOVE SYS-DATE    TO   WDINPTDT OF WIP004-REC,
                                 WDUPDTDT OF WIP004-REC.
           WRITE WIP004-REC INVALID KEY
                 MOVE "H" TO WERCD
                 MOVE WDITNO OF WIP004-REC TO WK-ERRITNO
                 PERFORM ERROR-WRITE-RTN THRU ERROR-WRITE-EXIT
                 GO TO UPDATE-EXIT.
           IF WK-PRQT = ZEROS
              NEXT SENTENCE
           ELSE
              GO TO TRANS-WRITE-RTN.
       UPDATE-EXIT.
           EXIT.
       ERROR-WRITE-RTN.
           MOVE COMLTD   OF INV401-REC TO COMLTD OF WIP041-REC.
           MOVE SLIPTYPE OF INV401-REC TO SLIPTYPE OF WIP041-REC.
           MOVE SRNO     OF INV401-REC TO SRNO     OF WIP041-REC.
           MOVE SRNO1    OF INV401-REC TO SRNO1    OF WIP041-REC.
           MOVE SRNO2    OF INV401-REC TO SRNO2    OF WIP041-REC.
           MOVE XPLANT   OF INV401-REC TO XPLANT   OF WIP041-REC.
           MOVE DIV      OF INV401-REC TO DIV      OF WIP041-REC.
           MOVE SLNO     OF INV401-REC TO SLNO     OF WIP041-REC.
           MOVE ITNO     OF INV401-REC TO ITNO     OF WIP041-REC.
           MOVE CLS      OF INV401-REC TO CLS      OF WIP041-REC.
           MOVE SRCE     OF INV401-REC TO SRCE     OF WIP041-REC.
           MOVE VSRNO    OF INV401-REC TO VSRNO    OF WIP041-REC.
           MOVE DEPT     OF INV401-REC TO DEPT     OF WIP041-REC.
           MOVE RTNGUB   OF INV401-REC TO RTNGUB   OF WIP041-REC.
           MOVE XUSE     OF INV401-REC TO XUSE     OF WIP041-REC.
           MOVE RSVSRNO  OF INV401-REC TO RSVSRNO  OF WIP041-REC.
           MOVE EXFR     OF INV401-REC TO EXFR     OF WIP041-REC.
           MOVE EXTO     OF INV401-REC TO EXTO     OF WIP041-REC.
           MOVE RQDIV    OF INV401-REC TO RQDIV    OF WIP041-REC.
           MOVE TDTE4    OF INV401-REC TO TDTE4    OF WIP041-REC.
           MOVE TQTY1    OF INV401-REC TO TQTY1    OF WIP041-REC.
           MOVE TQTY2    OF INV401-REC TO TQTY2    OF WIP041-REC.
           MOVE TQTY3    OF INV401-REC TO TQTY3    OF WIP041-REC.
           MOVE TQTY4    OF INV401-REC TO TQTY4    OF WIP041-REC.
           MOVE RTQTY    OF INV401-REC TO RTQTY    OF WIP041-REC.
           MOVE WERCD                  TO ERRCD    OF WIP041-REC.
           MOVE WK-ERRITNO             TO ERRITNO  OF WIP041-REC.
           WRITE WIP041-REC.
       ERROR-WRITE-EXIT.
           EXIT.
       ITEM-CHECK-RTN.
           ADD 1 I-IDX GIVING K-IDX.
           IF (WK-PTNO1(I-IDX) = "R" AND WK-PTNO1(K-IDX) = "K") OR
              (WK-PTNO1(I-IDX) = "R" AND WK-PTNO1(K-IDX) = "P")
              MOVE "1" TO ERR-SW1.
       ITEM-CHECK-EXIT.
           EXIT.
       END-JOB-RTN.
           CLOSE WIP001-FILE BOM001L03-FILE INV002-FILE INV101-FILE
                 INV401-FILE WIP004-FILE WIP041-FILE  WIP090-FILE
                 BOM001L03-FILE1
                 BOM003-FILE BOM003LA-FILE.
           GOBACK.

