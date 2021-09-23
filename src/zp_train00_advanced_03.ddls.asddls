/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_ADVANCED_03
*&---------------------------------------------------------------------*
*&  Consume Input Parameters
*&  Simplify complexity - Internal calculation
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZPTRAIN00ADVAN03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Consume Input Parameters'

define view ZP_TRAIN00_ADVANCED_03
  with parameters
    i_key_date : abap.dats @<Environment.systemField: #SYSTEM_DATE,
    i_days_1   : abap.int1,
    i_koart    : koart
  as select from ZI_TRAIN00_MORE_06                as Acc

    inner join   ZI_TRAIN00_ADVANCED_01(
                 i_days_1 : $parameters.i_days_1 ) as KeyDate on KeyDate.CalendarDate = $parameters.i_key_date

  association to I_BusinessPartner as _Partner on _Partner.BusinessPartner = $projection.partner
{
  key Acc.rbukrs,
  key Acc.gjahr,
  key Acc.belnr,
  key Acc.docln,

      case $parameters.i_koart
        when 'D'
          then Acc.kunnr
        else Acc.lifnr
      end                    as partner,
      Acc.rhcur,

      $parameters.i_key_date as keyDate,
      Acc.budat,
      Acc.netdt,
      Acc.augdt,
      KeyDate.Date1,

      @Semantics.amount.currencyCode: 'rhcur'
      Acc.hsl,

      @Semantics.amount.currencyCode: 'rhcur'
      case
        when Acc.netdt > KeyDate.Date1
          then Acc.hsl
        else 0
      end                    as overDue,

      @Semantics.amount.currencyCode: 'rhcur'
      case
        when Acc.netdt <= KeyDate.Date1
          then Acc.hsl
        else 0
      end                    as currentDue,

      $parameters.i_koart    as koart,
      
      _Partner
}
where
       Acc.koart = $parameters.i_koart
  and  Acc.budat <= $parameters.i_key_date
  and(
       Acc.augdt = '00000000'
    or Acc.augdt > $parameters.i_key_date
  )
