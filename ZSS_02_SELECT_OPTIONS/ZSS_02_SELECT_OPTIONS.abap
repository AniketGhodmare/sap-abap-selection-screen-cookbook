*&---------------------------------------------------------------------*
*& Report ZSS_02_SELECT_OPTIONS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zss_02_select_options.

************************************************************************
* Program        : ZSS_02_SELECT_OPTIONS
* Title          : SELECT-OPTIONS Demonstration
* Author         : Demo
*
* Purpose:
*   Demonstrates different ways of using SELECT-OPTIONS in SAP ABAP.
*
* Topics Covered
*   1. Character Range
*   2. Material Range
*   3. Customer Range
*   4. Sales Order Range
*   5. Date Range
*   6. Integer Range
*   7. Currency Range
*   8. Default Values
*   9. Validation
*  10. Reading Internal Selection Table
************************************************************************

TABLES:
  mara,
  kna1,
  vbak,t001.

************************************************************************
* Selection Screen
************************************************************************

SELECTION-SCREEN BEGIN OF BLOCK b1
  WITH FRAME TITLE TEXT-001. "SELECT-OPTIONS Demonstration

*-----------------------------------------------------------------------
* Character Range
*-----------------------------------------------------------------------
  SELECT-OPTIONS:
  s_char FOR sy-uname.

*-----------------------------------------------------------------------
* Material Number
*-----------------------------------------------------------------------
  SELECT-OPTIONS:
  s_matnr FOR mara-matnr.

*-----------------------------------------------------------------------
* Customer Number
*-----------------------------------------------------------------------
  SELECT-OPTIONS:
  s_kunnr FOR kna1-kunnr.

*-----------------------------------------------------------------------
* Sales Order Number
*-----------------------------------------------------------------------
  SELECT-OPTIONS:
  s_vbeln FOR vbak-vbeln.

*-----------------------------------------------------------------------
* Date Range
*-----------------------------------------------------------------------
  SELECT-OPTIONS:
  s_date FOR sy-datum.

*-----------------------------------------------------------------------
* Integer Range
*-----------------------------------------------------------------------
  SELECT-OPTIONS:
  s_int FOR sy-tabix.

*-----------------------------------------------------------------------
* Currency Key
*-----------------------------------------------------------------------
  SELECT-OPTIONS:
  s_curr FOR t001-waers.

SELECTION-SCREEN END OF BLOCK b1.

************************************************************************
* Initialization
************************************************************************

INITIALIZATION.

*-----------------------------------------------------------------------
* Default Material Range
*-----------------------------------------------------------------------

  s_matnr-sign = 'I'.
  s_matnr-option = 'BT'.
  s_matnr-low = '000000000000000001'.
  s_matnr-high = '000000000000000100'.
  APPEND s_matnr.

*-----------------------------------------------------------------------
* Default Date
*-----------------------------------------------------------------------

  CLEAR s_date.

  s_date-sign = 'I'.
  s_date-option = 'BT'.
  s_date-low = sy-datum - 30.
  s_date-high = sy-datum.
  APPEND s_date.

************************************************************************
* Validation
************************************************************************

AT SELECTION-SCREEN.

*-----------------------------------------------------------------------
* Check Integer Range
*-----------------------------------------------------------------------

  LOOP AT s_int.

    IF s_int-low < 0.

      MESSAGE 'Negative numbers are not allowed.'
      TYPE 'E'.

    ENDIF.

  ENDLOOP.

************************************************************************
* Start of Selection
************************************************************************

START-OF-SELECTION.

  WRITE:/ '==============================================='.
  WRITE:/ '      SELECT-OPTIONS DEMONSTRATION'.
  WRITE:/ '==============================================='.

  SKIP.

***********************************************************************
* Material
***********************************************************************

  WRITE:/ 'Material Selection'.

  ULINE.

  LOOP AT s_matnr.

    WRITE:/ 'SIGN    :', s_matnr-sign.
    WRITE:/ 'OPTION  :', s_matnr-option.
    WRITE:/ 'LOW     :', s_matnr-low.
    WRITE:/ 'HIGH    :', s_matnr-high.

    SKIP.

  ENDLOOP.

***********************************************************************
* Customer
***********************************************************************

  WRITE:/ 'Customer Selection'.

  ULINE.

  LOOP AT s_kunnr.

    WRITE:/ 'SIGN    :', s_kunnr-sign.
    WRITE:/ 'OPTION  :', s_kunnr-option.
    WRITE:/ 'LOW     :', s_kunnr-low.
    WRITE:/ 'HIGH    :', s_kunnr-high.

    SKIP.

  ENDLOOP.

***********************************************************************
* Sales Order
***********************************************************************

  WRITE:/ 'Sales Order Selection'.

  ULINE.

  LOOP AT s_vbeln.

    WRITE:/ 'SIGN    :', s_vbeln-sign.
    WRITE:/ 'OPTION  :', s_vbeln-option.
    WRITE:/ 'LOW     :', s_vbeln-low.
    WRITE:/ 'HIGH    :', s_vbeln-high.

    SKIP.

  ENDLOOP.

***********************************************************************
* Date
***********************************************************************

  WRITE:/ 'Date Selection'.

  ULINE.

  LOOP AT s_date.

    WRITE:/ 'SIGN    :', s_date-sign.
    WRITE:/ 'OPTION  :', s_date-option.
    WRITE:/ 'LOW     :', s_date-low.
    WRITE:/ 'HIGH    :', s_date-high.

    SKIP.

  ENDLOOP.

***********************************************************************
* Integer
***********************************************************************

  WRITE:/ 'Integer Selection'.

  ULINE.

  LOOP AT s_int.

    WRITE:/ 'SIGN    :', s_int-sign.
    WRITE:/ 'OPTION  :', s_int-option.
    WRITE:/ 'LOW     :', s_int-low.
    WRITE:/ 'HIGH    :', s_int-high.

    SKIP.

  ENDLOOP.

***********************************************************************
* Currency
***********************************************************************

  WRITE:/ 'Currency Selection'.

  ULINE.

  LOOP AT s_curr.

    WRITE:/ 'SIGN    :', s_curr-sign.
    WRITE:/ 'OPTION  :', s_curr-option.
    WRITE:/ 'LOW     :', s_curr-low.
    WRITE:/ 'HIGH    :', s_curr-high.

    SKIP.

  ENDLOOP.

***********************************************************************
* Character
***********************************************************************

  WRITE:/ 'Character Selection'.

  ULINE.

  LOOP AT s_char.

    WRITE:/ 'SIGN    :', s_char-sign.
    WRITE:/ 'OPTION  :', s_char-option.
    WRITE:/ 'LOW     :', s_char-low.
    WRITE:/ 'HIGH    :', s_char-high.

    SKIP.

  ENDLOOP.