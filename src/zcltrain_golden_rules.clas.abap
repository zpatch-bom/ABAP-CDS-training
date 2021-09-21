CLASS zcltrain_golden_rules DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-METHODS
      keep_result_sets_small.
    METHODS minimize_transferred_data.
    METHODS one_plus_two.
    METHODS minimize_data_transfers.

ENDCLASS.



CLASS zcltrain_golden_rules IMPLEMENTATION.


  METHOD keep_result_sets_small.
    TYPES: BEGIN OF helper_type,
             bukrs   TYPE bseg-bukrs,
             gjahr   TYPE bseg-gjahr,
             belnr   TYPE bseg-belnr,
             buzei   TYPE bseg-buzei,
             h_budat TYPE bseg-h_budat,
             kunnr   TYPE bseg-kunnr,
           END OF helper_type.
    DATA: lt_dont   TYPE STANDARD TABLE OF helper_type,
          lt_result LIKE lt_dont.

    SELECT FROM bseg AS a
      FIELDS
        a~bukrs, a~gjahr, a~belnr, a~buzei, a~h_budat, a~kunnr
      WHERE a~bukrs = '0001'
        AND a~gjahr = '2021'
      INTO TABLE @lt_dont.

    LOOP AT lt_dont ASSIGNING FIELD-SYMBOL(<lw_dont>).
      CHECK <lw_dont>-h_budat BETWEEN '20210701' AND '20210731'.
      CHECK <lw_dont>-kunnr = '0020000001'.
      APPEND <lw_dont> TO lt_result.
    ENDLOOP.

    SELECT FROM bseg AS a
      FIELDS
        a~bukrs, a~gjahr, a~belnr, a~buzei
      WHERE a~bukrs = '0001'
        AND a~gjahr = '2021'
        AND a~h_budat BETWEEN '20210701' AND '20210731'
        AND a~kunnr = '0020000001'
      INTO TABLE @DATA(lt_do).

  ENDMETHOD.


  METHOD minimize_transferred_data.

    SELECT FROM bseg AS a
      FIELDS
        a~*
      WHERE a~bukrs = '0001'
        AND a~gjahr = '2021'
        AND a~h_budat BETWEEN '20210701' AND '20210731'
        AND a~kunnr = '0020000001'
      INTO TABLE @DATA(lt_dont).

    SELECT FROM bseg AS a
      FIELDS
        a~bukrs, a~gjahr, a~belnr, a~buzei
      WHERE a~bukrs = '0001'
        AND a~gjahr = '2021'
        AND a~h_budat BETWEEN '20210701' AND '20210731'
        AND a~kunnr = '0020000001'
      INTO TABLE @DATA(lt_do).

  ENDMETHOD.


  METHOD one_plus_two.

    TYPES:
      BEGIN OF lty_result,
        bukrs TYPE bsid-bukrs,
        kunnr TYPE bsid-kunnr,
        dmbtr TYPE bsid-dmbtr,
      END OF lty_result.

    DATA:
      lt_result TYPE SORTED TABLE OF lty_result WITH UNIQUE KEY bukrs kunnr,
      lw_result LIKE LINE OF lt_result.

    CONSTANTS:
      lc_minus TYPE p LENGTH 1 DECIMALS 0 VALUE -1.

    " DON'T
    SELECT FROM bseg AS a
      FIELDS
        a~*
      WHERE a~bukrs = '0001'
        AND a~gjahr = '2021'
        AND a~h_budat BETWEEN '20210701' AND '20210731'
        AND a~kunnr = '0020000001'
      INTO TABLE @DATA(lt_dont).

    LOOP AT lt_dont ASSIGNING FIELD-SYMBOL(<lw_dont>).
      CLEAR: lw_result.
      lw_result-bukrs = <lw_dont>-bukrs.
      lw_result-kunnr = <lw_dont>-kunnr.
      lw_result-dmbtr = <lw_dont>-dmbtr.
      IF <lw_dont>-shkzg = 'H'.
        lw_result-dmbtr *= lc_minus.
      ENDIF.
      COLLECT lw_result INTO lt_result.
    ENDLOOP.

    DELETE lt_result WHERE dmbtr < 0.

    " DO
    SELECT FROM bseg AS a
      FIELDS
        a~bukrs, a~kunnr,
        SUM(
          CASE
            WHEN a~shkzg = 'S'
              THEN a~dmbtr
            ELSE a~dmbtr * @lc_minus
          END ) AS dmbtr
      WHERE a~bukrs = '0001'
        AND a~gjahr = '2021'
        AND a~h_budat BETWEEN '20210701' AND '20210731'
        AND a~kunnr = '0020000001'
      GROUP BY
        a~bukrs, a~kunnr
      HAVING
        SUM(
          CASE
            WHEN a~shkzg = 'S'
              THEN a~dmbtr
            ELSE a~dmbtr * @lc_minus
          END )  >= 0
      INTO TABLE @lt_result.

  ENDMETHOD.


  METHOD minimize_data_transfers.
    TYPES: BEGIN OF helper_type,
             bukrs TYPE bseg-bukrs,
             gjahr TYPE bseg-gjahr,
             belnr TYPE bseg-belnr,
             buzei TYPE bseg-buzei,
             kunnr TYPE bseg-kunnr,
             dmbtr TYPE bseg-dmbtr,
           END OF helper_type.
    DATA: lt_dont   TYPE STANDARD TABLE OF helper_type,
          lt_result LIKE lt_dont,
          lt_do     LIKE lt_dont.

    " DON'T
    SELECT FROM bseg AS a
      FIELDS
        a~bukrs, a~gjahr, a~belnr, a~buzei, a~kunnr, a~dmbtr
      WHERE a~bukrs = '0001'
        AND a~h_budat BETWEEN '20210701' AND '20210731'
        AND a~koart = 'D'
      INTO TABLE @lt_dont.

    SELECT FROM kna1 AS a
      FIELDS
        a~kunnr, a~ktokd
      FOR ALL ENTRIES IN @lt_dont
      WHERE a~kunnr = @lt_dont-kunnr
      INTO TABLE @DATA(lt_kna1).

    LOOP AT lt_dont ASSIGNING FIELD-SYMBOL(<lw_dont>).
      READ TABLE lt_kna1 ASSIGNING FIELD-SYMBOL(<lw_kna1>)
        WITH KEY kunnr = <lw_dont>-kunnr.
      CHECK sy-subrc = 0 AND <lw_kna1>-ktokd = 'ZOT'.
      APPEND <lw_dont> TO lt_result.
    ENDLOOP.

    SELECT FROM bseg AS a
      INNER JOIN kna1 AS b
        ON  b~kunnr = a~kunnr
      FIELDS
        a~bukrs, a~gjahr, a~belnr, a~buzei, a~kunnr, a~dmbtr
      WHERE a~bukrs = '0001'
        AND a~h_budat BETWEEN '20210701' AND '20210731'
        AND a~koart = 'D'
        AND b~ktokd = 'ZOT'
      INTO TABLE @lt_do.

  ENDMETHOD.



ENDCLASS.
