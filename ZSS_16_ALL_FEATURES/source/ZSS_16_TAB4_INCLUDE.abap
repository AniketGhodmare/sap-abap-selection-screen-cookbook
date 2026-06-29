*&---------------------------------------------------------------------*
*& Include ZSS_15_TAB4_INCLUDE
*&---------------------------------------------------------------------*
*& Advanced Tab - Screen 1004
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF SCREEN 400 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b8 WITH FRAME TITLE text-t14.
    PARAMETERS: p_log   TYPE flag AS CHECKBOX MODIF ID a01,   " <=8
                p_paral TYPE flag AS CHECKBOX MODIF ID a02.   " <=8

    SELECTION-SCREEN SKIP.


    PARAMETERS: p_server TYPE char20 MODIF ID a03.
*    SELECTION-SCREEN COMMENT 1(20) text-t15 FOR FIELD p_server.
    SELECTION-SCREEN SKIP.
    PARAMETERS: p_maxrec TYPE i MODIF ID a04.
*    SELECTION-SCREEN COMMENT 1(20) text-t16 FOR FIELD p_maxrec.


    SELECTION-SCREEN SKIP.
    PARAMETERS: p_debug TYPE flag AS CHECKBOX MODIF ID a05,
                p_trace TYPE flag AS CHECKBOX MODIF ID a06.
  SELECTION-SCREEN END OF BLOCK b8.

  SELECTION-SCREEN BEGIN OF BLOCK b9 WITH FRAME TITLE text-t17.
    SELECT-OPTIONS: s_buffer FOR sy-datum MODIF ID a07.
    PARAMETERS: p_commit TYPE i MODIF ID a08.
  SELECTION-SCREEN END OF BLOCK b9.

SELECTION-SCREEN END OF SCREEN 400.

*INITIALIZATION.
*  PERFORM init_tab4.
*
*AT SELECTION-SCREEN OUTPUT.
*  PERFORM tab4_screen_output.

*AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_server.
*  PERFORM f4_server_list_tab4.

FORM init_tab4.
  p_log = 'X'.
  p_maxrec = 1000.
  p_commit = 100.
  p_server = 'APP_SERVER_01'.
ENDFORM.

FORM tab4_screen_output.
  LOOP AT SCREEN.
    CASE screen-group1.
      WHEN 'A02'.
        IF p_log IS INITIAL.
          screen-input = 0.
          MODIFY SCREEN.
        ENDIF.
      WHEN 'A04'.
        IF p_paral = 'X'.
          screen-required = 2.
        ELSE.
          screen-required = 0.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'A07'.
        IF p_debug = 'X'.
          screen-active = 1.
        ELSE.
          screen-active = 0.
        ENDIF.
        MODIFY SCREEN.
    ENDCASE.
  ENDLOOP.
ENDFORM.

FORM f4_server_list_tab4.
  DATA: lt_servers TYPE TABLE OF string.
  APPEND 'APP_SERVER_01' TO lt_servers.
  APPEND 'APP_SERVER_02' TO lt_servers.
  APPEND 'APP_SERVER_03' TO lt_servers.
  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield   = 'P_SERVER'
      dynpprog   = sy-repid
      dynpnr     = sy-dynnr
    TABLES
      value_tab  = lt_servers
    EXCEPTIONS
      OTHERS     = 0.
ENDFORM.