/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_ANNOTATIONS_01
*&---------------------------------------------------------------------*
*&  Basic Annotations
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00ANNOT01'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Basic Annotations'

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view ZI_Train00_Annotations_01
  as select from matdoc as MDOC
{
  key MDOC.mjahr,
  key MDOC.mblnr,
  key MDOC.zeile,

      @EndUserText.label: 'My Qty'
      @Semantics.quantity.unitOfMeasure: 'MEINS'
      MDOC.stock_qty,

      @Semantics.unitOfMeasure: true
      MDOC.meins,
      
      @Semantics.amount.currencyCode: 'waers'
      MDOC.dmbtr_stock,

      @Semantics.currencyCode: true
      MDOC.waers,

      MDOC.bwart,
      MDOC.matnr,
      MDOC.bukrs,
      MDOC.budat,
      MDOC.shkzg
}
where
      MDOC.record_type =       'MDOC'
  and MDOC.bwart       between '101' and '102'
