/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_BASIC_03
*&---------------------------------------------------------------------*
*& LEFT JOIN
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00BASIC03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Training - Left Join'

define view ZI_Train00_Basic_03
  as select from    ZI_Train00_Basic_01 as CC

    left outer join adrc                as Address on  Address.addrnumber = CC.adrnr
                                                   and Address.nation     = 'T'
                                                   and Address.date_from  <= $session.system_date
                                                   and Address.date_to    >= $session.system_date
                                                   and CC.spras           = '2'

{
  key CC.bukrs,
      CC.spras,
      CC.adrnr,
      Address.name1,
      Address.name2,
      Address.street,
      Address.location,
      Address.city2,
      Address.city1
}
//where
//  CC.spras = '2'  // Cannot put here (for this requirement)
