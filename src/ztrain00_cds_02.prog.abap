*&---------------------------------------------------------------------*
*& Report ZTRAIN00_CDS_02
*&---------------------------------------------------------------------*
*& Training - ALV IDA
*&---------------------------------------------------------------------*
REPORT ztrain00_cds_02.

TABLES: matdoc.

PARAMETERS:
  p_bukrs TYPE bukrs DEFAULT '0001'.

SELECT-OPTIONS:
  s_matnr FOR matdoc-matnr,
  s_budat FOR matdoc-budat.

START-OF-SELECTION.

  TRY.

*      DATA(go_alv) = cl_salv_gui_table_ida=>create_for_cds_view( 'ZI_Train00_Annotations_01').
*      DATA(go_alv) = cl_salv_gui_table_ida=>create_for_cds_view( 'ZI_Train00_More_01').
*      DATA(go_alv) = cl_salv_gui_table_ida=>create_for_cds_view( 'ZI_Train00_More_02').
*      DATA(go_alv) = cl_salv_gui_table_ida=>create_for_cds_view( 'ZI_Train00_More_03').
      DATA(go_alv) = cl_salv_gui_table_ida=>create_for_cds_view( 'ZI_Train00_More_04').

      DATA(go_range) = NEW cl_salv_range_tab_collector( ).
      go_range->add_ranges_for_name( iv_name = 'MATNR' it_ranges = s_matnr[] ).
      go_range->add_ranges_for_name( iv_name = 'BUDAT' it_ranges = s_budat[] ).
      go_range->get_collected_ranges( IMPORTING et_named_ranges = DATA(gt_named_ranges) ).

      DATA(go_condition_factory) = go_alv->condition_factory( ).
      DATA(go_condition) = go_condition_factory->equals( name = 'BUKRS' value = p_bukrs ).

      go_alv->set_select_options(
        it_ranges     = gt_named_ranges
        io_condition  = go_condition ).

      go_alv->set_maximum_number_of_rows( 1000 ).
      go_alv->fullscreen( )->display( ).

    CATCH cx_salv_error INTO DATA(lx_error).
      MESSAGE lx_error TYPE 'S' DISPLAY LIKE 'E'.
  ENDTRY.
