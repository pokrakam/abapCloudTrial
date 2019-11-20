CLASS zcl_mp_web02 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: html TYPE REF TO lcl_html,
          form_data TYPE if_web_http_request=>name_value_pairs.
    METHODS generate_page_body.
    METHODS generate_new_question.
    METHODS check_answer.
ENDCLASS.



CLASS zcl_mp_web02 IMPLEMENTATION.

  METHOD if_http_service_extension~handle_request.
    html = NEW lcl_html( ).
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

    IF answer is initial.
      generate_new_question( ).
    ELSE.
      check_answer( ).
    ENDIF.
  ENDMETHOD.

  METHOD generate_new_question.
    html->add( '<form method="get">' ).
    html->add( '<table><tr><td>' ).
    html->add( |<input type=number name=n1 value=3 hidden=true>| ).
    html->add( |<input type=number name=n2 value=7 hidden=true>| ).
    html->add( |What is 3 * 7?<input type=number name=answer>| ).
    html->add( |<input type="submit" value="Submit">| ).
    html->add( `<td>` ).
    html->add( `</td></tr></table>` ).
    html->add( `</form>` ).
  ENDMETHOD.

  METHOD check_answer.
    DATA(n1) = VALUE i( form_data[ name = `n1` ]-value OPTIONAL ).
    DATA(n2) = VALUE i( form_data[ name = `n2` ]-value OPTIONAL ).

    IF n1 * n2 = VALUE i( form_data[ name = `answer` ]-value ).
      html->add( `Yay!! \(ˆ˚ˆ)/` ).
      html->add( |<image src=https://media.giphy.com/media/fsULJFFGv8X3G/giphy.gif>| ).
    ELSE.
      html->add( |Not quite close enough, { n1 } * {  n2 } is { n1 * n2 }| ).
      html->add( |<image src=https://media.giphy.com/media/LYd7VuYqXokv20CaEG/giphy.gif| ).
    ENDIF.
    html->add( '<form method="get">' ).
    html->add( |<input type="submit" value="Try another">| ).

    html->add( `</form>` ).

  ENDMETHOD.

ENDCLASS.
