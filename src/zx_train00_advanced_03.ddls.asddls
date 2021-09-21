@AbapCatalog.sqlViewAppendName: 'ZXTRAIN00ADVAN03'
@EndUserText.label: 'Training - Extend View'
extend view ZI_TRAIN00_ADVANCED_03 with ZX_TRAIN00_ADVANCED_03
  association to ZI_Train00_Basic_01 as _Company on _Company.bukrs = $projection.rbukrs
{
  1                      as fixed_val,
  $parameters.i_key_date as KeyDate,
  _Company
}


