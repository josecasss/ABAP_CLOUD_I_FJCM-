CLASS zcl_04_field_symbols_fjcm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_04_field_symbols_fjcm IMPLEMENTATION. "Apuntadores que apuntan a la memoria con alias *Variables, estructuras, tablas


  METHOD if_oo_adt_classrun~main.

***Alias temporal para datos simples o estructuras, incluso líneas de tablas.
***VARIABLES

*    DATA: gv_employee TYPE string.
*
**   FIELD-SYMBOLS <fs_employee> TYPE string. "Vieja syntaxis
*
*    gv_employee = 'Freddy'.
*
*    ASSIGN gv_employee TO FIELD-SYMBOL(<fs_employee>). " Forma moderna y declaracion en linea
*
*    out->write( <fs_employee> ).
*
*    <fs_employee> = 'Laura'.
*
*    out->write( <fs_employee> ).


*TABLAS INTERNAS

    SELECT FROM /dmo/flight
    FIELDS *
     WHERE carrier_id = 'AA'
     INTO TABLE @DATA(lt_flights).

*    out->write( lt_flights ).
*
     " LOOP = RECORRE TODA LA TABLA
*    "SIEMPRE QUE SE LEA O SE HAGA UNA LECTURA MEJOR PRATICA USAR FIELD SYMBOLS
*
*    LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<fs_flights>). "Leer toda la tabla en una field symbol
*
*      "MODIFICAR DATOS *Ver tablas internas clase
*
*      <fs_flights>-flight_date = cl_abap_context_info=>get_system_date( ).
*      <fs_flights>-currency_code = 'EUR'.
*
*      out->write( |flight: { <fs_flights>-carrier_id }-{ <fs_flights>-connection_id }| ).
*
*    ENDLOOP.
*
*    out->write( lt_flights ).

    "Añdir registros a un field symbols

*    APPEND INITIAL LINE TO lt_flights ASSIGNING FIELD-SYMBOL(<fs_flights>). "Linea inicial vacia de primera
*
*    IF <fs_flights> IS ASSIGNED. "Validacion
*
*      out->write( <fs_flights> ).
*
**      UNASSIGN <fs_flights>. "Asi libero memoria
*
*    ENDIF.

*    "Isertar registros a un field symbols

*    INSERT INITIAL LINE INTO lt_flights ASSIGNING FIELD-SYMBOL(<fs_flights>) INDEX 1. " Para insertar un registro en el index especificado
*
*    IF <fs_flights> IS ASSIGNED. "Validacion
*
*      <fs_flights> = VALUE #( carrier_id = 'MX'
*                              connection_id = '0002'
*                              flight_date = '20250320'
*                              price = '3000'
*                              currency_code = 'MXN' ).
*
*      out->write( <fs_flights> ).
*
*    ELSE.
*
*      out->write( 'Field symbol UNASSIGNED' ).
*
*    ENDIF.

" Leer tabla

*    READ TABLE lt_flights ASSIGNING FIELD-SYMBOL(<fs_flights>) INDEX 1.
*
*    out->write( <fs_flights> ).
*
*    <fs_flights>-carrier_id = 'MX'.
*    <fs_flights>-currency_code = 'MXN'.
*
*    out->write( <fs_flights> ).
*
*    UNASSIGN <fs_flights>.

    TYPES: BEGIN OF ty_date,
             day   TYPE n LENGTH 2,
             month TYPE n LENGTH 2,
             year  TYPE n LENGTH 4,
           END OF ty_date.

    DATA: lv_date     TYPE d.

*     Implicit casting of date type to a field symbol
    FIELD-SYMBOLS: <lv_date>  TYPE d,
                   <lv_date2> TYPE any,
                   <lv_date3> TYPE n.

    lv_date = cl_abap_context_info=>get_system_date( ).
    lv_date = lv_date+6(2) && lv_date+4(2) && lv_date+0(4).

    ASSIGN lv_date TO <lv_date>.
    out->write( |Today's Date: { <lv_date> }| ).

    ASSIGN lv_date TO <lv_date2> CASTING TYPE ty_date.


    DO.

      ASSIGN COMPONENT sy-index OF STRUCTURE <lv_date2> TO <lv_date3>.

      IF sy-subrc <> 0.

        EXIT.

      ENDIF.

      out->write( |Today's Date: { <lv_date3> }| ).

    ENDDO.

  ENDMETHOD.

ENDCLASS.
