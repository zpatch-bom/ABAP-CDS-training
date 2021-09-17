/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_BASIC_04
*&---------------------------------------------------------------------*
*& LEFT JOIN
*& NULL, NOT NULL
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00BASIC04'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Training - Null, Not Null'

define view ZI_TRAIN00_BASIC_04
  as select from    ZI_Train00_Basic_01 as CC //(A)

    inner join      adrc                as Address on  Address.addrnumber = CC.adrnr
                                                   and Address.nation     = 'T'
                                                   and Address.date_from  <= $session.system_date
                                                   and Address.date_to    >= $session.system_date

    left outer join zttrain000100       as Exclude on Exclude.bukrs = CC.bukrs //(B)
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
where
  Exclude.bukrs is null     //  (A)-(B): CCode must NOT exists in ZTTRAIN000100
//Exclude.bukrs is not null //  (A)&(B): the results are the same as INNER JOIN
