CLASS lhc_zr_bigl_fdb_v2 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Biglietto
        RESULT result,
      earlynumbering_create FOR NUMBERING
        IMPORTING entities FOR CREATE Biglietto,
      checkStatus FOR VALIDATE ON SAVE IMPORTING keys
                                                   FOR biglietto~checkStatus,
      GetDefaultsForCreate FOR READ
        IMPORTING keys FOR FUNCTION Biglietto~GetDefaultsForCreate RESULT result,
      get_instance_features FOR INSTANCE FEATURES
        IMPORTING keys REQUEST requested_features FOR Biglietto RESULT result,
      onSave FOR DETERMINE ON SAVE
        IMPORTING keys FOR Biglietto~onSave,
      CustomDelete FOR MODIFY
        IMPORTING keys FOR ACTION Biglietto~CustomDelete RESULT result.

ENDCLASS.

CLASS lhc_zr_bigl_fdb_v2 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD earlynumbering_create.
*DATA:
*        lv_id TYPE ZBIGL_FDB_V2-id_biglietto.
*    WITH +big AS (
*        SELECT MAX( id_biglietto ) AS id_max
*            FROM ZBIGL_FDB_V2
*        UNION
*        SELECT MAX( IdBiglietto ) AS id_max
*            FROM ZBIGL_FDB_V2_d
*        )
*        SELECT MAX( id_max )
*            FROM +big AS big
*            INTO @DATA(lv_max).
**    SELECT MAX( Idbiglietto )
**        FROM zr_biglietto_gf2
**        INTO @DATA(lv_max).
*    LOOP AT entities
*            INTO DATA(ls_entity).
*      IF ls_entity-IdBiglietto IS INITIAL.
**            cl_numberrange_runtime=>number_get(
**       EXPORTING
**         nr_range_nr = '01'
**         object      = 'ZID_B_FDB'
**       IMPORTING
**         number      = DATA(lv_max) ) .
*
*        lv_max += 1.
*        lv_id = lv_max.
*      ELSE.
*        lv_id = ls_entity-IdBiglietto.
*      ENDIF.
*      APPEND VALUE #(
*              %cid = ls_entity-%cid
*              %is_draft = ls_entity-%is_draft
*              IdBiglietto = lv_id
*          )
*          TO mapped-biglietto.
*    ENDLOOP.
*with +big AS (
*SELECT MAX( Idbiglietto ) as IdMax
*from zr_biglietto_gf2
*UNION
*SELECT MAX( Idbiglietto ) as IdMax
*from zbiglietto_gf2_d
*)
*SELECT MAX( IdMax  ) from +big as big into @DATA(lv_max).
    DATA: latest_num   TYPE cl_numberrange_runtime=>nr_number.

    DATA(All_entities) = entities.
    DELETE All_entities WHERE IdBiglietto IS NOT INITIAL.
    IF all_entities IS NOT INITIAL.
      TRY.
          cl_numberrange_runtime=>number_get(
            EXPORTING
              nr_range_nr = '01'
              object      = 'ZID_B_FDB'
              quantity = CONV #( lines( all_entities ) )
            IMPORTING
              number      = latest_num
              returncode = DATA(code)
              returned_quantity = DATA(return_qty) ).

        CATCH cx_nr_object_not_found INTO DATA(lx_obj_not_found).
        CATCH cx_number_ranges INTO DATA(lx_ranges_error).

          LOOP AT All_entities INTO DATA(entity_line).

            APPEND VALUE #( %cid = entity_line-%cid
                            %key  = entity_line-%key ) TO failed-biglietto.
            APPEND VALUE #( %cid = entity_line-%cid
                            %key = entity_line-%key
                            %msg = lx_ranges_error ) TO reported-biglietto.
          ENDLOOP.
          EXIT.
      ENDTRY.

      DATA(curr_num) = latest_num - return_qty.

      LOOP AT All_entities INTO entity_line.
        curr_num = curr_num + 1 .
        APPEND VALUE #( %cid = entity_line-%cid
        %is_draft = entity_line-%is_draft
        IdBiglietto = curr_num ) TO mapped-biglietto.

      ENDLOOP.
    ELSE.
      LOOP AT entities INTO entity_line.

        APPEND VALUE #( %cid = entity_line-%cid
        %is_draft = entity_line-%is_draft
        IdBiglietto = entity_line-IdBiglietto ) TO mapped-biglietto.

      ENDLOOP.
    ENDIF.
