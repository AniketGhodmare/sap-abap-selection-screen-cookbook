*&---------------------------------------------------------------------*
*& Include ZSS_15_PROCESSING_INCLUDE
*&---------------------------------------------------------------------*
*& Main Processing and Output
*&---------------------------------------------------------------------*

FORM gather_selection_summary.
  gs_selection_summary-employee   = p_emp.
  gs_selection_summary-sales_org  = p_vkorg.
  gs_selection_summary-distr_chan = p_vtweg.
  gs_selection_summary-division   = p_spart.
  gs_selection_summary-date_from  = s_date-low.
  gs_selection_summary-date_to    = s_date-high.
  IF rb_order = 'X'.
    gs_selection_summary-date_type = 'O'.
  ELSE.
    gs_selection_summary-date_type = 'D'.
  ENDIF.
  gs_selection_summary-test_run    = p_test.
  gs_selection_summary-logging     = p_log.
  gs_selection_summary-parallel    = p_paral.
  gs_selection_summary-server      = p_server.
  gs_selection_summary-max_records = p_maxrec.
  PERFORM convert_range_to_string.
ENDFORM.

FORM convert_range_to_string.
  DATA: lv_string TYPE string,
        ls_matnr  LIKE LINE OF s_matnr,
        ls_kunnr  LIKE LINE OF s_kunnr.
  CLEAR lv_string.
  LOOP AT s_matnr INTO ls_matnr.
    CONCATENATE lv_string ls_matnr-low ';' INTO lv_string.
  ENDLOOP.
  gs_selection_summary-materials = lv_string.
  CLEAR lv_string.
  LOOP AT s_kunnr INTO ls_kunnr.
    CONCATENATE lv_string ls_kunnr-low ';' INTO lv_string.
  ENDLOOP.
  gs_selection_summary-customers = lv_string.
ENDFORM.

FORM main_processing.
  DATA: lv_start TYPE i,
        lv_end   TYPE i.
  GET RUN TIME FIELD lv_start.
  CLEAR gt_out.
  IF p_test = 'X'.
    gv_message = 'Test run - no data processed'.
    MESSAGE s000(00) WITH gv_message.
    RETURN.
  ENDIF.
  PERFORM process_data.
  IF p_file IS NOT INITIAL.
    PERFORM upload_file_data.
  ENDIF.
  IF p_maxrec > 0 AND lines( gt_out ) > p_maxrec.
    DELETE gt_out FROM p_maxrec + 1.
  ENDIF.
  IF p_log = 'X'.
    PERFORM log_processing.
  ENDIF.
  IF p_paral = 'X'.
    PERFORM process_parallel.
  ENDIF.
  GET RUN TIME FIELD lv_end.
  gv_runtime = lv_end - lv_start.
  gv_records = lines( gt_out ).
ENDFORM.

FORM process_data.
  DATA: lv_idx TYPE i.
  DO 100 TIMES.
    lv_idx = sy-index.
    APPEND |Sample Record { lv_idx }| TO gt_out.
  ENDDO.
ENDFORM.

FORM upload_file_data.
  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename   = p_file
    TABLES
      data_tab   = gt_out
    EXCEPTIONS
      OTHERS     = 1.
  IF sy-subrc = 0.
    gv_message = |Upload successful: { lines( gt_out ) } records|.
    MESSAGE s000(00) WITH gv_message.
  ELSE.
    gv_message = 'Upload failed'.
    MESSAGE w000(00) WITH gv_message.
  ENDIF.
ENDFORM.

FORM log_processing.
  DATA: lv_log TYPE string.
  lv_log = |Processing completed at { sy-timlo } with { gv_records } records|.
ENDFORM.

FORM process_parallel.
  DATA: lv_msg TYPE string.
  lv_msg = |Parallel processing on server { p_server }|.
  MESSAGE i000(00) WITH lv_msg.
ENDFORM.

FORM display_output.
  PERFORM display_summary.
  PERFORM display_alv.
ENDFORM.

FORM display_summary.
  WRITE: / '==============================================',
         / '   Sales Order Report - Selection Summary',
         / '=============================================='.
  WRITE: / 'Employee       : ', gs_selection_summary-employee.
  WRITE: / 'Sales Org      : ', gs_selection_summary-sales_org.
  WRITE: / 'Distr Channel  : ', gs_selection_summary-distr_chan.
  WRITE: / 'Division       : ', gs_selection_summary-division.
  WRITE: / 'Date From      : ', gs_selection_summary-date_from.
  WRITE: / 'Date To        : ', gs_selection_summary-date_to.
  WRITE: / 'Date Type      : ', gs_selection_summary-date_type.
  WRITE: / 'Test Run       : ', gs_selection_summary-test_run.
  WRITE: / 'Records Read   : ', gv_records.
  WRITE: / 'Runtime (ms)   : ', gv_runtime.
  WRITE: / '=============================================='.
  SKIP.
ENDFORM.

FORM display_alv.
  IF gt_out IS NOT INITIAL.
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program = sy-repid
        i_structure_name   = 'STRING'
      TABLES
        t_outtab           = gt_out
      EXCEPTIONS
        OTHERS             = 0.
  ELSE.
    WRITE: / 'No data to display'.
  ENDIF.
ENDFORM.