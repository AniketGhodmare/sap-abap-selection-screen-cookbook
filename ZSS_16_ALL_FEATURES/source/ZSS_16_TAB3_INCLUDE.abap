*&---------------------------------------------------------------------*
*& Include ZSS_15_TAB3_INCLUDE
*&---------------------------------------------------------------------*
*& Upload Tab - Screen 1003
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF SCREEN 300 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b6 WITH FRAME TITLE text-t09.
    PARAMETERS: p_file   TYPE string MODIF ID u01,
                p_folder TYPE string MODIF ID u02.
    SELECTION-SCREEN SKIP.
    PARAMETERS: p_test TYPE flag AS CHECKBOX MODIF ID u03. " <=8
    SELECTION-SCREEN SKIP.
    SELECTION-SCREEN PUSHBUTTON /40(20) pb_valid USER-COMMAND validate MODIF ID u04.
    SELECTION-SCREEN COMMENT 70(30) text-t10 .
*    SELECTION-SCREEN COMMENT 70(30) text-t10 FOR FIELD pb_valid.
    SELECTION-SCREEN PUSHBUTTON /40(20) pb_upld USER-COMMAND upload MODIF ID u04.
    SELECTION-SCREEN COMMENT 70(30) text-t11 .
*    SELECTION-SCREEN COMMENT 70(30) text-t11 FOR FIELD pb_upld.
  SELECTION-SCREEN END OF BLOCK b6.

  SELECTION-SCREEN BEGIN OF BLOCK b7 WITH FRAME TITLE text-t12.
    SELECTION-SCREEN COMMENT /1(75) text-t13.
    PARAMETERS: p_status TYPE char60 MODIF ID u05 NO-DISPLAY.
  SELECTION-SCREEN END OF BLOCK b7.

SELECTION-SCREEN END OF SCREEN 300.

*INITIALIZATION.
*  PERFORM init_tab3.

*AT SELECTION-SCREEN OUTPUT.
*  PERFORM tab3_screen_output.

*AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
*  PERFORM f4_file_browser_tab3.

*AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_folder.
*  PERFORM f4_folder_browser_tab3.

FORM init_tab3.
  p_test = 'X'.
  p_status = 'Ready for upload'.
ENDFORM.

FORM tab3_screen_output.
  LOOP AT SCREEN.
    IF screen-group1 = 'U04'.
      IF p_test IS INITIAL.
        screen-input = 1.
      ELSE.
        screen-input = 0.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.

FORM f4_file_browser_tab3.
  DATA: lt_file_table TYPE filetable,
        ls_file       TYPE file_table,
        lv_rc         TYPE i.
  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    EXPORTING
      window_title = 'Select Upload File'
    CHANGING
      file_table   = lt_file_table
      rc           = lv_rc
    EXCEPTIONS
      OTHERS       = 1.
  IF sy-subrc = 0 AND lt_file_table IS NOT INITIAL.
    READ TABLE lt_file_table INDEX 1 INTO ls_file.
    p_file = ls_file-filename.
  ENDIF.
ENDFORM.

FORM f4_folder_browser_tab3.
  DATA: lv_folder TYPE string.
  CALL METHOD cl_gui_frontend_services=>directory_browse
    EXPORTING
      window_title = 'Select Folder'
    CHANGING
      selected_folder = lv_folder
    EXCEPTIONS
      OTHERS       = 3.
  IF sy-subrc = 0.
    p_folder = lv_folder.
  ENDIF.
ENDFORM.