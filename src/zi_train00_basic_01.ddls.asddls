/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_BASIC_01
*&---------------------------------------------------------------------*
*&  Naming Convention
*&  Z[A]_[BB][CC]_[Description]
*&  A:
*&    P - Private (optional)
*&        - Internal calculation
*&    I - Interface/Basic (mandatory)***
*&        - Reusable
*&        - Cube, Dimension, Fact (BI/BW)
*&        - Contains calculation fields
*&        - Contains JOIN condition
*&        - Consumed by another ABAP CDS View, OpenSQL
*&        - Expose to OData service as API
*&    C - Consumption (optional)
*&        - Query(BI/BW)
*&        - Contains UI annotations
*&        - No calculation field
*&        - Consumed by OpenSQL, ALV IDA, Fiori apps (OData with UI)
*&        - Expose to OData service with UI annotations
*&  BB: Module ([FI],[SD],[MM],...)
*&  CC: Sub-module (FI-[AA,AR,AP,GL,...],MM-[PU,IM],...)
*&--------------------------------------------------------------------*/

/*
  This is
  Multiple lines comment
*/

// This is Single line comment

@AbapCatalog.sqlViewName: 'ZITRAIN00BASIC01'  //SQL Name
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Training - Simple ABAP CDS View'

define view ZI_Train00_Basic_01 //CDS Entity
  as select from t001 as CC
{
  key CC.bukrs,
      CC.butxt,
      CC.ort01,
      CC.land1,
      CC.waers,
      CC.spras,
      CC.ktopl,
      CC.adrnr
}
where
  CC.f_obsolete = ''
