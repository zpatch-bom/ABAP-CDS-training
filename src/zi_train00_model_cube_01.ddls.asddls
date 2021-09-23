/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_MODEL_CUBE_01
*&---------------------------------------------------------------------*
*&  Same as ZI_TRAIN00_ADVANCED_03 but more Analyticals
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00MCUBE01'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Model - Aggregation'

@Analytics.dataCategory: #AGGREGATIONLEVEL
@VDM.viewType: #COMPOSITE

define view ZI_TRAIN00_MODEL_CUBE_01
  with parameters
    i_key_date : abap.dats @<Environment.systemField: #SYSTEM_DATE,
    i_days_1   : abap.int1,
    i_koart    : koart
  as select from ZP_TRAIN00_MODEL_CUBE_01(
                 i_key_date: $parameters.i_key_date,
                 i_days_1: $parameters.i_days_1,
                 i_koart: $parameters.i_koart ) as Acc
{
  key Acc.rbukrs,
  key Acc.partner,

      //      Acc.CompanyName,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'rhcur'
      cast(
        sum( Acc.openingAmount )
        as ztrain_de_openning preserving type )               as openingAmount,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'rhcur'
      cast(
        sum( Acc.overDue )
          as ztrain_de_overdue preserving type )              as overDue,

      @Aggregation.default: #SUM
      cast(
        sum( Acc.currentDue )
          as ztrain_de_currentdue preserving type )           as currentDue,

      @Aggregation.default: #SUM
      cast(
        count( * ) as ztrain_de_nofrecords preserving type  ) as nOfRecords,

//    For the Percentage, we cannot do like this. % cannot SUM
//      cast(
//        sum(
//          case
//            when Acc.openingAmount <> 0
//              then division(
//                    Acc.overDue * 100,
//                    Acc.openingAmount,
//                    4)
//              else 0
//          end ) as abap.dec( 23, 4 ) )                        as percentageOverdue,

      Acc.rhcur,

      // Associations
      acc._Partner,
      acc._Company
}
group by
//  Acc.CompanyName,
  Acc.rbukrs,
  Acc.partner,
  Acc.rhcur
