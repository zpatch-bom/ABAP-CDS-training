/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_MORE_07
*&---------------------------------------------------------------------*
*&  Aggregations
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00MORE07'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Aggregations'
define view ZI_TRAIN00_MORE_07
  as select from ZI_TRAIN00_MORE_06 as Acc
{
  key Acc.kunnr,
      Acc.koart,
      count( * )                           as nOfRecords,
      count( distinct Acc.racct )          as nOfGL,
      max( Acc.hsl )                       as highestAmt,
      min( Acc.budat )                     as firstTrans,
      @Semantics.amount.currencyCode: 'rhcur'
      avg( Acc.hsl )                       as avgAmtFloat,
      @Semantics.amount.currencyCode: 'rhcur'
      avg( Acc.hsl as abap.curr( 23, 2 ) ) as avgAmtDec,
      @Semantics.amount.currencyCode: 'rhcur'
      cast(
        sum( Acc.hsl )
        as fins_vhcur12 preserving type )  as balance,
      @Semantics.amount.currencyCode: 'rhcur'
      sum(
        case
          when Acc.auggj = ''
            then Acc.hsl
          else 0
        end )                              as opening,
      Acc.rhcur
}
where
  Acc.koart = 'D'
group by
  Acc.koart,
  Acc.kunnr,
  Acc.rhcur
having
  sum( Acc.hsl ) <> 0
