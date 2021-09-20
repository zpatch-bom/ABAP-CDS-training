/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_ADVANCED_01
*&---------------------------------------------------------------------*
*&  Input Parameters
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00ADVAN01'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Input Parameters'

define view ZI_TRAIN00_ADVANCED_01
  with parameters
    i_days_1 : abap.int1
  as select from I_CalendarDate

{
  key CalendarDate,
      CalendarYear,
      CalendarMonth,
      @EndUserText.label: 'Diff. Date'
      dats_add_days(
        CalendarDate,
        $parameters.i_days_1 * -1,
        'NULL' ) as Date1
}


