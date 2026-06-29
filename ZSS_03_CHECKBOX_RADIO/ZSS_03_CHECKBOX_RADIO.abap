*&---------------------------------------------------------------------*
*& Report ZSS_03_CHECKBOX_RADIO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zss_03_checkbox_radio.

************************************************************************
* Program  : ZSS_03_CHECKBOX_RADIO
* Title    : Checkboxes and Radio Buttons Demo
*
* Purpose:
*   Demonstrates the usage of:
*     - Checkboxes
*     - Radio Button Groups
*     - USER-COMMAND
*     - Dynamic Screen Modification (MODIF ID)
*     - Validation
************************************************************************

TABLES sscrfields.

*-----------------------------------------------------------------------
* Text Symbols
*-----------------------------------------------------------------------
* 001  Processing Mode
* 002  Additional Options
* 003  Mode Specific Fields
*-----------------------------------------------------------------------

*---------------------------------------------------------------------*
* Block 1 : Processing Mode (radio buttons)
*---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1
  WITH FRAME TITLE TEXT-001.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 1(18) TEXT-004.

    PARAMETERS:
      p_cre RADIOBUTTON GROUP grp DEFAULT 'X' USER-COMMAND rad.

    SELECTION-SCREEN COMMENT 23(8) TEXT-005.

    PARAMETERS:
      p_cha RADIOBUTTON GROUP grp.

    SELECTION-SCREEN COMMENT 36(8) TEXT-006.

    PARAMETERS:
      p_dis RADIOBUTTON GROUP grp.

    SELECTION-SCREEN COMMENT 50(8) TEXT-007.

    PARAMETERS:
      p_del RADIOBUTTON GROUP grp.

    SELECTION-SCREEN COMMENT 63(8) TEXT-008.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK b1.

*---------------------------------------------------------------------*
* Block 2 : Output Options (Checkboxes)
*---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b2
  WITH FRAME TITLE TEXT-002.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 1(18) TEXT-009.

    PARAMETERS:
      p_alv AS CHECKBOX DEFAULT 'X'.

    SELECTION-SCREEN COMMENT 23(6) TEXT-010.

    PARAMETERS:
      p_excel AS CHECKBOX.

    SELECTION-SCREEN COMMENT 34(8) TEXT-011.

    PARAMETERS:
      p_email AS CHECKBOX.

    SELECTION-SCREEN COMMENT 48(8) TEXT-012.

    PARAMETERS:
      p_print AS CHECKBOX.

    SELECTION-SCREEN COMMENT 62(8) TEXT-013.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK b2.

*---------------------------------------------------------------------*
* Block 3 : Mode Specific Fields
*---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b3
  WITH FRAME TITLE TEXT-003.

  PARAMETERS:
    p_vbeln TYPE vbak-vbeln MODIF ID crt.

  PARAMETERS:
    p_reason TYPE char40 MODIF ID del.

SELECTION-SCREEN END OF BLOCK b3.

*-----------------------------------------------------------------------
* Dynamic Screen
*-----------------------------------------------------------------------

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF screen-group1 = 'DEL'.

      IF p_del = 'X'.
        screen-active = 1.
      ELSE.
        screen-active = 0.
      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

*-----------------------------------------------------------------------
* Validation
*-----------------------------------------------------------------------

AT SELECTION-SCREEN.

*  Skip validations when a radio button was just clicked
  IF sscrfields-ucomm = 'RAD'.
    RETURN.
  ENDIF.

*-----------------------------------------------------------------------
* Delete reason mandatory
*-----------------------------------------------------------------------

  IF p_del = 'X' AND p_reason IS INITIAL.

    MESSAGE 'Please enter delete reason.' TYPE 'E'.

  ENDIF.

*-----------------------------------------------------------------------
* At least one output option
*-----------------------------------------------------------------------

  IF p_alv IS INITIAL
  AND p_excel IS INITIAL
  AND p_email IS INITIAL
  AND p_print IS INITIAL.

    MESSAGE 'Select at least one output option.' TYPE 'E'.

  ENDIF.

*-----------------------------------------------------------------------
* Start of Selection
*-----------------------------------------------------------------------

START-OF-SELECTION.

  WRITE:/ '========================================='.
  WRITE:/ 'CHECKBOX & RADIO BUTTON DEMONSTRATION'.
  WRITE:/ '========================================='.

  SKIP.

*-----------------------------------------------------------------------
* Selected Mode
*-----------------------------------------------------------------------

  WRITE:/ 'Selected Processing Mode'.

  ULINE.

  IF p_cre = 'X'.
    WRITE:/ 'CREATE'.
  ELSEIF p_cha = 'X'.
    WRITE:/ 'CHANGE'.
  ELSEIF p_dis = 'X'.
    WRITE:/ 'DISPLAY'.
  ELSEIF p_del = 'X'.
    WRITE:/ 'DELETE'.
  ENDIF.

  SKIP.

*-----------------------------------------------------------------------
* Selected Options
*-----------------------------------------------------------------------

  WRITE:/ 'Selected Output Options'.

  ULINE.

  IF p_alv = 'X'.
    WRITE:/ 'ALV Output'.
  ENDIF.

  IF p_excel = 'X'.
    WRITE:/ 'Excel Export'.
  ENDIF.

  IF p_email = 'X'.
    WRITE:/ 'Email Notification'.
  ENDIF.

  IF p_print = 'X'.
    WRITE:/ 'Print Output'.
  ENDIF.

  SKIP.

  WRITE:/ 'Sales Order :', p_vbeln.

  IF p_del = 'X'.
    WRITE:/ 'Delete Reason:', p_reason.
  ENDIF.

  WRITE:/.
  WRITE:/ 'Program Executed Successfully.'.




*| Text     | Description          |
*| -------- | -------------------- |
*| TEXT-001 | Processing Mode      |
*| TEXT-002 | Output Options       |
*| TEXT-003 | Mode Specific Fields |
*| TEXT-004 | Mode :               |
*| TEXT-005 | Create               |
*| TEXT-006 | Change               |
*| TEXT-007 | Display              |
*| TEXT-008 | Delete               |
*| TEXT-009 | Output :             |
*| TEXT-010 | ALV                  |
*| TEXT-011 | Excel                |
*| TEXT-012 | Email                |
*| TEXT-013 | Print                |