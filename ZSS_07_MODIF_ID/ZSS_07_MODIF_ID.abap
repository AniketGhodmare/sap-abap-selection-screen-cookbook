*&---------------------------------------------------------------------*
*& Report ZSS_07_MODIF_ID
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSS_07_MODIF_ID.

************************************************************************
* Program  : ZSS_07_MODIF_ID
* Title    : MODIF ID Demonstration
*
* Purpose:
*   Demonstrates dynamic selection screen modification using MODIF ID.
*
* Topics Covered:
*   1. MODIF ID
*   2. LOOP AT SCREEN
*   3. SCREEN-ACTIVE
*   4. SCREEN-INPUT
*   5. SCREEN-INVISIBLE
*   6. SCREEN-REQUIRED
*   7. USER-COMMAND
************************************************************************

TABLES sscrfields.

*---------------------------------------------------------------------*
* Block 1 : Processing Mode
*---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1
WITH FRAME TITLE text-001.

PARAMETERS:
  p_cre RADIOBUTTON GROUP g1 DEFAULT 'X' USER-COMMAND rad,
  p_cha RADIOBUTTON GROUP g1,
  p_dis RADIOBUTTON GROUP g1,
  p_del RADIOBUTTON GROUP g1.

SELECTION-SCREEN END OF BLOCK b1.

*---------------------------------------------------------------------*
* Block 2 : Sales Order Details
*---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b2
WITH FRAME TITLE text-002.

PARAMETERS:
  p_vbeln TYPE vbak-vbeln MODIF ID SO.

PARAMETERS:
  p_kunnr TYPE kna1-kunnr MODIF ID SO.

PARAMETERS:
  p_reason TYPE char40 MODIF ID DEL.

PARAMETERS:
  p_secret TYPE char20 MODIF ID HID.

SELECTION-SCREEN END OF BLOCK b2.

*---------------------------------------------------------------------*
* Dynamic Screen Modification
*---------------------------------------------------------------------*
AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

*-----------------------------------------------------------------------
* CREATE MODE
*-----------------------------------------------------------------------
    IF p_cre = 'X'.

* Hide Delete Reason
      IF screen-group1 = 'DEL'.
        screen-active = 0.
      ENDIF.

* Hide Secret Field
      IF screen-group1 = 'HID'.
        screen-active = 0.
      ENDIF.

*-----------------------------------------------------------------------
* CHANGE MODE
*-----------------------------------------------------------------------
    ELSEIF p_cha = 'X'.

* Disable Sales Order
      IF screen-group1 = 'SO'
      AND screen-name = 'P_VBELN'.

        screen-input = 0.

      ENDIF.

* Hide Delete Reason
      IF screen-group1 = 'DEL'.

        screen-active = 0.

      ENDIF.

*-----------------------------------------------------------------------
* DISPLAY MODE
*-----------------------------------------------------------------------
    ELSEIF p_dis = 'X'.

* Display Only
      IF screen-group1 = 'SO'.

        screen-input = 0.

      ENDIF.

* Hide Delete Reason
      IF screen-group1 = 'DEL'.

        screen-active = 0.

      ENDIF.

*-----------------------------------------------------------------------
* DELETE MODE
*-----------------------------------------------------------------------
    ELSEIF p_del = 'X'.

* Show Delete Reason
      IF screen-group1 = 'DEL'.

        screen-active = 1.
        screen-required = 1.

      ENDIF.

* Hide Secret Field
      IF screen-group1 = 'HID'.

        screen-invisible = 1.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

*---------------------------------------------------------------------*
* Validation
*---------------------------------------------------------------------*
AT SELECTION-SCREEN.
* Skip validations when a radio button was just clicked
  IF sscrfields-ucomm = 'RAD'.
    RETURN.
  ENDIF.

  IF p_del = 'X'
  AND p_reason IS INITIAL.

    MESSAGE 'Delete Reason is mandatory.' TYPE 'E'.

  ENDIF.

*---------------------------------------------------------------------*
* Output
*---------------------------------------------------------------------*
START-OF-SELECTION.

WRITE:/ '====================================='.
WRITE:/ ' MODIF ID DEMONSTRATION'.
WRITE:/ '====================================='.

SKIP.

IF p_cre = 'X'.
  WRITE:/ 'Mode : CREATE'.
ELSEIF p_cha = 'X'.
  WRITE:/ 'Mode : CHANGE'.
ELSEIF p_dis = 'X'.
  WRITE:/ 'Mode : DISPLAY'.
ELSE.
  WRITE:/ 'Mode : DELETE'.
ENDIF.

SKIP.

WRITE:/ 'Sales Order :', p_vbeln.
WRITE:/ 'Customer    :', p_kunnr.

IF p_del = 'X'.
  WRITE:/ 'Delete Reason :', p_reason.
ENDIF.

WRITE:/ 'Program Executed Successfully.'.


*| Text     | Description         |
*| -------- | ------------------- |
*| TEXT-001 | Processing Mode     |
*| TEXT-002 | Sales Order Details |