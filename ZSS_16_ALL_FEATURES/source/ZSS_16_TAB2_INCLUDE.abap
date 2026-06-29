*&---------------------------------------------------------------------*
*& Include ZSS_15_TAB2_INCLUDE
*&---------------------------------------------------------------------*
*& Selection Tab - Screen 1002
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF SCREEN 200 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE text-t07.
    SELECT-OPTIONS: s_matnr FOR mara-matnr  MODIF ID s01,
                    s_kunnr FOR kna1-kunnr  MODIF ID s02,
                    s_werks FOR t001w-werks MODIF ID s03,
                    s_lgort FOR T001L-LGORT MODIF ID s04,
                    s_vbeln FOR vbak-vbeln  MODIF ID s05.
  SELECTION-SCREEN END OF BLOCK b4.

  SELECTION-SCREEN BEGIN OF BLOCK b5 WITH FRAME TITLE text-t08.
    PARAMETERS: p_ordtyp TYPE char1 MODIF ID s06,   " <=8
                p_soldto TYPE kna1-kunnr MODIF ID s07. " <=8
    SELECT-OPTIONS: s_create FOR sy-datum MODIF ID s08.
  SELECTION-SCREEN END OF BLOCK b5.

SELECTION-SCREEN END OF SCREEN 200.

*INITIALIZATION.
*  PERFORM init_tab2.

*AT SELECTION-SCREEN OUTPUT.
*  PERFORM tab2_screen_output.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR s_matnr-low.
  PERFORM f4_material_tab2.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR s_kunnr-low.
  PERFORM f4_customer_tab2.

FORM init_tab2.
  s_matnr-sign = 'I'.
  s_matnr-option = 'EQ'.
  s_kunnr-sign = 'I'.
  s_kunnr-option = 'EQ'.
  p_ordtyp = 'A'.
ENDFORM.

FORM tab2_screen_output.
  LOOP AT SCREEN.
    IF screen-group1 = 'S04' AND s_werks[] IS INITIAL.
      screen-input = 0.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.

FORM f4_material_tab2.
  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield   = 'MATNR'
      dynpprog   = sy-repid
      dynpnr     = sy-dynnr
      dynprofield = 'S_MATNR-LOW'
    TABLES
      value_tab  = gt_mara
    EXCEPTIONS
      OTHERS     = 0.
ENDFORM.

FORM f4_customer_tab2.
  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield   = 'KUNNR'
      dynpprog   = sy-repid
      dynpnr     = sy-dynnr
      dynprofield = 'S_KUNNR-LOW'
    TABLES
      value_tab  = gt_kna1
    EXCEPTIONS
      OTHERS     = 0.
ENDFORM.