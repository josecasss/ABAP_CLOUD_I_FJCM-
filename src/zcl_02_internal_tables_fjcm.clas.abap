CLASS zcl_02_internal_tables_fjcm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF ty_employee,
             id     TYPE i,
             email  TYPE string,
             ape1   TYPE string,
             ape2   TYPE string,
             name   TYPE string,
             fechan TYPE d,
             fechaa TYPE d,
           END OF ty_employee,

           BEGIN OF ty_flights,
             iduser(40) TYPE c,
             aircode    TYPE /dmo/carrier_id,
             flightnum  TYPE /dmo/connection_id,
             key        TYPE land1,
             seat       TYPE /dmo/plane_seats_occupied,
             flightdate TYPE /dmo/flight_date,
           END OF ty_flights,

           BEGIN OF ty_airlines,
             carrier_id      TYPE /dmo/carrier_id,
             connection_id   TYPE /dmo/connection_id,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
           END OF ty_airlines,

           BEGIN OF ty_seats,
             carrier_id    TYPE /dmo/carrier_id,
             connection_id TYPE /dmo/connection_id,
             seats         TYPE /dmo/plane_seats_occupied,
             bookings      TYPE /dmo/flight_price,
           END OF ty_seats,
********************************************************************
           BEGIN OF ty_range,
             sign(1)   TYPE c,
             option(2) TYPE c,
             low       TYPE i,
             high      TYPE i,
           END OF ty_range.

    TYPES: ty_currency TYPE c LENGTH 8,
           BEGIN OF ENUM mty_currency BASE TYPE ty_currency,
             c_initial VALUE IS INITIAL, "0
             c_dollar  VALUE 'USD',      "1
             c_euros   VALUE 'EUR',      "2
             c_colpeso VALUE 'COP',      "3
             c_mexpeso VALUE 'MEX',      "4
           END OF ENUM mty_currency.

    DATA: mt_employees    TYPE TABLE OF ty_employee,
          mt_employees_2  TYPE TABLE OF ty_employee,
          ms_employee     TYPE ty_employee,
          mt_spfli        TYPE TABLE OF /dmo/connection,
          ms_spfli        TYPE /dmo/connection,
          ms_spfli_2      TYPE /dmo/connection,
          mt_airlines     TYPE STANDARD TABLE OF /dmo/connection,
          mt_flights_type TYPE STANDARD TABLE OF /dmo/flight,
          mt_scarr        TYPE STANDARD TABLE OF /dmo/carrier.

    DATA gr_range TYPE ty_range.

    DATA mt_airlines2 TYPE STANDARD TABLE OF ty_airlines.

    METHODS:
      add_records IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      insert_record IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      append_records IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      corresponding_example IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      read_table_with_key IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      check_records IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      get_record_index IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      loop_example IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.


    METHODS add_flights_with_for IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS nested_for IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS add_multiple_lines IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS sort_records IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS modify_records IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS delete_records IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS clear_free_memory IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS collect_records IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS use_let IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS use_base IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS group_records IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS use_range_tables IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS use_enumerations IMPORTING ir_out TYPE REF TO if_oo_adt_classrun_out.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_02_internal_tables_fjcm IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

**    Add records
*    add_records( out ).
*
**    Insert records
*    insert_record( out ).
*
**    Adding records with append
*    append_records( out ).
*
*    Corresponding
*    corresponding_example( out ).
*
*    Read table with key
*    read_table_with_key( out ).
*
*    Checking records
*    check_records( out ).
*
*    Index of a record
*    get_record_index( out ).
*
*    Loop statement
*    loop_example( out ).
*
*******************Second part**************************************************
*   For
*   add_flights_with_for( out ).
*
*   For nested
*    nested_for( out ).
*
*    Add multiple lines (select)
*    add_multiple_lines( out ).
*
*    Sort records
*    sort_records( out ).
*
*    Modify records
*    modify_records( out ).
*
*    Delete records
*    delete_records( out ).
*
*    Clear / free
*    clear_free_memory( out ).
*
*    Collect statement
*    collect_records( out ).
*
*    Let instruction
*    use_let( out ).

