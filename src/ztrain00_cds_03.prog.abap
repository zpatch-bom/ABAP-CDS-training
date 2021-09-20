*&---------------------------------------------------------------------*
*& Report ZTRAIN00_CDS_03
*&---------------------------------------------------------------------*
*& Training - Input Parameters
*&---------------------------------------------------------------------*
REPORT ztrain00_cds_03.


PARAMETERS:
  p_days_1 TYPE int1 DEFAULT 45.

PARAMETERS:
  p_disp_1 RADIOBUTTON GROUP dis DEFAULT 'X',
  p_disp_2 RADIOBUTTON GROUP dis.

START-OF-SELECTION.

  CASE abap_true.
    WHEN p_disp_1.
      PERFORM alv_ida.
    WHEN p_disp_2.
      PERFORM demo_output.
  ENDCASE.

FORM alv_ida.
  TRY.
      DATA(go_alv) = cl_salv_gui_table_ida=>create_for_cds_view( 'ZI_TRAIN00_ADVANCED_01').
      go_alv->set_view_parameters(
        it_parameters = VALUE #(
          ( name = 'I_DAYS_1'   value = p_days_1 )
        )
      ).
      go_alv->fullscreen( )->display( ).
    CATCH cx_salv_error INTO DATA(lx_error).
      MESSAGE lx_error TYPE 'S' DISPLAY LIKE 'E'.
  ENDTRY.
ENDFORM.

FORM demo_output.

  SELECT FROM zi_train00_advanced_01( i_days_1    = @p_days_1 ) AS a
    FIELDS
      a~*
    INTO TABLE @DATA(lt_date)
    UP TO 10 ROWS.

  cl_demo_output=>display( lt_date ).

ENDFORM.
