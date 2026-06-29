*&---------------------------------------------------------------------*
*& Include ZSS_15_EVENTS_INCLUDE
*&---------------------------------------------------------------------*
*& Main Events Handler
*&---------------------------------------------------------------------*

AT SELECTION-SCREEN OUTPUT.

*  PERFORM set_gui_status.
  PERFORM dynamic_screen_mod.
  PERFORM tab1_screen_output.
  PERFORM tab2_screen_output.
  PERFORM tab3_screen_output.
  PERFORM tab4_screen_output.

AT SELECTION-SCREEN.
  PERFORM handle_user_command.
  PERFORM validate_date_range.
  PERFORM validate_cross_field.

AT SELECTION-SCREEN ON p_emp.
  PERFORM validate_employee.

AT SELECTION-SCREEN ON p_vkorg.
  PERFORM validate_sales_org.

AT SELECTION-SCREEN ON p_vtweg.
  PERFORM validate_distribution_channel.

AT SELECTION-SCREEN ON p_spart.
  PERFORM validate_division.

AT SELECTION-SCREEN ON s_matnr.
  PERFORM validate_material_range.

AT SELECTION-SCREEN ON s_kunnr.
  PERFORM validate_customer_range.

AT SELECTION-SCREEN ON s_werks.
  PERFORM validate_plant_range.

AT SELECTION-SCREEN ON BLOCK b1.
  PERFORM validate_sales_org.

AT SELECTION-SCREEN ON BLOCK b2.
  PERFORM validate_date_range.

AT SELECTION-SCREEN ON BLOCK b4.
  PERFORM validate_material_range.

AT SELECTION-SCREEN ON BLOCK b6.
  PERFORM validate_file_upload.

AT SELECTION-SCREEN ON RADIOBUTTON GROUP grp1.
  IF rb_order = 'X'.
    gv_message = 'Selected: Order Date'.
  ELSE.
    gv_message = 'Selected: Delivery Date'.
  ENDIF.

*AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_emp.
*  PERFORM f4_employee_tab1.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM f4_file_browser_tab3.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_folder.
  PERFORM f4_folder_browser_tab3.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_server.
  PERFORM f4_server_list_tab4.

AT SELECTION-SCREEN ON HELP-REQUEST FOR p_emp.
  PERFORM show_help.

AT SELECTION-SCREEN ON HELP-REQUEST FOR p_vkorg.
  PERFORM show_help.

START-OF-SELECTION.
  PERFORM gather_selection_summary.
  PERFORM validate_all.
  PERFORM main_processing.

END-OF-SELECTION.
  PERFORM display_output.

FORM set_function_keys.
  sscrfields-functxt_01 = 'Help (F1)'.
  sscrfields-functxt_02 = 'Reset (F2)'.
  sscrfields-functxt_03 = 'About (F3)'.
ENDFORM.

FORM set_gui_status.
  SET PF-STATUS 'SEL_STATUS'.
ENDFORM.

FORM handle_user_command.
  CASE sy-ucomm.
    WHEN 'VALIDATE'.
      PERFORM validate_all.
    WHEN 'UPLOAD'.
      PERFORM upload_file_data.
    WHEN 'RESET' OR 'FC02'.
      PERFORM reset_all_fields.
    WHEN 'PREVIEW'.
      PERFORM show_preview.
    WHEN 'EXECUTE'.
      PERFORM main_processing.
    WHEN 'EXPORT'.
      PERFORM export_data.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'FC01'.
      PERFORM show_help.
    WHEN 'FC03'.
      PERFORM show_about.
  ENDCASE.
ENDFORM.