*    Base instruction
*    use_base( out ).
*
*    Grouping of records
    group_records( out ).

*    Range tables
*    use_range_tables( out ).
*
*    Enumerations
*    use_enumerations( out ).

  ENDMETHOD.

  METHOD add_flights_with_for.

    DATA: "ls_flight       TYPE ty_flights,
          lt_flights      TYPE STANDARD TABLE OF ty_flights,
          lt_flights_info TYPE STANDARD TABLE OF ty_flights.

    lt_flights = VALUE #( FOR i = 1 UNTIL i > 15 "Ciclo FOR
                          ( iduser     = |User{ i }|
                            aircode    = 'SQ'
                            flightnum  =  0000 + i
                            key        = | US |
                            seat       =   0 + i
                            flightdate =   cl_abap_context_info=>get_system_date( ) ) ).

    ir_out->write( lt_flights ).


" NOTACION VIEJA
*    LOOP AT lt_flights INTO ls_flight.
*      ls_flight-aircode = 'CL'.
*      ls_flight-flightnum = ls_flight-flightnum + 10.
*      ls_flight-key = 'COP'.
*      APPEND ls_flight TO lt_flights_info.
*    ENDLOOP.

"NOTACION NUEVA llenar itab
    lt_flights_info = VALUE #( FOR ls_flight IN lt_flights (  "ls_flight estructura temporal, tomando referencia de lt_flights
                               iduser     = ls_flight-iduser
                               aircode    = 'CL'
                               flightnum  = ls_flight-flightnum + 10
                               key        = 'COP'
                               seat       = ls_flight-seat
                               flightdate = ls_flight-flightdate ) ).

    ir_out->write( data = lt_flights_info name = 'For Table' ).

  ENDMETHOD.


  METHOD add_multiple_lines.

   "Consulta con varios campos TRAE TODAS LAS COINCIDENCIAS CON ESA CLAVE
    SELECT carrier_id, connection_id, airport_from_id, airport_to_id
      FROM /dmo/connection
      WHERE airport_from_id = 'FRA'
      INTO TABLE @mt_airlines2.

    ir_out->write( data = mt_airlines2 name = 'Multiple lines' ).

  ENDMETHOD.


  METHOD add_records.

  " Este método agrega registros a la tabla interna.
  " Utiliza la construcción VALUE #( ) para inicializar la tabla con un conjunto de datos.
  " Este método sobrescribe cualquier dato anterior si la tabla es reasignada con VALUE #( )

    me->mt_employees = VALUE #( ( id     = 1
                                  email  = 'emp1@logali.com'
                                  ape1   = 'perez'
                                  ape2   = 'gomez'
                                  name   = 'juan'
                                  fechan = '19900101'
                                  fechaa = '20220101' ) ).

    me->ms_employee-id = 2.
    me->ms_employee-email = 'emp2@logali.com'.
    me->ms_employee-ape1 = 'lopez'.
    me->ms_employee-ape2 = 'martinez'.
    me->ms_employee-name = 'ana'.
    me->ms_employee-fechan = '19920202'.
    me->ms_employee-fechaa = '20220202'.
    APPEND me->ms_employee TO me->mt_employees.


    io_out->write(  data = me->mt_employees name = '*Add records*'  ).

  ENDMETHOD.


  METHOD append_records.

   "VALUE # para inicializar la tabla
    me->ms_employee = VALUE #( id = 5
                                  email = 'emp5@logali.com'
                                  ape1 = 'torres'
                                  ape2 = 'ruiz'
                                  name = 'carlos'
                                  fechan = '19950505'
                                  fechaa = '20220505' ).

    APPEND me->ms_employee TO me->mt_employees_2.

*     adding a record a me->mt_employees_2 using append value
    APPEND VALUE #( id = 6   "APPEND VALUE es para agregar un registro sin sobreescribir
                    email = 'emp6@logali.com'
                    ape1 = 'hernandez'
                    ape2 = 'jimenez'
                    name = 'laura'
                    fechan = '19960606'
                    fechaa = '20220606' ) TO me->mt_employees_2.

