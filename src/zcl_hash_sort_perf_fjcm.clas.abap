CLASS zcl_hash_sort_perf_fjcm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.

    METHODS:
      constructor,
      standard,
      sort,
      hash.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: lt_standard TYPE STANDARD TABLE OF /dmo/booking_m WITH NON-UNIQUE KEY travel_id booking_id booking_date,
          lt_sort     TYPE SORTED TABLE OF /dmo/booking_m WITH NON-UNIQUE KEY travel_id booking_id booking_date,
          lt_hash     TYPE HASHED TABLE OF /dmo/booking_m WITH UNIQUE KEY travel_id booking_id booking_date.

    DATA: key_tavel_id    TYPE /dmo/travel_id,
          key_boooking_id TYPE /dmo/booking_id,
          key_date        TYPE /dmo/booking_date.

    METHODS: set_line_to_read.

ENDCLASS.


CLASS zcl_hash_sort_perf_fjcm IMPLEMENTATION. "Click derecho en la clase y profile as ABAP CONSOLE, Despues "ABAP PROFILING PERSPECTIVE, Luego HIT LIST


  METHOD hash. "PARA MILLONES DE REGISTROS

    DATA(result) = lt_hash[ travel_id = me->key_tavel_id
                            booking_id = me->key_boooking_id
                            booking_date = me->key_date ].

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_object) = NEW zcl_sortvshash_c345( ).

    lo_object->standard( ).
    lo_object->sort( ).
    lo_object->hash( ).

    out->write( me->key_tavel_id ).
    out->write( me->key_boooking_id ).
    out->write( me->key_date ).

  ENDMETHOD.

  METHOD sort.

    DATA(result) = lt_sort[ travel_id = me->key_tavel_id
                            booking_id = me->key_boooking_id
                            booking_date = me->key_date ].

  ENDMETHOD.

  METHOD standard. " PARA MILES DE REGISTROS, ORDENAR SORT Y LUEGO BINARY SEARCH

    DATA(result) = lt_standard[ travel_id = me->key_tavel_id
                               booking_id = me->key_boooking_id
                               booking_date = me->key_date ].

  ENDMETHOD.

  METHOD constructor.

    SELECT FROM /dmo/booking_m
    FIELDS *
    INTO TABLE @lt_standard.

    SELECT FROM /dmo/booking_m
    FIELDS *
    INTO TABLE @lt_sort.

    SELECT FROM /dmo/booking_m
    FIELDS *
    INTO TABLE @lt_hash.

    me->set_line_to_read( ).

  ENDMETHOD.

  METHOD set_line_to_read.

    DATA(lv_data) = lt_standard[ CONV i( lines( lt_standard ) * '0.65' ) ].

    me->key_tavel_id = lv_data-travel_id.
    me->key_boooking_id = lv_data-booking_id.
    me->key_date = lv_data-booking_date.

  ENDMETHOD.

ENDCLASS.
