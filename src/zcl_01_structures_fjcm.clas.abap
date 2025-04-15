CLASS zcl_01_structures_fjcm DEFINITION
PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_01_structures_fjcm IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    DATA: BEGIN OF ls_empl_info,
*            BEGIN OF info,
*              id         TYPE i VALUE 123456,
*              first_name TYPE string VALUE `Laura`,
*              last_name  TYPE string VALUE `Martínez`,
*            END OF info,
*            BEGIN OF address,
*              city    TYPE string VALUE `Frankfurt`,
*              street  TYPE string VALUE `123 Main street`,
*              country TYPE string VALUE `Germany`,
*            END OF address,
*            BEGIN OF position,
*              department TYPE string VALUE `IT`,
*              salary     TYPE p DECIMALS 2 VALUE `2000.25`,
*            END OF position,
*          END OF ls_empl_info.
*
*    out->write( data = ls_empl_info name = `ls_empl_info` ).

    TYPES: BEGIN OF lty_flights,
             flight_date   TYPE /dmo/flight-flight_date,
             price         TYPE /dmo/flight-price,
             currency_code TYPE /dmo/flight-currency_code,
           END OF lty_flights.

    DATA: BEGIN OF ls_flight,
            carrier    TYPE /dmo/flight-carrier_id VALUE 'AA',
            connid     TYPE /dmo/flight-connection_id VALUE '0018',
            lt_flights TYPE TABLE OF lty_flights WITH EMPTY KEY,
          END OF ls_flight.

    SELECT *
     FROM /dmo/flight
     WHERE carrier_id = 'AA'
     INTO CORRESPONDING FIELDS OF TABLE @ls_flight-lt_flights
     UP TO 4 ROWS.

    out->write( data = ls_flight name = `ls_flight` ).

    SELECT FROM /DMO/I_Flight
    FIELDS AVG( DISTINCT MaximumSeats ) AS AvgSeats,
           SUM( DISTINCT MaximumSeats ) AS SumSeats
    WHERE AirlineID = 'AA'
      INTO ( @DATA(lv_avgseats), @DATA(lv_sumseats) ).


  ENDMETHOD.

ENDCLASS.
