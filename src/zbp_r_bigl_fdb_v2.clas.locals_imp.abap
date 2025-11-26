CLASS lhc_zr_bigl_fdb_v2 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Biglietto
        RESULT result,
      earlynumbering_create FOR NUMBERING
*        RAISING
*          cx_number_ranges
        IMPORTING entities FOR CREATE Biglietto.
ENDCLASS.

CLASS lhc_zr_bigl_fdb_v2 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD earlynumbering_create.
DATA:
        lv_id TYPE ZBIGL_FDB_V2-id_biglietto.
    WITH +big AS (
        SELECT MAX( id_biglietto ) AS id_max
            FROM ZBIGL_FDB_V2
        UNION
        SELECT MAX( IdBiglietto ) AS id_max
            FROM ZBIGL_FDB_V2_d
        )
        SELECT MAX( id_max )
            FROM +big AS big
            INTO @DATA(lv_max).
*    SELECT MAX( Idbiglietto )
*        FROM zr_biglietto_gf2
*        INTO @DATA(lv_max).
    LOOP AT entities
            INTO DATA(ls_entity).
      IF ls_entity-IdBiglietto IS INITIAL.
*            cl_numberrange_runtime=>number_get(
*       EXPORTING
*         nr_range_nr = '01'
*         object      = 'ZID_B_FDB'
*       IMPORTING
*         number      = DATA(lv_max) ) .

        lv_max += 1.
        lv_id = lv_max.
      ELSE.
        lv_id = ls_entity-IdBiglietto.
      ENDIF.
      APPEND VALUE #(
              %cid = ls_entity-%cid
              %is_draft = ls_entity-%is_draft
              IdBiglietto = lv_id
          )
          TO mapped-biglietto.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
