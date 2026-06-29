*&---------------------------------------------------------------------*
*& Include ZSS_15_TOP_INCLUDE
*&---------------------------------------------------------------------*
*& Global Data Definitions
*&---------------------------------------------------------------------*

TABLES: vbak, vbap, kna1, mara, t001w, T001L, usr21,sscrfields.

TYPES: BEGIN OF ty_selection_summary,
         employee      TYPE string,
         sales_org     TYPE string,
         distr_chan    TYPE string,
         division      TYPE string,
         date_from     TYPE d,
         date_to       TYPE d,
         date_type     TYPE c LENGTH 1,
         materials     TYPE string,
         customers     TYPE string,
         plants        TYPE string,
         stor_locs     TYPE string,
         orders        TYPE string,
         upload_file   TYPE string,
         upload_folder TYPE string,
         test_run      TYPE flag,
         logging       TYPE flag,
         parallel      TYPE flag,
         server        TYPE string,
         max_records   TYPE i,
       END OF ty_selection_summary.

DATA: gs_selection_summary TYPE ty_selection_summary,
      gt_mara              TYPE STANDARD TABLE OF mara,
      gt_kna1              TYPE STANDARD TABLE OF kna1,
      gt_vbak              TYPE STANDARD TABLE OF vbak,
      gt_t001w             TYPE STANDARD TABLE OF t001w,
      gt_orders            TYPE STANDARD TABLE OF vbak,
      gt_out               TYPE STANDARD TABLE OF string,
      gv_runtime           TYPE i,
      gv_records           TYPE i,
      gv_tab_act           TYPE sy-ucomm,
      gv_ok_code           TYPE sy-ucomm,
      gv_file              TYPE string,
      gv_folder            TYPE string,
      gv_message           TYPE string.


CONSTANTS: c_tab_general   TYPE sy-ucomm VALUE 'General',
           c_tab_selection TYPE sy-ucomm VALUE 'Selection',
           c_tab_upload    TYPE sy-ucomm VALUE 'Upload',
           c_tab_advanced  TYPE sy-ucomm VALUE 'Advance'.

DATA: BEGIN OF gs_fkey_text,
        fcode TYPE sy-ucomm,
        text  TYPE string,
      END OF gs_fkey_text.
DATA: gt_fkey_text LIKE STANDARD TABLE OF gs_fkey_text.