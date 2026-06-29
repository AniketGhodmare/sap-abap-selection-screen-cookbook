*&---------------------------------------------------------------------*
*& Report ZSS_09_F4_HELP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSS_09_F4_HELP.

************************************************************************
* Program : ZSS_09_F4_HELP
* Title   : F4 Help Demonstration
*
* Purpose:
*   Demonstrates Standard and Custom F4 Help on Selection Screen.
************************************************************************

TABLES:
  mara,
  kna1,
  vbak.

TYPE-POOLS vrm.

*---------------------------------------------------------------------*
* Type Declaration
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_material,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         meins TYPE mara-meins,
       END OF ty_material.

DATA:
  gt_material TYPE STANDARD TABLE OF ty_material,
  gt_return   TYPE STANDARD TABLE OF ddshretval.

*---------------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1
WITH FRAME TITLE text-001.

*---------------------------------------------------------------------*
* Standard F4 Help
* (Automatically available because of DDIC reference)
*---------------------------------------------------------------------*
PARAMETERS:
  p_kunnr TYPE kna1-kunnr.

PARAMETERS:
  p_vbeln TYPE vbak-vbeln.

*---------------------------------------------------------------------*
* Custom F4 Help
*---------------------------------------------------------------------*
PARAMETERS:
  p_matnr TYPE mara-matnr.

*---------------------------------------------------------------------*
* Select Options
*---------------------------------------------------------------------*
SELECT-OPTIONS:
  s_matnr FOR mara-matnr.

SELECTION-SCREEN END OF BLOCK b1.

*---------------------------------------------------------------------*
* Custom F4 for Parameter
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_matnr.

  PERFORM f4_material
    USING 'P_MATNR'.

*---------------------------------------------------------------------*
* Custom F4 for LOW
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON VALUE-REQUEST FOR s_matnr-low.

  PERFORM f4_material
    USING 'S_MATNR-LOW'.

*---------------------------------------------------------------------*
* Custom F4 for HIGH
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON VALUE-REQUEST FOR s_matnr-high.

  PERFORM f4_material
    USING 'S_MATNR-HIGH'.

*---------------------------------------------------------------------*
* Display
*---------------------------------------------------------------------*
START-OF-SELECTION.

WRITE:/ 'Customer     :', p_kunnr.
WRITE:/ 'Sales Order  :', p_vbeln.
WRITE:/ 'Material     :', p_matnr.

SKIP.

WRITE:/ 'Material Range'.

ULINE.

LOOP AT s_matnr.

  WRITE:/ s_matnr-sign,
          s_matnr-option,
          s_matnr-low,
          s_matnr-high.

ENDLOOP.

*---------------------------------------------------------------------*
* FORM : Custom F4 Help
*---------------------------------------------------------------------*
FORM f4_material
USING
  pv_field TYPE dynfnam.

  CLEAR:
    gt_material,
    gt_return.

  SELECT
      matnr,
      mtart,
      meins
  FROM mara
  INTO TABLE @gt_material
  UP TO 100 ROWS.

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield        = 'MATNR'
      dynpprog        = sy-repid
      dynpnr          = sy-dynnr
      dynprofield     = pv_field
      value_org       = 'S'
    TABLES
      value_tab       = gt_material
      return_tab      = gt_return
    EXCEPTIONS
      parameter_error = 1
      no_values_found = 2
      OTHERS          = 3.

  IF sy-subrc <> 0.

    MESSAGE 'No values found.' TYPE 'I'.

  ENDIF.

ENDFORM.