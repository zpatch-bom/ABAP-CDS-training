CLASS zclmm_train_po_hdrtxt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
    INTERFACES if_sadl_exit_sort_transform .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zclmm_train_po_hdrtxt IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA:
      lt_headers TYPE STANDARD TABLE OF c_purchaseorderfs WITH EMPTY KEY,
      lt_lines   TYPE tline_t,
      lt_string  TYPE STANDARD TABLE OF text200 WITH EMPTY KEY.

    lt_headers = CORRESPONDING #( it_original_data ).

    LOOP AT lt_headers ASSIGNING FIELD-SYMBOL(<lw_item>).
      DO 2 TIMES.
        CALL FUNCTION 'READ_TEXT'
          EXPORTING
            id       = 'F01'
            language = SWITCH spras( sy-index WHEN 1 THEN '2' ELSE 'E' )
            name     = CONV tdobname( <lw_item>-purchaseorder )
            object   = 'EKKO'
          TABLES
            lines    = lt_lines
          EXCEPTIONS
            OTHERS   = 8.
        IF sy-subrc = 0.
          CALL FUNCTION 'CONVERT_ITF_TO_STREAM_TEXT'
            TABLES
              itf_text    = lt_lines
              text_stream = lt_string.

          <lw_item>-zzheadertext = concat_lines_of( table = lt_string ).
          EXIT.
        ENDIF.
      ENDDO.

    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_headers ).

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.


  METHOD if_sadl_exit_sort_transform~map_element.
  ENDMETHOD.
ENDCLASS.
