CLASS zcl_mp_web02 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_http_service_extension .
    METHODS constructor.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: html      TYPE REF TO lcl_html,
          form_data TYPE if_web_http_request=>name_value_pairs,
          random    TYPE REF TO cl_abap_random_int.
    METHODS generate_page_body.
    METHODS generate_new_question.
    METHODS check_answer.
    METHODS show_gif
      RETURNING
        VALUE(r_result) TYPE abap_bool.
ENDCLASS.



CLASS zcl_mp_web02 IMPLEMENTATION.

  METHOD constructor.
    random = cl_abap_random_int=>create( min = 0 max = 10 seed = cl_abap_random=>seed( ) ).
  ENDMETHOD.

  METHOD if_http_service_extension~handle_request.
    html = NEW lcl_html( ).
    html->initialize( ).
    TRY.
        form_data = request->get_form_fields( ).
        generate_page_body( ).

      CATCH cx_web_message_error INTO DATA(error).
        html->add( error->get_text( ) ).
    ENDTRY.

    html->add_closing_tags( ).
    response->set_text(  html->render( ) ).
  ENDMETHOD.

  METHOD generate_page_body.
    DATA(answer) = VALUE #( form_data[ name = `answer` ]-value OPTIONAL ).

    IF answer IS INITIAL.
      generate_new_question( ).
    ELSE.
      check_answer( ).
    ENDIF.
  ENDMETHOD.

  METHOD generate_new_question.
    DATA(n1) = random->get_next( ).
    DATA(n2) = random->get_next( ).
    html->add( `<form method="get">` ).
    html->add( `<table><tr>` ).
    html->add( |<input type=number name=n1 value={ n1 } hidden=true>| ).
    html->add( |<input type=number name=n2 value={ n2 } hidden=true>| ).
    html->add( |<td>What is { n1 } * { n2 }?</td>| ).
    html->add( |<td><input type=number name=answer></td>| ).
    html->add( |<td><input type="submit" value="Submit"></td>| ).
    html->add( `</tr></table>` ).
    html->add( `</form>` ).
  ENDMETHOD.

  METHOD check_answer.
    DATA(n1) = VALUE i( form_data[ name = `n1` ]-value OPTIONAL ).
    DATA(n2) = VALUE i( form_data[ name = `n2` ]-value OPTIONAL ).

    html->add( |<table>| ).

    IF n1 * n2 = VALUE i( form_data[ name = `answer` ]-value ).
      html->add_row( |Yay!! \\(ˆ˚ˆ)/| ).
      IF show_gif( ).
        html->add_row( |<image src=https://media.giphy.com/media/fsULJFFGv8X3G/giphy.gif>| ).
      ENDIF.
    ELSE.
      IF show_gif( ).
        html->add_row( |Close, but not quite close enough, { n1 } * {  n2 } is { n1 * n2 }| ).
        html->add_row( |<image src=https://media.giphy.com/media/LYd7VuYqXokv20CaEG/giphy.gif>| ).
      ELSE.
        html->add_row( |Not quite, { n1 } * {  n2 } is { n1 * n2 }| ).
      ENDIF.
    ENDIF.
    html->add( '<form method="get">' ).
    html->add_row( |<input type="submit" value="Try another">| ).
    html->add( `</form>` ).
    html->add( |</table>| ).
  ENDMETHOD.

  METHOD show_gif.
    IF random->get_next( ) < 3.
      r_result = abap_true.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
