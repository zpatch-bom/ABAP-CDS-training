/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_MORE_06
*&---------------------------------------------------------------------*
*&  Aggregations
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00MORE06'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Aggregations (Basic-ACDOCA)'

@Analytics.dataCategory: #FACT
@VDM.viewType: #BASIC

define view ZI_TRAIN00_MORE_06
  as select from acdoca as Acc
{
  key Acc.rbukrs,
  key Acc.gjahr,
  key Acc.belnr,
  key Acc.docln,
      Acc.budat,
      Acc.blart,
      Acc.koart,
      Acc.racct,
      Acc.kunnr,
      Acc.lifnr,
      @Semantics.amount.currencyCode: 'rhcur'
      Acc.hsl,
      @Semantics.currencyCode: true
      Acc.rhcur,
      Acc.augbl,
      Acc.auggj,
      Acc.augdt,
      Acc.netdt
}
where
       Acc.rldnr  =    '0L'
  and(
       Acc.kunnr  like '0002%'
    or Acc.lifnr  like '0002%'
  )
//  and  Acc.rbukrs =    '0001'
  and(
       Acc.koart  =    'D'
    or Acc.koart  =    'K'
  )
