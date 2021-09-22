/*---------------------------------------------------------------------*
*& Data Definition: ZP_TRAIN00_MODEL_CUBE_01
*&---------------------------------------------------------------------*
*&  Same as ZP_TRAIN00_ADVANCED_03 but more Analyticals
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZPTRAIN00MCUBE01'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - Model - Cube'

@Analytics.dataCategory: #CUBE
@VDM.viewType: #COMPOSITE

define view ZP_TRAIN00_MODEL_CUBE_01
  with parameters
    i_key_date : abap.dats @<Environment.systemField: #SYSTEM_DATE,
    i_days_1   : abap.int1,
    i_koart    : koart
  as select from ZI_TRAIN00_MORE_06                as Acc

    inner join   ZI_TRAIN00_ADVANCED_01(
                 i_days_1 : $parameters.i_days_1 ) as KeyDate on KeyDate.CalendarDate = $parameters.i_key_date

  association to I_BusinessPartner   as _Partner on _Partner.BusinessPartner = $projection.partner
  association to ZI_Train00_Basic_01 as _Company on _Company.bukrs = $projection.rbukrs
{
      @ObjectModel.foreignKey.association: '_Company'
  key Acc.rbukrs,
  key Acc.gjahr,
  key Acc.belnr,
  key Acc.docln,

      @ObjectModel.foreignKey.association: '_Partner'
      cast(
        case $parameters.i_koart
          when 'D'
            then Acc.kunnr
          else Acc.lifnr
        end as bp_partner preserving type )           as partner,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'rhcur'
      cast(
        Acc.hsl
        as ztrain_de_openning preserving type )       as openingAmount,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'rhcur'
      cast(
        case
          when Acc.netdt > KeyDate.Date1
            then Acc.hsl
          else 0
        end as ztrain_de_overdue preserving type )    as overDue,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'rhcur'
      cast(
        case
          when Acc.netdt <= KeyDate.Date1
            then Acc.hsl
          else 0
        end as ztrain_de_currentdue preserving type ) as currentDue,

      Acc.rhcur,

      $parameters.i_key_date                          as keyDate,
      Acc.budat,
      Acc.netdt,
      Acc.augdt,
      KeyDate.Date1,
      $parameters.i_koart                             as koart,

      _Partner,
      _Company
}
where
       Acc.koart = $parameters.i_koart
  and  Acc.budat <= $parameters.i_key_date
  and(
       Acc.augdt = '00000000'
    or Acc.augdt > $parameters.i_key_date
  )
