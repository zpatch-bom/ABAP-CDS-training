/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_MORE_01
*&---------------------------------------------------------------------*
*&  Literals
*&  CASE WHEN THEN ELSE
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00MORE01'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Literals & CASE'

define view ZI_Train00_More_01
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
      end  as CrDr,

      @EndUserText.label: 'Criteria'
      2000 as Criteria,

      @EndUserText.label: 'Qty. Criteria'
      case
        when MDOC.stock_qty >= 2000
          then 'More'
        when MDOC.stock_qty >= 0
          then 'Less'
        else 'Return'
      end  as Qty_Criteria,

      MDOC.stock_qty,
      MDOC.meins,

      MDOC.dmbtr_stock,
      MDOC.waers,

      MDOC.bwart,
      MDOC.matnr,
      MDOC.bukrs,
      MDOC.budat
}
