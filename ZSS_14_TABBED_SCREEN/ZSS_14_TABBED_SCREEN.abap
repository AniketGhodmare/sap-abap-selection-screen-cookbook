*&---------------------------------------------------------------------*
*& Report ZSS_14_TABBED_SCREEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSS_14_TABBED_SCREEN.

************************************************************************
* Program : ZSS_14_TABBED_SCREEN
* Title   : Tabbed Selection Screen Demonstration
*
* Purpose:
*   Demonstrates how to create a tabbed selection screen using
*   selection-screen subscreens.
************************************************************************


TABLES sscrfields.

************************************************************************
* Tabbed Block Declaration
************************************************************************
SELECTION-SCREEN BEGIN OF TABBED BLOCK tb1
                  FOR 10 LINES.

SELECTION-SCREEN TAB (20) tab1 USER-COMMAND TAB1
                  DEFAULT SCREEN 100.

SELECTION-SCREEN TAB (20) tab2 USER-COMMAND TAB2
                  DEFAULT SCREEN 200.

SELECTION-SCREEN TAB (20) tab3 USER-COMMAND TAB3
                  DEFAULT SCREEN 300.

SELECTION-SCREEN END OF BLOCK tb1.

************************************************************************
* Subscreen 100 - Basic Information
************************************************************************
SELECTION-SCREEN BEGIN OF SCREEN 100 AS SUBSCREEN.

SELECTION-SCREEN BEGIN OF BLOCK b1
WITH FRAME TITLE text-001. "Basic Information

PARAMETERS:
  p_name TYPE char30,
  p_age  TYPE i.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN END OF SCREEN 100.

************************************************************************
* Subscreen 200 - Address
************************************************************************
SELECTION-SCREEN BEGIN OF SCREEN 200 AS SUBSCREEN.

SELECTION-SCREEN BEGIN OF BLOCK b2
WITH FRAME TITLE text-002. "Address Information

PARAMETERS:
  p_city    TYPE char20,
  p_state   TYPE char20,
  p_cont    TYPE land1 DEFAULT 'IN'.

SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN END OF SCREEN 200.

************************************************************************
* Subscreen 300 - Business Data
************************************************************************
SELECTION-SCREEN BEGIN OF SCREEN 300 AS SUBSCREEN.

SELECTION-SCREEN BEGIN OF BLOCK b3
WITH FRAME TITLE text-003. "Business Information

PARAMETERS:
  p_kunnr TYPE kna1-kunnr,
  p_matnr TYPE mara-matnr.

SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN END OF SCREEN 300.

************************************************************************
* Initialization
************************************************************************
INITIALIZATION.

  tab1 = 'Basic Info'.
  tab2 = 'Address'.
  tab3 = 'Business'.

************************************************************************
* Selection Screen Processing (PAI) - Captures Tab Clicks
************************************************************************
AT SELECTION-SCREEN.
* Dynamically highlight the correct tab based on user command
  CASE sscrfields-ucomm.
    WHEN 'TAB1'.
      tb1-activetab = 'TAB1'.
    WHEN 'TAB2'.
      tb1-activetab = 'TAB2'.
    WHEN 'TAB3'.
      tb1-activetab = 'TAB3'.
  ENDCASE.

************************************************************************
* Output Event (PBO) - Sets default when screen first loads
************************************************************************
AT SELECTION-SCREEN OUTPUT.
* Set default active tab only if none is set (first display)
  IF tb1-activetab IS INITIAL.
    tb1-activetab = 'TAB1'.
  ENDIF.

************************************************************************
* Display Output
************************************************************************
START-OF-SELECTION.

WRITE: / '============================================='.
WRITE: / '     TABBED SELECTION SCREEN DEMONSTRATION'.
WRITE: / '============================================='.

SKIP.

WRITE: / 'Name      :', p_name.
WRITE: / 'Age       :', p_age.

WRITE: / 'City      :', p_city.
WRITE: / 'State     :', p_state.
WRITE: / 'Country   :', p_cont.

WRITE: / 'Customer  :', p_kunnr.
WRITE: / 'Material  :', p_matnr.