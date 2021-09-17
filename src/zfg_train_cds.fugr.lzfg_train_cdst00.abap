*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 15.09.2021 at 22:11:43
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZTTRAIN000100...................................*
DATA:  BEGIN OF STATUS_ZTTRAIN000100                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTTRAIN000100                 .
CONTROLS: TCTRL_ZTTRAIN000100
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZTTRAIN000100                 .
TABLES: ZTTRAIN000100                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
