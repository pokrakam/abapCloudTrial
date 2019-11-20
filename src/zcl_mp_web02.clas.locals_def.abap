CLASS lcl_html DEFINITION.

  PUBLIC SECTION.
    METHODS add IMPORTING i_line TYPE clike.
    METHODS constructor.
    METHODS add_closing_tags.
    METHODS render RETURNING VALUE(result) TYPE string.

  PRIVATE SECTION.
    DATA: html TYPE string.

ENDCLASS.
