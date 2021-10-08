*&---------------------------------------------------------------------*
*& Report ZTRAIN00_CDS_034
*&---------------------------------------------------------------------*
*& Training - Consume ABAP CDS - ALV IDA
*&---------------------------------------------------------------------*
REPORT ztrain00_cds_04.

TABLES: but000.

PARAMETERS:
  p_bukrs  TYPE bukrs DEFAULT '0001'      OBLIGATORY,
  p_keydat TYPE datum DEFAULT '20210331'  OBLIGATORY,
  p_days_1 TYPE int1  DEFAULT 45          OBLIGATORY,
  p_koart  TYPE koart DEFAULT 'D'         OBLIGATORY.

SELECT-OPTIONS:
  s_partnr FOR but000-partner.

START-OF-SELECTION.

  PERFORM alv_ida.

FORM alv_ida.
  TRY.
*      DATA(lo_alv) = cl_salv_gui_table_ida=>create_for_cds_view( 'ZC_TRAIN00_ADVANCED_03').
      DATA(lo_alv) = cl_salv_gui_table_ida=>create_for_cds_view( 'ZC_TRAIN00_MODEL_Query_01').

      lo_alv->set_view_parameters(
        it_parameters = VALUE #(
          ( name = 'I_DAYS_1'   value = p_days_1 )
          ( name = 'I_KOART'    value = p_koart )
          ( name = 'I_KEY_DATE' value = p_keydat )
        )
      ).

      DATA(lo_range) = NEW cl_salv_range_tab_collector( ).
      lo_range->add_ranges_for_name( iv_name = 'PARTNER' it_ranges = s_partnr[] ).
      lo_range->get_collected_ranges( IMPORTING et_named_ranges = DATA(lt_named_ranges) ).

      DATA(lo_condition_factory) = lo_alv->condition_factory( ).
      DATA(lo_condition) = lo_condition_factory->equals(
        EXPORTING
          name         = 'RBUKRS'
          value        = p_bukrs
      ).

      lo_alv->set_select_options(
        it_ranges    = lt_named_ranges
        io_condition = lo_condition
      ).

      DATA(lo_layout) = lo_alv->default_layout( ).
      lo_layout->set_aggregations(
*        VALUE #(  ( field_name = 'HSL       '    function = if_salv_service_types=>cs_function_code-sum )
        VALUE #(  ( field_name = 'OPENINGAMOUNT'  function = if_salv_service_types=>cs_function_code-sum )
                  ( field_name = 'OVERDUE   '     function = if_salv_service_types=>cs_function_code-sum )
                  ( field_name = 'CURRENTDUE'     function = if_salv_service_types=>cs_function_code-sum ) ) ).
      lo_layout->set_sort_order(
        VALUE #(
          ( field_name = 'RBUKRS' is_grouped = abap_true )
          ( field_name = 'PARTNER' )
        ) ).

      lo_alv->fullscreen( )->display( ).

    CATCH cx_salv_ida_dynamic INTO DATA(lx_error).
      MESSAGE lx_error TYPE 'S' DISPLAY LIKE 'E'.
  ENDTRY.
ENDFORM.
