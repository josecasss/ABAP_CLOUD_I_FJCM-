CLASS zcl_07_performance_fjcm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_07_performance_fjcm IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_total,
             price    TYPE /dmo/flight_price,
             seatsocc TYPE /dmo/plane_seats_occupied,
           END OF ty_total.

    DATA: lt_flights TYPE TABLE OF /dmo/flight.

    SELECT FROM /dmo/flight
    FIELDS *
    INTO TABLE @lt_flights.

"Reduce para sumar campos numericos  *REEMPLAZO DE COLLECT"
    DATA(lv_sum) = REDUCE i( INIT lv_result = 0  "Acumulador que lo iniciare en 0
                             FOR ls_flight IN lt_flights  "Bucle implicito, como si fuera un LOOP AT
                             NEXT lv_result += ls_flight-price ). " ASIGNAR Lv_result que es mi acumulador se sumara con los campos de ls_flight. Sumara los campos price

    out->write( |Sum of Price: { lv_sum }| ).

    DATA(ls_totals) = REDUCE ty_total( INIT ls_total TYPE ty_total "Aca trabajamos con la estructura ya declarada
                                       FOR ls_flight2 IN lt_flights WHERE ( carrier_id = 'AA' ) "Aca solo hace loop evaluando solo carrierid 'AA'
                                       NEXT ls_total-price += ls_flight2-price " Acumular el valor del campo price acumuado en la estructura declarada ls_total
                                            ls_total-seatsocc += ls_flight2-seats_occupied ). " Acumular el valor del campo seats occupied acumuado en la estructura declarada ls_total

    out->write( |Sum of Price and Seats OCC:| ).
    out->write( ls_totals ).

  ENDMETHOD.

ENDCLASS.
