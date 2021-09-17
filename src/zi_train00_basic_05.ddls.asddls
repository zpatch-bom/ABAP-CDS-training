/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_BASIC_05
*&---------------------------------------------------------------------*
*& Literals
*&--------------------------------------------------------------------*/


@AbapCatalog.sqlViewName: 'ZITRAIN00BASIC05'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Training - Literals'

define view ZI_Train00_Basic_05
  as select from ZI_Train00_Basic_02 as CC
{
  key CC.bukrs,
      CC.name1,
      CC.street,
      CC.location,
      CC.city2,
      CC.city1,
      'CCode'     as fixed_txt1,
      '0100'      as fixed_txt2,
      1           as fixed_int1,
      -9          as fixed_int2,
      0.7         as fixed_dec1,
      #koart.D    as koart,
      #land1.'TH' as land1
}
