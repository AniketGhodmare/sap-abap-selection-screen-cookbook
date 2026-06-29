*&---------------------------------------------------------------------*
*& Report ZSS_16_ALL_FEATURES
*&---------------------------------------------------------------------*
*& Sales Order Report - Complete Selection Screen Demo
*&---------------------------------------------------------------------*
*& This program demonstrates all selection screen features
*& using a modular template-based approach
*&---------------------------------------------------------------------*

REPORT zss_16_all_features
*       NO STANDARD PAGE HEADING
*       LINE-SIZE 132
*       LINE-COUNT 65
*       MESSAGE-ID 00
       .



"---------------------------------------------------------------------*
" INCLUDE ALL MODULES
"---------------------------------------------------------------------*

INCLUDE zss_16_top_include.
INCLUDE zss_16_tab1_include.
INCLUDE zss_16_tab2_include.
INCLUDE zss_16_tab3_include.
INCLUDE zss_16_tab4_include.
INCLUDE zss_16_validation_include.
INCLUDE zss_16_dynamic_include.
INCLUDE zss_16_processing_include.
INCLUDE zss_16_utility_include.
INCLUDE zss_16_events_include.

"---------------------------------------------------------------------*
" SELECTION SCREEN LAYOUT (Standard full-screen)
"---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK blk_main
  WITH FRAME TITLE TEXT-001.

  SELECTION-SCREEN BEGIN OF TABBED BLOCK tab_block FOR 14 LINES.
    SELECTION-SCREEN TAB (30) tab1 USER-COMMAND tab1 DEFAULT SCREEN 100.
    SELECTION-SCREEN TAB (30) tab2 USER-COMMAND tab2 DEFAULT SCREEN 200.
    SELECTION-SCREEN TAB (30) tab3 USER-COMMAND tab3 DEFAULT SCREEN 300.
    SELECTION-SCREEN TAB (30) tab4 USER-COMMAND tab4 DEFAULT SCREEN 400.
  SELECTION-SCREEN END OF BLOCK tab_block.

SELECTION-SCREEN END OF BLOCK blk_main.

SELECTION-SCREEN SKIP 1.
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE TEXT-t18.

  SELECTION-SCREEN PUSHBUTTON 1(10)  pb_val USER-COMMAND validate.
  SELECTION-SCREEN PUSHBUTTON 15(10) pb_res USER-COMMAND reset.
  SELECTION-SCREEN PUSHBUTTON 29(10) pb_pre USER-COMMAND preview.
  SELECTION-SCREEN PUSHBUTTON 43(10) pb_exe USER-COMMAND execute.
  SELECTION-SCREEN PUSHBUTTON 57(10) pb_exp USER-COMMAND export.
  SELECTION-SCREEN PUSHBUTTON 71(10) pb_exit USER-COMMAND exit.

SELECTION-SCREEN END OF BLOCK b0.


SELECTION-SCREEN FUNCTION KEY 1.
SELECTION-SCREEN FUNCTION KEY 2.
SELECTION-SCREEN FUNCTION KEY 3.

INITIALIZATION.

  tab1 = c_tab_general.
  tab2 = c_tab_selection.
  tab3 = c_tab_upload .
  tab4 = c_tab_advanced .

  pb_val  = TEXT-t19.
  pb_res  = TEXT-t20.
  pb_pre  = TEXT-t21.
  pb_exe  = TEXT-t22.
  pb_exp  = TEXT-t23.
  pb_exit = TEXT-t24.

  PERFORM init_tab1.
  PERFORM init_tab2.
  PERFORM init_tab3.
  PERFORM init_tab4.
  PERFORM set_function_keys.

  tab_block-prog      = sy-repid.
  tab_block-dynnr     = '0100'.
  tab_block-activetab = c_tab_general.