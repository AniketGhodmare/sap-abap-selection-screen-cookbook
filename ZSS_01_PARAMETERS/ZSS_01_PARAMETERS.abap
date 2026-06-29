*&---------------------------------------------------------------------*
*& Report ZSS_01_PARAMETERS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSS_01_PARAMETERS.

************************************************************************
* Program        : ZSS_01_PARAMETERS
* Title          : PARAMETERS Statement Demo
* Author         : Demo
*
* Purpose:
*   Demonstrates the commonly used PARAMETERS input fields available
*   in SAP ABAP Selection Screen.
*
* Topics Covered:
*   1. Character Field
*   2. Numeric Text (NUMC)
*   3. Integer
*   4. Packed Number
*   5. Floating Point
*   6. Date
*   7. Time
*   8. String
*   9. Currency Key
*  10. Quantity
*  11. Language
*  12. Client
*  13. User Name
*  14. Material Number
*  15. Customer Number
*  16. Sales Order
*  17. LOWER CASE
*  18. OBLIGATORY
*  19. DEFAULT
*  20. NO-DISPLAY
************************************************************************

TABLES:
  mara,
  kna1,
  vbak.

*---------------------------------------------------------------------*
* Hidden Parameter
*---------------------------------------------------------------------*
* This field is available in the program but is not shown on screen.
*---------------------------------------------------------------------*
PARAMETERS:
  p_hidden TYPE char20 NO-DISPLAY.

*---------------------------------------------------------------------*
* Block : Basic Parameters
*---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1
WITH FRAME TITLE TEXT-001.

*text-001 = Parameters Demonstration

*---------------------------------------------------------------------*
* Character Field
*---------------------------------------------------------------------*
PARAMETERS:
  p_char TYPE char30
  DEFAULT 'OpenAI'.

*---------------------------------------------------------------------*
* NUMC Field
*---------------------------------------------------------------------*
PARAMETERS:
  p_numc TYPE numc10.

*---------------------------------------------------------------------*
* Integer Field (Mandatory)
*---------------------------------------------------------------------*
PARAMETERS:
  p_int TYPE i
  OBLIGATORY
  DEFAULT 1.

*---------------------------------------------------------------------*
* Packed Number
*---------------------------------------------------------------------*
PARAMETERS:
  p_pack TYPE p LENGTH 8 DECIMALS 2
  DEFAULT '1000.50'.

*---------------------------------------------------------------------*
* Floating Point
*---------------------------------------------------------------------*
PARAMETERS:
  p_float TYPE wrbtr.

*---------------------------------------------------------------------*
* Date
*---------------------------------------------------------------------*
PARAMETERS:
  p_date TYPE sy-datum
  DEFAULT sy-datum.

*---------------------------------------------------------------------*
* Time
*---------------------------------------------------------------------*
PARAMETERS:
  p_time TYPE sy-uzeit
  DEFAULT sy-uzeit.

*---------------------------------------------------------------------*
* String (Allows Long Text)
*---------------------------------------------------------------------*
PARAMETERS:
  p_string TYPE string LOWER CASE.

*---------------------------------------------------------------------*
* Currency Key
*---------------------------------------------------------------------*
PARAMETERS:
  p_curr TYPE waers
  DEFAULT 'INR'.

*---------------------------------------------------------------------*
* Quantity
*---------------------------------------------------------------------*
PARAMETERS:
  p_qty TYPE menge_d
  DEFAULT '10'.

*---------------------------------------------------------------------*
* Language Key
*---------------------------------------------------------------------*
PARAMETERS:
  p_lang TYPE sylangu
  DEFAULT sy-langu.

*---------------------------------------------------------------------*
* Client
*---------------------------------------------------------------------*
PARAMETERS:
  p_mandt TYPE mandt
  DEFAULT sy-mandt.

*---------------------------------------------------------------------*
* User Name
*---------------------------------------------------------------------*
PARAMETERS:
  p_user TYPE syuname
  DEFAULT sy-uname.

*---------------------------------------------------------------------*
* Material Number
* Standard F4 Search Help Available
*---------------------------------------------------------------------*
PARAMETERS:
  p_matnr TYPE mara-matnr.

*---------------------------------------------------------------------*
* Customer Number
*---------------------------------------------------------------------*
PARAMETERS:
  p_kunnr TYPE kna1-kunnr.

*---------------------------------------------------------------------*
* Sales Order Number
*---------------------------------------------------------------------*
PARAMETERS:
  p_vbeln TYPE vbak-vbeln.

*---------------------------------------------------------------------*
* Lower Case Example
*---------------------------------------------------------------------*
PARAMETERS:
  p_email TYPE char50 LOWER CASE.

SELECTION-SCREEN END OF BLOCK b1.

*---------------------------------------------------------------------*
* INITIALIZATION
*---------------------------------------------------------------------*
INITIALIZATION.

  p_hidden = 'SECRET'.

*---------------------------------------------------------------------*
* Field Validation
*---------------------------------------------------------------------*
AT SELECTION-SCREEN.

  IF p_int <= 0.
    MESSAGE 'Integer value must be greater than zero.' TYPE 'E'.
  ENDIF.

  IF p_qty < 0.
    MESSAGE 'Quantity cannot be negative.' TYPE 'E'.
  ENDIF.

*---------------------------------------------------------------------*
* Date Validation
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON p_date.

  IF p_date > sy-datum.
    MESSAGE 'Future date is not allowed.' TYPE 'E'.
  ENDIF.

*---------------------------------------------------------------------*
* START-OF-SELECTION
*---------------------------------------------------------------------*
START-OF-SELECTION.

  WRITE: / '=========================================='.
  WRITE: / '      PARAMETERS DEMONSTRATION REPORT'.
  WRITE: / '=========================================='.

  SKIP.

  WRITE: / 'Character Field      :', p_char.
  WRITE: / 'NUMC Field           :', p_numc.
  WRITE: / 'Integer             :', p_int.
  WRITE: / 'Packed Number       :', p_pack.
  WRITE: / 'Float Number        :', p_float.
  WRITE: / 'Date                :', p_date.
  WRITE: / 'Time                :', p_time.
  WRITE: / 'String              :', p_string.
  WRITE: / 'Currency            :', p_curr.
  WRITE: / 'Quantity            :', p_qty.
  WRITE: / 'Language            :', p_lang.
  WRITE: / 'Client              :', p_mandt.
  WRITE: / 'User                :', p_user.
  WRITE: / 'Material            :', p_matnr.
  WRITE: / 'Customer            :', p_kunnr.
  WRITE: / 'Sales Order         :', p_vbeln.
  WRITE: / 'Email               :', p_email.

  SKIP.

  WRITE: / 'Hidden Parameter    :', p_hidden.

  SKIP.

  WRITE: / 'Program Executed Successfully.'.