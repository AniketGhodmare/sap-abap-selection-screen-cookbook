*&---------------------------------------------------------------------*
*& Include ZSS_15_UTILITY_INCLUDE
*&---------------------------------------------------------------------*
*& Utility Functions
*&---------------------------------------------------------------------*

FORM reset_all_fields.
  CLEAR: p_emp, p_vkorg, p_vtweg, p_spart, p_prio,
         p_file, p_folder, p_test, p_status,
         p_log, p_paral, p_server, p_maxrec,
         p_debug, p_trace, p_commit, p_ordtyp, p_soldto.
  FREE: s_date, s_matnr, s_kunnr, s_werks, s_lgort, s_vbeln, s_create, s_buffer.
  PERFORM init_tab1.
  PERFORM init_tab2.
  PERFORM init_tab3.
  PERFORM init_tab4.
  CLEAR gt_out.
  gv_records = 0.
  gv_runtime = 0.
  gv_message = 'All fields reset to defaults'.
  MESSAGE s000(00) WITH gv_message.
ENDFORM.

FORM show_preview.
  DATA: lv_popup TYPE string.
  PERFORM gather_selection_summary.
  lv_popup = |Report will use:\n\n| &&
             |Employee: { p_emp }\n| &&
             |Sales Org: { p_vkorg }\n| &&
             |Date Range: { s_date-low } - { s_date-high }\n| &&
             |Max Records: { p_maxrec }|.
  CALL FUNCTION 'POPUP_TO_INFORM'
    EXPORTING
      titel = 'Selection Preview'
      txt1  = lv_popup.
ENDFORM.

FORM export_data.
  DATA: lv_filename TYPE string.
  IF gt_out IS INITIAL.
    gv_message = 'No data to export'.
    MESSAGE w000(00) WITH gv_message.
    RETURN.
  ENDIF.
  CONCATENATE 'export_' sy-datum '_' sy-timlo '.txt'
    INTO lv_filename.
  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      filename = lv_filename
    TABLES
      data_tab = gt_out
    EXCEPTIONS
      OTHERS   = 1.
  IF sy-subrc = 0.
    gv_message = |Data exported to { lv_filename }|.
    MESSAGE s000(00) WITH gv_message.
  ELSE.
    gv_message = 'Export failed'.
    MESSAGE w000(00) WITH gv_message.
  ENDIF.
ENDFORM.

FORM show_help.
  DATA: lv_help TYPE string.
  lv_help = 'Sales Order Report - Help\n\n' &&
            'General Tab: Basic parameters\n' &&
            'Selection Tab: Selection criteria\n' &&
            'Upload Tab: File upload options\n' &&
            'Advanced Tab: Advanced settings\n\n' &&
            'F2: Reset all fields\n' &&
            'F3: About this report'.
  CALL FUNCTION 'POPUP_TO_INFORM'
    EXPORTING
      titel = 'Help'
      txt1  = lv_help.
ENDFORM.

FORM show_about.
  DATA: lv_about TYPE string.
  lv_about = 'ZSS_15_ALL_FEATURES\n\n' &&
             'Sales Order Report\n' &&
             'Version 1.0\n\n' &&
             'Demonstrates all selection screen features\n' &&
             'Developer: SAP Team\n' &&
             'Date: 2026'.
  CALL FUNCTION 'POPUP_TO_INFORM'
    EXPORTING
      titel = 'About'
      txt1  = lv_about.
ENDFORM.