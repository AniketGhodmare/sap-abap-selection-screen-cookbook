*&---------------------------------------------------------------------*
*& Report ZSS_10_FILE_UPLOAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zss_10_file_upload.

************************************************************************
* Program : ZSS_10_FILE_UPLOAD
* Title   : Frontend File Selection Demo
*
* Purpose:
*   Demonstrates how to browse and select a file from the user's
*   local computer using F4 Help.
************************************************************************

*---------------------------------------------------------------------*
* Type Declaration
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_file,
         filename TYPE string,
       END OF ty_file.

DATA:
  gt_files TYPE filetable,
  gv_rc    TYPE i,
  gs_file  TYPE file_table.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1
  WITH FRAME TITLE TEXT-001.

  PARAMETERS:
    p_file TYPE rlgrap-filename OBLIGATORY.

  DATA:
    lv_file   TYPE string,
    lv_result TYPE abap_bool.

SELECTION-SCREEN END OF BLOCK b1.

*---------------------------------------------------------------------*
* F4 Help for File Selection
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  PERFORM browse_file.

*---------------------------------------------------------------------*
* Validation
*---------------------------------------------------------------------*
AT SELECTION-SCREEN.

  IF p_file IS INITIAL.
    MESSAGE 'Please select a file.' TYPE 'E'.
  ENDIF.

  lv_file = p_file.

  CALL METHOD cl_gui_frontend_services=>file_exist
    EXPORTING
      file   = lv_file
    RECEIVING
      result = DATA(lv_exists).

  IF lv_exists IS INITIAL.
    MESSAGE 'Selected file does not exist.' TYPE 'E'.
  ENDIF.

*---------------------------------------------------------------------*
* Start of Selection
*---------------------------------------------------------------------*
START-OF-SELECTION.

  WRITE:/ '========================================='.
  WRITE:/ '      FILE UPLOAD DEMONSTRATION'.
  WRITE:/ '========================================='.

  SKIP.

  WRITE:/ 'Selected File:'.
  WRITE:/ p_file.

  SKIP.

  WRITE:/ 'Program Executed Successfully.'.

*---------------------------------------------------------------------*
* FORM Browse File
*---------------------------------------------------------------------*
FORM browse_file.

  CLEAR:
    gt_files,
    gv_rc.

  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    EXPORTING
      window_title            = 'Select a File'
      default_extension       = 'xlsx'
      file_filter             =
                                'Excel Files (*.xlsx)|*.xlsx|CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|All Files (*.*)|*.*|'
      multiselection          = abap_false
    CHANGING
      file_table              = gt_files
      rc                      = gv_rc
    EXCEPTIONS
      file_open_dialog_failed = 1
      cntl_error              = 2
      error_no_gui            = 3
      not_supported_by_gui    = 4
      OTHERS                  = 5.

  IF sy-subrc <> 0.
    MESSAGE 'Unable to open file dialog.' TYPE 'E'.
  ENDIF.

  IF gv_rc > 0.

    READ TABLE gt_files INTO gs_file INDEX 1.

    IF sy-subrc = 0.
      p_file = gs_file-filename.
    ENDIF.

  ENDIF.

ENDFORM.