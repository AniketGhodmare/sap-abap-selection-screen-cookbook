*&---------------------------------------------------------------------*
*& Include ZSS_15_DYNAMIC_INCLUDE
*&---------------------------------------------------------------------*
*& Dynamic Screen Modifications
*&---------------------------------------------------------------------*

FORM dynamic_screen_mod.
  PERFORM modify_by_radio_group.
  PERFORM modify_by_checkbox.
  PERFORM modify_by_selection.
  PERFORM modify_by_authorization.
ENDFORM.

FORM modify_by_radio_group.
  LOOP AT SCREEN.
    CASE screen-group1.
      WHEN 'G02'.
        IF rb_order = 'X'.
          screen-active = 1.
        ELSE.
          screen-active = 1.
        ENDIF.
        MODIFY SCREEN.
    ENDCASE.
  ENDLOOP.
ENDFORM.

FORM modify_by_checkbox.
  LOOP AT SCREEN.
    CASE screen-group1.
      WHEN 'U03'.   " Test run
        IF p_test = 'X'.
          screen-input = 0.
        ELSE.
          screen-input = 1.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'A02'.   " Parallel
        IF p_log IS INITIAL.
          screen-input = 0.
          screen-required = 0.
        ELSE.
          screen-input = 1.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'A04'.   " Max records
        IF p_paral = 'X'.
          screen-required = 2.
          screen-input = 1.
        ELSE.
          screen-required = 0.
          screen-input = 0.
        ENDIF.
        MODIFY SCREEN.
    ENDCASE.
  ENDLOOP.
ENDFORM.

FORM modify_by_selection.
  LOOP AT SCREEN.
    CASE screen-group1.
      WHEN 'S04'.   " Storage Location
        IF s_werks[] IS INITIAL.
          screen-input = 0.
        ELSE.
          screen-input = 1.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'A07'.   " Buffer
        IF p_debug = 'X'.
          screen-active = 1.
        ELSE.
          screen-active = 0.
        ENDIF.
        MODIFY SCREEN.
    ENDCASE.
  ENDLOOP.
ENDFORM.

FORM modify_by_authorization.
  LOOP AT SCREEN.
    CASE screen-group1.
      WHEN 'G03'.   " Priority
        IF sy-uname <> 'SAPUSER'.
          screen-input = 0.
          screen-required = 0.
        ENDIF.
        MODIFY SCREEN.
    ENDCASE.
  ENDLOOP.
ENDFORM.