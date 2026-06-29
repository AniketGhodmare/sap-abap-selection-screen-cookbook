*&---------------------------------------------------------------------*
*& Report ZSS_12_SEARCH_HELP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSS_12_SEARCH_HELP.

************************************************************************
* Program : ZSS_12_SEARCH_HELP
* Title   : Standard Search Help Demonstration
*
* Purpose :
*   Demonstrates the usage of standard SAP Dictionary Search Helps.
************************************************************************

TABLES:
  mara,
  kna1,
  vbak,
  t001.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1
WITH FRAME TITLE text-001. "Standard Search Help

*-----------------------------------------------------------------------
* Automatic Search Help
*-----------------------------------------------------------------------

PARAMETERS:
  p_matnr TYPE mara-matnr,
  p_kunnr TYPE kna1-kunnr,
  p_vbeln TYPE vbak-vbeln,
  p_bukrs TYPE t001-bukrs.

*-----------------------------------------------------------------------
* Select Options
*-----------------------------------------------------------------------

SELECT-OPTIONS:
  s_matnr FOR mara-matnr,
  s_kunnr FOR kna1-kunnr.

SELECTION-SCREEN END OF BLOCK b1.

*---------------------------------------------------------------------*
* Explicit Search Help
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_bukrs.

  CALL FUNCTION 'F4IF_FIELD_VALUE_REQUEST'
    EXPORTING
      tabname   = 'T001'
      fieldname = 'BUKRS'.

*---------------------------------------------------------------------*
* Output
*---------------------------------------------------------------------*
START-OF-SELECTION.

WRITE:/ '========================================='.
WRITE:/ ' SEARCH HELP DEMONSTRATION'.
WRITE:/ '========================================='.

SKIP.

WRITE:/ 'Material      :', p_matnr.
WRITE:/ 'Customer      :', p_kunnr.
WRITE:/ 'Sales Order   :', p_vbeln.
WRITE:/ 'Company Code  :', p_bukrs.

SKIP.

WRITE:/ 'Material Range'.

ULINE.

LOOP AT s_matnr.

  WRITE:/ s_matnr-sign,
          s_matnr-option,
          s_matnr-low,
          s_matnr-high.

ENDLOOP.

SKIP.

WRITE:/ 'Customer Range'.

ULINE.

LOOP AT s_kunnr.

  WRITE:/ s_kunnr-sign,
          s_kunnr-option,
          s_kunnr-low,
          s_kunnr-high.

ENDLOOP.