*     adding lines from me->mt_employees a me->mt_employees_2
    APPEND LINES OF me->mt_employees FROM 2 TO 3 TO me->mt_employees_2. "Añadir lineas de itab a otra itab

    io_out->write( data = me->mt_employees_2 name = 'Add records with append lines' ).

  ENDMETHOD.


  METHOD check_records.

*     flight consultation with connection_id older 0400
    SELECT * FROM /dmo/connection WHERE connection_id >= '0400' INTO TABLE @me->mt_spfli.
    io_out->write( data = me->mt_spfli name = 'flight consultation with connection_id older 0400' ).

   "NUEVA NOTACION
*     check if the flight exists 0407
    IF line_exists( me->mt_spfli[ connection_id = '0407' ] ).
      io_out->write( |Flight 0407 exists| ).
    ELSE.
      io_out->write( |Flight 0407 does not exist| ).
    ENDIF.

   " VIEJA NOTACION"
*    read table me->mt_spfli TRANSPORTING NO FIELDS with key connection_id = '0407'.
*
*    if sy-subrc = 0.
*
*    si existe
*
*    else.
*     no existe
*    endif.

  ENDMETHOD.


  METHOD clear_free_memory.

    SELECT * FROM /dmo/connection WHERE carrier_id = 'SQ' INTO TABLE @mt_airlines.

    CLEAR mt_airlines.   "CLEAR Vacia la tabla pero sigue en memoria *Pa variables

    SELECT * FROM /dmo/connection WHERE carrier_id = 'SQ' INTO TABLE @mt_airlines.

    FREE mt_airlines.    " FREE Elimina la tabla por completo para liberar memoria *Pa tablas internas

  ENDMETHOD.


  METHOD collect_records. "AGRUPA valores numericos para un registro, para evitar duplicados

    DATA: lt_seats   TYPE HASHED TABLE OF ty_seats WITH UNIQUE KEY carrier_id connection_id,
          lt_seats_2 TYPE STANDARD TABLE OF ty_seats.

    SELECT DISTINCT carrier_id, connection_id, seats_occupied AS seats, price AS bookings
      FROM /dmo/flight
      WHERE seats_max = '140'
      INTO TABLE @lt_seats.

    ir_out->write( data = lt_seats name = 'lt_seats antes del collect' ).

    SELECT carrier_id, connection_id, seats_occupied AS seats, price AS bookings
      FROM /dmo/flight
      INTO TABLE @lt_seats_2.

    ir_out->write( data = lt_seats_2 name = 'lt_seats_2 ' ).

    LOOP AT lt_seats_2 INTO DATA(ls_seat). "Recorre lt_seats_2 en esa estructura y luego sumariza iguales
      COLLECT ls_seat INTO lt_seats.
    ENDLOOP.
 "En este caso sumo los registros repetidos de ambas tablas, sumando los asientos y bookings.
    ir_out->write( data = lt_seats name = 'Collect table' ).

  ENDMETHOD.


  METHOD corresponding_example.

*   using move-corresponding to move data between structures
    SELECT * FROM /dmo/connection
        WHERE carrier_id = 'LH'
        INTO TABLE @mt_spfli.
*SYNTAXIS ANTIGUA DE LEER TABLA
    READ TABLE mt_spfli INTO me->ms_spfli INDEX 2. "Segundo registo en la estructura ms_
*SYNTAXIS NUEVA PERO LEVANTA EXCEPCION
    DATA(ls_airport_to) = me->mt_spfli[ 1 ]. "Itab index 1, registro 1
    DATA(lv_airport_to) = me->mt_spfli[ 1 ]-airport_from_id. "Forma moderno de leer moderna con indice y levanta excepciones si esta vacia *CATCH*

