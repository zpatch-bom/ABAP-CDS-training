@AbapCatalog.sqlViewAppendName: 'ZXCPURORDITEMENH'
@EndUserText.label: 'Extend C_PURORDITEMENH'
extend view C_PurOrdItemEnh with ZX_C_PURORDITEMENH {

  @EndUserText.label: 'Item Text'
  @UI.lineItem: [{ position: 900, qualifier: 'PurchItem', importance: #HIGH },
                 { position: 31, importance: #HIGH }]
  @ObjectModel.virtualElement: true
  @ObjectModel.virtualElementCalculatedBy: 'ZCLMM_TRAIN_PO_ITMTXT'
  cast( 'ItemText' as abap.char(300) ) as zzItemText
}
