*&---------------------------------------------------------------------*
*& Report ZSS_11_FOLDER_BROWSER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSS_11_FOLDER_BROWSER.

************************************************************************
* Program : ZSS_11_FOLDER_BROWSER
* Title   : Folder Browser Demonstration
*
* Purpose:
*   Demonstrates how to browse and select a folder
*   from the user's local computer.
*
* Author  : Demo
************************************************************************

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1
WITH FRAME TITLE text-001. "Folder Browser Demonstration
PARAMETERS:
  p_folder TYPE string LOWER CASE OBLIGATORY.

SELECTION-SCREEN END OF BLOCK b1.

*---------------------------------------------------------------------*
* F4 Help
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_folder.

  PERFORM browse_folder.

*---------------------------------------------------------------------*
* Validation
*---------------------------------------------------------------------*
AT SELECTION-SCREEN.

  IF p_folder IS INITIAL.

    MESSAGE 'Please select a folder.' TYPE 'E'.

  ENDIF.

*---------------------------------------------------------------------*
* Output
*---------------------------------------------------------------------*
START-OF-SELECTION.

  WRITE:/ '=========================================='.
  WRITE:/ '     FOLDER BROWSER DEMONSTRATION'.
  WRITE:/ '=========================================='.

  SKIP.

  WRITE:/ 'Selected Folder :'.

  WRITE:/ p_folder.

  SKIP.

  WRITE:/ 'Program Executed Successfully.'.

*---------------------------------------------------------------------*
* FORM Browse Folder
*---------------------------------------------------------------------*
FORM browse_folder.

  DATA:
    lv_folder TYPE string.

  lv_folder = p_folder.

  CALL METHOD cl_gui_frontend_services=>directory_browse
    EXPORTING
      window_title    = 'Select Folder'
      initial_folder  = lv_folder
    CHANGING
      selected_folder = lv_folder
    EXCEPTIONS
      cntl_error            = 1
      error_no_gui          = 2
      not_supported_by_gui  = 3
      OTHERS                = 4.

  IF sy-subrc = 0.

    p_folder = lv_folder.

  ELSE.

    MESSAGE 'Unable to open Folder Browser.' TYPE 'I'.

  ENDIF.

ENDFORM.