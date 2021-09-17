/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_MORE_02
*&---------------------------------------------------------------------*
*&  Arithmetic Expressions
*&  Type Conversion
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00MORE02'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Arithmetic & CAST'

define view ZI_Train00_More_02
  as select from ZI_Train00_Annotations_01 as MDOC
{
  key MDOC.mjahr,
  key MDOC.mblnr,
  key MDOC.zeile,

      MDOC.shkzg,

      @EndUserText.label: 'Credit/Debit'
      case MDOC.shkzg
        when 'S'
          then 'Debit'
        else 'Credit'
      end                                 as CrDr,

      @EndUserText.label: 'Criteria'
      cast( 2000 as abap.dec( 13, 3 ) )   as Criteria,

      @EndUserText.label: 'Qty. Criteria'
      case
        when MDOC.stock_qty >= 2000
          then 'More'
        when MDOC.stock_qty >= 0
          then 'Less'
        else 'Return'
      end                                 as Qty_Criteria,

      MDOC.meins,
      MDOC.stock_qty,

      @EndUserText.label: 'Qty. w/Condition'
      case
        when MDOC.stock_qty >= 2000
          then division( MDOC.stock_qty, 10, 3)
        when MDOC.stock_qty >= 0
          then MDOC.stock_qty * 10
        else 0
      end                                 as Qty_Cond,

      @EndUserText.label: 'Qty. w/CAST predefined'
      @Semantics.quantity.unitOfMeasure: 'meins'
      cast(
        case
          when MDOC.stock_qty >= 2000
            then division( MDOC.stock_qty, 10, 3)
          when MDOC.stock_qty >= 0
            then MDOC.stock_qty * 10
          else 0
        end
      as abap.quan( 13, 3 ) )             as Qty_Cast1,

      @EndUserText.label: 'Qty. w/CAST data element'
      @Semantics.quantity.unitOfMeasure: 'meins'
      cast(
        case
          when MDOC.stock_qty >= 2000
            then division( MDOC.stock_qty, 10, 3)
          when MDOC.stock_qty >= 0
            then MDOC.stock_qty * 10
          else 0
        end
      as nsdm_stock_qty preserving type ) as Qty_Cast2,


      MDOC.bwart,
      MDOC.matnr,
      MDOC.bukrs,
      MDOC.budat
}
