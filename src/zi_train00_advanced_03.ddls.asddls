/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_ADVANCED_03
*&---------------------------------------------------------------------*
*&  Consume Input Parameters
*&  Simplify complexity
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00ADVAN03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Consume Input Parameters'
define view ZI_TRAIN00_ADVANCED_03
  with parameters
    i_key_date : abap.dats @<Environment.systemField: #SYSTEM_DATE,
    i_days_1   : abap.int1,
    i_koart    : koart
  as select from ZP_TRAIN00_ADVANCED_03(
                 i_key_date: $parameters.i_key_date,
                 i_days_1: $parameters.i_days_1,
                 i_koart: $parameters.i_koart ) as Acc
{
  key Acc.rbukrs,
      @EndUserText.label: 'Partner'
  key Acc.partner,
      Acc.rhcur,
      @EndUserText.label: 'Opening Amount'
      sum (Acc.hsl )        as hsl,
      @EndUserText.label: 'Overdue Amount'
      sum( Acc.overDue )    as overDue,
      @EndUserText.label: 'Current due Amount'
      sum( Acc.currentDue ) as currentDue,
      @EndUserText.label: 'Count'
      count( * )            as nOfRecords
}
group by
  Acc.rbukrs,
  Acc.partner,
  Acc.rhcur
