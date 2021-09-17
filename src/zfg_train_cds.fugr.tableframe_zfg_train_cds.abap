*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZFG_TRAIN_CDS
*   generation date: 15.09.2021 at 22:11:42
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZFG_TRAIN_CDS      .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
