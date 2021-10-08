class ZCLIM_INBOX_PO definition
  public
  final
  create public .

public section.

  interfaces /IWWRK/IF_TGW_CUSTOM_ATTR .
  interfaces IF_BADI_INTERFACE .
protected section.
private section.
ENDCLASS.



CLASS ZCLIM_INBOX_PO IMPLEMENTATION.


  method /IWWRK/IF_TGW_CUSTOM_ATTR~PROVIDE_ATTRIBUTE_DATA.
  endmethod.


  method /IWWRK/IF_TGW_CUSTOM_ATTR~PROVIDE_ATTRIBUTE_DEFINITION.
  endmethod.
ENDCLASS.
