CLASS zcl_fdb_insert_new_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fdb_insert_new_table IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lt_table TYPE TABLE OF zmm_fdb_table WITH EMPTY KEY.

*delete zmm_fdb_table from @lt_table.
    lt_table = VALUE #( ( id = 'A1'
  descr = 'Tipo Utente Premium'
  limit = 'Nessuna'
  price     = '99.99'
  currency_code     = 'E'
     ) ).
    modify zmm_fdb_table
    FROM TABLE @lt_table.
    COMMIT WORK AND WAIT.
  ENDMETHOD.
ENDCLASS.