*    MOVE-CORRESPONDING me->ms_spfli TO me->ms_spfli_2. "Syntaxis VIEJA

    me->ms_spfli_2 = CORRESPONDING #( me->ms_spfli ).   "Syntaxis NUEVA "Mover registros de una structura-structura o itab-itab

    io_out->write( data = me->ms_spfli_2 name = 'Add records using move-corresponding' ).

    io_out->write( data = me->ms_spfli name = 'ms_spfli ' ).

    io_out->write( data = ls_airport_to name = 'registro 1' ).
    io_out->write( data = lv_airport_to name = 'Lectura campo airport_from_id'  ).

  ENDMETHOD.


  METHOD delete_records.

    SELECT * FROM /dmo/connection WHERE connection_id >= '0400' INTO TABLE @me->mt_spfli.

    ir_out->write( data = mt_spfli name = 'Before Delete' ).

    DELETE mt_spfli WHERE airport_from_id = 'FRA'.   "Elimina los registros que concidan con esa key
    ir_out->write( data = mt_spfli name = 'Delete Records' ).

  ENDMETHOD.


  METHOD get_record_index.
*     get index of flight 0407

    SELECT * FROM /dmo/connection WHERE connection_id >= '0400' INTO TABLE @me->mt_spfli.

"Notacion vieja
    READ TABLE me->mt_spfli WITH KEY connection_id = '0402' TRANSPORTING NO FIELDS.

    DATA(lv_index2) = sy-tabix.

 "Notacion NUEVA syntaxis

    DATA(lv_index) = line_index( me->mt_spfli[ connection_id = '0407'  ]  ). "El indice del registro especificado

    DATA(lv_lines) = lines( me->mt_spfli ). "Cantidad de registros

   io_out->write( data = me->mt_spfli name = 'mt_spfli con filtro' ).

"VALIDACIONES
    IF lv_index > 0.
      io_out->write( |Flight index 0407: { lv_index }| ).
      io_out->write( lv_lines ).
    ELSE.
      io_out->write( 'Flight 0407 not found' ).
    ENDIF.

    IF lv_index > 0.
      io_out->write( |Flight index 0402: { lv_index2 }| ).
      io_out->write( lv_lines ).
    ELSE.
      io_out->write( 'Flight 0402 not found' ).
    ENDIF.

  ENDMETHOD.


  METHOD group_records.

    TYPES lty_group_keys TYPE STANDARD TABLE OF /dmo/connection-carrier_id WITH EMPTY KEY.
    DATA: lt_members TYPE STANDARD TABLE OF /dmo/connection.

    FIELD-SYMBOLS <ls_spfli> TYPE /dmo/connection.

    SELECT * FROM /dmo/connection
*        WHERE carrier_id EQ 'LH'
        INTO TABLE @mt_spfli.

**    Grouping of records
*"AGRUPANDO POR CAMPO
*    LOOP AT mt_spfli ASSIGNING <ls_spfli>
*        GROUP BY <ls_spfli>-airport_from_id.
*      CLEAR lt_members.
*      LOOP AT GROUP <ls_spfli> INTO DATA(ls_member).
*        lt_members = VALUE #( BASE lt_members ( ls_member ) ).
*      ENDLOOP.
*      ir_out->write( data = lt_members name = 'lt_members' ).
*    ENDLOOP.
*    UNASSIGN <ls_spfli>.

*    Grouping by key
*    LOOP AT mt_spfli ASSIGNING <ls_spfli>
*      "Grouping by more than one column of groups
*      GROUP BY ( airportfrom = <ls_spfli>-airport_from_id
*                 airportto   = <ls_spfli>-airport_to_id   ) INTO DATA(gs_key).
*      CLEAR lt_members.
*      LOOP AT GROUP gs_key INTO DATA(gs_member).
*        lt_members = VALUE #( BASE lt_members ( gs_member ) ).
*      ENDLOOP.
*      ir_out->write( data = lt_members name = 'lt_members' ).
*      ir_out->write( data = gs_key name = 'gs_key' ).
*    ENDLOOP.

