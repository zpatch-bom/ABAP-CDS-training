/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_ADVANCED_02
*&---------------------------------------------------------------------*
*&  Consume Input Parameters
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00ADVAN02'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Consume Input Parameters'
 
define view ZI_TRAIN00_ADVANCED_02
  with parameters
    i_key_date : abap.dats @<Environment.systemField: #SYSTEM_DATE,
    i_days_1   : abap.int1,
    i_koart    : koart
  as select from ZI_TRAIN00_MORE_06                as Acc

    inner join   ZI_TRAIN00_ADVANCED_01(
                 i_days_1 : $parameters.i_days_1 ) 
               as KeyDate on KeyDate.CalendarDate = $parameters.i_key_date
{
  key Acc.rbukrs,
  key case $parameters.i_koart
        when 'D'
          then Acc.kunnr
        when 'K'
          then Acc.lifnr
        else ''
      end                    as partner,
      @Semantics.amount.currencyCode: 'rhcur'
      sum( Acc.hsl )         as hsl,
      @Semantics.amount.currencyCode: 'rhcur'
      sum(
        case when Acc.netdt > KeyDate.Date1
          then Acc.hsl
          else 0
        end )                as overDue,
      @Semantics.amount.currencyCode: 'rhcur'
      sum(
        case when Acc.netdt <= KeyDate.Date1
          then Acc.hsl
          else 0
        end )                as currentDue,
      max( Acc.budat )       as maxBUDAT,
      max( Acc.augdt )       as maxAUGDT,
      count( * )             as nOfRecords,
      Acc.rhcur,
      $parameters.i_key_date as keyDate,
      $parameters.i_koart    as koart
}
where
       Acc.koart = $parameters.i_koart
  and  Acc.budat <= $parameters.i_key_date
  and(
       Acc.augdt = '00000000'
    or Acc.augdt > $parameters.i_key_date
  )
group by
  Acc.rbukrs,
  Acc.kunnr,
  Acc.lifnr,
  Acc.rhcur
