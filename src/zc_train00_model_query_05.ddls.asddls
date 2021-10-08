/*---------------------------------------------------------------------*
*& Data Definition: ZC_TRAIN00_MODEL_Query_01
*&---------------------------------------------------------------------*
*&  Same as ZC_TRAIN00_ADVANCED_03 but more Analyticals
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZCTRAIN00QUERY05'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Model - Query'

@Analytics.query: true
@VDM.viewType: #CONSUMPTION
@OData.publish: true

define view ZC_TRAIN00_MODEL_QUERY_05
  as select from ZI_TRAIN00_MODEL_CUBE_01(
                   i_key_date: $session.system_date,
                   i_days_1: 30,
                   i_koart: 'D' )
{
      @AnalyticsDetails.query.display: #KEY_TEXT
  key rbukrs,

      @AnalyticsDetails.query.display: #KEY_TEXT
  key partner,

      rhcur,
      openingAmount,
      overDue,
      currentDue,
      
      _Partner,
      _Company
}

