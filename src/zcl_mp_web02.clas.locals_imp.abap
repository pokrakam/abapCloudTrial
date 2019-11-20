

CLASS lcl_html IMPLEMENTATION.

  METHOD initialize.
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

  METHOD add_row.
    add( `<tr><td>` && i_line && `</td></tr>` ).
  ENDMETHOD.

  METHOD render.
    result = html.
  ENDMETHOD.

  METHOD add_closing_tags.
    add( `  </body>` ).
    add( `</html>` ).
  ENDMETHOD.

ENDCLASS.
