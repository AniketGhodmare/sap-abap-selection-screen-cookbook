*&---------------------------------------------------------------------*
*& Include ZSS_15_VALIDATION_INCLUDE
*&---------------------------------------------------------------------*
*& Validation Logic Module
*&---------------------------------------------------------------------*

FORM validate_all.
  PERFORM validate_employee.
  PERFORM validate_sales_org.
  PERFORM validate_distribution_channel.
  PERFORM validate_division.
  PERFORM validate_material_range.
  PERFORM validate_customer_range.
  PERFORM validate_plant_range.
  PERFORM validate_date_range.
  PERFORM validate_cross_field.
  PERFORM validate_file_upload.
  PERFORM validate_authorization.
  IF sy-subrc = 0.
    gv_message = 'All validations passed'.
    MESSAGE s000(00) WITH gv_message.
  ENDIF.
ENDFORM.

FORM validate_employee.
  DATA: lv_emp TYPE usr21-bname.
  IF p_emp IS NOT INITIAL.
    SELECT SINGLE bname FROM usr21 INTO lv_emp
      WHERE bname = p_emp.
    IF sy-subrc <> 0.
      gv_message = |Employee { p_emp } does not exist|.
      MESSAGE e000(00) WITH gv_message.
    ENDIF.
  ENDIF.
ENDFORM.

FORM validate_sales_org.
  DATA: lv_vkorg TYPE tvko-vkorg.
  IF p_vkorg IS NOT INITIAL.
    SELECT SINGLE vkorg FROM tvko INTO lv_vkorg
      WHERE vkorg = p_vkorg.
    IF sy-subrc <> 0.
      gv_message = |Sales Org { p_vkorg } invalid|.
      MESSAGE e000(00) WITH gv_message.
    ENDIF.
  ENDIF.
ENDFORM.

FORM validate_distribution_channel.
  DATA: lv_vtweg TYPE tvtw-vtweg.
  IF p_vtweg IS NOT INITIAL.
    SELECT SINGLE vtweg FROM tvtw INTO lv_vtweg
      WHERE vtweg = p_vtweg.
    IF sy-subrc <> 0.
      gv_message = |Distr. Chan. { p_vtweg } invalid|.
      MESSAGE e000(00) WITH gv_message.
    ENDIF.
  ENDIF.
ENDFORM.

FORM validate_division.
  DATA: lv_spart TYPE tspa-spart.
  IF p_spart IS NOT INITIAL.
    SELECT SINGLE spart FROM tspa INTO lv_spart
      WHERE spart = p_spart.
    IF sy-subrc <> 0.
      gv_message = |Division { p_spart } invalid|.
      MESSAGE e000(00) WITH gv_message.
    ENDIF.
  ENDIF.
ENDFORM.

FORM validate_material_range.
  DATA: lt_mara TYPE STANDARD TABLE OF mara.
  IF s_matnr[] IS NOT INITIAL.
    SELECT matnr FROM mara INTO TABLE lt_mara
      FOR ALL ENTRIES IN s_matnr
      WHERE matnr = s_matnr-low.
    IF sy-subrc <> 0.
      gv_message = 'No valid materials found'.
      MESSAGE w000(00) WITH gv_message.
    ENDIF.
  ENDIF.
ENDFORM.

FORM validate_customer_range.
  DATA: lt_kna1 TYPE STANDARD TABLE OF kna1.
  IF s_kunnr[] IS NOT INITIAL.
    SELECT kunnr FROM kna1 INTO TABLE lt_kna1
      FOR ALL ENTRIES IN s_kunnr
      WHERE kunnr = s_kunnr-low.
    IF sy-subrc <> 0.
      gv_message = 'No valid customers found'.
      MESSAGE w000(00) WITH gv_message.
    ENDIF.
  ENDIF.
ENDFORM.

FORM validate_plant_range.
  DATA: lt_t001w TYPE STANDARD TABLE OF t001w.
  IF s_werks[] IS NOT INITIAL.
    SELECT werks FROM t001w INTO TABLE lt_t001w
      FOR ALL ENTRIES IN s_werks
      WHERE werks = s_werks-low.
    IF sy-subrc <> 0.
      gv_message = 'No valid plants found'.
      MESSAGE w000(00) WITH gv_message.
    ENDIF.
  ENDIF.
ENDFORM.

FORM validate_date_range.
  IF s_date-low > s_date-high.
    gv_message = 'From date must be <= To date'.
    MESSAGE e000(00) WITH gv_message.
  ENDIF.
  IF s_date-low IS NOT INITIAL AND s_date-high IS NOT INITIAL.
    IF s_date-high < s_date-low.
      gv_message = 'Invalid date range'.
      MESSAGE e000(00) WITH gv_message.
    ENDIF.
  ENDIF.
ENDFORM.

FORM validate_cross_field.
  DATA: ls_werks LIKE LINE OF s_werks,
        ls_lgort LIKE LINE OF s_lgort,
        lv_lgort TYPE t001l-lgort.
  IF s_werks[] IS NOT INITIAL AND s_lgort[] IS NOT INITIAL.
    LOOP AT s_werks INTO ls_werks.
      LOOP AT s_lgort INTO ls_lgort.
        SELECT SINGLE lgort FROM t001l INTO lv_lgort
          WHERE werks = ls_werks-low
          AND   lgort = ls_lgort-low.
        IF sy-subrc <> 0.
          gv_message = |Stor.loc { ls_lgort-low } not valid for plant { ls_werks-low }|.
          MESSAGE w000(00) WITH gv_message.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDIF.
ENDFORM.

FORM validate_file_upload.
  DATA: lv_exists TYPE flag.
  IF p_file IS NOT INITIAL.
    CALL METHOD cl_gui_frontend_services=>file_exist
      EXPORTING
        file   = p_file
      RECEIVING
        result = lv_exists.
    IF lv_exists = abap_false.
      gv_message = |File { p_file } does not exist|.
      MESSAGE e000(00) WITH gv_message.
    ENDIF.
  ENDIF.
ENDFORM.

FORM validate_authorization.
  AUTHORITY-CHECK OBJECT 'S_CARRID'
           ID 'CARRID' FIELD 'LH'.
  IF sy-subrc <> 0.
    gv_message = 'You are not authorized'.
    MESSAGE e000(00) WITH gv_message.
    STOP.
  ENDIF.
ENDFORM.