CLASS zcl_03_constructor_exp_fjcm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_03_constructor_exp_FJCM IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

  "Constructores manera de construir y manipular valores de manera mas legible

** Value  "Para construir instancias y inicializarlos
*
*    DATA(lt_msg) = VALUE string_table( ( `Welcome` )  "String_table tipo de tabla que tomara de referencia
*                                       ( `Student` ) ).
*
*    out->write( data = lt_msg name = 'lt_msg' ).
*
*
*    lt_msg = VALUE #( ). "Aca lo inicializo sin valores
*
*
*    out->write( data = lt_msg name = 'lt_msg' ).


* DATA : BEGIN OF ls_student_data,
*         student_name TYPE /dmo/first_name,
*         id           TYPE c LENGTH 2,
*         BEGIN OF personal_data,
*           address TYPE /dmo/street,
*           number  TYPE i,
*         END OF personal_data,
*       END OF ls_student_data.
*
*       ls_student_data = VALUE #(  student_name = 'Freddy José' "Cuando uso # Es por que ya defini explicitamente la estrutura
*                                   id           = '01'
*                                   personal_data = VALUE #(  address = 'Chelmoskiego 6A'
*                                                             number  = 8  ) ).
*
*    out->write( ls_student_data ).
*
*    ls_student_data =  VALUE #( ). " Incizialice esta structura
*
*    out->write( ls_student_data ).

** CAST "Conversiones " Ver otra vez para entender
*
*    TYPES: BEGIN OF t_struct,
*             col1 TYPE i,
*             col2 TYPE i,
*           END OF t_struct.
*
*    DATA: lo_data TYPE REF TO data,
*          ls_int  TYPE t_struct.
*
*
*    lo_data = NEW t_struct( ).
*
*    ls_int = CAST t_struct( lo_data )->*.
*
*    out->write( ls_int ).
*
*    out->write( cl_abap_char_utilities=>newline ).
*
*    ls_int = VALUE #( col1 = 4
*                      col2 = 6 ).
*9
*    CAST t_struct( lo_data )->* = ls_int.

** REDUCE "Sumar dentro de un ciclo
*
*    DATA: numbers TYPE TABLE OF i, " Declaramos una tabla interna de enteros
*          sum     TYPE i.          " Variable para guardar la suma final
*
*    numbers = VALUE #( ( 1 ) ( 2 ) ( 3 ) ( 4 ) ( 5 ) ). " Asignamos valores directamente a la tabla usando VALUE # por que ya esta definida implictamente
*
*    sum = REDUCE #(         "IGUAL QUE UN COLLECT PARA TABLAS INTERNAS
*               INIT x = 0         " x es el acumulador inicial, comienza en 0
*               FOR n IN numbers   " n es el iterador que recorre cada valor de la tabla numbers
*               NEXT x = x + n     " En cada iteración, sumamos el valor de n a x
*             ).
*
*    out->write( sum ). " Imprimimos el resultado de la suma
*
*    out->write( cl_abap_char_utilities=>newline ). " Imprimimos un salto de línea


** CORRESPONDING "Mueve los campos correspondientes, si coinciden y si no los deja en blanco
*
*    TYPES: BEGIN OF ty_old,
*             name TYPE string,
*             age  TYPE i,
*             nationality TYPE string,
*           END OF ty_old.
*
*    TYPES: BEGIN OF ty_new,
*             name    TYPE string,
*             age     TYPE i,
*             address TYPE string,
*             nationality TYPE string,
*           END OF ty_new.
*
*    DATA: old_data TYPE ty_old.
*          new_data TYPE ty_new.
*
*    old_data = VALUE #( name = 'Freddy' age = 24 nationality = 'Peruvian' ). "Asignar valores con VALUE # Ya que ya esta definido explicitamente
*
*    DATA(new_data) = CORRESPONDING ty_new( old_data ). "Cuando es variable en linea se tiene que especificar que tipo de referencia tomara en este caso ty_new
*                                                       "Creamos una variable en línea y copiamos los campos comunes desde old_data hacia new_data
*    out->write( old_data ). " Mostramos la estructura original
*
*    out->write( new_data ). " Mostramos la nueva estructura, con campos coincidentes copiados
*
*    out->write( cl_abap_char_utilities=>newline ).

*** REF "Generar refrencias de tipos de datos o *instancias de clase
*
*    DATA: lv_num  TYPE i,
*          ref_num TYPE REF TO i.
*
*    lv_num = 200.
*
*    ref_num = REF #( lv_num ). " Crear una referencia al valor de num
*
*    out->write( ref_num->* ). " Acceder al valor referenciado
*                              " ->* Accede al contenido apuntado por una referencia, sea un número, estructura o tabla
*
*    lv_num = 1500. "Cambiar el origen afecta la referencia
*
*    out->write( ref_num->* ). " Acceder al valor referenciado AFECTA la referencia cuando lo cambio
*
*    out->write( cl_abap_char_utilities=>newline ).

* CONV "Convertir tipos de datos

*    DATA: text TYPE string,
*          num  TYPE p LENGTH 5 DECIMALS 1 VALUE '3.4'.
*
**    num = 100.
*
*    text = CONV string( num ). "Convertira a string la variable num
*
*    out->write( text ).


* NEW "Generar instancias de una clase Si usas NEW, creas una instancia independiente con sus propios atributos
*    DATA(lo_class) = NEW zcl_11_busniess_pr_log_c346( ). "New y "Nombre de la clas"
*
*    DATA: lo_class2 TYPE REF TO zcl_11_busniess_pr_log_c346. " Otra forma por type REF TO
*
*    lo_class2 = NEW #( ).

* Exact  "Manejo de conversiones totalmente estricto, solo se basa en si se puede o no se puede

*    DATA: lv_int_value  TYPE i VALUE 32767,
*          lv_int2_value TYPE int2. " Cuidado: el valor debe estar dentro del rango de int2 (-32,768 a 32,767)
*    TRY.
*        lv_int2_value = EXACT int2( lv_int_value ). "Exacto osea lo trunca, solo se basa en si se puede o no. Siendo muy estricto
*        out->write( data = lv_int2_value name = 'Converted value:' ).
*      CATCH cx_sy_conversion_error INTO DATA(lx_error).
*        out->write( data = lx_error->get_text( ) name = 'Error' ).
*    ENDTRY.

** Filter "Muy importante, fitro de tablas en tiempo de ejecucion
*
    DATA: lt_flights_all   TYPE STANDARD TABLE OF /dmo/flight,
          lt_flights_final TYPE STANDARD TABLE OF /dmo/flight,
          "Filter table *La tabla a la que se le va aplicar tiene que ser sort y tiene que tener llave*
          lt_filter        TYPE SORTED TABLE OF /dmo/flight-carrier_id WITH UNIQUE KEY table_line. " table_line para traer toda la linea justo porque defini la tabla filter con un solo campo de la base de datos /dmo/flight

    SELECT FROM /dmo/flight
        FIELDS *
        INTO TABLE @lt_flights_all.

    "Filter values
    lt_filter = VALUE #( ( 'AA ' ) ( 'LH ' ) ( 'UA ' ) ). "Aca solo voy a filtrar los carrier id AA LH UA
    lt_flights_final =  FILTER #( lt_flights_all IN lt_filter WHERE carrier_id = table_line ) . " Filtra todos los registros de lt_flights_all donde el campo carrier_id coincida con algún valor en la tabla lt_filter.
    out->write( lt_flights_all ).
    out->write( lt_flights_final ).

  ENDMETHOD.

ENDCLASS.
