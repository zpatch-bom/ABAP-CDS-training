class ZCLMM_TRAIN_PO_ITMTXT definition
  public
  final
  create public .

public section.

  interfaces IF_SADL_EXIT .
  interfaces IF_SADL_EXIT_CALC_ELEMENT_READ .
  interfaces IF_SADL_EXIT_SORT_TRANSFORM .
protected section.
private section.
ENDCLASS.



CLASS ZCLMM_TRAIN_PO_ITMTXT IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA:
      lt_items  TYPE STANDARD TABLE OF c_purorditemenh WITH EMPTY KEY,
      lt_lines  TYPE tline_t,
      lt_string TYPE STANDARD TABLE OF text200 WITH EMPTY KEY.

    lt_items = CORRESPONDING #( it_original_data ).

    LOOP AT lt_items ASSIGNING FIELD-SYMBOL(<lw_item>).
      DO 2 TIMES.
        CALL FUNCTION 'READ_TEXT'
          EXPORTING
            id       = 'F01'
            language = SWITCH spras( sy-index WHEN 1 THEN '2' ELSE 'E' )
            name     = CONV tdobname( <lw_item>-purchaseorder && <lw_item>-purchaseorderitem )
            object   = 'EKPO'
          TABLES
            lines    = lt_lines
          EXCEPTIONS
            OTHERS   = 8.
        IF sy-subrc = 0.
          CALL FUNCTION 'CONVERT_ITF_TO_STREAM_TEXT'
            TABLES
              itf_text    = lt_lines
              text_stream = lt_string.

          <lw_item>-zzitemtext = concat_lines_of( table = lt_string ).
          EXIT.
        ENDIF.
      ENDDO.

    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_items ).

  ENDMETHOD.


  METHOD IF_SADL_EXIT_CALC_ELEMENT_READ~GET_CALCULATION_INFO.
  ENDMETHOD.


  method IF_SADL_EXIT_SORT_TRANSFORM~MAP_ELEMENT.
  endmethod.
ENDCLASS.
