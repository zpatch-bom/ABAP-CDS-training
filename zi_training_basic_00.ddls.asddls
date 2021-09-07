@AbapCatalog.sqlViewName: 'ZI_TRAIN00_01'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS - Basic'

define view ZI_Training_Basic_00
  as select from t001 as CC
{
  key CC.bukrs,
      CC.butxt,
      CC.ort01,
      CC.land1,
      CC.waers,
      CC.spras,
      CC.ktopl
}
