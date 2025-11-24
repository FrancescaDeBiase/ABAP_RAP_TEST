CLASS zcl_fdb_test_rap_hello_cloud DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fdb_test_rap_hello_cloud IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( 'Hello World!' ).

    " SELECT dalla tabella /dmo/flight
    SELECT carrier_id,  flight_date FROM /dmo/flight INTO TABLE @DATA(lt_flights).

    LOOP AT lt_flights INTO DATA(ls_flight).
      out->write( |Carrier: { ls_flight-carrier_id }, Date: { ls_flight-flight_date }| ).
    ENDLOOP.


  ENDMETHOD.
ENDCLASS.
