/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_MORE_08
*&---------------------------------------------------------------------*
*&  Union
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00MORE08'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Union'
define view ZI_TRAIN00_MORE_08
  as select from ZI_TRAIN00_MORE_07 as Acc
{
  key Acc.kunnr,
      Acc.koart,
      Acc.nOfRecords,
      Acc.nOfGL,
      Acc.highestAmt,
      Acc.firstTrans,
      Acc.avgAmtFloat,
      Acc.avgAmtDec,
      Acc.balance,
      Acc.opening,
      Acc.rhcur
}
union all select from zttrain000200 as Custom
{
  key Custom.partner             as kunnr,
      'D'                        as koart,
      0                          as nOfRecords,
      0                          as nOfGL,
      Custom.balance             as highestAmt,
      '00000000'                 as firstTrans,
      0                          as avgAmtFloat,
      0                          as avgAmtDec,
      Custom.balance,
      Custom.balance             as opening,
      cast( 'THB' as abap.cuky ) as rhcur
}




