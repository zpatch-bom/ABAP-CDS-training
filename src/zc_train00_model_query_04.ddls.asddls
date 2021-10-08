/*---------------------------------------------------------------------*
*& Data Definition: ZC_TRAIN00_MODEL_Query_01
*&---------------------------------------------------------------------*
*&  Same as ZC_TRAIN00_ADVANCED_03 but more Analyticals
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZCTRAIN00QUERY04'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Model - Query'

@VDM.viewType: #CONSUMPTION
@OData.publish: true
@OData.entitySet.name: 'Query3Sets'
@OData.entityType.name: 'Query3Type'

define view ZC_TRAIN00_MODEL_QUERY_04
  as select from ZI_TRAIN00_MODEL_CUBE_01( 
                   i_key_date: $session.system_date,
                   i_days_1: 30,
                   i_koart: 'D' )
{
//      @UI.textArrangement: #TEXT_LAST
  key rbukrs,

//      @UI.textArrangement: #TEXT_LAST
  key partner,

      rhcur,
      openingAmount,
      overDue,
      currentDue,
      
      _Partner,
      _Company
}
