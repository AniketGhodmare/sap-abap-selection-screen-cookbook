*&---------------------------------------------------------------------*
*& Report ZSS_08_VALIDATION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSS_08_VALIDATION.

************************************************************************
* Program  : ZSS_08_VALIDATION
* Title    : Selection Screen Validation Demo
*
* Purpose:
*   Demonstrates different validation techniques available on the
*   selection screen.
************************************************************************

TABLES:
  mara,
  vbak.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1
WITH FRAME TITLE text-001.

PARAMETERS:
  p_name  TYPE char30 OBLIGATORY,
  p_age   TYPE i,
  p_date  TYPE sy-datum DEFAULT sy-datum,
  p_email TYPE char50 LOWER CASE.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2
WITH FRAME TITLE text-002.

PARAMETERS:
  p_vbeln TYPE vbak-vbeln,
  p_matnr TYPE mara-matnr.

SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b3
WITH FRAME TITLE text-003.

SELECT-OPTIONS:
  s_date FOR sy-datum,
  s_matnr FOR mara-matnr.

SELECTION-SCREEN END OF BLOCK b3.

************************************************************************
* Validation for Name
************************************************************************
AT SELECTION-SCREEN ON p_name.

  IF strlen( p_name ) < 3.
    MESSAGE 'Name must contain at least 3 characters.' TYPE 'E'.
  ENDIF.

************************************************************************
* Validation for Age
************************************************************************
AT SELECTION-SCREEN ON p_age.

  IF p_age < 18.
    MESSAGE 'Age should be greater than or equal to 18.' TYPE 'E'.
  ENDIF.

  IF p_age > 100.
    MESSAGE 'Age looks unusually high.' TYPE 'W'.
  ENDIF.

************************************************************************
* Validation for Date
************************************************************************
AT SELECTION-SCREEN ON p_date.

  IF p_date > sy-datum.
    MESSAGE 'Future date is not allowed.' TYPE 'E'.
  ENDIF.

************************************************************************
* Validation for Email
************************************************************************
AT SELECTION-SCREEN ON p_email.

  IF p_email IS NOT INITIAL
     AND p_email NP '*@*.*'.

    MESSAGE 'Invalid Email Address.' TYPE 'E'.

  ENDIF.

************************************************************************
* Validation for Sales Order
************************************************************************
AT SELECTION-SCREEN ON p_vbeln.

  IF p_vbeln IS NOT INITIAL.

    SELECT SINGLE vbeln
      FROM vbak
      INTO @DATA(lv_vbeln)
      WHERE vbeln = @p_vbeln.

    IF sy-subrc <> 0.
      MESSAGE 'Sales Order does not exist.' TYPE 'E'.
    ENDIF.

  ENDIF.

************************************************************************
* Validation at END OF Select-Option
************************************************************************
AT SELECTION-SCREEN ON END OF s_date.

  LOOP AT s_date.

    IF s_date-low > sy-datum.

      MESSAGE 'Future Date Range is not allowed.' TYPE 'E'.

    ENDIF.

  ENDLOOP.

************************************************************************
* Validation on Entire Block
************************************************************************
AT SELECTION-SCREEN ON BLOCK b2.

  IF p_vbeln IS INITIAL
     AND p_matnr IS INITIAL.

    MESSAGE
    'Enter either Sales Order or Material.'
    TYPE 'E'.

  ENDIF.

************************************************************************
* General Validation
************************************************************************
AT SELECTION-SCREEN.

*-----------------------------------------------------------------------
* Cross Field Validation
*-----------------------------------------------------------------------

  IF p_age >= 60
     AND + P_DATE > sy-datum - 365.

    MESSAGE
    'Senior users should not have registration date within last year.'
    TYPE 'W'.

  ENDIF.

************************************************************************
* Output
************************************************************************
START-OF-SELECTION.

WRITE:/ '======================================'.
WRITE:/ ' SELECTION SCREEN VALIDATION DEMO'.
WRITE:/ '======================================'.

SKIP.

WRITE:/ 'Name        :', p_name.
WRITE:/ 'Age         :', p_age.
WRITE:/ 'Date        :', p_date.
WRITE:/ 'Email       :', p_email.
WRITE:/ 'Sales Order :', p_vbeln.
WRITE:/ 'Material    :', p_matnr.

SKIP.

WRITE:/ 'Date Ranges'.

ULINE.

LOOP AT s_date.

  WRITE:/ s_date-sign,
          s_date-option,
          s_date-low,
          s_date-high.

ENDLOOP.

SKIP.

WRITE:/ 'Material Ranges'.

ULINE.

LOOP AT s_matnr.

  WRITE:/ s_matnr-sign,
          s_matnr-option,
          s_matnr-low,
          s_matnr-high.

ENDLOOP.

SKIP.

WRITE:/ 'Program Executed Successfully.'.


*| Text ID  | Description       |
*| -------- | ----------------- |
*| TEXT-001 | Basic Information |
*| TEXT-002 | Business Data     |
*| TEXT-003 | Range Selection   |