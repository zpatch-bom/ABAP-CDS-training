@AbapCatalog.sqlViewAppendName: 'ZXTRAIN00ADVA003'
@EndUserText.label: 'Training - Extend View'
extend view ZC_TRAIN00_ADVANCED_03 with ZXC_TRAIN00_ADVANCED_03
{
  @EndUserText.label: 'Key Date'
  ZI_TRAIN00_ADVANCED_03.KeyDate,
  ZI_TRAIN00_ADVANCED_03._Partner.BusinessPartnerGrouping as BPGroup
}