*mapped-biglietto = VALUE #(  for ls in entities (  %cid = ls-%cid %is_draft = ls-%is_draft
*IdBiglietto = COND #( when ls-IdBiglietto is Initial then lv_max + 1 else ls-IdBiglietto ) ) ).
*IdBiglietto = latest_num ) ).
  ENDMETHOD.

  METHOD checkStatus.
    DATA:
    lt_biglietto TYPE TABLE FOR READ RESULT zr_bigl_fdb_v2.
    READ ENTITIES OF zr_bigl_fdb_v2
    IN LOCAL MODE
    ENTITY Biglietto
    FIELDS ( Stato )
    WITH CORRESPONDING #( keys )
    RESULT lt_biglietto.

    LOOP AT lt_biglietto
                INTO DATA(ls_biglietto)
                WHERE Stato <> 'BOZZA'
                AND stato <> 'FINALE'
                AND stato <> 'CANC'.
      APPEND VALUE #(
            %tky = ls_biglietto-%tky )
        TO failed-biglietto.
      APPEND VALUE #(
            %tky = ls_biglietto-%tky
            %msg = NEW zcx_error_biglietti_fdb(
                textid = zcx_error_biglietti_fdb=>invalid_stat
                iv_stato = ls_biglietto-Stato
                severity = if_abap_behv_message=>severity-error
                 )
                 %element-Stato = if_abap_behv=>mk-on )
        TO reported-biglietto.
    ENDLOOP.
  ENDMETHOD.
  METHOD GetDefaultsForCreate.

    result = VALUE #( FOR key IN keys (
               %cid = key-%cid
               %param-stato = 'BOZZA'
                ) ).

  ENDMETHOD.

  METHOD get_instance_features.

    DATA:  ls_result LIKE LINE OF result.

    READ ENTITIES OF zr_bigl_fdb_v2
  IN LOCAL MODE
  ENTITY Biglietto
  FIELDS ( Stato )
  WITH CORRESPONDING #( keys )
  RESULT DATA(lt_biglietto).


    LOOP AT lt_biglietto
    INTO DATA(ls_biglietto).

      CLEAR: ls_result.
      ls_result-%tky = ls_biglietto-%tky.
      ls_result-%field-Stato = if_abap_behv=>fc-f-read_only.
      ls_result-%action-CustomDelete = COND #(
        WHEN ls_biglietto-Stato = 'FINALE'
            THEN if_abap_behv=>fc-o-enabled
            ELSE if_abap_behv=>fc-o-disabled ).

      APPEND ls_result
        TO result.

*      APPEND VALUE #(
*      %tky = ls_biglietto-%tky
*      %field-Stato = if_abap_behv=>fc-f-read_only ) TO result .
    ENDLOOP.

  ENDMETHOD.

  METHOD onSave.
    DATA: lt_update TYPE TABLE FOR UPDATE  zr_bigl_fdb_v2.

    READ ENTITIES OF zr_bigl_fdb_v2
  IN LOCAL MODE
  ENTITY Biglietto
  FIELDS ( Stato )
  WITH CORRESPONDING #( keys )
  RESULT DATA(lt_biglietto).

    LOOP AT lt_biglietto
      INTO DATA(ls_biglietto)
      WHERE stato = 'BOZZA'.

      APPEND VALUE #(
      %tky = ls_biglietto-%tky
        Stato = 'FINALE'
         %control-Stato = if_abap_behv=>mk-on )
          TO lt_update.
    ENDLOOP.
    IF lt_update IS NOT INITIAL.
      MODIFY ENTITIES OF zr_bigl_fdb_v2
      IN LOCAL MODE ENTITY biglietto
      UPDATE FROM lt_update.
    ENDIF.

  ENDMETHOD.

  METHOD CustomDelete.

    DATA: lt_update TYPE TABLE FOR UPDATE  zr_bigl_fdb_v2,
          ls_update LIKE LINE OF lt_update.

    READ ENTITIES OF zr_bigl_fdb_v2
     IN LOCAL MODE
     ENTITY Biglietto
   ALL FIELDS
     WITH CORRESPONDING #( keys )
     RESULT DATA(lt_biglietto).

    LOOP AT lt_biglietto ASSIGNING FIELD-SYMBOL(<ls_biglietto>).
      <ls_biglietto>-stato = 'CANC'.
      APPEND VALUE #(
       %tky = <ls_biglietto>-%tky
          %param = <ls_biglietto> )
          TO result .

      ls_update = CORRESPONDING #( <ls_biglietto> ).
      ls_update-%control-Stato = if_abap_behv=>mk-on.
      APPEND ls_update
        TO lt_update.
    ENDLOOP.

    MODIFY ENTITIES OF zr_bigl_fdb_v2
        IN LOCAL MODE
        ENTITY Biglietto
        UPDATE FROM lt_update.


  ENDMETHOD.

ENDCLASS.
