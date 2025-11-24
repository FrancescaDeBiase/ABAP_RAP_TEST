CLASS zcl_fdb_estrazione_flight DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fdb_estrazione_flight IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA lt_flights TYPE TABLE OF /dmo/flight.

  SELECT * FROM /dmo/flight INTO TABLE @lt_flights.
  out->write(  exporting data = lt_flights ).
  ENDMETHOD.
ENDCLASS.
