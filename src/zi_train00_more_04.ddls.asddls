/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_MORE_04
*&---------------------------------------------------------------------*
*&  Unit and Currency conversion
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00MORE04'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Unit & Currency conversion'

define view ZI_Train00_More_04
  as select from ZI_Train00_Annotations_01 as MDOC
{
  key MDOC.mjahr,
  key MDOC.mblnr,
  key MDOC.zeile,

      MDOC.matnr,

      MDOC.stock_qty,
      MDOC.meins,

      @Semantics.quantity.unitOfMeasure: 'unit_g'
      unit_conversion(
        error_handling  => 'SET_TO_NULL',
        quantity        => MDOC.stock_qty,
        source_unit     => MDOC.meins,
        target_unit     => cast( 'G' as abap.unit ) ) as qty_g,

      @Semantics.unitOfMeasure: true
      cast( 'G' as abap.unit )                    as unit_g,

      MDOC.dmbtr_stock,
      MDOC.waers,
      
      @Semantics.amount.currencyCode: 'curr_usd'
      currency_conversion( 
        amount              => MDOC.dmbtr_stock, 
        source_currency     => MDOC.waers, 
        target_currency     => cast( 'USD' as abap.cuky ), 
        exchange_rate_date  => MDOC.budat ) as amount_usd,
      
      @Semantics.currencyCode: true
      cast( 'USD' as waers ) as curr_usd,

      MDOC.bukrs,
      MDOC.budat
}
