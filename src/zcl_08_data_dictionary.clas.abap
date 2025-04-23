CLASS zcl_08_data_dictionary DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_08_data_dictionary IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

***Domain
*  "Definicion tecnica de tipo de dato y longitud
*  "Se puede asociar a multiples Data Element
*
*
*
***Data Element
*  "Puede estar asociado a un dominio
*  "Mas usado usar tipo predefinidio o dominio
*  "Solo a un Dominio puede estar asociado
*
***Structure
*  "Puedo construirlo apartir de mis elementos de datos para los campos que tendrá
*   DATA ls_nested_structure type zst_structure_fjcm. " zst_structure_fjcm Structura creada en Data Dictionary
*                                                     " Lo construi con tipos de dato personalizados y genericos
*                                                     " Tiene anidada la structura *zst_adress_emp_fjcm*
*
*   "Aca es NESTED STRUCTURE, anide una estructura dentro de otra con un *alias*
*
*   ls_nested_structure = VALUE #( employeeid = 01
*                          age        = 24
*                          first_name = 'Freddy José'
*                          last_name  = 'Casas Mejia'
*                          role       = '01'
*                          adress     = VALUE #( adressid     = '8'
*                                                city         = 'Poznan'
*                                                country      = 'Poland'
*                                                neighborhood = 'Lazarz'
*                                                num          =   6
*                                                postalcode   = '5001'
*                                                street       = 'Chelmoskiego' ) ).
*
**   out->write( name = 'Employee Structure' data = ls_nested_structure ).
*
*   "Aca es INCLUDE STRUCTURE, inclui una estructura con otra es como una fusion
*
*   DATA ls_incluide_structure type zst_employee_fjcm.
*
*   ls_incluide_structure = VALUE #( employeeid   = 01
*                          age          = 24
*                          first_name   = 'Freddy José'
*                          last_name    = 'Casas Mejia'
*                          role         = '01'
*                          adressid     = '8'
*                          city         = 'Poznan'
*                          country      = 'Poland'
*                          neighborhood = 'Lazarz'
*                          num          =  6
*                          postalcode   = '5001'
*                          street       = 'Chelmoskiego' ).
*
*
**   out->write( name = 'Incluide Structure' data = ls_incluide_structure ).
*
***TABLE TYPES
*  "Puede tener los atributos de estructuras
*  "Es como crear un tipo de tabla interna, definiendo su tipo STANDART,HASH,SORT y sus keys si es necesario
*
***DEEP STRUCTURE
*  "Estructura que tiene una tabla interna en uno de sus campos
*  DATA ls_deep_structure type zst_employee_deep_fjcm.  "Declarando
*
*  DATA(lt_adress) = VALUE ztt_address_fjcm( (   adressid     = '8'       "Declaro nueva variable para guardar datos en una tabla interna del tipo que cree en el diccionario
*                                                city         = 'Poznan'
*                                                country      = 'Poland'
*                                                neighborhood = 'Lazarz'
*                                                num          =   6
*                                                postalcode   = '5001'
*                                                street       = 'Chelmoskiego' )
*
*                                             (  adressid     = '104'
*                                                city         = 'Ayacucho'
*                                                country      = 'Perú'
*                                                neighborhood = 'Santa Ana'
*                                                num          =   104
*                                                postalcode   = '6001'
*                                                street       = 'Jr. Las palmeras' ) ).
*
*
*  ls_deep_structure = VALUE #( employeeid = 01  "Agrego datos a la estructura
*                               age        = 24
*                               first_name = 'Freddy José'
*                               last_name  = 'Casas Mejia'
*                               role       = '01'
*                               address    = lt_adress ). "Aca en campo address es mi deep, por que contiene mi tabla interna
*
**  out->write( name = 'Deep Structure' data = ls_deep_structure ).
*
********IMPORTANTE********
**✅Analogía rápida para recordar: ✅
*"Primary key = Cédula o DNI: Identifica a una persona.
*
*"Secondary key = Índice del libro: Te ayuda a encontrar rápidamente el capítulo o tema, sin ser una identificación única.
*
***ITAB DEEP ANIDADA
*
*DATA(lt_employee) = VALUE ZTT_EMPLOYEE_FJCM( ( employeeid = 01
*                                               age        = 24
*                                               first_name = 'Freddy José'
*                                               last_name  = 'Casas Mejia'
*                                               role       = '01'
*                                               address    = lt_adress )
*
*                                             ( employeeid = 02
*                                               age        = 20
*                                               first_name = 'Paulina'
*                                               last_name  = 'Sobik'
*                                               role       = '02'
*                                               address    = lt_adress ) ).
*
*out->write( name = 'Deep ITAB' data = lt_employee ).

**DATA BASE TABLE "Siempre primer campo cliente "DeliveryClass: #A Datos maestros  #C custom #DataMaintenance Display, allowed, etc
                   "Tambien se puede usar INCLUDE para agregar mas campos desde estructuras
                   "Hacer notacion, si se usaran currency @Semantics.amount.currencyCode :
**Transparent DB  "Normales que almacenan datos

DATA lt_employee TYPE STANDARD TABLE OF zemployee_fjcm. "Tipo de mi tabla de base de datos(zemployee_fjcm)

lt_employee = VALUE #( (   employeeid = 01            "Se autoasigna por que esta declarado explicitamente #
                           age        = 24
                           first_name = 'Freddy José'
                           last_name  = 'Casas Mejia'
                           role       = '01' )
                         ( employeeid = 02
                           age        = 20
                           first_name = 'Paulina'
                           last_name  = 'Sobik'
                           role       = '02' ) ).

"MANEJAR VALIDACIONES CON TRY-CATCH
*TRY.
*    MODIFY zemployee_fjcm FROM TABLE @lt_employee. " Agregar registros a la tabla interna en la capa de persistencia
*    out->write( 'Inserción correcta' ).            " MODIFY (Base de datos) from table @(la itab o estructura que quieras agregar).
*  CATCH cx_root INTO DATA(lx_root).
*    out->write( |Error: { lx_root->get_text( ) }| ).
*ENDTRY.


**Global temporal  "Viven dentro del programa, en memoria

"
TRY.
    MODIFY zemployee2_fjcm FROM TABLE @lt_employee.
    SELECT * FROM zemployee2_fjcm INTO TABLE @DATA(lt_results).

    IF lt_results IS NOT INITIAL.
      out->write( 'Inserción correcta' ).
      out->write( lt_results ).
    ELSE.
      out->write( 'No se insertaron datos' ).
    ENDIF.

  CATCH cx_root INTO DATA(lx_root).
    out->write( |Error: { lx_root->get_text( ) }| ).
ENDTRY.




"Techncial Table Settings

"Data class: APPL0 datos maestros APPL1 transaccionales, Size Category: Tamaño de la tabla respecto a los registros, tiene rangos. Storage Type, etc.

  ENDMETHOD.
ENDCLASS.
