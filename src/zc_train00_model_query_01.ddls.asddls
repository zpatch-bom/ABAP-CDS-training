/*---------------------------------------------------------------------*
*& Data Definition: ZC_TRAIN00_MODEL_Query_01
*&---------------------------------------------------------------------*
*&  Same as ZC_TRAIN00_ADVANCED_03 but more Analyticals
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZCTRAIN00QUERY01'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Model - Query'

@Analytics.query: true
@VDM.viewType: #CONSUMPTION

define view ZC_TRAIN00_MODEL_Query_01
  with parameters
//    @Environment.systemField: #SYSTEM_DATE
    @Consumption.defaultValue: '20210331'
    i_key_date : keyda,
    @Consumption.defaultValue: '30'
    i_days_1   : agedays,
    @Consumption.defaultValue: 'D'
    i_koart    : koart
  as select from ZI_TRAIN00_MODEL_CUBE_01(
                   i_key_date: $parameters.i_key_date,
                   i_days_1: $parameters.i_days_1,
                   i_koart: $parameters.i_koart )
{
      @Consumption.filter: {
        mandatory: true,
        defaultValue: '0001',
        defaultValueHigh: '0003',
        selectionType: #INTERVAL,
        multipleSelections: true
      }
      @AnalyticsDetails.query.axis: #COLUMNS
      @AnalyticsDetails.query.display: #KEY_TEXT
      @AnalyticsDetails.query.totals: #SHOW
  key rbukrs,

      @AnalyticsDetails.query.axis: #ROWS
//      @AnalyticsDetails.query.display: #KEY_TEXT
      @AnalyticsDetails.query.display: #KEY
  key partner,

      //      @AnalyticsDetails.query.axis: #FREE
      //      CompanyName, // Do not add text field like this, use foreign key association instead

      @AnalyticsDetails.query.axis: #FREE
      rhcur,

      @AnalyticsDetails.query.axis: #COLUMNS
      openingAmount,

      @AnalyticsDetails.query.axis: #COLUMNS
      overDue,

      @AnalyticsDetails.query.axis: #COLUMNS
      currentDue,

      @EndUserText.label: '%Overdue'
      @AnalyticsDetails.query.axis: #COLUMNS
      @AnalyticsDetails.query.formula: 'NDIV0( overDue * 100 / openingAmount)'
      cast( 0 as abap.dec( 23, 4 ) ) as percentOverdue,
      
      @EndUserText.label: '%Overall'
      @AnalyticsDetails.query.axis: #COLUMNS
      @AnalyticsDetails.query.formula: 'NDIV0( overDue * 100 / SUMRT( openingAmount ) )'
      cast( 0 as abap.dec( 23, 2 ) ) as sumgt
      

}
