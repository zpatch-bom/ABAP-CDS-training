/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_MORE_05
*&---------------------------------------------------------------------*
*&  Date Functions
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00MORE05'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Date Functions'

define view ZI_TRAIN00_MORE_05
  as select from ZI_Train00_Annotations_01 as MDOC
{
  key MDOC.mjahr,
  key MDOC.mblnr,
  key MDOC.zeile,

      MDOC.budat,
      
      dats_is_valid(
        cast(
          concat(
            left( MDOC.budat, 6),
            '31'
          ) as abap.dats
        )
      )                                         as dIsValid,

      dats_add_days( MDOC.budat, -1, 'NULL' )   as dAddDays,

      dats_add_months( MDOC.budat, 2, 'NULL' ) as dAddMonths,

      dats_days_between( MDOC.budat,
        cast( $session.system_date as abap.dats )
      )                                         as dDiff,

      MDOC.bukrs
}
