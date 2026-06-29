*&---------------------------------------------------------------------*
*& Report ZSS_04_LISTBOX
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSS_04_LISTBOX.

************************************************************************
* Program        : ZSS_04_LISTBOX
* Title          : Listbox (Dropdown) Demonstration
* Author         : Demo
*
* Purpose:
*   Demonstrates the use of Listboxes (Dropdowns) on the
*   Selection Screen using Function Module VRM_SET_VALUES.
*
* Topics Covered:
*   1. Single Listbox
*   2. Multiple Listboxes
*   3. Default Values
*   4. Dynamic Population
*   5. Validation
************************************************************************

TYPE-POOLS: vrm.

************************************************************************
* Type Declaration
************************************************************************

DATA:
  gt_values TYPE vrm_values,
  gs_value  TYPE vrm_value.

************************************************************************
* Selection Screen
************************************************************************

SELECTION-SCREEN BEGIN OF BLOCK b1
WITH FRAME TITLE text-001. "Listbox Demonstration

*-----------------------------------------------------------------------
* Country
*-----------------------------------------------------------------------

PARAMETERS:
  p_cntry TYPE char10
  AS LISTBOX
  VISIBLE LENGTH 20.

*-----------------------------------------------------------------------
* Department
*-----------------------------------------------------------------------

PARAMETERS:
  p_dept TYPE char10
  AS LISTBOX
  VISIBLE LENGTH 20.

*-----------------------------------------------------------------------
* Status
*-----------------------------------------------------------------------

PARAMETERS:
  p_status TYPE char10
  AS LISTBOX
  VISIBLE LENGTH 20.

SELECTION-SCREEN END OF BLOCK b1.

************************************************************************
* Initialization
************************************************************************

INITIALIZATION.

  p_cntry = 'IN'.

  p_dept = 'IT'.

  p_status = 'A'.

************************************************************************
* Fill Listboxes
************************************************************************

AT SELECTION-SCREEN OUTPUT.

*-----------------------------------------------------------------------
* Country Listbox
*-----------------------------------------------------------------------

  CLEAR gt_values.

  gs_value-key = 'IN'.
  gs_value-text = 'India'.
  APPEND gs_value TO gt_values.

  CLEAR gs_value.
  gs_value-key = 'US'.
  gs_value-text = 'United States'.
  APPEND gs_value TO gt_values.

  CLEAR gs_value.
  gs_value-key = 'UK'.
  gs_value-text = 'United Kingdom'.
  APPEND gs_value TO gt_values.

  CLEAR gs_value.
  gs_value-key = 'JP'.
  gs_value-text = 'Japan'.
  APPEND gs_value TO gt_values.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'P_CNTRY'
      values = gt_values.

*-----------------------------------------------------------------------
* Department Listbox
*-----------------------------------------------------------------------

  CLEAR gt_values.

  CLEAR gs_value.
  gs_value-key = 'IT'.
  gs_value-text = 'Information Technology'.
  APPEND gs_value TO gt_values.

  CLEAR gs_value.
  gs_value-key = 'HR'.
  gs_value-text = 'Human Resource'.
  APPEND gs_value TO gt_values.

  CLEAR gs_value.
  gs_value-key = 'FIN'.
  gs_value-text = 'Finance'.
  APPEND gs_value TO gt_values.

  CLEAR gs_value.
  gs_value-key = 'MM'.
  gs_value-text = 'Materials Management'.
  APPEND gs_value TO gt_values.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'P_DEPT'
      values = gt_values.

*-----------------------------------------------------------------------
* Status Listbox
*-----------------------------------------------------------------------

  CLEAR gt_values.

  CLEAR gs_value.
  gs_value-key = 'A'.
  gs_value-text = 'Active'.
  APPEND gs_value TO gt_values.

  CLEAR gs_value.
  gs_value-key = 'I'.
  gs_value-text = 'Inactive'.
  APPEND gs_value TO gt_values.

  CLEAR gs_value.
  gs_value-key = 'B'.
  gs_value-text = 'Blocked'.
  APPEND gs_value TO gt_values.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'P_STATUS'
      values = gt_values.

************************************************************************
* Validation
************************************************************************

AT SELECTION-SCREEN.

  IF p_cntry IS INITIAL.
    MESSAGE 'Please select Country.' TYPE 'E'.
  ENDIF.

  IF p_dept IS INITIAL.
    MESSAGE 'Please select Department.' TYPE 'E'.
  ENDIF.

  IF p_status IS INITIAL.
    MESSAGE 'Please select Status.' TYPE 'E'.
  ENDIF.

************************************************************************
* Output
************************************************************************

START-OF-SELECTION.

WRITE:/ '========================================='.
WRITE:/ '        LISTBOX DEMONSTRATION'.
WRITE:/ '========================================='.

SKIP.

WRITE:/ 'Selected Country    :', p_cntry.
WRITE:/ 'Selected Department :', p_dept.
WRITE:/ 'Selected Status     :', p_status.

SKIP.

WRITE:/ 'Program Executed Successfully.'.