*   FOR GROUPS
    ir_out->write(  VALUE lty_group_keys( FOR GROUPS gv_group OF gs_group IN mt_spfli
                                          GROUP BY gs_group-carrier_id
                                          ASCENDING
                                          WITHOUT MEMBERS ( gv_group )  )  ).

  ENDMETHOD.


  METHOD insert_record.

 " Este método inserta un nuevo registro en la tabla interna sin sobrescribirla.
 " Usa la sentencia INSERT para agregar el registro de manera segura.
 " Si la tabla tiene claves únicas, este método evita duplicados automáticamente.
 " Si la tabla es SORTED o HASHED, el nuevo registro se inserta en el orden adecuado, manteniendo la integridad de la tabla.

  " Insertar un nuevo registro directamente usando VALUE #( )
  INSERT VALUE #( id     = 3  " Asegurar un ID único
                  email  = 'emp3@logali.com'
                  ape1   = 'casas'
                  ape2   = 'martinez'
                  name   = 'paula'
                  fechan = '19920202'
                  fechaa = '20220202' ) INTO TABLE me->mt_employees.

  " Mostrar la tabla actualizada
  io_out->write( data = me->mt_employees name = 'Insert records' ).

  ENDMETHOD.


  METHOD loop_example. "Lee registro por registro almacenando en una estructura

    SELECT * FROM /dmo/connection WHERE connection_id >= '0400' INTO TABLE @me->mt_spfli.

*     loop through records with loop = 'KM'
    LOOP AT me->mt_spfli INTO me->ms_spfli FROM 2 TO 6 WHERE distance_unit = 'KM'.
      io_out->write( me->ms_spfli ).
    ENDLOOP.

  ENDMETHOD.


  METHOD modify_records.

   SELECT * FROM /dmo/connection WHERE connection_id >= '0400' INTO TABLE @me->mt_spfli.

   ir_out->write( data = mt_spfli name = 'Before Modify' ).

    LOOP AT mt_spfli INTO DATA(ls_spfli).
      IF ls_spfli-departure_time >= '12:00:00'. "Si el campo departure time es mayor a 12:00:00 cambiara a la hora actual del sistema
        ls_spfli-departure_time = cl_abap_context_info=>get_system_time(  ).
        MODIFY mt_spfli FROM ls_spfli TRANSPORTING departure_time.  "Solo afecta el campo departure time
      ENDIF.
    ENDLOOP.
    ir_out->write( data = mt_spfli name = 'Modify table' ).

  ENDMETHOD.


  METHOD nested_for.

    DATA: lt_final TYPE SORTED TABLE OF ty_flights WITH NON-UNIQUE KEY aircode.

    SELECT * FROM /dmo/flight INTO TABLE @mt_flights_type.
    SELECT * FROM /dmo/connection WHERE carrier_id = 'SQ' INTO TABLE @mt_airlines.

    lt_final = VALUE #(  FOR ls_flights_type IN mt_flights_type  WHERE (  carrier_id = 'SQ' )
                             FOR ls_airline IN mt_airlines WHERE ( connection_id = ls_flights_type-connection_id )
                       ( iduser = ls_flights_type-client
                         aircode = ls_flights_type-carrier_id
                         flightnum = ls_airline-connection_id
                         key = ls_airline-airport_from_id
                         seat = ls_flights_type-seats_occupied
                         flightdate = ls_flights_type-flight_date  )  ).

    ir_out->write( data = lt_final name = 'Nested For Table' ).

  ENDMETHOD.

  METHOD read_table_with_key.

    SELECT * FROM /dmo/connection
         WHERE carrier_id = 'LH'
         INTO TABLE @mt_spfli.

*     read table with key to display departure city for destination airport 'FRA'
    "NOTACION VIEJA "Mejor por performance
    READ TABLE me->mt_spfli INTO me->ms_spfli WITH KEY airport_to_id = 'FRA'. "Lee el primer registro que cumpla la KEY

"NOTACION NUEVA, EXECPCION SI ESTA VACIA
    DATA(lv_airtport_to) = me->mt_spfli[ airport_from_id = 'JFK' ]-airport_to_id. "La key es lo que esta en [

     io_out->write( data = mt_spfli name = 'mt_spfli' ).

    IF sy-subrc = 0.
      io_out->write( |Departure city for FRA: { me->ms_spfli-airport_from_id }| ).
      io_out->write( lv_airtport_to ).
    ENDIF.

  ENDMETHOD.


  METHOD sort_records.

    SELECT carrier_id, connection_id, airport_from_id, airport_to_id
      FROM /dmo/connection
      WHERE airport_from_id = 'FRA'
      INTO TABLE @mt_airlines2.
