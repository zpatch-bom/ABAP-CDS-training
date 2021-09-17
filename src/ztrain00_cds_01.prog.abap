*&---------------------------------------------------------------------*
*& Report ztrain00_cds_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztrain00_cds_01.

*&---------------------------------------------------------------------*
TABLES t001.

DATA gt_basic TYPE STANDARD TABLE OF zi_train00_basic_01 WITH EMPTY KEY.

*&---------------------------------------------------------------------*
SELECT-OPTIONS  s_bukrs FOR t001-bukrs NO INTERVALS.
PARAMETERS      p_up_to TYPE i DEFAULT 3 OBLIGATORY.

*&---------------------------------------------------------------------*
START-OF-SELECTION.

  SELECT FROM zi_train00_basic_01 AS a
    FIELDS
      a~*
    WHERE a~bukrs IN @s_bukrs
    INTO TABLE @gt_basic
    UP TO @p_up_to ROWS.

  cl_demo_output=>display( gt_basic ).
