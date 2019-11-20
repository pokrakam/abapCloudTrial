CLASS lcl_html DEFINITION.

  PUBLIC SECTION.
    METHODS add IMPORTING i_line TYPE clike.
    METHODS constructor.
    METHODS finish.
    METHODS render RETURNING VALUE(result) TYPE string.

  PRIVATE SECTION.
    DATA: html TYPE string.

ENDCLASS.

CLASS lcl_html IMPLEMENTATION.

  METHOD constructor.
    add( `<!DOCTYPE html>`                                                         ).
    add( `<html>`                                                                  ).
    add( `  <head>`                                                                ).
    add( `    <title>Mike's Test</title>`                                          ).
    add( `    <style>body { font-family: sans-serif; }</style>`                    ).
    add( `    <meta http-equiv="X-UA-Compatible" content="IE=edge">`               ).
    add( `    <meta http-equiv='Content-Type' content='text/html;charset=UTF-8'/>` ).
    add( `  </head>`                                                               ).
    add( `  <body>`                                                                ).
  ENDMETHOD.

  METHOD add.
    html = html && i_line && cl_abap_char_utilities=>newline.
  ENDMETHOD.

  METHOD render.
    result = html.
  ENDMETHOD.

  METHOD finish.
    add( `  </body>` ).
    add( `</html>` ).
  ENDMETHOD.

ENDCLASS.
