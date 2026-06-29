************************************************************************
* Program : ZSS_15_ALL_FEATURES
* Title   : ABAP Selection Screen Complete Cookbook
*
* Part    : 1 (Framework)
*
* Purpose :
*   Production Ready Framework
*
*   - 4 Working Tabs
*   - Function Keys
*   - Push Button
*   - Proper Navigation
*   - Ready for Extension
************************************************************************

REPORT zss_15_all_features.

TABLES sscrfields.

************************************************************************
* Function Keys
************************************************************************

SELECTION-SCREEN FUNCTION KEY 1.
SELECTION-SCREEN FUNCTION KEY 2.
SELECTION-SCREEN FUNCTION KEY 3.

************************************************************************
* Push Button
************************************************************************

*DATA gv_validate(20).

************************************************************************
* Main Block
************************************************************************

SELECTION-SCREEN BEGIN OF BLOCK blk_main
  WITH FRAME TITLE TEXT-001.

************************************************************************
* Tab Strip
************************************************************************

  SELECTION-SCREEN BEGIN OF TABBED BLOCK tb_main
    FOR 16 LINES. "This specifies how much vertical space the tab area occupies.

    SELECTION-SCREEN TAB (18) tab_gen "The number inside parentheses specifies the width of the tab label
      USER-COMMAND tab1
      DEFAULT SCREEN 100.

    SELECTION-SCREEN TAB (18) tab_sel
      USER-COMMAND tab2
      DEFAULT SCREEN 200.

    SELECTION-SCREEN TAB (18) tab_upl
      USER-COMMAND tab3
      DEFAULT SCREEN 300.

    SELECTION-SCREEN TAB (18) tab_adv
      USER-COMMAND tab4
      DEFAULT SCREEN 400.

  SELECTION-SCREEN END OF BLOCK tb_main.

SELECTION-SCREEN END OF BLOCK blk_main.

************************************************************************
* Bottom Push Button
************************************************************************

SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF LINE.

  SELECTION-SCREEN PUSHBUTTON
    30(20)
    gv_val
    USER-COMMAND vald.

SELECTION-SCREEN END OF LINE.

************************************************************************
* TAB 1
************************************************************************

SELECTION-SCREEN BEGIN OF SCREEN 100 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b1
    WITH FRAME TITLE TEXT-002.

    SELECTION-SCREEN COMMENT /2(50) TEXT-006.

    PARAMETERS dummy1 TYPE char20.

  SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN END OF SCREEN 100.

************************************************************************
* TAB 2
************************************************************************

SELECTION-SCREEN BEGIN OF SCREEN 200 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b2
    WITH FRAME TITLE TEXT-003.

    SELECTION-SCREEN COMMENT /2(50) TEXT-007.

    PARAMETERS dummy2 TYPE char20.

  SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN END OF SCREEN 200.

************************************************************************
* TAB 3
************************************************************************

SELECTION-SCREEN BEGIN OF SCREEN 300 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b3
    WITH FRAME TITLE TEXT-004.

    SELECTION-SCREEN COMMENT /2(50) TEXT-008.

    PARAMETERS dummy3 TYPE char20.

  SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN END OF SCREEN 300.

************************************************************************
* TAB 4
************************************************************************

SELECTION-SCREEN BEGIN OF SCREEN 400 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b4
    WITH FRAME TITLE TEXT-005.

    SELECTION-SCREEN COMMENT /2(50) TEXT-009.

    PARAMETERS dummy4 TYPE char20.

  SELECTION-SCREEN END OF BLOCK b4.

SELECTION-SCREEN END OF SCREEN 400.

************************************************************************
* INITIALIZATION
************************************************************************

INITIALIZATION.

* Tab Titles

  tab_gen     = 'General'.
  tab_sel     = 'Selection'.
  tab_upl  = 'Upload'.
  tab_adv     = 'Advanced'.

* Default Tab

  tb_main-prog      = sy-repid.
  tb_main-dynnr     = '0100'.
  tb_main-activetab = 'TAB1'.

* Push Button

  gv_val = 'Validate'.

* Function Keys

  sscrfields-functxt_01 = 'Help'.
  sscrfields-functxt_02 = 'Reset'.
  sscrfields-functxt_03 = 'About'.

************************************************************************
* Dynamic Screen
************************************************************************

AT SELECTION-SCREEN OUTPUT.

  tb_main-prog = sy-repid.

************************************************************************
* Selection Screen Events
************************************************************************

AT SELECTION-SCREEN.

  CASE sscrfields-ucomm.

    WHEN 'TAB1'.

      tb_main-dynnr = '0100'.

    WHEN 'TAB2'.

      tb_main-dynnr = '0200'.

    WHEN 'TAB3'.

      tb_main-dynnr = '0300'.

    WHEN 'TAB4'.

      tb_main-dynnr = '0400'.

    WHEN 'VALD'.

      MESSAGE
        'Validation will be implemented later.'
        TYPE 'I'.

    WHEN 'FC01'.

      MESSAGE
        'Help will be implemented later.'
        TYPE 'I'.

    WHEN 'FC02'.

      CLEAR:
        dummy1,
        dummy2,
        dummy3,
        dummy4.

      MESSAGE
        'Screen Reset.'
        TYPE 'S'.

    WHEN 'FC03'.

      MESSAGE
        'ABAP Selection Screen Cookbook'
        TYPE 'I'.

  ENDCASE.

************************************************************************
* Start of Selection
************************************************************************

START-OF-SELECTION.

  WRITE:/ '========================================='.
  WRITE:/ ' ZSS_15_ALL_FEATURES'.
  WRITE:/ '========================================='.

  WRITE:/ 'Framework Loaded Successfully'.

  WRITE:/ 'Current Screen :', tb_main-dynnr.







*| ID  | Text                   |
*| --- | ---------------------- |
*| 001 | Sales Order Management |
*| 002 | General Information    |
*| 003 | Selection Criteria     |
*| 004 | Upload Center          |
*| 005 | Advanced Options       |
*| 006 | General tab (Part 2)   |
*| 007 | Selection tab (Part 3) |
*| 008 | Upload tab (Part 4)    |
*| 009 | Advanced tab (Part 5)  |