" ORDENAR REGISTROS. campo carrier_id Ascendiente, se puede poner mas campos
"Por default ordena ascending si no se pone explicito
    SORT mt_airlines2 BY carrier_id ASCENDING. " sorted by connection_id in descending order

    ir_out->write( mt_airlines2 ).

  ENDMETHOD.


  METHOD use_base.

    DATA lt_flights_base TYPE STANDARD TABLE OF /dmo/flight.

    SELECT * FROM /dmo/flight WHERE connection_id >= 400 INTO TABLE @mt_flights_type.

    ir_out->write( mt_flights_type ).
    "Lo que tiene la tabla mt_flights_type lo usare como base + Los registros que estoy agregan y se agregan al final
    lt_flights_base = VALUE #( BASE mt_flights_type ( carrier_id    = 'DL'
                                                      connection_id    = '2500'
                                                      flight_date    = cl_abap_context_info=>get_system_date( )
                                                      price     = '2000'
                                                      currency_code  =  'USD'
                                                      plane_type_id =  'A380-800'
                                                      seats_max  =  120
                                                      seats_occupied  =  100      )
                                                      ( carrier_id    = 'DT'
                                                      connection_id    = '2500'
                                                      flight_date    = cl_abap_context_info=>get_system_date( )
                                                      price     = '2000'
                                                      currency_code  =  'USD'
                                                      plane_type_id =  'A380-800'
                                                      seats_max  =  120
                                                      seats_occupied  =  100      ) ).
    SORT lt_flights_base BY connection_id ASCENDING. "Para ordenarlo

    ir_out->write( data = lt_flights_base name = 'Flight Base Table' ).

  ENDMETHOD.


  METHOD use_enumerations.   "DEPENDE DE LA ESTRUCTURA como esta definida

    DATA: lv_currency TYPE mty_currency.

    lv_currency = c_euros.
    ir_out->write( |Currency Code: { lv_currency }| ).

    lv_currency = c_dollar.
    ir_out->write( |Currency Code: { lv_currency }| ).

    DATA(lv_value) = lv_currency.

    ir_out->write( lv_value ).


  ENDMETHOD.


METHOD use_let.

  " Leer vuelos y aerolíneas desde las tablas del modelo /DMO
  SELECT * FROM /dmo/flight INTO TABLE @mt_flights_type.
  SELECT * FROM /dmo/carrier INTO TABLE @mt_scarr.

  " LOOP para mostrar información de solo un vuelo como ejemplo (puedes quitar el EXIT)
  LOOP AT mt_flights_type INTO DATA(ls_flight_let).

    " LET: Obtener nombre de aerolínea, precio del vuelo y ID del carrier *Variables temporales
    DATA(lv_flights) = CONV string(
      LET
        lv_airline_name = mt_scarr[ carrier_id = ls_flight_let-carrier_id ]-name
        lv_flight_price = mt_flights_type[ carrier_id     = ls_flight_let-carrier_id
                                           connection_id = ls_flight_let-connection_id ]-price
        lv_carrid       = mt_scarr[ carrier_id = ls_flight_let-carrier_id ]-carrier_id
      IN
        |Airline ID: { lv_carrid } / Airline name: { lv_airline_name } / Flight price: { lv_flight_price }|
    ).

    " Salir del loop tras el primer vuelo (puedes quitar el EXIT para recorrer todos)
    EXIT.

  ENDLOOP.

  " Mostrar resultado
  ir_out->write( data = lv_flights name = 'Let data' ).

ENDMETHOD.



  METHOD use_range_tables.

    TYPES lty_price TYPE RANGE OF /dmo/flight-price.

    DATA(lt_range) = VALUE lty_price(  ( sign   = 'I' "E  "Incluide or Exclude
                                         option = 'BT' "EQ  "Between or Equal
                                         low    = '200' "Rangos
                                         high   = '400'  )  ). "Rangos

    SELECT * FROM /dmo/flight
     WHERE seats_occupied IN @lt_range
      INTO TABLE @mt_flights_type.

    LOOP AT mt_flights_type INTO DATA(ls_flight).
      ir_out->write( data = ls_flight name = 'Range Tables' ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
