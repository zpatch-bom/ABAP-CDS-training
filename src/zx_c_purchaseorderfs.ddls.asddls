@AbapCatalog.sqlViewAppendName: 'ZXCPURORDERFS'
@EndUserText.label: 'Extend C_PURCHASEORDERFS'
extend view C_PurchaseOrderFs with ZX_C_PURCHASEORDERFS {

  @EndUserText.label: 'Header Text'
  @UI.identification: [{ position: 900 }]
  @ObjectModel.virtualElement: true
  @ObjectModel.virtualElementCalculatedBy: 'ZCLMM_TRAIN_PO_HDRTXT'
  cast( 'TEST' as abap.char( 255 ) ) as zzHeaderText
}

