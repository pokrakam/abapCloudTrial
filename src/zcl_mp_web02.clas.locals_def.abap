CLASS lcl_html DEFINITION.

  PUBLIC SECTION.
    METHODS add IMPORTING i_line TYPE clike.
    METHODS add_row IMPORTING i_line TYPE clike.

    METHODS initialize.
    METHODS add_closing_tags.
    METHODS render RETURNING VALUE(result) TYPE string.

  PRIVATE SECTION.
    DATA: html TYPE string.

ENDCLASS.
