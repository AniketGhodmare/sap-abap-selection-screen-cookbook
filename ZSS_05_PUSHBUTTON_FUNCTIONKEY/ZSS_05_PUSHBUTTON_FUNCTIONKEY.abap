*&---------------------------------------------------------------------*
*& Report ZSS_05_PUSHBUTTON_FUNCTIONKEY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSS_05_PUSHBUTTON_FUNCTIONKEY.

************************************************************************
* Program        : ZSS_05_PUSHBUTTON_FUNCTIONKEY
* Title          : Push Button and Function Key Demo
*
* Purpose:
*   Demonstrates:
*     1. Push Button
*     2. Function Key 1
*     3. Function Key 2
*     4. Function Key 3
*     5. USER-COMMAND
*     6. Selection Screen Events
************************************************************************

TABLES:
  sscrfields.


************************************************************************
* Global Data
************************************************************************

*DATA:
*  btn1(20),
*  btn2(20).
************************************************************************
* Text Elements
************************************************************************
* TEXT-001 : User Information
* TEXT-002 : Push Button Demo
************************************************************************

************************************************************************
* Function Keys
************************************************************************

SELECTION-SCREEN FUNCTION KEY 1.
SELECTION-SCREEN FUNCTION KEY 2.
SELECTION-SCREEN FUNCTION KEY 3 .

************************************************************************
* Block
************************************************************************

SELECTION-SCREEN BEGIN OF BLOCK b1
WITH FRAME TITLE text-001.

PARAMETERS:
  p_name TYPE char30,
  p_city TYPE char20,
  p_age  TYPE i.

SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN PUSHBUTTON
5(20)
btn1
USER-COMMAND BTN1.

SELECTION-SCREEN PUSHBUTTON
30(20)
btn2
USER-COMMAND BTN2.

SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK b1.



************************************************************************
* Initialization
************************************************************************

INITIALIZATION.

*-----------------------------------------------------------------------
* Push Button Text
*-----------------------------------------------------------------------

  btn1 = 'Show Message'.

  btn2 = 'Clear Fields'.

*-----------------------------------------------------------------------
* Function Key Text
*-----------------------------------------------------------------------

  sscrfields-functxt_01 = 'Help'.

  sscrfields-functxt_02 = 'Reset'.

  sscrfields-functxt_03 = 'About'.

************************************************************************
* Selection Screen Events
************************************************************************

AT SELECTION-SCREEN.

  CASE sscrfields-ucomm.

*-----------------------------------------------------------------------
* Push Button 1
*-----------------------------------------------------------------------

    WHEN 'BTN1'.

      MESSAGE 'Hello! Push Button Clicked.' TYPE 'I'.

*-----------------------------------------------------------------------
* Push Button 2
*-----------------------------------------------------------------------

    WHEN 'BTN2'.

      CLEAR:
        p_name,
        p_city,
        p_age.

      MESSAGE 'All fields cleared successfully.' TYPE 'S'.

*-----------------------------------------------------------------------
* Function Key 1
*-----------------------------------------------------------------------

    WHEN 'FC01'.

      MESSAGE
      'Enter Name, City and Age, then press Execute.'
      TYPE 'I'.

*-----------------------------------------------------------------------
* Function Key 2
*-----------------------------------------------------------------------

    WHEN 'FC02'.

      CLEAR:
        p_name,
        p_city,
        p_age.

      MESSAGE
      'Selection Screen Reset.'
      TYPE 'S'.

*-----------------------------------------------------------------------
* Function Key 3
*-----------------------------------------------------------------------

    WHEN 'FC03'.

      MESSAGE
      'Push Button & Function Key Demonstration Program'
      TYPE 'I'.

  ENDCASE.

************************************************************************
* Validation
************************************************************************

AT SELECTION-SCREEN ON p_age.

  IF p_age < 0.

    MESSAGE
    'Age cannot be negative.'
    TYPE 'E'.

  ENDIF.

************************************************************************
* Output
************************************************************************

START-OF-SELECTION.

WRITE:/ '============================================'.
WRITE:/ ' PUSH BUTTON & FUNCTION KEY DEMONSTRATION'.
WRITE:/ '============================================'.

SKIP.

WRITE:/ 'Name :', p_name.
WRITE:/ 'City :', p_city.
WRITE:/ 'Age  :', p_age.

SKIP.

WRITE:/ 'Program Executed Successfully.'.