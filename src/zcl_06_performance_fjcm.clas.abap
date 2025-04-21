CLASS zcl_06_performance_fjcm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_06_performance_fjcm IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    TYPES ty_flights TYPE STANDARD TABLE OF /dmo/flight
                      WITH NON-UNIQUE KEY carrier_id connection_id flight_date. "Todos estos campos KEY primaria

    DATA: lt_flights TYPE ty_flights.

    lt_flights = VALUE #( ( client = sy-mandt
                            carrier_id = 'CO'
                            connection_id = '0500'
                            flight_date = '20250201'
                            plane_type_id = '123-456'
                            price = '1000'
                            currency_code = 'COP' )
                            ( client = sy-mandt
                            carrier_id = 'MX'
                            connection_id = '0600'
                            flight_date = '20250120'
                            plane_type_id = '747-400'
                            price = '800'
                            currency_code = 'MXN' )
                            ( client = sy-mandt
                            carrier_id = 'QF'
                            connection_id = '0006'
                            flight_date = '20230112'
                            plane_type_id = 'A380'
                            price = '1600'
                            currency_code = 'AUD' )
                            ( client = sy-mandt
                            carrier_id = 'SP'
                            connection_id = '0700'
                            flight_date = '20250610'
                            plane_type_id = '321-654'
                            price = '100'
                            currency_code = 'EUR' )
                            ( client = sy-mandt
                            carrier_id = 'LX'
                            connection_id = '0900'
                            flight_date = '20250101'
                            plane_type_id = '258-963'
                            price = '50'
                            currency_code = 'COP' )
                            ( client = sy-mandt
                            carrier_id = 'CO'
                            connection_id = '0500'
                            flight_date = '20250204'
                            plane_type_id = '123-456'
                            price = '3000'
                            currency_code = 'COP' )  ).

    out->write( 'Before sort' ).
    out->write( lt_flights ).
    out->write( lines( lt_flights ) ). "Para numero de lineas lines()

***    " Sort with primary key
*    SORT lt_flights.
*    out->write( 'Sort by Primary key' ). "Carrier ID, Connection ID y Flight date son mis llaves primarias
*    out->write( lt_flights ). " Jerarquia de KEY por orden de declaramiento, Carrier ID primero
**
***    " Sort by any fields
*    SORT lt_flights BY currency_code plane_type_id. "Especificando campo
*    out->write( 'Sort by any field' ).
*    out->write( lt_flights ).
**
***    " Sort by any field - ascending and descending
*    SORT lt_flights BY carrier_id ASCENDING flight_date DESCENDING. "Ordenandolo de forma ascendiente o descendiente segun el requerimiento
*    out->write( 'Sort by any field - ASC & DES' ).
*    out->write( lt_flights ).

* Delete records
    DELETE ADJACENT DUPLICATES FROM lt_flights.
    out->write( lines( lt_flights ) ).

*    SORT lt_flights BY carrier_id connection_id.
**    DELETE ADJACENT DUPLICATES FROM lt_flights COMPARING carrier_id connection_id.
*    DELETE ADJACENT DUPLICATES FROM lt_flights COMPARING ALL FIELDS.
*    out->write( 'After sort' ).
*    out->write( lt_flights ).
*    out->write( lines( lt_flights ) ).

  ENDMETHOD.

ENDCLASS.
