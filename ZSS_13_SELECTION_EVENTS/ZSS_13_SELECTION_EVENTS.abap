*&---------------------------------------------------------------------*
*& Report ZSS_13_SELECTION_EVENTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSS_13_SELECTION_EVENTS.

************************************************************************
* Program : ZSS_13_SELECTION_EVENTS
* Title   : Selection Screen Events Demonstration
*
* Purpose:
*   Demonstrates all major Selection Screen Events.
************************************************************************

TABLES:
  sscrfields,
  mara.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1
WITH FRAME TITLE text-001. " Basic Information

PARAMETERS:
  p_matnr TYPE mara-matnr,
  p_date  TYPE sy-datum,
  p_qty   TYPE i.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2
WITH FRAME TITLE text-002. "Processing Mode

PARAMETERS:
  p_create RADIOBUTTON GROUP grp DEFAULT 'X'
           USER-COMMAND rad,

  p_change RADIOBUTTON GROUP grp,

  p_dis RADIOBUTTON GROUP grp.

SELECTION-SCREEN END OF BLOCK b2.

*---------------------------------------------------------------------*
* INITIALIZATION
*---------------------------------------------------------------------*
INITIALIZATION.

  p_date = sy-datum.
  p_qty  = 10.

*---------------------------------------------------------------------*
* OUTPUT EVENT
*---------------------------------------------------------------------*
AT SELECTION-SCREEN OUTPUT.

* Executed every time before the screen is displayed.

  LOOP AT SCREEN.

    IF p_dis = 'X'
       AND screen-name = 'P_QTY'.

      screen-input = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

*---------------------------------------------------------------------*
* FIELD VALIDATION
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON p_qty.

  IF p_qty <= 0.

    MESSAGE 'Quantity must be greater than zero.'
    TYPE 'E'.

  ENDIF.

*---------------------------------------------------------------------*
* BLOCK VALIDATION
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON BLOCK b1.

  IF p_matnr IS INITIAL
     AND p_qty > 100.

    MESSAGE
    'Material is mandatory when Quantity > 100'
    TYPE 'E'.

  ENDIF.

*---------------------------------------------------------------------*
* RADIO BUTTON EVENT
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON RADIOBUTTON GROUP grp.

  CASE 'X'.

    WHEN p_create.

      MESSAGE 'Create Mode Selected'
      TYPE 'S'.

    WHEN p_change.

      MESSAGE 'Change Mode Selected'
      TYPE 'S'.

    WHEN p_dis.

      MESSAGE 'Display Mode Selected'
      TYPE 'S'.

  ENDCASE.

*---------------------------------------------------------------------*
* F4 HELP
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_matnr.

  MESSAGE
  'Custom F4 Help can be implemented here.'
  TYPE 'I'.

*---------------------------------------------------------------------*
* F1 HELP
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON HELP-REQUEST FOR p_matnr.

  MESSAGE
  'Enter a valid Material Number.'
  TYPE 'I'.

*---------------------------------------------------------------------*
* GENERAL VALIDATION
*---------------------------------------------------------------------*
AT SELECTION-SCREEN.

  IF p_date > sy-datum.

    MESSAGE
    'Future Date is not allowed.'
    TYPE 'E'.

  ENDIF.

*---------------------------------------------------------------------*
* START OF SELECTION
*---------------------------------------------------------------------*
START-OF-SELECTION.

WRITE:/ '=========================================='.
WRITE:/ ' SELECTION SCREEN EVENTS DEMONSTRATION'.
WRITE:/ '=========================================='.

SKIP.

WRITE:/ 'Material :', p_matnr.
WRITE:/ 'Date     :', p_date.
WRITE:/ 'Quantity :', p_qty.

SKIP.

IF p_create = 'X'.

  WRITE:/ 'Mode : CREATE'.

ELSEIF p_change = 'X'.

  WRITE:/ 'Mode : CHANGE'.

ELSE.

  WRITE:/ 'Mode : DISPLAY'.

ENDIF.

*---------------------------------------------------------------------*
* END OF SELECTION
*---------------------------------------------------------------------*
END-OF-SELECTION.

SKIP.

WRITE:/ 'End of Report.'.