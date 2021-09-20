*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 19.09.2021 at 18:49:44
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZTTRAIN000100...................................*
DATA:  BEGIN OF STATUS_ZTTRAIN000100                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTTRAIN000100                 .
CONTROLS: TCTRL_ZTTRAIN000100
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZTTRAIN000200...................................*
DATA:  BEGIN OF STATUS_ZTTRAIN000200                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTTRAIN000200                 .
CONTROLS: TCTRL_ZTTRAIN000200
            TYPE TABLEVIEW USING SCREEN '0002'.
*.........table declarations:.................................*
TABLES: *ZTTRAIN000100                 .
TABLES: *ZTTRAIN000200                 .
TABLES: ZTTRAIN000100                  .
TABLES: ZTTRAIN000200                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
