CLASS zcl_mp_web01 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_http_service_extension .
ENDCLASS.



CLASS ZCL_MP_WEB01 IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA(html) = NEW lcl_html( ).
    html->add( `Hello World!` ).
    html->finish( ).

    response->set_text(  html->render( ) ).

  ENDMETHOD.
ENDCLASS.
