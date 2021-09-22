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
    i_key_date : keyda @<Environment.systemField: #SYSTEM_DATE,
    i_days_1   : agedays,
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
  key rbukrs,

      @AnalyticsDetails.query.axis: #ROWS
      @AnalyticsDetails.query.display: #KEY_TEXT
//      @ObjectModel.foreignKey.association: '_Partner'
  key partner,

      @AnalyticsDetails.query.axis: #FREE
      rhcur,

      @AnalyticsDetails.query.axis: #COLUMNS
      openingAmount,

      @AnalyticsDetails.query.axis: #COLUMNS
      overDue,

      @AnalyticsDetails.query.axis: #COLUMNS
      currentDue
      
//      _Partner
}


