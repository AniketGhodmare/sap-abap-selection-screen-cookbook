*&---------------------------------------------------------------------*
*& Report ZSS_06_BLOCK_COMMENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSS_06_BLOCK_COMMENT.

************************************************************************
* Program        : ZSS_06_BLOCK_COMMENT
* Title          : Selection Screen Layout Demo
* Author         : Demo
*
* Purpose:
*   Demonstrates different Selection Screen Layout elements.
*
* Topics Covered:
*   1. BLOCK
*   2. COMMENT
*   3. BEGIN OF LINE
*   4. POSITION
*   5. SKIP
*   6. ULINE
*   7. PUSHBUTTON
************************************************************************

TABLES sscrfields.

*---------------------------------------------------------------------*
* Push Button Text
*---------------------------------------------------------------------*
*DATA:
*  gv_btn(20).

*---------------------------------------------------------------------*
* Block 1 : Employee Details
*---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1
WITH FRAME TITLE text-001.

SELECTION-SCREEN COMMENT /1(60) text-004.

PARAMETERS:
  p_empid TYPE char10 OBLIGATORY,
  p_name  TYPE char30.

SELECTION-SCREEN END OF BLOCK b1.

*---------------------------------------------------------------------*
* Blank Line
*---------------------------------------------------------------------*
SELECTION-SCREEN SKIP.

*---------------------------------------------------------------------*
* Horizontal Line
*---------------------------------------------------------------------*
SELECTION-SCREEN ULINE.

*---------------------------------------------------------------------*
* Block 2 : Department Information
*---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b2
WITH FRAME TITLE text-002.

SELECTION-SCREEN COMMENT /1(45) text-005.

PARAMETERS:
  p_dept TYPE char20,
  p_desg TYPE char25.

SELECTION-SCREEN END OF BLOCK b2.

*---------------------------------------------------------------------*
* Blank Line
*---------------------------------------------------------------------*
SELECTION-SCREEN SKIP.

*---------------------------------------------------------------------*
* Block 3 : Contact Information
*---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b3
WITH FRAME TITLE text-003.

SELECTION-SCREEN COMMENT /1(40) text-006.

*---------------------------------------------------------------------*
* Multiple Fields in One Line
*---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 2(8) text-007.

PARAMETERS:
  p_city TYPE char20.

SELECTION-SCREEN POSITION 40.

SELECTION-SCREEN COMMENT 42(8) text-008.

PARAMETERS:
  p_state TYPE char20.

SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 2(8) text-009.

PARAMETERS:
  p_pin TYPE char6.

SELECTION-SCREEN POSITION 40.

SELECTION-SCREEN COMMENT 42(8) text-010.

PARAMETERS:
  p_contry TYPE land1 DEFAULT 'IN'.

SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK b3.

*---------------------------------------------------------------------*
* Blank Line
*---------------------------------------------------------------------*
SELECTION-SCREEN SKIP.

*---------------------------------------------------------------------*
* Push Button
*---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN PUSHBUTTON 25(20)
gv_btn
USER-COMMAND BTN1.

SELECTION-SCREEN END OF LINE.

*---------------------------------------------------------------------*
* Initialization
*---------------------------------------------------------------------*
INITIALIZATION.

  gv_btn = 'Display Message'.

*---------------------------------------------------------------------*
* Push Button Event
*---------------------------------------------------------------------*
AT SELECTION-SCREEN.

  CASE sscrfields-ucomm.

    WHEN 'BTN1'.

      MESSAGE 'Selection Screen Layout Demo' TYPE 'I'.

  ENDCASE.

*---------------------------------------------------------------------*
* Output
*---------------------------------------------------------------------*
START-OF-SELECTION.

WRITE:/ '========================================='.
WRITE:/ 'SELECTION SCREEN LAYOUT DEMONSTRATION'.
WRITE:/ '========================================='.

SKIP.

WRITE:/ 'Employee ID :', p_empid.
WRITE:/ 'Employee Name :', p_name.

WRITE:/ 'Department :', p_dept.
WRITE:/ 'Designation :', p_desg.

WRITE:/ 'City :', p_city.
WRITE:/ 'State :', p_state.
WRITE:/ 'PIN :', p_pin.
WRITE:/ 'Country :', p_contry.


*| Text ID | Text                               |
*| ------- | ---------------------------------- |
*| 001     | Employee Details                   |
*| 002     | Department Information             |
*| 003     | Contact Information                |
*| 004     | Enter employee master information. |
*| 005     | Enter department and designation.  |
*| 006     | Enter contact details.             |
*| 007     | City                               |
*| 008     | State                              |
*| 009     | PIN                                |
*| 010     | Country                            |