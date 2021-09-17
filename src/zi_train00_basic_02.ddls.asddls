/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_BASIC_02
*&---------------------------------------------------------------------*
*& INNER JOIN
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00BASIC02'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Training - Inner Join'

define view ZI_Train00_Basic_02
  as select from    ZI_Train00_Basic_01 as CC

    inner join      adrc                as Address on  Address.addrnumber = CC.adrnr
                                                   and Address.nation     = 'T'
                                                   and Address.date_from  <= $session.system_date
                                                   and Address.date_to    >= $session.system_date

{
  key CC.bukrs,
      CC.adrnr,
      Address.name1,
      Address.name2,
      Address.street,
      Address.location,
      Address.city2,
      Address.city1
}



