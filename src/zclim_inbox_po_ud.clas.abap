class ZCLIM_INBOX_PO_UD definition
  public
  final
  create public .

public section.

  interfaces /IWPGW/IF_TGW_USER_DETAIL .
  interfaces IF_BADI_INTERFACE .
protected section.
private section.
ENDCLASS.



CLASS ZCLIM_INBOX_PO_UD IMPLEMENTATION.


  method /IWPGW/IF_TGW_USER_DETAIL~GET_USER_PICTURE_STREAM.
  endmethod.


  METHOD /iwpgw/if_tgw_user_detail~read_user_details_by_context.
  ENDMETHOD.
ENDCLASS.
