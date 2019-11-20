CLASS zcl_mp_hello DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.



CLASS zcl_mp_hello IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA(d) = `Foo`.
    DATA(n) = `Bar`.
    DATA(in) = out->get(
           data = d
           name = n
         ).
    out->write( in ).
    out->write( `Hello World!` ).
  ENDMETHOD.

ENDCLASS.
