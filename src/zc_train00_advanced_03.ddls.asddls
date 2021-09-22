/*---------------------------------------------------------------------*
*& Data Definition: ZC_TRAIN00_ADVANCED_03
*&---------------------------------------------------------------------*
*&  Consume Input Parameters
*&  Simplify complexity
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZCTRAIN00ADVAN03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Consume Input Parameters'

define view ZC_TRAIN00_ADVANCED_03
  with parameters
    i_key_date : abap.dats @<Environment.systemField: #SYSTEM_DATE,
    i_days_1   : abap.int1,
    i_koart    : koart
  as select from ZI_TRAIN00_ADVANCED_03(
                   i_key_date: $parameters.i_key_date,
                   i_days_1: $parameters.i_days_1,
                   i_koart: $parameters.i_koart )
{
  key rbukrs,

      @EndUserText.label: 'Partner'
  key partner,

      @EndUserText.label: 'Customer Name'
      _Partner.BusinessPartnerFullName as FullName,

      rhcur,

      @EndUserText.label: 'Opening Amount'
      hsl,

      @EndUserText.label: 'Overdue Amount'
      overDue,

      @EndUserText.label: 'Current due Amount'
      currentDue,

      firstPostingDate,
      lastClearingDate
}
