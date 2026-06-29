*&---------------------------------------------------------------------*
*& Include ZSS_15_TAB1_INCLUDE
*&---------------------------------------------------------------------*
*& General Tab - Screen 1001
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF SCREEN 100 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.
    PARAMETERS: p_emp   TYPE usr21-bname MODIF ID g01,
                p_vkorg TYPE vbak-vkorg  MODIF ID g01,
                p_vtweg TYPE vbak-vtweg  MODIF ID g01,
                p_spart TYPE vbak-spart  MODIF ID g01.
  SELECTION-SCREEN END OF BLOCK b1.


  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-t02.
    SELECT-OPTIONS: s_date FOR sy-datum MODIF ID g02.

*--------------------------------------------------------------------
*radio button in single line
*--------------------------------------------------------------------
    SELECTION-SCREEN BEGIN OF LINE.

      PARAMETERS: rb_order RADIOBUTTON GROUP grp1 DEFAULT 'X' MODIF ID g02.
      SELECTION-SCREEN COMMENT 3(10) TEXT-t03 FOR FIELD rb_order.

      PARAMETERS: rb_deliv RADIOBUTTON GROUP grp1.
      SELECTION-SCREEN COMMENT 16(14) TEXT-t04 FOR FIELD rb_deliv.

    SELECTION-SCREEN END OF LINE.


  SELECTION-SCREEN END OF BLOCK b2.


  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-t05.
    PARAMETERS: p_prio TYPE char8 MODIF ID g03.   " <=8 chars
    SELECTION-SCREEN COMMENT /1(40) TEXT-t06.
  SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN END OF SCREEN 100.

*INITIALIZATION.
*  PERFORM init_tab1.

*AT SELECTION-SCREEN OUTPUT.
*  PERFORM tab1_screen_output.

*AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_emp.
*  PERFORM f4_employee_tab1.

FORM init_tab1.
  p_vkorg = '1000'.
  p_vtweg = '10'.
  p_spart = '00'.
  p_prio  = '1'.
  s_date-sign = 'I'.
  s_date-option = 'BT'.
  s_date-low = sy-datum - 30.
  s_date-high = sy-datum.
  APPEND s_date.
ENDFORM.

FORM tab1_screen_output.
  " Any screen modifications specific to Tab 1
ENDFORM.

FORM f4_employee_tab1.
  DATA: lt_return TYPE STANDARD TABLE OF dfies,
        ls_ret    TYPE dfies.
  CALL FUNCTION 'F4IF_FIELD_VALUE_REQUEST'
    EXPORTING
      tabname    = 'USR21'
      fieldname  = 'BNAME'.
*    TABLES
*      return_tab = lt_return
*    EXCEPTIONS
*      OTHERS     = 1.
*  IF sy-subrc = 0 AND lt_return[] IS NOT INITIAL.
*    READ TABLE lt_return INDEX 1 INTO ls_ret.
*    p_emp = ls_ret-fieldname.
**    p_emp = ls_ret-fieldval.
*  ENDIF.
ENDFORM.