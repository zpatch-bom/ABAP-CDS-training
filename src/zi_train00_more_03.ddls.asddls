/*---------------------------------------------------------------------*
*& Data Definition: ZI_TRAIN00_MORE_03
*&---------------------------------------------------------------------*
*&  String
*&--------------------------------------------------------------------*/

@AbapCatalog.sqlViewName: 'ZITRAIN00MORE03'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Training - String Functions'

define view ZI_Train00_More_03
  as select from ZI_Train00_Annotations_01 as MDOC
{
  key MDOC.mjahr,
  key MDOC.mblnr,
  key MDOC.zeile,

      MDOC.matnr,

      @EndUserText.label: 'LENGTH'
      length( MDOC.matnr )                           as slength,

      @EndUserText.label: 'LTRIM'
      ltrim( MDOC.matnr, '0' )                       as sltrim,

      @EndUserText.label: 'LENGTH+LTRIM'
      length( ltrim( MDOC.matnr, '0' ) )             as slength_ltrim,

      @EndUserText.label: 'RPAD'
      rpad( MDOC.matnr, 20, '0' )                    as srpad,

      @EndUserText.label: 'LEFT'
      left( MDOC.matnr, 10 )                         as sleft,

      @EndUserText.label: 'RIGHT'
      right( MDOC.matnr, 8 )                         as sright,

      @EndUserText.label: 'SUBSTRING'
      substring( MDOC.matnr, 10, 1 )                 as ssubstring,

      @EndUserText.label: 'CONCAT'
      concat( MDOC.mblnr, MDOC.mjahr )               as sconcat,

      @EndUserText.label: 'CONCAT_WITH_SPACE'
      concat_with_space( MDOC.mblnr, MDOC.mjahr, 1 ) as sconcat_wspace,

      @EndUserText.label: 'REPLACE'
      replace( MDOC.matnr, '0', '.')                 as sreplace,

      MDOC.bktxt,

      @EndUserText.label: 'UPPER'
      upper( MDOC.bktxt )                            as supper,

      @EndUserText.label: 'LOWER'
      lower( MDOC.bktxt )                            as slower,

      MDOC.bukrs,
      MDOC.budat
}
